Return-Path: <bpf+bounces-50420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8D2A276A1
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 16:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FA5D1885AAF
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 15:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D39B214809;
	Tue,  4 Feb 2025 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dYEPRsrk"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76231D7985;
	Tue,  4 Feb 2025 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738684774; cv=fail; b=ZpZhaCqMQINpLZV61Suf+y8HyypOgC586monvgS4FPg0uxMaDoF0t1o59/caX5rl2NFPUjYYlKZABkOxQevw358VFdS9zkRBXh3KlylMKxhPYZ8Qb+Dsm8fdQAPpU4esUVctXOFTiYBRl2vmnah6t3oMg1kToJklsFcfpvIp7Qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738684774; c=relaxed/simple;
	bh=hsjOlHtB9fqOkjramd5+IsH54X+++wnIHDiChSyLwBE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IitGal5eB+sPxIaCuy6dFdbKi9h/E+ElZy/hkYYLAB3ADlkq9uW0fAs5aTIk0URWzbO7Mb5XEDiHP90ipP5cS5jLUMe0DT3nBipsAvzI6f9O/njlyaFbgq/l6K4f37jOjUQTAi4ix5lkZOoMKMIkFKEFtXTxhZsJhwrwZm04ezY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dYEPRsrk; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dldUJKixPtN9dUhgy8+0ZOOCjCfEjmerIAkoYmDd5Te/5oT4oz5kDJCAwulScUQ1ift+3x+ntFlhNSQuXuoT331Et/O1covQWMBVOGBYtZ1jRuOCgHkdpgjDIyxymLAlGI/Glugcc9On+UTGf25oB05DY939Lz1r81aqTc4wYCYP7ZHYS+/OpzNJk7+4KBHcEDIKkkfdCPmrA368UDZiXLElYbcH3EwE7FEZPQYCYWA+pcUf6YHrjiHldguwS3DZK7Mwn6Y9HXwrj+3xElqeaDTBKZf4h3AUmZ5qWjBEmM9SpHP5wt2UsPrsRjoNZGjtvJd4WxfwR+tpBv630ZDgRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsjOlHtB9fqOkjramd5+IsH54X+++wnIHDiChSyLwBE=;
 b=cIE8fPufYeB5RMYJYegW62SpA2kuPrGBXEwUlbBL+NQKS/T3VLHKTVGgVPXD4yezQp+YjKfKOQnxmf5yx4lkFHGYgiLtbHT20F27jqTP+6hMqljRUuhulJuwlUhnYirspJi5DsrJmC0I9Gcweuf07t1phm9VT+cezf/koy4EzLvWSAlI6B9xUFEhNoO8GHOKQvwfAcoJV6npFL1WXYR+UfQQnH5vgq/i125PpwfVeoZdOrWrd1ediTIs3CJ7bPh2MpwaLN2nLc7rm2LD+2gnXmRN+Ry+wBdEbl4QJtzt/bp55OspmEPmJiyZ+8ZQudi3zHz7y72faEUAAy011hSqUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsjOlHtB9fqOkjramd5+IsH54X+++wnIHDiChSyLwBE=;
 b=dYEPRsrkJNGYm9JDJIE2zpItyu5rGVT0aepsPVcwfcctqMbp2iUMDZzbi78rAFMKA0nrwjc/BBTEmU0UGSnI9kLmc0zS28v/uDz3TB0MqEABLu2ozY7g3C31f5xXANw9rIu5iffQmUsYOOU7TVjvP+rThzRVkv0tGRzWjzpboNhCG53G1+jGpyiZg94HIldnRtDxfbaDb/f5DA14JQbdCxKCFB2/MPLFAxcdoD2nbIkYgSk4aKGmyeqRi2ojbbCseU+PSyRJAnT6wHq64RtuNnO4NmwtkUZS/MDBd9OEzgAsSKR9nc7Ol9TGWcez6m1swKDSGhM8YxcVAsmg6Qz1kw==
