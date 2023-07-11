Return-Path: <bpf+bounces-4739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5823E74E9CB
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 11:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EAAE28157B
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 09:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FFC1774F;
	Tue, 11 Jul 2023 09:04:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0F917738
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 09:04:17 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F835E77
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:04:12 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b69923a715so85352061fa.0
        for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 02:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689066250; x=1691658250;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HbMLuIF27u7pQ+Go96/OgjU9ZxHo6A8KGb2tl9dEB3c=;
        b=BKYq63xarGjVV3GiE2CQoLBu1fyn5a+b51/PiUFtXCc33mKyf4s3YA+wla5EKH+xZH
         BcVgn1aI+SFM1PkYylEjnLyTo8S6XDCkgfxgX5S245yMOcyTJn+g+9cud/K9A1ySyI1T
         eNqWMluM9YoIUtWlYXP6/bNvawoqSAsRr+IAhlV2ECOFiu7mtHpamIkOcGQV6C3deUXI
         otGUJzexYsjSYy5QRN3skbFtKfBD18roLhF6sdJi8zno5qT7jChQQZFa+VOB6Ab3S0Vz
         RZ+yNuXfFizAyIUNn5DVLIm8fS1eG7a0L5LZroEKgoz/81Ehtx041U7R76gUEyJ8Wuqo
         9PbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689066250; x=1691658250;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HbMLuIF27u7pQ+Go96/OgjU9ZxHo6A8KGb2tl9dEB3c=;
        b=JDC2eVlfFqMIe70mpG5YEf8xc09jmuyRR1swtrJjTF80Y4h0w+KxRGP+d89zKpE3rq
         A+sKC7TbwzKEJG2fzdLzqWtVm5RJIgkbh7jdAAdUUw+ma0RWpVFTFYGelPqs+1i0rpJl
         JZMpfiG2K+ZayNkUj1OO/hO+XEvrlOIeIDCwNJWCyZ+nI+dbRtP0f58HypX3bCAS21gn
         cEEQK772Jmq2yx0+hxKuUAfGpq+DChISd/6uhqbYGAiAqdWvnxmXIjfhBGjTFaOlBP/E
         ONFml9ivyVCRXd0H6Yh1+g3hTGATM/sWPs8dVdVjkCa9PT1xIoylS4yDfipIhnNYbLOC
         gxUQ==
X-Gm-Message-State: ABy/qLaY1A5WsIEpQVhD09quzYnYBbTkJF/Gl8oRULO4CkKOQJclIrw7
	UwdI8ItXeKneCq3sz+wi/BQ=
X-Google-Smtp-Source: APBJJlEZ7n+bwoDTB+o03qGl9AK6QqnGFvYU0+wMYScgBUb5FYLK8QJlGEFfcOjcG8teEhUvDLwabg==
X-Received: by 2002:a2e:9c14:0:b0:2b7:31c:8c44 with SMTP id s20-20020a2e9c14000000b002b7031c8c44mr13128234lji.7.1689066250213;
        Tue, 11 Jul 2023 02:04:10 -0700 (PDT)
Received: from krava (net-109-116-206-239.cust.vodafonedsl.it. [109.116.206.239])
        by smtp.gmail.com with ESMTPSA id l6-20020a170906230600b00991faf3810esm875574eja.146.2023.07.11.02.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 02:04:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 11 Jul 2023 11:04:06 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv3 bpf-next 16/26] libbpf: Add uprobe multi link support
 to bpf_program__attach_usdt
Message-ID: <ZK0bBlRNtaKJnUTY@krava>
References: <20230630083344.984305-1-jolsa@kernel.org>
 <20230630083344.984305-17-jolsa@kernel.org>
 <CAEf4Bzb=NjO5eqYcx8oa3nOoPXt83MA54Om=aUqn4aTJFCSHmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb=NjO5eqYcx8oa3nOoPXt83MA54Om=aUqn4aTJFCSHmg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 09:29:35PM -0700, Andrii Nakryiko wrote:
