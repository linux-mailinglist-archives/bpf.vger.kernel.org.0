Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B22270B9F
	for <lists+bpf@lfdr.de>; Sat, 19 Sep 2020 09:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgISH6u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Sep 2020 03:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgISH6t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Sep 2020 03:58:49 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56CCC0613CE;
        Sat, 19 Sep 2020 00:58:49 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id y74so9529307iof.12;
        Sat, 19 Sep 2020 00:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XE8nLNkkdXM29xmdX4zcPnPC7d0nZDaF9zEHOMGcSk=;
        b=IiJG874ybkgZmWvsfGtQjvhUto1g5/iVGdQIziTUccJoEftsZ+8gh/VAuYqIAh222t
         fuEmCsbdM1Sr6MO5381rxgjP+XPYkXuBPqppyFmnidDG/jHHrg5hODLo/m9Y/8GXMqsi
         UQ3pJ6WXHSgD/St1SBCybe85CdnkzmdwFE9Iw5lxQx6fnpA0JdyQlSCMJSMBtQ5q0cCs
         ejFXv1q0tVzqa/p/3Vcj3kcwMdRkyGLRcx3qYvTDCJSWaEELh9FrkMc1OzW/7gqs95JY
         Uqa/NOz/acuvgCmMJaH+wUuC6sAMIfDtkfIKRG45QxEtogEERz1ZURNfuI4GwOolVYON
         5mKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XE8nLNkkdXM29xmdX4zcPnPC7d0nZDaF9zEHOMGcSk=;
        b=DT4AqIM5UgA0ZL9Xj1CkbINdvRg/Pf3ED69gg4LZo3iHqhtod9JLZXZ1GPzCpxni54
         AaDEa2bb9n+BxZQvkZfO4bT6JNOpx4whRt28e/gftqhzijSDY8i01uPWR35j8XnzkUvu
         CflF0rK5sXpEfZU0/h7cls3+YD2nhoga+xtXyRBUZ0i1UCBmPfToEJAtv+KdG0CWzB9a
         A7+vUAXNVtlXInGMKFF77ZRKcbW+yHD9K2B2rlqKXGLkX4IkS3kZJXzBe8SgbYz80GZo
         c6A+qhcXjlSWQ+92rj4lotJbYMyu1zC9P+8xLCcXhNf3oa3a9UhVv7i5+H8XhpDudxWF
         zTkg==
X-Gm-Message-State: AOAM531rjotqboH//iSAJOZcb6EuP/P7zuaQLApBeIkhfmqjfg2uCdxN
        2vVdd+9zaRtSheJGOse7/XWMZ8qeYSDOlb/cXKA=
X-Google-Smtp-Source: ABdhPJwfyWbLFJzlRO1OPhOal7domzFqoRRp08ARzHQAU9rfYSCmvwmAatZe8wEs05S0pOMNALkh0PFol8T9LZj8We0=
X-Received: by 2002:a02:c914:: with SMTP id t20mr33225079jao.117.1600502328851;
 Sat, 19 Sep 2020 00:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGftE8ipAacAnm9xMHFabXCL-XrCXGmOsX-Nsjvz9wnh3Zx-w@mail.gmail.com>
 <9e99c5301fbbb4f5f601b69816ee1dc9ab0df948.camel@linux.ibm.com>
 <CAEf4Bza9tZ-Jj0dj9Ne0fmxa95t=9XxxJR+Ce=6hDmw_d8uVFA@mail.gmail.com>
 <8cf42e2752e442bb54e988261d8bf3cd22ad00f2.camel@linux.ibm.com> <20200909142750.GC3788224@kernel.org>
In-Reply-To: <20200909142750.GC3788224@kernel.org>
From:   Tony Ambardar <tony.ambardar@gmail.com>
Date:   Sat, 19 Sep 2020 00:58:39 -0700
Message-ID: <CAPGftE8jNys9aVfUZW2iE5vB=QWKEmmwwWuWq9ek0ZXp-Aobkg@mail.gmail.com>
Subject: Re: Problem with endianess of pahole BTF output for vmlinux
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 9 Sep 2020 at 07:27, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Sep 09, 2020 at 11:02:24AM +0200, Ilya Leoshkevich escreveu:
> > On Tue, 2020-09-08 at 13:18 -0700, Andrii Nakryiko wrote:
> > > On Mon, Sep 7, 2020 at 9:02 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> > > > On Sat, 2020-09-05 at 21:16 -0700, Tony Ambardar wrote:
>
[...]
> > > > > Is this expected? Is DEBUG_INFO_BTF supported in general when
> > > > > cross-compiling? How does one generate BTF encoded for the
> > > > > target endianness with pahole?
>
> The BTF loader has support for endianness, its just the encoder that
> doesn't :-\
>
> I.e. pahole can grok a big endian BTF payload on a little endian machine
> and vice-versa, just can't cross-build BTF payloads ATM.
>
> > > Yes, it's expected, unfortunately. Right now cross-compiling to a
> > > different endianness isn't supported. You can cross-compile only if
> > > target endianness matches host endianness.
>
> I agree that having this in libbpf is better, it should be done as part
> of producing the result of the deduplication phase.
>
Thanks for confirming this wasn't a case of operator error. My platforms for
learning/experimenting with BPF have been small embedded ones, including
cross-compiling to different archs, word-size and endianness, which have
"helped" me run into multiple problems till now. This one is the first I
couldn't work around however...

[...]
> > > I'm working on extending BTF APIs in libbpf at the moment. Switching
> > > endianness would be rather easy once all that is done. With these new
> > > APIs it will be possible to switch pahole to use libbpf APIs to
> > > produce BTF output and support arbitrary endianness as well. Right
> > > now, I'd rather avoid implementing this in pahole, libbpf is a much
> > > better place for this (and will require ongoing updates if/when we
> > > introduce new types and fields to BTF).
>
> Right, we could do it right after btf_dedup() and before
> btf_elf__write(), doing the same process as in btf_loader.c, i.e.
> checking if the ELF target arch is different in endianness and doing the
> reverse of the loader.
>
> > > Hope this plan works for you guys.
> >
> > That sounds really good to me, thanks!
>
Andrii and Arnaldo, I really appreciate your working on a proper endianness fix.
If you have a WIP or staging branch and could use some help please let me know.

Best regards,
Tony
