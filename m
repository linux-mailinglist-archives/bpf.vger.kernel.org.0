Return-Path: <bpf+bounces-8440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E454786513
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 04:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797771C20D94
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 02:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE40817F3;
	Thu, 24 Aug 2023 02:09:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D127F
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 02:09:55 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9540EE77
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 19:09:53 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe27849e6aso9615864e87.1
        for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 19:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692842992; x=1693447792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnbLozqhWrgRkpBc44Mw4uxFX1tiP09pZzD7yoYexOA=;
        b=pKrfVFyH/IGuf7SEs3nsoETAE35KMSkiOphTT4i31F8LNou+BtQBflFqNY8XCP+/D2
         Ao53awxGrUGvvgAijgjCZkEYQO2bIrq7t6sBqyCeGdPuYlPD7F5M+BFT7sZRGaL6HVGf
         vq43SpDPm3KP6wwRmbu8wElhndXCQ1ISVTntJGjQfGaVafiUA/i5pAmAyeT40YwhWW++
         uwf9IbWl6QhK3HOqb/XucfbUjfbJI1ZUM0EHAFIHhhmvumdNwwQE2uBMFFRv4nvvrpY7
         FLRh2Nrw6zBjzrOGJfQTYQLH7zm+hulZkODB9Q2TQHO1AEs3IgRT57m/idToi7kVjkMs
         bWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692842992; x=1693447792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnbLozqhWrgRkpBc44Mw4uxFX1tiP09pZzD7yoYexOA=;
        b=jAeTKJwobMss/x4roWEM2SqFHo58kbQW8BRPXVC8os7SfElAStwxrKSa3WrwMzeJ2l
         pvbsIMMyIf2sJapec8rheCiXgB0urRJ72zbQ7M1ItJEjoY1loasraMQcp3+AYHRu/dg7
         s01yi3dTAC1xHwXGJPFQoh2p9XeWJ0MEg3no1ZPTX9SGAzVXiPuruBIvRF6DLENyoAOH
         oy6ipFDcfqT9nvIcB+ARlt+C5HRbafjipMO4oB38mEardedEcB8a+k7UkORytnirjO+T
         BnnuVtpVPfEz+V+EdKrqFv1M7WIADOQ0bLriGtVIGKCyhMegCrf5VLY9tvA0hHXlmbrp
         2oJw==
X-Gm-Message-State: AOJu0YycEy9FibyHUgwC1Lb4L2G6NiP4bzaPJ6UitRCcx5lur8YrR2Uc
	wuaZC2FwzWzwWF1O2GltSxnSgo4bHoKdbfnJcSo=
X-Google-Smtp-Source: AGHT+IGrB4bj8baFc8zty5VrQdjaP4FBdtwdbmr87jwOWgJOjdwrjfEA0bQNYrO67Ow3+16oZQIZ8e1VPzk4UQV314c=
X-Received: by 2002:a2e:3001:0:b0:2bc:d567:bdbd with SMTP id
 w1-20020a2e3001000000b002bcd567bdbdmr4622614ljw.15.1692842991412; Wed, 23 Aug
 2023 19:09:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230821193311.3290257-1-davemarchevsky@fb.com>
 <20230821193311.3290257-4-davemarchevsky@fb.com> <01367775-1be4-a344-60d7-6b2b1e48b77e@linux.dev>
 <CAADnVQK-6A08+OCtOK20yRebBP_N1hKgfmHxtMgokM67LZrcEQ@mail.gmail.com>
 <71152843-d35d-4165-6410-0aa30a4c0f74@linux.dev> <CAADnVQKuAaYhd05XqXzwe=UuAXnV67UUc6MNWH5mgvLozTkSUw@mail.gmail.com>
In-Reply-To: <CAADnVQKuAaYhd05XqXzwe=UuAXnV67UUc6MNWH5mgvLozTkSUw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 23 Aug 2023 19:09:40 -0700
Message-ID: <CAADnVQKXSxYk5DM2LPYyqPn5Usr70S7EmpLNmv4cLG_8A0hiAw@mail.gmail.com>
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

