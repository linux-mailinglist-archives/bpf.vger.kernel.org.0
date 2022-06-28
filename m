Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9616D55C985
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 14:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245004AbiF1Ch7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jun 2022 22:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245484AbiF1ChI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jun 2022 22:37:08 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F4924F05;
        Mon, 27 Jun 2022 19:35:20 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e40so15611228eda.2;
        Mon, 27 Jun 2022 19:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=77y8k5HwZn62QQEYdBEIajSquSU8YYGk2sZykOU7Npc=;
        b=LQUpgVH6mM88Om1xQhWT1I5OFFY6VXqfVb3DQj3mioaPnp4tQ621Sz8o8905Ek7876
         6BQBohW/ZzAUNKgvp1pGhLBtkSmFVnCoMtvKtffmkp7xeHcnyDN2GRYCO/UPM6lsbNjs
         yGoFjY3uB8Luj8Xktzn+X2yZtXgrWuCyjc2u3BPsl5vnxuy45MsS+6E1oAonbKN+BXVR
         vKyn7lvYYLNZtRpZwfAOiz2FDoYZWmLFMES7O4Z1FMQGaWZjFjcXSNbW0mAFtOAejuiJ
         s1RhIo8dBKR2MgwWzCRvQHPmDS4o7XcG9MePmiwEddrIh9RQse4EpZ0Wjc+6b3KvL+AI
         gdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77y8k5HwZn62QQEYdBEIajSquSU8YYGk2sZykOU7Npc=;
        b=GuvAZEE5qLMoaoGLcSjfqj0/n8PAHBWuEBfXJYowpZhcWzAOzdGZvtyQ8FnvDvmXO5
         eeGS+bBKA77pYjXsfqbrapyZvNI+5BZveOzYDZ780+fZJQdL7AB5z71orLqyYpZXiTch
         1qWaIUDrTmv0DkJWBm4dIn1gkaU69u9DAuqjTbu0mbM57zivVK9Yh+2dsS3FmB6UzvbF
         jbuzawanNuT3qkGngqZi03ZfgyhM07Crv6czYr84hZ8WuwuxHfgyO6v77iq332mFSGo1
         o0XF8U6kNartYwrWsujzR8rh9/pKOSQ9YDtqLfwKI8+z5EPSPrUzxHZ/fiLCwfb1s9cj
         VCCg==
X-Gm-Message-State: AJIora/X/uv++CPv05M8gE978bzvGWEkNpQDb5vJaGDTU8Eb6K4YzHb9
        m+oVeTNwad41pneYpmbBVxpCiBmj8zeJXJoyzjM=
X-Google-Smtp-Source: AGRyM1uN21z+as3WVU+2V6rnFKlf8BSjTih54MbevuuJ+hZ61aHnKUwMfs2RNyFo1KGBoAUpulmOfrZB2QxuMZseak8=
X-Received: by 2002:a05:6402:32a2:b0:435:8b5a:4081 with SMTP id
 f34-20020a05640232a200b004358b5a4081mr20520205eda.232.1656383719382; Mon, 27
 Jun 2022 19:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220626031301.60390-1-nashuiliang@gmail.com> <CAEf4BzbnEFqdEZTNRWf8vJ8hExpKkg_rwgoQE-cyyU7fDafxZw@mail.gmail.com>
 <CACueBy5zdsVz-CVhtY0ekKDbrmF3ra6YSBuPWQK_qxSb6dXsxA@mail.gmail.com>
In-Reply-To: <CACueBy5zdsVz-CVhtY0ekKDbrmF3ra6YSBuPWQK_qxSb6dXsxA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Jun 2022 19:35:08 -0700
Message-ID: <CAEf4BzZK7WNFfwHo3dV=0_BTKVUVPXKAAtGoS6MKgzWGz1GzkQ@mail.gmail.com>
Subject: Re: [PATCH v3] libbpf: Cleanup the legacy kprobe_event on failed add/attach_event()
To:     Chuang W <nashuiliang@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jingren Zhou <zhoujingren@didiglobal.com>
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

