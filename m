Return-Path: <bpf+bounces-69212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FD0B9106D
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 14:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC68188C33A
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 12:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841A530648D;
	Mon, 22 Sep 2025 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lxwEOUeP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CP0DLa4C"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B461A9FB7;
	Mon, 22 Sep 2025 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758542401; cv=fail; b=jvYfRQoH4iCZgzx28MuC2SMez+PQ8h4xcYuisOAQm9XyNlGO+JpBgFOOprOjz6dCgiBkKyhTuJ1igfYtK99VEoPCcVUGCeYTEbTRLh5uKbPNKgfreebbCBIo34zgemNLAnneuPYZBvTEogExxhgINNYB06nsqRZ1E1y0rjNGyZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758542401; c=relaxed/simple;
	bh=A1YpU0Owhwz7lZ3QAhpdiYfIIpRMgkhYoQ1H8fT+CIw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jj0aRFf4KTQdy7qj7WCzWWXi0QL63dU8owicTpkA2CoZwFvo0c/IVwAyoHtFGfencJIFpky8ZpCzKM3/feC/oOzQFKPPonnbHufDTtrGNgnTsYVw9CTh6ojjhnicyP6kiHroPev7MStFpIvQHmAsIu7UdwAlN21jeQVugFp/dng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lxwEOUeP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CP0DLa4C; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7NM2C010308;
	Mon, 22 Sep 2025 11:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KqsYX24BMcJd0at3o5onUPzy/SOWK2ssDY5KhIcQ+JY=; b=
	lxwEOUePfi4fSygINbc72BABXRoh/H4qXCSwbB/V3qwAyCRj3kmJC9XkNgotHWgg
	1e8zMuD5xqwfZWjolaw8aIH6Oz44TR+aEGgzGwcoShQgkJi/TgcoJSzWlsM/bZzp
	n3m3siIhUgdGzTL/6wtxlaMfKq7Mqe4WDT8vbB90WQhktbxHP5opfXeHc7hnyNVV
	GTcFmEaqoN9C5gj803eAhWgGd8S/cjDBn7RNVSdUAlfBjEqGxyCdwSno8g/eD1Kr
	ggiFz7oKkY5L5b7dakc9b6XtfSFFhV7FI4yaTeiIztWcPq3E1b/wKjFlnlf9rE/W
	LjctX634Bcz0cNQj3PyJhw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499m59a80f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 11:59:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58MAGQsN034105;
	Mon, 22 Sep 2025 11:59:35 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49a6nh6q3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 11:59:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjRWIaFLYTCj0gREjdrkA/pmrrwKFp353st2NRljzjXa6vQd+nOMZ7KHUz8h19Uvrpv6r0HbYAqqCnidVH7rLRqFb5yljohEQedhD65YmcM9TzwyqMQkpZI/DvoUMUxcrErnYf/bDm7Q5fRIBuu7zS5SSDOBfFiIjLuZMnHCC7Yuxt4vSBZ56/0DryEew87i9MvpylsKBwCBI1iZow7umZfafcX5qjAGVlm7Ou42kvWVnFK/CPl4m7uGWKkCSe9OYSkydKRl43u7bD53ysYionC4njPkDMAdsEoJ5cnpRgTCrn7KFUNfMKGPbwSxObXUavVbzOlTUeA9JikNbu0sNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqsYX24BMcJd0at3o5onUPzy/SOWK2ssDY5KhIcQ+JY=;
 b=ivea2gGEDJAeuJ4RG4Ys5KErNWBLg3I52k1mz8Ogw5L8QBOfJUc832nJhjRLVxBPJ3h/to4srlm6bnJMOy0202LraR93i5uPos8u5dseeWM0fvSPdl7DnZfNOMw6N2Tv+nbaISPKBXfrTX17riTfYd4gkFHqLcGXhyG1BsmAo73+ARfFosB34p9U/ISrw0bsNvyiiDL7kskwNjY4aErpmkDLfMHTg6pdzdIjTUwRD2K+4ecPu8NNjbKSVu3s4oX/aqq6j0U2r1zxnwPl6thfZRbviW1l2xO2TtLVD1NCjYdZQpI4Y+9khw3voU2ZaAie5UUPtRE5y32V89OQNTOWcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqsYX24BMcJd0at3o5onUPzy/SOWK2ssDY5KhIcQ+JY=;
 b=CP0DLa4C8TEHff+4Tb9NpUpTw3kLjphuXSQwGCrqBW9IMHexjs5Y/JmgggrQJ5KDz0JfC164qYfoaZcWMSIfE+46WI4lVlQko5Q5PuPMrZq9QoP2+Qw3/IE1pLCH2sGL6rVkXsm82uTacJbUCxUe3An7H0j/n+dENgrCSGpF5i8=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 DS4PPF9390CCBA1.namprd10.prod.outlook.com (2603:10b6:f:fc00::d33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 11:59:31 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 11:59:30 +0000
Message-ID: <29b65682-d3f5-42b3-a7b2-b9ac78615ca9@oracle.com>
Date: Mon, 22 Sep 2025 12:59:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v1] btf_encoder: move ambiguous_addr flag to
 elf_function
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org
Cc: bpf@vger.kernel.org, acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        eddyz87@gmail.com, olsajiri@gmail.com, kernel-team@meta.com
References: <20250920003656.3592976-1-ihor.solodrai@linux.dev>
 <580f039a-72eb-417b-a435-d9ec0661fb96@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <580f039a-72eb-417b-a435-d9ec0661fb96@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0353.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::16) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|DS4PPF9390CCBA1:EE_
