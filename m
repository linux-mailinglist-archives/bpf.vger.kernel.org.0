Return-Path: <bpf+bounces-27795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7308B1CAB
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 10:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD96A1F21010
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 08:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5176EB7C;
	Thu, 25 Apr 2024 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jARygBAo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CtaKrdvz"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA9D6E5FE
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 08:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714033000; cv=fail; b=TlAgs0gc0T2GuY/3HGHqjUV/46jzkf+8M19W5i/f+7eXRdXaX82Qlnf5xwwjznXCgzRCsVKda0RrOAIHqnSpNhi4ISyS+cBKCgeOXQU0nWnL2QQAUwfgaPpqE5DOW6pzd9B2/ZxHY0pTmo+8MgnB8F/PB/dXgMx9ltWYSToRTwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714033000; c=relaxed/simple;
	bh=MdS9hRnKbQ44FvI7M0/dc12bGx79x7IIPam1VrhU3oc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n5BeqfRnBxdjGA4dE681Yzl+HFWrHwSkS2xgpX/DiCKmUN5/yo0GbM+G1wjlA42Jl3xsf9KxB/8KPF4DGwvfxXxAyj8t3kj7aw46n+SeOp2mefDIP5UDLKQaiCiF7BtS/lGde3ej36VpBflCU2BzOt8agF273z0ANbE+4l9EU2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jARygBAo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CtaKrdvz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43P0i6tP015239;
	Thu, 25 Apr 2024 08:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=FvI7Mpr+K3b3npJAEfxWNsogQUtfMHYkKo3j+aflhwU=;
 b=jARygBAo1O5ahD/Oo7B3YZVGECloC92LYj3OXFzWD5HciIt0NZz940qbjbhOlpafM6Bc
 eui5tqyOHwYbZsKhHRdvB5YbehbxhTzO62OpHOh7fNKx5VPV3H/hxmbK2StiXqbnloLh
 6iN6jOlpaQK4/Bghl4PFiH5fdE222btq08asQ3nl5i+ZQWLYUSfTgEeWuqsQzBvwinND
 fD6WNPHnVj8s9I2tkihTOLVQzC1PCPg37kGxbRbmO32YyQ48JUpzgfFvhMMFJLbpP9bo
 ScR3WGBlT8JWp3UTLR/e4GTyo1GVGhMJdKm1t07zzVHVL9f00kpFtjykjy5T1is0MnoA /Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm44f1tbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 08:16:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43P76Za6025225;
	Thu, 25 Apr 2024 08:16:17 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45gavvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 08:16:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJOyXu3fBKwRrJKx+rQBhq7onLYQYKfHfWDRhC3LebsS+My3Pup5hDiivir/VVNi9lzl6ZySmBC9ZafaaU0aiZpqQ0Cv5FePsO8NZKbbvBgwSQG+r9XAVNfvRZBk9AjOBWb8SGE7qlZBdultev+8uVDmaWVNdJ2KQqqoNUvZCISWI2pijnWcTPchQFBIMz+q17QRBkPUYdl5gyN+V1MxBePNblQT2MdBmG1UARsoP++B6IvNaQkoGwyiAIbrAQB+XvII2zXR/UZncVcEaudJC/wfxBQy4pJLKjcjFA2Nz4ZlLPKDyEcO5V+powD0C3LYe3hOgsBVkbGKg7ZmGPMBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvI7Mpr+K3b3npJAEfxWNsogQUtfMHYkKo3j+aflhwU=;
 b=hS82REdTIyf5lDzHgfvhGP+FC+YFkStdyZ3osM/3wJzgauVM3miJP8NoX/MiSeQtqSF5uwKawtzvaXdXJ6RWbqyOtgdMfeOnhcXb2bwFueSmxsflOZUtMXxDJWXoTql1hXQZC+iGs0b23OTcedVUk5Kn9Wzpp/xc1ij3DDkhcLMQCXEPx/wsIxhIqCC19w69L4IPSMS9ymAzmqsMw/eGR/nPZ97jXOaEQpiOa0f8iRi6opZH8xOXYbzMsoOkNW77ljkeWTf4bco4lE32nAsUsxR/lRbb0tI7uGDb+YqWB0i6fp47ETOF6NanKsmgCtIMECNSWsp3bNfjcqGQxMX/bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvI7Mpr+K3b3npJAEfxWNsogQUtfMHYkKo3j+aflhwU=;
 b=CtaKrdvzYTlAymA7j2kyo+tjaJ3WHLGAARG9e2wMTLZTFktBGs96c3xmKZCLBXmEejNCHudPMrHQBR4qMM3B1sX9PmoCywRknh2ltdi7B7+JDcfj3o099Gk6gvTE8ohaVDpxO+1cBdfgAgsZBHLUUzHoQjHG/FdDOxhVwg0t4mg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA1PR10MB5969.namprd10.prod.outlook.com (2603:10b6:208:3ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 08:16:14 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 08:16:14 +0000
Message-ID: <7399c206-23e0-49ea-b46f-5ea582c18cc5@oracle.com>
Date: Thu, 25 Apr 2024 09:16:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v7 2/2] pahole: Inject kfunc decl tags into BTF
To: Daniel Xu <dxu@dxuuu.xyz>, acme@kernel.org, jolsa@kernel.org,
        quentin@isovalent.com, eddyz87@gmail.com
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org
References: <cover.1713980005.git.dxu@dxuuu.xyz>
 <bd853cc2c6da4c29984b8751c0adf81a3ba0b8a3.1713980005.git.dxu@dxuuu.xyz>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <bd853cc2c6da4c29984b8751c0adf81a3ba0b8a3.1713980005.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P192CA0020.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::25) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA1PR10MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 051240c7-c7a1-43d0-1205-08dc64fff8ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ekRYNk9VNVhjZXhnTTBKc0QxY2dzTXVLR0pHNnhtNGI5NnRZYTJqdmYrbGVp?=
 =?utf-8?B?WllsZFBMZDlUOFVPMTg2SkR6dzJrdWdlY1NKb2ZZVFlmaG16YStnQkZSZzhm?=
 =?utf-8?B?cVU5L1FIMCs3VW56Z2o3b2hPNUkzZzJzTi9zMFFKeEx1M2FBNmtUWjdwb1RU?=
 =?utf-8?B?YkhJbTF3TDRHcHpvajllRUlpTFpuc0JEMDhUNDkrZnFsUlhNMW5FL2w4eG80?=
 =?utf-8?B?QmcwRXZZQTdkaFdtWHEvSWZJVDk5K2FNbk51eUxlYlFtLytaUkpPOENRYW1v?=
 =?utf-8?B?Z1BvcWNoaHpIUnFPUDN4SXp6dVpkNWJ2Wm1PempRUWgrUE0xZHNnV1MvdUV2?=
 =?utf-8?B?NndoeGR2dWdmeWxYNmhpbUxrRnFWRVpsb0pVcHZiRmpEcXRYVXZzREZYWkY2?=
 =?utf-8?B?MjEvcVNiL3V0djFOZVh4YVNMN1BudE9KTzhwdDllSFpzbFY4UXZsMFVlcFlZ?=
 =?utf-8?B?ZnFVejJFb2xFeVZiOUhvYXN5RTdFVWxObUFwRG1JQ0E5U09IVWdWdEI3cGYr?=
 =?utf-8?B?Mksxd085dURhOVIya3o1elhWZ21oZ2VmRXRpbjNpbzhwdTJmc0FMSTN6TFhM?=
 =?utf-8?B?OGxDWmZIRFg0MW9pdUhTbHU2TVdTc1FVRE9HRW5jQmErZWx2M055Q1pzbHhp?=
 =?utf-8?B?amNCV1U0UjZoZzcrMzY0RVJjZGNieFlQTm9Cdm13RkE2K2owdDdJNXJtMy9T?=
 =?utf-8?B?TERTVko4WUxqekxaR09QK3dJcEsxRmJSVUFpaWw2SlF6dUt3UE9McEZ2ZC9l?=
 =?utf-8?B?djc1OXdYOXJmdzNvVFBjbTUyNG9PNUZwVGM2UThMcDQ4cExtNFJ0MUptdVZq?=
 =?utf-8?B?dENIN0dmZlVtSzV1dm53a2J1N253QkV2eDZONm1EajRKczYzb3M5VjIrSitF?=
 =?utf-8?B?dE5wQmJPS1BlSUtNMFFadGFwcGh0elJYUTZxamRmc2JHUmYrV3NCNVZ0MTd4?=
 =?utf-8?B?Qlp3cC9ZQ25zNmVCVnFNT2FWOWxxWGVRWHlTN2VseWlVUnkxVGorYTl4QTJM?=
 =?utf-8?B?T1p3WCs0RXFmbWkwZjdHRGJ1T3QvbG4vSkU1cCtRNHJudFZrWEUxcEo3VXdJ?=
 =?utf-8?B?UlVBdUxzRm44YTNkWXJ6b2hLdjRJUkxoa3dLdlFGcnhuUVZKSEpBNTl1ZmxV?=
 =?utf-8?B?N2NCVFZya2VxQ25qYlpBLzI2Z05JV3NKcHNxdklqa0tQNTBQb3VmWENMQTBS?=
 =?utf-8?B?VGR6TTgvcURYZHB1bXM3ZGQ2Yml5SnBiSFJoRHArb01MM0VDdUpFMFdiY3hp?=
 =?utf-8?B?VVJYNkxidzRXOFh6VW1tSVFuQngwM2kvdUh5QjR3MDhneTNMZW5KSlV0citz?=
 =?utf-8?B?VWhuSGhEV2h4dmJFUGRETHo3cWFQaW52Ry9UUkl4dElBVWhuS3FUamgwRlhX?=
 =?utf-8?B?ZmxFWWE5VE9jNEVZSm5HWVNMbFBHQWJPd01HRlcyTkFxVlhaUDZmbFpUSGVY?=
 =?utf-8?B?NHREdWlqS2J3VXJ1bEkxbnhDSGVKRTFMeWIrajYvVWdOM0tibUxES0pVMkwz?=
 =?utf-8?B?MjBheXJ4dTluSlpPUWJpa1B6MGl3L1RDSXByQSs1cDZCUjRMSFFsbUxBWGxp?=
 =?utf-8?B?VHpZNHBab0t1TWx4NGxZUWxXOFc1V05GUzZiVlJ6cG1tcTJaYkEwTHoyczhh?=
 =?utf-8?B?djQ5VGZETERuSXBGSkh2a2RrUzZnTzJoY2xQcHlGVmovUW83UCs2QVFsSFlJ?=
 =?utf-8?B?V0JpYkFhNlFDTkVoeEkwOWNtTDVWK0JYNWtuWFl0U0VrNmI3NjU0VDR3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UmhnWmJQUWJUVkJzY0VzU2N5T1lEZFQxd09YLzZJdkJvNFI4ME9UN2QzV0JJ?=
 =?utf-8?B?OUdVMHZMN2RIdk9MSGRYdGprRjVrbDRaaWNlZTZEeWNkL2I0V2dkbm5WL1B2?=
 =?utf-8?B?TE00WVZDWVlldGR3cFR1cWVtL2ovRUtuNE9QRUozc0VHSktyZG5BTk1EQS9F?=
 =?utf-8?B?b2I0UlJPTVFLTzRiT29wTkUxdWcrT1NEVHk4aDV2cFkxZkRvNERnN1NuSm1X?=
 =?utf-8?B?cEFhTExhWkhiYUhGWGNra1ZpekRlK0lCMVdMbSttL2txWng5WTVYL2hHOGR4?=
 =?utf-8?B?MEg0Z0cyQTYyMXpQVy9SalVNTHVySGlVVUovR0NCQ3ZTVFQzVlkzc3daeXVu?=
 =?utf-8?B?RDBMK2VMMXFPcW94YUdLMEgxa29sODB2RW9hcGNkcmZWT2k1MnZIaGRpZlN5?=
 =?utf-8?B?VEp0eVJMTnEvVEtERXdUL0VjTGJyb0dxSzM3eWtCcmFubVdyQVQrMHhJSzRo?=
 =?utf-8?B?ckV4c1M3UUNjZGFQWURueDRicElpcXNLZTV5eVd6YVVaR0lRVVJ4RVlRT3pp?=
 =?utf-8?B?cjJoWGlqcXZZK1g3TGJPS3gvYUVoMDRkUE43NnFwazNqbTMwdzJUZlIyNmpZ?=
 =?utf-8?B?bC93UHZ1MHdsYWIzNTREVEd5c01nWVBQaFZFSDR6bVI4UHJ6K0NKMjBwbmtr?=
 =?utf-8?B?WStBNUdCZlVCQnZhc2lRQXg4TFlKa25qQnVLOTVrYWttTnZNOFVobTJ2MFRM?=
 =?utf-8?B?U3UxVzhUZllkWmxQUU1HNzFJL1hkWGFNOWswZ25YVGg0cFNmWnFreGVpSktJ?=
 =?utf-8?B?ekVVb3AxZ2lmYW5COEpHejNtL0l2dG1wYzFQM0UvR0N1RFl1TERsTjA1d3JH?=
 =?utf-8?B?Vzg2QWxlY3loT2t0eG1Pd0VQenI5bUpIN3VEMUFydVJTVEVjcko2OE4xWk5j?=
 =?utf-8?B?ZGZhUTl1K3BMQkp4TmxSYk5qeGZ6c091cWZKTlJnTSs4VTFIdDFHRjViVTl0?=
 =?utf-8?B?M0llUURoZTJhbC9sZFliU1VVZDJiazBZSWVzdHhTUUt3RldZd1NKSzZzV1ZY?=
 =?utf-8?B?V1dad3I0OVJHTFNxUzZkRGpDRFlrbm1FU1J1cis0NEpsWlM4Z2VqaDhPaktl?=
 =?utf-8?B?V0F1WnZnUGlkTnBiRmJxUkxPcVYxQXJpRWpvOTRuOGRleFBhWW12VGEzRGZm?=
 =?utf-8?B?T1IwMEJKVUdlZXVzZGFjOVhHQnNiazh5Z1pZUWkxdTBIcW41ZklRM2tyUUJu?=
 =?utf-8?B?Y1ROVWtqblQ0WnluYklCNGhZMDNpbWRwby9nMFZkOFk5NlJ1VDNhVElRMTJP?=
 =?utf-8?B?MlorSWVoZ2xHU09CRmpWY2dDcm94OG1JM3RIWGZmYzNOR2JLdWJCbXV3Y204?=
 =?utf-8?B?ang0SytCWmsyK0ZIZjdRL09KcEQ5Y2dvOEZRcDN2bzkza1BKd09QRU40djBu?=
 =?utf-8?B?cnVoSTVLVTR6VUNCYmEzaWwrT01YeHRZalowZm5oSFRJMG9YMEpNUUZGUGtN?=
 =?utf-8?B?enNQVlhKQ3BSRGNMc3oydkpBZjJWb1crTGNheWgxSU5zaUFHUkx1RnFBYVJZ?=
 =?utf-8?B?bEFpSkQvaDREditJbWRXTXVXN0doWXViallvaUtkL2NRNXk1c3pFZERITE5I?=
 =?utf-8?B?Z2MxbzNKQnJMWmovTkZueCsvRC9wNG8yMjIxTVloQnViM0ZSM0hKOEVVS0M5?=
 =?utf-8?B?elBTOC9pckxVS3RET3c3a1NDZEhrQU15NEEyWTJWT2FJQ3JIUld4U3c0dE1Z?=
 =?utf-8?B?WFYzRWN5azZnUldiVkhHLytBcTVoaTFBMldCVjRLNkkrYnFaT2FSYmxIdThp?=
 =?utf-8?B?Y0RkNnlHcWRWazhPcUhkeS91d0NvOTFjQnNRcnNjZ1hhSGVyK2JYM1R5STVO?=
 =?utf-8?B?MWFCdEd5ZEdsQVFuTThjbFB3Y3V0d2FlMVhMbmcvbXNEc0NUVmJKUWZJM2Fl?=
 =?utf-8?B?TEh4Y3VCUWU4M3pTb1Y5TkFwS2xIbTZvRjhsQUZPeU1hd0RiQVR6N2FYbDBP?=
 =?utf-8?B?c2ViTURyMkNaN3cveTBZRlM3NGY1Y0p3WHRoTFFKRGZ1bGhGZVR4UnV1YXlY?=
 =?utf-8?B?SlhFNHVsbTVSSEtnRmU3VUx5Sy9HeDRvRUpVdGxkcnlrQkxPanpVUDlGcXlJ?=
 =?utf-8?B?RHM3K21aSGNsWkJvanJkeHJEYWs0M0pWY3NXaDd0bUpvVENhRysyRWlyNlFM?=
 =?utf-8?B?RzlRaDQxZGlZOVNybjJGaXY3SjRXV2NWUTliVS9UN3J1c05TU1FTdlNTdVZk?=
 =?utf-8?Q?FVmIzxN9r5NkMXNhZdpQ/XM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Lwmi1gEegDlPgHwGroxwCBYDhYSl+/rDMT64HObOSHAWXtNag99TVI1E2i8qMK5q3eQQ5xZlpiIPwh9YtTNXod/YCZyip1iASWI+IkpHV/7n7vi9NUQQJYni+WLD9c8DBs0eYo5ntODoCPcudwt4JtlCJa/8mcAH2yVF4FY6vDrsXOfphhe5kN1iPTCHqu73/pDwCYYaH/k90MON5EYrqCTypfoxiMfNNezlr0vUBI/ek8yyxzkbBJaB8KDjJ/oQZWX8wCCscvX01GEYOOrMDbp4pZyNHMVnvuXHQ1B2Dyx5BT5+Tum1g4YLbFFX/siNsvyPJfspsO/JSzlcvHFjTuUwNC8RgW2sdaStzEEpyn5xB6+yvLS/SIxnr+uXDpogiyqcdUAl0ZfgbSCB5zbDrHGd1HchToQR4yXsfpav4SIobP6u2yNRjwtkSO4xiS3meWH37JtVwWFLOUSfNU+Caso2IAkn2Ok3wIbTC+T/8OsJEqhptWFhGJEp6DSJjyVmeH/DZyljfNWGfEou5chW4mQw/a+mJyobhv+WmQWshEHBzh2QVOzYm7+83TqTzYT4KRHZgN0qJ/IGz440gf8jHbzBkccjA0iAxNT0byt9Tsw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 051240c7-c7a1-43d0-1205-08dc64fff8ff
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 08:16:13.7739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6MK8tzwpGC5XKBrf206BCbQdzQXkThEmI2KMSmgtHnLiN1/59TI6YWUG0myZcWkRkBlOeVGeQhqr23VpanQvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5969
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_07,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250058
X-Proofpoint-ORIG-GUID: elI5sOF9-FHAUA56UVji_CBd6hQGy5nT
X-Proofpoint-GUID: elI5sOF9-FHAUA56UVji_CBd6hQGy5nT

