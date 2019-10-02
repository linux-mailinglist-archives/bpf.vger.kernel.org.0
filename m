Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCCFC9109
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2019 20:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfJBSpL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Oct 2019 14:45:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33696 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfJBSpL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Oct 2019 14:45:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id q1so24747pgb.0;
        Wed, 02 Oct 2019 11:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=13XjhSMoHUotvnT/6gwxwCtrPn3U5+PA5KF+bM08Ss0=;
        b=YRfnqiN3dWX/UrQ6CZOPA/blP8louSmAQ6zZCzZP0U2fmjHo1pHrlyc+dPrVes9OL5
         qYOEc8n7g2QXcas0+eyI9fXplBpjNuvhSiubE2FCT41tjt1oKujdHC7fbqyXjooCdkLv
         cY5pKiqwv+gW4sqMwaowfquV60QrJbIRf3AO6FTP1msiql0PpC4He+32d9yt0zY3tVoV
         FxqwNe7IvDy5Oa4151la5BatjlGZpyrZ3U58Kb84JB1MHEFWPX5vkZJyWUPY9Vn2aIgN
         Xpx9wj3bksnWsIqPcoDzo1P9+GJLOa2s7waBCAYOXM9p84c+bcBPzYgAR1gcsapAZsHk
         ErWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=13XjhSMoHUotvnT/6gwxwCtrPn3U5+PA5KF+bM08Ss0=;
        b=EF8qo+N+MC9SJBQrzlFy1EIr8/UWorUMcmI3PnDeGQkP4ZDtStAQ2nsjZsdu/m370Q
         WiKWzZslHYnEhsFBhQ+h9VdcVu0knMhqZVwK20LgJRuRwKiH+6IfIplRE6G9dRfO9Jh2
         1b6VhqqrixWc8NF1z3gXJzInNzrflhxonReXh5vlDKiHXBgCdenkIIoXiYOc7jLvBd/9
         WCH6uLpHIi62ERMiuvzOEw1cznA2hGOYCWAhLN3FENZDV1+Kd9HegRtT3qcHJ+1oRbBg
         pEhHL2bl3NW/cxbzH7hUreVj673QEpBCmTBP59QIB2XhlTTBP+PXRjRUHaDj45Ex1nVY
         6K0Q==
X-Gm-Message-State: APjAAAX4m5aEA5U+nT3sPng+DmmPzNxT192N7MruoQ5r/l7Zr5oMxEzx
        h6SeuNMdM62QNJsr6sAOtlfz5E90
X-Google-Smtp-Source: APXvYqx80cVbYWHFmM2bz4jjyJYogCOlPZwpPDUVGOIM8XYwhneMKU4TZJmTvcQKOEFP+f+2/jwNUg==
X-Received: by 2002:a62:8142:: with SMTP id t63mr6402522pfd.246.1570041910288;
        Wed, 02 Oct 2019 11:45:10 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::1:2790])
        by smtp.gmail.com with ESMTPSA id q2sm176804pfg.144.2019.10.02.11.45.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Oct 2019 11:45:09 -0700 (PDT)
Date:   Wed, 2 Oct 2019 11:45:08 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     KP Singh <kpsingh@chromium.org>
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
Message-ID: <20191002184506.iauttcpgyzcplope@ast-mbp.dhcp.thefacebook.com>
References: <20191002174632.28610-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002174632.28610-1-kpsingh@chromium.org>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 02, 2019 at 07:46:32PM +0200, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Rename asm_goto_workaround.h to asm_workaround.h and add a
> workaround for the newly added "asm_inline" in:
> 
>   commit eb111869301e ("compiler-types.h: add asm_inline definition")
> 
> Add missing include for <linux/perf_event.h> which was removed from
> perf-sys.h in:
> 
>   commit 91854f9a077e ("perf tools: Move everything related to
> 	               sys_perf_event_open() to perf-sys.h")
> 
> Co-developed-by: Florent Revest <revest@google.com>
> Signed-off-by: Florent Revest <revest@google.com>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  samples/bpf/Makefile                            |  2 +-
>  .../{asm_goto_workaround.h => asm_workaround.h} | 17 ++++++++++++++---
>  samples/bpf/task_fd_query_user.c                |  1 +
>  3 files changed, 16 insertions(+), 4 deletions(-)
>  rename samples/bpf/{asm_goto_workaround.h => asm_workaround.h} (46%)
> 
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 42b571cde177..ab2b4d7ecb4b 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -289,7 +289,7 @@ $(obj)/%.o: $(src)/%.c
>  		-Wno-gnu-variable-sized-type-not-at-end \
>  		-Wno-address-of-packed-member -Wno-tautological-compare \
>  		-Wno-unknown-warning-option $(CLANG_ARCH_ARGS) \
> -		-I$(srctree)/samples/bpf/ -include asm_goto_workaround.h \
> +		-I$(srctree)/samples/bpf/ -include asm_workaround.h \
>  		-O2 -emit-llvm -c $< -o -| $(LLC) -march=bpf $(LLC_FLAGS) -filetype=obj -o $@
>  ifeq ($(DWARF2BTF),y)
>  	$(BTF_PAHOLE) -J $@
> diff --git a/samples/bpf/asm_goto_workaround.h b/samples/bpf/asm_workaround.h
> similarity index 46%
> rename from samples/bpf/asm_goto_workaround.h
> rename to samples/bpf/asm_workaround.h
> index 7409722727ca..7c99ea6ae98c 100644
> --- a/samples/bpf/asm_goto_workaround.h
> +++ b/samples/bpf/asm_workaround.h
> @@ -1,9 +1,10 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /* Copyright (c) 2019 Facebook */
> -#ifndef __ASM_GOTO_WORKAROUND_H
> -#define __ASM_GOTO_WORKAROUND_H
> +#ifndef __ASM_WORKAROUND_H
> +#define __ASM_WORKAROUND_H

I don't think rename is necessary.
This file already has a hack for volatile().
Just add asm_inline hack to it.

