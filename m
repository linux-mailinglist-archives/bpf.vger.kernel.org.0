Return-Path: <bpf+bounces-8429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3968F7864B6
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 03:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3722813FF
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 01:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5176617CF;
	Thu, 24 Aug 2023 01:39:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1724C7F
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 01:39:08 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB491706
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 18:38:35 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bb8a12e819so96361551fa.1
        for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 18:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692841099; x=1693445899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bYTzxiFiBrr69HAQNxh90Sj/MvwRD7iAUtKsASt+IM=;
        b=H/GcpAnPtOX9vXhhPFjyHERXua+MyCef3jvbksZDNElDrvCRyxjwATsPbrWbhbnJUv
         hWhfSrsG8lCBGMFfpHoBt7cYau8YA111sUP7mF9B7ARa9kQOmy+FqHoS3ahWwrC9TS7Y
         E/lahcZKfpcDujT7HiyR35ooMWh8jeR++UVuPq0oKNWok4j8Mw1a/pSWCAOJBenj5+AZ
         NRGx0mJOdgIM5fBLtkdlnI25wZHgPj+CD81YdcpevItRdDlOZ2r4IPb2x4VOk3I0+wbV
         CWUnBoCstp7+pN7msnT4qmCdAruwfI9nDZr7sK1+5Jw3udnNxq4vWytqy2aaJ6Kykfd7
         zAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692841099; x=1693445899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6bYTzxiFiBrr69HAQNxh90Sj/MvwRD7iAUtKsASt+IM=;
        b=l77sDiBBvmGE6fQwxufRIX7Ca+H46ka9KlFSVgfWICoj8NcGZgTJdMxE8iiXkQQpj8
         8o3eDxK2en4eADjrlIDjaPNmw8WEcmRxnapZQeEZggwksPTCk2eAqscGk7ROjB5DeNBl
         y9wT++HJh1FuAIY4PUceykttbaTYmShKn8trbeyCiTvPzcvSR3d82q+4qJQsE3FCfsUw
         O9JHGw/ibhDAorYb4nMg0PJBl7HcRyt5lKpqCx86JJmc9iLWWbzpIuKdYOYfcOduS/s7
         OBv658PX+Ua3wlzAxqMJTftjWUh4ZdLJE+TTBsPEzbAYKbMrX9gC+oR95zxGgjjLYGDI
         Mqvg==
X-Gm-Message-State: AOJu0YzqwTLnK9f1SToDbDqx5bpQlWIIOHhdJ4gK0PVCO4KysMLwYz3f
	rzpLnmoa4sUtKMAkclBnLG2//8WK8WWnnyefmNI=
X-Google-Smtp-Source: AGHT+IGtpg2Q6UGEpQu9Kbm1lil1laVG2rZ46gcsYH66vTdv7oRwBlOt25J0y0Aq3jPwgZsRKNqzouDJ4llSN66v6p0=
X-Received: by 2002:a2e:9395:0:b0:2b9:ebbd:be6f with SMTP id
 g21-20020a2e9395000000b002b9ebbdbe6fmr11379072ljh.3.1692841099180; Wed, 23
 Aug 2023 18:38:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230821193311.3290257-1-davemarchevsky@fb.com>
 <20230821193311.3290257-4-davemarchevsky@fb.com> <01367775-1be4-a344-60d7-6b2b1e48b77e@linux.dev>
 <CAADnVQK-6A08+OCtOK20yRebBP_N1hKgfmHxtMgokM67LZrcEQ@mail.gmail.com> <71152843-d35d-4165-6410-0aa30a4c0f74@linux.dev>
