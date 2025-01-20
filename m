Return-Path: <bpf+bounces-49309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BB8A17525
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 01:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC152188950E
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 00:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EEB1F0E36;
	Mon, 20 Jan 2025 23:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="g2l7Q1qx"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00007101.pphosted.com (mx0a-00007101.pphosted.com [148.163.135.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A671AF0B5;
	Mon, 20 Jan 2025 23:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737417595; cv=fail; b=Gm19J8rCjVKGqcfpetOL5W9esIxquB9NNl7LsC+AOacsnElvvk1BJSXmoW+EIdw6VAfetr7cEE0rPh7wMo/PedfRS1KicE0vcdE5mc0KUSQr9B5p3dmWKqn5cH+PZ9obSLi8BY1J9OesAw0keJBeMQTdQk5l7JAzIFUS/QFluCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737417595; c=relaxed/simple;
	bh=+L588Vx5zqGMoSYmHpu3IzOR7ZMnmWZwJjlvD3USidw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ldB+PXDDpfHFfea6iLx3Uidq+pV/vELbPb00G3lAwFegQ0BRQu1xJCZWnV9D5l1e8ifc0JdPf03WLMyVwaWE+S8bx7EgnffrJNAaUBhqg4lQ3WLXhuMpTO6M0dwfg7wXRYLp8j/tEoGV9HX1aMm26u0mzgCyf/JLgAchUU3IzoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=g2l7Q1qx; arc=fail smtp.client-ip=148.163.135.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0166257.ppops.net [127.0.0.1])
	by mx0a-00007101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50KNg5UR016761;
	Mon, 20 Jan 2025 23:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=campusrelays;
	 bh=r9PyFO+6lqTXq1FlMOly3ybE0QPydhYr6vVz7KTq4us=; b=g2l7Q1qxb4Ok
	7JpWl6SVSdA7HI3e8ZDGqup7cllad1uixU+DPUd8e4SB0nxQOHA6nfh4VN8wUUmZ
	mRA1P+7/Q4KDz+cTZJDdLZyoRz+AA7OqFIEdSXMNMbJsydxnEkWau8VAT15ZRxHn
	0D9WpPRjSivwysYstIsQ5UPEp4mKf/8jngodoT7iRIFanCCy7L5stZZfo8/HFDzM
	kkJnKVlIoPN6LO47xuQ/FG0rjeCQCpg7Rz+ZvnMyepCxSRC4rvrawc0mB/Bx1YHi
	PhtVEEGd/oJRR4vzuIIOgkMQjD1fmFDWx7VjYcbNlBX0Gj4AgNRvKN713Hzmi5hf
	MbYg90PsiQ==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by mx0a-00007101.pphosted.com (PPS) with ESMTPS id 44a0cu02ms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 23:59:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOa7Bfr4ioXcHsbZ4EihWj46fsjp5Dy51vLvc/ZnoGeLbcQddnRRtPZH2fe9xnmLqM84nDTv+TCeabGj0x2uoPWf2VBt2LYAL6hKzDiqMOWFb/EzXZE4Q+Pb8pjmUZb4d7JvAUmVx074hug2QwG1XCk229zTlFZibpBUPBNHhe2ZkQ7NEcvG5u7ZlZHYTtoPe6n15EVWptvH7cNCl5sb9x/4s0qIB8lHWjZ5zzm7Rg5rK70cyNEkns5JtJZZ+p8nnLeY02YrATfzKsQ5kQvn8zzTSO8jntYADfwtY4XiO+6a7CWH2WUhZPl5F6/vBvyTZsqpSYyT5j5GVSorNXnSjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9PyFO+6lqTXq1FlMOly3ybE0QPydhYr6vVz7KTq4us=;
 b=FTAkY5JOxoa16Wb02yu43ICKNK6LJcKiDWDj+t3i76RWSxNal/uRMqec7ptGW7hmiB/CnRqf6OpPBrGSm6EHivzH3j6qWJWds5tAvBQ+kOLd6nEqThB7pQ+0jS6hUneUZNeTc4bCeSPx51ioGn4RmGojGd4/P3aVEAzdB1MFt33diqMihU7tjpHAnh59xfPbyefjNhi5tQT/bgff5+Cd3UnsdreymvXhIQYFtAwm8ANmvYUki6TYmEF9DW9y24GHxEbsIKuNPC+13B/sQgmd3OhfJkkmb99I3n48LNiC2EkIi8q2QCuEJHO6HWyb6Z9dZPtSuBlewzQ2odCZ3AaCnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15)
 by SA1PR11MB8575.namprd11.prod.outlook.com (2603:10b6:806:3a9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 23:59:15 +0000
Received: from DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::d52:d2da:59c7:808]) by DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::d52:d2da:59c7:808%4]) with mapi id 15.20.8356.014; Mon, 20 Jan 2025
 23:59:15 +0000
