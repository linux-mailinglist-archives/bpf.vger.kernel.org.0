Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01388633297
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 03:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbiKVCDs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 21:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbiKVCDr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 21:03:47 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96D8C7213
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 18:03:45 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so12631177pjb.0
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 18:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mp4Ii2i4wLgPPa7F/R6ZcX3r3WMhUQy8EEaFZFK09Rg=;
        b=EbW2xB+Op0HAN87T9oG0Dy5NdZL7G+v13Em1BfBKXgAfbN0Fe2s94ymk7cR8Tpisa+
         w7vsSI3AyGDZmn4bu8HYcADmxlfEvHsFQ8faab8E4hXPbyxQO+zb8Bnx/45jcMSv/eYV
         n+uTxvgd4JMssqrurPFOniA9luErdrKH1Jd3H6BJRvkHof1N1uZQLK4oekjOxt2AlR+M
         hoJAplGN70aGomsmN5YAhOQRSt/wDDuvE0UlQeIMHY2VW/1v43Or6Q/PIm8xAiQZ41pR
         SIEHtAbG8ebF4oBfKiCMFpGTohJ2zwlhRk2SIjv7eWIZeLU+XEY15+pnylew3D2F5oQ4
         Ktlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mp4Ii2i4wLgPPa7F/R6ZcX3r3WMhUQy8EEaFZFK09Rg=;
        b=6lJ2qFF/3oJrq07Rm+hmlWX9WRmw3TEeXVmWHAQGDzRVDqxGZTmS3Y3Yhbn0Oqf2sb
         fHGGB5/2vslmMeJWVr97WK6Qth4K3Ox4jEWTpQQYQTXBgfIaRG04/tD4EX6ElgnMYAdO
         Sg4jDSKrlsA5dj7PYLjtP5cwog5f49G9YPj2UV4IBb5vMf7BEN38U+/61KHsjVxDxzeH
         qvfsU/haswpdtXoXkQLz6qCg5Wjfa1qp0qV/SyvVobXIS5RImBQL9eNx5Yyntvcvpkfj
         Tzd/K2h0TpjOcJnQpl+VyDaume5KtTNrPR1x4SBnhb530iW2QEhQ00h4Ty90cSXy3S83
         tg5g==
X-Gm-Message-State: ANoB5pmXrRveXt2p1P9j1TksB17qCmx5lViEv0EeBL/d0Wy7E3z+OnfY
        BiVBcnv+tLJXyam1IN3NCEM=
X-Google-Smtp-Source: AA0mqf68UsnWXS7jhsP0o0J78jUBuXs17aCsYG41cKILfVTNorgbpvCDRqXQUZJ+D3ArxVsVTtn66w==
X-Received: by 2002:a17:90a:a003:b0:214:1a8a:a415 with SMTP id q3-20020a17090aa00300b002141a8aa415mr23017087pjp.197.1669082625321;
        Mon, 21 Nov 2022 18:03:45 -0800 (PST)
Received: from localhost ([2605:59c8:6f:2810:f4d9:9612:b71b:8711])
        by smtp.gmail.com with ESMTPSA id n4-20020a170903110400b0017c19d7c89bsm10423012plh.269.2022.11.21.18.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 18:03:44 -0800 (PST)
Date:   Mon, 21 Nov 2022 18:03:42 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Yonghong Song <yhs@meta.com>,
        Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
Message-ID: <637c2dfe3277f_18ed920828@john.notmuch>
In-Reply-To: <8166d67a-de10-7c6a-c0c5-976fbac37a55@meta.com>
References: <20221121170515.1193967-1-yhs@fb.com>
 <20221121170530.1196341-1-yhs@fb.com>
 <ee7248b9-50ae-f4cf-5592-49634913b6ce@linux.dev>
 <7b09c839-ea51-fc8d-99b3-a32c94d175b9@meta.com>
 <1b1d17a5-8178-0cf8-21c3-b60c7f011942@linux.dev>
 <8166d67a-de10-7c6a-c0c5-976fbac37a55@meta.com>
