Return-Path: <bpf+bounces-54583-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D190A6CEE2
	for <lists+bpf@lfdr.de>; Sun, 23 Mar 2025 12:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09D1E18932A2
	for <lists+bpf@lfdr.de>; Sun, 23 Mar 2025 11:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48D42046AA;
	Sun, 23 Mar 2025 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kuiYi4L0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jWGwgZEO"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4702BC13B;
	Sun, 23 Mar 2025 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742728326; cv=fail; b=k5cDtpz+wBjXak+o0ADhmCJs/LwSI1VGh0NPWAm5cOVXemoDCVeSlDNptfnsoLQMu1zdCjluJPd2t9YM2e761yfGC8WiGKvCRxW8jFF29xWQF+wX9uh7wl+XW+fD+cJd4iuVRYq0NP+PzVNoI0PVdm9jNopCQjmjA4+j5zrWNJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742728326; c=relaxed/simple;
	bh=upVO0Andm2tHDc+TgibVti+1GrK2Ziu5xz2lIElR+cI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tYkNRL2y31WfQ6GSg39W3F2hoyavwxLtu3vGQg7tpu9LOfjLs0s0okgyGzx4KLaQc1cEzabLWyGMcFJYkazUikDbAt3xwCQiKMJO/ndADSX/nTd6dCpNQqphbixvseTBYHb8C7jgLz1cQzmt6eL/WHthrcqLxDXLFmn9HwPSmac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kuiYi4L0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jWGwgZEO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52N4pCQI010652;
	Sun, 23 Mar 2025 11:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=EwEuvvMQKPazsFK4+phKycWEM8nPuNxGBxjmreVG1iM=; b=
	kuiYi4L0Jt+n9RBvvi3AvvgQoawQNhWvdnBlT3k55EJkC6+J19UVmxf0e2/T6zTC
	G8VdXaoySTXh+rHP5kCzKHmsaY174d9cGoL4mY0D4nqT43ZsrHlb+P7UOLwGqL92
	Z1kr4Ox141WgYlb2wdS8szOKLQYr+Wn4xxRIOv+ghVTqmYLFvqBVEyLur5pgs0Ju
	Yf4PKcznHSP6StGvsRWMsCnKnhc8F1GzXwV1jcPoQd/+if/QO9ehBsNdqyMN16wp
	w4025hdxBO3BCbvPTQQM5Y+IlXR6c1TBjeJZo8DS2qeiW89BmnHlscWLsZFRYArB
	F8d3lttTMGRGTS9yEe/R0g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn7dj1v1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Mar 2025 11:11:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52N9jUsu025669;
	Sun, 23 Mar 2025 11:11:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45hkn6quqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Mar 2025 11:11:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdA0C9Elj+Bz7CJ0zt6R9RhIgeI5nW91rxKbvV5zx0LeixOQz29s/ze3ru1FgSnOsxWvoXoLkIugwjwADZafpyn0UTbDygfgw7uQldyaoDfpCMdUvIRgZoEbBx/QBSWBCfuUMaZ03+YmL6n6wqoZizIlr13PMDDquZgZdy4dT36cZbcnyYnOzWGjGaWXE2/Dy2x+ewwdGg6oasMUtvXhPdJ+/o0SG3Jza/yQZw47JEbPsXALSReBcR8EuaWxH9NgUuET7jLf1Wdx9OkxE43XKNFx8cbfDMMEf9MVNqYF+xWaE9NDgwaHkS3BT4NSSRNthrRx0Ch2bQLLjxstHD6DEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwEuvvMQKPazsFK4+phKycWEM8nPuNxGBxjmreVG1iM=;
 b=aRqt9KA0/rZISaPt+uFBIUF9ADzixmLVw4Ly6WcK483lCuWnimJ5Ks/756kRNlzciZ/dEjN0G5Ov/HZb3I85+uyn4ugqTDcQdMkOmDqH1cuzBx4ellQTV5SRCps+cSKEAQ0thvKAYMlFhkladHsow/gLwcU4jUfv1HpSi3Tkcbig0Ua7G1c54tNcXqPM01ufu/4kwDCjNDx9dBdc+ueC0ReBAiaEHCpgvOZ+DYHlF9/bwS9YdgAVI9tuPW45yJIg3HpXURfr2QQxhKz8BFW7ENXqJ4U/G99HsjcaDhR3QHtgo3odg5IwMH/vG/ReRWTgc+q2t5A6h+NVkFEbhwAZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwEuvvMQKPazsFK4+phKycWEM8nPuNxGBxjmreVG1iM=;
 b=jWGwgZEOKTNBStgeG80IckV1797sTWqG/ajsfRTX5an7eW29fSx1GNiTK2HmHX8lot9DeXtKQ3vRJsMTM0VnOLwmpjynihIz3WMMUcus30Bzdy0SnX59CNZQv1kSRjITyaq5j0YuboPv2TC1OaQTj3nvTyUeTqfsZcTelcTmeos=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS7PR10MB4975.namprd10.prod.outlook.com (2603:10b6:5:3b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Sun, 23 Mar
 2025 11:11:28 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.8534.040; Sun, 23 Mar 2025
 11:11:27 +0000
Message-ID: <b1a23727-098e-473b-8282-8fb0cbf97603@oracle.com>
Date: Sun, 23 Mar 2025 11:11:22 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v4 0/6] btf_encoder: emit type tags for bpf_arena
 pointers
