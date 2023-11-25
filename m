Return-Path: <bpf+bounces-15855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9009F7F8F64
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 22:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7F8281476
	for <lists+bpf@lfdr.de>; Sat, 25 Nov 2023 21:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F6530D0F;
	Sat, 25 Nov 2023 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+zHqaYP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCB311D
	for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 13:04:51 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a02d12a2444so437187766b.3
        for <bpf@vger.kernel.org>; Sat, 25 Nov 2023 13:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700946290; x=1701551090; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EfpLawYlLaQnVqr/B5iKkWKvi+8ENF+/PZqTTGBljn0=;
        b=l+zHqaYP/FUF9V3WPKr/GUFL75mB5+WLKY5QQ1KUofPaeZc3Q2BRw9rkukRLwmQOsx
         lWbwqjAR8KqOeytQ+fUBU8TAEmz9t/uZ2Z77Q7WX9P82JZEq6dBP795uHBtsnO4SCzdA
         yCqrTIgxJ0FbMLPkJBa88gq08E3TLPzwl724rSOVS3djuxp0NhJWRC12De6dfeiYz6du
         BJ9BdPDdCVYQnIFOGpC6Qb5buNCoTMjtkVQqIuxmYJ+iKQ0FaerY+II9Xm/CBOLauh6d
         r0GscNbw3XwcXYSlUYtfXpv90KnTt4W33JFELtHcZg2ZrHuumgGht2jaYW//Hv67DqXc
         K6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700946290; x=1701551090;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EfpLawYlLaQnVqr/B5iKkWKvi+8ENF+/PZqTTGBljn0=;
        b=v+464TCwnl9FGcadc2E0DcOK9/oMLXAI6+RcaN26OwMLDa45I+nPqs6w21EVgdlWmX
         NLiV88OS1Sjz8jn/WEDlNYbb/usPlkKEosAlc0cpDQzAvI2jFnK+i1Y8dWxGJ2sWqu5g
         9T+v4ds8kvzGsuy88qJLa4HKweiO0fmnAKznE5QlAzM0jp/oFf3xlgU4Z5UVytZ7NYNc
         mdW6eiOeGRzxjesYQeyOLCzvkQxifmaW34F9FIDHfZurHIuQd20YVdShXHzpS1J9S699
         XNwfqEmp0rmFicDOZiQHYO43UsYLfVB1agT+4rWfpAvyNoHg7adWoGtRZ+MaXNhmLxX8
         JkLg==
X-Gm-Message-State: AOJu0YzyFJpsuRiv1575hNIGbzsKx62+XiBfI5y7IX4emheqOmDpaXLZ
	bHTw0yVLAssttKLOAqqrV109ymh/LbH9iw==
X-Google-Smtp-Source: AGHT+IHQe6I3Fe1+5dcOnMmP03NTU3M3jhmmw3dxbJ+2fbCFOqZwBpOAC8+ymXA7LEmU3UOPQQqgHw==
X-Received: by 2002:a17:907:3c23:b0:a02:3f1e:57e8 with SMTP id gh35-20020a1709073c2300b00a023f1e57e8mr4429887ejc.36.1700946289611;
        Sat, 25 Nov 2023 13:04:49 -0800 (PST)
Received: from erthalion.local (dslb-178-005-231-183.178.005.pools.vodafone-ip.de. [178.5.231.183])
        by smtp.gmail.com with ESMTPSA id br24-20020a170906d15800b009fd7bcd9054sm3924176ejb.147.2023.11.25.13.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 13:04:49 -0800 (PST)
Date: Sat, 25 Nov 2023 22:01:13 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev,
	dan.carpenter@linaro.org
Subject: Re: [RFC PATCH bpf-next v2] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <20231125210113.sqinphd3swowlvbb@erthalion.local>
References: <20231122191816.5572-1-9erthalion6@gmail.com>
 <CAPhsuW5A6t+g77GiOJdeK0fmshe2uKg5yLSOHEuVczhzKNTvFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW5A6t+g77GiOJdeK0fmshe2uKg5yLSOHEuVczhzKNTvFw@mail.gmail.com>

> On Sat, Nov 25, 2023 at 12:46:57PM -0800, Song Liu wrote:
> On Wed, Nov 22, 2023 at 11:22 AM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
> >
> > Currently, it's not allowed to attach an fentry/fexit prog to another
> > one of the same type. At the same time it's not uncommon to see a
> > tracing program with lots of logic in use, and the attachment limitation
> > prevents usage of fentry/fexit for performance analysis (e.g. with
> > "bpftool prog profile" command) in this case. An example could be
> > falcosecurity libs project that uses tp_btf tracing programs.
> >
> > Following the corresponding discussion [1], the reason for that is to
> > avoid tracing progs call cycles without introducing more complex
> > solutions. Relax "no same type" requirement to "no progs that are
> > already an attach target themselves" for the tracing type. In this way
> > only a standalone tracing program (without any other progs attached to
> > it) could be attached to another one, and no cycle could be formed.
>
> Actually, is it really possible to have tracing programs form a cycle?
> AFAICT, attach_prog_fd is specified at BPF_PROG_LOAD. So a
> program can never attach to another program loaded after it. Did I
> miss something? Only BPF_PROG_TYPE_EXT program can change
> target_fd at BPF_LINK_CREATE time.

Yes, I've mentioned that in the v1 thread, it doesn't look like the
actual tracing program cycle is possible currently (to test that a cycle
would be prevented I had to minimally modify few other bits of prog
lifecycle; although those changes were mostly in the verifier, I can
check about attach_prog_fd). My understanding is that the original
intent was to make everything robust against the future changes, even in
case if the code around would make cycles possible at some point.