X-MS-Office365-Filtering-Correlation-Id: 2347328f-a5fc-4e29-b6a2-08ddf9cf7cf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWx5SnBsRUpHdW10dC9jZjNlcjFyK1orNU10V3A5S2VBaEFiOFFDT2dmN2pR?=
 =?utf-8?B?M05KTXAwMVprS3kxY2VRMXNwWm5rOEhUL1QrNnk3SG91bksyaS91N05CNjNQ?=
 =?utf-8?B?SmR0THhqUkMyU2ZhZlpzVk1SWnBlOE9DMzE4WVJFRzFuRmZlNVR4UEhpN0wz?=
 =?utf-8?B?ZDN3cFJIQ2hlNTNYUkRGZU84NkMrUUQ3ZEJDR0gxZjZuL3V5dWNiUlNHejA3?=
 =?utf-8?B?SkhQSnJhbFJkMmxLb0prK2dVNkE4dkFBSHUydW9IT0NnS0lKaDVSaW40Tk0y?=
 =?utf-8?B?cUtNcFN1cndXWGdzS21vRjNjcVJwL2ZkTkFBcGZRckZ4NWZic3pqcy8vSjBU?=
 =?utf-8?B?SFFuYnFMdXl1U0lzZEVmYkI4akJVbzcrbm1MMEFQbEVkN2ZxL1lqYXRvOTVx?=
 =?utf-8?B?MkVDdEVhK05LWmVvNGJUY2tOMGJRTXF5Zlc4c2IrUk03dGVTTFRFSS8zYXJy?=
 =?utf-8?B?SUZ0dXBjcElsclZZTUNFLy9QMEZ3R1dFU25CS3Yxdy91WHdEZHY4UGQ2ZTcw?=
 =?utf-8?B?NjFBejk1UHpoQ1MxZmJKNmpJSmNrUmt5K2kwNGRXMWszMUdSWWVCdlBua2to?=
 =?utf-8?B?bzZCKzZvQmlRVzFueWxWVFhMNlhEeHZQbWRlNWMzNmlkcE5jNVB0ekFqZElJ?=
 =?utf-8?B?bm8xMDZySFJRY241REpUV1hoRDdQOUZQVGxHTWZHOC9jQURIc1FObmtYb3pP?=
 =?utf-8?B?ZWw3TUNqd2NGTmVCa3dRYmlEMXpuK0RuSTJpYTdOanJGa2xsclNQcU5lc04y?=
 =?utf-8?B?ZktZc3dRV2JpcjY1ZG5VWVd6dTZHTC9oU1NLV0dHcmdpalRiaU1obW5JUyt5?=
 =?utf-8?B?RlhpeDhVTHZyUVpmRTVNZXdEeDBZRTNIMzdxQ3U3bG0vdUozUUJQSXpvRGkr?=
 =?utf-8?B?WXQ2SmhjOXgrRzlTZ2E5eHBjUzNTYW53MXJKS3VFQXlybHY2MWlZY2xxMWtD?=
 =?utf-8?B?MlJXeVBSRnA0UmlRQkc5ZFo5U2VBZlZoU1pqcFpLSUZteU1UQzYxaVYrR0xi?=
 =?utf-8?B?OHAyeW5NNmhkVHh5cVl4dTVWR3d5ZjhHQUhCKzc5RllqV3ZJV05VZHM0ZldN?=
 =?utf-8?B?TWxFVlBPVDJxTzlCaC9tdkRtdUQ0N3MxSnJGWnlITWNkMzFVazRyOXhPSUtw?=
 =?utf-8?B?Mll2RThCUzBXMXNuS1Jmb2pqK3NFUWlSUWJuOG42ai9BdkFHQklsUE1YeDhw?=
 =?utf-8?B?elh1eHo0VzZVQU92V3FvSDFIYnhoMURvVnRGR0xNV0pTdjdLZ3gvZWVnQVZQ?=
 =?utf-8?B?ZHZQVTBwa3g3UWplSXRmNGtUYjVlZnF6UFpHaEhINGZYbTRQNVZQZ1IzVVRk?=
 =?utf-8?B?OWpnV0JkT3F1QXh1M0RaQ0cvaDdLSzF3S0liV2hWTFhsd2J3cjRLS0NmRm5D?=
 =?utf-8?B?WUEveFZ4WG0rUkU4VzV3YTZPKzU4U0FLOU84SnZCcG1mVlRXWFgxUlVYcEIz?=
 =?utf-8?B?ZkxEQVdVY0FLbXluVGRvdExIS2hITUlsZGUrRDlLcVlSYlJRZDVPN1g4Z3cv?=
 =?utf-8?B?MnVpb2YyeS9XQUhkZGg1dTBnT2tEeDYyd1c1TUNMV2ZFZXNlZjhuWFR1Z1hX?=
 =?utf-8?B?RXBxTGlTeVl5MXBzVmRvRGdIamVNUXpGRm1mTFN3MVV5am9FMlpDQndJUml5?=
 =?utf-8?B?UUJSVjMyTVFINCt3V2hzVUlZekh0SmVkaXREMktCaVY3bTNsS1NPSDVXaG1I?=
 =?utf-8?B?Y1BDQ1MrOWJBWnFWZzUyM3E5MVI3eW94Qm5BUU1vaWZwM1JSa012bGFscGNl?=
 =?utf-8?B?TWtxWnBPQ1gwdWJIZmFpSlpwaFRidy9jWC82OEk1eTVEaWJpdFRPNGxRVVBJ?=
 =?utf-8?B?MFZPUGMyazhHbll2TjBKa0NhTm5zSWlRUmVoYlJyQ1NmRWVTaks5anZxbjdY?=
 =?utf-8?B?ZjhpNWd1N0VxYzhKV244R1BJdStyMWg5NXBjOXliSGNOQWJpbmdjQ3BjdnpI?=
 =?utf-8?Q?Z/jitgmleTQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWtxOEFSL2lsR2U0MC96eEVhc3o4dXc0b1Rtb1lYdXhibE1udTBhbVkwSlRz?=
 =?utf-8?B?UWxYUFhpWUg3SmdUQjNDOW1pZFlMTzRUTjA1a0lYaDBicmoydVhQYXhrSC9k?=
 =?utf-8?B?U1VNSld4VC9OQ0pvcFl3SXA5TzhjTHZYRXg3VmViQTRQYUxiYWVQN1NuV1N3?=
 =?utf-8?B?TU5GM3dlMEtrMkQ3MFhXb3dYcldrYThyazlaVjltRkJlV3c5NitEaEZJY2xM?=
 =?utf-8?B?bS9jYWJYUEhOQ0xocEJ4TElZT3lzeS82a3h0ODZsclZRb3k2S1FJMkNXSE1s?=
 =?utf-8?B?dTdaZnZ4T29RMHZXWVNEanllaGV4S3FzNjJBaGxpQzgwUzBnVDNqdURIYWEz?=
 =?utf-8?B?ZGsxL2JoWGJ4YWY2OU5FMkNoNVROUFFMY0lxcTNITjExSnErelBpK0lxR2Fh?=
 =?utf-8?B?bGpXOUJuWWdPRWhSSXBKZEZGWWFYclBzb2RqSS9zQkx3WXFMN29yRW53TFJD?=
 =?utf-8?B?NTZDYVZSUFUvaExGZ21sd0VRQWRVSmZZemUxdTVSVzcvYnVRVkRsK1FvdzNR?=
 =?utf-8?B?T1AvVVIwS0pQVVZtSjBQd2dtRld3TmtDcW5yOEo2cEpGMDlWNW9iQ2hNQzNs?=
 =?utf-8?B?OGVJei94K1NYZjF5dmZoU1hKUHdvUUVERWN6cFlUK2xEcVExVXZJd1B6TFlO?=
 =?utf-8?B?UFlxczRCa2NzdmpCSGVnVDlCbUFWUnYreGIycEFPdS9KWHQ2eml4ZUU1SlVM?=
 =?utf-8?B?ZFhoZ1p1a3RFZzFYRVNRMGdRT2IxSVFsMlY3VkNva2lGNjhGL0trVm5iMCts?=
 =?utf-8?B?MkdpQkplMUMxWkxJZ24zL3VqTm9BWGRaM0ZGR2tEVjEwQ3IzbmZRL3FhQ29M?=
 =?utf-8?B?dWUrencwYTRremprU2UxUXdrYmpTSVNtN3k3NUh3WkJ0KzZGMGVNZTc0UWtP?=
 =?utf-8?B?UCtsQ0JGKzBxdmw2THc5RnV3akFQVHEycVg2QksvaFBmNlRVV2lzQmZpUTRv?=
 =?utf-8?B?SkRxbk8reUZrSDJFQ0xrSDkzYXovWDhWNjdadkJQL2Npd3VJN1IwQUhRK1Y5?=
 =?utf-8?B?L0tsVkdwNis0Z0FNNDJnQnY4bTF6SXQ5ZjJZZVlwaERtZHVGVkVxWVpDYmtl?=
 =?utf-8?B?RVM3U2RNTjI2aUIzV09BVk1yZFg1bW5qc1JvZ01pY0tHNWQzZTdtMy9IY25I?=
 =?utf-8?B?Ky83bm5Vem82QU00T05LYnlockQxR0llZUV1eHRlNFFGUTlGTjJCZXVhOFox?=
 =?utf-8?B?bWJYRHVXQ2RENXV5YmxFbklnWElGWUlXRjkwVVQ4TFBiTU9PUWdBVnROWHA3?=
 =?utf-8?B?LzlveGZIUFVkVWZ6aVhVWE9mNVlESlJDZWd3RE9VTks1UkxmSkJXWlVhZ2pE?=
 =?utf-8?B?WW9VNWU5TjU2clJKaFpVVmppNS9uWnh2RlpxcG1vVit3cnVLRm5uTWNudjAx?=
 =?utf-8?B?TDNnVU9RSVpjcFNpSTlrMEJoeUNmSjdleUx6YmYrbGQ1NktPbWxYN1pPdFVu?=
 =?utf-8?B?TUJUN1ZwWkdrRy9aSG00Wmx1eGQzckorZm1MbGN5MENETk16ZWh3aWJzYXo5?=
 =?utf-8?B?SzZlZExoNkc3d1l2SFJvUjM4bXVlSldlOXYyZjJxU1c3MWNUTDY5NTNSNUI3?=
 =?utf-8?B?dllqcGZKWFBWRGxDaFhobzFzWHhncFo5WHh1dHo0R0FWWnp5b3dyWENHRjVD?=
 =?utf-8?B?Z2RHYnhWaHY5U3BWSmJndnlUTEhaQnhXZk9DMUFScDFqT0J0UDF4b1ovbDJK?=
 =?utf-8?B?ZEdCS29QQnZlYzFGYzN6WFkvM05uQjFpbjRkNTIzNkJ3Mk8xcXpHMFlZRkR1?=
 =?utf-8?B?dkt6c3Q5eVdmR1lWRGVScDNmVmRmVUYyME1wbFA4WDVPUzg2ZzFjb1MwMFNw?=
 =?utf-8?B?R1l2ZzRDelQyMUpOd3hWWmxLSmpmbE95ZTJwTmxnQU1vMVhlajhuTTF2Sk5B?=
 =?utf-8?B?Y2hWbTIvcFBNVVFESzhFc0REUWNHSC9Kb05GdjQ0WjR2SWNMZXJwNjFHRERL?=
 =?utf-8?B?bTZPMnFWYzJDTVlzemZEUVV3eEFCVmpUQTE5Mnp0YzBKSHRtN3FOOVpWNXM5?=
 =?utf-8?B?Ry9LTG9TaUJwbC8xMitqQUN6Z1RnTENKRGRPYlQ2eWJvc1JyK3lNTHM3NHZF?=
 =?utf-8?B?WVdXT1pWVlNhbHlhYjlHR2o0NGNYbS8wZS9DVFluaHorVnFiTzgzQzRiNnk0?=
 =?utf-8?B?QlpsY3BPN3daczExR2RLSG02TWdIYWViTjFFNVlzWk9MVzN4VUhZNnoxQmt0?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7Y1hytcOgUBUrElp39CqyUBJZsNYtKYLjQvB0SRFpGEeqkxo225rugvKF69Tow9QmSVMvdjcevmEis28k3bP8SYLBThyobePs5QRRoPwOx03qWLZrmDdiX8VFzyyJNH800xDseIHoEcl+wDalGVwxhavH8+WgWo/Nmk9c0U+Ssa88tn+RF+rw7HjC443LPeh2Kw4O5iRytZ2Si4QGdI6MdAZ5JkAMuF/yoHkgaFo4RmHDBZ0rAcYJNO2y1wg9W5XqbQr70A8YR/cUmr4psyz8JXHiorIX+Xz9TKwa/DsgMHSWv0IanLjdtCtgqnqESUfK8pGYYE5vEkog+t/j6lD19u2fK66baZEi94H3tXEVuVolOgxHsrHNJDtzX38tHULGFjZl4oXHN9ecPOW5M1sptHfTBS9UYUJ0IerLo/ZbXCdkEjzpBZjz7shtiFjkOr0iBdJIuM/0IBsJAUsue6BOjbKxle4aevZFbWPRN3VkfJcG+IxDTyjnt2+PYNgcHE1hwfFHmbVTZ7Ld3SsoJ758FmnAlInMZzgRcQ5mo8khrdgUw0tcC+CsSPncC86NmeqCM+S7pMKfNFJH4RAb/N07m8pLw7Oav5ESDMdxL0bwd0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2347328f-a5fc-4e29-b6a2-08ddf9cf7cf5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 11:59:30.9393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kOMUSCiLA3VMVGpY9wj4L8RUQLpjcbKbz2JxtcbxpcLSmPyfY7WI9k4r0xY6SLuiQeKnjBpKoZwZlPVFsxxeNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF9390CCBA1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509220117
