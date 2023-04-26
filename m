Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DDD6EECCA
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 05:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239315AbjDZDmr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 23:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239221AbjDZDmp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 23:42:45 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E4C10C2
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 20:42:43 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 33PLEBcP029812
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 20:42:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=xOe6tr6MIN7tbYnCOFTxQfDKx7Pd+TwlSXTh5g4zZUk=;
 b=FRD9KIWodrx02ZYhXPwtJ0WBuKnQwZfyx3/IS62A3dpUmaSiMfkpQgtlQRPPeKbaB2q6
 bZqssQVN7wDp8qSwQzEXWr719lg/Atb6YiDPfiiyDcDfAuEsTIE6myroJykHgjT/2Oe5
 KLyMAkV8XVVrCH5cnsTfwIeXkc97Ly9lZwWMfgOsDuXRAFGmHAlhCGf//n6GYHXDcm1V
 Zd4MPCk3xcS+1lWadW/oshpkur4z0OjEOYzugknb6e/8GLKOQHIVbnhWrNiFfa+RDvwB
 4L/oLj+X7JLAi7aWiLylTqn3w5o1IsF7KvlAeneb0mIMshWnPv8QWrydmrXPQQeo2wMX 8Q== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by m0089730.ppops.net (PPS) with ESMTPS id 3q6mgtjt6b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 20:42:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRXz3ktkavhJN3LkV3kwkQKf+2DlPtIWcD+RlpuDiA8IytuytqGV4xO/+UXOzDoEz2x9x0kZ1HUzy5doR5b0n9MPMRa4txUogIzdmLnuOLRYDeKyvjTrlo9T7ZSp7hiwEc02UVPoLosMoUqsLaNExRHXje6UgJp9d3tMopy9/I7SSF8E+kBGwjBabumnWJ8XPvWh83WZWOay4brcJs7Q4AGDsF+hnQFSBLptqHDP8kofb9OVeoD+HmKImIyIv23ZOlTZZijSTeePhLSpnzbQyvT8x0EjvZNZYkmbJ1JnmC5fYjbqq3dYZHMGWLQ4SNrbbnXoM+4FBohTtPvIWj2h8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xOe6tr6MIN7tbYnCOFTxQfDKx7Pd+TwlSXTh5g4zZUk=;
 b=Q9nKFZvxV+t6oN8hVKrfvW59n0ozrGPq266ohMg0sJ6x4geoeiRPEvboZn8E3EK8BNMXdrsFOgSi/en/fThIg0aFSPyTbr9ITYMpC7VTbyAys06D6U30LWI6R7J/lscGO2IgSqtuT9x3770qPuZ5xhL/kLmdh+4NBd+e+nnCHz7yXgqFQeDS36wwx3iA4viWTKB3ampoWeYluWqJfUNfKecKbJRYjKBeGIpyedWecXxEw5wBqwxzalxCzVhP05Cyt+uloLYLackCOIbk8AjU/z6l6fLt1/FdHcBBCPTBbaIIJMFI8Nmj0JzsloBsdEnHcrgAAhZsHJYWWkRTY6AE3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA3PR15MB5701.namprd15.prod.outlook.com (2603:10b6:806:304::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.31; Wed, 26 Apr
 2023 03:42:39 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6319.033; Wed, 26 Apr 2023
 03:42:38 +0000
Message-ID: <4f4cb939-93fd-f1ad-61ab-71cabf6c1d76@meta.com>
Date:   Tue, 25 Apr 2023 20:42:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: extract insert_test from
 parse_test_list
Content-Language: en-US
To:     Stephen Veiss <sveiss@meta.com>, bpf@vger.kernel.org
References: <20230425225401.1075796-1-sveiss@meta.com>
 <20230425225401.1075796-2-sveiss@meta.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230425225401.1075796-2-sveiss@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA3PR15MB5701:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b307964-e8d4-4b33-f02f-08db4608480d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RSZ++I96ka1stHfxq33q0iFowEyCMujqBGB5SexH2/0WRJ2HyRO7FEHPX1o9zQFPTT1ed3/Z4zCZtBpHnBRp1VxMxcZWdXjzZBBwgWTwg44sRtoX+ayQHMt5KR6J9xYfn8P31qNHqIhMRmHD3WWxVU+YPMmiKq3DY2a3VIRYBVwmWcrOhue75rpKImAtuHP6Tjns5orKg6bqTK1k612RUbwoEAHQsvatJY5dO/EUwEalcQAxVQqSaZSPQYQVw+VB0u3sUH42k3OHYeWqKQulUJHviLRtitdTQHT+OzA/KA99y+TfNG11hX+3xwp3CJwkczR9BvGBS/zPZMnbDZWqwHPA+qe492vX9AviuYwn6I4qmW0CZaylqgAKs1sfrl8xiJGKerA/avPSZreDzUqisD7aPA1Je4L/Dx4i3YYyc3Z+yZ1KKrX5BLVcoSwVpRQDeJwJpGaoFcvAwumcwTLvsXkgqvSpwTsJkr/SCPsQOSbigxIBwMGUimDPlFaMgvTY7tYgy3eDZLlb9NsnU9nX3w/Y6ieXk3sJPj2YmIcW84aYWs/5uWhf6sHf+H7yT5JIFSq4KJ/LtKKfvHvFXBNxbulDErJRBJ/4UjQRHxCCzDm5OdlBtQoBz/jCPX16y7JvCFCYoYgYPglI4p3XuOUfbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(451199021)(2616005)(83380400001)(2906002)(5660300002)(31686004)(8676002)(186003)(53546011)(6512007)(8936002)(38100700002)(6506007)(41300700001)(66946007)(36756003)(6486002)(478600001)(86362001)(66476007)(31696002)(66556008)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnRKZFAydlFhc0tTamdHaHhyNnBjU2x2VkRlZGhPWE5RMjFVbHdWOVlOdFdP?=
 =?utf-8?B?Q1J6dHowZjhyVVhXT3QzZmoranlmNjBQT0lET2FJNDY0QURudmw5Mk8zVGRL?=
 =?utf-8?B?aExSSjBNSVlJQ0FlaHZIbWtMQzZ4NGJtaXFGZ0Y1NUEyZ0RnM1k4V2dwZDFC?=
 =?utf-8?B?cFhheU5jSXByVlFacU83aTdER0VNQjlDQU1xQkJBaGI5SWxyblhTV3g3UU1v?=
 =?utf-8?B?NkpRZUNaVC81Vm9xNTE1OEpDL0FudC96SzJEZm8rdmxMTjA4cW1sZ0xoaXNC?=
 =?utf-8?B?OG1BT0lCUlAzTU5PYk9XbzJXUXViaTlOK3pZRXpzNmhyTEhXeXEvdFo5WWNZ?=
 =?utf-8?B?NjhId1JkZHlHVCtjNFgvUHZsWlVtQU9lb2ptT3ZvaUIvenNFRHBDS1pMOHFR?=
 =?utf-8?B?cVJlQWNtelRleWRZOWVCREJMVTZ5S01BdC84Wll0Tkx2MVhUeHoxMkZ2bmJT?=
 =?utf-8?B?UGRuV1dNclB1YlBiS0N6akxwcTJ5VlM1V2xGbWpNVHd1MHNUam1aUTJISXhp?=
 =?utf-8?B?Y295RklKY0RvS2dLOUZpNDVua25yWmdudStZQmdObHFINnBJb0hOeGM4SUxN?=
 =?utf-8?B?REJjMCtCc085QTFMZml4ekdvVW9RTW9oT2VFSGtxaEgwOW5PM2grSWp4THkw?=
 =?utf-8?B?TWlaZTYvSVFhbWpBN0lOcGhDREVLdDh5QzRCdWkvRVZCclZkV0hmeFVTS1FG?=
 =?utf-8?B?UFFrZzM2aGhpVkdOeHZ4QnROYTJTNHRZL1FBVnp0cHdmQm9SVWo5SWJndFZv?=
 =?utf-8?B?c3lTRVdONlVYVGVRRVpwY0luMVd1UCtLaXUydnhnclJpTmlaN0pSbEh1OVRs?=
 =?utf-8?B?eG0wcURtSmxsakExT3VnR21seVg0N0tqbFRiR3RsbTcxem1HVTd4aFpJUktK?=
 =?utf-8?B?dXhBbERQNENLRXBzWWVOQjZpTlZsSWUyNDJFcjhFTUlSdTNIZ1ZoaHUydlpP?=
 =?utf-8?B?S29DYVN5VFRaWnpUaitHOU1za1hoRHNWazI4SG84SnRrV1h5OUtZaVRmUjZ3?=
 =?utf-8?B?bU4wYmVVNE1yelhpWXJqUk5YZGYvTTFhc2Q3VHhoR0dyQTVlSmlOVnRYWDlo?=
 =?utf-8?B?ckRyTCswb0pnTzMrYzA0bDVLMHVmSGI0OEl4OFUwRDV6dUpubm5aMStudzVF?=
 =?utf-8?B?NlFBenRyR1Z2bXFoSXFSdlZWcDdXUE1kZHJraHlmS2V0R0JaemtwU2RIZDRX?=
 =?utf-8?B?ZGVrR0xLSXdpZndzSlE1Y1ExSk1ETFJYWU14ZCtUZmdPQlFlbUE2eHdwVEls?=
 =?utf-8?B?eXFxa083ZkxocnJQOVQ4Q2VtYVZmQ3UrV0EwTi9aMnVlWHNDVS9YOTNGRUZn?=
 =?utf-8?B?YlUyblV5TzlpNng5bHdzaUVYdlpYMWxwSEYvWFh0QVQxYTlHR0FDQ09CSWZW?=
 =?utf-8?B?dVExOWxvejRkdFlyVTFScHRlT0gwc3JKTUE2QUJPZEd3c3pYcGlOU3ZiRlJm?=
 =?utf-8?B?TGlCazJyVVBpOTF0cVhxR2FLdXM5eXVMWTNlWkJkWnFtMUt5WFlNa2RuNFNY?=
 =?utf-8?B?cFZzM00zNytKbmhqUU9zK2huWE1xZ1dmLzhncmo5bjJYQXIvTkRvaktRY1g4?=
 =?utf-8?B?UTFBZW9WaFBHNkdUM04vcFc3NHYzejVMemRNbTE3dllLdHZJUnR6YUh3bW9G?=
 =?utf-8?B?UEZMcmpTZUhTK2dEZktLQ1BSZThicmpVV0d2RUFDZEN4WDZXbXdYaHBQWENs?=
 =?utf-8?B?MmNObUdSOEM0UUl5TkZUWnpyTkJ2WDUyWmJIbWRjUi8vdzlNNTRQclJBU0lH?=
 =?utf-8?B?UkZwSHo4Unl3OWlhelA3Y1U0MDNLRjRPY3Rva2E1Z2tudXcwOW1uUmZMcElo?=
 =?utf-8?B?dWhkeWJ5SUhYaFVXUmtRc3hoSkVPek9YRGdHaHVaZ1ZZNlo2NkxNVE41ekZn?=
 =?utf-8?B?M0RXSUsxV1B4Wk1QMkxDVm9DVUM5RzFiMFNxOURSbE9kZlp1RjhpNVowTmky?=
 =?utf-8?B?YWxhcVpVUmxBVjJFYXpaYTdmVXUxRnp6b1YwZjJDUmlld29TSE1JWEtxSDV0?=
 =?utf-8?B?Q1NIdFFnZ2g4QUtaaXBSZFhnbUxQUGJNaW1OMEtKN3g1eW9Od2FaOXZhVUxS?=
 =?utf-8?B?Q1dvVko2Q0ZRVFlQOWZuR1IrVng4TzlPUnhVeU1lOFJ3cy8wc0ZocXU1dlI5?=
 =?utf-8?B?Ym5SZXFKajc3WFRYV0VXSWs3eDFoQlpBYWllZjFVWng3S3NJSHd1QXJuVk53?=
 =?utf-8?B?a2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b307964-e8d4-4b33-f02f-08db4608480d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 03:42:38.7924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IgcxUvAcpp1KjMNEkQIira/y4P0JrGmMfJT9mZyyzIPMKw8oZOmh1Te8jO65pKM+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB5701
X-Proofpoint-GUID: w0PlyilCXOddbz1abRekdfUISITHGV82
X-Proofpoint-ORIG-GUID: w0PlyilCXOddbz1abRekdfUISITHGV82
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_11,2023-04-25_01,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/25/23 3:54 PM, Stephen Veiss wrote:
> Split the logic to insert new tests into test filter sets out from
> parse_test_list.
> 
> Fix the subtest insertion logic to reuse an existing top-level test
> filter, which prevents the creation of duplicate top-level test filters
> each with a single subtest.
> 
> Signed-off-by: Stephen Veiss <sveiss@meta.com>
> ---
>   .../selftests/bpf/prog_tests/arg_parsing.c    |  13 ++
>   tools/testing/selftests/bpf/testing_helpers.c | 176 +++++++++++-------
>   2 files changed, 117 insertions(+), 72 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> index b17bfa0e0aac..3754cd5f8c0a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> +++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> @@ -96,6 +96,19 @@ static void test_parse_test_list(void)
>   		goto error;
>   	ASSERT_OK(strcmp("*bpf_cookie*", set.tests[0].name), "test name");
>   	ASSERT_OK(strcmp("*trace*", set.tests[0].subtests[0]), "subtest name");
> +	free_test_filter_set(&set);
> +
> +	ASSERT_OK(parse_test_list("t/subtest1,t/subtest2", &set, true),
> +		  "parsing");
> +	if (!ASSERT_EQ(set.cnt, 1, "count of test filters"))
> +		goto error;
> +	if (!ASSERT_OK_PTR(set.tests, "test filters initialized"))
> +		goto error;
> +	if (!ASSERT_EQ(set.tests[0].subtest_cnt, 2, "subtest filters count"))
> +		goto error;
> +	ASSERT_OK(strcmp("t", set.tests[0].name), "test name");
> +	ASSERT_OK(strcmp("subtest1", set.tests[0].subtests[0]), "subtest name");
> +	ASSERT_OK(strcmp("subtest2", set.tests[0].subtests[1]), "subtest name");
>   error:
>   	free_test_filter_set(&set);
>   }
> diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
> index 0b5e0829e5be..14322371e1d8 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.c
> +++ b/tools/testing/selftests/bpf/testing_helpers.c
> @@ -70,92 +70,124 @@ int parse_num_list(const char *s, bool **num_set, int *num_set_len)
>   	return 0;
>   }
>   
> +static int do_insert_test(struct test_filter_set *set,
> +			  char *test_str,
> +			  char *subtest_str)
> +{
> +	struct test_filter *tmp, *test;
> +	char **ctmp;
> +	int i;
> +
> +	for (i = 0; i < set->cnt; i++) {
> +		test = &set->tests[i];
> +
> +		if (strcmp(test_str, test->name) == 0) {
> +			free(test_str);
> +			goto subtest;
> +		}
> +	}
> +
> +	tmp = realloc(set->tests, sizeof(*test) * (set->cnt + 1));
> +	if (!tmp)
> +		return -ENOMEM;
> +
> +	set->tests = tmp;
> +	test = &set->tests[set->cnt];
> +
> +	test->name = test_str;
> +	test->subtests = NULL;
> +	test->subtest_cnt = 0;
> +
> +	set->cnt++;
> +
> +subtest:
> +	if (!subtest_str)
> +		return 0;
> +
> +	for (i = 0; i < test->subtest_cnt; i++) {
> +		if (strcmp(subtest_str, test->subtests[i]) == 0) {
> +			free(subtest_str);
> +			return 0;
> +		}
> +	}
> +
> +	ctmp = realloc(test->subtests,
> +		       sizeof(*test->subtests) * (test->subtest_cnt + 1));
> +	if (!ctmp)
> +		return -ENOMEM;
> +
> +	test->subtests = ctmp;
> +	test->subtests[test->subtest_cnt] = subtest_str;
> +
> +	test->subtest_cnt++;
> +
> +	return 0;
> +}
> +
> +static int insert_test(struct test_filter_set *set,
> +		       char *test_spec,
> +		       bool is_glob_pattern)
> +{
> +	char *pattern, *subtest_str, *ext_test_str, *ext_subtest_str = NULL;
> +	int glob_chars = 0;
> +
> +	if (is_glob_pattern) {
> +		pattern = "%s";
> +	} else {
> +		pattern = "*%s*";
> +		glob_chars = 2;
> +	}
> +
> +	subtest_str = strchr(test_spec, '/');
> +	if (subtest_str) {
> +		*subtest_str = '\0';
> +		subtest_str += 1;
> +	}
> +
> +	ext_test_str = malloc(strlen(test_spec) + glob_chars + 1);
> +	if (!ext_test_str)
> +		goto err;
> +
> +	sprintf(ext_test_str, pattern, test_spec);
> +
> +	if (subtest_str) {
> +		ext_subtest_str = malloc(strlen(subtest_str) + glob_chars + 1);
> +		if (!ext_subtest_str)
> +			goto err;
> +
> +		sprintf(ext_subtest_str, pattern, subtest_str);
> +	}
> +
> +	return do_insert_test(set, ext_test_str, ext_subtest_str);
> +
> +err:
> +	free(ext_test_str);
> +	free(ext_subtest_str);
> +
> +	return -ENOMEM;
> +}
> +
>   int parse_test_list(const char *s,
>   		    struct test_filter_set *set,
>   		    bool is_glob_pattern)
>   {
> -	char *input, *state = NULL, *next;
> -	struct test_filter *tmp, *tests = NULL;
> -	int i, j, cnt = 0;
> +	char *input, *state = NULL, *test_spec;
> +	int err;
>   
>   	input = strdup(s);
>   	if (!input)
>   		return -ENOMEM;
>   
> -	while ((next = strtok_r(state ? NULL : input, ",", &state))) {
> -		char *subtest_str = strchr(next, '/');
> -		char *pattern = NULL;
> -		int glob_chars = 0;
> -
> -		tmp = realloc(tests, sizeof(*tests) * (cnt + 1));
> -		if (!tmp)
> -			goto err;
> -		tests = tmp;
> -
> -		tests[cnt].subtest_cnt = 0;
> -		tests[cnt].subtests = NULL;
> -
> -		if (is_glob_pattern) {
> -			pattern = "%s";
> -		} else {
> -			pattern = "*%s*";
> -			glob_chars = 2;
> +	while ((test_spec = strtok_r(state ? NULL : input, ",", &state))) {
> +		err = insert_test(set, test_spec, is_glob_pattern);
> +		if (err) {
> +			free(input);
> +			return err;
>   		}
> -
> -		if (subtest_str) {
> -			char **tmp_subtests = NULL;
> -			int subtest_cnt = tests[cnt].subtest_cnt;
> -
> -			*subtest_str = '\0';
> -			subtest_str += 1;
> -			tmp_subtests = realloc(tests[cnt].subtests,
> -					       sizeof(*tmp_subtests) *
> -					       (subtest_cnt + 1));
> -			if (!tmp_subtests)
> -				goto err;
> -			tests[cnt].subtests = tmp_subtests;
> -
> -			tests[cnt].subtests[subtest_cnt] =
> -				malloc(strlen(subtest_str) + glob_chars + 1);
> -			if (!tests[cnt].subtests[subtest_cnt])
> -				goto err;
> -			sprintf(tests[cnt].subtests[subtest_cnt],
> -				pattern,
> -				subtest_str);
> -
> -			tests[cnt].subtest_cnt++;
> -		}
> -
> -		tests[cnt].name = malloc(strlen(next) + glob_chars + 1);
> -		if (!tests[cnt].name)
> -			goto err;
> -		sprintf(tests[cnt].name, pattern, next);
> -
> -		cnt++;
>   	}
>   
> -	tmp = realloc(set->tests, sizeof(*tests) * (cnt + set->cnt));
> -	if (!tmp)
> -		goto err;
> -
> -	memcpy(tmp +  set->cnt, tests, sizeof(*tests) * cnt);
> -	set->tests = tmp;
> -	set->cnt += cnt;
> -
> -	free(tests);
>   	free(input);
>   	return 0;
> -
> -err:
> -	for (i = 0; i < cnt; i++) {
> -		for (j = 0; j < tests[i].subtest_cnt; j++)
> -			free(tests[i].subtests[j]);
> -
> -		free(tests[i].name);
> -	}
> -	free(tests);
> -	free(input);
> -	return -ENOMEM;
>   }

LGTM.
For parse_test_list() function, maybe using the following code which
is more in kernel coding style.

int parse_test_list(const char *s,
                     struct test_filter_set *set,
                     bool is_glob_pattern)
{
         char *input, *state = NULL, *test_spec;
         int err = 0;

         input = strdup(s);
         if (!input)
                 return -ENOMEM;

         while ((test_spec = strtok_r(state ? NULL : input, ",", &state))) {
                 err = insert_test(set, test_spec, is_glob_pattern);
                 if (err)
                         break;
         }

         free(input);
         return err;
}

>   
>   __u32 link_info_prog_id(const struct bpf_link *link, struct bpf_link_info *info)
