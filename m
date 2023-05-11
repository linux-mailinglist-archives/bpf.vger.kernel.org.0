Return-Path: <bpf+bounces-321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC036FE909
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 03:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF39D281523
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 01:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEFD62C;
	Thu, 11 May 2023 01:06:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4155620
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 01:06:28 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397BF19AC;
	Wed, 10 May 2023 18:06:27 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc0117683so14213762a12.1;
        Wed, 10 May 2023 18:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683767185; x=1686359185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glQhUr96IfsYHdFFbknYKaga/6qXtKFb6tvCMxBk3bI=;
        b=sc5RqHZXAGh+0GPEjA7e5Umr/Wv2CyK86D5gpIn6akIs3LjuFpsb2gOVZ7xipRztxI
         GptfJZidIh+FMyQlRGOaIdYcBom8AvDpmtQvit/aCizulJBYjNBH6Z9XRfU2UAt9XxRV
         YDNgND/f7A4PMv7W17sw9svjWNMsG4Fq2Armr3CMCFa8y/abVPAwafcNCCFGZDkxbYO0
         CaTNPvfVyRFO/cLKT3m2ow0qVUS7/smyxUyhxcy05wdIJOIIPuHcDA2nhr2LhqFESxKZ
         ddR2athFDLNGunHxrtaKS/b+zTnfAAn45iiZwIJpWb1CA573M4Z+CykWMsx3o4FvJsAs
         sAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683767185; x=1686359185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=glQhUr96IfsYHdFFbknYKaga/6qXtKFb6tvCMxBk3bI=;
        b=O+GKOUXAHuJ0vRkfpRtX0nr5NRifWC/qbi+Aybamv7loH/2HdhSA85h9oH4cw058IA
         fyMqa7r2pSPbIMjGwpyK2BMYRcJythvam735ywN58EjqZCQmJh6ABuoo1B3Dqsj3hcg5
         zYGTc8TqFGEYyiHaENb13GZHbzOI9bvd6eknUsxrVnZPGrmcPqzt3Sz3o37ZN0/rC+h9
         bTxJeOCz7C/s0f2qV3/shZaxdNh+QItWITAs3k9DIJdI6RSxrUWT1ojTXaRKnJ45HNW6
         otJLT2aaJduiodOlyIdMeif2R1TuLLd5JtH0qPAvwxjPeWfH9SNvvk7HMEyaHbSRBZXw
         imVQ==
X-Gm-Message-State: AC+VfDyrkHb5qW+rPY0sYUSwiqoFAKjcGMjb0JhYzall4a/CUXI+E9D6
	24bsq7qzAUSIVwrkrHrbmHT09gnc3eJYTu9/j48=
X-Google-Smtp-Source: ACHHUZ7reF294ZQU8Bd4Si7YnIK4FJPGm29+TKFCT4USFn5MS3UXEP/7jJsVBWE9Q99VgXNvPdz5Wsv6r0YCgTt6Spo=
X-Received: by 2002:a05:6402:1a48:b0:50c:d5d:c960 with SMTP id
 bf8-20020a0564021a4800b0050c0d5dc960mr15858297edb.38.1683767185401; Wed, 10
 May 2023 18:06:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230510122045.2259-1-zegao@tencent.com> <6308b8e0-8a54-e574-a312-0a97cfbf810c@meta.com>
In-Reply-To: <6308b8e0-8a54-e574-a312-0a97cfbf810c@meta.com>
From: Ze Gao <zegao2021@gmail.com>
Date: Thu, 11 May 2023 09:06:14 +0800
Message-ID: <CAD8CoPBBipQWP0xT5unAshL93OtXLQox_rz0f7rfrGgy05UVJg@mail.gmail.com>
Subject: Re: [PATCH] bpf: reject blacklisted symbols in kprobe_multi to avoid
 recursive trap
To: Yonghong Song <yhs@meta.com>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Ze Gao <zegao@tencent.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I'm afraid filtering in user space tools is not enough, cause it's a kernel=
 BUG.

it would 100% trigger a kernel crash if you run cmd like

