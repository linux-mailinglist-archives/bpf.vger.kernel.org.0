Return-Path: <bpf+bounces-11142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EA57B3BF7
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 23:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 9A6B21C20A43
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 21:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEAA6728C;
	Fri, 29 Sep 2023 21:29:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B556669B
	for <bpf@vger.kernel.org>; Fri, 29 Sep 2023 21:29:23 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17EF1AB;
	Fri, 29 Sep 2023 14:29:21 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-533cbbd0153so15659975a12.0;
        Fri, 29 Sep 2023 14:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696022960; x=1696627760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ulc+lDz0cmLjLptsbHUWL0O/uVNoSf1Xc1Or5n5xvRo=;
        b=ZDR4Qq2pe40f0N34LNncp+9fMDtAh1Kxz3D1LbpJeLH8GEPtCRlp0hHfvess7gxAcx
         oPb5NFOuoaca3pW91SvI53x86/d7phv6sNCAJ9gkRlQNp36IIc9gbtaxDprBibpnf4Vm
         SQh209rtfNdbXJyKLhdP8rf50I22Yw40DfQWDC8lZ/LYn/ovW8myqkyW5nofSR1STujt
         Dxv/cWYnqNPX7WzHAUHzU3XV2/NyFeAbp1A4VjvgBwEAjzLMBVtBSzOYq/QWU4gGcDGX
         AE3eE5TUa4+Bdqof53vbEx+kPqGlxS/sLyPVg17e2TJd1axb6SVuuYRh8PwoJXEKQQdU
         qbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696022960; x=1696627760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ulc+lDz0cmLjLptsbHUWL0O/uVNoSf1Xc1Or5n5xvRo=;
        b=IgdhL2Fn2v6KIhEJjRRCaMvKloA/QdVGS30Oam+EGEeyrXuLXuuL/uoqTE4CJ3qtzd
         /sFRnK1cgq1uuApIrEno4ZjNOnFRsYNpp7XQePwixJsKNgrNEhk1aZKjVV2fwHxpXQju
         u1JpdC2Pma0HzXJUTw4X7gRqWv6Lf0fXWCyahIufnZbkU37kSwO6loUXxOL2IF+qOccQ
         0pndltEMXa2JWrbPiQep9+Rrer1QQ4Lj3ACJ/aX9VUg0CBUgudzIqI31hKTZ1Ikpe71t
         Bm3WeuixSYXmew7KfNRnqUR42jPHSnMp16mZVXqqggRT3YItkm5RkoZEVaecq2H1jjEM
         g7lQ==
X-Gm-Message-State: AOJu0YwFeERGoNkEf+PZlbeYPYR//5F0QQ5M4/mKrzBstWe7eGaMjj6j
	oE5rKXtK2JMEnSwFqOW8UUUbKLjT5/hCnmmZE5w=
X-Google-Smtp-Source: AGHT+IGlgptbueMHq7HzNbGa7p2NENix24xgxoIdRp14aXNwHNTx1rxfuqHRSLYlMCZxust4BW0Y2wD5VE2SKqePXtc=
X-Received: by 2002:aa7:d648:0:b0:534:2e79:6b04 with SMTP id
 v8-20020aa7d648000000b005342e796b04mr4794500edr.14.1696022960015; Fri, 29 Sep
 2023 14:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925105552.817513-1-zhouchuyi@bytedance.com>
 <20230925105552.817513-5-zhouchuyi@bytedance.com> <CAEf4BzbYgf1t8tfQJ4xwfDH-o_3n+PRMBgC4AZRLbXGM=QJtzQ@mail.gmail.com>
 <27b57638-48db-7082-2b53-93d84e423350@bytedance.com>
