Return-Path: <bpf+bounces-40661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01C198BD48
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 15:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70F0D283C9D
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 13:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116B663B9;
	Tue,  1 Oct 2024 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDKxZk/D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE9536C;
	Tue,  1 Oct 2024 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727788670; cv=none; b=Kkd1BwBvYLiz2h8CG3S5KoXvEjhlO5XsAs7tIK4ZjuIkJmCx8ApUTKM6hXeN0H+PWmfQq6UIaYj9iRiLdOfSIIC1gdxM1EkuZKlRR4iJh0hNUuGMry/PW9XpOnby0O1lgyjiuhRE/T7peOKUkZ7wbzBhMpOWhB1YQ4TkU+9OlfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727788670; c=relaxed/simple;
	bh=WPMpOd8Iw2kSzbRwKqXYnnhA6JW5T7DbmEoD1hPbr0g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/nFz+mAiEm7K7kqsvto74K5wQiYtl5D6r6NT266AZP+YOpupMrr7keKKOeFoftdn8rs8Rs7yhpRWVYcHRlIKyfqwicHo9zKndnu+Ai25dWHs6g737JwPhIsgAXL7YlyroWN3G2Kkf4O3IjhHKpbCg5nPGbTd3wIDrURPIyAqYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDKxZk/D; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so49019655e9.0;
        Tue, 01 Oct 2024 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727788667; x=1728393467; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KmPQDwzcEIkFp9T4l5sYPEseGg7Xn9NS3SfB4A7nlZo=;
        b=MDKxZk/DXhlGaSoEl/bInKCTw936Z5MecSoL4J28H2jq+UukrNwEElTq2//vpHrP4l
         sGblphVYPE16IH60NRTqfoPQWisC12PNWSXD5hcKRS9jvxGfpUtatWyUkbXt4t8BWP4Z
         MwPc55n1lYUH8dEMOwvnVufEUtJZGGmuMsNwWTSJAw+ScuIQb6zSk0F2avZhIB9F509l
         dJ8WM+qCCptx3AHEwTlzI0o/ah/iBlYQVsAMKlj2++vCjD5OUQV3tHQ0fT6xnt8UUjoc
         LNj61Va4/3z2AlHd8dsVkDknOdz42sMsy74JTt16GivngwH7sGSKc4scsP/HyG6SOy9e
         ajhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727788667; x=1728393467;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmPQDwzcEIkFp9T4l5sYPEseGg7Xn9NS3SfB4A7nlZo=;
        b=U9p4P68rzcnnE6vAogJkIoUJPMoWHIBqmirxacCV7YAABHARex4yiFwTxHeanbgsLC
         Jm8q37QNCu3COiFn80P0OMpmD4RBTlQ9jqpuZ3+yVRLtbq8v6Kb5xSvaM/KPIZn+0lHo
         8SqtNPcjhpRXZKDKmpcM+raavZ1yFaBayV9dgZR6mWSd6yuxI4rkxyeiw3FJ6w3Yvb1B
         6GWAH7EIKS5c/jah5t7kY2F1qLCawJkXlx2eNaVTEu1KErNRC8Joh13ArU/cngo5yIwX
         roqbjVIsW1ocK+KznctXjhd0L/jv6+b8pXIIKw0eQDVY7PvyFsD1g33Knu9g4q2Hq7dv
         EF3g==
X-Forwarded-Encrypted: i=1; AJvYcCVGDZe0vsfIxRS2kY89bAirhm0NUAtg1A+qMgup3qyRIZHjUELg1Py+mQZOrDltJAReOizpHc1YHHGIgdcVjRG+9014@vger.kernel.org, AJvYcCVjvaU3G197ps2NQr5dcu4A8MThbNVmAv2e9NmDAVGAly5fcZDmVCk6XptURtMdtSic7vI9jzmFt0CyRl5K@vger.kernel.org, AJvYcCWFtQpK6i8UHfOh4yeq4veSqlFPWoUEugj1NCM8Ju4U5iwTBw/P2ejc3eX5s2irvZjMOhw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5TFUXbEw0w5pKrveNQqhucUMJARf1dEzGLjYBhWHlsFCOyaCT
	oPfnOGhdYeueoeKtl4WNcn9vPDeSJCfajYdE2/RLYhyRreBnofyB
