Return-Path: <bpf+bounces-57846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CF7AB0EE1
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 11:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5122F3AF7EE
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 09:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F1427C15C;
	Fri,  9 May 2025 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="afrifURs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B+fdYfGE"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D7127C150
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 09:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746782414; cv=fail; b=KOjESATrMKolpQLkr95IS6vL0yuxM4RCcF8cRi22z5Y2EAwlbWVXvWEqglSc6MBFKHXUZdH+kUjuk9dNPOK6sLbCQgg3h9IVnFek/7FOarHB1qD3LlBhbRJcw/wkglFnCmMI8QCYiIcFDC3shAQrmfdqpftPRWA8q4SMenN42/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746782414; c=relaxed/simple;
	bh=ilAi3gDrMbp/AcF0hopfdzJMxnc1lPabAfPMIhAAw1k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mwW3n3ofBD0rIT5wa+qrBrcW51B23t4VTtZufGnR7JdFcpK1F6Wax9blnZtxAl1qN619rywLdDlp6WkziY56Nia7pKW6HdPkOJlN3m+evrZDFhZrz31JI+L9sNw29t6K5ufZAzDNc5OyyGtcihBeWP6HTEcFOVjAv/7ODqWzq1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=afrifURs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B+fdYfGE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5497HDpO020268;
	Fri, 9 May 2025 09:19:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6Hp0Ju0RqQWMHIleG77wDz2ajsbFsB3WgSZ+UUw0MdI=; b=
	afrifURsYcMwD1xVQebXLX8R4lcD6A2Cm7iAAstdIluqIZJigI9CkBlNdt26rBdT
	SztC1RPysn2rQ6JV4hrcF1GMQcb1qLjnq8OJN506Pr1c7gnceIxtIZsWOppmZ1gk
	2GZ8moBUOM/hKjXV3K6mvQ2Qze8JAjBVWdOHGc2GPZj2tijfP0hW4S3/zxQkBdh+
	tClVUA6H6gmkfXwM0G0t9F+upkQLp0sJtQAqK44e8MU47WL4UFsJQ3KYY1XdEXe+
	/4ZDwtdQbW+/11n66jcT+h0CjqSeLocvIWp3cFYtt7AWPt0fZARq79SeBEIi2CCf
	k3uxp+xjuqRq6su38x8qCA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46hd6589qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 09:19:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 549727Br001909;
	Fri, 9 May 2025 09:19:52 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012032.outbound.protection.outlook.com [40.93.1.32])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46gmcctd3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 09:19:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhsQj8vkVhI/iItL8/cFa9+Q6prOx0Vc6HwkA0qEcjmLlyck1lwV8a1Mr6TSadsF4njkOqUZE3n9gDXq5axN3oK0Gdrq1i+CyGnPezuh59JqOv/DJv422Iq3JRG88am328n5TdIAnHSeJcpFFf3JAcRBpB+6RGvlgPpx3M5g70l79jfLP+UpyXuIC6W4EgkiKgJDidlG1AAs0RGHLf5Ntny/JTzm4XB93d8lSD0t5Ij3a+tnDYG/rqZ9EXaDa+OhIHplz7sBIdjMSNhOQR5KNHJG6RcVTJ+84t9ILrGfgNt6qv1Mc+Xv7BHd8Dw1EqxyC5PTpQMl+yr3zAtIcGRMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Hp0Ju0RqQWMHIleG77wDz2ajsbFsB3WgSZ+UUw0MdI=;
 b=nOgwFCs/pSQQ7yj6FyqABwlDC43G/AGhD5u9PR9hEnRiZCTfVf5rNpIfox56eWqzna0z1bpF3ygjFlwyyRYSv212nD/wGZFytIg/TJYZm32fh9qElQIRanuOpgbcsPQ/9BwPyS/7Zx3rzPwxUnd9M8/qO71onOcPMD3phpQgg0dYmN6gvtYQ02L0iq9wMBqvEJX12qOIrXRl9wlMZtQEEne4xazEeEcaA6CuEmgjyG0/JTs9cRuY7GqqnTpqGynNwfE1sBQ23k6SkiPmPFLbn8CKk+4nR6PM7/7fBdoF2x2AmD3R8OF9aFQRBl5b9v9XeXC6vcCZ0aTeYSyjEXDfeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Hp0Ju0RqQWMHIleG77wDz2ajsbFsB3WgSZ+UUw0MdI=;
 b=B+fdYfGE7xZLtMSkfFvLWqxOe+0Mk0chvIE0FfM3MbPlngh6R2RowMfcQcgVMdwDtjARJxqMTe9NnrdLO/NvMNarY+TeiPQ9ggJS/Y4aclnUsw4aJ1oOH+WWJ6dm64fQHeOuCXtbC3qj8F8R/MRJwT/XGI/qJgLDwis36aiwGBI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ2PR10MB7736.namprd10.prod.outlook.com (2603:10b6:a03:574::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 09:19:50 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8699.022; Fri, 9 May 2025
 09:19:49 +0000
Message-ID: <c0b1d7e1-2d6b-464d-920e-d2b6bd6fb6c4@oracle.com>
Date: Fri, 9 May 2025 10:19:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 06/11] bpf: Report may_goto timeout to BPF
 stderr
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Emil Tsalapatis
 <emil@etsalapatis.com>,
        Barret Rhoden <brho@google.com>,
        Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com,
        kernel-team@meta.com
