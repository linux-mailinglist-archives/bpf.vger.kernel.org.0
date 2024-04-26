Return-Path: <bpf+bounces-27959-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8A68B3ED0
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 20:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1EB282C9C
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 18:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73B7168B06;
	Fri, 26 Apr 2024 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q4P8gu7U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ENPn2EQI"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7B715E5D0
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714154542; cv=fail; b=K4uBYXWtKoxsRdAsqtwa41ZUKb1U3usp7L8pculP23gQLt6CpUzcwr+aii43G/NCbHL3kgHhpdRVHaMhjZq7LvG/xD3xSOpcD6YHs5SdWOJfAJJZvpc+B0KuI2xAYTOEns1/jLCVDoD0pjT5WyV5LIjeEj2dL9W1ctR3rA53uRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714154542; c=relaxed/simple;
	bh=qEWXCdb9TJdLxUZr0iJFhG/ryGL34H7NDwrgtR/HQtU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=GlCCBEFAd0QlXtSx4FkeQ58Xs9n21DFToUObeWlkH6rJWLRoz9tdliOQVadYua35VwcLL32gBa0qJRJR0+dE1+MQbjGFgRXoqa50E6GOTFuAeMYaGhaafG2esxLPzYScx9RPrrlF2f3BdXGQAjqA05Qys6ngdN8zF0LHlhVGkGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q4P8gu7U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ENPn2EQI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43QHdpQf005293;
	Fri, 26 Apr 2024 18:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=HCH5x526S7o3Y0dX5ufs9yiOxQl3XELURFEJvAmAH+s=;
 b=Q4P8gu7UzPnWggMRuUZp2yTUr3+paBtd/Hg/ZXMcerSA1eTwrWS9pW0rV+IN2nHW7qtO
 1axrv9womwReG1fjnJR8eUMx+5QZBHqyGCF8bsv3Xt0Ydc5uVFWxga3+G8SCyboeYz8f
 a1DmXdMxE054e/BZSj0oFeOu/lx4kTzJrZqj8b/R1lCt4F5jFdarTUv2l5olB0GYcmXH
 BgNWluMJAXj90HXQohTEAxt+TKNPsoZxOc9fgBidfwpr+KIaiBGjfauDcXNGa0bf6dYk
 Vd7QmmZzypGL36mU5ZETjIZP78V+jjqZzBIYK6PzVHxo8fRhtm6RihuZ+YTKBiFwKXwB ag== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm68vpjb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 18:02:17 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43QGev9B030835;
	Fri, 26 Apr 2024 18:02:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45bybt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 18:02:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWyGPpFMaqyB0jv11rQf3b3X8c5uUhoEiqMTO9trOzGp98ZzJdTcDz3NkoKUgYZ0uuQZg0zdLqORyZd0/huU5zpeVh31y/EuJothTqGuh4bzcnxok/W3hcyiDFjwp7eNm16fHCioJ1ddnZNJeie0AxkRvNkEtjdGbRJgJ62ySKyB+s5V8ZjnfcZmMaTun2bTbdup8rIiio6G0K64FxEtpRZYZ/uYwCfdJq+tuziIY3Jf2+9EvoQYLTl9U0DQ4FhjWCQjXkcubyhtrm8MfIlde2w11jACj/NePQ/zjKecuCWHxYG1hKG2BtvxmVO6BYXeZbSIbOl/HEcL6BR2ZJYfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCH5x526S7o3Y0dX5ufs9yiOxQl3XELURFEJvAmAH+s=;
 b=j9PQaOdnqW+W3Wb/ky65Hn4AdpHKCHhk7O1PmWpbT/QrgCqt5c+6NdC2NNfvqKw4P7640B+kzx8IbmDEsN7HjVfv6QekKpXjxGViSnORuMLIMGXuCdpTVGpedkOP7Nqp/K1myq/mGnfdchJXYkeU0K6axQSSvtN0XlEo9RFNSR4B1+1qr1M38HKaXPqYB8bwtNv3RhSJlRIiDPqioi5/KuXH+dXphg9OfS4T1TPRRVqJ6exErDBeiWqyGdNlqpPMKbQdR66H8OND71Pw48AEGY2+g48bQxiq+67AbcxEKH4nZb7tT/f0OdEF1Y9wy9gfwJ35XzY8LX8RdEC3nHw6/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCH5x526S7o3Y0dX5ufs9yiOxQl3XELURFEJvAmAH+s=;
 b=ENPn2EQImdLbYi7M/mkPq8ed8bFd2Cfi3TP2ClkQwfCICLzztzfcYcX3I41n6a1lDk62bJeuWfC16VMIrN8fgBB8zBYJQyb6v5V4WwEsu7vmvfNZ2R1IyyruKdKEJao8BG1p28qVHGA6XjlRAiIFZn8HetNM12fjJmYlD2eqwc0=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by MN2PR10MB4368.namprd10.prod.outlook.com (2603:10b6:208:1d6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 18:02:13 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%6]) with mapi id 15.20.7519.030; Fri, 26 Apr 2024
 18:02:13 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: Re: [PATCH bpf-next] bpf: avoid casts from pointers to enums in
 bpf_tracing.h
