Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16ADF5F5CF5
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 00:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiJEW7D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 18:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiJEW7C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 18:59:02 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D66E8558B
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 15:59:01 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-345528ceb87so2440027b3.11
        for <bpf@vger.kernel.org>; Wed, 05 Oct 2022 15:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=px8M0E3ljR/RFob5R0IdDzx3OPIg8z5A2S6oaKI3GMc=;
        b=WCZyNVJhYkFZxj8R6STb6FWopw6XJGgvv2WX+tqQkV93N1EpQSoaw2sHtg9aDJAvQN
         rqRW/X1imWs6kWMn3sbPZbaztnd8dvimsI0DF6v2lnblCUbaLOFO2ICQGD2mlj+o/HQf
         PR4MkdRi8md2nwdbVih6q+AvS90UQjCUVtjVcZfOtwR6v7FVaGEDR9cDSz7jZsIdoIpY
         ClQCLnGORCJjKD2c30HlEdCwpZfCrmkTqIP6ra1w7bcJdpQj8tVvm7siMPSnGER3PnuD
         9r34Xli3AuWdk4ffW+QXTCfTqVPLsVlug5liJoOe44Y4KF1atTVpeC58NblcaTv8K80e
         tI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=px8M0E3ljR/RFob5R0IdDzx3OPIg8z5A2S6oaKI3GMc=;
        b=2XLKbkDMJA9iHIsiOufmsfaulvPvyb43B2rl9uwL9RGGPWB1kqiF+iQ/7d/jejWFfx
         vcMWAuNSy7LIZv9KOtpXRawEMyrwOodklDSTKXNDpyWmBRsskqS27+r2JTSpwQhMKM6q
         v/vA3pUXdDnQTfia5PI5iXJhzQCTQzO0Q/dGfqCZCBcP1uRjvtWTBt2heVUrMnyaEfYF
         Aktt2YkCnoxSrJ9X8heuoDypnLdlS0LTJBbNw34dcy0UHLjbU9AUwUrzLFM3NrWwyB0p
         VijIOmUHvHh7NvLJMpgaC7OAx40U8BtN7cib0S22EwXMPSMAtEvAlRJWwWBlW3w8/tSm
         4xfQ==
X-Gm-Message-State: ACrzQf0cm/kUgbqaBVc5Ns3dVo8Us+ySlq3gK8EwPi2m1XaRoIrni5Br
        ytAbwRea0AaJ59CzWyszI/Go/8S/RxOAFPwvIiA=
X-Google-Smtp-Source: AMsMyM71idh0gs8v+y1sAPW2AnMbqwQOqEbq7SggHWCGU1Lr+h0edfdIoCHXyIJ2YZSTnxh6Y1miWxPXVh6v0ndhhw4=
X-Received: by 2002:a81:7b88:0:b0:349:37fa:130e with SMTP id
 w130-20020a817b88000000b0034937fa130emr2077492ywc.155.1665010740362; Wed, 05
 Oct 2022 15:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221002151141.1074196-1-jolsa@kernel.org> <49aa0aec-a009-c0c3-cf47-11a6734aae36@linux.dev>
 <YzvU3/rwCnbWQM8P@krava> <YzwjQJurtyF6f0W1@krava>
In-Reply-To: <YzwjQJurtyF6f0W1@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Oct 2022 15:58:45 -0700
Message-ID: <CAEf4BzZay5mLX04C7Hk0xawpTvMMX+JXoRvh4_Z19DBoOnmFaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add missing bpf_iter_vma_offset__destroy
 call
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 4, 2022 at 5:16 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Tue, Oct 04, 2022 at 08:38:23AM +0200, Jiri Olsa wrote:
> > On Mon, Oct 03, 2022 at 05:12:44PM -0700, Martin KaFai Lau wrote:
> > > On 10/2/22 8:11 AM, Jiri Olsa wrote:
> > > > Adding missing bpf_iter_vma_offset__destroy call to
> > > > test_task_vma_offset_common function and related goto jumps.
> > > >
> > > > Fixes: b3e1331eb925 ("selftests/bpf: Test parameterized task BPF iterators.")
> > > > Cc: Kui-Feng Lee <kuifeng@fb.com>
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >   tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 8 +++++---
> > > >   1 file changed, 5 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > > > index 3369c5ec3a17..462fe92e0736 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> > > > @@ -1515,11 +1515,11 @@ static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opts, bool
> > > >           link = bpf_program__attach_iter(skel->progs.get_vma_offset, opts);
> > >
> > > Thanks for the fix.
> > >
> > > A nit.  Instead of adding a new goto label.  How about doing
> > >
> > >     skel->links.get_vma_offset = bpf_program_attach_iter(...)
> > >
> > > and bpf_iter_vma_offset__destroy(skel) will take care of the link destroy.
> > > The earlier test_task_vma_common() is doing that also.
> >
> > right, I forgot destroy would do that.. it'll be simpler change
>
> ugh actually no ;-) it's outside (of skeleton) link,
> so it won't get closed in bpf_iter_vma_offset__destroy

Martin's point was that if you assign it to skel->links.get_vma_offset
it will be closed by skeleton's destroy method. So let's do that?

>
> the earlier test_task_vma_common does not create such link
>
> jirka
>
> >
> > thanks,
> > jirka
> >
> > >
> > > Kui-Feng, please also take a look.
> > >
> > > >           if (!ASSERT_OK_PTR(link, "attach_iter"))
> > > > -         return;
> > > > +         goto exit_skel;
> > > >           iter_fd = bpf_iter_create(bpf_link__fd(link));
> > > >           if (!ASSERT_GT(iter_fd, 0, "create_iter"))
> > > > -         goto exit;
> > > > +         goto exit_link;
> > > >           while ((len = read(iter_fd, buf, sizeof(buf))) > 0)
> > > >                   ;
> > > > @@ -1534,8 +1534,10 @@ static void test_task_vma_offset_common(struct bpf_iter_attach_opts *opts, bool
> > > >           close(iter_fd);
> > > > -exit:
> > > > +exit_link:
> > > >           bpf_link__destroy(link);
> > > > +exit_skel:
> > > > + bpf_iter_vma_offset__destroy(skel);
> > > >   }
> > > >   static void test_task_vma_offset(void)
> > >
