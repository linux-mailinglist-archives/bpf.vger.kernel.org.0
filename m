Return-Path: <bpf+bounces-79667-lists+bpf=lfdr.de@vger.kernel.org>
Delivered-To: lists+bpf@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WI7KK8vVb2mgMQAAu9opvQ
	(envelope-from <bpf+bounces-79667-lists+bpf=lfdr.de@vger.kernel.org>)
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 20:21:47 +0100
X-Original-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B39F64A31F
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 20:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49947A63EC7
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 18:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F358144DB6A;
	Tue, 20 Jan 2026 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="F6c1CUVD"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010071.outbound.protection.outlook.com [52.101.84.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB56329E55;
	Tue, 20 Jan 2026 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768932706; cv=fail; b=Hy+43PzQeidBneYIvzKruSmqKXn33gJLAJLNXVYi6jb/Z5lAD8xH95wWz81/3Djkwm8owg394HQqsibqq6OiCEKLz5gm5zFhipWS7fg494BQe6xJMNo+WLDwgLl4vxcMcXt4gRjegJF5xEPGVWpDK2U4/qvxx7MzWgj2sR18Upo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768932706; c=relaxed/simple;
	bh=ruyRIST75Q6bGQ/RL40dRfO9re9PH3aBEg0oJQ4u73s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a7T07JQJ9qE+iFFL+OIfxiyWhp3tCaapdX6T3hQ1cPsFlFqOqMoV6j6mFhZn3KXQyMzDY6vGCEEPFU5u8g3Ja1SvTMkiJ99xQ44mjm0pnvVoldbcwnRpQJLgfKfigDiQBtQbGIx6bm1HGHOkbV7y05hTsTbGEqVtidLrMVUSLCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=F6c1CUVD; arc=fail smtp.client-ip=52.101.84.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZY/6r8BQiodwtOp65TXv4YRHjbV2wtuucD0Jz6DxrbjzQgS4Uc3WDF/Jwohhjwy//utySt5erwdPpkcX9xokugNvqoHEwoEKQsiT8Kh7hZxueEaHEsndtVF0uysZM7Fk/z2Il2L0LMxWiKCd42VlZLtrrM0yFfq/cVDDbePsL8EbRGEbmlzU3HAjaXe9iE770OceC2UCKn5sDwkgHrzX6JC9O9SDOODiL6xUPKVrzSD5Qi2RCqZACCLUlSMXEaeqUWzZSTtYe6xf6EwCHCi5IODMMNGxF3wYHXWzHR2UJ4afDyyqpee4FebJh881SDl89STjeScfLBXLatRYKgdYSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruyRIST75Q6bGQ/RL40dRfO9re9PH3aBEg0oJQ4u73s=;
 b=vCdVEnau2IjT7WU95imVQajI2KAQoFGYjIJReIRTKRfH9/yjJMeKY1qoRq+ms5ckO8hqvJWgJa+JGEihn98UBEtI0BfCukkGiPm7juTQPv19n4RsM55Fm3GznRvHMJraTPEVudb1WwTf4l2V+jVOIZzLNEVOB1yepWEq8i1tQ2XxO+COavR97j4tLaGk//SBYCDJx1JF5QliY06M4aW1uRIpelxgscP3K0nvCx1BNqFZTrp3r4wWMpH/hzZM0FtPMM2xHSraRvMfjIzXlxvVlAWmNdEPZfZvDupXwf/4C05aIHSpKXL+yy7NBhE2iWPEiq61HcbpBHxdmHZdyWNqSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruyRIST75Q6bGQ/RL40dRfO9re9PH3aBEg0oJQ4u73s=;
 b=F6c1CUVD5Gnd6T+/mivFMREfFKdrRcxgyis3coT4MwaT3o2RW1Y4h5Gvr6drEK82Cp2H5Fjzq8et25YDAanybg4ps0XRF6+yWGy44jW9PAS/1BHR3dg1iM7EY7H/iNSgJvLK/1ZwzIwdqoJVCCq7JpYHaCwcNcdWTpFUg0iEx6o3gYqpgOSucIQMFO/DhoTuwChGMkoduSZysaCFNbB9rosm2I4WLytSWJ1Zimho9o88GC5dH4pLkVpOKCwJBilqYOzvE1LtZVYI5ycKH9x9H4Xw53P19CIG47JEsB2d2+ebfjHSViDTWF9fA+DlK1atD8erViQ4JQ4bEOgRjiVi8g==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PA1PR07MB10413.eurprd07.prod.outlook.com (2603:10a6:102:4f6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 18:11:39 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9520.005; Tue, 20 Jan 2026
 18:11:39 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Eric Dumazet <edumazet@google.com>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, "parav@nvidia.com"
	<parav@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "kuniyu@google.com"
	<kuniyu@google.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com"
	<dave.taht@gmail.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "xiyou.wangcong@gmail.com"
	<xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"ast@fiberby.net" <ast@fiberby.net>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Subject: RE: [PATCH v9 net-next 10/15] tcp: accecn: unset ECT if receive or
 send ACE=0 in AccECN negotiaion
Thread-Topic: [PATCH v9 net-next 10/15] tcp: accecn: unset ECT if receive or
 send ACE=0 in AccECN negotiaion
Thread-Index: AQHciXW6T6gKpPGmBUCQ+Rl0BdgE3rVa5kKAgAAWR1A=
Date: Tue, 20 Jan 2026 18:11:39 +0000
Message-ID:
 <PAXPR07MB7984E2D22D4337CA97EBB9CBA389A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
 <20260119185852.11168-11-chia-yu.chang@nokia-bell-labs.com>
 <CANn89i+NEyZ+1R1pouUcroarCfNrQEN01azsEhOuZoeR0Y3mhA@mail.gmail.com>
In-Reply-To:
 <CANn89i+NEyZ+1R1pouUcroarCfNrQEN01azsEhOuZoeR0Y3mhA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PA1PR07MB10413:EE_
x-ms-office365-filtering-correlation-id: 9b8b1e8a-981e-4f67-9203-08de584f5b70
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yk16dmdHTk5Nc3ZGK282Rk9KV3doVjdkSFJaUEZkK1czRk83RWNMaHdmV0Fs?=
 =?utf-8?B?bTVHSWhLVGpMSWhPQUxRam5TUmwzUDNDK2VROFRncTBPTmxTMXBiUHNFb2JS?=
 =?utf-8?B?KzhMQlhNTmlURmZJQzFscXhHcnY1a2NwazFpUVJOcFVtSkd4dFMxdzlTT2RO?=
 =?utf-8?B?eXhwN0k5U1RZaWxEaHU0MXEzSFJZWWRLK0g3SEV3SmJWZmpRUnJVVG51RzlI?=
 =?utf-8?B?UDZyaTh2MnNTSlZkcUxIbXF3azNXdkZqa1dWdjkxNnppdHkyT1Y3Y1M1aExH?=
 =?utf-8?B?cHcra2VudHVibnJGbEVaOHExdThXMmZzMlVHL0xKTENyNm5wUjFZTiszWVNt?=
 =?utf-8?B?L3ZYYXlYVTJERVRzZW9EdUR2YUhrRkpPQXAxNWJCdUVsYlRhWEhhVmVzR1hu?=
 =?utf-8?B?SlNBeGFjS3R0U3FkY1JsZVZuUTFOdjF4c2NadDh5R1RMWjdSRWo3d0drUkoy?=
 =?utf-8?B?NysxMk1rREJEUzlvUU9CY1kxYjVPNTFGTEFxaGlYVzBsVVVQQ01iRHQ2Y3ll?=
 =?utf-8?B?dmQxNENaamROS1lEWVZ0akpHajJ5dVZUSXZLNjk2b01hVkZhZ0pVekxSc2VS?=
 =?utf-8?B?RUhMTFRRbExLbmRBWXMxOHVSVHVZSVhDREhlQXNBYXJuS3ExazdiZ2FodDl6?=
 =?utf-8?B?bzdJMEhYY1RyT3lYQnFFVDdESFIxYllFU05qbVVQdmxkWVJNZnlhQVRWb096?=
 =?utf-8?B?SWNLZGxMdTR6aDNVSk9MZWFLNk96SHFZQ1RnMVR6ZG9QdmNNZHBLaHJRRDVL?=
 =?utf-8?B?OExHVHdkRlZwVy94aEliVFg5dTRMYXVYK0c1QWRud0JNVXA0TGpDdFRETC9l?=
 =?utf-8?B?a2F1N2hnK2xabFByVEhqMG16bFhGQUlXM3dtN0Z5RDNwSnpMU2ZubENmblVJ?=
 =?utf-8?B?dWZxeDcwOVJqY3hhSHcwWVhuMkJ0akhYNjlKUzU4MlhDNXEvcWdLNmVIckVI?=
 =?utf-8?B?c2NFZ0ZsRkxydlkvZ2VGeGlxaEJ4TmM5ZzJCZW5vZythc2RiY0ZIeWpMS1Mw?=
 =?utf-8?B?VG51RGdDaFlnTkdUeTZ3MmFMcnBhMTVTYUhDbUxWRmtYdHQ5U2h6c0VhNk5Z?=
 =?utf-8?B?TDhPdVRMbzBSMmdvbWNQVzAzZm8xRWg4V21YcHVSL3RUMDQ4T00ybnBSZU9Y?=
 =?utf-8?B?WjlkY3NEbEJSRHVRMkZDaTJmMEVtR3RRWHY5WG9BbjRNN08waEhBSHVVYW4v?=
 =?utf-8?B?R3BNOXNlRDNBZ0t5V3ZJbUdYcFRzYWM4WFBncFpWQUsrZUU5WW5vZ2QyRm1N?=
 =?utf-8?B?ZVBKdEJzNUxxeDJycmh2Q3R3TUYxbVk3Yndsb1EwMzgrK25NSEZhSW00ZTcx?=
 =?utf-8?B?NjB3NGxtQ2hIQktpSjN3UVcrKytyWlduaWMwbGIxZUxJVCtEdkNPSnB3WmUr?=
 =?utf-8?B?VTJRT0ptOVFWaXRMWHVCUHlqYWN3UWpqL2xmaThma2lMRThETXBucTRlaUZZ?=
 =?utf-8?B?UnBidlEya3VvRndPcFlVVTZDb0xwb0dHeXlrckZsblhTUGJPeGpzYXBJS0Vn?=
 =?utf-8?B?d2FDYUZMRXJBVHM0RnErUHFKQXVhbzRJUVNOVjd1Z25La0FOY3IwSW9IVEox?=
 =?utf-8?B?UlN1TUNocE53RkdFQ2FiMnBreFI2eUt4MGo3MkNYSmVyOUZYSmVObk1vV1N2?=
 =?utf-8?B?MmN4bmR4Ri9NU0c1cFJ3ZXlSNGZNTk1ZenFxRDd1RDZ2a3V0TEtKdkkrMEta?=
 =?utf-8?B?aTRjS2owUHVaYWRPcEE0YjZWeVdpNFFBelVieXRnS211WnE4NytwOUp5MU1p?=
 =?utf-8?B?c0tlYWQ4QmNiTWNNa2FmdDl2RnkvNnpBRlNHeDY5R1hnSnZnRVFtRis3Qlpz?=
 =?utf-8?B?Sm5tOFpXelAvTlJ4N2tZZXgxUmh2RFBnRyt1T2FFbmhRL1dFRVlHeElFTVhU?=
 =?utf-8?B?WllETzdZWiswTUFCc0s4OUgwdWJYaU11dWpKMGRPMWdYeTRYWGcveFFNWGpN?=
 =?utf-8?B?SWpLV0s2bHYvS1dmcEN2bHJUN2hmWUFXNVorUEV1WWZpeGJ0bXMzZ2tBTzJR?=
 =?utf-8?B?Qng1ZGd0WUlQTTZQL2xVbHNWZGFlblROd2xHTkJaWVVhc3lISHIvYnYyc1Jv?=
 =?utf-8?B?S3k5RGNmeTg1ejJ3bElEUXZqSlQ4MUZnS0NqUzhVcFZLRzdtYTFVbVlIVGJl?=
 =?utf-8?B?d0kyS3dsSDZrUmtzYTdZOVptVk1pY2RRQjJGYnhXNXpzUHlBbHBHOVlrRjdD?=
 =?utf-8?Q?Vc5YkinldIo8byMxFhqUitE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?djgxeHAxbys2a3liNEx2cTRzZWQvZzhjZERzZFA2VFZHRXJpaTN2UDlSWnQ0?=
 =?utf-8?B?eG83c1VtSmVuMXlUdEVGbEJ6RGxMYVdJV01MYWJYYlNmd3cva1psMHJmQWIr?=
 =?utf-8?B?UXhBWTBPOTEycmtmRHAySjl0S3lrTGUwMkFmTDVTcUtOZW1hOEY5dUpid09z?=
 =?utf-8?B?aU1lYUYzc2hSdTY4Q1g4a25Sd2FNT1BpYktEYWZJZFFNclJhMEw1Qm8veGp4?=
 =?utf-8?B?VXh4RHprYXF3bmNzaDJiQld6QXVmdC9WdTZKd3JUcE1LcTgxQnZFNC84MEFo?=
 =?utf-8?B?MFhHSTVrVGRBN0FRWGFxZThiTTlTclFrRHNEeWNSaHFGRmZrSG9yRXl4cENJ?=
 =?utf-8?B?bFlHUFBMQS82aUlYcGxiY3l6RHp4OFo3amVxRXluT2FLY3hXTURmTlJscDdy?=
 =?utf-8?B?azJZTHZnMUVTL3FEZzFXYUxyL1UvTVRCbmlPWTBOTGRkbThvQThsRjlpeGlw?=
 =?utf-8?B?MGxkb0xNK3huK2pYY0I0Y2NMY1JCVWt2TFczaGNGK1hBaTdITFExaXRZVitQ?=
 =?utf-8?B?ZjFYU1lQdEFyMXZaWVFlZXFXK1RyR0lZclZjNVMzc1VnbzZGa0ZlaFFreTlF?=
 =?utf-8?B?dGZvSnpLNDMyVUxNTTFSK2QzLzZNRlpnM1lDRFJLOUV6eFJFNWJ5NWsrTHRE?=
 =?utf-8?B?ZCtRS05rdG1uQThQTDZQRFdENlJrL3IycUgwMHhPbXl3VUZ0RHNUbFhvdm9s?=
 =?utf-8?B?WFlqQTAzMVk4eDdvSzNBOHBSQTE5ZnhTZFkveWEyN0lEWjcxZTBzUkNLQUFH?=
 =?utf-8?B?OVMxQ1p2bUIybmRoa2VTenZUTGpJM0dFK3NCMGxyTk5BcmlEOHM2ZXV6WVM0?=
 =?utf-8?B?em9tVXZ4V1RuWUdFYnNVdjl0OE9hS0VOcGM3WUI2TDdhcUNpVkdkVXRZdnZO?=
 =?utf-8?B?ODNTeVZaS3JVUTVEL3Z3c0lQWjJpRHlveWxiSU0vVy9vMUwxTmVkSjBjOGM0?=
 =?utf-8?B?aTdPd1VGVDZiOTZxcVZFWFJLbzEyM283TG1MQncvSUxiaWFld2N0QStTRU9L?=
 =?utf-8?B?TGpwMlV0QXB4YytvQnFhdEdCTHFXOEtaQWVGcWZDendUU3plQSs2bitEblhG?=
 =?utf-8?B?Z1dQaFpDNVlLQlZaUkxDOCtTbldmK3I0ZlZ1a0pBczZna2owNGdwRktScEhn?=
 =?utf-8?B?aDFVK202MWxpSEplWmZ0TngvL05ScUZZL0FMbjluREhGK0VxVHdwNXNnK1pl?=
 =?utf-8?B?K3hRUWNVaWNqaWxWM21WL1M5a1lZekNhY29NUE5RTy9oOVpHazVGTmRSOHNX?=
 =?utf-8?B?WnlxczJyb25HRk9hK25wNGFDR3Q0bGlha2IxcEVyVW5QRmJjKzZ6Nkp0WThH?=
 =?utf-8?B?bFV1ckZrMFF2bjIydGdrVCtJanBCWENqQVZZUWlyT3g1em9CYTVDNnM4d1li?=
 =?utf-8?B?RDl6TEpNYlJjYzZwRmZyQ3BlUE5od3hiSXFGYzNOUnFNN3VpWkJhRGRYd2tk?=
 =?utf-8?B?bkM1bnlEMDNWeC8xbkhnMEZLbjQ3SWVIeWJMNVY3ZHYxYktWaXpZczdFYnMy?=
 =?utf-8?B?SEhOVXBiNmZuLzY0Qmlka0E1eWREN24xNmFKUHM4dXRWdVd6Tnp0VjUrbTNX?=
 =?utf-8?B?c3dRV0VmVCt3SzcwanFhQzVad2hVYnl2M1d2ZVIzdDd5eHV5SFpJQWwybndN?=
 =?utf-8?B?VWFla29tc1Fzak4wd1crbXNoNTlia0pJcGdtc2JmT3ZpZVcvY0J1eGlwWnRt?=
 =?utf-8?B?clBxN3dTMDFZWjlFM2swNjFlcU1Pc1d2Y1VEdDhGcWFiNlprbEZES2JQSDBF?=
 =?utf-8?B?aDYzNUdGQnZvTUZSQTN0ZGMveUZpMHpPbUhKRDdZNUtIUUorWWdPYTBYS3VE?=
 =?utf-8?B?RlFiKzNyVkMxTnhoVnUvMFdoNm5yYUl6Nlo1ZGNKdTJzc0ZhbFl2VEhUUWFP?=
 =?utf-8?B?YndaemFJNWozTEJPT1Q5b2dqWitJRXljU3lVK2s1Rm45N0wxWDhYNDF5VkFZ?=
 =?utf-8?B?dEgrZ3ZVRC9WYmdXTGNxZDNiUTREZHdmb3lkZmJLbzFhSUdBSlJZUkZqdlpk?=
 =?utf-8?B?Rmg2L2RzUG5EWCs1cHlFSGhxYmRFczI0dG00aHlSRGVnNVZDRFFUTmxRaDVs?=
 =?utf-8?B?eThHcWx1Q1dmT1M5d0lneW9DRWZwS2pRckkvZzJUdlR2S29hRTVHYUhEc3Zj?=
 =?utf-8?B?cy9MYS9FZ2V5ckhkV1c1MHFia0hMRExWWXIwd1VCZEptZlNvQ05yeS9RQUVU?=
 =?utf-8?B?dkhzdUptUGZjYllRbTIvc3c2NzBKTzZUSFkwaThXYit5TUphQlBSbExocnZN?=
 =?utf-8?B?STN6WFd4M2xBc0k4L0thcG9RN1YzVWhmbGduL1Z3V2t2OXVvVkRCUXovcEUx?=
 =?utf-8?B?aE41cmFCZzJTK2QrOTZSaTRnZnZGMENmVkVvV1AzZXROUHVwWUlYMnFuUjVE?=
 =?utf-8?Q?Ax1ujyx5vEsvStFs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8b1e8a-981e-4f67-9203-08de584f5b70
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 18:11:39.2381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +o9XuM5VHhPEBhE2JFVNjeP2parSvuyJojGcMAS+bP9YNEjmlTVaeBL0Er1Hd4Dah/slLi4n2mRWlfpYFFWRwqBigsDvSXpi0i8Tqc7mEo8kWblRhj4UwP1U7BCpu+bZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB10413
X-Spamd-Result: default: False [1.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[nokia-bell-labs.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79667-lists,bpf=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,nvidia.com,vger.kernel.org,lwn.net,kernel.org,google.com,gmail.com,mojatatu.com,networkplumber.org,resnulli.us,davemloft.net,lunn.ch,fiberby.net,nokia-bell-labs.com,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[nokia-bell-labs.com,reject];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chia-yu.chang@nokia-bell-labs.com,bpf@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nokia-bell-labs.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[bpf,netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: B39F64A31F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIER1bWF6ZXQgPGVkdW1h
emV0QGdvb2dsZS5jb20+IA0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDIwLCAyMDI2IDEyOjA1
IFBNDQo+IFRvOiBDaGlhLVl1IENoYW5nIChOb2tpYSkgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVs
bC1sYWJzLmNvbT4NCj4gQ2M6IHBhYmVuaUByZWRoYXQuY29tOyBwYXJhdkBudmlkaWEuY29tOyBs
aW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBjb3JiZXRAbHduLm5ldDsgaG9ybXNAa2VybmVsLm9y
ZzsgZHNhaGVybkBrZXJuZWwub3JnOyBrdW5peXVAZ29vZ2xlLmNvbTsgYnBmQHZnZXIua2VybmVs
Lm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGF2ZS50YWh0QGdtYWlsLmNvbTsgamhzQG1v
amF0YXR1LmNvbTsga3ViYUBrZXJuZWwub3JnOyBzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZzsg
eGl5b3Uud2FuZ2NvbmdAZ21haWwuY29tOyBqaXJpQHJlc251bGxpLnVzOyBkYXZlbUBkYXZlbWxv
ZnQubmV0OyBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7IGRvbmFsZC5odW50ZXJAZ21haWwuY29tOyBh
c3RAZmliZXJieS5uZXQ7IGxpdWhhbmdiaW5AZ21haWwuY29tOyBzaHVhaEBrZXJuZWwub3JnOyBs
aW51eC1rc2VsZnRlc3RAdmdlci5rZXJuZWwub3JnOyBpakBrZXJuZWwub3JnOyBuY2FyZHdlbGxA
Z29vZ2xlLmNvbTsgS29lbiBEZSBTY2hlcHBlciAoTm9raWEpIDxrb2VuLmRlX3NjaGVwcGVyQG5v
a2lhLWJlbGwtbGFicy5jb20+OyBnLndoaXRlQGNhYmxlbGFicy5jb207IGluZ2VtYXIucy5qb2hh
bnNzb25AZXJpY3Nzb24uY29tOyBtaXJqYS5rdWVobGV3aW5kQGVyaWNzc29uLmNvbTsgY2hlc2hp
cmUgPGNoZXNoaXJlQGFwcGxlLmNvbT47IHJzLmlldGZAZ214LmF0OyBKYXNvbl9MaXZpbmdvb2RA
Y29tY2FzdC5jb207IFZpZGhpIEdvZWwgPHZpZGhpX2dvZWxAYXBwbGUuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIHY5IG5ldC1uZXh0IDEwLzE1XSB0Y3A6IGFjY2VjbjogdW5zZXQgRUNUIGlm
IHJlY2VpdmUgb3Igc2VuZCBBQ0U9MCBpbiBBY2NFQ04gbmVnb3RpYWlvbg0KPiANCj4gDQo+IENB
VVRJT046IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSBiZSB2ZXJ5IGNhcmVmdWwg
d2hlbiBjbGlja2luZyBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBTZWUgdGhlIFVSTCBu
b2suaXQvZXh0IGZvciBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLg0KPiANCj4gDQo+IA0KPiBPbiBN
b24sIEphbiAxOSwgMjAyNiBhdCA3OjU54oCvUE0gPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1s
YWJzLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBDaGlhLVl1IENoYW5nIDxjaGlhLXl1LmNo
YW5nQG5va2lhLWJlbGwtbGFicy5jb20+DQo+ID4NCj4gPiBCYXNlZCBvbiBzcGVjaWZpY2F0aW9u
Og0KPiA+ICAgaHR0cHM6Ly90b29scy5pZXRmLm9yZy9pZC9kcmFmdC1pZXRmLXRjcG0tYWNjdXJh
dGUtZWNuLTI4LnR4dA0KPiA+DQo+ID4gQmFzZWQgb24gU2VjdGlvbiAzLjEuNSBvZiBBY2NFQ04g
c3BlYyAoUkZDOTc2OCksIGEgVENQIFNlcnZlciBpbiANCj4gPiBBY2NFQ04gbW9kZSBNVVNUIE5P
VCBzZXQgRUNUIG9uIGFueSBwYWNrZXQgZm9yIHRoZSByZXN0IG9mIHRoZSANCj4gPiBjb25uZWN0
aW9uLCBpZiBpdCBoYXMgcmVjZWl2ZWQgb3Igc2VudCBhdCBsZWFzdCBvbmUgdmFsaWQgU1lOIG9y
IA0KPiA+IEFjY2VwdGFibGUgU1lOL0FDSyB3aXRoIChBRSxDV1IsRUNFKSA9ICgwLDAsMCkgZHVy
aW5nIHRoZSBoYW5kc2hha2UuDQo+ID4NCj4gPiBJbiBhZGRpdGlvbiwgYSBob3N0IGluIEFjY0VD
TiBtb2RlIHRoYXQgaXMgZmVlZGluZyBiYWNrIHRoZSBJUC1FQ04gDQo+ID4gZmllbGQgb24gYSBT
WU4gb3IgU1lOL0FDSyBNVVNUIGZlZWQgYmFjayB0aGUgSVAtRUNOIGZpZWxkIG9uIHRoZSANCj4g
PiBsYXRlc3QgdmFsaWQgU1lOIG9yIGFjY2VwdGFibGUgU1lOL0FDSyB0byBhcnJpdmUuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGlhLVl1IENoYW5nIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJl
bGwtbGFicy5jb20+DQo+ID4NCj4gPiAtLS0NCj4gPiB2ODoNCj4gPiAtIEFkZCBuZXcgaGVscGVy
IGZ1bmN0aW9uIHRjcF9hY2NlY25fYWNlX2ZhaWxfc2VuZF9zZXRfcmV0cmFucygpDQo+ID4NCj4g
PiB2NjoNCj4gPiAtIERvIG5vdCBjYXN0IGNvbnN0IHN0cnVjdCByZXF1ZXN0X3NvY2sgaW50byBz
dHJ1Y3QgcmVxdWVzdF9zb2NrDQo+ID4gLSBTZXQgdGNwX2FjY2Vjbl9mYWlsX21vZGUgYWZ0ZXIg
Y2FsbGluZyB0Y3BfcnR4X3N5bmFjaygpLg0KPiA+IC0tLQ0KPiA+ICBpbmNsdWRlL25ldC90Y3Bf
ZWNuLmggICAgICAgICAgIHwgIDcgKysrKysrKw0KPiA+ICBuZXQvaXB2NC9pbmV0X2Nvbm5lY3Rp
b25fc29jay5jIHwgIDMgKysrDQo+ID4gIG5ldC9pcHY0L3RjcF9pbnB1dC5jICAgICAgICAgICAg
fCAgMiArKw0KPiA+ICBuZXQvaXB2NC90Y3BfbWluaXNvY2tzLmMgICAgICAgIHwgMzYgKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+ID4gIG5ldC9pcHY0L3RjcF9vdXRwdXQuYyAg
ICAgICAgICAgfCAgMyArKy0NCj4gPiAgbmV0L2lwdjQvdGNwX3RpbWVyLmMgICAgICAgICAgICB8
ICAyICsrDQo+ID4gIDYgZmlsZXMgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRp
b25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9uZXQvdGNwX2Vjbi5oIGIvaW5j
bHVkZS9uZXQvdGNwX2Vjbi5oIGluZGV4IA0KPiA+IDc5NmM2MTNiNWVmMy4uZjVlMWY2YjFiZWMz
IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbmV0L3RjcF9lY24uaA0KPiA+ICsrKyBiL2luY2x1
ZGUvbmV0L3RjcF9lY24uaA0KPiA+IEBAIC05Nyw2ICs5NywxMyBAQCBzdGF0aWMgaW5saW5lIHZv
aWQgdGNwX2FjY2Vjbl9mYWlsX21vZGVfc2V0KHN0cnVjdCB0Y3Bfc29jayAqdHAsIHU4IG1vZGUp
DQo+ID4gICAgICAgICB0cC0+YWNjZWNuX2ZhaWxfbW9kZSB8PSBtb2RlOw0KPiA+ICB9DQo+ID4N
Cj4gPiArc3RhdGljIGlubGluZSB2b2lkIHRjcF9hY2NlY25fYWNlX2ZhaWxfc2VuZF9zZXRfcmV0
cmFucyhzdHJ1Y3QgcmVxdWVzdF9zb2NrICpyZXEsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgDQo+ID4gK3RjcF9zb2Nr
ICp0cCkgew0KPiA+ICsgICAgICAgaWYgKHJlcS0+bnVtX3JldHJhbnMgPiAxICYmIHRjcF9yc2so
cmVxKS0+YWNjZWNuX29rKQ0KPiA+ICsgICAgICAgICAgICAgICB0Y3BfYWNjZWNuX2ZhaWxfbW9k
ZV9zZXQodHAsIA0KPiA+ICtUQ1BfQUNDRUNOX0FDRV9GQUlMX1NFTkQpOyB9DQo+ID4gKw0KPiA+
ICAjZGVmaW5lIFRDUF9BQ0NFQ05fT1BUX05PVF9TRUVOICAgICAgICAgICAgICAgIDB4MA0KPiA+
ICAjZGVmaW5lIFRDUF9BQ0NFQ05fT1BUX0VNUFRZX1NFRU4gICAgICAweDENCj4gPiAgI2RlZmlu
ZSBUQ1BfQUNDRUNOX09QVF9DT1VOVEVSX1NFRU4gICAgMHgyDQo+ID4gZGlmZiAtLWdpdCBhL25l
dC9pcHY0L2luZXRfY29ubmVjdGlvbl9zb2NrLmMgDQo+ID4gYi9uZXQvaXB2NC9pbmV0X2Nvbm5l
Y3Rpb25fc29jay5jIGluZGV4IDk3ZDU3YzUyYjlhZC4uOWQxNmNiOWMzZGI0IA0KPiA+IDEwMDY0
NA0KPiA+IC0tLSBhL25ldC9pcHY0L2luZXRfY29ubmVjdGlvbl9zb2NrLmMNCj4gPiArKysgYi9u
ZXQvaXB2NC9pbmV0X2Nvbm5lY3Rpb25fc29jay5jDQo+ID4gQEAgLTIwLDYgKzIwLDcgQEANCj4g
PiAgI2luY2x1ZGUgPG5ldC90Y3Bfc3RhdGVzLmg+DQo+ID4gICNpbmNsdWRlIDxuZXQveGZybS5o
Pg0KPiA+ICAjaW5jbHVkZSA8bmV0L3RjcC5oPg0KPiA+ICsjaW5jbHVkZSA8bmV0L3RjcF9lY24u
aD4NCj4gPiAgI2luY2x1ZGUgPG5ldC9zb2NrX3JldXNlcG9ydC5oPg0KPiA+ICAjaW5jbHVkZSA8
bmV0L2FkZHJjb25mLmg+DQo+ID4NCj4gPiBAQCAtMTEwMyw2ICsxMTA0LDggQEAgc3RhdGljIHZv
aWQgcmVxc2tfdGltZXJfaGFuZGxlcihzdHJ1Y3QgdGltZXJfbGlzdCAqdCkNCj4gPiAgICAgICAg
ICAgICAoIXJlc2VuZCB8fA0KPiA+ICAgICAgICAgICAgICAhdGNwX3J0eF9zeW5hY2soc2tfbGlz
dGVuZXIsIHJlcSkgfHwNCj4gPiAgICAgICAgICAgICAgaW5ldF9yc2socmVxKS0+YWNrZWQpKSB7
DQo+ID4gKyAgICAgICAgICAgICAgIHRjcF9hY2NlY25fYWNlX2ZhaWxfc2VuZF9zZXRfcmV0cmFu
cyhyZXEsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICANCj4gPiArIHRjcF9zayhza19saXN0ZW5lcikpOw0KPiANCj4gDQo+IE91Y2guDQo+
IA0KPiBJIHRoaW5rIHlvdSBtaXNzZWQgdGhlIGZhY3QgdGhhdCBhIGxpc3RlbmVyIGlzIHNoYXJl
ZCBieSBtYW55IFNZTl9SRUNWIHJlcXVlc3RzLg0KPiANCj4gQ29uc2lkZXIgaXQgYXMgcmVhZC1v
bmx5IGhlcmUuDQoNCkhpIEVyaWMsDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KRG8geW91
IG1lYW4gc2tfbGlzdGVuZXIgaGVyZSBpcyByZWFkLW9ubHkgZGVzcGl0ZSB0aGVyZSBpcyBubyBj
b25zdCBoZXJlPw0KDQpUaGVuLCBjb3VsZCB5b3UgaGVscCB0byBzdWdnZXN0IHRoZSB3YXkgcGxl
YXNlPw0KQmVhY3VzZSBmb3IgQWNjRUNOLCBoZXJlIHdlIG5lZWQgdG8gc2V0IGZhaWwgZmxhZyBh
ZnRlciByZXRyYW5zbWl0dGluZyBTWU4vQUNLID4gMSB0aW1lLg0KQW5kIHRoaXMgd2FzIGRvbmUg
d2l0aGluIHRjcF9tYWtlX3N5bmFjaygpLCBidXQgbm93IG1vdmUgdG8gZXZlcnkgcGxhY2Ugd2hl
cmUgY291bGQgcmV0cmFuc21pdCBTWU4vQUNLLg0KDQpUaGFua3MuDQpDaGlhLVl1DQo=

