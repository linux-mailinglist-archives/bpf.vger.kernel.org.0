Return-Path: <bpf+bounces-79306-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E6ED337CD
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 17:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F26E3301E5B6
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 16:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4B83939AD;
	Fri, 16 Jan 2026 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jI2nmMNg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5714833B951
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768580817; cv=none; b=mVH8VjrZtMGIFxOpdBJgLw950L1X7maSO54ddjiMccVGwfKY8kFWmwvbcV/4jBE8h3C0b4n05HNarCBPu4jKVSWu5ewWQXtUisidmkl8t3btGrSF+3t+AEtbcmaJKxDCmSx7DlAwpIs0jsZtp6fkPMh6DGm0nKeCFWdevFhR4j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768580817; c=relaxed/simple;
	bh=8AHs53fSvU5bHukwFUEWbX+8QI5Zs/IgwW6Go1qm7u0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPCbE52GfWLUYmYGFOwbJvfiXuPTLR1LRp0VnHMNp+6X+lUtygxSIxxVrMNJcC3ybdT3hYA7gHE3dH7GczWTo41a2zcceElXRqFt5uDOXpdBxt9xMk287a9zYGos6TcsUylsHaYtpJcMpKB82YXB4qsLr3wj0k0oSlLq6jE9WwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jI2nmMNg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so9016785e9.0
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 08:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768580815; x=1769185615; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LpEcqtGHA2DG3RqR34GHiAvSZA6xSMmh8o8+NjypMPE=;
        b=jI2nmMNgKMgi+E7qsC39d4L4g2pQPQnUJhS8+fT0by3BZItCSJYx6rwNIuvsY5jjPQ
         D4skJvdk6oyhj87V8vXUz495z1Qc2B3quLCsbDqMIa8EsUPGLnTv+vImB6fD5Iq8CnDf
         SYs36KxLWRVU1RH5AJ/g5d0cQXNd1IhH4POmPYMcoeP9oyHTjyCUDbqwF4OtwZ+pObta
         TbM4DsCGi7LoccPSloIcxM8QbIk16Od/BSF0Pcgu+gSHRYtuwZw22xik0CFW5ghCnGFj
         eehv36qJ3Nm4c2XfFewJBLtBk+/oB/QZCMsZYN3gQi+AjG7NV8sb1vIZwTet9vOHTiyr
         B04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768580815; x=1769185615;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LpEcqtGHA2DG3RqR34GHiAvSZA6xSMmh8o8+NjypMPE=;
        b=piyBMfb2DylwWfBakuNUEOsGRBYQ1COhtrlMxieceHbTfA2AJ26CqKGLHPwzvPjh87
         2go3GYwz9gOuTRrcQeml0NPlMSiLWKXZjqd3z3tHc0u7YIhie9dBPPWjz4KwNySJM0pn
         V6SJI77U3AwDjuPlVEvy9LSmqRNSxRg14UV4t52Hdh6pnQu16njtpYbm/4XxbzVUveDm
         TkP7jhzYN6b7mJX/z8RLieEAD80ABXz7j5hTrk7RRgkOZT9mR36/+JOsBMlrwIWCofwB
         RG8KaIK+eV3OL+uNMMf0ds26/N2spRWHSposSMoWgo/tFiOuQ+NLXU+bBMQtp6+9LQrl
         EWBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb51ACkifQq4aqW9deo38/3Ay17nuHYzn0MSuhEKmhfP9ghhR7mtVcrTDm/+FVaXISvHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoSHNYhE0S7QmrCi+XpC9/V/kUznMbK4fuOLOogYrFC5nkUEyJ
	GjdkVXV1EpxtnV+CfgXkS+w9GZ2WUODYfL5+EPqsZxOBnXQ+NqP2X6l1
X-Gm-Gg: AY/fxX68haiQZgNRz7K2InW6QbauTgbgmFSzEvXOa5UG/j+zFS2EdYg3QDXdLVeLzth
	0gdn5JpKof6tANbBB5r6KIaaX3g/bxkJN9mcd1FLNjP2/k/TiLO4i5CSoYNl/KdUQ9S5Wz6D6MR
	soLvy1WRRC7r9CKsahlhkmdmOQmTnEtSfWAHcvu5aKtMTySKRD7nDJ+UNMClmxBK2nmlmkmqH51
	QZAy96oFK2eOIHsqIp1V2bwiBbCJ9ZyXwxPwwOONKKoLbptGDGmdRuHCrF7Svb2Kp9ZqxVVqfRj
	DlacTrl6fCAtvlrmR/JKmqp6mPqxckMqM37t/thNBlOi0D06lVXnUZhluiXEnzCEBwlZdK+7dCL
	YC7tCHvXtnynFiRoV8cpDDx88IUsSYWuvo/TabVpu32JMF5huJW0xBTJ+/mc8Z/ObCnX53Dm3sW
	WTBnk=
X-Received: by 2002:a05:600c:37cc:b0:480:1b65:b741 with SMTP id 5b1f17b1804b1-4801eac97b9mr38192555e9.15.1768580814334;
        Fri, 16 Jan 2026 08:26:54 -0800 (PST)
Received: from krava ([2a00:102a:400f:3ccc:ffd6:980:bac0:cb06])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe67780sm18796955e9.16.2026.01.16.08.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 08:26:54 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 16 Jan 2026 17:26:50 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Allow to benchmark trigger
 with stacktrace
Message-ID: <aWpmymeGXwb1pgev@krava>
References: <20260112214940.1222115-1-jolsa@kernel.org>
 <20260112214940.1222115-5-jolsa@kernel.org>
 <CAEf4BzaXhGpkycs-TO_1V81-irq3d8Mjfyk=LMc0OC-NW-FnRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaXhGpkycs-TO_1V81-irq3d8Mjfyk=LMc0OC-NW-FnRg@mail.gmail.com>

On Thu, Jan 15, 2026 at 10:48:29AM -0800, Andrii Nakryiko wrote:
> On Mon, Jan 12, 2026 at 1:50 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support to call bpf_get_stackid helper from trigger programs,
> > so far added for kprobe multi.
> >
> > Adding the --stacktrace/-g option to enable it.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/bench.c            |  4 ++++
> >  tools/testing/selftests/bpf/bench.h            |  1 +
> >  .../selftests/bpf/benchs/bench_trigger.c       |  1 +
> >  .../selftests/bpf/progs/trigger_bench.c        | 18 ++++++++++++++++++
> >  4 files changed, 24 insertions(+)
> >
> 
> This now actually becomes a stack trace benchmark :) But I don't mind,
> I think it would be good to be able to benchmark this. But I think we
> should then implement it for all different tracing programs (tp,
> raw_tp, fentry/fexit/fmod_ret) for consistency and so we can compare
> and contrast?...

yep, agreed

> 
> > diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
> > index bd29bb2e6cb5..8dadd9c928ec 100644
> > --- a/tools/testing/selftests/bpf/bench.c
> > +++ b/tools/testing/selftests/bpf/bench.c
> > @@ -265,6 +265,7 @@ static const struct argp_option opts[] = {
> >         { "verbose", 'v', NULL, 0, "Verbose debug output"},
> >         { "affinity", 'a', NULL, 0, "Set consumer/producer thread affinity"},
> >         { "quiet", 'q', NULL, 0, "Be more quiet"},
> > +       { "stacktrace", 'g', NULL, 0, "Get stack trace"},
> 
> bikeshedding time: why "g"? why not -S or something like that?

perf tool strikes back ;-) -S is better

thanks,
jirka