Message-ID: <ce79eb50-fceb-4e84-9219-a71fe3e6dd6e@illinois.edu>
Date: Mon, 20 Jan 2025 17:59:13 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] samples/bpf: fix broken vmlinux path for VMLINUX_BTF
To: Daniel Borkmann <daniel@iogearbox.net>, Ruowen Qin <ruqin@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nicolas Schier <n.schier@avm.de>,
        Masahiro Yamada <masahiroy@kernel.org>, bentiss@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250120023027.160448-1-jinghao7@illinois.edu>
 <938b3544-535c-487c-92d3-6f544231b7f7@iogearbox.net>
Content-Language: en-US
From: Jinghao Jia <jinghao7@illinois.edu>
In-Reply-To: <938b3544-535c-487c-92d3-6f544231b7f7@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::24) To DS0PR11MB7286.namprd11.prod.outlook.com
 (2603:10b6:8:13c::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7286:EE_|SA1PR11MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: b05dbfc7-48f8-4e22-cede-08dd39ae71c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1UvSUhUUXlnejVzMmI2QzgvQjFnK1lnWWJIcjZnZzV1UE9jdzVrUXVaV2pi?=
 =?utf-8?B?UGI4dU5oTWRYZ3VVaEQyTy8yS1kyclVGZjd0WkJUVUJqeWVvNWxpZm5qU0xq?=
 =?utf-8?B?WEFuOHVXU1FqNEp0ckdnR3NXdlhkYjB3bDBrVzhBV0daUFh0MDdidUxrRERt?=
 =?utf-8?B?RDlpYUJJKy82Z1dRSXNFT05jd0hjcFpiT0tyaEp2NFhrc2JzODZSeTVTelJn?=
 =?utf-8?B?WDVkM0xIYUR5MWVldGdIOTU0TjlzZ1FvSkZJR2IxUFBLd2djMHJaVXN3Nm9V?=
 =?utf-8?B?VU83RGNwZTZPdm9jUHFqWlRtdDVzMDZJVnpjVEdRZmwyT1dHa3pYcjN1b2NS?=
 =?utf-8?B?ZlByclNBalNIMjBzejc5czBieFU5dDVIVm9IT1dWSm1aSkRlSkRRYjM4dUJk?=
 =?utf-8?B?YlFTcDg3dDZlU0Z4TjllazJTVnU4SkFYWDJUNW0rbnJlMm8xT0VGS0RQblRT?=
 =?utf-8?B?bVFZNFBwWWVQZWFCejhWSGlXeXgzMWovK0hHREFZdlhHanNTY1E2UDQ3bXJP?=
 =?utf-8?B?Q1hYdFJrZXI5dlFXVUtrcFo5R1ZHRWxhUmxvSUZkWEFFbDE4ZVRYUjUyYS9W?=
 =?utf-8?B?QnVEOHJ3V29zbWlDamw3OXJWcVIyRUVMTUxOWFJGNndSaHAwblc0bFc0Mi9V?=
 =?utf-8?B?eS9nZzNTQktuaTdTanZ1MmhlQ3hIZ3VkSkhNUFlFcktLMUFxQ2NaQkZiSE40?=
 =?utf-8?B?YzFaSHVMY1daZTI3ejVzcEEySHNJSWllNEdUK2FrTjU2ZllxWFV1YXVIUW5K?=
 =?utf-8?B?Z3I1RzVBOHlmYmhha0pKZW1pZGlsVDQweTdLL01QYjdoQ3NDYjNpYVB3K3NX?=
 =?utf-8?B?RTBuUU51UW5lRlNlY01UczRNTTNWZUtBTmxBSVQzSklUN1AvcXhEWFRraHVr?=
 =?utf-8?B?d0xHTUZVVXBvNFVoR1c3azRlWUl5Z04waGxvVTFOcmYreVVRQXVKRXhzMDl6?=
 =?utf-8?B?MnRqWlg5dFlubGlSL0lHcml1YTdTOEZiaEVxV0xXdlkzN05aY3RPOVpqNHow?=
 =?utf-8?B?Zk1tVktXMFdXWllJcndIcjRIYUxqZWxpclc5bHZkZlhEMGVqQllUT2pPbEFi?=
 =?utf-8?B?c3VvRVN2KzlBbVJoR3o5RG54azRIUHhBZktzWXJlRUdPcUdNUE1LWFlRSHRM?=
 =?utf-8?B?bVZHWmtqdEdKamlFdjdCdEhZM0hPUWN3ZDhQS1dwOXNjV21UVFlob0U4ZnJL?=
 =?utf-8?B?TndvWTZ3Q0hiRmZmSDFzQzNPYk5QWngvVzhYblFSMkU4blJqQUVmUWNIN1NI?=
 =?utf-8?B?L1BVMU5jVDV4ekRwUkRRT29CVjh6aUVkV1NqUk1uNWErZUlHTzFyOHhvSnhh?=
 =?utf-8?B?VEtUR3JFdGJQY2pwc0N1dDRGNG1RUTREZ0ZOWThEQi80K2pTWllLR2JiRFRl?=
 =?utf-8?B?NlFmcWpCQUpBcThSQk93YlE4Y2JvQ20ycVBwck1HOXc2NlV4L3g3c0Ntdk9Y?=
 =?utf-8?B?WDlRZXN3VWRKYjV0dUZmeUpHNURIYk9KMW8yZGZlWndqcG00V1k5MlVQcm5r?=
 =?utf-8?B?L29qWlVqWEovMjQwbnNtcTMrVXhHTy92cUlvVjZLc3V0WFh5R3BZRGRObzZ4?=
 =?utf-8?B?Tk54eVBQdXd3TWpTaFJIeG53c0ZRY0hLWEppMDJ4OHRXbTV4ZktoMU81YWRM?=
 =?utf-8?B?azl4TjNkMmsyTHI2TGF1OEY4RnBjdzZ4bHowUkg2UW4rNG9uOGpwOHd4MVlo?=
 =?utf-8?B?Wk85M3U5TFNuTG9DcE1iSmRUMnJxNG1icVMrVm9lRXpXY291TE1qbDQyWG1h?=
 =?utf-8?B?bHJRMU1sSVlXM094UE1Pc2tPMHgyU1MwdHpFR2JHRDcrUmxIbW1GQ0s2dW9P?=
 =?utf-8?B?TjE1cDRBd2lvY2hmVlZadTFqU2lKMEEzelBndFdURXdVcGFQZDVzaUZ6VjFM?=
 =?utf-8?B?ajhta0VVWnRCMXRlMU5iYUZTdEJDSElhZVF2YmE4bW5UdlNRSGdRWWROVXV0?=
 =?utf-8?Q?npCoVV6JlqI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7286.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnM4b3lqQVlGM3ZBb1k2QWpxU1BsNnNCZUpSSis2ZFEyMFF1WEFlc1QyYk9I?=
 =?utf-8?B?TmhEem5sSTk4VWhnbHFnRm9WRTdWT2V1MElxR0NnZ3loRjd2NElRSlpROThZ?=
 =?utf-8?B?VWQ5TnhTUHU3UVh0ZzBXa3FKYXpEUmJyUHNYU2ZmQkMyb0g1c2hhbU5maWNF?=
 =?utf-8?B?MWF3cDdnTjNtQzF5ZFpMSUtIVURURDhBdnQ1V21KcFNiUHEraGNURmU3eUZE?=
 =?utf-8?B?M1NEeG9ocXA0YmdLbVBLSjdWU2VqOHc2YUdaQm1SeTB6SVM5a0FNUmgyZmtR?=
 =?utf-8?B?S252SVZIa1lFeUExcFY2SGdsdGgrd001dk94THJrdjhuS3VGWHpNV1k0Y2Z6?=
 =?utf-8?B?c3Y5R0p2NUlmYk0yMDR6WTNsWXNTTndoWGdwdEx1eERydVRaWVI0VDYzQlRL?=
 =?utf-8?B?S0xDZ2t0RGtwekVrVFJYaVY1MFZQUEI2K1AxZUpYb01WenI0Tmh0QUUwTUJD?=
 =?utf-8?B?bzlUOUNnN2lrc3ovdm0zSUgrME5DWUQwTmphZTV3bzhJWThuUFlVRlpjdnJR?=
 =?utf-8?B?T3RZSDV0dTNDMGRQMW9EUXg1VWRMZFJDUXNWNHBCTGlGTXdRb2xMK3VSRzFN?=
 =?utf-8?B?aW9pRXB0RVdZV2grdGkyNTRtYk1tNGIwa3prSFZidGl6eTNmd2w5d2ZmNi9I?=
 =?utf-8?B?b3NIMzM3SGN2dVdENFFMcFlqOFlpOE9pek14SXIyK3kvWnZWNG03WHNmVXpC?=
 =?utf-8?B?Syt3S0FuTjZQNDhuYlRQcnAwYTFuTWJURlMzUEdqa1RVemdOUERlbzR5OHgx?=
 =?utf-8?B?TXdyTHBDWjRPS2M2OFExcTR4amlVcWY1Yjh0L2xmcFRhTndQL1VxQzN6Mms0?=
 =?utf-8?B?SUNCVVRkbkNoUStadndlMmltbWsrY2UvempQL05jQmMzdThicUhra3pxNzRE?=
 =?utf-8?B?R0cybzJxd2RXRzNLNS80djkvdjZFbXMreUNPYVFmRmtnVXAra0RpZVY0MFhD?=
 =?utf-8?B?SnRNaERrbnR0YTVtcmpDNkJOWnVPNm5OWGlyQWJlb1VOYWJFNFlRMm1DTlJG?=
 =?utf-8?B?QkJNbmE5aFBkNExtWXA4TGhnWDBqVnRCdUtBTFM1czJ1YyszdzZYaG5jcDJ0?=
 =?utf-8?B?QlE1ajcvOVFnRUE0c0dMSjI3UitUMnlnL2NnKzB4WHNnZlUzN3NucitteStR?=
 =?utf-8?B?T3hTbXFzdVhtRlVIekNPa0RIRy9iTTZmZXl6YkR4bTc3SE84YitvR0ZaRmVW?=
 =?utf-8?B?VGFNcldIQW1OZXFIT3lEd3JrWXpoSDNNdVQ1czVzOXBpVXJ3a1JFMi8zM0sv?=
 =?utf-8?B?cEx0YjJaWGJjZkVLZS9EbzF5QTRoRzhXMlhBRVRpMUw4VFhYdXFVTmljUW9E?=
 =?utf-8?B?T0hLTzBQa3dja0VETHBlVGRjakJVcnR0UytNMXd2MmNjYjM3TnZONmZDVlhY?=
 =?utf-8?B?SHZ0ak9xRXRYTmlnWm1vTHNIYXl4MEZSQlAvWjZLc3N6bHZDeU8yYkdjU2Zp?=
 =?utf-8?B?My9mSS8rYVZROS9BUjdzVzZYN0RUeTNOOWJ6ajlMbmxJSkQ2S0VBL3dsTkZa?=
 =?utf-8?B?WFY5ZUMxTWVpc2owd1JpOEw0VVFaTHduTGxDd1FBVC84VldzdCtZUGFkUERD?=
 =?utf-8?B?cXZETTdScmZPRTFCYVpPS0RKNGVzZVRSTEFZb3pjQ2V5anFjZndXME1wWFJH?=
 =?utf-8?B?OTB5eWFsWktWYUlIUURraXlWZ3RyeWVWVStvQ05iQnVJVlp4RGRqVlJ3L1Fi?=
 =?utf-8?B?dVVPZzZzV3A3cEx0T2pXR1Jlazdzb01hVGE2eDlYSlVJa1VBNUNhRzlqS2Zm?=
 =?utf-8?B?eDFkdFljb0ppdndpdTYrZWg3d2ZOSG11OEF1ZUpha1cwdndKSkFGVnBrU1hz?=
 =?utf-8?B?eHp3a0dxUy9vZE16dWtnRkFEN0ZXWGUwbmsyMFNWcElJZzZqV3JBL01ISTZ3?=
 =?utf-8?B?QndVbWhxcWwvU1BiTTdEUi9QSW1lcXQ2TGxKTXBLTWlrVm42NFJqQnMvZloz?=
 =?utf-8?B?cjFIN3RXajlqcVl0MTFiTnVENEJmSGVyV0pLeWhaR24ydTBkOVZtV3FhMmNk?=
 =?utf-8?B?eG80Z281RVFIRWl2cWZaREIyQWptL2NuTzgxZFNGOGgydW54dVBzUFRySUxY?=
 =?utf-8?B?ZlFBWDlZUTRQVWk5c1p5YmYwOTMzS1Q0V000dnFMcHh1N1lPWjhOY2JEY2Rq?=
 =?utf-8?Q?xl4b1PFiGspOil863dYGv1mt9?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b05dbfc7-48f8-4e22-cede-08dd39ae71c0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7286.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 23:59:15.4229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMnbJVzcihz2uxHMteomytT1Wr8zCUWUX+2SRDdi2YWLIcv69gSVngzDY84hDxgxhjepfbSdYjXZQ1YVXU79+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8575
X-Proofpoint-GUID: 5W-Bgmy6eKWtP1qX7sCZ2t4fNmYBkGFp
X-Proofpoint-ORIG-GUID: 5W-Bgmy6eKWtP1qX7sCZ2t4fNmYBkGFp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_07,2025-01-20_03,2024-11-22_01
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 bulkscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=785 clxscore=1011 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501200196
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 



On 1/20/25 9:51 AM, Daniel Borkmann wrote:
> 
> 
> On 1/20/25 3:30 AM, Jinghao Jia wrote:
>> Commit 13b25489b6f8 ("kbuild: change working directory to external
>> module directory with M=") changed kbuild working directory of bpf
>> samples to $(srctree)/samples/bpf, which broke the vmlinux path for
>> VMLINUX_BTF, as the Makefile assumes the current work directory to be
>> $(srctree):
>>
>>    Makefile:316: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  /path/to/linux/samples/bpf/vmlinux", build the kernel or set VMLINUX_BTF like "VMLINUX_BTF=/sys/kernel/btf/vmlinux" or VMLINUX_H variable.  Stop.
>>
>> Correctly refer to the kernel source directory using $(srctree).
>>
>> Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
>> Tested-by: Ruowen Qin <ruqin@redhat.com>
>> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
>> ---
>>   samples/bpf/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>> index 96a05e70ace3..f97295724a14 100644
>> --- a/samples/bpf/Makefile
>> +++ b/samples/bpf/Makefile
>> @@ -307,7 +307,7 @@ $(obj)/$(TRACE_HELPERS): TPROGS_CFLAGS := $(TPROGS_CFLAGS) -D__must_check=
>>     VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))                \
>>                $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux))    \
>> -             $(abspath ./vmlinux)
>> +             $(abspath $(srctree)/vmlinux)
>>   VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
>>     $(obj)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
> 
> samples/hid/Makefile needs this fix as well :
> 
> VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))                         \
>                      $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)) \
>                      $(abspath ./vmlinux)
> VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
> 

Oh yes you are right. I will roll out a v2.

--Jinghao


