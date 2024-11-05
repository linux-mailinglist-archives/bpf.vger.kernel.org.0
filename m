Return-Path: <bpf+bounces-44079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D55D9BD977
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 00:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30CFB1C226A5
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 23:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F96216450;
	Tue,  5 Nov 2024 23:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GPn+pLRk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BMUJkXqe"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B73383;
	Tue,  5 Nov 2024 23:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730848082; cv=fail; b=k5gBqjJoGaAmLTlMsdT91Chcy5EipSVMRCWufv4ANqMq/euYJ7ERw+qPQN1rRP6YhNFi9TSPUUp3+gLviEdxHG+rMcTN2GL3HHF5CdmDtvPJaQhvG/8Idyn3xPFYd/DyUDYhrF0ir0tQVtyKFoRv2trnLPT+O+JTGxpDiK7bDdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730848082; c=relaxed/simple;
	bh=0nfGfDUyz5osWABLP2RGUvB1beJhoqGRqIsDA6kRg+s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=POyDh8YlNPcFweL5iRwq786kWszkqgUC+Mz+hwqUHngVcbQyvyOWKSUhJZf8KCWY5Yz6MYv9mtoxxiGims/XXPtMZTs5G4HIFRXJk3Sgr7Yx2ckM9mlUn8BKi0664yIAZiN6j45cU5QqlmdIvXJoa5sZI5n/20syg+AyWcq4SHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GPn+pLRk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BMUJkXqe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5KfYxf019801;
	Tue, 5 Nov 2024 23:07:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bocijomQdL8XKPPNCF322+4Lnn2rt6c4dZstyDZyAfE=; b=
	GPn+pLRkcKa809/0yyh6P+2pbZ7jqT9pT36Hy3SLHZ8QOnWtwUpRbWSbsPLsx5Dy
	dPd2aIszRmFZu2sSxrh+7+w3EtuyhxCwX7aEYgyrpIdMIHtK+e3epNC2ahbHroRn
	urPXUXhTyekg5gKbV5ZvXisojeeLYL+EmwMLRKRR+3ecel0VZWQFeQjNZySPY7u0
	jn/jQdWmsTBAqDZVmcuLTSnU94V3r/4C2RA292eRYMeIUIRnwy99p4guzao/hgeK
	O1sCzs/7vkiqNap4iF2ea0a0EIodON5w07R/e7ScOmDbhI0Fj/peMOafUKPcnyTK
	b19dh6ipc60SAxXHZu9+RQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nav26nyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 23:07:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5N2Jnt036689;
	Tue, 5 Nov 2024 23:07:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nah7t8jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 23:07:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KO33PkZ6k+yEDoZfY0BV0gGOcHF5NStnu3FicCSTxcOQipYMp6X598IDBkrFPz0LwFGhIsEpvvDeWJM/4mqMhKlBflcyqvPCZBK6lsYn4KtqD9/AZCeEzmENmF+N5O307IdNM27jmjlD8TJwD8WF/SM3JJCSJ7HrbmzhzfErGzv3+wa4A1WH7yHnfNYTTimidqahi7HMotsyTKa2o62+kfJ2+FrGUK4NA0DLewKXURoAZqBtkZG3oZTsmbk+bM/qYro1Mu0ez+pH1Q7BgvKLsXTVCQ8Fm+xmLlPzz/WdnoOhM4QnORLS4cr0DCqJ1bSY9kohti7Jcpm6NEXAQTGs6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bocijomQdL8XKPPNCF322+4Lnn2rt6c4dZstyDZyAfE=;
 b=Mcw454YrITs6v3hOEyHx6GLhe4++9pnyudsvmp8cq/NTC2UNzuYMg72VGEmCnhqjvYDhN+SOEUKxJLpwtNhPKDEUk8YQBmhiyVYjBApe8O3OKUvPJGLdpy8FbgEZNcqLl8qePvzHFQbYKLVsXqzroYcFE5jPuf6P7a9fynYfGPrdWGpix7EMOuBiwDeFTLD2hA92sIu84lGUmCINlVyXoYE0CLnL5J6DjiziUr6GgzyjowrNFmsWPFDen+YX9/5x5qck2u0mDma8BeK6WV8fxHkJOhWB6NbxwSlNSAQ5/6ZyVYIVUqv6/SZtn4OMzIXwYB5BhWXxhAgUkuDn2ceeSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bocijomQdL8XKPPNCF322+4Lnn2rt6c4dZstyDZyAfE=;
 b=BMUJkXqeqJMdDxc2DoIM74/DCKjwwY4nqYkMVMNheYgaChb62av6dsv5QDRAS/oQPq2PtJ6G4NB08BJ03y8gFtiUierIQckOtprIHIsurG9okpx83P8PwHceHLGR3ewK5EOTlldmKO18RORyOrmzpv/R5U6JGslM4nYntBouue4=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH3PR10MB7395.namprd10.prod.outlook.com (2603:10b6:610:147::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 23:07:18 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%3]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 23:07:18 +0000