X-Proofpoint-ORIG-GUID: bWDSP-9HDaFbWosxdVd-WNUJnXiSafFn
X-Proofpoint-GUID: bWDSP-9HDaFbWosxdVd-WNUJnXiSafFn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyOCBTYWx0ZWRfXzY5gJ5+If0AS
 R1+bk8bR44hCBc4XdaDZUkR3+TZwgg8rUiqPPpypFX/wX38MhFni9+SB/47Se8twH8w04GR/2CS
 iwRg/E7J5nhaZh+FX9ZSs2QfoU9Y6DPIPNr7mYPfCk3PinVIE70/x+d/rTVdYNW7s74tw3DnYgK
 G0taq0E5jY5/cN6R7ib0SBt4SZg9f9oH6KJRuexuFZFB6g9sQ/1vu77vCH+zzJyqoVokHbqfR6J
 hYT4PKi0Vi1f1cztJ7lsGQ/fIdS6TRdf3KKyaj2wf6r0+h4odcD+3/8qBJWzNPZriSB/ds7xJ7A
 0XWtpym6mcv/Oiy8uZR9eP7hnDGcyS5mSVd/KWYf+PUJ/PWypsacBU/COfr/Z902/w7WORZd5pF
 P4/14w+ba1W8SgJxQ3EokdJZPlbT1A==
X-Authority-Analysis: v=2.4 cv=HJrDFptv c=1 sm=1 tr=0 ts=68d13a29 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=ruMe8xyG7t8too32Pn0A:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13614

On 20/09/2025 01:43, Ihor Solodrai wrote:
> On 9/19/25 5:36 PM, Ihor Solodrai wrote:
>> Having an "ambiguous address" in the context of BTF encoding is an
>> attribute of an ELF function, and not any specific DWARF instance of
>> it. Thus it is redundant to maintain this flag in every
>> btf_encoder_func_state, and merging them in btf_encoder__save_func().
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  btf_encoder.c | 47 ++++++++++++++++++++++++-----------------------
>>  1 file changed, 24 insertions(+), 23 deletions(-)
>>
>> [...]
> Hi Alan,
> 
> I've just noticed that you merged v2 of "btf_encoder: group all
> function ELF syms by function name" and not v3 [1] as I expected.
> 
> This patch is essentialy v2->v3 diff merged into current next.
> 
> vmlinux.h is identical between this patch and pahole/next (09c1e9c)
> for a sample vmlinux I had at hand.
>

great, thanks for doing this! I'll do some testing at my end and merge
later this week provided no issues occur. If anyone else has the time to
test that would be great.

Alan

