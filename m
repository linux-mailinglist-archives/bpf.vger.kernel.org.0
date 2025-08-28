Return-Path: <bpf+bounces-66819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA6EB39B2B
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 13:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6210E4E4050
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 11:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0724F30E0CB;
	Thu, 28 Aug 2025 11:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FAlTtwo2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IwxwLVv1"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E311330F522;
	Thu, 28 Aug 2025 11:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756379534; cv=fail; b=G1i2u2BRb3xf/QaM+k/gSXdkFLIJMEO4oks9NxM+Xhb1baIcQNEB3kZSolxIJwbLjOeT67hn+8Bx/CcuVm0FRyzTAKAq2BOCwMY+cbPD7Nyv+Txx6gAPPiLMsEH2OpTRv5NDiQIJfAV0F3lI2mccF4oYlcr7uUg2eQMUkzgqShI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756379534; c=relaxed/simple;
	bh=JEIqUK7Vr8DHg0eoHlx3BKaYUKNRA6BgtqVF5hs1pek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A8vnmija5+Pjy7Ca6KlWy50i/LBuNzYOF+xc52D1Pb2piW0HqIGlduYZ8P+l5LpQIBoRvsJJL+89yR1KPfsWzhI0osM4evmH1MPc8WtLUdClv/UGN4rpteZMN3/U7DIZz7yaQrZ++ZahUaetHgGbwED/cqG3p6WYMp+No3h/CkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FAlTtwo2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IwxwLVv1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S8u3Xg007750;
	Thu, 28 Aug 2025 11:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=l45h4UokURL/AVuYMOlR62LNIgMKgaWvFfrV9/oJk4k=; b=
	FAlTtwo29l76A9e6Nu2CbqQw2ezDq4h54XTHC8Mbc7mhdSoDbdQsqj2hr7WbWM53
	AZQUhl0FK+N9EClg13VfIQAkZ5wmZ8Jt4bTXCbkamBWI6kI1s0w4Y9J3Ul1/Q6Mi
	q7wlYPMTKItozfPVlhQn/JwWbjYYLrr7Eqj0R+2yIe3WsM1Lg905UW1De5c+uqBR
	41qL8BnNxZtQc6JSuemcD8J94/Mf6EKIGpkA07MBvQxwOWOyUZz4ChM4m2yiltCt
	lrQA9t9TuxDzmKIMjEEMGnmEAFYtHwqDzhk+hy1TX/fNzFWgTzjbPCsSp9vbWvrx
	DTsZczsj0NLCBkjmFh/EOQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q42t8486-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 11:11:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57S9exh2005663;
	Thu, 28 Aug 2025 11:11:33 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48qj8c0fnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 11:11:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHE/sDDEX+HS1BU5MVSHioXpyENE8IxTskMfe6CnIaSr5PoliwTgCAWL/z+1AtBlywWnAVn4RBC09ldteBp+LRvizP/pb5FZl13A5Bc5QeMwykfVEjl2EcoVlt57fdrGBbPmvAE6+3i78Gl2TOsVhCwp7kEbuEbOpPq6ehZSS01zainV+7xKeqQ0JvapYJ+cy0a64hMYJRzM80DGw9yOERYuNSE07YDdsfiqZGOFN6245v+pE8Odf4W86oFlyYuWRW0AkL7bOLNELghg/1SR44qcigTcxd5N0c6lnSJMhN4Q+g3kGG9Md6bUonGyZ7jOEwP15Tw3gLwaX+RnAFNzMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l45h4UokURL/AVuYMOlR62LNIgMKgaWvFfrV9/oJk4k=;
 b=iR+Eoxn/nYUmMptYeoELq7ulgHib9SpbVkWE8TKkRFQE6M8HD3UqmWf4ZAT6bYz/w62yEyQhVlTtMX99OBpTKV1EoyD+V4a+mPo4ZN9xjW/mbuQ8T3ARloYlnpU0unGR0CeCbUFelRUF0kfPtGoxTpgzHnE3KnBujkH9ckiuvli1rwRm+YUH7MLCza3xMEqrQ97batPcevmFMGzO+vcbaFy9Phhtrin94xZ6SHeqV3q3DDB6d+yftSZCw6nCsJLFdVDSYgDtOBMOBMayaudEXl/lyFapwaMJd/LY6AkOO7uDcOcIRlMgJLykDgfenLkOzuVk2ZEOeBg01nNa4VVHxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l45h4UokURL/AVuYMOlR62LNIgMKgaWvFfrV9/oJk4k=;
 b=IwxwLVv1D4mpBcl/rSg+k7g1G8LZoMUswWNkNb+77Xe0YAbw9a3O1YZfnP9J3FP/adkQASy4xL8V0VRUIUZhFJ+GLKu7nGw5wO/d6hsZurf6JjYWBZW5vDO5K9sKXFKCvAgMm1SjE86jEYrObnY9HNjaJmrTqZiT2Mct9TTdtn8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN2PR10MB4223.namprd10.prod.outlook.com (2603:10b6:208:1dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 11:11:26 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 11:11:26 +0000
Date: Thu, 28 Aug 2025 12:11:22 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 mm-new 04/10] bpf: mark vma->vm_mm as trusted
Message-ID: <b335afe9-be7a-46bb-bf92-37abf806d164@lucifer.local>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
 <20250826071948.2618-5-laoar.shao@gmail.com>
 <bca7698c-7617-4584-afaa-4c3d2c971a79@lucifer.local>
 <CALOAHbDxxN8CsGwAWQU4XRkG8NvU-chbiDv=oKW0mADSf1vaiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDxxN8CsGwAWQU4XRkG8NvU-chbiDv=oKW0mADSf1vaiQ@mail.gmail.com>
