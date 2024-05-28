Return-Path: <bpf+bounces-30755-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 162FB8D21A9
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 18:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7BC282EAF
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 16:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25EF170826;
	Tue, 28 May 2024 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="wTJZUsu1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="TefSr/xC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Nq1M9YQ0"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E4D1DA4C
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=50.223.129.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716913949; cv=fail; b=LwrzO7C9VyessGFaD5kgt1oyzdysXD+8yQq1aQDaa3eNcBA/VdWW6NuGuliABZFAewHPP66jwzSXSywyGx3iq5P2iewIMY1PXqg8gNArvY5Mqxrd8HbHr20edIEqsf7UrVWCixamewu1IYXCdopQ0RFFsyQdeNN6HLIA/5y6Uxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716913949; c=relaxed/simple;
	bh=6xPHsj7+MiakwUerkJLbhbgeAWKutQmoQaJryf0lQX0=;
	h=To:Date:Message-ID:References:In-Reply-To:MIME-Version:Subject:
	 Content-Type:From; b=MbhHNwMVdbb6GqJhLfnMHuAX+8fu6JvXBGVEEgDZEgN6JX7w7/yutbOUUC15CWVxBSpTZTMElArH0pyX+ltfA0ESkzqTyW48hvJMYbbzJnIxPJH14B4pqcjDe0dRdxzx3AGkPckq7WOUaYBEmtNCOHGakMrJOViFGyZMp5ujPkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=wTJZUsu1; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=TefSr/xC reason="signature verification failed"; dkim=fail (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Nq1M9YQ0 reason="signature verification failed"; arc=fail smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id C0F06C1D6FC4
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 09:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1716913945; bh=6xPHsj7+MiakwUerkJLbhbgeAWKutQmoQaJryf0lQX0=;
	h=To:Date:References:In-Reply-To:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=wTJZUsu1w5vLz2sGzLJBRzt7PdkJMAIOutopkrPVjG2i1/XIHERDfvvN+b98TC99+
	 GKPC10Ik8+kap0H6kf4PUOCbfv0vnUQHELbxkZrC6+5M0RzOcBgpkd87MbshYqNrwh
	 L9OWs7Eq2Wl/LRJanDlNiUFb+CoWcAQr2bOg2sjk=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id A65FCC1D620C
 for <bpf@vger.kernel.org>; Tue, 28 May 2024 09:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1716913945; bh=g+0J4NvGkB9KuvhdjYck2MSZ4XOEyOn7qMRZWZtFtqY=;
 h=From:To:Date:References:In-Reply-To:Subject:List-Id:List-Archive:
 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe;
 b=TefSr/xCqUJT29f0GKCqCJ7SUjGxFoVT+KcKbWoi5/9d+Vio8/iltVyBKpP8PHpnx
 6rEq9R7jDkW+7Yy5ZX5tulvT9lF4ehxL76ZGXUroakNCYho+lBmZIymMMv28Yzh/r1
 oDIea6/SG0G3QcVr3BIsnRxC31+jjmZyxFjCoftg=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id A238DC1CAF4C
 for <bpf@ietfa.amsl.com>; Tue, 28 May 2024 09:32:19 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -7.099
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=microsoft.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MM6Ol_HtR54N for <bpf@ietfa.amsl.com>;
 Tue, 28 May 2024 09:32:17 -0700 (PDT)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11020002.outbound.protection.outlook.com [52.101.85.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id C1BCAC1CAF2D
 for <bpf@ietf.org>; Tue, 28 May 2024 09:32:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TE44rNSSAcCNKt7XG2SVx6aQFOIuznQBeBauuzNaozUIo3GqcBW7Ih5yMwiH8+LU6iE4AtiXuhWF84TxG1Ul7QH2xosYMvJnYToRI4/JmXyKMPVOFEBvgKdjwVnk+SYchbknJC47LuYs0DtB3oW5M09I3UC6KDPrWQpwd3chMLVGkwsnHjCveR/izsYANkB3RjzkEDyMDjXkjgWySePCNw0zRfO269xFFWNgAtu3ELdXt/qw70P7UnmW2N/vmYraNnK85Rd5ESM3J7fW1wvQNQqgLVO51qxN9AUgaaB9rtg0mkpiz1pUnSrcn203WwnH20crF+WTDM02/VVkMQE6Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uewFcNp9v7oFSoM1wzqwN5QR55Fp/Z0NxdUv3QB4JBE=;
 b=AGkqwMui5bjIV/xqUNUFBcTXhK7Ikpg9ZoqfiHyeVzABTATPyVw7vmieYJqDYT0hHfG2ci8PgkFsu81SrNAwzUJhY0dTlVZTTZwIgcXFO81AOx1I+A/Cv6po+szYUnNdVQp6UXsRIwa264wJP6RhCHrwnkz0asONy7sIKD1uPJlOKeHWoFjdWXHjfEez7BctwLa0mmvATVwkGvzSMDlLBfiTJS7vbLmuFb62TolupdJBOW06BSU9LenyH3yi+gviSBSH1QSz6iw386xrFdqHvA0/cnDKg27xpK+yNrqlr6C1YWJztx1KVzCyUk/gPtiG1H86Ry8jQE6BkFqM7LSZwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uewFcNp9v7oFSoM1wzqwN5QR55Fp/Z0NxdUv3QB4JBE=;
 b=Nq1M9YQ0tksyoPOSPjsQyO9FxASfjFY+MX9ByF0zR7TbRXyfdLgs2z2oAbLSS1AtW8hdKGq8uxJ8vRkm50tq42JAnX0lNFdskZUAlCc6h6Nm3zjl/GbTynCg/vk3AZYPlFNnakJEaJLtbXWOTElRskVRo8jhlwzWrBWK87D+tG4=
Received: from PH0PR21MB1910.namprd21.prod.outlook.com (2603:10b6:510:1b::13)
 by MW4PR21MB3029.namprd21.prod.outlook.com (2603:10b6:303:133::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.0; Tue, 28 May
 2024 16:32:15 +0000
Received: from PH0PR21MB1910.namprd21.prod.outlook.com
 ([fe80::1cfb:f0b3:be9e:b5ff]) by PH0PR21MB1910.namprd21.prod.outlook.com
 ([fe80::1cfb:f0b3:be9e:b5ff%2]) with mapi id 15.20.7656.000; Tue, 28 May 2024
 16:32:15 +0000
To: "bpf@ietf.org" <bpf@ietf.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Thread-Topic: Writing into a ring buffer map from user space
Thread-Index: AQHasNIHYBfIk+HE/EiWi9pvHppnWLGs1v30
Date: Tue, 28 May 2024 16:32:15 +0000
Message-ID: <PH0PR21MB191058745A71A705F199B19A98F12@PH0PR21MB1910.namprd21.prod.outlook.com>
References: <PH0PR21MB19101A296E6A180AD99EDD3898F12@PH0PR21MB1910.namprd21.prod.outlook.com>
In-Reply-To: <PH0PR21MB19101A296E6A180AD99EDD3898F12@PH0PR21MB1910.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-05-28T16:32:19.690Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR21MB1910:EE_|MW4PR21MB3029:EE_
x-ms-office365-filtering-correlation-id: 399714b5-086b-41da-7732-08dc7f33bbdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?eHBVUHYyWGxUeUxEUTNDWE1FSlJtRnQwTmZmaENjWGF0YzJ0YkE1ZFMrNkVU?=
 =?utf-8?B?c09UbHZqdWNzUWZ5R0tzRnM1RWJwM292YU81SEJzZDVpay9uLzJZRUdYaC8x?=
 =?utf-8?B?TnVNVisyK2M4S0hwcENRWktST3BiNzV1L3BnODdERlZLblFoZURMQWxTSXRz?=
 =?utf-8?B?SEtiNjEyd1JMVEROZk1HOWtsWHZqL2JlMkFleXZrR2ZPSDg2c2VIMTlpdXdv?=
 =?utf-8?B?M3Y4WG5OSzRKSkxkelR2M0tqVjdqQlJVS3VLaVVMdGF5NFVxZ09aTllwTTVS?=
 =?utf-8?B?UzExZ1pibjJ4b05hcXJTb1N0N3VZT0dxcmRyODZCTDc4TXl0NGZnQ1ZXc2gv?=
 =?utf-8?B?SGQ2emFtT0p5L1JHN3kxa1JmUGVmbE1LR1dJK1hzTzhWam1xT0k4cTFwMjZC?=
 =?utf-8?B?VDNRekd0M1I0YjhrQVVpVUFwVlBaaysrNXBTVzhhSitGbjBNZlh3dTF0SnBm?=
 =?utf-8?B?ZWx6c2ZNaThXbHArYzdIZURqTmF6a1huK3VQbXRpdjk2Ry9GeEhOT2phcG5s?=
 =?utf-8?B?dTkvWGlEQkNvaWdhTjF3L1E5aVA2dExkOUw0UU5Pa01wd2NDUVhtWURydlVx?=
 =?utf-8?B?RGNBY0ZSU1FZY2lLdjNPOGpaKzFINVh2czU2UlcxOHluUnFmY2dNbTFNUmph?=
 =?utf-8?B?R1h1RU92bWp4dk5qNlFCVFNzcDZFQmJBcm9xNnhHdWZGTDFLbGN4dzUyN1NH?=
 =?utf-8?B?ekRWOEZOenA5NnVqMldyU2ZjTmdJTHJibDNtYXdQNVpqeUtvTEt6OW9HTW5O?=
 =?utf-8?B?bzhJSndLa2RvR2pvWHlaeXJWeTh3SVpMSzBlelpEZFVXTndiMmQrVys1VHNJ?=
 =?utf-8?B?ZUZ6VlNoOURFZTlNdWtucFUyUjBaMlJGN3pKVDV2cWxIWFFUTlNrU2lvTnhm?=
 =?utf-8?B?VkpjWW5lbU56bEw5N3c4RHVHcStDQllDN3RVL0puRHIyNU5LWDd1VmN4cGhF?=
 =?utf-8?B?QjRwSWE5LzRhc2FVZkhCN1JKanB5dGV5c214ZmNHem93c2Z1eTJybFFCdXdI?=
 =?utf-8?B?MHI4OTZjbXhFbTJaRjIyMDIyVHFma3A0N2pId21oMTd2V2JURVF1aG96QU85?=
 =?utf-8?B?L0NoMkdiVXZ5bnk5eGI0WTBlQk9vWFYrRmkvOHdKSDZuTUtIcFB2T2pWcVda?=
 =?utf-8?B?bTZVYS8zSnI5ay9EeDZPYW45WWdvSCtUaVRTSDlDbTBIeDIvWHVCSit6NlRC?=
 =?utf-8?B?TkJyaUt2Q3JIRmZXcU8wUGNycUFiYndWakUyYThYa3NoUXdCanVnUmtMb01m?=
 =?utf-8?B?aFRpVlhTRlV1VDkxOGpmcDdrZklNSUhwbWtiaEY5Z0dLcHAxVmJ5QlYwcWc3?=
 =?utf-8?B?eThXMDY5bnVKQyt1Vy9tZGFacGl1LzZVY0IwaDBWM2NxNlVQVEZHSHduVWhI?=
 =?utf-8?B?T3o3L0dlanNxcjlpNnI3MnYwYVQ1aDNIUEN1VUhxcjVpS2NFRG50Vm40WEtZ?=
 =?utf-8?B?RXVJM3F6S0NiaXhIV0czZU45Z3FlL0h1cjZlNzlOU1Q1YkJjK29lVDROWTBs?=
 =?utf-8?B?bk5YL3pXNUxiZm1HT1Zuc2FZVUtHYWxucmpkSFZGZDB6M2Rmbk95TmNxUnBs?=
 =?utf-8?B?bENkVHhJM2tlQnFpTFNUdWF3SEFNeDJrV1N4aU9xY0NyVUNjWEZmZjVBR0lY?=
 =?utf-8?B?YVdoaVlhU0ZJY09rSzY3WS80Wm9HSjM4S1cwL0EzZEduelp6V3hCMUQ3d0lS?=
 =?utf-8?B?L2FRcisrMGhXVEtIQ09sVWpBN2lOQmxKb0JIMU1xVU00R2F6dVFnSHlBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR21MB1910.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTRYUzBlSHNlczRZRG5SU2hyM2ZjMFZrU2hYSFIvOUF6SGNvRTVxN0dycUZt?=
 =?utf-8?B?eFlOd2JMUnNnS3ZHdnBVdGdFS1ZHYjdtOTJCVnUyUXB0cW5IWG5EZlR3R0F5?=
 =?utf-8?B?eXRPbXhuSWJsWmNJTTJiN0FJd2ZKejVHM0tCTHVRTk1XVTBVeFVrZlk5cmdu?=
 =?utf-8?B?NTJ0Q3Z4RlQ4OUhnc09NTmJUMWJSbFg4UXlyS01BTlp4VEZ1VlhpRWFsL0dH?=
 =?utf-8?B?Z3NpU3JhQW1UeUlvWXEvdlRPaWh3bmdKTjRZa3R1TkgrVXVXQ0hCeHc3OTF1?=
 =?utf-8?B?UTVCbUNsQ251N3BoZ1Zwa0hHZU5xdXFaRW1Vd1FBYWNBMWJkSStWTTlBbWpG?=
 =?utf-8?B?Wm1ZMzVXRzBJVkkvck85Y05Vb1EzWHlkY2wzRFlpVzhOME42OUJkMGNUZlNp?=
 =?utf-8?B?LzRPemtnNitEc0xaZUVyeG9MMUFpcjBPNnJzRWRRd1VudXRvMTNVVEVIODEx?=
 =?utf-8?B?RWtTNXd0L21nMFpXVXFRQ1IwR0FCRlNkbjJNS1lWeHlzeEY4QldVZS9BVENN?=
 =?utf-8?B?alg0dEtEN2R4KzdsbGFPN3kvSVovWmxuTU9GR2xpKzVHd1J1UTNCaVBWR05h?=
 =?utf-8?B?N2FFVTdINXdGVkhINUdoaXJ6ZU96akM4QVBWNGswWDBpY21HL0QrL0d1RHht?=
 =?utf-8?B?UTd4Z2V4eVM4emJ6ZUZnWlVJYVAzemJDeVdCcWM4VGoyZDRpNWxFSlNjL21O?=
 =?utf-8?B?Qk5HOEpHSkNxUzNzZmpiT1V3OC95RU9FeldkWFQ1SlhCWFkzNVdpRkx6S2gx?=
 =?utf-8?B?aUJkZEZRbDk3ZHBBdENQSUw4NzBSZjFHaU9JblF1Q1Rxcnl5Zno2OUFqaGlK?=
 =?utf-8?B?cmVicEN0amREL1VPSnU2bUFBTk9NSm14YjIvSXRibXlwVnVGSjR1RGN0cnd4?=
 =?utf-8?B?amMxWWtrWGpISnlPNVJZaCtWN1JEMGd6cUoxMytBT3pYRzFFZ0VpMjd2T2Fr?=
 =?utf-8?B?QWhMMmV4VXBISTZrNEpKM0pzZEpPdHpUbUdRM3B5dGxUai9PbnozMXhJZlpR?=
 =?utf-8?B?M2ZHcnNuSWYyTUx4RzRQL1N2czFYRFp2N0VRcytRNjgxSWhkU0hIdGNPSFNQ?=
 =?utf-8?B?aENzRnZ5OHpJS09IdFlzRXprTStER0F0TFByVGg0Y2pTOG80eTdXRXJlZnNa?=
 =?utf-8?B?cU9ObjlIa1FGK3NBUG10LzNidVJYcXM2TWVFdnkwZXRTdzZidHR4a3lJWHFY?=
 =?utf-8?B?QUZ6ckttZWdPNVplSTdaaURQejFEQjhMd3VXcGpLQzJWUmVSdzdqR0c0Y2RM?=
 =?utf-8?B?QXl2M0tXMmttYlEzWiswTWJ1c1lRYnl6Y2IxOWJoekxOcEx1czdZRHpTYkh1?=
 =?utf-8?B?Z0RpTm5oZ0s5YS9uOWQwS1N6dUdGRjVoWlBuazVNR2JGSDFocWRCWEZlb3Zr?=
 =?utf-8?B?NTlSOVUrVU9KSDFtRGJQZ3BVV0Q4c0s1WDlUNTBma3E5UTM3RU96NTNzd2tW?=
 =?utf-8?B?c0UzL2ZpS2d0a1BVN1JMSmZMUm5pZjc0KzA3U210ZTZ1ZmwvUnFUZFMrU2Rj?=
 =?utf-8?B?TzcycHdpcEZMTVlYWUg4RmVSdnM4bGlzVmRiS2FqNHh2Z2Izd3ZSdmwyMXZw?=
 =?utf-8?B?SlBDZWhFSEhzWkpPbVFid0RFK3hkNjZPblhhUTBIRTBvRXNjWnR5NGFRbnpD?=
 =?utf-8?B?SUJUTVBpdzlNdzV0a0MvREtoUWFpMzlRbUZwMkU2OFJrdy9kOVY3c3dNOENv?=
 =?utf-8?B?am8wNmJrREROTUZQZUVLZEc3dlZvdUhZOU5JWjJzR2VhdzBvL2FuZWhtQkU5?=
 =?utf-8?B?My8wcXdJa1F2YktsWUtKVUtsbWFYdDAvYVNITEYrQjhaZnNiWEN4QmJSejNi?=
 =?utf-8?B?OC90TmdCaDFjWU8rS3NveFJCTFQrSWRZLzJQekV6NjZRM3lyUGhTYkVOZTF4?=
 =?utf-8?B?ZEVoN1ZCb1R4YVVyK1UzNkNwbWd6ekpqU3RSTnNJMjZyc25pZHd1aXhPR0F0?=
 =?utf-8?B?M2VIR2xoaHczUkFIZVpNcld6OHhIVkpSMUtBV3ZTRENzNWpLTGVmRHVWM2to?=
 =?utf-8?B?QXBBNGs0K3hDeXdKekdxSnZRNDRCTCtzS1NoaDh6ZXNsS09iSnhIMFhPTitX?=
 =?utf-8?B?R3drQ3I3VGtZZ0tPV2FMVEM5azU4b0ZIWW1oeUxTVng4b2xjM2dsR09WQTJs?=
 =?utf-8?Q?rzTlSS8xqw17Ft/VCROKHmYs+?=
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB1910.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 399714b5-086b-41da-7732-08dc7f33bbdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 16:32:15.1018 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JCYP7GR0mXbP4NHVbGx8fZjmxXELp6aNFZojmGCLRmd8l1nE4kOweiI9z5EkHZNuy5S0fsr4Cvv9TdL9t9BCobkMVYWGz3SLZYD9Hy0jVz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB3029
Message-ID-Hash: 3L4IXHRPGZR3FN2SC64Q3AVDAGJOVDW4
X-Message-ID-Hash: 3L4IXHRPGZR3FN2SC64Q3AVDAGJOVDW4
X-MailFrom: Shankar.Seal@microsoft.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
X-Mailman-Version: 3.3.9rc4
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_Writing_into_a_ring_buffer_map_from_user_space?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/yAqxUO0wyVa0Dn1Mw6mPMLekCFs>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: multipart/mixed; boundary="===============1254192866946485853=="
X-Original-From: Shankar Seal <Shankar.Seal@microsoft.com>
From: Shankar Seal <Shankar.Seal=40microsoft.com@dmarc.ietf.org>

--===============1254192866946485853==
Content-Language: en-US
Content-Type: multipart/alternative;
 boundary="_000_PH0PR21MB191058745A71A705F199B19A98F12PH0PR21MB1910namp_"

--_000_PH0PR21MB191058745A71A705F199B19A98F12PH0PR21MB1910namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QWRkaW5nIGJwZkB2Z2VyLmtlcm5lbC5vcmcNCg0KQSBjb21tb24gdXNlIGNhc2Ugb2YgYW4gQlBG
IHJpbmcgYnVmZmVyIG1hcCB0byB1c2UgYXMgYSBxdWV1ZSBvZiBldmVudHMgZ2VuZXJhdGVkIGJ5
IEJQRiBwcm9ncmFtcyB0aGF0IGNhbiBiZSByZWFkIGluLW9yZGVyIGJ5IHVzZXIgc3BhY2UgYXBw
bGljYXRpb25zLiBJIGhhdmUgYSBzY2VuYXJpbyByZXF1aXJlbWVudCBmb3IgYSB1c2VyIHNwYWNl
IGFwcGxpY2F0aW9uIHRvIHdyaXRlIGludG8gYSByaW5nIGJ1ZmZlciAob3Igc2ltaWxhcikgbWFw
LCBzdWNoIHRoYXQgZXZlbnRzIGJ5IEJQRiBwcm9ncmFtcyBpbiBrZXJuZWwgYW5kIHVzZXIgc3Bh
Y2UgYXBwbGljYXRpb25zIGFyZSBpbnRlcmxlYXZlZCBpbiB0aGUgb3JkZXIgdGhleSB3ZXJlIGdl
bmVyYXRlZCwgdGhhdCBjYW4gYmUgY29uc3VtZWQgYnkgYW5vdGhlciB1c2VyIHNwYWNlIGFwcGxp
Y2F0aW9uDQoNCkkgd291bGQgbGlrZSB0byBpbXBsZW1lbnQgdGhpcyBuZXcgZmVhdHVyZSBpbiB0
aGUgaHR0cHM6Ly9naXRodWIuY29tL21pY3Jvc29mdC9lYnBmLWZvci13aW5kb3dzIHByb2plY3Qu
IEJ1dCBiZWZvcmUgSSBnbyBhaGVhZCB3aXRoIHRoZSBpbXBsZW1lbnRhdGlvbiwgSSB3YW50ZWQg
dG8gY2hlY2sgaWYgdGhlcmUgaXMgYW55IHdheSB0byBhY2NvbXBsaXNoIHRoaXMgaW4gTGludXgg
dG9kYXk/IElmIG5vdCwgaXMgdGhlcmUgYW55IHJlYXNvbiB3aHkgdGhpcyBzaG91bGQgbm90IGJl
IGRvbmU/DQoNCg0KVGhhbmtzLA0KU2hhbmthcg0K4Ka24KaC4KaV4KawIOCmtuCngOCmsg0KDQoN
Cg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCkZyb206IFNoYW5rYXIgU2VhbA0K
U2VudDogVHVlc2RheSwgTWF5IDI4LCAyMDI0IDEyOjQwIEFNDQpUbzogYnBmQGlldGYub3JnIDxi
cGZAaWV0Zi5vcmc+DQpTdWJqZWN0OiBXcml0aW5nIGludG8gYSByaW5nIGJ1ZmZlciBtYXAgZnJv
bSB1c2VyIHNwYWNlDQoNCg0KSSBoYXZlIGEgc2NlbmFyaW8gcmVxdWlyZW1lbnQgZm9yIGEgdXNl
ciBzcGFjZSBhcHBsaWNhdGlvbiB0byB3cml0ZSBpbnRvIGEgcmluZyBidWZmZXIgZUJQRiBtYXAg
dGhhdCBJIHdvdWxkIGxpa2UgdG8gaW1wbGVtZW50IGluIHRoZSBodHRwczovL2dpdGh1Yi5jb20v
bWljcm9zb2Z0L2VicGYtZm9yLXdpbmRvd3MgcHJvamVjdC4gSXMgdGhlcmUgYW55IHdheSB0byBh
Y2NvbXBsaXNoIHRoaXMgaW4gTGludXggdG9kYXk/IElmIG5vdCwgaXMgdGhlcmUgYW55IHJlYXNv
biB3aHkgdGhpcyBzaG91bGQgbm90IGJlIGRvbmU/DQoNCg0KDQpUaGFua3MsDQpTaGFua2FyDQrg
prbgpoLgppXgprAg4Ka24KeA4KayDQoNCg0K

--_000_PH0PR21MB191058745A71A705F199B19A98F12PH0PR21MB1910namp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxzdHlsZSB0eXBlPSJ0ZXh0L2NzcyIgc3R5bGU9
ImRpc3BsYXk6bm9uZTsiPiBQIHttYXJnaW4tdG9wOjA7bWFyZ2luLWJvdHRvbTowO30gPC9zdHls
ZT4NCjwvaGVhZD4NCjxib2R5IGRpcj0ibHRyIj4NCjxkaXYgY2xhc3M9ImVsZW1lbnRUb1Byb29m
IiBzdHlsZT0idGV4dC1hbGlnbjogbGVmdDsgdGV4dC1pbmRlbnQ6IDBweDsgbWFyZ2luOiAwcHg7
IGZvbnQtZmFtaWx5OiBHZW9yZ2lhLCBzZXJpZjsgZm9udC1zaXplOiAxMHB0OyBjb2xvcjogcmdi
KDAsIDM2LCA4MSk7Ij4NCkFkZGluZyBicGZAdmdlci5rZXJuZWwub3JnPGJyPg0KPGJyPg0KQSBj
b21tb24gdXNlIGNhc2Ugb2YgYW4gQlBGIHJpbmcgYnVmZmVyIG1hcCB0byB1c2UgYXMgYSBxdWV1
ZSBvZiBldmVudHMgZ2VuZXJhdGVkIGJ5IEJQRiBwcm9ncmFtcyB0aGF0IGNhbiBiZSByZWFkIGlu
LW9yZGVyIGJ5IHVzZXIgc3BhY2UgYXBwbGljYXRpb25zLiBJIGhhdmUgYSBzY2VuYXJpbyByZXF1
aXJlbWVudCBmb3IgYSB1c2VyIHNwYWNlIGFwcGxpY2F0aW9uIHRvIHdyaXRlIGludG8gYSByaW5n
IGJ1ZmZlciAob3Igc2ltaWxhcikgbWFwLA0KIHN1Y2ggdGhhdCBldmVudHMgYnkgQlBGIHByb2dy
YW1zIGluIGtlcm5lbCBhbmQgdXNlciBzcGFjZSBhcHBsaWNhdGlvbnMgYXJlIGludGVybGVhdmVk
IGluIHRoZSBvcmRlciB0aGV5IHdlcmUgZ2VuZXJhdGVkLCB0aGF0IGNhbiBiZSBjb25zdW1lZCBi
eSBhbm90aGVyIHVzZXIgc3BhY2UgYXBwbGljYXRpb248YnI+DQo8YnI+DQo8L2Rpdj4NCjxkaXYg
Y2xhc3M9ImVsZW1lbnRUb1Byb29mIiBzdHlsZT0idGV4dC1hbGlnbjogbGVmdDsgdGV4dC1pbmRl
bnQ6IDBweDsgbWFyZ2luOiAwcHg7IGZvbnQtZmFtaWx5OiBHZW9yZ2lhLCBzZXJpZjsgZm9udC1z
aXplOiAxMHB0OyBjb2xvcjogcmdiKDAsIDM2LCA4MSk7Ij4NCkkgd291bGQgbGlrZSB0byBpbXBs
ZW1lbnQgdGhpcyBuZXcgZmVhdHVyZSBpbiB0aGUgPHNwYW4gc3R5bGU9ImJhY2tncm91bmQtY29s
b3I6IHJnYigyNTUsIDI1NSwgMjU1KTsiPg0KPGEgaHJlZj0iaHR0cHM6Ly9naXRodWIuY29tL21p
Y3Jvc29mdC9lYnBmLWZvci13aW5kb3dzIiB0YXJnZXQ9Il9ibGFuayIgaWQ9Ik9XQWUzZGI0ZmUz
LTcyZjQtYjZhYi00M2ZhLWZjMjVkYWE0MDQxNCIgY2xhc3M9Ik9XQUF1dG9MaW5rIiByZWw9Im5v
b3BlbmVyIG5vcmVmZXJyZXIiIGRhdGEtYXV0aD0iTm90QXBwbGljYWJsZSIgZGF0YS1saW5raW5k
ZXg9IjAiIGRhdGEtbG9vcHN0eWxlPSJsaW5rb25seSIgc3R5bGU9Im1hcmdpbjogMHB4OyBiYWNr
Z3JvdW5kLWNvbG9yOiByZ2IoMjU1LCAyNTUsIDI1NSk7IHRleHQtYWxpZ246IGxlZnQ7Ij5odHRw
czovL2dpdGh1Yi5jb20vbWljcm9zb2Z0L2VicGYtZm9yLXdpbmRvd3M8L2E+PC9zcGFuPiZuYnNw
O3Byb2plY3QuDQogQnV0IGJlZm9yZSBJIGdvIGFoZWFkIHdpdGggdGhlIGltcGxlbWVudGF0aW9u
LCBJIHdhbnRlZCB0byBjaGVjayBpZiB0aGVyZSBpcyBhbnkgd2F5IHRvIGFjY29tcGxpc2ggdGhp
cyBpbiBMaW51eCB0b2RheT8gSWYgbm90LCBpcyB0aGVyZSBhbnkgcmVhc29uIHdoeSB0aGlzDQo8
aT5zaG91bGQgbm90PC9pPiZuYnNwO2JlIGRvbmU/PC9kaXY+DQo8ZGl2IGNsYXNzPSJlbGVtZW50
VG9Qcm9vZiIgc3R5bGU9ImZvbnQtZmFtaWx5OiBHZW9yZ2lhLCBzZXJpZjsgZm9udC1zaXplOiAx
MHB0OyBjb2xvcjogcmdiKDAsIDM2LCA4MSk7Ij4NCjxicj4NCjwvZGl2Pg0KPGRpdiBpZD0iU2ln
bmF0dXJlIj4NCjxkaXYgaWQ9ImRpdnRhZ2RlZmF1bHR3cmFwcGVyIj4NCjxkaXYgaWQ9ImRpdnRh
Z2RlZmF1bHR3cmFwcGVyIj4NCjxkaXYgaWQ9ImRpdnRhZ2RlZmF1bHR3cmFwcGVyIj4NCjxkaXYg
aWQ9ImRpdnRhZ2RlZmF1bHR3cmFwcGVyIj4NCjxwPjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTog
JnF1b3Q7R2VvcmdpYSBQcm8mcXVvdDssIHNlcmlmOyBmb250LXNpemU6IDEwLjVwdDsgY29sb3I6
IHJnYigwLCAzMiwgOTYpOyI+VGhhbmtzLDxicj4NClNoYW5rYXI8L3NwYW4+PGJyPg0KPHNwYW4g
c3R5bGU9ImZvbnQtZmFtaWx5OiAmcXVvdDtTaG9uYXIgQmFuZ2xhJnF1b3Q7LCBzZXJpZjsgZm9u
dC1zaXplOiAxNHB0OyBjb2xvcjogcmdiKDAsIDMyLCA5Nik7Ij7gprbgpoLgppXgprAg4Ka24KeA
4KayPC9zcGFuPjwvcD4NCjwvZGl2Pg0KPC9kaXY+DQo8cCBzdHlsZT0iYmFja2dyb3VuZC1jb2xv
cjogd2hpdGU7Ij4mbmJzcDs8L3A+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9kaXY+DQo8ZGl2IGlkPSJh
cHBlbmRvbnNlbmQiPjwvZGl2Pg0KPGhyIHN0eWxlPSJkaXNwbGF5OmlubGluZS1ibG9jazt3aWR0
aDo5OCUiIHRhYmluZGV4PSItMSI+DQo8ZGl2IGlkPSJkaXZScGx5RndkTXNnIiBkaXI9Imx0ciI+
PGZvbnQgZmFjZT0iQ2FsaWJyaSwgc2Fucy1zZXJpZiIgc3R5bGU9ImZvbnQtc2l6ZToxMXB0IiBj
b2xvcj0iIzAwMDAwMCI+PGI+RnJvbTo8L2I+IFNoYW5rYXIgU2VhbDxicj4NCjxiPlNlbnQ6PC9i
PiBUdWVzZGF5LCBNYXkgMjgsIDIwMjQgMTI6NDAgQU08YnI+DQo8Yj5Ubzo8L2I+IGJwZkBpZXRm
Lm9yZyAmbHQ7YnBmQGlldGYub3JnJmd0Ozxicj4NCjxiPlN1YmplY3Q6PC9iPiBXcml0aW5nIGlu
dG8gYSByaW5nIGJ1ZmZlciBtYXAgZnJvbSB1c2VyIHNwYWNlPC9mb250Pg0KPGRpdj4mbmJzcDs8
L2Rpdj4NCjwvZGl2Pg0KPHN0eWxlIHR5cGU9InRleHQvY3NzIiBzdHlsZT0iZGlzcGxheTpub25l
Ij4NCjwhLS0NCnANCgl7bWFyZ2luLXRvcDowOw0KCW1hcmdpbi1ib3R0b206MH0NCi0tPg0KPC9z
dHlsZT4NCjxkaXYgZGlyPSJsdHIiPg0KPGRpdiBjbGFzcz0ieF9lbGVtZW50VG9Qcm9vZiIgc3R5
bGU9ImZvbnQtZmFtaWx5Okdlb3JnaWEsc2VyaWY7IGZvbnQtc2l6ZToxMHB0OyBjb2xvcjpyZ2Io
MCwzNiw4MSkiPg0KPGJyPg0KPC9kaXY+DQo8ZGl2IGNsYXNzPSJ4X2VsZW1lbnRUb1Byb29mIiBz
dHlsZT0iZm9udC1mYW1pbHk6R2VvcmdpYSxzZXJpZjsgZm9udC1zaXplOjEwcHQ7IGNvbG9yOnJn
YigwLDM2LDgxKSI+DQpJIGhhdmUgYSBzY2VuYXJpbyByZXF1aXJlbWVudCBmb3IgYSB1c2VyIHNw
YWNlIGFwcGxpY2F0aW9uIHRvIHdyaXRlIGludG8gYSByaW5nIGJ1ZmZlciBlQlBGIG1hcCB0aGF0
IEkgd291bGQgbGlrZSB0byBpbXBsZW1lbnQgaW4gdGhlDQo8YSBocmVmPSJodHRwczovL2dpdGh1
Yi5jb20vbWljcm9zb2Z0L2VicGYtZm9yLXdpbmRvd3MiIGlkPSJMUGxuayI+aHR0cHM6Ly9naXRo
dWIuY29tL21pY3Jvc29mdC9lYnBmLWZvci13aW5kb3dzPC9hPiZuYnNwO3Byb2plY3QuIElzIHRo
ZXJlIGFueSB3YXkgdG8gYWNjb21wbGlzaCB0aGlzIGluIExpbnV4IHRvZGF5PyBJZiBub3QsIGlz
IHRoZXJlIGFueSByZWFzb24gd2h5IHRoaXMNCjxpPnNob3VsZCBub3Q8L2k+Jm5ic3A7YmUgZG9u
ZT88L2Rpdj4NCjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5Okdlb3JnaWEsc2VyaWY7IGZvbnQtc2l6
ZToxMHB0OyBjb2xvcjpyZ2IoMCwzNiw4MSkiPjxicj4NCjwvZGl2Pg0KPGRpdiBjbGFzcz0ieF9l
bGVtZW50VG9Qcm9vZiIgc3R5bGU9ImZvbnQtZmFtaWx5Okdlb3JnaWEsc2VyaWY7IGZvbnQtc2l6
ZToxMHB0OyBjb2xvcjpyZ2IoMCwzNiw4MSkiPg0KPGJyPg0KPC9kaXY+DQo8ZGl2IGlkPSJ4X1Np
Z25hdHVyZSI+DQo8ZGl2IGlkPSJ4X2RpdnRhZ2RlZmF1bHR3cmFwcGVyIj4NCjxkaXYgaWQ9Inhf
ZGl2dGFnZGVmYXVsdHdyYXBwZXIiPg0KPGRpdiBpZD0ieF9kaXZ0YWdkZWZhdWx0d3JhcHBlciI+
DQo8ZGl2IGlkPSJ4X2RpdnRhZ2RlZmF1bHR3cmFwcGVyIj4NCjxwPjxzcGFuIHN0eWxlPSJmb250
LWZhbWlseTomcXVvdDtHZW9yZ2lhIFBybyZxdW90OyxzZXJpZjsgZm9udC1zaXplOjEwLjVwdDsg
Y29sb3I6cmdiKDAsMzIsOTYpIj5UaGFua3MsPGJyPg0KU2hhbmthcjwvc3Bhbj48YnI+DQo8c3Bh
biBzdHlsZT0iZm9udC1mYW1pbHk6JnF1b3Q7U2hvbmFyIEJhbmdsYSZxdW90OyxzZXJpZjsgZm9u
dC1zaXplOjE0cHQ7IGNvbG9yOnJnYigwLDMyLDk2KSI+4Ka24KaC4KaV4KawIOCmtuCngOCmsjwv
c3Bhbj48L3A+DQo8L2Rpdj4NCjwvZGl2Pg0KPHAgc3R5bGU9ImJhY2tncm91bmQtY29sb3I6d2hp
dGUiPiZuYnNwOzwvcD4NCjwvZGl2Pg0KPC9kaXY+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9ib2R5Pg0K
PC9odG1sPg0K

--_000_PH0PR21MB191058745A71A705F199B19A98F12PH0PR21MB1910namp_--


--===============1254192866946485853==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

LS0gCkJwZiBtYWlsaW5nIGxpc3QgLS0gYnBmQGlldGYub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQg
YW4gZW1haWwgdG8gYnBmLWxlYXZlQGlldGYub3JnCg==

--===============1254192866946485853==--


