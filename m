Return-Path: <bpf+bounces-13388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F5C7D8DED
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 06:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73792B213BD
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 04:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563755229;
	Fri, 27 Oct 2023 04:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGgdtGWe"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03D04434
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 04:55:38 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154F21A5
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 21:55:36 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a8ada42c2aso12774677b3.3
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 21:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698382535; x=1698987335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9qn6SLIPvR+jvmU9XqKyb3fI7G1aOoXH0tiKFqE4GbU=;
        b=dGgdtGWe3S9ZZvrLqhA2+Ncp/9ye7s/+tWUQXB0N0uJhGdv1agBwag9S42FsaA8JTk
         z7RdPf5Fkmjc9wGWF8SEpEa4nRknas+vMaRcBWqUnX9WPk3oB3Hu9AqLMKH8GC40akOO
         lCl9+tAw/fOqGc929nSHKG50zpPw0UbtEZoCD1M8biGw0/2VBz7c4R5jG+TZOYraSgVG
         2FuM1eSGWVeGEiKGlThvs0Rq8gzCJ9OYD8rNELtsiPyOc7719cFYYptQiEfEmRbGk0Zr
         HPiIKbJSQnAUvlNhjn0QDNB48MrshkKR2M6A+mQg7PYQAJx4R8+5VA2BiqzLoTac0Dzz
         4F8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698382535; x=1698987335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qn6SLIPvR+jvmU9XqKyb3fI7G1aOoXH0tiKFqE4GbU=;
        b=mPzaDkgxCp1GW+4hmjWAGx9Klhwlybttnvi4t5XYkGg7LJmmtiapzRGTMZZ2g7zKJl
         sDujrAwvA/dUMNvx3NuWAz1IkZsqk9KpUd3knBifL4SRxmJNyYdOH6FzbCCQF1sULKTy
         NadIj8Kt4QF3l+EQd6qc9uqGLcUbF4Y/7gRhcLc0ElvUYoNdRp9YR6SHTwYXw/846p5K
         J9RSVup3mbWFFSWzxVXUNaBpbHCej5ATMjaXT6Mjnmj+DOFBoAPO2iUdChDk/CKpUPmE
         qKZYxXZppz1eFNCtjzQRtBxQnzY4FGXxfeOEVuZb5d4+5J0HBaxG7lLsguuQxqEuR1SG
         rq5g==
X-Gm-Message-State: AOJu0Yx65LM2DD9wQSuY6Qdv11zGKeQiyU+KSQ6iy+KKrmxnch3qcIoJ
	/LxSD6y/7Lt/+DqZr3U0j4I=
X-Google-Smtp-Source: AGHT+IGggnkTqN1UJdXLMFKtX9mE81CJNRKUe6VSmVUJhFzhaClhsguEUh+KUuqiccSTEQX0sXeziA==
X-Received: by 2002:a25:d784:0:b0:d7f:af26:2c7e with SMTP id o126-20020a25d784000000b00d7faf262c7emr1466722ybg.20.1698382535185;
        Thu, 26 Oct 2023 21:55:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:ed69:fa3e:676a:4a7a? ([2600:1700:6cf8:1240:ed69:fa3e:676a:4a7a])
        by smtp.gmail.com with ESMTPSA id x33-20020a25aca1000000b00d9c7bf8f32fsm370771ybi.42.2023.10.26.21.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 21:55:34 -0700 (PDT)
Message-ID: <5b3609f3-bc40-4fc3-b591-d124432dc4d9@gmail.com>
Date: Thu, 26 Oct 2023 21:55:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 10/10] selftests/bpf: test case for
 register_bpf_struct_ops().
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, thinker.li@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
Cc: kuifeng@meta.com
References: <20231022050335.2579051-1-thinker.li@gmail.com>
 <20231022050335.2579051-11-thinker.li@gmail.com>
 <abd76cd234ab2a1185bb9557fa54013264df6a50.camel@gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <abd76cd234ab2a1185bb9557fa54013264df6a50.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/26/23 13:31, Eduard Zingerman wrote:
> On Sat, 2023-10-21 at 22:03 -0700, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Create a new struct_ops type called bpf_testmod_ops within the bpf_testmod
>> module. When a struct_ops object is registered, the bpf_testmod module will
>> invoke test_2 from the module.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Hello,
> 
> Sorry for the late response, was moving through the patch-set very slowly.
> Please note that CI currently fails for this series [0], reported error is:
> 
> testing_helpers.c:13:10: fatal error: 'rcu_tasks_trace_gp.skel.h' file not found
>     13 | #include "rcu_tasks_trace_gp.skel.h"
>        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Thank! I will fix this dependency issue.

> 
> I get the same error when try to run tests locally (after full clean).
> On the other hand it looks like `kern_sync_rcu_tasks_trace` changes
> are not really necessary, when I undo these changes but keep changes in:
> 
> - .../selftests/bpf/bpf_testmod/bpf_testmod.c
> - .../selftests/bpf/bpf_testmod/bpf_testmod.h
> - .../bpf/prog_tests/test_struct_ops_module.c
> - .../selftests/bpf/progs/struct_ops_module.c
> 
> struct_ops_module/regular_load test still passes.
> 

The test will pass even without this change.
But, the test harness may complain by showing warnings.
You may see an additional warning message without this change.

> Regarding assertion:
> 
>> +	ASSERT_EQ(skel->bss->test_2_result, 7, "test_2_result");
> 
> Could you please leave a comment explaining why the value is 7?
> I don't understand what invokes 'test_2' but changing it to 8
> forces test to fail, so something does call 'test_2' :)

It is called by bpf_dummy_reg() in bpf_testmod.c.
I will add a comment here.

> 
> Also, when running test_maps I get the following error:
> 
> libbpf: bpf_map_create_opts has non-zero extra bytes
> map_create_opts(317):FAIL:bpf_map_create() error:Invalid argument (name=hash_of_maps)

It looks like a padding issue. I will check it.

