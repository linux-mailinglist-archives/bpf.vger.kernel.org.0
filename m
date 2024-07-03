Return-Path: <bpf+bounces-33787-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B25C9266E4
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 19:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA2F1C21075
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 17:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41B11836EF;
	Wed,  3 Jul 2024 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COYGASSX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A511E18C05;
	Wed,  3 Jul 2024 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720026956; cv=none; b=JqCG1JQGKZmmFdx6R357v8iriHZCPk79JHzwtBTp4dp44QKmyxTYDDWwvZpz35r1ZSFdLUFk6TirVX9ka5mJAAOyASOLQ6+zWLtnaE+hvgb7H4372JeOcqd94BtCiSx3KNbxHsag9GVqXFvl61gnPN0ojsses2LDcW7DAmtC7Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720026956; c=relaxed/simple;
	bh=tJYfia9Xj+Wu1Cnlgt2pniPUMGyHlDBfZmv+zXZ6JYc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ki/diJ2YyG0Yv+CYxXHM4xMK/p0+COzngNwKfHxA6lMFiyLjADJQTTMKyFIUmWKBbAyT3QFPuMSZYKc0TXqZM6sF+xBXURw5La7w7sKTaFMUoj0Od8sP1vogCr8sb0/1dSdb4y93j3nn6dVPGaRmRL8kMrgjEIHQAlhxsmE0+v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COYGASSX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42565cdf99cso50139505e9.3;
        Wed, 03 Jul 2024 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720026953; x=1720631753; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pMoYeAZihUPAPF/tX5g0vli6m1IPOdXc954LKiR10Jc=;
        b=COYGASSXooxwoL/nkRvRLXBxeEz8Avdl50UlParzt726/YAPY27HjAgt8gugknyjge
         LPq1MwvAmjf2Db/zPsz6/daIAu8w3sYnZue6S4SvMamFUKhuiW/bsdYr6GZj0PxPzdts
         0UG4QeNQPlaWpe7DCGyQinBOvBaEbhUHRGi1T0CRp8/XgZsHt2Q6R0/tV8FEb33BU+Q2
         OEowkFEyorOlp+nLYRBCUqUTCHOwMWs7m4VjOhlJSsqWsrtzAjf1MeYkS36w5LXn+KnJ
         Y3agEiEiDvcba08tW/P1A644PYZCEDlyFBmjFj+GoktNs24TCmCp3+niSyQx6HRgm34I
         gpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720026953; x=1720631753;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pMoYeAZihUPAPF/tX5g0vli6m1IPOdXc954LKiR10Jc=;
        b=ShBONeY+tZ4C3AVADkH4GAz8FlRPgQWS11sAfyO7PyOa3VveaBdUbIWu5DIsB3HYDa
         wDmuXXO4/kkBXw01rUU9qV1iQDtMA7NClRRin+RDrVp6hOnOPSC+gCMtscmqTsNLezyj
         xL0Hxt41RVwmHrPaGlpJIgT1ohzqHn8NTAHZS3zB+bVY1PKei4LvnHdBy0letrGg/cOu
         HcMwhkhcUQeCc5VlQedcUwHA2MnZhbXsNFT0EZU+iBYsMuLoWpgRIOYYeOfbX78HXMO4
         OVttIzV0NbE9nnc5ZneXHaEsTg5rqaagBq6ZcjH+Dw+8PfToq/2oo4lV44+ybDavhnVQ
         R1tQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXeqsxgXQJew4D4FRoc0sWpeXIfpl5QIPR7/FOe3y5hyJkrzGYLweg4YPl/KDjsWppepTauR3X5Z+AsQyptyrnHbnx+4HvxbBYCfTA9XMh7wY/sKUap3n1bk2w8MWQKlR+xRHwAETBUvkoaD7dBn60OUj3FuRSH96q//UTdJv8E+CFD26r
X-Gm-Message-State: AOJu0YyI88Yih8FlJzwxfNsf1gHvhMgmY6Vf1ozzknBsazkAJNHBaONv
	xTseXvIeTJV33Ba/b1fP0+ri6mmqasoYhKQH5/BENeR4RiRrpXuAxM9ECURMnXg=
X-Google-Smtp-Source: AGHT+IGF/iRz4wP3dVebTRr1i4jd1ULlXLj4BS/YyKzRnRRWNt8efFQxglhByrMiDcJtHea15y2snw==
X-Received: by 2002:a05:600c:47c7:b0:425:5f73:e2e1 with SMTP id 5b1f17b1804b1-4257a00c088mr103369925e9.22.1720026952876;
        Wed, 03 Jul 2024 10:15:52 -0700 (PDT)
Received: from krava ([176.105.156.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42577a0c286sm133274945e9.0.2024.07.03.10.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 10:15:52 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 3 Jul 2024 19:15:47 +0200
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
Subject: Re: [PATCHv2 bpf-next 5/9] libbpf: Add uprobe session attach type
 names to attach_type_name
Message-ID: <ZoWHQ3V4WyZcTodb@krava>
References: <20240701164115.723677-1-jolsa@kernel.org>
 <20240701164115.723677-6-jolsa@kernel.org>
 <CAEf4BzZefhPv+yXJ3ozX6nCewaq4LQGOCpy_g7a9QKsAq5FDQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZefhPv+yXJ3ozX6nCewaq4LQGOCpy_g7a9QKsAq5FDQQ@mail.gmail.com>

On Tue, Jul 02, 2024 at 02:56:34PM -0700, Andrii Nakryiko wrote:
> On Mon, Jul 1, 2024 at 9:43 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding uprobe session attach type name to attach_type_name,
> > so libbpf_bpf_attach_type_str returns proper string name for
> > BPF_TRACE_UPROBE_SESSION attach type.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/libbpf.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> 
> Can you merge this into a patch that adds BPF_TRACE_UPROBE_SESSION to
> keep bisectability of BPF selftests? It's a trivial patch, so
> shouldn't be a big deal.

ok

jirka

> 
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 492a8eb4d047..e69a54264580 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -133,6 +133,7 @@ static const char * const attach_type_name[] = {
> >         [BPF_NETKIT_PRIMARY]            = "netkit_primary",
> >         [BPF_NETKIT_PEER]               = "netkit_peer",
> >         [BPF_TRACE_KPROBE_SESSION]      = "trace_kprobe_session",
> > +       [BPF_TRACE_UPROBE_SESSION]      = "trace_uprobe_session",
> >  };
> >
> >  static const char * const link_type_name[] = {
> > --
> > 2.45.2
> >

