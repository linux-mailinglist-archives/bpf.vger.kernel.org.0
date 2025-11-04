Return-Path: <bpf+bounces-73429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1F5C30F24
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 13:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B0918C3CA7
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 12:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26182EFDB5;
	Tue,  4 Nov 2025 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NZRSx/5V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oxtK2HId"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9451929BD96
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 12:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258554; cv=fail; b=BhCIP98dlbqjMAjlfHhrMc/E4yhcoWeC9IH8py8mp2bziT2FG9dmaj0TGF8b/0RCchbtZ7iKCIn4Tbap1qkKyOmKCOYlK0w5oQ3prCP/y3xm07D7BCwfLduFxTZGSEp+nzbLcxIVD+Sch05FoBjXDV5IKCdBdWbxUcmlF6hg0gM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258554; c=relaxed/simple;
	bh=dQq0FujXmi3yTGwY4oddZRrfL66sqBIpguoG5Mub0lk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fR6ttZKSNa4e0fNbYn02JT7cX8SFBnqCFqw/f9uV4Oa8dIZ/wv9AL64/WgbnwbKVz2odG5gLe53LKacMbLScyMqiypfLy31PuxKqRuNI18kEHUw7Faml61vjMuUkhKQ2Y9SWePNDNTVrueMZEk/Yl1lTKiY3HnpfV5p19eYTZzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NZRSx/5V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oxtK2HId; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4BuNnl007997;
	Tue, 4 Nov 2025 12:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gMugoGk9jcsZZAU1aLvxa3uJRBb8XT8Q32Zt5mhRTrs=; b=
	NZRSx/5VovVQlgSAmzeuFpMR83EXI3qbwQM13g/IEt6YJmZIzODaKQrLqP6wPjEm
	BDRK3oZ735jf68u38uE2KISxJgv7l4kzOiL0vMCUpEq9/3w0oK1BsgXNFfRFAvbg
	4mMZQJ0IDPMiAc2XSGnwEvxDlDql4ivqqEMCVf5Q4mOpNGmNmFQu3L3E3baGxWee
	v3KKOi+o2cCvKw84WUVMlqGGR2gSiKnkidWQDCRJscpaWUuhCy6TLAb/Vl5MzkLY
	4E/In5vNJlct4uFjsg/8DjQNAmLATOsendLA6yyqc9hmu9uJiYgPPL3qREFgVB3F
	5H+3aDUTKBIXX3BpoUFqxw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a7gegg4pp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 12:15:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4AZNO4022392;
	Tue, 4 Nov 2025 12:15:24 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n9gp5n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Nov 2025 12:15:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hcx/s4SHbma5v8EW1D8q6GoBCjZgpMRwhLGuvv0ezpLEhlHNjN0tvoWjkbu6Kl85JqHzCWASSHbqmyIuBcjlmOj35lQT/vaeSYgxrYaJdIBWZD146ZNSG2sZMUprVMUKDKGzWBirNA27HBwpR7eAeOxzL4Gfn17OaxGvGDX1QtDGCxb5CJH5uC8uj2U8jQnDOyf3Ge5qyoVDhlMuYf4dBM6kmK8MeY+5Kscd99BsTde2N80UcmlZLBXN1JDZI4I0nOWV89nDLGaXIHQwRsn1+qHvYb199evGzLCj/yMn9ajBdmDlFMs4y2LZoPBb9f7RZJzQY8YGMDWiFh4Dg2pUzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMugoGk9jcsZZAU1aLvxa3uJRBb8XT8Q32Zt5mhRTrs=;
 b=NN7aVDAnvqGpKB7TDzbnt1wGWMyRlbw8+IVdAuI/q43hHzp3ffkg0vrrmIn6kO5A6tzKHb5+lbi4lh/aH0Sr4KSFajfpU7pUgqK+S28O22yGrkv0wr9GfD12VE1oTOiOCcnkOJtOKTOKpMpRAmu7oQEc6DQfgJo3iy9NZL1Wo0L9GOtvhrmhGyQ8vjTgp4ZZQtBlcfLLu/VjqxZrrw3KZucV2RQlC5E3lqmWv/2dTxmxnkpVSlTrZGNaN4WsrOfl7COMVpwCiACVAqY/MdL43wDIkDJT9Ar1ejvM/0+qQmsyHgQ2ltvQRSAr5mBt0xIZFuhl2BvNjQ8lMQNg0lGkJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMugoGk9jcsZZAU1aLvxa3uJRBb8XT8Q32Zt5mhRTrs=;
 b=oxtK2HIdmmvZgWPgWrUwP7BEO7bg5jpql4i0HwP4a/xNeSnY4799b/k2fTX692VPSvXRelfJ14ePdZEJ7sxMbcLcntnLWys3CobHft7LCiDbNTrahBGcdydTYw1qIP/76veNPaaNDB6T0dxM49Of/En40jweZhNVr7re4kffvtE=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CH3PR10MB7393.namprd10.prod.outlook.com (2603:10b6:610:146::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 12:14:36 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 12:14:36 +0000
Message-ID: <8282b59a-4784-4e96-a459-6d238e2e1c6b@oracle.com>
Date: Tue, 4 Nov 2025 12:14:17 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 2/2] selftests/bpf: Test parsing of
 (multi-)split BTF
