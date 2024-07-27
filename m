Return-Path: <bpf+bounces-35801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7B193DD30
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 06:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB03284D0B
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 04:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386E54A1B;
	Sat, 27 Jul 2024 04:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ky4hgwg/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248C61FB5;
	Sat, 27 Jul 2024 04:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722053049; cv=none; b=abfldgEe0xYp4eqHOs247wl89IlooFT5vCmsZfAmfaifZJI+lCmXvWH07OGJXUzQwtb+IL6T5zy0U+NjFFy3ghfsV8hL4SKVIlDfd2bxLNtpoirkgPvLbnVsp3JvronWLtf0xIyPX2Ebt2stG9YR9QbkY+7YK+Nb8L0KsBUUd/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722053049; c=relaxed/simple;
	bh=BIoDo9ir3+cxQXQJocCQv1raAVmCY+bXDXXIPdjuZHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZR35R9MKLKbFvgwSg2z0GEdt74D18pOAS8/ZQVY6g1GxCEbR27N4jUjm3fsZBbFbKd1B6YcFP3GR9VP4vXmpbr8zRJrVXV+CC6n5trO77oJ8w89tOsKhqd+18gQ6EPMegw818VBTjKtQVP6LH/oKdZeO9F2eKl4fFC5uvKBMgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ky4hgwg/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc4fccdd78so10087225ad.2;
        Fri, 26 Jul 2024 21:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722053047; x=1722657847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qiEFsingphefDRSqTfgQolRa5tlLZONPiI6xt7Kr6Us=;
        b=ky4hgwg/3918VDprCqMe0KXXeinfz9jlJbU+X8XrKpYdHJp9x1dAXfazDP5nbRj4lc
         +pLsPb+aV43Q4RFwp9o8Nm7yLLiaJG0sI/8NqZYQo8OnNmYf0rRCxEfoycg7FYtcgvqa
         tzvF5koAjwRGqTNwmCVf3azj6YkE0vuvt64gaGC8dIH42mQdRgDrXlqTs8H13ewLbQa8
         z/6gJkPjX1zW/P71RsdhJTp7SBllxbehyyQ/hwefr0SrEbn3cb2/bJNZHzsKXAs/rrZu
         FtUY6I9olHhpZnCoka6xs0rpVhSkqsglIfnZBE9GV23eMbq63vLpBJeccDRCiyQ5oa/z
         7Ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722053047; x=1722657847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qiEFsingphefDRSqTfgQolRa5tlLZONPiI6xt7Kr6Us=;
        b=ZXWC7tsr6HNw+R8VoppPBzRhTB48Ldr3T+DR1gbx/ZLMq7vTdf8Sg1u2mJ8VZ2csA3
         jhp0XpZYM1CFWogMlBDyodRVHZJ2HVn4DRCAJDjuRUFcdib4nspvs0Ej1UH5RjTcclY2
         Ejg7OsNtaOJamwM19nYDO2prdcg2yRmnc88aaH5dugmU7fcI7mN218DeeA0w5xLLaYE7
         RXXQo4NjEIh5m3+5VGMbAKiDnvoIQVHjzCo3DEVQJH4X0LIiUUFHI5jPAYtbysYNQ9q6
         1C5ihVhxpG3k5ncm1793Eu0SiinrEudC0qBgU8HXEMbZ8s3o90zlQPzO6POQEIyiLxOe
         Pnbw==
X-Forwarded-Encrypted: i=1; AJvYcCViKEXp5KzJaiyPcCfyfT2GK8uttsxO2EgQEl9C1xnuSyxmRNZG2QW0kjJ+ta5fxSpDQ1/VxvKyG2tHjdiFQWv2k0/8xEb3tMEfpNadoueXeEFQPcrVfmEewu0iD8I40zBf
X-Gm-Message-State: AOJu0YyVJSURfhPyrAA9rp6jAMV1cGGAnKfmHwn2UHcNMSBeEnA/jBjH
	pEw/+dtNs0uk4/xkfiND/SrXIRXNREr7oPJimgMrNdwYLcJGxVhH
