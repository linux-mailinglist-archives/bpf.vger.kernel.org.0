Return-Path: <bpf+bounces-46152-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F529E5362
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 12:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE86C165EB9
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 11:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4031DDA35;
	Thu,  5 Dec 2024 11:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZoBLJFjC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TXWm33Ba"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3021DACBB;
	Thu,  5 Dec 2024 11:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733396945; cv=fail; b=uQ7b1xh7oC1pNGHV+RtXiy8/5ltixgRhEAdOH2FlwHOWSyIPJFVBN0f5HyFrWwkFhIjUNcZWfOZ1NjxmajRf6kZBsvzmsn/zRqOT9Mk4Si4akS458aptODmcLkyU1U4yoIaU00snZfBHy8BylcwzMDXeL7TnHZDSs65p/q8jRhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733396945; c=relaxed/simple;
	bh=d7i46PwpEKKNvB+ty9ZxijRLlCJTdPzKMBRR8LrABJg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O8lLFIeTYFp3UlUFYyuoxgtYgRRXcY1TMjBi9mlfGaNzeDOm5ncpYyhpaPApZ2lqHpmTUl1zkJhULWAXArNtfBwlVSoobYvZYgE9UCtsa6xuf+fGjl/F3WcIu4mNPeiHW0uKez8sOTq+jKR5lXRYA5Vk5S1+eK2HeQTE7cHKILs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZoBLJFjC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TXWm33Ba; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B57MtPD007204;
	Thu, 5 Dec 2024 11:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=99d+JfoqS16dpyF8NLVNs69YfSJPV/VSdBfZAFQ5iNs=; b=
	ZoBLJFjClK+ggWatAWcdmcFJZVfVRgxqx6I7TXo2jo1q7ziKezJy16KNAGaLW82n
	drc46CnHVMcUrPPfezjxgx/f1nuygLt75xFfOhX0UYZJPLSVSrEHWveOy2mXyKKr
	bQH5oC0/Vxg5YhDzUYJ7GvDVTlGdqA0WzPX/w46+oyxbAwzSSnjRwqE9e4iXUyCO
	PZ8S2ZhytdLEu9elII1VuV+8Gnk0Ito9G0nIqx/fTGkpNmkNALUg2Agfw1ym6LCk
	8kpEbpnd/mpjPACyX3uFT/BecSyVPobXjaynzoUV4gy1/K6ijzh4Lrsam1jPhSOd
	BpHZkQecgl5QP+yjlWhd9A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437sa02s92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 11:08:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5AONS5011751;
	Thu, 5 Dec 2024 11:08:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5aq7sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Dec 2024 11:08:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qPsnGFXBX43zOJA4mmyxqcuug68BkJQls7EddGi1ckm5BxiP+LisO28QxdwRACYkoRnl0gw3QHABT6Mim5ZX3WHIyT/vwY3HYRrVuQX/SRfApzKxwiWTNB/hGaZfeK9l9Tfp6GpPgqs40xUEDgtjxsjeeFXsqUAMyzBa4Hq0rYjBAdQVji8uhmpZe0G7g8Eda9jZsvxgBhMJ97y51e2nTa+iA+mr2GsFBq6AZkz93L5bMmLkDc4j0+3c+qYH9zPAL7JzvEanrFU3FeesQjoLRTUT9kQMRNR3eWOPNg95ODfjrS0VgluK0v3GA0LKYY1qDGqm1xh37jGL2GQCnCXrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99d+JfoqS16dpyF8NLVNs69YfSJPV/VSdBfZAFQ5iNs=;
 b=OZQ302WFXT/Kn8gZIvxr9virO27xroAvWf2AY/i2eovwE0EmPfs0ILmBviAPjoYFvpklfs1Qef+MfTyCvmpRPrTJhxFFTap+iYKMMFPrF7P1aLAA5M129MbWdUbC/nQ24fkxYzrsI1BlYqWN8SvZf/XV7OmYeu3HQt2S+bD9xvfwUJV1oz8ZU4HBpw+FLUESAqpnokRF417Qz8fOyQH71sGqfy7BJg1CMUjXK6PeFjnT1TdKty93XRo0AsTKZPsD2pSCTSKzHbQtJtDUgrrOi6DlmA5iCAzxGzct9oowc57tN46KKomCtLPdcxUHnxchiS7iImHwfuYkUWlr/lA6Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99d+JfoqS16dpyF8NLVNs69YfSJPV/VSdBfZAFQ5iNs=;
 b=TXWm33BaNvzIvIOuo/b7inqo6lhdsHCJfweZSaxgq3IreSE3jC/zjru+Ir++pkX7DoiUPHEzD+/B3kt59mmUCxk32/cj5EdC/loY7qu1MheuacdEFCDMvSYegOi2kNIVyCJ25eTVi9WGopYnMLlUKD7KGatMwzyP3lwU0qQwn7Q=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH3PR10MB7209.namprd10.prod.outlook.com (2603:10b6:610:123::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Thu, 5 Dec
 2024 11:08:00 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%3]) with mapi id 15.20.8230.010; Thu, 5 Dec 2024
 11:07:59 +0000