> 
> [0] https://patchwork.kernel.org/project/netdevbpf/patch/20231022050335.2579051-11-thinker.li@gmail.com/
>      (look for 'Logs for x86_64-gcc / build / build for x86_64 with gcc ')
> 
>> ---
>>   tools/testing/selftests/bpf/Makefile          |  2 +
>>   .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 59 +++++++++++++++++++
>>   .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  5 ++
>>   .../bpf/prog_tests/test_struct_ops_module.c   | 38 ++++++++++++
>>   .../selftests/bpf/progs/struct_ops_module.c   | 30 ++++++++++
>>   tools/testing/selftests/bpf/testing_helpers.c | 35 +++++++++++
>>   6 files changed, 169 insertions(+)
>>   create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>>   create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_module.c
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index caede9b574cb..dd7ff14e1fdf 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -706,6 +706,8 @@ $(OUTPUT)/uprobe_multi: uprobe_multi.c
>>   	$(call msg,BINARY,,$@)
>>   	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
>>   
>> +$(OUTPUT)/testing_helpers.o: $(OUTPUT)/rcu_tasks_trace_gp.skel.h
>> +
>>   EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
>>   	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
>>   	feature bpftool							\
>> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> index cefc5dd72573..f1a20669d884 100644
>> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
>> @@ -1,5 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   /* Copyright (c) 2020 Facebook */
>> +#include <linux/bpf.h>
>>   #include <linux/btf.h>
>>   #include <linux/btf_ids.h>
>>   #include <linux/error-injection.h>
>> @@ -517,11 +518,66 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_static_unused_arg)
>>   BTF_ID_FLAGS(func, bpf_kfunc_call_test_offset)
>>   BTF_SET8_END(bpf_testmod_check_kfunc_ids)
>>   
>> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>> +
>> +DEFINE_STRUCT_OPS_VALUE_TYPE(bpf_testmod_ops);
>> +
>> +static int bpf_testmod_ops_init(struct btf *btf)
>> +{
>> +	return 0;
>> +}
>> +
>> +static bool bpf_testmod_ops_is_valid_access(int off, int size,
>> +					    enum bpf_access_type type,
>> +					    const struct bpf_prog *prog,
>> +					    struct bpf_insn_access_aux *info)
>> +{
>> +	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
>> +}
>> +
>> +static int bpf_testmod_ops_init_member(const struct btf_type *t,
>> +				       const struct btf_member *member,
>> +				       void *kdata, const void *udata)
>> +{
>> +	return 0;
>> +}
>> +
>>   static const struct btf_kfunc_id_set bpf_testmod_kfunc_set = {
>>   	.owner = THIS_MODULE,
>>   	.set   = &bpf_testmod_check_kfunc_ids,
>>   };
>>   
>> +static const struct bpf_verifier_ops bpf_testmod_verifier_ops = {
>> +	.is_valid_access = bpf_testmod_ops_is_valid_access,
>> +};
>> +
>> +static int bpf_dummy_reg(void *kdata)
>> +{
>> +	struct bpf_testmod_ops *ops = kdata;
>> +	int r;
>> +
>> +	BTF_STRUCT_OPS_TYPE_EMIT(bpf_testmod_ops);
>> +	r = ops->test_2(4, 3);
>> +
>> +	return 0;
>> +}
>> +
>> +static void bpf_dummy_unreg(void *kdata)
>> +{
>> +}
>> +
>> +struct bpf_struct_ops bpf_bpf_testmod_ops = {
>> +	.verifier_ops = &bpf_testmod_verifier_ops,
>> +	.init = bpf_testmod_ops_init,
>> +	.init_member = bpf_testmod_ops_init_member,
>> +	.reg = bpf_dummy_reg,
>> +	.unreg = bpf_dummy_unreg,
>> +	.name = "bpf_testmod_ops",
>> +	.owner = THIS_MODULE,
>> +};
>> +
>> +#endif /* CONFIG_DEBUG_INFO_BTF_MODULES */
>> +
>>   extern int bpf_fentry_test1(int a);
>>   
>>   static int bpf_testmod_init(void)
>> @@ -532,6 +588,9 @@ static int bpf_testmod_init(void)
>>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_testmod_kfunc_set);
>>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_testmod_kfunc_set);
>>   	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_kfunc_set);
>> +#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>> +	ret = ret ?: register_bpf_struct_ops(&bpf_bpf_testmod_ops);
>> +#endif
>>   	if (ret < 0)
>>   		return ret;
>>   	if (bpf_fentry_test1(0) < 0)
>> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
>> index f32793efe095..ca5435751c79 100644
>> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
>> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
>> @@ -28,4 +28,9 @@ struct bpf_iter_testmod_seq {
>>   	int cnt;
>>   };
>>   
>> +struct bpf_testmod_ops {
>> +	int (*test_1)(void);
>> +	int (*test_2)(int a, int b);
>> +};
>> +
>>   #endif /* _BPF_TESTMOD_H */
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> new file mode 100644
>> index 000000000000..7261fc6c377a
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
>> @@ -0,0 +1,38 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
>> +#include <test_progs.h>
>> +#include <time.h>
>> +
>> +#include "rcu_tasks_trace_gp.skel.h"
>> +#include "struct_ops_module.skel.h"
>> +
>> +static void test_regular_load(void)
>> +{
>> +	struct struct_ops_module *skel;
>> +	struct bpf_link *link;
>> +	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
>> +	int err;
>> +
>> +	skel = struct_ops_module__open_opts(&opts);
>> +	if (!ASSERT_OK_PTR(skel, "struct_ops_module_open"))
>> +		return;
>> +	err = struct_ops_module__load(skel);
>> +	if (!ASSERT_OK(err, "struct_ops_module_load"))
>> +		return;
>> +
>> +	link = bpf_map__attach_struct_ops(skel->maps.testmod_1);
>> +	ASSERT_OK_PTR(link, "attach_test_mod_1");
>> +
>> +	ASSERT_EQ(skel->bss->test_2_result, 7, "test_2_result");
>> +
>> +	bpf_link__destroy(link);
>> +
>> +	struct_ops_module__destroy(skel);
>> +}
>> +
>> +void serial_test_struct_ops_module(void)
>> +{
>> +	if (test__start_subtest("regular_load"))
>> +		test_regular_load();
>> +}
>> +
>> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tools/testing/selftests/bpf/progs/struct_ops_module.c
>> new file mode 100644
>> index 000000000000..cb305d04342f
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
>> @@ -0,0 +1,30 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
>> +#include <vmlinux.h>
>> +#include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_tracing.h>
>> +#include "../bpf_testmod/bpf_testmod.h"
>> +
>> +char _license[] SEC("license") = "GPL";
>> +
>> +int test_2_result = 0;
>> +
>> +SEC("struct_ops/test_1")
>> +int BPF_PROG(test_1)
>> +{
>> +	return 0xdeadbeef;
>> +}
>> +
>> +SEC("struct_ops/test_2")
>> +int BPF_PROG(test_2, int a, int b)
>> +{
>> +	test_2_result = a + b;
>> +	return a + b;
>> +}
>> +
>> +SEC(".struct_ops.link")
>> +struct bpf_testmod_ops testmod_1 = {
>> +	.test_1 = (void *)test_1,
>> +	.test_2 = (void *)test_2,
>> +};
>> +
>> diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
>> index 8d994884c7b4..05870cd62458 100644
>> --- a/tools/testing/selftests/bpf/testing_helpers.c
>> +++ b/tools/testing/selftests/bpf/testing_helpers.c
>> @@ -10,6 +10,7 @@
>>   #include "test_progs.h"
>>   #include "testing_helpers.h"
>>   #include <linux/membarrier.h>
>> +#include "rcu_tasks_trace_gp.skel.h"
>>   
>>   int parse_num_list(const char *s, bool **num_set, int *num_set_len)
>>   {
>> @@ -380,10 +381,44 @@ int load_bpf_testmod(bool verbose)
>>   	return 0;
>>   }
>>   
>> +/* This function will trigger call_rcu_tasks_trace() in the kernel */
>> +static int kern_sync_rcu_tasks_trace(void)
>> +{
>> +	struct rcu_tasks_trace_gp *rcu;
>> +	time_t start;
>> +	long gp_seq;
>> +	LIBBPF_OPTS(bpf_test_run_opts, opts);
>> +
>> +	rcu = rcu_tasks_trace_gp__open_and_load();
>> +	if (IS_ERR(rcu))
>> +		return -EFAULT;
>> +	if (rcu_tasks_trace_gp__attach(rcu))
>> +		return -EFAULT;
>> +
>> +	gp_seq = READ_ONCE(rcu->bss->gp_seq);
>> +
>> +	if (bpf_prog_test_run_opts(bpf_program__fd(rcu->progs.do_call_rcu_tasks_trace),
>> +				   &opts))
>> +		return -EFAULT;
>> +	if (opts.retval != 0)
>> +		return -EFAULT;
>> +
>> +	start = time(NULL);
>> +	while ((start + 2) > time(NULL) &&
>> +	       gp_seq == READ_ONCE(rcu->bss->gp_seq))
>> +		sched_yield();
>> +
>> +	rcu_tasks_trace_gp__destroy(rcu);
>> +
>> +	return 0;
>> +}
>> +
>>   /*
>>    * Trigger synchronize_rcu() in kernel.
>>    */
>>   int kern_sync_rcu(void)
>>   {
>> +	if (kern_sync_rcu_tasks_trace())
>> +		return -EFAULT;
>>   	return syscall(__NR_membarrier, MEMBARRIER_CMD_SHARED, 0, 0);
>>   }
> 

