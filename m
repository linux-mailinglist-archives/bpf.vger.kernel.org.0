Return-Path: <bpf+bounces-5178-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C0B758341
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 19:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94BF028122B
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 17:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9950513AE5;
	Tue, 18 Jul 2023 17:11:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F02DD50F
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 17:11:17 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D83BE;
	Tue, 18 Jul 2023 10:11:15 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fba03becc6so8901507e87.0;
        Tue, 18 Jul 2023 10:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689700274; x=1692292274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVKA/R97zzebU34rkfNx8z76K/WFnLH2X07BfD6WPMs=;
        b=BOtC+WP1SFtHT+WmFxJF9zR4yIkcldB/8sKTylrmacquvpPmbQu4PZgdvFqewQRkkE
         BNNZ82U0eeklf7NuiGc0xvN5335UTWvWzaVFbKUO20jj6ifht99jhHiIcIZAX5V2BW85
         IQa/fjW4c47+1m8VLFj/eKVUtIbfvuST5lILAxVNkoolo/BND9KtvwuShSj6b2Iumyj+
         QO11FzBdl05dl9eLaMAfU/NZLgVhlbLY+iKS0sDB5vBvk0PaAo8VtxCUZx6TfvaifBe7
         PMTcubT8K8wgx/2rNABGlR4T06zt8UTUXl7nEj1G1nbB3voldeCGci8ii5PkGy6kOcS6
         1z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689700274; x=1692292274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVKA/R97zzebU34rkfNx8z76K/WFnLH2X07BfD6WPMs=;
        b=kU5WKJdQaFZr31O+lja73tCkJ6rqxY8/Qf084pEJM5l56mVTt8v8KedUr6ohdD8JYX
         hfoOJ7FahQnNBVzm5lcSg1N5HVslGgeEWA8OogUHmYC7IoI72GSeHOPpVDbU4k0dxh0Z
         z884M2KvLoVkLuQ7FRYNdImhnuzEoLcoB5uNuOUcWL+grpfZYvuWlgESD6dDD6JKFRmg
         SJAd8Hi4+YQQ8FguMj7BoEgO1z5/ij15F026JctLbOhwYS/m1GBz3ciyAeS/2un17jLa
         0cZeWKii0YtfVjZ6J/GssmIJ/kB4qPAB/t77jDz83wNiT1M56eVJfudixEv5Jx886K3i
         iWAw==
X-Gm-Message-State: ABy/qLYrYCGqkb1VfFM/xxEN1cEmpX/sy0s0B4RjxBPxOG2EFgw92tA2
	+cUdtWHLJe48F9nwaitVj1LCrFM5awwo6kLpb9ljnkhScDg=
X-Google-Smtp-Source: APBJJlFfQE7c2arN2JS1eZ3c11S/q4JGLflpIB+lEVCAjsVAMOZONx08ifJIMYlthtcLRg4xh5ORmYSy4OQ6RL9UTIU=
X-Received: by 2002:a05:6512:3d1d:b0:4f6:56ca:36fc with SMTP id
 d29-20020a0565123d1d00b004f656ca36fcmr5205132lfv.6.1689700273810; Tue, 18 Jul
 2023 10:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
 <168960741686.34107.6330273416064011062.stgit@devnote2> <CAErzpmuvhrj0HhTpH2m-C-=pFV=Q_mxYC59Hw=dm0pqUvtPm0g@mail.gmail.com>
 <20230718194431.5653b1e89841e6abd9742ede@kernel.org> <20230718225606.926222723cdd8c2c37294e41@kernel.org>
In-Reply-To: <20230718225606.926222723cdd8c2c37294e41@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Jul 2023 10:11:01 -0700
Message-ID: <CAADnVQ+8PuT5tC4q1spefzzCZG9r1UszFv0jenK5+Ed+QNqtsw@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] bpf/btf: tracing: Move finding func-proto API and
 getting func-param API to BTF
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Donglin Peng <dolinux.peng@gmail.com>, linux-trace-kernel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 6:56=E2=80=AFAM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Tue, 18 Jul 2023 19:44:31 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > > >  static const struct btf_param *find_btf_func_param(const char *fun=
cname, s32 *nr,
> > > >                                                    bool tracepoint)
> > > >  {
> > > > +       struct btf *btf =3D traceprobe_get_btf();
> > >
> > > I found that traceprobe_get_btf() only returns the vmlinux's btf. But
> > > if the function is
> > > defined in a kernel module, we should get the module's btf.
> > >
> >
> > Good catch! That should be a separated fix (or improvement?)
> > I think it's better to use btf_get() and btf_put(), and pass btf via
> > traceprobe_parse_context.
>
> Hmm, it seems that there is no exposed API to get the module's btf.
> Should I use btf_idr and btf_idr_lock directly to find the corresponding
> btf? If there isn't yet, I will add it too.

There is bpf_find_btf_id.
Probably drop 'static' from it and use it.