References: <20250507171720.1958296-1-memxor@gmail.com>
 <20250507171720.1958296-7-memxor@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250507171720.1958296-7-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::7) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ2PR10MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a28fe1a-d571-4b82-96d0-08dd8edaa613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2pqNlFOcXVIbEdmSmZMam90UXR6QzkzTkdIeWJ5cWhlNFVYWWJSQkNTREhi?=
 =?utf-8?B?WGJ1bEE3T2RxRGozQTJNOHNjYW13M012LzYwRzgwTW9tRDVlbTl6ckdNeU5Y?=
 =?utf-8?B?Q3pxcGgzNkJ6NWo0VkpNNmJXZnFlblFpeEZXYWo0VFFNQ3B0cFkwcmxJNVE1?=
 =?utf-8?B?UFQ2MkFXSFRWbUo3UjRNQ0lJRXN1cjYyUUloMUdqVVE0WmpjU3hKR1l6M2p2?=
 =?utf-8?B?Z2Y4L29yNFRWS0tOSzZtL29JeWNNMWtqeUhmdEtiUytnRjhxekRNdXBaMk01?=
 =?utf-8?B?NUFmK0xKU0F6NW9ObllVMmlQUTBoQXI5MXV4ZlBWN1RQSDVrUDNTVlUyVEtm?=
 =?utf-8?B?d2ZhaFJINVZCRjU5dStiT3dYaFJ2TnhBS1RWcnRDSjhmbEx6MnErSm5qRGVR?=
 =?utf-8?B?bnBpTTdFUUZwd0l2alJtNUdYaDd4U1ZlM2ZvRHM2aTF5VHMvaTd1SmJjZTdH?=
 =?utf-8?B?Zlc2TGFsR1VtVTFBWHg1YUZTOHZNV0NEaTlJb0ZNcHBibHptV2haRzZXOHNk?=
 =?utf-8?B?UW4vQlY2SkIrSlRHSUlDL3A5YXgwZU1mOXdyVC83cUxQRFpSV0UvMXE1ZkIx?=
 =?utf-8?B?T2ZMMTBmaGxLZmVHc205ZVJhM0FEcU55MjFTb0JHQmY1dlBueFNWck5IeUEw?=
 =?utf-8?B?WjdBOVdTS2ZhVkRQMUZTM0JkMUczUTNSNjZYNlVYVjdIbStWdWJNNHFOMllE?=
 =?utf-8?B?bW9FVTBLRjhLcWFhd0tmWEROTXJJR2xCZFR3NG1iT1l1MnZFdTAzVjlLNW5o?=
 =?utf-8?B?aGI5ZkxRMnpyWUNSczVKL0JXYk9VVC81YmtJRzdXMG4xQkozNGhwaklKZEw5?=
 =?utf-8?B?L0xsTDV0ME42WmpwNzdadVR5NmlrSDZkcDZmcTVObGdJcTlmbjg0NHRVL3NP?=
 =?utf-8?B?MGt0TDcwUGFPYkgzdU9TaExMVmIrUEdrNzhpNnp4SkNPTGxsMnUwQmNjekkz?=
 =?utf-8?B?N1hiNXk5bnRmQXpiTGRRSVA2TjhWQU9EM3BVUlVhUWZGMVVzTWRtTUVNU3RJ?=
 =?utf-8?B?Ymt6d3dnWWNURmdZcFYvUENzeDB6eUpHbmxxbERJemhRL1BLUkV2UnI5c01x?=
 =?utf-8?B?MTJQMHdUeW84QndXR1lWdVFpb0ZIL3B6N1d5T0ticm1aK2p4cXlWUTZHYUha?=
 =?utf-8?B?TFhtMDJ6elpybHNwRTZHSU5JUks2cWFOZGFTbEgwV1FwcDg0UElvbEc2aEhj?=
 =?utf-8?B?Qys4amdONnlwOXRNV21CVnRtMTBQc1dwU3IvQS9UU3E2MVByQjc4OXBIOEda?=
 =?utf-8?B?RHdqSVU0NUVrTzNONTY2dFArUllFK3Fyd2Rqc1lWbEVuN3FBVHl1UDZtZkxi?=
 =?utf-8?B?ek4reVNYeWNGOFlzZ0w3eE41ZEl0WUFtVndDTkIxTFM1NDdMSUJyeTFncktC?=
 =?utf-8?B?anhUd0ZWemUzWGs4Uk15NnJsRGtGM1BwUzVCTE0rNGdRSVhSTVlnSk1TcjVs?=
 =?utf-8?B?ZkhrQ1p1eUw2L09URG8xVkVDbWxlTndMSXhUekFaaFM1dGo1ZzFNbTFuOXdF?=
 =?utf-8?B?MEJjS1VrczhQZHU4Y2pLN3MyM0RybWtySE9WV3lWQVBzL1cyS2tSSk1ncDA5?=
 =?utf-8?B?MjMydWp1NGpxaUo5ZHoxMU1Cc0NvMXNBbEthSFpoYkpHZzNiblczRExybTcr?=
 =?utf-8?B?VDRvZ3dLZ3o4aGhBMGZkcG9UL1pQQmpadmtqVWJzcU5rbFBMRFNaaUxxVTc3?=
 =?utf-8?B?MU1jY2pjY3VMbGZqcDQ4U0ozT1lCci9IU2FtWG9QQ1VlYmdDc0orOWdsdkVT?=
 =?utf-8?B?blNQd2I3c1MzNE42akFZS0lmbnh3QVNac3NNZitvRFAwK2YxYTBpaXh1S0p2?=
 =?utf-8?B?SDBMVnJ2Y0dnR0pjY0xLWXFMdlZUMlQ1YzVkb21UTko3U2RucW50L2E4R0lt?=
 =?utf-8?B?cnBMWDBzWEM1aVBuNTY0N24xSkZUSlF1OHpLc1ZvM01vOXF3bDJkcFdpOW5T?=
 =?utf-8?Q?8mrkeMywpIA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3VESXZVMVNNYUsrcnhtMVRoQUdWWm1mUDQxejFHQzRkc2J3cTJNRG1aZWhO?=
 =?utf-8?B?eUVLS09NemR6dDhodmlPZ3FZNUtUL25VaXcxeHk1RWs1Qk1rQWNIQ3pxQVIv?=
 =?utf-8?B?a01VSFhVa1lHS2ZqSHRxWUlxQWZUQlRIR0dwOGhybWJRVGpqek9yRkJob0tD?=
 =?utf-8?B?U0RCT2xxWWRMa0pWbFpUbldzR2taV0xTUDE5bmtRZEpyTGRkU2RvWkgrT2NV?=
 =?utf-8?B?V0x4TDZTUlIxSWlSZHpEK0UrYUFwODhXeW8xOWxYTm4yS2N2b3dsS2laeTFP?=
 =?utf-8?B?RnNsdmZSZGJUU0haTVNBdDRiamFCR3BOV0hacDUzVEkzYUZyb05PZW1OWElH?=
 =?utf-8?B?SlRnekdtOVM3ZURpcUFtNnVWZ0xZTzcvazdRaitJQ0pVL2hMR2pxTGE1N29r?=
 =?utf-8?B?cTRyZjJJczlKd2Y5d0hVNUhsZlN4MUY4YmYwdnRyZ3JEOE10ZzFXcXlQVEla?=
 =?utf-8?B?Tk85VmJpR0JEY01yc3EzSnNmVjZoSnY5MEtxOEZCMUdSYjB4VmxLQjNLWHhM?=
 =?utf-8?B?QWFiOUt4R1QxT0F6NHdvNjFoeGRzR2wwT2M2ZTlMZjhyQlB5b296MkxGT3VS?=
 =?utf-8?B?YXBUaVFDTVRpcWNCRFViYlJFaXVrMTllc01UeFl5dWdqSFdtRlR2SjZ1Q2Jw?=
 =?utf-8?B?SzZ5OThCdzRQaTNNSk45ellJSTVZckg5WXhIQTJIS0JRbWc4MGlaeDRxOG5Q?=
 =?utf-8?B?bzBIK2doOXk1ZGZBNmQ5N0VORjJxd2VTRjdvQ0ZIK1F5MTVtUHBhZzJCZkx6?=
 =?utf-8?B?RjdObEI1QkZncnk2NzB5cnAxanRyQWNsUytJazRHOGs3c2t1c1lUaEJmekFV?=
 =?utf-8?B?eHFuZE1qeVlGMEdYWkpzdU5ma1NILzlGcUdCWlFWbkhzblpFWEpsMnVwdXln?=
 =?utf-8?B?VXJhZXo4L0VTbTM0aXNhYWpIYW02bkJJeXpXRnhLSElKVExUemQ2MVdYcC9U?=
 =?utf-8?B?MGZwNTVPTCt1Mjh3dVIzUXpxVXAvL0R4REpxdHJIcHJDR29VbUdqMEtNak9l?=
 =?utf-8?B?ZjdDazkrekROY1lzR3JVSXh5cXl1emVrQTdKaDJ2TnQ5eTVCeURLcUZib1lv?=
 =?utf-8?B?eHp6Nm5KYnRISWVsTWtMVGowWUtoc05KQkNMSGpucnF2VXVRUkFWeG9FNjFm?=
 =?utf-8?B?TlFvMENCKzFxSFR1dnlpdXYyc05uYlIvSi9raFdDeVBEa2RsOUI0SXZUZ014?=
 =?utf-8?B?ZzMrY09RY0trSGMrSDVJc05tdWlEaDNmZHZhbnN6eUtYVG5DWVRHWHppUlFW?=
 =?utf-8?B?bFhCcS85cHg3dDg5cTJWcUVDT2x2QU5MT3NzSFk2V015cGUwbDlKcXAwMHVO?=
 =?utf-8?B?d05LTTBHeU1LRk5aK2FXMTM1OXZpNXdkREs2ZzhKRGtYazBSY2VlSW9TNFI1?=
 =?utf-8?B?N01IaTJSOUROZC9JQ1RBVkNleC81akRqaXV1T1pQK2hZOUxORU5xZHlQblIy?=
 =?utf-8?B?OXozWmVvOVBGTjNMUHVrNUQyWWJSQlJwS0FyZnAxMDk1azBjc05OcTVCU1RT?=
 =?utf-8?B?VjhrYVdpYis0OW1RRTM3UTFMeHUwWTA1Mmh6TWRZYjNNUEQrZGlKTXM3ZVNt?=
 =?utf-8?B?dUhXMXlUTm92R243N05Bekx3U1Z0ZnpLalFwejNWVzhZM1RMNmNsanhGeEFF?=
 =?utf-8?B?UjVXamY3TVM1aW5IUHBJQ3dOTXZNVEs4dXpMTjNOVjU0N20zMmNuZEZpMFI1?=
 =?utf-8?B?bC9pekpZaUg3WTdpeTYzZ3VTTmozbGJnVnVzS1RQc2twZ1NaVHptYzF4azJL?=
 =?utf-8?B?MXI2ZFNqQUVPQWtXajZPRjQ0ZmYwSDI5eDJNcWswR1RTY2FCUzFSVnk3bU1Z?=
 =?utf-8?B?SmpWbTQ5ZW9zMnJLUEVyNkp6NEVNcCtKcVNUNnhqWnhnOXZmeTJQYjEyTGgy?=
 =?utf-8?B?dExHeVVENkFnU2lvOG44dzFWZDBZNFMzRG8veURKdk1mZ3JUdzI2RHdreDFD?=
 =?utf-8?B?K3Q3SlRyMHo5NFhNU21WbFFFMVowaFNQOWxKMVhzZ0lITDlROC9ZckZQc29O?=
 =?utf-8?B?QjNyaXRNVnVSS2tRSWxXYlBMTEp4eUlKOGtKcGUwWGM0eVdyU1JoWWx2aDV6?=
 =?utf-8?B?cGs2bFltK0FNbklFTitJRlQ3cTQ0UnJHQ3h1VzFpcWtpbWttY0UyUGt0Tk00?=
 =?utf-8?B?QXhSRXlDNEtYWG13NmYyWjRYT0RsK3g0dU53dzhrdzJVbmF3ZEcwSFBJK3ZC?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f8d3G6aH7JRNUV8I7Sp+QjPffWhbKPFtBjIpnwCcWJg8d5HM/j7a2tmeWHXjbcJjCcI8Ma97TilGgO9BRz7Lf/6Yq8fVNbOo1NzW3p1EzTuiObljZSIsq6N1Ojfxgvu2eFE9TKi2DY0nHh/R6O89gRQE9DzPFxRahSMqZTjhrqTE7fTfAP5+Li1R4EHN8BObmizshJD4fBPtdnESknHtKY+TVJ8TmjTB+UjK8L+x630PMQlB49kVSgL8la2a/3pAwJPfCRxSzPuEzFLfTM2a/LMJQc7LOIKQx7NDEZC6QIz8Y9BkrKpzIYybAvWLk1FfBnae/g17R6V11BLDyQ0lRyCasb4of1Ogq4X9TtDZ+pd/YBWAQbgO08s/xD3zr8BfJ7aYMN4VMBQPzEPB5ze8OY2KcGun1iEnJMl2Q86N8qiiu2LxShF1gotr6oMrUifigKeuDh9K0hKOJymj4RXUTLN6QesSPXVnmkNhwQcNBJUCGBPc8QpoUxX1LMIhKTxDaD+vvpCFuoNTn+nRL/qPx5jt848kR/zMvZr8IWlz5Qz4TzKHqAqkI5K+CdbyCkTebBF+t+SiTMhiWRIoSkeJAJkPaI0C39G8rXtvpXyUuZ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a28fe1a-d571-4b82-96d0-08dd8edaa613
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 09:19:49.8887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wv3PTPqiN/UXMunf7oBAildnfhViK+tMlPcNvsgnVhg9oCclsihAF5wxmZ1K6vi3zIYBvz2XgwH4bzrcr9i/Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_03,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505090089
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA4OSBTYWx0ZWRfX/240r4m0kTrf cqbbXLjZ7xO3CgbSCIc2Fo4HqxxOg4PgOIDpl8MmylxVfOks1G8AwVNTPTY8sEK+cWLUcCroJI0 uXAQrl3jB6NlOlyvhcmgu0DVmLI63wmz432C0m460rYXneVUiku/xvcFxqEmMQimeEUzbesWX4Z
 ILVRqFbnidRr9pORXUGU7INfD6GlSIxJUrHxj0LQEfZzwDWEHCnwht7LI/joEfZjc2j5HNGMTKg sbIvw1Q6q1KDTNQhFzXm+AmdlLw7kbhpY2e4gNL+xvWGCtpsXFLX0cqJTog6c2s453ehq8miGl0 Smv4ecie2sQRYlZUMa4CPDJZ7myAutq3hBYLRFlcLJS8KoyU2vaTIxpupwll843lufw0zPyiq75
 /jIYWPPwmy1Q3LTkWSu1VIQPkDZJXMqWMdHTZqs+cgFVAaGwswxDBdoapAzeBu3t8ErVg8j6