Received: from BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5)
 by DM4PR12MB6011.namprd12.prod.outlook.com (2603:10b6:8:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Tue, 4 Feb
 2025 15:59:30 +0000
Received: from BL1PR12MB5922.namprd12.prod.outlook.com
 ([fe80::5851:fa86:f137:1858]) by BL1PR12MB5922.namprd12.prod.outlook.com
 ([fe80::5851:fa86:f137:1858%7]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 15:59:30 +0000
From: Amit Cohen <amcohen@nvidia.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Petr Machata
	<petrm@nvidia.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Network Development
	<netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	bpf <bpf@vger.kernel.org>, mlxsw <mlxsw@nvidia.com>
Subject: RE: [PATCH net-next 00/12] mlxsw: Preparations for XDP support
Thread-Topic: [PATCH net-next 00/12] mlxsw: Preparations for XDP support
Thread-Index: AQHbdvTSSF23zIgvCUCVpF8bzJYgQ7M3TLQAgAAAhaA=
Date: Tue, 4 Feb 2025 15:59:30 +0000
Message-ID:
 <BL1PR12MB59225F7D902ACBC6A91511C3CBF42@BL1PR12MB5922.namprd12.prod.outlook.com>
References: <cover.1738665783.git.petrm@nvidia.com>
 <CAADnVQKMN4+Zg9ZG4FpH9pJw4KdmwWmT2d4BiJgHUUQ-Hd7OkQ@mail.gmail.com>
In-Reply-To:
 <CAADnVQKMN4+Zg9ZG4FpH9pJw4KdmwWmT2d4BiJgHUUQ-Hd7OkQ@mail.gmail.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5922:EE_|DM4PR12MB6011:EE_
x-ms-office365-filtering-correlation-id: e04a61c2-87c9-4f89-cb75-08dd4534e8af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MVNWWWtHTFdTUDN4ZnJVZ2xxeVNpa3Fock5CbTVaa3RRUjZsb1JCQjM4TWl5?=
 =?utf-8?B?RFdlaFVNOFNTUWR3dCtmeTgvWS9zV29LUTM4QUJNMlZjOEgxU05CQWlYaGtN?=
 =?utf-8?B?TWpDVHdRRER6L3hLN2NwTzR6UnNwZmQwclpCbEcySkQrdmdzakw2aWJQNjdo?=
 =?utf-8?B?aXFWQXNrQ0JPeWJvbnVaQTluY3A4cVE0YUpXRVRWWURHYVpicnBxdDhCY3pi?=
 =?utf-8?B?RjViaFgwRzVJV2Y2VlVKYXV3TUtUblM1QlVDZ3EwQ0x4dS9Ia3A4UXF6aldB?=
 =?utf-8?B?Ny91S09ZU0t2SXpHRlh2eU5UaEJjdGlBWVZjc01GMTErYzBYZFo5SldTZHRT?=
 =?utf-8?B?Mm44bW5Jd1ZteVl1aTE5S2Nmdzk0bTVtVTBZNjdyWGhZOUNkMGhoL2pWMHI1?=
 =?utf-8?B?Vnc3Zk8vODlVak5aSHRnOGZydDFWYlp3blNYS21NMlZmaWNyaFRGcjRNbEds?=
 =?utf-8?B?WFE5RjZISUVvamRpZXBKQUxJeGI2UkxoRmhqUGpFM25XM0wrZjhNWG1lam5x?=
 =?utf-8?B?ckNaRGJXclhaMTNYYkU4UWRXbzkza0FwYWhvVXRsL01TdVduRk8rZ1lhT1l2?=
 =?utf-8?B?Y1FVZUc1Ly9EK04rYUlKUWZ4eDFSenJqQWFWOGg2QW5oOTNJTEtkdWxvUXJW?=
 =?utf-8?B?NHFoR1dYdW1UcjNHWFVFNlBrZXRoOWtEd1o3cVU4WGYxek44VG1JWUYyK21M?=
 =?utf-8?B?OGc1dHFCbEZFRWlGRVV1dzNpSEJlcVNST3RSbHpjeXpSWXpzMmVjSjA2MXJj?=
 =?utf-8?B?OEdvVzdjVVlUTmQ0M29oYzV4cEFFcG04ZUdxRUhCUVZLQUE0YXB0NTloeDlt?=
 =?utf-8?B?aU1ZVFBYUnByTklIT2g4TGNWUnptdEhqUTBGSzhteDBlemRlNWpYV0E3S2FM?=
 =?utf-8?B?V0xxMHZYYnE4MTE2N1BxWUtCRnlMWUVQcVVjNXNOQzVjbmViTTZiMUkzcnBm?=
 =?utf-8?B?RVlkR0VLZjlqdWZvSTZGNlVJZTVZWEs2K3Z4eXd6aW9DL2lrUytRaWl2Y01G?=
 =?utf-8?B?YjNUOUNwUzdhSFptZ20zTFlzSWVKWXlYeGZSL2M1NnRXODF1V2RDMFpYMEdo?=
 =?utf-8?B?c0FweGRiRGowMlZpZjMzaHVPc3NCWDN5QmVFWjNBQjJqNWVveVVGSW9xY2dC?=
 =?utf-8?B?UERNVG9BZ21XcUFkRmhSSFF4dnZUSGovSEZ4NE5OTmR1d3N1SGFiUTZ1UEtE?=
 =?utf-8?B?UVdMQkZwc2xrNVBVRjlaUTJ3SnVZbVlIQU9uMWs5OENaSDdiMHFYRzlQcGVu?=
 =?utf-8?B?OFdKSDNHdkhBLy9wMmdhQWtBR2lZR1NKNlVTMWp0WmFoMklLVHZvYU0zVzg2?=
 =?utf-8?B?T3NoQ0haUlVvS3dpOEZpVkd0QnZZaWNYWE1ybEVuU1FLZ0U5cXRpTXJEeExB?=
 =?utf-8?B?RlhDcGszdStCTkllSk8yQ0JzL21lRTFhend4WllHZWZCNHYrZlhRSVBoV1pl?=
 =?utf-8?B?YUhiYzlza0lpb3l4TjloYUI5bnkxVHZiTVFRSnhqY2dsYkZEM1kzTjRlMXlm?=
 =?utf-8?B?Z21DTVg0Q1VBNURkZm5ZUzVKRFgwVFFoZGNFck1nemJLSTFRSWVxMGdxWWV5?=
 =?utf-8?B?eVFZSDk5bElibjU0bDFmeFJnZ2NWYTRualNTYmhrbnpUZVVHQ0k2dk1qVlp6?=
 =?utf-8?B?UnhrdWlVdDU5KzhROFNRQ2J2b3B6ZzZpYnhWeGZlZ3VuSStXK2JvTjZiNit0?=
 =?utf-8?B?c2NzeVpKeTFSeWRab2NMNUoyblpQSURvNTVXcVk2KzFsTndOdDR0ajFoN21i?=
 =?utf-8?B?VGxBMUl2WnlGMTY3K1Q0a2tvaUFCSUVNbE1TdS9WaUVYaWQ1Y1BqeXlwZjZK?=
 =?utf-8?B?SXkrc09LTWZvbGVEbVNMOU1iVkFBdzN4cWpmeUJuTWV1L29VMlZaQlltRkxB?=
 =?utf-8?B?MW9CSHcwS3pvV0I0ZUxKWFR2bjVmdmVsWVY2RGo4MklWWXQxZFExU0pxMzUw?=
 =?utf-8?Q?Ysf15S+KIhkZjcFEvLNt7auTznPpdlbH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5922.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eXVlSVRDV3NzZTZrcjZmeWhnVmdNNlVUYkpmaTJOc0JxaWtob1FzVHZtaVV6?=
 =?utf-8?B?NTYvSmZoK1c0b283TW1QZjR3Y3ZTSjg2dk0xbVo5QXBPTzN4Y1c0NTRrOFFO?=
 =?utf-8?B?NlZCcE1ob2hybmZvQUlLUVNicVJUTEpHY2J0MXNUOWhqNGxDYkR1OGU4S1Jm?=
 =?utf-8?B?dCtPVEpEQWFMZDJZQ1pOUWdoNllHZkFNRmUzWFFBbTRmcmpRanFDOCtrS2pz?=
 =?utf-8?B?OE1iZ2RrK0RFYU4vMlFVQTZaQjZ1ZHU4dFgwSVpwSFR1ZEhjblhFY1kwckJ0?=
 =?utf-8?B?YnBCeE1BLzVCbE9yZjY2QmNxVGY4ZVFoVTF1SENWVm80SnRvaFlhbUE0TzNw?=
 =?utf-8?B?dklNVmNBT01xa0tQWDNPU2NMMkFoYjBwRGFGbVZmbHBXZCtRWWxTdnNQWlky?=
 =?utf-8?B?OXo1anZSUlV0b3hFTUwxWnZiM2NsU2hHY3NpUzBrelcwakNVQWxvNmpSdS9z?=
 =?utf-8?B?QmFudjcrMmdaeUlnY1hEZGF2UUtCalA0SjNNQ0RKbVZELzJ2bFJMd2NrZDJk?=
 =?utf-8?B?T3hOTjNIUExocldXNG8yYVIrQmI4VU1yelByeHMxZE5lRXhiN0xIQVFkV2Q0?=
 =?utf-8?B?T2UzN2paOWRpOHdFSllNOGNhd3BpSkJndnRaRERxL00xQzRoVktVTTZOT1lJ?=
 =?utf-8?B?d1hBVnRsczYyUjBHSVE1NmFETnlMRDdHcms1aFN0Snp0VjBnKzAyVUplWWhY?=
 =?utf-8?B?Q2Qra2NPdi9kckNITnZDVlpKdjg5WGNpUW8vTEUwU00ydExsMDJwbzZjNm90?=
 =?utf-8?B?Q2tML3hOZGE4UVpzbUVVYmt2YS9MbDU3alpxbVo0RjAvMGtjTjJGNGZ0TmEz?=
 =?utf-8?B?OG12ZnNiV25xYXZQVSt6NFBYZVpod3grY3dFTkdVelRvaGtqQytVcm9SaUJi?=
 =?utf-8?B?QXZBb3hjTFFodDRZdm5vQ0kzQXIxWXJPQVNnOWVUVDVQaTlsK3VWNXFJUXho?=
 =?utf-8?B?c3FPOXBaVmt4bkdjczFHdE82U05XOWw3LzNYa0ZlTkRLT2s4L3JvekRYc003?=
 =?utf-8?B?NklWV2NKOEFzRjBrQytVRFZ6YUxLcm9yS2Q2MVI3aFBjZ0xuQkZJdjBEQlpQ?=
 =?utf-8?B?SXpoSVBLSmJmdUhyc2xvakY0emU1UFNlYWhyVk83VlQxU0tXUFh4T3JaN1Vt?=
 =?utf-8?B?a3g1SlZyUjVoSE5FbWxjL1JIY0ZmREs1Sk9zSXJxeThQR3BBS0pURjBCMXNO?=
 =?utf-8?B?RUlONUR2UDI3MWZtUk9HeklXejdlQXRxUURjYzhLUVcvenR3cWNUWTFlclRp?=
 =?utf-8?B?WG5GUENnSHIyL01iaFRWcysxYUd3SHNyc0U1aENXaS9QK2Jvdmt6MXJUU3Bl?=
 =?utf-8?B?Q0JqSEhyODhSTzgzdUQydTlYTjhnckN2clI3ZERIRjhWOGZpc1pVV0t5aGVl?=
 =?utf-8?B?WWhQMVQvOGdGTmR2cTkweDFDRk10NGx3L2FPOFBUaUtweHl4RTJ2UFBYZTRr?=
 =?utf-8?B?Njd1YmF5bkxMR2VCQ1cvRFFxQmtCb2JTdzhCQWE4YzBaMjNqOEM4TUUyK3FP?=
 =?utf-8?B?eU9lK3pQTkpSRE1rT1VlenJXVVRjRGdHV1dDamNiNGQxREkvMHpNUmh1bTZa?=
 =?utf-8?B?ejAwSThwZXl6M1BWMHROcWg5dWNxSVFaZUF5b3R0dENjaE81c0tuZGh3VDd1?=
 =?utf-8?B?SzljTWpPRXpYdjV1TmNzZ3lYL1plUysxb3F6TzQxdFNublZKTlpMeWZLZnht?=
 =?utf-8?B?NzBzVDFpWFBlZkU0Z0xUMXhia09pbk45TGdEU0gvVXNOSjlIanBOQ3ZkN0ZB?=
 =?utf-8?B?OWc3TTJTSWVpOXJsbVljZkV4dHFvOW1pZjhoU3lENHQ1bGlpRlNZbTVrMmZU?=
 =?utf-8?B?WklHWk1EV0hJL1MwMVUyMFVZeFlEank0VURvRndGQS9JS2tFb2pHWEIyK0ln?=
 =?utf-8?B?bEZaQVh2MzU2MmtoRDBqSzIwR0RKOFYyRUY1RkZrS1NDYkpmSS9mVTRaNFpV?=
 =?utf-8?B?OElyaDVuRVVBd0hYZXJoT1AyMTcyOG44YWZrQmNVNXNRa3MrMXkxUzlMaDZW?=
 =?utf-8?B?cjYwbkRBM0F3T05rNkdKSnRsTjJ0M2ErUy9DZHVrZjJDd0hGV2IrN3EvTjBj?=
 =?utf-8?B?ZCs5MmlmVUZPU3JMQUFCWUtxQ3ZRYm9ybndJRDVrTjArYlJRc3hlWWtJakZu?=
 =?utf-8?Q?Wy3QxnJEiUhkmvEdnXE3weJHy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5922.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04a61c2-87c9-4f89-cb75-08dd4534e8af
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 15:59:30.0497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 48hv0QzBBvF9IwNfd1E1CHkRY0HfVi1ncUcVfcIPtZFgbYykOlUx1Uic0Q8zb2Q0hUOLkpL/VsEGadpc/bnSUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQWxleGVpIFN0YXJvdm9p
dG92IDxhbGV4ZWkuc3Rhcm92b2l0b3ZAZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCA0IEZl
YnJ1YXJ5IDIwMjUgMTc6NTYNCj4gVG86IFBldHIgTWFjaGF0YSA8cGV0cm1AbnZpZGlhLmNvbT4N
Cj4gQ2M6IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD47IEVyaWMgRHVtYXpl
dCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT47IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+
OyBQYW9sbyBBYmVuaQ0KPiA8cGFiZW5pQHJlZGhhdC5jb20+OyBBbmRyZXcgTHVubiA8YW5kcmV3
K25ldGRldkBsdW5uLmNoPjsgTmV0d29yayBEZXZlbG9wbWVudCA8bmV0ZGV2QHZnZXIua2VybmVs
Lm9yZz47IEFtaXQgQ29oZW4NCj4gPGFtY29oZW5AbnZpZGlhLmNvbT47IElkbyBTY2hpbW1lbCA8
aWRvc2NoQG52aWRpYS5jb20+OyBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBrZXJuZWwub3JnPjsg
RGFuaWVsIEJvcmttYW5uDQo+IDxkYW5pZWxAaW9nZWFyYm94Lm5ldD47IEplc3BlciBEYW5nYWFy
ZCBCcm91ZXIgPGhhd2tAa2VybmVsLm9yZz47IEpvaG4gRmFzdGFiZW5kIDxqb2huLmZhc3RhYmVu
ZEBnbWFpbC5jb20+OyBicGYNCj4gPGJwZkB2Z2VyLmtlcm5lbC5vcmc+OyBtbHhzdyA8bWx4c3dA
bnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dCAwMC8xMl0gbWx4c3c6
IFByZXBhcmF0aW9ucyBmb3IgWERQIHN1cHBvcnQNCj4gDQo+IE9uIFR1ZSwgRmViIDQsIDIwMjUg
YXQgMTE6MDbigK9BTSBQZXRyIE1hY2hhdGEgPHBldHJtQG52aWRpYS5jb20+IHdyb3RlOg0KPiA+
DQo+ID4gQW1pdCBDb2hlbiB3cml0ZXM6DQo+ID4NCj4gPiBBIGZ1dHVyZSBwYXRjaCBzZXQgd2ls
bCBhZGQgc3VwcG9ydCBmb3IgWERQIGluIG1seHN3IGRyaXZlci4gVGhpcyBzZXQgYWRkcw0KPiA+
IHNvbWUgcHJlcGFyYXRpb25zLg0KPiANCj4gV2h5Pw0KPiBXaGF0IGlzIHRoZSBnb2FsIGhlcmU/
DQo+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhhdCBtbHhzdyBpcyBhIGh3IHN3aXRjaCBhbmQgc2ti
LXMgYXJlIHVzZWQgdG8NCj4gaW1wbGVtZW50IHRhcCBmdW5jdGlvbmFsaXR5IGZvciBmZXcgbGlz
dGVuZXJzLg0KPiBUaGUgdm9sdW1lIG9mIHN1Y2ggcGFja2V0cyBpcyBzdXBwb3NlZCB0byBiZSBz
bWFsbC4NCj4gRXZlbiBpZiBYRFAgaXMgYWRkZWQgdGhlcmUgaXMgYSBodWdlIG1pc21hdGNoIGlu
IHBhY2tldCByYXRlcy4NCj4gSGVuY2UgdGhlIHF1ZXN0aW9uLiBXaHkgYm90aGVyPw0KDQpZb3Un
cmUgcmlnaHQsIG1vc3Qgb2YgcGFja2V0cyBzaG91bGQgYmUgaGFuZGxlZCBieSBIVywgWERQIGlz
IG1haW5seSB1c2VmdWwgZm9yIHRlbGVtZXRyeS4gDQo=

