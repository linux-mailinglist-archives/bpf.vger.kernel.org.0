Return-Path: <bpf+bounces-368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A67E770000C
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 07:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB672819FA
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 05:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F30111B;
	Fri, 12 May 2023 05:53:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBDAA2A
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 05:53:23 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6CB30E1;
	Thu, 11 May 2023 22:53:21 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50bc4ba28cbso16829188a12.0;
        Thu, 11 May 2023 22:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683870800; x=1686462800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxEocq0cfbYqCnvqhVYRjwnXYTxjRtW9m6JsKrCrFjQ=;
        b=brIEtQeiBhOcopDhT/dmPSOsg8BwWq0rrYoH3l62MzdBqpGWO1YOtQ252k+4PnaIH/
         RjuoYyyi+cqmj7otFmPpRIx//Oz8yLLfoBe9RwC6a8BnQ+KYG0CqElWKfLuMa6cHw0fG
         WEVRhrfiwTnxtNYxz3BBVC2/dE29DSmpdQwmL9pJm5qbXIVC+YQhX1D4KUngrIA9u1bK
         /nkwJ6459gqfHyhYrOFbQ16vrGtjnjgNFzLgLkVoRhRvRwb6o9q/R5882wOXRxPhnP+u
         Wg/OIsFjRfbL5r8Il93oFcpV9oYjpIWu5w3Ysptvk4jFMmprBh+T5B8zIKiU5HQxnXgN
         +j6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683870800; x=1686462800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxEocq0cfbYqCnvqhVYRjwnXYTxjRtW9m6JsKrCrFjQ=;
        b=ht9UYXWHNn5friLaUg4wbY25AsNbnEfVwOduo4QfhZZ9lLSNA/Pu7Lld9pIU5S+FVM
         kgpFy8eKtR/fqlW/HmU74l1oUXkjhFX9UpRV5bZSSQjBMFZUDrc2RYu4ZcdlRdpc499C
         fcHxVekctKAyuJNxI5VQrhinKJyaU+9zXdAqODhaatuLCgJZVdUoCXEEW5vkZDx1iHHx
         keUHiNmkSSBivkPyYsd0bXnYGNy294b9oGHvlShAaFucW+EXSD25e9Z5cnICtQUrRkuc
         McxLdAN37J36XzWfRfS5iRnaxgawoYnz+7mGMszquGJlGM0CgpMNdusRkoknRkaqGapt
         XliA==
X-Gm-Message-State: AC+VfDx2Km/VJ0DhtkIVQImnW133/ET6ztdgBMFN2bAjWccQaEYB200s
	Yttabku+b2AD7px1yDkL6sOOmPZj2fPA6+cZDI5cXKWU4f9xfQ==
X-Google-Smtp-Source: ACHHUZ4FynjIPPaRLICd8flpj3EVm6gbWqtiVTs85jGrlqaTN3rWa9GbkNK5KELWuXPd1X32nxP0j7kzOPHLSIIlAg4=
X-Received: by 2002:aa7:c546:0:b0:4be:b39b:ea8f with SMTP id
 s6-20020aa7c546000000b004beb39bea8fmr17653998edr.2.1683870799671; Thu, 11 May
 2023 22:53:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230510122045.2259-1-zegao@tencent.com> <6308b8e0-8a54-e574-a312-0a97cfbf810c@meta.com>
 <ZFvUH+p0ebcgnwEg@krava>
In-Reply-To: <ZFvUH+p0ebcgnwEg@krava>
From: Ze Gao <zegao2021@gmail.com>
Date: Fri, 12 May 2023 13:53:08 +0800
Message-ID: <CAD8CoPC_=d+Aocp8pnSi9cbU6HWBNc697bKUS1UydtB-4DFzrA@mail.gmail.com>
Subject: Re: [PATCH] bpf: reject blacklisted symbols in kprobe_multi to avoid
 recursive trap
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Yonghong Song <yhs@meta.com>, Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>, 
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

Yes, Jiri. Thanks for pointing it out. It's true that not all probe
blacklisted functions should be banned from bpf_kprobe.

I tried some of them, and all kprobe blacklisted symbols I hooked
works fine except preempt_count_{sub, add}.
so the takeaway here is preempt_cout_{sub, add} must be rejected at
least for now since kprobe_multi_link_prog_run
( i.e., the fprobe handler) and rethook_trampoline_handler( i.e. the
rethook handler) calls preempt_cout_{sub, add}.

