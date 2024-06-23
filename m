Return-Path: <bpf+bounces-32855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209D5913DA1
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 21:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9E9228308C
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 19:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F16F1836F0;
	Sun, 23 Jun 2024 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OZZdQOfj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B0O/eNZh"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9DF14884C
	for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 19:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719169515; cv=fail; b=JLnjRbn4Cd4vCCZgEuyLmZOaIDvbASMikJbda87EhnsYR/DWrC59gu1vUZdTpbjvj9Cxm15j03xPrZ8GZ4xPcfODXEy9F44kIas7FRr1pxeFZClYwG7jsxr7+9E/2W250NZfKUC3bKPKI6SihS/vlwER4IJcY+D318QD9EonNqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719169515; c=relaxed/simple;
	bh=k400rJ72m79a+LIZEC8ekF9KbXLOMiIWeC2z/TfiWGo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EPQP1Vvxo5y182oahpKxWgDP7CEisaIMasgqSLu04vrm13DCNIVZhDM5naWRlYk9AEcueKgdq7/0Bh9TARAc8omMxAdGbebn4nRiIFoCMagCy0D4BEGYfYuxYbUkC3Zu5AbNAeXB4CsT8+4/aZmJ3YEjmiLYxfJEH67L62I/wT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OZZdQOfj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B0O/eNZh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45NJ38TI031579;
	Sun, 23 Jun 2024 19:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=iyibaByb5+uA6xBKBq9hFG5ngxdx/RCuprz7YZeMWtM=; b=
	OZZdQOfjCrLiNb89xG5YCmFM1otyRH1y0JTHtkPhP/yBKEx2s7pw5SSNiTIwB6n6
	KbD3a9DgdFvH1QhQZI51mrx5YJC+AhiNkja9DfIw/WnBtWBgHfGhiotd8jLuL2yX
	ODCbP5dz8W+f7q+sZz9LqWxgNU2HIaQBvSoz/E7GxOfdXNLCGvUEcZJNWIM5Bugr
	3r7mW7RWqyoBC9Ats6ESCKfOx4rGTVNjqh6gEI8IokMYYasDqBAaWSQwd8cM6JGv
	4GHsaRlJ8fv4KrBv4KV5OuYCoD9kEcZu9VZfxwi4/7RcFJuSDfhbrljtNt2XiI9U
	Tt0SfY6CfYyAE9FA/o56bg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnd29ekx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Jun 2024 19:04:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45NF1wi9017801;
	Sun, 23 Jun 2024 19:04:18 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn25587d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Jun 2024 19:04:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXFr35J7fuE6Y95Tmi/m2tOYgjx/fxcoc1IoOdyK6gyVAK19txAH+WOEgLp50KEVDF1E2fX7nQNzHZwi7iWn0wuV/Nwriq1USIAf85ip8Yv5eqL5dpla+52NPVT7G3LinI0tlj8rj4T/xIK1QohhTfa3/R6trMk2Ns7lGbxm7zdiH2itjh4XFJCM3WtKC6AEDspoWgy8MjAiDNr/QbG3co8MDTQ1Y34XgVW/MeudBjECqTyq4bLlEXiOVBqMvZvwXyoOSxdifGwatqtoyfIp3DGusNN8RZXoj7ofHZ2Skxu63s8PEgZTIPFnm/AcoM/dAklgVi81rhf0b32hp/pZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iyibaByb5+uA6xBKBq9hFG5ngxdx/RCuprz7YZeMWtM=;
 b=Ejwl3E/kKp1vIH9vpCPHy4ILGPpwZMbWqkr1sRQH0BzMAvtVQRcN3QPr53+UBd7eCxnhaPrO+4dmkGROGDJPhvAHo3qU32PueraEAb8QZzzGpa8hHktCyIBOBug7q6+ceE1kYLZ4ZEg9ZAwM/ul4ak03li9ZgDOCVgdAGaU+j0tdx+/do2YOXHSg9x4H6TLajkFW0lzdOFPKGfMplBgSNqdiPpvUAVkYa/HP9ehdzKpBGnVRk8oCfrZavz8q7LdwR6ZVV1fIAswxZt+DOjcJOJtG6H0thniVmI2BVHQuMHdXiV9hG+6oOi6QBuaHKQSelZ47sw+HphsJiqojwop21Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iyibaByb5+uA6xBKBq9hFG5ngxdx/RCuprz7YZeMWtM=;
 b=B0O/eNZhONItj/t203ya8kwqcRESvcfOMYT3udw4ZEafPD5e0Qh0tOsrwakL7Sxa6221Z28SNvbJp3bB3GV3/3o0DV6mmSBmcKTsFSdmN+cicw3f7RDMcbRxNfAR6HWMmK/ECF2nxqc44ruY5+xUiVVsPrdfi6uZItDlrqN9NzI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB6352.namprd10.prod.outlook.com (2603:10b6:a03:47a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Sun, 23 Jun
 2024 19:04:14 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7698.025; Sun, 23 Jun 2024
 19:04:12 +0000
Message-ID: <9cfd00b0-8a7d-4c38-9eaf-3a529ffa5ca1@oracle.com>
Date: Sun, 23 Jun 2024 20:04:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: fix build when
 CONFIG_DEBUG_INFO_BTF[_MODULES] is undefined
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor
 <nathan@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Kui-Feng Lee <thinker.li@gmail.com>,
        Benjamin Tissoires
 <bentiss@kernel.org>,
        Geliang Tang <tanggeliang@kylinos.cn>, bpf <bpf@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20240623135224.27981-1-alan.maguire@oracle.com>
 <CAADnVQJ_s3FyRo3J3cNTETd3ZSFsFdTvxWy+HnRDzT9LuKrSSA@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQJ_s3FyRo3J3cNTETd3ZSFsFdTvxWy+HnRDzT9LuKrSSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0121.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB6352:EE_
X-MS-Office365-Filtering-Correlation-Id: d58c0778-dd33-40e2-6515-08dc93b74518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QWsvM1g3SWx0RzJhTndtZWRHSnhodVJ1cHQ3K3htcHhFY2FxVk1JZ0E0K3pt?=
 =?utf-8?B?eFJicEw4M1JEQmx1cXBYUUhrMi9hRmhydnljckloWTN1TjFaOVF1YVZiMFd3?=
 =?utf-8?B?MEpVTSt1Rm1EVDdTZ0ZFQis4STdxWUVvdGorSTRsVGJqcWlnOTBrWGFYd1hj?=
 =?utf-8?B?QTMrV0xwYitCZnBFVEl1clNvbjNlWm9weDluQjIxSGJScHFsb0lsNTdpaFUr?=
 =?utf-8?B?RzBoNlNYMkM0Z0NyRzNYQWFXY29VdFBuckpEd0hTQzNBRFNUeEM2MGJIN3hX?=
 =?utf-8?B?OExiZllkMFNaV0dvUnIvS1FnbjhDcVNqN3AzdTVNUVpRekM4OGVUY3pqYkd0?=
 =?utf-8?B?SEJSWm0vbklCemcyM3VGemthVHFQWnJkbDJRREp0T2UwaXhyRUVsMDNCVFV4?=
 =?utf-8?B?WkM1TU5mNTQ3Z3RBZTdyZjc3bmlnZXhWZENZYStOSDg2N0pLYkRnWnhTcWJ1?=
 =?utf-8?B?aHlTWWpPNFFRam5PbW5sQWtabjFHdTB3MWNaSVp2ZjkwR2NOdVpzOFFGN3Fw?=
 =?utf-8?B?Q05tc3E3clVCWnpVejR2S3Nod2Fvc2ozR2dyUnFjMXNBM1VacUxZV2NLandI?=
 =?utf-8?B?LzFpeDlmcVRFOHczMmpGdUp2SUJMdEdNMkZYMWRzU1NiVkpsK3U0Q2daVGxm?=
 =?utf-8?B?L1V2UlkxdUlMaXpJdGJqQWs4Z2RmdUdJUTNOWFNZTkpnMlArRTRuSlhIWkpR?=
 =?utf-8?B?OFhzaDgxdHJabVowRlJwS2poRnZIRDJzc1dGT2ZkMEZqNGdnU0VZeU1tU0Fv?=
 =?utf-8?B?QzVOaWZHemthZFV5SCt4cnZ2c045dzNNMDI4K0xLeHhCU01CemhPRFpPa1o1?=
 =?utf-8?B?WVJSRGRlUnpCYzUweFcrbGdDVXNja1V0TUJLRVdQNkFtWld5a202NXNFdmdJ?=
 =?utf-8?B?cytzVkw3U2FpOGNUMEIyV096MWRYVEcvcVdKaitmdXBLc3BxTXBzWVFlZVJm?=
 =?utf-8?B?LzdkMjZmbmRCbFdJVnJObWIxUFRzTGIxdzhVYVoyMUV5dUtLaDdwUlRaNEpU?=
 =?utf-8?B?OTYyQllvUyszNm9uOGpTTGJ4T3ZiT1FKRkJUbFowNzNENFlDYkhtMFJUMFdj?=
 =?utf-8?B?L2NKbmZXU0R5SG9GeGk3cVFMZlZIaVBHMVVHcUJpd0c0K0puZEFXbGZrUCtp?=
 =?utf-8?B?bVNjR2xtUGNhRSt4SE1pR0Z0T3FlWnRwMEZXWGpkSVlINUd5MUEwZTNUa0s4?=
 =?utf-8?B?eERLaUpsVlArWG5kaGxsQm9PUVA4cnpaVEM1SElhNGU5SUJURGJRZVhtWWp1?=
 =?utf-8?B?MGVsbXZPdnZ1TjNkSmp6bXo1VmtwdVBLVUh2bTBrRDVlTGF1SytyOVpJQUc3?=
 =?utf-8?B?WkpDdy8rQmhnd0R2RWUrWkZSYjJ1UlZudzZVQ09kd3g0azBmLzJMb3UrQTdD?=
 =?utf-8?B?YTJtaXpkaDRuN1BnR25uSGJnQXBoZnVtUWMzbUtZUVRrNTFJNi9xdm93RTFp?=
 =?utf-8?B?QWpkWmNDMFdhNno2bC85aHNaeEVjRFRLR2pzZmtBOXVMRm43MnZDMUNHU0Rq?=
 =?utf-8?B?Z2d5QkptM1ZOcUs0VXpYcFNGSGRCQ0R4ZklmTUxHY1k4ejh5ZHl4andSeFE0?=
 =?utf-8?B?QWpvZksrSUo0dEZFaW1PdnBNWEhvQ2c0YkZXT24vbDJZUzcvUFZZTENtbW5X?=
 =?utf-8?B?NFlEd0dGR2g0WDlHeFpaUm1tNjlKR3IyTXg1ek1zTkhsK28zZWt4VUtuS3lk?=
 =?utf-8?B?NjRJNzRWR3ZkSy9wajBuYmNFdlZUbW1uZnJiZzNjT3pqdXBrcTR0dnV3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NkdlTUJOdHhIbnJmbmpnUVhVczBoSStJQ1hjWC9zaExhL0tPZ3gzVXVHYndP?=
 =?utf-8?B?cTAxUUsrdDl2ZDFsTTdkc2lTMmVnN2EvNE9iejYrSXhzdkZTdmwwOVdDc0Rv?=
 =?utf-8?B?OHl3WkU5aUh0aDE0My9DMk9waXBrdTJUaEFjQjJqRHprVHZrRGVaSGVPZU0w?=
 =?utf-8?B?Wm1MVXBKSHRZT3dESmt3WStUU2I2S0Y5MktVWUJjbW5md3oyblhUMVo5QnBt?=
 =?utf-8?B?SHFrR3VNT215QnlTL0hWbFNYYk1xL3RFd2g4YU5MR1B5TFpoeThkMUYvU2hQ?=
 =?utf-8?B?WEdYTXNRY1hTLzFhNDNkallHVzJhSXJycFJVTkdzWWxBdEl2b2hScVdadWUr?=
 =?utf-8?B?S3k5M2I0dkdoNmxHR29HUEExVmk4THlzWXdIZkFuYUhOT1kvaG5HYlF6Ni9M?=
 =?utf-8?B?QUVDZDNKakhLSFZVSnFGL3JRN1FpNzFhZktVL2xDcnVMM0hLWlIrQU4rbDhG?=
 =?utf-8?B?ZkYwQW1zUWViamFacWNSRmJId2lVQ09iRURoWWVmQjlBOEZiaWtQb0k2dld5?=
 =?utf-8?B?QUdrOTI0NzB0NWdvQUNRWGlqQ2JIWCtTeDQ2Vkg2eWpUM1lYOVNYN0lYYUkw?=
 =?utf-8?B?NXU4cC9nZWd3MmJzZCtYRFNhdzBUU1doNFBodlJXdVdFclc3VGxXZ3RiV2NF?=
 =?utf-8?B?dlpRNzVVaTl6cXBmQlRDa0gwcngxUlFCMFQvK2lQQlBwcFYzaWdjd25TNldj?=
 =?utf-8?B?WEhnZzlVV0VacGdmanAybTRWRzNwcys1d0F1OXMxUExCeEF3KzZrQ2R1Zmlr?=
 =?utf-8?B?U09WOUg4cHJrd00rdkEzYk9GNlkxV1djWlZMUlNpTjVxMHIvUmpoUXI0M0NT?=
 =?utf-8?B?RUZhWDVvK0prQjNZaHgxbzltdnZmeWtrUzdiK3RUL3h5cVg2cVlsdk9qL0E0?=
 =?utf-8?B?TGxWcG5FKzFzOUZGbnVpelhjY0NYRDZtMGpXeFY4WXZad3FGbUNZUjZqUG5r?=
 =?utf-8?B?YmRQSTZBSVZXUmpUc0lyczZ4MXZmZkpvUStBNDRKYy95eVNselJMMHo1MFQy?=
 =?utf-8?B?THJ1LzBoZStCVjRKb2pmKzcyZjkvNDhMSkxwaytiSUI4alUzOS9CcWQ3bnlt?=
 =?utf-8?B?cnFnbW9CWmRZaG1PSTRZckE0VXlJeTRTSG13VUxZMnQrWktieVYzVE41eFB0?=
 =?utf-8?B?d2w0ZXdiWjU2ZTMxVG5IWlRNZGJxNXpXN09WUGxyQnM3S0VFTE84dFRYQ1BB?=
 =?utf-8?B?eG9uVlJnbVFyTFErQW5uZVFqY0daZ0ZRam9YT1U2QlNmb0hwS0VEZVNTZlNu?=
 =?utf-8?B?dFl6U3BldktwVXR4QmNDa211b3BjS2tlUmdFSEhTeWphV2tCK2dQQlhTTHh1?=
 =?utf-8?B?YTZCSGZsYTNkUjB0WmRzVVdCQlVWMUhpZUd5YzI4TXdsVFpoYlZrcW1qZDRa?=
 =?utf-8?B?ZlRIaloyV1dlSHdCaEg5ZHlUNG9vcVAxV1lpY0RJVGY2d0FEMUVyQXRmOUlP?=
 =?utf-8?B?ell2NTdpTVI2RmoxT0N4ZGIxRXpLOHdTekw1WlZGaUVPUXFiaHljeGNHYjVK?=
 =?utf-8?B?T3pMNXR2UFZzTzkvVVdrYnRCcGRQT05XRE5GdnFJbk9mamR3N0xRMDM3ZDQ1?=
 =?utf-8?B?a2ZDQjJDM1pzSGpUSXZNaUZ0M1lCWVVXZDhPUVpDV0pPVy9WdFd6NGcvZ0N4?=
 =?utf-8?B?ZC9KbHc0ellPaWdwWXlabDkzeEZweWI4OGJsdGFEUVp5YXY0ZzNWK2ozbzdT?=
 =?utf-8?B?Qllka2ZLclBxejNwZHpDbkNBR3VKMGxaTXNJamtmUkVvR0RCdjR4aVpJZHo3?=
 =?utf-8?B?dUM1YjNKTWt6NlVLYzQ1SWRCWnhYTHhiK0lKQXo0Uy9wNzcvKzcrK2Q5MXRJ?=
 =?utf-8?B?ZnVhN2FxM2RRLytTd1BzUDFYTEI1WExKVjRIVDE2aHhsK2d6QlR0Vld0VCt4?=
 =?utf-8?B?SGx5TDE3cVV5YUJNTGNFd3VuMTJQTE9jQVBLTkZHd0hnNUxTZDU0TndNNVd0?=
 =?utf-8?B?amtTSDgvTEtpQy9FR1hLbmtMZjBCc21BMjhMYkdBRE43OWRWZXRxTXBKM1Ro?=
 =?utf-8?B?a05kVVYxWklKR3lNcWIvQVhGdUJ3UkVmMnVSbkRRVXJlRGpYNC9wZHdYQW82?=
 =?utf-8?B?Vk9Sd3FJdVp4MzVNQ0NCL0ZqcGpKTUk3RUx1Z1VkQlE2NUROVExNR2RyTlc2?=
 =?utf-8?B?TWxsbTZrRHZLeGFvR2hIVFJaRVI1Ukk4aGpUcXhDYmJDTjR0Q2ttLytVM21V?=
 =?utf-8?Q?QSElhvAP1h56BJ2ca1qGFec=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hTOuy5Dcbe0IVqiw7jtWq4lMLjCOYUpW51fWo2Nq3H4Qg2inuf2nmEG35PXRxvTfbf/LDDoQQZVjUgl7fZbIM8iybr50eZEqEqUvDqy6hwkCTmztYTqfnAIURcEmwVbu1xzKIfhRDTuYitMqHDxoC8z+QRhekincslYMCBAw2JGeOiTMmbZ+6RU7kHywDJ2w/QTh8kiENJ555irn4Q7mBq+EayoGeJ1vwyNEr7tNuoD4/gnweIyLyXv/2H47GiNCz/WXytoaDKk8t1wINbjgicvJxu6UgWNOeJMLQFSvIRCaFBr5oQ0Kn9Vdt54lblRQzlB+dRrnFp8ZPpzaNMcBADgARS4r1On1qrcUY+oonL8tv2istxxzikzhmJZQrqS61KpouYRsQ8deFTkjQVffTCR0ThLf+kHTWhdgA8USlcTuthS1VUzCdeMWY5WgOm3iNHdDHL6ONIp+Kv9Bf2uT0Kbh9BWkiXuVvcMG70MttDrUKTWErhSrjtKzftz2NoEs15YF6Pty40RAQ5RccfqLSVwqPR/kIsODZEWVgZ2XID0aoiTrcDapsAERQqE1rXf+my/8x6IRCLYAdxFREolOCD0aUszGZu33W6V5qWoCKrA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58c0778-dd33-40e2-6515-08dc93b74518
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2024 19:04:12.8946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XW0MqhZ3jeDsyoBmBs3LYe5T0RMVXvOovu//09h0v/A5WCSBSp70K7xc7U3BECqQRpL6n4v3BSh3gW8RMGgytg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6352
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-23_11,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406230154
X-Proofpoint-ORIG-GUID: tvtLKvZ8SPbaqFs7udDbDHppnXogiHaq
X-Proofpoint-GUID: tvtLKvZ8SPbaqFs7udDbDHppnXogiHaq

On 23/06/2024 15:35, Alexei Starovoitov wrote:
> On Sun, Jun 23, 2024 at 6:52 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> Kernel test robot reports that kernel build fails with
>> resilient split BTF changes.
>>
>> Examining the associated config and code we see that
>> btf_relocate_id() is defined under CONFIG_DEBUG_INFO_BTF_MODULES.
>> Moving it outside the #ifdef solves the issue.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202406221742.d2srFLVI-lkp@intel.com/
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  kernel/bpf/btf.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>> index 8e12cb80ba73..4ff11779699e 100644
>> --- a/kernel/bpf/btf.c
>> +++ b/kernel/bpf/btf.c
>> @@ -6185,8 +6185,6 @@ struct btf *btf_parse_vmlinux(void)
>>         return btf;
>>  }
>>
>> -#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>> -
>>  /* If .BTF_ids section was created with distilled base BTF, both base and
>>   * split BTF ids will need to be mapped to actual base/split ids for
>>   * BTF now that it has been relocated.
>> @@ -6198,6 +6196,8 @@ static __u32 btf_relocate_id(const struct btf *btf, __u32 id)
>>         return btf->base_id_map[id];
>>  }
>>
>> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>> +
> 
> It doesn't fix it all. The 32 build is still failing:
> 
> ../kernel/bpf/btf.c: In function ‘btf_populate_kfunc_set’:
> -../kernel/bpf/btf.c:8251:36: error: implicit declaration of function
> ‘btf_relocate_id’; did you mean ‘btf_relocate’?
> [-Wimplicit-function-declaration]
> - 8251 |                 set->pairs[i].id = btf_relocate_id(btf,
> set->pairs[i].id);
> -      |                                    ^~~~~~~~~~~~~~~
> -      |                                    btf_relocate
> -
> 
> See build_32, build_clang, build_allmod failures in CI:
> https://patchwork.kernel.org/project/netdevbpf/patch/20240623135224.27981-1-alan.maguire@oracle.com/

I've been trying to reproduce this with no success I'm afraid. I may be
misreading but it appears that the diff from baseline to new build is
actually telling us the btf_relocate_id() issues went away

https://netdev.bots.linux.dev/static/nipa/864622/13708618/build_clang/stderr

shows (note the "-" in the diffs preceding the btf_relocate_id()
complaints):

New errors added
--- /tmp/tmp.tLVKGCnz0N	2024-06-23 07:09:50.097720906 -0700
+++ /tmp/tmp.5jUDaRbbAY	2024-06-23 07:10:36.751715396 -0700
@@ -9,24 +9,846 @@
-../kernel/bpf/btf.c:8251:22: error: call to undeclared function
'btf_relocate_id'; ISO C99 and later do not support implicit function
declarations [-Wimplicit-function-declaration]
- 8251 |                 set->pairs[i].id = btf_relocate_id(btf,
set->pairs[i].id);
-      |                                    ^
-../kernel/bpf/btf.c:8251:22: note: did you mean 'btf_relocate'?
-../include/linux/btf.h:556:5: note: 'btf_relocate' declared here
-  556 | int btf_relocate(struct btf *btf, const struct btf *base_btf,
__u32 **map_ids);
-      |     ^
-../kernel/bpf/btf.c:8376:37: error: call to undeclared function
'btf_relocate_id'; ISO C99 and later do not support implicit function
declarations [-Wimplicit-function-declaration]
- 8376 |                 ret = btf_check_kfunc_protos(btf,
btf_relocate_id(btf, kset->set->pairs[i].id),
-      |                                                   ^
-../kernel/bpf/btf.c:8440:17: error: call to undeclared function
'btf_relocate_id'; ISO C99 and later do not support implicit function
declarations [-Wimplicit-function-declaration]
- 8440 |                 dtor_btf_id = btf_relocate_id(btf,
dtors[i].kfunc_btf_id);
-      |                               ^
-../kernel/bpf/btf.c:8529:26: error: call to undeclared function
'btf_relocate_id'; ISO C99 and later do not support implicit function
declarations [-Wimplicit-function-declaration]
- 8529 |                 tab->dtors[i].btf_id = btf_relocate_id(btf,
tab->dtors[i].btf_id);
-      |                                        ^
-4 errors generated.
-make[5]: *** [../kernel/bpf/Makefile:60: kernel/bpf/btf.o] Error 1
-make[4]: *** [../scripts/Makefile.build:485: kernel/bpf] Error 2
-make[3]: *** [../scripts/Makefile.build:485: kernel] Error 2
-make[3]: *** Waiting for unfinished jobs....
-make[2]: *** [/home/nipa/bpf-next/wt-0/Makefile:1934: .] Error 2
-make[1]: *** [/home/nipa/bpf-next/wt-0/Makefile:240: __sub-make] Error 2
-make: *** [Makefile:240: __sub-make] Error 2
+WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
+WARNING: modpost: missing MODULE_DESCRIPTION() in
arch/x86/kernel/cpu/mce/mce-inject.o
+WARNING: modpost: missing MODULE_DESCRIPTION() in
arch/x86/mm/testmmiotrace.o
+WARNING: modpost: missing MODULE_DESCRIPTION() in
arch/x86/crypto/crc32-pclmul.o
+WARNING: modpost: missing MODULE_DESCRIPTION() in
arch/x86/crypto/curve25519-x86_64.o

...

...and looking at

https://github.com/linux-netdev/nipa/blob/main/tests/patch/build_32bit/build_32bit.sh

...that appears to be a diff between old and new build logs. The new
issues all appear to be missing module license complaints in an
allmodconfig build.

I did find another issue in tools/lib/bpf/btf_relocate.c when compiling
with clang that I'll send a patch for, and there's an existing issue in
btf.c that generates a warning:

tools/testing/selftests/kvm/settings: warning: ignored by one of the
.gitignore files
../kernel/bpf/btf.c: In function ‘btf_seq_show’:
../kernel/bpf/btf.c:7544:29: warning: function ‘btf_seq_show’ might be a
candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
 7544 |         seq_vprintf((struct seq_file *)show->target, fmt, args);
      |                             ^~~~~~~~
../kernel/bpf/btf.c: In function ‘btf_snprintf_show’:
../kernel/bpf/btf.c:7581:9: warning: function ‘btf_snprintf_show’ might
be a candidate for ‘gnu_printf’ format attribute
[-Wsuggest-attribute=format]
 7581 |         len = vsnprintf(show->target, ssnprintf->len_left, fmt,
args);
      |         ^~~


...but I can't see how this fix is still causing failures in finding
btf_relocate_id(). There may be something I'm missing here of course.
Thanks!

Alan