In-Reply-To: <CAEf4BzY14jZkUUgkZb3A88KguX6=7pJLhNZ3T1H-Hde7raLb6A@mail.gmail.com>
	(Andrii Nakryiko's message of "Fri, 26 Apr 2024 09:15:24 -0700")
References: <20240426092214.16426-1-jose.marchesi@oracle.com>
	<CAEf4BzY14jZkUUgkZb3A88KguX6=7pJLhNZ3T1H-Hde7raLb6A@mail.gmail.com>
Date: Fri, 26 Apr 2024 20:02:08 +0200
Message-ID: <87h6fo0zq7.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P190CA0064.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::16) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|MN2PR10MB4368:EE_
X-MS-Office365-Filtering-Correlation-Id: cb98aaf0-f786-469a-ae6e-08dc661b0007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SDhmWm5LeEZtWW1naytIYkVsdk9TYVNqcVFnVkp1NHdWQU8xYzBjckdIdTdR?=
 =?utf-8?B?cGRYaThMRXdlVjdNRTFrYWRjeWVYTW5VSnpack9WdFJQZ0VhVDNlWlhVclh0?=
 =?utf-8?B?SlVaeTlzVitZMlVScVFZeENwZ1RmYmhDK0daYTdZRCtJTWdGTzZ6cmFFZVZh?=
 =?utf-8?B?YWluT1BmNmYyUTVKL0lPZTgzKzdZdnZxVThwUlZlRjAyUzlZR1RibHdKSjIz?=
 =?utf-8?B?bGZZZEFYUHJxaEgveEluOHFSb2cyRHdLakpQbXRmZ0JyTUF0ZHJCVUxWNS9u?=
 =?utf-8?B?UmZLTkVxN1VoUHErbWg4R0wrb0VZc0dxeldVcUFpTTUvaGZYNVM5Y003akFO?=
 =?utf-8?B?bDF4R2ljUmZEVU05azN5azBWc05oZE0ydlhFbFRMblFhbWowSTB6a2RRR01J?=
 =?utf-8?B?U0N2cVA0N2FmcXlqSGM0UGZOSEhiK2RvK0JOMzd4MnBWY2pQd0h5eExVR2Uz?=
 =?utf-8?B?WXpJeWxlMmpVSldGWURGOFBpSkNzODJIdnhQRlcrRVF5S0VWYlRPazQ1VFpx?=
 =?utf-8?B?bWtkdTBSWHpoZWlubG5mUW53dGJwTVZGZXppQ2FLcU4zcEhrak9RRXNSRTh3?=
 =?utf-8?B?ajR1V1ZOeGxnSVU5ZzdGazVsbmx5MjlHb0N4ZWZHRW8vdzdaOTFFV21nTmRQ?=
 =?utf-8?B?cFlyaTNiQzM0QjF5TDBNWE50SHJtc0lSQjR5MDZ6WkNPb1VKRXBwM2pJMlo0?=
 =?utf-8?B?enBIWFpjOExHVmc4U1dZT3VLYXJwZmh4dFZGN01ldGthN29uNTBiZ00zNkxI?=
 =?utf-8?B?OHBzS05ON2hQQXI4Vlc3TW5MbHBGT1dIR2dna3pFVWF6ZUxOcktqT1VMYXh3?=
 =?utf-8?B?Y1lUZG0zaFlkR2w0RVpkcUFLR3U3bkNmeGxoQ3M1cEFVOE5tRncwcGRKOVk3?=
 =?utf-8?B?MlBMT0krVzV5TkxzdkF3U2tYNW5uZzZCbUQ0WW5WbmRmQ0poYkRqT05rTW1h?=
 =?utf-8?B?REJKTS9Wa2ZlUFBtbFkvc2gwdjN0ak12dkVhNjhLRjQvRmJ5YVhIdWl0eThB?=
 =?utf-8?B?WFVIb1JIaFk5eUpwL3VLRk1iWFM1aWVpelNtSnRUT1d0Nkt1N3Q2L2twN3lS?=
 =?utf-8?B?dFZiUzAvMGVBWDhQYk5DRFVLWGN0YUM5bmFPU3ErQWpBV2t2ZmFrODV3bjhy?=
 =?utf-8?B?TU4zOFJRZ0duQUVYa2dpUEpyenZzL3U2OHlWbkRBcjE5MEpSS3FhdzhQU0hO?=
 =?utf-8?B?SC9WbUZFMnRRSXdGM3ArVkc1cFNGeXZkc2VwSnBBUjN1VzRvRG5iemdUMkdY?=
 =?utf-8?B?aW1VdUROTzBYWUgvOHB3M3hmbTY3ZlVGMExkTjJSbS81OGtaQWpaUUZ6dGlj?=
 =?utf-8?B?TzJBTmcwaExuYXFZMUJ6RzJuU0ZRVWdUMitkWmhCMXdEeEdXeDBDYWIwQkRG?=
 =?utf-8?B?L1Y0enZuUW1UNDhxUy9RRVVKbkZYOTBpODVSTFo2aWo0UWJDcnR1WnZ2NVll?=
 =?utf-8?B?R0U0NU9KdjV6TUVwSDRUekZLTVlRd1dhcTIzQ3k4WWljc1hrQjF6K0lWeTcv?=
 =?utf-8?B?T0k2WWEwaHRPT1YydzY1bjJ2TzJTbmltMEdNZm95bnFGMFo4WDV2a05FMkxC?=
 =?utf-8?B?Nis0bHB1eDBNblFScVpiQ3kzYUIyekhDekdnNUFNYWp3dzRMRWMxSTFhL2dZ?=
 =?utf-8?B?OVNuZld6S3NZR3VJY0swcmdBZE91WTdjT3ptOFB5d0xablYwTDh4QU9PY0JH?=
 =?utf-8?B?Yko1Nisxd0R0N25FVjg4NFJNTGNjRnZVV2JhOU1vUGxKcWdGei9YeEFnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NlhueGs2NWR4dUt3THFYZGpiclFDVkhDWEdQd3B3UXRLL0ovR3lGUDR4TDZz?=
 =?utf-8?B?d3F0NDFXN0hKYzc2SDZDd0N2K1JmdDFxc09kMmlmaXRUZ0s0bk43cmpyUExO?=
 =?utf-8?B?aTM4Q1hzZGRWbGlNbndhaUczbms3ZFUwYUxQQlBwdy85NnM1ekNjeEhEWHp2?=
 =?utf-8?B?THRmQlpnOFNjMFkvcGF6ckROeEpVWFVkWWFKdFpUcC9xd2MvcVBlSjFQbXBo?=
 =?utf-8?B?Z1R0QnBJaWlJSzQ0dU5uSlpNUjNQS1BiNUxLQml6Nm1XNjNwNlBqaHJDM0hu?=
 =?utf-8?B?blZwODhGTG9sdWRJU0JwNkNxNys1ZzZOaXZEc1BXYXBlTXFxcERDUXdvMUQ2?=
 =?utf-8?B?a0FlQnZRVmpqczZZME5OM1VXdEZmejJWbnlKOTdXS3l3bElPVUlPZGtKcEtj?=
 =?utf-8?B?ZW5SUEFxNExwL2RKWHJ3NkZYWTZtZzdtRG5CbmRwSDFtNXpBZjkrZlRRN2lY?=
 =?utf-8?B?S01lbm9zVDkySTJUcEl0a1VhOEFqaGdhWmNROGtzd0poOG5NUVhLeExnR2t2?=
 =?utf-8?B?V0RLeWI0QytEclNCd0FGV05Ncmc2VHRaSWIrOHRPYXBzVTkvbzB4VHo3dHRa?=
 =?utf-8?B?Zm43Q0lVOTBqdVVCOHU3Z2xjOWo5aTV6TmwzTE9BZzlLZ3lKcDBkVzlVWkFq?=
 =?utf-8?B?N0ZZNm9nZklqeEEwNmp1N2t4d2JzcHA2T2xudHJwWkRLWUJIR1U5dGtuSTlu?=
 =?utf-8?B?TmQ2U0VXNlc0SUJuN0dPblBjSGJvVUNmQ21OczlxZTdIN2xQZEVLOWxvSkNm?=
 =?utf-8?B?ZEZMcSsyS3YwRnNKSUtMbjdFN1VLOWtEYkovaG80N2pES2RaYkRWRTlXUmVh?=
 =?utf-8?B?bHNvK3loT0I0ODVza0YyRi9zSXg4YXArVCtoLzAxNE4xNDVXczZ0V0FkNVd3?=
 =?utf-8?B?Rm50ZUVRNmtWRHdRL0xua0dyRlM0dk5zc0lFNFN3ZnJWMFk2YlhMSTVRUVlB?=
 =?utf-8?B?VkhpaDdudEhWN1YxSlVOMGYrS0dLZ082YVRSNUE1bmYzZlh2TDF2SnBuajgr?=
 =?utf-8?B?YTI4a3k5aVd4UVJCZTdIbjg3TkUxdWgyMVlaT3RGYTJxZlRQTk9zK0VvN3pR?=
 =?utf-8?B?QjFHSTJ0bTRyaWd5d2tBRzBHajluYiswV2ZYUVVuZ3NCemg5djRZeXpqTWdF?=
 =?utf-8?B?QkI3R0FIcVhRd0NNeEtldEQzejVCdUlPSlpXQVpkcEtoclBxR3ExSThmemFH?=
 =?utf-8?B?Q1NpOGhvZFpOYkxaZGVtdVRTOStmL1FFVnhOQVBaL1pOMWFuTGJDc0VJVWZV?=
 =?utf-8?B?OVczblVvbHM3ZHRlUCtyTHY1MjFNTDhySU9mTFpQd3liQUh4dnlqeEhPVlNS?=
 =?utf-8?B?dE4xYU95WGZhYVRoaXNZTmQzNzQzbjBScGdBMFo3L21sdGZSMHZLamZMSnN5?=
 =?utf-8?B?aWVncTh0QWp3dWJHOTlYd2VzNmRydlpZVzZLZTVDQXQyRW5UT25ZV0hjV3FZ?=
 =?utf-8?B?VEhIK0JSaHlONGkvOU9BV3BIZ2lqR0JKN01IczZzZ21PVmZzMEhNYTBoaHpI?=
 =?utf-8?B?QWxRZlVTbnZSUFU4NzZCWHN0ZGNocXVCWkhYZXN3cDlEU1o4K01KK2NJMnBv?=
 =?utf-8?B?djh6QzgwUEM0SFd2Q3VVeHRHVmRGRWJHbVZ0dkNpMnNvRlYwN0NURWFZa0Nx?=
 =?utf-8?B?VlRvU1hMTkhWQ3UvRTh3c1RDRzBKcHZQbExFV0d4eWMrcmF0Qzd5SlBGbERU?=
 =?utf-8?B?SUVOM3FwOWQvaVV2WWY4Wjh4Rk1zcENUN1lOZVZ1MFdpb0gyRzdNdXlTUkkw?=
 =?utf-8?B?bWMyWVVGNnVPUm9VRXFMdGpLaTVESWZWcWVIOW4zbEFnZEgrdXBrWkc2TU1O?=
 =?utf-8?B?MENYS2V4UUQ5ZFBoU0hxcVExUVRIZlA3MWk3UU9tVXhrclUvUncvbk5VZWQy?=
 =?utf-8?B?UTdZUjl4KzVOajBTd1RSbXBRM2w0REpibTJOcWIzcml5dTFOY0VqbE1LUzB3?=
 =?utf-8?B?Q1JrZkIvMjFKR2ZOZFJ2MForZmVPQVlCd0dkL2JOclBNWTBuV2Z5eUMrbVhY?=
 =?utf-8?B?MjBJdnpCUUlBM3FQaHNwWk1uRHE1YWo1b3ROWWpjQzJMa3UvOGh3NFhVV24x?=
 =?utf-8?B?TkVoMUhqUDBSYVo2ckp4WllrUVlRay9MdEI0dVVvMXZkSkhkOHZaQm1EdThV?=
 =?utf-8?B?UWN4SkNBaFpsWDY0ZVM5UnBmUklRSWtDSjJXYnNWbGU2MUIyaXdkUkd2ZHl1?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vEKETbLMsJ9HWan+kKHtowUv2aTZbzooR3UZMA3lXiBkg8paFLPiRdNAwH+NNI7+YPbTvBkCZ5CrNFtIArd1UGucbAQK/EBLjYWHubRmSB9xXRS5W8w5MKsPhv8+sy6MCvrRL42BPUh/0YScMS8xBbBf5uI0QC0QzLqPkz1EKLBJt0wAN39WYHOjCQOvMfSGJjCrjnPc48kOKc90Rle5zIgi6WcKKpfYQ1WwmvX3xpF+xyiguzzo1UdYlRmu6G3IOof9uxGui67K4/2680AmflMejnEqON8DQqp+AMudYKg6JoWAgceWq5sdi3RMwrs6HZpLbBYcRtfgAcBZ0hEpgn3uyeR3dBxF9u1XwdilWkJdrCB0GplJlm8FQUWcRJ8XUMlNaVMJH0r1igeZARn20oq6iqliHP7tughQ45Ea6zuePfG2yL3SuJlOr8dMaijB1z2lj86GaWersiWiciJ0Stcda7LTSjWKUHrz8LcsbVdKOIpPz+/hzMTGY9eIkR5sUF6RBL0WLsoeumpkbqJpojdnqjM13Oqzhz5HSl8FoJS6mpUd7eA4fTe1aku1/Zs6MxDLxePrzUb9M9MXN9/wIZvcUA87MrLG1H7j4fTkv6Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb98aaf0-f786-469a-ae6e-08dc661b0007
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 18:02:13.2011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqB1TRB+FJnEoFzOu1ua2DnmIaZdb3JPrWJArwBB4TaWti0lu1SF7W99pscMHnLIkn9sTx/e3Oyo5+3wqwV+N7lK6ym9ulrkFBIJ3CMAf9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4368
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_15,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404260122
X-Proofpoint-GUID: KoI2Cx83rZFVAgYi2X9eBy-UrDSNbRGp
X-Proofpoint-ORIG-GUID: KoI2Cx83rZFVAgYi2X9eBy-UrDSNbRGp


