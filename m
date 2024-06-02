Return-Path: <bpf+bounces-31147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF818D75C6
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 15:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50BBF1F217F1
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 13:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67683D0D1;
	Sun,  2 Jun 2024 13:42:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F52B39FD4
	for <bpf@vger.kernel.org>; Sun,  2 Jun 2024 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717335748; cv=fail; b=bFcVn28LFRkaJ1VIS06fOG9jIXTG3mNpBFvHflOXN2+OyWKSaecr+3P3R+hFm4raXCgn2BUKRKZaoqIIcGPWrR9Vayp2H0sRtS6soGl0Hw8lKMbVhCdsSGFmzB7GEvC2HGikSSCKt29uHit9pqyBCXx3TxBLijfVW96VaLuOCmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717335748; c=relaxed/simple;
	bh=o3gKo7/EpWVMOr4ZKXVGsTh9z7PSQOxubiDrQSAkEQs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R0I/k0gl5dfu4lYrSh5WxRQ+XlFSfTw67FArkActg8ZOSNuDmv8PNUu5+qpgWpQfkl8PAin3wEZ6TgLmi8T1NHm2+Y9gURCdUiWpF610muT6NufPzqJRoHhe4pVJ/4JLQEzXrvvjRrcUHg8P7EL4UVO/596MFJdOIsCTFGk6kLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 452Aqnut028372;
	Sun, 2 Jun 2024 13:41:43 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DNIMHMPLeharDBK+ZdOowpAFgnMrn93VT+WLh2GEAaMU=3D;_b?=
 =?UTF-8?Q?=3DgzzgTpneJmd6S8yOUk9ZVnEbcq5ZyuaUqvmBWIc5rdBvX0iQOH/2eh8HlNvm?=
 =?UTF-8?Q?Bmq3Ruxb_SFjxjcRdQAgydgeoOBgHnQAqmapGdgvexX3EBQIv4HJaJ0KRGirY6W?=
 =?UTF-8?Q?jJfD/GBRuH3sqL_TT9JLOXbjBgnmbQHZr9ezB1JE8MjmBQlCNgkWiQ8cJm0v22Q?=
 =?UTF-8?Q?F/PM97NJjfflnR4oe2tS_Uv7wQPrs9Y73I36rf3BSj0q0Smgqz/RwKZQ4W+OJX3?=
 =?UTF-8?Q?MWcSND2tdcu9zzHzlaCj98o8K1_4A3cUlh6FoSSoqKroeIIRY93SjpXgmQZdXoZ?=
 =?UTF-8?Q?IEJ2d+x1b+gMUSakqyTFFro0KCMX6mkj_+Q=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfuvvsc2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Jun 2024 13:41:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 452CIFfG031183;
	Sun, 2 Jun 2024 13:41:42 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrmb92r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Jun 2024 13:41:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdY2g0C1QIgWkgluXhe0ZRQSMfToIxBK8set1ahEUNmV1OjRScvyFVMmpGE1XcQSi8MAS5+IWcrAkwgiweE28YHXYyNf22PpAcdAkS2GKtbN1lYesJOSShOXVJm+8I83ukNIFy91nY4e9om9y6kMvQZoyvcqGYhpCIWGlXyr56t943SveGS4BGa7DkBJSUH/7mpQQDmh4gXIVE9hDgV5Wb8lujQS6hD9D2ErP7tExsuLcqLsGKJk+/Zc3N5BpkP111RcOmE4YZO8VWUI3Q9BOfNUfQhUYYC+ouTE1bsG614qRuc3jyrSRvDAsPSA2jJ+ExomB2X5gzyrUkJAn7RElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIMHMPLeharDBK+ZdOowpAFgnMrn93VT+WLh2GEAaMU=;
 b=ikWU80Zob6PypSid/keBX08bbrEXFu2RdMUFvKnwVTjWXSXe9YWfi1eClDQACVuTHOlhs0f6T6OhjUkrPxWtFnXYqbyvz79MrsYAkYW1/KHc6qOKGuCeerbk1wyF7JdnIy5/bt+uqXsIautY6U64+jud+PlJ2IyIcuk8stE6k0RNIRi3jymoWYrKe5kzNGFXGRkic7m7eDTENfT4aWMyjuOSlvqVabMnrsxwsaZMZCgrFBSBUOGomKI5i0CpMwiAhYvdIFzod29aUdkiMtsyWJDOCWLThEm+srH0bE7AzSAbzYMbG0KVkjp/w6IvmHJIRXhrsGB1anO7gFshrbOgqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIMHMPLeharDBK+ZdOowpAFgnMrn93VT+WLh2GEAaMU=;
 b=PH7FORt7uIe0V4HnY4pl69h0nykuXaHRgMZ889RGMeoHS8yA8vCFh5I5LSqnl+TIh60Pd0ivWvZa2vc7j9erOZh69dh4dM0wgNuZNFu8O/BQIhpPqJ/aCGRREHraZTvH1mMaw9rL+FWf2HnCV63kwb271ErY3BtTDoMKG30fd9Q=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH2PR10MB4295.namprd10.prod.outlook.com (2603:10b6:610:a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Sun, 2 Jun
 2024 13:41:39 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7633.021; Sun, 2 Jun 2024
 13:41:39 +0000
Message-ID: <762bba74-7daa-4ebd-b991-acb9a0b14d82@oracle.com>
Date: Sun, 2 Jun 2024 14:41:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 bpf-next 9/9] kbuild,bpf: add module-specific pahole
 flags for distilled base BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        houtao1@huawei.com, bpf@vger.kernel.org, masahiroy@kernel.org,
        mcgrof@kernel.org, nathan@kernel.org
