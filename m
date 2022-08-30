Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8925A712C
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 00:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiH3WzK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 18:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiH3WzG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 18:55:06 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7785FC8
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 15:55:03 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UMjG79020478;
        Tue, 30 Aug 2022 15:54:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cuTaKz1ob6seNtmHAkKvGkkjYXXloTqyicG//8mt/X8=;
 b=bE8QcYE4urM1N7DfQCOaC0JwkbuTRgo4LcYlETfAJHkj+gUHN5YFGSyQ8gB4xi0aVvc6
 GEp1bSz5dS7yJKZzwemPY2HtfBwCGfqpwrFpJ+DZ/S4Q9NeRT2v1eLsLT2enDvQ6GFFe
 Y7e6LRmIcXYKS4ZfwnNKhD49jrEcTA/PKb4= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9e9yn7mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 15:54:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZVpkrCK3Tz4KQbCjvUbt8uwleYD5vyP/QkCfi5wMZE4mNF+oXC97a+DisAD0vKI3trzVuftcNXB+QlC7Hot42ucoXr5CJ7fCQyNWBOhXigWx3r+Er894DcLC4DD9jyvrW67iJDJ1cpqeYH3j9E5miN1CLdqeHspbU+fuv+adpeSGizBPFHuGXtX2pQ+nkcgPK+UrLGu+CNqPgKI0XpwjnD54GJWZRLdtR9U3avx/VojzGGTvqqZBdSM+7J7+onJ9pU5AqtLfNMP2c6C2BFzMxLVHNqnJO6eNcxZN8YBXEHH18SOyYdEQusPGUWpweWCWJyEGPJNrVehri522Ghe3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuTaKz1ob6seNtmHAkKvGkkjYXXloTqyicG//8mt/X8=;
 b=aMEBJ/I9PRSLrsbRVqL+GDEa5JzTtvFm2sbRFXwKmk2ZOw93ZeFFaGa2WDxImSDr4IC3tfpT8KkVBEYC0AcPoOh+wHy/20lnca0eYg4I+T2kTYw7otljOSyF9g09QzJwHjw7uiH+AyY7M1wyX1fGroIZFjkQC8gWN+o9TJFcMh9PUI6NecG1PfSqnmvWVTrTU8Zx39hla4v8sGJxsSEEusEfioVq1TJcfR60kIqNj13lGtUWGl/nSjJlpxPHYDFc8pYrDUr+6RYf/vPHK+D0FUhdWIJjoNUFsLeMEtumIWyd+CFrvDB+Qz2DCK9cqPzUQf2E5TZRvZdq+dI3ApnGyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN7PR15MB2450.namprd15.prod.outlook.com (2603:10b6:406:92::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 30 Aug
 2022 22:54:46 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 22:54:45 +0000
Message-ID: <7e24948d-4e50-2058-ba6c-05dcee9b7426@fb.com>
Date:   Tue, 30 Aug 2022 15:54:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v8 4/5] selftests/bpf: Test parameterized task
 BPF iterators.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com
References: <20220829192317.486946-1-kuifeng@fb.com>
 <20220829192317.486946-5-kuifeng@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220829192317.486946-5-kuifeng@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0205.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::30) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1f869899-0ac1-4b8a-8219-08da8adaa24d
