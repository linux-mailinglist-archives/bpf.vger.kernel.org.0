Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E23E64F21B
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 21:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiLPUFw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 15:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbiLPUFu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 15:05:50 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA5CA452
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 12:05:49 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BGJxCkr024532;
        Fri, 16 Dec 2022 12:05:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=WW+yz+xK7ZK++KW7GLEnQv3zPkDcFmoQ7XlygHPboQE=;
 b=T/kHcqUb7/u+Ou8A4Z4QJcQKOpI3fe+6abQPJ+uKPD3gMlxnKY1lxCN6vkVO5LDaAQlE
 2rktSRZANGvHSSFOvKnJN6DK8e3atM95rGTIXVV6WuCpEO9Xy/s0+oBciAJ3SkCwNvXR
 6T8yr8c54Qn8ijN/4qa1n0ZxdirrTFUVMjtbWhzj/DmGzrietJD0R5zglBVrBZnbusIi
 9v/9hkT6BCssisZ53hk7CpcegkPUeFfEEVS7SsFqqzklVLyMpe4M6XjOxBiU2DlAPOmB
 Z+mmPau934FK2ahjciZF4t//KUN4AECGGWuurqOWDD2L+SHvE+JscPzlDVvMdtkcmU/t tw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mgwvu0sjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 12:05:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LESx0f3ydfdFjhfNC8BiTrZCdewSG15argLSng85jHc5ukeJ5d25g7TcSlAnVGUGInPKLAkPRTzsiEj0J7iGoExwmFb0wbLduNsmPXcXQKLtngpGKpODL/B/ktzGTnH2TgwQQOp33r3BgZBiVD/FgnX4T6cnMLJ2C/7iYaV+0WZkhvpEhLkcmVfE5tVu4j0jKc1KWOjdvcfG0cASHkgs7a0ZyQ0Cye2t69d6c0sG/SKxoRKGQBpPUnR1Kphcrlv6fVczhtQVkPWCf/BTTBQf9QZ19uRR+M6c4CKzHxz7v5F5YMKUBj9BrDXfIvijuvXYSHrUq/e33sXRR9CwQ1glCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WW+yz+xK7ZK++KW7GLEnQv3zPkDcFmoQ7XlygHPboQE=;
 b=AHADoO0yhEQrb1rTs8Gckr5EDhs8Uz+lhJHchPsa/QE8yJ93pWG9nwxwjhW9pnLDJAOpbTD6BvUFCg+AsLGDgvBnmBmYuwxWPHcx/stYtCMW58G83R+cZ7sSKzcYyIyGmwCxzDgo6hviOapdHMAtGKWvxgLugHqFZdLsGgZVwHgjokKmapMhKrbTD499kbd78AQPhGcEsnT4EnNMRdKOo2g4BgZsUHcQAb1G0z0ehhPdg6qpLLK7yeanfcv+b8uH1LnUptlJrZveLckZjmrldGC6F55jpZQgozhXabcfqErgaOjI7GJK/di55/YJiYsO4LifpnxuoNnmcUjFh4muBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB5824.namprd15.prod.outlook.com (2603:10b6:a03:4e7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11; Fri, 16 Dec
 2022 20:05:39 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.015; Fri, 16 Dec 2022
 20:05:39 +0000
Message-ID: <aea7a3fa-3335-fc32-e87c-52972251579b@meta.com>
Date:   Fri, 16 Dec 2022 12:05:36 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: create new processes
 repeatedly in the background.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, kernel-team@meta.com,
        song@kernel.org
References: <20221216015912.991616-1-kuifeng@meta.com>
 <20221216015912.991616-3-kuifeng@meta.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221216015912.991616-3-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ0PR15MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: 28cd1755-bd2a-4ff5-e8b0-08dadfa0e6fb
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P1UWP9k47VS9joMQmFyhQKAqFQm9bapW2piG1YSIWZulOpLzOIx2832dfaqZqRGMYlVrl8HSVcfj+tWcDd5QgMrMECWhgvK5GunTRy4ffiN++5vH6OK2QRXQwHyvFfCZrURnrlGwg9LamNMUBnYNGFfcGQchhSELn+qdJyPib+HK5b2BFVBaxe/iY269XMPbZayGHEVAtXGVLfUmfyqk6xpy8CqgN1P39tvz4WLnPItA3o0dI2Fiqc7yRRJnbhLZw4GksKYtiCtyyHyqC22daiIwtu7jI3Sby0fh/8onuDr7Rr9QhBCkXl88ZHFl2vpmZDHLXpMdX+wiY0CkG3TCl/T7TjZLvDizqgdy+sVnDvSNlYJrKhdWhAy5AFRT+m7i6cjJkQlqBZko+SDZDNH2iuPMioyXK+ODEqovObe4lxjeoTlqTddwMafroKScETsQxLtq/ByXGMP1ktmKdknn5Zgcqt/s41JPR1eewEDX4+lYPcnDxSN2ygypjIX6I+vOZRO9uHtiD7IUEm47WyxwsT53h3j4k1xZPcJ7tZDAXKgUAJafo4Wb4H2FwZXnudCVHT5iGKA29gxiMsSsXbAekeG6KDsyWZyeTKQdHmVw8vz8dGcjCz7/RiMZ3PbfgTaJPja5w3ifMEw/H7+KHNRYxozLkkRSsvihi8pkwPLtoi9VLzPcYaegiWXqComWVX1CkfuTkXcWl3AGqamwfrcCyfsddEh8tC59WTMyZncALuw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(86362001)(83380400001)(31696002)(2616005)(38100700002)(41300700001)(5660300002)(6506007)(6486002)(6666004)(478600001)(66946007)(53546011)(6512007)(186003)(66476007)(8676002)(66556008)(316002)(8936002)(2906002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0hhaUV3N0djcGNqUkRjSFJEWFhhWW5HRGkyZ0VvM1ZKdUF0enFvOG0vWjdl?=
 =?utf-8?B?dnRldk8vZEJoNFRnNGpPWHRhNVN6aHlRaU1zSjIrOGlrSUprTmxJMCs2S1RU?=
 =?utf-8?B?Qy9mR2FoOEpLSzI5dnNpby9KYit1b1NrQ0NBa25TaElJUmZXbnNaOGE0REF0?=
 =?utf-8?B?ZHFoOWVmUFR2TkZxT25LOTBtdy9JbmhENm5ycnVnUWNHSXU3cExkZE9YWG1Z?=
 =?utf-8?B?TGVyYVZKVW1odXpLU29JcnVObUJzZG1DTkQ5NDB5bWZ4aVdCVXpwRU9LNXd1?=
 =?utf-8?B?ZGZCbVZMcFp4ZzJJbFk4clh2d2RLMzJiaUo1VTBHa3FvUFIyVnVmbVhRcDhH?=
 =?utf-8?B?MnJpWHJoZjdMT0ZNT2xWNE83YzFCYXpZMEpNZExydkNBSnpZSTJNSlo5MlFP?=
 =?utf-8?B?V0VoVlBoTmxrWUdEUFYydTIyamtlU1dFVFB3Y0wzM1JGd2M5ZFcxZHk5WW5N?=
 =?utf-8?B?Lzk2dzQ4WG9RN2Q5MEpsQkxaM0VJRDdjQm15RWwxV1cvOUpQMGNoWFNsK1A0?=
 =?utf-8?B?aWIrWFBYSlkyU1BlTmFtK2hwTGlvYi9TUmRTeEUxdi9GRGc5aGw2M2MxMmZE?=
 =?utf-8?B?YkdJcENLdWM0bzRYUmZkcFRHMmo5TGpjYXIwZzZVZUZEUVhsNUsvTkZBN2NS?=
 =?utf-8?B?MDQwZGhLWWlkMG83SVk2U2ZJdlIxVGZCVC8wUkVocU1XbTBPOHNoU29YZTUw?=
 =?utf-8?B?U2F0SFNjUElUOGp4U3VqZUxqb3BraFkvTitUR0RRcC9KcHNyRGNPeFdOa0NJ?=
 =?utf-8?B?dzFQTUx4UGFQbGswZkF5NXk3WTVsUXo2eE9CdnVEdlg4dkhZb00zejQwL0RT?=
 =?utf-8?B?bjIvSFlBZHAveXV4TG9YbnlLMmhjcGQ5RTV2WVZ5bzhvNkErRXBCWUVhODE4?=
 =?utf-8?B?Ymd6dHQ0Ni9VVkgxamYyak52S3EzU0FXUzZueDNtL2NIbGVJOTdoZU92VE1m?=
 =?utf-8?B?U1dXWkZ0c3c4cmZmT3BwTE5EaXhKRVFwaDd0NjlOSDhWYUFSR0dCM2w5aGlx?=
 =?utf-8?B?RUZEQVIyckhxSXpKQkVlQ29XaDhYdk5ZWUNXSVhHVkMxbU1QL2ZFZDUrKzZ2?=
 =?utf-8?B?SUVwMzBoWktTVW1TdFYyaWROMWRuc0kvZU9IZG41Q1puT1kwSGFZWXUzOE1C?=
 =?utf-8?B?YkYwWmdxcDNFc2pwZlJjdnViNW9MN2tEUWpxdDRZR254VnQ0TkhsdnpCeWhz?=
 =?utf-8?B?SGxjNDVramVwc2NCUk5KRmFUdWluU0UxZWFiYWNkelZ2eUg1cTlZV1M5TUY2?=
 =?utf-8?B?eWxQSHZRajJ6UVczTzkxVXpHb3ZwaStBcVdQOFBhZmx6WVovczZMbURaU2xi?=
 =?utf-8?B?Z1RyRjMxTGVBRENIZG9mTHZJald5Y0MrbUo2TXNFQ0Jab1NCQnZqa3dNME9y?=
 =?utf-8?B?VjFNL0JCRjhrYUZNY2xlMk1JVC9zbUc3bTJNd3NFZEFlOFZXckpJSWpHS0Ix?=
 =?utf-8?B?MW1JMVBIcy9tMG5wMENpdWpCbzMrYWM1ellhcmRiZmtTa2VDWk56eit5amlZ?=
 =?utf-8?B?SHVZOENSdkp1Z0pKSk90bUk5VGcxSnlQNzJOWkZOM3BuZnhuTzd5L3ByZjNy?=
 =?utf-8?B?RzQ1bHh2eWRHTHNIc3g1amVUMzZWSXZkSUxtQVlyLzZNN1UyQUppbVR0SElI?=
 =?utf-8?B?aURpNG1LQUx6MFdYTk4vOXJHdXVJN29mYmJtUDJEdGVtdFN4U2FjWGc5ZkNI?=
 =?utf-8?B?UE9naHFGaXJybHVFMSt6NWVsVjFtQndvWDZqUzlPYW9WV3UxNXphNkplQzVw?=
 =?utf-8?B?ZkFsYmZPY0MvcE8wNzl5b0FKYjdidXAvS1pGNlVKRXJvd0dSYmtIZWEyL2NE?=
 =?utf-8?B?c0tXUi9wVDdtWDhwSDZNNkkzNm1yYU9odzdJU2hmcHgraTFJNTlzdFNZUGt6?=
 =?utf-8?B?OS9DSzJtSmFqa0NQVG50ZmMwOGN6N1pyZUJkN0haU01QQ21TZXdvUkVFaTVu?=
 =?utf-8?B?NWFUUTYrdVdJcXBEWU1FZXJyWGJYNGJxWHQycG5LY0x4bzV0YTk3OWpaY2tw?=
 =?utf-8?B?TlJVWXhlUXJiVlo4bHBpSmhyNE4zeVdsaGxmVTREb1pLVWZiQnA1YnROWVBX?=
 =?utf-8?B?UzBYUHZCZk9ETUI4NVJTcGJEM0labkl2S2hhM01ZRW1EK3cxSFJrTEtxdkpv?=
 =?utf-8?B?cG5hQ0VCeDBwb3cwZU5GTWNJSkN2VUR4ZHRuWEE1OWxPdEhNL0pJMno5UHZs?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28cd1755-bd2a-4ff5-e8b0-08dadfa0e6fb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 20:05:39.1251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CGhEP6dNRlL7Z4r7vKR+OYZ9nmPbTNuqhS556qTZuz84IEvnT4TTANjdUjfFjjgM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5824
X-Proofpoint-GUID: oBdS-hTkPgkhB4ytlzF_pLTM-H7SzakW
X-Proofpoint-ORIG-GUID: oBdS-hTkPgkhB4ytlzF_pLTM-H7SzakW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_14,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/15/22 5:59 PM, Kui-Feng Lee wrote:
> According to a report, the system may crash when a task iterator

There is no context about this 'a report'. You can just remove it
and say:
   When a task iterator traverses vma(s), it is possible task->mm
   might become invalid in the middle of traversal and this may
   cause kernel misbehave (e.g., crash).

> travels vma(s).  The investigation shows it takes place if the
> visiting task dies during the visit. >
> This test case creates iterators repeatedly and forks short-lived
> processes in the background to detect this bug.  The test will last
> for 3 seconds to get the chance to trigger the issue.

The subject is not precise. The test is not about
"create new processes repeatedly in the background."
It is about
"Add a test for iter/task_vma with shortlived processes"

> 
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>

Ack with a few nits.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   .../selftests/bpf/prog_tests/bpf_iter.c       | 79 +++++++++++++++++++
>   1 file changed, 79 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index 6f8ed61fc4b4..df13350d615a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -1465,6 +1465,83 @@ static void test_task_vma_common(struct bpf_iter_attach_opts *opts)
>   	bpf_iter_task_vma__destroy(skel);
>   }
>   
> +static void test_task_vma_dead_task(void)
> +{
> +	int err, iter_fd = -1;
> +	struct bpf_iter_task_vma *skel;
> +	int wstatus, child_pid = -1;
> +	time_t start_tm, cur_tm;
> +	int wait_sec = 3;

Since it is new code, maybe reverse Christmas tree coding style.

> +
> +	skel = bpf_iter_task_vma__open();
> +	if (!ASSERT_OK_PTR(skel, "bpf_iter_task_vma__open"))
> +		return;
> +
> +	skel->bss->pid = getpid();
> +
> +	err = bpf_iter_task_vma__load(skel);
> +	if (!ASSERT_OK(err, "bpf_iter_task_vma__load"))
> +		goto out;
> +
> +	skel->links.proc_maps = bpf_program__attach_iter(
> +		skel->progs.proc_maps, NULL);
> +
> +	if (!ASSERT_OK_PTR(skel->links.proc_maps, "bpf_program__attach_iter")) {
> +		skel->links.proc_maps = NULL;
> +		goto out;
> +	}
> +
> +	start_tm = time(NULL);
> +	if (start_tm < 0)
> +		goto out;

 From the man page, start_tm should not fail. Note that you didn't put
an ASSERT* either. So I think you can remove it. The same for a few 
instances below.

> +	cur_tm = start_tm;
> +
> +	child_pid = fork();
> +	if (child_pid == 0) {
> +		/* Fork short-lived processes in the background. */
> +		while (cur_tm < start_tm + wait_sec) {
> +			system("echo > /dev/null");
> +			cur_tm = time(NULL);
> +			if (cur_tm < 0)
> +				exit(1);
> +		}
> +		exit(0);
> +	}
> +
> +	if (!ASSERT_GE(child_pid, 0, "fork_child"))
> +		goto out;
> +
> +	while (cur_tm < start_tm + wait_sec) {
> +		iter_fd = bpf_iter_create(bpf_link__fd(skel->links.proc_maps));
> +		if (!ASSERT_GE(iter_fd, 0, "create_iter"))
> +			goto out;
> +
> +		/* Drain all data from iter_fd. */
> +		while (cur_tm < start_tm + wait_sec) {
> +			err = read_fd_into_buffer(iter_fd, task_vma_output, CMP_BUFFER_SIZE);
> +			if (!ASSERT_GE(err, 0, "read_iter_fd"))
> +				goto out;
> +
> +			cur_tm = time(NULL);
> +			if (cur_tm < 0)
> +				goto out;
> +
> +			if (err == 0)
> +				break;
> +		}
> +
> +		close(iter_fd);
> +		iter_fd = -1;
> +	}
> +
> +	check_bpf_link_info(skel->progs.proc_maps);
> +
> +out:
> +	waitpid(child_pid, &wstatus, 0);
> +	close(iter_fd);
> +	bpf_iter_task_vma__destroy(skel);
> +}
> +
>   void test_bpf_sockmap_map_iter_fd(void)
>   {
>   	struct bpf_iter_sockmap *skel;
> @@ -1586,6 +1663,8 @@ void test_bpf_iter(void)
>   		test_task_file();
>   	if (test__start_subtest("task_vma"))
>   		test_task_vma();
> +	if (test__start_subtest("task_vma_dead_task"))
> +		test_task_vma_dead_task();
>   	if (test__start_subtest("task_btf"))
>   		test_task_btf();
>   	if (test__start_subtest("tcp4"))