Message-ID: <19f0b0bb-dd2d-4cdd-8b86-b995b01bfd03@oracle.com>
Date: Tue, 5 Nov 2024 23:07:07 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kbuild,bpf: pass make jobs' value to pahole
To: Florian Schmaus <flo@geekplace.eu>,
        Masahiro Yamada
 <masahiroy@kernel.org>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?=
 <holger@applied-asynchrony.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier
 <nicolas@fjasle.eu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20241102100452.793970-1-flo@geekplace.eu>
 <73398de9-620c-9fb9-8414-d0f5c85ac53a@applied-asynchrony.com>
 <CAK7LNATd0UNu8KsxeD-q2mDUTxQD3ATL1wF59B9K2pxzU08OQQ@mail.gmail.com>
 <935ac01a-8a1b-4986-9802-d2d1fd6445c2@geekplace.eu>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <935ac01a-8a1b-4986-9802-d2d1fd6445c2@geekplace.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0476.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH3PR10MB7395:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cd7fbce-a858-4003-3655-08dcfdee9888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlNYbzJyRkc4cXJocHF4UCt6aEQ5dzFGcnpyRkFDd2dOeDBwem5HZXBhdXA4?=
 =?utf-8?B?Y24veTVqc0tHdDRweEk2YXRmY2g0UFhxcVJ1WWVPQVNtTjZnNmFOaHJXK2Z5?=
 =?utf-8?B?dWd6RStkSGkyWmgwUDJBQWtBY1c0bEdkV1BZa1V3aXNSYU0xSkhtRUkxMUNG?=
 =?utf-8?B?TXo3bkFEemk1R1o0ZndKcDlEZU03bVdJWHhGeW9iU21JNU5BYWcxbDR0UStZ?=
 =?utf-8?B?c3Y3ZDI3aTV5Z2tHUWpqbzNSMWlLSzNUMlpOVFJpZ3I1ZGFmWUdUbGQ1V0Qw?=
 =?utf-8?B?Z1JoL3RJNXhDZEhtSnl0czdBQ3dZK0s2SWxUSW9NbHlQVXppeGFJY3ZZQllS?=
 =?utf-8?B?Mmk0N1NhblVJbWNWWUdSWTJTS2xlOWtSSVdWRHBlZmdEUkhhclYwL25YZTZT?=
 =?utf-8?B?VXlQQW5lMlBZRXhLRlpScXcrWHRNd05GNFNUbjBrUnlEZ1FFVnpoU2E0VVRt?=
 =?utf-8?B?dnpDKytPY1pDY0NielIreVN2UTZHN1VuY0xENUNoYkc2aTBTa01zN1MzdFMz?=
 =?utf-8?B?bnk4MmFid1hpOFlhQ0I1UWJxc2FFL3gxSVlocCt3Wi9VRWJxejFGazU5aVcv?=
 =?utf-8?B?dDNsUFdINUVGdnZRc1daUW44ayt3SWFrcTVnS3lmTW1pL0JvZnlTZGdqQ0V5?=
 =?utf-8?B?TFpBNmhiSzRIY0xQcXB6Z3g0Z2xOc1NwQmFvUFBwd1ZWR2pNK0lJdlZEVUVW?=
 =?utf-8?B?M0YrVXJmaFNrTC8yTE81Y3Jwd3pEWGp1SE1HZEVrbEw5RmxyeHRMQmZLN1Qv?=
 =?utf-8?B?cGIxT0tGZ0ZVZHA0WjdGZVV2dWpqbndBd1hRYjBpNDMxZnh1UmdmU3h6SFhu?=
 =?utf-8?B?ZkZDRk9YUGR4a29GaVY0Q0FPQ3JZQ2hKOTlYMyt0MnpSVk5udThtT1ZhS3Fm?=
 =?utf-8?B?NGkrRThLTS9pOVBCalE3MmcvTnRXd3lwdVJzL29hRjRYSGdoYW9mOXhUbjBX?=
 =?utf-8?B?UmFnN3FiUHE4d0JIWUM2NjhpT0ZPQUhWL2E3T0lqa0F6M2dKMlhnUzJlSm5m?=
 =?utf-8?B?cUQyNjllRG1aWXFkS2g0ejFnMWFaSGFkVVdUaHdZTWUwTVE1dVlxUzhYRU1S?=
 =?utf-8?B?ekg3MVdYNUhES3l5TjdNSnRkMXRPM1pUbFRuUkRTREdLVHZ0dkpQNXVudmdT?=
 =?utf-8?B?OHkvUkVYc25EUE5sT01OWm9LQndZRkVtZWJUUkY2SWdyMjVobVExV1A4a2xU?=
 =?utf-8?B?ZG5VellyOERqckNjdlVueXdrR3R1aHBsVmxBK1Nmd1VKOHBEb3pDQlpWbVcr?=
 =?utf-8?B?d0RjY21oNTdnYUZ2MFI3eGJtOHJsSXd3VzVXNHFnYW9iK0U5SEJEV3BWbmpx?=
 =?utf-8?B?aFhFRFRPN2hZZmdHVGtoZEJoOVEwT293cGRzTmNMeFcrNWxZUzEvYjhzZjVD?=
 =?utf-8?B?Y0F6dmFYdGp0MkcxckNGblc1NG9FMEdKSEo2bkNUc0EySjlLMEExWG9TbFRO?=
 =?utf-8?B?b2dkSlNPSVZnWHFocVlRZHNEZXRoU2c0cnJDL1dGQjdFNjF0UWlaU3dQSWIy?=
 =?utf-8?B?SWZNa2ZPQnhCTSsrTDlaNGlGYW8zZmRXU2l0YXhha0RxUHZ4M2UyMjk0SW5u?=
 =?utf-8?B?clNrdkRYRzU5U3NFY2Q4R3l3ZWo0dVlMMkFZMWkzWHdRWDlhMzNQSVVibk9L?=
 =?utf-8?B?TzBkT3Q0S0tqMmFCbUtTQ1FRQndnMmY0K2NsWkFkMnl5Qy9QNENGbExJMlAw?=
 =?utf-8?B?cXZ0YzdsOGhKTUhyYjNtRnIxKzgwYlk0VEQ4MFVqN1pNMTlPQXVmZEs5Vmpo?=
 =?utf-8?Q?wSotcAr4iJTzIKKK40Sf33L3VAcFp1Ec903Bb//?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OStpTzNNTHBBKzZVY2N0MUlWSEJyeGoyeENlYlhlSzUxZkNPY285WEVPOXI0?=
 =?utf-8?B?akFOcU9qT0t3T29GUUVBL1puOWdINlIwR3I0bFpOSDN4cVptOVcxdmw2Yjdx?=
 =?utf-8?B?czBWY0J4bCtndFdJVkQ4NUgzNXVXVEZCRFN6RzJPQzh0aVEyUU1IeGNsdDhm?=
 =?utf-8?B?blYzRGg2OFNtRi9YYW1PYmlNd2EwTEpkSTRDTXJQZFQvd0JTSE83aitOeG0z?=
 =?utf-8?B?dW9GMzY5K1dQRUQxVHZNcnNHKzUzT2NDeEt2cGZFZE5jUXV3WTZqNHp1VXlw?=
 =?utf-8?B?cHN4V1hsdzdsWG1nV2hwQUZLRUo5K3ZTRkh1Sis4NTBIZzF2UnU0aHUvcVcr?=
 =?utf-8?B?VkVvWlYxamh3SFlFNWhDNFplMmtmM04wbW5XSm1ISXFHK1c4RjZUZXhSVlpw?=
 =?utf-8?B?ZjVid0RvMHJlVDdBZlVtcU9vYjU0WkpDdk5qTmw2L0lMeU91dFAxTkczekR2?=
 =?utf-8?B?RWJjWlhBWlN5RmpKb2xVeENlV3BwbWxYL0ZzWXIxOWlaYnI2N0R3SVUxeFIz?=
 =?utf-8?B?OHpzbDF6LzVmeVRBSE5TNG9aamtoNFlmVzZqZFcvT2UrMTRUMjkrR01tTU1i?=
 =?utf-8?B?RitBbG4vZnBJS2tDZ3I0VHRES3lBa2dMQTgwTTI4THZQY1lxeG5LWGgwWUdI?=
 =?utf-8?B?OGtVU1FJUklDVGtNSTZqb0xrNkYzVGRMRHlEL3JRU0hFSEUzaHErOW0vdHA4?=
 =?utf-8?B?aW05RzVLZm9nYnlMUm5xY2NwQlRQLzN3RGwzQzNpZWJDN1FCcXYrRUduYlVN?=
 =?utf-8?B?REJSUUgyM2JHVE5OSG1rK01JZVEzcXhZQUtBVGJSc0xEbkp0aFhGd2ZnZzda?=
 =?utf-8?B?Mk1XU25mZDBES1hZOHBLRGFMVlRJRThHaWkrTTRrTGdWWDFyQUxDNEFyR0Z5?=
 =?utf-8?B?RWFXZ0lUWW43OGNhVFZMM3FGa21UU0p1N0dPdWNndURqSFJvZUF5eUgzYStu?=
 =?utf-8?B?Q2J2cnRKRk1HZWVuc0NzbmJ5bGV6U3VFLzlOcWVBQ3NYYXFtSHowcGphZmgx?=
 =?utf-8?B?d1FOUS9udWxLTHZmb1FKWTNLMjkvWGtScTVvbXBhY0hhamJ6ZXEraFl4QkRK?=
 =?utf-8?B?YkVXVkoxem8xUDlZMU9QNDJ4clhsd0F6NEc3TWJkYVBPU2NUY09NaWZGVk1C?=
 =?utf-8?B?cXJlandNOWUwSWxiZlZHUzlwTzFVZU5TRmtkLzEzRkRtNDVIUXpKUjdJN0lq?=
 =?utf-8?B?TVR5YW1iV0pnZjFGODZPdkduYUM4MmJjQmgyamI2dEZuWElvTmtiMGNkOFlE?=
 =?utf-8?B?RHlXSTRobHA3WHp1YkJEZ214bVdKaG1hYW9TMHRoVlN4eUdrNWJBd250blpp?=
 =?utf-8?B?bGVDMjRtOHRBUDdMNEJSVktNT21Zc3FYWDNHU2w0ekRLblhhTmFxZDkzak5L?=
 =?utf-8?B?Z3lqRWgxbnBqTjU1NXNtbkY0ZThoWWF0T0llbFd3R0cwQ281UEpzY0Z3aEVF?=
 =?utf-8?B?M1UwOGZveklUYVNkd0xWYW8zUjlLclZTcVl2ZmgrVWJaR0FscUs3KytNRjYr?=
 =?utf-8?B?K1FNRUdCOXk0emdzSUxBRVIyS3MwV2RsU0d6ZXBVSjI3TXNpUEVKNitrZ2xZ?=
 =?utf-8?B?c1lHVm91RU52RFVWejAvSFRmeUhrVXpBYWJjNkpjTDF0ZlBua1ZaMW5BeStK?=
 =?utf-8?B?RkE4M3VvdStaQjFaVzBrdGt6a2Z4RHNGU0d0STdzVUJCTEFadnlqVTEyY2RZ?=
 =?utf-8?B?eXAyU2FDRlNISjVXcUxwdWV0Znp4WmlrT2lTQW5yVW1HM0Nka2hEVDk4YUZz?=
 =?utf-8?B?YTEzWk5mekxWVFRmVjMvQWFzYTRFT09UUXBrRFR0MkkyZEZ0KzhsbWNvYUtY?=
 =?utf-8?B?cGpSR0FrelFWMVd6aDE0TkF2NmN3WmhaeDhGYVVOc0hWTENKN3laczg2VnRz?=
 =?utf-8?B?anBsNDUzOXgxZDNQQjdaL0g3OU1FVTlqOWt0amdKOTRpd21uVUkxSXc3bXMv?=
 =?utf-8?B?bks0aXJTRDFYblBDUllCVVd2aHNXZy9QK016b1pxcklQZE5ZcnpET0Z1bXg5?=
 =?utf-8?B?Y05MR1FPNTI2N2YvK3lwUkJhaFZjMk9JVDJETjlaV2NXWUc3Q2hWbllsL1Nz?=
 =?utf-8?B?V3NjVHFGRzVLN0VmYUpqS1VEQmw4Y1JVNkZKTHZ5b2tjZzdFSmZDaG1hVmRL?=
 =?utf-8?B?YXRYTVFSYmRYemduNnludWE2QnBRcTJzMTVPNEdVZis5WEdvT2dydXlOWjYv?=
 =?utf-8?Q?mDFlMwwYxZxs/ubCJYP55WE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0N7bMAk/48hwJaYVPzAbB75QMJQCt6AjcFRvg18fdSwtcf9kaRima8w6vc4nFaXVkp5tsOqdsGqnBKIXUXy37qqO6Exu54NtFGG0uNTiW14R85g2r3IFp8ouL9Essikz3sGKCXlCEIi1ySuxh82nKsJeE/6VMevTXCsNfVWaXPUO3RSDCVPqsce++rFRI3rLAYJdLThTI7WAgwNu1HHL4jk6Nb9K98EmEsJ+KaUyYKbomaYUEx/Pl+QAVd1kCrhsOrznN+Vxf47T76eDqc4g5U54udmYgoIJ9GeeFm47KCBCGgfse3GzNt7YpkjJCG1+iSI0VusLVZBuncGwLRF/9PBIR8qviVlOIzMqS+Kc9xisNLb3/EiV0RW1u+yuKDyLY/beQFxPZTtlYMdFvB7hQHhPHwDWLr5MIuf2nEf5OOvnoRBcSCcsnSextobX8pAk6gzVzulycAoL3vWyJy2at8KrvbltLTfMBOT4l9AAoJnVZ25qDt7B9FFdjXjnrRjo1m87pRODcEBm6VkzQOfkwIxrLDhUxzNZwcbxPayvAe6/yNNi8gH1mCQCm56Ui5GS1uh9F/zlZHa1uitIHpGU3ZFv89ndUA970x5iNnTDYA8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd7fbce-a858-4003-3655-08dcfdee9888
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 23:07:18.5985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBdZsHKAz5NEYEc4Qb52iXQgB3Cjd0q7TsQ5xe6XsEFltLOQTnjcEt7r2+KzpnZcmc9YHoCAc35G6yBZzjhc/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-05_07,2024-11-05_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411050179
X-Proofpoint-GUID: 3Amvg7kmtiUdeTBBZXIz5kS9ZloFUAQ8
X-Proofpoint-ORIG-GUID: 3Amvg7kmtiUdeTBBZXIz5kS9ZloFUAQ8

