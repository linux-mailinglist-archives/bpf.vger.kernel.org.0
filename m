Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36F53C71EC
	for <lists+bpf@lfdr.de>; Tue, 13 Jul 2021 16:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbhGMOR6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Jul 2021 10:17:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24917 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236636AbhGMOR5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 13 Jul 2021 10:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626185707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mLkk+cKF9D7a7EE6O0W6DpvhUQ4QSgIqQQqruwzRfZk=;
        b=SW+JeY5UtbVpKtqSD8zKIG3u3w1Z8eN8qNRlxMV0EMnANXB4QuOgKc5ghoK9GmxlmpT0Em
        iAiSN27K1dAUQ+cgEDRw7tuDweJNZ5IvXtz8tckzmWcNerA4ONZnhXzf/mxh9+vvtC7Dkr
        fZ8LLGVT+MeWVcyYvp1H8ifyJlJjqgE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-j6gAGg3VPLuQdYqDRUzDig-1; Tue, 13 Jul 2021 10:15:06 -0400
X-MC-Unique: j6gAGg3VPLuQdYqDRUzDig-1
Received: by mail-wr1-f72.google.com with SMTP id j6-20020adff5460000b029013c7749ad05so6484337wrp.8
        for <bpf@vger.kernel.org>; Tue, 13 Jul 2021 07:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mLkk+cKF9D7a7EE6O0W6DpvhUQ4QSgIqQQqruwzRfZk=;
        b=Ls06BMZhLQ4NX3VPs25IvKv5IHftSpoBcNjaYQ2vhjtusEdJQZmAmxRKp8tepV4SaS
         h0pVyn97dSmh3OoJqbiOOqPBxZO7ppU8Mqh/qnvRVpo7Z48wwLB5QY/SzqKBkTWAtFqG
         ghmRVwzuTpRnnnV+AyUjdvUka7menYpEK+YS6F8bpcgv1uUAdpGcKlz6gemvaVbWRF5H
         LvNCrQjjlCT5PwdOl4r/4o5E4qcngxvBeAk3SbJ+G+dC0FjTveoE/fLnPEhB2sdGriZc
         Tp6faIr4c+xziodgcV+HXYN4Imq4W+jbsPoE1zNlW/3/pg50V4Ta0aoRWlaWeDmH5zYf
         yiXw==
X-Gm-Message-State: AOAM532f1r3sw3v10K03+ZotK70oR+8Nd8SQI0p54MaUW6HLNUpWBxlm
        CRRNcjWK6TAUI1gkPycIb7My9/L+Z2u/SQUdF2yunhq+rVuf1Klcci7Ijdr1iqzaBVvP8D5W5n0
        Q5vvUhAHEz5fv
X-Received: by 2002:adf:e581:: with SMTP id l1mr5936193wrm.116.1626185704903;
        Tue, 13 Jul 2021 07:15:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWfXidFyPQHiMoamF/HVX5qiODoBJ6g82KbS2BIxWa8E53bpU6nmqRtih3iZfLh97h1om3dA==
X-Received: by 2002:adf:e581:: with SMTP id l1mr5936160wrm.116.1626185704755;
        Tue, 13 Jul 2021 07:15:04 -0700 (PDT)
Received: from krava ([5.171.236.3])
        by smtp.gmail.com with ESMTPSA id o14sm12078342wrj.66.2021.07.13.07.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 07:15:04 -0700 (PDT)
Date:   Tue, 13 Jul 2021 16:15:00 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCHv3 bpf-next 7/7] selftests/bpf: Add test for
 bpf_get_func_ip in kprobe+offset probe
Message-ID: <YO2f5HFFjeG26R8f@krava>
References: <20210707214751.159713-1-jolsa@kernel.org>
 <20210707214751.159713-8-jolsa@kernel.org>
 <CAEf4Bzb9DTtGWubdEgMYirWLT-AiYbU2LfB-cSpGNzk6L0z8Kg@mail.gmail.com>
 <YOsEsb1sMasi1WyR@krava>
 <CAEf4BzYQfe6-UngVn=kTE9gg6Gc7HFdDQ2NGX7p0+uuO27RETA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYQfe6-UngVn=kTE9gg6Gc7HFdDQ2NGX7p0+uuO27RETA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 12, 2021 at 04:32:25PM -0700, Andrii Nakryiko wrote:
> On Sun, Jul 11, 2021 at 7:48 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Wed, Jul 07, 2021 at 05:18:49PM -0700, Andrii Nakryiko wrote:
> > > On Wed, Jul 7, 2021 at 2:54 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > > >
> > > > Adding test for bpf_get_func_ip in kprobe+ofset probe.
> > >
> > > typo: offset
> > >
> > > > Because of the offset value it's arch specific, adding
> > > > it only for x86_64 architecture.
> > >
> > > I'm not following, you specified +0x5 offset explicitly, why is this
> > > arch-specific?
> >
> > I need some instruction offset != 0 in the traced function,
> > x86_64's fentry jump is 5 bytes, other archs will be different
> 
> Right, ok. I don't see an easy way to detect this offset, but the
> #ifdef __x86_64__ detection doesn't work because we are compiling with
> -target bpf. Please double-check that it actually worked in the first
> place.

ugh, right

> 
> I think a better way would be to have test6 defined unconditionally in
> BPF code, but then disable loading test6 program on anything but
> x86_64 platform at runtime with bpf_program__set_autoload(false).

great, I did not know about this function, will be easier

thanks,
jirka

> 
> >
> > >
> > > >
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  .../testing/selftests/bpf/progs/get_func_ip_test.c  | 13 +++++++++++++
> > > >  1 file changed, 13 insertions(+)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/progs/get_func_ip_test.c b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> > > > index 8ca54390d2b1..e8a9428a0ea3 100644
> > > > --- a/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> > > > +++ b/tools/testing/selftests/bpf/progs/get_func_ip_test.c
> > > > @@ -10,6 +10,7 @@ extern const void bpf_fentry_test2 __ksym;
> > > >  extern const void bpf_fentry_test3 __ksym;
> > > >  extern const void bpf_fentry_test4 __ksym;
> > > >  extern const void bpf_modify_return_test __ksym;
> > > > +extern const void bpf_fentry_test6 __ksym;
> > > >
> > > >  __u64 test1_result = 0;
> > > >  SEC("fentry/bpf_fentry_test1")
> > > > @@ -60,3 +61,15 @@ int BPF_PROG(fmod_ret_test, int a, int *b, int ret)
> > > >         test5_result = (const void *) addr == &bpf_modify_return_test;
> > > >         return ret;
> > > >  }
> > > > +
> > > > +#ifdef __x86_64__
> > > > +__u64 test6_result = 0;
> > >
> > > see, and you just forgot to update the user-space part of the test to
> > > even check test6_result...
> > >
> > > please group variables together and do explicit ASSERT_EQ
> >
> > right.. will change
> >
> > thanks,
> > jirka
> >
> > >
> > > > +SEC("kprobe/bpf_fentry_test6+0x5")
> > > > +int test6(struct pt_regs *ctx)
> > > > +{
> > > > +       __u64 addr = bpf_get_func_ip(ctx);
> > > > +
> > > > +       test6_result = (const void *) addr == &bpf_fentry_test6 + 5;
> > > > +       return 0;
> > > > +}
> > > > +#endif
> > > > --
> > > > 2.31.1
> > > >
> > >
> >
> 