On 24/04/2024 18:33, Daniel Xu wrote:
> This commit teaches pahole to parse symbols in .BTF_ids section in
> vmlinux and discover exported kfuncs. Pahole then takes the list of
> kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> 
> Example of encoding:
> 
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kfunc'" | wc -l
>         121
> 
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
>         [56337] FUNC 'bpf_ct_change_timeout' type_id=56336 linkage=static
>         [127861] DECL_TAG 'bpf_kfunc' type_id=56337 component_idx=-1
> 
> This enables downstream users and tools to dynamically discover which
> kfuncs are available on a system by parsing vmlinux or module BTF, both
> available in /sys/kernel/btf.
> 
> This feature is enabled with --btf_features=decl_tag,decl_tag_kfuncs.
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Tested-by: Jiri Olsa <jolsa@kernel.org>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

I ran into failures running the reproducible build test in tests/
with this patch.

You can reproduce this by running that via

bash reproducible_build.sh /path/2/vmlinux

or just doing

pahole --btf_features=default
--btf_encode_detached=/tmp/vmlinux.btf.serial /path/2/vmlinux

The problem seems to be with detached encoding. It stems from the
assumption that encoder->filename is the source of the BTF and the
destination. In the case of detached BTF, source and destination are
different, so I think we just need to store both the source and
destination for encoding in struct btf_encoder.

