Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F125A0306
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 22:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240174AbiHXUvX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 16:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240513AbiHXUvU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 16:51:20 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9478574CD8
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 13:51:18 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27OIsrH7021686;
        Wed, 24 Aug 2022 13:51:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=3RMZR18IvIH+NAM1xQ1cONiS+ENgoreSSwA+Kenguqs=;
 b=JYi9WiqOAqR5OdV0Oed52s/MRUN6E0XMrkI38ZZ09ZeydFqW+xYMZDhX5seDf5+D7auw
 OG/djuEkYPWzbCJ7QcoRX2LIRDMLI8X2op4P8BTD0WWQCNh/coM6I7cQRI+WT/A8zvSA
 1ytHlCHIgyx7P+5A8fewKsxnpG+PeRq4510= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5nfcayp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Aug 2022 13:51:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVZFtGyL4fOms+JpgH0Z9QfXJDwSNELNg4euM9TqbVHw07VvMjaWMhN9KuX77tih92sLxWW+JkVZH/u35AZDOBnKF/st78HQIM43lsxXh778P0NgztV6fPQ8toWV8XZrnow/+3BmfVkpzJVqA46yobl0xRCQr1N9XqljUBg2qVf50O/Por8stT6+Mmk7XORwqezOQVJqJP5TLSvu6TCrE1092+U77B5rjXctpeXb+emnV5PhgBHVnOSw2S2jStqHBEevB6HjbO3x88ZVpgDOfkKnWrkk5adUgiEmMED/lF65XhRfkBfWJzuLRaMxslo/zQPubWCS8uJ73s7viVo7Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RMZR18IvIH+NAM1xQ1cONiS+ENgoreSSwA+Kenguqs=;
 b=KzoI05XqPv4i5ltpuRs5ifs8Jhh9c9+306YRDMojRQoDoF2P3C2u8UeRfSLss7A5zPxVPtw2Y3m+DJbHLHVtegoNmf+9jQplDzm3o6Yp1KYJTevEbk6F1dnegs0HaZV4jGt093bc5kNLaHXyCPfXiWs+RdehsdUUq+6SVERTwybijJuJJcbLOzRMboHWUu8QXJeWLs0IT/dI1oVsNJ9scAlfA/aXX7kgrIEmFtu6fGsq4Epj62Hv2ih1eyYQsXF8YOzIKeS8ZfPWhlPEWzZ9E3zeQH40TBsMDwXEC392tLGumjq5A6x2v02+XO0F59DWmWB1qdBXxT1O6OWNrl8OKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3856.namprd15.prod.outlook.com (2603:10b6:806:86::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 20:51:01 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 20:51:01 +0000
Message-ID: <cef5b6d2-6a95-6b57-2d57-8607cff97d92@fb.com>
Date:   Wed, 24 Aug 2022 13:50:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v6 4/4] selftests/bpf: Test parameterized task
 BPF iterators.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com
References: <20220819220927.3409575-1-kuifeng@fb.com>
 <20220819220927.3409575-5-kuifeng@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220819220927.3409575-5-kuifeng@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:a03:60::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4539a2a-47f6-41c1-55d8-08da86125a79