> On Fri, Jun 30, 2023 at 1:37 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support for usdt_manager_attach_usdt to use uprobe_multi
> > link to attach to usdt probes.
> >
> > The uprobe_multi support is detected before the usdt program is
> > loaded and its expected_attach_type is set accordingly.
> >
> > If uprobe_multi support is detected the usdt_manager_attach_usdt
> > gathers uprobes info and calls bpf_program__attach_uprobe to
> > create all needed uprobes.
> >
> > If uprobe_multi support is not detected the old behaviour stays.
> >
> > Also adding usdt.s program section for sleepable usdt probes.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c | 13 +++++--
> >  tools/lib/bpf/usdt.c   | 78 ++++++++++++++++++++++++++++++++++--------
> >  2 files changed, 75 insertions(+), 16 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 4f61f9dc1748..e234c2e860f9 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -365,6 +365,8 @@ enum sec_def_flags {
> >         SEC_SLEEPABLE = 8,
> >         /* BPF program support non-linear XDP buffer */
> >         SEC_XDP_FRAGS = 16,
> > +       /* Setup proper attach type for usdt probes. */
> > +       SEC_USDT = 32,
> >  };
> >
> >  struct bpf_sec_def {
> > @@ -6807,6 +6809,10 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
> >         if (prog->type == BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
> >                 opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
> >
> > +       /* special check for usdt to use uprobe_multi link */
> > +       if ((def & SEC_USDT) && kernel_supports(NULL, FEAT_UPROBE_MULTI_LINK))
> 
> please pass prog->obj to kernel_supports(), it will be especially
> important later with BPF token stuff

did not realize I have it in prog->obj ;-) ok

> 
> > +               prog->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
> > +
> >         if ((def & SEC_ATTACH_BTF) && !prog->attach_btf_id) {
> >                 int btf_obj_fd = 0, btf_type_id = 0, err;
> >                 const char *attach_name;
> > @@ -6875,7 +6881,6 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
> >         if (!insns || !insns_cnt)
> >                 return -EINVAL;
> >
> > -       load_attr.expected_attach_type = prog->expected_attach_type;
> >         if (kernel_supports(obj, FEAT_PROG_NAME))
> >                 prog_name = prog->name;
> >         load_attr.attach_prog_fd = prog->attach_prog_fd;
> > @@ -6911,6 +6916,9 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
> >                 insns_cnt = prog->insns_cnt;
> >         }
> >
> > +       /* allow prog_prepare_load_fn to change expected_attach_type */
> > +       load_attr.expected_attach_type = prog->expected_attach_type;
> > +
> >         if (obj->gen_loader) {
> >                 bpf_gen__prog_load(obj->gen_loader, prog->type, prog->name,
> >                                    license, insns, insns_cnt, &load_attr,
> > @@ -8711,7 +8719,8 @@ static const struct bpf_sec_def section_defs[] = {
> >         SEC_DEF("uretprobe.multi.s+",   KPROBE, BPF_TRACE_UPROBE_MULTI, SEC_SLEEPABLE, attach_uprobe_multi),
> >         SEC_DEF("ksyscall+",            KPROBE, 0, SEC_NONE, attach_ksyscall),
> >         SEC_DEF("kretsyscall+",         KPROBE, 0, SEC_NONE, attach_ksyscall),
> > -       SEC_DEF("usdt+",                KPROBE, 0, SEC_NONE, attach_usdt),
> > +       SEC_DEF("usdt+",                KPROBE, 0, SEC_USDT, attach_usdt),
> > +       SEC_DEF("usdt.s+",              KPROBE, 0, SEC_USDT|SEC_SLEEPABLE, attach_usdt),
> 
> spaces around |

ook

> 
> >         SEC_DEF("tc",                   SCHED_CLS, 0, SEC_NONE),
> >         SEC_DEF("classifier",           SCHED_CLS, 0, SEC_NONE),
> >         SEC_DEF("action",               SCHED_ACT, 0, SEC_NONE),
> > diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> > index 9fa883ebc0bd..6ff66a8eaf85 100644
> > --- a/tools/lib/bpf/usdt.c
> > +++ b/tools/lib/bpf/usdt.c
> > @@ -809,6 +809,8 @@ struct bpf_link_usdt {
> >                 long abs_ip;
> >                 struct bpf_link *link;
> >         } *uprobes;
> > +
> > +       struct bpf_link *multi_link;
> >  };
> >
> >  static int bpf_link_usdt_detach(struct bpf_link *link)
> > @@ -817,6 +819,9 @@ static int bpf_link_usdt_detach(struct bpf_link *link)
> >         struct usdt_manager *man = usdt_link->usdt_man;
> >         int i;
> >
> > +       /* When having multi_link, uprobe_cnt is 0 */
> 
> misplaced comment, move down to for() loop?

right, will move

> 
> > +       bpf_link__destroy(usdt_link->multi_link);
> > +
> >         for (i = 0; i < usdt_link->uprobe_cnt; i++) {
> >                 /* detach underlying uprobe link */
> >                 bpf_link__destroy(usdt_link->uprobes[i].link);
> > @@ -944,11 +949,13 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
> >                                           const char *usdt_provider, const char *usdt_name,
> >                                           __u64 usdt_cookie)
> >  {
> > +       unsigned long *offsets = NULL, *ref_ctr_offsets = NULL;
> >         int i, err, spec_map_fd, ip_map_fd;
> >         LIBBPF_OPTS(bpf_uprobe_opts, opts);
> >         struct hashmap *specs_hash = NULL;
> >         struct bpf_link_usdt *link = NULL;
> >         struct usdt_target *targets = NULL;
> > +       __u64 *cookies = NULL;
> >         struct elf_fd elf_fd;
> >         size_t target_cnt;
> >
> > @@ -995,10 +1002,21 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
> >         link->link.detach = &bpf_link_usdt_detach;
> >         link->link.dealloc = &bpf_link_usdt_dealloc;
> >
> > -       link->uprobes = calloc(target_cnt, sizeof(*link->uprobes));
> > -       if (!link->uprobes) {
> > -               err = -ENOMEM;
> > -               goto err_out;
> > +       if (kernel_supports(NULL, FEAT_UPROBE_MULTI_LINK)) {
> 
> see how we feature-detect has_sema_refcnt and has_bpf_cookie, let's do
> the same with UPROBE_MULTI_LINK, detect once, remember, consistently
> use it (it also matters later for BPF token)

ok

> 
> > +               offsets = calloc(target_cnt, sizeof(*offsets));
> > +               cookies = calloc(target_cnt, sizeof(*cookies));
> > +               ref_ctr_offsets = calloc(target_cnt, sizeof(*ref_ctr_offsets));
> > +
> > +               if (!offsets || !ref_ctr_offsets || !cookies) {
> > +                       err = -ENOMEM;
> > +                       goto err_out;
> > +               }
> > +       } else {
> > +               link->uprobes = calloc(target_cnt, sizeof(*link->uprobes));
> > +               if (!link->uprobes) {
> > +                       err = -ENOMEM;
> > +                       goto err_out;
> > +               }
> >         }
> >
> >         for (i = 0; i < target_cnt; i++) {
> > @@ -1039,20 +1057,48 @@ struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct
> >                         goto err_out;
> >                 }
> >
> > -               opts.ref_ctr_offset = target->sema_off;
> > -               opts.bpf_cookie = man->has_bpf_cookie ? spec_id : 0;
> > -               uprobe_link = bpf_program__attach_uprobe_opts(prog, pid, path,
> > -                                                             target->rel_ip, &opts);
> > -               err = libbpf_get_error(uprobe_link);
> > +               if (kernel_supports(NULL, FEAT_UPROBE_MULTI_LINK)) {
> > +                       offsets[i] = target->rel_ip;
> > +                       ref_ctr_offsets[i] = target->sema_off;
> > +                       cookies[i] = spec_id;
> > +               } else {
> > +                       opts.ref_ctr_offset = target->sema_off;
> > +                       opts.bpf_cookie = man->has_bpf_cookie ? spec_id : 0;
> > +                       uprobe_link = bpf_program__attach_uprobe_opts(prog, pid, path,
> > +                                                                     target->rel_ip, &opts);
> > +                       err = libbpf_get_error(uprobe_link);
> > +                       if (err) {
> > +                               pr_warn("usdt: failed to attach uprobe #%d for '%s:%s' in '%s': %d\n",
> > +                                       i, usdt_provider, usdt_name, path, err);
> > +                               goto err_out;
> > +                       }
> > +
> > +                       link->uprobes[i].link = uprobe_link;
> > +                       link->uprobes[i].abs_ip = target->abs_ip;
> > +                       link->uprobe_cnt++;
> > +               }
> > +       }
> > +
> > +       if (kernel_supports(NULL, FEAT_UPROBE_MULTI_LINK)) {
> 
> same as above, we should feature-detect once per usdt_manager while we
> have associated bpf_object

ook

> 
> > +               LIBBPF_OPTS(bpf_uprobe_multi_opts, opts_multi,
> > +                       .cnt = target_cnt,
> > +                       .offsets = offsets,
> > +                       .ref_ctr_offsets = ref_ctr_offsets,
> > +                       .cookies = cookies,
> > +               );
> > +
> > +               link->multi_link = bpf_program__attach_uprobe_multi(prog, pid, path,
> > +                                                                   NULL, &opts_multi);
> > +               err = libbpf_get_error(link->multi_link);
> 
> let's not use libbpf_get_error() in new code, there is no need, just
> `err = -errno` and `if (!link->multi_link)`

ah right, did not see its comment that says it's no longer recomended,
will change

thanks,
jirka

