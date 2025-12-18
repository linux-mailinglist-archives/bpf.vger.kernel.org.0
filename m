Return-Path: <bpf+bounces-76997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA195CCC7FB
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 16:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD5A83093D95
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76A4325483;
	Thu, 18 Dec 2025 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ONEGGIxj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA132DF3DA;
	Thu, 18 Dec 2025 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766071766; cv=fail; b=WmI9dqYr+jO245YUFBLyxKMandwkwFUZmSKZZ23aRYIzYXzQWnMCXHuWTA7q9nRKevzMm9sCFP6iolBw6IMpW9eWG5N65gQMiWME74ZjMM8jp/CSqURuJw2GDLehOXTvzDL586xsLT3k8pTJHmDS8AS7HiHAptH23/zO/vqsJwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766071766; c=relaxed/simple;
	bh=b0AFoYJc6NoLjY/KkAO56PEVbUcEhU/Bb65HeRdVPvg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RqZIczSYywfuIKthiLRjycMbwRNR5VrBvWK8G5o2Y0y7KqlW4ZbMvr5HTvs7j5PChNUUNeUNh2lsgEhOB/fkjam7HER7yBi3Nw+H2Qa3KkeA//UYr6pCOWnRq3ymUCnvOB6w5/ouIc/7+vy7Kpl7hV6YXmOTIR584cBiuciZeX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ONEGGIxj; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BI57Dqp753521;
	Thu, 18 Dec 2025 07:27:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=g9x6KPcV+YLliVU/U3VOQXq+3RTocS5qmeUoyu9y2Do=; b=ONEGGIxj9R7I
	6MNjlgHuyhxCx9fNZqpHx57W5bB6+Ka8fSftmv0KM9lRwsTlHfFYPQTEQBis+uOJ
	aI+zS43W0xzf9oDIxW/MPpyKVWLslMZY6Rd/RdGPxWSnCBo/rydwh7hMgOhk22iJ
	Zj3bm9ibX1V7W/LGl6UwUjg0/FnUMFe6meqkS9cd3vWYZRrm6WmzbWCZFNJh9aV/
	HDDaWiWneX3N5QNDCo56rky0qVd14FAAuHtgRJrXvLVXykZ+LVMZ4a+lElQUIpq2
	iuVeuHpoA/K0T9MG02Mz++eU+Z0e/S8OcSPVa4iqFSLG9qBLkDhATaudMfigm5xR
	dArGWJAIvQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4b4b6c3m0d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 07:27:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFuCtA7k0+jRvCCU/0W/KqBum1/FpLwUn9wKQysKDGM/oOv1V50KqBWlKUek6evvotArjGphn/mHAfp1ica4XyMeY0Iu7pOWWY+A4lH+tKWrT5I5wggofuMBPygMjb4yitRWl+8uRVf53iqcssgFD6uB9JBXk8ZQYnRK3B6K4xZShpOCYGWJM4+6q+CKUZ3Nt3LK5XUICxN1Uk2f9Sfgy/5itKHxrsTZ0hgeHdl8BSRyBLnrXMLhEMRQGT8ewoDuxQj/VuWkKhAXwcFGlj5dXQBU2X7KT8hDp12hvSQ8tGArlKljXex2kJ57oM7ViY9c3SacaWdvuAP4xlNe0kzCFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9x6KPcV+YLliVU/U3VOQXq+3RTocS5qmeUoyu9y2Do=;
 b=jA9v8cN5AfXW3Y7XbWnTM1upMEurOYOQhzkss3OinNNg+xxfTWuZT18kDzg25YUc1VrG8yqU3uxxn7q+jTQwkfwRrW1DJWzY0hTPTVma9e0YcUVB52GhFGKTljhleNK20MOS3ofq5i8UN+WmxGtAsn9t776cqVx8R7SLjrsPDYsgZAOORKMyNJpID7zwpfIbewdADmaDKGU7fEKG66+MY5AzUBuY0CUPwtkSq987Cri4km91lS2io/aW0+X+LTx9epDgASy74kDeuH5MLrIQ+8QfIM/V3GNUAwQN3M6ee73XmJgKHWBsJRb5ZWerbeMxTSZZvVSHlqAky+MM0FeG6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by SA1PR15MB4705.namprd15.prod.outlook.com (2603:10b6:806:19c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 15:26:55 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 15:26:55 +0000
Message-ID: <b30af462-4bd0-4ee0-9ec9-9607204d099c@meta.com>
Date: Thu, 18 Dec 2025 10:26:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] LoongArch: ftrace: Refactor register restoration
 in ftrace_common_return
