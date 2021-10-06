Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23EB4249B5
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 00:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhJFWhH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 18:37:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11454 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229576AbhJFWhG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 6 Oct 2021 18:37:06 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196K2FZa031961
        for <bpf@vger.kernel.org>; Wed, 6 Oct 2021 15:35:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=a1ffjfsVa7WabzSrwNy9RTPGpT6NyqX1MdUZe7HZ/bc=;
 b=cjRZJs0jXAVBlKH/CjN7cTdYtKR/IJq9RCu9vmUZelLZRtIOYwssSg7nSrITtmG3H8r9
 NZeFbpSG2XOHqFBxDTX8agj+qQEPPdItdN6YITu+hCbPGpegAmCaCO/q8OaqBYN9fYal
 li7GtveotnVwrtVmTgvo7zOuLEQ0ETOkuHs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bhetfb0n0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 06 Oct 2021 15:35:14 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 6 Oct 2021 15:35:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Md3EKA6AfHlBYTjHzHJOeQ2lgyinezOOOagRj1/y8t9nJDiHtp6EL+ve0J/HN2tGT5ehWHFGNyMNMJgYtciKAOQaV9DcXDSmNnLkpUoVqmE4Q06kuFXTN/Q9WGlGfcZ87lfPMmYwucLZbU6C92ANC/AEijNpCB2Afd3hV9Ha/wCFEvFcWmKYlkXeYup/aCfZOhSnflRKP8Yn0/zVGrw4va8mUiiw6nExPX9dpI72lyqu6/YlmmSO9AHYYo5tYKGP1xqM5juur95NUXUL0BQCtKyVCq8+u4odlTp9MyKp+DAVCSs2qbD7FPxQc0Zy1JzZg0OyulUefkMrXtlKSXYTug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1ffjfsVa7WabzSrwNy9RTPGpT6NyqX1MdUZe7HZ/bc=;
 b=LIafrDmjxhjDc9jtiy9qTHPI8KoHbJF80CJjZVeAP2eNu3melBcZ11Mgob3AhZGmht8EVVi1U2jv1cvZ6hy5gCnxfw6JC/nakEZPI+roVctmTMEewLJPjzLvsj17VG6KVU5rC+rf731Pzc5eR0QzyD1ukPRkMZ8GgiixtFE+AbrTPK0mMHcVL3xevNa/4iKHQ3E20/qdXOCNj+H8sNtR9AgnEDaTkGf21QTbWWAB+1uA3sfIsQJ7/WGl5RejFmpUPXHz/7qcq4c1IGR9u3/b2h9pmVOGfjl3dMa3K3u7BjcqJ02goHQLgsk5Gwnh88qCsTHH2DEXQH2xT0y9Ujvw4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SN6PR15MB2398.namprd15.prod.outlook.com (2603:10b6:805:25::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.19; Wed, 6 Oct
 2021 22:35:11 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::85c6:f939:61cf:a55c]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::85c6:f939:61cf:a55c%7]) with mapi id 15.20.4566.023; Wed, 6 Oct 2021
 22:35:11 +0000
Message-ID: <9eb52022-2528-c2a8-62a8-25dfda4c0908@fb.com>
Date:   Wed, 6 Oct 2021 15:35:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH bpf-next v4 4/5] bpf/benchs: Add benchmark tests for bloom
 filter throughput + false positive