X-ClientProxiedBy: GVZP280CA0046.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN2PR10MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: 691a7268-661c-43b3-2d1b-08dde623a166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEViRm9wZkRvcUNlZXBjVmYrQ1g3S29wWXNnbWR1VTVxZUYxRzV4UTc0R0Q2?=
 =?utf-8?B?Q1IxNGZyaXh3NmJLYWVIUytVUGtMcXUvaW9KMU9sMVVobENnSitPSGREOTFI?=
 =?utf-8?B?cnl3RldLQ1ZJaFVKWkJpTXd2NHdHaGcyVUpiaVB0NEFTdHQza3BFYXl0bG01?=
 =?utf-8?B?Z3A4OTNacWw3STd6WmtsODNTbG93OVJaWWhFakUxZkdpdGYySmsvTkowSkps?=
 =?utf-8?B?amJyOEFRa2JEZWQwY3FmNndTcTE5YytnWENmNk12Rm1OSTBUV2tkdy8xZUh6?=
 =?utf-8?B?bnhRMDR1UEF0cXBBbU5rMjF1TEh5NzNZemZjRW9XOVdKdVNnNDVRTWt5RmRq?=
 =?utf-8?B?ZHErRG1LMmVxZlI4SHcwUzdwc0hwbXhST0hYdEFNTTIvTE5HNlFHRE1nYzhF?=
 =?utf-8?B?alI4YUpXUmgvNjVGL1VFbkp5a09LR2V5SXF3TlVpanJ6TGhocEdyV3dsS3Rh?=
 =?utf-8?B?N0NwSk9IVXQwZEFlWWJrbFpaTGQ5bmMrUXZsblRIMEQzM2p5eDlSZDZPb0U0?=
 =?utf-8?B?eUN2YmNLVmRsVEdOQW5EbWN2VDZMUnFpTHI5UEIyb0ZOMGdxK3V6dG1ZZUlV?=
 =?utf-8?B?bTNxN3ZMdVhHS1hycWhoNEwwckw5U3kzY0VOZ09LWXFDbFltbTc0STQzTjAw?=
 =?utf-8?B?dUw4bmRYbTkwWTQ3eURQSXZkZ3hlejB2Qld2TzdIOFB2dklENGVQcFFkclVV?=
 =?utf-8?B?d1pRT1Zia0xRYnVsY1JmZWM5M1I3alplYzNhNUlXbTJGczlDaEFYTXdMV2Zs?=
 =?utf-8?B?bmJ0NHB1MElTaUh0V3h0VTNacDR1anZiZnBFQTVDUlhSdVFrWVBoYm45YVlQ?=
 =?utf-8?B?UXMzWk1tRHN1YUNTUTh6cFJwT1dXZlRsYVlaL2pQSkJpKzVwd3gvYjFHa0l0?=
 =?utf-8?B?VnNKcjVHYWlGV1dnNmRpaFBrL3ZmdmVmWlhYLzJQMkRWUVQ1Ri9NV2lxQjZU?=
 =?utf-8?B?c3hrQ242dnlWSnBvN0NBUk1Gdm0yam9vTFovTDBCL3ZYM2F4dXNCYTR3dmdE?=
 =?utf-8?B?M3dmL3VWTTNVWFBoQTNHRHlnMThFMG5Qc2VyM2FkZVBOc0wwaXZLbWErcHlv?=
 =?utf-8?B?aWdRakswNHZyOS9hNG5nbjVDZmR2MzhuZ1ZDNXBVT1U3bzRVMWFETG5YZGNG?=
 =?utf-8?B?Y0ZXd2hTQnRVZndaSncxbUF5MkNxY0hVcFEvWFZmR1dhNVhOU0VydzFkUUx2?=
 =?utf-8?B?Wk1CM1BaYzJWOFBycTZoZWgvQTZEWVJVckRSQ3dCYTdVUGJBV2FtK1UycUIy?=
 =?utf-8?B?R0VPZlF5c25iQTJJWmJkWWdRNUFRTFFFamM0bCtEaWZPcnhUWmIvenBITTgz?=
 =?utf-8?B?TEVYaTU4MlBwUzVwV1MxT2ZPK0lKVHBBK3FZWjh5aDYxVlhmdjdFMkRDdFZi?=
 =?utf-8?B?NlJRVGhCMUR5ZnMvNjNhMW00NEk5OGxLMllrSFBZRmZZa3MxQUk1NUIwazR4?=
 =?utf-8?B?aFprUFlscHpicE1lZXNPejlZR0dxT3FhR0laZXlBSUJYSjkxajFmaENycmdM?=
 =?utf-8?B?a0RyQVZ6OVFMa2JWQjZkTHRqdk9GK1g4b0FzRlEyd0lOaFV3YlFJbjF1U2x1?=
 =?utf-8?B?eDR1MGhpNElUc2hQWUtwVkRUM1B3dklXUk5kU1JuejVibklXNHA3ay9SbDVm?=
 =?utf-8?B?NS9vcllEcWRLMDIwSEpEVk9xMWQ2d3hDYUgzb2p6enNUM01iMEhVUmpYTUlm?=
 =?utf-8?B?dnBXck51eW9HcGFJaC9XODJhNHlmN1d0YnNCbGp1WFpjMmxZOEFFODdsYmxa?=
 =?utf-8?B?VmRIdlZOdHNiYzA4bXFtcmNuMUJWZGE1UUZTbnpUTDVQRnhoeDB4OTRFZnZM?=
 =?utf-8?B?bkI1RCtOV1k2TFk1UTZxM0gzc0dWRktrWHNyN0dpdEFuUm15b2NqamFtVDgy?=
 =?utf-8?B?RDlwM252WUx4Ni9CYk4zeHdvN2hoYWw0VC81QmxsaUZFYTVZREZManZyaktO?=
 =?utf-8?Q?PlNYAJwqd20=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGt1QUJHOTVjVFhsK0hPMXVzZC9nVmhYejc0TnV2YWt4cEpvSm1XS0ZJT3RW?=
 =?utf-8?B?M0ZqcTc3TUxFZEs3aStOMVVSRXF4NS9DSHNkTkExSVNMY3hqT0xhcjZLR3U5?=
 =?utf-8?B?MU84cHRCdXc5YnNvQjlrekRFVEphMjQyd3pSOFFvWUd4aWRYaWpjOWU0bHlV?=
 =?utf-8?B?SlNvQVlXdEp0VVFzemlLNEJjK0hDdVJXS1hmSGlhVjQ5SDN5akUreDgvU00y?=
 =?utf-8?B?Uk9RbzA4NkdKVWNIR3hiYnZkcjh1b3RjaGY1M3V3UUxpcTVDUGlJMGZxYmFB?=
 =?utf-8?B?Njc5M2paZEdjcEVnOUoyMHlaTzVnZGZHTUk2bnFpWEoweUIreUNhZVhmSEFP?=
 =?utf-8?B?UGs2Y29KSlhRUXkxYllOMGNHQ3p3NDFEY2hsQVV3dEFlL0xya0piOFBQTnBr?=
 =?utf-8?B?Sk4xNTU5WThvb3p3OE1WK0l1b3hXL2RqUXpIdFNwb3R4U2FCVzJqdlM5eVNL?=
 =?utf-8?B?ak1iUW5teCtldHdlNzAxVUJpaENpU3U3ZmREcHQra21KNGt6a1V1Y1N5OUhZ?=
 =?utf-8?B?cnpiTE9xcWNwRjdPdmJoRnErSlEvbG41SGx1bVZLOC8reGx2VEk0NEhUenM2?=
 =?utf-8?B?a0ZheE1vRG5PdHgvV0thZDhKOHZiQTg5ZnpqUHVFK3ZpQU42cS9QMi9kUmZI?=
 =?utf-8?B?RFk2dnQ5eGpQVUxOaEV6RkVZWVAyNUNkaWVBYXR6SWZvNFloNkp3Qlpxb0lY?=
 =?utf-8?B?Y0dIM1NiVmhmTm5STXZlbkkxTmpxMGZrMnBXT0xFaElIRjNVQzh3OU5oL0RU?=
 =?utf-8?B?Z3BrQ2JtaEtOeXBzNTJMdjl5WU8zaFQvTUdqQnNxa3BnaW45RnAxeENtL0VM?=
 =?utf-8?B?bS9QNUdqYXRWS01McGpDWlgzQzFqWDFYUVFFR2p6R2hwSXQzSlUrYklYZzFE?=
 =?utf-8?B?ZHBxOFFieFRPcGN3NE8xYzhSdHNZVEcwemNWQmlReGtGTEFzUFZiZlViaTlZ?=
 =?utf-8?B?Z3EvM0NYbE1tOUlyVERQUEF1aVBkbGc3bUlocWZRK0sxcHVja2s3c3BLVEM3?=
 =?utf-8?B?MFNSME14UC9tUU4yN1U3VGE2Qm1IR0hTalhVQ2VsdE5JTXpFWXBPZjYwUFNR?=
 =?utf-8?B?UUtBMVJNRzRRNVptY3o4TkIveStyZHdkcW90UStkcVIrN1BGVGFERjg3bnNh?=
 =?utf-8?B?WDdDdUdOaDY5Z1ZBU1BsVVc0Q01TekN4RkdwMTdoNmptQ2ZBL1Y4eE85bm1Q?=
 =?utf-8?B?dW8wdTltQkdaVE9qUHFGZ0lyTjU4Z2NEUkl3aEhuWUwyRDg2dHRyVnFndk1i?=
 =?utf-8?B?YVE1dXRWZE5iYkdqenUxY3YxWnd6eDZCRTlMRHN2c052azJNUENZWVFUenNk?=
 =?utf-8?B?TGFOYUNYSXJnc2hnVlhYa05jUGtFMUFOanJVdVZkUnZuK2R6ZEE3Z1dyeU9U?=
 =?utf-8?B?YVBjRFRuenF3cWlDV0JWM0V5akZKRG1la1UzZm9LZ2xRZDJpczRiby95S0Vp?=
 =?utf-8?B?bzIrY0Z3blkzbytzM0ZMSS84OVl2S1RwRnVvUE9nclh5TnBLK3FLSlF6eVov?=
 =?utf-8?B?U1RpMkZMNzArU0FHZVRHSkRWQzBFUjFXeWZuazlVeFh6MFhpZVJkd1lpeGs3?=
 =?utf-8?B?d1lHVnhHVFJnR214SHhJN2ZiM1BHOS9yVDhaU1hkKzlwY1BKNTlYS1kxRXpP?=
 =?utf-8?B?Z1RaNFk1a1RmTmdOVmxSVHVpYjlyRnBnaWg5amlEMjFhb0h2NGg4VnJKcWtB?=
 =?utf-8?B?ZWFpQWJBVUVqNFllSlI1dGV0WXZUOE4veEdLc3NYaCs1REYxTDFJTjB3amZn?=
 =?utf-8?B?ck9VY1FwbUdBZjZ2aFVrK0dwdzg4SStudlRQZlVtZTZDQzUydHF2T1Zaekdp?=
 =?utf-8?B?Mk9QMWV3ZHV6c1NCam8rdW5tU0lmMUwyRjRLOXpqN2hsMmk2UUkwaFQ2UUJM?=
 =?utf-8?B?V3R0ODVaZjhiR05YeldNclhSL1RBOUpJMWhxa1c3aUVaVEZRaGYxT2g2elFX?=
 =?utf-8?B?TkczOHVOS3FaY0t6RCt1NWxZMk8yZDd6YVdLWVQ3cm5iOHJtUVUvRnZ2Zi9P?=
 =?utf-8?B?WXNUZGRhZWxrWXpENFhGdjVRdFlMcmJMVWpJcmJ6ekxwN2FVNG9iUDRYRUxx?=
 =?utf-8?B?UnpJOWYwMlJQeENPenI0Y09SSVdRNHN1ZTNyMmJRUGFha0h0bldidzJGUUhs?=
 =?utf-8?B?K3NpTjBta0FjbXdIMnZYeUFUL2Z2WGhVb3g1OUxsb1V0bTB3dWl4NG9mdkd4?=
 =?utf-8?B?TUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NACTDJlrYBCOMuSrDNHrK86ACXVEAFJ/VL5AkQ0tkjcocGFmhVxieY4GCM7dTVCjj1NDMq4hzbTTdq4YzLwbfDx08qigM8mtBAMtw/3YUourOB0oLodxBt/TEbrOYleiWpJpj953ylf0LDsNCBOH1Q/R0D4qfBnqdHpnRB3qif/sX6cJuD93KK6dkzGMKZrLIA9Dv83/8vbI4bjpJY094IOo1DLl8IAS+f4KOO41KZNnAQvEumTHnD6EjAv1Jz2n7KsZhN9GddSfD0jvCH6SB/6hviV3Gfc2awfwazXjIV2g3v5DQnaLb6ZonsDIYan/ht8mC6+f7dIJDu2pLjn3tl233rSj4JymhcadKOhMjI9lpiK6Nv+UgjntaFsfc7Yrr0DWxbcn5RKEXC3MvJ1coSyIya12pa3iLeRO5l2IO0qkxU4/4qy1d9XOEbnRZ04tJBWFKr6p5AbdxfasiocTQgGDfXkJ6ZiuXXXf1VJrkCtYLijasufq9+ved8Yg9Nolhk/u1/fJY6CaiAangdqoqTk5Yry2kFy2Uj/9eBTk2iP1FrxtMWXEPEcD5jWJTX3Bz0gzGK/DxzhBLOgr1IbXC0lXEb/6yQ3ZVkAkrFlx/Zo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 691a7268-661c-43b3-2d1b-08dde623a166
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:11:26.3235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKQGYvnEN5taE82f/0I2rLBF5weoeRKLVeywR9h7FhgYb3dgTK4mRb1sw7Sy9ryhwB0M1GgTja4u7GO8kmj7OQz0d97RTWQ3U1hjCe4nMvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4223
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=901 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508280093
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxMyBTYWx0ZWRfX++9kDSvEsrda
 pK6j136KGV6Ah45rqq/epHXou9fSHUJxA0O1xKe2cPEKSgl0oDrXCjwwdmldbpunzxm2QElT67c
 jIeuoEVAosQt4+fVC/Iexb0eDJp27+B7f5J1ua+2KS8kKoQB7Somo9msvO6yL9HzRI6MpVuJE6G
 bVY2cIMGdNvBcwvh+ZsR5CBe6AYsbE7YbfFZOoXvsTjOIBHsY8FJ2Opx21TWQ9D1ZgMyO6COm02
 PymJhup2zpTSGjwiTNQ8xRAESu1gqYW3X3J3yROPCcARyU4jw4QFBEQQMcaNDv7hzvXT1JrqZ2H
 slZWWagZmbj+vSWG8nLixZA+9s+LVb6RUgp4zcFai0dGp+kCJ4MjsEcAVQpyJHlrruhTvwi5/Cd
 /c+4Pu4rdoLM0O4/NIlFE6Vf1eycVw==
