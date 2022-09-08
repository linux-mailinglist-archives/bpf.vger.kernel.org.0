Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF215B2A78
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 01:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiIHXfd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 19:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiIHXet (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 19:34:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97BB5D0C9
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 16:33:08 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id dv25so16299ejb.12
        for <bpf@vger.kernel.org>; Thu, 08 Sep 2022 16:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=nTZj4t+03EARlY96ZG9IhZEDsvzCHFU+yjyrPoB54ig=;
        b=X9HriGPR4EADQtKeIf/zjVLLW7XdBu3t1WFfet3Rds/4qUB5AZ+r9m59h4G1IIavVv
         jk35dyaPBIczuCedlxTZM50gTmlUVNKFQ4EZNkzxMtU7HbuU2gN5cfPn2yJrUw7dEzvZ
         9Hd5SuVLtyzdCg0x7V18B6OS7IQv6Xy4wkJIyQmnNhvgUPh6gLIbno4BIlEcU4yMdAzN
         OdyeXj/CcM7HlhW11PVGjdhR3PcKEBMSxRf9iHvNiY+nQbo5tmZSxV5w//3TtD+Mjgop
         MikFExs64vzUsxeiP3udomC2sXRoUacPL/rXZ2C8u36P8jBenZ/q6hZWRGaPuUiwp3ZG
         y6BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=nTZj4t+03EARlY96ZG9IhZEDsvzCHFU+yjyrPoB54ig=;
        b=VtCwZ6Mo0el2KMdGGEs6oItvB4pc30Z45Qt29FfUOUZB/XghB4QCa7L1HSR9nq8j6e
         tiRk+1aHfB2BClXCGcTb1GNujLGUArhnDVsUcO9RyO4qngFKSZQFjoY8+iDrEb9cNvyr
         0BKDweBly1QHOf1w87wBQt6uHVisj+ZbcVeUgYYKr0VdJn58gaj0w7DZnlCWg8BFcz+T
         UEm5MczpQkLSRbLOKuwMXkYtHDdo3iu6tXcdGU0Qs37hSXWhH4vzRVhB2aY4kXlVgXuI
         KwsX5tJNZYrH6ERWS5z8MEe0QJe3aPs3gwRF+Wnf1en5BPN47zv2w5AdduIO7HVD2T8K
         j8oQ==
X-Gm-Message-State: ACgBeo1gvtn4FupnWcDPl7/0yB/C76EFb1mSEHNq/whqMv1QKO1AuYbW
        BTOAIJ4GR5X/iEZZZcuns1zvfsvpSOlqvUEv0qw=
X-Google-Smtp-Source: AA6agR5sFeQ04PzdoU50WpcM38dPPNIlfgXDzjcpVQRsFUU5BnauO7n04tdHhg6AfPTKmZteWuN/q3Ml0xR3KgwXi4s=
X-Received: by 2002:a17:907:2be9:b0:770:77f2:b7af with SMTP id
 gv41-20020a1709072be900b0077077f2b7afmr7812768ejc.545.1662679986991; Thu, 08
 Sep 2022 16:33:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220824033837.458197-1-weiyongjun1@huawei.com>
 <b942bf8f-204b-6bf1-7847-ec5f11c50ca0@isovalent.com> <CAEf4BzafSAZfhkun5PBGODw6v1s10Nh4JeH8azdqZY-62kBCKg@mail.gmail.com>
 <ee620e99-dc04-aa2c-f53b-b875dba79feb@isovalent.com> <d17a51a0-954f-7c77-7172-9ef5b3bb84f7@huawei.com>
 <0fea646d-429a-9c7f-2c1d-b2893b02554a@isovalent.com>
In-Reply-To: <0fea646d-429a-9c7f-2c1d-b2893b02554a@isovalent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 8 Sep 2022 16:32:55 -0700
Message-ID: <CAEf4BzZ5MVmzu7y82ybonfLdn5r_aOSjcB8kZYOmBrrCwFngKw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpftool: implement perf attach command
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     "weiyongjun (A)" <weiyongjun1@huawei.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
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

On Tue, Sep 6, 2022 at 2:17 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
> On 02/09/2022 11:23, weiyongjun (A) wrote:
> > Hi Quentin,
> >
> > On 2022/8/26 18:45, Quentin Monnet wrote:
> >> Hi Andrii,
> >>
> >> On 25/08/2022 19:37, Andrii Nakryiko wrote:
> >>> On Thu, Aug 25, 2022 at 8:28 AM Quentin Monnet
> >>> <quentin@isovalent.com> wrote:
> >>>>
> >>>> Hi Wei,
> >>>>
> >>>> Apologies for failing to answer to your previous email and for the
> >>>> delay
> >>>> on this one, I just found out GMail had classified them as spam :(.
> >>>>
> >>>> So as for your last message, yes: your understanding of my previous
> >>>> answer was correct. Thanks for the patch below! Some comments inline.
> >>>>
> >>>
> >>> Do we really want to add such a specific command to bpftool that would
> >>> attach BPF object files with programs of only RAW_TRACEPOINT and
> >>> RAW_TRACEPOINT_WRITABLE type?
> >>>
> >>> I could understand if we added something that would be equivalent of
> >>> BPF skeleton's auto-attach method. That would make sense in some
> >>> contexts, especially for some quick testing and validation, to avoid
> >>> writing (a rather simple) user-space loading code.
> >>
> >> Do you mean loading and attaching in a single step, or keeping the
> >> possibility to load first as in the current proposal?
> >>
> >>>
> >>> But "perf attach" for raw_tp programs only? Seem way too limited and
> >>> specific, just adding bloat to bpftool, IMO.
> >>
> >> We already support attaching some kinds of program types through
> >> "prog|cgroup|net attach". Here I thought we could add support for other
> >> types as a follow-up, but thinking again, you're probably right, it
> >> would be best if all the types were supported from the start. Wei, have
> >> you looked into how much work it would be to add support for
> >> tracepoints, k(ret)probes, u(ret)probes as well? The code should be
> >> mostly identical?
> >>
> >
> >
> > When I try to add others support, I found that we need to dup many code
> > with libbpf has already done, since we lost the section name info.

I don't think bpftool should be parsing SEC() definitions. As Quentin
suggested, just bpf_program__attach() should be enough.

>
> What amount of code does this represent? Do you have a version of the
> patch accessible somewhere? I trust you, I'm just curious about the
> steps we're missing without having processed the section name info, but
> I can go and look at the details myself otherwise.
>
> > I have tried to add auto-attach, it seems more easier then perf
> > attach command.
> >
> > What's about your opinion?
>
> Yes I'm good with that approach, too.
>
> > Maybe we only need a little of changes like this:
> >
> > $ bpftool prog load test.o /sys/fs/bpf/test auto-attach
>
> "auto_attach", other keywords use underscores rather than dashes.
>
> > diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> > index c81362a001ba..87fab89eaa07 100644
> > --- a/tools/bpf/bpftool/prog.c
> > +++ b/tools/bpf/bpftool/prog.c
> > @@ -1464,6 +1464,7 @@ static int load_with_options(int argc, char
>
>
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 3ad139285fad..915ec0a97583 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -7773,15 +7773,32 @@ int bpf_program__pin(struct bpf_program *prog,
> > const char *path)
> >      if (err)
> >          return libbpf_err(err);
> >
> > -    if (bpf_obj_pin(prog->fd, path)) {
> > -        err = -errno;
> > -        cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
> > -        pr_warn("prog '%s': failed to pin at '%s': %s\n", prog->name,
> > path, cp);
> > -        return libbpf_err(err);
> > +    if (prog->autoattach) {
> > +        struct bpf_link *link;
> > +
> > +        link = bpf_program__attach(prog);
> > +        err = libbpf_get_error(link);
> > +        if (err)
> > +            goto err_out;
> > +
> > +        err = bpf_link__pin(link, path);
> > +        if (err) {
> > +            bpf_link__destroy(link);
> > +            goto err_out;
> > +        }
> > +    } else {
> > +        if (bpf_obj_pin(prog->fd, path)) {
> > +            err = -errno;
> > +            goto err_out;
> > +        }
> >      }
> >
> >      pr_debug("prog '%s': pinned at '%s'\n", prog->name, path);
> >      return 0;
> > +err_out:
> > +    cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
> > +    pr_warn("prog '%s': failed to pin at '%s': %s\n", prog->name, path,
> > cp);
> > +    return libbpf_err(err);
> >  }
> >
> >  int bpf_program__unpin(struct bpf_program *prog, const char *path)
>
> I don't think it is correct to modify libbpf's bpf_program__pin()
> though, because it shouldn't be its role to attach and also because I
> think it might lead to a second attempt to attach if the user tries to
> pin in addition to running the auto-attach from a skeleton. Let's just
> call bpf_program__attach() from bpftool instead?

+1, libbpf shouldn't be modified for this feature
