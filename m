Return-Path: <bpf+bounces-5198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 198B17588EE
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 01:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C729628173C
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 23:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516BF17AC6;
	Tue, 18 Jul 2023 23:13:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B6F51D
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 23:13:12 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45849ED;
	Tue, 18 Jul 2023 16:13:09 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b743161832so96829141fa.1;
        Tue, 18 Jul 2023 16:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689721987; x=1692313987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NQfBVXDdJBauiDRZhAmRRYJqr7LclnAThyEWYFadCc=;
        b=b1A78LJBt6GeKcjIel5xGf2nrJ1kcal3jaIcMyCrNrFBd2QzaFoaGdEx4XMZDf8En5
         dN2BByGDzYfgOY83IL1Uz9WOibbRkj97iSZWD1XUW6xJtNgUNeIAx76gTF5IFKUIaMGz
         cA6f1HYXlQsqCf2T911C8g3U0dC/W8ym7c8m6UqsNVP2QBJyMtU0k0MkQS3QFnbx1svE
         tpO3azyX8V297OnfaGCEu+S42Ad4DgZsihGwLSjO24FfQpWWNy0nG/TbEWLLY6OtqOD+
         nidrtbDAUuKO9hTYzR3WIvP4jtViOxbrCj3j2Ylruk+6Tqwn6P1D8GsvEoAnq9ZRg7Zu
         okPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689721987; x=1692313987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NQfBVXDdJBauiDRZhAmRRYJqr7LclnAThyEWYFadCc=;
        b=JPBF2zS+2VSavuWS7uITPFqthnrt1GsReO4CXDaH4CGjJU8781lTv3KH0f55SNb+p/
         57Gm+JvnwbZYSaNChA+yVuaQU/F8HH+DddBGyzKQ+uDLpl5PeoXp+rPmG7WU1S2pLzOi
         TzPTGef9XMmaHvcikpf8sofBbmNHZ3lhkTNd6jOyx6G9BmbCfwBK4fb7MXlgTamR8SjQ
         DI7xxjrlZoy5j/4uyG5aUhW42PMUATPU/9WKGqWR31NHC/qXbVJ9aGZr3ZtcQr9jKt7Z
         0ZanuCJaervtw/bWO8ED0mU5k5kgCDFH3DK0Vt8hHUUe1549uK2GVLhwaXqh5HXVw3CG
         elQQ==
X-Gm-Message-State: ABy/qLbmGBNqyXdQ19Mt6AriTa88YJgg0MexsXGx2geRwSgd4vvStpf3
	doS/p5RtTSKa4zxoUSlhkdCLKocBPLAlLDNiZs8=
X-Google-Smtp-Source: APBJJlHcskr7dGBo1hyJ2V2TgmSn/6riRb+xxRHJkjhaiOubd2mRACSAjhQFk4IeQdNS9z8xoJn+GoOhScojrsO1bZ4=
X-Received: by 2002:a2e:7403:0:b0:2b6:fa71:5bae with SMTP id
 p3-20020a2e7403000000b002b6fa715baemr507830ljc.12.1689721987346; Tue, 18 Jul
 2023 16:13:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
 <168960741686.34107.6330273416064011062.stgit@devnote2> <CAErzpmuvhrj0HhTpH2m-C-=pFV=Q_mxYC59Hw=dm0pqUvtPm0g@mail.gmail.com>
 <20230718194431.5653b1e89841e6abd9742ede@kernel.org> <20230718225606.926222723cdd8c2c37294e41@kernel.org>
 <CAADnVQ+8PuT5tC4q1spefzzCZG9r1UszFv0jenK5+Ed+QNqtsw@mail.gmail.com> <20230719080337.0955a6e77d799daad4c44350@kernel.org>
In-Reply-To: <20230719080337.0955a6e77d799daad4c44350@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 18 Jul 2023 16:12:55 -0700
Message-ID: <CAADnVQJNk=3nKk=1U4iGEQ7jQQD4xhObsEthESsMXiLt8Jz0fA@mail.gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 18, 2023 at 4:03=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Tue, 18 Jul 2023 10:11:01 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > On Tue, Jul 18, 2023 at 6:56=E2=80=AFAM Masami Hiramatsu <mhiramat@kern=
el.org> wrote:
> > >
> > > On Tue, 18 Jul 2023 19:44:31 +0900
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > >
> > > > > >  static const struct btf_param *find_btf_func_param(const char =
*funcname, s32 *nr,
> > > > > >                                                    bool tracepo=
int)
> > > > > >  {
> > > > > > +       struct btf *btf =3D traceprobe_get_btf();
> > > > >
> > > > > I found that traceprobe_get_btf() only returns the vmlinux's btf.=
 But
> > > > > if the function is
> > > > > defined in a kernel module, we should get the module's btf.
> > > > >
> > > >
> > > > Good catch! That should be a separated fix (or improvement?)
> > > > I think it's better to use btf_get() and btf_put(), and pass btf vi=
a
> > > > traceprobe_parse_context.
> > >
> > > Hmm, it seems that there is no exposed API to get the module's btf.
> > > Should I use btf_idr and btf_idr_lock directly to find the correspond=
ing
> > > btf? If there isn't yet, I will add it too.
> >
> > There is bpf_find_btf_id.
> > Probably drop 'static' from it and use it.
>
> Thanks! BTW, that API seems to search BTF type info by name. If user want=
 to
> specify a module name, do we need a new API? (Or expand the function to p=
arse
> a module name in given name?)

We can allow users specify module name, but how would it help?
Do you want to allow static func names ?
But module name won't help. There can be many statics with the same name
in the module. Currently pahole filters out all ambiguous things in BTF.
Alan is working on better representation of statics in BTF.
The work is still in progress.

For now I don't see a need for an api to specify module, since it's not
a modifier that can be relied upon to disambiguate.
Hence bpf_find_btf_id that transparently searches across all should be enou=
gh.
At least it was enough for all of bpf use cases.

