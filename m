Return-Path: <bpf+bounces-20064-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4ED838616
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 04:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9AAA1F2574A
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 03:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AF82116;
	Tue, 23 Jan 2024 03:35:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D3820E4;
	Tue, 23 Jan 2024 03:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705980901; cv=none; b=Ri5ldNNHubKPM9N2opNM53+RJ9N9Fg1ag794RoS5sYoXbacGvUAqkcu9Neaj285hhrnEaS15iurJ4WBbwihDMWY+4QpT44ux00HwnE/tJhuL8ewwP0tSROAgPzoxjNvssbyCwAUAyALWBt94i40Y6v11SYHDVUgZj9RsQY7WfSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705980901; c=relaxed/simple;
	bh=3sxs2O9LrM2s18G5hF1AexTqUrIFcqy80j4fGSirTnE=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UASHukBlgQTatSvARx+YHNQ/G7PmXxVjCNjDiqoD1FyCow4oiIc6ODRJph9ccm6hJd/YUyeDkk5aicP/j4PHACvh2hL+K1cK40JCcE1EuiPELlO+hyr0T/tWZ+DmfeBgGehoaUlpjjPQJ4AESoMHZwyPsTfHmGxy8uWOqaLxPgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxLOvfM69lhAAEAA--.5867S3;
	Tue, 23 Jan 2024 11:34:55 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxLs_eM69lmX4TAA--.22404S3;
	Tue, 23 Jan 2024 11:34:54 +0800 (CST)
Subject: Re: [PATCH bpf-next v6 3/3] selftests/bpf: Skip callback tests if jit
 is disabled in test_verifier
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
References: <20240122075700.7120-1-yangtiezhu@loongson.cn>
 <20240122075700.7120-4-yangtiezhu@loongson.cn>
 <CAEf4Bzaj=W3tUbfKRbQ3JgYqXimthVOs9uvmj4YxkbDhE3v0SA@mail.gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
 Hou Tao <houtao@huaweicloud.com>, Song Liu <song@kernel.org>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <15c4c8b2-9561-37b9-91d9-ce4ec76537e4@loongson.cn>
Date: Tue, 23 Jan 2024 11:34:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4Bzaj=W3tUbfKRbQ3JgYqXimthVOs9uvmj4YxkbDhE3v0SA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxLs_eM69lmX4TAA--.22404S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZryUuF15Zw43KF45CrWrCrX_yoWrCryUp3
	WkXayv9F4jqF4akry7Ar4SkFWrCrWkZrW0kFn0vrWUZa1DKw4fJry8KFW5tF9xWFWFvrna
	yFnrXa9Y9r4UWrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzZ2-
	UUUUU



On 01/23/2024 09:08 AM, Andrii Nakryiko wrote:
> On Sun, Jan 21, 2024 at 11:57 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> If CONFIG_BPF_JIT_ALWAYS_ON is not set and bpf_jit_enable is 0, there
>> exist 6 failed tests.

...

>>         if (expected_ret == ACCEPT || expected_ret == VERBOSE_ACCEPT) {
>> +               if (fd_prog < 0 && saved_errno == EINVAL && jit_disabled) {
>> +                       for (i = 0; i < prog_len; i++, prog++) {
>> +                               if (!insn_is_pseudo_func(prog))
>> +                                       continue;
>> +                               printf("SKIP (callbacks are not allowed in non-JITed programs)\n");
>> +                               skips++;
>> +                               goto close_fds;
>> +                       }
>> +               }
>
> Wouldn't it be better to add an explicit flag to those tests to mark
> that they require JIT enabled, instead of trying to derive this from
> analysing their BPF instructions?

Maybe something like this, add test flag F_NEEDS_JIT_ENABLED in
bpf_loop_inline.c, check the flag and jit_disabled at the beginning
of do_test_single(), no need to check fd_prog, saved_errno and the other
conditions, the patch #2 can be removed too.

If you are OK with the following changes, I will send v7 later.

----->8-----

diff --git a/tools/testing/selftests/bpf/test_verifier.c 
b/tools/testing/selftests/bpf/test_verifier.c
index 1a09fc34d093..c65915188d7c 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -67,6 +67,7 @@

  #define F_NEEDS_EFFICIENT_UNALIGNED_ACCESS     (1 << 0)
  #define F_LOAD_WITH_STRICT_ALIGNMENT           (1 << 1)
+#define F_NEEDS_JIT_ENABLED                    (1 << 2)

  /* need CAP_BPF, CAP_NET_ADMIN, CAP_PERFMON to load progs */
  #define ADMIN_CAPS (1ULL << CAP_NET_ADMIN |    \
@@ -74,6 +75,7 @@
                     1ULL << CAP_BPF)
  #define UNPRIV_SYSCTL "kernel/unprivileged_bpf_disabled"
  static bool unpriv_disabled = false;