Subject: Re: [PATCH bpf-next v7 3/4] bpf: Add kfunc bpf_rcu_read_lock/unlock()
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song wrote:
> =

> =

> On 11/21/22 2:56 PM, Martin KaFai Lau wrote:
> > On 11/21/22 12:01 PM, Yonghong Song wrote:
> >>
> >>
> >> On 11/21/22 11:41 AM, Martin KaFai Lau wrote:
> >>> On 11/21/22 9:05 AM, Yonghong Song wrote:
> >>>> @@ -4704,6 +4715,15 @@ static int check_ptr_to_btf_access(struct =

> >>>> bpf_verifier_env *env,
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EAC=
CES;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>> +=C2=A0=C2=A0=C2=A0 /* Access rcu protected memory */
> >>>> +=C2=A0=C2=A0=C2=A0 if ((reg->type & MEM_RCU) && env->prog->aux->s=
leepable &&
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !env->cur_state->activ=
e_rcu_lock) {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 verbose(env,
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "R%d is ptr_%s access rcu-protected memory with off=3D%d, =

> >>>> not rcu protected\n",
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 regno, tname, off);
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EACCES;
> >>>> +=C2=A0=C2=A0=C2=A0 }
> >>>> +
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (env->ops->btf_struct_access && =
!type_is_alloc(reg->type)) {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!btf_is=
_kernel(reg->btf)) {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 verbose(env, "verifier internal error: reg->btf must =

> >>>> be kernel btf\n");
> >>>> @@ -4731,12 +4751,27 @@ static int check_ptr_to_btf_access(struct =

> >>>> bpf_verifier_env *env,
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;=

> >>>> +=C2=A0=C2=A0=C2=A0 /* The value is a rcu pointer. The load needs =
to be in a rcu =

> >>>> lock region,
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * similar to rcu_dereference().
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> >>>> +=C2=A0=C2=A0=C2=A0 if ((flag & MEM_RCU) && env->prog->aux->sleepa=
ble && =

> >>>> !env->cur_state->active_rcu_lock) {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 verbose(env,
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "R%d is rcu dereference ptr_%s with off=3D%d, not in =

> >>>> rcu_read_lock region\n",
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 regno, tname, off);
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EACCES;
> >>>> +=C2=A0=C2=A0=C2=A0 }
> >>>
> >>> Would this make the existing rdonly use case fail?
> >>>
> >>> SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
> >>> int task_real_parent(void *ctx)
> >>> {
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct task_struct *task, *real_paren=
t;
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0task =3D bpf_get_current_task_btf();
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 real_parent =3D ta=
sk->real_parent;
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_printk("pid %u=
\n", real_parent->pid);
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> >>> }
> >>
> >> Right, it will fail. To fix the issue, user can do
> >> =C2=A0=C2=A0=C2=A0 bpf_rcu_read_lock();
> >> =C2=A0=C2=A0=C2=A0 real_parent =3D task->real_parent;
> >> =C2=A0=C2=A0=C2=A0 bpf_printk("pid %u\n", real_parent->pid);
> >> =C2=A0=C2=A0=C2=A0 bpf_rcu_read_unlock();
> >>
> >> But this raised a good question. How do we deal with
> >> legacy sleepable programs with newly-added rcu tagging
> >> capabilities.
> >>
> >> My current option is to error out if rcu usage is not right.
> >> But this might break existing sleepable programs.
> >>
> >> Another option intends to not break existing, like above,
> >> codes. In this case, MEM_RCU will not tagged if it is
> >> not inside bpf_rcu_read_lock() region.
> > =

> > hmm.... it is to make MEM_RCU to mean a reg is protected by the curre=
nt =

> > active_rcu_lock or not?
> =

> Yes, for example, in 'real_parent =3D task->real_parent' where
> 'real_parent' in task_struct is tagged with __rcu in the struct
> definition. So the 'real_parent' variable in the above assignment
> will be tagged with MEM_RCU.
> =

> > =

> >> In this case, the above non-rcu-protected code should work. And the
> >> following should work as well although it is a little
> >> bit awkward.
> >> =C2=A0=C2=A0=C2=A0 real_parent =3D task->real_parent; // real_parent=
 not tagged with rcu
> >> =C2=A0=C2=A0=C2=A0 bpf_rcu_read_lock();
> >> =C2=A0=C2=A0=C2=A0 bpf_printk("pid %u\n", real_parent->pid);
> >> =C2=A0=C2=A0=C2=A0 bpf_rcu_read_unlock();
> > =

> > I think it should be fine.=C2=A0 bpf_rcu_read_lock() just not useful =
in this =

> > example but nothing break or crash.=C2=A0 Also, after bpf_rcu_read_un=
lock(), =

> > real_parent will continue to be readable because the MEM_RCU is not s=
et?
> =

> That is correct. the variable real_parent is not tagged with MEM_RCU
> and it will stay that way for the rest of its life cycle.
> =

> With new PTR_TRUSTED mechanism, real_parent will be marked as normal
> PTR_TO_BTF_ID and it is not marked as PTR_UNTRUSTED for backward
> compatibility. So in the above code, real_parent->pid is just a normal
> load (not related to rcu/trusted/untrusted). People may think it
> is okay, but actually it does not okay. Verifier could add more state
> to issue proper warnings, but I am not sure whether it is worthwhile
> or not. As you mentioned, nothing breaks. It is just the current
> existing way. So we should be able to live with this.
> =

> > =

> > On top of the active_rcu_lock, should MEM_RCU be set only when it is =

> > dereferenced from a PTR_TRUSTED ptr (or with ref_obj_id !=3D 0)?
> =

> I didn't consider PTR_TRUSTED because it is just introduced yesterday..=
.
> =

> My current implementation inherits the old ptr_to_btf_id way where by
> default any ptr_to_btf_id is trusted. But since we have PTR_TRUSTED
> we should be able to use it for a stronger guarantee.
> =

> > I am thinking about the following more common case:
> > =

> >  =C2=A0=C2=A0=C2=A0=C2=A0/* bpf_get_current_task_btf() may need to be=
 changed
> >  =C2=A0=C2=A0=C2=A0=C2=A0 * to set PTR_TRUSTED at the retval?
> >  =C2=A0=C2=A0=C2=A0=C2=A0 */
> >  =C2=A0=C2=A0=C2=A0=C2=A0/* task: PTR_TO_BTF_ID | PTR_TRUSTED */
> >  =C2=A0=C2=A0=C2=A0=C2=A0task =3D bpf_get_current_task_btf();
> > =

> >  =C2=A0=C2=A0=C2=A0=C2=A0bpf_rcu_read_lock();
> > =

> >  =C2=A0=C2=A0=C2=A0=C2=A0/* real_parent: PTR_TO_BTF_ID | PTR_TRUSTED =
| MEM_RCU */
> >  =C2=A0=C2=A0=C2=A0=C2=A0real_parent =3D task->real_parent;
> > =

> >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* bpf_task_acquire() nee=
ds to change to use =

> > refcount_inc_not_zero */
> >  =C2=A0=C2=A0=C2=A0=C2=A0real_parent =3D bpf_task_acquire(real_parent=
);
> > =

> >  =C2=A0=C2=A0=C2=A0=C2=A0bpf_rcu_read_unlock();
> > =

> >  =C2=A0=C2=A0=C2=A0=C2=A0/* real_parent is accessible here (after che=
cking NULL) and
> >  =C2=A0=C2=A0=C2=A0=C2=A0 * can be passed to kfunc
> >  =C2=A0=C2=A0=C2=A0=C2=A0 */
> > =

> =

> Yes, the above is a typical use case. Or alternatively after
>      real_parent =3D task->real_parent;
>      /* use real_parent inside the bpf_rcu_read_lock() region */
> =

> I will try to utilize PTR_TRUSTED concept in the next revision.

Also perhaps interesting is when task is read out of a map
with reference already pinned. I think you should clear
the MEM_RCU tag on all referenced objects?