The following change fixed this for me:

diff --git a/btf_encoder.c b/btf_encoder.c
index d326404..303a6d5 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -79,6 +79,7 @@ struct btf_encoder {
        struct btf        *btf;
        struct cu         *cu;
        struct gobuffer   percpu_secinfo;
+       const char        *source_filename;
        const char        *filename;
        struct elf_symtab *symtab;
        uint32_t          type_id_off;
@@ -1545,7 +1546,7 @@ out:

 static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
 {
-       const char *filename = encoder->filename;
+       const char *filename = encoder->source_filename;
        struct gobuffer btf_kfunc_ranges = {};
        struct gobuffer btf_funcs = {};
        Elf_Data *symbols = NULL;
@@ -2020,6 +2021,7 @@ struct btf_encoder *btf_encoder__new(struct cu
*cu, const char *detached_filenam

        if (encoder) {
                encoder->raw_output = detached_filename != NULL;
+               encoder->source_filename = strdup(cu->filename);
                encoder->filename = strdup(encoder->raw_output ?
detached_filename : cu->filename);
                if (encoder->filename == NULL)
                        goto out_delete;
@@ -2104,6 +2106,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
        btf_encoders__delete(encoder);
        __gobuffer__delete(&encoder->percpu_secinfo);
        zfree(&encoder->filename);
+       zfree(&encoder->source_filename);
        btf__free(encoder->btf);
        encoder->btf = NULL;
        elf_symtab__delete(encoder->symtab);


If you could roll something like the above into a respin of this patch
that would be great. Thanks!

> ---
>  btf_encoder.c | 372 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 372 insertions(+)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 850e36f..d326404 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -34,6 +34,21 @@
>  #include <pthread.h>
>  
>  #define BTF_ENCODER_MAX_PROTO	512
> +#define BTF_IDS_SECTION		".BTF_ids"
> +#define BTF_ID_FUNC_PFX		"__BTF_ID__func__"
> +#define BTF_ID_SET8_PFX		"__BTF_ID__set8__"
> +#define BTF_SET8_KFUNCS		(1 << 0)
> +#define BTF_KFUNC_TYPE_TAG	"bpf_kfunc"
> +
> +/* Adapted from include/linux/btf_ids.h */
> +struct btf_id_set8 {
> +        uint32_t cnt;
> +        uint32_t flags;
> +        struct {
> +                uint32_t id;
> +                uint32_t flags;
> +        } pairs[];
> +};
>  
>  /* state used to do later encoding of saved functions */
>  struct btf_encoder_state {
> @@ -75,6 +90,7 @@ struct btf_encoder {
>  			  verbose,
>  			  force,
>  			  gen_floats,
> +			  skip_encoding_decl_tag,
>  			  tag_kfuncs,
>  			  is_rel;
>  	uint32_t	  array_index_id;
> @@ -94,6 +110,17 @@ struct btf_encoder {
>  	} functions;
>  };
>  
> +struct btf_func {
> +	const char *name;
> +	int	    type_id;
> +};
> +
> +/* Half open interval representing range of addresses containing kfuncs */
> +struct btf_kfunc_set_range {
> +	uint64_t start;
> +	uint64_t end;
> +};
> +
>  static LIST_HEAD(encoders);
>  static pthread_mutex_t encoders__lock = PTHREAD_MUTEX_INITIALIZER;
>  
> @@ -1363,8 +1390,343 @@ out:
>  	return err;
>  }
>  
> +/* Returns if `sym` points to a kfunc set */
> +static int is_sym_kfunc_set(GElf_Sym *sym, const char *name, Elf_Data *idlist, size_t idlist_addr)
> +{
> +	void *ptr = idlist->d_buf;
> +	struct btf_id_set8 *set;
> +	int off;
> +
> +	/* kfuncs are only found in BTF_SET8's */
> +	if (!strstarts(name, BTF_ID_SET8_PFX))
> +		return false;
> +
> +	off = sym->st_value - idlist_addr;
> +	if (off >= idlist->d_size) {
> +		fprintf(stderr, "%s: symbol '%s' out of bounds\n", __func__, name);
> +		return false;
> +	}
> +
> +	/* Check the set8 flags to see if it was marked as kfunc */
> +	set = ptr + off;
> +	return set->flags & BTF_SET8_KFUNCS;
> +}
> +
> +/*
> + * Parse BTF_ID symbol and return the func name.
> + *
> + * Returns:
> + *	Caller-owned string containing func name if successful.
> + *	NULL if !func or on error.
> + */
> +static char *get_func_name(const char *sym)
> +{
> +	char *func, *end;
> +
> +	/* Example input: __BTF_ID__func__vfs_close__1
> +	 *
> +	 * The goal is to strip the prefix and suffix such that we only
> +	 * return vfs_close.
> +	 */
> +
> +	if (!strstarts(sym, BTF_ID_FUNC_PFX))
> +		return NULL;
> +
> +	/* Strip prefix and handle malformed input such as  __BTF_ID__func___ */
> +	func = strdup(sym + sizeof(BTF_ID_FUNC_PFX) - 1);
> +	if (strlen(func) < 2) {
> +                free(func);
> +                return NULL;
> +        }
> +
> +	/* Strip suffix */
> +	end = strrchr(func, '_');
> +	if (!end || *(end - 1) != '_') {
> +		free(func);
> +		return NULL;
> +	}
> +	*(end - 1) = '\0';
> +
> +	return func;
> +}
> +
> +static int btf_func_cmp(const void *_a, const void *_b)
> +{
> +	const struct btf_func *a = _a;
> +	const struct btf_func *b = _b;
> +
> +	return strcmp(a->name, b->name);
> +}
> +
> +/*
> + * Collects all functions described in BTF.
> + * Returns non-zero on error.
> + */
> +static int btf_encoder__collect_btf_funcs(struct btf_encoder *encoder, struct gobuffer *funcs)
> +{
> +	struct btf *btf = encoder->btf;
> +	int nr_types, type_id;
> +	int err = -1;
> +
> +	/* First collect all the func entries into an array */
> +	nr_types = btf__type_cnt(btf);
> +	for (type_id = 1; type_id < nr_types; type_id++) {
> +		const struct btf_type *type;
> +		struct btf_func func = {};
> +		const char *name;
> +
> +		type = btf__type_by_id(btf, type_id);
> +		if (!type) {
> +			fprintf(stderr, "%s: malformed BTF, can't resolve type for ID %d\n",
> +				__func__, type_id);
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
> +		if (!btf_is_func(type))
> +			continue;
> +
> +		name = btf__name_by_offset(btf, type->name_off);
> +		if (!name) {
> +			fprintf(stderr, "%s: malformed BTF, can't resolve name for ID %d\n",
> +				__func__, type_id);
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
> +		func.name = name;
> +		func.type_id = type_id;
> +		err = gobuffer__add(funcs, &func, sizeof(func));
> +		if (err < 0)
> +			goto out;
> +	}
> +
> +	/* Now that we've collected funcs, sort them by name */
> +	gobuffer__sort(funcs, sizeof(struct btf_func), btf_func_cmp);
> +
> +	err = 0;
> +out:
> +	return err;
> +}
> +
> +static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *funcs, const char *kfunc)
> +{
> +	struct btf_func key = { .name = kfunc };
> +	struct btf *btf = encoder->btf;
> +	struct btf_func *target;
> +	const void *base;
> +	unsigned int cnt;
> +	int err = -1;
> +
> +	base = gobuffer__entries(funcs);
> +	cnt = gobuffer__nr_entries(funcs);
> +	target = bsearch(&key, base, cnt, sizeof(key), btf_func_cmp);
> +	if (!target) {
> +		fprintf(stderr, "%s: failed to find kfunc '%s' in BTF\n", __func__, kfunc);
> +		goto out;
> +	}
> +
> +	/* Note we are unconditionally adding the btf_decl_tag even
> +	 * though vmlinux may already contain btf_decl_tags for kfuncs.
> +	 * We are ok to do this b/c we will later btf__dedup() to remove
> +	 * any duplicates.
> +	 */
> +	err = btf__add_decl_tag(btf, BTF_KFUNC_TYPE_TAG, target->type_id, -1);
> +	if (err < 0) {
> +		fprintf(stderr, "%s: failed to insert kfunc decl tag for '%s': %d\n",
> +			__func__, kfunc, err);
> +		goto out;
> +	}
> +
> +	err = 0;
> +out:
> +	return err;
> +}
> +
> +static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
> +{
> +	const char *filename = encoder->filename;
> +	struct gobuffer btf_kfunc_ranges = {};
> +	struct gobuffer btf_funcs = {};
> +	Elf_Data *symbols = NULL;
> +	Elf_Data *idlist = NULL;
> +	Elf_Scn *symscn = NULL;
> +	int symbols_shndx = -1;
> +	size_t idlist_addr = 0;
> +	int fd = -1, err = -1;
> +	int idlist_shndx = -1;
> +	size_t strtabidx = 0;
> +	Elf_Scn *scn = NULL;
> +	Elf *elf = NULL;
> +	GElf_Shdr shdr;
> +	size_t strndx;
> +	char *secname;
> +	int nr_syms;
> +	int i = 0;
> +
> +	fd = open(filename, O_RDONLY);
> +	if (fd < 0) {
> +		fprintf(stderr, "Cannot open %s\n", filename);
> +		goto out;
> +	}
> +
> +	if (elf_version(EV_CURRENT) == EV_NONE) {
> +		elf_error("Cannot set libelf version");
> +		goto out;
> +	}
> +
> +	elf = elf_begin(fd, ELF_C_READ, NULL);
> +	if (elf == NULL) {
> +		elf_error("Cannot update ELF file");
> +		goto out;
> +	}
> +
> +	/* Locate symbol table and .BTF_ids sections */
> +	if (elf_getshdrstrndx(elf, &strndx) < 0)
> +		goto out;
> +
> +	while ((scn = elf_nextscn(elf, scn)) != NULL) {
> +		Elf_Data *data;
> +
> +		i++;
> +		if (!gelf_getshdr(scn, &shdr)) {
> +			elf_error("Failed to get ELF section(%d) hdr", i);
> +			goto out;
> +		}
> +
> +		secname = elf_strptr(elf, strndx, shdr.sh_name);
> +		if (!secname) {
> +			elf_error("Failed to get ELF section(%d) hdr name", i);
> +			goto out;
> +		}
> +
> +		data = elf_getdata(scn, 0);
> +		if (!data) {
> +			elf_error("Failed to get ELF section(%d) data", i);
> +			goto out;
> +		}
> +
> +		if (shdr.sh_type == SHT_SYMTAB) {
> +			symbols_shndx = i;
> +			symscn = scn;
> +			symbols = data;
> +			strtabidx = shdr.sh_link;
> +		} else if (!strcmp(secname, BTF_IDS_SECTION)) {
> +			idlist_shndx = i;
> +			idlist_addr = shdr.sh_addr;
> +			idlist = data;
> +		}
> +	}
> +
> +	/* Cannot resolve symbol or .BTF_ids sections. Nothing to do. */
> +	if (symbols_shndx == -1 || idlist_shndx == -1) {
> +		err = 0;
> +		goto out;
> +	}
> +
> +	if (!gelf_getshdr(symscn, &shdr)) {
> +		elf_error("Failed to get ELF symbol table header");
> +		goto out;
> +	}
> +	nr_syms = shdr.sh_size / shdr.sh_entsize;
> +
> +	err = btf_encoder__collect_btf_funcs(encoder, &btf_funcs);
> +	if (err) {
> +		fprintf(stderr, "%s: failed to collect BTF funcs\n", __func__);
> +		goto out;
> +	}
> +
> +	/* First collect all kfunc set ranges.
> +	 *
> +	 * Note we choose not to sort these ranges and accept a linear
> +	 * search when doing lookups. Reasoning is that the number of
> +	 * sets is ~O(100) and not worth the additional code to optimize.
> +	 */
> +	for (i = 0; i < nr_syms; i++) {
> +		struct btf_kfunc_set_range range = {};
> +		const char *name;
> +		GElf_Sym sym;
> +
> +		if (!gelf_getsym(symbols, i, &sym)) {
> +			elf_error("Failed to get ELF symbol(%d)", i);
> +			goto out;
> +		}
> +
> +		if (sym.st_shndx != idlist_shndx)
> +			continue;
> +
> +		name = elf_strptr(elf, strtabidx, sym.st_name);
> +		if (!is_sym_kfunc_set(&sym, name, idlist, idlist_addr))
> +			continue;
> +
> +		range.start = sym.st_value;
> +		range.end = sym.st_value + sym.st_size;
> +		gobuffer__add(&btf_kfunc_ranges, &range, sizeof(range));
> +	}
> +
> +	/* Now inject BTF with kfunc decl tag for detected kfuncs */
> +	for (i = 0; i < nr_syms; i++) {
> +		const struct btf_kfunc_set_range *ranges;
> +		unsigned int ranges_cnt;
> +		char *func, *name;
> +		GElf_Sym sym;
> +		bool found;
> +		int err;
> +		int j;
> +
> +		if (!gelf_getsym(symbols, i, &sym)) {
> +			elf_error("Failed to get ELF symbol(%d)", i);
> +			goto out;
> +		}
> +
> +		if (sym.st_shndx != idlist_shndx)
> +			continue;
> +
> +		name = elf_strptr(elf, strtabidx, sym.st_name);
> +		func = get_func_name(name);
> +		if (!func)
> +			continue;
> +
> +		/* Check if function belongs to a kfunc set */
> +		ranges = gobuffer__entries(&btf_kfunc_ranges);
> +		ranges_cnt = gobuffer__nr_entries(&btf_kfunc_ranges);
> +		found = false;
> +		for (j = 0; j < ranges_cnt; j++) {
> +			size_t addr = sym.st_value;
> +
> +			if (ranges[j].start <= addr && addr < ranges[j].end) {
> +				found = true;
> +				break;
> +			}
> +		}
> +		if (!found) {
> +			free(func);
> +			continue;
> +		}
> +
> +		err = btf_encoder__tag_kfunc(encoder, &btf_funcs, func);
> +		if (err) {
> +			fprintf(stderr, "%s: failed to tag kfunc '%s'\n", __func__, func);
> +			free(func);
> +			goto out;
> +		}
> +		free(func);
> +	}
> +
> +	err = 0;
> +out:
> +	__gobuffer__delete(&btf_funcs);
> +	__gobuffer__delete(&btf_kfunc_ranges);
> +	if (elf)
> +		elf_end(elf);
> +	if (fd != -1)
> +		close(fd);
> +	return err;
> +}
> +
>  int btf_encoder__encode(struct btf_encoder *encoder)
>  {
> +	bool should_tag_kfuncs;
>  	int err;
>  
>  	/* for single-threaded case, saved funcs are added here */
> @@ -1377,6 +1739,15 @@ int btf_encoder__encode(struct btf_encoder *encoder)
>  	if (btf__type_cnt(encoder->btf) == 1)
>  		return 0;
>  
> +	/* Note vmlinux may already contain btf_decl_tag's for kfuncs. So
> +	 * take care to call this before btf_dedup().
> +	 */
> +	should_tag_kfuncs = encoder->tag_kfuncs && !encoder->skip_encoding_decl_tag;
> +	if (should_tag_kfuncs && btf_encoder__tag_kfuncs(encoder)) {
> +		fprintf(stderr, "%s: failed to tag kfuncs!\n", __func__);
> +		return -1;
> +	}
> +
>  	if (btf__dedup(encoder->btf, NULL)) {
>  		fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
>  		return -1;
> @@ -1660,6 +2031,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>  		encoder->force		 = conf_load->btf_encode_force;
>  		encoder->gen_floats	 = conf_load->btf_gen_floats;
>  		encoder->skip_encoding_vars = conf_load->skip_encoding_btf_vars;
> +		encoder->skip_encoding_decl_tag	 = conf_load->skip_encoding_btf_decl_tag;
>  		encoder->tag_kfuncs	 = conf_load->btf_decl_tag_kfuncs;
>  		encoder->verbose	 = verbose;
>  		encoder->has_index_type  = false;

