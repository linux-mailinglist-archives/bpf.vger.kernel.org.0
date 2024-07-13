Return-Path: <bpf+bounces-34734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1943F930671
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 18:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 445A7B20C51
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 16:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B042113B287;
	Sat, 13 Jul 2024 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irdq6KWg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED96E2E639
	for <bpf@vger.kernel.org>; Sat, 13 Jul 2024 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720889132; cv=none; b=crsvTIjyUuwa0N5Wudc+Ql7kTOvmQcAQeLWSXznX7p/CK8lK9wC5+hfyvEqwMaJaGU6a8dwKDE6DcF/QWx8iTB44suraGSieHaFx/ZcFeYAyKIw6jYQ51iB8rs6aoK2BQCaickKFXAm1LByI1WF6juU2o+HOdBr6SzUn4zinYoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720889132; c=relaxed/simple;
	bh=0S/YTCLvOCjMP9AW2yVRnjqHmXT/G9Nv3b3zuJuHjww=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZuaqRxvStE24MkHGxRrOgOT5qB9SbUy9BuKmlcqBsAjoO7oDG+ZSqsDYHeZxh/TKlEVpJltXEhvs4I88kIiCA2ze4P0DUapbR4dnsXUJMAnNWQ8CwW0oYlZZh3UIBI5/BAjvB9ordqae0wnG7Ds/MAqLHpvlOXRpu2oT2BB2dso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irdq6KWg; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70af8062039so2283458b3a.0
        for <bpf@vger.kernel.org>; Sat, 13 Jul 2024 09:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720889130; x=1721493930; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=98aSC0HfCjSbtf79XPNLJZHcuUp6619e3rZOzIhkZcY=;
        b=irdq6KWgBjGzv3SBj6jKYDY/qdka+2/aZtETBmF3qZm8KQLWYNtyKkm6QxM1luyVVf
         95jS7px/3RUwdmvwI83VZoIgjxN3dqNF7qUFMrDjFy5nzWh5NnTlu2JiWpDNlIdwmjzK
         Kjk8JwD+KgBu4Lb9WO48dlABqesQWYhUuGbwjD7sTYe08YDTD+h78hKwkuxpVGCD5zWF
         GOco4L17By+K7q2QcUpDN6czq+cMLWxSu42yZGPLtHH8F5tzYdzEg8kTdpa2LStqWQH9
         mU9TbuNJCHHeKJdgAgNogi2KXaEbqYnVzXw1XAkAvrTMqffojsGDFzIeq860XvX5Cn52
         W3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720889130; x=1721493930;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=98aSC0HfCjSbtf79XPNLJZHcuUp6619e3rZOzIhkZcY=;
        b=e35VCSu681m7zbbKBvXJcmhJLG9LNAaNW/90SUxbPhw7Mrp5vWiV0e7WwNF0KReagg
         IaqhysgaCoO4dT20mkvX3HN8S4kSQHJ8cOSveAo/JK8HYs4LA9y/qS9vOu7lrNSA/uB0
         QU+BTB25xAz/cDzCPsb4+d17pSCkwmnJ8dq1g83SNcAgSB91j6MG8gzgPpvNfjncnH+u
         glX3C2VLamvxuPU67uXb2cdGKZjYHdYrGzv9F05Pj/SA6gPsvStjGBL0F8xdHbyEUDHa
         cnBRtm0ltgpu1EuMHbRIV5gU5XBu4gy9dFJpTfbjeyvHR1VfquvdleCVjMPv3OHli8Ed
         UISA==
X-Gm-Message-State: AOJu0Yw3ajTFTnOyR9dI1QtnZj91ElDLqIycR4+ebHMg8v82MBoSzQr/
	yZkhmrXsTbDcvkUhPKFA40CLZfsl+ShbsUteKyhq6FuwEm2aZ5eUUYSVTBTM0NKlvqXa1anFG7Q
	+rX/Hu06Qxyo+KcbQw8bFFBBR3OS5Micj
