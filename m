Return-Path: <bpf+bounces-75580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB41DC89CDC
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 13:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 40A534E4D01
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 12:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690BB328B47;
	Wed, 26 Nov 2025 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zb/zqOD1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V6sa+mW6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63307328267;
	Wed, 26 Nov 2025 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764160722; cv=fail; b=CLF2nmtfMwkDpv/IHgAyzkt8SlzKFSY9SKL1wQXwdU9JZlK6A840/sNGdYbc7Xo2I7Fx6ZCOA9yBaRJUhmdpArRsvo3RTvT+MycEEzxjZn2rIFP7k5yijIR3k296netKGro+9L4w7fOZBwiDZMwNGp+FhKrJ7p5G2H45Vfz+eO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764160722; c=relaxed/simple;
	bh=xNajln3Kgbzl0OmMFtKhKyDXpusFdZIlZk3GoJxDK+w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cK9aKqhbkjhtB22DYEV3TKzTNaqOy0LtrCzHzJScyijmgoIsR+dWckRug6jHJNRb1xhFWQdQx0SiRATQJ93JvdMWji+cqehTtCQnnB5n3M2LG8Imy8p1NljbyDro2rPY/ag1+gI5mipPjtI3f65ZQoJvpgwOHVes4b9Kwib96+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zb/zqOD1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V6sa+mW6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AQAn3Pr1543780;
	Wed, 26 Nov 2025 12:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=iT6O/m3xuLHw6tWl2qHvvTaSnZcUJaWxNwAnLfWgobM=; b=
	Zb/zqOD1d2STZ4i8M/owyNJ3+TwEh/xEYCwjQpjC/iXL3LgXWI4+JU2FrKetKWqb
	MLgexsipHLhuR0nwmnrImwOKxMjm1PP/WcNz9pO8GReoigt/TwoRIVC0MfIdKH1F
	q66V7S1bL8NuDqnmJesrzrXw9+MVbPq+sLf7ZiENGMCpIDIXLnN4T1rWojbx1brC
	iVPYpbRHy19jHfiYHS+KIgrywK/UIwyQDV+KKAizQEHxOtmC1JUmg2cqgkilVi/r
	PnYLsvoUQzYdA6ixbsV5pb0e+CiTfYXUqqgsxhPtaqKAzrUStwfGXR8wHO15xx74
	c98I5PRPrCAhUu/06GEsfQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ak8ddkvsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 12:37:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQAtCTx029886;
	Wed, 26 Nov 2025 12:37:03 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011059.outbound.protection.outlook.com [40.93.194.59])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mef6v2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 12:37:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mm8Z9j+PR5zjTaqjin+7q+Qtb9tAc8XavGF9QFzD7irAM6XMT/j2UMtf9wxTqhYTDqJKpkoPzaI8ShjUqj5l+Q8S5U5XhlGM/+LutnhDXixUSu3Isc9OXoG9NSUkikuXfT1aoxftnVinlSWpCyHdFNCaZUH3Jb0pbbCS/5bA9/8R3N1hk3JEqNoW1vvwueIbqTTW88yC1IF0TFluBfo1inQM4mxSfkYOC9EGkskhyKvaoms0tulPn/K/f56YgqMCr6xVnUFxUgcs7pAWdbGd1A7zEYagfx5MezBOjkpJxiWxXFt+y96jajZUAbs9jPgbX0UYbjE2dDRz8AiElIODTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iT6O/m3xuLHw6tWl2qHvvTaSnZcUJaWxNwAnLfWgobM=;
 b=RohKUEpvM4i6EleHiHVGt3bvTrl1h74WQv/oHnTEojTi3w8Rq2tRdHIt10z4M5za/52sHyvC3s8yO3WVNIKnDqgXwhsom5OSvkXyNciP7RbiPNaHdi/X8FPRpkrNJ/Jwz0DaknQKuBJvWRou5FO+csgnJiGmHik+GEqP2/rSZc+r6Zc0g5iC2MEvMTwMpIaDZlSU0V0PBTiF5VVJEzzJZS2JWODc1/oYgx6YwQ9lEA5FqTDLC6nVKMZ6KzmQ4fCXNYefbE8ll1LYuShjvYUM3Yu2iGXDSJ8JxBZr2IRPJkApZRf9T75uMq1GAnXG6ykw080WEsG4ogzDcx3FC2cIbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iT6O/m3xuLHw6tWl2qHvvTaSnZcUJaWxNwAnLfWgobM=;
 b=V6sa+mW65rmkxP8I8O4S21SBL9HjHEbX16b/IOQN7/XH+gp8NPf7YVvqK3l9n06QGeJ20O39c5X7uHc9dfiKu2slZMlPbKqhkqgWxFW4X3IDPsBgElAHybebPW5pe63LU5pW9u4lNMugSqZD/y6XFrO21ljeixUktbXQFB3ZcQM=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SA2PR10MB4411.namprd10.prod.outlook.com (2603:10b6:806:116::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.11; Wed, 26 Nov 2025 12:36:59 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 12:36:59 +0000
Message-ID: <5bd0b578-e9ff-4958-b01c-fa3e9336eecb@oracle.com>
Date: Wed, 26 Nov 2025 12:36:50 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v1 0/4] resolve_btfids: Support for BTF
 modifications
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas.schier@linux.dev>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Donglin Peng <dolinux.peng@gmail.com>
References: <20251126012656.3546071-1-ihor.solodrai@linux.dev>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20251126012656.3546071-1-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0199.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::19) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SA2PR10MB4411:EE_
X-MS-Office365-Filtering-Correlation-Id: 2812a649-7dd0-4adc-6393-08de2ce87df2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUg5dVpiMmxGaTVUNW8vVlFiMXJsWnMxY2RodzN1b1JFdi9oL0k3eDI4SXJx?=
 =?utf-8?B?VWtkdTJ2QXN3OG1sMGU5MTdJSUZWQ3d4OTRMVDM5OHhSQzF1bkIzb2lkT1Bu?=
 =?utf-8?B?T284ZmFKOXEyYVkzNjc4UURtaW9BMWJ1eVFRejdITit3Qm5VbENMZTZaS2Fm?=
 =?utf-8?B?aEJCaktqZ3FSVHVEaDNTZTNzT2hRdlFGOGdWL1MvKzdjTHZlMmN5VmJBYTIv?=
 =?utf-8?B?cjRTM2xRT1NadlVFMHJ3Lzc5bytYMFhYdXUyQmlhQWJid3NJcGR2VEtOOHRq?=
 =?utf-8?B?WjdvS0JjYW9NeHltZEVoNHcwUXhrMG43cVI4NkN1K2IwRWJNSURHSFFHTm5i?=
 =?utf-8?B?eG9ubzV3R3dJTWxDUVVLbU1CaW9QeUNNMlpib3h1bHB0KzR2d3NmbXFwV3RN?=
 =?utf-8?B?MXFMZ2F1SGhiU3l3NTJ0SElaTFRHRTdRSTY3Wnh1c2UvV0cyWWJ6a3RqalRY?=
 =?utf-8?B?ZVRDZkNQcXJjaWNwZ0h4bFhaaUlVMkdhbEVMdUtnTGYvRzNsVHFGYmt2dWZK?=
 =?utf-8?B?VkN0djVzSlNMQVN2ZHIvdjVzTytuVWl2SnpjYllGNTF2NkFYaDJBRndTK1Zk?=
 =?utf-8?B?YStmbDJvc3BZdVJ4aEZPMG9ZNGRhZUdnZ3M3R0hDZi9hem85Q3U3OWJtMDgv?=
 =?utf-8?B?R0J1S0VZVHdPbXZDVFFIYUxQUkM2Z2NlNCtkUUVpbXE5RFZEdnl4TXhpT0Iz?=
 =?utf-8?B?MFJSQUkxdzhNbjBYZ0RXVnpiZ1NGSWNRcUl0Rko4Q3V5TUxJcmZRSnVGTmIz?=
 =?utf-8?B?Uk5Md0hTTEQvaGZ0WkhSaFMveXA3M0VaU3NCNlBraVl0OVhEWWVReUhYQzdh?=
 =?utf-8?B?cWtaTFg1VnRUditrOTlscGRvcXdSZDdJR25hOWZuNDFQNE94TUNLNTcwRjBy?=
 =?utf-8?B?K3ZxaXpReXV1dTk4UFNJQmNwdVFGWE9sdCtWZ0tZM2czQ0l6NFJOT04yQ0NX?=
 =?utf-8?B?TllOUU1KMzVUdDY4RERTaUExcU0zck03ZXYwN1UrSDBlUFhnaTRxNituWFdZ?=
 =?utf-8?B?YVJxaHB4c09XUGJTMnFVaDIvQ1dVUWtNRklDNVdaZlJnZ1JnMDcwRWRrTXUr?=
 =?utf-8?B?NGV1V1pYa1ovR3N1VzZBQlFhYmJrbFQ3d1Nha1pWaDRwcllnTzRmZWhQM1lN?=
 =?utf-8?B?V1dCTW9wNyt3RW1iWjgzS2p2TFA3cU5JWUZOVnc4cit3azJXN0R1UDl0U3J5?=
 =?utf-8?B?Y2x6a1ZNdlI0elhZa2dHaEhIZVdUQk4rV28zaHZuUGdrcFVVbE5UeEJvY0Y1?=
 =?utf-8?B?K1IyUThyZ3BkS1AreTgyUDFnODhuL05ldEhGclRzVndiT2RuODA0cHpxQWZH?=
 =?utf-8?B?QmY2WkdQR1k1TDBnUkhNMGxERjhUTlNOamdMRnpRdWtSOHhkdjdhdmY2S3lU?=
 =?utf-8?B?S3g2WGtCWnBvMGNLc1BzS3c1dVVyK3h3VkFVK1VZWmQxK290ZFkxQ0l5c2JR?=
 =?utf-8?B?cmcrY0RkSHBsY3pHYXVwWDdEcEVaSXV0SkRlSlBtZm5yN2RxbXBnUG5LWVow?=
 =?utf-8?B?MlgvVVFRdE41dGhPaTRyZCtCVU1OSytJSzNiRlBFWHhTUGN5RVZQM3JrelZh?=
 =?utf-8?B?OVpUTU5ZYm9RM1p6ZlJLN3BJN2g4d2p2UWp0eThpc1hzNmtocm52RTU0aU9B?=
 =?utf-8?B?anIrYnVYWjErRDZxNGZJMFV5S0FzN2dhZDRrNGJNYTNYbGZYekIvRjY0WHJ2?=
 =?utf-8?B?MGpUR1hXb245OC9xRUhxVWRXN200dGZqZnVDWHVyKytYR2lmSWhpd1NUZ0VG?=
 =?utf-8?B?Y01WbjNrZmJKbTQwVzVUVVJramRZWExSUXhKZ3RUN1JOSjRiOW0rNHE1cHg1?=
 =?utf-8?B?aUthYmNaZkpIZkVrQ1FxOFZHbFRXanNlMVNNSG5rMGdlczZoVTFRTUliTVMr?=
 =?utf-8?B?dXM2bzYrTHlPNFNjMlZ4REVaUTc5a2l1cUFwenh2M2dsTGFndE9Sc3Y5bS9q?=
 =?utf-8?B?bldPNHZJcDJDbExOSU9CdUdVc2lDZFdsQ3pPUDRoUG1HcW12WG5XTWlvV1B6?=
 =?utf-8?B?Q0J3RXU0Yk93PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmVwUlJySUVrREdoMHpGWklRa3N3ekNiSGRzbTBzREZwd2pMOWJRcGNQZGc0?=
 =?utf-8?B?RGJjUVozRVl3L1krVTdxZkxYdjJkeEFicHlVY1ZhMVZvL2xSUWRzYStjQ0lK?=
 =?utf-8?B?VGhObm8xYXhsUFAvcXJtZDBhWlRjWDJzVlk0OUdKeU1xNGI4L3g4S1JXK0F0?=
 =?utf-8?B?QjBCNmxKZE5YNzRmTXI4TUtQR3NrbGFqVHZ6TC9uK2dqWUcvSW56VGFIbGl6?=
 =?utf-8?B?N3JsTklUTHV2Z29rYWowREtjZEFGcVpVWjEzMDFrSlpKeWp4bnlvUGE2TDNx?=
 =?utf-8?B?SGxjeDRmbmJlaDJGWXUwb1dqYnE3bksyNVBDeGEwS1dEQXE0dHd6dDVFN1FP?=
 =?utf-8?B?ckRwU1NTYllDYjZ5YXFLdzJoQkwvL2ZYRlFVVzRISG9YVXNsNnR4cjF1L0hz?=
 =?utf-8?B?MU9SNFpCNkpyYkx2UDkxcnF0NXd3R2FGb2x2Zk9IL0tpR1ZNRkoxN25jcmNy?=
 =?utf-8?B?ZFoxazArQ1RLTGFmYlZRcjFHbkhRTEVNRm54MkV2OU16aDRrZCtEeS93blhs?=
 =?utf-8?B?MU9JQWdISDAwcm5yZml6bjlFWnM5RSs4dS9NalFUVXAvaHFGL0RueU9ITjFI?=
 =?utf-8?B?UVh3MUpYcXY1cWoyY3dmRHYveGUxY2hQTjdsWVdIQStzQmxLQytNOFVhanNF?=
 =?utf-8?B?Z2ErejZMNlIxdWFabnlDOXBLSkljMVNVOTZSMEljek1FWC8xdTFKZEVJRFBH?=
 =?utf-8?B?MjdpOWtCc1FQVGhBVU9PMkRENWdISmNyRlpucStkRUFmMDE1OGV5R0J5dElQ?=
 =?utf-8?B?S3R4YkQ0TmJnUTFzZzlmWDVQMlNWb0wzQUkxK1E1VmowUE9ZYXlHTnEvc3R0?=
 =?utf-8?B?bmlKcjFZU3JZZGZBUSszNGxvcWNSVUNWTGc3OHJiUU53dWdRVkp4QjNnVnpv?=
 =?utf-8?B?WGxsek93TEhWNUdkeDBCUEp4QVZqOSsxSlZQYUMzcmNwYU52V0tsd1dIUmJw?=
 =?utf-8?B?emZtMjduaEdET1lqWkRvUlJGL0N4MEphN0g3R1BVakNiVWFjSUdQTGpMdmVG?=
 =?utf-8?B?NmlweWJIUVB6VzRRQzVRcHVncXJPR0ZDbkRCa0hkWkthcm05ZDhWbFQ3bVVV?=
 =?utf-8?B?UmRaVEFnc1VGZG1qc01USzMxeDF2MHRhZzdhQy94bXMvNHg2TFNwd3FIQ0Iz?=
 =?utf-8?B?WGZJbDhnaDdnS1BCVzlxSjZmV1k4VWNpVnBTYzM1VzNyMHIySUdROEVwNTBL?=
 =?utf-8?B?TGY5NjVMcjlWcFRaL2YyTVlYMEdRdzc4UE9jMXJuNDNWb3p6dktrYlBnb3Z2?=
 =?utf-8?B?S0JOeW5YMkpJenVNVnBUYVlLTllNV3NTY252VmpTNGx6Z080WGg3TXlSUTZU?=
 =?utf-8?B?MEJ2cFZRZGVuenhZcy9JYlF1d3lnVDM4YjZFdFNKamcvTDZGSzhnRjhtYmFM?=
 =?utf-8?B?dUpySW56dWxpbndvQXZZTTNla2dlM05EMjhTVUgva3lhUzRUWFNWRmYxL3Np?=
 =?utf-8?B?VGpaVXZxc0FSVEw2WElQOStrejlHcTFybkRmUFR5b1JEMC9JU2dWSkYvNWV2?=
 =?utf-8?B?aGVVeENKdFBqN2MwNEFvdm0rSFl6aWVtblNYQkVMcUZyRkJaL1lHb3JsL0ZC?=
 =?utf-8?B?aHpUNVNXaGF5bE55cWdJRTBTTFNkRlY2bU9iZXhTVzBxM1FuUFF1ZWhrVnN5?=
 =?utf-8?B?RDlPUm1Ra3hCSmRMSTVyWHFlUFFSSVZTWWcxNXQvdzF2enVVWTVLRW1iQXFQ?=
 =?utf-8?B?bWlkOEJ3eWxkaGUvSmh1UnJwZEpVRk5PZzlqaHFQcWZuMUdnTkJUK0tiUXk3?=
 =?utf-8?B?c1ViQk1HMytaYldodGVnUjY0djFKV3dpM0NIdnBGNjlGcXp1ZEhVOGd3UVZt?=
 =?utf-8?B?VWdkb014NDNjNjJnR2JjNzVXOG81VnY3OWEwd0Z3NDZBNEZsYzQrQTZoRnYv?=
 =?utf-8?B?Y3dPcnBiT0orT3A4WE5aYmFvaFlYNWs1cHFhY3Eva2xybHo2dTVXbE9LNFVN?=
 =?utf-8?B?Q0RONHVOK1EzQzBMTWI5eGM0QnJPM0JpM20yMThjWTJCekozTHp6TEx4N2N4?=
 =?utf-8?B?dGl5dzd0QWovNmtmdW5aWDVHZEdTQUp5dnJpdFhWTWtZVTd2azRxVnpQUnhp?=
 =?utf-8?B?OVE3M2RuTHVvbHB2dDNkSHpWcjdUTzg0a0FNRnVlNGovK1BOSmFMZ3N1WUIx?=
 =?utf-8?B?SUFDK1FrMmo5dzRDSldwQitxam1aWjFjWjhtVzhVb1BRSFhaL3hBakJMZ0hu?=
 =?utf-8?B?Qmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b/O0/rTlBbu/unbP9rvk4V0+msQ51jsyzrWyGm8r5JJzxU9RT1LrG+in0H9+Ey8KKbPWD37haTtd6pDWP55YZzr3BhY4mMoe9XEX5tkeSWMUaiEgsfmTYWTL5gvbVE4QJNaVJcBn0RHk2TpXB2wTW5aCZF9BvRGpJhDu16JvQtIYDZlZ4MoIWKSTt8ZuKdTjU0V38rdAq2xNSrAzvkMC3OWhYtnIDWCGx5eEXqRba6ayl1ckWCtLhSR4Jnk1OhPa2vNNbz69BEOpPsd/0NVx868oOhdqsFC3ueaI3kmMAuva37owl2C9cVp7na1lgBKiPOe2uSyDMH1eotMO6auzKVp+fqQ6DaocDOrVhA6p+Ja+e0QcYfgdOZgrDYPWBpsNSSPzZoz14wIYga1MGmWejcRyxJVGf0wYErZ+LLM5Q1PN9iRlk/EX9r+TAH2s7opVEnnRNQ+btppZoZyfScJdDhou6ldsCSqayQpePbrBNvAs7jRMvCae/keEtb7vDSrHVv+XCdtzT6LEl1ILgevW2WFxQu5R/FhRL7GfnuSIDVvYDvw70GX0hE0ele4vgzNA2PEEvwo43+bQEedTnsPPgdo9gclByV/imIYOSeoyugQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2812a649-7dd0-4adc-6393-08de2ce87df2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 12:36:59.2475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QbaSXFTSUTI/L8UQ6wLuXaatYQk4gVAZiWGuYyWh3xS5yAB4hy1rSrkuPHvac9MgaM7UCX3fbsYZoMaX+E28w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4411
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511260103
X-Proofpoint-GUID: 0cZ5ZtAtIQAHtSj7_vyOvBlqZBNod7HU
X-Authority-Analysis: v=2.4 cv=ObqVzxTY c=1 sm=1 tr=0 ts=6926f46f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=IF_df2xdiJLUJPE7RtEA:9 a=QEXdDO2ut3YA:10
 a=U-CovGJQSHYA:10 cc=ntf awl=host:12099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDEwMyBTYWx0ZWRfXygYThsEIcHFZ
 q4XaVXeS+d8EAg88GxftFL4sOLO/KBhqbhhIEFsA7KuITV3AQ1Tzy7WnDk6Xox2SlyjIhPtp+xM
 BOl522SP4pmVEMUfe/j1StCORGqFHyZ+HT+uFRqrzp+VGuATbM76ZoS9enEWSLqdVvv4QzzEUbW
 /HB9ZnSfX4n2YvQ/PLx/VJ42f8GnYvzCOdvgjG8b6G+wss1Lzx0+YiJYYgJgwDpRqdPQkEbpn3R
 wruaXNpjo0T8nvjt4+OyXwYG2v2s2frSV76jZEepPPRAO13g4SAt88fTsang0DQpKOPN+cdTmpi
 moDS5KVfyaRgyH4Ro9bqTRj9EhAzj8ZfVJ8eU+U2JxjxVKT5oXqt6wUFNdbNXi/15yHHZs2QPLp
 GqSGeoVRTH5CfrJji35FO30r6uEsqajdUnAUrwViGm71LKk5PiM=
