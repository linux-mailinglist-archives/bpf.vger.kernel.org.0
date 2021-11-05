Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8E3445F21
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 05:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhKEE1y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 00:27:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10586 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231648AbhKEE1y (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Nov 2021 00:27:54 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A52lXvp024207;
        Thu, 4 Nov 2021 21:24:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=tGE7XVFHMpXUWw3xLHZhWHeiim92KeYRh+4kmhypa4k=;
 b=ey6KOZZc1KAonkgHeI7mszdHcTA+6gg8zb0flLS1XtKncNRkHkC8wzRon40Qc3pOGkou
 cJwPBS6Fdd3aZ1mMl7Tg4VUBkiZWCLU/89X9mzhOIawy75hFlWpG9x7d91kpMsgb9aTY
 VaYgQyuvCWs7prjlS9sWcAXEfl2+RQBWAP0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c4t7fh2fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 04 Nov 2021 21:24:50 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 4 Nov 2021 21:24:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGF/LgM3pP56H+XxDYbFr2JJPMBTklC8jf2AnPayZ447kQXEp+vHLQfxnKZnU1bXXye6hZfBiqF87XnpF+6646Fu9SXD4HsUatlyobkojV6ajPvv8LwAMDAyCWWgc4KTWt3HWALfH1EoGKZpQ1QXA3JzDesbl5IHtIRl9qyHAhaZWrxnW9iuTODA7jsoXgI+UUCniEMyDBTRkCVQAtlkBHQc9toGdJhhc3YWn9HWPmT3kFG3tND+4QDI7QOl8b5IJ3iYWZYr2v63q6oJhcRG2LJA4MoYtl/wPUMaGKARUJQ5ZoBz8QKEFIztOy9+JDFLafyA0eKgfT0DE5/Ek0oWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGE7XVFHMpXUWw3xLHZhWHeiim92KeYRh+4kmhypa4k=;
 b=gOmErOOOh/3Iwz37Q9fFD+4eoZVy09bRHogpwfxiDVM5U5FRgDwvXEwuJYZBzYkHuim+IVaYdj/oCfpIj6gey2LuV5c7eqZQYhdm8DfcxuJ+ooZf4IaAIX+WY0dYpCkGHZL+giVT6JgqAn3bHTQMGUBREtigmtLKRlAeokalCZfp/jRRWxBSimwS8JcGjRYAbVLQOJJqR9bAE71alKUsZ45+6HxHCzkDsE2moU4FweQildviU3xUIHXe8tZ/Nev6pm8iEqsfdkbVuq2k1aU154wIZulNuWRlNn4MxjR/TFcpMq5yOVlboSfW5IC4MMMDBJv6jy1XCwEQcucJLZoVuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2479.namprd15.prod.outlook.com (2603:10b6:805:17::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Fri, 5 Nov
 2021 04:24:47 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4669.011; Fri, 5 Nov 2021
 04:24:47 +0000
Message-ID: <63084c63-35b7-d584-ed83-b94c6ef5665d@fb.com>
Date:   Thu, 4 Nov 2021 21:24:44 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.0
Subject: Re: [PATCH bpf-next v5 2/2] selftests: bpf: test BPF_PROG_QUERY for
 progs attached to sockmap
Content-Language: en-US
To:     Di Zhu <zhudi2@huawei.com>, <davem@davemloft.net>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kafai@fb.com>, <songliubraving@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
        <jakub@cloudflare.com>
CC:     <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211105015730.1605333-1-zhudi2@huawei.com>
 <20211105015730.1605333-2-zhudi2@huawei.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211105015730.1605333-2-zhudi2@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0157.namprd04.prod.outlook.com
 (2603:10b6:303:85::12) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e1::14ee] (2620:10d:c090:400::5:bd86) by MW4PR04CA0157.namprd04.prod.outlook.com (2603:10b6:303:85::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Fri, 5 Nov 2021 04:24:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ae2cda2-8fff-498f-e9cd-08d9a0143386
X-MS-TrafficTypeDiagnostic: SN6PR15MB2479:
X-Microsoft-Antispam-PRVS: <SN6PR15MB24791E47199E21F85B31DAEDD38E9@SN6PR15MB2479.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: va1PnJlX/lk0ahEz2mdlP/bvbszp99A/u8YjYZSLyIA9vEWM34dhwBEsAkMfnHvl+jQ9nbP8cOWCPU6HPgKdm8ONtW/TtYzOmD4vHrBlLayqChwZCiLJZNAtjOijxKN7HYEdip5juGrP2BwUdvOq5snwl2btylnBA+PQ9ZXa7B9sSjx+GDWHH2zUpK+HKcLKRO0KimvvN1w5cctDOx2kceIO5xfcZs+ho7Ce6ny6Ew3wj+MetB259JMP9lgcgyRi+uyLHFp8de+E4dmj564ppR9IRSC3lHyz1A4uexgHAhhRCtTnAfDIJ6FemNfBwJKtQS9MegVm8lAtMaKDAT7WmNZWtVwwzHH59vwe98RxmcLyeD+lCe0E9xrN2rm9P98jSnlKd7xsIdXZqAsisqrymXBfEF+WmDipGRTCn5jwJSb9P2zD5mBugjXgCC/fFzwBHDsCfq7QHlrhFYXivC65pDPnt/wM4gcfp7VNLWoj0FzSmfrJh1zJ4fBtgbY7w33vLffUrtxr68B7Sm6x1AY/5KsgDmSGYWO5A5hVT2NiVLhgV+0UI8ek2kfdNdxJ9iGXr8A9mZbwAa/M2AvNzJ3h0pB086+/tpV7ecWqvckuxUwXpnyKDhIv8LPViEiMCk6yEAR6V1KqejDztKAstmNKJno0cTenZNr9PmqYT/k5ORb6BWcKDJ9pk+kpCaKwWZSGQPPfrhTnUqQkHCA4KuQzFALfdxZPvvIUqv+azBTLZfdKdZZeFEyuY/+3CLqU+4i/lEhhThwS5As2pePms4RxCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(66946007)(66476007)(66556008)(8936002)(2906002)(508600001)(86362001)(6486002)(8676002)(4326008)(52116002)(316002)(186003)(4744005)(5660300002)(7416002)(31696002)(53546011)(921005)(38100700002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azdZVFpjM3MveFptM0h1ZUZqOWRDOGRMakZFUUgrbUNOZytGT3ZpQnYyZjFo?=
 =?utf-8?B?aHB3UDM5a285blJzby9Ob0JuVmxVKzRZSDRMREZtSG9rdGQxV3A2Vlp1N1hO?=
 =?utf-8?B?aVRaZGNqa1BJQkplVGpSQjIrRTVWaGxvVVRHOWZCTDNwd0NkZnFsaUdSWFIz?=
 =?utf-8?B?Z1pSRml1eHBQUWZwYm55T3IzbTUyREZHQjNLYlFzT0o3V2lVV3c3SmVKN1dK?=
 =?utf-8?B?MEZhemN3ZVZBMTJucTgrTjVEOEhtQTlrWmlHUm9Qd0tKK0NjWk10aXoyMXg3?=
 =?utf-8?B?L2tlOUI0OXZkMytmUlNoV1pIQjBKYU81RzVhTnZ5UjlZQUZrT3R0VHVrN3pE?=
 =?utf-8?B?Sm9MQ1FsVVhHUnNNRzBnWDJkRmxIZ3luenY2bEVYV1pSMndnalJsMlJITU00?=
 =?utf-8?B?NThFc0lxdU92Mlp1TFRXSUpzMEN3dXVMd056V1dCUWZCM0labDlTeDJZeHpO?=
 =?utf-8?B?elR0SlNSYTJVTnEyek1VRGNOOG9kTjc3OTM5YmQ5bUZjUDhIcVEyTWRSaDFz?=
 =?utf-8?B?Vk1DdFI1ZTNhQ2JjQktFTXNGRnZtMXBIRnBvMkw5VlRySEVsL3FiYVZyUnY0?=
 =?utf-8?B?Y0lsNHJtQVFlUlZKdm9YdzRkUlQ0QXdyZk5Db1AxbzJUM2puMXJHSTk0MSsr?=
 =?utf-8?B?YUtzdy9XZ0Rsb2lQNXdGeEIyNVN0Y0svR0ZrNSsxMy9kbmJ3cDI5VytyZmxP?=
 =?utf-8?B?YkpWVlJxRTVnVjZlK2Mwc3FTTzBDNFdzRk00b1cyQXVNOWYyS3EvdVBIUkZK?=
 =?utf-8?B?cUVWbUpyN1AxcUlRc0ZCakhIdlduV1V4clVEVEFub25tS2ZSYmpEUXFvcjZ0?=
 =?utf-8?B?RGZoYVd1alhkdFdKcmJ4Vjh4algxV3YxSzlEUStwYXBKL2V2T1VmZGZuY2x3?=
 =?utf-8?B?cjJnd0tjaThwRGpwNHVxYktSdHV1MlJLVEVEaWhrUHRtbzdiWkpQcFBlcDhX?=
 =?utf-8?B?T0pPSHh2UVJxY0xpVmJEYWdTRnV5Q3lKRzdyQlBBVkpseWMrVWpBeW1KUitM?=
 =?utf-8?B?QU1UV2pKNjRHZFBUbWFrczZDK2NKZkhIQkJjN1h2Z0lMQ0hiR2NLdkRZTzdD?=
 =?utf-8?B?aE40b0toeHpHLzdPV1VvMDB6QVRjaEdkUVdKY0JrTWM1dEFXQ0dBb3JNOUZX?=
 =?utf-8?B?K1ZTbkh2QkxzWEl0aTJRWTlybXpjVVZSMXI4anlOR1FNeDVvTmREYTdIWkwr?=
 =?utf-8?B?NFJYU0lWc2xTczFDVXg4eVJCaE8reTgyV3ZsR0xqaHRzVVNsTVY2NE53ZWt2?=
 =?utf-8?B?b01CaWlzeXlTRW1iejJRaFJZTkR2NTNVcC9MbUZXODFKSldJUWluRkdiTjEv?=
 =?utf-8?B?OUNLYmRMYWpFcEFXVlljeksyQTQ3UmR2dTNMUHRLeDdtNEw4dWhhZHpHOTlI?=
 =?utf-8?B?czlmejZGRjRuMm5EdFExNmRQMWoxbWdVTWp3YUpDTW5QdEhrbTJBN251OG5S?=
 =?utf-8?B?dnZ6V0NwaDZmTURCM1N6WlZQUXZjNWp0NjRtUUFIY2tmeWpZK2FLNGxMZUxN?=
 =?utf-8?B?c2VBLytGempTZEJqUXFvdEdZZEtnRW5uR1FMVEUzYTg0VndLRHZkR1dZWjh2?=
 =?utf-8?B?RlVUSU9XNUU3d1JsZGkwT2s3N3gvQ2FQZzhoMXNFbzA3MjlNQVZrSHFvL1Y1?=
 =?utf-8?B?WHhhdW5odmFIN2NyczZRcS9MVU5DVDBKczkyT0o0TEVWSHFmaWxMc2ZmdlVH?=
 =?utf-8?B?RUxMTS9VVGpFWlhFZjM5aktPLzVSVms0S05YcEF4bk9sakE0ei9YcEQ0ZlRR?=
 =?utf-8?B?ZjFReHdMMk1wdnRUN2hveVRYODBsbkJIMWwzbzIxNXRzN0NtVFJQT0lXNGJn?=
 =?utf-8?B?OHhyQjJ1NTZBWUJpRlBFTWczd3RRL0lTM1JhRDVMa3N1SU92aklKeW5YSVFT?=
 =?utf-8?B?OUdvZC9CaSsxc1g3MVZ0V3Z1VG5qOXJVK1NDVlVpc1ZUS05SR2F0RVNXV3dv?=
 =?utf-8?B?NjNkN21zMzRXZW5YZ3dxbUM3RG1OYW1TWmNSbmcwNDFDS1dvYW1wWDR0NWlj?=
 =?utf-8?B?YWRPMzYrbFpOWlJtTXZCZXVoeHY4VDREcnV2YWh5M0I5ME42MGRSbDBjZ1VX?=
 =?utf-8?B?NEMzNVpOVlNzVGpVWG9iV0RadHgyOFBnMkw1akpwOVI5blZBVXZRaU5qQkdK?=
 =?utf-8?B?K2h6MEc1aU5QQ2k0cU00dUJyVytHOVVNbmVEcHRWdVF2QjVjQ2F3bUhzaExm?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae2cda2-8fff-498f-e9cd-08d9a0143386
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 04:24:47.5584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7ZyqcxMCg8HEOGjUu9L9H0gUP2e4b5yytOhl3phmB1P7sck+mo0bm78wjwobDI3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2479
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: OXZgxGT7T-7hG0oS46Q5YvceeBRg7snD
X-Proofpoint-GUID: OXZgxGT7T-7hG0oS46Q5YvceeBRg7snD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-05_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxlogscore=526 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111050023
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/4/21 6:57 PM, Di Zhu wrote:
> Add test for querying progs attached to sockmap. we use an existing
> libbpf query interface to query prog cnt before and after progs
> attaching to sockmap and check whether the queried prog id is right.
> 
> Signed-off-by: Di Zhu <zhudi2@huawei.com>

Acked-by: Yonghong Song <yhs@fb.com>
