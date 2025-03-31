Return-Path: <bpf+bounces-54954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6274A763E9
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 12:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF6FB7A2DB4
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 10:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABFE1DF270;
	Mon, 31 Mar 2025 10:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JMXYxv0d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vtTK7iyN"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BEC157A5A
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 10:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743416067; cv=fail; b=Yx805eJ5D6tOYvF1qkfm/G30V3j38tX1fvWFEIlTkiW3heqprbi/vsqiIAeLyhksV2sJKNbBHViDQnUAr6RdD4UxygeKMtjIOLQyvntAD3pSfGsRfIeOvtn39ew7ljNpW7314DILdQBAsx9oQt9MSHBCbBd9dZqMv+xJPlD4DxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743416067; c=relaxed/simple;
	bh=TwJNyIikDr4UCFLFDU7ynOa2eiipivdD6ClM+u9LK2Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h9y82Adp2O+yHYHZFgrinlKKo8EMZxSuvEhecLazl3BULU7usVruXNqhxOOOKqo/YceV6YbPY4v9hExOsoU+dCLKrrJwf5qPnYHlzBhg7q5mwwur9oD4Bo19Rl8bRi7ZfsPGGjYmz35LduEj+Rf9ZOPcTkbnyH5q64z78mq3vOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JMXYxv0d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vtTK7iyN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52UMVpYm019445;
	Mon, 31 Mar 2025 10:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Tl0x0by6ZIfXklNczc5ARGd8cKxu9ww1LeuurP4yBlI=; b=
	JMXYxv0dUlO2ZTy6l2h9GoI7XdrbEhrPnj2JL2PZEJ1KLGAy6UzTHu9t4CiJJdjq
	IBHvOGJk5Y9Sydtahvj9OuzDOdqT2iVA2t9gaK9xbfvbpd6bCdhJlPqUbsdFzbFE
	K5KNlleIT0ror+utZ2VlX9xvYMI/Ts4koz1o7wKDOXZiUS9YZqhPXO213zEEcce9
	Masj1RrQ9zFDRfUT2sCDUdLP+GZxFmpJJ+UBPNL4S/wQE1YMjREWeDYSC7I18vNx
	IpuWyQ8EoOh+1VTistmf83KcN3pEF2OBmRTMGvMwBnupHt2N7LH5/RbrEKdqTaoI
	46z4eINQ0t3XbpXZ4/saeA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8wcaxdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 10:13:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52V9ecRF003543;
	Mon, 31 Mar 2025 10:13:57 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45p7a7gd9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 10:13:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOgbmJkuWeKPLIhZoYCXBdX8Qyfww5+AWt6SD3JHgx/pGPnpCH1y00AQK1Lb9sk1Icl5z9haVv2HcZmjtnGfoUlboxWtGJrMH3sD5BYYUWRriLMDvU14jz52AwDURVcVVaOQmva529tcmybjdAQdqrn8RTuGDyNhHmT4KTFiAJwCJ+Ho0jDhdZ5HwK/5B2eRLOGFIZBRfaAE4/tdGnw0txcrVz5z6mKFLbUaLl4hlpiIKPyq0O5Z9AK43xVsPRCPzaDgid6rsrgxC8XeYZWnigX6vfDJVpmBdxS5Txh7NZXcIiw5A/QSWdQJz9sAGpkmJVaKqqt9+Z5jJ9+vfZAKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tl0x0by6ZIfXklNczc5ARGd8cKxu9ww1LeuurP4yBlI=;
 b=InNrc8z8Imd8MOkOuOABij8V8/vKgRWRWXLPv4/0imS0Z2tlM23+YzS9V1vASy+vaLlyopI6R30uOj+etl6BPsi8WEZSB/sO74YPVaMpx8+o3dq5jxJfBZN5FnIbynRP0702m0EeoRHOuqonfbdeYEk3mg1xYh0qLWBppCjM6aNhsOHL2qKZgXaVmsfzt37Lg6F7kqCrl12yUEBSvNNwCYEAYQXp28uZjYOz+fQO+oQCxvbgJZ8wKguW9qBxDbq8NJbq0rBVbKQC9VjEQR5VEAuxSgiCTCVyo/uXmMq9ki3CNUI/3knLAJ2E9koHv7Pmjrl3pLZzNdFinUnBha70IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tl0x0by6ZIfXklNczc5ARGd8cKxu9ww1LeuurP4yBlI=;
 b=vtTK7iyNEcnzf0bMAeJzS1v3gA3YWZJzvmCRn0c4IWRQ8f7GzzV+2YVVIrHM32EizS3HMSKFEMI3FNP6smvpdt/lP7OhOj6TXVx0T5J+99bWLScAwdo+sIjplfClOPUj49oqutK+zr8O8p0NjyA9L5yOMERVvlWBv/I3rcBv14A=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ2PR10MB7785.namprd10.prod.outlook.com (2603:10b6:a03:56b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.28; Mon, 31 Mar
 2025 10:13:54 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.8583.038; Mon, 31 Mar 2025
 10:13:53 +0000
Message-ID: <3c6f539b-b498-4587-b0dc-5fdeba717600@oracle.com>
Date: Mon, 31 Mar 2025 11:13:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Question: fentry on kernel func optimized by compiler
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Tao Chen <chen.dylane@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
        bpf <bpf@vger.kernel.org>
References: <7e46c811-e85b-4001-8fac-b16aa0e9815f@linux.dev>
 <CAEf4BzaEg1mPag0-bAPVeJhj-BL_ssABBAOc_AhFvOLi2GkrEg@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzaEg1mPag0-bAPVeJhj-BL_ssABBAOc_AhFvOLi2GkrEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0485.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::10) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ2PR10MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: 748d6836-db8c-49cb-ba7c-08dd703cbd7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmtyVFZRam9kVGNKSFpYTE10YUZnelBsQVVnTEJQU3RjR3JqbjBIbnRLZUkv?=
 =?utf-8?B?R29Ea2xJMlNYVHlROFg5SnIzQmJndThOMkJhblEwYldycUxmeklkSkpuaktU?=
 =?utf-8?B?MW53MXJrRFBEWWJmak1ZWkVLbmVDa2NrVnNiNlVRa2x4Yy9JeklWMW1RbGxV?=
 =?utf-8?B?UzBzbFVWT1hrZDlod1hMS0JGcUtGeW1FUWpQOHdZNHB3Wml4U042Ujhtd25Y?=
 =?utf-8?B?eW5oMkV6YUk2OUZxVWgrenh3WEYwNjl4U0wzMDBwUmlLVldKSC9WbTQ1dE5B?=
 =?utf-8?B?cEJNdG5MMFFlVlkwc3h3VVRtNyt4eGs1eHJUZUg5Wmh1UitPbC9OU29TYmdT?=
 =?utf-8?B?UE1hNVN1Qlo5dWczM3FKNGIzR1MwSUFsK0dOK0svRkdRQVorY21xa3h0RFNw?=
 =?utf-8?B?MFJudCtiNnpZKzJLSUZkTHp2eGlpWGhNR1hMLzVIdTYyY1BYWUpvajBVcGVV?=
 =?utf-8?B?ck9oL0RoM0ljNUdVVVliSS9aNU1MZDc3VnNQRCtPQktVZVZPZ3ozUXIwaHRX?=
 =?utf-8?B?TnJmdElnZGlmOC9vbmtCRWxZZVVHbmZZeWoraUNXd0RZbTl6Z256WlQ3a3V2?=
 =?utf-8?B?MjB0cWVBb2VlSjFLSjd1cjlDczAvWS9qWGljN25LWlhoZmZiRjJVeHl6N25x?=
 =?utf-8?B?djlXbXArRTkrelZiRVRqTWtmbEk5VXhKMHIwelJseUdDN1gvUit0REIzeUwr?=
 =?utf-8?B?N1J6YjY3b1lXN2EwZFgrQjJvUjJEZklzOUd3Q1BzL3AzMEJCeWZpYU50T0Q5?=
 =?utf-8?B?QTcrUDE1a2FMT0VYOU40UktVMVhWSEVmZ1h6UVZuQjhkVmxiWTRtVjM3bUhH?=
 =?utf-8?B?aWo3QUhRQzFhRXFpWjVBcytOaW1PYko0VUdmY1lLeURoWEJRbXkxQXgzSy9o?=
 =?utf-8?B?d0V3bDg5ZXVQOHRHQTJpQmVPTkRsT2FEVWlLa0dlSjR0bVlTQW4xTnBNZE1q?=
 =?utf-8?B?RDNGNUF2cTBKTVlOMzlTazBTT3JrU1dOSm1ZNHZjZ21wTklRMm40L2JoMHc1?=
 =?utf-8?B?YkFDaWpkUWtWakxzRFdOUzVrejE1S1k0K0FaR1dCM1piV3c0VDFncS9LVHg2?=
 =?utf-8?B?OGpPQ2dNdXlLWjRxWEJPeXF3SlpVSi83UlQ1UVVmdFJaTnF1QUZ6NTVCbytE?=
 =?utf-8?B?VDFTSCtNT0xLU3N1MUttM0lUenJqanhBdDkvdXMwN2JyWlowVGk3dGsrdnVa?=
 =?utf-8?B?c3Q0V2hKdFlaWTRHSHRMWVVoYVNDYnp1d2pWSmMvWWFITC9kaEFXZDZ1cTFj?=
 =?utf-8?B?aEpZc3hQZWRaWmZCK0pnb2FnTjVDRzNlNDNjMXRxdXlvUHpNT0ZzS2RYU3dO?=
 =?utf-8?B?a0NreGNCWVFudy9WWDhjdlVlSXE0eXhNUEVoVGxIbDNwUlg5cGVSWDQ0NS9D?=
 =?utf-8?B?UTltSkFsNWVwTTRIL0FVdU1XUlcvaHJDc0xodGNZUzF4cGlmV1pBU21TdGNU?=
 =?utf-8?B?cDhweFQ2TVhkNjRuUUhzdnVWN2hCb1NOY0QvdTV1bmU2Mm1wSkloYlYzNnFa?=
 =?utf-8?B?Qks4NzUvYzlYTDVjNzJac1FEb3ZYMmYwbThuVVdodUZtMWlKQ0t3WHVadEZV?=
 =?utf-8?B?ZGdZMzdUTnkvcnlVT2c5ZEYxS2JWZnNKZXZ1NUZyS0NsRGtvaGNPVFN1elJO?=
 =?utf-8?B?UHZyMkg5SlovSlRSRE5CQUxRUFlsOWpRa0NqTUVRdkZIaktzMmh4eEFWZXlE?=
 =?utf-8?B?UXpSQ0FqV0MxTmJIUlY3SWxKSGJ4Y0Y5b2VGVVY3TUM0dVNRaGRKSWJIZkpx?=
 =?utf-8?B?dlVLelBNMmZxWVBHbk1MTzVlck1ZQ1JZdU0zeTR0bVdsRCtpekF5b1UvWWxL?=
 =?utf-8?B?NmY1YWp0QUx3SlJTNEIxN1A0dC9wd0FLVzVUOVFWOFFtUTlMQi9zRFV6c0cx?=
 =?utf-8?Q?5XZJjPgGkgEVk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2d0Tis0MmhHZDY1a0JZOHFSZ0RQS25EVzV0K2Q0eUxRVWhxanJmaEJTZlV5?=
 =?utf-8?B?US92YlA5MTMyUVI3ZEM4RWdtakhBc29Cd3hOU0tMQUJySkpiRDhwcDFPV3FH?=
 =?utf-8?B?cTFnR2tMR3hDck5CMUwvSXliRUFmMXkvZHNUYVkxZThSL1NhOXpZN1plY1ls?=
 =?utf-8?B?RW1CZEhBN2lDTjZWdHNISUV1cFpPV2NjVUZNamI5SENtcFJ3L0R2QVE5eTU2?=
 =?utf-8?B?Rmh4MGFXWmZzczhFUmlqZ3AvTXUwaC9vMHlaNVBBaGw0UmZYcHhscjF6U0U2?=
 =?utf-8?B?OTBWcThnWk1WWTdVZk1wUlVMTzlKa0ZuVlVjN2xsdlNheEd6VkloMkIvLzRR?=
 =?utf-8?B?SmtVdFVrMWxvMjBoWlI0cENCc3VleUFQS2kxaitQa3g1bmNwK2pTR3pBMFNp?=
 =?utf-8?B?c1czTldYZjFEczdQdytnbktLcXVVZkw5Q201VmFGVFJ0ZXV5Z254Q25tYXlY?=
 =?utf-8?B?cnN0QkU4RkRPWTdVY1NJdlBjUFVKRGowMytNSHhKQ3EybDk3K2tUcG1uZUUx?=
 =?utf-8?B?MFl1Y1ZTWXF3T0tlM1FEOHdzUEVITFUxdy9IRFRNS0VvSFU2Uld6UFAvY3pZ?=
 =?utf-8?B?NTM5OTU3bmV2WkdMZVlWZ1lVWSsyNGdrRFUyY2dEZ2lKQ0xPZFg4UnJNRGRp?=
 =?utf-8?B?Y002a3dhU1FURFFCOTBqeGlsbUtITWVGRzMrMlBZSEE0MUJobUhyUWswNHRM?=
 =?utf-8?B?KzNpL0hnK2VNMU1EbU1rMjRTcUd6bkdnemdZS0VsSFFuaExkQVY4MCtMRXlY?=
 =?utf-8?B?UE84ZW1IYzA4UmdoQVlTZDBBOHFhRzBBVTlqRXZrTVFhWmhwTjQ3WTgvbEFW?=
 =?utf-8?B?UkI5cTZXV0RIS2hPTUovaGVLZlhkbzdodHFkNG9pSFpFRHNLUU93aWdrTk04?=
 =?utf-8?B?dDIxUndUVXJCL1F3azBiKzFEaDNKRGhKUStkRG1jaWpOd2FmNDZqYVo3ZkJh?=
 =?utf-8?B?d2pUWFNwejRyeXBmZVpGeGR5UzkxeFJDbURLS3VXeVVuM1FnM0IyMFJiUmcy?=
 =?utf-8?B?Q3VBV0VHNU4wOEZpRTZZOG1sNjVJME9OMFErNVptU3pXY1FiTHArZDVGczNO?=
 =?utf-8?B?Q212QmIvajFXOUUwcmNqUkxwTXh2WFVjMW1WdytnY0locnZFRnpuaDRGYTBp?=
 =?utf-8?B?YjVSVkxXekdkejBSVFJ3d25tZkJHZERlNjN4VVdDVHFxUmtPWDFZVVNXZ014?=
 =?utf-8?B?Wnc3RCtPZ3FoTHB6NXJkZHZCcTlJWE9jd2NhK0xORG94MGJ0V1ZhM0VXR01N?=
 =?utf-8?B?ZUJiZTRPUDBldFF0Y1BORFhyajNDdzlLZmFlSDBEYzN2ZFFMQ1YxVHVPRkhV?=
 =?utf-8?B?VVIvb3FJaDZHZzc0VVplNmlpV2VTRUNjV0FWUzhZeVR2TCtDTFRVMUlBTDBU?=
 =?utf-8?B?TnlOTWlUTlhwOWg1MnA5VHJhR3ZZYjQ3NVZGTXJFeWR0RkQrY0t0RlhwTVBk?=
 =?utf-8?B?LzFVbi9MQVBZbFFIMDQ5S2JCZk9EVzk5bUxYRDluMC93SVBzVTI3NXBNQ0dz?=
 =?utf-8?B?MjViK0dMSnFMSUVOdUtpREYzOG9NRndnOGlzcFlzNGs2Y3lUMUMwNjUwSng2?=
 =?utf-8?B?YTZQRnp2ZHNsYjZMUGhTbFZ6L2lXcXZGYmIzQU4zSDllS3VvMTl6MVR1Z09N?=
 =?utf-8?B?NitWZjdYem5nbytsMVpiNjhxVVhhNjhOYmRXSk9jWEtTazZ4UkZ5ZVlZdGxp?=
 =?utf-8?B?WUN3R1MrRHdNN2tkV0xtU2FwMmhraGVZKzFpZEFxRndPSWt0Ty95Ujh5a2NB?=
 =?utf-8?B?TERrcGFoWUhXUHVrS0tnOFREdTVVZTk3OWtTV1NvY0hhdStJQllwOGRyOFk4?=
 =?utf-8?B?cDJUZ0hOT3dMdUJZOW1vbnREakY5bDFzWmNDaXM0ZTdPN2dHakg4UXdFK0lV?=
 =?utf-8?B?Z0MrZ3NSNlF3VVNRL3pxSEpQWTBISGRXa3lVOUozQ0VhSHBXQWgzVGxXNkpP?=
 =?utf-8?B?N2w3S0VnVVVwejgrakZCT3E4WEFUWWllL3JERzFqZFFTRXhuZElvM0VjSzRR?=
 =?utf-8?B?akx4ekZ0dEM4QyttU3BETFNBZmVvQW5MSU42dlczL0VjekVZc1VCNnc5K3B0?=
 =?utf-8?B?Wk53cWNnN3lHaytxS21zQnVMTTBqcldWSGJDSEZkYzA1SkRTc0Mzd0JnaEl6?=
 =?utf-8?B?OUQ1Wnp2SmYyVmlTaTVVYi8yU2RWRm8vZE8zOE54R2V3aWU5QzlRUXEwWW5H?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XTRYz5faHnx77NwN5Dlg1nctuSXALYXX4/inTpnnI8/j3Zi2hqp6SEeG90TDmYttD5l/kUOXIDNyanb26JeiIliM78AI8Vm4/zR8K/Tgz/i4e3eIZQjECxs6RK0QlN4OsJq+px+v887hMnzHOwZOlv+a4UJaZgyuU2vSofSFPs8FSL6GfKZr7QMILCVMmzOiNQK5VimD1za4amtABt12qRBDNg/gzw/AGWaI9eMKIO45keJQi3i6YezOxQP6sHxGGW+n/LR59WBftpeGuOmqFLbrP/K1cSSh4JyG2/clhYcLH4ENjOXKF3+aXsjBbMC9U7e/h4gNboIGms5VZQ2lLExO5+eDLGEJTBB108wj6qYE/e2MkhZGnEpgF5v5gwPwb55m0liYYpvDpfZ56YQ67bBccyshXXXACRSmKMlfANm7MElVJWq6iNzNb+POX7vsNp1sZwAm7hOkG9yGgUy8iNkLf7Pxegg1h2DGozcbj3QFCYxJ3tCZUPdObTM0SYpFB/6+P6d2EMdzBTzrldNCtdo/MNLPs7RjXYg8AMxwRQ+VyamgAFGaq+d5Q3pWba6v//kAY42nnKS8HhASyGXc+c+hdSMvCBwIEA13DyPXBjk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 748d6836-db8c-49cb-ba7c-08dd703cbd7a
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:13:53.7366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcXoYs9ZqjPxrfxbDsJ1z3VWdZ+UgVMeBVT3Jcz3ydPe3qgJDbIgWVcDUFYWQb7WEXENMMQW0OwuOZ+MygurRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503310073
X-Proofpoint-GUID: e7blRMxBZjtyXv_rAHdhnC5KE-fz_AEK
X-Proofpoint-ORIG-GUID: e7blRMxBZjtyXv_rAHdhnC5KE-fz_AEK