X-Google-Smtp-Source: AGHT+IGEVIHCq4ftw4b/5tYUuRNvuYV7kodpu9Bc/IrMc5iK1g30cwUi1sbkOZqq4wPnYFIhEPH5gNGDaHXMMVpI7U0=
X-Received: by 2002:a05:6a20:3948:b0:1c2:94ad:1c5d with SMTP id
 adf61e73a8af0-1c2981fbf1bmr16812180637.2.1720889129872; Sat, 13 Jul 2024
 09:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: andrea terzolo <andreaterzolo3@gmail.com>
Date: Sat, 13 Jul 2024 18:45:18 +0200
Message-ID: <CAGQdkDtQC1=W1NYyO7w2s7f=nJdD_oafVx5szKASM-6wGAmQ6Q@mail.gmail.com>
Subject: [QUESTION] Check PTR_UNTRUSTED usage in sleepable eBPF iterators
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi folks! I would like to check with you if the verifier failure I'm
facing is expected. The verifier rejects the following eBPF program in
recent kernel versions (e.g. 6.8.0-1010-aws). The same program
correctly works on older kernel versions (e.g. 6.5.0-41-generic) so
it's unclear to me why now the verifier should reject it.

```
#define EXE_PATH_MAX_LEN 512
char exe_path[EXE_PATH_MAX_LEN];

SEC("iter.s/task")
int dump_task(struct bpf_iter__task *ctx) {
  struct task_struct *task = ctx->task;

  if (task == NULL) {
    return 0;
  }

  struct file *exe_file = task->mm->exe_file;
  if (exe_file != NULL) {
    bpf_d_path(&(exe_file->f_path), exe_path, EXE_PATH_MAX_LEN);
    bpf_printk("exe path: %s", exe_path);
  }
  return 0;
}
```

Verifier log

```
-- BEGIN PROG LOAD LOG --
0: R1=ctx() R10=fp0
; struct task_struct *task = ctx->task;
0: (79) r1 = *(u64 *)(r1 +8)          ;
R1_w=trusted_ptr_or_null_task_struct(id=1)
; if (task == NULL) {
1: (15) if r1 == 0x0 goto pc+15       ; R1_w=trusted_ptr_task_struct()
; struct file *exe_file = task->mm->exe_file;
2: (79) r1 = *(u64 *)(r1 +2264)       ; R1_w=untrusted_ptr_mm_struct()
; struct file *exe_file = task->mm->exe_file;
3: (79) r1 = *(u64 *)(r1 +1176)       ; R1_w=untrusted_ptr_file()
; if (exe_file != NULL) {
4: (15) if r1 == 0x0 goto pc+12       ; R1_w=untrusted_ptr_file()
5: (b7) r2 = 152                      ; R2_w=152
6: (0f) r1 += r2                      ;
R1_w=untrusted_ptr_file(off=152) R2_w=152
; bpf_d_path(&(exe_file->f_path), exe_path, EXE_PATH_MAX_LEN);
7: (18) r2 = 0xffffa839013ee000       ;
R2_w=map_value(map=bpf_iter.bss,ks=4,vs=528)
9: (b7) r3 = 512                      ; R3_w=512
10: (85) call bpf_d_path#147
R1 type=untrusted_ptr_ expected=ptr_, trusted_ptr_, rcu_ptr_
processed 10 insns (limit 1000000) max_states_per_insn 0 total_states
0 peak_states 0 mark_read 0
-- END PROG LOAD LOG --
```

From what I understand, as soon as we dereference the `struct
task_struct *task` pointer inside an RCU CS we obtain an untrusted
pointer (e.g. after `task->mm` we already have an untrusted pointer).
This causes the `bpf_d_path` helper to fail because it receives an
`untrusted_ptr_file`. In this case, I marked the eBPF program as
sleepable on purpose, to trigger the failure. If I use a not-sleepable
bpf iterator the `bpf_d_path` helper correctly receives a
`PTR_TO_BTF_ID` and everything works fine.

I'm wondering if this is the expected behavior and if so, how can I
continue to use the `bpf_d_path` helper inside this sleepable ebpf
program? Is there a way to obtain again a `PTR_TO_BTF_ID` for
`&(exe_file->f_path)` to satisfy the `bpf_d_path` signature?

