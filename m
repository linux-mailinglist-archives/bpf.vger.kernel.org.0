Return-Path: <bpf+bounces-3381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1152073CDC4
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 03:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33FC41C20621
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 01:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4243562C;
	Sun, 25 Jun 2023 01:18:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082787F
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 01:18:50 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E029AEA
	for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 18:18:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fa8692a006so9666125e9.3
        for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 18:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687655927; x=1690247927;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CKJgYVSiFMGIXOaFunVNs0jJ28tROHIsIqY9PLPMj8U=;
        b=F2MKY1Leo58k/6QOSXWzWeBxBTD9dY4+792oE2jZzuJYDs86U56QyvsLuvPuklLIKL
         bqsZNnIPC+cE41py0LDzc0WXjImBWx8dZO7kclNRdBem7pMdJHe8fgHwH7nQeM8JRqK6
         2bv0nrBR9lBfC7jDSnlrGZiLheaY7e5vKncCJ65Ahj2crNx1XIx9Rd9S5JeFQYmp3a0J
         fIe9x9pXeWIflgSHsAzRobAOrKOyHwj7JE/1vOgm4/r8yIcd2iXPFjAtx6kamZggtaIH
         Tp+9OxJBAWbiSF9fFJUvt1FiHp+a6JCHzQ6jUf0d4+7TutdLA+cqXOhomzaPxXBB6Mz8
         DZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687655927; x=1690247927;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CKJgYVSiFMGIXOaFunVNs0jJ28tROHIsIqY9PLPMj8U=;
        b=UGBgm0DYURo6aWYYR554oZW2dy8Q30EaBzBAgotshkEYLMTnq5VFM56WzVAy8lV6/t
         H0G4TBJegpeIiPsRHwWomTKZIo2fp7x24S8janS7YbCwXR5nE8liq8jqfwOJLZirpK/h
         1nQcGGqtBWS1sgH4HuiNWf8wC8fIeWge1V2NVRnITi+UdPbfibbIvl1/afyXDs8NWZOj
         SU6lAaP3O/zrNs6vmhxjyRsJIEt0IS+XxADqtNkfN/DlAovBvNPwcH6H0kN3SoaObO7+
         ZFdEGWqvXqQUswautvUJvN2KS7R08YZzVupTNapHgfREL+KBfmCInU1rd3zA2+LbN5hd
         qvAA==
X-Gm-Message-State: AC+VfDydcOKvS8T4l+KUJys9WZv/hvw8Rp23iRCAS5JkfPB2hlaRqkJe
	1xQReBuC7/1w16gwUF2MBRU=
X-Google-Smtp-Source: ACHHUZ4ym+nz9bU2+QlhjC7sZEKdGoZxunNK3YSZvQvEqtGW3pwu4a/8uYxKEM0XG+SVnWOgAyRXyQ==
X-Received: by 2002:a5d:6505:0:b0:30f:d2af:d62b with SMTP id x5-20020a5d6505000000b0030fd2afd62bmr19774457wru.19.1687655926691;
        Sat, 24 Jun 2023 18:18:46 -0700 (PDT)
Received: from krava (brn-rj-tbond05.sa.cz. [185.94.55.134])
        by smtp.gmail.com with ESMTPSA id i11-20020adfefcb000000b0030ae3a6be5bsm3308738wrp.78.2023.06.24.18.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 18:18:46 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 25 Jun 2023 03:18:42 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf-next 14/24] libbpf: Add uprobe multi link support
 to bpf_program__attach_usdt
Message-ID: <ZJeV8p/LJeiRGp9j@krava>
References: <20230620083550.690426-1-jolsa@kernel.org>
 <20230620083550.690426-15-jolsa@kernel.org>
 <CAEf4Bza6=rxq8R3WGyqVf_KT3hX_SEKXZ5usk-QiCTRr=UgU5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza6=rxq8R3WGyqVf_KT3hX_SEKXZ5usk-QiCTRr=UgU5w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 01:40:27PM -0700, Andrii Nakryiko wrote:
> On Tue, Jun 20, 2023 at 1:38 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support for usdt_manager_attach_usdt to use uprobe_multi
> > link to attach to usdt probes.
> >
> > The uprobe_multi support is detected before the usdt program is
> > loaded and its expected_attach_type is set accordingly.
> >
> > If uprobe_multi support is detected the usdt_manager_attach_usdt
> > gathers uprobes info and calls bpf_program__attach_uprobe_opts to
> > create all needed uprobes.
> >
> > If uprobe_multi support is not detected the old behaviour stays.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c |  12 ++++-
> >  tools/lib/bpf/usdt.c   | 120 ++++++++++++++++++++++++++++++-----------
> >  2 files changed, 99 insertions(+), 33 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 3d570898459e..9c7a67c5cbe8 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -363,6 +363,8 @@ enum sec_def_flags {
> >         SEC_SLEEPABLE = 8,
> >         /* BPF program support non-linear XDP buffer */
> >         SEC_XDP_FRAGS = 16,
> > +       /* Setup proper attach type for usdt probes. */
> > +       SEC_USDT = 32,
> >  };
> >
> >  struct bpf_sec_def {
> > @@ -6799,6 +6801,10 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
> >         if (prog->type == BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
> >                 opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
> >
> > +       /* special check for usdt to use uprobe_multi link */
> > +       if ((def & SEC_USDT) && kernel_supports(NULL, FEAT_UPROBE_LINK))
> > +               prog->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
> 
> this is quite ugly. I think KPROBE programs do not have enforcement
> for expected_attach_type during BPF_PROG_LOAD, so we can set
> BPF_TRACE_UPROBE_MULTI unconditionally, right?

t doesn't but we are adding one earlier to bpf_prog_attach_check_attach_type
(the one with U/K typo):

	+       case BPF_PROG_TYPE_KPROBE:
	+               if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI &&
	+                   attach_type != BPF_TRACE_UPROBE_MULTI)
	+                       return -EINVAL;



for same reasons we did the check for kprobe_multi in:

  db8eae6bc5c7 bpf: Force kprobe multi expected_attach_type for kprobe_multi link

> 
> > +
> >         if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
> >                 int btf_obj_fd = 0, btf_type_id = 0, err;
> >                 const char *attach_name;
> > @@ -6867,7 +6873,6 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
> >         if (!insns || !insns_cnt)
> >                 return -EINVAL;
> >
> > -       load_attr.expected_attach_type = prog->expected_attach_type;
> >         if (kernel_supports(obj, FEAT_PROG_NAME))
> >                 prog_name = prog->name;
> >         load_attr.attach_prog_fd = prog->attach_prog_fd;
> > @@ -6903,6 +6908,9 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
> >                 insns_cnt = prog->insns_cnt;
> >         }
> >
> > +       /* allow prog_prepare_load_fn to change expected_attach_type */
> > +       load_attr.expected_attach_type = prog->expected_attach_type;
> > +
> >         if (obj->gen_loader) {
> >                 bpf_gen__prog_load(obj->gen_loader, prog->type, prog->name,
> >                                    license, insns, insns_cnt, &load_attr,
> > @@ -8703,7 +8711,7 @@ static const struct bpf_sec_def section_defs[] = {
> >         SEC_DEF("uretprobe.multi.s+",   KPROBE, BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
> >         SEC_DEF("ksyscall+",            KPROBE, 0, SEC_NONE, attach_ksyscall),
> >         SEC_DEF("kretsyscall+",         KPROBE, 0, SEC_NONE, attach_ksyscall),
> > -       SEC_DEF("usdt+",                KPROBE, 0, SEC_NONE, attach_usdt),
> > +       SEC_DEF("usdt+",                KPROBE, 0, SEC_USDT, attach_usdt),
> 
> btw, given you are touching USDT stuff, can you please also add
> sleepable USDT (usdt.s+) ?

ok

> 
> 
> >         SEC_DEF("tc",                   SCHED_CLS, 0, SEC_NONE),
> >         SEC_DEF("classifier",           SCHED_CLS, 0, SEC_NONE),
> >         SEC_DEF("action",               SCHED_ACT, 0, SEC_NONE),
> > diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> > index f1a141555f08..33f0a2b4cc1c 100644
> > --- a/tools/lib/bpf/usdt.c
> > +++ b/tools/lib/bpf/usdt.c
> > @@ -808,6 +808,16 @@ struct bpf_link_usdt {
> >                 long abs_ip;
> >                 struct bpf_link *link;
> >         } *uprobes;
> > +
> > +       bool has_uprobe_multi;
> > +
> > +       struct {
> > +               char *path;
> > +               unsigned long *offsets;
> > +               unsigned long *ref_ctr_offsets;
> > +               __u64 *cookies;
> 
> you shouldn't need to persist this, this can be allocated and freed
> inside usdt_manager_attach_usdt(), you only need the link pointer

aah right, that can go away, nice

> 
> 
> > +               struct bpf_link *link;
> > +       } uprobe_multi;
> >  };
> >
> >  static int bpf_link_usdt_detach(struct bpf_link *link)
> > @@ -816,19 +826,23 @@ static int bpf_link_usdt_detach(struct bpf_link *link)
> >         struct usdt_manager *man = usdt_link->usdt_man;
> >         int i;
> >
> > -       for (i = 0; i < usdt_link->uprobe_cnt; i++) {
> > -               /* detach underlying uprobe link */
> > -               bpf_link__destroy(usdt_link->uprobes[i].link);
> > -               /* there is no need to update specs map because it will be
> > -                * unconditionally overwritten on subsequent USDT attaches,
> > -                * but if BPF cookies are not used we need to remove entry
> > -                * from ip_to_spec_id map, otherwise we'll run into false
> > -                * conflicting IP errors
> > -                */
> > -               if (!man->has_bpf_cookie) {
> > -                       /* not much we can do about errors here */
> > -                       (void)bpf_map_delete_elem(bpf_map__fd(man->ip_to_spec_id_map),
> > -                                                 &usdt_link->uprobes[i].abs_ip);
> > +       if (usdt_link->has_uprobe_multi) {
> > +               bpf_link__destroy(usdt_link->uprobe_multi.link);
> > +       } else {
> > +               for (i = 0; i < usdt_link->uprobe_cnt; i++) {
> > +                       /* detach underlying uprobe link */
> > +                       bpf_link__destroy(usdt_link->uprobes[i].link);
> > +                       /* there is no need to update specs map because it will be
> > +                        * unconditionally overwritten on subsequent USDT attaches,
> > +                        * but if BPF cookies are not used we need to remove entry
> > +                        * from ip_to_spec_id map, otherwise we'll run into false
> > +                        * conflicting IP errors
> > +                        */
> > +                       if (!man->has_bpf_cookie) {
> > +                               /* not much we can do about errors here */
> > +                               (void)bpf_map_delete_elem(bpf_map__fd(man->ip_to_spec_id_map),
> > +                                                         &usdt_link->uprobes[i].abs_ip);
> > +                       }
> >                 }
> 
> you can avoid shifting all this by keeping uprobe_cnt to zero
> 
> bpf_link__destory(usdt_link->uprobe_multi.link) will work fine for NULL
> 
> so just do both clean ups sequentially, knowing that only one of them
> will actually do anything

ok, good idea

> 
> >         }
> >
> > @@ -868,9 +882,15 @@ static void bpf_link_usdt_dealloc(struct bpf_link *link)
> >  {
> >         struct bpf_link_usdt *usdt_link = container_of(link, struct bpf_link_usdt, link);
> >
> > -       free(usdt_link->spec_ids);
> > -       free(usdt_link->uprobes);
> > -       free(usdt_link);
> > +       if (usdt_link->has_uprobe_multi) {
> > +               free(usdt_link->uprobe_multi.offsets);
> > +               free(usdt_link->uprobe_multi.ref_ctr_offsets);
> > +               free(usdt_link->uprobe_multi.cookies);
> > +       } else {
> > +               free(usdt_link->spec_ids);
> > +               free(usdt_link->uprobes);
> > +               free(usdt_link);
> > +       }
> 
> similar to the above, just do *all* the clean up unconditionally and
> rely on free() handling NULLs just fine

ok

> 
> >  }
> >
> >  static size_t specs_hash_fn(long key, void *ctx)
> > @@ -943,11 +963,13 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
> >                                           const char *usdt_provider, const char *usdt_name,
> >                                           __u64 usdt_cookie)
> >  {
> > +       LIBBPF_OPTS(bpf_uprobe_multi_opts, opts_multi);
> >         int i, fd, err, spec_map_fd, ip_map_fd;
> >         LIBBPF_OPTS(bpf_uprobe_opts, opts);
> >         struct hashmap *specs_hash = NULL;
> >         struct bpf_link_usdt *link = NULL;
> >         struct usdt_target *targets = NULL;
> > +       struct bpf_link *uprobe_link;
> >         size_t target_cnt;
> >         Elf *elf;
> >
> > @@ -1003,16 +1025,29 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
> >         link->usdt_man = man;
> >         link->link.detach = &bpf_link_usdt_detach;
> >         link->link.dealloc = &bpf_link_usdt_dealloc;
> > +       link->has_uprobe_multi = bpf_program__expected_attach_type(prog) == BPF_TRACE_UPROBE_MULTI;
> 
> just use kernel_supports(), it's cleaner (and result is cached, so
> it's not less efficient)

ok

thanks,
jirka

