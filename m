Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2B34BF0F3
	for <lists+bpf@lfdr.de>; Tue, 22 Feb 2022 05:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiBVEap (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Feb 2022 23:30:45 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiBVEao (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Feb 2022 23:30:44 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050AD9D4C1;
        Mon, 21 Feb 2022 20:30:15 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id gl14-20020a17090b120e00b001bc2182c3d5so799608pjb.1;
        Mon, 21 Feb 2022 20:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2IZfGqcc5mgEr3Q2qco8v+1frM3x3CTORZa261ZfQBw=;
        b=WqttCe9aYEff+/cRAdFFPQEiABP3ZhIUeiepBC8nhk7yXwsAc0FEyM6jjVlMtC9sP5
         PTbtiwz5RTF+MKoix1doUgVdPrNOARdJCbewBDqG6eIDKSVUgelfg4z6cfV1yYo+3MLZ
         JgYa5YI/9NrB0acRD7tVMr1dM8DDhgrrNJyTGWeRJgKmdxEOAxl9ykX46s6vPhFMwxqo
         j9pZxorAraUf39yjjAHpkUgZzOwdHaCET/Niwzyugl+QiIzdNwLwOyEq8xodGgBkLeE9
         LQlitUXyKqeYjkt8h6nh5TOOat5dIVFV0JmEc2Px2aN7FnnTeMtNSUm25fEopkgyHu30
         urTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2IZfGqcc5mgEr3Q2qco8v+1frM3x3CTORZa261ZfQBw=;
        b=Joi9qYndm93wi4LD5MNeWYvw+E8vIPEKYJo9K+lFHQ1Jc4GMYp/aNa1gaVtsA8q1ns
         Z9TWf9/DYQ+WRlgNJBRL3GjidJ78oWhJJTsanELmbWQvP0qWK+2yKTT0/KEkyMfXy+vh
         8QpqZQG1yIB3+ayADbWonEf7I/jDFpMUy8ivwwROmT07kO2liU9W7sxwm12n7htF8fKS
         ZQWBuoVj8BNwysC5i3hqtq+Q16t9kTBOWH9N7dj29Zh6D2HWGc8We1UbwogTHVWx+lXx
         fdQY48ZtgkG0yEAIuOrPRENZGB52Jwzh+E7NnlDe8zsO6XTLWo5IkyhYnV3MdwBqctZB
         VP3g==
X-Gm-Message-State: AOAM531Qgmz6xZXPbksx/L8D7UCJW47vsdRZbYiNCVOlX9oIGWezJ4WJ
        KFGhVjikE8G49+EY7Y4DpA/a4v47hBHE12yD8NY=
X-Google-Smtp-Source: ABdhPJx9YayGKPD6R0B87TBiNa2x1jXMZFOtocFXPgEKQMMy3Aul3dy82oDwXS7HImXbAp71rlWF7rxStle9h1VapDQ=
X-Received: by 2002:a17:902:76c5:b0:14e:e325:9513 with SMTP id
 j5-20020a17090276c500b0014ee3259513mr21618411plt.55.1645504215284; Mon, 21
 Feb 2022 20:30:15 -0800 (PST)
MIME-Version: 1.0
References: <20220218095612.52082-1-laoar.shao@gmail.com> <20220218095612.52082-3-laoar.shao@gmail.com>
 <CAADnVQJhGmvY1NDsy9WE6tnqYM6JCmi4iZtB7xHuWh4yC-awPw@mail.gmail.com>
 <CALOAHbCytBP4osCXSZ_7+A69NuVf6SYDWGFC62O_MkHn9Fn10Q@mail.gmail.com>
 <CAADnVQ+FuK2wihDy5GumBN3LVBky0r04CmS4h1JsVoS7QoH6LA@mail.gmail.com> <CALOAHbAvG1gEAFhqs61x4aStaxph-O3f8k0XbCuUJK4rxcMRFw@mail.gmail.com>
In-Reply-To: <CALOAHbAvG1gEAFhqs61x4aStaxph-O3f8k0XbCuUJK4rxcMRFw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 21 Feb 2022 20:30:04 -0800
Message-ID: <CAADnVQ+ye+hRB2RvDY+=-kTOhBZesW0fyLR0EY9cV972SwZSSQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] bpf: set attached cgroup name in attach_name
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
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

On Mon, Feb 21, 2022 at 6:26 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> On Mon, Feb 21, 2022 at 4:59 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Sun, Feb 20, 2022 at 6:17 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > >
> > > On Sun, Feb 20, 2022 at 2:27 AM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Fri, Feb 18, 2022 at 1:56 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > > >
> > > > > Set the cgroup path when a bpf prog is attached to a cgroup, and unset
> > > > > it when the bpf prog is detached.
> > > > >
> > > > > Below is the result after this change,
> > > > > $ cat progs.debug
> > > > >   id name             attached
> > > > >    5 dump_bpf_map     bpf_iter_bpf_map
> > > > >    7 dump_bpf_prog    bpf_iter_bpf_prog
> > > > >   17 bpf_sockmap      cgroup:/
> > > > >   19 bpf_redir_proxy
> > > > >
> > > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > > ---
> > > > >  kernel/bpf/cgroup.c | 8 ++++++++
> > > > >  1 file changed, 8 insertions(+)
> > > > >
> > > > > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > > > > index 43eb3501721b..ebd87e54f2d0 100644
> > > > > --- a/kernel/bpf/cgroup.c
> > > > > +++ b/kernel/bpf/cgroup.c
> > > > > @@ -440,6 +440,7 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
> > > > >         struct bpf_cgroup_storage *storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
> > > > >         struct bpf_cgroup_storage *new_storage[MAX_BPF_CGROUP_STORAGE_TYPE] = {};
> > > > >         enum cgroup_bpf_attach_type atype;
> > > > > +       char cgrp_path[64] = "cgroup:";
> > > > >         struct bpf_prog_list *pl;
> > > > >         struct list_head *progs;
> > > > >         int err;
> > > > > @@ -508,6 +509,11 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
> > > > >         else
> > > > >                 static_branch_inc(&cgroup_bpf_enabled_key[atype]);
> > > > >         bpf_cgroup_storages_link(new_storage, cgrp, type);
> > > > > +
> > > > > +       cgroup_name(cgrp, cgrp_path + strlen("cgroup:"), 64);
> > > > > +       cgrp_path[63] = '\0';
> > > > > +       prog->aux->attach_name = kstrdup(cgrp_path, GFP_KERNEL);
> > > > > +
> > > >
> > > > This is pure debug code. We cannot have it in the kernel.
> > > > Not even under #ifdef.
> > > >
> > > > Please do such debug code on a side as your own bpf program.
> > > > For example by kprobe-ing in this function and keeping the path
> > > > in a bpf map or send it to user space via ringbuf.
> > > > Or enable cgroup tracepoint and monitor cgroup_mkdir with full path.
> > > > Record it in user space or in bpf map, etc.
> > > >
> > >
> > > It is another possible solution to  hook the related kernel functions
> > > or tracepoints, but it may be a little complicated to track all the
> > > bpf attach types, for example we also want to track
> > > BPF_PROG_TYPE_SK_MSG[1], BPF_PROG_TYPE_FLOW_DISSECTOR and etc.
> > > While the attach_name provides us a generic way to get how the bpf
> > > progs are attached, which can't be got by bpftool.
> >
> > bpftool can certainly print such details.
> > See how it's using task_file iterator.
> > It can be extended to look into cgroups and sockmap,
> > and for each program print "sockmap:%d", map->id if so desired.
>
> I have read through the task_file code, but I haven't found a direct
> way to get the attached cgroups or maps of a specified prog.
> It is easy to look into a cgroup or sockmap, but the key point here is
> which is the proper cgroup or sockmap.
> There are some possible ways to get the attached cgroup or sockmap.
>
> - add new member into struct bpf_prog_aux

No. Please stop proposing kernel changes for your debug needs.

>    For example,
>     struct bpf_prog_aux{
>         union {
>             struct cgroup *attached_cgrp;
>             struct bpf_map *attached_map;
>         };
>     };
>     Then we can easily get the related map or cgroup by extending
> task_file iterator.
>
> - build a table for attached maps, cgroups and etc
>    Like we did for pinned files.
>    Then we can compare the prog with the members stored in this table
> one by one, but that seems a little heavy.
>
> There may be some other ways.

- iterate bpf maps
- find sockmap
- do equivalent of sock_map_progs(), but open coded inside bpf prog
- read progs, print them.