In-Reply-To: <71152843-d35d-4165-6410-0aa30a4c0f74@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 23 Aug 2023 18:38:08 -0700
Message-ID: <CAADnVQKuAaYhd05XqXzwe=UuAXnV67UUc6MNWH5mgvLozTkSUw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/7] bpf: Use bpf_mem_free_rcu when
 bpf_obj_dropping refcounted nodes
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 23, 2023 at 1:29=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
>
> On 8/23/23 9:20 AM, Alexei Starovoitov wrote:
> > On Tue, Aug 22, 2023 at 11:26=E2=80=AFPM Yonghong Song <yonghong.song@l=
inux.dev> wrote:
> >>
> >>
> >>
> >> On 8/21/23 12:33 PM, Dave Marchevsky wrote:
> >>> This is the final fix for the use-after-free scenario described in
> >>> commit 7793fc3babe9 ("bpf: Make bpf_refcount_acquire fallible for
> >>> non-owning refs"). That commit, by virtue of changing
> >>> bpf_refcount_acquire's refcount_inc to a refcount_inc_not_zero, fixed
> >>> the "refcount incr on 0" splat. The not_zero check in
> >>> refcount_inc_not_zero, though, still occurs on memory that could have
> >>> been free'd and reused, so the commit didn't properly fix the root
> >>> cause.
> >>>
> >>> This patch actually fixes the issue by free'ing using the recently-ad=
ded
> >>> bpf_mem_free_rcu, which ensures that the memory is not reused until
> >>> RCU grace period has elapsed. If that has happened then
> >>> there are no non-owning references alive that point to the
> >>> recently-free'd memory, so it can be safely reused.
> >>>
> >>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> >>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> >>> ---
> >>>    kernel/bpf/helpers.c | 6 +++++-
> >>>    1 file changed, 5 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >>> index eb91cae0612a..945a85e25ac5 100644
> >>> --- a/kernel/bpf/helpers.c
> >>> +++ b/kernel/bpf/helpers.c
> >>> @@ -1913,7 +1913,11 @@ void __bpf_obj_drop_impl(void *p, const struct=
 btf_record *rec)
> >>>
> >>>        if (rec)
> >>>                bpf_obj_free_fields(rec, p);
> >>
> >> During reviewing my percpu kptr patch with link
> >>
> >> https://lore.kernel.org/bpf/20230814172809.1361446-1-yonghong.song@lin=
ux.dev/T/#m2f7631b8047e9f5da60a0a9cd8717fceaf1adbb7
> >> Kumar mentioned although percpu memory itself is freed under rcu.
> >> But its record fields are freed immediately. This will cause
> >> the problem since there may be some active uses of these fields
> >> within rcu cs and after bpf_obj_free_fields(), some fields may
> >> be re-initialized with new memory but they do not have chances
> >> to free any more.
> >>
> >> Do we have problem here as well?
> >
> > I think it's not an issue here or in your percpu patch,
> > since bpf_obj_free_fields() calls __bpf_obj_drop_impl() which will
> > call bpf_mem_free_rcu() (after this patch set lands).
>
> The following is my understanding.
>
> void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
> {
>          const struct btf_field *fields;
>          int i;
>
>          if (IS_ERR_OR_NULL(rec))
>                  return;
>          fields =3D rec->fields;
>          for (i =3D 0; i < rec->cnt; i++) {
>                  struct btf_struct_meta *pointee_struct_meta;
>                  const struct btf_field *field =3D &fields[i];
>                  void *field_ptr =3D obj + field->offset;
>                  void *xchgd_field;
>
>                  switch (fields[i].type) {
>                  case BPF_SPIN_LOCK:
>                          break;
>                  case BPF_TIMER:
>                          bpf_timer_cancel_and_free(field_ptr);
>                          break;
>                  case BPF_KPTR_UNREF:
>                          WRITE_ONCE(*(u64 *)field_ptr, 0);
>                          break;
>                  case BPF_KPTR_REF:
>                         ......
>                          break;
>                  case BPF_LIST_HEAD:
>                          if (WARN_ON_ONCE(rec->spin_lock_off < 0))
>                                  continue;
>                          bpf_list_head_free(field, field_ptr, obj +
> rec->spin_lock_off);
>                          break;
>                  case BPF_RB_ROOT:
>                          if (WARN_ON_ONCE(rec->spin_lock_off < 0))
>                                  continue;
>                          bpf_rb_root_free(field, field_ptr, obj +
> rec->spin_lock_off);
>                          break;
>                  case BPF_LIST_NODE:
>                  case BPF_RB_NODE:
>                  case BPF_REFCOUNT:
>                          break;
>                  default:
>                          WARN_ON_ONCE(1);
>                          continue;
>                  }
>          }
> }
>
> For percpu kptr, the remaining possible actiionable fields are
>         BPF_LIST_HEAD and BPF_RB_ROOT
>
> So BPF_LIST_HEAD and BPF_RB_ROOT will try to go through all
> list/rb nodes to unlink them from the list_head/rb_root.
>
> So yes, rb_nodes and list nodes will call __bpf_obj_drop_impl().
> Depending on whether the correspondingrec
> with rb_node/list_node has ref count or not,
> it may call bpf_mem_free() or bpf_mem_free_rcu(). If
> bpf_mem_free() is called, then the field is immediately freed
> but it may be used by some bpf prog (under rcu) concurrently,
> could this be an issue?

I see. Yeah. Looks like percpu makes such fields refcount-like.
For non-percpu non-refcount only one bpf prog on one cpu can observe
that object. That's why we're doing plain bpf_mem_free() for them.

So this patch is a good fix for refcounted, but you and Kumar are
correct that it's not sufficient for the case when percpu struct
includes multiple rb_roots. One for each cpu.

> Changing bpf_mem_free() in
> __bpf_obj_drop_impl() to bpf_mem_free_rcu() should fix this problem.

I guess we can do that when obj is either refcount or can be
insider percpu, but it might not be enough. More below.

> Another thing is related to list_head/rb_root.
> During bpf_obj_free_fields(), is it possible that another cpu
> may allocate a list_node/rb_node and add to list_head/rb_root?

It's not an issue for the single owner case and for refcounted.
Access to rb_root/list_head is always lock protected.
For refcounted the obj needs to be acquired (from the verifier pov)
meaning to have refcount =3D1 to be able to do spin_lock and
operate on list_head.

But bpf_rb_root_free is indeed an issue for percpu, since each
percpu has its own rb root field with its own bpf_spinlock, but
for_each_cpu() {bpf_obj_free_fields();} violates access contract.

percpu and rb_root creates such a maze of dependencies that
I think it's better to disallow rb_root-s and kptr-s inside percpu
for now.

> If this is true, then we might have a memory leak.
> But I don't whether this is possible or not.
>
> I think local kptr has the issue as percpu kptr.

Let's tackle one at a time.
I still think Dave's patch set is a good fix for recounted,
while we need to think more about percpu case.