On 04/11/2024 12:52, Florian Schmaus wrote:
> On 03/11/2024 14.22, Masahiro Yamada wrote:
>> On Sun, Nov 3, 2024 at 9:04 PM Holger Hoffstätte
>> <holger@applied-asynchrony.com> wrote:
>>>
>>> On 2024-11-02 11:04, Florian Schmaus wrote:
>>>> Pass the value of make's -j/--jobs argument to pahole, to avoid out of
>>>> memory errors and make pahole respect the "jobs" value of make.
>>>>
>>>> On systems with little memory but many cores, invoking pahole using -j
>>>> without argument potentially creates too many pahole instances,
>>>> causing an out-of-memory situation. Instead, we should pass make's
>>>> "jobs" value as an argument to pahole's -j, which is likely configured
>>>> to be (much) lower than the actual core count on such systems.
>>>>
>>>> If make was invoked without -j, either via cmdline or MAKEFLAGS, then
>>>> JOBS will be simply empty, resulting in the existing behavior, as
>>>> expected.
>>>>
>>>> Signed-off-by: Florian Schmaus <flo@geekplace.eu>
>>>
>>> As discussed on IRC:
>>
>> Do not do this. Others do not see what was discussed.
> 
> Sorry, you are right. However, not much was discussed. Holger just
> pointed out that the memory usage of pahole was already reported as
> problematic in
> 
> https://lore.kernel.org/lkml/20240820085950.200358-1-jirislaby@kernel.org/
> 
> My patch would potentially help there as well, as it allows the user to
> limit the number of threads used by pahole.
> 
> 
>> I guess the right thing to do is to join the jobserver.
>>
>> https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html
> 
> Yes, this would be the ideal solution. Until it is implemented, the
> proposed patch is probably the next best thing.
> 
> - Florian
> 

If you haven't already, I'd suggest testing the latest pahole (building
from master branch). Significant improvements in memory utilization have
been made and more are planned post the 1.28 release.

In terms of the patch itself, respecting the "make -j" value seems right
to me. Thanks!

Alan

