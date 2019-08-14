Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F20CA8C54B
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2019 02:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfHNAv1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Aug 2019 20:51:27 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34423 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfHNAv1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Aug 2019 20:51:27 -0400
Received: by mail-qk1-f194.google.com with SMTP id m10so6087109qkk.1
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2019 17:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=e4ipHmjstA00JJ7hj0bT6ZJ9g9vJm42QWWcFx7lmVKg=;
        b=Z7bH0Q05/jJSYaqVXLS6XnoIpnn5nSaxuIb8qW8OLaxqodbgjamZV9J7Ho/yCxWAPQ
         PwhlF2xzrAu/RPUt7DVkagmLW4vskcbNM/oJXuoHbBLCLLBf6w6PMp98acqDdh7o5GeZ
         4M6cKx78TQneqsNV7J8o8BgmB5PcoCcbtw+LLnfa3LfAmLGSUhu3XwJVeukbkAsAPQT/
         6WtbQmKDaVD/rBRL+VZZUGMTgIOjHNr7KVZllz+IVuG4EaGdM+tQYUSSWJnHo4Px2UvL
         aln1Nv8o/RFcF7vLNq4k7kG4vYxc6cbR/ul8OOO1vq/4RVKwoMMoPI47oLDYee40f/Mr
         B7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=e4ipHmjstA00JJ7hj0bT6ZJ9g9vJm42QWWcFx7lmVKg=;
        b=oDB6lBP5fAkRnQ12T8nOqvq0USpn45EmtZjsbImbsQo3Uy4xEhZXtDAH5Ph+29xx/S
         Sj3CJZTwOt+hJ00qDjEuzjzemWCLQop5k0i8mbM91WhEPWelW6wPaeesDW7bQYDPhlE1
         dP0kLJMKEAIgX3JQdMD/PeLCqvHtasWAYyPM7lYP7+Ys+Cz2tB7DISUkpGiSCa16E+XH
         G444Ke/SWmMGjoS05Ov+eUk/8FjjbJKWBcLYP4tNNkG8lanBfkP5R6E/qmgAhGBwGrt1
         5hsU+2V33rrGfWebtnZlq3soYP5BCUJrY5y4sxtK19qdhCt+prYE+VAGLCDJAUEzy0Nw
         VFPg==
X-Gm-Message-State: APjAAAXaVCQrVGMR5R2fpMvG2Q3SevhdoebXy84rY1epYqP8X1gEXMOi
        NqoyC50qu1dmqHCwRsqcvN21ZA==
X-Google-Smtp-Source: APXvYqykHXwWErzsV15qk3twpCtvVkhM4RgGxXQZLNbAxwATNmAy7OtLXzM99hhTv66CbYLen4tOeg==
X-Received: by 2002:a37:be85:: with SMTP id o127mr36199045qkf.194.1565743886184;
        Tue, 13 Aug 2019 17:51:26 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id k2sm9723347qtq.84.2019.08.13.17.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 17:51:26 -0700 (PDT)
Date:   Tue, 13 Aug 2019 17:51:15 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <andrii.nakryiko@gmail.com>,
        <kernel-team@fb.com>, Andrey Ignatov <rdna@fb.com>
Subject: Re: [PATCH bpf-next] libbpf: make libbpf.map source of truth for
 libbpf version
Message-ID: <20190813175115.79383f09@cakuba.netronome.com>
In-Reply-To: <20190813232408.1246694-1-andriin@fb.com>
References: <20190813232408.1246694-1-andriin@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 13 Aug 2019 16:24:08 -0700, Andrii Nakryiko wrote:
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 9312066a1ae3..d9afc8509725 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -1,9 +1,10 @@
>  # SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>  # Most of this file is copied from tools/lib/traceevent/Makefile
>  
> -BPF_VERSION = 0
> -BPF_PATCHLEVEL = 0
> -BPF_EXTRAVERSION = 4
> +BPF_FULL_VERSION = $(shell \
> +	grep -E 'LIBBPF_([0-9]+)\.([0-9]+)\.([0-9]+) \{' libbpf.map | \
> +	tail -n1 | cut -d'_' -f2 | cut -d' ' -f1)
> +BPF_VERSION = $(firstword $(subst ., ,$(BPF_FULL_VERSION)))
>  
>  MAKEFLAGS += --no-print-directory
>  
> @@ -79,15 +80,12 @@ export prefix libdir src obj
>  libdir_SQ = $(subst ','\'',$(libdir))
>  libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
>  
> +LIBBPF_VERSION	= $(BPF_FULL_VERSION)

Perhaps better use immediate set here ':='? 
I'm not sure how many times this gets evaluated, but it shouldn't
really change either..

>  VERSION		= $(BPF_VERSION)
> -PATCHLEVEL	= $(BPF_PATCHLEVEL)
> -EXTRAVERSION	= $(BPF_EXTRAVERSION)
>  
>  OBJ		= $@
>  N		=
>  
> -LIBBPF_VERSION	= $(BPF_VERSION).$(BPF_PATCHLEVEL).$(BPF_EXTRAVERSION)
> -
>  LIB_TARGET	= libbpf.a libbpf.so.$(LIBBPF_VERSION)
>  LIB_FILE	= libbpf.a libbpf.so*
>  PC_FILE		= libbpf.pc