X-Google-Smtp-Source: AGHT+IEnDE6wjI9HEWyGeV7WUmvdmKD0dOfKUy24RV3qN1iuRE12CVnQRS17JvbbpRmY7MQrsDtpbg==
X-Received: by 2002:a5d:5052:0:b0:37c:d537:9dc0 with SMTP id ffacd0b85a97d-37cd5a6bf42mr10272474f8f.12.1727788666869;
        Tue, 01 Oct 2024 06:17:46 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd565e21dsm11807727f8f.33.2024.10.01.06.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 06:17:46 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 1 Oct 2024 15:17:44 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv5 bpf-next 02/13] uprobe: Add support for session consumer
Message-ID: <Zvv2eM2YNuiv7C8-@krava>
References: <20240929205717.3813648-1-jolsa@kernel.org>
 <20240929205717.3813648-3-jolsa@kernel.org>
 <CAEf4BzZ+1=YU=61mVup8pAc80SOvNuYtMzNdz4miH+Sm4qV4ig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ+1=YU=61mVup8pAc80SOvNuYtMzNdz4miH+Sm4qV4ig@mail.gmail.com>

On Mon, Sep 30, 2024 at 02:36:03PM -0700, Andrii Nakryiko wrote:
> On Sun, Sep 29, 2024 at 1:57 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > This change allows the uprobe consumer to behave as session which
> > means that 'handler' and 'ret_handler' callbacks are connected in
> > a way that allows to:
> >
> >   - control execution of 'ret_handler' from 'handler' callback
> >   - share data between 'handler' and 'ret_handler' callbacks
> >
> > The session concept fits to our common use case where we do filtering
> > on entry uprobe and based on the result we decide to run the return
> > uprobe (or not).
> >
> > It's also convenient to share the data between session callbacks.
> >
> > To achive this we are adding new return value the uprobe consumer
> > can return from 'handler' callback:
> >
> >   UPROBE_HANDLER_IGNORE
> >   - Ignore 'ret_handler' callback for this consumer.
> >
> > And store cookie and pass it to 'ret_handler' when consumer has both
> > 'handler' and 'ret_handler' callbacks defined.
> >
> > We store shared data in the return_consumer object array as part of
> > the return_instance object. This way the handle_uretprobe_chain can
> > find related return_consumer and its shared data.
> >
> > We also store entry handler return value, for cases when there are
> > multiple consumers on single uprobe and some of them are ignored and
> > some of them not, in which case the return probe gets installed and
> > we need to have a way to find out which consumer needs to be ignored.
> >
> > The tricky part is when consumer is registered 'after' the uprobe
> > entry handler is hit. In such case this consumer's 'ret_handler' gets
> > executed as well, but it won't have the proper data pointer set,
> > so we can filter it out.
> >
> > Suggested-by: Oleg Nesterov <oleg@redhat.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/uprobes.h |  21 +++++-
> >  kernel/events/uprobes.c | 148 +++++++++++++++++++++++++++++++---------
> >  2 files changed, 137 insertions(+), 32 deletions(-)
> >
> 
> LGTM,
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> 
> Note also that I just resent the last patch from my patch set ([0]),
> hopefully it will get applied, in which case you'd need to do a tiny
> rebase.
> 
>   [0] https://lore.kernel.org/linux-trace-kernel/20240930212246.1829395-1-andrii@kernel.org/

the rebase is fine, but what I'm not clear about is that after yours and
Oleg's changes get in, my kernel changes will depend on peter's perf/core,
but bpf selftests changes will need bpf-next/master

jirka

