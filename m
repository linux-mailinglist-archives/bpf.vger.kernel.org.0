Return-Path: <bpf+bounces-48241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 825F1A05A14
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 12:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A473E1886A1D
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 11:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8C41F8AC3;
	Wed,  8 Jan 2025 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3eArnE0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345E31632D9;
	Wed,  8 Jan 2025 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736336334; cv=none; b=KIMLN8jC28IOq8ilLg+FDI4oRMf8IwRGpgORJS0ZHeokn1QhgzOcpYu99XkEzhJ//KsmbspvlpY8iSwjK6ZZlbStGnVor5Kk1hqepTff2YKKnLOrVwF0dCG6pIuwdguMIjyr6y6tc/cv+FelKBwNp9ARDxH9kbD0OokeyCiVhys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736336334; c=relaxed/simple;
	bh=GKSWeIs3SNCuqRSvLDRdT+Ol2XUVqJ0tmgWgCZ6YpgQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdyprTou0J8pAZkJJCtxYN+nTP/yYIa1YRlxWYE7fb/yCzkMOGrF8FDGcHHPqE3cloN4JJhBNZ5EMMRM+NY8put/tr9TX7u/ASVqj+yPhtqYwcukUspWVSj9Pmc7n2/9RgRstE8mw3JOliH3bOuje8HdoNsl/wbXhrANBc+1WLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3eArnE0; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3862d161947so7893625f8f.3;
        Wed, 08 Jan 2025 03:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736336331; x=1736941131; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wfDUaSyAwf8y+EBWHrOhJz1t0LZv/CD1lph7mHopUew=;
        b=A3eArnE0++MYmYKrG7TLMATl4crxrUBkKYIkLKBQqS8YGMUr3nr1BUIaFYcRBQRqjo
         gfAgowwVuoehmmgeH7/kY97Vpk84J4zE9RhZY3WZBNCap2Sd6sSiaV2og/nM6meuD1S0
         mcTnSJSeeqMSe7/AaSdICD85no+K/CruuKxferGqLj9rxH7rUrB96W6RUE+FqJmdUpJR
         nfCHXYS3U1dRPNxJJ10rwzRQy2EXPmn1DEnrR9GbqMlpX2WWqToc3FMPVLLzZ6l6UCSI
         998MpiwsLZzp2pKB4VSftpcPw3FQCYs0mrU08FHcRxVMG/9L3tCwVRQ5F6s7AtTQ6Mrb
         Y1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736336331; x=1736941131;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfDUaSyAwf8y+EBWHrOhJz1t0LZv/CD1lph7mHopUew=;
        b=eFxA4aaOsBvLT7hfN4dq3xRHLqFgyZh5NALXm1BwXFQtSwr/s1kR0ggbkr/yYZC6Zl
         iaoomL26+QIeJ6KLG299yZH1h35BQ7js8OuS3+M8Df2Ly3dCBWEJBiAMDCdsWF5RG8xG
         Bs9FzBKMgAriH47kP93YrQXIoruRmIHxniucNOMM8N7o3rvO23jcukX5cCbEFhvs8FmW
         vTO0PUVnKhr9m4CrVdMt4oR+/qUSaGkaRP2+8uh2iEIsmJkvhaOIoulqbYfqAwD4cb4M
         uMypbv2JRajR+MeajTpYW40jHF8Lq1mUqDPtRpWAs9gtwPf2e8vKhU7p2QpnY+7FSjZk
         Fhzw==
X-Forwarded-Encrypted: i=1; AJvYcCUl4Jpg3hjp9pEUgmECrK2p8tQjX+laTLuqIf1XD5yGfNWgS6DJqvIExL2q9oXJvZVrLviFAiLevI2GMPkZvvwOuw==@vger.kernel.org, AJvYcCXiH5VtY/D9fFVRZNkch84KH5I0cl2702IYAEEieu5K5jE72FmFuBNrGT+AkrbU20zns3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOaJarDNrTOaDmjb7kmLBBGk7opHAki1dwh0c+RMbisZuw7xKC
	tkfiwz9fXcU6iBBndIn+a9tb3CgvE6lxy5c78M8PVs+ioP2cQ/Bo
X-Gm-Gg: ASbGnct6jcSvT8z+z/5RcyTYsvFFQf2EcOCHuBrl2AVJuwec2VJSYiVxmJ6dNkdGoyK
	IFcwRTyQ9u071AyrsKdPv4WIjNqZ8b0BEm30BmRbsn4/xmxq+kkzLauq80QeC4G/JTRgk7u8cgz
	TRO4VzpB6OKUS4/Cu6K9yOXMRvqG68/ilRHXI0hmZkbfpARM4gvWrgjahRZasaoM79RySkiZ51K
	7XGhuJTQn9/mfuKPv4uDhkPCrsyjsw4ZhLulKAlopk=
X-Google-Smtp-Source: AGHT+IHFlx9Hv+kLOWVugbXvMed1KdgogPvUCKi4z6k80IajYZnD8A9rfBJy+hjJKJt4C3bgLbjF+A==
X-Received: by 2002:a05:6000:4024:b0:385:f220:f788 with SMTP id ffacd0b85a97d-38a873556c6mr1801999f8f.48.1736336331251;
        Wed, 08 Jan 2025 03:38:51 -0800 (PST)
Received: from krava ([213.175.46.84])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c832e74sm51984479f8f.30.2025.01.08.03.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 03:38:50 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 8 Jan 2025 12:38:48 +0100
To: Song Liu <song@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: Return error for missed kprobe multi
 bpf program execution
Message-ID: <Z35jyGWboftcEPRF@krava>
References: <20250106175048.1443905-1-jolsa@kernel.org>
 <CAPhsuW5p9C+0oLbec=bxZPvoEuPpAbDzbyPRD95ucBP=7HbO8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5p9C+0oLbec=bxZPvoEuPpAbDzbyPRD95ucBP=7HbO8A@mail.gmail.com>

On Mon, Jan 06, 2025 at 02:26:22PM -0800, Song Liu wrote:
> On Mon, Jan 6, 2025 at 9:50 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > When kprobe multi bpf program can't be executed due to recursion check,
> > we currently return 0 (success) to fprobe layer where it's ignored for
> > standard kprobe multi probes.
> >
> > For kprobe session the success return value will make fprobe layer to
> > install return probe and try to execute it as well.
> >
> > But the return session probe should not get executed, because the entry
> > part did not run. FWIW the return probe bpf program most likely won't get
> > executed, because its recursion check will likely fail as well, but we
> > don't need to run it in the first place.. also we can make this clear
> > and obvious.
> >
> > It also affects missed counts for kprobe session program execution, which
> > are now doubled (extra count for not executed return probe).
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/trace/bpf_trace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 48db147c6c7d..1f3d4b72a3f2 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2797,7 +2797,7 @@ kprobe_multi_link_prog_run(struct bpf_kprobe_multi_link *link,
> >
> >         if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
> >                 bpf_prog_inc_misses_counter(link->link.prog);
> > -               err = 0;
> > +               err = 1;
> 
> nit: Shall we return -EBUSY or some other error code?

it's processed in __fprobe_handler and it's treated as bool, so technically
it does not matter.. but I'd rather keep the 0/1 return values in here,
because it's what the session program is forced to return

thanks,
jirka