> On Fri, Apr 26, 2024 at 2:22=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>> The BPF_PROG, BPF_KPROBE and BPF_KSYSCALL macros defined in
>> tools/lib/bpf/bpf_tracing.h use a clever hack in order to provide a
>> convenient way to define entry points for BPF programs as if they were
>> normal C functions that get typed actual arguments, instead of as
>> elements in a single "context" array argument.
>>
>> For example, PPF_PROGS allows writing:
>>
>>   SEC("struct_ops/cwnd_event")
>>   void BPF_PROG(cwnd_event, struct sock *sk, enum tcp_ca_event event)
>>   {
>>         bbr_cwnd_event(sk, event);
>>         dctcp_cwnd_event(sk, event);
>>         cubictcp_cwnd_event(sk, event);
>>   }
>>
>> That expands into a pair of functions:
>>
>>   void ____cwnd_event (unsigned long long *ctx, struct sock *sk, enum tc=
p_ca_event event)
>>   {
>>         bbr_cwnd_event(sk, event);
>>         dctcp_cwnd_event(sk, event);
>>         cubictcp_cwnd_event(sk, event);
>>   }
>>
>>   void cwnd_event (unsigned long long *ctx)
>>   {
>>         _Pragma("GCC diagnostic push")
>>         _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")
>>         return ____cwnd_event(ctx, (void*)ctx[0], (void*)ctx[1]);
>>         _Pragma("GCC diagnostic pop")
>>   }
>>
>> Note how the 64-bit unsigned integers in the incoming CTX get casted
>> to a void pointer, and then implicitly converted to whatever type of
>> the actual argument in the wrapped function.  In this case:
>>
>>   Arg1: unsigned long long -> void * -> struct sock *
>>   Arg2: unsigned long long -> void * -> enum tcp_ca_event
>>
>> The behavior of GCC and clang when facing such conversions differ:
>>
>>   pointer -> pointer
>>
>>     Allowed by the C standard.
>>     GCC: no warning nor error.
>>     clang: no warning nor error.
>>
>>   pointer -> integer type
>>
>>     [C standard says the result of this conversion is implementation
>>      defined, and it may lead to unaligned pointer etc.]
>>
>>     GCC: error: integer from pointer without a cast [-Wint-conversion]
>>     clang: error: incompatible pointer to integer conversion [-Wint-conv=
ersion]
>>
>>   pointer -> enumerated type
>>
>>     GCC: error: incompatible types in assigment (*)
>>     clang: error: incompatible pointer to integer conversion [-Wint-conv=
ersion]
>>
>> These macros work because converting pointers to pointers is allowed,
>> and converting pointers to integers also works provided a suitable
>> integer type even if it is implementation defined, much like casting a
>> pointer to uintptr_t is guaranteed to work by the C standard.  The
>> conversion errors emitted by both compilers by default are silenced by
>> the pragmas.
>>
>> However, the GCC error marked with (*) above when assigning a pointer
>> to an enumerated value is not associated with the -Wint-conversion
>> warning, and it is not possible to turn it off.
>>
>> This is preventing building the BPF kernel selftests with GCC.
>>
>> This patch fixes this by avoiding intermediate casts to void*,
>> replaced with casts to `uintptr', which is an integer type capable of
>> safely store a BPF pointer, much like the standard uintptr_t.
>>
>> Tested in bpf-next master.
>> No regressions.
>>
>> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>> Cc: david.faust@oracle.com
>> Cc: cupertino.miranda@oracle.com
>> ---
>>  tools/lib/bpf/bpf_tracing.h | 80 ++++++++++++++++++++-----------------
>>  1 file changed, 43 insertions(+), 37 deletions(-)
>>
>> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
>> index 1c13f8e88833..1098505a89c7 100644
>> --- a/tools/lib/bpf/bpf_tracing.h
>> +++ b/tools/lib/bpf/bpf_tracing.h
>> @@ -4,6 +4,12 @@
>>
>>  #include "bpf_helpers.h"
>>
>> +/* The following integer unsigned type must be able to hold a pointer.
>> +   It is used in the macros below in order to avoid eventual casts
>> +   from pointers to enum values, since these are rejected by GCC.  */
>> +
>> +typedef unsigned long long uintptr;
>> +
>
> hold on, we didn't talk about adding new typedefs. This bpf_tracing.h
> header is included into tons of user code, so we should avoid adding
> extra global definitions and typedes. Please just use (unsigned long
> long) explicitly everywhere.

Ok.

> Also please check CI failures ([0]).
>
>   [0] https://github.com/kernel-patches/bpf/actions/runs/8846180836/job/2=
4291582343

How weird.  This means something is going on in my local testing
environment.

> pw-bot: cr
>
>>  /* Scan the ARCH passed in from ARCH env variable (see Makefile) */
>>  #if defined(__TARGET_ARCH_x86)
>>         #define bpf_target_x86
>> @@ -523,9 +529,9 @@ struct pt_regs;
>>  #else
>>
>>  #define BPF_KPROBE_READ_RET_IP(ip, ctx)                                =
            \
>> -       ({ bpf_probe_read_kernel(&(ip), sizeof(ip), (void *)PT_REGS_RET(=
ctx)); })
>> +       ({ bpf_probe_read_kernel(&(ip), sizeof(ip), (uintptr)PT_REGS_RET=
(ctx)); })
>>  #define BPF_KRETPROBE_READ_RET_IP(ip, ctx)                             =
    \
>> -       ({ bpf_probe_read_kernel(&(ip), sizeof(ip), (void *)(PT_REGS_FP(=
ctx) + sizeof(ip))); })
>> +       ({ bpf_probe_read_kernel(&(ip), sizeof(ip), (uintptr)(PT_REGS_FP=
(ctx) + sizeof(ip))); })
>
> these are passing pointers, please don't just do a blind find&replace
>
>>
>>  #endif
>>
>
> [...]

