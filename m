Return-Path: <bpf+bounces-4393-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C65D074A9D2
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 06:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02AA11C20F0B
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 04:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389151FCA;
	Fri,  7 Jul 2023 04:16:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD051876;
	Fri,  7 Jul 2023 04:16:27 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B46212D;
	Thu,  6 Jul 2023 21:16:25 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b6a16254a4so21207801fa.0;
        Thu, 06 Jul 2023 21:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688703384; x=1691295384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZU1/XzGT5BNrGN+0cqGYTVmy8izzN0m7W3Ws1LadGhQ=;
        b=bAwjhyyTQNvOuKwWh4bdYpB6JaM2PMDctxwy/xtDMtEFC1yr1oHGD27jUGjddnUBA9
         1BXNWB+8QjE60KjZQlcLam2+4/UTrH8SrRxAu6dng+c0DRtjK8yROuuv6WO4YiKOQDTl
         lk1rjcNEsa/KwDW26pwqgAOduJMYzwGs5nUWqa7ZNw6dfsOl81zFsZGDcf85Ho9gsDi9
         0fVOQExABiC5jeFYWQMG5bmiJjDolHqBrfSmQi9qopXmKM6Fo8Sipvcu/7qEexkrx/yq
         zN7OKrPXGmvTFvJKve12gec9dxMnWojdY2SAZd95+ceWq9xHTo1aG/k9LfQn6LS5cmhg
         fzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688703384; x=1691295384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZU1/XzGT5BNrGN+0cqGYTVmy8izzN0m7W3Ws1LadGhQ=;
        b=ZYY4RijqaqfXZoJeN/6HG2EHOcZeaeXDSd0QhfZbK7Hr39pZrDMOQS8hgk/FykUayC
         G+wDeN1lIbqWTNL48oxz/5RJf8AWQqIF2cU+jjSr/oKjF94Rxv3kml6VgiYrMvEKBjid
         CpbHuebZVTvW2dE6SWve/VpxKxIf8qp9B47oj4cDeCBUDWI/BdcM61RSh39C7Yj2GmdK
         YMFbQ27IAKx433WrnMDjrlVIrlSF0BNlETJMVIwG5DfipxibfhfQb7OpWmZceUJpN0fO
         KtupbtWYZsg1Ya8UwsHZGs0CjuV9ApxLkAK6KamgstlO1Cc9201s3MyHf/nyC51AK+8N
         IN2g==
X-Gm-Message-State: ABy/qLZSpfitGaOlubxXdbM4ohtbIr8W+n5sDQXV43xjK24btNQzMMWV
	JiEFRvlXo3IIElWxdidM5G0NqnADdJwTwVyBe3I=
X-Google-Smtp-Source: APBJJlERN3vlOORUB2Sm5msker+VlOm7G/Rg3lHVVtiBp1FPz/FV3N4JWldUHpVYmfyJP4HUQfwvh6oM5i4KbmpOEng=
X-Received: by 2002:a2e:2e17:0:b0:2b7:31a:9d7c with SMTP id
 u23-20020a2e2e17000000b002b7031a9d7cmr2676957lju.33.1688703383493; Thu, 06
 Jul 2023 21:16:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230706033447.54696-1-alexei.starovoitov@gmail.com>
 <20230706033447.54696-10-alexei.starovoitov@gmail.com> <fe733a7b-3775-947a-23c0-0dadacabdca2@huaweicloud.com>
 <CAADnVQJ3mNnzKEohRhYfAhBtB6R2Gh9dHAyqSJ5BU5ke+NTVuw@mail.gmail.com> <4e0765b7-9054-a33d-8b1e-c986df353848@huaweicloud.com>
In-Reply-To: <4e0765b7-9054-a33d-8b1e-c986df353848@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 6 Jul 2023 21:16:12 -0700
Message-ID: <CAADnVQJhrbTtuBfexE6NPA6q=cdh1vVxfVQ73ZR2u8ZZWRb+wA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 09/14] bpf: Allow reuse from
 waiting_for_gp_ttrace list.
