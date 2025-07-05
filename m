Return-Path: <bpf+bounces-62462-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C90AF9E4C
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 06:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1590D1C47AAF
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 04:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D5D227B8E;
	Sat,  5 Jul 2025 04:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOAF/Dul"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697472E370A
	for <bpf@vger.kernel.org>; Sat,  5 Jul 2025 04:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751690467; cv=none; b=adgqN+Ey1KUS4S5AziJB70I76+golKjvgkqDRQ56kpzGtJ1TwM3wWin1QiSgjME6JaCIy3Z8Ckdkenm/+bwrWaYqRXi0ha72GS4/HRU570oR2YkZy7QDWUSdQ8ISeZVfXH+Y1YZrt39K+siabPgx15YJTysvWhae/DHq62ZHY6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751690467; c=relaxed/simple;
	bh=6D7h/R6hUP75s46AyjGzQ8L8ovXutfvFioA4FU4zTNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cinksNaoU+Ts4mdsA3qa5BqXbLfKyZcqcORh/eOcOaJlY+whB6SSeaelq9uUvctZ/9NzFBb6vExIPvKQ+RrcAScSZhszhgTaysGUIp1RsL3L74HD209NG2UBqFaapVBjfelCxtQi1+LDE5x3HY2DgBWB1eD5ewTZNr4YIKdNzug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOAF/Dul; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so249166866b.0
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 21:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751690464; x=1752295264; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fYCIlfXigHVeNE443XMGkY+cJ+NhXU3ejUxj02sJCs8=;
        b=TOAF/DulRDgKdZNbahsCcZdJsdLtvkhSRDRw8aPzXmzVQNmeIh555xDSy1OGgt7AoR
         LKsqerPcMp9AL+rNF0BGjkWg+sDxTjhTImp18a4fSemeA61nrfF3Ia1Q5K/3Y/Qd7+hL
         otYhfHCczvDOg0CbZ5Rgc9QCbX+fwVdOh/tUtW7/5f+TpstUhpYZ0oquclkrGH6tEav+
         uY6N2541e2TyppLj1gl1hcTlqyRtFBoaZQeYdIhAA5qRPh6CvMrn1PGtGMC4sVZzJGNK
         Pznht3GYaC4TkT3hVP2/qAv14THAVpLkOmWCzqgZ3/Eo0XBZpoFToQkEdIrqQRMEmin2
         e4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751690464; x=1752295264;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fYCIlfXigHVeNE443XMGkY+cJ+NhXU3ejUxj02sJCs8=;
        b=WZ9782NzkXq270AxeD5ArcCaVAI6R4eH3EUH69C/y2IHH+I4yvBoEi9qZmxSWq7ys8
         mUYjP3E0mgGQ2xTmyj3Pd8tt59ArM2ccUldIM9qe+Q8jpk3gVvzQl8ySQ2baZasrBabn
         2bgk6vRLRH7gkxSKdSXopGsgs735aTm3ywPiw42R50luVT6UumljHjCjEQluGaMh0FcN
         Ely4NPp4cg8QaGLACVHPJr7xbj6UwBGm9DKbiWe+Ft/BNBOOctXPU5gbGmcb+WCPOpdA
         WVBFKnwoTcrHDFl8vFCh1yNqn/C8PRiPtZSmXdf9GCBztznqol161F0Zfja363x59Y46
         AXTQ==
X-Gm-Message-State: AOJu0YynKKD9i9cYTMfgX9BVmaBpGrzJS7sUzC5DmHINopwstzAjILEc
	DRd6rKauL1VrBBJLulUlZ3J5ZTpn750TzG4w7T2UeuJT5IWusdBU3PxiBgFJE1mTGVAOFCjDtA9
	60tATxKc/t760ahhgN9h0aB5DUG/wIG9S1LL+
X-Gm-Gg: ASbGncu93Cblku80z1kXVyGnuA/LigZsE+iIMBOorWSCpHOFEQtpMrbduIZ9jALSRgw
	4iys+ULH7OTQvaG/4T6pBDR5fPSgWEl7nmaD8UniSk+EG0jY5y+qMJgRDruhTxE4le6qPyOhCOJ
	emQfig7vO0J4u49VfiFMB8392mP62L9GeoPU0IRlBgWo1FxQ+Mmrh2dnNWrQpCY2iAd7BLm+nDP
	QbU/K5dEDMMFw==
X-Google-Smtp-Source: AGHT+IGW/t4/LQsYh0VZXcHIQ8X8DQWca9hAJjLg59TV9QQTQnJkcqVnBG6XXYEmqNYSwBgTdR6JOwDkRmMIPRgxTvc=
X-Received: by 2002:a17:907:7242:b0:ae3:a240:7ad2 with SMTP id
 a640c23a62f3a-ae3fe64e56fmr420876166b.2.1751690463315; Fri, 04 Jul 2025
 21:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f3527af3b0620ce36e299e97e7532d2555018de2.camel@gmail.com>
