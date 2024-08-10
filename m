Return-Path: <bpf+bounces-36829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 286A294DC04
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 11:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3763B1C210F3
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 09:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B5314E2C0;
	Sat, 10 Aug 2024 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="osgfKYkM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xYt7Jf8D"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9024A142E77
	for <bpf@vger.kernel.org>; Sat, 10 Aug 2024 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723282675; cv=fail; b=jGJLj/795QsxjXutO+YnHpMFr9F866vvyM22JFQKfIs1c7NBGyrcuDJkoeGn8tcmDFvXlDVAO9XIyYwye6yzCBRXw/RY2DofKZH+sL5dU8lFZ+mOZhG4MjGyKh8oZUoCTr3TYRO6F4CrVf7UEpRK4knhcSAbAua/8hXvCxgOS5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723282675; c=relaxed/simple;
	bh=eTyplfC15Wr8c9hISZAU86x9KzFe7DD/eTcqK5aB9P8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X+LaF0BfH2574PWrplxTG6VLOceelEGRKvi6tlnqFJg1xRei+IFY20lvNrMUFPR6SEXcqaNsCe6Er5hsyQ7aZo47pKM+sIiYe2DM+wJpEQQMlLRGhmV8/iazyGrmrV6SbzZQr73ECI2YLkifKTJ/eTq3Zr5rQajfgJL5rWS6Jmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=osgfKYkM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xYt7Jf8D; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47A3MjdT010459;
	Sat, 10 Aug 2024 09:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=5M6d0ctx8+W+xVknMiDZWcKsepQB7JklfRhN8P5+1BQ=; b=
	osgfKYkMTQpqzKby/+ZghHaTeCgnEl/zdVuJviDjtH7K1cBVnbT8OocX+IqflR1L
	ew6hm5mlY/0eT2eA4cJaiBBDsLksQDSZgCq6LThw25wjh+vkdLwJFrdKTymNfufd
	JVnit31Ym8YYJDNJpgrJdIVpQ8SOfiy3mHE22z1GSpt1R7wXokXexWCqcKB14rcU
	xpyNubmNDtVQvafsoIoMGPcR6oC/yCuTuhcecWEbIpAIg/62t94SC5vATqDceTcF
	nx2Jy5O/yFiEFrgScm/aG0+aabpaefI3oxAbGFxhjZq8Z8OQucvEmUseNHebcZuB
	ENhEbY7JClnEVepkCTVFag==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x08cg75h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 Aug 2024 09:37:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47A6AwkX017746;
	Sat, 10 Aug 2024 09:37:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn6f731-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 10 Aug 2024 09:37:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8zNGvXyjMLET/Praft56bmOO4a8Kd8eGAMgyepPob4nNRz1ICihrWgLCqI+OZiS8CfKdURp3dqKOVc95JGNYTZ+BO7khjWhbqHbHYwMvta3mpEoSvRYU0rLT4u2k/jOU10V/BALIgk8C+4QunzBNw0/GRLOUUekcGhk6HnZUchxWw/TYot2vzcMt0zVr5kLXVrbE/83MECN25dptMBWJQMJjKgGWY6puvoA9nV+/wVFiKWGh0NK0yL2q2gGTHEGx4H/zxmnhm/dSAKpRYUhnK3rgQHu1iiDEu1cAkQlFJnOervzf+WhNhmzYsubkmUdAcqaMgB6d4WFAe6fu65BYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5M6d0ctx8+W+xVknMiDZWcKsepQB7JklfRhN8P5+1BQ=;
 b=VmvWJnVSP+C55l3PLDlsGk9Cxl6qoBMdlHWnNJbY/6lKvmZrXVbvQRohPdsgk6ScSCGHdU5VUULLD4X79DwU7T4GurSY8/O/cGXLZ8rLfyqzRuc444tuXwLH/ZsFJNO5pv7ZJ+bcppIluIWg4dnglLO4Qr98Dj5tJDytaDqfDc1Qr/xmdTP/1bCRGNdPIHuZ9VEu33yrWTIJOGDfoij7msF+Q1nIuURyeLtPYSPaYNWFqvKv4azill81O7SI1YIdTTXNMYY2nQsOoSu80AaZsNiEeBlrJPOl71Zxc0Gl4/qkY69hrPFcvCihTLB0lDUNtajtTPASc/rjOgDCVUsa8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5M6d0ctx8+W+xVknMiDZWcKsepQB7JklfRhN8P5+1BQ=;
 b=xYt7Jf8Dlw8y4Vkh7DlECBILKmMH+5Hl6NQ3hOUsE0S3M4CJYa2VTRb2zDJEgSMs6A3ogECu7NjI1NCmUrxP0E8g20DemJAzIbiW9G+M7MddTNLZ7ldzH/kG4O1HfWcAIAZE50OoNJ7mI6U8TsORcWSoI8AyCt4TADD1w7aomT8=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH3PR10MB6690.namprd10.prod.outlook.com (2603:10b6:610:143::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.9; Sat, 10 Aug
 2024 09:37:20 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7849.013; Sat, 10 Aug 2024
 09:37:20 +0000
Message-ID: <cc6b3f06-13d2-481b-b15d-c752c90ff7bc@oracle.com>
Date: Sat, 10 Aug 2024 10:37:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 bpf-next 3/9] libbpf: split BTF relocation
To: Neill Kapron <nkapron@google.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mcgrof@kernel.org,
        masahiroy@kernel.org, nathan@kernel.org, mykolal@fb.com, dxu@dxuuu.xyz,
        bpf@vger.kernel.org
