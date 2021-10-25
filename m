Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9EBF43A11F
	for <lists+bpf@lfdr.de>; Mon, 25 Oct 2021 21:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbhJYThT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 15:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbhJYTfL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Oct 2021 15:35:11 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D121C01CB0F
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 12:20:35 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id i65so27915242ybb.2
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 12:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q5uuo/tkmRanVEZOtusHRjFgGBTswNEY21F9yVMlbQs=;
        b=Ve44g1PTpCQLZ9PgY9JvedGIaq4zI90wIx0D0DL/hH4mFa4ZXmhUdtFtJqgrtwS929
         Gwac1gOeaLA6bo9KaC5vouHOqgYPjniGhwnaTQ/H8o2YLrQF+3ShFTkZM1oTOwyeAXgr
         VQgxG0+PShrAfLcp1+wERjsrijUouFr21Z/t0Xa9N/nWsM3uNN/qQbDaxuL0zOBUjwHL
         fY41+cSGlGXwfTsxIctS7Bk99cUO2JbYE7Zm5djPE05FN5UDvS0qL7WITwHePAhiuVKG
         7O3sWqqwKztiNyA7+ZdFATgaeEeTf8D6JH7FjUFYZg+lLLmy0FN9ryWO09WE3+dW+Dp/
         zPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q5uuo/tkmRanVEZOtusHRjFgGBTswNEY21F9yVMlbQs=;
        b=eF20Cf8ryH0PVhUpHAapaD/+aMJb/nzmZ3blYuagU/d6BuQTrZyaD+z+fDNZw9pJtM
         vJp4ymUpncCQBXkHf++axvmgFk2coRz1P42Dz0YrXQmoRzRfrUGyitZnHH+t1tN9mIrF
         6OWG7pftsDHVjTzRtARD9AMN0wGlqL6re+/quGE8fGtxxF/HTNvPQUpozRdRJT8+leyM
         kGFntCl5+shh6cA0aHW2uROL6J1zc9Go8qU6QysJn6VQXpforOlMuUGFXKhpJE2h9vS2
         da6yNqoadttNqS/3wSEnb8euAOj3Lt+syd72Nv+UbOH1L9/Z6Q1QXicfZu7/AcZOLdEt
         L7ww==
X-Gm-Message-State: AOAM533aGSgEAPwFT2VNMYHqcZgc2OgMpWtw5twm25gKKC+2vXPy4nsS
        1epzVr60+VkDmMKCv579ufGa7UTVpLZFt0k4oo4=
X-Google-Smtp-Source: ABdhPJzbVwKB8qhFQUOoXfOOoqeNl1RB5+TwVDkP+2ddLySya3pYD7taKjWvKghOSriPQRcQAZB6eaYDGbETxFy1fl8=
X-Received: by 2002:a25:aa0f:: with SMTP id s15mr12829960ybi.51.1635189634509;
 Mon, 25 Oct 2021 12:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAO15rP=JzzanBC7Hj=9pshpMeWGJVpbt0wCiZfP8HwBaEbcFMw@mail.gmail.com>
In-Reply-To: <CAO15rP=JzzanBC7Hj=9pshpMeWGJVpbt0wCiZfP8HwBaEbcFMw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Oct 2021 12:20:23 -0700
Message-ID: <CAEf4Bzbkvb3YN+ZkWdZFw1=Uv-c1Gnsv+KoTtLMUUPnV15zZ=A@mail.gmail.com>
Subject: Re: Question regarding "BPF CO-RE reference guide" blog post
To:     Tal Lossos <tallossos@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        assaf.shab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 5:06 AM Tal Lossos <tallossos@gmail.com> wrote:
>
> Hello!
> After reading Andrii's new blog post regarding BPF CO-RE, which was
> really lovely and well written, I came up with a small question:
> When you gave the example for BPF_CORE_READ, you've accessed the
> executable pointer under linux_binfmt struct.
> Is it a mistake with linux_binprm struct? or maybe I'm missing something.

Yeah, totally a mistake, sorry. I've fixed it. It should be
t->mm->exe_file->fpath.dentry->d_name.name (one pointer dereference
step shorter). Thanks for reading carefully and reporting the problem!

>
> Another thing, maybe you could add a little explanation about how
> libbpf validates the structs offsets with the help of BTF? It's a key
> part of CO-RE so it would be nice to have a little deep-dive in the
> blog post about it :)

This felt like repeating some low-level things from previous blog
posts and describing BTF rather than CO-RE mechanics itself. This
topic was described in previous BPF CO-RE post in more detail ([0]),
BTF itself was described (along the dedup algo) in [1]. CO-RE
relocation format I don't think I've ever described in detail, but
this comment ([2]) in libbpf source code should give you a pretty good
idea, I hope.

  [0] https://nakryiko.com/posts/bpf-portability-and-co-re/#compiler-support
  [1] https://nakryiko.com/posts/btf-dedup/#bpf-and-type-information
  [2] https://github.com/libbpf/libbpf/blob/master/src/relo_core.h#L25-L70

>
> Thanks.
