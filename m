Return-Path: <bpf+bounces-9007-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F65E78E235
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 00:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16C41C208C9
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 22:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8821B8BFB;
	Wed, 30 Aug 2023 22:17:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623D87481
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 22:17:36 +0000 (UTC)
Received: from out-253.mta0.migadu.com (out-253.mta0.migadu.com [IPv6:2001:41d0:1004:224b::fd])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8734CB4
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 15:17:14 -0700 (PDT)
Message-ID: <566fe0ba-9bd5-d3d6-0c48-6e417dbb7b00@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693433530; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/qNAxViRV6qEJ5uVuwQ0hBEiP3GVDRYz676LKaLLyk=;
	b=g5+zAcmy0OEZTSzA10CRK5IePEgPy7N7LhG5MpLfcBpPl0p4I+Kl+Jv/ME4lWosPd0m2Q3
	YXjfkvfl7FXrkSpv1ULtpNEq8TB0dbF/d+m6ZsqjXhYkcrwOl0FuAnAXN/hnG8Q1Xa7/sc
	VWony4Dr7onxq5s8zxL4P9zl4COWayg=
Date: Wed, 30 Aug 2023 18:11:52 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [RFC/PATCH bpf-next] bpf: Fix d_path test after last fs update
To: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Hou Tao <houtao1@huawei.com>
References: <20230830093502.1436694-1-jolsa@kernel.org>
 <ZO9DvsaOImg4Dt5r@krava>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZO9DvsaOImg4Dt5r@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/30/23 9:27 AM, Jiri Olsa wrote:
> On Wed, Aug 30, 2023 at 11:35:02AM +0200, Jiri Olsa wrote:
>> Recent commit [1] broken d_path test, because now filp_close is not
>> called directly from sys_close, but eventually later when the file
>> is finally released.
>>
>> I can't see any other solution than to hook filp_flush function and
>> that also means we need to add it to btf_allowlist_d_path list, so
>> it can use the d_path helper.
>>
>> But it's probably not very stable because filp_flush is static so it
>> could be potentially inlined.
> 
> looks like llvm makes it inlined (from CI)
> 
>    Error: #68/1 d_path/basic
>    libbpf: prog 'prog_close': failed to find kernel BTF type ID of 'filp_flush': -3
> 
> jirka
> 
>>
>> Also if we'd keep the current filp_close hook and find a way how to 'wait'
>> for it to be called so user space can go with checks, then it looks
>> like d_path might not work properly when the task is no longer around.
>>
>> thoughts?

Jiri,

The following patch works fine for me:

$ git diff
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index a7264b2c17ad..fdeec712338f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -941,6 +941,7 @@ BTF_ID(func, vfs_fallocate)
  BTF_ID(func, dentry_open)
  BTF_ID(func, vfs_getattr)
  BTF_ID(func, filp_close)
+BTF_ID(func, __fput_sync)
  BTF_SET_END(btf_allowlist_d_path)

  static bool bpf_d_path_allowed(const struct bpf_prog *prog)
diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c 
b/tools/testing/selftests/bpf/progs/test_d_path.c
index 84e1f883f97b..672897197c2a 100644
--- a/tools/testing/selftests/bpf/progs/test_d_path.c
+++ b/tools/testing/selftests/bpf/progs/test_d_path.c
@@ -40,8 +40,8 @@ int BPF_PROG(prog_stat, struct path *path, struct 
kstat *stat,
         return 0;
  }

-SEC("fentry/filp_close")
-int BPF_PROG(prog_close, struct file *file, void *id)
+SEC("fentry/__fput_sync")
+int BPF_PROG(prog_close, struct file *file)
  {
         pid_t pid = bpf_get_current_pid_tgid() >> 32;
         __u32 cnt = cnt_close;

>> jirka
>>
>>
>> [1] 021a160abf62 ("fs: use __fput_sync in close(2)")
>> ---
>>   kernel/trace/bpf_trace.c                        | 1 +
>>   tools/testing/selftests/bpf/progs/test_d_path.c | 4 ++--
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index a7264b2c17ad..c829e24af246 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -941,6 +941,7 @@ BTF_ID(func, vfs_fallocate)
>>   BTF_ID(func, dentry_open)
>>   BTF_ID(func, vfs_getattr)
>>   BTF_ID(func, filp_close)
>> +BTF_ID(func, filp_flush)
>>   BTF_SET_END(btf_allowlist_d_path)
>>   
>>   static bool bpf_d_path_allowed(const struct bpf_prog *prog)
>> diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c b/tools/testing/selftests/bpf/progs/test_d_path.c
>> index 84e1f883f97b..3467d1b8098c 100644
>> --- a/tools/testing/selftests/bpf/progs/test_d_path.c
>> +++ b/tools/testing/selftests/bpf/progs/test_d_path.c
>> @@ -40,8 +40,8 @@ int BPF_PROG(prog_stat, struct path *path, struct kstat *stat,
>>   	return 0;
>>   }
>>   
>> -SEC("fentry/filp_close")
>> -int BPF_PROG(prog_close, struct file *file, void *id)
>> +SEC("fentry/filp_flush")
>> +int BPF_PROG(prog_close, struct file *file)
>>   {
>>   	pid_t pid = bpf_get_current_pid_tgid() >> 32;
>>   	__u32 cnt = cnt_close;
>> -- 
>> 2.41.0
>>
> 