On 28/03/2025 17:21, Andrii Nakryiko wrote:
> On Thu, Mar 27, 2025 at 9:03 AM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> Hi,
>>
>> I recently encountered a problem when using fentry to trace kernel
>> functions optimized by compiler, the specific situation is as follows:
>> https://github.com/bpftrace/bpftrace/issues/3940
>>
>> Simply put, some functions have been optimized by the compiler. The
>> original function names are found through BTF, but the optimized
>> functions are the ones that exist in kallsyms_lookup_name. Therefore,
>> the two do not match.
>>
>>          func_proto = btf_type_by_id(desc_btf, func->type);
>>          if (!func_proto || !btf_type_is_func_proto(func_proto)) {
>>                  verbose(env, "kernel function btf_id %u does not have a
>> valid func_proto\n",
>>                          func_id);
>>                  return -EINVAL;
>>          }
>>
>>          func_name = btf_name_by_offset(desc_btf, func->name_off);
>>          addr = kallsyms_lookup_name(func_name);
>>          if (!addr) {
>>                  verbose(env, "cannot find address for kernel function
>> %s\n",
>>                          func_name);
>>                  return -EINVAL;
>>          }
>>
>> I have made a simple statistics and there are approximately more than
>> 2,000 functions in Ubuntu 24.04.
>>
>> dylane@2404:~$ cat /proc/kallsyms | grep isra | wc -l
>> 2324
>>
>> So can we add a judgment from libbpf. If it is an optimized function,
> 
> No, we cannot. It's a different function at that point and libbpf
> isn't going to be in the business of guessing on behalf of the user
> whether it's ok to do or not.
> 
> But the user can use multi-kprobe with `prefix*` naming, if they
> encountered (or are anticipating) this situation and think it's fine
> for them.
> 
> As for fentry/fexit, you need to have the correct BTF ID associated
> with that function anyways, so I'm not sure that currently you can
> attach fentry/fexit to such compiler-optimized functions at all
> (pahole won't produce BTF for such functions, right?).
> 

Yep, BTF will not be there for all cases, but ever since we've had the
"optimized_func" BTF feature, we've have encoded BTF for suffixed
functions as long as their parameters are not optimized away and as long
as we don't have multiple inconsistent representations associated with a
function (say two differing function signatures for the same name).
Optimization away of parameters happens quite frequently, but not always
for .isra.0 functions so they are potentially sometimes safe for fentry.

The complication here is that - by design - the function name in BTF
will be the prefix; i.e. "foo" not "foo.isra.0". So how we match up the
BTF with the right suffixed function is an issue; a single function
prefix can have ".isra.0" and ".cold.0" suffixes associated for example.
The latter isn't really a function entry point (in the C code at least);
it's just a split of the function into common path and less common path
for better code locality for the more commonly-executed code.

Yonghong and I talked about this a bit last year in Plumbers, but it did
occur to me that there are conditions where we could match up the prefix
from BTF with a guaranteed fentry point for the function using info we
have today.

/sys/kernel/tracing/available_filter_functions_addr has similar info to
/proc/kallysyms but as far as I understand it we are also guaranteed
that the associated addresses correspond to real function entry points.
So because the BTF representation currently ensures consistency _and_
available function parameters, I think we could use
available_filter_functions_addr to carry out the match and provide the
right function address for the BTF representation.

In the future, the hope is we can handle inconsistent representations
too in BTF, but the above represents a possible approach we could
implement today I think, though I may be missing something. Thanks!

Alan