Content-Language: en-US
To:     <bpf@vger.kernel.org>
CC:     <Kernel-team@fb.com>
References: <20211006222103.3631981-1-joannekoong@fb.com>
 <20211006222103.3631981-5-joannekoong@fb.com>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <20211006222103.3631981-5-joannekoong@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0234.namprd04.prod.outlook.com
 (2603:10b6:303:87::29) To SA1PR15MB4465.namprd15.prod.outlook.com
 (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21cf::1fe8] (2620:10d:c090:400::5:cff0) by MW4PR04CA0234.namprd04.prod.outlook.com (2603:10b6:303:87::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend Transport; Wed, 6 Oct 2021 22:35:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1202f71-d267-4f0c-3f12-08d989198e9b
X-MS-TrafficTypeDiagnostic: SN6PR15MB2398:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR15MB2398968A65BB9C70305482A1D2B09@SN6PR15MB2398.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8CjYmlM1AWtjTfDZhDAjSEJnbUWMOHbjrdXnvW9+qzqlyt2/Bg8tmy4T7VzJLwQgFoNqt9TnTPC7hDF6CCuV8Fh6SRmN29WhB7eXWjTGzKe0H/QnKZa6nkZ5P5TuSrKqc9gHaGesxtZt2VBfJ8qcbonFlGJLLRRSIWSxSoXUcxwAPWwo7RzSXhB9p8x5GUwlteSUznm+3yV8p17X8uFfuCFK5OlYDABSbIFwzufglKu7GKFvpP/oL/nino3cdAD30TcQfyh9M+weLNyrPfNmXTYad+i6OzOPFSV/AhfUnto8PbtU6iuE3KIpcj266eCudJyL3iwJTABHiai23nhbgJcvogofWfVX8ppqejuMTwDLUoQ1zEF3G90QqJ8Ur3bgOvK5BHpYlw3T8FqRHptGIQ/9pOWcHxqZzlDg0+JDQ9i7czcMSkmWZQya1kXBYTBnF7gG6+vUOnqNp3cIPiQPA/kEcVSH7Vq9qhQ4UEjqCdnH5+vmFklzL1K8p3UBrNtGRGb1+wHlKJI9uTr+cYKzjIq6DDDsSgxv4L3N5nnhbd3be2Bdz+9YRcGXw68zas9MGcjUGZwR4XDoevB76YQFPNd1lZ6uNOmI1Nz9XkszFbX5PGUZjm2igNycYhvLjpCBQrjDwWS0/smlG6Yw7g+1jJCbqEYnfgILnOT4qP+mAN1WfWzK1ujkC7nYiFJplD4mtHfzXCpfMbOBqPjoLU775dduiovLMAF9xvRq6ggk30E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(8676002)(86362001)(38100700002)(2616005)(8936002)(36756003)(66946007)(2906002)(30864003)(4326008)(53546011)(508600001)(6916009)(66556008)(66476007)(5660300002)(186003)(31696002)(316002)(6486002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1ZVS29pL0JQOHVtVzlLVHYxcGRXZERWS0Z2cHFadW5vN2VjcmdXQmlkOWlI?=
 =?utf-8?B?eGJmRG51SzB6bFZ1cnpjMERvSGgxVkdvR1g3SlIzamQ4QTR4YlVubUtSZ3dw?=
 =?utf-8?B?V0dKclVYeTFoL09zL0kwelp3S1d5MVo0b0xNUWQ2NytyTy9IZ3VrSmdzb3RD?=
 =?utf-8?B?eS9NaFV1WUpCRnRic2hhdmtjY05iZHlvOXNzV3NIeFhnc3Q5SU9pRmhQdjJm?=
 =?utf-8?B?d3VkVjluZEthTjN1eUdKM3Yvb2pZNlE3Yk9zc1RuUEM1SGc2S2RJYXFZYUFs?=
 =?utf-8?B?YmgyYm4xTEdmWHhsaSszUkNaQmdqVTdFdEJsdW9uMmp0alNpdFNJNVBBSkdo?=
 =?utf-8?B?ZGkveHpDa2I1ajVpdmlNdTFxQTl3NEFJenRldVBxSDI3VXBSWFZzVTRrY2dQ?=
 =?utf-8?B?a3M1WWNEYndneWJQQlFTTlhhVzlKT3oxT0VlckZrRHRGUVVKNTNBTFc2WUUw?=
 =?utf-8?B?THg1YzdYWFVXUjdaWDN5OWNkdnVtejBPQ3RGbzVLTVQwZHpTTkVCdTJHRUpu?=
 =?utf-8?B?c1B2T25nVVlJelA4SFVXT0s1dnpyMnZnejJNYWFuMVJPWUF3dkowcW5jalNo?=
 =?utf-8?B?MVdidGl3N3EycGh5NWlBYksvTUlJVXBjelR2dG02NUQ3eW1xWWxHUTlLYlRV?=
 =?utf-8?B?WWh2M0ZQZXRXNVNYWWw3MGY4TDMvTXZ2d3o3eUhuYUpCRC9hems4Y2lyTEUx?=
 =?utf-8?B?L2c5T3BBVlVoYjZXMjZoR2VIU0pnODh5bkRzT1FJcU5ncU9YOWl0V0RXTFhJ?=
 =?utf-8?B?R0NPaHREUG1QbDFVNk83YUM1Y2JXc2hmeWVta0IvVC95MmUzbGdONXMwNXY5?=
 =?utf-8?B?WkgxT28yNExqcE1VdXBFOUJ3Uk5YNlArTGpONk5RTTdPVi8xSjYxZXJFbzNX?=
 =?utf-8?B?c2srUFAxd3p1QmRyYXB4Nld3Q2ltbVE4SUJmV3lNNTBNU3djUU9KWHpRQUZH?=
 =?utf-8?B?QVFEaXIrN0Zvb0cyc1AwMkZZaE5WenNYclV0bmd6aG9rbVlqdmJnUXFMRFBN?=
 =?utf-8?B?M0w2a3ZoL2RWMngrL1hHei9od0pyRFFWdCtUNkRUc0kxVmJTMDh0VGQyZW5i?=
 =?utf-8?B?bzcyaGRMV0paazkyOXdEaXNjS1I0dGJGNVhCOVdCSldkKzVJaWxrdEdLd3V6?=
 =?utf-8?B?c3JOVUw4NWpzb1VkZUpVL1V0WkFqSnVYTlVwOTlPeUVKR0hwbVN1Mk8relpi?=
 =?utf-8?B?djFSU0tpMFpHZXhtS2tlb2puNDVORTdUcEkxNmhtRDkwczA5VjBta0JPa3h1?=
 =?utf-8?B?eXUrQzlsbElVZC9Dd05icXIxZzgxNlF1NUU4VWpiTkZ0ci94VmZiZjlmQmVD?=
 =?utf-8?B?aW1teHAzYW53b0hxNkp6aEFGc3VxcjlYdnZFWkRQS1RVUUFPM0FjeWE3Qmh2?=
 =?utf-8?B?c2ZqYlpGdngzK1NLMG00aGU4UXR1alJINkpOZ3ZtQ3dkb05pUll3Mmd4Q3V4?=
 =?utf-8?B?cVltckRBQzJUa1ovOVBIVTI2N0pGc1Z4ZlNwN3pWNFFpaGNvNFRrL0tFZnBw?=
 =?utf-8?B?aHlaclNJcnlEL3ZsM0s3NnBtdDk1Q2pQSmg2RHYzRjZWMlJPLzVYeWFIMGRJ?=
 =?utf-8?B?MjFnaWVkN0FNWCt0U3NmVnkzeld2aE1zMnU4WmxEMGM1YmtjZjhvRWZJM3ZD?=
 =?utf-8?B?RWxFajRFYzMxejZPOWlqaUk2OXEyQzRMZEZUNVhPdzhHUXdqc01nSHZnVWtZ?=
 =?utf-8?B?QjVJYXhqSW1nR01EemlJdXpHclRpbmpYNzJRR254ekN3emNic2FhazRaQ1lL?=
 =?utf-8?B?UXNxSUJMbGhCVDdUblRiL3lKSlhUeHQrakJvdkJ0RklIYXRaUVJPWFZobm5F?=
 =?utf-8?B?aVhjNnVUU1R2WnJJMFptQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e1202f71-d267-4f0c-3f12-08d989198e9b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 22:35:11.6700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zri1u3rup7pDbuPaw+mrT8LbBTqc/n85Idl9Qmxg97dGknenLvxX3Xa8bActaxrAZYNkAH76/oqdd5S+asxxrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2398
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: mf6oipVWaUlw4qKQLVvAKIkvFoRDFfUz
X-Proofpoint-ORIG-GUID: mf6oipVWaUlw4qKQLVvAKIkvFoRDFfUz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060140
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/6/21 3:21 PM, Joanne Koong wrote:

> This patch adds benchmark tests for the throughput (for lookups + updates)
> and the false positive rate of bloom filter lookups, as well as some
> minor refactoring of the bash script for running the benchmarks.
>
> These benchmarks show that as the number of hash functions increases,
> the throughput and the false positive rate of the bloom filter decreases.
>  From the benchmark data, the approximate average false-positive rates for
> 8-byte values are roughly as follows:
>
> 1 hash function = ~30%
> 2 hash functions = ~15%
> 3 hash functions = ~5%
> 4 hash functions = ~2.5%
> 5 hash functions = ~1%
> 6 hash functions = ~0.5%
> 7 hash functions  = ~0.35%
> 8 hash functions = ~0.15%
> 9 hash functions = ~0.1%
> 10 hash functions = ~0%
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---
>   tools/testing/selftests/bpf/Makefile          |   6 +-
>   tools/testing/selftests/bpf/bench.c           |  37 ++
>   tools/testing/selftests/bpf/bench.h           |   3 +
>   .../bpf/benchs/bench_bloom_filter_map.c       | 411 ++++++++++++++++++
>   .../bpf/benchs/run_bench_bloom_filter_map.sh  |  28 ++
>   .../bpf/benchs/run_bench_ringbufs.sh          |  30 +-
>   .../selftests/bpf/benchs/run_common.sh        |  48 ++
>   tools/testing/selftests/bpf/bpf_util.h        |  11 +
>   .../selftests/bpf/progs/bloom_filter_bench.c  | 146 +++++++
>   9 files changed, 690 insertions(+), 30 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
>   create mode 100755 tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_map.sh
>   create mode 100644 tools/testing/selftests/bpf/benchs/run_common.sh
>   create mode 100644 tools/testing/selftests/bpf/progs/bloom_filter_bench.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index c5c9a9f50d8d..66e1ad17acef 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -517,18 +517,20 @@ $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
>   # Benchmark runner
>   $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
>   	$(call msg,CC,,$@)
> -	$(Q)$(CC) $(CFLAGS) -c $(filter %.c,$^) $(LDLIBS) -o $@
> +	$(Q)$(CC) $(CFLAGS) -O2 -c $(filter %.c,$^) $(LDLIBS) -o $@
>   $(OUTPUT)/bench_rename.o: $(OUTPUT)/test_overhead.skel.h
>   $(OUTPUT)/bench_trigger.o: $(OUTPUT)/trigger_bench.skel.h
>   $(OUTPUT)/bench_ringbufs.o: $(OUTPUT)/ringbuf_bench.skel.h \
>   			    $(OUTPUT)/perfbuf_bench.skel.h
> +$(OUTPUT)/bench_bloom_filter_map.o: $(OUTPUT)/bloom_filter_bench.skel.h
>   $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
>   $(OUTPUT)/bench: LDLIBS += -lm
>   $(OUTPUT)/bench: $(OUTPUT)/bench.o $(OUTPUT)/testing_helpers.o \
>   		 $(OUTPUT)/bench_count.o \
>   		 $(OUTPUT)/bench_rename.o \
>   		 $(OUTPUT)/bench_trigger.o \
> -		 $(OUTPUT)/bench_ringbufs.o
> +		 $(OUTPUT)/bench_ringbufs.o \
> +		 $(OUTPUT)/bench_bloom_filter_map.o
>   	$(call msg,BINARY,,$@)
>   	$(Q)$(CC) $(LDFLAGS) -o $@ $(filter %.a %.o,$^) $(LDLIBS)
>   
> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
> index 6ea15b93a2f8..e836bacd6f9d 100644
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -51,6 +51,35 @@ void setup_libbpf()
>   		fprintf(stderr, "failed to increase RLIMIT_MEMLOCK: %d", err);
>   }
>   
> +void false_hits_report_progress(int iter, struct bench_res *res, long delta_ns)
> +{
> +	long total = res->false_hits  + res->hits + res->drops;
> +
> +	printf("Iter %3d (%7.3lfus): ",
> +	       iter, (delta_ns - 1000000000) / 1000.0);
> +
> +	printf("%ld false hits of %ld total operations. Percentage = %2.2f %%\n",
> +	       res->false_hits, total, ((float)res->false_hits / total) * 100);
> +}
> +
> +void false_hits_report_final(struct bench_res res[], int res_cnt)
> +{
> +	long total_hits = 0, total_drops = 0, total_false_hits = 0, total_ops = 0;
> +	int i;
> +
> +	for (i = 0; i < res_cnt; i++) {
> +		total_hits += res[i].hits;
> +		total_false_hits += res[i].false_hits;
> +		total_drops += res[i].drops;
> +	}
> +	total_ops = total_hits + total_false_hits + total_drops;
> +
> +	printf("Summary: %ld false hits of %ld total operations. ",
> +	       total_false_hits, total_ops);
> +	printf("Percentage =  %2.2f %%\n",
> +	       ((float)total_false_hits / total_ops) * 100);
> +}
> +
>   void hits_drops_report_progress(int iter, struct bench_res *res, long delta_ns)
>   {
>   	double hits_per_sec, drops_per_sec;
> @@ -132,9 +161,11 @@ static const struct argp_option opts[] = {
>   };
>   
>   extern struct argp bench_ringbufs_argp;
> +extern struct argp bench_bloom_filter_map_argp;
>   
>   static const struct argp_child bench_parsers[] = {
>   	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
> +	{ &bench_bloom_filter_map_argp, 0, "Bloom filter map benchmark", 0 },
>   	{},
>   };
>   
> @@ -323,6 +354,9 @@ extern const struct bench bench_rb_libbpf;
>   extern const struct bench bench_rb_custom;
>   extern const struct bench bench_pb_libbpf;
>   extern const struct bench bench_pb_custom;
> +extern const struct bench bench_bloom_filter_lookup;
> +extern const struct bench bench_bloom_filter_update;
> +extern const struct bench bench_bloom_filter_false_positive;
>   
>   static const struct bench *benchs[] = {
>   	&bench_count_global,
> @@ -344,6 +378,9 @@ static const struct bench *benchs[] = {
>   	&bench_rb_custom,
>   	&bench_pb_libbpf,
>   	&bench_pb_custom,
> +	&bench_bloom_filter_lookup,
> +	&bench_bloom_filter_update,
> +	&bench_bloom_filter_false_positive,
>   };
>   
>   static void setup_benchmark()
> diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/bpf/bench.h
> index c1f48a473b02..624c6b11501f 100644
> --- a/tools/testing/selftests/bpf/bench.h
> +++ b/tools/testing/selftests/bpf/bench.h
> @@ -33,6 +33,7 @@ struct env {
>   struct bench_res {
>   	long hits;
>   	long drops;
> +	long false_hits;
>   };
>   
>   struct bench {
> @@ -56,6 +57,8 @@ extern const struct bench *bench;
>   void setup_libbpf();
>   void hits_drops_report_progress(int iter, struct bench_res *res, long delta_ns);
>   void hits_drops_report_final(struct bench_res res[], int res_cnt);
> +void false_hits_report_progress(int iter, struct bench_res *res, long delta_ns);
> +void false_hits_report_final(struct bench_res res[], int res_cnt);
>   
>   static inline __u64 get_time_ns() {
>   	struct timespec t;
> diff --git a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
> new file mode 100644
> index 000000000000..25d6b8179c8e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
> @@ -0,0 +1,411 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Facebook */
> +
> +#include <argp.h>
> +#include <linux/log2.h>
> +#include <pthread.h>
> +#include "bench.h"
> +#include "bloom_filter_bench.skel.h"
> +#include "bpf_util.h"
> +
> +static struct ctx {
> +	struct bloom_filter_bench *skel;
> +
> +	int bloom_filter_fd;
> +	int hashmap_fd;
> +	int array_map_fd;
> +
> +	pthread_mutex_t map_done_mtx;
> +	pthread_cond_t map_done;
> +	bool map_prepare_err;
> +
> +	__u32 next_map_idx;
> +
> +} ctx = {
> +	.map_done_mtx = PTHREAD_MUTEX_INITIALIZER,
> +	.map_done = PTHREAD_COND_INITIALIZER,
> +};
> +
> +struct stat {
> +	__u32 stats[3];
> +};
> +
> +static struct {
> +	__u32 nr_entries;
> +	__u8 nr_hash_funcs;
> +	__u32 value_size;
> +} args = {
> +	.nr_entries = 1000,
> +	.nr_hash_funcs = 3,
> +	.value_size = 8,
> +};
> +
> +enum {
> +	ARG_NR_ENTRIES = 3000,
> +	ARG_NR_HASH_FUNCS = 3001,
> +	ARG_VALUE_SIZE = 3002,
> +};
> +
> +static const struct argp_option opts[] = {
> +	{ "nr_entries", ARG_NR_ENTRIES, "NR_ENTRIES", 0,
> +		"Set number of expected unique entries in the bloom filter"},
> +	{ "nr_hash_funcs", ARG_NR_HASH_FUNCS, "NR_HASH_FUNCS", 0,
> +		"Set number of hash functions in the bloom filter"},
> +	{ "value_size", ARG_VALUE_SIZE, "VALUE_SIZE", 0,
> +		"Set value size (in bytes) of bloom filter entries"},
> +	{},
> +};
> +
> +static error_t parse_arg(int key, char *arg, struct argp_state *state)
> +{
> +	switch (key) {
> +	case ARG_NR_ENTRIES:
> +		args.nr_entries = strtol(arg, NULL, 10);
> +		if (args.nr_entries == 0) {
> +			fprintf(stderr, "Invalid nr_entries count.");
> +			argp_usage(state);
> +		}
> +		break;
> +	case ARG_NR_HASH_FUNCS:
> +		args.nr_hash_funcs = strtol(arg, NULL, 10);
> +		if (args.nr_hash_funcs == 0 || args.nr_hash_funcs > 15) {
> +			fprintf(stderr,
> +				"The bloom filter must use 1 to 15 hash functions.");
> +			argp_usage(state);
> +		}
> +		break;
> +	case ARG_VALUE_SIZE:
> +		args.value_size = strtol(arg, NULL, 10);
> +		if (args.value_size < 2 || args.value_size > 256) {
> +			fprintf(stderr,
> +				"Invalid value size. Must be between 2 and 256 bytes");
> +			argp_usage(state);
> +		}
> +		break;
> +	default:
> +		return ARGP_ERR_UNKNOWN;
> +	}
> +
> +	return 0;
> +}
> +
> +/* exported into benchmark runner */
> +const struct argp bench_bloom_filter_map_argp = {
> +	.options = opts,
> +	.parser = parse_arg,
> +};
> +
> +static void validate(void)
> +{
> +	if (env.consumer_cnt != 1) {
> +		fprintf(stderr,
> +			"The bloom filter benchmarks do not support multi-consumer use\n");
> +		exit(1);
> +	}
> +}
> +
> +static inline void trigger_bpf_program(void)
> +{
> +	syscall(__NR_getpgid);
> +}
> +
> +static void *producer(void *input)
> +{
> +	while (true)
> +		trigger_bpf_program();
> +
> +	return NULL;
> +}
> +
> +static void *map_prepare_thread(void *arg)
> +{
> +	__u32 val_size, i;
> +	void *val = NULL;
> +	int err;
> +
> +	val_size = args.value_size;
> +	val = malloc(val_size);
> +	if (!val) {
> +		ctx.map_prepare_err = true;
> +		goto done;
> +	}
> +
> +	while (true) {
> +		i = __atomic_add_fetch(&ctx.next_map_idx, 1, __ATOMIC_RELAXED);
> +		if (i > args.nr_entries)
> +			break;
> +
> +again:
> +		/* Populate hashmap, bloom filter map, and array map with the same
> +		 * random values
> +		 */
> +		err = syscall(__NR_getrandom, val, val_size, 0);
> +		if (err != val_size) {
> +			ctx.map_prepare_err = true;
> +			fprintf(stderr, "failed to get random value: %d\n", -errno);
> +			break;
> +		}
> +
> +		err = bpf_map_update_elem(ctx.hashmap_fd, val, val, BPF_NOEXIST);
> +		if (err) {
> +			if (err != -EEXIST) {
> +				ctx.map_prepare_err = true;
> +				fprintf(stderr, "failed to add elem to hashmap: %d\n",
> +					-errno);
> +				break;
> +			}
> +			goto again;
> +		}
> +
> +		i--;
> +
> +		err = bpf_map_update_elem(ctx.array_map_fd, &i, val, 0);
> +		if (err) {
> +			ctx.map_prepare_err = true;
> +			fprintf(stderr, "failed to add elem to array map: %d\n", -errno);
> +			break;
> +		}
> +
> +		err = bpf_map_update_elem(ctx.bloom_filter_fd, NULL, val, 0);
> +		if (err) {
> +			ctx.map_prepare_err = true;
> +			fprintf(stderr,
> +				"failed to add elem to bloom filter map: %d\n", -errno);
> +			break;
> +		}
> +	}
> +done:
> +	pthread_mutex_lock(&ctx.map_done_mtx);
> +	pthread_cond_signal(&ctx.map_done);
> +	pthread_mutex_unlock(&ctx.map_done_mtx);
> +
> +	if (val)
> +		free(val);
> +
> +	return NULL;
> +}
> +
> +static void populate_maps(void)
> +{
> +	unsigned int nr_cpus = bpf_num_possible_cpus();
> +	pthread_t map_thread;
> +	int i, err;
> +
> +	ctx.bloom_filter_fd = bpf_map__fd(ctx.skel->maps.bloom_filter_map);
> +	ctx.hashmap_fd = bpf_map__fd(ctx.skel->maps.hashmap);
> +	ctx.array_map_fd = bpf_map__fd(ctx.skel->maps.array_map);
> +
> +	for (i = 0; i < nr_cpus; i++) {
> +		err = pthread_create(&map_thread, NULL, map_prepare_thread,
> +				     NULL);
> +		if (err) {
> +			fprintf(stderr, "failed to create pthread: %d\n", -errno);
> +			exit(1);
> +		}
> +	}
> +
> +	pthread_mutex_lock(&ctx.map_done_mtx);
> +	pthread_cond_wait(&ctx.map_done, &ctx.map_done_mtx);
> +	pthread_mutex_unlock(&ctx.map_done_mtx);
> +
> +	if (ctx.map_prepare_err)
> +		exit(1);
> +}
> +
> +static struct bloom_filter_bench *setup_skeleton(bool hashmap_use_bloom_filter)
> +{
> +	struct bloom_filter_bench *skel;
> +	int err;
> +
> +	setup_libbpf();
> +
> +	skel = bloom_filter_bench__open();
> +	if (!skel) {
> +		fprintf(stderr, "failed to open skeleton\n");
> +		exit(1);
> +	}
> +
> +	skel->rodata->hashmap_use_bloom_filter = hashmap_use_bloom_filter;
> +
> +	/* Resize number of entries */
> +	err = bpf_map__resize(skel->maps.hashmap, args.nr_entries);
> +	if (err) {
> +		fprintf(stderr, "failed to resize hashmap\n");
> +		exit(1);
> +	}
> +
> +	err = bpf_map__resize(skel->maps.array_map, args.nr_entries);
> +	if (err) {
> +		fprintf(stderr, "failed to resize array map\n");
> +		exit(1);
> +	}
> +
> +	err = bpf_map__resize(skel->maps.bloom_filter_map,
> +			      BPF_BLOOM_FILTER_BITSET_SZ(args.nr_entries,
> +							 args.nr_hash_funcs));
> +	if (err) {
> +		fprintf(stderr, "failed to resize bloom filter\n");
> +		exit(1);
> +	}
> +
> +	/* Set value size */
> +	err = bpf_map__set_value_size(skel->maps.array_map, args.value_size);
> +	if (err) {
> +		fprintf(stderr, "failed to set array map value size\n");
> +		exit(1);
> +	}
> +
> +	err = bpf_map__set_value_size(skel->maps.bloom_filter_map, args.value_size);
> +	if (err) {
> +		fprintf(stderr, "failed to set bloom filter map value size\n");
> +		exit(1);
> +	}
> +
> +	err = bpf_map__set_value_size(skel->maps.hashmap, args.value_size);
> +	if (err) {
> +		fprintf(stderr, "failed to set hashmap value size\n");
> +		exit(1);
> +	}
> +	/* For the hashmap, we use the value as the key as well */
> +	err = bpf_map__set_key_size(skel->maps.hashmap, args.value_size);
> +	if (err) {
> +		fprintf(stderr, "failed to set hashmap value size\n");
> +		exit(1);
> +	}
> +
> +	skel->bss->value_sz_nr_u32s = (args.value_size + sizeof(__u32) - 1)
> +		/ sizeof(__u32);
> +
> +	/* Set number of hash functions */
> +	err = bpf_map__set_map_extra(skel->maps.bloom_filter_map,
> +				     args.nr_hash_funcs);
> +	if (err) {
> +		fprintf(stderr, "failed to set bloom filter nr_hash_funcs\n");
> +		exit(1);
> +	}
> +
> +	if (bloom_filter_bench__load(skel)) {
> +		fprintf(stderr, "failed to load skeleton\n");
> +		exit(1);
> +	}
> +
> +	return skel;
> +}
> +
> +static void bench_setup_lookup(void)
> +{
> +	struct bpf_link *link;
> +
> +	ctx.skel = setup_skeleton(true);
> +
> +	populate_maps();
> +
> +	link = bpf_program__attach(ctx.skel->progs.prog_bloom_filter_lookup);
> +	if (!link) {
> +		fprintf(stderr, "failed to attach program!\n");
> +		exit(1);
> +	}
> +}
> +
> +static void bench_setup_update(void)
> +{
> +	struct bpf_link *link;
> +
> +	ctx.skel = setup_skeleton(true);
> +
> +	populate_maps();
> +
> +	link = bpf_program__attach(ctx.skel->progs.prog_bloom_filter_update);
> +	if (!link) {
> +		fprintf(stderr, "failed to attach program!\n");
> +		exit(1);
> +	}
> +}
> +
> +static void hashmap_lookup_setup(void)
> +{
> +	struct bpf_link *link;
> +
> +	ctx.skel = setup_skeleton(true);
> +
> +	populate_maps();
> +
> +	link = bpf_program__attach(ctx.skel->progs.prog_bloom_filter_hashmap_lookup);
> +	if (!link) {
> +		fprintf(stderr, "failed to attach program!\n");
> +		exit(1);
> +	}
> +}
> +
> +static void measure(struct bench_res *res)
> +{
> +	long total_hits = 0, total_drops = 0, total_false_hits = 0;
> +	static long last_hits, last_drops, last_false_hits;
> +	unsigned int nr_cpus = bpf_num_possible_cpus();
> +	int hit_key, drop_key, false_hit_key;
> +	int i;
> +
> +	hit_key = ctx.skel->rodata->hit_key;
> +	drop_key = ctx.skel->rodata->drop_key;
> +	false_hit_key = ctx.skel->rodata->false_hit_key;
> +
> +	if (ctx.skel->bss->error != 0) {
> +		fprintf(stderr, "error (%d) when searching the bitset\n",
> +			ctx.skel->bss->error);
> +		exit(1);
> +	}
> +
> +	for (i = 0; i < nr_cpus; i++) {
> +		struct stat *s = (void *)&ctx.skel->bss->percpu_stats[i];
> +
> +		total_hits += s->stats[hit_key];
> +		total_drops += s->stats[drop_key];
> +		total_false_hits += s->stats[false_hit_key];
> +	}
> +
> +	res->hits = total_hits - last_hits;
> +	res->drops = total_drops - last_drops;
> +	res->false_hits = total_false_hits - last_false_hits;
> +
> +	last_hits = total_hits;
> +	last_drops = total_drops;
> +	last_false_hits = total_false_hits;
> +}
> +
> +static void *consumer(void *input)
> +{
> +	return NULL;
> +}
> +
> +const struct bench bench_bloom_filter_lookup = {
> +	.name = "bloom-filter-lookup",
> +	.validate = validate,
> +	.setup = bench_setup_lookup,
> +	.producer_thread = producer,
> +	.consumer_thread = consumer,
> +	.measure = measure,
> +	.report_progress = hits_drops_report_progress,
> +	.report_final = hits_drops_report_final,
> +};
> +
> +const struct bench bench_bloom_filter_update = {
> +	.name = "bloom-filter-update",
> +	.validate = validate,
> +	.setup = bench_setup_update,
> +	.producer_thread = producer,
> +	.consumer_thread = consumer,
> +	.measure = measure,
> +	.report_progress = hits_drops_report_progress,
> +	.report_final = hits_drops_report_final,
> +};
> +
> +const struct bench bench_bloom_filter_false_positive = {
> +	.name = "bloom-filter-false-positive",
> +	.validate = validate,
> +	.setup = hashmap_lookup_setup,
> +	.producer_thread = producer,
> +	.consumer_thread = consumer,
> +	.measure = measure,
> +	.report_progress = false_hits_report_progress,
> +	.report_final = false_hits_report_final,
> +};
> diff --git a/tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_map.sh b/tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_map.sh
> new file mode 100755
> index 000000000000..5d4f84ad9973
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/run_bench_bloom_filter_map.sh
> @@ -0,0 +1,28 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +source ./benchs/run_common.sh
> +
> +set -eufo pipefail
> +
> +header "Bitset map"
> +for v in 2, 4, 8, 16, 40; do
> +for t in 1 4 8 12 16; do
> +for h in {1..10}; do
> +subtitle "value_size: $v bytes, # threads: $t, # hashes: $h"
> +	for e in 10000 50000 75000 100000 250000 500000 750000 1000000 2500000 5000000; do
> +		printf "%'d entries -\n" $e
> +		printf "\t"
> +		summarize "Lookups, total operations: " \
> +			"$($RUN_BENCH -p $t --nr_hash_funcs $h --nr_entries $e --value_size $v bloom-filter-lookup)"
> +		printf "\t"
> +		summarize "Updates, total operations: " \
> +			"$($RUN_BENCH -p $t --nr_hash_funcs $h --nr_entries $e --value_size $v bloom-filter-update)"
> +		printf "\t"
> +		summarize_percentage "False positive rate: " \
> +			"$($RUN_BENCH -p $t --nr_hash_funcs $h --nr_entries $e --value_size $v bloom-filter-false-positive)"
> +	done
> +	printf "\n"
> +done
> +done
> +done
> diff --git a/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh b/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
> index af4aa04caba6..ada028aa9007 100755
> --- a/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
> +++ b/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
> @@ -1,34 +1,8 @@
>   #!/bin/bash
>   
> -set -eufo pipefail
> -
> -RUN_BENCH="sudo ./bench -w3 -d10 -a"
> -
> -function hits()
> -{
> -	echo "$*" | sed -E "s/.*hits\s+([0-9]+\.[0-9]+ ± [0-9]+\.[0-9]+M\/s).*/\1/"
> -}
> -
> -function drops()
> -{
> -	echo "$*" | sed -E "s/.*drops\s+([0-9]+\.[0-9]+ ± [0-9]+\.[0-9]+M\/s).*/\1/"
> -}
> +source ./benchs/run_common.sh
>   
> -function header()
> -{
> -	local len=${#1}
> -
> -	printf "\n%s\n" "$1"
> -	for i in $(seq 1 $len); do printf '='; done
> -	printf '\n'
> -}
> -
> -function summarize()
> -{
> -	bench="$1"
> -	summary=$(echo $2 | tail -n1)
> -	printf "%-20s %s (drops %s)\n" "$bench" "$(hits $summary)" "$(drops $summary)"
> -}
> +set -eufo pipefail
>   
>   header "Single-producer, parallel producer"
>   for b in rb-libbpf rb-custom pb-libbpf pb-custom; do
> diff --git a/tools/testing/selftests/bpf/benchs/run_common.sh b/tools/testing/selftests/bpf/benchs/run_common.sh
> new file mode 100644
> index 000000000000..670f23b037c4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/run_common.sh
> @@ -0,0 +1,48 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +RUN_BENCH="sudo ./bench -w3 -d10 -a"
> +
> +function header()
> +{
> +	local len=${#1}
> +
> +	printf "\n%s\n" "$1"
> +	for i in $(seq 1 $len); do printf '='; done
> +	printf '\n'
> +}
> +
> +function subtitle()
> +{
> +	local len=${#1}
> +	printf "\t%s\n" "$1"
> +}
> +
> +function hits()
> +{
> +	echo "$*" | sed -E "s/.*hits\s+([0-9]+\.[0-9]+ ± [0-9]+\.[0-9]+M\/s).*/\1/"
> +}
> +
> +function drops()
> +{
> +	echo "$*" | sed -E "s/.*drops\s+([0-9]+\.[0-9]+ ± [0-9]+\.[0-9]+M\/s).*/\1/"
> +}
> +
> +function percentage()
> +{
> +	echo "$*" | sed -E "s/.*Percentage\s=\s+([0-9]+\.[0-9]+).*/\1/"
> +}
> +
> +function summarize()
> +{
> +	bench="$1"
> +	summary=$(echo $2 | tail -n1)
> +	printf "%-20s %s (drops %s)\n" "$bench" "$(hits $summary)" "$(drops $summary)"
> +}
> +
> +function summarize_percentage()
> +{
> +	bench="$1"
> +	summary=$(echo $2 | tail -n1)
> +	printf "%-20s %s%%\n" "$bench" "$(percentage $summary)"
> +}
> diff --git a/tools/testing/selftests/bpf/bpf_util.h b/tools/testing/selftests/bpf/bpf_util.h
> index a3352a64c067..a260a963efda 100644
> --- a/tools/testing/selftests/bpf/bpf_util.h
> +++ b/tools/testing/selftests/bpf/bpf_util.h
> @@ -40,4 +40,15 @@ static inline unsigned int bpf_num_possible_cpus(void)
>   	(offsetof(TYPE, MEMBER)	+ sizeof_field(TYPE, MEMBER))
>   #endif
>   
> +/* Helper macro for computing the optimal number of bits for a
> + * bloom filter map.
> + *
> + * Mathematically, the optimal bitset size that minimizes the
> + * false positive probability is n * k / ln(2) where n is the expected
> + * number of unique entries in the bloom filter and k is the number of
> + * hash functions. We use 7 / 5 to approximate 1 / ln(2).
> + */
> +#define BPF_BLOOM_FILTER_BITSET_SZ(nr_uniq_entries, nr_hash_funcs) \
> +	((nr_uniq_entries) * (nr_hash_funcs) / 5 * 7)
> +
>   #endif /* __BPF_UTIL__ */
> diff --git a/tools/testing/selftests/bpf/progs/bloom_filter_bench.c b/tools/testing/selftests/bpf/progs/bloom_filter_bench.c
> new file mode 100644
> index 000000000000..a44a47ddc4d7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bloom_filter_bench.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Facebook */
> +
> +#include <errno.h>
> +#include <linux/bpf.h>
> +#include <stdbool.h>
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct bpf_map;
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(key_size, sizeof(__u32));
> +	/* max entries and value_size will be set programmatically.
> +	 * They are configurable from the userspace bench program.
> +	 */
> +} array_map SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_BITSET);
> +	/* max entries,  value_size, and # of hash functions will be set
> +	 * programmatically. They are configurable from the userspace
> +	 * bench program.
> +	 */
> +} bloom_filter_map SEC(".maps");
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	/* max entries, key_size, and value_size, will be set
> +	 * programmatically. They are configurable from the userspace
> +	 * bench program.
> +	 */
> +} hashmap SEC(".maps");
> +
> +struct callback_ctx {
> +	struct bpf_map *map;
> +	bool update;
> +};
> +
> +/* Tracks the number of hits, drops, and false hits */
> +struct {
> +	__u32 stats[3];
> +} __attribute__((__aligned__(256))) percpu_stats[256];
> +
> +__u8 value_sz_nr_u32s;
> +
> +const __u32 hit_key  = 0;
> +const __u32 drop_key  = 1;
> +const __u32 false_hit_key = 2;
> +
> +const volatile bool hashmap_use_bloom_filter = true;
> +
> +int error = 0;
> +
> +static __always_inline void log_result(__u32 key)
> +{
> +	__u32 cpu = bpf_get_smp_processor_id();
> +
> +	percpu_stats[cpu & 255].stats[key]++;
> +}
> +
> +static __u64
> +bloom_filter_callback(struct bpf_map *map, __u32 *key, void *val,
> +		      struct callback_ctx *data)
> +{
> +	int err;
> +
> +	if (data->update)
> +		err = bpf_map_push_elem(data->map, val, 0);
> +	else
> +		err = bpf_map_peek_elem(data->map, val);
> +
> +	if (err) {
> +		error |= 1;
> +		return 1; /* stop the iteration */
> +	}
> +
> +	log_result(hit_key);
> +
> +	return 0;
> +}
> +
> +SEC("fentry/__x64_sys_getpgid")
> +int prog_bloom_filter_lookup(void *ctx)
> +{
> +	struct callback_ctx data;
> +
> +	data.map = (struct bpf_map *)&bloom_filter_map;
> +	data.update = false;
> +
> +	bpf_for_each_map_elem(&array_map, bloom_filter_callback, &data, 0);
> +
> +	return 0;
> +}
> +
> +SEC("fentry/__x64_sys_getpgid")
> +int prog_bloom_filter_update(void *ctx)
> +{
> +	struct callback_ctx data;
> +
> +	data.map = (struct bpf_map *)&bloom_filter_map;
> +	data.update = true;
> +
> +	bpf_for_each_map_elem(&array_map, bloom_filter_callback, &data, 0);
> +
> +	return 0;
> +}
> +
> +SEC("fentry/__x64_sys_getpgid")
> +int prog_bloom_filter_hashmap_lookup(void *ctx)
> +{
> +	__u64 *result;
> +	int i, j, err;
> +
> +	__u32 val[64] = {0};
> +
> +	for (i = 0; i < 1024; i++) {
> +		for (j = 0; j < value_sz_nr_u32s && j < 64; j++)
> +			val[j] = bpf_get_prandom_u32();
> +
I tried out prepopulating these random values from the userspace side
(where we generate a random sequence of 10000 bytes and put that
in a bpf array map, then iterate through the bpf array map in the bpf
program; when I tried implementing it using a global array, I saw
verifier errors when indexing into the array).

However, this runs into issues where we do not know ahead of time
how many random bytes will be needed (eg on a local qemu server, 1 million
may be enough whereas on other servers, 1 million is too little and
results in benchmark stats that show there is no discernible difference
with vs. without the bloom filter).

Additionally, this slows down the bench program as well, since we need
to generate all of these random values in the setup() portion of the 
program.
I'm not convinced that prepopulating the values ahead of time nets us
anything - if the concern is that this slows down the bpf program,
I think this slows down the program in both the hashmap with and without
bloom filter cases; since we are mainly only interested in the delta between
these two scenarios, I don't think this ends up mattering that much.

> +		if (hashmap_use_bloom_filter) {
> +			err = bpf_map_peek_elem(&bloom_filter_map, val);
> +			if (err) {
> +				if (err != -ENOENT) {
> +					error |= 3;
> +					return 0;
> +				}
> +				log_result(hit_key);
> +				continue;
> +			}
> +		}
> +
> +		result = bpf_map_lookup_elem(&hashmap, val);
> +		if (result) {
> +			log_result(hit_key);
> +		} else {
> +			if (hashmap_use_bloom_filter)
> +				log_result(false_hit_key);
> +			log_result(drop_key);
> +		}
> +	}
> +
> +	return 0;
> +}
