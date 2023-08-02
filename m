Return-Path: <bpf+bounces-6709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A00D76CD3F
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 14:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC39281DB9
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 12:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D6C746C;
	Wed,  2 Aug 2023 12:43:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04E163B1
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 12:43:41 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97673273B
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 05:43:20 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372Ai4uZ002886;
	Wed, 2 Aug 2023 12:42:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Ezcjl9H66KCQE7teV+jNL0ozEJc+wgSNNl84aVLJpks=;
 b=jE9ue6PVuHKyjFI+/9Sr7WiM8b2E6cT5c5x9ZW2xJDz1noE28KVmfjcznGoGMJN9N1n3
 C9/+ex0cdp6z+IQX//QyinDYJQ8UMGCvTctwS8MVNqkKwArWLtO6qDTChj5606HY+MwO
 Cq1OC9aN09Un7QGkJES1Vq8a/T1fL9FdoNl3ln9i012UZGGAa91s30uexIV1rTGB5anP
 cB7+whlK8LxKxL3LIVA3gr82cu1U14m1e4qoszc82VQb/sbCVhWs882re+3GUsJs5DQE
 ad3FTgBq+eGle/uSN07LpEsTvlF0D/cECRfs5wOdyayG79OvV55qsNz1PIUFIDALe+ci sA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4tcty43b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Aug 2023 12:42:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 372BoMFl006605;
	Wed, 2 Aug 2023 12:42:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7ed35n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Aug 2023 12:42:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeoDworvSL0ixCrRbL9hcmVvLSx8FvXSegGEy8RCkRYVNEkjG9DzmnmT/S4QSXMsGAedjxqLpsMVxXmq8btlSqTEweZf8AL40yE0cdCwgp+JvM7aDQyVTT/VFpeDBDgHI3p68jKTRUf65KuJmhMCKwLv9dXLmVk9CuGmv8jOZutT40lKeOHz6Wu8TzqGeVG29zGXTU4nhhvv8laWgx9zm14a7/VFa0qvMedeJKI8FS5wKFSemf5SFr73VhXA+UrbnjoLKgSnqE3+yWwB9+m9yvKqjHXVK7B+da7p2kEmbPR+D7bEfAVkMNjvfmcK5rUWxnPCAHqhqUP4WkcMdJCKZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ezcjl9H66KCQE7teV+jNL0ozEJc+wgSNNl84aVLJpks=;
 b=If1jn7DOqML+b5E4WL4Vq5VVqNJkryGukJNMVqQWHDOxdLIro4cWz+QB1ZWp+6SSva3Vu1BWCwxgzN0gckSUPmMMK6Ipip9/ZMOeuhZsYNyfsvIjkiGzGumAL7wjXU2vQtUZsQuK+M8YmnKS12TWUIFZTeSZlj0P1RW5BGmXJCUnRRutssFFt2Tq3NuuHu32Xliq/+BhWh2E+4HF75bhHV0pUn7jkMaK/lJSAabWbDvKW2nF/AUrihvKHrtBnctIB5licoKh/cO+wIGqBu7PLV1RMg8wL8YLmJ9KH8s/RMS9OXVlO0X6tlsUKJrrd8sTpc87s76Jl34M5z3q3/9Qgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ezcjl9H66KCQE7teV+jNL0ozEJc+wgSNNl84aVLJpks=;
 b=diMNxo3l+f+pNnc+lCM+cOGqsJUSUUuzgKmvYM9PPW3qTl+AJktyMJYMrt/6dQfHcNwtPdKpS8pySzty/uDZou+Geex30vuSsB4jzUET1KzlE4GZk9imcgsRTpU92xOUNvYdtZm4R8O6Yh4Qi4p2tA2Z9Ic2pM66C939+Hi2TAU=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB6178.namprd10.prod.outlook.com (2603:10b6:510:1f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 12:42:17 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6652.019; Wed, 2 Aug 2023
 12:42:17 +0000
Message-ID: <bb978112-c133-fdb8-44b4-4775832207c7@oracle.com>
Date: Wed, 2 Aug 2023 13:42:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add bpf_get_func_ip test for
 uprobe inside function
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20230801073002.1006443-1-jolsa@kernel.org>
 <20230801073002.1006443-4-jolsa@kernel.org>
 <ca1c1fcf-4cc5-da44-d0ed-1bf7b6c66892@oracle.com> <ZMpLkJVPSVcc17Ou@krava>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZMpLkJVPSVcc17Ou@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: a5740ddf-9f88-4cb7-059d-08db9355e793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2yBE7F20n9ziX+MZ6hg6A9Lji26k13fJKep0xeQ6vEht4jvSkRWiuqKAoQOr2Dj4tFJkVuHmRZHt1UIjfz9THDCUMWwxWsL5wG3nPdSLAcQGVFHL8wIVIHhw9zW1bW3iqUTgr3hqzAMaPT/s70dBSdRxo9fYcVqvrYAClEli9tOpqbvmOCY7vvDZZ3ROHPX6fHdE0XpFeQzo2/jBDBcCR11qFlUKOe/IKs4qv56TPQNA4GXweJN3wwbEYO3SyvyLJjsDMannvKJ6CbBBBUhoj0BbeQeyeM8dxIwshV42euTgQJy6SvwSZl24TZ1wVrWGYiwGgHzOZsYl9VKHnp0U8ftJ6CwY1zbKCWMY4rNBxAMCm5jWRzpBlTSsB5RyXO2B8xWNZbKo7DMDRlxC0bfk4Bozi7oTRekYlyG0Zdq1MuRAQd2NmI2QyxUqv5TRknmO7nbciCZ8RN5zed2RTVKA/W+KVRoqx3Nc+KENEjLoXYoJ1/CeBqkgL1JfokKjO6oF0fUsgQyONvDoXqtWGta12TlWs2fpqz/XbSjTtGP77aoTPqQxCHiCfje8YluKTDUqIahn1ccCA8k71itV/jgY/4Z3VLA+UEFgZGM5G+DCzWewRSleZMh9Eh1uYvm6mgXU3DA9wq5kqZM5cV3FalBSpw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(5660300002)(83380400001)(36756003)(6506007)(53546011)(8676002)(8936002)(31686004)(7416002)(44832011)(54906003)(38100700002)(6512007)(2616005)(2906002)(66476007)(66556008)(6666004)(66946007)(478600001)(31696002)(4326008)(6916009)(6486002)(86362001)(316002)(186003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RnluL1VYczlKMnUwTDFOZThVRDZXWnZoTEZDbC9KOGFhY1k0Zm0yVDNVay91?=
 =?utf-8?B?d2NDTk43d0M3T1UzZm5VRThLaWx0dFZyWTVPTWxHRU9BOGU4VFJDSU01aHcr?=
 =?utf-8?B?MmN0OGtsaUd2SXo2eE1rTWpjckY2cjBKYTFrSWNad2doendoQWVITmJrT1pt?=
 =?utf-8?B?USsrK2szUStnd3JZQTJDeUo5WFhxWWMyd2pNNlAzM0RiVXdMY3E3cHNCQ3ZM?=
 =?utf-8?B?SFNZUWx2alR3S21wWkQ5clkzNDZoL0R3aHRqOEs0RnFqZkJWRkkrYk1jcXpq?=
 =?utf-8?B?My9QMXIyNytNWTE0UVJZWkdJd2xtSmc5QmY5TVp0aEdPN1c0VU9lNk9mMXRh?=
 =?utf-8?B?ZDVZRGRhV1FxWURubVdkYThGcmFjczg2UlhERDJzQjVWN0U5QkNtYjlwZ3c1?=
 =?utf-8?B?ME1ZeTNST1J4MmlQYVZBSzQwY1oyMnhVZFhRY2xWY2VlZzgwc1hweU1kN2dw?=
 =?utf-8?B?ZDU5ejJld29oZHkrc2lqRTNVY2ZqWjNiYTNaYWdZVzdUdkgyVkVrYXB6N2pM?=
 =?utf-8?B?Ry9mWnpqU0MxSktXNTVjdjgxY3lDbnkxb2M2ZXZLSUJPVzVXY0ZCSE1sbkxp?=
 =?utf-8?B?bVRxd095alRycEZQSjBKZFlnckZBOElwMXg5YnZRN0hkQzY5cUJCR3JadjV2?=
 =?utf-8?B?NzM5MnV3WXpHK0J6TkFvdElZWDQzR2xkdXNPL2xQKytUOTZxMWZua0Rqbndh?=
 =?utf-8?B?Q1J0QndkbDl0eFNsaGMwVkFORVNxWlFPSDRjWFZBMkZFSkFIc09UM2I1S2sx?=
 =?utf-8?B?VDdMQnhObEtBMzF4dGliNVZKZ1JKM2ZyR2djMzhGY1ZSMXB3clExQnNRVW1q?=
 =?utf-8?B?TGsrUGszVDRmREtSM0lFUUpNd29CM2FvckFKUjVzY0I1akcybjlVeXJzWnZW?=
 =?utf-8?B?WTFGdVE0OEhVbithYkhaYzIwaDUxdU5jUWE3YVJzZnlZaGxDblk4Mm1WOXM2?=
 =?utf-8?B?NVJuRGU1SkhMZTVKeTlPNmNxZzlzS01KZWtOa0NoTWhDV0VtMEhSblBQZVBJ?=
 =?utf-8?B?TndUR3BTRy83ZjVTQmIycG8xV1hpV3RIZVpDMmFUdU5EcUdmRTBmV21RTUlQ?=
 =?utf-8?B?b0dCZ3llcHA1V2hXY3NXKzRkZ3lwb3Q3aGplSkpjZ2tZekdVdDB2UkJwejBm?=
 =?utf-8?B?cEQxQ1ZRVlMzckVQQy8veVpNU0FaV3RJTjB1dytWSngzM0hCcjcwaXdUTlVz?=
 =?utf-8?B?MytVT2VycmlqbUczNkc0UVRLTmhLd1NCTEJNT0REeWJjdWFieW9mMUp5UlB2?=
 =?utf-8?B?Z2xhOEVvdmI5bkpoQ0s3WmtVenZwVXlsMFJwZ3pkekVkQjdwemN5bHRMd2hD?=
 =?utf-8?B?eHNDa3RuTzFLZ1FYR29YOG9zSkRyRTF1dnRKRzJicGYvNU5YVkVkMG1IRng1?=
 =?utf-8?B?RFJDSXB1bWtyT3ZkbXgzN1BveG9jQy9jK1c5M3B3ZXlPM3BwUFNZQmtWeWlC?=
 =?utf-8?B?Y2w0MnlHcFRoZFdBME1aY056QU1RTWNmbkg0a280SWF6VXI2TFZwYWZFZmhQ?=
 =?utf-8?B?RnVVYWpQQkNybjJnRmRDRTlXRU9qRDd1dlZQcG9MdThPMjkzTjFDTHFia0lU?=
 =?utf-8?B?UDFEUFUydzB4ZVJMZlZESmUzQ1pid3JEWDF1RXYzNUh6WUlBMXpobElROHhG?=
 =?utf-8?B?TC9UM0dnYlp5Smt6NzdPZ2NCdmkrbWMxSHIwazFIU1ozS3g1WENCVHUxN0p2?=
 =?utf-8?B?T3JyKzJCaGlZRFZVUnA4M01XcGNuOVBnZ0N6SzN1RmZXUG42RGMrdFFnMUpa?=
 =?utf-8?B?aHU5cU5pNmR0VThMZXFyWG9abWg2bXVFUEhGQnU4R3ZGTXVIREJscjl6Tnh6?=
 =?utf-8?B?UHRLSnVPOTBIL29NMFNxYWN0N3pOY3JDMzJWZlNCdnRFelRrZmU3K1lpcXZm?=
 =?utf-8?B?akhIejIwT3c1SlJUYXRKc3NFd1BkeWJpRDJUNlJXbWUzTXUyNndKank4aDV6?=
 =?utf-8?B?Wmg3SmVhbEtZR2diczA3Q0ZRb0hRcUdNRTI4SnpLZ0F1RWJhTi9oSlMwSXkw?=
 =?utf-8?B?bDVkd2wrZm9sOUduOC9QZHBhYk0rbkNNaGNDZzR5QVVVRy9VeFlhQTNqMWMr?=
 =?utf-8?B?Rk1HMklERlgwOWcreGZyU29xQzFoTm9XZWxDeWZZSXZ2UEtqcENOOERRYkdv?=
 =?utf-8?B?MTc2SFpVZ3NxM1dMSGJ2VFpLVWoxWlRvTHpNS3ZhSXB6WmI1MzROUzlWMUdh?=
 =?utf-8?Q?SYVFoNdTOs2sHk3AjJWkitI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?TlgvSnhVdVlMR0dhQis1QU82dDZJa214d0dUNE0wK3Jkc1pONkN5Nk81OTB5?=
 =?utf-8?B?YXhQWGVFZENjcW9NTmdnRjkxayswT081Q2RsMUFhTEJwaTcxbC83TGllWnpp?=
 =?utf-8?B?OUFiWW9uSFk5cGtkeFM4bkVtVDVmNmp1bWlWNG1uNitsb3lDR0pxUTZzelgr?=
 =?utf-8?B?NDZneDZLci9zL2haVnVVbTN4ckswTlhzQTVTS0JDWkNvSm9DNzVnU1N3eTY4?=
 =?utf-8?B?NjB4b0VpSkVyNmpIQlpJdzRDSlhDVEVDeTJSc0NIRk0xcFlHNGdoWHNxSTdN?=
 =?utf-8?B?UklPWS9MampOWEVxNHpiMW16MTIxWmFLcXpRdU5GMmlKblpTd29zdm9pWTc2?=
 =?utf-8?B?MU9IZEFpUHJFaWl6TStkOVJ0ak9ndGNWaTlNODRFSlp1ak1Ha0dWTFBBaDU0?=
 =?utf-8?B?dHYyK2I2dHpEUFJRWk1xbTJPZkw5Y2N1TTE3ZlZTVHhrRjRsRUliZTd3SytE?=
 =?utf-8?B?NUdZUnc5aHpsTHNvcmkrZ3BGN1hoZnpRQXJvcldDVmhXUXRtVmlnN2VXU0tq?=
 =?utf-8?B?TDZHeXZWR0tPWFV5YWZEUWR1NzN5SVdhMzBIenFLZEJPK1djZFlXbithdDhj?=
 =?utf-8?B?UjZaakdtWmRPNmViNW0wbzN2NE9rMU5KOGUvOGJDWWYyeGtxNmVvb2l0WEY2?=
 =?utf-8?B?VDY4TXl1eW1oZzBoa0pWcGxvcFZHRHYyZlprQWtHbnQxKzFrSVVOUEF6cTJU?=
 =?utf-8?B?bGxlRkZ2Vm5xcFRrcFJLbWxCYmlNOGM1REM4YWF1NmxESGtoWGtKTWRaSk40?=
 =?utf-8?B?Y09ORGxoZnF6Sm1xY2M3MFRnZzNnK2g2MGVJS05DbEhnRzk0NGUrWHRzd3pB?=
 =?utf-8?B?dlZydi9SaXNMK1k3d1lVcS9ZR0hiVXo1eFNHenNTMjFoOW4veU5jdUwrUzNS?=
 =?utf-8?B?b2J2SFdTK2FIWGpRaGhnd1lJMXlySXExdDNYNWZNb3BZQ01ZV1lPVWdxUVVF?=
 =?utf-8?B?UWptZU1uQzJsVHpqTndwbFYxSzdYaUdiZExrMGU3YzlHTVVEYk1ibE8ybE1w?=
 =?utf-8?B?UFB1RFU3UnNKTlp2Qm54TDVCN2JqWm90WVBIQjA4Y09JaVcxVjZCVWxycnRX?=
 =?utf-8?B?a3N5aUt4d0VqRDk1SFpLU3hxK2pGbEE4WFVUUTNHZnBSeHAxcHh6bVI1RkFP?=
 =?utf-8?B?N2t5QnRHdGZuUVFSN2ZrNkpXSHpjTlRpNW5uY1YyT0NQMnMzN2svMENKTWxl?=
 =?utf-8?B?blZkSVZEdzlzTG0zUnhtQloreDZtQSt3V3dRT0s1d3dkWDF1S2hJV3MwUVlw?=
 =?utf-8?B?dVJMSEFnN21KanU1NkxzcjhrUG1GcUtWTGtFNFJPMnNPa3Ardz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5740ddf-9f88-4cb7-059d-08db9355e793
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 12:42:17.2247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGi2qJFMBkbi5qWHDKM9gjb5QL90YWgvmko4DtG8y8E5YhWgglzzcpF/03uxGodK3+//jQy4fP2FdJCJIQX3BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_08,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020113
X-Proofpoint-GUID: O_u42Td0MxUGo_QDYwlXwF7xDeD_AWkI
X-Proofpoint-ORIG-GUID: O_u42Td0MxUGo_QDYwlXwF7xDeD_AWkI
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 02/08/2023 13:26, Jiri Olsa wrote:
> On Wed, Aug 02, 2023 at 12:30:36PM +0100, Alan Maguire wrote:
>> On 01/08/2023 08:30, Jiri Olsa wrote:
>>> Adding get_func_ip test for uprobe inside function that validates
>>> the get_func_ip helper returns correct probe address value.
>>>
>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>> ---
>>>  .../bpf/prog_tests/get_func_ip_test.c         | 40 ++++++++++++++++++-
>>>  .../bpf/progs/get_func_ip_uprobe_test.c       | 18 +++++++++
>>>  2 files changed, 57 insertions(+), 1 deletion(-)
>>>  create mode 100644 tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
>>> index 114cdbc04caf..f199220ad6de 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/get_func_ip_test.c
>>> @@ -55,7 +55,16 @@ static void test_function_entry(void)
>>>   * offset, disabling it for all other archs
>>
>> nit: comment here
>>
>> /* test6 is x86_64 specific because of the instruction
>>  * offset, disabling it for all other archs
>>
>> ...should probably be updated now multiple tests are gated by the
>> #ifdef __x86_64__.
> 
> right will update that
> 
>>
>> BTW I tested if these tests would pass on aarch64 with a few tweaks
>> to instruction offsets, and they do. Something like the following
>> gets all of the tests running and passing on aarch64:
> 
> nice, thanks a lot for testing that
> 
> SNIP
> 
>> diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c
>> b/tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c
>> index 052f8a4345a8..56af4a8447b9 100644
>> --- a/tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c
>> +++ b/tools/testing/selftests/bpf/progs/get_func_ip_uprobe_test.c
>> @@ -8,11 +8,17 @@ char _license[] SEC("license") = "GPL";
>>  unsigned long uprobe_trigger_body;
>>
>>  __u64 test1_result = 0;
>> +#if defined(__TARGET_ARCH_x86)
>> +#define OFFSET 1
>>  SEC("uprobe//proc/self/exe:uprobe_trigger_body+1")
>> +#elif defined(__TARGET_ARCH_arm64)
>> +#define OFFSET 4
>> +SEC("uprobe//proc/self/exe:uprobe_trigger_body+4")
>> +#endif
>>  int BPF_UPROBE(test1)
>>  {
>>         __u64 addr = bpf_get_func_ip(ctx);
>>
>> -       test1_result = (const void *) addr == (const void *)
>> uprobe_trigger_body + 1;
>> +       test1_result = (const void *) addr == (const void *)
>> uprobe_trigger_body + OFFSET;
>>         return 0;
>>  }
>>
>>
>> Anyway if you're doing a later version and want to roll something like
>> the above in feel free, otherwise I can send a followup patch later on.
>> Regardless, for the series on aarch64:
> 
> I'd preffer if you could send follow up for arm, because I have
> no easy way to test that change
>

sure, will do! thanks!

Alan

