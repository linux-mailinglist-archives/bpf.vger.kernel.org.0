Return-Path: <bpf+bounces-6730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD94B76D3C6
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 18:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12DEA1C2139D
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 16:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B42079CB;
	Wed,  2 Aug 2023 16:33:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EAF63D8
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 16:33:34 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6966C26B5
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 09:33:32 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9f48b6796so41369841fa.3
        for <bpf@vger.kernel.org>; Wed, 02 Aug 2023 09:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690994010; x=1691598810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQubRKv5sLMIVdyl63NSTIY5PJZsJuy6j4UtDcLwJiY=;
        b=U6PDDWdu4w7QbzjoAcRGcpaLYOfQwExIznPrVmziEWWxbsPfGYFMfkyyB1Q02XC7D8
         Ma68CWHP4ZR886T4q9GM9ya0upBGMCDNVyn3SoUyKgngQvobD2VXoCzw0qgQ6JCmD0Aj
         2CgNLAe8BStYqyAzz26Hu0x99xdVbJwn19h51Ndcb/249Q1ECwm0pZo67uQnTBbLVd0k
         7qHJpjwV4rIPTypA4uwwgGPY93nHus3SIk/yEA/DEgixtKvukyCWLmdJsgUoAkmhDZXl
         wLHkp8KO8a/PUUDCaG8h59rvvZZhD+PgL0eImBtXteh1a8/ieyl431fOfndyp5roz+In
         aeeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690994010; x=1691598810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RQubRKv5sLMIVdyl63NSTIY5PJZsJuy6j4UtDcLwJiY=;
        b=fkIKiRiOUAciSQYBBU+bNOaUUgiv3iUkbaPcRYwxDBZdfuiYosDC3y8ImJzEFv42mT
         W0xQASX6N2QW5UnhguTiBquro3bPNm3xDvAOMi0S/OJV6xclZ+MqaTvL6moX7i/lIMzb
         0Yy0wrGogWqcSHfBdBtAF+LFvcxNzJXC3Cvq8DVPDkzCZVP9m+RFdU8dIts46BVpJnha
         Ukk/XCHGwlZMHSHs49xaLzbB5ck7Caoe/1lyic9GzP6C1YyX5FLUcmx5KBmb4bIPm4ba
         8xkZ5fGWQ4mMSCPxaaTUUZpN9V8DsJyRDzjBvcMV0W/ORuyB6X9MIdzmJYRYuVYWo55Y
         DKrg==
X-Gm-Message-State: ABy/qLb3YRlR/56/eBU9/fXnmiYOL9YrJ69GuFVWKsLVk4zr3AYo8veE
	5Rd9C+m18KnonkCud/4o1SGvAIkbC3aTOjRg73m3lFVmH7c=
X-Google-Smtp-Source: APBJJlEEhZZmYpL1zAJkGJAxxTdM+RVZPj/1sKxi8KA2WgIv1rsvHIKqZF7/KW1tLtsDxBtG+FmBUAIER3TdlWwBofo=
X-Received: by 2002:a2e:870b:0:b0:2b6:eefc:3e4f with SMTP id
 m11-20020a2e870b000000b002b6eefc3e4fmr5466271lji.21.1690994009753; Wed, 02
 Aug 2023 09:33:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801142912.55078-1-laoar.shao@gmail.com> <3f56b3b3-9b71-f0d3-ace1-406a8eeb64c0@linux.dev>
 <CALOAHbAnyorNdYAp1FretQcqEp_j6mQ93ATwx02auLTYnL_0KQ@mail.gmail.com>
 <CAADnVQKwY+j6JrxJ4dc1M7yhkSf958ubSH=WB7dKmHt9Ac9gQQ@mail.gmail.com> <20230802032958.GB472124@maniforge>
In-Reply-To: <20230802032958.GB472124@maniforge>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 2 Aug 2023 09:33:18 -0700
Message-ID: <CAADnVQJnv5mC2=s1sQ8YKNj6gZXyXHeuNyaBJjk3D90VrM0iBw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: Add new bpf helper bpf_for_each_cpu
To: David Vernet <void@manifault.com>, Alan Maguire <alan.maguire@oracle.com>
Cc: Yafang Shao <laoar.shao@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 8:30=E2=80=AFPM David Vernet <void@manifault.com> wr=
ote:
> I agree that this is the correct way to generalize this. The only thing
> that we'll have to figure out is how to generalize treating const struct
> cpumask * objects as kptrs. In sched_ext [0] we export
> scx_bpf_get_idle_cpumask() and scx_bpf_get_idle_smtmask() kfuncs to
> return trusted global cpumask kptrs that can then be "released" in
> scx_bpf_put_idle_cpumask(). scx_bpf_put_idle_cpumask() is empty and
> exists only to appease the verifier that the trusted cpumask kptrs
> aren't being leaked and are having their references "dropped".

why is it KF_ACQUIRE ?
I think it can just return a trusted pointer without acquire.

> [0]: https://lore.kernel.org/all/20230711011412.100319-13-tj@kernel.org/
>
> I'd imagine that we have 2 ways forward if we want to enable progs to
> fetch other global cpumasks with static lifetimes (e.g.
> __cpu_possible_mask or nohz.idle_cpus_mask):
>
> 1. The most straightforward thing to do would be to add a new kfunc in
>    kernel/bpf/cpumask.c that's a drop-in replacment for
>    scx_bpf_put_idle_cpumask():
>
> void bpf_global_cpumask_drop(const struct cpumask *cpumask)
> {}
>
> 2. Another would be to implement something resembling what Yonghong
>    suggested in [1], where progs can link against global allocated kptrs
>    like:
>
> const struct cpumask *__cpu_possible_mask __ksym;
>
> [1]: https://lore.kernel.org/all/3f56b3b3-9b71-f0d3-ace1-406a8eeb64c0@lin=
ux.dev/#t
>
> In my opinion (1) is more straightforward, (2) is a better UX.

1 =3D adding few kfuncs.
2 =3D teaching pahole to emit certain global vars.

nm vmlinux|g -w D|g -v __SCK_|g -v __tracepoint_|wc -l
1998

imo BTF increase trade off is acceptable.