From: Alan Maguire <alan.maguire@oracle.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
        mykolal@fb.com, kernel-team@meta.com
References: <20250228194654.1022535-1-ihor.solodrai@linux.dev>
 <9c3d6c77c79bfa2175a727886ce235152054f605@linux.dev>
 <27f725da-eeda-4921-b0f1-c84b95337e17@oracle.com>
Content-Language: en-GB
In-Reply-To: <27f725da-eeda-4921-b0f1-c84b95337e17@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0243.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::7) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS7PR10MB4975:EE_
X-MS-Office365-Filtering-Correlation-Id: ba921da9-92cf-442c-4969-08dd69fb74b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WXpncDhhUGtMVUZQZ2tIcU9mWkt5OU0xaDl6M2RRTXpDSGlZekM5OXNONzVx?=
 =?utf-8?B?dm5zS2NSbWdvck1YUjZSenRPSE1VT00rSG4yVTdwSlJGQ3M5N2ZTKzhYUEJO?=
 =?utf-8?B?czJ0Uk5OWW11WGMzRFlKZmhYWHRTK2QzZDVUMEt4NGhlRHRxa3Q4ai9mTVNO?=
 =?utf-8?B?bHVoNDYzb0YydzQwQmtlcHlmY3luQVM3Lyt0MmRaNnhEdjFnMitaRTVBTW9I?=
 =?utf-8?B?N1UzYStlalZsTEJGSDNuWXJTWkFIZGJITERLUk94aGtkdXJpcHVmVGFoSWph?=
 =?utf-8?B?Tm9lTHF3ODN2eS96WkhSQllIdFBaQUNEalBxcWx0V3N4eFpZeW1PblBLOTVp?=
 =?utf-8?B?V1VQdE91WklUMVYzWmFjMTFEVU5iSVNiejNtdFdlaFI0dnhrOGE3UUlCTDlT?=
 =?utf-8?B?UDlxQ2Z6bnZCRzBQT3kreUNYRm54aXI5d3Exc0NCSnRBVTJVb3IyamlKK085?=
 =?utf-8?B?UTAwMW12M0dMWG1idlBieHN4eFI5dFVKN2dOVG5EZm1jN0pDS1d3eExMb0tt?=
 =?utf-8?B?MnYzSkpPM2ZnSmprZ3AwREhheEQ1R2htZXZYRlp1R0QvSjdIWE5ZK21mNVJ0?=
 =?utf-8?B?YVk1eWYySndUM29kZnJtU0ppL1M2V3pHdXkzVkxTczN1dGhzK01oMXozS2hj?=
 =?utf-8?B?NS9XcUFnMjVIKzJGbVZhUmpxMi8ya3pVRkhlNnMvdmwzaUxWWHptM1Bub1l1?=
 =?utf-8?B?R3pPbC9EOWp6aXAzVytxYUxCTTduUkVqa1o1QWtYUnFnRzlWWk9hMGRON1Ra?=
 =?utf-8?B?SzdFenExMklxRUY3dHJlZWlDTzFJMEFDTjFQUldrdnc4bGcwYmkvZzFQK0tP?=
 =?utf-8?B?eFpuQzhua0NKQXE2TFJkYjkxbTlTYVd3QXJqOThBMEZJdXFaUWJmZ0xYQ3Vl?=
 =?utf-8?B?ZmhBTlMweUlLWVdreTBxZWFiUlNTNUdCWWdtUVlJY21yT3pyREtzNmtjNmhQ?=
 =?utf-8?B?Y3M5SEl5YTE5UGlXeFBkemMwZi92dnBQeUpabTZFRG5ibTM2a01QL1pubm5L?=
 =?utf-8?B?TkhXWVRwSGxXbUVMWHU3WitCQ1VqY3hET0JsZXBQd2drNm14ZHlqSWkzN2px?=
 =?utf-8?B?K1JPZDcrZzFjRUpWWlJCRmhLNUNFNzBVTHpaSG45V09sZHRCYkwySmVwMWpE?=
 =?utf-8?B?bzBldmJJMTVsOUNLUVdRd29Jcms5TDhNa1ViMXJ2UEZsMTc4Mk95d05iZGpj?=
 =?utf-8?B?Mk5WSGxHa2tYcGsyMjJXWnIyRzJla1ZLQTBpdTA2WElWZTE0UkpqVDI3UnBS?=
 =?utf-8?B?NU0zcFl2QndIL1FLZzlwc29SWnE5M1VMUExML09SQUkyMFRza2NXc2hyQ1FO?=
 =?utf-8?B?cGlDMHJsT1dVRU9SMGVkVlNDVXBTcDFJVEdPVDlPbE9yVzlvS0hEdTBlRXJF?=
 =?utf-8?B?Y0JJd3NSZGdIRDMxWjRiWTd6cXpUVFF5cWozS09OL1dwREM4U1JJQTRnek44?=
 =?utf-8?B?VEVXOFE4QlpMMk8zNDJQTzc3NE1JNnc3S0V4UW8vU1Ixa1B0cGM4cmlDV2Yw?=
 =?utf-8?B?SGpuWk9KNmlMTnVrenVESHRNNTlHeFNuVlU1NDkwVWJRdnJSWk54Z1RROGZK?=
 =?utf-8?B?eW5MbTJzTVEzSVVuNGRGeTVnUzhZU1ltMU5xNC9OUkYzU1NaaExlUEZhMlI5?=
 =?utf-8?B?dGY1bmVlOURBQm1DcUczL3ZLbnkxczl1d1o1V3N0QWJTWW0rSHFsL20xOXZW?=
 =?utf-8?B?M3B0S2Y1RjB6R2oxWFoyclloOTBFSlFRdlBwcGdRclk2QkhaSUNOaWNNVXl4?=
 =?utf-8?B?TzNQMG1rMjdSNHFWOHN0dzRNOUd0aVdxaFRaRzI2MUU3ME1FcFQ0VTRYUUpk?=
 =?utf-8?B?SkR6REhveURMcnBRS2xyZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjhqN3RaYU1QdVd1M0VPaWNFQXBRdnUvbFlFU0RDTzltOUdnaDIwYXgxTTBW?=
 =?utf-8?B?cHpSOWNzWGplZFhaeEJVZWp0RnBsSEMwalU4ckNLOGZBTld1blFXdmdnaitJ?=
 =?utf-8?B?eHZRZ1J0Znp5WjU3bDdzZFJHa2pSQzFsZWtnazVURWVxN0VvcUdRdGwwS1dI?=
 =?utf-8?B?S3QxdXR4STR6UCt1WkdRVzEwWjdISWd4U1pnNUdJMHZKd3hCZ3BGeHhjTU9s?=
 =?utf-8?B?OUZ1NUFycHhTRHZQbzEwaXRIZFhrazA2ZmVCU3orRnAvd1c0SjhYTHpXSCtM?=
 =?utf-8?B?Sk5wTWQvSDVLNHEzbU9LVnpQODJFRlJWVC9TWm14YkNKaVBWZ0pSamk1Z05W?=
 =?utf-8?B?YXhjVWNQektVTGRzaloyQmQyL0RDU0FaS0tCbHJ5SDJ0aW1PbkZyYWtXUExI?=
 =?utf-8?B?NzBlUDhjY3VnVnozOUJZcG44UUJsWDZNOFJjWWtodjEyeEhIVWpSRGViK2dK?=
 =?utf-8?B?eXk2S0ViQSt4THNlSE5jaThDQzdMVDdSOEZEeHBSSnJ1aTN4Wm1JQmpZZXJz?=
 =?utf-8?B?cXRoSURqa1RWdWdMczdWdDBZMTVGbms5dlhmRCt5TG1CTEd3R3R0a2hIdnk4?=
 =?utf-8?B?dWFHNjFrQUZTUm0wcXJHc2w2TFF5dEYzcHZTN2FVK0NUVWdQeWtYSjBld0U0?=
 =?utf-8?B?YTJBZnhlQnRJZmZHTlpJMnp5bEdxQ0FoQWJqS2Z4bTVOVzZpT1p2emt5MmpN?=
 =?utf-8?B?M3R0aUZDaUpvRzhUMDB0enlCL1JkTXVnZit0V1huZ1Fsb3VhNzZ3UWt4SVRu?=
 =?utf-8?B?N2k3dnZUUXZxMFpKTm5jVkp5M2xONXB5K2pYdmU1c01DR3RCZWk3dG52RWlm?=
 =?utf-8?B?ekVEdHUvTkFGWGpnNGlLanhFb3UvM0tRam1pR3Q5bFMxMGI1b0xaTUMzNEtR?=
 =?utf-8?B?QlZqbks0aXYwMDAzNytyWXQwYlNHZXg1VUJyeU5kdk9IanMxbEdxUG4rNXgx?=
 =?utf-8?B?YXlNVWNtWWpDaXgyM0huQjYrUTcwbk1QYWlISklaemp6SlMwY3l3MUQ5VGJV?=
 =?utf-8?B?cDhOemtJVnIxZmFVWkpzQlluVzBDUU92bDhNNS9EMUhhcytTWnIrcVhMYlhE?=
 =?utf-8?B?WEdDeDdNcW1aY1ZkakFRbzdhUnZGbnUvYXhtZUU0TWNFNjZrekJCaENPNWNJ?=
 =?utf-8?B?YjV3cjRYSGU5bkZmblFXNCtYbUpIaUc3NEpKc204ZytsVzZuZ1FvajdWdkpn?=
 =?utf-8?B?cXhlUlFNYVR5UkFhN3M3QVBWOVl1VXZqSUhFeFBhcjhBVmpGWUo0WFdZODY2?=
 =?utf-8?B?Vk0rbTcrcG1oMXNEYkU2ajJ3d3ZNdHF3MHh2dkdOZHJwOVoyaHNQSTJLc0xN?=
 =?utf-8?B?NXZQZ2htcG9jRFhFQlArZmN4cTdXeFI0SE1sT0lNK21CLzlnb0VyNW5Ed1pt?=
 =?utf-8?B?RDFaMklKMnNtcEZPV1RzZlQxRC9uQ1FOYWpSZkdNKzVWQURkdnF6MUFVK3dy?=
 =?utf-8?B?clZwcFBxcnJpYUYxUjduNjZRRHAyVGRSQ2NLazhoWFJqRzkwcnI0cmc0Smhk?=
 =?utf-8?B?RTZUVERxVU9ZVzlBUWFWbHk2STJQb3RacklqOHByUldsZTRvclFUVU1tWnk4?=
 =?utf-8?B?TkMzT1c0aXJWQTBZeGxiRkJFU2RTZUg5azJqUkNzQk9HQmpuZFBNVlRIWHpt?=
 =?utf-8?B?Y1FFU2NiN0o3REk1RW9uYXdtUzk2dkpra28wRlk4Tk4xVmx6VDZnOHllL1ZK?=
 =?utf-8?B?aDhhVjQzSWE3ZjJ3aEVJZThuWEUrVjZIeGZRV1ZjWm5JU1RVRTVRcFVPUkhX?=
 =?utf-8?B?VndaV29NenVsMDVzTVpHV1pyYmNOR1crc1k5b2JvU3dBOVpBcmFhY2tVVkp6?=
 =?utf-8?B?cEI2RVV4UFpPdkFwdm9CNWliQU41YVdTL3E3Z2J6Zk1MNThBbCtrNmxrcm9z?=
 =?utf-8?B?MzBhVkJkZ3VHdWhDeVhrMTgrU2h1VmZpZUdtWnlOSGF0c1hmdWV0Wmg3S1BD?=
 =?utf-8?B?RHpOYS9NVU5rcWpkb0crRk45bmUwTXBZa3BGKzJBVURaa1JUVkFnQlBQSFcr?=
 =?utf-8?B?bjZud015UU1PaDN3RTUwZW4rSlFCNkRhRW4wWElZTWRrZWZFc1ZRbHA1UE9x?=
 =?utf-8?B?S2pJV3hUM2pubVpneDVyQzI4a2JEUDIwVFFoZGZaWGY0U2NWTG5lWmo0elZs?=
 =?utf-8?B?L3dYSFJZejlTak9TK0ZyUDZPdFozbkh4c2RhWG5hUFgwMkhZQU9oeDdLOTA4?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GnsAvJ7Klx6Wp00B4qMXKi9b8+YFToLpaMSPiWu1hghw6/OtPy/7henR5NTUJz/oIhaCGWsTUl1bxC5THWEkvp7BAkJ8nB4toRj1KqX+YUojlth12vSJYrEFEjR4ZHAmK3E2P7PSYegZ4+Aip0Mvz3l32LXLxYIMTeX8+AcW0fKeFwqi78GxBcCkpoLF80kCe2FxxnbHhg9OqVux9e8UpF7rMWKWyrbZ1rJcFTekPt67bjYF19U86NED27+5bz7PZ+4Aqrg7p6SIiX85G4CbG6Jpe8I1SmHUaCOornrjynT855GTy9q2eHwxpXveZt1v/FQ2qR2qmsAeTv+D21a3bfxdq7OIreQ/PusRM08ttqCRt7g7nFsSHKDa2h1Arig2uEgQG59ykILKVpZwfBnMNJ3XIRkQwazyV0vMEL8sRntMnglVLESnnp+IonpsBmfwUW172V/0fYAzH8+W7TLmp4EQtFhBUNUtsVEM9HGA8Prcl5mVXomnN/OH5nRsN1uytcqbuBn/9NN4/2zsXTWwPVq0lEIOuXIc3qP16faAHaIHduhEqxSA5qJFNjiKgt+xrrJP+2AsevlpObEpDGU+OAqs0FHZHr3JL5dX+1v26rQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba921da9-92cf-442c-4969-08dd69fb74b0
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2025 11:11:27.4296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epNaPqLwDVwJ1czCNyr+AyKj4NZ81Y6g1LUYW0qE+0i6UAF5zYdFEJOtWa0PumxN5h/HZi32VKDFyMsNF+8X4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4975
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-23_05,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503230083
X-Proofpoint-GUID: oWECkRMSu3wzh8gtl_S7w29pkLTajLxG
X-Proofpoint-ORIG-GUID: oWECkRMSu3wzh8gtl_S7w29pkLTajLxG

