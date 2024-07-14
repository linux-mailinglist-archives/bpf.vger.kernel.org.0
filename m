Return-Path: <bpf+bounces-34776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CBE930A62
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 16:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4C41F21A79
	for <lists+bpf@lfdr.de>; Sun, 14 Jul 2024 14:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4FA136E17;
	Sun, 14 Jul 2024 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyJttMWD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A119770EC
	for <bpf@vger.kernel.org>; Sun, 14 Jul 2024 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720967518; cv=none; b=NhQt89awOvaaCprqEG0Khvn8iLIkudP50m6ZxwvSCcyncK7FXG00OA1bUtzYVl7yVBsjdfrqQyPoTCR2TMxGScCxPwffosGA5iVVX48zESSj1onfknqTwJbERbuzanEmPY1xokmkII760ER1t0+ffDxqQMYlz/09ZSyrG8pwAiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720967518; c=relaxed/simple;
	bh=y06X4aUCQXlSrPRuvHKiB+Sj41QHbUbSG9sTKJg5buI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ZsySCHBfswCWhyLv0k+kvGknbPPFV6EJPqcpOb8s0Puwpo5OSp+35qIvCd5+bU5rSg8Gbrd76SLiGq+Oc2ax/fb6Pq7X6J7tEPMz36L3uxIFSWftYY8eYdt8bTdWwWJ2C9NjvXovoM54A+K9kx9tvNYpqNmyghLsSOnUUfk87L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyJttMWD; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5c669a0b5d1so1964024eaf.3
        for <bpf@vger.kernel.org>; Sun, 14 Jul 2024 07:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720967516; x=1721572316; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J2tpOhq6FDiJWjEbv5ojTWQ9PZY7yy/eO9AOTNPZoYw=;
        b=fyJttMWDlGsAudJe4W7T8m+4ezY8zY3oT5xSkm8UbSMwJDjavBdwZn6sSoAQ4RQveC
         objB9v5VjAjvgjX8HrNZlWEyU9BXyWmkp6TriIxjsYGqzVFXYsn3qHbhI5o+8GwhrCpQ
         epbJYBrunhx2iNUIJubwQPd4B6nWrvZSE6VRMweeGRpc0SX6vbgeJQKhWe4dsjL2QtIq
         mm/Gn1L+taxWbHqpfCDp48ZlIWDra9etaTczmMYkpa03P8ATranG0vwGVcs/IsR4ldbM
         tcNA7eSC+4A7MpiFWl7fPSzvE3eGbeeCvaHbhjCJjUvGFvW0RdWsgFWHGSqeRV8ylrJc
         VGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720967516; x=1721572316;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2tpOhq6FDiJWjEbv5ojTWQ9PZY7yy/eO9AOTNPZoYw=;
        b=hJRiOelQuzc08DGUgFWSuz2i/aIZsSE/P+/M4+ijBma7oO/NzoZIl/OsO8U9i82tn4
         FjqwXkG5gSmPtnhmLMYG5gBsTz5ECvCb6Q8WpxZxM38eedq8rOJyIhCNheRtkkcYG6EL
         fYR/XRyGFA9pI/KWSh2s5dy+6dWX1o9DE6T6yoABonsgLvYSmSmtAJaKJ+ervSahClEz
         Qyx4fiIRIWw1bx/NlGwgWXPAP9ehxwAjjsFJWkTxRq/qTpZh6wr1vHo5xr3VDWmuZe+G
         xYrc/xlWJtQVyALlBrh8804H1EegYeRBjhTx/yFTKEbB4YoT4/TLudlVA83LeGNkxGNH
         W7Ng==
X-Gm-Message-State: AOJu0Yx7p3tqjvJJev2eQeigJ2nRsNc0xc3hfblggTz9hs4MFIOC62BF
	Pv9KJHLQmKMav0E+MZ+X6XUU+SOHRY1zyecRncam2n44ymfTRIwOS2Fga8T9tFOlMS/y7Jfg53t
	z8iFu2w27GQA0ulFp+KKXdK9nmq5sHwua
X-Google-Smtp-Source: AGHT+IFDbOdTHBwwZ5XMopfWfxDVjoinlrjU4Ji9gtmHEE3TImJw1SNHtAHB//7wQSG3ZkhGBYBKWdYuaav+fmmhoeo=
X-Received: by 2002:a05:6358:5913:b0:1aa:a27c:ae94 with SMTP id
 e5c5f4694b2df-1aade0dc175mr1776292855d.24.1720967515689; Sun, 14 Jul 2024
 07:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGQdkDtQC1=W1NYyO7w2s7f=nJdD_oafVx5szKASM-6wGAmQ6Q@mail.gmail.com>