X-MS-TrafficTypeDiagnostic: SA0PR15MB3856:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/8Y3xxOkp8LhjCVeDC8aHQP12BvxEs/ouCR/qN4RldwnavGHRKNYzWcyspm0hkb4u6JqdNw5T2GXc3qcz5XkUKOiDmEOFOiqfvXe1cOl3W/v6nWZubJ5D2ywn5P+br5tWa+vs63bwxNoirrnzOOcCMn8aBRIyBCeD9gmeUilOAZ8kB6dv9ZDBCH81epVJhgGVD25C2p5v4TchdZhgt1N8BkzSPq/oUB2Nw8JI3OfHdkN+8sC7T6Nl69IQmyX3ple+dZq36HalmiujyTCvwLeDggF1+LPKJRpN5IG42rWsrnXf7Dm8lSJtygrQtjgHbI4lzqE/Pq6LWpdeiLiL/J+e8EAj4EbHjiOADoDoHf8rRmESjqJosP8WmvktfI0CRdERXGog6k0Uyi3uKyRLa689LtKWb5OFldvrBBJ/L8gYDE8gXiWJCcL0J/lsm1SvlpmbPqrvzMh0zx8s5pZJmMseFZ57vhj485ErWF9SqoUYN3NBBtEKhMgeZGlQtg4EnzxzQzOfASEP0O8awNp3WRDfszlRzV2EXsyqVd9/2QidWf1BFYpsgeVk+4hznIC4aNqWh/mokduv9QWrq8JAo4TriO9hYVjvVO4t4okrs+1548Aj4SAXmDgnLNhL4D4/GXVoxIa++yLSVx62Z78jPF0+X16cOT2mlGc1CJT5QY2a9SsxH+i91jhUq7WMeyJDNtLBL1p55TM/fSYPZFuz04+w73Z9GnHzM1G+6XPL/7iVsYo7YKcG6Os8l9pPmbg2hgWbho+cC/pjLxcBDwqZoJTZH8lfPKcFDjjvCxzyMbpjg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(136003)(346002)(396003)(8676002)(316002)(66476007)(6636002)(66946007)(66556008)(30864003)(8936002)(2906002)(5660300002)(38100700002)(36756003)(86362001)(31696002)(41300700001)(6512007)(53546011)(6666004)(6506007)(478600001)(6486002)(83380400001)(186003)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXFnYlp4Z1dmNzQ4VGRlazNJckZXbmpRMjVSYS9nT0hucm16SUdjYXZGQnhK?=
 =?utf-8?B?ZVFEbDBuWU9jVGxVYmkwaExyZnlIQ1kxOU9PWFVSQXdlQkVqQ1hXNGQ5OTJH?=
 =?utf-8?B?NkxUQlVCY0YwYzBCTWJ1K1ZVYmZTNFhiRmpWWnBRU2JoV05nWGJvNzIxZVE3?=
 =?utf-8?B?YXB2V0dqaUJUTDN6M0RxNFNMbnZ2dkdoYkN5Y211SHdMNitvb2ZoTjBvVlVo?=
 =?utf-8?B?OE5FZVRZREhEZmNDTzk5Z0o0djJsMnlrSlNrNC9FYmw0Q2hsaXZGOTBHWVF1?=
 =?utf-8?B?WHRXMGdLVkkvY09IZmhTYUZqNWVLcVNDb2pST21kbnNKbE9CdVRXdi9FbUp2?=
 =?utf-8?B?U0cyd3ZqYmZBVXk1aDhOUG5zbFM4cHJuRW9URHBYMUZ2SmM3cDREMzZTSndC?=
 =?utf-8?B?YkJVOTh4bmZjNFB5MjZ4UzFMVmEwZ3ZWVCsxTlQzZUs4dFZacXBwOHpNVFJt?=
 =?utf-8?B?c3dQbHRKNzFnaUJHTGpydEpsMHVHc2c2Vm5OalpKUjVXZXhrS2I5QjloT00y?=
 =?utf-8?B?UmpSUXdzZGJNMG9PczJtQ1ZlRVJuVURzQUZtYU9majBqbCtRTWZkMGJGVGt0?=
 =?utf-8?B?dS9hQXN3T0cwL3JNalhnMFBBNFM0dTluUmRLcDljZHNyOE13b21mNWdwWno0?=
 =?utf-8?B?bzJEZ1dRYnR0RFVFMWdTdFpBMXM1REd2d1plSE1BUjFXcmFJdlJNSVhIbVZq?=
 =?utf-8?B?YnBjVHN2MCsyY0xxL2JWK3dtdnVZNTg0S0k0bnJmbVpsSWlmMkEwZDVLc3lQ?=
 =?utf-8?B?empiZ29DYmJ2TFpWMWxRSG1PelVudldkVW0zQUZSZUo3elJzWTk1NWtHN21U?=
 =?utf-8?B?YkZ0TTRQZm5UeFZ6VFFOb2MwVFp0QnFjcjVVRzY1Z3pMUm1WTW9xdGVTek9l?=
 =?utf-8?B?elNoVmF4NGNqdG5jNjZBY2VmOStaK1B0Mk9nMzk4anhqODg3SlhNT1lUTHg3?=
 =?utf-8?B?YUtNQ2JzSWR6c0xjN255UkI5YkhJNUNxUnNNdDNmcVdTQ0Z4RFJ6R3Bzbkpp?=
 =?utf-8?B?eVJ0TXZoWklPdzh3R3g3VEkwb3RBNTZ0M3ZDeldnQWozSmZZOTZTVEZxUUNt?=
 =?utf-8?B?b1BsVzhsSWptaW1TbmozbjdpRW5VK2RnOEJHQ1kyaU8rVFVIeisvNkt4emJv?=
 =?utf-8?B?RHdEejRDZENzOUFoeW9pRW52QWQxYVpFSDQreEdrMUVMNm9ZVXpHSjFmODNY?=
 =?utf-8?B?TDNFSjgvYmVkSzFQSXpNYjhnWXk4RU1QZ3NKRklPSGJSTFV6cFFPS1U1UWxu?=
 =?utf-8?B?NWRiQTBiNGd4RnVmSXhnSG1LczRGbW03UTVvTFI3WnUyQlJxanMxbEordmc3?=
 =?utf-8?B?NGNWRWIxZk8xOXFlRUh1akdVeWdzZ3BxSXg1UThyMzdvVjZaTWdCUk5sWlRh?=
 =?utf-8?B?TzkyNllOQVdFMmFDRG90YkljSGVjUmVNRCtTRjlUY010SjdCN3Z0NEhRN25l?=
 =?utf-8?B?VENCc3I0UURaWmlEQ3d1QmJLREpPcm55M1l2NEhkMUwzY3U2eUw1Sk96WVJU?=
 =?utf-8?B?OGkvaGl0WittTDBqZk0vbVFwTUs5RjNyclhWRHQ2dWsxYmJHdEV5T2FHUTU4?=
 =?utf-8?B?MGZWajl4d0Ewb1ZrK25vY0gvUGRnNUx3T2dOYTZOZDgyZE5jQnZ5a3ljbVo4?=
 =?utf-8?B?YjljMEMrSG40Y09GVVRVOWJERnZ2SzFwUXRoVklEVkNZdVpJNVRhRk1kRmk3?=
 =?utf-8?B?ZG5qb2xVcjZNcVlOeHpIWElEblpLUjE1WDZodzBOL0pKU0ZPMDlQSVMxVGMv?=
 =?utf-8?B?NmpxS1IwbGN6cGpFdVlkbWtVbTIydUNVSXlqdk5VUlFJZVhqWGtxVjMwYVVO?=
 =?utf-8?B?ZnptaHMzem54Y1ZlZFlCakN0YWQxcHc1N3RnNkd1c25RUWRrc21PL0paWUtK?=
 =?utf-8?B?MWJ4NndKS1VHZmlUQ3ZmemVOSUpSUXVOMyt4bFJ6MUlpakx4MDlWTTBMWlhu?=
 =?utf-8?B?dU1leVJTd1pESmt4UmxuQmxvV1VqcFgwZWtGTi9PeHlHZFVwYzBtZkJwdmM1?=
 =?utf-8?B?UHJDNlhWSk5aWXc2eXdNajVKQ3I1U0FIZlhiMDlVUC9FbzArbGQ0bmFMai8w?=
 =?utf-8?B?THBueXhpRE5pTklRQVZnWHVYcnNHbkZrbXE1RkVkUkRYWDQ1K20xNFpHTzUw?=
 =?utf-8?B?TVpmNDViZThjNzhIRWp3L0N1Yy9IQkRoNFNyVmUxNkgwRjFtenRPK2JUdmxm?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4539a2a-47f6-41c1-55d8-08da86125a79
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 20:51:01.3031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+gjatrAPoT6flz4w8z6Sib8fmtPaUAFbfSxytRGVZl+u67EIw5mYkh0OLmS+ky9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3856
X-Proofpoint-GUID: 6WmhG2diAJqJSZ5u2brablwG0GwyXoLL
X-Proofpoint-ORIG-GUID: 6WmhG2diAJqJSZ5u2brablwG0GwyXoLL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-24_13,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/19/22 3:09 PM, Kui-Feng Lee wrote:
> Test iterators of vma, files, and tasks of tasks.
> 
> Ensure the API works appropriately to visit all tasks,
> tasks in a process, or a particular task.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>   .../selftests/bpf/prog_tests/bpf_iter.c       | 284 +++++++++++++++++-
>   .../selftests/bpf/prog_tests/btf_dump.c       |   2 +-
>   .../selftests/bpf/progs/bpf_iter_task.c       |   9 +
>   .../selftests/bpf/progs/bpf_iter_task_file.c  |   9 +-
>   .../selftests/bpf/progs/bpf_iter_task_vma.c   |   6 +-
>   .../bpf/progs/bpf_iter_uprobe_offset.c        |  35 +++
>   6 files changed, 326 insertions(+), 19 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_uprobe_offset.c
> 
[...]
> +
> +static pthread_mutex_t do_nothing_mutex;
> +
> +static void *do_nothing_wait(void *arg)
> +{
> +	pthread_mutex_lock(&do_nothing_mutex);
> +	pthread_mutex_unlock(&do_nothing_mutex);
> +
> +	pthread_exit(arg);
> +}
> +
> +static void test_task_common_nocheck(struct bpf_iter_attach_opts *opts,
> +				     int *num_unknown, int *num_known)
>   {
>   	struct bpf_iter_task *skel;
> +	pthread_t thread_id;
> +	bool locked = false;

We can have a more 'kernel'-way implementation than using
'locked'.
	if (!ASSERT_OK(pthread_mutex_lock(&do_nothing_mutex), 
"pthread_mutex_lock"))
		goto done;
	if (!ASSERT_OK(pthread_create(&thread_id, NULL, &do_nothing_wait, 
NULL), "pthread_create"))
		goto unlock;

	...
unlock:
	ASSERT_OK(pthread_mutex_unlock(&do_nothing_mutex), "pthread_mutex_unlock");
done:
	bpf_iter_task__destroy(skel);


> +	void *ret;
>   
>   	skel = bpf_iter_task__open_and_load();
>   	if (!ASSERT_OK_PTR(skel, "bpf_iter_task__open_and_load"))
>   		return;
>   
> -	do_dummy_read(skel->progs.dump_task);
> +	if (!ASSERT_OK(pthread_mutex_lock(&do_nothing_mutex), "pthread_mutex_lock"))
> +		goto done;
> +	locked = true;
> +
> +	if (!ASSERT_OK(pthread_create(&thread_id, NULL, &do_nothing_wait, NULL),
> +		  "pthread_create"))
> +		goto done;
> +
> +
> +	skel->bss->tid = getpid();
> +
> +	do_dummy_read_opts(skel->progs.dump_task, opts);
> +
> +	*num_unknown = skel->bss->num_unknown_tid;
> +	*num_known = skel->bss->num_known_tid;
> +
> +	ASSERT_OK(pthread_mutex_unlock(&do_nothing_mutex), "pthread_mutex_unlock");
> +	locked = false;
> +	ASSERT_FALSE(pthread_join(thread_id, &ret) || ret != NULL,
> +		     "pthread_join");
>   
> +done:
> +	if (locked)
> +		ASSERT_OK(pthread_mutex_unlock(&do_nothing_mutex), "pthread_mutex_unlock");
>   	bpf_iter_task__destroy(skel);
>   }
>   
> +static void test_task_common(struct bpf_iter_attach_opts *opts, int num_unknown, int num_known)
> +{
> +	int num_unknown_tid, num_known_tid;
> +
> +	test_task_common_nocheck(opts, &num_unknown_tid, &num_known_tid);
> +	ASSERT_EQ(num_unknown_tid, num_unknown, "check_num_unknown_tid");
> +	ASSERT_EQ(num_known_tid, num_known, "check_num_known_tid");
> +}
> +
> +static void test_task(void)

