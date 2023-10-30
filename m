Return-Path: <bpf+bounces-13602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B687DBA7D
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 14:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2F228158A
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 13:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C0E16433;
	Mon, 30 Oct 2023 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeGZS3sl"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C9DF9E6
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 13:19:46 +0000 (UTC)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DA6C9
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 06:19:45 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507975d34e8so6428940e87.1
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 06:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698671984; x=1699276784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fZy7GnfLEuXAYdJMwdtpLjBRakptVyChQedwSz4wUMU=;
        b=HeGZS3slE3G63u98gacQAZo4vqu7M44w2sNqF+DrddjNFrKPm7ejWgvsoKB74luyb8
         N9KFvKvriERVwLHcD7zYn2bPcmByumK9UbVr6ycyl16FKTeoJLXB/eFvwUmrJvEfqZpB
         2KboFXl9ZhldomzRLU/Zpb/IFh/4sWTSY6SehYDqcZGiRl6eqJ0Z2Bzv1Ou56vA5PYYt
         ZN3j2XenfwezH2K9XGB8hYQ711vkxI7wwjz+Jhoq50VctXWH8m5WI4MNi1AOEvvF/N7E
         VDlow7GFZArAlt1Up44jNM9kmFpBpeNOK+Si6KL9ADMKxVBKnn7N8XHGmfBSUvtxdeOM
         /lsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698671984; x=1699276784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZy7GnfLEuXAYdJMwdtpLjBRakptVyChQedwSz4wUMU=;
        b=Wmzte/Tyeb4KHu/b2+vibZo28L3VJJO08DiMyz2h1SAgLuaqObyAYSnYqi/v907Q0k
         xM21DbkMRG89Id9tB5dsM6hRbdG9ZTexMZp23QENYWxXBpivOphuvoIulca2uzdmGhfG
         6ZW5bxWrWi1yEgQGGU52tOWPKWRnRkiMBKeTDLPmGSixer5jTzH99M7SZzMUXNYfPzct
         uFH4v/tVKJkFM60b/gM3+43xYIB86aKKQjDMRODUaHHdwEAt/B8gqXgTiKcpCori3UBB
         dL79a4Skubu9CCApUa83CO1rL9Jqtw3/Z76CSbDlyFrzW7pVvxDMq7bffnDFDscMcJWY
         rU2Q==
X-Gm-Message-State: AOJu0Yw/OLcQ7T9tJd/vRs45eXmdcMlfV7gRGBYn0ydCtJNQAeZdPvRf
	IZrLVvKMLIN3padtZbaqKSm9FOJwW7k=
X-Google-Smtp-Source: AGHT+IFHMvPfuEd993Fl2ojwWbNrKqGmLYO3/I55IX0qs6NmBVlrMk3xJteyDbJBsrz/g4d5dif5BA==
X-Received: by 2002:a19:5211:0:b0:507:99fe:28f3 with SMTP id m17-20020a195211000000b0050799fe28f3mr6508764lfb.34.1698671983430;
        Mon, 30 Oct 2023 06:19:43 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id cn28-20020a0564020cbc00b0054354da96e5sm265520edb.55.2023.10.30.06.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 06:19:43 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 30 Oct 2023 14:19:41 +0100
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org
Subject: Re: kfunc use newbie question
Message-ID: <ZT+tbVP29nH29gbh@krava>
References: <ZT94/1VlpfA231TX@nanopsycho>
 <ZT+CG0cWnko5AIO8@krava>
 <ZT+NNS1kgBRdfZnW@nanopsycho>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZT+NNS1kgBRdfZnW@nanopsycho>

On Mon, Oct 30, 2023 at 12:02:13PM +0100, Jiri Pirko wrote:
> Mon, Oct 30, 2023 at 11:14:51AM CET, olsajiri@gmail.com wrote:
> >On Mon, Oct 30, 2023 at 10:35:59AM +0100, Jiri Pirko wrote:
> >> Hi BPF :)
> >> 
> >> I'm trying to use bpf_dynptr_from_skb() kfunc in my program. I compiled
> >> it with having following declaration in the bpf .c file:
> >> extern int bpf_dynptr_from_skb(struct __sk_buff *skb, __u64 flags,
> >>                                struct bpf_dynptr *ptr__uninit) __ksym;
> >> 
> >> I have all "BPF/BTF" kernel config options on. During load,
> >> I'm still getting:
> >> 
> >> libbpf: failed to find BTF for extern 'bpf_dynptr_from_skb': -3
> >
> >heya,
> >error -3 suggests there's no BTF generated, is there .BTF section
> >in the object ? did you compile with -g ?
> 
> w/o -g. If I compile with -g, I'm getting this:
> libbpf: failed to find valid kernel BTF
> libbpf: Error loading vmlinux BTF: -3

hum, this one seems straightforward missing vmlinux btf,
(check btf__load_vmlinux_btf in tools/lib/bpf/btf.c)
could you please send your .config?

jirka

> 
> 
> >
> >jirka
> >
> >> 
> >> I'm pretty much clueless about what may be wrong. Documentation didn't
> >> help me either :/
> >> 
> >> Any idea what I may be doing wrong?
> >> 
> >> Thanks
> >> 
> >> Jiri
> >> 