To: bot+bpf-ci@kernel.org, andrii@kernel.org
Cc: eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, ihor.solodrai@linux.dev, bpf@vger.kernel.org,
        martin.lau@kernel.org, clm@meta.com
References: <20251028225544.1312356-3-alan.maguire@oracle.com>
 <f41705b65cd398234052e965943ab9dedf7f78fbed66d1b6e385a0e58db81c2b@mail.kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <f41705b65cd398234052e965943ab9dedf7f78fbed66d1b6e385a0e58db81c2b@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0310.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::9) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CH3PR10MB7393:EE_
X-MS-Office365-Filtering-Correlation-Id: ee41e2ee-1c89-4236-bdad-08de1b9bb808
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?STRJRXJxRTJyQzZCSVZyaDAvMndqVVhMc0NYaWRwMHB4VHdmZkw1WG1UQjhL?=
 =?utf-8?B?Q0RpVCsrNUdqaGpTd2o5VzRtMnY2aktUMTQ0ZGNaTjVCaTEwbC81dUQvMHF2?=
 =?utf-8?B?eEIxQ2RHam9BWUU0QWVwTkdjZTF6S0M1amRCM3B4a2hoMzNYaUVyS2JpSkla?=
 =?utf-8?B?cHI5RnZodEFwV0FyeDdsUXJ4MjVtRGFqbjRudDdXODZNZm9aT2F5VVZVSStz?=
 =?utf-8?B?TElrMXhFSEI4WnBBTkN2NHNTUS9lb0tSNEM5bVJXMkJXWDZWcHNEMGlVMGNI?=
 =?utf-8?B?dWVDKzNOcWtWWUFNdDZSSHkyN0VrUlpPeElsYjFKb3ExYmcwUXk5bEpzYXc4?=
 =?utf-8?B?U0JvekN0dGpLbkpIK09mZVdYYitYYkRCdnp6OVVoUGF5c1hQeEVacEZtUnJQ?=
 =?utf-8?B?OUpNcnFLQWRIN012eERDckEzamdqaVoxZzdFa2lrRmw4OHAxTFlZZHFZVXdM?=
 =?utf-8?B?TituZ0V3MWcyMmFYOTlGdi95T0xMczRqcUdEcVRLdHBpV01mS01IV2NrNUtm?=
 =?utf-8?B?dExMZW5aU25SZnlwWWZ0TW1mbjhZemNMM2dSS0lIMFhMaU9ySkY2SHFwRHBW?=
 =?utf-8?B?UU5IM2hMeUt2L1lGNFlrMXQ3dHN5OG9IZWphK2xEZkFDWXhPdzAzQXhxOFN2?=
 =?utf-8?B?RWFDN2JKdlBQQ2g3cHUvSjVqVHVvOFpBMitJNnlLNExYN2pGcXNnM3FFWUN5?=
 =?utf-8?B?Q0o1aTFadjd6SERoYkJBcVJveENvY1lRQ3FaUmZ2TUtheWhQcmhmTXlQa0Jn?=
 =?utf-8?B?MVJLWUZwREtJcWRQY2hPbGxtRkJwVTVyczlGYUdYMUdwOUdnWmMyK0cxK3hB?=
 =?utf-8?B?RnZTc0VkZzN0aHlHWnFBNjRYSVltemkzVzhDYjJCNUtBdlpBWEdWWGUyUHZQ?=
 =?utf-8?B?cEVrLzd3bGJoSTVFdXdFSGJLMGhyV1pCZnVpQWFLNFpaVitrL3lYL29ZT0N4?=
 =?utf-8?B?bkxaN0lzNXVlUThaODloNVd5ZkQ5SHJJTDd5R0c3a1pMSG5mR3RvQ3YxdXdD?=
 =?utf-8?B?NzFXcXphTy9ER2tTM1lkUE5iOXFQNTZEV0I4dUVpd0paT2syVCt5YlhJanhz?=
 =?utf-8?B?V2NiZXZ4aTFUeU53RFh2VFNGMkhoZzZjUmdYMWVZOTlpcG1UMWw2UThaZk43?=
 =?utf-8?B?Tm9kVUhtbCs1eEdBM3ljS1VOaFFsQ0hpNHRIdDVCdGR2dXN1LzBtMWl1NEJx?=
 =?utf-8?B?cFl1TGJFM2hzMXZyeHhIWTkvbU1Eb3pwa1pvQzYzVkg4eG9ENmhMQ1lUZUZR?=
 =?utf-8?B?T1FWeklYQWNPVDhyZGhKdksvRCtmNHRqbVdHdDlaSFhBUXFZTmxWNW94MzNa?=
 =?utf-8?B?VWNQaHY5WHdYRk5HL3p1UE5YUDZPRzkvbmpiZEZZWW40TTZkSGZ1QThmV1Za?=
 =?utf-8?B?L1VlbFB1aVpqNzJmRU82U01yMENEODViU0dCMXkyNUIyMDdleGlaWlprSEVB?=
 =?utf-8?B?S2NhZHp1RFZiVklCK1BYTFROaWJmTVJBNTFhSTVaUWZpd3ZiMWN3S1BuZitL?=
 =?utf-8?B?K1RKRGkxQ3VkcWd1SklKRVIwYUVYUTkrbUdNandXaUdORkxHNWNtendoUldQ?=
 =?utf-8?B?bGlKdER1TG1ZTkVLcVp3TEVIL2tCWWlsbVB5cXFwbjhLblZXRy9kLzVyZ2xm?=
 =?utf-8?B?R2tCTUczSVRHUmVJVlNFVzFrQ2lXSHV3OG1hSGNhd0phU2sxSTd1WUFIdmx0?=
 =?utf-8?B?TXo0dWRXdEJwbmNZemltMXo2VWF6d24wbkd0UnNrT3hMRkZHZDNKZGlNVmk2?=
 =?utf-8?B?TFlvVWFmN29jS2xCbEptZ0RvRUdOS1BKZXNZQUkwN1dqMmNzWGJ0RDhRSk9U?=
 =?utf-8?B?eGV1SzRyeUFuUEZ1R1JwekJIOUwyWE9BaFlhSTBYYmR3bU8vMVI2elArVHRV?=
 =?utf-8?B?VGpTbGx3bTNjK3ZUYjZNY2JESnlhUWsvZXd0anVXdmxlZmNBelA2RGhweEVo?=
 =?utf-8?Q?nGGJK8EC9/hFksfdvhYN8hFkBTzXvPak?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZjJzb05McG81OCtMNlM1N21XdnhydTFXcy9FS1dISFZodkhqMEtZOTdQSDhL?=
 =?utf-8?B?N0Jtc3V3VGNrRnI2elN1NWI5VE1acXdHNVJWSDlMOFEyRnRndUtPWTgzbUYv?=
 =?utf-8?B?VEpzcS9OZUtER1BmS09oL05NK291WlovSU5PVktVWUtkc0FoeFlBNzZwYVZJ?=
 =?utf-8?B?enUySE1jUU5WVTYwd0lCZmRzYm5KNEtUWDNCM05KM3lIOUxkalFpM0xrZTJ1?=
 =?utf-8?B?UWZ5cm5DaFZFNVQrd3dLTWRLZ0FVaUI1VlJuYUgreVM5S01GUVF5VW5LZ0M3?=
 =?utf-8?B?SDdOUFNuWHQ1UytGK0h3NW5tQjBaeWRjTjlJUndlZzAvb21tV3FGakZUOWpo?=
 =?utf-8?B?WFdabjdtL1duUngwOHVPdkZSSDhMY1V6a0M2cHp6QVdYazd3Qloxa010Smk2?=
 =?utf-8?B?dEpwRlV5anZaOEo2b1AzQi9HcDQxdFR4ZjJVcFFzV3RHUGc4ZFZ4cndGOWYw?=
 =?utf-8?B?TG13WSt0QTdjZHRsNEZwWmFKT2E5V0ZvMXdaTVY1RzdJWkhMbndmNkZwcW1M?=
 =?utf-8?B?Z1RBdHRhZTV1TUxONDlyVFpGWGtOVGRIeUp6cFpYb3FhM1BaVFFLeVdnanV5?=
 =?utf-8?B?NXBVYUVnMURNc2gwZGR6dnFXS3k0OE9qenJ2UFo1ZjdNc2RtK2hQcDRLM1Iv?=
 =?utf-8?B?U21EV3lQdmI1MzZVRFVDTUJiaURtRm9qYmQrR0cwTTcwK0FDY2RpNHFLZ3Jh?=
 =?utf-8?B?Z3lCaHIrV0U0ckJUbC9DQ1RtL3hTYk01Vzk5WW9PVkk5ang4WlRNWnVEdDlE?=
 =?utf-8?B?OGpBQnBqbTk5RVkyeUxQaVVmbldGekVFU1VpanQzNWY5aWFOaVdBR3RvbU9z?=
 =?utf-8?B?ZkZGQmRaM29JajJpU3NGY3g2N3RXcnpaWEN2Mi9sbjNnWm9KakhwaGtEQmcy?=
 =?utf-8?B?VXEvb0xEVnpxNU5DZDdndnMxTTFzN2FBV25OV281bTdkNE9Gb3dLbnc3c1pN?=
 =?utf-8?B?Zm90OEs5MmhiZjB5WlpHWncvcy9VVU1YRjBSVFE5dFRMamxiaXRhd05kVTFU?=
 =?utf-8?B?OTBadllEWTUyUzcwLytRdnNFNC9pRGtVNGF1VkFNSVczYjFLM2xwQmhraHE2?=
 =?utf-8?B?anZkNnFocUlEc2ZEakdzeXVhSWVONjk3eGFCWExod2xVTWJ3OG1GS3RuYUQz?=
 =?utf-8?B?U2ZpMFhWZzVCQVZBN09wZmN6WFg2Rzk0ZWFYNU5PN0M2ZmY5bDJFWWxVa3Rm?=
 =?utf-8?B?RHpQcnBhUEhqK0dPblJFa2ZCVWNSS1h6Z1p0b3ZrY3RCU2JFMktPWVJoY3ZS?=
 =?utf-8?B?bVBPY1I4ejdJREhuSk9ScysxQndFS2k3OWZyTHgwMmgxYnFiMHdZZ01FbHc1?=
 =?utf-8?B?di9EY0hTWHdHZ1g2cmRaSVBJL3RhNGREd2RLKzRXcWF4NlVHVks3TVlnY2xx?=
 =?utf-8?B?QzJNRTQ3WWw1SW52dFVZT1JoZlVSZzJUT1hXWEIvd01EQUVYNzdTd3pab0VX?=
 =?utf-8?B?SkwxcU9JVHU1eHU0RmdvaTJVZDFjd0R6bnk3dVFaekI5ZWVpMWJ2K0NlWmVy?=
 =?utf-8?B?R2R2TFd5aE5LMllGUUZPd3VrQmNYOEMyTlo3TThxcTdZc0ZTcFNXRWdMcExh?=
 =?utf-8?B?djlIV28zU3gySkZkZXl6NGFYREkyMjZHQnpQUXB5amh5SmZuYTIvTC9vdHBr?=
 =?utf-8?B?eXBCdUZQSXhsQWQzWmJiM0FXUmEwMFVnVEQ3cVd3b3JDQURwNnFNL3o1Q01s?=
 =?utf-8?B?TGJyL0FOSEdoRlhua3FYdllqOHNiQVVrVFJBSmJEaGtxWVpqK0tqMExKUG4r?=
 =?utf-8?B?Zjc4dmtvVS9velVGTW16TjBRZ044VmNTSVp4djlTV3Y2QTBWUC92czExZ01v?=
 =?utf-8?B?VkZFYjBKQys2TittY3JtQkdVWkRTWnd0Y0k4V3JEdEErZ0Q5eHJZaHFoQ0NJ?=
 =?utf-8?B?L3Z1WStOTjBxUGhUdFhReTBNUk5oZDRIMk1JUzNacEgra09pRnlvR2d6ekdl?=
 =?utf-8?B?SUorSHJjSFJZM2pRc3RRMWE5VXRCZDdsazB0UzdhdzBWRnNDQWFuVWhuSXNh?=
 =?utf-8?B?NzlxMzFqN2R0MldEWmxqM1luRnBGeVZSaGQ2azQ1NzJSaUpFNFBsMHVYWGNw?=
 =?utf-8?B?d04zT1pKcU5TNnBjR29rS3FFTTQ5UmdsOWpPMW5FZWtBOFJpNFV0MWc4RXNN?=
 =?utf-8?B?QjhtV3ZtaHBpRWJ2ME8xRFpuTHZQVnNpdVB6UzNVRzBLbnQ4dlQ5blQzUGZi?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q09uIZJHRIimZhT2O28s0yyyCq6A9P0KielihG7nUhU4k1wHH5NKSEH6iIlZCwAV5Tv2eIL77IR+kJuSQdu/BmtKZfXqJVPlnmhIMUS7Fu9UxojeXrkx1IA/oZAHbruSkErBi7NPv2S3zTnl/iPfJ0PFyYa328ZmFCTsKUstXDCmEXmbeQIRVq3fuR9cRF7aSHDa2qXTSBUdrSMl4VykhUikreDPM84y5c63xiNExUZP0cl+1/piz+a9IQPgIPL7B9TezgaVP5LwoCS/Pd4RFOk8HqmDgoQwZyjft5Lp/hYh2hBhNO58UAV1kli8fpu/jcnyQZym3iHWr8al5J0rd7ivWIiTUYtfh2wJYH67WLIZO5FSNleXpPhn2v68pkuP7wkiiOYVf3UD6dkIukfJBNzMgMoQG3LzSkW2OizA1ilxuI126RSgrRTRmA3Mw5WRijNLFBtrqOkiSc66jUbxP7x9K1fZY35UoLVrxJY4PqEIfYWNzH4KoK7zRsxEl0S6TbtK6yGNxX8Msf4ft/v3PaJU4mZoK84rIAdHndHIJSyTm3didnbcfW7e8f43/A3jEw8rflKoVWGeFbUv6//04p8Wy0DL4GKb0g4UK0MLuRs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee41e2ee-1c89-4236-bdad-08de1b9bb808
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 12:14:35.9809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0jmdFcHL7xsiJ7wjLBshsdr7xD3grY5yVKTv16JVUJSJjxQ1X1eFKnkunE7ERC1oZgU7atQS5+JyyFwcmlgBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7393
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511040101
X-Authority-Analysis: v=2.4 cv=UtNu9uwB c=1 sm=1 tr=0 ts=6909ee5d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=NuoSDmQO2E7U06cPOcgA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA5MSBTYWx0ZWRfX/E6H+l2xw0jb
 RNOkzTPMLgU54WNk1LmTbnvEUOg/xLMQeALNH6PPKU+7wXUWXDCWD++uIiShhEMhnD5uXDeVe02
 loH6PXTBonLOKUyUuR1eiMM3uyGl3LHzc+YbFC7S5TU9grM3qzkj1nl1GDxxUO355NimUPH/XHf
 eq1iRIrw+wxTXMN59uK3HREdG9Q3o6uF2cgr/Kk1CXugfG5LDyRHa2EcRtKPMTfbV9GdVe5ar3s
 +BBfIX6y3x3nRxmud9aQc2SqbM6iihp+vKMJYzZIS+T12J4R5e7ZGES9SPsLMPvLOfcS+C0jzFb
 6gMsZb+PqTah7QMEZqgDubD2G7N2v2bGTl9s2fFAuzfMp6ZIvybo6G64aNRalXS+N3ETktwx6fw
 mDCHGpDc4HHphnXIDc2swZKQjNk/EQ==