test_task_tid?

> +{
> +	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +	union bpf_iter_link_info linfo;
> +	int num_unknown_tid, num_known_tid;
> +
> +	memset(&linfo, 0, sizeof(linfo));
> +	linfo.task.tid = getpid();
> +	opts.link_info = &linfo;
> +	opts.link_info_len = sizeof(linfo);
> +	test_task_common(&opts, 0, 1);
> +
> +	linfo.task.tid = 0;
> +	linfo.task.pid = getpid();
> +	test_task_common(&opts, 1, 1);
> +
> +	test_task_common_nocheck(NULL, &num_unknown_tid, &num_known_tid);
> +	ASSERT_GT(num_unknown_tid, 1, "check_num_unknown_tid");
> +	ASSERT_EQ(num_known_tid, 1, "check_num_known_tid");
> +}
> +
> +static void test_task_tgid(void)

test_task_pid?

> +{
> +	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +	union bpf_iter_link_info linfo;
> +
> +	memset(&linfo, 0, sizeof(linfo));
> +	linfo.task.pid = getpid();
> +	opts.link_info = &linfo;
> +	opts.link_info_len = sizeof(linfo);
> +
> +	test_task_common(&opts, 1, 1);
> +}
> +
> +static void test_task_pidfd(void)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +	union bpf_iter_link_info linfo;
> +	int pidfd;
> +
> +	pidfd = pidfd_open(getpid(), 0);
> +	if (!ASSERT_GT(pidfd, 0, "pidfd_open"))
> +		return;
> +
> +	memset(&linfo, 0, sizeof(linfo));
> +	linfo.task.pid_fd = pidfd;
> +	opts.link_info = &linfo;
> +	opts.link_info_len = sizeof(linfo);
> +
> +	test_task_common(&opts, 1, 1);
> +
> +	close(pidfd);
> +}
> +
>   static void test_task_sleepable(void)
>   {
>   	struct bpf_iter_task *skel;
> @@ -212,15 +349,13 @@ static void test_task_stack(void)
>   	bpf_iter_task_stack__destroy(skel);
>   }
>   
> -static void *do_nothing(void *arg)
> -{
> -	pthread_exit(arg);
> -}
> -
>   static void test_task_file(void)
>   {
> +	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
>   	struct bpf_iter_task_file *skel;
> +	union bpf_iter_link_info linfo;
>   	pthread_t thread_id;
> +	bool locked = false;

similar to the above, 'locked' variable can be removed
by implementing an alternative approach.

>   	void *ret;
>   
>   	skel = bpf_iter_task_file__open_and_load();
> @@ -229,19 +364,43 @@ static void test_task_file(void)
>   
>   	skel->bss->tgid = getpid();
>   
> -	if (!ASSERT_OK(pthread_create(&thread_id, NULL, &do_nothing, NULL),
> +	if (!ASSERT_OK(pthread_mutex_lock(&do_nothing_mutex), "pthread_mutex_lock"))
> +		goto done;
> +	locked = true;
> +
> +	if (!ASSERT_OK(pthread_create(&thread_id, NULL, &do_nothing_wait, NULL),
>   		  "pthread_create"))
>   		goto done;
>   
> -	do_dummy_read(skel->progs.dump_task_file);
> +	memset(&linfo, 0, sizeof(linfo));
> +	linfo.task.tid = getpid();
> +	opts.link_info = &linfo;
> +	opts.link_info_len = sizeof(linfo);
>   
> -	if (!ASSERT_FALSE(pthread_join(thread_id, &ret) || ret != NULL,
> -		  "pthread_join"))
> -		goto done;
> +	do_dummy_read_opts(skel->progs.dump_task_file, &opts);
> +
> +	ASSERT_EQ(skel->bss->count, 0, "check_count");
> +	ASSERT_EQ(skel->bss->unique_tgid_count, 1, "check_unique_tgid_count");
> +
> +	skel->bss->last_tgid = 0;
> +	skel->bss->count = 0;
> +	skel->bss->unique_tgid_count = 0;
> +
> +	do_dummy_read(skel->progs.dump_task_file);
>   
>   	ASSERT_EQ(skel->bss->count, 0, "check_count");
> +	ASSERT_GT(skel->bss->unique_tgid_count, 1, "check_unique_tgid_count");
> +
> +	check_bpf_link_info(skel->progs.dump_task_file);
> +
> +	ASSERT_OK(pthread_mutex_unlock(&do_nothing_mutex), "pthread_mutex_unlock");
> +	locked = false;
> +	ASSERT_OK(pthread_join(thread_id, &ret), "pthread_join");
> +	ASSERT_NULL(ret, "phtread_join");
>   
>   done:
> +	if (locked)
> +		ASSERT_OK(pthread_mutex_unlock(&do_nothing_mutex), "pthread_mutex_unlock");
>   	bpf_iter_task_file__destroy(skel);
>   }
>   
> @@ -1249,7 +1408,7 @@ static void str_strip_first_line(char *str)
>   	*dst = '\0';
>   }
>   
[...
> +
>   void test_bpf_iter(void)
>   {
> +	if (!ASSERT_OK(pthread_mutex_init(&do_nothing_mutex, NULL), "pthread_mutex_init"))
> +		return;
> +
>   	if (test__start_subtest("btf_id_or_null"))
>   		test_btf_id_or_null();
>   	if (test__start_subtest("ipv6_route"))
> @@ -1337,6 +1583,10 @@ void test_bpf_iter(void)
>   		test_bpf_map();
>   	if (test__start_subtest("task"))
>   		test_task();
> +	if (test__start_subtest("task_tgid"))
> +		test_task_tgid();
> +	if (test__start_subtest("task_pidfd"))
> +		test_task_pidfd();
>   	if (test__start_subtest("task_sleepable"))
>   		test_task_sleepable();
>   	if (test__start_subtest("task_stack"))
> @@ -1397,4 +1647,6 @@ void test_bpf_iter(void)
>   		test_ksym_iter();
>   	if (test__start_subtest("bpf_sockmap_map_iter_fd"))
>   		test_bpf_sockmap_map_iter_fd();
> +	if (test__start_subtest("uprobe_offset"))
> +		test_task_uprobe_offset();

uprobe_offset -> vma_offset? See below.

>   }
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> index 5fce7008d1ff..32c34ce9cbeb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> @@ -764,7 +764,7 @@ static void test_btf_dump_struct_data(struct btf *btf, struct btf_dump *d,
>   
>   	/* union with nested struct */
>   	TEST_BTF_DUMP_DATA(btf, d, "union", str, union bpf_iter_link_info, BTF_F_COMPACT,
> -			   "(union bpf_iter_link_info){.map = (struct){.map_fd = (__u32)1,},}",
> +			   "(union bpf_iter_link_info){.map = (struct){.map_fd = (__u32)1,},.task = (struct){.tid = (__u32)1,},}",
>   			   { .map = { .map_fd = 1 }});
>   
>   	/* struct skb with nested structs/unions; because type output is so
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task.c b/tools/testing/selftests/bpf/progs/bpf_iter_task.c
> index d22741272692..96131b9a1caa 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_task.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_task.c
> @@ -6,6 +6,10 @@
>   
>   char _license[] SEC("license") = "GPL";
>   
> +uint32_t tid = 0;
> +int num_unknown_tid = 0;
> +int num_known_tid = 0;
> +
>   SEC("iter/task")
>   int dump_task(struct bpf_iter__task *ctx)
>   {
> @@ -18,6 +22,11 @@ int dump_task(struct bpf_iter__task *ctx)
>   		return 0;
>   	}
>   
> +	if (task->pid != tid)
> +		num_unknown_tid++;
> +	else
> +		num_known_tid++;
> +
>   	if (ctx->meta->seq_num == 0)
>   		BPF_SEQ_PRINTF(seq, "    tgid      gid\n");
>   
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c b/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c
> index 6e7b400888fe..b0255080662d 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_file.c
> @@ -7,14 +7,16 @@ char _license[] SEC("license") = "GPL";
>   
>   int count = 0;
>   int tgid = 0;
> +int last_tgid = 0;
> +int unique_tgid_count = 0;
>   
>   SEC("iter/task_file")
>   int dump_task_file(struct bpf_iter__task_file *ctx)
>   {
>   	struct seq_file *seq = ctx->meta->seq;
>   	struct task_struct *task = ctx->task;
> -	__u32 fd = ctx->fd;
>   	struct file *file = ctx->file;
> +	__u32 fd = ctx->fd;
>   
>   	if (task == (void *)0 || file == (void *)0)
>   		return 0;
> @@ -27,6 +29,11 @@ int dump_task_file(struct bpf_iter__task_file *ctx)
>   	if (tgid == task->tgid && task->tgid != task->pid)
>   		count++;
>   
> +	if (last_tgid != task->tgid) {
> +		last_tgid = task->tgid;
> +		unique_tgid_count++;
> +	}
> +
>   	BPF_SEQ_PRINTF(seq, "%8d %8d %8d %lx\n", task->tgid, task->pid, fd,
>   		       (long)file->f_op);
>   	return 0;
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c b/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c
> index 4ea6a37d1345..44f4a31c2ddd 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_vma.c
> @@ -20,6 +20,7 @@ char _license[] SEC("license") = "GPL";
>   #define D_PATH_BUF_SIZE 1024
>   char d_path_buf[D_PATH_BUF_SIZE] = {};
>   __u32 pid = 0;
> +__u32 one_task = 0;
>   
>   SEC("iter/task_vma") int proc_maps(struct bpf_iter__task_vma *ctx)
>   {
> @@ -33,8 +34,11 @@ SEC("iter/task_vma") int proc_maps(struct bpf_iter__task_vma *ctx)
>   		return 0;
>   
>   	file = vma->vm_file;
> -	if (task->tgid != pid)
> +	if (task->tgid != pid) {
> +		if (one_task)
> +			BPF_SEQ_PRINTF(seq, "unexpected task (%d != %d)", task->tgid, pid);

Let us change this to an error code like
__u32 one_task_error = 0;
...
if (task->tgid != pid) {
	if (one_task)
		one_task_error = 1;
	return 0;
}
In bpf_iter.c, we can assert one_task_error must be 0?

>   		return 0;
> +	}
>   	perm_str[0] = (vma->vm_flags & VM_READ) ? 'r' : '-';
>   	perm_str[1] = (vma->vm_flags & VM_WRITE) ? 'w' : '-';
>   	perm_str[2] = (vma->vm_flags & VM_EXEC) ? 'x' : '-';
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_uprobe_offset.c b/tools/testing/selftests/bpf/progs/bpf_iter_uprobe_offset.c
> new file mode 100644
> index 000000000000..825ca86678bd
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_uprobe_offset.c

Maybe change file name to bpf_iter_vma_offset so we know the test
is related 'iter/task_vma'? the offset can be used by uprobe, but
it can be used for other purposes, e.g., symbolization.

> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +#include "bpf_iter.h"
> +#include <bpf/bpf_helpers.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +__u32 unique_tgid_cnt = 0;
> +uintptr_t address = 0;
> +uintptr_t offset = 0;
> +__u32 last_tgid = 0;
> +__u32 pid = 0;
> +
> +SEC("iter/task_vma") int get_uprobe_offset(struct bpf_iter__task_vma *ctx)

get_vma_offset?

> +{
> +	struct vm_area_struct *vma = ctx->vma;
> +	struct seq_file *seq = ctx->meta->seq;
> +	struct task_struct *task = ctx->task;
> +
> +	if (task == NULL || vma == NULL)
> +		return 0;
> +
> +	if (last_tgid != task->tgid)
> +		unique_tgid_cnt++;
> +	last_tgid = task->tgid;
> +
> +	if (task->tgid != pid)
> +		return 0;
> +
> +	if (vma->vm_start <= address && vma->vm_end > address) {
> +		offset = address - vma->vm_start + (vma->vm_pgoff << 12);
> +		BPF_SEQ_PRINTF(seq, "OK\n");
> +	}
> +	return 0;
> +}