+static bool jit_disabled;
  static int skips;
  static bool verbose = false;
  static int verif_log_level = 0;
@@ -1524,6 +1526,13 @@ static void do_test_single(struct bpf_test *test, 
bool unpriv,
         __u32 pflags;
         int i, err;

+       if ((test->flags & F_NEEDS_JIT_ENABLED) && jit_disabled) {
+               printf("SKIP (callbacks are not allowed in non-JITed 
programs)\n");
+               skips++;
+               sched_yield();
+               return;
+       }
+
         fd_prog = -1;
         for (i = 0; i < MAX_NR_MAPS; i++)
                 map_fds[i] = -1;
@@ -1844,6 +1853,8 @@ int main(int argc, char **argv)
                 return EXIT_FAILURE;
         }

+       jit_disabled = !is_jit_enabled();
+
         /* Use libbpf 1.0 API mode */
         libbpf_set_strict_mode(LIBBPF_STRICT_ALL);

diff --git a/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c 
b/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
index a535d41dc20d..59125b22ae39 100644
--- a/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
+++ b/tools/testing/selftests/bpf/verifier/bpf_loop_inline.c
@@ -57,6 +57,7 @@
         .expected_insns = { PSEUDO_CALL_INSN() },
         .unexpected_insns = { HELPER_CALL_INSN() },
         .prog_type = BPF_PROG_TYPE_TRACEPOINT,
+       .flags = F_NEEDS_JIT_ENABLED,
         .result = ACCEPT,
         .runs = 0,
         .func_info = { { 0, MAIN_TYPE }, { 12, CALLBACK_TYPE } },
@@ -90,6 +91,7 @@
         .expected_insns = { HELPER_CALL_INSN() },
         .unexpected_insns = { PSEUDO_CALL_INSN() },
         .prog_type = BPF_PROG_TYPE_TRACEPOINT,
+       .flags = F_NEEDS_JIT_ENABLED,
         .result = ACCEPT,
         .runs = 0,
         .func_info = { { 0, MAIN_TYPE }, { 16, CALLBACK_TYPE } },
@@ -127,6 +129,7 @@
         .expected_insns = { HELPER_CALL_INSN() },
         .unexpected_insns = { PSEUDO_CALL_INSN() },
         .prog_type = BPF_PROG_TYPE_TRACEPOINT,
+       .flags = F_NEEDS_JIT_ENABLED,
         .result = ACCEPT,
         .runs = 0,
         .func_info = {
@@ -165,6 +168,7 @@
         .expected_insns = { PSEUDO_CALL_INSN() },
         .unexpected_insns = { HELPER_CALL_INSN() },
         .prog_type = BPF_PROG_TYPE_TRACEPOINT,
+       .flags = F_NEEDS_JIT_ENABLED,
         .result = ACCEPT,
         .runs = 0,
         .func_info = {
@@ -235,6 +239,7 @@
         },
         .unexpected_insns = { HELPER_CALL_INSN() },
         .prog_type = BPF_PROG_TYPE_TRACEPOINT,
+       .flags = F_NEEDS_JIT_ENABLED,
         .result = ACCEPT,
         .func_info = {
                 { 0, MAIN_TYPE },
@@ -252,6 +257,7 @@
         .unexpected_insns = { HELPER_CALL_INSN() },
         .result = ACCEPT,
         .prog_type = BPF_PROG_TYPE_TRACEPOINT,
+       .flags = F_NEEDS_JIT_ENABLED,
         .func_info = { { 0, MAIN_TYPE }, { 16, CALLBACK_TYPE } },
         .func_info_cnt = 2,
         BTF_TYPES

Thanks,
Tiezhu


