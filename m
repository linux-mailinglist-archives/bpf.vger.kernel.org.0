Return-Path: <bpf+bounces-13594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DAF7DB797
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 11:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74E501C204AB
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 10:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC8B10A1A;
	Mon, 30 Oct 2023 10:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4afzCSW"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8C6654
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 10:14:57 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C03420B
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 03:14:55 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso6861718a12.1
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 03:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698660894; x=1699265694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X19Gqm6HaOSFTeBTgBoiHKdq1teYWpgEoltqvIffQ0c=;
        b=E4afzCSW9UidWEnzwrQnBaQSOaAKEtNBI19VQVg6fpT+84tflf1YHf+C+rpx8PMIom
         vt7CYJ08KbWPUKpjS96iXwa0WTOpHeJOHyitxgXGG0EVh4xbDWY5DBXez/4oD5wvIZP9
         bMWfaw5JUIyV56wlhOleQcWSJcXouZwrEQJklKyhAfAG9PBuCl/VWmWAY2gW80OwwQZv
         V77d/Fz+iFj58ASX6G+5rtPLahlif3bTUQFUnsbFwllZQTN9cbfTDgdC/hdph54/eGCv
         khqN3wyZRA+Q3MUPYknkuAn17O/5f9nvj2zofblQlSaqpuEljIzpkHLegYz7K4A3/KrV
         W8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698660894; x=1699265694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X19Gqm6HaOSFTeBTgBoiHKdq1teYWpgEoltqvIffQ0c=;
        b=LewSN5/tmlBOgcl7hZMn367c3LOaMUuugBkKjHWzHBxS0Q+XYrWciGGlc1UF/tfU8z
         kill1znQNuE/Caw8UK2oFBecaTLJt4Zm+JyuR1C/RJT3nwyZFECLr/Tg27/jIwKvKBNz
         jugtOd3jIvzB0EsiPALdz/isUaYk3oEg34JvFyY1fA2SYGqoh0CkqM37DmkKI9yI8zjO
         RtIjOLmILSy6wJ59bJF6y4DPQBbh+knA/OvTB3eCiIL4uMtfeq3HhSO58CrUdXJo/J0w
         kvTP+IvQDL8MKw2fNW1A3GRBLGb894Epq65Bi8ye0kjsst9PZnlycEkX0pKLL5HXgu4n
         8IKw==
X-Gm-Message-State: AOJu0Yz06XfX9Apr9pRw5IYd1w/XOfGoZjjTY4MxbRwGj4ji4WsJxz86
	MevYHx1vgEXIMeOR5axVU8dSQ2josH4=
X-Google-Smtp-Source: AGHT+IFNe1ScYohMBY2Yw1jI9haB5ZReLh2dMcm1Zx6A6f9Fv8sD5+i+O9X/4pgJf8bLoVf7a8EJfw==
X-Received: by 2002:a05:6402:6cf:b0:53d:d4e7:af5f with SMTP id n15-20020a05640206cf00b0053dd4e7af5fmr7466954edy.13.1698660893488;
        Mon, 30 Oct 2023 03:14:53 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id z67-20020a509e49000000b00533e915923asm5978586ede.49.2023.10.30.03.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 03:14:52 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 30 Oct 2023 11:14:51 +0100
To: Jiri Pirko <jiri@resnulli.us>
Cc: bpf@vger.kernel.org
Subject: Re: kfunc use newbie question
Message-ID: <ZT+CG0cWnko5AIO8@krava>
References: <ZT94/1VlpfA231TX@nanopsycho>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZT94/1VlpfA231TX@nanopsycho>

On Mon, Oct 30, 2023 at 10:35:59AM +0100, Jiri Pirko wrote:
> Hi BPF :)
> 
> I'm trying to use bpf_dynptr_from_skb() kfunc in my program. I compiled
> it with having following declaration in the bpf .c file:
> extern int bpf_dynptr_from_skb(struct __sk_buff *skb, __u64 flags,
>                                struct bpf_dynptr *ptr__uninit) __ksym;
> 
> I have all "BPF/BTF" kernel config options on. During load,
> I'm still getting:
> 
> libbpf: failed to find BTF for extern 'bpf_dynptr_from_skb': -3

heya,
error -3 suggests there's no BTF generated, is there .BTF section
in the object ? did you compile with -g ?

jirka

> 
> I'm pretty much clueless about what may be wrong. Documentation didn't
> help me either :/
> 
> Any idea what I may be doing wrong?
> 
> Thanks
> 
> Jiri
> 