In-Reply-To: <CAGQdkDtQC1=W1NYyO7w2s7f=nJdD_oafVx5szKASM-6wGAmQ6Q@mail.gmail.com>
From: andrea terzolo <andreaterzolo3@gmail.com>
Date: Sun, 14 Jul 2024 16:31:44 +0200
Message-ID: <CAGQdkDtgqwJkHyx+txp6hQD83qUaRRWuo7nYMVGZq79xw+kgTA@mail.gmail.com>
Subject: Re: [QUESTION] Check PTR_UNTRUSTED usage in sleepable eBPF iterators
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Jul 2024 at 18:45, andrea terzolo <andreaterzolo3@gmail.com> wrote:
>
> Hi folks! I would like to check with you if the verifier failure I'm
> facing is expected. The verifier rejects the following eBPF program in
> recent kernel versions (e.g. 6.8.0-1010-aws). The same program
> correctly works on older kernel versions (e.g. 6.5.0-41-generic) so
> it's unclear to me why now the verifier should reject it.
>
> ```
> #define EXE_PATH_MAX_LEN 512
> char exe_path[EXE_PATH_MAX_LEN];
>
> SEC("iter.s/task")
> int dump_task(struct bpf_iter__task *ctx) {
>   struct task_struct *task = ctx->task;
>
>   if (task == NULL) {
>     return 0;
>   }
>
>   struct file *exe_file = task->mm->exe_file;
>   if (exe_file != NULL) {
>     bpf_d_path(&(exe_file->f_path), exe_path, EXE_PATH_MAX_LEN);
>     bpf_printk("exe path: %s", exe_path);
>   }
>   return 0;
> }
> ```
>
> Verifier log
>
> ```
> -- BEGIN PROG LOAD LOG --
> 0: R1=ctx() R10=fp0
> ; struct task_struct *task = ctx->task;
> 0: (79) r1 = *(u64 *)(r1 +8)          ;
> R1_w=trusted_ptr_or_null_task_struct(id=1)
> ; if (task == NULL) {
> 1: (15) if r1 == 0x0 goto pc+15       ; R1_w=trusted_ptr_task_struct()
> ; struct file *exe_file = task->mm->exe_file;
> 2: (79) r1 = *(u64 *)(r1 +2264)       ; R1_w=untrusted_ptr_mm_struct()
> ; struct file *exe_file = task->mm->exe_file;
> 3: (79) r1 = *(u64 *)(r1 +1176)       ; R1_w=untrusted_ptr_file()
> ; if (exe_file != NULL) {
> 4: (15) if r1 == 0x0 goto pc+12       ; R1_w=untrusted_ptr_file()
> 5: (b7) r2 = 152                      ; R2_w=152
> 6: (0f) r1 += r2                      ;
> R1_w=untrusted_ptr_file(off=152) R2_w=152
> ; bpf_d_path(&(exe_file->f_path), exe_path, EXE_PATH_MAX_LEN);
> 7: (18) r2 = 0xffffa839013ee000       ;
> R2_w=map_value(map=bpf_iter.bss,ks=4,vs=528)
> 9: (b7) r3 = 512                      ; R3_w=512
> 10: (85) call bpf_d_path#147
> R1 type=untrusted_ptr_ expected=ptr_, trusted_ptr_, rcu_ptr_
> processed 10 insns (limit 1000000) max_states_per_insn 0 total_states
> 0 peak_states 0 mark_read 0
> -- END PROG LOAD LOG --
> ```
>
> From what I understand, as soon as we dereference the `struct
> task_struct *task` pointer inside an RCU CS we obtain an untrusted
> pointer (e.g. after `task->mm` we already have an untrusted pointer).
>
Sorry, here I meant "outside an RCU CS" instead of "inside".
>
> This causes the `bpf_d_path` helper to fail because it receives an
> `untrusted_ptr_file`. In this case, I marked the eBPF program as
> sleepable on purpose, to trigger the failure. If I use a not-sleepable
> bpf iterator the `bpf_d_path` helper correctly receives a
> `PTR_TO_BTF_ID` and everything works fine.
>
Ok, I checked the code, and the reason seems that all non-sleepable
eBPF programs are always contained in an RCU CS. So the `in_rcu_cs`
method always returns `true`.
To emulate the same behavior in a sleepable program we need to
explicitly add an RCU CS.

```
#define EXE_PATH_MAX_LEN 512
char exe_path[EXE_PATH_MAX_LEN];

extern void bpf_rcu_read_lock(void) __ksym;
extern void bpf_rcu_read_unlock(void) __ksym;

SEC("iter.s/task")
int dump_task(struct bpf_iter__task *ctx) {
  struct task_struct *task = ctx->task;

  if (task == NULL) {
    return 0;
  }
  bpf_rcu_read_lock();
  struct file *exe_file = task->mm->exe_file;
  if (exe_file != NULL) {
    bpf_d_path(&(exe_file->f_path), exe_path, EXE_PATH_MAX_LEN);
    bpf_printk("exe path: %s", exe_path);
  }
  bpf_rcu_read_unlock();

  return 0;
}
```
>
> I'm wondering if this is the expected behavior and if so, how can I
> continue to use the `bpf_d_path` helper inside this sleepable ebpf
> program? Is there a way to obtain again a `PTR_TO_BTF_ID` for
> `&(exe_file->f_path)` to satisfy the `bpf_d_path` signature?

So what has changed is that now in sleepable progs we explicitly need
to create RCU CS when we dereference trusted pointers if we want to
preserve `PTR_TO_BTF_ID` pointers