In-Reply-To: <27b57638-48db-7082-2b53-93d84e423350@bytedance.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 29 Sep 2023 14:29:08 -0700
Message-ID: <CAEf4Bza68mRn0KpOX2k7PtbXvO-uYzKHhQ=C8J+zyNS6WTFPpA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] bpf: Introduce css open-coded iterator kfuncs
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 7:51=E2=80=AFPM Chuyi Zhou <zhouchuyi@bytedance.com=
> wrote:
>
> Hello,
>
> =E5=9C=A8 2023/9/28 07:24, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Mon, Sep 25, 2023 at 3:56=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance=
.com> wrote:
> >>
> >> This Patch adds kfuncs bpf_iter_css_{new,next,destroy} which allow
> >> creation and manipulation of struct bpf_iter_css in open-coded iterato=
r
> >> style. These kfuncs actually wrapps css_next_descendant_{pre, post}.
> >> css_iter can be used to:
> >>
> >> 1) iterating a sepcific cgroup tree with pre/post/up order
> >>
> >> 2) iterating cgroup_subsystem in BPF Prog, like
> >> for_each_mem_cgroup_tree/cpuset_for_each_descendant_pre in kernel.
> >>
> >> The API design is consistent with cgroup_iter. bpf_iter_css_new accept=
s
> >> parameters defining iteration order and starting css. Here we also reu=
se
> >> BPF_CGROUP_ITER_DESCENDANTS_PRE, BPF_CGROUP_ITER_DESCENDANTS_POST,
> >> BPF_CGROUP_ITER_ANCESTORS_UP enums.
> >>
> >> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> >> ---
> >>   kernel/bpf/cgroup_iter.c                      | 57 +++++++++++++++++=
++
> >>   kernel/bpf/helpers.c                          |  3 +
> >>   .../testing/selftests/bpf/bpf_experimental.h  |  6 ++
> >>   3 files changed, 66 insertions(+)
> >>
> >> diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
> >> index 810378f04fbc..ebc3d9471f52 100644
> >> --- a/kernel/bpf/cgroup_iter.c
> >> +++ b/kernel/bpf/cgroup_iter.c
> >> @@ -294,3 +294,60 @@ static int __init bpf_cgroup_iter_init(void)
> >>   }
> >>
> >>   late_initcall(bpf_cgroup_iter_init);
> >> +
> >> +struct bpf_iter_css {
> >> +       __u64 __opaque[2];
> >> +       __u32 __opaque_int[1];
> >> +} __attribute__((aligned(8)));
> >> +
> >
> > same as before, __opaque[3] only
> >
> >
> >> +struct bpf_iter_css_kern {
> >> +       struct cgroup_subsys_state *start;
> >> +       struct cgroup_subsys_state *pos;
> >> +       int order;
> >> +} __attribute__((aligned(8)));
> >> +
> >> +__bpf_kfunc int bpf_iter_css_new(struct bpf_iter_css *it,
> >> +               struct cgroup_subsys_state *start, enum bpf_cgroup_ite=
r_order order)
> >
> > Similarly, I wonder if we should go for a more generic "flags" argument=
?
> >
> >> +{
> >> +       struct bpf_iter_css_kern *kit =3D (void *)it;
> >
> > empty line
> >
> >> +       kit->start =3D NULL;
> >> +       BUILD_BUG_ON(sizeof(struct bpf_iter_css_kern) !=3D sizeof(stru=
ct bpf_iter_css));
> >> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_css_kern) !=3D __alig=
nof__(struct bpf_iter_css));
> >
> > please move this up before kit->start assignment, and separate by empty=
 lines
> >
> >> +       switch (order) {
> >> +       case BPF_CGROUP_ITER_DESCENDANTS_PRE:
> >> +       case BPF_CGROUP_ITER_DESCENDANTS_POST:
> >> +       case BPF_CGROUP_ITER_ANCESTORS_UP:
> >> +               break;
> >> +       default:
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       kit->start =3D start;
> >> +       kit->pos =3D NULL;
> >> +       kit->order =3D order;
> >> +       return 0;
> >> +}
> >> +
> >> +__bpf_kfunc struct cgroup_subsys_state *bpf_iter_css_next(struct bpf_=
iter_css *it)
> >> +{
> >> +       struct bpf_iter_css_kern *kit =3D (void *)it;
> >
> > empty line
> >
> >> +       if (!kit->start)
> >> +               return NULL;
> >> +
> >> +       switch (kit->order) {
> >> +       case BPF_CGROUP_ITER_DESCENDANTS_PRE:
> >> +               kit->pos =3D css_next_descendant_pre(kit->pos, kit->st=
art);
> >> +               break;
> >> +       case BPF_CGROUP_ITER_DESCENDANTS_POST:
> >> +               kit->pos =3D css_next_descendant_post(kit->pos, kit->s=
tart);
> >> +               break;
> >> +       default:
> >
> > we know it's BPF_CGROUP_ITER_ANCESTORS_UP, so why not have that here ex=
plicitly?
> >
> >> +               kit->pos =3D kit->pos ? kit->pos->parent : kit->start;
> >> +       }
> >> +
> >> +       return kit->pos;
> >
> > wouldn't this implementation never return the "start" css? is that inte=
ntional?
> >
>
> Thanks for the review.
>
> This implementation actually would return the "start" css.
>
> 1. BPF_CGROUP_ITER_DESCENDANTS_PRE:
> 1.1 when we first call next(), css_next_descendant_pre(NULL, kit->start)
> will return kit->start.
> 1.2 second call next(), css_next_descendant_pre(kit->start, kit->start)
> would return a first valid child under kit->start with pre-order
> 1.3 third call next, css_next_descendant_pre(last_valid_child,
> kit->start) would return the next valid child
> ...
> util css_next_descendant_pre return a NULL pointer, which means we have
> visited all valid child including "start" css itself.
>
> The above logic is equal to macro 'css_for_each_descendant_pre' in kernel=
.
>
> Same, BPF_CGROUP_ITER_DESCENDANTS_POST is equal to macro
> 'css_for_each_descendant_post' which would return 'start' css when we
> have visited all valid child.
>
> 2. BPF_CGROUP_ITER_ANCESTORS_UP
> 2.1 when we fisrt call next(), kit->pos is NULL, and we would return
> kit->start.
>
>
> The selftest in patch7 whould check:
> 1. when we use BPF_CGROUP_ITER_DESCENDANTS_PRE to iterate a cgroup tree,
> the first cgroup we visted should be root('start') cgroup.
> 2. when we use BPF_CGROUP_ITER_DESCENDANTS_POST to iterate a cgroup
> tree, the last cgroup we visited should be root('start') cgroup.
>
>
> Am I miss something important?
>

No, again, my bad, I didn't trace the logic completely before asking.
All makes sense with kit->pos being initialized to NULL. Thanks for
elaborating!

>
> Thanks.
>
>
>