X-Google-Smtp-Source: AGHT+IGHcFYnnVtt1qxfZhg0ax6/W52Ms9T0wsWqDTHkETtRvU0YtInd7++FBVWGlfE7MYln2qY/FA==
X-Received: by 2002:a17:902:8ec1:b0:1fb:a1cb:cb31 with SMTP id d9443c01a7336-1ff0482ba51mr14922125ad.17.1722053047046;
        Fri, 26 Jul 2024 21:04:07 -0700 (PDT)
Received: from [192.168.1.76] (bb219-74-23-111.singnet.com.sg. [219.74.23.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f1cc38sm40826095ad.200.2024.07.26.21.04.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 21:04:06 -0700 (PDT)
Message-ID: <a1ba10df-b521-40f7-941f-ab94b1bf9890@gmail.com>
Date: Sat, 27 Jul 2024 12:04:01 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpf: Add bpf_check_attach_target_with_klog
 method to output failure logs to kernel
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Zheao Li <me@manjusaka.me>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240725051511.57112-1-me@manjusaka.me>
 <08e180da-e841-427d-bed6-3ba8d73e8519@linux.dev>
 <c7952df9-5830-45d3-89bb-b45f2b030e24@gmail.com>
 <6511ce2a-1c7d-497c-aeb6-d4f0b17271ed@linux.dev>
 <2c6b1737-0a96-44ed-afe9-655444121984@gmail.com>
 <CAEf4BzbL0xfdCEYmzfQ4qCWQxKJAK=TwsdS3k=L58AoVyObL3Q@mail.gmail.com>
 <0f5b7717-fad3-4c89-bacf-7a11baf7a9df@gmail.com>
 <CAEf4BzZCz+sLuAUF65SaHqPUemsUb0WBhAhLYoaAs54VfH1V2w@mail.gmail.com>
Content-Language: en-US
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <CAEf4BzZCz+sLuAUF65SaHqPUemsUb0WBhAhLYoaAs54VfH1V2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/7/27 08:12, Andrii Nakryiko wrote:
> On Thu, Jul 25, 2024 at 7:57 PM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>
>>
>>
>> On 26/7/24 05:27, Andrii Nakryiko wrote:
>>> On Thu, Jul 25, 2024 at 12:33 AM Leon Hwang <hffilwlqm@gmail.com> wrote:
>>>>
>>>>
>>>>
>>>> On 25/7/24 14:09, Yonghong Song wrote:
>>>>>
>>>>> On 7/24/24 11:05 PM, Leon Hwang wrote:
>>>>>>
>>>>>> On 25/7/24 13:54, Yonghong Song wrote:
>>>>>>> On 7/24/24 10:15 PM, Zheao Li wrote:
>>>>>>>> This is a v2 patch, previous Link:
>>>>>>>> https://lore.kernel.org/bpf/20240724152521.20546-1-me@manjusaka.me/T/#u
>>>>>>>>
>>
>> [SNI]
>>
> 
> [...]
> 
>>>
>>
>> Build and run, sudo ./retsnoop -e verbose -e bpf_log -e
>> bpf_verifier_vlog -e bpf_verifier_log_write -STA -v, here's the output:
>>
>>
>> FUNCTION CALLS   RESULT  DURATION  ARGS
>> --------------   ------  --------  ----
>> ↔ bpf_log        [void]   1.350us  log=NULL fmt='%s() is not a global
>> function ' =(vararg)
>>
>> It's great to show arguments.
>>
> 
> Thanks for repro steps, they worked. Also, I just pushed latest
> retsnoop version to Github that does support capturing vararg
> arguments for printf-like functions. See full debugging log at [0],
> but I basically did just two things:
> 
> $ sudo retsnoop -e '*sys_bpf' --lbr -n freplace
> 
> -n freplace filters by process name, to avoid the noise. I traced
> bpf() syscall (*sys_bf), and I requested function call LBR (Last
> Branch Record) stack. LBR showed that we have
> bpf_prog_attach_check_attach_type() call, and then eventually we get
> to bpf_log().
> 
> So I then traced bpf_log (no --lbr this time, but I requested function
> trace + arguments capture:
> 
> $ sudo retsnoop -n freplace -e '*sys_bpf' -a bpf_log -TA
> 
> 17:02:39.968302 -> 17:02:39.968307 TID/PID 2730863/2730855 (freplace/freplace):
> 
> FUNCTION CALLS      RESULT     DURATION  ARGS
> -----------------   ---------  --------  ----
> → __x64_sys_bpf
> regs=&{.r15=2,.r14=0xc0000061c0,.bp=0xc00169f8a8,.bx=28,.r11=514,.ax=0xffffffffffffffda,.cx=0x404f4e,.dx=64,.si=0xc00169fa10…
>     → __sys_bpf                          cmd=28
> uattr={{.kernel=0xc00169fa10,.user=0xc00169fa10}} size=64
>         ↔ bpf_log   [void]      1.550us  log=NULL fmt='%s() is not a
> global function ' vararg0='stub_handler_static'
>     ← __sys_bpf     [-EINVAL]   4.115us
> ← __x64_sys_bpf     [-EINVAL]   5.467us
> 
> 
> For __x64_sys_bpf that's struct pt_regs, which isn't that interesting,
> but then we have:
> 
> ↔ bpf_log   [void]      1.550us  log=NULL fmt='%s() is not a global
> function ' vararg0='stub_handler_static'

It's awesome to show vararg.

> 
> Which showed format string and the argument passed to it:
> 'stub_hanler_static' subprogram seems to be the problem here.
> 
> 
> Anyways, tbh, for a problem like this, it's probably best to just
> request a verbose log when doing the BPF_PROG_LOAD command. You can
> *normally* use veristat tool to get that easily, if you have a .bpf.o
> object file on the disk. But in this case it's freplace and veristat
> doesn't know what's the target BPF program, so it's not that useful in
> this case:
> 
> $ sudo veristat -v freplace_bpfel.o
> Processing 'freplace_bpfel.o'...
> libbpf: prog 'freplace_handler': attach program FD is not set
> libbpf: prog 'freplace_handler': failed to prepare load attributes: -22
> libbpf: prog 'freplace_handler': failed to load: -22
> libbpf: failed to load object 'freplace_bpfel.o'
> PROCESSING freplace_bpfel.o/freplace_handler, DURATION US: 0, VERDICT:
> failure, VERIFIER LOG:
> 
> File              Program           Verdict  Duration (us)  Insns
> States  Peak states
> ----------------  ----------------  -------  -------------  -----
> ------  -----------
> freplace_bpfel.o  freplace_handler  failure              0      0
>  0            0
> ----------------  ----------------  -------  -------------  -----
> ------  -----------
> Done. Processed 1 files, 0 programs. Skipped 1 files, 0 programs.
> 
> But for lots of other programs this would be a no-brainer.
> 
> 
>   [0] https://gist.github.com/anakryiko/88a1597a68e43dc945e40fde88a96e7e
> 
> [...]
> 
>>
>> Is it OK to add a tracepoint here? I think tracepoint is more generic
>> than retsnoop-like way.
> 
> I personally don't see a problem with adding tracepoint, but how would
> it look like, given we are talking about vararg printf-style function
> calls? I'm not sure how that should be represented in such a way as to
> make it compatible with tracepoints and not cause any runtime
> overhead.

The tracepoint is not about vararg printf-style function calls.

It is to trace the reason why it fails to bpf_check_attach_target() at
attach time.

So, let me introduce bpf_check_attach_target_with_tracepoint() and
BPF_LOG_KERNEL_WITHOUT_PRINT. bpf_check_attach_target_with_tracepoint()
is to call bpf_check_attach_target() and then to call
trace_bpf_check_attach_target() if err. BPF_LOG_KERNEL_WITHOUT_PRINT is
to avoid pr_err() in bpf_verifier_vlog().

Here's the diff without trace_bpf_check_attach_target() definition:

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index bfd093ac333f2..717e4deda2998 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -629,6 +629,7 @@ struct bpf_verifier_log {
 #define BPF_LOG_LEVEL	(BPF_LOG_LEVEL1 | BPF_LOG_LEVEL2)
 #define BPF_LOG_MASK	(BPF_LOG_LEVEL | BPF_LOG_STATS | BPF_LOG_FIXED)
 #define BPF_LOG_KERNEL	(BPF_LOG_MASK + 1) /* kernel internal flag */
+#define BPF_LOG_KERNEL_WITHOUT_PRINT (BPF_LOG_KERNEL << 1)
 #define BPF_LOG_MIN_ALIGNMENT 8U
 #define BPF_LOG_ALIGNMENT 40U

@@ -853,6 +854,11 @@ int bpf_check_attach_target(struct bpf_verifier_log
*log,
 			    const struct bpf_prog *tgt_prog,
 			    u32 btf_id,
 			    struct bpf_attach_target_info *tgt_info);
+int bpf_check_attach_target_with_tracepoint(const struct bpf_prog *prog,
+					    const struct bpf_prog *tgt_prog,
+					    u32 btf_id,
+					    struct bpf_attach_target_info *tgt_info);
+
 void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);

 int mark_chain_precision(struct bpf_verifier_env *env, int regno);
diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 5aebfc3051e3a..2bdcdd2fc320f 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -65,8 +65,10 @@ void bpf_verifier_vlog(struct bpf_verifier_log *log,
const char *fmt,

 	n = vscnprintf(log->kbuf, BPF_VERIFIER_TMP_LOG_SIZE, fmt, args);

-	if (log->level == BPF_LOG_KERNEL) {
+	if (log->level & BPF_LOG_KERNEL) {
 		bool newline = n > 0 && log->kbuf[n - 1] == '\n';
+		if (log->level & BPF_LOG_KERNEL_WITHOUT_PRINT)
+			return;

 		pr_err("BPF: %s%s", log->kbuf, newline ? "" : "\n");
 		return;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 869265852d515..4d293a8da5a9b 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3464,8 +3464,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog
*prog,
 		 */
 		struct bpf_attach_target_info tgt_info = {};

-		err = bpf_check_attach_target(NULL, prog, tgt_prog, btf_id,
-					      &tgt_info);
+		err = bpf_check_attach_target_with_tracepoint(prog, tgt_prog,
+							      btf_id, &tgt_info);
 		if (err)
 			goto out_unlock;

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index f8302a5ca400d..44b9f95a07e9c 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -699,9 +699,9 @@ int bpf_trampoline_link_cgroup_shim(struct bpf_prog
*prog,
 	u64 key;
 	int err;

-	err = bpf_check_attach_target(NULL, prog, NULL,
-				      prog->aux->attach_btf_id,
-				      &tgt_info);
+	err = bpf_check_attach_target_with_tracepoint(prog, NULL,
+						      prog->aux->attach_btf_id,
+						      &tgt_info);
 	if (err)
 		return err;

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1f5302fb09570..acd9b1b96c76c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21929,6 +21929,28 @@ int bpf_check_attach_target(struct
bpf_verifier_log *log,
 	return 0;
 }

+int bpf_check_attach_target_with_tracepoint(const struct bpf_prog *prog,
+					    const struct bpf_prog *tgt_prog,
+					    u32 btf_id,
+					    struct bpf_attach_target_info *tgt_info);
+{
+	struct bpf_verifier_log *log;
+	int err;
+
+	log = kzalloc(sizeof(*log), GFP_KERNEL);
+	if (!log) {
+		err = -ENOMEM;
+		return err;
+	}
+
+	log->level = BPF_LOG_KERNEL | BPF_LOG_KERNEL_WITHOUT_PRINT;
+	err = bpf_check_attach_target(log, prog, tgt_prog, btf_id, tgt_info);
+	if (err)
+		trace_bpf_check_attach_target(log->kbuf);
+	kfree(log);
+	return err;
+}
+
 BTF_SET_START(btf_id_deny)
 BTF_ID_UNUSED
 #ifdef CONFIG_SMP