X-MS-TrafficTypeDiagnostic: BN7PR15MB2450:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oHj3Pebf/hq+sKOmuZtkoBg2qmUrQ0wMAWBPuhY5h2SDeDszwZFTKUJsgsU3SrgG6sC5bvK9sJbwoIgBrf8Gr2TpWuLlpVDkMVm2G9VyfiZUBYBExwb5jg/r+9e73AhEmxcMsa+mqq5zx4vPOg5AjkMoRYxQsEWv0nvg2qb+sZGANP1gpKL9YHKDh8venBj+uatKDZDxs1CKejWUGsa3MUpRPgdIEvRxAlkCPnRUfuTyZDxcDDCFXOHtsufFRi1QTbqcGHKs5UDx1bAPOvDkwn2128zXEYFWLPhhi4kbiDE3FXmQs177/gn+WLHrHSNjSoQFAiJl37XaQIF1vVZI8nuNmv8aAKqNtJD+qSzkA/sVN2Qgp7XsA1KXu1DuBDcKddfyFKpeTGyBixFJschPl9BNg2nobkLTouK5A7kqa5+g78pcY689wOjt8e23AFUW/FnP/1r+NeEIeLayl4432CWwTGyGX4p9RhLkHA09blwbwWv6PgBOskZTU9QO1k8KXOCcUp1f7fkS81m0R1U95+YZ+9wf8QQxTUOsOfFw3gR2idEcS7A9WRZTmnSj7uYc+A4qCTg1yrd1kYRrcWBRtOv4pbp6u8R4CduKiWa0GrbMIvk9yrq9+HBwbshWeUlxu0Xbrlba4DFfGRaI7vankIDqPE2ZAQfP1t2kT6o79NJivTFcwNHTB1Zl97jux6v2NyqdmxGokguCyJJl5kjhtc5asK0u6JTk+4UHDVuZhOmIP1Vom7nZhzyJBF0rt3Fv0RQZ34v6daOnFralcKtH40Cs16PFBbDU7/v8/MQvKqE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(38100700002)(8676002)(66946007)(66556008)(66476007)(316002)(6636002)(2906002)(5660300002)(6512007)(53546011)(83380400001)(8936002)(2616005)(186003)(6486002)(478600001)(6506007)(41300700001)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bENQRVRldS9XWU9idHFLYmRMalRvTmVoNUhFTnNoanRONGZlNUFHcGszMTcy?=
 =?utf-8?B?Mm5ZSHlYN0R3QWJhNWRQY1o4TGNJeHB0SnFHRkFIMitJaUV0NytyWDJxUkd6?=
 =?utf-8?B?cnNFbGlRWG1tbytSa3VRYko1V0E0YTlUYTN0R0IzN3d0NGUzTDREblloR1lI?=
 =?utf-8?B?TzV2MURLKzNralIvdG9sOW5nRU9DeFZDcVp0RWR1bGFaN0hBWjFUNitiZmZJ?=
 =?utf-8?B?azhFQWlIWnIrUzhsa0IrWDV0aU04bklacWcyc2NycEtlS3RRb3E5Q1FWOSto?=
 =?utf-8?B?czBkUlV2NmNIS0t2NVY5K3d0STh0cnl6VkFpUlJhM1A2aVZhY0NNbzJ4VEZy?=
 =?utf-8?B?ZG1MQzlyRUIwVUZCc1BiU3ZRWTVkWERVZjA3WWx0RGNpTzgxQkdNL2paYlVq?=
 =?utf-8?B?QW9PQU5sNWpYVXpoMVZHSHlkRkk2T0VoOGlZcm5MeTVPZTQrQm43LzlyeDVP?=
 =?utf-8?B?WFl6VmZvY2J2RmhnNXFkbUcyTkFCTDVBWTNhdmNRb2NDQTlGWi92amJEeWl2?=
 =?utf-8?B?cnhRcE1Pd05pbWM2VXlObGp4aEhIWGkwNXNadkwyL2RJbnBZSklFTi9QVG05?=
 =?utf-8?B?UHpCVXFySUZYVWpEM0ZUZVhyQnh2OHJwaHhWbDJ0UWFzbnk4bUduY2RhNUNH?=
 =?utf-8?B?b0RlNldWNjFhZHhtOWF4M1htT3g4WmJId1ZtdTB4c0RNUGJDZzdHN1kzN3Ra?=
 =?utf-8?B?aFNzREc2TFpCT2lyVG4zcVgyTkh3UFJDcnp3UlFBOUttQ0phS3VsckNGTjRK?=
 =?utf-8?B?TVNjMTFQWWE0bU8zaFhJdXVGYkRMd3B0cSs2SGZiZENTVlR1YmFNMlVjVEox?=
 =?utf-8?B?VzgyOGp4YlhEOEVnVlovNkpoMUZaUnRKc2htbWFzbGxtTzZhZkJTM0ZmeDQ4?=
 =?utf-8?B?MzFMODlmMVRKZ0VKMFVBNVRiTWl2dTNob2dYOXFoMW1UdHlPdHZnNzhSOWk2?=
 =?utf-8?B?TEcyUkdRcStXRUxmamJJejhGYzh5ZmpGeFYwLzhyY0J1by9nbURxUktFQjdQ?=
 =?utf-8?B?TjZHRG9MZ3I3a2t2Mkhub3Z2bU1VcXczYjY2NThCdWVvNVBjRnc2cEVzaXJD?=
 =?utf-8?B?MXRxeU5jRE5oZ1dYK2hOTnFWUzhuWXF4d0ROOEovN3ZNd2ppRHNGWjYxUWZK?=
 =?utf-8?B?ZjdHU3BlTTc5Um45cFU0QXMzOHFFWDM5Q3JMc2FVZS8zVjVRbCsvQkpHUG9O?=
 =?utf-8?B?RWpLeEZweTRuRzhWQXZsV3pZTlNMeUVzK1NOL290dnpjRjR1TTliRUF3ZmVq?=
 =?utf-8?B?d2w4QTJOY0pyWEpTaGlTSGdKN0k2Zkx5QWhwK0d1bU5uTlk0bDh6YkwxL01Z?=
 =?utf-8?B?eFBaelRNUEZadGtnbGdTK0lqS1N3K0JUUmFEK0dOdjVpQ0JpeURwdlBRNjFV?=
 =?utf-8?B?bDk1Tm1CS01Dc0IvNng1d0RKV3hWRFlUWUduS1g2cnFyVWpNaDZ3ZGZaZTAz?=
 =?utf-8?B?bG9ITklidFY3V0Q1SjlSczlIazdGcTdWb2dnNitHV2l1TitscXoxNU5yNlZD?=
 =?utf-8?B?dW52a3dpMXQxOUNOK3ZhNVoyVGZVV25CL21CVkNIRHY2WDBKay94M2RlQWEy?=
 =?utf-8?B?YW5NT2VUQ1VDZTdtRStyRmlxRllRRDV1Y3ozR3lJZHM3ZnVCRWNrMGhKQUY5?=
 =?utf-8?B?bG9aTElZVk14UmVGYzJnY3ZIcExQV2c5VHN0RTRCckNLc1g2ZitYWXpoRW9R?=
 =?utf-8?B?dHV5VGVTbFZ5NXdYTEVqSm5lMEpmV21VbmlweGh1OElIR2t0UjNIUUZhTGdR?=
 =?utf-8?B?bGh3M2xxSmI5Vm1jMFRMOGh5dGwvOVRoZDFhQkxxWUtYVmJhbmdLRmtHNmdV?=
 =?utf-8?B?Uk0yRnNmK2VmeUowRm5peDdsTnY3VHZKTkF6R1Q4L0tVRlJGMHNUaXBRVElJ?=
 =?utf-8?B?V3duc2Jabk1YTWR6T24wN1dXblBqa1N5ZXRVaWJhY3VpVG0vcHM1TTBWSUh4?=
 =?utf-8?B?MHJXVEk3UmpobzBYRUJvc0JnVHZxaXJNRlovWVZrR3ZSQnFvMURXWEFha2tp?=
 =?utf-8?B?ckp1S3lNdEwxOWFWYnNjZ0pEQnU3YWhGZm5TcU00NDBmaXprMmpKRjRJQURI?=
 =?utf-8?B?ZjU0S3kwZzlpeklSNGxIUjBBenNnVVh5S2RhSnF4TzM4VVhhSWt2N2p2NW1u?=
 =?utf-8?B?NlQ3SVhHeTRGNjBBb05Zby9DT2E4d0FzR2ptK1cyMVdJQlRHYjlJdC9aa0pU?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f869899-0ac1-4b8a-8219-08da8adaa24d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 22:54:45.8557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzKInlg/vZBfy1TJDNhOgyJkrESLN5oQIdF1v2jSVUYdx5lXyNj9y9uJu8qa0nZ5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2450
