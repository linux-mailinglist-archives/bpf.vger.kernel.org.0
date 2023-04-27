Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E866EFEEE
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 03:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242970AbjD0BUq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 21:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243032AbjD0BU1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 21:20:27 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A3544A4
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 18:20:00 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-508418b6d59so14417731a12.3
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 18:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682558391; x=1685150391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8ZvBBQjgBl1WV0E0U+OsFJ/NXgqDBJGJgiNX7TA4MI=;
        b=SouTqhLBACgBFlnDlJufx3E/6WGN2g4z4BzGU8rqfkt2+5USayVgU5+Oe8jDK4OG5i
         /bavNWcAQJ1Kv53YIjdoCV8hyyov4vH6V5iLM6kY7FjzzHrqKhugARxhYC3s2vzfJYit
         EfqWjPL/THyxKeC+cjiLAnLlSws+fMo4XRcjGepUpIZ0dordVbEyDjmPCI79GxtzEXuo
         1XG3qd79UsIqjkHzyvrwxYOFhw9XyRwsNnXPxPWhYrqJN9zjRju/x6WdjEh6MVjcXE2w
         ReeHSEWdXh/Cpz4mzmJUFltacSg9COG/Rot0TukioccyJcwsVUfkrQT5qearLRJQLE1h
         EuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682558391; x=1685150391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8ZvBBQjgBl1WV0E0U+OsFJ/NXgqDBJGJgiNX7TA4MI=;
        b=khapuAMDUWh1M7oDTwT8NpvWTsdk8ASBTIdXJmlt0xVKyTEgzQDTE9R1n3XNj94e4B
         0rEyq/UGfvK5HwkV6RQVoFyD3AsRGhEjXpm4OQs+bS8a5CYCqyFyxhD4Vz8JXoVlnW1l
         eBn724eAesoydopDU30ZXKT088M8PqSaH14O57baIjlCw7xMRt2RR7bqnFF9+uenz1m6
         fcW+fDDIm72EHcOtAk97U9yedpWQAIp2i6EXjY/oLMz/iBYaJjjZOemAItYoqWOUxa+t
         B6aqP5tspOTdE0W8SuKGNXYBUyW2V9m+7CgATyM+7cUcbWsyt2650uYk9MtpZoOPgk/l
         L9XQ==
X-Gm-Message-State: AC+VfDywOMXCkrI7TJdcS33dygO9B9bOopYWNZJrgw5Iiip3rGJoiD51
        JBdnsRSokcsG3znC1O54A9CpiCkoT2ceHRXfipw=
X-Google-Smtp-Source: ACHHUZ5xz35GahuWOZvAZm/sBi4vWCXZ4fZlDp4PPH1fi8GZRiTbeRLP3cuvFyw+OLXrgR8++DRyoqDQ+lTTr09no9s=
X-Received: by 2002:a05:6402:47:b0:506:92d7:6dce with SMTP id
 f7-20020a056402004700b0050692d76dcemr249833edu.15.1682558390788; Wed, 26 Apr
 2023 18:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230427001425.563232-1-namhyung@kernel.org>
In-Reply-To: <20230427001425.563232-1-namhyung@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Apr 2023 18:19:38 -0700
Message-ID: <CAEf4BzYs6iD+iE4RZnXTKHhBHCOr9r7AdhsBWWDpivy7sshPKw@mail.gmail.com>
Subject: Re: [HELP] failed to resolve CO-RE relocation
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Hao Luo <haoluo@google.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 26, 2023 at 5:14=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> I'm having a problem of loading perf lock contention BPF program [1]
> on old kernels.  It has collect_lock_syms() to get the address of each
> CPU's run-queue lock.  The kernel 5.14 changed the name of the field
> so there's bpf_core_field_exists to check the name like below.
>
>         if (bpf_core_field_exists(rq_new->__lock))
>                 lock_addr =3D (__u64)&rq_new->__lock;
>         else
>                 lock_addr =3D (__u64)&rq_old->lock;

I suspect compiler rewrites it to something like

   lock_addr =3D (__u64)&rq_old->lock;
   if (bpf_core_field_exists(rq_new->__lock))
        lock_addr =3D (__u64)&rq_new->__lock;

so rq_old relocation always happens and ends up being not guarded
properly. You can try adding barrier_var(rq_new) and
barrier_var(rq_old) around if and inside branches, that should
pessimize compiler

alternatively if you do

if (bpf_core_field_exists(rq_new->__lock))
    lock_addr =3D (__u64)&rq_new->__lock;
else if (bpf_core_field_exists(rq_old->lock))
    lock_addr =3D (__u64)&rq_old->lock;
else
    lock_addr =3D 0; /* or signal error somehow */

It might work as well.

>
> Note that I've applied a patch [2] to fix an issue with this code.
>
> It works fine on my machine (with a newer kernel), but failed on the
> old kernels.  I guess it'd go to the else part without a problem but
> it didn't for some reason.
>
> Then I change the code to check the rq_old first.  It works well on
> the old kernels but fails on newer kernels.. :(
>
>     libbpf: prog 'collect_lock_syms': BPF program load failed: Invalid ar=
gument
>     libbpf: prog 'collect_lock_syms': -- BEGIN PROG LOAD LOG --
>     reg type unsupported for arg#0 function collect_lock_syms#380
>     0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
>     ; int BPF_PROG(collect_lock_syms)
>     0: (b7) r6 =3D 0                        ; R6_w=3D0
>     1: (b7) r7 =3D 0                        ; R7_w=3D0
>     2: (b7) r9 =3D 1                        ; R9_w=3D1
>     3: <invalid CO-RE relocation>
>     failed to resolve CO-RE relocation <byte_off> [381] struct rq___old.l=
ock (0:0 @ offset 0)
>     processed 4 insns (limit 1000000) max_states_per_insn 0 total_states =
0 peak_states 0 mark_read 0
>
> I'm curious what went wrong with this.  I guess it's supposed to work
> on any kernel verions by definition.  Not sure the compiler generated
> a wrong reloc or something.  Maybe I just made silly mistakes..
>
> Do you see anything wrong?  Any hints to debug this issue?
>
> Thanks,
> Namhyung
>
>
> [1] file://linux/tools/perf/util/bpf_skel/lock_contention.bpf.c
> [2] https://lore.kernel.org/lkml/20230423215650.287812-1-namhyung@kernel.=
org/
