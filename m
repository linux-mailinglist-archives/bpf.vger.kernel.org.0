Return-Path: <bpf+bounces-72647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24865C1742B
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 00:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1F33AB380
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 23:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA21636A5FC;
	Tue, 28 Oct 2025 22:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SD/wv+PF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gsNLm8aS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9121736A5F8
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 22:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761692352; cv=fail; b=MWkhCmcluH/LbWGBaTV5VlXDR7MabovcfwqJFZfMsEeCeZbjWQQ/1yVEBMy4dEzFdowm03xYEY/L5c1krOQIhSKB7/zVaLPp+WBARo5D4jrDRezDo0jA9PNUFJUJEJ6ZS38OBicsV0rn2lwkSDH+9+PN//KOE7wkzxHWvYrlU5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761692352; c=relaxed/simple;
	bh=Pdt/3Klq+xhG3ny0FveWIm0zT/gPT/qwENWs+LXh71o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=e1kNAiUdYlMSchYETkCNBRLKO8xdy/zXCFOQTtxQjmKdAfIuF3p7cS7/fxQAKAamy+DMnRxEQAbKdXlOOPwsT2mqMibTHasjT0UmCerHqNkExdWdlVe+BvkAfDxME33lFR302nxjIH7qWkXAVPiF9L0eEeYgRBkIFra18TFyqLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SD/wv+PF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gsNLm8aS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SMuOk3016924;
	Tue, 28 Oct 2025 22:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RNuqwyR0s98OE6kZ/27orJrHG4KLC3aYAC9UVrosp90=; b=
	SD/wv+PFPMdfhNsJAJEO1DeSuTIhQ/rHh7syJV4Xk0zJqM47qtFIx8QKwmb7rvsK
	KIH960C8XMKpoSL1WPDyJIqqJJFmasP1yWf8j+NVOZ8iKegddYbgtT7j7+KL1x/g
	gHsjexWKLjZgjflx2Vo+x3N95M9ulqePZ3tH616FWm3QDzEYqdAmKliUG3godzSX
	7u0vENNQ23x0g6OP9Mi2VQN8wEWNFF8VMq3cJWHiZWBwtoXmk9HmrPUFqC2rkQJV
	13YZxwIcWjNPIKFHZHM1GGqp16UAnfSg8bl1Yz5t+zQ9si7xtdlydTHWPKq+rkE2
	U6QBR1lrkhgTn0WbhM82ig==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a33vx8bk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 22:58:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59SMmaCl015929;
	Tue, 28 Oct 2025 22:58:45 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a34q6vnnd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 22:58:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnhRch8NRznNNKcQs/vJMLlPmfV5CtZ1MKBrQDws7jo+wECZYhEWT7uVJ81NCW4lyyFZjemqjj8NG4xKao/At/3JSQHvnLLcMBXDdmoOAbMoCTPG7G24SpLRA/5NNQLNhNZY6o4uCL5qbwcNAILngwnIskmZVJZ0TON35M7mmaD60JnZW5XVc3jU9jNuMoY0u++ir2oBj3/fPHlbip5pBIyDXT20zrp1wEcmhdlg4ogDX3Szncx/ntp1NLU2dm+ZAA8Nyo7kTcrvtdebYRtmpLq+T8TiEfjrDXIIUTLu+pgniT+su8sdDBIXR9AXxQOSw4o9z3pYsl9NEGHfZfS+zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNuqwyR0s98OE6kZ/27orJrHG4KLC3aYAC9UVrosp90=;
 b=lbSRfMRoQjt1uypCRyDdJLCMs9NnAsLhRmssWR2BsTqeAMVDtg+9ZFGOQoax+8j+lA6qEBpUciQCPxzPbF+DzaBPDUlXwBkgE2sV9j3360uN77yy1ojS8lVLtzApj17DmkOo9JRNTtSIGju1dYJFXUYvHUkG/JYgCqYQQnR4/h+N9yWvOS2n71J/yHzj0n21arXzNkQ9Uw30iL+I00WSBjmCLYtN9iBjlAqNuQP8fzXo9gPeK8WAAozD3zham4xYjKpxzKSmr+Yn4BHAc5iWjRkjD0p26WXe7rmmH4Qv3JW/JtvUnELY4SO5Oo/3gNDv8U9iw0g8P1cvwfqpP/WKpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNuqwyR0s98OE6kZ/27orJrHG4KLC3aYAC9UVrosp90=;
 b=gsNLm8aS0bQBGhkBJUlC3cCEH0JBlp4Pannz+UoIYNhtWS/IhpeapKorBDTCeekp3J37Y7nhr0eJZI/9y5qY33X76kwtP1JlY/h97rL7XB21h16qZQobqqNZmfwLJbr/6pNOcaB87hdM9yW+lr4mq1UwpcwtUkpsKWnQNe11e3g=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 LV0PR10MB997613.namprd10.prod.outlook.com (2603:10b6:408:345::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 22:58:43 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 22:58:43 +0000
Message-ID: <e5c94901-98de-433b-82cd-0f974dfded66@oracle.com>
Date: Tue, 28 Oct 2025 22:58:34 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Test parsing of
 (multi-)split BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bot+bpf-ci@kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, ihor.solodrai@linux.dev, bpf@vger.kernel.org,
        martin.lau@kernel.org, clm@meta.com
References: <20251028155709.1265445-3-alan.maguire@oracle.com>
 <478a9790d452e3ab4c846f673e7e6ed1b4cb347adfe9628d0fc71256d7f2edcc@mail.kernel.org>
 <CAEf4BzYYMyjFQMn+UKFBEK2bgFTYP=qEGg2aF_fGZif+GeMJfg@mail.gmail.com>
 <CAEf4BzZoqySO4Z59bYiKaG5ka+6hLhkaD7rbh8WK1Mt588NTZA@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzZoqySO4Z59bYiKaG5ka+6hLhkaD7rbh8WK1Mt588NTZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::8) To CY5PR10MB6261.namprd10.prod.outlook.com
 (2603:10b6:930:43::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|LV0PR10MB997613:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af9619f-d27f-43e7-74ef-08de16758a48
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dm9iOHFqSFlMWkx0VXhYSklpWURXNnR2RHFGRW82MDFHOUdYUWJ1NW1Td1dM?=
 =?utf-8?B?VERBdTJ0dFh3N0xrSlQ1KzBqaVJmcllHOVpQSlpEZ1pGdG05TVllcElJbWE4?=
 =?utf-8?B?RzM2b1JqSkIrQ2crZG9LeW9razgwWEd1dWxzMnRlQ2dZazBGVEhPcEZIbnJw?=
 =?utf-8?B?R3h4OEJyTmZxNWYrdksyNDlRWG5xMzBhcXlNUXNjbGhwRjJJVE1YV1hLcGhS?=
 =?utf-8?B?SjFuU2RlZi9CMHJ4NnpCU3lFRkFzcC9UYUg0SXRTMmpkNE1LMU1GVWZWNXVk?=
 =?utf-8?B?VlZtMHFTclczcXp6SjB4YW56TVR4K2hnZUJRcU1hOU9RRHR6UzBwLythL2VM?=
 =?utf-8?B?a1RCY0FtdFZHZUdGUEg3L0FzditDSW1FMHN3S0l5ZU9zbDR1eU5oK04xVzFp?=
 =?utf-8?B?ZFc3NGZpNzVRczJyT3BjaWhRYWRUQ0lwTDh3WDNqVUFIOWdvUERGUkZpU1RY?=
 =?utf-8?B?MnhZcnlzQlNUeEppSUZwS25nVFo0ajF6eEVTd2RzUmNEbWd6QlEvS0cvZHRN?=
 =?utf-8?B?Wm5xbFRETWx3Y1dFbHdPZzhGZ2lQZUpPTUpjUG1mQmd0VG5obEI3U1Evbm1T?=
 =?utf-8?B?S3M5UjNMbEQwbmdwUnJ1RWhEVzJQRm50ZzMvZkZaMWhCUlpWYkJMdUpZMGZp?=
 =?utf-8?B?Q1BiZ0MxR0gvRXJCdXZQMGhFaFlEWGEzRFQ5UWxqOU5VbzVXN3YvMHV4Njht?=
 =?utf-8?B?emx6bGhyaFQwak1wemd0RktVdk5oTWJtWEFSWHJLZkJtMmRRTGlTeHRQL0JE?=
 =?utf-8?B?bHFYR0R3a2lucktFZnQ2Ni9tQ0MzclJ4RjFUVXFVQkIwbGlVVnlNcWE2RS8y?=
 =?utf-8?B?MmhmSGZBRTFvdWhpVUtvZ2paSVRFaFpYcEh3YklhdDVYcXV3dzlYdDhQS1hW?=
 =?utf-8?B?TzhjT1RXODg4WUdyZFNQRU8rMEVVcjhEY1NOcU5DdUJFTmJNZnY1VktnaWJL?=
 =?utf-8?B?cjl3eU5ZZkRXVnFLWkJhMTBPU1dsZUd1TFFsQWxmMnF5M09yVWRkZzlQSmZs?=
 =?utf-8?B?MStNR1dLYTY1bll1M0hYUjdMZWlrU3g5UGdIUG9YbUFuS253ZnFEYlA5ZkNV?=
 =?utf-8?B?cHU3VzJ2dFhtWE92Nzd5S05OMWx5dnVwWDRLbjdwdDIxaGlVb1FqUjBzelRO?=
 =?utf-8?B?NzhaaU5jK2RnVjlJNXRxdFh0eUNFazdTZWwycWxRMHNSVUxqUGJxbWhFbEhl?=
 =?utf-8?B?NmEyVzVzQTVHdndnY1dPRHM0N3VPZG83cEhxQnJkZ1FGYnQvWmp0Tm4wdWJs?=
 =?utf-8?B?VzZ1Rk92c3ZMQzdtWHBXdlZFK0JJeGR4K0JPVlRzVE9sSUdocjlvNVoydUJx?=
 =?utf-8?B?L21xeHVQTXRRd0NzaWNLcm1lWHY1d0lDSkRKMVphVldxQTcyZzdMQkZIMVJ1?=
 =?utf-8?B?L3h4ZWE4WFZXSWx3NldJYzlWRWxadm13U2VGYjlsQ0VhMEo5S2g0dkIwZ2lF?=
 =?utf-8?B?L3psK0xJK0lMTU1NbzlLb21YaGk4VUxxcTg1T2xKOWp6VmdGamJpRXFocjR3?=
 =?utf-8?B?bGo0b0ZFZndLbjVVaHg3L09YNVFZNGp3UVVNUTN5ZjNJTnhlTkViMUxrU3Zh?=
 =?utf-8?B?dzBmSnp5eFBnSVBtUTRtL0phL0JFaUYyODF0aDk4SUFKTUFhelN0amNySkhO?=
 =?utf-8?B?UnUzK0ZSOXZkS2NvTk1GYXg2SEx1RUYydXdMUjlZUHR1WXJLeUZ3SmJxNU9U?=
 =?utf-8?B?UUdyeXpybm85a3NxRHcxUkNNNjgwNlEwYm01a1duWG1vclVMYUtYc0YzVTV2?=
 =?utf-8?B?aklhMTlwOHRxbWhtTkx1MDBWNXJnQ2RDb3Q5N0ZWMHBjOGdsNkNmNmcrcExG?=
 =?utf-8?B?SjdFZWtGYmx4d2s0bWQ5VUFDMzl5T1BQZ0FMN0p0OGQvNGlWcHRoQU13YUFZ?=
 =?utf-8?B?TURQK2I0cVRzank5K3liU1hXRXhQQzM5ZXMyRS8rYXpTdWtNdk5FOGRBVEtl?=
 =?utf-8?Q?dLxk0IG0zSocu4mPkXLCJwXUrW8Awk6Y?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dVlMR3dWRG45dk5qSHFpNzZLN3RNRzJKRWlZQ00rTTRtT3BTYzk0Q1ZndDhH?=
 =?utf-8?B?d0p4U1N1UHQ5RGlRMXlaSzl5cnk3SFJqa0doWXJ3ME43RGFPTEdVUVVjWFFJ?=
 =?utf-8?B?Vi9ZVHV1UFYyeXgyWkl5ZCs4MjQwbVY0c2F1RmZqcXNiRTQvNzhiY09pdEYy?=
 =?utf-8?B?VVVuZWlQZUxCUkFCbld4Vy9Ha2U1c3lrTEd2TWhLSFZqU0p6WUVmMzBqQ0Mz?=
 =?utf-8?B?amRJVEJrUnovSkszNXZoTVdYL0Q3V2tsSklpOWdxbnBYRDgzYXBTQjB5R2Ir?=
 =?utf-8?B?T21FaVYrNWQ1YkFKdXpYbWhtL1VOTTdkTHQzL1lrb2FJWFp6Y3lpM0JhUnNC?=
 =?utf-8?B?a0t0Zks0SHhhK0ltenJMUTFJSk9ZWUxoMk1pdjIrM3EvVVJyY29XRXRTcEpN?=
 =?utf-8?B?ZGtKWXp4NXFSVEcrYkJ5MWI1QXhIQUVtdk1VMlBZYTZ1UTZMTkxvb1ZtMC9K?=
 =?utf-8?B?UWk4ZVJpTzBWNjkrenptQ29uNVoxVThsWGdXWmdzYWZ0R2twclRzNXJnZE0r?=
 =?utf-8?B?cWJNRlhyem0vUUJxbjVUbFRsUEVucG1TUENYZ0dHUHQra3ZRbk9SODdYZ0Ri?=
 =?utf-8?B?V25TZDFiRDUva3I4SUw2eEpEenFsaXJiL0p0TnNITnVzdTdNNzkycWZRb2o3?=
 =?utf-8?B?QkRvd2VmVDhIT1dCK3V6Q0ZFSTFSSndaQml2NklFODFXbDJMM2MySzBZY0lB?=
 =?utf-8?B?VGg1YmQ3bGlraGVTcHdDVzRuR0I0TXFkdFI1VlVERjFvU0h2MUpHMzkyc3VK?=
 =?utf-8?B?U1pYdkEvQzF5UkQ0NzdCRHA0a2xjSjhFeXJ6MmdMVTJtTWY1NlpnQiticC9m?=
 =?utf-8?B?dVBNTjFSTUlwaWExRWdlalIwZXZzbzVUSDFZL2RSYU1uTXdUU0tjbFhCckNW?=
 =?utf-8?B?NjlFM2dsdWNSeWVZc2xwTU5wb0I0Q0ZUWjN3bStsMGhnUUs3Q2ZrM2wwNTJu?=
 =?utf-8?B?ckJUcmdqZExha29KTGo3KzBRblVRczcyQS9GMXNodWd5MDE1ZnJHNEU3RTJY?=
 =?utf-8?B?eDJZclA2L2lkY3JiL3FlclQ1MU16VXRHbmg0eVRINUZQVmgxa0RONG44ZlFo?=
 =?utf-8?B?TmpzSW56L1hWWEtIK1Iyb2FxWlBUTXE0SnRKTHlUdm83VzhtZ1lzQ1BXZHJo?=
 =?utf-8?B?bmYrMFExZzhxSW5qV3hRS01raEwvQTYwK09iUWJocW0rUS92VGI3WERpSFI4?=
 =?utf-8?B?cHRUT0NNdlJJVUVkeUFIY3pzam1xWU5lNkw5QXAwOERjelNtYlRiY3ByMkx2?=
 =?utf-8?B?YUdrc1VaTnB3KzJnWEZnNlNYT1g4Q0VMUFhaRjYwZFZHWE5ERmh5L2dsZ1d1?=
 =?utf-8?B?QWNJU2QrbENHdWlEclJCVTNwN3dKNVN4VFdocWcrQWt5TjdiclhrOEtnUVp5?=
 =?utf-8?B?c0JwMDNFOVI3K09FdnZRMktrd2E0TURmT1puVWMyYTFKRFFZcHRQYk54TlM0?=
 =?utf-8?B?bXFDSGU5TWZBN3ZnL2RRdFFXZ29nY3k2L0RFbjhhVU8wY2hNbEdYdDJTZDVn?=
 =?utf-8?B?TVVVWFJsLzlSeEtwejN5aGhDUytnY2ZVT1p2ek1rQlRXN2RxRGkyRDF5TmJ2?=
 =?utf-8?B?Y3hJMTAzYjlqVlVpMGMvdGREdnM0d2gvWWhuQzEwSmJRM0k5ald4dGQrTlBq?=
 =?utf-8?B?bVlLcWtzVi9HZ2d2UVQzVFprVDd0TUlTcTh4WnpaV290blhzVnF0SEtpUTI2?=
 =?utf-8?B?SVNGSjVqRE54c1hTOUFPam11S3A0Z0d6ZUwrRnZwMU5uQkQ2OXZyYkxxdnJV?=
 =?utf-8?B?TFdzYkZQd1FDNjJpRHczUFFPMmhYeGtFN085QzJTVWprSmZLS0UwMG4zVU9P?=
 =?utf-8?B?YjBKYUhWUEtKNU42aFZDYllNVDJRcEFpOFFtNjhVRFBmYkgzYWxWS01jK0Z0?=
 =?utf-8?B?U1k3QldoNnZhZDN5a1NnaTVZS01tbUUzNlpGcVNxbXdYbmVSSVNiVlhqb1FD?=
 =?utf-8?B?WXVWZCs3MDlickk2SWFyNlgvMlRMdDdueHhRS0VvNzd2YzEvWEp0dWo2eUlh?=
 =?utf-8?B?Zm5PckNXdEJST3FGK1VVM21DYVFMaDhGOWFMYzlBUmI2ZDFIaEd6TmJWcXNZ?=
 =?utf-8?B?MkJMWlNIZWQrOHg0NjNBMi95TW1FSFdUSndOTnptTVhhWFlsUjhSbEpZeVNt?=
 =?utf-8?B?N2I0T2RWQ0ozUEgrajY5ZnVZWWNEUUtNeDhaeUFQZE9ZS0k5a2RHU08xNUdw?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H5mF3bMOL+I0iIIzl5p62abgKn43VWvIQ/LPeNOrYGJ8MFEq3AsULU2z2ffqKWblCU5ig3nA58C7OebTzvbS9LbQqikTHgDte2hYSV5Tm3yCrLCXocAkRPjT6nL92e3vT21575xeAWbc9TrSZwBWIIk1nORfr4LIwtHjIQeH7x1LKfgwWJPD82WiYkujYQDguqcrv8WsUM9cSkm1nsAjM5CtZrPjv4ZI+GE5fJob8PLeQXLcCPcyoT2LukrmhhuC1aHFkuhJuhOa6zymuDZRtqKsPkluB3PUBRtgyz4eXrg2hZ3aI7MsIt+rd8FzE1yL+qD7pfUmIGrdzkTyi61bsSAIcj0hd4BqE+bKpNOacVHKewSO48oY/10oYMUcdZ+GrSWuUmhA99HjdkSWyrkXH31H5zrYWz9KI96sfsj8UAoF4Litk++/cDIkNvUHeYXP7Z5ZRinQKD296N//RXiY9tWAd4ArCwQ6Le84is+7t0/mBDboIiH5iVgraoSQx0MmGCG1QOOnHNj6khyIE8ukqpImlQyfeA+67haBOzdnMN/0VHscSUKscooBvS4PF6vyQQO2xXkq4tKIaTZeQ9smsraEDhEy+VLsZ2U6Vvt395M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af9619f-d27f-43e7-74ef-08de16758a48
X-MS-Exchange-CrossTenant-AuthSource: CY5PR10MB6261.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 22:58:43.4127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HKx4QawNIgC6EzUMxXkF+98Drkyg3a5cW/fPyzypnhLaXfx8QnzTrVZkA4fTelzNyBkbWp1rzthvYDSKx8mcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997613
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510280195
X-Proofpoint-GUID: Y0LaCFdOMf1AdEcsfM_AukgKI3QE_IYQ
X-Authority-Analysis: v=2.4 cv=cq2WUl4i c=1 sm=1 tr=0 ts=69014aa7 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=o9-LLrrmoUf9SJMXhr4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12124
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2MiBTYWx0ZWRfXxMrdA8sd3XwT
 POXHd0Df1NDVWaoLyZomXKMOcTqFqM4BxCsgx6MsD81UyNB8QupC5yo/10YaVZfgf4bWw26LjKA
 CLas0H288xglQekU1qXhaiSFqhosvtJOGNmYw4VOsqkqdyCUhCKphrkMtyfE4FJ2JnRSP9/Y/E0
 cIfwCJPBC1FrxNnmMGh5pQzjDf6TEVHvONAPU2YkEM6nAdUN8JxOZHvvHJmmR5Fu8E4v8/xLU+a
 iGFwLvDkg8Lr301za3swTI53/E+xBZeweBK2rqVaZLy4AmrlOdaEOCm7PHd9pfc3rzpuimVT4WE
 Y6pCOaMFLo8e/QmpqsFPgw9jMIfuMSmftKHG0BJIRYDq/Hpq1r06UEWRex6OraE20BvtDwFpLh9
 7DciV3+lbyBRqTlzUqHU3bTsZYW2Bz3kciD5DQGKu0Egffugy+g=
X-Proofpoint-ORIG-GUID: Y0LaCFdOMf1AdEcsfM_AukgKI3QE_IYQ

On 28/10/2025 20:11, Andrii Nakryiko wrote:
> On Tue, Oct 28, 2025 at 1:01 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Tue, Oct 28, 2025 at 9:45 AM <bot+bpf-ci@kernel.org> wrote:
>>>
>>>
>>> ```
>>> commit 8509f4500fb2dfaec7a383a802dffaf84995c434
>>> Author: Alan Maguire <alan.maguire@oracle.com>
>>>
>>> selftests/bpf: Test parsing of (multi-)split BTF
>>>
>>> This commit adds test coverage for parsing split BTF data that has been
>>> written to files. It writes raw BTF data to temporary files, parses them
>>> back, and compares the parsed results to the original in-memory BTF.
>>>
>>>> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_split.c b/tools/testing/selftests/bpf/prog_tests/btf_split.c
>>>> index 3696fb9a0..ee1481c5f 100644
>>>> --- a/tools/testing/selftests/bpf/prog_tests/btf_split.c
>>>> +++ b/tools/testing/selftests/bpf/prog_tests/btf_split.c
>>>
>>> [ ... ]
>>>
>>>> @@ -123,6 +155,35 @@ static void __test_btf_split(bool multi)
>>>>  "    int uf2;\n"
>>>>  "};\n\n", "c_dump");
>>>>
>>>> +     /* write base, split BTFs to files and ensure parsing succeeds */
>>>> +     if (btf_raw_write(btf1, base_btf_file) != 0)
>>>> +             goto cleanup;
>>>> +     if (btf_raw_write(btf2, split_btf_file) != 0)
>>>> +             goto cleanup;
>>>> +     btf4 = btf__parse(base_btf_file, NULL);
>>>> +     if (!ASSERT_OK_PTR(btf4, "parse_base"))
>>>> +             goto cleanup;
>>>> +     btf5 = btf__parse_split(split_btf_file, btf4);
>>>> +     if (!ASSERT_OK_PTR(btf5, "parse_split"))
>>>> +             goto cleanup;
>>>> +     if (multi) {
>>>> +             if (btf_raw_write(btf3, multisplit_btf_file) != 0)
>>>> +                     goto cleanup;
>>>> +             btf6 = btf__parse_split(multisplit_btf_file, btf5);
>>>> +             if (!ASSERT_OK_PTR(btf5, "parse_multisplit"))
>>>                                  ^^^^^
>>>
>>> Should this check btf6 instead of btf5? The line above assigns to btf6,
>>> but this assertion checks btf5 which was already validated earlier.
>>> Following the pattern from the btf4 and btf5 checks above, it looks like
>>> this should be checking the newly assigned btf6 pointer.
>>>
>>
>> AI has a good point, I fixed it up while applying.
>>
>>
>> Alan, while fixing this up, I noticed that __test_btf_split clean up
>> path can dereference a bunch of uninitialized btfs (btf4 and btf5).
>> Also, we can goto cleanup before we create
>> {base,split,multisplit}_btf_file, so it would be nice if you could
>> send a follow up fixing all that. Thanks!
> 
> Ok, so BPF CI noticed this as well. I ended up not pushing, please fix
> the clean up path (unlink is pre-existing bug, but it doesn't cause
> compiler to complain)
>

sure, I've sent v3 which I think has all the cleanups needed now, along
with fixed Fixes: tag and ASSERT_OK_PTR() on right btf. Thanks!

Alan