X-Proofpoint-ORIG-GUID: 0cZ5ZtAtIQAHtSj7_vyOvBlqZBNod7HU

On 26/11/2025 01:26, Ihor Solodrai wrote:
> This series changes resolve_btfids and kernel build scripts to enable
> BTF transformations in resolve_btfids. Main motivation for enhancing
> resolve_btfids is to reduce dependency of the kernel build on pahole
> capabilities [1] and enable BTF features and optimizations [2][3]
> particular to the kernel.
> 
> Patches #1-#3 in the series are non-functional refactoring in
> resolve_btfids. The last patch (#4) makes significant changes in
> resolve_btfids and introduces scripts/gen-btf.sh. Implementation
> changes are described in detail in the patch description.
> 
> One RFC item in this patchset is the --distilled_base [4] handling.
> Before this patchset .BTF.base was generated and added to target
> binary by pahole, based on these conditions [5]:
>   * pahole version >=1.28
>   * the kernel module is out-of-tree (KBUILD_EXTMOD)
> 
> Since BTF finalization is now done by resolve_btfids, it requires
> btf__distill_base() to happen there. However, in my opinion, it is
> unnecessary to add and pass through a --distilled_base flag for
> resolve_btfids.
>
hi Ihor,

Can you say more about what constitutes BTF finalization and why BTF
distillation prior to finalization (i.e. in pahole) isn't workable? Is
it the concern that we eliminate types due to filtering, or is it a
problem with sorting/tracking type ids? Are there operations we
do/anticipate that make prior distillation infeasbile? Thanks!

> Logically, any split BTF referring to kernel BTF is not very useful
> without the .BTF.base, which is why the feature was developed in the
> first place. Therefore it makes sense to always emit .BTF.base for all
> modules, unconditionally. This is implemented in the series.
> 
> However it might be argued that .BTF.base is redundant for in-tree
> modules: it takes space the module ELF and triggers unnecessary
> btf__relocate() call on load [6]. It can be avoided by special-casing
> in-tree module handling in resolve_btfids either with a flag or by
> checking env variables. The trade-off is slight performance impact vs
> code complexity.
> 

I would say avoid distillation for in-tree modules if possible, as it
imposes runtime costs in relocation/type renumbering on module load. For
large modules (amdgpu take a bow) that could be non-trivial time-wise.
IMO the build-time costs/complexities are worth paying to avoid a
runtime tax on module load.

> [1] https://lore.kernel.org/dwarves/ba1650aa-fafd-49a8-bea4-bdddee7c38c9@linux.dev/
> [2] https://lore.kernel.org/bpf/20251029190113.3323406-1-ihor.solodrai@linux.dev/
> [3] https://lore.kernel.org/bpf/20251119031531.1817099-1-dolinux.peng@gmail.com/
> [4] https://docs.kernel.org/bpf/btf.html#btf-base-section
> [5] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/scripts/Makefile.btf#n29
> [6] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/kernel/bpf/btf.c#n6358
> 
> Ihor Solodrai (4):
>   resolve_btfids: rename object btf field to btf_path
>   resolve_btfids: factor out load_btf()
>   resolve_btfids: introduce enum btf_id_kind
>   resolve_btfids: change in-place update with raw binary output
> 
>  MAINTAINERS                     |   1 +
>  scripts/Makefile.modfinal       |   5 +-
>  scripts/gen-btf.sh              | 166 ++++++++++++++++++++++
>  scripts/link-vmlinux.sh         |  42 +-----
>  tools/bpf/resolve_btfids/main.c | 234 +++++++++++++++++++++++---------
>  5 files changed, 348 insertions(+), 100 deletions(-)
>  create mode 100755 scripts/gen-btf.sh
> 


