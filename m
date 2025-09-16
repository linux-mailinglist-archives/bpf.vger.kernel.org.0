Return-Path: <bpf+bounces-68485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2528B590BF
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 10:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32C81BC5B78
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 08:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288B0283C82;
	Tue, 16 Sep 2025 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rgYECUny"
X-Original-To: bpf@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0932D136E3F;
	Tue, 16 Sep 2025 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011547; cv=fail; b=dJjKRt5sfeLs6ILqohKR6k2cv3lInpDyHR4TZljVkuHercX5kbtCzQUpwK+j4oGbuG3sgX+mUzhETZq0E+L5EqrAWr7jC9SfZyWe1QnFJ9Beuo3+8Q6b47H9YxI/YZKvN3QwAInYTjU22gYWrUHQpep58eknDbMV/iKPvH2njfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011547; c=relaxed/simple;
	bh=DIqfJKxOp+EmGT2OoMPXSBSOjkW0erCmjnLUXhg7ruU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ffz3K0bCMvJ6xM8KdYf7dAEzcg2yLqetOTv0BPHzJODT+CJpjZArj1kGibWyVhvBmgBJ+BGj1sl4HpaoQGPcZ6KaByEqWtHt+U8idpPQTeZ4GYaZwD7NHCRRtneNs0bnlNCIwo3cJJx2Fhk34KorsIEevO08nKRjK8aDTMwr1lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rgYECUny; arc=fail smtp.client-ip=52.101.46.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CugL8mZjCsPbrNUZkcwBWUNGdSqVJnyadNcmBpta5MLCx2l//FuL+9ndC+FJWgB+uexEpVzNJNApuGF7LkovsZPUqqxtW+BCpZZqfGMSl3ZPvlyDMOeiPoomgDVvs5kr/L2sz7cbKyaslQ4Bc98pLNh7MYjoKPHY15Rbpi/uehcQx8/XeeARbji1ioZBEpqCmPc0BpuYqQ1m7DvG6h/hJe8wcGEv0BhxZ7h9OnmXY/JGZZksp+buqUdS6BshUPzMROQlB53F3RemQh1FVS8g1V5qpUoaBDXZ09V18mM7xcENYIT/Bi9geAypjLUnAXLMaebhNXvztzfTUsPHhorkLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIqfJKxOp+EmGT2OoMPXSBSOjkW0erCmjnLUXhg7ruU=;
 b=VtYwAUmxW+nbfy965DjWO1jOUTviD0KefsTiyLAz+CVOThZGV2+7PW/52KTe6AErUxxlxoCLoygh1YiF65Ksnbat2NQrv2ugsT8AkdbpUh6y4glyNKttElAYRd0ylFmlnRWewmwrUK5E4Fz91Y4TMBGCC4VySBCMBhexjn5StPIOmA2CiWecdZ4Qa3C+kQGEBwpO18jBVKwkEoeZCcrK1tpfwa+PJIT0pTx6ZcGEbwd/2GCa5EGB4GJNgYI3G3E0eDNB2YXWSlTbVJ5hDt4PcxxctLP1sT+iP43JKSuYCiBtFOjeMXVNdikttlCdB6EE5v/1+mOGk+EZimif1mzpsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIqfJKxOp+EmGT2OoMPXSBSOjkW0erCmjnLUXhg7ruU=;
 b=rgYECUnyQ9WsBOAABZ/jZ6H9Cz02My2tpogOD2nFAy6oWm8bAdKBdLqiPQfQkgpNDGPf4x3Si6HtuBnGr/IvUROkrjUarI/omabja3dc2tXHZYLTYbKDz9YxGNC9abdL660eUzLoXn+xN+UirpWGX4Z4jSnu7+hL6uL3GQDmx7rxeNhVXrAUPDU0Vm4jF/Ajn1vlvD0uTsol7Ur0OFjVJan2pE51tZm9qDSv2affmMO4s3CoOTJ+3eUaqKA5QLBgRPbLActapSQQtdyAkn/5XLnQiMONlbsS4xwYZYq02Ou9nJQmiztkOzhH6ydomqgL/+lnWyzjSBUR3wKlvESapA==
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::648) by CY5PR12MB6407.namprd12.prod.outlook.com
 (2603:10b6:930:3c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 08:32:23 +0000
Received: from DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::6d92:929f:6838:fba9]) by DS5PPF266051432.namprd12.prod.outlook.com
 ([fe80::6d92:929f:6838:fba9%4]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 08:32:23 +0000
From: Cosmin Ratiu <cratiu@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>, "stfomichev@gmail.com"
	<stfomichev@gmail.com>
CC: "corbet@lwn.net" <corbet@lwn.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "hawk@kernel.org" <hawk@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "leon@kernel.org" <leon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "ast@kernel.org"
	<ast@kernel.org>, "jiri@resnulli.us" <jiri@resnulli.us>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Jiri Pirko <jiri@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Dragos Tatulea
	<dtatulea@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Saeed
 Mahameed <saeedm@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, Gal Pressman
	<gal@nvidia.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: Re: [PATCH net-next 10/10] net/mlx5e: Use the 'num_doorbells' devlink
 param
Thread-Topic: [PATCH net-next 10/10] net/mlx5e: Use the 'num_doorbells'
 devlink param
Thread-Index: AQHcIj1kTZykFGrCMUe+G7il+UN0QLSMmBkAgAjsRAA=
Date: Tue, 16 Sep 2025 08:32:22 +0000
Message-ID: <a36bc123aa1021a5aeca0494f4b8ea140ef789d0.camel@nvidia.com>
References: <1757499891-596641-1-git-send-email-tariqt@nvidia.com>
	 <1757499891-596641-11-git-send-email-tariqt@nvidia.com>
	 <aMGkaDoZpmOWUA_L@mini-arch>
In-Reply-To: <aMGkaDoZpmOWUA_L@mini-arch>
Reply-To: Cosmin Ratiu <cratiu@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS5PPF266051432:EE_|CY5PR12MB6407:EE_
x-ms-office365-filtering-correlation-id: a8b3eacb-1f79-4b91-34e2-08ddf4fb8f0f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?V2lEd1ROcXB4NVgxVEdpa0Q4ZWlCcVlnNmpVMElaRlI0L2RlZGd0WUZ3YVQ5?=
 =?utf-8?B?R2RRRGNQNGRZejhiWDdqVWhUK0lmODZlNlkzdjgvbkJTS3daUjlqaEdlRnVL?=
 =?utf-8?B?LzdwdEZ4cytDQ09FeVlSaTlpU1d5VEh0RDZGU3kzcDBqb2RIY2xiZ1R1QUV0?=
 =?utf-8?B?ZXpJQXBVM3dRaVJxZkoxMEt2YXJyeHQ4Wkdac29yeHFKYjJ4MzR3VERtajBU?=
 =?utf-8?B?UmZJYUFDKzhGbkMrbHFzWVRZT0pFV2dDNTFMRjdLQmVWS3NKSWowUmlIZXd4?=
 =?utf-8?B?Nlc4RFdMM2VWSWlhbG1kbHcrN0RvVU9TTS8ydlBSTEFXZXNMUFNPbTJvUWpk?=
 =?utf-8?B?TzU1RGo5QjRud2NXN2dsakNpaEFXZWZ4c0luRklSUkpFY0hMeWpFQTJ6V1d6?=
 =?utf-8?B?QzR4Qi92a2lqczhDQ3JjK2I0TmZ5elVsVlRyRENRVXFOc1d1RVBudFMrN1JW?=
 =?utf-8?B?TmFISjZ2akRzM1FlcUl2ck5Ta1RVcWZkb1BUQmh5cFd0d3BkYkkvK2NWNHVQ?=
 =?utf-8?B?RHZLV1pUaTEvTTlWL016Qyt2bzFrdWhnTjU4TFlDRFlNQ2ZuV0VManRYd3dk?=
 =?utf-8?B?UzhjbDd4WklZSVZhTkxlTGpReXdYNEZxc2Q4TTVJY2hyZ1RWRWcyeWd4OFkw?=
 =?utf-8?B?YkRsU1FiRDhRU2c3RDhuVUJYbVVDWkNDVWdmSzlJemovRTUrbTJKTElFVHdV?=
 =?utf-8?B?Mkh2SVQyaEpGZ0VwRnpQQk5tQVZyYjJRbDhPcytUTkZzOWFKeHFHQStJWVcw?=
 =?utf-8?B?T3JYaitIdGQxbFc0NnhFTThFSm5XQWpYLzZXd3VtVjJ2QllOSHUrVU1DeVE5?=
 =?utf-8?B?TVY0VitKbEdxNHBrZUhGVHVoRzVQWHh4MDczeno4c045ZmsrYmkzajBpYWZM?=
 =?utf-8?B?ZlVtUWJjYTRRNU9zN3JtallRcE1GOEtQcXJsTnhGa3dCb0JHNkYvN1NvTEJ0?=
 =?utf-8?B?RnlPZS94cU1udHV2b1hsdnNkYW1IK0pFZ2hXN3h4NkprL2RxMVBNVktEZEFP?=
 =?utf-8?B?MnhvUkJDKzVvaVFyZlE1NDE5a2pxNStZazBSSlZON1FTQ0ttMEg3eXJ1ZThm?=
 =?utf-8?B?UkRlQmY2TEt2ZXVLNGw2VXBmM3N4am5URmNzeHUzMGVaVTVvODREUnFoWjhh?=
 =?utf-8?B?VzJxT1kxUjJDTVFCNGdnUm5uZXVtblVOWkZGUkNtNUV5VjFUMGhUeVJZY1Vi?=
 =?utf-8?B?ZnE1TGtIMlJBZVI4KzR4ZVJUbzFLSWhlaTJWdENuUmZzZzdtMlEzSDF2RTd3?=
 =?utf-8?B?N1lSSjk3b2pPNXUxclBWU0RjcEowWXRvNEZNK2JLeGFET3Y3NHAvNEUwTTVL?=
 =?utf-8?B?MENUVUtjeFNEN0I4Q216S2JNOGk3UGR4SlhLNGF4WDZZcVpJRFg1bWRRdmNw?=
 =?utf-8?B?cklZKzB0TzVvUXNHTUt2UWFEMUIvdC9WcjJ0MVhCZHF5YmIyL0VzcXVuOU0w?=
 =?utf-8?B?cTlCOE5qNjZOYnl1M2xjc01IekNDWTZDcFI3dHVWMmhpSGp1UlRIckRvbjRt?=
 =?utf-8?B?cUo1eGdkK1FFbGE1MDVlbHAzc1VWR0dLS2lUa2ptQXJWT0FpR0JyU2E3UGNa?=
 =?utf-8?B?bTVIcS9QcUJkdVRuYnJQQ1ErdmpWamJBeGlKalZkNGMwSHcxZ1ZuRVhpdHpn?=
 =?utf-8?B?SVhaNWZ0QTM3M2U1U2VET2EvU1h2Zll4V01ESWNUU2c2ZHNXTGpFUyt4dmZB?=
 =?utf-8?B?Z3NaQTlkRjVjQ09SNmZ4RmFFaXhZb0haU3NZK21hSkxjZzZubzBGUXFFc0xR?=
 =?utf-8?B?V05MVjFjT1NUb3JFdkVvZ3A2Y2dETUxjUWEvNWRXUGNlVk96K3FrQ2F4YjNy?=
 =?utf-8?B?aHJsTU9Td1E0L09HNVdtV0NHT2YwUXgrVzNEVFpoUVk2TjJGWXZ3OSttRndG?=
 =?utf-8?B?SUw3R1NENWFOK21qcWFzWm1EYkpBa21EN0NGL1RIMUI5L1FUeDFXU1NKRUNi?=
 =?utf-8?B?Sk93WVpVNDhiMFlPM2xaUTJkYTBudlYxVUwyRzZRK09IMzcwa1UzRjVDc21s?=
 =?utf-8?B?NW9NNnlOS3d3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF266051432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?blEzWTJPQkp4UVhMcnR1aGxYQitpeUlTS3dLMHVRUUJGeUhBWDZXWjhrS3RH?=
 =?utf-8?B?RG81eUJCYldTdEZaS3JjZEdKVTRVbVRWd0RtZm4yWFQ0QnBtR2g5NFRZNUxQ?=
 =?utf-8?B?UmNUcG96bzNrZDBCYnJYa3NPTVlsRHV2SG0zalBlVUNvUVREb3RtL1lXcllw?=
 =?utf-8?B?eHc3eGx6MVNQSXE2ZGhCeTU1K3lkU3U2QlVzRmFMdzlmRE1oRGRlRVlmY256?=
 =?utf-8?B?VzhDSWRsQXdQSGxpeEhUVVZZTWU5OU5BMG1FeFFGdzJKT0F3aXlaNXFUVDRm?=
 =?utf-8?B?S2Q1MFIwTk1lRGpMajRhZklmeDlybjFKZnVzVDhZZ2NrYzZyd25YWWdYbDFT?=
 =?utf-8?B?bW1pNTZKYWNRNjBJT2VnT3h2a2hMOVZFRFNUQitSN1diMEc5a0ROMWdBSGk1?=
 =?utf-8?B?cGRDVFVpYkRBdWpORWEvcVZZSVFyWVg4STRrMVBMVE5EUEJHZnFkV3dPVHc4?=
 =?utf-8?B?dTUwVUQwcGN3UHhNdGVVdEEzN2I3Z2lMcUVEVExoaVc1aDlvWC9VKzh6WXhQ?=
 =?utf-8?B?ei9WTkhwZ3YxOGtzRDJBV3JRM1NjVnBoWVpld2JXd3c4aXU2TjNsakZ5Ni8y?=
 =?utf-8?B?MktjR0tMM3BrbUovblc1RENvZXd6SlJPclhFbDNibTRkWForbUVtUDZaelRt?=
 =?utf-8?B?MHF1czNwdUMzeGR4MFlIekdCSDhUNUo3aGtOVWdxejErMEtiK0xEaEVCdnNm?=
 =?utf-8?B?UGR0NXlDK1FuVEhPTVhBRFVpQThLbUxyQUFnK3pTcE5IbVdHZ0xyckxJUVIx?=
 =?utf-8?B?aGI0OFE4aUpRbkhUUlp0UGIzeTNNa0tKMmwwb1AzZkFoWjRERE44WXdEa1cv?=
 =?utf-8?B?WUNNOVFOZjE4SGVhY0Jnc1ZBNWZCSUZ6OHFQekxKQVNLdWJjK05EMmFsR0NS?=
 =?utf-8?B?ZzNOQ1R1VXcrZWtleThqQWFWMUc3MmJhdkFlcjhONFNrcTd1OTVkeDdJYzNt?=
 =?utf-8?B?azlmMHFucDhOZTdPa1FtclY5a0FJcHJzbjk3VStQeFVPRVhIY016Z3NmZ1g3?=
 =?utf-8?B?cWY1TnQwVlhEMCtEM3dScHVIRlp0RVJ6WkFlSGJMdnBObUNFQTk3YlNaQytF?=
 =?utf-8?B?Z010eUlGcTBYOVRkV3FlZ2t0dkRGWkNyZXJ5K2FoN2VsNGI3WGM3aHBpcnlR?=
 =?utf-8?B?SEJDWEU3QjJtZXZzSDRjL1hUaFE4Mi9zTzVnTTczY3BtU1ZWbTlRWG9kcEZ4?=
 =?utf-8?B?Z1d6WUJvRGE2WVE0VDlDNHdGYnE3K1RxWDB5ZFhBdG1DRjNMZ3R6Zi9NanBX?=
 =?utf-8?B?ZU5uSlR4UnVNUFhoZzlhcVBUODhacnFvS2RGOGJGTGlBcG5JM2J5T2c4MTZt?=
 =?utf-8?B?WEtjdzg5S0F6ZVlKbWh4SW1laENZa3F6L1BlWmxPdEVMMlFCL01xbEM4Vmt6?=
 =?utf-8?B?eFBRQTYzVklFVDJoTGF6WWxWVnF5dXpCV3pxbmYrNHEyNHVzNmFQOUN1QkNX?=
 =?utf-8?B?QUN5VkFjeW9HbHhtSUp6Rm55dytYUmR0RTBFaEVpQ28xRVV2K1ZDU29XbWU5?=
 =?utf-8?B?OUplK25HcEVuN0EveDVYcDF1dlFEUWpydE1WeUJHWnU3QTU2K2dsd1o5TkRG?=
 =?utf-8?B?TEtxK1grc2V0MmxEQlNnano0ZW9TcUVDSG1mRkx1blVZOWRZVmxNekJDeGdU?=
 =?utf-8?B?VWRhTjJkTGJOSmRhMU5NUlJ4Ty9QZWpIL2l6cWxXRDlUL3ZLeEdIdlEwNG5h?=
 =?utf-8?B?cUtIQUdUcllhVk9sbytWemgreGZkM1RMUGc1TUlDTVJ1Ky9KejV3ZHVaR3B5?=
 =?utf-8?B?bEtpOXUyYkdwb0o4VmpiRXZuV0EwTGZmSlhGbnFHYjdVd2tMUzFVRWlxNDVs?=
 =?utf-8?B?OFRNUnMwOXBkSnBlemNtTnUweGRmRXRXYzIxNHJVU0s1bGQzcHZIbnRBdWti?=
 =?utf-8?B?cjljbnJacDViTEZxTjRnQ1RhRVRXV1FBVURTV1cyNzNDSTZmZzg1VzdSaGRp?=
 =?utf-8?B?NzkxV0hMUlB3UUJ2T1ZtSjUvaUxBSDRqV0FvS3hpMXdxUzZsa1kwUm9rc0l4?=
 =?utf-8?B?YXJNR09vek5qQ2k3bGt2Q2ViQS9rV0YzS09MYTBZN3dJVXp6WVo0T2FFTUlE?=
 =?utf-8?B?bGVCVVBaSmVGclpjay9McUhUbW5scGZvTFdWdFFUQnMvQ2RnZWllcngwbUhW?=
 =?utf-8?Q?2fQYIy+OAzxR7xbOvOFwW6r5/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF29E7440900D3479BA4927F9D1F72E3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF266051432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b3eacb-1f79-4b91-34e2-08ddf4fb8f0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 08:32:23.0345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZqTrdS3OcvHUhc3MUsbpgahkxo+fZVhY+uusOKVDkwoobiOFqjHilmLLYHuJ3ns85vM9hpzB4JjEYO05Q6R8Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6407

T24gV2VkLCAyMDI1LTA5LTEwIGF0IDA5OjE2IC0wNzAwLCBTdGFuaXNsYXYgRm9taWNoZXYgd3Jv
dGU6DQo+ID4gK8KgwqDCoMKgwqDCoCAtIDA6IE5vIGNoYW5uZWwtc3BlY2lmaWMgZG9vcmJlbGxz
LCB1c2UgdGhlIGdsb2JhbCBvbmUgZm9yDQo+ID4gZXZlcnl0aGluZy4NCj4gPiArwqDCoMKgwqDC
oMKgIC0gWzEsIG1heF9udW1fY2hhbm5lbHNdOiBTcHJlYWQgbmV0ZGV2IGNoYW5uZWxzIGVxdWFs
bHkNCj4gPiBhY3Jvc3MgdGhlc2UNCj4gPiArwqDCoMKgwqDCoMKgwqDCoCBkb29yYmVsbHMuDQo+
IA0KPiBEbyB5b3UgaGF2ZSBhbnkgZ3VpZGFuY2Ugb24gdGhpcyBudW1iZXI/IFdoeSB3b3VsZCB0
aGUgdXNlciB3YW50DQo+IGBudW1fZG9vcmJlbGxzIDwgbnVtX2Rvb3JiZWxsc2AgdnMgYG51bV9k
b29yYmVsbHMgPT0gbnVtX2NoYW5uZWxzYD8NCj4gDQo+IElPVywgd2h5IG5vdCBhbGxvY2F0ZSB0
aGUgc2FtZSBudW1iZXIgb2YgZG9vcmJlbGxzIGFzIHRoZSBudW1iZXIgb2YNCj4gY2hhbm5lbHMg
YW5kIGRvIGl0IHVuY29uZGl0aW9uYWxseSB3aXRob3V0IGRldmxpbmsgcGFyYW0/IEFyZSBleHRy
YQ0KPiBkb29yYmVsbHMgY2F1c2luZyBhbnkgb3ZlcmhlYWQgaW4gdGhlIG5vbi1jb250ZW5kZWQg
Y2FzZT8NCg0KSW4gbW9zdCBjYXNlcywgYWRkaXRpb25hbCBkb29yYmVsbHMgYXJlIGFuIG92ZXJo
ZWFkIGFuZCBub3QgcmVxdWlyZWQuDQpGb3IgdGhlIGxhc3QgMTArIHllYXJzLCBtbHg1IGhhcyBi
ZWVuIHJ1bm5pbmcgd2l0aCBhIHNpbmdsZSBkb29yYmVsbA0KZm9yIGFsbCBjaGFubmVscy4gQnV0
IGFzIHRoZSBudW1iZXIgb2YgY29yZXMgYW5kIGNoYW5uZWxzIGdyZXcsDQpib3R0bGVuZWNrcyB3
ZXJlIGRpc2NvdmVyZWQgb24gc29tZSBwbGF0Zm9ybXMuIFRodXMgdGhlIG5lZWQgZm9yIHRoaXMN
CnNlcmllcy4NCg0KVGhpcyBzZXJpZXMgcHJvcG9zZXMgOCBhcyB0aGUgbmV3IGRlZmF1bHQgYW5k
IHdlIGV4cGVjdCBub2JvZHkgd291bGQNCm5lZWQgdG8gdG91Y2ggdGhpcyBrbm9iIGV4Y2VwdCBp
biBleHRyZW1lIGNhc2VzLCBidXQgSSB0aGluayBpdCdzIG5pY2UNCmZvciBpdCB0byBleGlzdC4g
UmVncmVzc2lvbiB0ZXN0aW5nIHNob3dlZCBsaXR0bGUgdG8gbm8gaW1wYWN0IG9uIG1vc3QNCnBs
YXRmb3JtcyB3aGVyZSAxIGRvb3JiZWxsIHdhcyBlbm91Z2gsIGFuZCBhIHNpZ25pZmljYW50IGlt
cHJvdmVtZW50IG9uDQpwbGF0Zm9ybXMgdGhhdCBzaG93ZWQgTU1JTyBib3R0bGVuZWNrcy4NCg0K
SSdsbCBhZGQgc29tZSBudW1iZXJzIGluIHRoZSBuZXh0IHZlcnNpb24ncyBjb3ZlciBsZXR0ZXIu
DQoNCkNvc21pbi4NCg==