I'm considering providing a general  fprobe_blacklist framework just
like what kprobe does to allow others to mark
functions used inside fprobe handler or rethook handler as NOFPROBE to
avoid potential stack recursion. But only after
I figure out how ftrace handles recursion problems currently and why
it fails in the case I ran into.

Thanks
Ze

On Thu, May 11, 2023 at 1:28=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, May 10, 2023 at 07:13:58AM -0700, Yonghong Song wrote:
> >
> >
> > On 5/10/23 5:20 AM, Ze Gao wrote:
> > > BPF_LINK_TYPE_KPROBE_MULTI attaches kprobe programs through fprobe,
> > > however it does not takes those kprobe blacklisted into consideration=
,
> > > which likely introduce recursive traps and blows up stacks.
> > >
> > > this patch adds simple check and remove those are in kprobe_blacklist
> > > from one fprobe during bpf_kprobe_multi_link_attach. And also
> > > check_kprobe_address_safe is open for more future checks.
> > >
> > > note that ftrace provides recursion detection mechanism, but for kpro=
be
> > > only, we can directly reject those cases early without turning to ftr=
ace.
> > >
> > > Signed-off-by: Ze Gao <zegao@tencent.com>
> > > ---
> > >   kernel/trace/bpf_trace.c | 37 +++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 37 insertions(+)
> > >
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index 9a050e36dc6c..44c68bc06bbd 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -2764,6 +2764,37 @@ static int get_modules_for_addrs(struct module=
 ***mods, unsigned long *addrs, u3
> > >     return arr.mods_cnt;
> > >   }
> > > +static inline int check_kprobe_address_safe(unsigned long addr)
> > > +{
> > > +   if (within_kprobe_blacklist(addr))
> > > +           return -EINVAL;
> > > +   else
> > > +           return 0;
> > > +}
> > > +
> > > +static int check_bpf_kprobe_addrs_safe(unsigned long *addrs, int num=
)
> > > +{
> > > +   int i, cnt;
> > > +   char symname[KSYM_NAME_LEN];
> > > +
> > > +   for (i =3D 0; i < num; ++i) {
> > > +           if (check_kprobe_address_safe((unsigned long)addrs[i])) {
> > > +                   lookup_symbol_name(addrs[i], symname);
> > > +                   pr_warn("bpf_kprobe: %s at %lx is blacklisted\n",=
 symname, addrs[i]);
> >
> > So user request cannot be fulfilled and a warning is issued and some
> > of user requests are discarded and the rest is proceeded. Does not
> > sound a good idea.
> >
> > Maybe we should do filtering in user space, e.g., in libbpf, check
> > /sys/kernel/debug/kprobes/blacklist and return error
> > earlier? bpftrace/libbpf-tools/bcc-tools all do filtering before
> > requesting kprobe in the kernel.
>
> also fprobe uses ftrace drectly without paths in kprobe, so I wonder
> some of the kprobe blacklisted functions are actually safe
>
> jirka
>
> >
> > > +                   /* mark blacklisted symbol for remove */
> > > +                   addrs[i] =3D 0;
> > > +           }
> > > +   }
> > > +
> > > +   /* remove blacklisted symbol from addrs */
> > > +   for (i =3D 0, cnt =3D 0; i < num; ++i) {
> > > +           if (addrs[i])
> > > +                   addrs[cnt++]  =3D addrs[i];
> > > +   }
> > > +
> > > +   return cnt;
> > > +}
> > > +
> > >   int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct=
 bpf_prog *prog)
> > >   {
> > >     struct bpf_kprobe_multi_link *link =3D NULL;
> > > @@ -2859,6 +2890,12 @@ int bpf_kprobe_multi_link_attach(const union b=
pf_attr *attr, struct bpf_prog *pr
> > >     else
> > >             link->fp.entry_handler =3D kprobe_multi_link_handler;
> > > +   cnt =3D check_bpf_kprobe_addrs_safe(addrs, cnt);
> > > +   if (!cnt) {
> > > +           err =3D -EINVAL;
> > > +           goto error;
> > > +   }
> > > +
> > >     link->addrs =3D addrs;
> > >     link->cookies =3D cookies;
> > >     link->cnt =3D cnt;

