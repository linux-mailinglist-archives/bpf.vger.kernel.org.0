Return-Path: <bpf+bounces-6737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A5876D69B
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 20:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6795728140C
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 18:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298C5101D5;
	Wed,  2 Aug 2023 18:13:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003A6FC07
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 18:13:50 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301761724
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 11:13:49 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so1065411fa.2
        for <bpf@vger.kernel.org>; Wed, 02 Aug 2023 11:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691000027; x=1691604827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VHEJHHxrrAkpr3avWJDjq+GrOzUodJsVOnubASiVFhM=;
        b=hEshYt+TUQlyCZ7lMaZge1dQDWm73QcUN1r5JY4XXt1ZuAMzdZ5RMX6jeitnCrW6Kv
         kDKlaJncamDfr+ybarMSTL6OnEPErSg/Ctw1/Ak/oV3dtlYgMqtGJYMe1Il6P5c0U274
         UV9Fv9OozH1pPsiESru4tXaLqwpwD6olv5VDbhgZ78eOfOk4Ll1ulZOcHbqCCK4BLuSu
         0fDylT6g83NN4ApW9AQQABgQb0x5NisXdfIuAnJRMwYJh8R00QU+g9IaxmgiupBmfjF+
         L/Mt0OoRGVuDYdfYcKmijkY/hKjTsjgbWMKpLJP2ZcU+b+ffBUIo3TlJM8fyMKVMS2eZ
         Yv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691000027; x=1691604827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHEJHHxrrAkpr3avWJDjq+GrOzUodJsVOnubASiVFhM=;
        b=DnG5kyb+U4wJYiZUHjqqi8NxHvYnf/S3eM6EJiMACBCy9m8n6rVQnpMgUvqGUw+iVG
         9lj4fbrnOyV0LrI9+2YTgCfZZ6tK7h3SRenfhUBWjkgLK9+J4iEIyRzlZTBElExJinKi
         bBd+eG+qTzOrHPAHGrsKVHj0Ge1zbNlW6sUhoGhiq5gPpwvQ8h6S/LpEyz/HPez0/XfR
         KBmVP525aOLi2EFJ2abtCtk4uaOFBYuq+6ughVs6RDkvyKkCMXfh2SqKEFzHKeQQ34dY
         K2sYr6VutiXcg+TPAVmitU0SzSO0wRFJi06XqqvWiwUDliOnV0HIk0ykHsmizU2VaB9f
         rmTw==
X-Gm-Message-State: ABy/qLY2L2Nee38J3zU2HnbpXg//l7eBmRvHo+8Ca/LgyAXvhysMx4Vz
	hBrPu62Sp8dCwMDmoGDMqFOzBhYPymQPv9ZA07s=
X-Google-Smtp-Source: APBJJlF3rYO2Zf6octldQ0JELaOFs99ndM71kCCi5BzZ3CS3E7JfblVmpxqxs6+jxrJ+aHwqqlS9dVP+q5q4NnCUySs=
X-Received: by 2002:a2e:9b09:0:b0:2b9:b9c8:99 with SMTP id u9-20020a2e9b09000000b002b9b9c80099mr5843845lji.22.1691000027040;
 Wed, 02 Aug 2023 11:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801142912.55078-1-laoar.shao@gmail.com> <3f56b3b3-9b71-f0d3-ace1-406a8eeb64c0@linux.dev>
 <CALOAHbAnyorNdYAp1FretQcqEp_j6mQ93ATwx02auLTYnL_0KQ@mail.gmail.com>
 <CAADnVQKwY+j6JrxJ4dc1M7yhkSf958ubSH=WB7dKmHt9Ac9gQQ@mail.gmail.com>
 <20230802032958.GB472124@maniforge> <CAADnVQJnv5mC2=s1sQ8YKNj6gZXyXHeuNyaBJjk3D90VrM0iBw@mail.gmail.com>
 <20230802170618.GE472124@maniforge>
In-Reply-To: <20230802170618.GE472124@maniforge>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 2 Aug 2023 11:13:35 -0700
Message-ID: <CAADnVQLo6LUJ_N0VdWHx+yg4ipns1VgFtfTF1bB_-Qi9_i6V8A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: Add new bpf helper bpf_for_each_cpu
To: David Vernet <void@manifault.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 2, 2023 at 10:06=E2=80=AFAM David Vernet <void@manifault.com> w=
rote:
>
> On Wed, Aug 02, 2023 at 09:33:18AM -0700, Alexei Starovoitov wrote:
> > On Tue, Aug 1, 2023 at 8:30=E2=80=AFPM David Vernet <void@manifault.com=
> wrote:
> > > I agree that this is the correct way to generalize this. The only thi=
ng
> > > that we'll have to figure out is how to generalize treating const str=
uct
> > > cpumask * objects as kptrs. In sched_ext [0] we export
> > > scx_bpf_get_idle_cpumask() and scx_bpf_get_idle_smtmask() kfuncs to
> > > return trusted global cpumask kptrs that can then be "released" in
> > > scx_bpf_put_idle_cpumask(). scx_bpf_put_idle_cpumask() is empty and
> > > exists only to appease the verifier that the trusted cpumask kptrs
> > > aren't being leaked and are having their references "dropped".
> >
> > why is it KF_ACQUIRE ?
> > I think it can just return a trusted pointer without acquire.
>
> I don't think there's a way to do this yet without hard-coding the kfuncs=
 as
> special, right? That's why we do stuff like this:
>
>
> 11479                 } else if (meta.func_id =3D=3D special_kfunc_list[K=
F_bpf_cast_to_kern_ctx]) {
> 11480                         mark_reg_known_zero(env, regs, BPF_REG_0);
> 11481                         regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | PT=
R_TRUSTED;
> 11482                         regs[BPF_REG_0].btf =3D desc_btf;
> 11483                         regs[BPF_REG_0].btf_id =3D meta.ret_btf_id;
>
> We could continue to do that, but I wonder if it would be useful to add
> a kfunc flag that allowed a kfunc to specify that? Something like
> KF_ALWAYS_TRUSTED? In general though, yes, we can teach the verifier to
> not require KF_ACQUIRE if we want. It's just that what we have now
> doesn't really scale to the kernel for any global cpumask.

We should probably just do this:
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e7b1af016841..f0c3f69ee5a8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11567,7 +11567,7 @@ static int check_kfunc_call(struct
bpf_verifier_env *env, struct bpf_insn *insn,
                } else {
                        mark_reg_known_zero(env, regs, BPF_REG_0);
                        regs[BPF_REG_0].btf =3D desc_btf;
-                       regs[BPF_REG_0].type =3D PTR_TO_BTF_ID;
+                       regs[BPF_REG_0].type =3D PTR_TO_BTF_ID | PTR_TRUSTE=
D;
                        regs[BPF_REG_0].btf_id =3D ptr_type_id;

A quick audit for kfuncs shows that this code is never used.
Everywhere where ptr_to_btf is returned the kfunc is maked with KF_ACQUIRE.
We'd need to have careful code review to make sure future kfuncs
return trusted pointers.
That would simplify scx_bpf_get_idle_cpumask(). No need for get and nop put=
.

