Return-Path: <bpf+bounces-60791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6437EADBF38
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 04:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 974831892AE2
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 02:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4352367A9;
	Tue, 17 Jun 2025 02:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EUQJQiNp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bNb0ZY0J"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0CF171C9;
	Tue, 17 Jun 2025 02:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750127564; cv=fail; b=HQGlLa8AfRxNMjnjKX+LnpVzyvYOw7MY+bXLaJh2fjhNugQ06vmawmEYPRuRIbzz5udySF1hzNYpOPHp5RUi+Z/1nXUwYW9HRauWwjCEMy/JxeGxFGSaphM1FNupviYMBauu6RZKBWQWZCVBHz2UsAhS25NelrxcbfYwl+RAQbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750127564; c=relaxed/simple;
	bh=HQsGtdJmrh3gDtrfGh2q+0cGnGeZujNraL4SfvJJ/wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h0NBnQXAUgVThmMPvDTPyh4juV2aMlYopPvwe+Rc57+Nwp4jSDqy9E9Ku1l+qoNtMM61U9muKoio0nqdpZciYJgEVUwtSXMXyca9V0pLIO6HMQhE7ZzGX+wUobvZJVsd7YCHaMaJ6KqPIkftFcJ9ptclxa3B10qUuSWvQkQgYA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EUQJQiNp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bNb0ZY0J; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GLPYgt030535;
	Tue, 17 Jun 2025 02:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=FQ+9pnOhGmp6asZ4lbBnmXF+jQ7kgmvWHxVyWfTdGi8=; b=
	EUQJQiNpYjyyrLFgdaPcwvrNu0CSAhVZvIwfK/iFqrvUF1+UpEIgjHgHoZaRUaMe
	EYIn21nnzhxDhpbQn79eznFxrsHoBzu91Y4KJWbRwx3Gpe2XsIIo9q69XgJP+B8G
	6abPElnyCX0CoeQR2EEAkHjYuAlyNUQslvk5JGjtWGwxhbpAE94MCoOFwjXgFIXL
	SZ34WTISJe1AGhGsUTmNC0x6+VeaOO4Ya0+85tzjagI6wOIJPQBU8OBniAbCOK4O
	g2ukQbQ23d/aF3O8o0C3OMaLTl8ZT/p/RARUUoq+3CW1vXQSbtBqohz1nPI+nmvt
	hgv6zpUl4A7qtmSUjMngfA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 479q8r3eht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 02:32:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55GN8x7W032490;
	Tue, 17 Jun 2025 02:32:01 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11012006.outbound.protection.outlook.com [40.93.200.6])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yh8nm3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 02:32:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0rf8WgUmnPL/sq6hyxg+cORH1htXmwvPo5OvTaTF/wqznBJWX3f928E/H7pYRxk3uvzUUpgjLpD73x4Sbj9Gwm1skXdWB0CzSyS/D7Er3ikI/ObcHgS+ydrgi7JwzWPgNJhttPlykY8CF0rUSAVsDEyPWf+TernYp2zFhzpMOdA1aoNSkbLJBtMVI9d8MFDGZW5sFRpVisZesJEtaXAfAaX5JFBrkjp6LIe6EkSNfQ7M4sN4Ro//PhotGc1mMHzR7h4fZTJObbK6FKZimI01CHHiaHz7qYrGzznQqccra7afsrsxmeJpeulhiGmuSPB7JepNC73hVGknhM4TYSWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQ+9pnOhGmp6asZ4lbBnmXF+jQ7kgmvWHxVyWfTdGi8=;
 b=XW9ptjebojk2OCdFxgeV0UBr+Vp0ytFMc/B9xSYPOu5pbkcNN9+WEqPr/MF6EtFDvZsvCu83GcpBTVBYmJ5qUbAdf/alfTk61cc9KAgbSk0LSgUATj8GY8m6oweALLTP0gLhKgVf8ZMclSGfattTkNCnn7IxYIX92wdcuKUo/snQiHEsnQheIdR/mzyHUyHE6ueYRlyRYGrRzn+rlhYSwsYp8V7U7ZfLgmwdJEu4kcUIvj8+lHuiDCdBU4FVD6fC/dkA7p4PDWcB1nGmwb7jxGeYoSOLuPVcENI5zkhzmo9rQ1J76DZtZnRIMFLQYjTVbnIuFSwLGg78tJxtm1f5aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQ+9pnOhGmp6asZ4lbBnmXF+jQ7kgmvWHxVyWfTdGi8=;
 b=bNb0ZY0J0RzHES5Z5pt4MBLTvbgyoDioJHg/rArryOtSMCt4+l3PafYSMlnMWIidXTHcvZHua3i3+EsdxzwNtosuNKa8NQAQDLxaLi95/FBPkm/K8WcolKHSH3dPn8VfJ20xULHLA4eBfPFJ5khqFDwcBy8+B+IR4uV4a7JQQrA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MN6PR10MB8048.namprd10.prod.outlook.com (2603:10b6:208:4f4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 02:31:57 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 02:31:57 +0000
Date: Tue, 17 Jun 2025 11:31:38 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Byungchul Park <byungchul@sk.com>, Jakub Kicinski <kuba@kernel.org>,
        willy@infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel_team@skhynix.com, ilias.apalodimas@linaro.org, hawk@kernel.org,
        akpm@linux-foundation.org, davem@davemloft.net,
        john.fastabend@gmail.com, andrew+netdev@lunn.ch,
        asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
        edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
        leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
        vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
        vishal.moola@gmail.com
Subject: netmem series needs some love and Acks from MM folks
Message-ID: <aFDTikg1W3Bz_s5E@hyeyoo>
References: <20250609043225.77229-1-byungchul@sk.com>
 <20250609043225.77229-2-byungchul@sk.com>
 <20250609123255.18f14000@kernel.org>
 <20250610013001.GA65598@system.software.com>
 <20250611185542.118230c1@kernel.org>
 <20250613011305.GA18998@system.software.com>
 <CAHS8izMsKaP66A1peCHEMxaqf0SV-O6uRQ9Q6MDNpnMbJ+XLUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMsKaP66A1peCHEMxaqf0SV-O6uRQ9Q6MDNpnMbJ+XLUA@mail.gmail.com>
X-ClientProxiedBy: SE2P216CA0134.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c7::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MN6PR10MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f4b4b44-510a-4cde-2543-08ddad472149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OU12M1BidVNCZXJ0RGg5NVc0dko1MllCS2tlV05oelk3b3FRRFN5dTZsejRr?=
 =?utf-8?B?MHN0Y2RZT1p3Y2V2WCtIMlJtQWMwQ1dxaFFXN0xZcVFNaVB2WDJRN2ZaS0V4?=
 =?utf-8?B?SmtLWEZJU1VUcHo1NlhWWnN3T2JwUkZMb2hteHlkekllSEtvdDltL1ZpcjZ0?=
 =?utf-8?B?aldCVGtDNTJHSUY4MzVXd1dLYW8zQ3RiSCtLSk1TRko1VEdjVHRIRkJpYUFX?=
 =?utf-8?B?UTFYM0Z0U0FtUlZDalgvOFZFYmt3R3NuTi94MUdzUmhyOTE4WUNRVkUveGkr?=
 =?utf-8?B?SVJBQTVPMU1nck1KMFdpUEJNanU2UnlML05kZm1TV09Xb2o1WG9QVGJHZEtP?=
 =?utf-8?B?QVcyQWRTbXQ1SDJhU2hIZ2J5b09RMzNSZlIxZ1N6RTJyYTU3ODhzaDRFbUtV?=
 =?utf-8?B?d0RzNnZTWjhFYXUrOS9ucU5GdzNmUkhtQWZnUWFvcUZsbHpnRmNobTRSMnpW?=
 =?utf-8?B?U1JmM1FCMDFyRklLa2ljUHJqckVLTitDN2dKQlFYT1pMalBUNnBjekY1SGxw?=
 =?utf-8?B?aldyaUY4aUk3M2RSQnlsTW1JV2ZkN2dJWkx5aU9GZ2wwRWRTNFRqUE1FNi83?=
 =?utf-8?B?RmpTOXZ4bzlZOERwdkJITGpKeVRnM29jM21NS2VqQmNSQ3hpRzkxQWxMcjB6?=
 =?utf-8?B?S3VuRkd2NjltY0J0K2FZcUNYUitoeFJLUGpoUURZdzE1b0NqY0t6RitRNC9z?=
 =?utf-8?B?QWhUVm9EcUFtWHQ3dHNsbVdBVllOWGhxeU9pbHAwVUpiNmRFcnFZVTZ1VUNs?=
 =?utf-8?B?eWxwU0J0NWhraE9rMiswOElzSG5WUTFqMDlieExYZEpMdzdScHZSOW53RVJ1?=
 =?utf-8?B?NWN0SXd1bk5QZm80SGV2TitpdWFQRWt2bHdtS2d2WkFSQ3l5Z3dzREF2dnUr?=
 =?utf-8?B?UTFEL0h4blVNZWFTQzFmaUg3SGl3WStOazJDTzIrb1dDZWxQNHlmc0RTQnpw?=
 =?utf-8?B?bXJ5b0NWSHdxczFTSGJSbFE4Zk1keUoxNHJVOHFFT2R6bXozZ01welhqQ1Ex?=
 =?utf-8?B?aFB4bGlIL2diUEQ1WFVqNGNxTUtYNzBhY3lQK1VraXRVU1JQc3Fxd2w4ZlBD?=
 =?utf-8?B?RVlHbHQrclpxWVc1RDlPR0FmL0p4SVJnU01mWHJuS1ozSXRUNlVVMC9HdzZC?=
 =?utf-8?B?NnhZLzFFRVdISTNqSXVkdmwyMFF4aGJ2YlUyQjJYOEFWdGNvN3JERE5oZTgy?=
 =?utf-8?B?K3BNQldLRytWbFo0QXRycVZSYXZGRHhyWXR4cFJ2cHNEWURESVZRdnU2NEYv?=
 =?utf-8?B?cTJQVXFBWkVOSGdNK095VU9lcHN2Rmg2UDNYaWZSMUNLOEJIazk2dldwSDhi?=
 =?utf-8?B?ckErNTEzLzZMMGhFL3c5aWhwcVhRNzRjNU1peXlXZHgwa0tTY1hjMG9iam5r?=
 =?utf-8?B?QXNja255NmxwbDhqc0gyaktFU2ZVTWRwN3lISHFINjdRWTFoNzg4ME1XYVJI?=
 =?utf-8?B?N0JEVittbzhwYUlLbG1SZWdLVmwyZ29WK2lSdjlFbDhwSmduakVWbWg5ZFFU?=
 =?utf-8?B?R204bUlYY0RMRGExVHZJOW11L2hNd2kwaXVNMk5DL1NHS3ZtMG1XMm1KcFBQ?=
 =?utf-8?B?dGpCdkNybUtJL0tEOWZEdnFJRFhQTkRZZ1lWYjgrNDFiNGRQYUxFd0VVdW5B?=
 =?utf-8?B?U05yTWRlU29vbVpzdytHVjFYaGRoZmFBQmJDNE1yQ241ckFZaTJnZjVsQ3hU?=
 =?utf-8?B?RjZzVWFsdG9KUDFzVDEzRHFhbDEyYjBVcHdKYS9zc0t5SGNPMlpzQ2thbjMr?=
 =?utf-8?B?Y2gxUmsrS3dwWlRMSEM1cnhNSzE0c3FRRUd1Q2NMcWl1eHJOSlJGdlhLYWtr?=
 =?utf-8?B?Z2dmVlhHL0xzb1MzWTNuekUxMlZYRnkvTGR6THlDT00zZlVOUExTWUN6b2Nr?=
 =?utf-8?B?RzhRYjh2d2JhVEY3OWhyYzI2dC9iOUtsTU5INEJNeEY5dEd3Rlo0SjJvaEZk?=
 =?utf-8?Q?hNcYfuxYQaM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlFMSHhXTUNuYXNQdjNKU01GUGFzTVFpVDM3bzRhc1NycXV5bGo5L1Jlc0FP?=
 =?utf-8?B?NVljcy9Td21NYTVDZUx3MFZzMXQ5NER3b2dUcXVRYlR0cG1ScHRMQ3ZvZE9l?=
 =?utf-8?B?TjJweTcwbGtLQ280dUlwOWxDTnJCa2V1SEJGWHFXYm5SM0Q3c1ZqYXI1ZjR1?=
 =?utf-8?B?d0F3bWFtQXpWKzdXSEJac1hVMHBabGJSZnhENCt3cStlRW5VMGhjZm1LY3pJ?=
 =?utf-8?B?Qml4UDRHdnRXNnhlVHREaW5KSk5Ld1ozREloVkYvOU9QQXcrYnVJVnVqakJa?=
 =?utf-8?B?ZXA2ajNydDBvVHh0czFVTHpMMWl3QXFZSk5mSXRvdTNEcTc1SHBLWUtMVG9S?=
 =?utf-8?B?MHhFUkF0cWluUzVvR1lPZnljWHB6V1crWERiUDFHTVVlTmNsVFJwZnZLYkZs?=
 =?utf-8?B?SmtreTBsYlAvY1g3czcwL1o2QlRVSnBYblFLb0t1Wng0NTZreXVzT29mbTBs?=
 =?utf-8?B?RTRPMUZydVdRVitLYnQ4TytueUhIYUdxeGJlRjNnMmNyRWVhUDIvOGY4MkU5?=
 =?utf-8?B?eVU0ZE4rNDdmaGhLZlFYcjZpaW0vcVU2YWRtNW5rcE9mNW1NeUhXWEthWm9a?=
 =?utf-8?B?b2pkbThoWi9oY2tkNTVwZjZ2UFFJa29EODFOWjRtL0ppa1RxalVaTkZmY0Mv?=
 =?utf-8?B?WFNIOE9CSzRJTXR5K0ZHTUw0alRUUHZVMDMrTVVCVkE1c242M3Bsc0RONVlm?=
 =?utf-8?B?eFUzTzdzYU5pOEV2Y2RQb0R6OXNVMFlabWRKdmhPSzEvYzNhT3ZsWGd2TVV4?=
 =?utf-8?B?VTBtWGRmZzN2ZmJKSlRHNWZVZzNtcktKSlVkb28yRVhLT05UbmpMeEJNODRV?=
 =?utf-8?B?YjVKTDBmajJZSndrMEFHQ2o5eXFNbWwzRFhDaXgySkIzZnhsajM4b3ByaDlt?=
 =?utf-8?B?UDFwTzRwMFJwMkJHVlJoR0tjbXZsRHpmNTZ4eDg1aWVvdmV4Vk5ZZEhJSVdP?=
 =?utf-8?B?cjZ3VkRQUllJbnp5b1pyOUtNV2E5ZWtYbStpOTJkMHo2YmFCMExjV0IwMXFq?=
 =?utf-8?B?c2tyL29qUzVUYVd2eThRRFRqZXhLVEtZZU9ScExkdWhzUDlreWViN3VjUWJo?=
 =?utf-8?B?S0ZaM28wbXFiZ3BjR1hFMmlPbHpnRWVWdzRnRThwWkZLOEpnNFZFSTVEaXp3?=
 =?utf-8?B?M3BJcGJWMDh2VTF2M0dBVDFBK2wyd3BFK29pNnhrMXNqemJmczY2ZnNkN3Fs?=
 =?utf-8?B?aVBWMm0rQkpjRzlJeUFnRmMxN1luUE1pdy91bjB2RFhmMHJFTDNlSE9VSTJx?=
 =?utf-8?B?enFoUDIyQUZvKzZKS3JmcmhSMStURGZaT1JKOHl3RVp5bmYvOGNEajc5Qlkv?=
 =?utf-8?B?d0dqY0pTN0JVQmlDaE1YLzVDUzJBOTJ6L3BuTkRYNG9rNHNxRXlkcEQ4NnRQ?=
 =?utf-8?B?KzhiYW8yZ2NJNjJhUjA1OWgwdy84M1pFZ1UraG95MU1pelFzYm9SZ3lyWkRV?=
 =?utf-8?B?cTNCUk1YVEJXQkdueU5qYzFQZWdjR2JxWnA2YUY1WDZsZmp1NnRncDlVUUNu?=
 =?utf-8?B?S0haSVlkTEZoemV0V0VPVXE0elNFcnN6YTNWRFFIZWtwUDhIZjN4WUl5aWdE?=
 =?utf-8?B?dWtURFJCZVRjY3lrU1MrZHN5NWMyOU1jczF4TUgvMFRGTWZUYlZIdXl0UkJS?=
 =?utf-8?B?OWxnR25TKzdMTERYcG1CelVQQlJSRm1zeXlOd1lNaEV6bnlhdUduSE5nNktR?=
 =?utf-8?B?WGVqTnhxYkpvRGZPUUlVaGFOYUJ4YXh1Ukx4UnlkQjZTdGNDei85WHFYdXVI?=
 =?utf-8?B?dWt4Tjl5a3NQR0l0WG5nbzVwM01FRHhZd2lhOVN6Q3JCc01wN0N0MFBlVUdV?=
 =?utf-8?B?Q1JxQXp1M01pZXpQZVVaWjdkWHJZWEo0a08zRTg1M2FqUUphc01laGpBcG1Q?=
 =?utf-8?B?SnV6d3ZsbXNzeTV0bXQwQ1pHZGtPNzVoZExWZkhmYkNmeFZiZmFlQW1OL2Rw?=
 =?utf-8?B?aUk4bVRoTGlBNWhPL2o3eXFhVFpwWWVXWTBsSW9EcnNyck9sZFV0SzlhemtE?=
 =?utf-8?B?RitWZk92eW5EQU9OQjJ0OWpiSUQ2QVN0MDNaaG8rdXhWVTA3dkJ0eHgwSDA3?=
 =?utf-8?B?NmJLQXVyUUtzNnVlVk84SlR3ZFh2WllabVpKRER6QjVBRzNmeUxIT3ZXalRy?=
 =?utf-8?Q?CofVz4JJZJfcq5rlHuJ99bJU0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	G0fEcVPWbJghWG1FxDeEWR7Elg6CNuR7O7oTkZSBxdWc5ukubDdi8i1Z49/IruH3Br9w+rOsJTrWXsFL2BX4fFOSCtDgvXgp7oUN0xEV0CnE5XSZHW/GKH8PT9Tw21VJa4KSaNR7+u1Ds5IJLfdM/eJmxKj3iTTOAHEQ+w/o8bYQCf92mElIoqlhQgORgqaJ69iGAjApbac9oWphsatN0eOLk2zFgboe3qBET7KciWpMR3RbfWdpJ9bRWJpEgV/3yhJCZbHOOeAG7MPkwuMR6R1pXAXRkE2oThYEnEA6Q2ZvKnuho8OlLVrIA+2uHWlyOma+pELeo+T9lmIfOBhsQ7SlqFQRW97Gk3VHy7LJlebzsdQWsa6R5+jytFDTE5OK1WwjRCvENvm2B0RzRNg4ROwvoTbJR+EP2l2LNs4TXBZj3FYSGlZUakVXKU2sNwfjzKypvOZrxuU4WiEP8TIFxjt9oUx+nedEF1+Q4RFB8vgrR5qmj94+JTcM+YJysq4TI2LfmbhEFnAFg9BbUHG/E0Wg6zVmf68ndM+dpUqwqd8/bg8/bJS1aj4ZsTU5GTwqXhTNKaDSd2TwyhmZ/JLharMaosEOSeqn4qabrZ6kZfc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4b4b44-510a-4cde-2543-08ddad472149
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 02:31:57.1497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TBqiKBv8oEZyB+yXMYfwxnY45bXpMpGVXZoYLgJlWhGeGb5GgEKB3HPwf1C9M48j8FK4zwGLXWIGetQAG0oHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506170020
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDAyMCBTYWx0ZWRfXyv6uoUCI0Zn4 rY4JWvOIG9aRqdfRd12f3p0hV7GjrqlRcnscKBsGedkuHfVK8MUcd34fkwbuAC5hRo7SnjDg4c0 mz/E7e84X0iwlRf6ch5RYiIFIhaz3Ma0RBsq0HzzW2GYpzfUlog6q3dLjnMvlFBx0ed4ttLhrxZ
 EfDK+cwR/3fzhZe028L+bxTbz8uk6TJ4jdVrGtIMy23EC673nWd6xi8TQxUVsU1kRqDLmgGnuXX onx04JOVylpqdPPjv+BP5UwRn+MEcURgwaEJ0EzFi/RQxnmkj/Gn3BrLUq8BeKarxaecwy1csRE OH0VpIO08su60UtwVoSokCun6lvTxW4Nq/M/CbW/Bw2U8GKzdaPldeXrUIqMQd3oEnR4c93aPGX
 fb3FMq2EOLiknzEeGWkDLOQi/WFw/GepADv+ouiAKVCyI5uaI/9aPo00fTfsqTZoaFEBjiXo
X-Proofpoint-GUID: m6Nfr8p1xH9YmpxNkweSKxqLXJGnQpv7
X-Proofpoint-ORIG-GUID: m6Nfr8p1xH9YmpxNkweSKxqLXJGnQpv7
X-Authority-Analysis: v=2.4 cv=dvLbC0g4 c=1 sm=1 tr=0 ts=6850d3a2 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=ph6IYJdgAAAA:8 a=TwVAqxVyhHmQQekKjaMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ty6LBwuTSqq6QlXLCppH:22

On Fri, Jun 13, 2025 at 07:19:07PM -0700, Mina Almasry wrote:
> On Thu, Jun 12, 2025 at 6:13 PM Byungchul Park <byungchul@sk.com> wrote:
> >
> > On Wed, Jun 11, 2025 at 06:55:42PM -0700, Jakub Kicinski wrote:
> > > On Tue, 10 Jun 2025 10:30:01 +0900 Byungchul Park wrote:
> > > > > What's the intended relation between the types?
> > > >
> > > > One thing I'm trying to achieve is to remove pp fields from struct page,
> > > > and make network code use struct netmem_desc { pp fields; } instead of
> > > > sturc page for that purpose.
> > > >
> > > > The reason why I union'ed it with the existing pp fields in struct
> > > > net_iov *temporarily* for now is, to fade out the existing pp fields
> > > > from struct net_iov so as to make the final form like:
> > >
> > > I see, I may have mixed up the complaints there. I thought the effort
> > > was also about removing the need for the ref count. And Rx is
> > > relatively light on use of ref counting.
> > >
> > > > > netmem_ref exists to clearly indicate that memory may not be readable.
> > > > > Majority of memory we expect to allocate from page pool must be
> > > > > kernel-readable. What's the plan for reading the "single pointer"
> > > > > memory within the kernel?
> > > > >
> > > > > I think you're approaching this problem from the easiest and least
> > > >
> > > > No, I've never looked for the easiest way.  My bad if there are a better
> > > > way to achieve it.  What would you recommend?
> > >
> > > Sorry, I don't mean that the approach you took is the easiest way out.
> > > I meant that between Rx and Tx handling Rx is the easier part because
> > > we already have the suitable abstraction. It's true that we use more
> > > fields in page struct on Rx, but I thought Tx is also more urgent
> > > as there are open reports for networking taking references on slab
> > > pages.
> > >
> > > In any case, please make sure you maintain clear separation between
> > > readable and unreadable memory in the code you produce.
> >
> > Do you mean the current patches do not?  If yes, please point out one
> > as example, which would be helpful to extract action items.
> >
> 
> I think one thing we could do to improve separation between readable
> (pages/netmem_desc) and unreadable (net_iov) is to remove the struct
> netmem_desc field inside the net_iov, and instead just duplicate the
> pp/pp_ref_count/etc fields. The current code gives off the impression
> that net_iov may be a container of netmem_desc which is not really
> accurate.
> 
> But I don't think that's a major blocker. I think maybe the real issue
> is that there are no reviews from any mm maintainers?

Let's try changing the subject to draw some attention from MM people :)

> So I'm not 100%
> sure this is in line with their memdesc plans. I think probably
> patches 2->8 are generic netmem-ifications that are good to merge
> anyway, but I would say patch 1 and 9 need a reviewed by from someone
> on the mm side. Just my 2 cents.

As someone who worked on the zpdesc series, I think it is pretty much
in line with the memdesc plans.

I mean, it does differ a bit from the initial idea of generalizing it as
"bump" allocator, but overall, it's still aligned with the memdesc
plans, and looks like a starting point, IMHO.

> Btw, this series has been marked as changes requested on patchwork, so
> it is in need of a respin one way or another:

-- 
Cheers,
Harry / Hyeonggon

