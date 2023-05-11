Return-Path: <bpf+bounces-324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AC56FE95A
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 03:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7124B2815D1
	for <lists+bpf@lfdr.de>; Thu, 11 May 2023 01:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A97D645;
	Thu, 11 May 2023 01:24:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41804637
	for <bpf@vger.kernel.org>; Thu, 11 May 2023 01:24:33 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EC32D53;
	Wed, 10 May 2023 18:24:31 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-965cc5170bdso1169220366b.2;
        Wed, 10 May 2023 18:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683768269; x=1686360269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtbFuN3sw5A4xlLHEXKg8dMxvjNkGg9uDaGYFlhrrNs=;
        b=qKeuSu2RxQdE7VjMcmlq0GQ/pw2gqcPmLE/UYZNPn+0Odr6sflDM0sSuFhvOJNDZoh
         hj4QHy7ILYhaxgnrqLzBE8nCEjxcTe/kw87Ct1Y5PDfFNEYAgXcb0fLY+Wopza9jk3CA
         8R073JONi5Aa+SQDP7mIOrf54ad+ntuJuPiWc061E+7eu3pb/BE2qSCK9Z3AHEFJAmU3
         ro9Vc41AZmyZlo4K7/RcItWj/c57lwvLmqky7nJeFUFRfAnHmS4O2SkXXrTnkUdwwEZG
         8/Rhmtn525K6gl4mabg4At8CND8u9xt6e74HD8juzKlL2Naetas/o7bfYxRjzHUzhCrR
         lihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683768269; x=1686360269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VtbFuN3sw5A4xlLHEXKg8dMxvjNkGg9uDaGYFlhrrNs=;
        b=KtjRbbHPAboN8YwJG2lsUE4kGSaWrYAJC8+pImx5QhMjXyXRbpkEahXUQ//Zk9io2p
         Z7ZQtzDTMtfptfO5qDpPZ8b3BRvBweJrjns+PZtTY3edQh5V4X8atGeI7Lt7ZV/1FYdC
         0wuHVX4TY3DsaeS8B/xMA8ihZUfIi8QN5V2NnjFPmZqo8rHUrdMhgvkp3EudDOoc5tyP
         YIM5gJbL06jVaj6INPJhrTFifKZDfZGWHLEtkuMSE+V4rdMF5ALQb9ShwAYB0hEoGZro
         grBMnGP+xoEBpCu8hJE9m1QpSzewQyKdK/gv+xzS3hLxFau9NcXbLVsO2rRjSaRzJ/hU
         mtBg==
X-Gm-Message-State: AC+VfDwiI7+rPKshGumFMb2UZpIQ+75DKHKtVJxsnOvl3I7wb+CbB7zl
	oU8UO7cCG/Wn87Ok2ZHiQPmrmp2vFUfYVuXWk5Q=
X-Google-Smtp-Source: ACHHUZ5SVtkBkwVTkMpRgi9RzuNlJDHLpJkVBhBmwiO5o64zcubAk4+WUX160MQZpIt2vySGn2gi2h/rt2yUUdmWM/Y=
X-Received: by 2002:a17:907:97d2:b0:968:1102:1fb7 with SMTP id
 js18-20020a17090797d200b0096811021fb7mr11166653ejc.6.1683768269268; Wed, 10
 May 2023 18:24:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230510122045.2259-1-zegao@tencent.com> <6308b8e0-8a54-e574-a312-0a97cfbf810c@meta.com>
 <ZFvUH+p0ebcgnwEg@krava> <1195c4bd-ef54-2f1d-b079-2a11af42c62f@meta.com> <89159b33-3be4-487b-7647-0cbbd20c233d@meta.com>
In-Reply-To: <89159b33-3be4-487b-7647-0cbbd20c233d@meta.com>
From: Ze Gao <zegao2021@gmail.com>
Date: Thu, 11 May 2023 09:24:18 +0800
Message-ID: <CAD8CoPBzqih=0YxumRtywvSLs0aHwEbzpbehqKvpb18GzntVqA@mail.gmail.com>
Subject: Re: [PATCH] bpf: reject blacklisted symbols in kprobe_multi to avoid
 recursive trap
To: Yonghong Song <yhs@meta.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Song Liu <song@kernel.org>, 
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

Thank yonghong for your sage reviews.
Yes, this is an option I am also considering . I will try this out
later to see if works

But like you said it's not clear whether kprobe blacklist=3D=3D fprobe blac=
klist.
And also there are cases I need to investigate on, like how to avoid recurs=
ions
when kprobes and fprobes are mixed.

Rejecting symbols  kprobe_blacklisted is kinda brute-force yet a straight w=
ay to
avoid kernel crash AFAIK.

Ze

