Return-Path: <bpf+bounces-58441-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57024ABA85D
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 07:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368A01B63B72
	for <lists+bpf@lfdr.de>; Sat, 17 May 2025 05:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D880156C62;
	Sat, 17 May 2025 05:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbSQS5N9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A659A1FC8
	for <bpf@vger.kernel.org>; Sat, 17 May 2025 05:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747458113; cv=none; b=YOLUuq230ZJY2mJSmYgTW0csZkp6dyvqXglQYf/XdP3SBK0EA3pGzzY/CGUeE6Dt6AIr9+18weQsfSgvK03oY8W2iGw7N6A8XisaqfRCuF75uOoT77pjhlGTkT4AUBeWaoY8hEawHjEV6urv/JuZvRulMhdrB2wujpOvbkCcxaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747458113; c=relaxed/simple;
	bh=glwLiYrH9bqkVFyQ4Ss+xib8fsypSJWbykny1u6D9Gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QwZzT2Y/g2jRvEf/NbPeta/QRWTJ6oOVipa19/7o5JTM6QuhogUgrB/ZlKekDp8RNl6kka+kr/UCeJnud1pzqPnwhoZIBv+TMZqpCTx86pWCwDpHFWDIDRJ2vvG4vvr272mQrv/BCJ0DV7kSuinouJZ9im51vtCXNPwwJEQ2WKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbSQS5N9; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e73e9e18556so2681363276.0
        for <bpf@vger.kernel.org>; Fri, 16 May 2025 22:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747458110; x=1748062910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wi5yt8nW6YuXw2FXkd0e5aSE9TTfTOr5f7f11J6zXZY=;
        b=FbSQS5N96kBCPFCTlEmBTWOVwC7JMsZpZzbNXUByne0++Apc8YdTBAxQcDXf4yWwBB
         ceP3zAaidldezkekrEfKYevzJ0Fdh/Q1KV7plSI8XnNHnqn2w/X/bBznPucIw2171C8s
         mWRZjZ3F/Wv2kUqYjVRr2TB/odWl+Qa8CPj4PUehGtf+LkgEe+8KbncFGsG485hzfj8t
         rbWb3ClaAFtLsbiHre5uGLueh/Adxn6GX6PfEiVGqeg+desekloqbvJV7xVk1I64ZLiY
         8SNezSbS9gRPhNSukfv0OfJXv1/AmbCLPMWpt2grgOPGtLVM5dxyt7rYyiTZQ7oa5EuF
         dQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747458110; x=1748062910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wi5yt8nW6YuXw2FXkd0e5aSE9TTfTOr5f7f11J6zXZY=;
        b=ljc2aOvVkxeZD5g1jaw+HFhEuMQj0rpTtSmWW8cyO2OLr26tg8YqrlYUoU7Pf1uPjn
         aKfVUwvV0xyzWxk75wk43Mz9HaMkcAtcuJJwv0LZalYFdBL31XMDuMHwS9a4Z70P86gB
         kYNz7MnAA3rB2lISEB5zToFWSqc4bx0gDeA8P+4r0Ul0I+a2l/LACMKUDYkWjPZtSpdr
         T/1JpI0ilelkP2RDqseSJpp/F6hDe31tebPuJOrKCBqe1UIm4XTDtqk1NTUpESDfxKrd
         m/kSO083aVG96fTd7/Qy+3RyTgi2WNeCgQ2Oa3n9qFFIVXaFuYW/aqIKUCeu0dhOU5h3
         xb7g==
X-Forwarded-Encrypted: i=1; AJvYcCWhNPxtE8EK8y2zsW3HYK/cgC12+SlagCcxzFlxmlkOv/5vc9dMS8X+mFBkBzY9tOtAPJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/KoMbbjFDH4M/0dUXOsEh0zcFfdBGxX5H1nrNjAfHrjYfuajd
	Q8JtPSRCdtk2bei+E9iAFnzMmm4MK7iSbM1hq7WOL7JBmsFc2uyTao8ovlb+r22mNoGMJHjW/3L
	UAERM9NeQLuazi8r0u1r+aHqwef5kM+A=
X-Gm-Gg: ASbGncvWV5zR7VzUg6NBMDZryB1rAsc9E6kiMoEPhsgEhW8R9vbw9AklnA3wmFJV1yV
	DvqY8HBDKn22TBsjsr7Ni6XbZMflp5vSDE+YIWaAdKJinpLCw4fzn8pdx38sP5G/dTXfZ/wBEmu
	AYYhzVsiszAnocMcnbPtw7BRjZCOD6VKOPgFgfzKHYMcfO/cDvu9GR+0PBqMSB10PQpWmTQ4d94
	8Ip
