Return-Path: <bpf+bounces-13006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D0C7D386B
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 15:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F312813D4
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 13:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0988D1A282;
	Mon, 23 Oct 2023 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dq7H/WmJ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B6623DE
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 13:50:13 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223F491
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 06:50:12 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b44befac59so3160622b3a.0
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 06:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698069011; x=1698673811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QWre9mZnAtrgAX834z5juWzz6buAAbXRMNn1b4/Lu10=;
        b=dq7H/WmJqTSdj7Aq3FzHdxa+ADO1CVIDAPyztu0C0LNqDvB0+vLUwDSsi+QoVsRi4Y
         yxIg4UDkzd6YLZZ/sCStlHVfBrf7xRUrsleclMvKFkJ2W/57WJeAiCtGxy7Rl7O+LSAQ
         YnGadkyadabHmkPsGZE5mVavz+s8gilPN4W4EMXhYPSduqSWFJZJd0phIvM6h1edQrVT
         2/avnyU3xtymXZPOkdrS4TQNaTGrCEVm/kLZtw6W+vuvKiDcLM3M4Pc0uGO2jCMR8qaj
         VC0UnTGCVmovSqwXNehf7ycrV9pjPxbjIRo1edTie/isGXhGSHXTWn0NsCqYfMtDCP5r
         TCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698069011; x=1698673811;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QWre9mZnAtrgAX834z5juWzz6buAAbXRMNn1b4/Lu10=;
        b=AU3uis28SsMAf9hkX9ce8Ycoo6QN11CrTp91D/88/aODAn+JMbJitk2YlUR8bNOCDK
         xyQBan3WbUDkHzEq+r92pQ4FPIGKIIVR/5GSsH1CojV+tSG3YxOwGSWM4nIcA2pTh5J2
         BIO18X1/I5hh69fVnWhej/bSRmpEbNNPpisbJMHztDT1wqVL6Y/c2A+KC8l6Cd2OW0s8
         6Wa1f//f2RXZQNtIK7iQiPFI+lci2sak9z8E+ppDPXy6q8J1C7bEkzYPnrO6zFP/+Ey1
         ypHh4PUNueErnJLgf1rdOgmI/SonsBM9kbvA+1CaoHEvX30GviBM4lrRPlYiNcrbxTTl
         lM6A==
X-Gm-Message-State: AOJu0YzWnhoOTbgfmlua748v5iaf3Z/SpAmbEzKOFPKP/jlXpOk0xRKD
	ZF3OYez0KxmSt034Y+Zez819wjhw20uLggukPWE=
X-Google-Smtp-Source: AGHT+IH9FGzehZRlaAxd4JxRjibu/2iIcquWhXqlPGuHa/h2uM8brsbHPgBhMax6zdzQSjvh7ePF8Q==
X-Received: by 2002:a05:6a20:4420:b0:15e:4084:6480 with SMTP id ce32-20020a056a20442000b0015e40846480mr13053050pzb.27.1698069011241;
        Mon, 23 Oct 2023 06:50:11 -0700 (PDT)
Received: from [10.254.107.145] ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id z6-20020aa79f86000000b006be4bb0d2dcsm6328098pfr.149.2023.10.23.06.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 06:50:10 -0700 (PDT)
Message-ID: <cfaf3363-51b9-40af-8993-9718d7edbaf7@bytedance.com>
Date: Mon, 23 Oct 2023 21:50:05 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test for css_task iter
 combining with cgroup iter
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20231022154527.229117-1-zhouchuyi@bytedance.com>
 <20231022154527.229117-3-zhouchuyi@bytedance.com>
 <CAADnVQLGwn_x9CZmYX5K_6K5Y0SB7EjU5wfRUHRMdXhAvKEJVw@mail.gmail.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAADnVQLGwn_x9CZmYX5K_6K5Y0SB7EjU5wfRUHRMdXhAvKEJVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/10/23 00:03, Alexei Starovoitov 写道:
> On Sun, Oct 22, 2023 at 8:45 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>> This patch adds a test which demonstrates how css_task iter can be combined
>> with cgroup iter and it won't cause deadlock, though cgroup iter is not
>> sleepable.
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   .../selftests/bpf/prog_tests/cgroup_iter.c    | 33 +++++++++++++++
>>   .../selftests/bpf/progs/iters_css_task.c      | 41 +++++++++++++++++++
>>   2 files changed, 74 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c b/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
>> index e02feb5fae97..3679687a6927 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_iter.c
>> @@ -4,6 +4,7 @@
>>   #include <test_progs.h>
>>   #include <bpf/libbpf.h>
>>   #include <bpf/btf.h>
>> +#include "iters_css_task.skel.h"
>>   #include "cgroup_iter.skel.h"
>>   #include "cgroup_helpers.h"
>>
>> @@ -263,6 +264,35 @@ static void test_walk_dead_self_only(struct cgroup_iter *skel)
>>          close(cgrp_fd);
>>   }
>>
>> +static void test_walk_self_only_css_task(void)
>> +{
>> +       struct iters_css_task *skel = NULL;
>> +       int err;
>> +
>> +       skel = iters_css_task__open();
>> +       if (!ASSERT_OK_PTR(skel, "skel_open"))
>> +               return;
>> +
>> +       bpf_program__set_autoload(skel->progs.cgroup_id_printer, true);
>> +
>> +       err = iters_css_task__load(skel);
>> +       if (!ASSERT_OK(err, "skel_load"))
>> +               goto cleanup;
>> +
>> +       err = join_cgroup(cg_path[CHILD2]);
>> +       if (!ASSERT_OK(err, "join_cgroup"))
>> +               goto cleanup;
>> +
>> +       skel->bss->target_pid = getpid();
>> +       snprintf(expected_output, sizeof(expected_output),
>> +               PROLOGUE "%8llu\n" EPILOGUE, cg_id[CHILD2]);
>> +       read_from_cgroup_iter(skel->progs.cgroup_id_printer, cg_fd[CHILD2],
>> +               BPF_CGROUP_ITER_SELF_ONLY, "test_walk_self_only_css_task");
>> +       ASSERT_EQ(skel->bss->css_task_cnt, 1, "css_task_cnt");
>> +cleanup:
>> +       iters_css_task__destroy(skel);
>> +}
>> +
>>   void test_cgroup_iter(void)
>>   {
>>          struct cgroup_iter *skel = NULL;
>> @@ -293,6 +323,9 @@ void test_cgroup_iter(void)
>>                  test_walk_self_only(skel);
>>          if (test__start_subtest("cgroup_iter__dead_self_only"))
>>                  test_walk_dead_self_only(skel);
>> +       if (test__start_subtest("cgroup_iter__self_only_css_task"))
>> +               test_walk_self_only_css_task();
>> +
>>   out:
>>          cgroup_iter__destroy(skel);
>>          cleanup_cgroups();
>> diff --git a/tools/testing/selftests/bpf/progs/iters_css_task.c b/tools/testing/selftests/bpf/progs/iters_css_task.c
>> index 5089ce384a1c..0974e6f44328 100644
>> --- a/tools/testing/selftests/bpf/progs/iters_css_task.c
>> +++ b/tools/testing/selftests/bpf/progs/iters_css_task.c
>> @@ -10,6 +10,7 @@
>>
>>   char _license[] SEC("license") = "GPL";
>>
>> +struct cgroup *bpf_cgroup_acquire(struct cgroup *p) __ksym;
>>   struct cgroup *bpf_cgroup_from_id(u64 cgid) __ksym;
>>   void bpf_cgroup_release(struct cgroup *p) __ksym;
>>
>> @@ -45,3 +46,43 @@ int BPF_PROG(iter_css_task_for_each, struct vm_area_struct *vma,
>>
>>          return -EPERM;
>>   }
>> +
>> +static inline u64 cgroup_id(struct cgroup *cgrp)
>> +{
>> +       return cgrp->kn->id;
>> +}
>> +
>> +SEC("?iter/cgroup")
>> +int cgroup_id_printer(struct bpf_iter__cgroup *ctx)
>> +{
>> +       struct seq_file *seq = ctx->meta->seq;
>> +       struct cgroup *cgrp, *acquired;
>> +       struct cgroup_subsys_state *css;
>> +       struct task_struct *task;
>> +
>> +       cgrp = ctx->cgroup;
>> +
>> +       /* epilogue */
>> +       if (cgrp == NULL) {
>> +               BPF_SEQ_PRINTF(seq, "epilogue\n");
>> +               return 0;
>> +       }
>> +
>> +       /* prologue */
>> +       if (ctx->meta->seq_num == 0)
>> +               BPF_SEQ_PRINTF(seq, "prologue\n");
>> +
>> +       BPF_SEQ_PRINTF(seq, "%8llu\n", cgroup_id(cgrp));
>> +
>> +       acquired = bpf_cgroup_from_id(cgroup_id(cgrp));
> 
> You're doing this dance, because a plain cgrp pointer is not trusted?
> Maybe let's add
> BTF_TYPE_SAFE_RCU_OR_NULL(struct bpf_iter__cgroup) {...}
> to the verifier similar to what we do for bpf_iter__task.
> 

Yes, thanks for the suggestion.

But it seems currently, bpf_iter__task->task works well either.

SEC("iter/task")
int dump_task(struct bpf_iter__task *ctx)
{
	struct task_struct *task = ctx->task;
	// here task should be trusted since BTF_TYPE_SAFE_TRUSTED(struct 
bpf_iter__task) {...}
	if (task == NULL) {
		return 0;
	}
	bpf_task_acquire(task);
	
	bpf_task_release(task);
	return 0;
}

The log of verifier is :
VERIFIER LOG:
=============
reg type unsupported for arg#0 function dump_task#7
0: R1=ctx(off=0,imm=0) R10=fp0
; struct task_struct *task = ctx->task;
0: (79) r6 = *(u64 *)(r1 +8)          ; R1=ctx(off=0,imm=0) 
R6_w=ptr_or_null_task_struct(id=1,off=0,imm=0)
; if (task == NULL) {
1: (15) if r6 == 0x0 goto pc+4        ; R6_w=ptr_task_struct(off=0,imm=0)
; bpf_task_acquire(task);
2: (bf) r1 = r6                       ; 
R1_w=ptr_task_struct(off=0,imm=0) R6_w=ptr_task_struct(off=0,imm=0)
3: (85) call bpf_task_acquire#26990
R1 must be a rcu pointer
processed 4 insns (limit 1000000) max_states_per_insn 0 total_states 0 
peak_states 0 mark_read 0

 From the above log, it seems 'task' is a normal porint not a trusted 
pointer.

Actually, it seems BPF verifier didn't even call check_ptr_to_btf_access()..

But for bpf_iter__task->meta, it works well. BPF verifier would consider 
it as a trusted pointer.

SEC("iter/task")
int dump_task(struct bpf_iter__task *ctx)
{
         struct task_struct *task = ctx->task;
         struct bpf_iter_meta *meta = ctx->meta;
         struct seq_file *seq = meta->seq;
         if (task == NULL) {
                 BPF_SEQ_PRINTF(seq, "%s\n", "NULL");
                 return 0;
         }
         bpf_task_acquire(task);

         bpf_task_release(task);
         return 0;
}

VERIFIER LOG:
=============
reg type unsupported for arg#0 function dump_task#7
0: R1=ctx(off=0,imm=0) R10=fp0
; int dump_task(struct bpf_iter__task *ctx)
0: (bf) r8 = r1                       ; R1=ctx(off=0,imm=0) 
R8_w=ctx(off=0,imm=0)
; struct bpf_iter_meta *meta = ctx->meta;
1: (79) r1 = *(u64 *)(r8 +0)
func 'bpf_iter_task' arg0 has btf_id 22699 type STRUCT 'bpf_iter_meta'
2: R1_w=trusted_ptr_bpf_iter_meta(off=0,imm=0) R8_w=ctx(off=0,imm=0)
; struct seq_file *seq = meta->seq;
2: (79) r6 = *(u64 *)(r1 +0)          ; 
R1_w=trusted_ptr_bpf_iter_meta(off=0,imm=0) 
R6_w=trusted_ptr_seq_file(off=0,imm=0)
; struct task_struct *task = ctx->task;
3: (79) r7 = *(u64 *)(r8 +8)          ; 
R7_w=ptr_or_null_task_struct(id=1,off=0,imm=0) R8_w=ctx(off=0,imm=0)
; if (task == (void *)0) {
4: (55) if r7 != 0x0 goto pc+12 17: 
R1_w=trusted_ptr_bpf_iter_meta(off=0,imm=0) 
R6_w=trusted_ptr_seq_file(off=0,imm=0) R7_w=ptr_task_struct(off=0,imm=0) 
R8_w=ctx(off=0,imm=0) R10=fp0
; bpf_task_acquire(task);
17: (bf) r1 = r7                      ; 
R1_w=ptr_task_struct(off=0,imm=0) R7_w=ptr_task_struct(off=0,imm=0)
18: (85) call bpf_task_acquire#26990
R1 must be a rcu pointer

I will try to figure out it.

Thanks.