To: Hou Tao <houtao@huaweicloud.com>
Cc: Tejun Heo <tj@kernel.org>, rcu@vger.kernel.org, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, David Vernet <void@manifault.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 6, 2023 at 8:39=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> Hi,
>
> On 7/7/2023 10:12 AM, Alexei Starovoitov wrote:
> > On Thu, Jul 6, 2023 at 7:07=E2=80=AFPM Hou Tao <houtao@huaweicloud.com>=
 wrote:
> >> Hi,
> >>
> >> On 7/6/2023 11:34 AM, Alexei Starovoitov wrote:
> >>> From: Alexei Starovoitov <ast@kernel.org>
> >>>
> >>> alloc_bulk() can reuse elements from free_by_rcu_ttrace.
> >>> Let it reuse from waiting_for_gp_ttrace as well to avoid unnecessary =
kmalloc().
> >>>
> >>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> >>> ---
> >>>  kernel/bpf/memalloc.c | 16 ++++++++++------
> >>>  1 file changed, 10 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> >>> index 9986c6b7df4d..e5a87f6cf2cc 100644
> >>> --- a/kernel/bpf/memalloc.c
> >>> +++ b/kernel/bpf/memalloc.c
> >>> @@ -212,6 +212,15 @@ static void alloc_bulk(struct bpf_mem_cache *c, =
int cnt, int node)
> >>>       if (i >=3D cnt)
> >>>               return;
> >>>
> >>> +     for (; i < cnt; i++) {
> >>> +             obj =3D llist_del_first(&c->waiting_for_gp_ttrace);
> >>> +             if (!obj)
> >>> +                     break;
> >>> +             add_obj_to_free_list(c, obj);
> >>> +     }
> >>> +     if (i >=3D cnt)
> >>> +             return;
> >> I still think using llist_del_first() here is not safe as reported in
> >> [1]. Not sure whether or not invoking enque_to_free() firstly for
> >> free_llist_extra will close the race completely. Will check later.
> > lol. see my reply a second ago in the other thread.
> >
> > and it's not just waiting_for_gp_ttrace. free_by_rcu_ttrace is similar.
>
> I think free_by_rcu_ttrace is different, because the reuse is only
> possible after one tasks trace RCU grace period as shown below, and the
> concurrent llist_del_first() must have been completed when the head is
> reused and re-added into free_by_rcu_ttrace again.
>
> // c0->free_by_rcu_ttrace
> A -> B -> C -> nil
>
> P1:
> alloc_bulk()
>     llist_del_first(&c->free_by_rcu_ttrace)
>         entry =3D A
>         next =3D B
>
> P2:
> do_call_rcu_ttrace()
>     // c->free_by_rcu_ttrace->first =3D NULL
>     llist_del_all(&c->free_by_rcu_ttrace)
>         move to c->waiting_for_gp_ttrace
>
> P1:
> llist_del_first()
>     return NULL
>
> // A is only reusable after one task trace RCU grace
> // llist_del_first() must have been completed

"must have been completed" ?

I guess you're assuming that alloc_bulk() from irq_work
is running within rcu_tasks_trace critical section,
so __free_rcu_tasks_trace() callback will execute after
irq work completed?
I don't think that's the case.
In vCPU P1 is stopped for looong time by host,
P2 can execute __free_rcu_tasks_trace (or P3, since
tasks trace callbacks execute in a kthread that is not bound
to any cpu).
__free_rcu_tasks_trace() will free it into slab.
Then kmalloc the same obj and eventually put it back into
free_by_rcu_ttrace.

Since you believe that waiting_for_gp_ttrace ABA is possible
here it's the same probability. imo both lower than a bit flip due
to cosmic rays which is actually observable in practice.

> __free_rcu_tasks_trace
>     free_all(llist_del_all(&c->waiting_for_gp_ttrace))
>
>

