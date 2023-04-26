Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620BB6EECF0
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 06:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238440AbjDZEZt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 00:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjDZEZs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 00:25:48 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAED51FC8
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 21:25:46 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PME196026745
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 21:25:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=L8BcfXw5PUDH36qq0lPZKGO0jrI9voLPrqeNZBCusH8=;
 b=UJ8XmIMHQp8iRYrFMnRmmnBhpaT1SYzZNzNJxEllEZ3Jg2f/QVADJ4iifPB4+kUnH/uk
 Yn08hZfHIXYOZ+9X1Gv2OYnVarXBa5xWq7rQYTuiVINiD4uJs2/f+DQqRLcZvJ1jBchh
 8HdIpS1U4h015lHmIklDBqCL96uj79GI4LURVy+8TpymkoSN22HTtZ6scu3KLGQNmocI
 e431bD0Lq/8HlUigupfzUW6WuYpBRO0nF+JnAXkIOSE6esZe8mhrfQGE9oIuMyGZMxVZ
 pdo+SN6h3/Z6M8aFPbexqZawbXeJ0r45AIJmfkva2ZESAUz8w2DcLoIY41uPk9Ykjzxm ZQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q6qfksp4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 21:25:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6UX2J75oFFLLt1hEdgtqkshfkLvONLGuqcsQrnK/JN/mU9XvKk2JI1Z/eJU14eW3gXrZnKhF1dn/5bBPf0VTsMB/EK3MScxvXR+tEibHUvtXJrJCPKupB7QuJWzP5npyuErR1uUZiujGWo6VUpMsLLuPqo5VJdyi4eQHlfoGAQhHddzQnJFSBxVTipLSM/KK59k/qbrPmmgje9SCrzS1AMcxhTq6v0qLD2XI/shrNnyCgUJefQ4LtKFQG+1YxsJQd/FH4bveVZ59I8tBt4AaOyjj4O/fx5Lj3W5Zr192QCtelHZ7Wgl4I1xS5hL2oJtEemkV6ZsQODhLNp2bohk6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8BcfXw5PUDH36qq0lPZKGO0jrI9voLPrqeNZBCusH8=;
 b=gFGAFai/uM59SJGjH00sQ5toeGSlP9g5hYEnTz+XU+IVWgYsmY4HpQmeHbexJSX/LRuWOqZiW5ABqLhLdc/Q4264rUFdd7/qrt/mPV6L/cjnER1DegH8We2ytBfA93mKrVhJB548c5PZ9MGiMPHDV7zimvp6ikShO6a6S2j/RCmi1zeEEXl2caDAht9omj3cJ5O6TpgrLVaGdgXz2g1Xsw1T8h5EcwxEYkftDOpRiu9A4Pn/SlDwgUwKOuTN1ldpDKmXBfMDm38dNns2tjLKfu5dHikVW9i5esecMcJjaFZS4n4xK4ooPVrjHwtK9zSADzTGyoQml4DnzpkA5yqRzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM4PR15MB5429.namprd15.prod.outlook.com (2603:10b6:8:8b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.20; Wed, 26 Apr
 2023 04:25:44 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6319.033; Wed, 26 Apr 2023
 04:25:43 +0000
Message-ID: <3c83f3ae-c707-1852-57a6-18ac295a9f79@meta.com>
Date:   Tue, 25 Apr 2023 21:25:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: test_progs can read test
 lists from file
Content-Language: en-US
To:     Stephen Veiss <sveiss@meta.com>, bpf@vger.kernel.org
References: <20230425225401.1075796-1-sveiss@meta.com>
 <20230425225401.1075796-3-sveiss@meta.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230425225401.1075796-3-sveiss@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::8) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM4PR15MB5429:EE_
