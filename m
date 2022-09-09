Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CF65B42C0
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 01:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiIIXFf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 19:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiIIXFe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 19:05:34 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8188710F8C2
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 16:05:33 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id s11so1566917ilt.7
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 16:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=waSBXm40DuPzk7Td6506LW2Kw73L1pOqEkHRZ3NtMYw=;
        b=LRcyyXoFBVsqhUwGCXB12zc63b4gU1UCdVXcjhvBeuusWwJ6Y88k9eziQ7i6QUB5AI
         53/0TX+G20DjE+OgsjSzh/nC7BogVAYoI/ES9LuCGNjUrfVZQhAcCkngygQhVEvsbYy2
         nBwgQ9G5WN1IwNgqmDOfX7mm168jk5wKcEoi2OlvFd0IFBbVdV2EZ8IHP0ACioyh5Quu
         LH/HLV3kRH08ED4yRXtzYRc+BOMKbag0xd3+Zjcs96PiPiGJxThQdWaam6Oq4gMDCWaG
         +L8qpYWpefDMuYu83AyFZCwhT3Xmjqef6GqW+3s5FElLrJh3PQA4Bx+9dDLfWYy4eaL0
         R0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=waSBXm40DuPzk7Td6506LW2Kw73L1pOqEkHRZ3NtMYw=;
        b=XzZ9O7Us0FBXIPFCohAG6fgZB8JyAAzSVidtC78fH59280tbZW6VktwzHG01ERQUNm
         Wq3tcC4csHlUUg9oiK2kVQt1Onl7Gnyygd0OWQPek32VKtsTs8qd3hkMsPJ266Ay6LZX
         m3vt6xOUAAAeo2unhLTMjXC4BJq44OActYX9key7vgX6JwI6Y37dmUFdOJeiQ8ulPu7r
         ybiNhsgBbjGi+vK0m8fGgECW6k4tgtEDBazRE4ND5XEylPRms8kgCYktzBlw4KyNiaG2
         ODoHuc0ugffFeZku87kGBkvaYnH+WF34n3Hnkw7JIHUaWfu6LnLBW4ixkSlJOFquy7K2
         MYtg==
X-Gm-Message-State: ACgBeo2Zv90Ktz/j0WadBNnJd4qpwM0nKeie07KBnbZR66OabEVSNH/O
        ko2BgIa7A3YAeShJ3RvBEBX+AyZiUMykezEYeN6MfMzj
X-Google-Smtp-Source: AA6agR5E9O76JJvz2gys5bxTVaStjC2orjGZDEgs9ZyA1vp0STbVC8ZhrA4OeyRpCKI0dXd8iTo/+YgS+93liFbQhcA=
X-Received: by 2002:a05:6e02:1d0b:b0:2eb:73fc:2235 with SMTP id
 i11-20020a056e021d0b00b002eb73fc2235mr5272616ila.164.1662764732871; Fri, 09
 Sep 2022 16:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-22-memxor@gmail.com>
 <311eb0d0-777a-4240-9fa0-59134344f051@fb.com> <CAP01T76QJOYqk4Lsc=bUjM86my=kg3p6GHxuz3yXiwFMHJtjJA@mail.gmail.com>
 <CAADnVQJ6-kEE=_kHgyth_O3rUVHzJuNhS2MWhjQQed4wHzPpnA@mail.gmail.com>
 <CAP01T74-Bc8xLihXcoer8fOoSoQQ1dddJ1FGOVdRPRa92RRPyQ@mail.gmail.com>
 <CAADnVQLJP8YyYx5+mCBuSyenAfQDyXxDP8wfuDYCoZtO6kpunQ@mail.gmail.com>
 <CAEf4BzZL9GS0oAfkY1h4C9u1_XCzj-HTnKY9KHj+PX+h66TL3g@mail.gmail.com>
 <20220909192525.aymuhiprgjwfnlfe@macbook-pro-4.dhcp.thefacebook.com>
 <4b987779-bae0-dcd9-2405-e43f401bf5ad@fb.com> <CAP01T75voazy_BfqRzQKkLLt7k57LnYXNbu-E05jBKcsTkda3Q@mail.gmail.com>
 <CAADnVQJS0NBMdy=MhFgFud1DbSex4ej56DO7QDYDHQmR5QuW6A@mail.gmail.com>
In-Reply-To: <CAADnVQJS0NBMdy=MhFgFud1DbSex4ej56DO7QDYDHQmR5QuW6A@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Sat, 10 Sep 2022 01:04:56 +0200
Message-ID: <CAP01T74F8j9LQcwPgyP=qJMb=mfNCKSYGD8ZHewmdXzzHQioAw@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 21/32] bpf: Allow locking bpf_spin_lock
 global variables
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 10 Sept 2022 at 00:57, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Sep 9, 2022 at 3:50 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > So compared to the example above, user will just do:
> > struct bpf_spin_lock lock1;
> > struct bpf_spin_lock lock2;
> > struct bpf_list_head head __contains(...) __guarded_by(lock1);
> > struct bpf_list_head head2 __contains(...) __guarded_by(lock2);
> > struct bpf_rb_root root __contains(...) __guarded_by(lock2);
> >
> > It looks much cleaner to me from a user perspective. Just define what
> > protects what, which also doubles as great documentation.
>
> Unfortunately that doesn't work.
>
> We cannot magically exclude the locks from global data
> because of skel/mmap requirements.
> We cannot move the locks automatically, because it involves
> massive analysis of the code and fixing all offsets in libbpf.
> So users have to use a different section when using
> global locks, rb_root, list_head.
> Since a different section is needed anyway, it's better to keep
> one-lock-per-map-value for now.

Argh, right. Then they need one extra 'annotation', at that point it's
a bit questionable.
Also just realized reading your other reply that there are also
unanswered questions wrt what we do for BPF_F_LOCK.
