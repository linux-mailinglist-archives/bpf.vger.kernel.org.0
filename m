Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CA266A5AE
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 23:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjAMWH2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 17:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjAMWH1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 17:07:27 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA81011826;
        Fri, 13 Jan 2023 14:07:25 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id u9so55494939ejo.0;
        Fri, 13 Jan 2023 14:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wRJeuNMECfIR2T5BvBaStXjhMzdrlDtYinDb6OGqSJE=;
        b=dHw6TfJ4L90yibFDOR5cZ0Zz+JuTtNZSRTD8LxZ/oDHeTYXpEN1B4fsGqa8ZqcvWV6
         2RoMRVS8yIagHclgWsXA1nHlSRjh2m8AVsmUPV+L85/OimqvJKcHLqCDO6c1eJSrUIIj
         ZNFD0zX7vtBdL7jq2eFVIfo8xvIYI49E8JplP/rj5uVFV96SJVF8hMtY2X2udSkWOgBx
         /s498qcNS1Eid3rgSzccVAxlcYhpjXs+FwkfMAH3dfFg+PAncoaU/kB/0z1VjBfi5/3b
         s+JmMbiI2DgQLVxXf9HlA46kl2PETUgoQqABmk80LNQeIaAYQV32Eq4Znvy8EJnu+ZnR
         NqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wRJeuNMECfIR2T5BvBaStXjhMzdrlDtYinDb6OGqSJE=;
        b=HFCfLy6twteL9FXGrWG2Y9OK6DwIJqEVMms1Ras+E9JWGezOvqcNjWGasy1NwDLQ9V
         9ojJdcZuMzGEjx/NlOJUykZsIRzK4PSjwNvlVe4ij4vW30T1Bd85tBkpgn79G488qjXK
         5+83ypMENKO1d9Nqu+PvyQwMH+8xG3JCSd7upn1H7Hm96tV9tneqxqeeo3O0tqAZixzt
         kfjvPZEF/rtB/+6+SAsqkW5wCYVbsKzvTllESXcd/ztKIAgDpLtROMvycC4+VWx6sNnh
         qE0EFG608oKzcoF3PfMNkA7Z/QOelGYY4c8DWdbnlg1Dql8vIRvfOoQMM9fBicAMguW6
         i6wQ==
X-Gm-Message-State: AFqh2kqYW/TzyrK0FXqVdOqAVRN4w/Lk0mqdFpNrdmxSJcejtVSZQ4K6
        PV1OlFqmHZlss6aIOXPPuGxiwDVPw4B9UW463Ho=
X-Google-Smtp-Source: AMrXdXu4DocIb/qbjx4z9p5zFrQigVSJqzdXoljmC8b6VFjo9zoeYd1+wzIw/gRCZ6atl2XwOr7aLjKah3k/7CPL9U0=
X-Received: by 2002:a17:906:a014:b0:7c1:8450:f964 with SMTP id
 p20-20020a170906a01400b007c18450f964mr7788457ejy.176.1673647644511; Fri, 13
 Jan 2023 14:07:24 -0800 (PST)
MIME-Version: 1.0
References: <20230113093427.1666466-1-imagedong@tencent.com> <bdca73eb-07e3-2187-c46f-a3f14a9e50a4@oracle.com>
In-Reply-To: <bdca73eb-07e3-2187-c46f-a3f14a9e50a4@oracle.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 13 Jan 2023 14:07:12 -0800
Message-ID: <CAEf4BzZ5FNw-j3F8cUpy4knRiM1sqQOOPZnM43Kj8peN9kKQLg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: replace '.' with '_' in legacy kprobe event name
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     menglong8.dong@gmail.com, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
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

On Fri, Jan 13, 2023 at 6:13 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On 13/01/2023 09:34, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <imagedong@tencent.com>
> >
> > '.' is not allowed in the event name of kprobe. Therefore, we will get a
> > EINVAL if the kernel function name has a '.' in legacy kprobe attach
> > case, such as 'icmp_reply.constprop.0'.
> >
> > In order to adapt this case, we need to replace the '.' with other char
> > in gen_kprobe_legacy_event_name(). And I use '_' for this propose.
> >
> > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > ---
> >  tools/lib/bpf/libbpf.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index fdfb1ca34ced..5d6f6675c2f2 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -9994,9 +9994,16 @@ static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
> >                                        const char *kfunc_name, size_t offset)
> >  {
> >       static int index = 0;
> > +     int i = 0;
> >
> >       snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx_%d", getpid(), kfunc_name, offset,
> >                __sync_fetch_and_add(&index, 1));
> > +
> > +     while (buf[i] != '\0') {
> > +             if (buf[i] == '.')
> > +                     buf[i] = '_';
> > +             i++;
> > +     }
> >  }
>
> probably more naturally expressed as a for() loop as is done in
> gen_uprobe_legacy_event_name(), but not a big deal.
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Applied, but tuned to be exactly the same loop as in
gen_uprobe_legacy_event_name. Thanks.

>
> One issue with the legacy kprobe code is that we don't get test coverage
> with it on new kernels - I wonder if it would be worth adding a force_legacy
> option to bpf_kprobe_opts? A separate issue to this change of course, but
> if we had that we could add some legacy kprobe tests that would run
> for new kernels as well.

Yep, good idea. If we ever have some bug in the latest greatest kprobe
implementation, users will have an option to work around that with
this.

The only thing is that we already have 3 modes: legacy, perf-based
through ioctl, and bpf_link-based, so I think it should be something
like

enum kprobe_mode {
    KPROBE_MODE_DEFAULT = 0, /* latest supported by kernel */
    KPROBE_MODE_LEGACY,
    KPROBE_MODE_PERF,
    KPROBE_MODE_LINK,
};

LEGACY/PERF/LINK naming should be thought through, just a quick example.

And then just have `enum kprobe_mode mode;` in kprobe_opts, which
would default to 0 (KPROBE_MODE_DEFAULT).

Would that work?

>
> Alan
> >
> >  static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
> >