X-MS-Office365-Filtering-Correlation-Id: c70aa36d-5067-4fb8-7728-08db460e4c9a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TtMCiLhjOp3vM08fYepPymKN8KhFqdy32VmNFypmmLis4zmRwVnl56udXo/Mwc6nW3F1e4Fb3P4Mg3/7m+tdFMLttoZNKIoPgL1uqta5TUkkrB13yaBIfprQmSyC45qN409CXRqsxXOgTWxXx8fEW9WUm9oohEZt3FamGwBsd2coS2EBpTalZaDXXa4cX4F+vNllE8her2mD+J8O5ridvKKBZpy273n2AW8Mcs309aI7Cn5YP9u49ZEJGXHG4pwqurW/IwZiVf4k+QZQSRw1SmnHPFWQ7NWbbdbieGWp030hXrvMoJ5pu7gl6n434MdiNLAiNHaA90SZZejL9epkRTxy31AHxWWz9jsawo5fo6Cpr8wq/+QmqJxSlfkeQBoy5XTtQc3dt+2tllzsvWcPS84+vqyL7iK+EYWNpjoP7/m6MOfPKGOYcFuyRU+KUc1xzhruM0ZSkFSHve1KJXb10dpJyzeMksYM1+7W8iipxMTDS6IBaXqQSPMNR0xDeNJ6LoMBogILYFicXFcKjyj5J6m6sO3igdiL8FaLQSrZKsPvlNuMJmWaYS7HllJ2puyw2C3etTZXAQym/5rDJJF1V8z6P1QbBHfDrCUQgpnu3dKBd+iynTcroKTM2x0+hvjZw+My2u4v2D3P5f4xadJNIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199021)(53546011)(6506007)(186003)(6512007)(316002)(66476007)(66556008)(5660300002)(66946007)(6486002)(31686004)(83380400001)(2616005)(31696002)(36756003)(8676002)(8936002)(2906002)(478600001)(86362001)(38100700002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlE5alA3RG1vSjZNTnQwTnZNR0g3OE9rYmloVTQvcWMxUFVJOERpZDFXMnBZ?=
 =?utf-8?B?bUk4ZkNhcGY1ejlaVFNVWnV4VVBoYnpsalFQNkVNZkVrRkJJaE1GVzNvSCtR?=
 =?utf-8?B?RWZLcVFPdy9RMlY3dEo3Q1hFMmxDdVlWV2wrVlQ1WGxFZHRUQklzd29iTTcz?=
 =?utf-8?B?eUN4UVF5KzlOaTJ3OVdSa1V6WnZtbURXQnJvbkc3THlSalo2WlN6dW10QTE5?=
 =?utf-8?B?S0tLcUpwd0NoWktUbGtTT2JzbitnaEh4QitvT3RxaCsybDVTdzVQUWxJbHdj?=
 =?utf-8?B?THpBdmxESnZMTGU0dXN1OUpwZ2M5Y2ZIdm9oQ2dUbnJOeDlQeTlYNUcydDds?=
 =?utf-8?B?UEZTakZEUWRyTnVtSjVQUktWT1dzWkpIejVqR3czVUwxTzhCS1dRQXZVNndi?=
 =?utf-8?B?SEVzMnN3SkdERnZOTTgrNmEyK2lhTzA4QmtnTzAranFmd2wzT1d6TFltZjhP?=
 =?utf-8?B?WjJpNFlRdEVacm9EZFZXejZDeTNxN3IwNzUyMmdVREFZeUNVSUdJaHNkK0d2?=
 =?utf-8?B?b3Bvd2hxZ0h2Mzh5d2JhaGQyTVUrQW5QamhKL0N5Wmw2UzVQOUNmcyt2VzFW?=
 =?utf-8?B?RHNtVkMveEZSZjRvbzh3SXM3cGM3R04zTWF3NkZDMHFtWlJOVWFRUmFNd29L?=
 =?utf-8?B?MUFvRmtFeURlVXRLb3FPeXIzSmlFdkZuK29wdXVGWGVQVDMxT0J5RlFOMFpW?=
 =?utf-8?B?RjVOZC9QZUcybnBKT3JHbUpUWVZ0bDhPa1QyZWxDc0Fpa01GQzJWR1AycHBn?=
 =?utf-8?B?TENKRUhiTU02R1BKbkJRdlJFYTJJYW93RlgvQTl4UUhHWHNpbHF2b25OcUlO?=
 =?utf-8?B?QmdnOXZaU1lVbjBqbWUveUlxbG9SalBQMXAvRy9MTUpaODZWM0t1OTl5R1A0?=
 =?utf-8?B?ZHh0ckNRdkczTTd5ZStMd1dKa0puOHFxaklwTTIrRjlrY05jWmR0Sm9uZVJv?=
 =?utf-8?B?Tkc2a1ZNdXlBcDVlT1gzN2JzenI4M0NJTVNmbnZ3Vm9KcCtiUWtJTThqU0tt?=
 =?utf-8?B?cjZ3N3BoOTdFQkRuRUVtZTRkc2lEZTUrQ3Q1c0tFUXI5YlluMkhXbkROeDNx?=
 =?utf-8?B?blRtdTM1U3JwZzNTaC8vS1crWjU5cmR5NDVYdXZMQjJHR09WRENwQWtGWWd3?=
 =?utf-8?B?TXFnQmJkSE5vbHVHOWFaQUNmYmdTb2c2WVFhYzhEL3djVEpyVWJEajdxNG1r?=
 =?utf-8?B?M1c5bHYrOFRLMFpDUUp3aFFmWXlLbmpPQVk1UEoxTTVwVHkxendoTDU3N1Ra?=
 =?utf-8?B?YzVzMkNZOWxHTkllejVpQ1Q5ZUg2cEJ1dGZxcWwrNm1rQ0NscXVhaHVMNGlU?=
 =?utf-8?B?ekdmdDBEV3R6YUQvUW9oZSthNjJVMnExMW9VZllUVnEwUE1CbjhGOFdTQVk5?=
 =?utf-8?B?VFFiQ2x5cEtiNkdNU1gybjA4SlYzaXdCRFpVRHZKaTlwM1FZN0pVTWVSOTBu?=
 =?utf-8?B?Q0YwMjY1V3h3cTdTRjlzMThzVHJqcmIrN2g0NWhqTnRLWjdZV3h1eHAvQXps?=
 =?utf-8?B?UEJqenMyYmQ1V1lEbU0xWTVRaGRTSEIvRVplZE9vMk9nUkFDSWQ0Wi9STUFW?=
 =?utf-8?B?U1VsbWExRTRMMG5sREplcUFqN24zUU9Lakhiano5THJQV21mN29yTWkzY0Ny?=
 =?utf-8?B?Z2pqQmJRaEVoR05lM21ha3E2RTVzSXRMdU43TWFNN1JyMzEyblZ4Tk0zbVVi?=
 =?utf-8?B?QmZZN3BWZTU5anFPaS9GbDhHS1BWRlYxY3lTUk1MR1VLR0xUdVA3QWh4OGFN?=
 =?utf-8?B?b0w0bU9MQVBOa3g5ZDIyWU43NGE0bHR3WEYvbVI4QXdyTzhxU2llelRkQThC?=
 =?utf-8?B?NlAzN1lsMXVLZzFKT3pNa1A4VmQvM1ZYb05ldVEvYkpPRE8ySWo5U3BUMWky?=
 =?utf-8?B?MGlrZDJRQUNXSWNFMGpnbUpzWnhTbWF0V2VqUUFWK0NYdVVpUFZnVDVSMi9B?=
 =?utf-8?B?TjRNdHRkV2JjQjFSUnZIaDZRbC8rcHYvQThLVi9rNnREMHJSOFlwc3ZrOXdz?=
 =?utf-8?B?T3BFdXVKSG5jTzZtMVd6SmsydUt3WVJYSk1nenRVQ1F0L3RTMjFIakVUZVdO?=
 =?utf-8?B?bDl3TjYzRW8zRlNUbGlBWHlhdW4vVUpDUlc2OXJZVUJJMjZ0eC9rZm9DQWVx?=
 =?utf-8?B?LzdtQ0FPRjN3aHM4ZHRDYlVTVExpbWlFbnk0Nm4wV0pQR2hSdHZvT3NTWmcy?=
 =?utf-8?B?VUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70aa36d-5067-4fb8-7728-08db460e4c9a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 04:25:43.3358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9x9oJTv3lr18ix7sI/lSOqK1Dt5jKBwFJr9iT5ZlKeEzFnlS+iKtk2jM1Fn0y4PM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5429
X-Proofpoint-GUID: Rruh-FAl0t_Lgk7L1dJ2zpuZRq5w85rS
X-Proofpoint-ORIG-GUID: Rruh-FAl0t_Lgk7L1dJ2zpuZRq5w85rS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_01,2023-04-25_01,2023-02-09_01
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
> Improve test selection logic when using -a/-b/-d/-t options.
> The list of tests to include or exclude can now be read from a file,
> specified as @<filename>.
> 
> The file contains one name (or wildcard pattern) per line, and
> comments beginning with # are ignored.
> 
> These options can be passed multiple times to read more than one file.
> 
> Signed-off-by: Stephen Veiss <sveiss@meta.com>

LGTM. A few nits below.

> ---
>   .../selftests/bpf/prog_tests/arg_parsing.c    | 50 +++++++++++++++++++
>   tools/testing/selftests/bpf/test_progs.c      | 39 +++++++++++----
>   tools/testing/selftests/bpf/testing_helpers.c | 49 ++++++++++++++++++
>   tools/testing/selftests/bpf/testing_helpers.h |  3 ++
>   4 files changed, 132 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> index 3754cd5f8c0a..e0c6ef2dda70 100644
> --- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> +++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> @@ -113,8 +113,58 @@ static void test_parse_test_list(void)
>   	free_test_filter_set(&set);
>   }
>   
> +static void test_parse_test_list_file(void)
> +{
> +	char tmpfile[80];
> +	int fd;
> +	FILE *fp;
> +	struct test_filter_set set;
> +
> +	snprintf(tmpfile, sizeof(tmpfile), "/tmp/bpf_arg_parsing_test.XXXXXX");
> +	fd = mkstemp(tmpfile);
> +	ASSERT_GE(fd, 0, "create tmp");

If ASSERT_GE(...) is not true, we should simply return.

> +
> +	fp = fdopen(fd, "w");

We should check whether fp is NULL or not, if it is we should close fd 
and return (basically go to 'error').

> +
> +	fprintf(fp, "# comment\n");
> +	fprintf(fp, "  test_with_spaces    \n");
> +	fprintf(fp, "testA/subtest    # comment\n");
> +	fprintf(fp, "testB#comment with no space\n");
> +	fprintf(fp, "testB # duplicate\n");
> +	fprintf(fp, "testA/subtest # subtest duplicate\n");
> +	fprintf(fp, "testA/subtest2\n");
> +	fprintf(fp, "testC_no_eof_newline");
> +
> +	if (!ASSERT_OK(ferror(fp), "prepare tmp"))
> +		goto error;
> +
> +	if (!ASSERT_OK(fclose(fp), "close tmp"))
> +		goto error;
> +
> +	init_test_filter_set(&set);
> +
> +	ASSERT_OK(parse_test_list_file(tmpfile, &set, true), "parse file");
> +
> +	ASSERT_EQ(set.cnt, 4, "test  count");
> +	ASSERT_OK(strcmp("test_with_spaces", set.tests[0].name), "test 0 name");
> +	ASSERT_EQ(set.tests[0].subtest_cnt, 0, "test 0 subtest count");
> +	ASSERT_OK(strcmp("testA", set.tests[1].name), "test 1 name");
> +	ASSERT_EQ(set.tests[1].subtest_cnt, 2, "test 1 subtest count");
> +	ASSERT_OK(strcmp("subtest", set.tests[1].subtests[0]), "test 1 subtest 0");
> +	ASSERT_OK(strcmp("subtest2", set.tests[1].subtests[1]), "test 1 subtest 1");
> +	ASSERT_OK(strcmp("testB", set.tests[2].name), "test 2 name");
> +	ASSERT_OK(strcmp("testC_no_eof_newline", set.tests[3].name), "test 3 name");
> +
> +	free_test_filter_set(&set);
> +
> +error:
> +	remove(tmpfile);

Maybe do 'close(fd)' instead which is more intuitive?

> +}
> +
>   void test_arg_parsing(void)
>   {
>   	if (test__start_subtest("test_parse_test_list"))
>   		test_parse_test_list();
> +	if (test__start_subtest("test_parse_test_list_file"))
> +		test_parse_test_list_file();
>   }
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
> index ea82921110da..cf80d28c76e8 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -714,7 +714,13 @@ static struct test_state test_states[ARRAY_SIZE(prog_test_defs)];
>   
>   const char *argp_program_version = "test_progs 0.1";
>   const char *argp_program_bug_address = "<bpf@vger.kernel.org>";
> -static const char argp_program_doc[] = "BPF selftests test runner";
> +static const char argp_program_doc[] =
> +"BPF selftests test runner\v"

