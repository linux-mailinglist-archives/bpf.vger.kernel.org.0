Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8C0213C87
	for <lists+bpf@lfdr.de>; Fri,  3 Jul 2020 17:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgGCP3q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jul 2020 11:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgGCP3p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jul 2020 11:29:45 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEABC061794
        for <bpf@vger.kernel.org>; Fri,  3 Jul 2020 08:29:45 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id t11so9255968pfq.11
        for <bpf@vger.kernel.org>; Fri, 03 Jul 2020 08:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bapVTkxrkDSr2XwVCYXriZF3VIfxdvk4n+A7b5cGRV8=;
        b=P/DUcKMY9ZUmkYbHM3c/oGDDZoIQHKJ1bfrQLyn46foMQ3J3tT9FLhLkZlc794zPn2
         Fk++ph/LEEYCK8VFUSiccAnQUOazsmV+qDJ35SCd6PJw06pkAdBmnYn1cpRGt080A3f2
         DpJGxyvMiM5x7Gu5veUuANfXZIQTJ8OEKzpFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bapVTkxrkDSr2XwVCYXriZF3VIfxdvk4n+A7b5cGRV8=;
        b=j/BDznpzUqQCec3EVKdiSXwqwys+RXTAUVGW9AbPLK5vZGW4MDoGmK+pZJgF+32ZPW
         Noti+GKtoFatUz7osfFrNrXyzKmTFBcm1NkJ412e5mTV/34WNLcDczY1FybDuw6CEa/A
         l9xNfTGecMUvr56heMXYXya+RKGwl1kqez9eIW+Y3OB0xkHY1ll27YvgaCS4ZH0GRK2k
         wyr0+fu2gX3wF2ljxs9ti8zyanh7ne62FHPIx2DTit7/KBurYy/UPLED+bFfGgQmLsSi
         I72+3Uih6MAIAI5E4MWP3IhPk5BWeCBX3UZCwzLaMfkibyLda8iU/KmY58JQw6udbSNd
         nEpw==
X-Gm-Message-State: AOAM532XBUDs4Qco2JLW5ApsVWoRpPsUi3xZTLZ5Db1ysIpL/LfYMNaY
        qyBN17oU4kbAAuiKEBb7VrL6TA==
X-Google-Smtp-Source: ABdhPJxpcD4lKLLEtu0ZoqVhxMNd7PtMV9p8XukBzAD62b4Cw4QOUGh7aR497Xc8ltal1jh5m/p/2A==
X-Received: by 2002:a62:4e06:: with SMTP id c6mr33569844pfb.296.1593790185191;
        Fri, 03 Jul 2020 08:29:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y200sm12034670pfb.33.2020.07.03.08.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 08:29:44 -0700 (PDT)
Date:   Fri, 3 Jul 2020 08:29:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dominik Czarnota <dominik.czarnota@trailofbits.com>,
        stable@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Will Deacon <will@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matteo Croce <mcroce@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Alexander Lobakin <alobakin@dlink.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] module: Refactor section attr into bin attribute
Message-ID: <202007030818.99013B6@keescook>
References: <20200702232638.2946421-1-keescook@chromium.org>
 <20200702232638.2946421-3-keescook@chromium.org>
 <20200703060207.GA6344@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703060207.GA6344@kroah.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 03, 2020 at 08:02:07AM +0200, Greg Kroah-Hartman wrote:
> On Thu, Jul 02, 2020 at 04:26:35PM -0700, Kees Cook wrote:
> > +		sattr->battr.size = 3 /* "0x", "\n" */ + (BITS_PER_LONG / 4);
> 
> They get a correct "size" value now, nice!

Yeah, though I do have some concerns that switching to a bin attribute
changes the userspace behavior a bit. With seq_file-based "show", we
get a 4096 size, and seeking isn't possible (lseek to non-0 location
will fail). With the raw "read", we get the right size, but lseek()
is allowed (but I've got the "read" handler refuse reads starting from
non-zero). When I reviewed[1] potential readers (elftutils, systemtap,
kmod), they all seem to do normal things (fopen/fscanf/fclose), so I'm
hoping this won't be a problem in practice.

> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks!

[1] https://codesearch.debian.net/search?q=%2Fsys%2Fmodule.*sections&literal=0

-- 
Kees Cook
