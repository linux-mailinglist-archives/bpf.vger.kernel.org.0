Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068761D9A8F
	for <lists+bpf@lfdr.de>; Tue, 19 May 2020 17:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgESPAo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 May 2020 11:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbgESPAo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 May 2020 11:00:44 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE200C08C5C0
        for <bpf@vger.kernel.org>; Tue, 19 May 2020 08:00:43 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id h16so11756181eds.5
        for <bpf@vger.kernel.org>; Tue, 19 May 2020 08:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=olWeaL9L3Th4SH3qpwoevbMzoFhixmGWtefArTEgTk4=;
        b=bEyFs82H4jPOzYgYPlYzidt1XghxF9RQPbBVSYNlHHo+64d1MNTn8faNwlkFFp8XOf
         gG93TwfVwkG1x1SYSw+sjMMWFJkF7MEU4WVXqVGtcdcINUqMvvJ0+cCULgJtCQLQs61K
         vXj6dXSp1aRiCwt0AazexjVnkE4ZNAkpCDQS9XxiM0RaP1T3r5NtDEln4DdTvI5ROC75
         IyyM7+pvwZ7/s+bKvbD/iAAfpgQHgYVyLMUKpVP+x5wk348rr8fMWFwaLt3cdSNfwjEe
         PHIFvD/DButvkbeAQN6sl0IFWPv3XAMn/cdJYslshqL4n0Fjc65uCPcTOXm8wnzgg8Ac
         dmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=olWeaL9L3Th4SH3qpwoevbMzoFhixmGWtefArTEgTk4=;
        b=qMPANh7v6+7cWo/GG8w9FC6JorhUB/TTQ+waaCuabex62bpwwVBYQAy0BwyaEhVnqa
         jHSN4TCDFyyEHkAbe4eYfHFkAdcd4Q8Rdv9KDvg8DFaw1qio4cBzDV1jT2ey+zC+0ADe
         52lQsQGNsN1TDAvfHAJazAWJKBY+qpcB6qtTpLweOAGdi2Vg/ES7FxHU7c/yYAHHtAYF
         Z7hYP4K2LJhka6eNTIusFY2uy5bfvsEx6Z9v496DqF9kUmdJivSWefmOST/yoOBxnsqB
         S22OOtvj4fzdq6yFJ+aG80Reeh+gMsD93eTk7FikCQojXsvBGFeWl1Pfz92sm96MYMuZ
         vHpw==
X-Gm-Message-State: AOAM531iBYKgTId3rLX0mJC/5PdPLJUAVTCWbFy7zbmF10XmmcUd1Y6E
        NAEtvUSD15fBJLvkpUvmJ7NoMMHQfG1CPkL0qiU9Xg==
X-Google-Smtp-Source: ABdhPJz+lhIpPKFIwyc4CnD865mj0YwvB2BjckQu7J/mXksfcTixa7jQ+FQ7BA5W++Bj57SzGGXmJbtqvWOZOvNVKQg=
X-Received: by 2002:a50:ee1a:: with SMTP id g26mr17925721eds.18.1589900442359;
 Tue, 19 May 2020 08:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAG=TAF6mfrwxF1-xEJJ9dL675uMUa7RZrOa_eL2mJizZJ-U7iQ@mail.gmail.com>
 <CAEf4BzazvGOoJbm+zNMqTjhTPJAnVLVv9V=rXkdXZELJ4FPtiA@mail.gmail.com>
 <CAG=TAF6aqo-sT2YE30riqp7f47KyXH_uhNJ=M9L12QU6EEEfqQ@mail.gmail.com> <CAEf4BzaBfnDL=WpRP-7rYFhocOsCQyFuZaLvM0+k9sv2t_=rVw@mail.gmail.com>
In-Reply-To: <CAEf4BzaBfnDL=WpRP-7rYFhocOsCQyFuZaLvM0+k9sv2t_=rVw@mail.gmail.com>
From:   Qian Cai <cai@lca.pw>
Date:   Tue, 19 May 2020 11:00:31 -0400
Message-ID: <CAG=TAF5rYmMXBcxno0pPxVZdcyz=ik-enh03E-V8wupjDS0K5g@mail.gmail.com>
Subject: Re: UBSAN: array-index-out-of-bounds in kernel/bpf/arraymap.c:177
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Linux Netdev List <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 18, 2020 at 8:25 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, May 18, 2020 at 5:09 PM Qian Cai <cai@lca.pw> wrote:
> >
> > On Mon, May 18, 2020 at 7:55 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Sun, May 17, 2020 at 7:45 PM Qian Cai <cai@lca.pw> wrote:
> > > >
> > > > With Clang 9.0.1,
> > > >
> > > > return array->value + array->elem_size * (index & array->index_mask);
> > > >
> > > > but array->value is,
> > > >
> > > > char value[0] __aligned(8);
> > >
> > > This, and ptrs and pptrs, should be flexible arrays. But they are in a
> > > union, and unions don't support flexible arrays. Putting each of them
> > > into anonymous struct field also doesn't work:
> > >
> > > /data/users/andriin/linux/include/linux/bpf.h:820:18: error: flexible
> > > array member in a struct with no named members
> > >    struct { void *ptrs[] __aligned(8); };
> > >
> > > So it probably has to stay this way. Is there a way to silence UBSAN
> > > for this particular case?
> >
> > I am not aware of any way to disable a particular function in UBSAN
> > except for the whole file in kernel/bpf/Makefile,
> >
> > UBSAN_SANITIZE_arraymap.o := n
> >
> > If there is no better way to do it, I'll send a patch for it.
>
>
> That's probably going to be too drastic, we still would want to
> validate the rest of arraymap.c code, probably. Not sure, maybe
> someone else has better ideas.

This works although it might makes sense to create a pair of
ubsan_disable_current()/ubsan_enable_current() for it.

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 11584618e861..6415b089725e 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -170,11 +170,16 @@ static void *array_map_lookup_elem(struct
bpf_map *map, void *key)
 {
        struct bpf_array *array = container_of(map, struct bpf_array, map);
        u32 index = *(u32 *)key;
+       void *elem;

        if (unlikely(index >= array->map.max_entries))
                return NULL;

-       return array->value + array->elem_size * (index & array->index_mask);
+       current->in_ubsan++;
+       elem = array->value + array->elem_size * (index & array->index_mask);
+       current->in_ubsan--;
+
+       return elem;
 }