X-Proofpoint-ORIG-GUID: OqoCrlGHatsyD5om3ZhzUowOqjl7uacd
X-Proofpoint-GUID: OqoCrlGHatsyD5om3ZhzUowOqjl7uacd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_12,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/29/22 12:23 PM, Kui-Feng Lee wrote:
> Test iterators of vma, files and tasks.
> 
> Ensure the API works appropriately to visit all tasks,
> tasks in a process, or a particular task.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>   .../selftests/bpf/prog_tests/bpf_iter.c       | 282 ++++++++++++++++--
>   .../selftests/bpf/prog_tests/btf_dump.c       |   2 +-
>   .../selftests/bpf/progs/bpf_iter_task.c       |   9 +
>   .../selftests/bpf/progs/bpf_iter_task_file.c  |   9 +-
>   .../selftests/bpf/progs/bpf_iter_task_vma.c   |   7 +-
>   .../selftests/bpf/progs/bpf_iter_vma_offset.c |  37 +++
>   6 files changed, 322 insertions(+), 24 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_vma_offset.c
> 
[...]
> +
> +static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opts, bool one_proc)
> +{
> +	struct bpf_iter_vma_offset *skel;
> +	struct bpf_link *link;
> +	char buf[16] = {};
> +	int iter_fd, len;
> +	int pgsz, shift;
> +
> +	skel = bpf_iter_vma_offset__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "bpf_iter_vma_offset__open_and_load"))
> +		return;
> +
> +	skel->bss->pid = getpid();
> +	skel->bss->address = (uintptr_t)trigger_func;
> +	for (pgsz = getpagesize(), shift = 0; pgsz; pgsz >>= 1, shift++)
> +		;
> +	skel->bss->page_shift = shift;