In-Reply-To: <f3527af3b0620ce36e299e97e7532d2555018de2.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 5 Jul 2025 06:40:27 +0200
X-Gm-Features: Ac12FXygrTWsX2Z8tw6haX_-uB02YIYCrtVYL28GDjtZMeeXTbTXK9AT_uhOcuM
Message-ID: <CAP01T74O3esz3rZPjWNGqr4EhczRK_b-rj8pUarcv=r=HK+orw@mail.gmail.com>
Subject: Re: KASAN error in core.c:bpf_prog_get_file_line()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Jul 2025 at 04:47, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Hi Kumar,
>
> I hit a KASAN error when running verifier_iterating_callbacks/ja_and_may_goto_subprog test case.
> (CC'ing mailing list in case anyone else runs into it before fix).
> The error is within the function kernel/bpf/core.c:bpf_prog_get_file_line():

Thanks, I'll take a look and send a fix.

>
>
>   int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char **filep,
>                              const char **linep, int *nump)
>   {
>         ...
>         struct bpf_line_info *linfo;
>         ...
>         linfo = prog->aux->linfo;
>         ...
>         linfo = &prog->aux->linfo[prog->aux->linfo_idx];
>         ...
>         for (int i = 0; i < prog->aux->nr_linfo &&
> --->         linfo[i].insn_off >= insn_start && linfo[i].insn_off < insn_end; i++) {
>                 if (jited_linfo[i] >= (void *)ip)
>                         break;
>                 idx = i;
>         }
>         ...
>   }
>
> The error is reported at the marked line. Full report is in the
> attachment, main part is here:
>
> [    2.457680] BUG: KASAN: slab-out-of-bounds in bpf_prog_get_file_line (kernel/bpf/core.c:3263 (discriminator 2))
> ...
> [    2.458068] ? bpf_prog_get_file_line (kernel/bpf/core.c:3263 (discriminator 2))
> [    2.458074] bpf_prog_get_file_line (kernel/bpf/core.c:3263 (discriminator 2))
> [    2.458078] ? bpf_prog_0b95dbe6b5c648f2_subprog_with_may_goto+0x49/0x57
> [    2.466754] Allocated by task 150:
> ...
> [    2.467122] check_btf_line (./include/linux/slab.h:1065 kernel/bpf/verifier.c:18118)
> [    2.467190] bpf_check (kernel/bpf/verifier.c:18332 kernel/bpf/verifier.c:24611)
> [    2.467258] bpf_prog_load (kernel/bpf/syscall.c:2972 (discriminator 1))
> [    2.467325] __sys_bpf (kernel/bpf/syscall.c:6007)
> [    2.467392] __x64_sys_bpf (kernel/bpf/syscall.c:6115)
> [    2.467459] do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
> [    2.467527] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> [    2.467615]
> [    2.467660] The buggy address belongs to the object at ffff888107f8f980
> [    2.467660]  which belongs to the cache kmalloc-cg-32 of size 32
> [    2.467873] The buggy address is located 0 bytes to the right of
> [    2.467873]  allocated 32-byte region [ffff888107f8f980, ffff888107f8f9a0)
> [    2.468094]
>
> Note the following part of the verifier.c:jit_subprogs:
>
>   static int jit_subprogs(struct bpf_verifier_env *env)
>   {
>         ...
>         for (i = 0; i < env->subprog_cnt; i++) {
>                 ...
>                 func[i]->aux->linfo = prog->aux->linfo;
>                 func[i]->aux->nr_linfo = prog->aux->nr_linfo;
>                 ...
>                 func[i]->aux->linfo_idx = env->subprog_info[i].linfo_idx;
>                 ...
>   }
>
> Given the above initialization, I think bpf_prog_get_file_line() has
> to be fixed as follows:
>
> --- 8< -------------------------------------------
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index fe8a53f3c5bc..061ff34e0f53 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3253,13 +3253,13 @@ int bpf_prog_get_file_line(struct bpf_prog *prog, unsigned long ip, const char *
>                 return -EINVAL;
>         len = prog->aux->func ? prog->aux->func[prog->aux->func_idx]->len : prog->len;
>
> -       linfo = &prog->aux->linfo[prog->aux->linfo_idx];
> -       jited_linfo = &prog->aux->jited_linfo[prog->aux->linfo_idx];
> +       linfo = prog->aux->linfo;
> +       jited_linfo = prog->aux->jited_linfo;
>
>         insn_start = linfo[0].insn_off;
>         insn_end = insn_start + len;
>
> -       for (int i = 0; i < prog->aux->nr_linfo &&
> +       for (int i = prog->aux->linfo_idx; i < prog->aux->nr_linfo &&
>              linfo[i].insn_off >= insn_start && linfo[i].insn_off < insn_end; i++) {
>                 if (jited_linfo[i] >= (void *)ip)
>                         break;
>
> ------------------------------------------- >8 ---
>
> Could you please take a look?

