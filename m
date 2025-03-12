Return-Path: <bpf+bounces-53909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA937A5E212
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 17:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B691895465
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 16:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1D124397A;
	Wed, 12 Mar 2025 16:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eSjXsFQB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TbosnsIX"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCB31D5CD4;
	Wed, 12 Mar 2025 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798440; cv=fail; b=SvlaDnQlBg2nC8v0P9AfhV6Wsww+RdzjnRoCwNBGgeMKwk4j9FX4/fsSYGlCRc23thtHLob/fplksdTMSqVnBzbo3FuaZXSna+mIo3Z/py3DiuFQzw/ZW7yJPAD0P91d7/eV1fYhkty7LjgHvhVrT0UESs4IZX3gLwWSRz/N+Z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798440; c=relaxed/simple;
	bh=b1p194VQcDU0px1QvJf1vHbKxTmbyaXAV8WGQ1l7/+k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o5DJmOHzSLaHxDFAmbJG/lLyGb4xxyfR3x4UjSaoF6LgyfYpRteUU+zfv1ioDA4w9S9rjBQuD8vBOweDjtjQohE1Dx7dwX0f020ZcGAScPfjCuH3JA7soudcgqGcyJulTeGodN41njA/Mn9/EpDgiXXNdHnWa3wQ3gX04cbwqrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eSjXsFQB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TbosnsIX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CBsZUs022177;
	Wed, 12 Mar 2025 16:53:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=WsARRAWFknoMdXbBRJUcIEnu2uzwbvGDvOH6dOYFCsg=; b=
	eSjXsFQBlOQtznsmySrTLBMOyDLoqKqJX0js/zlZYO/6+/sVzcqVVlSKdiVicJpV
	DKu1FJlWsxCZiBbAsYRCO1DIjJhZzZTfvtajmsqYkVDJrxqkdh32WoO4jdZarlJH
	8xV0WCxr+wjvkLo3BbxYxOBcOHbCF1O/ioEa9UPTNCGRbfyvghGD+g4nuLJ0bBEJ
	aGXHIzEcP+Y3zMEE394t/os6PTxGHHWUlIucWNNPQLivO3CmqI2ppyAgalcXKCte
	GV0opQoewRBliV2mE2w9k4Zi32xsGqAcDkv4V4N04lcBDBeQVbw4Gesq9wPvaJ0U
	hVXKzn+0xbc46SyNqEWB2A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4h28uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 16:53:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52CGNvwk008501;
	Wed, 12 Mar 2025 16:53:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn3hvgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 16:53:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yU3xlvbxUlYArnj6DIuXFdSW6vGZLXOjB+7czGVFixFcN4P2A2mD1QGt6gcF+dKUmrgM/mETihVn4DssCuXtyxGgC9dLH6plyX19YN2LgRBN7ytYsm65ReFNnFlVnGXMzNexsGuIuxkGjTc/IDs5ik1siA/8p8/ChrU3HFFitBghSb/3Z8UCFSY7G6dSdB8uQC0x+SbwTrOJGziycieOrr841foVlBewQN1+9FVZ7Idefyk0ZKFfVcZC315o0x4HwqqamDP34KbXHgVXgFKxr38aVq060FSE5F96efAM0r5OohtKqIzi/+at85bnCNIugxkQSekCNs+3xj6l4eO1Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsARRAWFknoMdXbBRJUcIEnu2uzwbvGDvOH6dOYFCsg=;
 b=Fyh4LfmzKLzBK7UGAJ60YXSJ3csSYBlZHJLIjQqXFLJ/ETYR9LsmqPLgnNfBpRh/gcQs42wAZ+vXb8jRO9AJyas9/9O345CNixdh1OkNNALmL05cO928WuxefdNutqZr/9W2xtZO+QMNF5879XOkqNerRpSm41KzZEU9ifSR9I7XlTfqdrS5Wx9Y0Hg74B6+7U9Mf3+l+XLDUsPsfaFynYJkZRJ42AhFVNK2p1gdyLmiVstTsJaqqKG12TQovbIHoGBOUjtYJH9pKvnKnpI2KF5uLh0QnbRJcpF+6EQBOQZK38ZiTwlu/Cyf8wt3KG1JNXo8WkZEbe58GT8XTeSR7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsARRAWFknoMdXbBRJUcIEnu2uzwbvGDvOH6dOYFCsg=;
 b=TbosnsIXIoDtkRJCI3B0yUz5xDKhxEIR/JDYQXwYQweYipoHHbSqR66W1LUr5QAQJv4hs7jRaGBqIZoi/EJ3By40m5Be9RgI9leiJP7kNgsCOeOZxW2EzLE5WuVJXV62TDMr+79WE5UsjXJcEWxhdzio6fltbg466VVsGHkyM7s=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB5724.namprd10.prod.outlook.com (2603:10b6:510:125::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 16:53:29 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 16:53:29 +0000
Message-ID: <b5d5b91c-31a8-4f44-acdc-268081dc2647@oracle.com>
Date: Wed, 12 Mar 2025 16:53:22 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves] btf_encoder: verify 0 address DWARF variables are
 really in ELF section