What does it mean to use "\v" here?

> +"Options accepting the NAMES parameter take either a comma-separated list\n"
> +"of test names, or a filename prefixed with @. The file contains one name\n"
> +"(or wildcard pattern) per line, and comments beginning with # are ignored.\n"
> +"\n"
> +"These options can be passed repeatedly to read multiple files.\n";
>   
>   enum ARG_KEYS {
>   	ARG_TEST_NUM = 'n',
> @@ -797,6 +803,7 @@ extern int extra_prog_load_log_flags;
>   static error_t parse_arg(int key, char *arg, struct argp_state *state)
>   {
>   	struct test_env *env = state->input;
> +	int err;

Maybe initialize 'err = 0' and change later 'return 0' to 'return err',
so we don't need 'if (err) return err' below?

>   
>   	switch (key) {
>   	case ARG_TEST_NUM: {
> @@ -821,18 +828,32 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
>   	}
>   	case ARG_TEST_NAME_GLOB_ALLOWLIST:
>   	case ARG_TEST_NAME: {
> -		if (parse_test_list(arg,
> -				    &env->test_selector.whitelist,
> -				    key == ARG_TEST_NAME_GLOB_ALLOWLIST))
> -			return -ENOMEM;
> +		if (arg[0] == '@')
> +			err = parse_test_list_file(arg + 1,
> +						   &env->test_selector.whitelist,
> +						   key == ARG_TEST_NAME_GLOB_ALLOWLIST);
> +		else
> +			err = parse_test_list(arg,
> +					      &env->test_selector.whitelist,
> +					      key == ARG_TEST_NAME_GLOB_ALLOWLIST);
> +
> +		if (err)
> +			return err;
>   		break;
>   	}
>   	case ARG_TEST_NAME_GLOB_DENYLIST:
>   	case ARG_TEST_NAME_BLACKLIST: {
> -		if (parse_test_list(arg,
> -				    &env->test_selector.blacklist,
> -				    key == ARG_TEST_NAME_GLOB_DENYLIST))
> -			return -ENOMEM;
> +		if (arg[0] == '@')
> +			err = parse_test_list_file(arg + 1,
> +						   &env->test_selector.blacklist,
> +						   key == ARG_TEST_NAME_GLOB_DENYLIST);
> +		else
> +			err = parse_test_list(arg,
> +					      &env->test_selector.blacklist,
> +					      key == ARG_TEST_NAME_GLOB_DENYLIST);
> +
> +		if (err)
> +			return err;
>   		break;
>   	}
>   	case ARG_VERIFIER_STATS:
> diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
> index 14322371e1d8..d8bea5c2a4d6 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.c
> +++ b/tools/testing/selftests/bpf/testing_helpers.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>   /* Copyright (C) 2019 Netronome Systems, Inc. */
>   /* Copyright (C) 2020 Facebook, Inc. */
> +#include <ctype.h>
>   #include <stdlib.h>
>   #include <string.h>
>   #include <errno.h>
> @@ -167,6 +168,54 @@ static int insert_test(struct test_filter_set *set,
>   	return -ENOMEM;
>   }
>   
> +int parse_test_list_file(const char *path,
> +			 struct test_filter_set *set,
> +			 bool is_glob_pattern)
> +{
> +	FILE *f;
> +	size_t buflen = 0;
> +	char *buf = NULL, *capture_start, *capture_end, *scan_end;
> +	int err;
> +
> +	f = fopen(path, "r");
> +	if (!f) {
> +		err = -errno;
> +		fprintf(stderr, "Failed to open '%s': %d\n", path, err);
> +		return err;
> +	}
> +
> +	while (getline(&buf, &buflen, f) != -1) {
> +		capture_start = buf;
> +
> +		while (isspace(*capture_start))
> +			++capture_start;
> +
> +		capture_end = capture_start;
> +		scan_end = capture_start;
> +
> +		while (*scan_end && *scan_end != '#') {
> +			if (!isspace(*scan_end))
> +				capture_end = scan_end;
> +
> +			++scan_end;
> +		}
> +
> +		if (capture_end == capture_start)
> +			continue;
> +
> +		*(++capture_end) = '\0';
> +
> +		err = insert_test(set, capture_start, is_glob_pattern);
> +		if (err) {
> +			fclose(f);
> +			return err;

Set initial err = 0 and later 'return 0' => 'return err', so we
just do break here to avoid calling fclose(f) in two different
places?

> +		}
> +	}
> +
> +	fclose(f);
> +	return 0;
> +}
> +
>   int parse_test_list(const char *s,
>   		    struct test_filter_set *set,
>   		    bool is_glob_pattern)
> diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
> index eb8790f928e4..98f09bbae86f 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.h
> +++ b/tools/testing/selftests/bpf/testing_helpers.h
> @@ -20,5 +20,8 @@ struct test_filter_set;
>   int parse_test_list(const char *s,
>   		    struct test_filter_set *test_set,
>   		    bool is_glob_pattern);
> +int parse_test_list_file(const char *path,
> +			 struct test_filter_set *test_set,
> +			 bool is_glob_pattern);
>   
>   __u64 read_perf_max_sample_freq(void);