X-Proofpoint-GUID: 1DdnFJ1znA5t-5q92LEvIbqCeBWjSW63
X-Proofpoint-ORIG-GUID: 1DdnFJ1znA5t-5q92LEvIbqCeBWjSW63
X-Authority-Analysis: v=2.4 cv=Lt+Symdc c=1 sm=1 tr=0 ts=681dc8b9 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=pqNslV1UP4ZTQtF6OyEA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13186

On 07/05/2025 18:17, Kumar Kartikeya Dwivedi wrote:
> Begin reporting may_goto timeouts to BPF program's stderr stream.
> Make sure that we don't end up spamming too many errors if the
> program keeps failing repeatedly and filling up the stream, hence
> emit at most 512 error messages from the kernel for a given stream.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

this series is great, having runtime error reporting like this is hugely
valuable! One question below...

> ---
>  include/linux/bpf.h | 21 ++++++++++++++-------
>  kernel/bpf/core.c   | 17 ++++++++++++++++-
>  kernel/bpf/stream.c |  5 +++++
>  3 files changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 46ce05aad0ed..daf95333be78 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1667,6 +1667,7 @@ struct bpf_prog_aux {
>  		struct rcu_head	rcu;
>  	};
>  	struct bpf_stream stream[2];
> +	atomic_t stream_error_cnt;
>  };
>  
>  struct bpf_prog {
> @@ -3589,6 +3590,8 @@ void bpf_bprintf_cleanup(struct bpf_bprintf_data *data);
>  int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs);
>  void bpf_put_buffers(void);
>  
> +#define BPF_PROG_STREAM_ERROR_CNT 512
> +
>  void bpf_prog_stream_init(struct bpf_prog *prog);
>  void bpf_prog_stream_free(struct bpf_prog *prog);
>  
> @@ -3600,16 +3603,20 @@ int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
>  			    enum bpf_stream_id stream_id);
>  int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss);
>  
> +bool bpf_prog_stream_error_limit(struct bpf_prog *prog);
> +
>  #define bpf_stream_printk(...) bpf_stream_stage_printk(&__ss, __VA_ARGS__)
>  #define bpf_stream_dump_stack() bpf_stream_stage_dump_stack(&__ss)
>  
> -#define bpf_stream_stage(prog, stream_id, expr)                  \
> -	({                                                       \
> -		struct bpf_stream_stage __ss;                    \
> -		bpf_stream_stage_init(&__ss);                    \
> -		(expr);                                          \
> -		bpf_stream_stage_commit(&__ss, prog, stream_id); \
> -		bpf_stream_stage_free(&__ss);                    \
> +#define bpf_stream_stage(prog, stream_id, expr)                          \
> +	({                                                               \
> +		struct bpf_stream_stage __ss;                            \
> +		if (!bpf_prog_stream_error_limit(prog)) {                \
> +			bpf_stream_stage_init(&__ss);                    \
> +			(expr);                                          \
> +			bpf_stream_stage_commit(&__ss, prog, stream_id); \
> +			bpf_stream_stage_free(&__ss);                    \
> +		}                                                        \
>  	})
>  
>  #ifdef CONFIG_BPF_LSM
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index dcb665bff22f..d21c304fe829 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3156,6 +3156,19 @@ u64 __weak arch_bpf_timed_may_goto(void)
>  	return 0;
>  }
>  
> +static noinline void bpf_prog_report_may_goto_violation(void)
> +{
> +	struct bpf_prog *prog;
> +
> +	prog = bpf_prog_find_from_stack();
> +	if (!prog)
> +		return;
> +	bpf_stream_stage(prog, BPF_STDERR, ({
> +		bpf_stream_printk("ERROR: Timeout detected for may_goto instruction\n");
> +		bpf_stream_dump_stack();
> +	}));
> +}
> +

Given that we can hit a stream stage error limit, and that some users
might want a high-level picture before diving into stream output, is
there any scope here for adding error stats covering situations like
this? I can imagine some users (perhaps users of bpftool) might not want
to see the full error stream but rather get a summary of runtime error
stats first, so recording runtime error counts (perhaps contingent on
bpf_stats_enabled?) might be worthwhile too? Doesn't have to be this
series of course, but just wondering if others perceive a need here too.

A tracepoint for BPF runtime errors that is passed a bpf prog + an enum
representing the error encountered would be pretty handy for tracers I
suspect; that would allow them to tailor their output based upon their
needs when runtime errors are hit, with later dumping of the whole error
stream if required.

Thanks!

Alan