To: acme@kernel.org
Cc: yonghong.song@linux.dev, dwarves@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        song@kernel.org, eddyz87@gmail.com, olsajiri@gmail.com,
        stephen.s.brennan@oracle.com, laura.nao@collabora.com,
        ubizjak@gmail.com, Cong Wang <xiyou.wangcong@gmail.com>
References: <20241217103629.2383809-1-alan.maguire@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20241217103629.2383809-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd36dfc-12aa-4bb7-7bb5-08dd61866a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3IzZzlkNjJnTVNONUFVVmFscUQwdzlXa3BEc0hBcHpMRDZLQXBXSVhEWVA0?=
 =?utf-8?B?VTZEU1BlUTQ4cXczVGg4R2hBVVU5WVlnUUdyS2dqN0hFTmo3VWtqRjEwaWVM?=
 =?utf-8?B?Z3BPVGV1aWdUT3hITDJuNmppUVRCUEZBY3VSK2tSTzk5OWwrNFhkWGxGZ09z?=
 =?utf-8?B?VHY2TnRWekV5djgrdnk3b243dXRzVnNMYmxZNW5OZ2lOQytnbENibXd3RHVM?=
 =?utf-8?B?RXJCVTlGS3FMb2RMaXo1T1MwOFRRQXlyVnVrL012TFk0aUNiOFkzOFM0cGhk?=
 =?utf-8?B?by9wM1gyVjkvTm5yNVpZdUpFUnE2ek01c05rbnhGWlViU2tEV0V5NTh3M2Fv?=
 =?utf-8?B?cUlGZWJrQWpIVXNWeFkreDB4K2dZNEViQ3R1T1lFMmlHUFlyYnp0cUppRU00?=
 =?utf-8?B?T245ZyttczRnNGhuTkNjRUM1a3pEcXdpL3JMak1yeW5uOUFJbllGTzZienhW?=
 =?utf-8?B?NldTZGVlL2pDdkYreVZ0YnZKRTBZVm1ISkhLbjFFZ05vOHdiOERtUGZUa2Rr?=
 =?utf-8?B?TnNxN25FY3JlTitrMVNhYStFWmYrMEtqd1p3RTUwQlhpbkNtS1M0N0d5Vk9V?=
 =?utf-8?B?ZGJRam9VWkxFVjRLbzNPeEZ5azU4UFAxald6RWN5N0Vqcld6cmFWcmtHTVMx?=
 =?utf-8?B?YlBneSs1MDFzL3NaN1loWGZ3R1VlYmp6WktGemlWdnh2dUJOWCtRa09SYjA2?=
 =?utf-8?B?aDVqWDljc0FOWTJLVDZIRytQa0xueXRaNFV6SFFwMHo0c3JtenRPcktDcVlV?=
 =?utf-8?B?RXhjeUIwalJPVndhSW1ieC9wVTNiZnhPcW1taUFNSEN1VVhwbEp6bEhHUjVp?=
 =?utf-8?B?UUZhOEpkdmJ4QXQ3aGl3cnN4cHkwYzJUUFpJV3JBQXM0VUtDL3Zxamh1QTZz?=
 =?utf-8?B?VDNETDRBZjRVazY1bGNqZnFsL05DcG41SnpvblVoc3BWYnI2VG42eTNtd3lF?=
 =?utf-8?B?M2dCVWpTcUVrTEJLeDV6bm5IWWlzdGJVSWpsdmJ0eWhGU3YxSm5GYzU3SmhR?=
 =?utf-8?B?V0tRUUR5b2N6N3IxMUpXOUFOamZadmtFZ24zZVloenRRQXd1NXRFK2VkTnVW?=
 =?utf-8?B?cTVMaW1MUlFjbUJhajAweFY2S29WbmFoWjUwZEh4bWd4Sk5NZElEZzlOaVpu?=
 =?utf-8?B?Z0ZDUSs5eWgvVDZQTWRuMHNKell2aUpPSHNJVmJVM2tDaWozblk0OUtIR2pD?=
 =?utf-8?B?d2xCYjA5VzlBNGtJeWlXTjVScFFVbGgyUmpZZFVCS2VPTzBNdlFKUzAwQW90?=
 =?utf-8?B?K0UwZWloY0hONUxRK2dld0p6aThEbVNqQnBJMlpxNWMybmpEQk84SFc4WWZZ?=
 =?utf-8?B?WGRXVU13c0czMVNYdmZqeXlBa0xGS21LR3BPTk5PVnlvbXNObmhXTnVJVXBL?=
 =?utf-8?B?bVRMT2FVS0tFMTNjbVZBMURaZ0JJSzRvWDZYT1pFWkZNWGg1K3h4OG1UQmN2?=
 =?utf-8?B?bGZ1ZkJJeGhVRDJwc2xtQS9Wa0hJT3JiVjQ2dFZuZFd4S2ZTMlZYNm4wUy9m?=
 =?utf-8?B?NThjRDdXZ0MrdSsrZWVOSGlJREJRaHNSTW5mcWhZaGt5WmNFTGZsRkhib3V3?=
 =?utf-8?B?VGFIdU1EWG9tVWlqdEZOWlRXNms3TzZJMHU0clJSd3N6U2lOSVVmNEl5Njgx?=
 =?utf-8?B?QzdSZHpQQWljVHRlSjFUNERwdS8rMjR0ZXlKTFBtYVRsTFd3RUVHbnlzZkEy?=
 =?utf-8?B?cTkrWUthREpCa2h6UitFRGN4cU9ybXdsNVc4Vkp5L0hiU3ZGRy95blcrSmZp?=
 =?utf-8?B?M0swQ2RCMFVOVHhsd0JCTGYxWXFneDU4VnliMWdkN1Q1a0N3RXozcTJ6MWFr?=
 =?utf-8?B?d2o0ZTJVdnBPZUQ1RzNLc1d5TFphSy9DYXdmdHRzUkFHNkl0OGZSbVBubVdJ?=
 =?utf-8?Q?AvIOu3Fv2q0TM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ull3bnU1UkdvOElMeU9CUU5ZakM0VzlKOWRvekF0eTBKTTRYNVlaeUpUOWxR?=
 =?utf-8?B?MEl4eEc2NU1VK2VUdTZaYmZpZDhDUmxScFFuTE9iWkVFaVJwa3IwMTFtR2dz?=
 =?utf-8?B?ZGFVaTUyaHhFcm1PRy80b0RJZXlLTENaNUVuOXFweXVMS1Zvc1dwMmV3bHpt?=
 =?utf-8?B?a0Nzalg0UE1mYmg3Vm05WjZTby9YRTBVMXNxS3J2cE1OZ2hwQlFkaTIxdEk4?=
 =?utf-8?B?SGlSTDFtWEltUDc3S2MwSUNNOEZIT3RyM0svVjJUeGNSQTZQMW1BUHdDTFht?=
 =?utf-8?B?c1ZJcXBJbFl6SXcvS1BVU1R2TkFuYVRZbk42dFhLZ3FZTzNwT2JlYUhRTHZt?=
 =?utf-8?B?eCtwQnN0dU1Hd3N6d0IxTmhJSDJoNDdCeHpXcG1sNXpiL1dNUFlUdGJoVndu?=
 =?utf-8?B?b2JEVnBEZXR4ZlQ5OHdPaWFvaDlieHMxUXdWdmVvdlJzVEphcWJoZjNKbm5p?=
 =?utf-8?B?VmpHK2h2c2c4OEZsT1ZHNXVveU9EdjcyaURsSktjZ2xRMGlKcWh6RStxZW1J?=
 =?utf-8?B?L2IzZDZWSVIyQlVLZWpKV1BoSDVMT0g1M2M3bTQzOExqa3RLRnM4R2MwNHI1?=
 =?utf-8?B?WXVHS0drMlJtcjVVZGcvL3l4Y25aVG1YY1kxY3V3Z000YytwWnFOdnkzc2dK?=
 =?utf-8?B?M1RSYjY2TXpKRDV2YTZwTStwOVhuTlNPQlVFaDg5MHJ0WmdUdjRNTVpwZ2Nr?=
 =?utf-8?B?TVFjVTlMWEhIS2Y5MTdrWlgvcE1DVHM3WmErNFMyTlhiQXIwSkZCSkhRM01F?=
 =?utf-8?B?U1ZQcC9WWWpLMmthTXJuM2RBVzhEMFNzOE9lQlRFWG9nam4xY3AvWVRETGJR?=
 =?utf-8?B?aEF2N1FYMnpCY2RlL0lnSmVLNkZrUjh2REErcUF4RjRxdTFnKzY3RUJMMTdT?=
 =?utf-8?B?dmNHUm1OS096YTE5VzhYQ2tmdjRtM2RQcGJ3M2gxVnBaUDdaWmJnOWRZUmw5?=
 =?utf-8?B?ZzFYdGRJVFJGUG83c0ZZcFZkTWxNLzk3a2VRVG1RVVdWUjk1R1FuRkxVQ0ZY?=
 =?utf-8?B?ckpOUkF1YlpMYmd1b3JoQ05VY3VJYXRudkNQVjlkWDNYc2hkanM3RnQ3UUtQ?=
 =?utf-8?B?M1B1cDJWdzYwWEREN1ZsTnhQekhCUC9WS2RrRVcyeUZ1YUFYdTJHTjNQdEFQ?=
 =?utf-8?B?b3ZKN3lKOTlFUlM0V0NPZlpCOW8rMkhSbDQwY1BwdzlXMkErWE5QbjJ5R1h1?=
 =?utf-8?B?THlrclNTam5JbGRQb0RMSTI3cGk1YitZL0RBU3BNVW9ZbjFGaHg2RjlvZXZU?=
 =?utf-8?B?QndxME8wZzc1ZCtRTXlLeXpZUHlzSjdrNGcvQk1wUWdUeG9BRm4yVlhYZzdw?=
 =?utf-8?B?WUNJbDJYc1J5TFFzY0NGUnFYaUJ4ei8rdGpSOE9peDVGQk02TmNGaGoveDE1?=
 =?utf-8?B?ZGRla0lDY2hKMC8rcm5EZkowUGpleXBMRDlpV1E0dFdVeHl1dC9EZzRXd284?=
 =?utf-8?B?dmt1dVVSTmhZcklwd1FPQkdiblR0cUVWL1N4aVFiYzdhdzdnMnNOMEVlVmJh?=
 =?utf-8?B?c3ovRkJzZVhXWS9sdGNxelYyMEFhcnhOUGZydjlyMk1tb1Era3FJRHBzWFIw?=
 =?utf-8?B?ZmFiSEZSTnVYUy9MdjdpVXNpeE91bVlHK1ZlK0crUkpoQzE2dDloa0V1bktL?=
 =?utf-8?B?QTRXQyt5bHhWcTk1djI4VWFqRGxqWUplYTVnRmY4V2NiT01FNTJtd0dlZkRJ?=
 =?utf-8?B?cEwrd1o5TjBGODdsMXI0anIzM1NLbFdFa3kyOGE5UEhYTnNubjFuV1YzVHNQ?=
 =?utf-8?B?cmtJZmQ4YXVtc3h4dUtKWnQ0ZGtKbTRTNXloeUIvbmVoTXhQbks3M1BWOWsz?=
 =?utf-8?B?UVgvQmNvc3FudmNJdURCTDlQNVczT1MvYnhXSHk2SE5SUVlaNWQ2d1dBalJL?=
 =?utf-8?B?ZkJSVFNqdGFiU3BSdkpZSW1FVkMwdVVCY3NNK1BIdWY5TE9UMnpOMkRUc1Av?=
 =?utf-8?B?RjB0d2hWSlBORTZ2Znl0MU1oNnU5ZlRvc2orUGRBNERHZFJRNDdscjhWbDls?=
 =?utf-8?B?RVdRWW1nTjI5WUVEYjRESnFBMWlCNWkzMStzZ3d6YlErU2ovSFJDTnl2L0t0?=
 =?utf-8?B?YWxOTXczaGtlbFIxRi8zMGJjV2h6bmxsWDlOQXdybUl3SXdRRlZVSUJ3T0dl?=
 =?utf-8?B?U2t5b05EV3NwU01hdGdFTDVKK2Q4TEtieDZiZGJsOG5kU3NBdFRTRXFNeW1I?=
 =?utf-8?B?eGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xaNlkBKAfLfJZZ9oRZaERXWkMThS7ySFA8fAg/j4qNw68RZ3mB/TNCjlbWGl8qQGmCZyOj4ZPIUHmE/6z69bIx6tMND4v5WfeZ4iBHIOG0fdPvo+YM9XP6mrpUpT67iHTpYjkiewlRKnDdsvdiX/BP2wdUwWTTYVdQ5+b9itfVT+UZRQPbT6yos8KwI6p2XXuREjVu6P7wtnqZApoXT9JpiRbCNpCttYPIVxBl5e45ORcmOn746XKjSEaBULkxGoYLPBG4kvO4395FF+BJhpOWbAssxpwUGCkmHzM04GUAG/3W6XmSTbk5P/Efg7+tI6orxlBPcS4aaHMZQ/WkXlawKtXvc3ufko04xcpt7v6HLWF4FShZypN47Px6IKJbiZXRjKX5JV54OOfJtz7l0vF4sRjiVWlOBWm0nz2iPMupbO37ZsMCN17pwrM6w1L5GCiJPdxpXg5trM5L/9lBjER08EGnMwqs19u2oga6C+X8hTi6HaZFzoosFzOmmV1VeMPy9FWnvJA78koAwPcf3WpdH0YZsFVoNEEtsDlG+IDJ5QBacy6Tv3xkq032WG5feQwYx9yhAOcq3H6vHyvg02K80guXPG8NFoVIJZAyCOc9Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd36dfc-12aa-4bb7-7bb5-08dd61866a18
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 16:53:29.1886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y64GzCc3Tb8eHjOWqlXe7rdmKjceVUxFYxiFiwtBpS5Hi7Hc45g8/DhPC/xX56KhWgDuqtInOdYRo9ojgD4Ehw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503120116
X-Proofpoint-ORIG-GUID: Acya9NL53Pe64YF9hTcOzhiVDlWagqJm
X-Proofpoint-GUID: Acya9NL53Pe64YF9hTcOzhiVDlWagqJm

