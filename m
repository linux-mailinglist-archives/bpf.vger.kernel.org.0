Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D30E019A642
	for <lists+bpf@lfdr.de>; Wed,  1 Apr 2020 09:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731849AbgDAHcd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Apr 2020 03:32:33 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:40102 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731725AbgDAHcc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Apr 2020 03:32:32 -0400
Received: by mail-pl1-f175.google.com with SMTP id h11so9263281plk.7
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2020 00:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Q2zlprsjpvbH/CUCgF6/KaFZrKtD3zRPUib4YqmUolQ=;
        b=eH7GQi4Fb+gecHNihtjNMlPCkT58qolygnegnhh5hSJE1vBUBJ66LNnElFLF0DunMT
         FDAwRc5Hey0enMXIuTw8vOI9JR6u+IfleFr/zhPd9/fbIfhyQFu1uS1hiiX8gUWqR+RG
         PBAMcJAeTHpk9Uk9APR8+Vb/7wsuXYEM+S8fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Q2zlprsjpvbH/CUCgF6/KaFZrKtD3zRPUib4YqmUolQ=;
        b=ZHDYNGfLGn2wAgPqinDiYbDS9y1tfpCmS2ancXJr2g8jE98/ebxlnTInZXbZVCdSNB
         WVmFGKnXXpSiLI6mJ1eSH5e9sgcoM42Y51OpGhjPLGPNmOExoDYiTOeOGrMySmB8YXRN
         GA0a83cvA+k4qDDzkJSHQZXfqRVqODA6TuLaNbJ46mVhGjBQTBgeEs+N+L7AcxH1LaYb
         858WqsG37eIl1dagNiJyqlPAITBawoLdrlOBfNJ/Rck2rU+QNMZ9RXByuA6bqhPgYrFo
         /+o/mFXlzSn1xIgbNrC2CTB7pD95ivhJRtqsFNDdMAbXm/yPk7SnUZITVKlHaBNcfnMO
         SrsQ==
X-Gm-Message-State: AGi0Pub0laHAetsPL8vdtvHlcitGcIZgWWQstaHYZtElFdoj4ka+7RMx
        JFRb7KRpnAjLCgIJofP4M9mxcA==
X-Google-Smtp-Source: APiQypKmwoN+WlTZJjmydYo5ouItfzTZNL+lOANxC/eXYfxIziyQqxNU1yxknZE8OOqBHFK5Z7Q0QA==
X-Received: by 2002:a17:90b:4396:: with SMTP id in22mr3252194pjb.10.1585726350003;
        Wed, 01 Apr 2020 00:32:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k17sm911825pfp.194.2020.04.01.00.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 00:32:29 -0700 (PDT)
Date:   Wed, 1 Apr 2020 00:32:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Slava Bacherikov <slava@bacher09.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jann Horn <jannh@google.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: CONFIG_DEBUG_INFO_BTF and CONFIG_GCC_PLUGIN_RANDSTRUCT
Message-ID: <202004010029.167BA4AA1F@keescook>
References: <CAG48ez2sZ58VQ4+LJu39H1M0Y98LhRYR19G_fDAPJPBf7imxuw@mail.gmail.com>
 <CAADnVQ+Ux3-D_7ytRJx_Pz4fStRLS1vkM=-tGZ0paoD7n+JCLQ@mail.gmail.com>
 <CAG48ez0ajun-ujQQqhDRooha1F0BZd3RYKvbJ=8SsRiHAQjUzw@mail.gmail.com>
 <202003301016.D0E239A0@keescook>
 <c332da87-a770-8cf9-c252-5fb64c06c17e@iogearbox.net>
 <202003311110.2B08091E@keescook>
 <CAEf4BzYZsiuQGYVozwB=7nNhVYzCr=fQq6PLgHF3M5AXbhZyig@mail.gmail.com>
 <202003311257.3372EC63@keescook>
 <CAEf4BzYODtQtuO79BAn-m=2n8QwPRLd74UP-rwivHj6uLk3ycA@mail.gmail.com>
 <8962ffa8-69b7-ab6b-3969-3029a95dfcec@bacher09.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8962ffa8-69b7-ab6b-3969-3029a95dfcec@bacher09.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 01, 2020 at 12:24:46AM +0300, Slava Bacherikov wrote:
> 31.03.2020 23:23, Andrii Nakryiko пишет:
> > On Tue, Mar 31, 2020 at 12:58 PM Kees Cook <keescook@chromium.org> wrote:
> >> Sure! That'd by fine by me. I'd just like it to be a "|| COMPILE_TEST"
> >> for GCC_PLUGIN_RANDSTRUCT. Feel free to CC me for an Ack. :)
> >>
> > 
> > +cc Slava
> > 
> > I'm unsure what COMPILE_TEST dependency (or is it anti-dependency?)
> > has to do with BTF generation and reading description in Kconfig
> > didn't clarify it for me. Can you please elaborate just a bit? Thanks!
> > 
> >> -Kees
> 
> Hi,
> 
> Regarding COMPILE_TEST, DEBUG_INFO has dependency on:
> 
> DEBUG_KERNEL && !COMPILE_TEST
> 
> And DEBUG_INFO_BTF depends on DEBUG_INFO, so enabling COMPILE_TEST
> would block DEBUG_INFO and so DEBUG_INFO_BTF as well. Unless I don't
> understand something and there is some other reason to add it.

I meant that if you're adjusting the depends for GCC_PLUGIN_RANDSTRUCT,
I'd like it to be:

	depends on COMPILE_TEST || !DEBUG_INFO

That way randconfig, all*config, etc, will still select
GCC_PLUGIN_RANDSTRUCT with everything else, regardless of DEBUG_INFO.

-- 
Kees Cook
