Return-Path: <bpf+bounces-8021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F300878001D
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 23:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062961C21033
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 21:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87CE1BB43;
	Thu, 17 Aug 2023 21:46:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB9419898
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 21:46:38 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF38E4F
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 14:46:36 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so4192051fa.2
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 14:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692308795; x=1692913595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4rRFbDf4udX0R7zfJLbUlJW7MNK3cAdhNsyvTtNtWY=;
        b=ciKKAp8Pk39ySWkiMwqbEE4a3uSLguiF06TMUCNHA0HK828ZZxhKMXS5Wvd1978lA4
         xULsc/UXi07IsoQaIVT4qMgx8YSvbavEZbtX8oM69Zo7B5ASF7owwHhWBE4GFOCPHGIP
         MamxVwrp+Nc/VAwlDmVsLhGYsMmqOMHacXw24enrPB12MPskKY5THr+Saznt2o8W4Zt0
         PGBPeLboN9Wavry0uYXsHvuEfSRlDuDpeJsOn/nlVMAFu6Uli4VrDdxR2vBbakjEewOj
         O6cOti1J5TAJ7JSB6W4QgoXfJRHEwcAopsNpESE74CqIZmJfE05L7JsV39yhkKzHMS6c
         Jv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692308795; x=1692913595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4rRFbDf4udX0R7zfJLbUlJW7MNK3cAdhNsyvTtNtWY=;
        b=laMLK9zg/sNY2o6ycBhag3NdRnF8U9p98ko3TXLVT2fxuuo625uVTvlmuVXryFciJx
         a+OgxFI0YaACtxZSIrDbJKyFdUz817Q9KXGSdWZ9wPd2+bD1eCMMCLaKqO4DPJGNM9Zc
         LZy/UjaI+yzr/H0QYhiqjqsotukT9pUlzPjELFX7EXII34SQBBsCssvz2Uo2YTKqGmfJ
         zDNI3LforMxFTmM/YGYjW05lGJmKZnnWJQb0Bms0pCG8CWCQy6sB/2LDye126MyKcuRB
         j38sLeRbVleEJa9V3n88OhEfGv4zF4TejA9HkOp68RJ9v30CkQ/wBGAIBMeTRsi8cycp
         3mWw==
X-Gm-Message-State: AOJu0Yyo/e8ydOhp1cv84+AgJckldbPBJTG5stirtZ5NM3zFJqAZptdt
	J6Dt9NMPVbHJn/OOkb2Xi/oHSoDVhPtjoCIupIyAM5TU
X-Google-Smtp-Source: AGHT+IFdMu886X6G+Cq26+P95P5mL0NU8AP7ZMZVVy0nO06w7T629Tskm21LFdM4k4tS+S24FigYpLMMezvGU7IPD5w=
X-Received: by 2002:a2e:88d6:0:b0:2b6:c2e4:a57a with SMTP id
 a22-20020a2e88d6000000b002b6c2e4a57amr388454ljk.38.1692308794775; Thu, 17 Aug
 2023 14:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230815174712.660956-1-thinker.li@gmail.com> <20230815174712.660956-5-thinker.li@gmail.com>
 <20230817012518.erfkm4tgdm3isnks@MacBook-Pro-8.local> <f903808f-13c3-c440-c720-2051fe6ec4fe@linux.dev>
In-Reply-To: <f903808f-13c3-c440-c720-2051fe6ec4fe@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 17 Aug 2023 14:46:23 -0700
Message-ID: <CAADnVQKpiJE1aJNS=OP7GF+M9fm5ipOfO6tbKo-6yjdZMJ6YxQ@mail.gmail.com>
Subject: Re: [RFC bpf-next v3 4/5] bpf: Add a new dynptr type for CGRUP_SOCKOPT.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>, 
	Kui-Feng Lee <thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 1:41=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 8/16/23 6:25 PM, Alexei Starovoitov wrote:
> > But I think we have to step back. Why do we need this whole thing in th=
e first place?
> > _why_  sockopt bpf progs needs to read and write user memory?
> >
> > Yes there is one page limit, but what is the use case to actually read =
and write
> > beyond that? iptables sockopt was mentioned, but I don't think bpf prog=
 can do