X-Proofpoint-GUID: 1SBrXy4NextC2Jpr0Olp4KU6hyd30L0r
X-Proofpoint-ORIG-GUID: 1SBrXy4NextC2Jpr0Olp4KU6hyd30L0r

On 28/10/2025 23:25, bot+bpf-ci@kernel.org wrote:
> 
> ```
> commit 9da54f1ee8589391857dcb28c0dbc65a8e6632ea
> Author: Alan Maguire <alan.maguire@oracle.com>
> 
> selftests/bpf: Test parsing of (multi-)split BTF
> 
> This patch adds a test that writes raw BTF data to files, parses it
> back, and compares the parsed BTF to the original to verify correctness
> of the BTF parsing code.
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_split.c b/tools/testing/selftests/bpf/prog_tests/btf_split.c
>> index 3696fb9a0..b07a91ff2 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/btf_split.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/btf_split.c
> 
> [ ... ]
> 
>> @@ -123,6 +157,38 @@ static void __test_btf_split(bool multi)
>>  "	int uf2;\n"
>>  "};\n\n", "c_dump");
>>
>> +	/* write base, split BTFs to files and ensure parsing succeeds */
>> +	base_btf_sz = btf_raw_write(btf1, base_btf_file);
>> +	if (base_btf_sz < 0)
>> +		goto cleanup;
>> +	split_btf_sz = btf_raw_write(btf2, split_btf_file);
>> +	if (split_btf_sz < 0)
>> +		goto cleanup;
>> +	btf4 = btf__parse(base_btf_file, NULL);
>> +	if (!ASSERT_OK_PTR(btf4, "parse_base"))
>> +		goto cleanup;
>> +	btf5 = btf__parse_split(split_btf_file, btf4);
>> +	if (!ASSERT_OK_PTR(btf5, "parse_split"))
>> +		goto cleanup;
>> +	if (multi) {
>> +		multisplit_btf_sz = btf_raw_write(btf3, multisplit_btf_file);
>> +		if (multisplit_btf_sz < 0)
>> +			goto cleanup;
>> +		btf6 = btf__parse_split(multisplit_btf_file, btf5);
>> +		if (!ASSERT_OK_PTR(btf6, "parse_multisplit"))
>> +			goto cleanup;
>> +	} else {
>> +		btf6 = btf5;
>> +	}
>> +
>> +	/* compare parsed to original BTF */
>> +	for (i = 1; i < btf__type_cnt(btf6); i++) {
>> +		t = btf__type_by_id(btf6, i);
>> +		ot = btf__type_by_id(btf3, i);
>> +		if (!ASSERT_EQ(memcmp(t, ot, sizeof(*ot)), 0, "cmp_parsed_orig_btf"))
>> +			goto cleanup;
>> +	}
>> +
> 
> Can btf__type_by_id return NULL here in the comparison loop? The loop
> iterates based on btf6's type count, but accesses types in both btf6
> and btf3. If btf6 has more types than btf3 (indicating a parsing bug),
> then btf__type_by_id(btf3, i) will return NULL when i exceeds btf3's
> type count, leading to a NULL dereference in memcmp.
> 
> Other btf__type_by_id calls in this function (see earlier uses) check
> the return value with ASSERT_OK_PTR before dereferencing. Should this
> code either verify the type counts match first, or check these return
> values to maintain consistency with the rest of the function?
>

Should I respin a v4 with the bot's suggestion here? Perhaps along with
an ASSERT_EQ() that btf__type_cnt(btf3) == btf__type_cnt(btf6) ? Thanks!

Alan