On Mon, Jun 27, 2022 at 6:51 PM Chuang W <nashuiliang@gmail.com> wrote:
>
> Hi Andrii,
>
> On Tue, Jun 28, 2022 at 5:27 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sat, Jun 25, 2022 at 8:13 PM Chuang W <nashuiliang@gmail.com> wrote:
> > >
> > > Before the 0bc11ed5ab60 commit ("kprobes: Allow kprobes coexist with
> > > livepatch"), in a scenario where livepatch and kprobe coexist on the
> > > same function entry, the creation of kprobe_event using
> > > add_kprobe_event_legacy() will be successful, at the same time as a
> > > trace event (e.g. /debugfs/tracing/events/kprobe/XXX) will exist, but
> > > perf_event_open() will return an error because both livepatch and kprobe
> > > use FTRACE_OPS_FL_IPMODIFY. As follows:
> > >
> > > 1) add a livepatch
> > >
> > > $ insmod livepatch-XXX.ko
> > >
> > > 2) add a kprobe using tracefs API (i.e. add_kprobe_event_legacy)
> > >
> > > $ echo 'p:mykprobe XXX' > /sys/kernel/debug/tracing/kprobe_events
> > >
> > > 3) enable this kprobe (i.e. sys_perf_event_open)
> > >
> > > This will return an error, -EBUSY.
> > >
> > > On Andrii Nakryiko's comment, few error paths in
> > > bpf_program__attach_kprobe_opts() which should need to call
> > > remove_kprobe_event_legacy().
> > >
> > > With this patch, whenever an error is returned after
> > > add_kprobe_event_legacy() or bpf_program__attach_perf_event_opts(), this
> > > ensures that the created kprobe_event is cleaned.
> > >
> > > Signed-off-by: Chuang W <nashuiliang@gmail.com>
> >
> > Is this your full name? Signed-off-by is required to have a full name
> > of a person, please update if it's not
> >
> > > Signed-off-by: Jingren Zhou <zhoujingren@didiglobal.com>
> > > ---
> > > V2->v3:
> > > - add detail commits
> > > - call remove_kprobe_event_legacy() on failed bpf_program__attach_perf_event_opts()
> > >
> > >  tools/lib/bpf/libbpf.c | 15 ++++++++++++---
> > >  1 file changed, 12 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index 49e359cd34df..038b0cb3313f 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -10811,10 +10811,11 @@ static int perf_event_kprobe_open_legacy(const char *probe_name, bool retprobe,
> > >         }
> > >         type = determine_kprobe_perf_type_legacy(probe_name, retprobe);
> > >         if (type < 0) {
> > > +               err = type;
> > >                 pr_warn("failed to determine legacy kprobe event id for '%s+0x%zx': %s\n",
> > >                         kfunc_name, offset,
> > > -                       libbpf_strerror_r(type, errmsg, sizeof(errmsg)));
> > > -               return type;
> > > +                       libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
> > > +               goto clear_kprobe_event;
> > >         }
> > >         attr.size = sizeof(attr);
> > >         attr.config = type;
> > > @@ -10828,9 +10829,14 @@ static int perf_event_kprobe_open_legacy(const char *probe_name, bool retprobe,
> > >                 err = -errno;
> > >                 pr_warn("legacy kprobe perf_event_open() failed: %s\n",
> > >                         libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
> > > -               return err;
> > > +               goto clear_kprobe_event;
> > >         }
> > >         return pfd;
> > > +
> > > +clear_kprobe_event:
> > > +       /* Clear the newly added legacy kprobe_event */
> > > +       remove_kprobe_event_legacy(probe_name, retprobe);
> > > +       return err;
> > >  }
> > >
> >
> > this part looks good
> >
> >
> > >  struct bpf_link *
> > > @@ -10899,6 +10905,9 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
> > >
> > >         return link;
> > >  err_out:
> > > +       /* Clear the newly added legacy kprobe_event */
> > > +       if (legacy)
> > > +               remove_kprobe_event_legacy(legacy_probe, retprobe);
> >
> > this one will call remove_kprobe_event_legacy() even if we failed to
> > create that kprobe_event in the first place. So let's maybe add
> >
> > err_clean_legacy:
> >     if (legacy)
> >          remove_kprobe_event_legacy(legacy_probe, retprobe);
> >
> > before err_out: and goto there if we fail to attach (but not if we
> > fail to create pfd)?
> >
>
> Nice, I will modify it.
>
> >
> > Also, looking through libbpf code, I realized that we have exactly the
> > same problem for uprobes, so please add same fixed to
> > perf_event_uprobe_open_legacy and attach_uprobe_opts. Thanks!
> >
>
> Oh, yes. I also noticed this problem for uprobes, I was planning to
> submit a patch for uprobes.
> Do you think I should submit another patch for uprobes or combine
> kprobes and uprobes into one?
>

two separate patches make more sense, but send them as a patch series?

> Thanks,
> >
> >
> > >         free(legacy_probe);
> > >         return libbpf_err_ptr(err);
> > >  }
> > > --
> > > 2.34.1
> > >