To: Chenghao Duan <duanchenghao@kylinos.cn>, bot+bpf-ci@kernel.org
Cc: yangtiezhu@loongson.cn, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, hengqi.chen@gmail.com, chenhuacai@kernel.org,
        kernel@xen0n.name, zhangtianyang@loongson.cn, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        bpf@vger.kernel.org, youling.tang@linux.dev, jianghaoran@kylinos.cn,
        vincent.mc.li@gmail.com, linux-trace-kernel@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
        ihor.solodrai@linux.dev
References: <20251217061435.802204-2-duanchenghao@kylinos.cn>
 <5c7c7239a6f89e685f69093ff84fe686c75cf6b9b051dcbf812841f00ab3bc31@mail.kernel.org>
 <20251218012656.GA75051@chenghao-pc>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <20251218012656.GA75051@chenghao-pc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:208:91::20) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|SA1PR15MB4705:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd074d6-4bc8-413d-a64e-08de3e49e0b3
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmJQcWMzczlFNTkyeHNtVHNtYXY2NjN6bTR4V0YvdXRjVC8wSHhySFZFOVo5?=
 =?utf-8?B?ck1kUm5aQ0RyZ0lrR2t0V04xUjlvMkJoc0JpeWI0Y0swUmhjTm9WUTZqNUNt?=
 =?utf-8?B?K2hSWkZmQ0NMTTV4aHVsSndkdVUwcW56aVY1UnJMaXFUMGV2SVhwUkQ4ekxq?=
 =?utf-8?B?N3d6S05Zd21oOSsxenFPcFpHZkJmeGZhQXlhTkVmYU9sMTlGZjJxSXRKekQ2?=
 =?utf-8?B?U29HRE16dERuR1IwenkrWTRjb0t2aUh6MGRxSEQyL3RNbEYwTDZYQ2JGbmVQ?=
 =?utf-8?B?RzdDbFlUU3hDcThGdHlaL3BnWTdSRXNxc29LeStWc2llUjA0YjlzYkN2S0dF?=
 =?utf-8?B?RXI2ZGE2SDEydVR6VkxvcHJBK1Fsek41OXdGUm9Bd1JOeEFYYjBlVkZkR1hZ?=
 =?utf-8?B?ZjFIOXJKZFBqS1F1KzRyRTV5Vk5oeG1YL1orKzF3NUtkUUhiWEgxdEJCenpu?=
 =?utf-8?B?NWxEZkNOZVBGQitCSUtaaEREclNWQThvNnNKNzdURm9TdG53K21LdS9leUlH?=
 =?utf-8?B?U3BHZ0kxMWs5MjNTc0drRGFzLzFNbTBaY2lKVXk4S2JZQmxPQ2FhYWRhVmQ0?=
 =?utf-8?B?cW52aXR2ZWZQMXZCNGhOUDRJWXJyYW9ScUJrYXVleGQvUm5IemNoL2gySlNW?=
 =?utf-8?B?UHpvdEg0c3JiM3hJaGd3Sk8zN2JpZXdvMDVBY2lZR2xEbzVHRlhsNHFPMm4v?=
 =?utf-8?B?RytENU1uS0tPc3ZCQ2x0alFCMURHRmVuSTFuaVErMGpsdVZ4RlMxaFliR0hW?=
 =?utf-8?B?ODcyZGpYakh2SWsyWGNLbW4wY1VZdjNuVkp5c3B6N1hzT3FIemlOUDdHaWlN?=
 =?utf-8?B?aVJZbTN6L013YTJETGpFYVV6TjY4UDYrMndMaWJYWXFwWUxuOVFkTGlUWC9r?=
 =?utf-8?B?S1MzbmdDSk5tbUh1Zy9wQ1FSYVMvQXBsMWpqYmxqZHl4WGdHeWM5aUhLb2dB?=
 =?utf-8?B?bzlRS3lkK0w2dVVkZnNXQlAxR00valFuSUFibjYzeFhsanJuUUEweWpnSktU?=
 =?utf-8?B?Ui8rRUFrdWJhcmd1aUl3NUdtOXNIUHo3UkZYeFFBY1UyNjB5RS9qd1R4N1F2?=
 =?utf-8?B?WkxTTjloLzZKVk1Bek5iK3VKbXpGMnM1K1VsUy80bUdvOEtFOFNidFl0UFNj?=
 =?utf-8?B?SGlwamZ3ekFWWmRva3laMWJFbmJZS3J6T3paTlVmUi8zdkNsNFVIT2doSVZM?=
 =?utf-8?B?cld5akx6UEJmMFdURExKcHZkUmNxYlBURFdvampLUmlUK3VlMm5lUS9PMFdS?=
 =?utf-8?B?dGJGeEhKZTlJdngvNFRuRlZHS2gvSk5wNjJxeEY1akpKZnlmQ1ArZEpFam1j?=
 =?utf-8?B?bkZ5K1Byd3RVbTd1K3hYN01pdnJjMEUzaUVqenhZMitYODk2K0EwOXREbUtF?=
 =?utf-8?B?djBuZVVDdW1kNG8vUGIyenJaai83cllablpYejJJMTQ3amh1a3RGY1B1RG51?=
 =?utf-8?B?YlRhNEtWeFRHTTVNN2FXZUFMeHg5SXR2Q0xxd0lPMmYvRnhyLzdTSjcxaHBV?=
 =?utf-8?B?bG1QajVBWXZaOUpLQmZGMHVacG9Ndm1sakFxWWZZQWtxSmZHT2RzcHRxaWpL?=
 =?utf-8?B?NDE1OE9aMUM3ZXhhV2tiT21SRUcwWHpzZkE3NWgxOXlkcDBuQ1ZtOEtNeFNQ?=
 =?utf-8?B?U1VGR1BZUWFBbGpxT0llTkI0eDhocDlVUjFJT2lWMzBOazgvVTMvcDc0UUlu?=
 =?utf-8?B?KytKREdrczJUdFpkdUZaa2xieGVpZ1FqRSszZFRzS2hOZGY3NEhUOVllM3k5?=
 =?utf-8?B?WFJ4MjVpTDVaRkRSdnd1WHdJR051dmdQUkNXMmJLcVNSdk9sTldSVFA0bndS?=
 =?utf-8?B?bVVmTjlWZTI1MHdOUDUwV01haC9zMXdWU3VIT255dmpnNmFNMERyUEZTOFJZ?=
 =?utf-8?B?MmF0ajZuT1Q1cTN2NDd0ODNEclh4c1dmcGFtMEo3QVptTzB4Z3c3aHd3cm5t?=
 =?utf-8?Q?lw7nST+68TVLfCsor0Nqu/bohviyyYOA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OHIyRUh1eHdycnVMcXJpWlhIZlNTS1kvdVN1aGhnYmk2NVdOMm5qdnJ5VWg4?=
 =?utf-8?B?RlFTMmJqK0dUMm1TOVlrZjdpQWtSVjFwWmZyVHNIMlk1d0JLeTMvMk9GZHl5?=
 =?utf-8?B?NGRrZEpnZGF2Zkc5blY5UWJnRFNSRVYxSmRSWk42UDR6WFc2UzEyOERtT3ZL?=
 =?utf-8?B?RTUxRUNqSi9rVCtwcjcybUR3T09aRW9LTmw1UTJpTEw5bWhYWlc1Yy9scTQy?=
 =?utf-8?B?ZWpFaE44U2J3ZDIvaUJrKzdQTkdFZ1pDOWNwdldTQTFjRkd6Mzlpd0dJYm1L?=
 =?utf-8?B?NlZ2T05LMWR2SnB0MEsyL2hjNzdCTkpEUm1mVmx4a1lRV2NoVll5cTR0THVQ?=
 =?utf-8?B?UVRxWTRScUJ5a3U3M213R3dDV0F1enExeFRFOHhYaVBHeFZhdy83MWRxUG1X?=
 =?utf-8?B?a3BuazRSbHdhUURkNFdpN2IwcVAwcjdmTTRTWFJpRFRFTHJCZjVxVzNMTUNl?=
 =?utf-8?B?aEd2VlZXMjFXekp2TmtLcGQ0dFk4R1l5c0MxSDZqazBGTmgrQ1BYUlhWWXJ0?=
 =?utf-8?B?WTB1YXRqaDZuTWp1M2UrRk50dm1QTEVzUTBHalhNdWRwaXVJK2Nlc3RDenlM?=
 =?utf-8?B?Ymt4UmpYVHk4TXFDa1Z5dXpIMGpkYkhnQXU3ZjkxSHJFdlhLdU5MMEY1TW9N?=
 =?utf-8?B?U0J3QU4rYmJIMklOdktzVmJnYjA5NHpmZmllTjR0MndhakN4V2xnc3d4TFJ6?=
 =?utf-8?B?NVFBSHlJNXpoQXFUY0NnR05XYTlONEVVRjVtOGxMZW5ud1BzTlJBVWVqWnlT?=
 =?utf-8?B?Ni83ajlHSFRoQXpFL0VpQThDa1hxZWQxdnkxTnVMbjYwRE9FZXd5MlAxQUdn?=
 =?utf-8?B?V2UvZlpuTHJrQWI3Q0czU05lZS8xandpNzBOc28vRmc1UDZOQjRabUFad3Mr?=
 =?utf-8?B?ZlFVbk5xWEtUUUtlREpWUFNIakdtTW4wZ2NtK3k0d0dLc2dENlZNWjdWT0hm?=
 =?utf-8?B?MGFuZFVZbDdjTkdsd1lScXlEK091bjZ5Rzc4SHlCVnN4c3pDTnR4dStyMElm?=
 =?utf-8?B?VWZIQktNTlhNbUZtSkFuMm9HSTZtbUt1eXpic0xMc09FOHBOS3hCRDZ5blZJ?=
 =?utf-8?B?cmh6L1IzL1pkM3o2WWVqSDBEQnpvcGV1bG5RNnpzU1FZNmVxV3Jkb1RmWGx4?=
 =?utf-8?B?b3NJZkx1djNZZmVRNzBEcUlXQmtpcnVxTER0a0o2blU4ZXhRWS92ODBtdDJ3?=
 =?utf-8?B?SnJJYXozaS8rMG9BQjU5bkQwc25JbUhkT3FFa0FiSGZtZXZ4VC9KMlVuNXRk?=
 =?utf-8?B?d09SNWg5RkxhSElUbVlKMk1mZkhZNHVscVFNdVJCWFpMVm1sMVkzL0pTdEF1?=
 =?utf-8?B?eVRLOVE3WDBkOVRPYlJSbHQ0VXpCU1MyQlc5VzluMGF6QnpBZE54ZEZnRW1r?=
 =?utf-8?B?dE1kSDBrVTFVTUJsZHVIVDdLeHdyUDZ5QkVySkthNTRDQXBQRjVNMGtvOXAx?=
 =?utf-8?B?MklEc2NDWHZrVVFqQ3RnakpMdkFZU2M3UlRlTlZyTzdTY3J5NEhZWnY3SHpF?=
 =?utf-8?B?b0lqY1N5V2N0L1Z6T3ozbHdJREg0bHJXRlZaK2NPVk1XNkZOWFZVMUE0SjBZ?=
 =?utf-8?B?VmtZTTE0YklubEpBVXR3WUx6OWYzZ0xKckJsejBrQTd5MUhQWEFZSDFmUXUx?=
 =?utf-8?B?MzJLY1NJZk9sWGZHdDFKVFp5NzQzU3VEcFdSeVZSUVE4UFhxdXdNcmZ3c1BU?=
 =?utf-8?B?R1VkOXl2N3VmYlFTL0Zka3RxK1JaUVdGbzM3NEgzNHNSQWRUUE9tUjA4eTR0?=
 =?utf-8?B?TEtJK0JVUDZrQlk3cXB5YTdReHNvS3FxYUluOFJydVBFbUhZWlNzOEV0UkYz?=
 =?utf-8?B?ajRoNDhTYWx1dEJUaTZqT2lHZThsREtZN1ZjU0RwakN4Y0ZYdWV4T0IrcHFS?=
 =?utf-8?B?NzdlbUdUSEhJZXU0KzZFdVZ1bWo1b2RwUGNrc0QyYjlvTFpGa0pXc3ZZUlhH?=
 =?utf-8?B?WlRJT0dRNWsyaDhIZGpLV3M5NC84VzlPUW9ZOC93M2xPdGNBQXlrWlhPMkg3?=
 =?utf-8?B?anVVS291YWM1clpiUkRvamJuS2Z1YTdvUjcxbWtiMENPdXRXWFBTalBQSjJC?=
 =?utf-8?B?MFc3LzBaNFNUL1NwV1pzclJPMDJSV1c0c05GOGowU2VHZ24xYys2ckhvdW9y?=
 =?utf-8?Q?W84M=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd074d6-4bc8-413d-a64e-08de3e49e0b3
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 15:26:55.7879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: leWcNVWT0WIdcosrpxkkr2C3xZV+ybDbYEUSfQ64zaTFyjZ4LwufedoWelqnRrkJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4705
X-Proofpoint-ORIG-GUID: VUHO4vy9z0J9JW6D_ADvcOHWCxFWuMV1
X-Proofpoint-GUID: VUHO4vy9z0J9JW6D_ADvcOHWCxFWuMV1
X-Authority-Analysis: v=2.4 cv=YLeSCBGx c=1 sm=1 tr=0 ts=69441d44 cx=c_pps
 a=Ul8IY3gNdN0J7lfmD5e20A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=ZUV5OvUVkNxxVa8g-PUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE4MDEyOCBTYWx0ZWRfXyrOCbyOUn+cC
 JIOcolYuvyMkfzvOYQ4MwotXY3YQYzL2/Eu9J0+7dl8mbkVe/Dqh32fhFnwi30DwM5orcqB/jcc
 /Ko9IaOV/4CVPs2CgSQci5JNZlwGk9b5EusZgLMxgsH/RlfcyK77fQf0IngjSWZBZ94vrxMpTQC
 /yhaCT48rhNhti8sOGtqeLL72m/5xYGs0jD2xnvd8g78ScXMgywty4EvYjqWVDYn9pTf2Guatid
 eNwSKLdV0jNL3BXfNC38uM5oJlDSMTgRzTC0G6wNaPDLFiRS00i48wJqk1h3k3+A9Rn4ryO9tOV
 a6ge6Uy8GvA4w2tthYH0sFEb4rnwEM5Ypzw9jkgazlIRBAvoSQvXp9rhWCq4CIYBI+9yZ55qPXi
 1IVnwCdjMfsWt6Muy/hbQfhR+q+f7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_02,2025-12-17_02,2025-10-01_01

