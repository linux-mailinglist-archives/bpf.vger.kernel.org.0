Return-Path: <bpf+bounces-27564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C268AF35F
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 18:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A780B24396
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 16:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A702113CA86;
	Tue, 23 Apr 2024 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="FeycKJT9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ZXDI9PYh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NDWItIMG"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDF113C9DB
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=50.223.129.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888037; cv=fail; b=UTIqkwu/UmEg8S9jB2pUN6ox/dfYUpGrlSQujrtIsxfE/L1dqiJ/EqRQT0TgYfPwGCLHoD882dKY/nHF6bHdrPkikuZvTl3qjEiGeA0DLyIo1Bf05zmF+l3CCu2J2SKXd6lwhTNEsv0PbA9c7SyHrHHnSaOLW0kikXnQ4J1HzY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888037; c=relaxed/simple;
	bh=+EylbrNLY9m4AawNhgtEkDNU5DsGz/PK1/SweKeIAP8=;
	h=To:CC:Date:Message-ID:References:In-Reply-To:MIME-Version:Subject:
	 Content-Type:From; b=qpJ2MdGOSG8yMiXtdGMiBEEJqmucML2kZOKCeZ42OcAvm32/d1oGbfHsw4fKv3TtD3z3BPwHa42KhE/9gdD6PUbAOfFYpAIVwKnxEggno5TSQJ1kU4VZu3jbknBUWEsuhwPIK6bVtkGKJbua4Pt8ZcrOmkE6rfwuz6QKnJ4cMWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=FeycKJT9; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ZXDI9PYh reason="signature verification failed"; dkim=fail (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=NDWItIMG reason="signature verification failed"; arc=fail smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 51143C151075
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 09:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1713888033; bh=+EylbrNLY9m4AawNhgtEkDNU5DsGz/PK1/SweKeIAP8=;
	h=To:CC:Date:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FeycKJT9+EYPcgJ8ZHJLKSmtrswdZBr4W8RHxokXJoYlU34iWq9qUbGGpPzO2+dNM
	 4sV4JJQ1hBD6/Npat8L3ni9dVan60Cl1KmTiWQgJ9tw930QjJtv55GXbeV1k2MrPud
	 KXFEUaOZjMDkkidp2BS33XoQgctNXC9lceUvjPbA=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 337FCC14F702;
 Tue, 23 Apr 2024 09:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1713888033; bh=+EylbrNLY9m4AawNhgtEkDNU5DsGz/PK1/SweKeIAP8=;
 h=From:To:CC:Date:References:In-Reply-To:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=ZXDI9PYhULo74AtbZMOh+5SHK2eP6juxsNFyU6eAm0k3C/SehZ1M5hr5FvO4Y0RSB
 o2EfHwWKFC47r31Okb8zzXhgubGX2f3lMJYAsEbhTnsG5Z4BOJu3PBZp7UYAkuzHKD
 EIw35bCoZGHZaTveeSNZngYVCQtqEoysDCMZCxZU=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 5F517C14F702
 for <bpf@ietfa.amsl.com>; Tue, 23 Apr 2024 09:00:32 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -4.147
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=microsoft.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hgru6U7yWj8E for <bpf@ietfa.amsl.com>;
 Tue, 23 Apr 2024 09:00:31 -0700 (PDT)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11023015.outbound.protection.outlook.com [52.101.61.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 45A75C14F6B8
 for <bpf@ietf.org>; Tue, 23 Apr 2024 09:00:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ncu3YKCO6evlvxoz82AATn+a1r2oijAM4IqRIrmW37FDGyWMj639pnABOsZTKFS7951YzOtUq1S2atdXnFwD3/dXEJqGHG08padDgNX3PT2IFA7QHO0TgDftXMpm6XxDerroHSDC9aDcpgIEsOERWLT5gw1jZJObALH2lu4Byvg3pdcSewOrK+XlhiEW/iWC7V/onRX3y/D8ugIJaFrVRv0uw5MpymVNAsP8Ww/dKjj2dNbUkaAHiT++k6UVWwLIWjgx37DKf13b6dUuvp5O7qI6n1MZxTfpZMWCCyyhlQo5ves48qOy3HDtxCaKynFWAAqbKTrx/J7OtsyYDfUp2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+ekxRhIqDVfpWiwRSq/8qyw5H9BjYP6Nm5VKvREQUg=;
 b=LVlzqyJJWwdlKOelZW73BE3Hx6JFGqQBnnjceOFflddy1dK1ga8I5k7intuLOJ2eLAw6UhG/tW4oD7g2SMZnjKYJJbzBZIk1wQvftUhQ4SLt+pkcJFZE+2wHMc25rNWnRQZAzNgST1taaWl6k8EayXMEKtfFcU3FzOe9ZbklLQETCdQla7aWMT2W8a/pB4iLJcvsNigL/GIGjZoypqLzwy0t5Svp7rjfMcxmpBeNa8i5k8N+xrtAOX7VC383FCtIatXqEHjKyT/mGFdav8Zjj5OeZu2+stz2wHvcKHXsQtHGGFzsIvjbD0lQCe3yx43RS7uqD+TGEN9aL6rDASZlHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+ekxRhIqDVfpWiwRSq/8qyw5H9BjYP6Nm5VKvREQUg=;
 b=NDWItIMGFQqT1oeRXUULdRLdzWjUfD68v3Ouz2S74eWoyVLPash+I0aHA626OZioyRlgeb11+qO6BFcgxI1eb3fHMA4mxTQFKUrvTrupNb8WENZLkOGxCD/EybzjGTRM041tsyUFhybi8fXD8ZL/KmbOpC9//6GrVk7sHbE4Yz4=
Received: from CY5PR21MB3567.namprd21.prod.outlook.com (2603:10b6:930:c::9) by
 DS7PR21MB3342.namprd21.prod.outlook.com (2603:10b6:8:81::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.7; Tue, 23 Apr 2024 16:00:28 +0000
Received: from CY5PR21MB3567.namprd21.prod.outlook.com
 ([fe80::a1fd:84bc:b777:ff70]) by CY5PR21MB3567.namprd21.prod.outlook.com
 ([fe80::a1fd:84bc:b777:ff70%7]) with mapi id 15.20.7544.007; Tue, 23 Apr 2024
 16:00:28 +0000
To: Watson Ladd <watsonbladd@gmail.com>,
 "dthaler1968=40googlemail.com@dmarc.ietf.org"
 <dthaler1968=40googlemail.com@dmarc.ietf.org>
CC: "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>, David Vernet
 <void@manifault.com>, "bpf@ietf.org" <bpf@ietf.org>, "bpf@vger.kernel.org"
 <bpf@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [Bpf] BPF ISA Security Considerations section
Thread-Index: AQHalPQ3aL5YMUEGykmsEo8BSiyxtLF0/eCAgAEDaSg=
Date: Tue, 23 Apr 2024 16:00:28 +0000
Message-ID: <CY5PR21MB356763A1E30B6BEF74EDB9C6FA112@CY5PR21MB3567.namprd21.prod.outlook.com>
References: <093301da933d$0d478510$27d68f30$@gmail.com>
 <20240421165134.GA9215@maniforge> <109c01da9410$331ae880$9950b980$@gmail.com>
 <149401da94e4$2da0acd0$88e20670$@gmail.com>
 <20240422193451.GA18561@maniforge>
 <160501da94f3$4f8aef40$eea0cdc0$@gmail.com>
 <160f01da94f4$31201c50$936054f0$@gmail.com>
 <CACsn0ck4FW+S6ewkFwAouQ1ObHx-2sYZsEv3qGi7LcsFywfzAg@mail.gmail.com>
In-Reply-To: <CACsn0ck4FW+S6ewkFwAouQ1ObHx-2sYZsEv3qGi7LcsFywfzAg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-23T16:00:28.711Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR21MB3567:EE_|DS7PR21MB3342:EE_
x-ms-office365-filtering-correlation-id: 056e0c9d-edb1-4001-61eb-08dc63ae7f07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?QTcva1Z3c1crZGtiakhTTnJEODFzaWpPTHJha21ZdXU0RHA4aW5QalJjVkhL?=
 =?utf-8?B?WDA1R3V2Qi8yZDgxbkxIc2hWNWtheUQxV0gvdEkvSmoyWkpzWGJZeGhETU11?=
 =?utf-8?B?VWt5am13eWRjdmJsV2M2d0pPN0NvQlVwRGl0Wk1kVTdtRzJuUktiWnlIMGlm?=
 =?utf-8?B?aUExditEanR6YXdMME1GNHNHQ2dWdzhjSklNYzZla3NIWmFvZlk4U2o2YWM1?=
 =?utf-8?B?bWViMXJ4RTFBclF3UXB2ekhMZTQ5VlBQbFQzd2p5WEFtREQ2SWdnTEZoZTlI?=
 =?utf-8?B?VVJTZERYaGpmU2lBWGR0cis4a09yT1lhU3VtaVZ4RFZ6U21WZmlEc1EwUFB1?=
 =?utf-8?B?RnhaL1RpTHpyNFVrTk9VaHVxNkZZNkFTVWFBa25NVGdkODhWYkEyMitWMGxI?=
 =?utf-8?B?ek1FK0docU1FZitYalRWY1g4MXowRjZzdnpPejkrM0cxdzlFcDQwUmI3L2Jt?=
 =?utf-8?B?MjNWZk5UR1lqejRodVlMQThmbUdWdEU4b05SRnVTbUZsajZQdjhNcUF3eW5x?=
 =?utf-8?B?d2pPUkhIL3h3UlI4WTdEcVN2dXhST0pNL1IzbE83azVsbzR6RXN5ZGlTY09l?=
 =?utf-8?B?ZWFQQjh5UDNNVnA3UVEwV3gwRmdFenJBWVB6UlVzZjhSbmJqSnBEaVI0aERS?=
 =?utf-8?B?MURGaUlvZ0JFeHFpblU3eVJpZ0pWSktNcWZuaGhpN0NlZEZmZjRJSXlMY3l6?=
 =?utf-8?B?eERabXdZYmVYVi9RWWgxZEtFOUV6NEdXb3FQcE1uN0w3bldnMVFLbDlRUk9w?=
 =?utf-8?B?TXY5Wjh4SHFkRnRvd2w3Z21EKzdnQXBpRVBXNVJZdGJTaU1BOGk1bDJaeFRu?=
 =?utf-8?B?NVVycUFhR3h5NFhRN0lNTko4OEt1dys0V25NNW5rNEc5RThacjl2anluWExR?=
 =?utf-8?B?OGNLa09jUmtVaHNkT2dWWnZPSnJXRmVzdmJzOGZ5MEVYUnFsQVR2U1lBL0ts?=
 =?utf-8?B?QzloQmcxWmduRTEyT2M4K2o4YVlEWTgwU1BkUUhCb3RVaUVlb0c5Uk9CcjQz?=
 =?utf-8?B?cmhRd0kybWhTQkRMaHJzelcrQ2tFL1RKeUVVc0t6ZnBHR2F5OEovOTE5di9k?=
 =?utf-8?B?a3MwL1BpUEpjU00wVWZOUTV6RUZZakN3Rm1ESmpUM0g4bXl6bHFPaUVWdlNU?=
 =?utf-8?B?aERFcURMS2tod1Q1K0kvcWNHS0ZFSVlPaHBKUm56WU9Nc1FOdGQvaVljUnlr?=
 =?utf-8?B?TC9FS3M2VEUrTFErbE5ZZGM4ZlJrcGZhVVNlOW51N2cxV0tUK01VMVRvaGxT?=
 =?utf-8?B?UlBlT09zaG9EYnJDY0RWVFZrK1JQQXY1ang2RGFUMytjU2JPU2MwdkZqQ0RW?=
 =?utf-8?B?a1ZqMmFvY2hKSkdRT01jZFQ5Sy81MDJib2pxSnA3REREb0NIUEoyajNiY01j?=
 =?utf-8?B?TFNseE1aelJsMEh0cFdKaDQ2VnZuei9MVXJndFhHbSt3UHFtNVVxUERVZmxi?=
 =?utf-8?B?U2dRNkFGM3RocDB2T0xvVExXd1RMczRJeFFuR3VjdjlFT0drN0c2YjcrbkVs?=
 =?utf-8?B?SnppSU9SeWVvK3hmSW1MSGc3UmFudFdldHBIbFhUS0F5aDdzZEFaY25LNmky?=
 =?utf-8?B?RzZnSEl2ZnYrNll5U1Yycm1NdGxqTlk0LzFGTDlvemRXRHNXZHd2WGRPeU5x?=
 =?utf-8?B?NTk2TGREZnlSaHFSK2VEWFM1SmRjZm5GSDdTOEFQbHdwU0tua0VremV0V0RT?=
 =?utf-8?B?V2xxeW1ySDZJMHBkRkhZOXRxeW1McEtVVHd2YkFOZ0s5MW8wYnh1anEvVnoy?=
 =?utf-8?B?Q1MyRjlpYm1YSlE3VVBvditwMVRLYzdWN3Y0ZlJidmxVZWJEKzFqUk5PWWpp?=
 =?utf-8?B?L092SUpxSHBYaTFYYmNmUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:; 
 IPV:NLI; SFV:NSPM;
 H:CY5PR21MB3567.namprd21.prod.outlook.com; PTR:; CAT:NONE; 
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmdLWW9SMFl2aGR6enlHcnFGUml6NnF0dXlWUlBJZDAyU1hUNktDV2FqckhG?=
 =?utf-8?B?c2liTDZhc1lDZnJWUy90Z0dJRi9CN3dTRGhPM3JRRU00UnVCQmh1ZXpOMnQ3?=
 =?utf-8?B?MEhuTVl4K2R4ckZxbi9sV0JJclQvUGhqWlllYzBGbmY0TkpHRXFjbjMxR1I2?=
 =?utf-8?B?bU1mbS9SbHBjaEFxaGVxUG9nT21IMmx1M2hnNUVRVDVUZTNRMjgvV0RKb0tZ?=
 =?utf-8?B?V01pSE1uN3krSHJab1I4VXVuY3RWUEVjRlVpUlZaVlNkZ0czWk1pSU1OVDF0?=
 =?utf-8?B?TkhENnJ3aW9hNVlYUkdoNGtoaEkrWEdWZzY1SEV5dndxOGVhYlJOQ1l2OW4y?=
 =?utf-8?B?dUwxWEd0RHQ0MDd3Z0pDNkk3QUZCSEpPUjFvK3ArVHVRZXVUaFZHMDAxNElO?=
 =?utf-8?B?bkRQVUZKcU5HZS9PUmQ2YllsV1BBamoxbWJEMTlYMnJpbUN3MnEwTUh0U3Ax?=
 =?utf-8?B?UmRHNkZUcGhUUzVCN3kxM29Lcnd6NWpvbmx3Q3QySWl6dWlkS20rSGZQVlpy?=
 =?utf-8?B?dFR0UkRsTk81K0ZxUHBPUHZ5dWJPMllidW1CTys5eVBUZlBnbCtyNGhIUW1p?=
 =?utf-8?B?Z3VWbkV2SWgvbXNHNUZERmd4OEpxTk5oajRlTTAzaExNanVxTWpJVWNVSGVF?=
 =?utf-8?B?OWlSamtxT284dEowMm5yM1FHMnRjL09KaURJM0NadEhIV013Q211OGNxOTB0?=
 =?utf-8?B?WUhDUWU4RjEzS3RsVXZRY0NrT0NPOWt5a1J1dmFURkZaMlpDclJ3RnpmdTNt?=
 =?utf-8?B?Zmd5VkpGMmEzeVNRQWdZMC9FMnpmM2NBL0ZqVERkT1JGUFdqd2tvL0xxbFlN?=
 =?utf-8?B?YVE2cXhCQ1VnRUFQRnQvK2dhM3AveVFPMHNDRXdETWZMb3JXR295VFUzWHh6?=
 =?utf-8?B?SnI1WWlIRCtDVktvaGtWU0xDQ2w4ZWlodDZIemErYVFUd25HTXhFMUVOaTVr?=
 =?utf-8?B?OVJRSFBkTnZNbms0ZlR6ZkVQK25qZnc0cDBNWU9qM0EwZjhMYUt6T21IeVZ3?=
 =?utf-8?B?Yy9ucWY1aXlXd1djNUlFS3hvTEpLVVBUTEtCY082Y1RkUzZFb0gzOTI2RGls?=
 =?utf-8?B?NnNDc2NqdUZUNGx3Z1FyTDhRMDNFTWZPQitXa21wWHd6ZVJGdENUZnZDMzZP?=
 =?utf-8?B?eWt3VWZIZ0tlOXVMVjNkVVRqQUZzeDNLZGdnbDFiUlJSUUVNZS9FNnA1Mlk3?=
 =?utf-8?B?MjFXTWtaNG1XWkMrU1JySmQxeGZHMXg1SEZzZ0NzcEpVb3AraUE4WUNHeVVF?=
 =?utf-8?B?c2d1UEE0K0Z0ZkovSVhmdDRaMzBDRTg1MDdSK0VhK0pZTmZmYXVvdmk1Ull3?=
 =?utf-8?B?S09ybnFEU1ltd09xVVlETWJXOG4yd1pmclJBbjk5bDRQSGY1Q2NLZGZGQjd0?=
 =?utf-8?B?SS81cEdqaHgyaFlPWk8yWlE5OXpOZlBWWjdoSnVMaHpTS2FzRHgvaE1uVE9h?=
 =?utf-8?B?bHJwb2N5WldUZHBBeEgyajZMVG9KZk1ONzFXZlRHb1NubkZxRnAwMzJTTC9S?=
 =?utf-8?B?cElIUVM0RkZWaWpaUlc5ekJ2N09YMCswOEx3NUdQbG91VzJxSkduaGd3bXdG?=
 =?utf-8?B?dDNtT3lxbHZOejRyNklBVTR0TGdwdWhaVzBnUzVCYXlBbWt6Rk1XQkVIRkdW?=
 =?utf-8?B?bVV3QTRJK2szcnorS0JCWVdSSExNYytwUHBRT0M4RnYvZlhVYlI5TEl4VEZ1?=
 =?utf-8?B?OWpyOUZKbnplMUFwQ3NHSmRxSUNtTGlXeHNHVllrNHBJTERKNzFNOHB1cDdK?=
 =?utf-8?B?Nkdkc1lxYktic3BXOEcyZ2h0dTdCZ1lja3VpQ1d6dkQ4anhhRnFkcU1uaWcy?=
 =?utf-8?B?cDVERkZnbDVjVlN5SFU4czJQNkVzakZqV3Y4M0JzQ0NwcFVsYm1aemhhMTl6?=
 =?utf-8?B?VzJvOHQ4K1V3ZUJjLzZRVjlJU1IxN2xTTlZ2Rk1ZSWc5QjI0R3NzMmk4cThO?=
 =?utf-8?B?Rm90L1JlSzZNcDRVc2xMSVJWMk5aZHhRU0w2dS85R29TWmVVcDVlWGVtdHdS?=
 =?utf-8?B?cTNIQThLSFhIaHRhTzVyOUtTYkFWSTNqcUt0RGlJd1ZXU0o1Z3NlUmNJbWtz?=
 =?utf-8?B?N1VJenFqUERpUEF5V3A5ZzZlVG5xempHV1YrQVIrOFNpbEkreGdCcnlHb3h3?=
 =?utf-8?B?SHAxT2tmRVFXSk5mQ3FvWldvZkE3WFdMREsvcG1wWWdCNUVQOCtxVVprVUd4?=
 =?utf-8?Q?d25MwoKzxJ2c9rUDgijPN8U=3D?=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR21MB3567.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 056e0c9d-edb1-4001-61eb-08dc63ae7f07
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 16:00:28.6222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OSv3nBQWv+Ijes8DJNZ2gKYnErXJ1jH3bja3IrTtLFbvygoJl5QKduxo3tyzHzRd76jrqN+jiCpg/vGXJRY8XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3342
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/seKSXVLq2aNJlNxtpiP5_Gwcyfk>
Subject: Re: [Bpf] [EXTERNAL] Re:  BPF ISA Security Considerations section
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Alan Jowett <Alan.Jowett@microsoft.com>
From: Alan Jowett <Alan.Jowett=40microsoft.com@dmarc.ietf.org>

PkZyb206IEJwZiA8YnBmLWJvdW5jZXNAaWV0Zi5vcmc+IG9uIGJlaGFsZiBvZiBXYXRzb24gTGFk
ZCA8d2F0c29uYmxhZGRAZ21haWwuY29tPg0KPlNlbnQ6IE1vbmRheSwgQXByaWwgMjIsIDIwMjQg
NToxOSBQTQ0KPlRvOiBkdGhhbGVyMTk2OD00MGdvb2dsZW1haWwuY29tQGRtYXJjLmlldGYub3Jn
IDxkdGhhbGVyMTk2OD00MGdvb2dsZW1haWwuY29tQGRtYXJjLmlldGYub3JnPg0KPkNjOiBkdGhh
bGVyMTk2OEBnb29nbGVtYWlsLmNvbSA8ZHRoYWxlcjE5NjhAZ29vZ2xlbWFpbC5jb20+OyBEYXZp
ZCBWZXJuZXQgPHZvaWRAbWFuaWZhdWx0LmNvbT47IGJwZkBpZXRmLm9yZyA8YnBmQGlldGYub3Jn
PjsgYnBmQHZnZXIua2VybmVsLm9yZyA8YnBmQHZnZXIua2VybmVsLm9yZz4NCj5TdWJqZWN0OiBb
RVhURVJOQUxdIFJlOiBbQnBmXSBCUEYgSVNBIFNlY3VyaXR5IENvbnNpZGVyYXRpb25zIHNlY3Rp
b24NCj4NCj5PbiBNb24sIEFwciAyMiwgMjAyNCBhdCAxOjMy4oCvUE0NCj48ZHRoYWxlcjE5Njg9
NDBnb29nbGVtYWlsLmNvbUBkbWFyYy5pZXRmLm9yZz4gd3JvdGU6DQo+Pg0KPj4gPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gPiBGcm9tOiBkdGhhbGVyMTk2OEBnb29nbGVtYWlsLmNv
bSA8ZHRoYWxlcjE5NjhAZ29vZ2xlbWFpbC5jb20+DQo+PiA+IFNlbnQ6IE1vbmRheSwgQXByaWwg
MjIsIDIwMjQgMToyNiBQTQ0KPj4gPiBUbzogJ0RhdmlkIFZlcm5ldCcgPHZvaWRAbWFuaWZhdWx0
LmNvbT47IGR0aGFsZXIxOTY4QGdvb2dsZW1haWwuY29tDQo+PiA+IENjOiBicGZAaWV0Zi5vcmc7
IGJwZkB2Z2VyLmtlcm5lbC5vcmcNCj4+ID4gU3ViamVjdDogUkU6IEJQRiBJU0EgU2VjdXJpdHkg
Q29uc2lkZXJhdGlvbnMgc2VjdGlvbg0KPj4gPg0KPj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQo+PiA+ID4gRnJvbTogRGF2aWQgVmVybmV0IDx2b2lkQG1hbmlmYXVsdC5jb20+DQo+
PiA+ID4gU2VudDogTW9uZGF5LCBBcHJpbCAyMiwgMjAyNCAxMjozNSBQTQ0KPj4gPiA+IFRvOiBk
dGhhbGVyMTk2OEBnb29nbGVtYWlsLmNvbQ0KPj4gPiA+IENjOiBicGZAaWV0Zi5vcmc7IGJwZkB2
Z2VyLmtlcm5lbC5vcmcNCj4+ID4gPiBTdWJqZWN0OiBSZTogQlBGIElTQSBTZWN1cml0eSBDb25z
aWRlcmF0aW9ucyBzZWN0aW9uDQo+PiA+ID4NCj4+ID4gPiBPbiBNb24sIEFwciAyMiwgMjAyNCBh
dCAxMTozNzo0OEFNIC0wNzAwLCBkdGhhbGVyMTk2OEBnb29nbGVtYWlsLmNvbQ0KPj4gPiB3cm90
ZToNCj4+ID4gPiA+IERhdmlkIFZlcm5ldCA8dm9pZEBtYW5pZmF1bHQuY29tPiB3cm90ZToNCj4+
ID4gPiA+ID4gPiBUaGFua3MgZm9yIHdyaXRpbmcgdGhpcyB1cC4gT3ZlcmFsbCBpdCBsb29rcyBn
cmVhdCwganVzdCBoYWQgb25lDQo+PiA+ID4gPiA+ID4gY29tbWVudA0KPj4gPiA+ID4gPiBiZWxv
dy4NCj4+ID4gPiA+ID4gPg0KPj4gPiA+ID4gPiA+ID4gPiBTZWN1cml0eSBDb25zaWRlcmF0aW9u
cw0KPj4gPiA+ID4gPiA+ID4gPg0KPj4gPiA+ID4gPiA+ID4gPiBCUEYgcHJvZ3JhbXMgY291bGQg
dXNlIEJQRiBpbnN0cnVjdGlvbnMgdG8gZG8gbWFsaWNpb3VzDQo+PiA+ID4gPiA+ID4gPiA+IHRo
aW5ncyB3aXRoIG1lbW9yeSwgQ1BVLCBuZXR3b3JraW5nLCBvciBvdGhlciBzeXN0ZW0NCj4+ID4g
PiA+ID4gPiA+ID4gcmVzb3VyY2VzLiBUaGlzIGlzIG5vdCBmdW5kYW1lbnRhbGx5IGRpZmZlcmVu
dCAgZnJvbSBhbnkNCj4+ID4gPiA+ID4gPiA+ID4gb3RoZXIgdHlwZSBvZiBzb2Z0d2FyZSB0aGF0
IG1heSBydW4gb24gYSBkZXZpY2UuIEV4ZWN1dGlvbg0KPj4gPiA+ID4gPiA+ID4gPiBlbnZpcm9u
bWVudHMgc2hvdWxkIGJlIGNhcmVmdWxseSBkZXNpZ25lZCB0byBvbmx5IHJ1biBCUEYNCj4+ID4g
PiA+ID4gPiA+ID4gcHJvZ3JhbXMgdGhhdCBhcmUgdHJ1c3RlZCBvciB2ZXJpZmllZCwgYW5kIHNh
bmRib3hpbmcgYW5kDQo+PiA+ID4gPiA+ID4gPiA+IHByaXZpbGVnZSBsZXZlbCBzZXBhcmF0aW9u
IGFyZSBrZXkgc3RyYXRlZ2llcyBmb3IgbGltaXRpbmcNCj4+ID4gPiA+ID4gPiA+ID4gc2VjdXJp
dHkgYW5kIGFidXNlIGltcGFjdC4gRm9yIGV4YW1wbGUsIEJQRiB2ZXJpZmllcnMgYXJlDQo+PiA+
ID4gPiA+ID4gPiA+IHdlbGwta25vd24gYW5kIHdpZGVseSBkZXBsb3llZCBhbmQgYXJlIHJlc3Bv
bnNpYmxlIGZvcg0KPj4gPiA+ID4gPiA+ID4gPiBlbnN1cmluZyB0aGF0IEJQRiBwcm9ncmFtcyB3
aWxsIHRlcm1pbmF0ZSB3aXRoaW4gYQ0KPj4gPiA+ID4gPiA+ID4gPiByZWFzb25hYmxlIHRpbWUs
IG9ubHkgaW50ZXJhY3Qgd2l0aCBtZW1vcnkgaW4gc2FmZSB3YXlzLCBhbmQNCj4+ID4gPiA+ID4g
PiA+ID4gYWRoZXJlIHRvIHBsYXRmb3JtLXNwZWNpZmllZCBBUEkgY29udHJhY3RzLiBUaGUgZGV0
YWlscyBhcmUNCj4+ID4gPiA+ID4gPiA+ID4gb3V0IG9mIHNjb3BlIG9mIHRoaXMgZG9jdW1lbnQg
KGJ1dCBzZWUgW0xJTlVYXSBhbmQNCj4+ID4gPiA+ID4gPiA+ID4gW1BSRVZBSUxdKSwgYnV0IHRo
aXMgbGV2ZWwgb2YgdmVyaWZpY2F0aW9uIGNhbiBvZnRlbiBwcm92aWRlDQo+PiA+ID4gPiA+ID4g
PiA+IGEgc3Ryb25nZXIgbGV2ZWwgb2Ygc2VjdXJpdHkgYXNzdXJhbmNlIHRoYW4gZm9yDQo+PiA+
IG90aGVyIHNvZnR3YXJlDQo+PiA+ID4gYW5kIG9wZXJhdGluZyBzeXN0ZW0gY29kZS4NCj4+ID4g
PiA+ID4gPiA+ID4NCj4+ID4gPiA+ID4gPiA+ID4gRXhlY3V0aW5nIHByb2dyYW1zIHVzaW5nIHRo
ZSBCUEYgaW5zdHJ1Y3Rpb24gc2V0IGFsc28NCj4+ID4gPiA+ID4gPiA+ID4gcmVxdWlyZXMgZWl0
aGVyIGFuIGludGVycHJldGVyIG9yIGEgSklUIGNvbXBpbGVyIHRvDQo+PiA+ID4gPiA+ID4gPiA+
IHRyYW5zbGF0ZSB0aGVtIHRvIGhhcmR3YXJlIHByb2Nlc3NvciBuYXRpdmUgaW5zdHJ1Y3Rpb25z
LiBJbg0KPj4gPiA+ID4gPiA+ID4gPiBnZW5lcmFsLCBpbnRlcnByZXRlcnMgYXJlIGNvbnNpZGVy
ZWQgYSBzb3VyY2Ugb2YgaW5zZWN1cml0eQ0KPj4gPiA+ID4gPiA+ID4gPiAoZS5nLiwgZ2FkZ2V0
cyBzdXNjZXB0aWJsZSB0byBzaWRlLWNoYW5uZWwgYXR0YWNrcyBkdWUgdG8NCj4+ID4gPiA+ID4g
PiA+ID4gc3BlY3VsYXRpdmUNCj4+ID4gPiA+ID4gPiA+ID4gZXhlY3V0aW9uKSBhbmQgYXJlIG5v
dCByZWNvbW1lbmRlZC4NCj4+ID4gPiA+ID4gPg0KPj4gPiA+ID4gPiA+IERvIHdlIG5lZWQgdG8g
c2F5IHRoYXQgaXQncyBub3QgcmVjb21tZW5kZWQgdG8gdXNlIEpJVCBlbmdpbmVzPw0KPj4gPiA+
ID4gPiA+IEdpdmVuIHRoYXQgdGhpcyBpcyBleHBsYWluaW5nIGhvdyBCUEYgcHJvZ3JhbXMgYXJl
IGV4ZWN1dGVkLCB0bw0KPj4gPiA+ID4gPiA+IG1lIGl0IHJlYWRzIGEgYml0IGFzIHNheWluZywg
Ikl0J3Mgbm90IHJlY29tbWVuZGVkIHRvIHVzZSBCUEYuIg0KPj4gPiA+ID4gPiA+IElzIGl0IG5v
dCBzdWZmaWNpZW50IHRvIGp1c3QgZXhwbGFpbiB0aGUgcmlza3M/DQo+PiA+ID4gPiA+DQo+PiA+
ID4gPiA+IEl0IHNheXMgaXQncyBub3QgcmVjb21tZW5kZWQgdG8gdXNlIGludGVycHJldGVycy4g
IEkgY291bGRuJ3QgdGVsbA0KPj4gPiA+ID4gPiBpZiB5b3VyIGNvbW1lbnQgd2FzIGEgdHlwbywg
ZGlkIHlvdSBtZWFuIGludGVycHJldGVycyBvciBKSVQNCj4+ID4gPiA+ID4gZW5naW5lcz8gIEl0
IHNob3VsZCByZWFkIGFzIHNheWluZyBpdCdzIHJlY29tbWVuZGVkIHRvIHVzZSBhIEpJVA0KPj4g
PiA+ID4gPiBlbmdpbmUgcmF0aGVyIHRoYW4gYW4gaW50ZXJwcmV0ZXIuDQo+PiA+ID4NCj4+ID4g
PiBTb3JyeSwgeWVzLCBJIG1lYW50IHRvIHNheSBpbnRlcnByZXRlcnMuIFdoYXQgSSByZWFsbHkg
bWVhbnQgdGhvdWdoIGlzDQo+PiA+IHRoYXQgZGlzY3Vzc2luZw0KPj4gPiA+IHRoZSBzYWZldHkg
b2YgSklUIGVuZ2luZXMgdnMuIGludGVycHJldGVycyBzZWVtcyBhIGJpdCBvdXQgb2Ygc2NvcGUN
Cj4+ID4gPiBmb3INCj4+ID4gdGhpcyBTZWN1cml0eQ0KPj4gPiA+IENvbnNpZGVyYXRpb25zIHNl
Y3Rpb24uIEl0J3Mgbm90IGFzIHRob3VnaCBKSVQgaXMgYSBmb29scHJvb2YgbWV0aG9kDQo+PiA+
ID4gaW4NCj4+ID4gYW5kIG9mIGl0c2VsZi4NCj4+ID4gPg0KPj4gPiA+ID4gPiBEbyB5b3UgaGF2
ZSBhIHN1Z2dlc3RlZCBhbHRlcm5hdGUgd29yZGluZz8NCj4+ID4gPg0KPj4gPiA+IEhvdyBhYm91
dCB0aGlzOg0KPj4gPiA+DQo+PiA+ID4gRXhlY3V0aW5nIHByb2dyYW1zIHVzaW5nIHRoZSBCUEYg
aW5zdHJ1Y3Rpb24gc2V0IGFsc28gcmVxdWlyZXMgZWl0aGVyDQo+PiA+ID4gYW4NCj4+ID4gaW50
ZXJwcmV0ZXINCj4+ID4gPiBvciBhIEpJVCBjb21waWxlciB0byB0cmFuc2xhdGUgdGhlbSB0byBo
YXJkd2FyZSBwcm9jZXNzb3IgbmF0aXZlDQo+PiA+IGluc3RydWN0aW9ucy4gSW4NCj4+ID4gPiBn
ZW5lcmFsLCBpbnRlcnByZXRlcnMgYW5kIEpJVCBlbmdpbmVzIGNhbiBiZSBhIHNvdXJjZSBvZiBp
bnNlY3VyaXR5DQo+PiA+ID4gKGUuZy4sDQo+PiA+IGdhZGdldHMNCj4+ID4gPiBzdXNjZXB0aWJs
ZSB0byBzaWRlLWNoYW5uZWwgYXR0YWNrcyBkdWUgdG8gc3BlY3VsYXRpdmUgZXhlY3V0aW9uLCBv
cg0KPj4gPiA+IFdeWA0KPj4gPiBtYXBwaW5ncyksDQo+PiA+ID4gYW5kIHNob3VsZCBiZSBhdWRp
dGVkIGNhcmVmdWxseSBmb3IgdnVsbmVyYWJpbGl0aWVzLg0KPj4gPg0KPj4gPiBJJ3ZlIGhhZCBz
ZWN1cml0eSByZXNlYXJjaGVycyB0ZWxsIG1lIHRoYXQgdXNpbmcgYW4gaW50ZXJwcmV0ZXIgaW4g
dGhlDQo+PiBzYW1lIGFkZHJlc3MNCj4+ID4gc3BhY2UgYXMgb3RoZXIgY29uZmlkZW50aWFsIGRh
dGEgaXMgaW5oZXJlbnRseSBhIHZ1bG5lcmFiaWxpdHksIGkuZS4sIG5vDQo+PiBvbmUgY2FuIHBy
b3ZlDQo+PiA+IHRoYXQgaXQncyBub3QgYSBzaWRlIGNoYW5uZWwgYXR0YWNrIHdhaXRpbmcgdG8g
aGFwcGVuIGFuZCBhbGwgZXZpZGVuY2UgaXMNCj4+IHRoYXQgaXQgY2Fubm90DQo+PiA+IGJlIHBy
b3RlY3RlZC4gIE9ubHkgYW4gaW50ZXJwcmV0ZXIgaW4gYSBzZXBhcmF0ZSBhZGRyZXNzIHNwYWNl
IGZyb20gYW55DQo+PiBzZWNyZXRzIGNhbg0KPj4gPiBiZSBzYWZlIGluIHRoYXQgcmVzcGVjdC4g
IFNvIEkgYmVsaWV2ZSBqdXN0IHNheWluZyB0aGF0IGludGVycHJldGVycw0KPj4gInNob3VsZCBi
ZSBhdWRpdGVkDQo+PiA+IGNhcmVmdWxseSBmb3IgdnVsbmVyYWJpbGl0aWVzIiB3b3VsZCBub3Qg
cGFzcyBzZWN1cml0eSBtdXN0ZXIgYnkgc3VjaA0KPj4gZm9sa3MuDQo+PiA+DQo+PiA+ID4gPiBI
b3cgYWJvdXQ6DQo+PiA+ID4gPg0KPj4gPiA+ID4gT0xEOiBJbiBnZW5lcmFsLCBpbnRlcnByZXRl
cnMgYXJlIGNvbnNpZGVyZWQgYQ0KPj4gPiA+ID4gT0xEOiBzb3VyY2Ugb2YgaW5zZWN1cml0eSAo
ZS5nLiwgZ2FkZ2V0cyBzdXNjZXB0aWJsZSB0byBzaWRlLWNoYW5uZWwNCj4+ID4gPiA+IGF0dGFj
a3MgZHVlIHRvIHNwZWN1bGF0aXZlIGV4ZWN1dGlvbikNCj4+ID4gPiA+IE9MRDogYW5kIGFyZSBu
b3QgcmVjb21tZW5kZWQuDQo+PiA+ID4gPg0KPj4gPiA+ID4gTkVXOiBJbiBnZW5lcmFsLCBpbnRl
cnByZXRlcnMgYXJlIGNvbnNpZGVyZWQgYQ0KPj4gPiA+ID4gTkVXOiBzb3VyY2Ugb2YgaW5zZWN1
cml0eSAoZS5nLiwgZ2FkZ2V0cyBzdXNjZXB0aWJsZSB0byBzaWRlLWNoYW5uZWwNCj4+ID4gPiA+
IGF0dGFja3MgZHVlIHRvIHNwZWN1bGF0aXZlIGV4ZWN1dGlvbikNCj4+ID4gPiA+IE5FVzogc28g
dXNlIG9mIGEgSklUIGNvbXBpbGVyIGlzIHJlY29tbWVuZGVkIGluc3RlYWQuDQo+PiA+ID4NCj4+
ID4gPiBUaGlzIGlzIGZpbmUgdG9vLiBNeSBvbmx5IHdvcnJ5IGlzIHRoYXQgdGhlcmUgaGF2ZSBh
bHNvIGJlZW4gcGxlbnR5IG9mDQo+PiA+IHZ1bG5lcmFiaWxpdGllcw0KPj4gPiA+IGV4cGxvaXRl
ZCBhZ2FpbnN0IEpJVCBlbmdpbmVzIGFzIHdlbGwsIHNvIGl0IG1pZ2h0IGJlIG1vcmUgcHJ1ZGVu
dCB0bw0KPj4gPiA+IGp1c3QNCj4+ID4gd2FybiB0aGUNCj4+ID4gPiByZWFkZXIgb2YgdGhlIHJp
c2tzIG9mIGludGVycHJldGVycy9KSVRzIGluIGdlbmVyYWwgYXMgb3Bwb3NlZCB0bw0KPj4gPiBw
cmVzY3JpYmluZyBvbmUgb3Zlcg0KPj4gPiA+IHRoZSBvdGhlci4NCj4+ID4gPg0KPj4gPiA+IFdo
YXQgZG8geW91IHRoaW5rPw0KPj4gPg0KPj4gPiBJIHRoaW5rIHRoZSAic2hvdWxkIGJlIGF1ZGl0
ZWQgY2FyZWZ1bGx5IGZvciB2dWxuZXJhYmlsaXRpZXMiIHBocmFzZSB3b3VsZA0KPj4gYXBwbHkg
dG8gSklUcw0KPj4gPiBmb3Igc3VyZS4gIEhvd2V2ZXIgaXQgd291bGQgYWxzbyBhcHBseSB0byBh
bnkgbm9uLUJQRiBjb2RlIGluIGEgcHJpdmlsZWdlZA0KPj4gY29udGV4dA0KPj4gPiBzdWNoIGFz
IGEga2VybmVsLCBzbyBpdCB3b3VsZCBzZWVtIG9kZCB0byBjYWxsIGl0IG91dCBoZXJlIGFuZCBu
b3QgaW4gYWxsDQo+PiBvdGhlciBSRkNzDQo+PiA+IHRoYXQgd291bGQgYXBwbHkgdG8ga2VybmVs
IGNvZGUgKGUuZy4sIFRDUC9JUCkuICBCdXQgaWYgb3RoZXJzIHJlYWxseSB3YW50DQo+PiB0aGF0
LCB3ZQ0KPj4gPiBjb3VsZCBjZXJ0YWlubHkgc2F5IHRoYXQuDQo+Pg0KPj4gVXBkYXRlZCBwcm9w
b3NlZCB0ZXh0LCBiYXNlZCBvbiBEYXZpZCdzIGFuZCBXYXRzb24ncyBmZWVkYmFjazoNCj4+DQo+
PiBFeGVjdXRpbmcgcHJvZ3JhbXMgdXNpbmcgdGhlIEJQRiBpbnN0cnVjdGlvbiBzZXQgYWxzbyBy
ZXF1aXJlcyBlaXRoZXIgYW4NCj4+IGludGVycHJldGVyIG9yIGEgSklUIGNvbXBpbGVyDQo+PiB0
byB0cmFuc2xhdGUgdGhlbSB0byBoYXJkd2FyZSBwcm9jZXNzb3IgbmF0aXZlIGluc3RydWN0aW9u
cy4gIEluIGdlbmVyYWwsDQo+PiBpbnRlcnByZXRlcnMgYXJlIGNvbnNpZGVyZWQgYQ0KPj4gc291
cmNlIG9mIGluc2VjdXJpdHkgKGUuZy4sIGdhZGdldHMgc3VzY2VwdGlibGUgdG8gc2lkZS1jaGFu
bmVsIGF0dGFja3MgZHVlDQo+PiB0byBzcGVjdWxhdGl2ZSBleGVjdXRpb24sDQo+PiBvciBXXlgg
bWFwcGluZ3MpIHdoZW5ldmVyIG9uZSBpcyB1c2VkIGluIHRoZSBzYW1lIG1lbW9yeSBhZGRyZXNz
IHNwYWNlIGFzDQo+PiBkYXRhIHdpdGggY29uZmlkZW50aWFsaXR5DQo+PiBjb25jZXJucy4gIEFz
IHN1Y2gsIHVzZSBvZiBhIEpJVCBjb21waWxlciBpcyByZWNvbW1lbmRlZCBpbnN0ZWFkLiAgSklU
DQo+PiBjb21waWxlcnMgc2hvdWxkIGJlIGF1ZGl0ZWQNCj4+IGNhcmVmdWxseSBmb3IgdnVsbmVy
YWJpbGl0aWVzIHRvIGVuc3VyZSB0aGF0IEpJVCBjb21waWxhdGlvbiBvZiBhIHRydXN0ZWQNCj4+
IGFuZCB2ZXJpZmllZCBCUEYgcHJvZ3JhbQ0KPj4gZG9lcyBub3QgaW50cm9kdWNlIHZ1bG5lcmFi
aWxpdGllcy4NCj4NCj5CdXQgV15YIG1hcHBpbmdzIGFyZSBmb3IgSklUIChhbmQgYXZvaWRhYmxl
IGJ5IHdyaXRpbmcsIHRoZW4gcmVtYXBwaW5nDQo+YW5kIGV4ZWN1dGluZyksIG5vdCBpbnRlcnBy
ZXRlcnMuIEhvdyBhYm91dCB3ZSBqdXN0IHNheSAiRXhlY3V0aW5nIHRoZQ0KPnByb2dyYW0gcmVx
dWlyZXMgYW4gaW50ZXJwcmV0ZXIgb3IgSklUIGNvbXBpbGVyIGluIHRoZSBzYW1lIG1lbW9yeQ0K
PnNwYWNlIGFzIHRoZSBzeXN0ZW0gYmVpbmcgcHJvYmVkIG9yIGV4dGVuZGVkLiBUaGlzIGNyZWF0
ZXMgcmlza3Mgb2YNCj50cmFuc2llbnQgZXhlY3V0aW9uIGF0dGFja3MgdGhhdCBjYW4gcmV2ZWFs
IGRhdGEgd2l0aCBjb25maWRlbnRpYWxpdHkNCj5jb25jZXJucy4gTWV0aG9kcyBmb3IgYXZvaWRp
bmcgdGhlc2UgYXR0YWNrcyBhcmUgdW5kZXIgYWN0aXZlIHJlc2VhcmNoDQo+YW5kIGZyZXF1ZW50
bHkgZGVwZW5kIG9uIG1pY3JvYXJjaGl0ZWN0dXJhbCBkZXRhaWxzLiINCg0KSXMgaXQgc3RyaWN0
bHkgdHJ1ZSB0aGF0IEJQRiBpbXBsaWVzIGVpdGhlciBKSVQgb3IgaW50ZXJwcmV0ZXI/IFRoZSBl
QlBGIGZvciBXaW5kb3dzIHByb2plY3QgZG9lcyBhaGVhZCBvZiB0aW1lIGNvbXBpbGF0aW9uIChB
T1QpLCB0aHJvdWdoIGEgcHJvY2VzcyBvZiB0cmFuc2xhdGluZyBlYWNoIEJQRiBpbnN0cnVjdGlv
biBpbnRvIGFuIGVxdWl2YWxlbnQgQyBzdGF0ZW1lbnQgYW5kIHRoZW4gcGFzc2luZyBpdCB0aHJv
dWdoIGEgQyBjb21waWxlciB0byBwcm9kdWNlIHNpZGUtY2hhbm5lbCBhd2FyZSBjb2RlIChhbmQg
YWxzbyBwZXJtaXQgcG9zdCB2ZXJpZmljYXRpb24gb3B0aW1pemF0aW9uKS4gSSBiZWxpZXZlIGlu
dGVycHJldGVyIG9yIEpJVCBhcmUgaW1wbGVtZW50YXRpb24gZGV0YWlscyBhbmQgbm90IGludHJp
bnNpYyB0byB0aGUgSVNBLg0KDQpSZWdhcmRzLA0KQWxhbiBKb3dldHQNCg0KPg0KPlNpbmNlcmVs
eSwNCj5XYXRzb24NCj4+DQo+PiBEYXZlDQo+Pg0KPj4gLS0NCj4+IEJwZiBtYWlsaW5nIGxpc3QN
Cj4+IEJwZkBpZXRmLm9yZw0KPj4gaHR0cHM6Ly93d3cuaWV0Zi5vcmcvbWFpbG1hbi9saXN0aW5m
by9icGYNCj4NCj4NCj4NCj4tLQ0KPkFzdHJhIG1vcnRlbXF1ZSBwcmFlc3RhcmUgZ3JhZGF0aW0N
Cj4NCj4tLQ0KPkJwZiBtYWlsaW5nIGxpc3QNCj5CcGZAaWV0Zi5vcmcNCj5odHRwczovL3d3dy5p
ZXRmLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2JwZg0KPg0KLS0gCkJwZiBtYWlsaW5nIGxpc3QKQnBm
QGlldGYub3JnCmh0dHBzOi8vd3d3LmlldGYub3JnL21haWxtYW4vbGlzdGluZm8vYnBmCg==

