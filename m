Return-Path: <bpf+bounces-9391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 721A3796F6B
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 05:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847DF1C20A92
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 03:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F61EECD;
	Thu,  7 Sep 2023 03:53:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D2BEA9
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 03:53:17 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D704D11B
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 20:53:14 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bf078d5f33so4608965ad.3
        for <bpf@vger.kernel.org>; Wed, 06 Sep 2023 20:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694058794; x=1694663594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=67tSUMEldur0NgvWSbOxWYnnRkVagNN+OsAVdU6/3F0=;
        b=ehX6ZvbLtAinEjBObmJxy4VKnm+yNdwGAV77G7+PMvu+qnYnsojUolfC28SU2k2t9I
         L246EghwzUlBOBEvP3vZBgwQtMlRc6IFGritk961n6FRCDkTj35+OxO1uMKklyQjAJ7J
         AGq64YcGoN9ispFcxfiQd+RNv+FEhkzKeUtw/pw2tOhmLVjKoGqRlhUEdCMsBTF6Svw3
         uJNPTiyI3CvNbbGmOHzNiPUxcnEYb06+v4a+iqXyriRsLKWIqy8WS2uuMz99SN02YGFC
         lFC6/zLlVaQ6DfGu3O6+ir8z25VaKwP7RhLXYBZWJRuLIFbNrPgDxMudPNouYmgVmPg5
         KSdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694058794; x=1694663594;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=67tSUMEldur0NgvWSbOxWYnnRkVagNN+OsAVdU6/3F0=;
        b=ScUtWSwYDs37QwTlqNTsFxQtHvYFe813dOnPUghLvpCnnBxh11psegsg/CD0MjIp/R
         jC6PikXsBzb087BnZLRXGEbICjGU25MmNwMpg2mGt6XQDGQAIEZcw45dmaCtYARxCuLW
         Jyhl5oWPADP2DRfK9HSpZ4jVh2KQihgPc3ZATV1SAbpmpCvQtxKrodMm9Im4Oa+5SwKJ
         SidDjdCN424k9onR7Ac8fDAYzNt/I5Anvw1SUxgQG6wXxYBp9c6SN/qWAhzyN6DuTdOA
         vUYQjVSque7hcwJduimvmUeoCGsPDT/rU1NbeedQi1vHI5tAXP5hVKvfyzmLL+HxrRSh
         NWXw==
X-Gm-Message-State: AOJu0YySLQS9uKtm+KSxBa4YL0pKUIqC7FfJrZJd34wFiD4g2so2ruyL
	rB23dr7ckXh24dzaxOGPXhW1SyinH/k=
X-Google-Smtp-Source: AGHT+IHXw0OAYU3c+9sW/5OrY2ZpF2t8DF0oV5YCIQuJKfXcJFkwZtIL1dR9+hTkmiPxTdkHkTtTCA==
X-Received: by 2002:a17:902:d4ce:b0:1bc:6799:3f6c with SMTP id o14-20020a170902d4ce00b001bc67993f6cmr21703360plg.35.1694058794085;
        Wed, 06 Sep 2023 20:53:14 -0700 (PDT)
Received: from [10.22.67.252] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id d1-20020a170903230100b001bb99e188fcsm11786634plh.194.2023.09.06.20.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 20:53:13 -0700 (PDT)
Message-ID: <185859be-f2e4-011e-864c-b7dd2662d090@gmail.com>
Date: Thu, 7 Sep 2023 11:53:09 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [RFC PATCH bpf-next v4 4/4] selftests/bpf: Add testcases for
 tailcall infinite loop fixing
Content-Language: en-US
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 iii@linux.ibm.com, jakub@cloudflare.com, bpf@vger.kernel.org
References: <20230903151448.61696-1-hffilwlqm@gmail.com>
 <20230903151448.61696-5-hffilwlqm@gmail.com> <ZPjsnjoS/nh7aMcF@boxer>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <ZPjsnjoS/nh7aMcF@boxer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/9/23 05:18, Maciej Fijalkowski wrote:
> On Sun, Sep 03, 2023 at 11:14:48PM +0800, Leon Hwang wrote:
>> Add 4 test cases to confirm the tailcall infinite loop bug has been fixed.
>>
>> Like tailcall_bpf2bpf cases, do fentry/fexit on the bpf2bpf, and then
>> check the final count result.
>>
>> tools/testing/selftests/bpf/test_progs -t tailcalls
>> 226/13  tailcalls/tailcall_bpf2bpf_fentry:OK
>> 226/14  tailcalls/tailcall_bpf2bpf_fexit:OK
>> 226/15  tailcalls/tailcall_bpf2bpf_fentry_fexit:OK
>> 226/16  tailcalls/tailcall_bpf2bpf_fentry_entry:OK
>> 226     tailcalls:OK
>> Summary: 1/16 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
>> ---
>>  .../selftests/bpf/prog_tests/tailcalls.c      | 299 ++++++++++++++++++
>>  .../bpf/progs/tailcall_bpf2bpf_fentry.c       |  18 ++
>>  .../bpf/progs/tailcall_bpf2bpf_fexit.c        |  18 ++
>>  3 files changed, 335 insertions(+)
>>  create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
>> index b20d7f77a5bce..331b4e455ad06 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
>> @@ -884,6 +884,297 @@ static void test_tailcall_bpf2bpf_6(void)
>>  	tailcall_bpf2bpf6__destroy(obj);
>>  }
>>  
>> +static void tailcall_bpf2bpf_fentry_fexit(bool test_fentry, bool test_fexit)
>> +{
>> +	struct bpf_object *tgt_obj = NULL, *fentry_obj = NULL, *fexit_obj = NULL;
>> +	struct bpf_link *fentry_link = NULL, *fexit_link = NULL;
>> +	int err, map_fd, prog_fd, main_fd, data_fd, i, val;
>> +	struct bpf_map *prog_array, *data_map;
>> +	struct bpf_program *prog;
>> +	char buff[128] = {};
>> +
>> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
>> +		.data_in = buff,
>> +		.data_size_in = sizeof(buff),
>> +		.repeat = 1,
>> +	);
>> +
>> +	err = bpf_prog_test_load("tailcall_bpf2bpf2.bpf.o",
>> +				 BPF_PROG_TYPE_SCHED_CLS,
>> +				 &tgt_obj, &prog_fd);
>> +	if (!ASSERT_OK(err, "load tgt_obj"))
>> +		return;
>> +
>> +	prog = bpf_object__find_program_by_name(tgt_obj, "entry");
>> +	if (!ASSERT_OK_PTR(prog, "find entry prog"))
>> +		goto out;
>> +
>> +	main_fd = bpf_program__fd(prog);
>> +	if (!ASSERT_FALSE(main_fd < 0, "find entry prog fd"))
>> +		goto out;
>> +
>> +	prog_array = bpf_object__find_map_by_name(tgt_obj, "jmp_table");
>> +	if (!ASSERT_OK_PTR(prog_array, "find jmp_table map"))
>> +		goto out;
>> +
>> +	map_fd = bpf_map__fd(prog_array);
>> +	if (!ASSERT_FALSE(map_fd < 0, "find jmp_table map fd"))
>> +		goto out;
>> +
>> +	prog = bpf_object__find_program_by_name(tgt_obj, "classifier_0");
>> +	if (!ASSERT_OK_PTR(prog, "find classifier_0 prog"))
>> +		goto out;
>> +
>> +	prog_fd = bpf_program__fd(prog);
>> +	if (!ASSERT_FALSE(prog_fd < 0, "find classifier_0 prog fd"))
>> +		goto out;
>> +
>> +	i = 0;
>> +	err = bpf_map_update_elem(map_fd, &i, &prog_fd, BPF_ANY);
>> +	if (!ASSERT_OK(err, "update jmp_table"))
>> +		goto out;
>> +
>> +	if (test_fentry) {
>> +		fentry_obj = bpf_object__open_file("tailcall_bpf2bpf_fentry.bpf.o",
>> +						   NULL);
>> +		if (!ASSERT_OK_PTR(fentry_obj, "open fentry_obj file"))
>> +			goto out;
>> +
>> +		prog = bpf_object__find_program_by_name(fentry_obj, "fentry");
>> +		if (!ASSERT_OK_PTR(prog, "find fentry prog"))
>> +			goto out;
>> +
>> +		err = bpf_program__set_attach_target(prog, prog_fd,
>> +						     "subprog_tail");
>> +		if (!ASSERT_OK(err, "set_attach_target subprog_tail"))
>> +			goto out;
>> +
>> +		err = bpf_object__load(fentry_obj);
>> +		if (!ASSERT_OK(err, "load fentry_obj"))
>> +			goto out;
>> +
>> +		fentry_link = bpf_program__attach_trace(prog);
>> +		if (!ASSERT_OK_PTR(fentry_link, "attach_trace"))
>> +			goto out;
>> +	}
>> +
>> +	if (test_fexit) {
>> +		fexit_obj = bpf_object__open_file("tailcall_bpf2bpf_fexit.bpf.o",
>> +						  NULL);
>> +		if (!ASSERT_OK_PTR(fexit_obj, "open fexit_obj file"))
>> +			goto out;
>> +
>> +		prog = bpf_object__find_program_by_name(fexit_obj, "fexit");
>> +		if (!ASSERT_OK_PTR(prog, "find fexit prog"))
>> +			goto out;
>> +
>> +		err = bpf_program__set_attach_target(prog, prog_fd,
>> +						     "subprog_tail");
>> +		if (!ASSERT_OK(err, "set_attach_target subprog_tail"))
>> +			goto out;
>> +
>> +		err = bpf_object__load(fexit_obj);
>> +		if (!ASSERT_OK(err, "load fexit_obj"))
>> +			goto out;
>> +
>> +		fexit_link = bpf_program__attach_trace(prog);
>> +		if (!ASSERT_OK_PTR(fexit_link, "attach_trace"))
>> +			goto out;
>> +	}
>> +
>> +	err = bpf_prog_test_run_opts(main_fd, &topts);
>> +	ASSERT_OK(err, "tailcall");
>> +	ASSERT_EQ(topts.retval, 1, "tailcall retval");
>> +
>> +	data_map = bpf_object__find_map_by_name(tgt_obj, "tailcall.bss");
>> +	if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
>> +			  "find tailcall.bss map"))
>> +		goto out;
>> +
>> +	data_fd = bpf_map__fd(data_map);
>> +	if (!ASSERT_FALSE(data_fd < 0, "find tailcall.bss map fd"))
>> +		goto out;
>> +
>> +	i = 0;
>> +	err = bpf_map_lookup_elem(data_fd, &i, &val);
>> +	ASSERT_OK(err, "tailcall count");
>> +	ASSERT_EQ(val, 33, "tailcall count");
>> +
>> +	if (test_fentry) {
>> +		data_map = bpf_object__find_map_by_name(fentry_obj, ".bss");
>> +		if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
>> +				  "find tailcall_bpf2bpf_fentry.bss map"))
>> +			goto out;
>> +
>> +		data_fd = bpf_map__fd(data_map);
>> +		if (!ASSERT_FALSE(data_fd < 0,
>> +				  "find tailcall_bpf2bpf_fentry.bss map fd"))
>> +			goto out;
>> +
>> +		i = 0;
>> +		err = bpf_map_lookup_elem(data_fd, &i, &val);
>> +		ASSERT_OK(err, "fentry count");
>> +		ASSERT_EQ(val, 33, "fentry count");
>> +	}
>> +
>> +	if (test_fexit) {
>> +		data_map = bpf_object__find_map_by_name(fexit_obj, ".bss");
>> +		if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
>> +				  "find tailcall_bpf2bpf_fexit.bss map"))
>> +			goto out;
>> +
>> +		data_fd = bpf_map__fd(data_map);
>> +		if (!ASSERT_FALSE(data_fd < 0,
>> +				  "find tailcall_bpf2bpf_fexit.bss map fd"))
>> +			goto out;
>> +
>> +		i = 0;
>> +		err = bpf_map_lookup_elem(data_fd, &i, &val);
>> +		ASSERT_OK(err, "fexit count");
>> +		ASSERT_EQ(val, 33, "fexit count");
>> +	}
>> +
>> +out:
>> +	bpf_link__destroy(fentry_link);
>> +	bpf_link__destroy(fexit_link);
>> +	bpf_object__close(fentry_obj);
>> +	bpf_object__close(fexit_obj);
>> +	bpf_object__close(tgt_obj);
>> +}
>> +
>> +/* test_tailcall_bpf2bpf_fentry checks that the count value of the tail call
>> + * limit enforcement matches with expectations when tailcall is preceded with
>> + * bpf2bpf call, and the bpf2bpf call is traced by fentry.
>> + */
>> +static void test_tailcall_bpf2bpf_fentry(void)
>> +{
>> +	tailcall_bpf2bpf_fentry_fexit(true, false);
>> +}
>> +
>> +/* test_tailcall_bpf2bpf_fexit checks that the count value of the tail call
>> + * limit enforcement matches with expectations when tailcall is preceded with
>> + * bpf2bpf call, and the bpf2bpf call is traced by fexit.
>> + */
>> +static void test_tailcall_bpf2bpf_fexit(void)
>> +{
>> +	tailcall_bpf2bpf_fentry_fexit(false, true);
>> +}
>> +
>> +/* test_tailcall_bpf2bpf_fentry_fexit checks that the count value of the tail
>> + * call limit enforcement matches with expectations when tailcall is preceded
>> + * with bpf2bpf call, and the bpf2bpf call is traced by both fentry and fexit.
>> + */
>> +static void test_tailcall_bpf2bpf_fentry_fexit(void)
>> +{
>> +	tailcall_bpf2bpf_fentry_fexit(true, true);
> 
> Would it be possible to modify existing test_tailcall_count() to have
> fentry/fexit testing within? __tailcall_bpf2bpf_fentry_fexit() basically
> repeats the logic of test_tailcall_count(), right?
> 
> How about something like:
> 
> static void test_tailcall_bpf2bpf_fentry(void)
> {
> 	test_tailcall_count("tailcall_bpf2bpf2.bpf.o", true, false);
> }
> 
> // rest of your test cases
> 
> and existing tailcall count tests:
> 
> static void test_tailcall_3(void)
> {
> 	test_tailcall_count("tailcall3.bpf.o", false, false);
> }
> 
> static void test_tailcall_6(void)
> {
> 	test_tailcall_count("tailcall6.bpf.o", false, false);
> }

LGTM, I'll try it.

Thanks,
Leon

> 
>> +}
>> +
>> +/* test_tailcall_bpf2bpf_fentry_entry checks that the count value of the tail
>> + * call limit enforcement matches with expectations when tailcall is preceded
>> + * with bpf2bpf call, and the bpf2bpf caller is traced by fentry.
>> + */
>> +static void test_tailcall_bpf2bpf_fentry_entry(void)
>> +{
>> +	struct bpf_object *tgt_obj = NULL, *fentry_obj = NULL;
>> +	int err, map_fd, prog_fd, data_fd, i, val;
>> +	struct bpf_map *prog_array, *data_map;
>> +	struct bpf_link *fentry_link = NULL;
>> +	struct bpf_program *prog;
>> +	char buff[128] = {};
>> +
>> +	LIBBPF_OPTS(bpf_test_run_opts, topts,
>> +		.data_in = buff,
>> +		.data_size_in = sizeof(buff),
>> +		.repeat = 1,
>> +	);
>> +
>> +	err = bpf_prog_test_load("tailcall_bpf2bpf2.bpf.o",
>> +				 BPF_PROG_TYPE_SCHED_CLS,
>> +				 &tgt_obj, &prog_fd);
>> +	if (!ASSERT_OK(err, "load tgt_obj"))
>> +		return;
>> +
>> +	prog_array = bpf_object__find_map_by_name(tgt_obj, "jmp_table");
>> +	if (!ASSERT_OK_PTR(prog_array, "find jmp_table map"))
>> +		goto out;
>> +
>> +	map_fd = bpf_map__fd(prog_array);
>> +	if (!ASSERT_FALSE(map_fd < 0, "find jmp_table map fd"))
>> +		goto out;
>> +
>> +	prog = bpf_object__find_program_by_name(tgt_obj, "classifier_0");
>> +	if (!ASSERT_OK_PTR(prog, "find classifier_0 prog"))
>> +		goto out;
>> +
>> +	prog_fd = bpf_program__fd(prog);
>> +	if (!ASSERT_FALSE(prog_fd < 0, "find classifier_0 prog fd"))
>> +		goto out;
>> +
>> +	i = 0;
>> +	err = bpf_map_update_elem(map_fd, &i, &prog_fd, BPF_ANY);
>> +	if (!ASSERT_OK(err, "update jmp_table"))
>> +		goto out;
>> +
>> +	fentry_obj = bpf_object__open_file("tailcall_bpf2bpf_fentry.bpf.o",
>> +					   NULL);
>> +	if (!ASSERT_OK_PTR(fentry_obj, "open fentry_obj file"))
>> +		goto out;
>> +
>> +	prog = bpf_object__find_program_by_name(fentry_obj, "fentry");
>> +	if (!ASSERT_OK_PTR(prog, "find fentry prog"))
>> +		goto out;
>> +
>> +	err = bpf_program__set_attach_target(prog, prog_fd, "classifier_0");
>> +	if (!ASSERT_OK(err, "set_attach_target classifier_0"))
>> +		goto out;
>> +
>> +	err = bpf_object__load(fentry_obj);
>> +	if (!ASSERT_OK(err, "load fentry_obj"))
>> +		goto out;
>> +
>> +	fentry_link = bpf_program__attach_trace(prog);
>> +	if (!ASSERT_OK_PTR(fentry_link, "attach_trace"))
>> +		goto out;
>> +
>> +	err = bpf_prog_test_run_opts(prog_fd, &topts);
>> +	ASSERT_OK(err, "tailcall");
>> +	ASSERT_EQ(topts.retval, 1, "tailcall retval");
>> +
>> +	data_map = bpf_object__find_map_by_name(tgt_obj, "tailcall.bss");
>> +	if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
>> +			  "find tailcall.bss map"))
>> +		goto out;
>> +
>> +	data_fd = bpf_map__fd(data_map);
>> +	if (!ASSERT_FALSE(data_fd < 0, "find tailcall.bss map fd"))
>> +		goto out;
>> +
>> +	i = 0;
>> +	err = bpf_map_lookup_elem(data_fd, &i, &val);
>> +	ASSERT_OK(err, "tailcall count");
>> +	ASSERT_EQ(val, 34, "tailcall count");
>> +
>> +	data_map = bpf_object__find_map_by_name(fentry_obj, ".bss");
>> +	if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
>> +			  "find tailcall_bpf2bpf_fentry.bss map"))
>> +		goto out;
>> +
>> +	data_fd = bpf_map__fd(data_map);
>> +	if (!ASSERT_FALSE(data_fd < 0,
>> +			  "find tailcall_bpf2bpf_fentry.bss map fd"))
>> +		goto out;
>> +
>> +	i = 0;
>> +	err = bpf_map_lookup_elem(data_fd, &i, &val);
>> +	ASSERT_OK(err, "fentry count");
>> +	ASSERT_EQ(val, 1, "fentry count");
>> +
>> +out:
>> +	bpf_link__destroy(fentry_link);
>> +	bpf_object__close(fentry_obj);
>> +	bpf_object__close(tgt_obj);
>> +}
>> +
>>  void test_tailcalls(void)
>>  {
>>  	if (test__start_subtest("tailcall_1"))
>> @@ -910,4 +1201,12 @@ void test_tailcalls(void)
>>  		test_tailcall_bpf2bpf_4(true);
>>  	if (test__start_subtest("tailcall_bpf2bpf_6"))
>>  		test_tailcall_bpf2bpf_6();
>> +	if (test__start_subtest("tailcall_bpf2bpf_fentry"))
>> +		test_tailcall_bpf2bpf_fentry();
>> +	if (test__start_subtest("tailcall_bpf2bpf_fexit"))
>> +		test_tailcall_bpf2bpf_fexit();
>> +	if (test__start_subtest("tailcall_bpf2bpf_fentry_fexit"))
>> +		test_tailcall_bpf2bpf_fentry_fexit();
>> +	if (test__start_subtest("tailcall_bpf2bpf_fentry_entry"))
>> +		test_tailcall_bpf2bpf_fentry_entry();
>>  }
>> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c
>> new file mode 100644
>> index 0000000000000..8436c6729167c
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c
>> @@ -0,0 +1,18 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright Leon Hwang */
>> +
>> +#include "vmlinux.h"
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +
>> +int count = 0;
>> +
>> +SEC("fentry/subprog_tail")
>> +int BPF_PROG(fentry, struct sk_buff *skb)
>> +{
>> +	count++;
>> +
>> +	return 0;
>> +}
>> +
>> +char _license[] SEC("license") = "GPL";
>> diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c
>> new file mode 100644
>> index 0000000000000..fe16412c6e6e9
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c
>> @@ -0,0 +1,18 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright Leon Hwang */
>> +
>> +#include "vmlinux.h"
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +
>> +int count = 0;
>> +
>> +SEC("fexit/subprog_tail")
>> +int BPF_PROG(fexit, struct sk_buff *skb)
>> +{
>> +	count++;
>> +
>> +	return 0;
>> +}
>> +
>> +char _license[] SEC("license") = "GPL";
>> -- 
>> 2.41.0
>>