References: <20240528122408.3154936-1-alan.maguire@oracle.com>
 <20240528122408.3154936-10-alan.maguire@oracle.com>
 <CAEf4Bzbgie89A+j3NeFNDor+_AN84YO=f-f+3ekjauxfL=KZ5g@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4Bzbgie89A+j3NeFNDor+_AN84YO=f-f+3ekjauxfL=KZ5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0130.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::9) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH2PR10MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e7fdfa-14f2-4703-4dee-08dc8309bacf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RnpUbzhBTStRSXA2UjJJcm5zSVAvVFhNS2t6WG1kSWxkRHNKcE9xRzliWkVm?=
 =?utf-8?B?MUpkeTNVU3YrZzF1QkNnblJkb0JnRSt3WWdvTWNZTkw4QU9nQmFCNjJZa3NZ?=
 =?utf-8?B?ZWlPamxUVzYzN2NUSTQ3RGcwSXBQMTJLck5wWlN5R3p3UzdQY3FoeWUyNU5x?=
 =?utf-8?B?S2NTRVJXc0ljSDA1Q0EwdUpoM0VWamFNeHg2VWJPVkxuaUVId0V3bUtjTnlU?=
 =?utf-8?B?RWRTQnRhaU9GUC9tTk40QnVSK2Eva1p2K0hBdjNoQmM0UGM4STNrSkV2Rm5w?=
 =?utf-8?B?dFJXWnFVM1Q5Snlwem41OTE4OUJGWVdWbFFyMWt5d2pxTzBvcUxicXMyVVgr?=
 =?utf-8?B?VzRUdC9naWJaZjhwSkRLNW4xUVhWeHp2RWZwL2pUUGtkaWxYYkQ4SXhlK2F6?=
 =?utf-8?B?dDVHcVNzOVgvMmljemhESFNwTG5rQ2xRNG9haXBmY3NEVzdUNEZIU3gvTi9O?=
 =?utf-8?B?TWZiRElwc2NDQ090S1Y3d2JZU0FMRnJLQVlWLy9HdEI2UzFjcHlzMm5jbEFY?=
 =?utf-8?B?dUY1SXJzY3RQRDB0RzNqcnZ6WjBLQ0Jsbmt6ZzFEODB1WDFOMDFJY3FJR00z?=
 =?utf-8?B?bGFrSXdrWXFaNEE4amxERHFqOWVVZVBUOGpFT2Zodk1PS2dwbCt1bnMyd3Mv?=
 =?utf-8?B?QU04WCtFWVRFM0YyRzJ6eUVYZTFVTlFiQnNVbUdrazlDNTg0dVhhb0EvOWpy?=
 =?utf-8?B?amUvS1Q0Ykc3S2hpdGpOMnFPcFdWb2Flc01PY2tycDlhRlRtblpRSHV6TVlK?=
 =?utf-8?B?OForZUwyTlVnL2pHMFlmR015ekdCalRlbzgzVzBEdWNQMkYwZ1pJOU1ubXdU?=
 =?utf-8?B?NmpNMXZVaW02VnRTZ1JaYlNGYk05YlJZYzRZKzFqVWs2MVhmU1djamsvTnc3?=
 =?utf-8?B?N2xVMzAraTcrdTdsVTVhbjZrT3F1Yjk1REFOUGd0YWtlemU5R05lRXpmVXpE?=
 =?utf-8?B?WmlaSmJ0ZnBxMFVkMlgwVEk5Q0RyRnJrUndmZ2hSeTZGTXBDN2RCdkZ5ODNG?=
 =?utf-8?B?UEI3SmJlWXU4b0N6MHA1cDlVaVB0U1hQV05hMi94T21MTllHbDc4NHlDZ0s4?=
 =?utf-8?B?S01WblpmVm5udFZuekRpQ2RUMHNleTU3UGNIdW8xQ1c5Z3NtYVF6RE5qOVlr?=
 =?utf-8?B?MUt1UG50VmI0UktaTGtXUU1OMFU4aGRrekcwbkdMZC9LdHlEMG9HQjU5Mksx?=
 =?utf-8?B?a2Q2Q2hldENqL1VveUdhSjlkRUVqb08zSkVrc0F0cDhMeGhlayt2cEx0Ylla?=
 =?utf-8?B?dzNEcDRnNlFBRmUzMXVJTDgrNldna1o0Z3FESGZ5M2lPK0lia0VLbGliZHgr?=
 =?utf-8?B?TC85czYyajJuTEJIN0R5aU4wTThCYkh6a3hQVWxTOVJrTnFsYktFdVAwYkJT?=
 =?utf-8?B?QkY5N2NUanRNZEVuYkZHL2Z6L3dWc1RxUVk1emVUYXM4Nm03U1JuR2pQRjRT?=
 =?utf-8?B?OHUvRGtjMGRLMzNhSnVyNzdyL3hCZXpGenlSMTJydk1IYlMyTDZuSVhHTXBC?=
 =?utf-8?B?TExhTHNKeFNsZUk0TkZseWRWTW9SdWs2aWRXMUtzK3lHREVRVWlBd1k3M3lC?=
 =?utf-8?B?YVVrM05KTE9sS1RmQzE4V1k5NTYyWWhWek42RzhGaVk3MWt4Z1JtNFM5SnZy?=
 =?utf-8?B?bzBZazd0eEF4ZmtIV1kzVjI4eTlkNFg4OVNtU2MxSmxlYnhxenkvbTNsK3Aw?=
 =?utf-8?B?MmdWRWxnaWxtN3FIMVFXNXAwNytNbHlkYzdpdnU2YWd2bTB5VGpXakl3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZWdqbG1DdEZubUNta3ZaTmpDdGZ3UUpuWWs2N3BMeVh2RWIzOGJQU2tNWVhC?=
 =?utf-8?B?cGZEZnYwUVBYTVRMUWJJZ3Z5Q3pZdUhveUw5QlI4a2QzdmVXTUNTdnJxUTF6?=
 =?utf-8?B?dHZuaU9SUmQwQThhTVVHRlN5YWsySlNEVkpxbnNzS0pCRmd6Y3JlR0tiS0dJ?=
 =?utf-8?B?NUJmSFJEdmFkWUl5YUtWY2VWTUFweWZjK2xRbkx3bW4wVGJoYUlPeXhXQ2hm?=
 =?utf-8?B?d0p5VFpXOTcrcEU2RG5KMWFzdDh6OThmOWk3ZzdPOXMxM2FxWGRBOEM2US9Z?=
 =?utf-8?B?VE8xQnFDN1JKNFdMWG1pYUc4L0E5L1UyOVRDek96c2hQWk8xbVluSWVQbkQ2?=
 =?utf-8?B?aXhCWEVYYmRWNk1wVGNxZGVKNDhONStOODdRYmJRMVM4cXVUTUV3YTRvMm1S?=
 =?utf-8?B?QXJvWVNDU0lUdEo5NmViUlZWeWoyZ2h0WEdWbXJ4YldyMGpxZ0h1Y05ycklL?=
 =?utf-8?B?czlZbk91cHRrcmNTK01tZ3REN1FjOHFiUDdPdFAvUVBaNFIxRE9mT0NheFZm?=
 =?utf-8?B?aEl4b3NtZFRkVFQ0TDVDUDhOY0M0MU5RdWlhSkJVdit6dXdSc2ZaZENIaEVF?=
 =?utf-8?B?bCtyalF4bmt5ZTVuc0EwVTk3ckR6eUxIMkNtSkgyVllKQjdFWGxNaVh4SEZp?=
 =?utf-8?B?dmU2dE04eElKS1c5emk3MFN1TmMrUkZ0NHE5d2JOaDIyRVNMUjlQcTlFdlNs?=
 =?utf-8?B?MUg1NjNCRklLM1RHbmdDcDRXeGdCbm1mSE1aMGprS1M1SmNDWUg5VTZ2SEFM?=
 =?utf-8?B?MFhUSGlOS2wya2JyeEo3aUtWV3pJNGZZZFNTSjFoaThEaVg1QkUwYnY4TFU2?=
 =?utf-8?B?ZVB6UHdOVE9hMzRVU0FOeGc3T3NKOTZtcExHY283cUJ3bTlTRXZ1ejBXaWEr?=
 =?utf-8?B?Y1lHZXZVOVFhSU84WTRqM0g4bGc5MVBaM3NpTWN2OUpqdWRjcXdEeUtZbUtM?=
 =?utf-8?B?WWxFa0RMN2FtSmRGaC85eDRUY09aVHR0QmtqVnBGb3NBMitMVjkwMEhQZGww?=
 =?utf-8?B?SENQaHlkNStDWlNlZnZxUW13elo3NmUzWW9DblRJZDA2SWJsSHlOUWlsaUJM?=
 =?utf-8?B?S1Bub3BreFp6Y0owTHN3SFh0bjRlL2U3SXV0WVFqVUpBK04zZ2szZ1E0SVQ5?=
 =?utf-8?B?djFaYnVsS1lGSFdYa1M1T3VWYlN2cGJmd0VtWnZ1TXdyWmwvTVR3K3N3bVB0?=
 =?utf-8?B?WFg3dmd3MHpiTFNyRXN6Sm9ETWdPVjlsNDFiQVo0TWVsSnpkSnhOTmE2cjhY?=
 =?utf-8?B?VHRzdGlOWHJjb3A3UUY5dU1YeFR2d3hQY1QycE1DN2tsT1RiYU1JcS85Q2Fr?=
 =?utf-8?B?KzRIK1dIZHJXS1V4NUNidzNaV2praFFQTzViS3BhS1FWcVptdWJ6cmovdGc0?=
 =?utf-8?B?VElRSm1KMndQQ2ZxUFlKUHU0NW1obWp3SVRpWHZtbC9TZ2sxem1FZFhDZDhO?=
 =?utf-8?B?SHFnSXJyOUVjRGRBZmozaEdpOW1La3J0TFh0c0dmbVpBVytFbGRRYTlzdFc3?=
 =?utf-8?B?UXoweUszei82empoSVNqbnFtc2E5aWs3THI1aVpkTTN0bGUvaVk4OXlvSnJB?=
 =?utf-8?B?NHIyZFFXZEFudnpKWStWTjVkdCsrWE1Yc1kxVFoyUk5tYS9yaWp2QjZrR3hP?=
 =?utf-8?B?VVBTUVZLVTV6STZPd3FpRGF6UXFjVE1mell3T0s3dDhCaGtiaDJBUWlWelZC?=
 =?utf-8?B?QVVnK0FNTHBweTZDWkdjcmRzeGMrei96VkI3VG1oS1NIUDU2Vm5qTnJvdkZ6?=
 =?utf-8?B?eXlkQU1NS0NUakw3d2JJT1Y4cmVqaVFtVWFwMm44ZklVSXV4Y2p4U2VYd2Rs?=
 =?utf-8?B?QVA0YUl5ZkFMTnhIUlY3M1JZKzNGaVhHckxnOGlQd0lXTk9iNHdBdXZDeHc1?=
 =?utf-8?B?SUlPSHJtTkd5NG9QbkdkclFkMWVMZDJEcFVsd25IRVo1L3pneGNsWlByakkv?=
 =?utf-8?B?UGxTcWVyaHZTdXBaYVE4dWhxL2NwMkhNU0JUR3h1ZlhES0ZTdXg4ZklQZE9R?=
 =?utf-8?B?MDBUWDU5d2NFdWxqMUZXQVRDWmFXclJGVWtnM3hoakFCNXFyQkVvdUpyMzlL?=
 =?utf-8?B?M2drZkVyQU5EVWcvZ2hoc0ZwaVlFbEJqaFJCODFRQ1JwRmJKUS8xSm4xY2th?=
 =?utf-8?B?QnE0YkVGWkkxOVMyY0dZYjU3c24wSC9pbE1XN002b3h1aFAwNnI3RklQZlRK?=
 =?utf-8?Q?Ay8/0uKLYFtA+L23QnTp1UY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	c0zlrJIRYbP68tg/xn1Z3GYtyxVCSTNoM5bX5cx5yEUhRnzs40Awp5MLNzgXLz4aKGE4BplSkEgwNbmIUdgcGSEw+u96skMMO1j6xR8VDapmNpPBR2XjtSPlN9+VfiYKppnXPAOS7bl3zn+QQfZ9zNCjkxTMZvkBE/GXab7L0ojGc717vfz1LNX2qZj1GwB6H1cvNgnM9K26qymaibRWyk7pct/TFTMafJEZbNbEbBd6YK9QtpmScdRbPc3PUg71JTp7qNajfOMX3gUJymO/LAGi463LbpO83ou3DUFRkrlLLQZFOsdbmUqfCEr2J4Y1dEWCeIcmHQeWu+gIERIrw+f0/F+MeRnU0dIXPz4dkmgXB59OoCQDMsgj+TP6qi53a3MybhinktQHXj8r66CIYH9HQJemKujT3wqX3lKXxfIDhic6zjcsd7O9klMh5cHs6KI672d53wQ9veTdAD0DB4dRqV3+1WksjDQfdp8ApNPAH2i4iYvKBA5UcnOqOdYLDysJmNg9zJZ8orMvwnOX701WNQUPrDffLNX1D3rT+1VGM/rQLAKgHyaMuY8jYt2Ne9qYaVA0JWTwbx5cAyblpdN6FYVe4E8tZeDQ1FInXZs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e7fdfa-14f2-4703-4dee-08dc8309bacf
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 13:41:39.4450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0merVQHN5S50Ljc2XpbBL6Qlclkg6MknGPGAT29eZRWawrGsUyhi6w0KBGXRlvu80xL06p3q7Bwl6iW60dP9Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4295
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_08,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406020117
X-Proofpoint-GUID: 4_LdkIb9BV5zjvrJdKP87ePiMpKx44vm
X-Proofpoint-ORIG-GUID: 4_LdkIb9BV5zjvrJdKP87ePiMpKx44vm

