Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34A94D0D9F
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 02:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbiCHBnd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Mar 2022 20:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244565AbiCHBnc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Mar 2022 20:43:32 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316FB26E2
        for <bpf@vger.kernel.org>; Mon,  7 Mar 2022 17:42:35 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id d62so19224821iog.13
        for <bpf@vger.kernel.org>; Mon, 07 Mar 2022 17:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IgkPuj5KURNmuMTefsS6A1ZLQVs00dlbpKkyTtsPpqM=;
        b=lxpzWcoE8VWDPAuauPSVlvD54/IRf8aVC6Ih19wLhwVfhjMHmpF8q6W5FPmvQCsSg9
         u9ImNDJrotB/m5yGV9Tu3NE6Hj0sH65ABCoxCjhDbble5O9ojv9iAJ0lyg7ukSAF/Kxh
         fQqJ20M/h3Ym/rtuZkIORtjmG9876oKXSKqFei+MrxNoJM/eulGDDrGJYlIQTrzZ/JuO
         KGKY91B2N5uD2ymKYLlqSLvyZU9TBa6FhVFwemfUbiVQIoVd/PGVM3C81RURj9EvGDeI
         8VKIfUGviyn9TAAx0VmlwazMPSWj1Y63gkejjbvBy6SMVc1pcJY+xZaREKTauuNYix7H
         XM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IgkPuj5KURNmuMTefsS6A1ZLQVs00dlbpKkyTtsPpqM=;
        b=iapeyzPGCaBPCzEbQPWRIf6f2y809RL19SfJbD/drQzemObPv60EWjOfblWTFdHnOP
         PhXTWPjGDFdeXrUqX3IdVYhkKUc2VneP08SyJ1wQJU91gVmTfuDhbU/74YRy8VonPQz0
         /Ec4uSHSRva3Tl0d4cK6OCYcW4HWYNW7oP+yBmkMQhOmXHHd5pPM4Q53ZBVMXOEmB1Sr
         I21WrFPGn98Qipiy4g7fMRmBcu6wAw0o78xHqI0RKXgl54eagLSr5UitX1dXEmD+OspV
         hVbtQGKUH3FMCc/I05VsaWdrovFNajH+TQXwRwUT7DXDe8wkc0od2PYbDZPivB5yO8mH
         kgnw==
X-Gm-Message-State: AOAM531mJ0Uv785+tfm4DkMU4aoe3DxqDyzrJkF7YNCzM0C2dvCEMHGG
        pJxoJPcIjfJuHbCSVgIuH3l++ToRqHK7DABiWRs=
X-Google-Smtp-Source: ABdhPJxHkGQyLgOumVjJ3PFrPetmpRHdW72kt5ukwA/joH7f6W+TUepA7MSLM3BchIJsz+L3MNWYZWqOMwx62OS4CMk=
X-Received: by 2002:a05:6602:3c6:b0:63d:cac9:bd35 with SMTP id
 g6-20020a05660203c600b0063dcac9bd35mr12718234iov.144.1646703754596; Mon, 07
 Mar 2022 17:42:34 -0800 (PST)
MIME-Version: 1.0
References: <20220304143610.10796-1-9erthalion6@gmail.com> <acf30143-dc2c-9651-44b6-af45a1c426ce@fb.com>
 <20220305124426.qodif327pima6rqj@erthalion.local>
In-Reply-To: <20220305124426.qodif327pima6rqj@erthalion.local>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Mar 2022 17:42:23 -0800
Message-ID: <CAEf4Bza84P5sy9USvOWBNhkGYk228C48v=2qR91MXCA9SV2nyA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5] bpftool: Add bpf_cookie to link output
To:     Dmitry Dolgov <9erthalion6@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
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

On Sat, Mar 5, 2022 at 4:44 AM Dmitry Dolgov <9erthalion6@gmail.com> wrote:
>
> On Fri, Mar 04, 2022 at 08:21:34AM -0800, Yonghong Song wrote:
> >
> > > diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
> > > index 7c384d10e95f..6c6e7c90cc3d 100644
> > > --- a/tools/bpf/bpftool/pids.c
> > > +++ b/tools/bpf/bpftool/pids.c
> > > @@ -78,6 +78,8 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
> > >     ref->pid = e->pid;
> > >     memcpy(ref->comm, e->comm, sizeof(ref->comm));
> > >     refs->ref_cnt = 1;
> > > +   refs->bpf_cookie_set = e->bpf_cookie_set;
> > > +   refs->bpf_cookie = e->bpf_cookie;
> > >     err = hashmap__append(map, u32_as_hash_field(e->id), refs);
> > >     if (err)
> > > @@ -205,6 +207,9 @@ void emit_obj_refs_json(struct hashmap *map, __u32 id,
> > >             if (refs->ref_cnt == 0)
> > >                     break;
> > > +           if (refs->bpf_cookie_set)
> > > +                   jsonw_lluint_field(json_writer, "bpf_cookie", refs->bpf_cookie);
> >
> > The original motivation for 'bpf_cookie' is for kprobe to get function
> > addresses. In that case, printing with llx (0x...) is better than llu
> > since people can easily search it with /proc/kallsyms to get what the
> > function it attached to. But on the other hand, other use cases might
> > be simply just wanting an int.
> >
> > I don't have a strong opinion here. Just to speak out loud so other
> > people can comment on this too.
>
> Interesting, I didn't know that. The current implementation of
> 'bpf_cookie' seems to be quite opaque, with no assumptions about what
> does it contain, probably it makes sense to keep it like that. But I
> don't have a strong opinion here either, would love to hear what others
> think.

There is no assumption that it's going to be an address. I actually
expect that usually it will be a small index into an additional array
of configuration values. So keeping it decimal makes more sense to me.

>
> > > diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> > > index f70702fcb224..91366ce33717 100644
> > > --- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> > > +++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> > > @@ -38,6 +38,18 @@ static __always_inline __u32 get_obj_id(void *ent, enum bpf_obj_type type)
> > >     }
> > >   }
> > > +/* could be used only with BPF_LINK_TYPE_PERF_EVENT links */
> > > +static __always_inline __u64 get_bpf_cookie(struct bpf_link *link)
> > > +{
> > > +   struct bpf_perf_link *perf_link;
> > > +   struct perf_event *event;
> > > +
> > > +   perf_link = container_of(link, struct bpf_perf_link, link);
> > > +   event = BPF_CORE_READ(perf_link, perf_file, private_data);
> > > +   return BPF_CORE_READ(event, bpf_cookie);
> > > +}
> > > +
> > > +
> > >   SEC("iter/task_file")
> > >   int iter(struct bpf_iter__task_file *ctx)
> > >   {
> > > @@ -69,8 +81,21 @@ int iter(struct bpf_iter__task_file *ctx)
> > >     if (file->f_op != fops)
> > >             return 0;
> > > +   __builtin_memset(&e, 0, sizeof(e));
> > >     e.pid = task->tgid;
> > >     e.id = get_obj_id(file->private_data, obj_type);
> > > +   e.bpf_cookie = 0;
> > > +   e.bpf_cookie_set = false;
> >
> > We already have __builtin_memset(&e, 0, sizeof(e)) in the above, so
> > the above e.bpf_cookie and e.bpf_cookie_set assignment is not
> > necessary.
>
> Good point, will remote this.