> > anything useful with iptables binary blobs. They are hard enough for ke=
rnel to parse.
>
> Usually the bpf prog is only interested in a very small number of optname=
s and
> no need to read the optval at all for most cases. The max size for our us=
e cases
> is 16 bytes. The kernel currently is kind of doing it the opposite and al=
ways
> assumes the bpf prog needing to use the optval, allocate kernel memory an=
d
> copy_from_user such that the non-sleepable bpf program can read/write it.
>
> The bpf prog usually checks the optname and then just returns for most ca=
ses:
>
> SEC("cgroup/getsockopt")
> int get_internal_sockopt(struct bpf_sockopt *ctx)
> {
>         if (ctx->optname !=3D MY_INTERNAL_SOCKOPT)
>                 return 1;
>
>         /* change the ctx->optval and return to user space ... */
> }
>
> When the optlen is > PAGE_SIZE, the kernel only allocates PAGE_SIZE memor=
y and
> copy the first PAGE_SIZE data from the user optval. We used to ask the bp=
f prog
> to explicitly set the optlen to 0 for > PAGE_SIZE case even it has not lo=
oked at
> the optval. Otherwise, the kernel used to conclude that the bpf prog had =
set an
> invalid optlen because optlen is larger than the optval_end - optval and
> returned -EFAULT incorrectly to the end-user.
>
> The bpf prog started doing this > PAGE_SIZE check and set optlen =3D 0 du=
e to an
> internal kernel PAGE_SIZE limitation:
>
> SEC("cgroup/getsockopt")
> int get_internal_sockopt(struct bpf_sockopt *ctx)
> {
>         if (ctx->optname !=3D MY_INTERNAL_SOCKOPT) {
>                 /* only do that for ctx->optlen > PAGE_SIZE.
>                  * otherwise, the following cgroup bpf prog will
>                  * not be able to use the optval that it may
>                  * be interested.
>                  */
>                 if (ctx->optlen > PAGE_SIZE)
>                         ctx->optlen =3D 0;
>                 return 1;
>         }
>
>         /* change the ctx->optval and return to user space ... */
> }
>
> The above has been worked around in commit 29ebbba7d461 ("bpf: Don't EFAU=
LT for
> {g,s}setsockopt with wrong optlen").
>
> Later, it was reported that an optname (NETLINK_LIST_MEMBERSHIPS) that th=
e
> kernel allows a user passing NULL optval and using the optlen returned by
> getsockopt to learn the buffer space required. The bpf prog then needs to=
 remove
> the optlen > PAGE_SIZE check and set optlen to 0 for _all_ optnames that =
it is
> not interested while risking the following cgroup prog may not be able to=
 use
> some of the optval:
>
> SEC("cgroup/getsockopt")
> int get_internal_sockopt(struct bpf_sockopt *ctx)
> {
>         if (ctx->optname !=3D MY_INTERNAL_SOCKOPT) {
>
>                 /* Do that for all optname that you are not interested.
>                  * The latter cgroup bpf will not be able to use the optv=
al.
>                  */
>                 ctx->optlen =3D 0;
>                 return 1;
>         }
>
>         /* chage the ctx->optval and return to user space ... */
> }
>
> The above case has been addressed in commit 00e74ae08638 ("bpf: Don't EFA=
ULT for
> getsockopt with optval=3DNULL").

Agree with all of the above.
Existing bpf sockopt interfaces was problematic,
but with these workarounds we fixed all known issues.

> To avoid other potential optname cases that may run into similar situatio=
n and
> requires the bpf prog work around it again like the above, it needs a way=
 to
> track whether a bpf prog has changed the optval in runtime. If it is not
> changed, use the result from the kernel set/getsockopt. If reading/writin=
g to
> optval is done through a kfunc, this can be tracked. The kfunc can also d=
irectly
> read/write the user memory in optval, avoid the pre-alloc kernel memory a=
nd the
> PAGE_SIZE limit but this is a minor point.

so I'm still not following what sleepable progs that can access everything
would help the existing situation.
I agree that sleepable bpf sockopt should be free from old mistakes,
but people might still write old-style non-sleeptable bpf sockopt and
might repeat the same mistakes.
I'm missing the value of the new interface. It's better, sure, but why?
Do we expect to rewrite existing sockopt progs in sleepable way?
It might not be easy due to sleepable limitations like maps and whatever el=
se.