X-Proofpoint-ORIG-GUID: nLcgMD7fHdZkgcp2t58699WgIgxZwpUY
X-Authority-Analysis: v=2.4 cv=RqfFLDmK c=1 sm=1 tr=0 ts=68b03966 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=ADF3r5dVd05PiccEAqsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12068
X-Proofpoint-GUID: nLcgMD7fHdZkgcp2t58699WgIgxZwpUY

On Thu, Aug 28, 2025 at 02:12:12PM +0800, Yafang Shao wrote:
> On Wed, Aug 27, 2025 at 11:46 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Tue, Aug 26, 2025 at 03:19:42PM +0800, Yafang Shao wrote:
> > > Every VMA must have an associated mm_struct, and it is safe to access
> >
> > Err this isn't true? Pretty sure special VMAs don't have that set.
>
> I’m not aware of any VMA that doesn’t belong to an mm_struct. If there
> is such a case, it would be helpful if you could point it out. In any
> case, I’ll remove the VMA-related code in the next version since it’s
> unnecessary.

If you lok at get_vma_name() in fs/proc/task_mmu.c you'll see:

	if (!vma->vm_mm) {
		*name = "[vdso]";
		return;
	}

So a VDSO will have this condition.

I did a quick drgn()/printk() test and didn't see any, but maybe my system - but
in any case this appears to be a valid situation that can arise, presumably
because it's a VMA somehow shared with multiple mm's or something truly god
awful like that :)

Cheers, Lorenzo