Message-ID: <b0f1b5d9-8634-4524-b882-b0eda67d4f4a@oracle.com>
Date: Thu, 5 Dec 2024 11:07:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: RFT: Testing pahole for the release of v1.28
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>, Daniel Xu <dxu@dxuuu.xyz>,
        Jiri Olsa <jolsa@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Dominique Leuenberger <dimstar@opensuse.org>,
        Dominique Martinet <asmadeus@codewreck.org>, bpf@vger.kernel.org,
        kernel-team@fb.com, dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Z0jVLcpgyENlGg6E@x1>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <Z0jVLcpgyENlGg6E@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH3PR10MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a6ac71f-c085-4bc2-00c7-08dd151d1420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1RtR1p0Unl0ZUQxNTRzRUtqaGV3Sk5vS2JoVGlRN3JJUzhoL2tTNnVDQk9z?=
 =?utf-8?B?cS9PSUV4TTJKSHEzK2sxVlBoOWJuV28xNkJhYTFKN0IyY2lqdzg5VWtJUFVs?=
 =?utf-8?B?b0hJak5lY2xnTFY0NXQzSmNOa1FDTE92MTlEeklaZi82M0hjWlppL0tyZVh2?=
 =?utf-8?B?dWdZZnVGQURYaDgzNTYzeGJodGZoV3RuczMwS3BYZlkyclJJcTZTK3d1UEhn?=
 =?utf-8?B?VEdZWmJna1Q4YSs5NXBoTFJidzdOUlhUK3ZzWk5QUU1EVkxHdFdYOEJKK0g5?=
 =?utf-8?B?YTY0Q1lwWDRDMWlpaDE2YmxqMjF6Wm1rekl6SnQ5U2dyb2trUmpjMjRtV3dC?=
 =?utf-8?B?bDRPeUZpejd1ei84MTY3d3dCcVI4d0pVYXZmTmR2MG9iaWsrRGxIbGVvWUp3?=
 =?utf-8?B?K1RiRXFRemFIWXlXMzVOVVpIcVlDYVpUbkhtaFBMYWpmQSsyN01KMFNveldj?=
 =?utf-8?B?d0ZpWE8xWTN4QmdmcTNZSFI0WTN1OTlaTlpCdy9BS3E5cVJYcmxrOHQ2VjNi?=
 =?utf-8?B?SXJmeTdFbWt0emJmaDZqR2VIS0lucW5ZeVc3ZElFWW9EWVQxVVlIWllnYys2?=
 =?utf-8?B?MlVvaVJnVUF4NHEzTnlJYVFLY1hEcCtnN1AyVngxV0ZFZldxenZqclVhUGpQ?=
 =?utf-8?B?Tmk5TVVGMU1UbFNBOVNWdHNtS0IxY2VOR0NLT0hFazZrUHFLVnN3MFVtNnp0?=
 =?utf-8?B?d2x1a0dneHdEbWxhVnBBakxjM05DaHI0Qm5tdUZpdFpVdTI5RjljYUpaOWdp?=
 =?utf-8?B?WGcxNzB2ZmJQT0tXYXUzZy94UVJWbVlLaDlmREtVUEdDeThXekZacXg5Qk5O?=
 =?utf-8?B?MDhHNm5DZUFFcnE0eXB6MjFPZFJRMkV2WTEyRlo5aitEMGdRRkJ0WFBHWXJP?=
 =?utf-8?B?a3NkckZqWktPOTQ0UTdvNFhJRmUzTkRRTE1ycXRlbnI2bTJYbHQvdWtVQjRn?=
 =?utf-8?B?akhYdWpFcmxTSXZMQmhPWXBZU1JteGZHZTBuaFhPR3RQczFZUVlaUFM4YVFW?=
 =?utf-8?B?cm1jZitta24vQjlLdkhnaForNVROaVd3am1LTGVsbDhhcjMvUjBZbUN5Qzhx?=
 =?utf-8?B?eWZrV3U5c2FhSDF0QzgxNGRqeExHeUIvLzV0ZERGNnFtQThIM3BlUitvSFpN?=
 =?utf-8?B?UGFubGFtSkQyL2YxSFVLbEtsUXp5VEtKamdRQnNJUnJvTDJHb0hybWE2ZHA4?=
 =?utf-8?B?MFQxeGZWZE9sdTFUdTQ0NXdjaVJoSnJZdHdBdnBaTVhMTGd3dzJlZEJITmV5?=
 =?utf-8?B?eFdkVUtuaHpIVDJ4ckhKZkRJS1lGczBnVjJwTGRVU1E1clIxYVExMVpkSXhY?=
 =?utf-8?B?RVp6NXc1TTFGWGI5dnhpQ1lvdElLQzgyUWRLRDRCVnpBOThKOFBUbXZLdHlJ?=
 =?utf-8?B?Kzg4ZEwyNm9yQkVScTFXQnhrVDBjcjZ0NVI2N1FXRjkwZVVFVnc2SmN3bXpj?=
 =?utf-8?B?cEhMU2FiNHRiNjR6WWYvYlg3cGREV2wzaGl5VXVMTVFGNGM3S0NBOUYrN3FO?=
 =?utf-8?B?Y1V5ZHdWMmxPZEJVNHI1MU80UVRua2hJYmIwcExyNzhvcGJLYlRCdzFaUSti?=
 =?utf-8?B?eWUyNGhlcENySWVTUU1SbWFYcGJZNlZiRXFwd1ZqSllPbWhUSEYvT2xzRkJp?=
 =?utf-8?B?aU5yZ05DdnUwVFZtT1d5K0ZtMjl4QklyN1NUUXVSd0x3cHNrYlZoK29LZFF4?=
 =?utf-8?B?SFFEdHg4VTRzdWZvZFNJZHM1RHFYNm5GU2RWR1pFZjJOQjZCOGV6bFRZWDli?=
 =?utf-8?B?M3UvQ1NobUROR0hIOWVKYU0zTld1OXVyQjQrRDFLOWVVNi9WT1I1QjNBT3d5?=
 =?utf-8?Q?DMn94kGaT7FggvgZh1sXbS8NeZpacY/ZgRqhQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEVKYUJGVnVCOGxVcUlGNlYwTXhBNUtuYzMwcnRQWlhLQ0tDTFdaQzV1SXkv?=
 =?utf-8?B?OTV4bUJWTk1wY0FJaU5qSTl1SEV4QUkwOGZoZlNlL2xUUEJiOGdrN3ZtT2Q1?=
 =?utf-8?B?TVNpK1I2L1QxMXpBODh3ZS9nQkU2TG5XZDJpVk55TkVhVVk5K0htS1Fmd1hW?=
 =?utf-8?B?WVVtTCtja3pQRDcrZC80NHh5cGdGRTJkbC9IdzlEQ2dzTlhZTTRtbk4weWEr?=
 =?utf-8?B?MXZVWTIycTBIYTk0Mk1OTUIxSmtadXV3Ry9wM05Wa3VNb1BYYW0wS084V0do?=
 =?utf-8?B?MDRIcHVoWHFyNjNSZENpRmJ5UXV6VnpxOXBad2JjWXJTL0VVYUF5R3RDRnZB?=
 =?utf-8?B?MlhqMlEwMTh0TGs0M09XQnVPZmFLRktHL2lzREdyeS9BR1I3QlJmcHN4VTN1?=
 =?utf-8?B?Rm9Xczd0TkI0ZnVhUkNOb1M4Qi9ucVBwcUR5UTN5Q09rNUdwc3BMZUpIeUNl?=
 =?utf-8?B?N211VGVyTFpPeElqYklpMkhqWFErQkpsa1VQM2V0Y0o4bWtnUFdaYnZpZjhv?=
 =?utf-8?B?eTVmUjNPVmgrWmFtcTZ3SEJXeElkaGVDN1N5QkJORVI0YlFPZVlacFgwL1BN?=
 =?utf-8?B?UEdzMjNpYVpMWVFHUHpVWnY3TEdhUFZvUitiZDVmOUlKc3FzRlJQZUg4Ni80?=
 =?utf-8?B?Ny9rejJpTFpFY1NIbGV2dVN6dFJQb25UZERYcmk0Q3k3Z20zdWs5d1RISDQz?=
 =?utf-8?B?OUwrckIxVFRWQ0NYU2dDUG5UMEhlTlNVbUtoV01mZHlVbTVYMW1iczhhK2VV?=
 =?utf-8?B?aHQ2ZUNYRnVKbm1HQ2k4L21IYm1wRTJ2OHlzc1RhMGE4RG40QXFIYWE3dTVx?=
 =?utf-8?B?WVVjUnZSZ0xzNWJmT0RDS3pOSGNHTSsvRlVmQWpzdWFYVitBK0RZT2JLYkxx?=
 =?utf-8?B?UHRxVjVVc2R3YmlOcFVsWHF6ZUw5MlRobXVxeFVMQUhmYzlicEZwbXRoNDRh?=
 =?utf-8?B?MXByTGpudlRvSEp4SGp3SlFjL2ZIREp0YXJmbElhWFUzdHU1ZWp6eldkN09K?=
 =?utf-8?B?Y0RMODZpZ1NOYW9SdEIyaE1yZVZVSWxrcFd4eWYwUGt6Rk4rakhqTVRlR1NG?=
 =?utf-8?B?Wm1VSjQ2SlF4c2xqcENlNldPZkRUOUNCRFBoTkVVTjVPb3BjV09rN3hkYU5V?=
 =?utf-8?B?djdCVmtGSkw5dFpWUER0MnpJZS9YaFFRMlhmaExnTGxhTU92SURBNEpyMk5a?=
 =?utf-8?B?Qlhzdkp2Qm5CUno5cXRoZGdxSEdvZlcvWk5GMHR6ZXhNa0tLTEhMb0l2R0s4?=
 =?utf-8?B?NTdBN3hoWDlxZDdyRXp0cTlnR2tnMVJ3NFhmVkczOFN4Rkc5TVpXR05vb2RY?=
 =?utf-8?B?aE5CRDNkRGNZalFlV3pJV2N5ekRBZ2Y4SUE2VjlpS0czamFRazZlcXIwejdQ?=
 =?utf-8?B?eklnTG12dlRLdkNaU0JCRHQwbmJUZmVaeXN0ZEp1Vm9aZW9VNEhZcC83U2wr?=
 =?utf-8?B?bldEVm1EL21lV1VnYmV1Q05CYjB2SVBPWnhGOFpxS2NOdDFvUkhiZ0N5SDQ2?=
 =?utf-8?B?TERoRjlhQnR0ak1qSnR6VDg5UUpFOHZOekpPM05SOThMUUE1NUxTSFNlNDFI?=
 =?utf-8?B?RkhsMHV0MFVwSFAvc1FvRHcrT2NBbmdsWGMwdktaN1RTaHBDcHpOaTZUeTR3?=
 =?utf-8?B?dnExL29IdkhaTjBHbkd2Zi9xanVOZWJRekJjKzhjZDUwbkdvYXNMUldjRjNv?=
 =?utf-8?B?ZnF2UERKdHlaWUpnZjVLaURIMXVGZzgxempTamQrL0o4d1YxZm52M3dhVG9p?=
 =?utf-8?B?eG5acXI5a0ozYVJqeXBBN0R2NmFqUm1GUURHdDdEMDM3NXlYN2ZvREpYaWE5?=
 =?utf-8?B?OGlWSC9mWFRzanhaaDVPanFhM3VTN21xQmVHNmgwcDQwM1NKdit1K05CUm8y?=
 =?utf-8?B?b216Vjh3K2ZEd2VHbXpPQjJPeEtKbzcrRVRSd1B4amNPdFhkZUJnYnZSblFO?=
 =?utf-8?B?dktOc3h5ekpab0ZFNk52U2JTRXBGOHNaZkV2TWNMUjVRWnNCa2x4Ui95YmY5?=
 =?utf-8?B?WHZiT1FHQ0dvNWJJSkxtd2g1enU5NnZPWm9NVkI1U08xMGhJSVpWMGVpWHRE?=
 =?utf-8?B?dlMza0JibkhPYmxiTDZMTnYycDNaYkdCd1VZV0xWWWpMMERNZlJ6SUMvb1BL?=
 =?utf-8?B?RDQzeFFxOVpXSk9uM3lYdHZiWk1UZjdxckhoN2w3MEM5MjRUUmVMbkR2M0FJ?=
 =?utf-8?Q?x45AL+cdbSKyQLVUvrSnWMw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SBr9YnWHrC2zkNK6EmexudMKMT8yKqNebVd2mabd2RjyXSD/lnEzHdKPGDpgzTj5OIBwcvWE6RYmhHYusbwZaZeJhHvyQDG+6mF3+qH7o0fvw38MqjuDf7i1aGcyBdLgu75G3kjX5m+3IuG8ZWDLDKc7tXN63aza54I5gRRFYkMEo3cQwR6fOGx2jpTzI3/BoOMjmhAgg7RN21qyk8lJTvtjkAI611supRNzKPosY53TmdHjvjc3utTeZsxVT1k6h2U+3J2pNvD7SzNW98Ad2/aCFomIFDbHhgIrfHRsU3ApCeX/GHOPhhwk5r1oZSgjp5JJABnn4+pjHCC1rxz8lYn9YbsBxpt9ejcv/0aYHbz3h/1KYIF8MBlxQyMmGD/48+F+i7opmcx+FySJ9lL/W/P+C3gDUu+c6L4LXr1euh6ULptIMgYVdz3t7IXwmPzJ1+aEymcOzs9PmwDveKGVZBWgz7OBc6ayIqhHH/lvJ3JQPQgVWVsAdqnVF3nl2cwzT5CyleXcCvxnoLEYrKbPWPiZIKBD12+Qb1pFhlPqdBg6ANF9FncW92Kk6UAzqA1mEVOkPURh/MPz2A4NwPtoTtSYbBKs3g2VZyVQl9dxUHM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6ac71f-c085-4bc2-00c7-08dd151d1420
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 11:07:59.8656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTqpngVyo74vULQYskeOS0YO7Tcb3tU6J/C+zuuAhlfrdR9sxOy9PvmoUdMcaz+bkK6Nq+gX0Py+7yG6w4PrMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7209
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-05_08,2024-12-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412050079
X-Proofpoint-GUID: Cy03lOvxkALZ_6uejq0zGgCrooxKIf15
X-Proofpoint-ORIG-GUID: Cy03lOvxkALZ_6uejq0zGgCrooxKIf15

On 28/11/2024 20:40, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> 	Please consider testing what is in the master branch both in
> kernel.org as in github:
> 
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git
> https://github.com/acmel/dwarves.git
> 
> 	So that we can release v1.28, we want to follow the cadence of
> the kernel, i.e. since the kernel was recently released, we should
> release a new version of pahole, and this one is long overdue.
> 
> 	We'll then try to release v1.29 shortly after Linus releases
> v6.13, and so on.
> 
> 	Alan Maguire accepted to co-maintain pahole and as soon as he
> gets a kernel.org account he'll be able to help me in processing
> patches, that we expect to continue with the current fashion of being
> tested and reviewed by as many developers as possible, its greatly
> appreciated and a good way for us to keep this codebase in shape.
> 
> Thanks a lot for all the help,
> 
> - Arnaldo

Looks good on my side too; tested x86_64/aarch64 using latest bpf-next
and ran dwarves tests.

Tested-by: Alan Maguire <alan.maguire@oracle.com>