On 20/03/2025 20:34, Alan Maguire wrote:
> On 20/03/2025 16:32, Ihor Solodrai wrote:
>> On 2/28/25 11:46 AM, Ihor Solodrai wrote:
>>> This patch series implements emitting appropriate BTF type tags for
>>> argument and return types of kfuncs marked with KF_ARENA_* flags.
>>>
>>> For additional context see the description of BPF patch
>>> "bpf: define KF_ARENA_* flags for bpf_arena kfuncs" [1].
>>>
>>> The feature depends on recent changes in libbpf [2].
>>>
>>> [1] https://lore.kernel.org/bpf/20250206003148.2308659-1-ihor.solodrai@linux.dev/
>>> [2] https://lore.kernel.org/bpf/20250130201239.1429648-1-ihor.solodrai@linux.dev/
>>>
>>> v3->v4:
>>> * Add a patch (#2) replacing compile-time libbpf version checks with
>>> runtime checks for symbol availablility
>>> * Add a patch (#3) bumping libbpf submodule commit to latest master
>>> * Modify "btf_encoder: emit type tags for bpf_arena pointers"
>>> (#2->#4) to not use compile time libbpf version checks
>>>
>>> v2->v3:
>>> * Nits in patch #1
>>>
>>> v1->v2:
>>> * Rewrite patch #1 refactoring btf_encoder__tag_kfuncs(): now the
>>> post-processing step is removed entirely, and kfuncs are tagged in
>>> btf_encoder__add_func().
>>> * Nits and renames in patch #2
>>> * Add patch #4 editing man pages
>>>
>>> v2: https://lore.kernel.org/dwarves/20250212201552.1431219-1-ihor.solodrai@linux.dev/
>>> v1: https://lore.kernel.org/dwarves/20250207021442.155703-1-ihor.solodrai@linux.dev/
>>>
>>> Ihor Solodrai (6):
>>> btf_encoder: refactor btf_encoder__tag_kfuncs()
>>> btf_encoder: use __weak declarations of version-dependent libbpf API
>>> pahole: sync with libbpf mainline
>>> btf_encoder: emit type tags for bpf_arena pointers
>>> pahole: introduce --btf_feature=attributes
>>> man-pages: describe attributes and remove reproducible_build
>>
>> Hi Alan, Arnaldo.
>>
>> This series hasn't received any comments in a while.
>> Do you plan to review/land this?
>>
> 
> Yep, thanks for the reminder; I hit a wall last time I looked a this
> when testing with a shared library libbpf versus embedded but I can get
> around that now so I should have the testing done for both modes tomorrow.
> 

hi Ihor, I took a look at the series and merged it with latest next
branch; results are in

https://web.git.kernel.org/pub/scm/devel/pahole/pahole.git/log/?h=next.attributes-v4

...if you want to take a look.

There are a few small things I think that it would be good to resolve
before landing this.

First, when testing this with -DLIBBPF_EMBEDDED=OFF and a packaged
libbpf 1.5 - which means we wouldn't have the latest attributes-related
libbpf function; I saw:

  BTF     .tmp_vmlinux1.btf.o
btf__add_type_attr is not available, is libbpf < 1.6?
error: failed to encode function 'bbr_cwnd_event': invalid proto
Failed to encode BTF
  NM      .tmp_vmlinux1.syms

...and we got no BTF as a result. Ideally we'd like pahole to encode but
without the attributes feature if not available. Related, we also report
features that are not present, i.e. attributes with
"--supported_btf_features".  So I propose that we make use of the weak
declarations being NULL in an optional feature check function. It is
optionally declared for a feature, and if declared must return true if
the feature is available.

Something like the below works (it's in the next.attributes-v4 branch
too for reference) and it resolves the issue of BTF generation failure
and accurate supported_btf_features reporting. What do you think? Thanks!

Alan

From: Alan Maguire <alan.maguire@oracle.com>
Date: Sun, 23 Mar 2025 11:06:18 +0000
Subject: [PATCH] pahole: add a BTF feature check function

It is used to see if functions that BTF features rely on are
really there; weak declarations mean they will be NULL if not
in non-embedded linked libbpf.

This gives us more accurate --supported_btf_features reporting also.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 pahole.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/pahole.c b/pahole.c
index 4a2b1ce..8304ba4 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1183,10 +1183,31 @@ ARGP_PROGRAM_VERSION_HOOK_DEF =
dwarves_print_version;
  * floats, etc.  This ensures backwards compatibility.
  */
 #define BTF_DEFAULT_FEATURE(name, alias, initial_value)		\
-	{ #name, #alias, &conf_load.alias, initial_value, true }
+	{ #name, #alias, &conf_load.alias, initial_value, true, NULL }
+
+#define BTF_DEFAULT_FEATURE_CHECK(name, alias, initial_value,
feature_check)	\
+	{ #name, #alias, &conf_load.alias, initial_value, true, feature_check }

 #define BTF_NON_DEFAULT_FEATURE(name, alias, initial_value)	\
-	{ #name, #alias, &conf_load.alias, initial_value, false }
+	{ #name, #alias, &conf_load.alias, initial_value, false, NULL }
+
+#define BTF_NON_DEFAULT_FEATURE_CHECK(name, alias, initial_value,
feature_check) \
+	{ #name, #alias, &conf_load.alias, initial_value, false, feature_check }
+
+static bool enum64_check(void)
+{
+	return btf__add_enum64 != NULL;
+}
+
+static bool distilled_base_check(void)
+{
+	return btf__distill_base != NULL;
+}
+
+static bool attributes_check(void)
+{
+	return btf__add_type_attr != NULL;
+}

 struct btf_feature {
 	const char      *name;
@@ -1196,20 +1217,23 @@ struct btf_feature {
 	bool		default_enabled;	/* some nonstandard features may not
 						 * be enabled for --btf_features=default
 						 */
+	bool		(*feature_check)(void);
 } btf_features[] = {
 	BTF_DEFAULT_FEATURE(encode_force, btf_encode_force, false),
 	BTF_DEFAULT_FEATURE(var, skip_encoding_btf_vars, true),
 	BTF_DEFAULT_FEATURE(float, btf_gen_floats, false),
 	BTF_DEFAULT_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true),
 	BTF_DEFAULT_FEATURE(type_tag, skip_encoding_btf_type_tag, true),
-	BTF_DEFAULT_FEATURE(enum64, skip_encoding_btf_enum64, true),
+	BTF_DEFAULT_FEATURE_CHECK(enum64, skip_encoding_btf_enum64, true,
enum64_check),
 	BTF_DEFAULT_FEATURE(optimized_func, btf_gen_optimized, false),
 	BTF_DEFAULT_FEATURE(consistent_func,
skip_encoding_btf_inconsistent_proto, false),
 	BTF_DEFAULT_FEATURE(decl_tag_kfuncs, btf_decl_tag_kfuncs, false),
 	BTF_NON_DEFAULT_FEATURE(reproducible_build, reproducible_build, false),
-	BTF_NON_DEFAULT_FEATURE(distilled_base, btf_gen_distilled_base, false),
+	BTF_NON_DEFAULT_FEATURE_CHECK(distilled_base, btf_gen_distilled_base,
false,
+				      distilled_base_check),
 	BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
-	BTF_NON_DEFAULT_FEATURE(attributes, btf_attributes, false),
+	BTF_NON_DEFAULT_FEATURE_CHECK(attributes, btf_attributes, false,
+				      attributes_check),
 };

 #define BTF_MAX_FEATURE_STR	1024
@@ -1248,7 +1272,8 @@ static void enable_btf_feature(struct btf_feature
*feature)
 	/* switch "initial-off" features on, and "initial-on" features
 	 * off; i.e. negate the initial value.
 	 */
-	*feature->conf_value = !feature->initial_value;
+	if (!feature->feature_check || feature->feature_check())
+		*feature->conf_value = !feature->initial_value;
 }

 static void show_supported_btf_features(FILE *output)
@@ -1256,6 +1281,8 @@ static void show_supported_btf_features(FILE *output)
 	int i;

 	for (i = 0; i < ARRAY_SIZE(btf_features); i++) {
+		if (btf_features[i].feature_check && !btf_features[i].feature_check())
+			continue;
 		if (i > 0)
 			fprintf(output, ",");
 		fprintf(output, "%s", btf_features[i].name);
-- 
2.39.3


