Return-Path: <bpf+bounces-1368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D04713FFC
	for <lists+bpf@lfdr.de>; Sun, 28 May 2023 22:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC2C280E77
	for <lists+bpf@lfdr.de>; Sun, 28 May 2023 20:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35106129;
	Sun, 28 May 2023 20:02:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4C5611B
	for <bpf@vger.kernel.org>; Sun, 28 May 2023 20:02:56 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13144A8;
	Sun, 28 May 2023 13:02:55 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-970028cfb6cso521288166b.1;
        Sun, 28 May 2023 13:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685304173; x=1687896173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zo6CAhX/gKpTGl7xNzss4y9YGs7PPZhQ0B+6ZO4rHpo=;
        b=lmyAX8YvijPl9JTnu/+1ez+IEbz4YIX0RKM0OEzi8J793Xt/s9RCgCl7j/nm2Ge50J
         kKYDFBKL9WNE87XQdkgWWJiFktlw7XZpElXXGp/XQ9XBJ1EFmxgWgCHelRV1wqjbdrV4
         AngIoQgk1xxWX/Cdw3tiTOu4g1ZI6pWpjvF8s2ckLO5giUYibQaVO+NC5FdWYE4nenO9
         +FHom1aw+edwFW6s0Y+QaUhHtRAifMTuj2HGIyRgmUFrjwIv9iMAjEW6kuEYYnhFO9tY
         xyLM63K5Zzg92QWMHd2aO4qscr9I2wK/Q8PzFPeH4rybNacWDLqFBFrmnjhi9BxQ4hIr
         j2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685304173; x=1687896173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zo6CAhX/gKpTGl7xNzss4y9YGs7PPZhQ0B+6ZO4rHpo=;
        b=eeb9lHRvkJGIkUGJ2I45xkApmYT5172Sjvr2t1BeAgFI9f4It4XknE2dODpX6HR0Dz
         YCNTiYEP3xzdcZJ9DiOv9DcI5oYL0/izjBXIKQiRQ7BN+2Bu5rltvYStqkbYCUrV1IlL
         a74KcRUMLRptfAJjCBEhTLRS2rY01aOQVi3ZTyHXm+GjX/NTw0vuiIy0tPFvEplMhAV7
         g3dvbbgrT3JQe7BaSV3/bDCMp/VYdSMz/hivHt3u0+TsjksHz1nYZjNdI+/2nJRe5U8b
         KBwBCs53G7pF/Cd8SjHOpqrmnDVU1a0vV7lwCGJmOQgZ7hoJWquDf2ag4YiOYl9amZsU
         gjag==
X-Gm-Message-State: AC+VfDzwYF+MojJipuFEr00l78b1t0DEKSZeQ0Ein9suvPh9q92KnR5O
	iXrctYXVz3QaGgRC0MqKf1Y=
X-Google-Smtp-Source: ACHHUZ7amSCeEjsuTpePFIraYwQK5RrXHcbx6rWKwrU9eJeY6Nyzlnvs4W+vU8kdZC3CUytueRKAyw==
X-Received: by 2002:a17:907:7251:b0:973:d953:4bf7 with SMTP id ds17-20020a170907725100b00973d9534bf7mr6095191ejc.48.1685304173207;
        Sun, 28 May 2023 13:02:53 -0700 (PDT)
Received: from krava ([83.240.62.205])
        by smtp.gmail.com with ESMTPSA id v19-20020a1709060b5300b0096621340285sm5027344ejg.198.2023.05.28.13.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 13:02:52 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 28 May 2023 22:02:49 +0200
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tsahee Zidenberg <tsahee@annapurnalabs.com>,
	Andrii Nakryiko <andrii@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?iso-8859-1?Q?Mah=E9?= Tardy <mahe.tardy@isovalent.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH stable 5.4 0/8] bpf: Fix
 bpf_probe_read/bpf_probe_read_str helpers
Message-ID: <ZHOzaStC0WmTvwL9@krava>
References: <20230522203352.738576-1-jolsa@kernel.org>
 <2023052646-magnetize-equate-2b24@gregkh>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023052646-magnetize-equate-2b24@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 26, 2023 at 07:54:17PM +0100, Greg KH wrote:
> On Mon, May 22, 2023 at 10:33:44PM +0200, Jiri Olsa wrote:
> > hi,
> > we see broken access to user space with bpf_probe_read/bpf_probe_read_str
> > helpers on arm64 with 5.4 kernel. The problem is that both helpers try to
> > read user memory by calling probe_kernel_read, which seems to work on x86
> > but fails on arm64.
> 
> Has this ever worked on arm64 for the 5.4 kernel tree?  If not, it's not
> really a regression, and so, why not use a newer kernel that has this
> new feature added to it there?
> 
> In other words, what requires you to use the 5.4.y tree and requires
> feature parity across architectures?

we have a customer running ok on x86 v5.4, but arm64 is broken with
the same bpf/user space code

upgrade is an option of course, but it's not a big change and we can
have 5.4 working on arm64 as well

I can send out the change that will be closer to upstream changes,
if that's a concern.. with adding the new probe helpers, which I
guess is not a problem, because it does not change current API

jirka