On 12/17/25 8:26 PM, Chenghao Duan wrote:
> On Wed, Dec 17, 2025 at 06:55:00AM +0000, bot+bpf-ci@kernel.org wrote:
>>> diff --git a/arch/loongarch/kernel/mcount_dyn.S b/arch/loongarch/kernel/mcount_dyn.S
>>> index d6b474ad1d5e..5729c20e5b8b 100644
>>> --- a/arch/loongarch/kernel/mcount_dyn.S
>>> +++ b/arch/loongarch/kernel/mcount_dyn.S
>>> @@ -94,7 +94,6 @@ SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
>>>   * at the callsite, so there is no need to restore the T series regs.
>>>   */
>>>  ftrace_common_return:
>>> -	PTR_L		ra, sp, PT_R1
>>>  	PTR_L		a0, sp, PT_R4
>>>  	PTR_L		a1, sp, PT_R5
>>>  	PTR_L		a2, sp, PT_R6
>>> @@ -104,12 +103,17 @@ ftrace_common_return:
>>>  	PTR_L		a6, sp, PT_R10
>>>  	PTR_L		a7, sp, PT_R11
>>>  	PTR_L		fp, sp, PT_R22
>>> -	PTR_L		t0, sp, PT_ERA
>>>  	PTR_L		t1, sp, PT_R13
>>> -	PTR_ADDI	sp, sp, PT_SIZE
>>>  	bnez		t1, .Ldirect
>>> +
>>> +	PTR_L		ra, sp, PT_R1
>>> +	PTR_L		t0, sp, PT_ERA
>>> +	PTR_ADDI	sp, sp, PT_SIZE
>>>  	jr		t0
>>>  .Ldirect:
>>> +	PTR_L		t0, sp, PT_R1
>>> +	PTR_L		ra, sp, PT_ERA
>>                      ^^^^^^^^^^^^^^^^^^^
>> Does this break existing ftrace direct trampolines?
>>
>> Before this change, direct trampolines received:
>>   ra = parent return address (from PT_R1)
>>   t0 = traced function address (from PT_ERA)
>>
>> After this change, direct trampolines receive:
>>   t0 = parent return address (from PT_R1)
>>   ra = traced function address (from PT_ERA)
>>
>> The sample trampolines in samples/ftrace/ were written for the old
>> convention. For example, samples/ftrace/ftrace-direct.c does:
>>
>>   my_tramp:
>>     st.d  $t0, $sp, 8    # Save what it thinks is traced func addr
>>     st.d  $ra, $sp, 16   # Save what it thinks is parent addr
>>     bl    my_direct_func
>>     ld.d  $t0, $sp, 8    # Restore
>>     ld.d  $ra, $sp, 16   # Restore
>>     jr    $t0            # Jump to what it thinks is traced function
>>
>> With the new convention, the sample would save parent address in the
>> t0 slot, restore it to t0, and then jump to the parent instead of the
>> traced function, skipping the traced function entirely.
>>
>> This was fixed later in commit 055e392f3be7 "LoongArch: ftrace: Adjust
>> register stack restore order in direct call trampolines" which updated
>> all the samples to match the new convention. However, any out-of-tree
>> direct trampolines written before this commit would be broken by this
>> change.
>>
>> Was this ABI break intentional? The commit message mentions matching
>> "the state when ftrace was entered" but doesn't explain why breaking
>> compatibility was necessary. RISC-V uses the opposite convention
>> (t0 = traced func, ra = parent), which the original LoongArch code
>> matched.
> 
> The patch "LoongArch: ftrace: Refactor register restoration in
> ftrace_common_return" changed the conventions for t0 and ra after
> entering the direct call function, which is exactly the reason forthe
> changes made in this patch.

I'll try to adjust the kinds of ABI breakage AI comments on.  It did
catch the other related changes from this series, but the additional
commentary wasn't useful.

Thanks,
Chris