On 17/12/2024 10:36, Alan Maguire wrote:
> We use the DWARF location information to match a variable with its
> associated ELF section.  In the case of per-CPU variables their
> ELF section address range starts at 0, so any 0 address variables will
> appear to belong in that ELF section.  However, for "discard" sections
> DWARF encodes the associated variables with address location 0 so
> we need to double-check that address 0 variables really are in the
> associated section by checking the ELF symbol table.
> 
> This resolves an issue exposed by CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
> kernel builds where __pcpu_* dummary variables in a .discard section
> get misclassified as belonging in the per-CPU variable section since
> they specify location address 0.
> 
> Reported-by: Cong Wang <xiyou.wangcong@gmail.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

applied to the next branch of

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/

> ---
>  btf_encoder.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 3754884..04f547c 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -2189,6 +2189,26 @@ static bool filter_variable_name(const char *name)
>  	return false;
>  }
>  
> +bool variable_in_sec(struct btf_encoder *encoder, const char *name, size_t shndx)
> +{
> +	uint32_t sym_sec_idx;
> +	uint32_t core_id;
> +	GElf_Sym sym;
> +
> +	elf_symtab__for_each_symbol_index(encoder->symtab, core_id, sym, sym_sec_idx) {
> +		const char *sym_name;
> +
> +		if (sym_sec_idx != shndx || elf_sym__type(&sym) != STT_OBJECT)
> +			continue;
> +		sym_name = elf_sym__name(&sym, encoder->symtab);
> +		if (!sym_name)
> +			continue;
> +		if (strcmp(name, sym_name) == 0)
> +			return true;
> +	}
> +	return false;
> +}
> +
>  static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  {
>  	struct cu *cu = encoder->cu;
> @@ -2258,6 +2278,13 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>  		if (filter_variable_name(name))
>  			continue;
>  
> +		/* A 0 address may be in a "discard" section; DWARF provides
> +		 * location information with address 0 for such variables.
> +		 * Ensure the variable really is in this section by checking
> +		 * the ELF symtab.
> +		 */
> +		if (addr == 0 && !variable_in_sec(encoder, name, shndx))
> +			continue;
>  		/* Check for invalid BTF names */
>  		if (!btf_name_valid(name)) {
>  			dump_invalid_symbol("Found invalid variable name when encoding btf",