retsnoop -e 'pick_next_task_fair' -a ':kernel/sched/*.c' -vvv

which is caused by that BPF_LINK_TYPE_KPROBE_MULTI accidentally
attaches bpf progs
to preempt_count_{add, sub}, which in turn triggers stackoverflow
because the handler itself
calls those functions.

checking in libbpf is not enough if some tools use bpf syscall
directly, you know,
we can not cover all cases.

So kernel checking is a must, we cannot rely on users to not crash the kern=
el.

Thanks
Ze

On Wed, May 10, 2023 at 10:14=E2=80=AFPM Yonghong Song <yhs@meta.com> wrote=
:
>
>
>
> On 5/10/23 5:20 AM, Ze Gao wrote:
> > BPF_LINK_TYPE_KPROBE_MULTI attaches kprobe programs through fprobe,
> > however it does not takes those kprobe blacklisted into consideration,
> > which likely introduce recursive traps and blows up stacks.
> >
> > this patch adds simple check and remove those are in kprobe_blacklist
> > from one fprobe during bpf_kprobe_multi_link_attach. And also
> > check_kprobe_address_safe is open for more future checks.
> >
> > note that ftrace provides recursion detection mechanism, but for kprobe
> > only, we can directly reject those cases early without turning to ftrac=
e.
> >
> > Signed-off-by: Ze Gao <zegao@tencent.com>
> > ---
> >   kernel/trace/bpf_trace.c | 37 +++++++++++++++++++++++++++++++++++++
> >   1 file changed, 37 insertions(+)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 9a050e36dc6c..44c68bc06bbd 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2764,6 +2764,37 @@ static int get_modules_for_addrs(struct module *=
**mods, unsigned long *addrs, u3
> >       return arr.mods_cnt;
> >   }
> >
> > +static inline int check_kprobe_address_safe(unsigned long addr)
> > +{
> > +     if (within_kprobe_blacklist(addr))
> > +             return -EINVAL;
> > +     else
> > +             return 0;
> > +}
> > +
> > +static int check_bpf_kprobe_addrs_safe(unsigned long *addrs, int num)
> > +{
> > +     int i, cnt;
> > +     char symname[KSYM_NAME_LEN];
> > +
> > +     for (i =3D 0; i < num; ++i) {
> > +             if (check_kprobe_address_safe((unsigned long)addrs[i])) {
> > +                     lookup_symbol_name(addrs[i], symname);
> > +                     pr_warn("bpf_kprobe: %s at %lx is blacklisted\n",=
 symname, addrs[i]);
>
> So user request cannot be fulfilled and a warning is issued and some
> of user requests are discarded and the rest is proceeded. Does not
> sound a good idea.
>
> Maybe we should do filtering in user space, e.g., in libbpf, check
> /sys/kernel/debug/kprobes/blacklist and return error
> earlier? bpftrace/libbpf-tools/bcc-tools all do filtering before
> requesting kprobe in the kernel.
>
> > +                     /* mark blacklisted symbol for remove */
> > +                     addrs[i] =3D 0;
> > +             }
> > +     }
> > +
> > +     /* remove blacklisted symbol from addrs */
> > +     for (i =3D 0, cnt =3D 0; i < num; ++i) {
> > +             if (addrs[i])
> > +                     addrs[cnt++]  =3D addrs[i];
> > +     }
> > +
> > +     return cnt;
> > +}
> > +
> >   int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct b=
pf_prog *prog)
> >   {
> >       struct bpf_kprobe_multi_link *link =3D NULL;
> > @@ -2859,6 +2890,12 @@ int bpf_kprobe_multi_link_attach(const union bpf=
_attr *attr, struct bpf_prog *pr
> >       else
> >               link->fp.entry_handler =3D kprobe_multi_link_handler;
> >
> > +     cnt =3D check_bpf_kprobe_addrs_safe(addrs, cnt);
> > +     if (!cnt) {
> > +             err =3D -EINVAL;
> > +             goto error;
> > +     }
> > +
> >       link->addrs =3D addrs;
> >       link->cookies =3D cookies;
> >       link->cnt =3D cnt;