On 31/05/2024 20:06, Andrii Nakryiko wrote:
> On Tue, May 28, 2024 at 5:25 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> Support creation of module BTF along with distilled base BTF;
>> the latter is stored in a .BTF.base ELF section and supplements
>> split BTF references to base BTF with information about base types,
>> allowing for later relocation of split BTF with a (possibly
>> changed) base.  resolve_btfids detects the presence of a .BTF.base
>> section and will use it instead of the base BTF it is passed in
>> BTF id resolution.
>>
>> Modules will be built with a distilled .BTF.base section for external
>> module build, i.e.
>>
>> make -C. -M=path2/module
>>
>> ...while in-tree module build as part of a normal kernel build will
>> not generate distilled base BTF; this is because in-tree modules
>> change with the kernel and do not require BTF relocation for the
>> running vmlinux.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  scripts/Makefile.btf      | 5 +++++
>>  scripts/Makefile.modfinal | 2 +-
>>  2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
>> index bca8a8f26ea4..191b4903e864 100644
>> --- a/scripts/Makefile.btf
>> +++ b/scripts/Makefile.btf
>> @@ -21,8 +21,13 @@ else
>>  # Switch to using --btf_features for v1.26 and later.
>>  pahole-flags-$(call test-ge, $(pahole-ver), 126)  = -j --btf_features=encode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consistent_func
>>
>> +ifneq ($(KBUILD_EXTMOD),)
>> +module-pahole-flags-$(call test-ge, $(pahole-ver), 126) += --btf_features=distilled_base
> 
> Remind me, please. What's the state of pahole patches? Are they
> waiting on these libbpf changes to land first, right?
>

Exactly. The idea would be this; we land the libbpf patches first, and
then update the dependent commit in the dwarves repo to point at one
with the relocation APIs. In the interim - where we have the code in the
library but not in pahole - everything continues to work as before. It's
just that the above --btf_feature creating distilled BTF is ignored,
which means we don't generate any distilled BTF in any modules until
that support is in the pahole used.

Thanks!

Alan

>> +endif
>> +
>>  endif
>>
>>  pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         += --lang_exclude=rust
>>
>>  export PAHOLE_FLAGS := $(pahole-flags-y)
>> +export MODULE_PAHOLE_FLAGS := $(module-pahole-flags-y)
>> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
>> index 79fcf2731686..6d2b8da98ee5 100644
>> --- a/scripts/Makefile.modfinal
>> +++ b/scripts/Makefile.modfinal
>> @@ -39,7 +39,7 @@ quiet_cmd_btf_ko = BTF [M] $@
>>         if [ ! -f vmlinux ]; then                                       \
>>                 printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
>>         else                                                            \
>> -               LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) --btf_base vmlinux $@; \
>> +               LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base vmlinux $@; \
>>                 $(RESOLVE_BTFIDS) -b vmlinux $@;                        \
>>         fi;
>>
>> --
>> 2.31.1
>>

