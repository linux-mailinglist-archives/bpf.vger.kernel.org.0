Return-Path: <bpf+bounces-3238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D2073B245
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 10:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C571C21088
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 08:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F4F1C2D;
	Fri, 23 Jun 2023 08:02:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D754B17D3
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 08:02:06 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FF81FE3
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 01:02:01 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b4790ff688so5992141fa.1
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 01:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687507320; x=1690099320;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8kOL7IZpJlvvWQ/5Wx9fFtB+uPjTzhg6rgZdpESupZI=;
        b=ByIlM2hvDTlKf1af2Qy5rYr9Q6vzUbFX0r0rUjme0ExxI2q2zf+ZhhFPI6RPcEXNeh
         9i7HH/BOtI5fLXA1rQKQYO/d8gIh7n2Rr7JW+VuW4+8a+WxMAinBzS0dm+a/FsGHspyh
         yjKXorT3X0wdkRGF2Yy6OxVcRzCS0+ysjasKaSeh+lsNdiz9WnfjFTMsw8o/MdE+diwv
         awTJxEcWZWKeR1x3ISSQ9rowSxdtam7CAv5eOKVpdaCrVSO5nTgKY6dl9I33FUKo4Pfc
         vt5RCKl7OcDUaG08trlxUm7VgunDeGkdyjg7DJTTNJZKh63n/K65qJjbcA3Z4qy67mTa
         2VTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687507320; x=1690099320;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8kOL7IZpJlvvWQ/5Wx9fFtB+uPjTzhg6rgZdpESupZI=;
        b=Z9cfTYFK7X/SXHYZAv8EoMIz617zcDT0kWzRuy854l4/SDvSHGPL2TV54h1GEukePG
         jZ3K9sKXQ0QOQvKLAYuy0/rigvy8vAvnserFLEElKTIdlU+f2uDHIfg1RyEpKeCVwgQy
         Ut90vm55RnC+N5edY7Ea6TOGRDYhNh37H9LEqYfQib5nK36VJXX3UEEi8Yf/VvwKg1nD
         W3wEbCKVjQxrTP2GZBl5WcdfvHzGtwgPrxOpx6p01S98zfHj7fFdEJf4GEYuEZVKDoHS
         uJzP6UUesodSVQ8HTXyoEf0S6Bi4l4H9kSnzHEMgb8hf9kmyBIiwJCyPMYP84FgWt3ky
         ZOqg==
X-Gm-Message-State: AC+VfDzsvTs8+PPMM/bc2+CZ0jMRwU3vY7KivU82QTRAdbllor2Pct7X
	dDaFAT54upHJtlELUMAqblQ=
X-Google-Smtp-Source: ACHHUZ5TqyMv9RtDGKkctZrylBsyhrsLUuMjnZaVw19tJiEYVMOVryOVbR4ecjNJXsX2gfP1RfeYbA==
X-Received: by 2002:a19:7108:0:b0:4f3:8507:d90d with SMTP id m8-20020a197108000000b004f38507d90dmr11866610lfc.34.1687507319324;
        Fri, 23 Jun 2023 01:01:59 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id e25-20020a5d5959000000b003063db8f45bsm8868435wri.23.2023.06.23.01.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 01:01:58 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 23 Jun 2023 10:01:55 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf-next 02/24] bpf: Add cookies support for
 uprobe_multi link
Message-ID: <ZJVRc2uuMI5D1lNl@krava>
References: <20230620083550.690426-1-jolsa@kernel.org>
 <20230620083550.690426-3-jolsa@kernel.org>
 <CAEf4BzY9qYSmGsAOZt2W1KGuDZu+wtKFn5FNECuKkNpk7WNvwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY9qYSmGsAOZt2W1KGuDZu+wtKFn5FNECuKkNpk7WNvwA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 05:18:10PM -0700, Andrii Nakryiko wrote:
> On Tue, Jun 20, 2023 at 1:36 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support to specify cookies array for uprobe_multi link.
> >
> > The cookies array share indexes and length with other uprobe_multi
> > arrays (offsets/ref_ctr_offsets).
> >
> > The cookies[i] value defines cookie for i-the uprobe and will be
> > returned by bpf_get_attach_cookie helper when called from ebpf
> > program hooked to that specific uprobe.
> >
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/uapi/linux/bpf.h       |  1 +
> >  kernel/bpf/syscall.c           |  2 +-
> >  kernel/trace/bpf_trace.c       | 48 +++++++++++++++++++++++++++++++---
> >  tools/include/uapi/linux/bpf.h |  1 +
> >  4 files changed, 47 insertions(+), 5 deletions(-)
> >
> 
> [...]
> 
> > @@ -3026,6 +3045,16 @@ uprobe_multi_link_ret_handler(struct uprobe_consumer *con, unsigned long func, s
> >         return uprobe_prog_run(uprobe, func, regs);
> >  }
> >
> > +static u64 bpf_uprobe_multi_cookie(struct bpf_run_ctx *ctx)
> > +{
> > +       struct bpf_uprobe_multi_run_ctx *run_ctx;
> > +
> > +       if (!ctx)
> > +               return 0;
> 
> can't happen, let's crash if it does happen?

ok, will remove

jirka

> 
> 
> > +       run_ctx = container_of(current->bpf_ctx, struct bpf_uprobe_multi_run_ctx, run_ctx);
> > +       return run_ctx->uprobe->cookie;
> > +}
> > +
> 
> [...]

