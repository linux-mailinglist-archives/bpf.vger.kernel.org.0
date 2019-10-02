Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A046C9121
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2019 20:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfJBSwh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Oct 2019 14:52:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41437 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbfJBSwh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Oct 2019 14:52:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id f20so104419edv.8
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2019 11:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yVl3DvwCADMp64mcvKATV/e92AOrRf7vvTQmwDnOrvk=;
        b=TpyYBW2hiIXk1ZFCht2y3HJcPbCcRo2CDLEfs0/Sn6IRUDFDzcztEQ5+OP3uhfds3p
         HISNhssIt/0eInvtS1j1l6xoQDFrD9bOvfNWs6uSmd5j9jULKw+LfxVH7cawMse67ooU
         4/LWsuWbBUEhe3ALND6duir5F1uMOa9p92Dn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yVl3DvwCADMp64mcvKATV/e92AOrRf7vvTQmwDnOrvk=;
        b=QQwzXNX1KJAiR8yzXlOuHVabo8EiZaxgSHMnPNRJATrEm4Hr4OuuHcgTaS5onOL1Bx
         dOBTExgDrBMnb6AfUMwrNhjIXKfVCYKMSdSR4smfy6dbvzK9swoJJkCWRRxZedPA/QIf
         Vvnc+qk3p0x+jgdBit8cD4ha6ZiE8yv7WXxV2ar5wj1c4S9JWRyYoVSrJ2wf9Pwb07Ym
         eNbojGuvcU6hva575HeNDUEa4ypNZTULBqm5AfkUc6KFd6wmADcU1/JOLnpNpHduVj+M
         egxjnuwr4oJxIDjOfmYZxnA/jmv1z/1TUEPAoxCy80SjvuLO/ki6WuFIqurxSTiZo3UP
         KU8Q==
X-Gm-Message-State: APjAAAUEfbZ2nDX3qxM2xQMTjRvlcFYHITTHZ+qN0RGTM5UT+5lgFLc7
        dMK5ggN1YQOT2KvQr/EFVdx4bg==
X-Google-Smtp-Source: APXvYqy4nAcB23b6wdIF3ZqiDW0mlD3bK7ADCQW7GZ2ZJE4qpYFJuX+RzPLqxNkLw/iuPYQ1CM6/6Q==
X-Received: by 2002:a17:906:2ccc:: with SMTP id r12mr4383114ejr.219.1570042355474;
        Wed, 02 Oct 2019 11:52:35 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id os27sm2352181ejb.18.2019.10.02.11.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 11:52:34 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 2 Oct 2019 20:52:33 +0200
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Florent Revest <revest@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] samples/bpf: Fix broken samples.
Message-ID: <20191002185233.GA3650@chromium.org>
References: <20191002174632.28610-1-kpsingh@chromium.org>
 <20191002184506.iauttcpgyzcplope@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002184506.iauttcpgyzcplope@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02-Okt 11:45, Alexei Starovoitov wrote:
> On Wed, Oct 02, 2019 at 07:46:32PM +0200, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> > 
> > Rename asm_goto_workaround.h to asm_workaround.h and add a
> > workaround for the newly added "asm_inline" in:
> > 
> >   commit eb111869301e ("compiler-types.h: add asm_inline definition")
> > 
> > Add missing include for <linux/perf_event.h> which was removed from
> > perf-sys.h in:
> > 
> >   commit 91854f9a077e ("perf tools: Move everything related to
> > 	               sys_perf_event_open() to perf-sys.h")
> > 

I see this is already fixed in a patch that was sent yesterday and has
been Acked.

  https://lore.kernel.org/bpf/20191001112249.27341-1-bjorn.topel@gmail.com/

I will drop this change from my patch.

> > Co-developed-by: Florent Revest <revest@google.com>
> > Signed-off-by: Florent Revest <revest@google.com>
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  samples/bpf/Makefile                            |  2 +-
> >  .../{asm_goto_workaround.h => asm_workaround.h} | 17 ++++++++++++++---
> >  samples/bpf/task_fd_query_user.c                |  1 +
> >  3 files changed, 16 insertions(+), 4 deletions(-)
> >  rename samples/bpf/{asm_goto_workaround.h => asm_workaround.h} (46%)
> > 
> > diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> > index 42b571cde177..ab2b4d7ecb4b 100644
> > --- a/samples/bpf/Makefile
> > +++ b/samples/bpf/Makefile
> > @@ -289,7 +289,7 @@ $(obj)/%.o: $(src)/%.c
> >  		-Wno-gnu-variable-sized-type-not-at-end \
> >  		-Wno-address-of-packed-member -Wno-tautological-compare \
> >  		-Wno-unknown-warning-option $(CLANG_ARCH_ARGS) \
> > -		-I$(srctree)/samples/bpf/ -include asm_goto_workaround.h \
> > +		-I$(srctree)/samples/bpf/ -include asm_workaround.h \
> >  		-O2 -emit-llvm -c $< -o -| $(LLC) -march=bpf $(LLC_FLAGS) -filetype=obj -o $@
> >  ifeq ($(DWARF2BTF),y)
> >  	$(BTF_PAHOLE) -J $@
> > diff --git a/samples/bpf/asm_goto_workaround.h b/samples/bpf/asm_workaround.h
> > similarity index 46%
> > rename from samples/bpf/asm_goto_workaround.h
> > rename to samples/bpf/asm_workaround.h
> > index 7409722727ca..7c99ea6ae98c 100644
> > --- a/samples/bpf/asm_goto_workaround.h
> > +++ b/samples/bpf/asm_workaround.h
> > @@ -1,9 +1,10 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> >  /* Copyright (c) 2019 Facebook */
> > -#ifndef __ASM_GOTO_WORKAROUND_H
> > -#define __ASM_GOTO_WORKAROUND_H
> > +#ifndef __ASM_WORKAROUND_H
> > +#define __ASM_WORKAROUND_H
> 
> I don't think rename is necessary.
> This file already has a hack for volatile().
> Just add asm_inline hack to it.

Thanks, will send an update the patch to reflect this.

- KP

> 