if getpagesize() is 4K, shift will be 13 which is incorrect.

> +
> +	link = bpf_program__attach_iter(skel->progs.get_vma_offset, opts);
> +	if (!ASSERT_OK_PTR(link, "attach_iter"))
> +		return;
> +
> +	iter_fd = bpf_iter_create(bpf_link__fd(link));
> +	if (!ASSERT_GT(iter_fd, 0, "create_iter"))
> +		goto exit;
> +
> +	while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
> +		;
> +	buf[15] = 0;
> +	ASSERT_EQ(strcmp(buf, "OK\n"), 0, "strcmp");
> +
> +	ASSERT_EQ(skel->bss->offset, get_uprobe_offset(trigger_func), "offset");
> +	if (one_proc)
> +		ASSERT_EQ(skel->bss->unique_tgid_cnt, 1, "unique_tgid_count");
> +	else
> +		ASSERT_GT(skel->bss->unique_tgid_cnt, 1, "unique_tgid_count");
> +
> +	close(iter_fd);
> +
> +exit:
> +	bpf_link__destroy(link);
> +}
> +
> +static void test_task_vma_offset(void)
> +{
> +	LIBBPF_OPTS(bpf_iter_attach_opts, opts);
> +	union bpf_iter_link_info linfo;
> +
> +	memset(&linfo, 0, sizeof(linfo));
> +	linfo.task.pid = getpid();
> +	opts.link_info = &linfo;
> +	opts.link_info_len = sizeof(linfo);
> +
> +	test_task_vma_offset_common(&opts, true);
> +
> +	linfo.task.pid = 0;
> +	linfo.task.tid = getpid();
> +	test_task_vma_offset_common(&opts, true);
> +
> +	test_task_vma_offset_common(NULL, false);
> +}
> +
>   void test_bpf_iter(void)
>   {
> +	ASSERT_OK(pthread_mutex_init(&do_nothing_mutex, NULL), "pthread_mutex_init");
> +
>   	if (test__start_subtest("btf_id_or_null"))
>   		test_btf_id_or_null();
>   	if (test__start_subtest("ipv6_route"))
> @@ -1335,8 +1569,12 @@ void test_bpf_iter(void)
>   		test_netlink();
>   	if (test__start_subtest("bpf_map"))
>   		test_bpf_map();
> -	if (test__start_subtest("task"))
> -		test_task();
> +	if (test__start_subtest("task_tid"))
> +		test_task_tid();
> +	if (test__start_subtest("task_pid"))
> +		test_task_pid();
> +	if (test__start_subtest("task_pidfd"))
> +		test_task_pidfd();
>   	if (test__start_subtest("task_sleepable"))
>   		test_task_sleepable();
>   	if (test__start_subtest("task_stack"))
> @@ -1397,4 +1635,6 @@ void test_bpf_iter(void)
>   		test_ksym_iter();
>   	if (test__start_subtest("bpf_sockmap_map_iter_fd"))
>   		test_bpf_sockmap_map_iter_fd();
> +	if (test__start_subtest("vma_offset"))
> +		test_task_vma_offset();
>   }
[...]
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_vma_offset.c b/tools/testing/selftests/bpf/progs/bpf_iter_vma_offset.c
> new file mode 100644
> index 000000000000..03db36da5da8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_vma_offset.c
> @@ -0,0 +1,37 @@
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
> +__u32 page_shift = 0;

page_shift is not used here.

> +
> +SEC("iter/task_vma")
> +int get_vma_offset(struct bpf_iter__task_vma *ctx)
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

'12' -> page_shift?

> +		BPF_SEQ_PRINTF(seq, "OK\n");
> +	}
> +	return 0;
> +}
