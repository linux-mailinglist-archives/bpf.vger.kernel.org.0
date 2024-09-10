Return-Path: <bpf+bounces-39408-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36B2972A69
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 09:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90141C240CF
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 07:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D5817C7A3;
	Tue, 10 Sep 2024 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnblJAYE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059D917C220;
	Tue, 10 Sep 2024 07:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952647; cv=none; b=bNSjookXUYr+3f7lUNd0kEFeCjJOYQCHBORUdx8a2V1sjGRmOJn4irYVCkCfavFFCXyVQ2iNvctHXqjKcnVnNw0bgT2c5Y4FcDoPWlr8NcB6gRKyXQmoBkcfmqQscNDtbnwYHy94mA0lQRuyEZKviWcWx6CZDnr5ddUYiTNcuok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952647; c=relaxed/simple;
	bh=FhxNxlSSnX6nEGd5EE/Hqx3TDMmmX5dyRyYzzYw56gc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmkQ/dnKDng2ivzCCpViBprB+QFsDkkR80oDrGKgbZFEcC5kZQ6C7qNxD+0an0wSlDyge6811A4dORfPHWslygmbXvhYHJh8eDjtll0dIo5U14AHEKonsoDcsQMLQ5bswhieURvwyoRjutjz+sfTKCsf7bl0/ec0nYusBrSKP2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PnblJAYE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cae6bb895so27974415e9.1;
        Tue, 10 Sep 2024 00:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725952643; x=1726557443; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4AjEgfqbqfgxFkwY1fCX7Gvgr03DHrmEXDxVFYmDKPA=;
        b=PnblJAYEGKhipg8iOW/c9cxTbXneqMd1CLubJooZuWIpThxWisipTGD2P6NH++JjQX
         haJvSaQv2jKYoPOYVQ6QNKEcMGQKSX6etXA0u5ldwUizpriqafxzIlJESehqpV0+MeWf
         pVVerOlXWVWEJhRJDun81R89p+Q6sJ0HsngXCy0uPWX4HNOAoDntqZER3qMYbqFPDPWv
         b2gCpPt4IB1jWoAlYglFK+3neInmcqm5/EVHxrNS11UWSQfCZAak/UvDgWrk+xM2U/ra
         rQR5WJ2UVLo6V1FqcE7tRaDXglPeOZfbNdPYy7UnmqfBzDktuVd59KqOtGhUnP/nB8vu
         zFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725952643; x=1726557443;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4AjEgfqbqfgxFkwY1fCX7Gvgr03DHrmEXDxVFYmDKPA=;
        b=V+h4gY8iBshbkw9UyeEPaNWuEvZNEwsSrIh2ODQobRD4M22o/xrPl5vWT3jTWjX/cb
         BtCFa3ij38ADuvP2nx29qJ7LLIgV+Nq8hDic1RwXa95xLdPOw35eM8yuHELRInr+nnUs
         rbtU6CnILIee4eB29pDn722H+mBk0KJQCDKMR7mg4Idw6GgKnZ45eAIw8O7aja88hRMa
         yErXr1cZTFgxmT4TLRFiWwTxGWjuQBVdrQD7f2N46NQ+w/WxZGwQaf1lJoRwlB3ujYCV
         pSzOO1q5Bfw4EhORRm3Guus010yuF9ocLd2zBglFDSQzJcDoVkyGlq1Du3uOkoTmByxh
         Baxg==
X-Forwarded-Encrypted: i=1; AJvYcCV2bRh7M1lb4Gyp7siTm3LfZicU2+8Sy3hcDe3LAxpg2EQ5jC4NGmEaE3JomudeFj3dSgRiAbu1GWNKNdgf+N8ovY8W@vger.kernel.org, AJvYcCVV0BOvtrzYpJsTYesCdHHKTY+AcmprHXuj5tCbCMjG9TUL+RJ5YlBc0bOC5pbMH6vqpUY=@vger.kernel.org, AJvYcCXxqlMTqv+lXp0jv/RZS+shQDhLlHP/n71WpMUq1XdbOgYvG4EtIXRNsjIX9R0j1W26hQC+o/rGIpDgb4LR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqno/LmO5x3Y1nQvvNtxx3liBtOi4rzTRsiMvqMqnelsRLtxpB
	RCs7Jryn0ZjfUHbVaSPdQGBFerzVvX6tyKq0Q9cBDR6obJW+D0JL
X-Google-Smtp-Source: AGHT+IEkPSolpKSm1Xx0vU8RX2irEBeB+YCsbeuH437YWhKtTJ2JdaWm00I3jAOk0wbNvu9y08ZTfA==
X-Received: by 2002:a05:600c:1c8f:b0:42c:b55f:f7c with SMTP id 5b1f17b1804b1-42cb55f1796mr53902295e9.15.1725952643197;
        Tue, 10 Sep 2024 00:17:23 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb33489sm100080785e9.19.2024.09.10.00.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 00:17:22 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 10 Sep 2024 09:17:20 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 2/7] bpf: Add support for uprobe multi session attach
Message-ID: <Zt_ygFPEdX53rqaW@krava>
References: <20240909074554.2339984-1-jolsa@kernel.org>
 <20240909074554.2339984-3-jolsa@kernel.org>
 <CAEf4BzZ0+4Hd1xESWgE2WhSsNEuNuxtTju+OQeGiY0_iZsZbXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ0+4Hd1xESWgE2WhSsNEuNuxtTju+OQeGiY0_iZsZbXQ@mail.gmail.com>

On Mon, Sep 09, 2024 at 04:44:29PM -0700, Andrii Nakryiko wrote:
> On Mon, Sep 9, 2024 at 12:46 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support to attach bpf program for entry and return probe
> > of the same function. This is common use case which at the moment
> > requires to create two uprobe multi links.
> >
> > Adding new BPF_TRACE_UPROBE_SESSION attach type that instructs
> > kernel to attach single link program to both entry and exit probe.
> >
> > It's possible to control execution of the bpf program on return
> > probe simply by returning zero or non zero from the entry bpf
> > program execution to execute or not the bpf program on return
> > probe respectively.
> >
> 
> pedantic nit: bpf -> BPF

ok

> 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/uapi/linux/bpf.h       |  1 +
> >  kernel/bpf/syscall.c           |  9 +++++++--
> >  kernel/trace/bpf_trace.c       | 32 ++++++++++++++++++++++++--------
> >  tools/include/uapi/linux/bpf.h |  1 +
> >  tools/lib/bpf/libbpf.c         |  1 +
> >  5 files changed, 34 insertions(+), 10 deletions(-)
> >
> 
> LGTM
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]
> 
> > @@ -3336,9 +3347,13 @@ uprobe_multi_link_handler(struct uprobe_consumer *con, struct pt_regs *regs,
> >                           __u64 *data)
> >  {
> >         struct bpf_uprobe *uprobe;
> > +       int ret;
> >
> >         uprobe = container_of(con, struct bpf_uprobe, consumer);
> > -       return uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
> > +       ret = uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
> > +       if (uprobe->consumer.session)
> > +               return ret ? UPROBE_HANDLER_IGNORE : 0;
> 
> Should we restrict the return range to [0, 1] for UPROBE_SESSION
> programs on the verifier side (given it's a new program type and we
> can do that)?

yes, I think we can do that.. we have BPF_TRACE_UPROBE_SESSION as
expected_attach_type so we can do that during the load

hum, is it too late to do that for kprobe session as well?

thanks,
jirka

> 
> > +       return ret;
> >  }
> >
> 
> [...]