X-Google-Smtp-Source: AGHT+IGxHuj+Ua12KqE99ZHg2tw0iQbXDn2RBBfTUMXQ48BM5j9jeIXxCmgO9CDHHzQWyWRXcuvISotnfbIzn3GVARA=
X-Received: by 2002:a05:6902:1202:b0:e79:12b4:a4f with SMTP id
 3f1490d57ef6-e7b6b17bc4amr7094319276.11.1747458110410; Fri, 16 May 2025
 22:01:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420105524.2115690-1-rjsu26@gmail.com> <20250420105524.2115690-4-rjsu26@gmail.com>
 <m27c2l1ihl.fsf@gmail.com> <CAADnVQJZpyqY9TWanRKjmViOZxppAeh7FGAnxV_1CKAih7drkA@mail.gmail.com>
 <CAE5sdEh3NuXUcjScj4Auvtc2701NAS6fu0hpzLGVnaoQ7ESnfg@mail.gmail.com> <CAADnVQKX2=jYfs5TBBKdKxHPi_ssUvrSuxbr22-dmYoP_e3=dA@mail.gmail.com>
In-Reply-To: <CAADnVQKX2=jYfs5TBBKdKxHPi_ssUvrSuxbr22-dmYoP_e3=dA@mail.gmail.com>
From: Raj Sahu <rjsu26@gmail.com>
Date: Fri, 16 May 2025 22:01:34 -0700
X-Gm-Features: AX0GCFt8giDVOP9BZqSAV_HOqOXXZv5ovVDBW-qofJm2Iuctz3dO6AOO3YXtypI
Message-ID: <CAM6KYssQwOnOqQT6TxHuu1_vDmmuw+OtFB=FwPLqbFcv+QdVrg@mail.gmail.com>
Subject: Re: [RFC bpf-next 3/4] bpf: Generating a stubbed version of BPF
 program for termination
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Dan Williams <djwillia@vt.edu>, miloc@vt.edu, ericts@vt.edu, 
	rahult@vt.edu, doniaghazy@vt.edu, quanzhif@vt.edu, 
	Jinghao Jia <jinghao7@illinois.edu>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> In terms of detection this is a subset of watchdog.
> In terms of termination we still need to figure out the best
> path forward.
> bpf_loop() may or may not be inlined.
> If it's still a helper call then we can have per-prog "stop_me" flag,
> but it will penalize run-time, and won't really work for
> inlined (unless we force inlining logic to consult that flag
> as well).
> One option is to patch the callback subprog to return 1,
> but the callback might not have a branch that returns 1.
> Another option is to remember the insn that does:
>         /* loop header,
>          * if reg_loop_cnt >= reg_loop_max skip the loop body
>          */
>         insn_buf[cnt++] = BPF_JMP_REG(BPF_JGE, reg_loop_cnt, reg_loop_max, 5);
>
> in inlined bpf_loop() and patch that insn with 'goto +5',
> so inlined bpf_loop will terminate quickly.
>
We indeed thought about modifying the subprog to return 1 but realised
it would be complex. Currently the design does 2 things:
   1. For Inlining case we set the R0 = 1 which is later checked and forces
       the for loop to stop.

@@ -22502,7 +22506,14 @@ static struct bpf_prog
*inline_bpf_loop(struct bpf_verifier_env *env,

+ if (termination_states && termination_states->is_termination_prog) {
+                 /* In a termination BPF prog, we want to exit - set R0 = 1 */
+                 insn_buf[cnt++] = BPF_MOV64_IMM(BPF_REG_0, 1);
+ } else {
+                 insn_buf[cnt++] = BPF_CALL_REL(0);
+ }
+

   2. For non-inlining cases we just modified the bpf_loop helper.
This implies 2 things:
            2.1 If bpf_loop is yet to be executed, then bingo. We just return.
            2.2 If we are currently inside a bpf_loop, we must be
iteratively calling the callback function
                  (which btw is also stubbed out of all helpers and bpf_loop).
                  So the already running bpf_loop won't be doing any
expensive helper calls or issuing
                  further loop calls and the long-running BPF
program's execution time will be brought down
                  significantly.

> I mean the verifier should prepare the whole batch with all insns
> that needs to be patched and apply the whole thing at once
> with one call to text_poke_bp_batch() that will affect all cpus.
> It doesn't matter where the program was running on this cpu.
> It might be running somewhere else on a different cpu.
> text_poke_bp_batch() won't be atomic, but it doesn't have to be.
> Every cpu might have a different fast-execute path to exit.

While I was going through the definition of text_poke_bp_batch, I am
worried if, say, a running
instruction ends up getting modified midway with another instruction,
making the CPU read
half of insn1 and half of insn2. That would end up faulting !?

