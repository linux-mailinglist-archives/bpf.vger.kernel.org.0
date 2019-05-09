Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8269C1889C
	for <lists+bpf@lfdr.de>; Thu,  9 May 2019 12:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbfEIK7G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 May 2019 06:59:06 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44365 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfEIK7G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 May 2019 06:59:06 -0400
Received: by mail-yw1-f65.google.com with SMTP id e74so1489355ywe.11
        for <bpf@vger.kernel.org>; Thu, 09 May 2019 03:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gijiClUqpvZegCnqDiyaz/oVkk/6DyzwuzS4UmiYX2M=;
        b=Lfv5OBGt/pJg/w3rp59mwdqMbnQkmU+7oquCvYUbcDyrcaqPrD7tJ+CAA6CYKtxjYO
         6+rN5KnNxr5xiCEVi97NgXeIR8DJ7LaHVAV+bK8zD+FAqh/vvMPW7UTWL9HO9gZ7JR6w
         L3of7oAYKZOsFmmOLM6XgmSXG19MYYmc98YWcVu5Tyt6mr2IuQ5LTZ1zty8r+vy5ya4y
         fakzPvTCno6TZiHwnohhLD3pDFp4m6ALkr9mMkK+u1S1JNp5zZU6OHz5xh2TtxDtfjBO
         bqaq207Lv4GvT2HyNamqfT36Z8d8CjjswUh9a0EuAA/sS+RUF1mlZmZj0yFXzMvhzhfj
         mpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gijiClUqpvZegCnqDiyaz/oVkk/6DyzwuzS4UmiYX2M=;
        b=J1LZhobp56QzpXEHKfI9HPEDB6zPommnJuUE33I7mpLPliC6JcDYpPtpsstA0yEkZy
         1cAoJ40JVF213NrRO7aufDSUr28omjAjvpWyTp98vEL4Ynzxv4SwPfqFkYbgot3CfZ3c
         ylRcrtPf4fhZcvx7LW3RrRNEQIOuWW1isAg/WQyxoKo6ZdvIPXbbTcCKSDtV4n/4N00a
         YgrrNgT3NIyWKeaZ0eEIcC6ntdzkXNPSqUv7dlw76gugYBKG3CZC0bTwIWYTH6PWPtIm
         PJt8PX8koNiEESSQsdUSr/8HU1YuHBacNmwbbzAwn+gyJwIkGc9ScNa0jFuCKDOVXWae
         jkag==
X-Gm-Message-State: APjAAAVupSNesgKm6881J/51CRDuoUK+Ljvowa9NE8hlCaR/Wo2tccGF
        xyg1GVBhRkEQDh+qqVLBujM/OJNppiGww0LFlA4dwA==
X-Google-Smtp-Source: APXvYqyyympB73WWVs7Ht4ufHewVGNTI4a4YA6Lv8ROLV2/Y/V+0bD5vZnXhblQ+nB8LN8piPjpOgunu6L+K6AaDxIw=
X-Received: by 2002:a81:8a83:: with SMTP id a125mr1507410ywg.92.1557399544947;
 Thu, 09 May 2019 03:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <CANn89iL_XLb5C-+DY5PRhneZDJv585xfbLtiEVc3-ejzNNXaVg@mail.gmail.com>
 <20190508230941.6rqccgijqzkxmz4t@ast-mbp> <CANn89iL_1n8Lb5yCEk3ZrBsUtPPWPZ=0BiELUo+jyBWfLfaAzg@mail.gmail.com>
 <20190509044720.fxlcldi74atev5id@ast-mbp> <CANn89i+v52ktezz5J_0of_EvTUozf86rP1Uh36HpbHf33uzDJg@mail.gmail.com>
In-Reply-To: <CANn89i+v52ktezz5J_0of_EvTUozf86rP1Uh36HpbHf33uzDJg@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 9 May 2019 03:58:53 -0700
Message-ID: <CANn89iK8e8ROW8CrtTDq9-_bFeg2MdeqAdjf10i6HiwKuaZi=g@mail.gmail.com>
Subject: Re: Question about seccomp / bpf
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Kees Cook <keescook@google.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>, Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 9, 2019 at 3:52 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Wed, May 8, 2019 at 9:47 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, May 08, 2019 at 04:17:29PM -0700, Eric Dumazet wrote:
> > > On Wed, May 8, 2019 at 4:09 PM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Wed, May 08, 2019 at 02:21:52PM -0700, Eric Dumazet wrote:
> > > > > Hi Alexei and Daniel
> > > > >
> > > > > I have a question about seccomp.
> > > > >
> > > > > It seems that after this patch, seccomp no longer needs a helper
> > > > > (seccomp_bpf_load())
> > > > >
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bd4cf0ed331a275e9bf5a49e6d0fd55dffc551b8
> > > > >
> > > > > Are we detecting that a particular JIT code needs to call at least one
> > > > > function from the kernel at all ?
> > > >
> > > > Currently we don't track such things and trying very hard to avoid
> > > > any special cases for classic vs extended.
> > > >
> > > > > If the filter contains self-contained code (no call, just inline
> > > > > code), then we could use any room in whole vmalloc space,
> > > > > not only from the modules (which is something like 2GB total on x86_64)
> > > >
> > > > I believe there was an effort to make bpf progs and other executable things
> > > > to be everywhere too, but I lost the track of it.
> > > > It's not that hard to tweak x64 jit to emit 64-bit calls to helpers
> > > > when delta between call insn and a helper is more than 32-bit that fits
> > > > into call insn. iirc there was even such patch floating around.
> > > >
> > > > but what motivated you question? do you see 2GB space being full?!
> > >
> > >
> > > A customer seems to hit the limit, with about 75,000 threads,
> > > each one having a seccomp filter with 6 pages (plus one guard page
> > > given by vmalloc)
> >
> > Since cbpf doesn't have "fd as a program" concept I suspect
> > the same program was loaded 75k times. What a waste of kernel memory.
> > And, no, we're not going to extend or fix cbpf for this.
> > cbpf is frozen. seccomp needs to start using ebpf.
> > It can have one program to secure all threads.
> > If necessary single program can be customized via bpf maps
> > for each thread.
>
> Yes,  docker seems to have a very generic implementation and  should
> probably be fixed
> ( https://github.com/moby/moby/blob/v17.03.2-ce/profiles/seccomp/seccomp.go )

Even if the seccomp program was optimized to a few bytes, it would
still consume at least 2 pages in module vmalloc space,
so the limit in number of concurrent programs would be around 262,144

We might ask seccomp guys to detect that the same program is used, by
maintaining a hash of already loaded ones.
( I see struct seccomp_filter has a @usage refcount_t )