On Thu, May 11, 2023 at 7:54=E2=80=AFAM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 5/10/23 1:20 PM, Yonghong Song wrote:
> >
> >
> > On 5/10/23 10:27 AM, Jiri Olsa wrote:
> >> On Wed, May 10, 2023 at 07:13:58AM -0700, Yonghong Song wrote:
> >>>
> >>>
> >>> On 5/10/23 5:20 AM, Ze Gao wrote:
> >>>> BPF_LINK_TYPE_KPROBE_MULTI attaches kprobe programs through fprobe,
> >>>> however it does not takes those kprobe blacklisted into consideratio=
n,
> >>>> which likely introduce recursive traps and blows up stacks.
> >>>>
> >>>> this patch adds simple check and remove those are in kprobe_blacklis=
t
> >>>> from one fprobe during bpf_kprobe_multi_link_attach. And also
> >>>> check_kprobe_address_safe is open for more future checks.
> >>>>
> >>>> note that ftrace provides recursion detection mechanism, but for kpr=
obe
> >>>> only, we can directly reject those cases early without turning to
> >>>> ftrace.
> >>>>
> >>>> Signed-off-by: Ze Gao <zegao@tencent.com>
> >>>> ---
> >>>>    kernel/trace/bpf_trace.c | 37 +++++++++++++++++++++++++++++++++++=
++
> >>>>    1 file changed, 37 insertions(+)
> >>>>
> >>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> >>>> index 9a050e36dc6c..44c68bc06bbd 100644
> >>>> --- a/kernel/trace/bpf_trace.c
> >>>> +++ b/kernel/trace/bpf_trace.c
> >>>> @@ -2764,6 +2764,37 @@ static int get_modules_for_addrs(struct
> >>>> module ***mods, unsigned long *addrs, u3
> >>>>        return arr.mods_cnt;
> >>>>    }
> >>>> +static inline int check_kprobe_address_safe(unsigned long addr)
> >>>> +{
> >>>> +    if (within_kprobe_blacklist(addr))
> >>>> +        return -EINVAL;
> >>>> +    else
> >>>> +        return 0;
> >>>> +}
> >>>> +
> >>>> +static int check_bpf_kprobe_addrs_safe(unsigned long *addrs, int nu=
m)
> >>>> +{
> >>>> +    int i, cnt;
> >>>> +    char symname[KSYM_NAME_LEN];
> >>>> +
> >>>> +    for (i =3D 0; i < num; ++i) {
> >>>> +        if (check_kprobe_address_safe((unsigned long)addrs[i])) {
> >>>> +            lookup_symbol_name(addrs[i], symname);
> >>>> +            pr_warn("bpf_kprobe: %s at %lx is blacklisted\n",
> >>>> symname, addrs[i]);
> >>>
> >>> So user request cannot be fulfilled and a warning is issued and some
> >>> of user requests are discarded and the rest is proceeded. Does not
> >>> sound a good idea.
> >>>
> >>> Maybe we should do filtering in user space, e.g., in libbpf, check
> >>> /sys/kernel/debug/kprobes/blacklist and return error
> >>> earlier? bpftrace/libbpf-tools/bcc-tools all do filtering before
> >>> requesting kprobe in the kernel.
> >>
> >> also fprobe uses ftrace drectly without paths in kprobe, so I wonder
> >> some of the kprobe blacklisted functions are actually safe
> >
> > Could you give a pointer about 'some of the kprobe blacklisted
> > functions are actually safe'?
>
> Thanks Jiri for answering my question. it is not clear whether
> kprobe blacklist =3D=3D fprobe blacklist, probably not.
>
> You mentioned:
>    note that ftrace provides recursion detection mechanism,
>    but for kprobe only
> Maybe the right choice is to improve ftrace to provide recursion
> detection mechanism for fprobe as well?
>
> >
> >>
> >> jirka
> >>
> >>>
> >>>> +            /* mark blacklisted symbol for remove */
> >>>> +            addrs[i] =3D 0;
> >>>> +        }
> >>>> +    }
> >>>> +
> >>>> +    /* remove blacklisted symbol from addrs */
> >>>> +    for (i =3D 0, cnt =3D 0; i < num; ++i) {
> >>>> +        if (addrs[i])
> >>>> +            addrs[cnt++]  =3D addrs[i];
> >>>> +    }
> >>>> +
> >>>> +    return cnt;
> >>>> +}
> >>>> +
> >>>>    int bpf_kprobe_multi_link_attach(const union bpf_attr *attr,
> >>>> struct bpf_prog *prog)
> >>>>    {
> >>>>        struct bpf_kprobe_multi_link *link =3D NULL;
> >>>> @@ -2859,6 +2890,12 @@ int bpf_kprobe_multi_link_attach(const union
> >>>> bpf_attr *attr, struct bpf_prog *pr
> >>>>        else
> >>>>            link->fp.entry_handler =3D kprobe_multi_link_handler;
> >>>> +    cnt =3D check_bpf_kprobe_addrs_safe(addrs, cnt);
> >>>> +    if (!cnt) {
> >>>> +        err =3D -EINVAL;
> >>>> +        goto error;
> >>>> +    }
> >>>> +
> >>>>        link->addrs =3D addrs;
> >>>>        link->cookies =3D cookies;
> >>>>        link->cnt =3D cnt;