On Wed, Aug 23, 2023 at 6:38=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Aug 23, 2023 at 1:29=E2=80=AFPM Yonghong Song <yonghong.song@linu=
x.dev> wrote:
> >
> >
> >
> > On 8/23/23 9:20 AM, Alexei Starovoitov wrote:
> > > On Tue, Aug 22, 2023 at 11:26=E2=80=AFPM Yonghong Song <yonghong.song=
@linux.dev> wrote:
> > >>
> > >>
> > >>
> > >> On 8/21/23 12:33 PM, Dave Marchevsky wrote:
> > >>> This is the final fix for the use-after-free scenario described in
> > >>> commit 7793fc3babe9 ("bpf: Make bpf_refcount_acquire fallible for
> > >>> non-owning refs"). That commit, by virtue of changing
> > >>> bpf_refcount_acquire's refcount_inc to a refcount_inc_not_zero, fix=
ed
> > >>> the "refcount incr on 0" splat. The not_zero check in
> > >>> refcount_inc_not_zero, though, still occurs on memory that could ha=
ve
> > >>> been free'd and reused, so the commit didn't properly fix the root
> > >>> cause.
> > >>>
> > >>> This patch actually fixes the issue by free'ing using the recently-=
added
> > >>> bpf_mem_free_rcu, which ensures that the memory is not reused until
> > >>> RCU grace period has elapsed. If that has happened then
> > >>> there are no non-owning references alive that point to the
> > >>> recently-free'd memory, so it can be safely reused.
> > >>>
> > >>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > >>> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > >>> ---
> > >>>    kernel/bpf/helpers.c | 6 +++++-
> > >>>    1 file changed, 5 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > >>> index eb91cae0612a..945a85e25ac5 100644
> > >>> --- a/kernel/bpf/helpers.c
> > >>> +++ b/kernel/bpf/helpers.c
> > >>> @@ -1913,7 +1913,11 @@ void __bpf_obj_drop_impl(void *p, const stru=
ct btf_record *rec)
> > >>>
> > >>>        if (rec)
> > >>>                bpf_obj_free_fields(rec, p);
> > >>
> > >> During reviewing my percpu kptr patch with link
> > >>
> > >> https://lore.kernel.org/bpf/20230814172809.1361446-1-yonghong.song@l=
inux.dev/T/#m2f7631b8047e9f5da60a0a9cd8717fceaf1adbb7
> > >> Kumar mentioned although percpu memory itself is freed under rcu.
> > >> But its record fields are freed immediately. This will cause
> > >> the problem since there may be some active uses of these fields
> > >> within rcu cs and after bpf_obj_free_fields(), some fields may
> > >> be re-initialized with new memory but they do not have chances
> > >> to free any more.
> > >>
> > >> Do we have problem here as well?
> > >
> > > I think it's not an issue here or in your percpu patch,
> > > since bpf_obj_free_fields() calls __bpf_obj_drop_impl() which will
> > > call bpf_mem_free_rcu() (after this patch set lands).
> >
> > The following is my understanding.
> >
> > void bpf_obj_free_fields(const struct btf_record *rec, void *obj)
> > {
> >          const struct btf_field *fields;
> >          int i;
> >
> >          if (IS_ERR_OR_NULL(rec))
> >                  return;
> >          fields =3D rec->fields;
> >          for (i =3D 0; i < rec->cnt; i++) {
> >                  struct btf_struct_meta *pointee_struct_meta;
> >                  const struct btf_field *field =3D &fields[i];
> >                  void *field_ptr =3D obj + field->offset;
> >                  void *xchgd_field;
> >
> >                  switch (fields[i].type) {
> >                  case BPF_SPIN_LOCK:
> >                          break;
> >                  case BPF_TIMER:
> >                          bpf_timer_cancel_and_free(field_ptr);
> >                          break;
> >                  case BPF_KPTR_UNREF:
> >                          WRITE_ONCE(*(u64 *)field_ptr, 0);
> >                          break;
> >                  case BPF_KPTR_REF:
> >                         ......
> >                          break;
> >                  case BPF_LIST_HEAD:
> >                          if (WARN_ON_ONCE(rec->spin_lock_off < 0))
> >                                  continue;
> >                          bpf_list_head_free(field, field_ptr, obj +
> > rec->spin_lock_off);
> >                          break;
> >                  case BPF_RB_ROOT:
> >                          if (WARN_ON_ONCE(rec->spin_lock_off < 0))
> >                                  continue;
> >                          bpf_rb_root_free(field, field_ptr, obj +
> > rec->spin_lock_off);
> >                          break;
> >                  case BPF_LIST_NODE:
> >                  case BPF_RB_NODE:
> >                  case BPF_REFCOUNT:
> >                          break;
> >                  default:
> >                          WARN_ON_ONCE(1);
> >                          continue;
> >                  }
> >          }
> > }
> >
> > For percpu kptr, the remaining possible actiionable fields are
> >         BPF_LIST_HEAD and BPF_RB_ROOT
> >
> > So BPF_LIST_HEAD and BPF_RB_ROOT will try to go through all
> > list/rb nodes to unlink them from the list_head/rb_root.
> >
> > So yes, rb_nodes and list nodes will call __bpf_obj_drop_impl().
> > Depending on whether the correspondingrec
> > with rb_node/list_node has ref count or not,
> > it may call bpf_mem_free() or bpf_mem_free_rcu(). If
> > bpf_mem_free() is called, then the field is immediately freed
> > but it may be used by some bpf prog (under rcu) concurrently,
> > could this be an issue?
>
> I see. Yeah. Looks like percpu makes such fields refcount-like.
> For non-percpu non-refcount only one bpf prog on one cpu can observe
> that object. That's why we're doing plain bpf_mem_free() for them.
>
> So this patch is a good fix for refcounted, but you and Kumar are
> correct that it's not sufficient for the case when percpu struct
> includes multiple rb_roots. One for each cpu.
>
> > Changing bpf_mem_free() in
> > __bpf_obj_drop_impl() to bpf_mem_free_rcu() should fix this problem.
>
> I guess we can do that when obj is either refcount or can be
> insider percpu, but it might not be enough. More below.
>
> > Another thing is related to list_head/rb_root.
> > During bpf_obj_free_fields(), is it possible that another cpu
> > may allocate a list_node/rb_node and add to list_head/rb_root?
>
> It's not an issue for the single owner case and for refcounted.
> Access to rb_root/list_head is always lock protected.
> For refcounted the obj needs to be acquired (from the verifier pov)
> meaning to have refcount =3D1 to be able to do spin_lock and
> operate on list_head.
>
> But bpf_rb_root_free is indeed an issue for percpu, since each
> percpu has its own rb root field with its own bpf_spinlock, but
> for_each_cpu() {bpf_obj_free_fields();} violates access contract.
>
> percpu and rb_root creates such a maze of dependencies that
> I think it's better to disallow rb_root-s and kptr-s inside percpu
> for now.
>
> > If this is true, then we might have a memory leak.
> > But I don't whether this is possible or not.
> >
> > I think local kptr has the issue as percpu kptr.
>
> Let's tackle one at a time.
> I still think Dave's patch set is a good fix for recounted,
> while we need to think more about percpu case.

I'm planning to land the series though there could be still bugs to fix.
At least they're fixing known issues.
Please yell if you think we have to wait for another release.

Like I think the following is needed regardless:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb78212fa5b2..efa6482b1c2c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7210,6 +7210,10 @@ static int process_spin_lock(struct
bpf_verifier_env *env, int regno,
                        map ? map->name : "kptr");
                return -EINVAL;
        }
+       if (type_is_non_owning_ref(reg->type)) {
+               verbose(env, "Accessing locks in non-owning object is
not allowed\n");
+               return -EINVAL;
+       }
        if (rec->spin_lock_off !=3D val + reg->off) {
                verbose(env, "off %lld doesn't point to 'struct
bpf_spin_lock' that is at %d\n",

atm I don't see where we enforce such.
Since refcounted non-own refs can have refcount=3D0 it's not safe to access
non-scalar objects inside them.
Maybe stronger enforcement is needed?