References: <20240613095014.357981-1-alan.maguire@oracle.com>
 <20240613095014.357981-4-alan.maguire@oracle.com>
 <ZraYdV9NjDd0w3oO@google.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZraYdV9NjDd0w3oO@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0496.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH3PR10MB6690:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e36930-79c5-43c4-c36a-08dcb92007c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1hyS0oyakozVkxrMDFNL1RZZjVBMmhDQXpwZnlPZ2g3c29icDYxdHpVcytB?=
 =?utf-8?B?c0hpUExQMUVaL2hwUDdtWXEvRnR0b3hmeTZHVFlJOU9qVnZQeEJhSVdYOThp?=
 =?utf-8?B?bWp0eFV4WXk0SElWaHZQUUtOcitJRHNkdERneUVCQ256L04vTCsyUmhTa0hR?=
 =?utf-8?B?NW9ZYXY3dlZIeWZpTDlpRHJaMktuVUNuamRPVkZGMTNSQkdOS3UwWWY1ZTMw?=
 =?utf-8?B?bXphdjdjRTA0Y1ZGTFdja3p5Y29hMU9FVHMxVmIyN1AwLzc1R0NzZ3ZhNEx5?=
 =?utf-8?B?MllqcW5mNU8zMGE2aGVMK3RLaXRtNzlBWEpvRU5sVzhKMVVKSlhuMXFzWnFS?=
 =?utf-8?B?UmRjZDB1QlNpZzU5cjVubmMzbTdza1o4THg3RHlGUjNpMzJsWkFUMEVFZVpo?=
 =?utf-8?B?WGZWVmNoaW9ISHlVQ3dlS0oyVEE3NnFBSWpHcGJNNlVGMUxxUkViako3a2U0?=
 =?utf-8?B?cmIrRm90OHR0MDVlMytNYzAycGY2M2JINUxtd0VaR2lNMGFyK3NKQm80QWtv?=
 =?utf-8?B?dThCRjJGekNZNkRGdlA5M2FXazcycXdST2tpWXhSUWtrWGtvcTNwck5mMGNw?=
 =?utf-8?B?R3lGclhDN1FMUTdPbkpuVGcwZUtrUTI3Z3BzWXNWdkF0U2hqT3NJNjVvYlV4?=
 =?utf-8?B?cU83VFJCS3hjVTdMM015SUZXcTlsWXlXQjFtUndMVmFGSHBsKzhGSGllUU5B?=
 =?utf-8?B?ZnBDeUlINUR4WklPUUozWXhzZEN3Q20xakMrTW04b2Fnd1ZzQ1BCT1pDTXo2?=
 =?utf-8?B?SW02Z2NmRlIweXBRVlEwOWthTTZ4dnovbkRwUE8zdzJRckxUc1VYQzM3SVE2?=
 =?utf-8?B?bUlvczlwWVF5RVNNZXpBMFZvWXdjdlNsVDhUMTJCV2dXVnl3WWJKaDFRbjJX?=
 =?utf-8?B?RVVxRkhFNm42SlFhaHpvajZFMUcydXhIM3lyNU9rcjFMdndwc0FuN2RiK2Ft?=
 =?utf-8?B?cGJjdGkxcW5aN1ZoQlNiL3daWEFOSUgyVUZsUmUvdDROQVcwVGdFZ3BENUli?=
 =?utf-8?B?a294Q2RmcHBPV2hoM2swZU9wMjQwWi82OURBZmtXY1o4UGtEVWtNZzhuWWl4?=
 =?utf-8?B?azV3ZWh0M2xtN0hjaFVwQ05CVis3SUMvaG1aM3d4ay9ZcU0rQldid1JlcEtu?=
 =?utf-8?B?RUhjNDlpSTB6MEJPM0NpVjVXdWhRSkFVN1JuYzlQQ2IxeXhPSEVubW85NnRN?=
 =?utf-8?B?RERFNkVlVmJQNzd4SjR2aWZoeGtUUzBvOGdMNjl3ZmV4a1g3NTV3MG1zVDdn?=
 =?utf-8?B?ZWg1YVNQamwwOUo1NWNhMW42RTJDS0lldVlPOXFvMjlYcnJHREVUSXNvWGIr?=
 =?utf-8?B?cTZBUFJxRTQ3S3FpZEhZNURvM0NEZXdqaVR4aGRJQXUzNEo5WTNGaUlaV0lM?=
 =?utf-8?B?VjRCcHFrSVpmYmVLZTh3VmxNWXFPSWZ0QlRGcmFaYWxKUktpTVUwS2ozRlky?=
 =?utf-8?B?dlp6Q2gvZzBtK09SZU5SeEZxVVRHTVlxMS8waC84MktXWlllUEo4ZkJvLzQv?=
 =?utf-8?B?THNOWVJ0NDVlS1dEM1dyYldZb1BmSS81a2RldkwwV0NFcUViQlllVFFPalJM?=
 =?utf-8?B?Qy9NOXM1VnVpb2RaSVdkZXBiV29neWlpRU5JbHJ6WjhacGxMZlEzUTJVWVUw?=
 =?utf-8?B?QzNXa2JSRllTRXZSZmVjVkMxRzZ0RE1IRXYxRUNheGR1d1ZBTmM1SW51L0Zr?=
 =?utf-8?B?c3dtTVg5R3pjcHVnTmh4aWFpREFGSDhlRUtuVnhhUmhiQkxlRzE4YUt2ZmRW?=
 =?utf-8?Q?2OBSMcsuIDDMe+0Tj1BetLiIb1Sk7RxSEE0oe5q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFdVSCt6MWZ6c0VJR1hHUjhZdXprZDdiMXBPYlJrN2VUY2duUS9pSDVlZVNU?=
 =?utf-8?B?dEh0M0NNQ1krVjFHRGZTQW1OZzdDcUlvM0RnenpBVXhyNXJVVEcvSU90U1Fz?=
 =?utf-8?B?U3pJOHJJaG9RVVlhUHREN3QzeWx0QmE2Qng2UW5hZ25XWUlhZHZlY3pqWW9i?=
 =?utf-8?B?T1d3MXJnOG9kbHphbm1rM1l3bmJJZHdJaWlQNVVmZzFFVkszZFd5ZDUxWWIx?=
 =?utf-8?B?T0tCZTZWQnNNWlNKZUxGSFFZUWMwYk5FN1VqRTNPaCttMGpZR1NSVE5mSkhn?=
 =?utf-8?B?UzNoZWxRNVYyNGZTaC9wUUswb08vUmdCZlRSQTdmL1pLWEN5UFBnRHZFY1ov?=
 =?utf-8?B?dlNFdHlFWXp3cDlZa1NMYXZaWUwyclVOcVJCWFFOZVFlQ2xBVmxGUXNDV1RX?=
 =?utf-8?B?MEx0SnBnMFdKVFpMaDBRbTYrOHZoOC8rcFp0anVmdmR2bkdtMUUwbU0xMWk1?=
 =?utf-8?B?RWc0R0ErdWt3SG5EUU1WRG9OLzB1MXVqWWR4MXFrRXFRb0dFMGI1cHZ4TkN2?=
 =?utf-8?B?OWt3NWhnUHBxc2liNUxQVDRINDFJTzBUZk0zeHd6YXE3MTI3NXFIZ1U5bXFO?=
 =?utf-8?B?a3hyMHp3TUVRQWpKQmFXVCsyQzFGNUp6bkV6WW5uRG5uVm5LL2wxSGJ1dHNj?=
 =?utf-8?B?ang4amJ1ejAzYTE4bnRGSE4yMnRUOWMyT0JGTFlOQkM5WjRmNGI3RFUwMFl5?=
 =?utf-8?B?L2N3Mkl6NGExV091OG1KbVlkaER1QUZPYk4yRTRzU1ZsSm5tVEo3Z2NFVkhP?=
 =?utf-8?B?YzR1VlJDVUVlZ0JTc1I3QkpFaVQ0UldOd1J3dmxQTTZZeXFMMi82YmdtbW1L?=
 =?utf-8?B?ZUI2bmxDRmZvLzVkZ0N6SzdvejJ3cndpaGppa1MxL0hLTXc1d1B3cWFwREJm?=
 =?utf-8?B?SEVLMFRLQWJCeE5rdXBRYTBHV1RDT3kxdVpUNlN4dXM3a21vMldFbFdRdE00?=
 =?utf-8?B?RUw0WSttZ2pLSk9pZ1B2Smk1cm9BSFduek8yMnNSak1MTHRFTGdPUVZ0WWl2?=
 =?utf-8?B?MkR0N1FNUEhyMDg1M2tVdzZyMkJOaU5ra1ZMR1RjaFVGZVlGaXZXVTFPblhM?=
 =?utf-8?B?aXM0L0ZTNWhsYUlvSUxlanJGUFk5QllHU0lwSWdOZDRoem16KzFnWERHUHhP?=
 =?utf-8?B?aDZMM0JkWUdFMTd5ZUZ0TmRzNk04M0szZURoMXlUbTljSFRYVWdZTmRhRytt?=
 =?utf-8?B?d0o0TzNsUzZ5ODl3aEpWWXhta2s0UTJucGVzVU1HUWxuWkpMNHg3TGxJU2E4?=
 =?utf-8?B?eVk1NmpoZEJ1NldzcUY2OGUraU5Zdy90UDAzdzZoVU94bHFsM1dRWG1odFFY?=
 =?utf-8?B?cUh4ZXVjcllJYm9xOWxYcFBMbGU0VUtNR1FrSUl6Y0NSOGlWbVliWkZzWFIy?=
 =?utf-8?B?a0lINnBjTnhYM0FmQWZ2NHdIRTV4dDhqMjRKbFFrVWcrNy8vM0cyMzZWQjFH?=
 =?utf-8?B?UWVpU0dTaXZBcGMremxlZkFRbVVpeFlmMTFoNDBaTThtM2JJU3lMaUx6UHlU?=
 =?utf-8?B?cVNNcXhLV2wvSXhFK2Rla2pPWCtwUTd0RXRNOGxlMVdiZEUxaG1saTY5TVl0?=
 =?utf-8?B?MlFLVC9HZ2JCUUdwQUJYaXFjYXJ2STlJM1JiL1prUk14clhoUDdaR0Z6bHRQ?=
 =?utf-8?B?dlZoSjJuczFOODRuUGMrWGZBVnNGTTZYdFp0RW5BeHdmWGVjVlpDYUttVDh4?=
 =?utf-8?B?WWk4T2EvaTJVWFF5dXU2c1NkQzdVTzlQWXNZbjRJbnBJbVZMQnZmcU1lNTAy?=
 =?utf-8?B?aEhINVNIc3VSZEZnSW5VM0NzN3g2OFFaRkZ2dFRKaEZSN0hLclpENlVadHdW?=
 =?utf-8?B?MzMwaGN0OEFRZUdYQzgvYXViMlZWUmpvVVZyWStGbXR6c0pnYjJkVnZ6VjRY?=
 =?utf-8?B?c1dSY3pXbDgwSncxWWNYeVNmZWhwdVZNcHhMZEwxbUkyQ0wwQnNaYmhacVlG?=
 =?utf-8?B?U2tqZzgwelJBQkRJSVl3cjY0UHI3Mkg3WlU0Sy9VWnBacmllekV6YXJOUm9X?=
 =?utf-8?B?eGY1emgzdkxmVjkrcnZDa1BvN0d5QXRQblFLMWdzdmJzQWpwOE1tVUo3Tzdl?=
 =?utf-8?B?WGE0NUFMakx5M24rR1lkOWU2WXBFZ3BINEMzU3ozbm5kUkdlM1JlVGdYUEFO?=
 =?utf-8?B?MnVpMkV0VkVCaEFEYitWM1NTbzc5MDBWN2pEOTBKd2VsNUFWalVrTWN1b1Bn?=
 =?utf-8?Q?ZEuS4LurguhyBJqaO1d6jy0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HgdC8QhSK+8XQQgZ4jFgAS3M955T2bbhn7WuTtpVuT3NNTIfGxFYzWyOyRLqXQAqAtqDWmfRspl12LdmJNVNAnOx/03Fz9UusHEsXFG+rcLdbcSXPTPAHyDrNgr6kMzMkQWWGDofTt3825gT+82pKTxIg5nPIn1dSqIET5aOb231zkXArZ0Xyxd/rTYL/D67pvDJVeUKYeu6d4YSsriFHN3cYfS2CBoRBUroz4beDiCn76Lo1DE4KLJnxWzoKVIGs/aEauV8JcE5okwmGbR3AWnmVRo+x1auYAlkt/9o6QpOx65GttzeLBrrDFcW38cQN03qSWKciLPkJdhCdyXKh1Vng05lk8PxSi2Ug8chx/BgwnlsIz3LS2agmVxgub9L5dkB6E6PPTV+LqXIVUv01WcjrtC6sp0k9g36O3GJZE6j5mxlDMEcL/3Eslv43B0KaPZkzjMkqxqYGyx0zh/KAhOZeXgEaWTM2xPxdyOWZlEpqEBTJ3H9gpIIKnTXEOeGZtnELxqCE4fQhc6Pk+SwS3sPi9pHPXOd/chcQ42E+a66WCzxFM/djyeYDA2+cARz5UbEIulZVc8dMk2LL7pugK/RIe+lePdDoGltbhNKVeQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e36930-79c5-43c4-c36a-08dcb92007c5
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2024 09:37:20.2364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iQa6L3/ow18xcpyJOT3Gv94FCtFKLqWZLGZZYCD++hoJtSpSYB4ixeqs1kxUKf/2wVKynOksqfPBvPKRgdwdaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6690
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-10_06,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408100072
X-Proofpoint-ORIG-GUID: qZZkVJlUgelc1PCaTyYx42aWoRtq0JCm
X-Proofpoint-GUID: qZZkVJlUgelc1PCaTyYx42aWoRtq0JCm

On 09/08/2024 23:30, Neill Kapron wrote:
> On Thu, Jun 13, 2024 at 10:50:08AM +0100, Alan Maguire wrote:
> 
> [...]
> 
>> diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
>> new file mode 100644
>> index 000000000000..eabb8755f662
>> --- /dev/null
>> +++ b/tools/lib/bpf/btf_relocate.c
>> @@ -0,0 +1,506 @@
>> +// SPDX-License-Identifier: GPL-2.0
> Did you mean to license this GPL-2.0? [1] states the code should
> licensed BSD-2-Clause OR LGPL-2.1
> 

Yeah, aim was simply to be consistent with existing conventions for
libbpf. The only wrinkle with this file is it is included in both kernel
and libbpf, but that is true for relo_core.c too, and that has

// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)

I've sent a fixup patch [1]

Alan

[1]
https://lore.kernel.org/bpf/20240810093504.2111134-1-alan.maguire@oracle.com/
> [...]
> 
> [1] https://github.com/libbpf/libbpf?tab=readme-ov-file#license

