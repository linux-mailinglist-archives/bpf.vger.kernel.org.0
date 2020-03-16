Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE131874AA
	for <lists+bpf@lfdr.de>; Mon, 16 Mar 2020 22:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbgCPVYC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Mar 2020 17:24:02 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55363 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732567AbgCPVYC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Mar 2020 17:24:02 -0400
Received: by mail-pj1-f65.google.com with SMTP id mj6so8844174pjb.5
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2020 14:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k6XAwrWDY/zsycDAo2K53Vl70GhIjA99tBrFA4ZGhTE=;
        b=Z4fiWqfQ8XqKDmI6T07Gvt9pSMGVDJUgyS7JXSsUrxYXw5wRk0V8uSAvIqRruGXw0p
         HJuR1b+QA5U1tbigOvOVLQ4OgbkYu4GefP+XZUhBtOVBKbOY/TueH94wGRDdLo1r9nve
         DPmbJMLt1BiluEmWC3f8a1Tkp1qIPaTIIKm9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k6XAwrWDY/zsycDAo2K53Vl70GhIjA99tBrFA4ZGhTE=;
        b=AtOS7u3FegFy46+4am/zRAl6rBkSZ6cCp4wx9EsPXppUvWdV5F8ZHygOJWgmfyyPp1
         1Xf9y53aYW9iuqywb00i9RoGG+fqj9e4H7b66LTxPw1fY91rx8jbrxLHWkd+W/VQV5AJ
         +PZvP70/5Zf8aAVPopd38Dh6rojFmYaCNODueMYqr+pWUtuUJnBRFZaxeP+pNp8koh4o
         huy9IU0W7g8rJzPJNgod8vQ/7NuKyNRuSsA/h59LV9d7YkoczEf5X8pI+43fsC6Tk3bK
         tOifJjoxHVyiKob7OEfv6PPujP4+rxDdrw7Pja5iSz6glRCrY4ve36wNe9baXIcr3TOe
         d6JA==
X-Gm-Message-State: ANhLgQ1WC1vYfk3JjDF2Y7w+6raa/hOXZOLoB7tOmP1VGX+bJmImMn5F
        JwqwscU10Ha9GHlF9UGXOym3Ng==
X-Google-Smtp-Source: ADFU+vs68X9RkPUqkATV2iQxMOvZU1EVi/eKUQuxzDFOyagTnzRG37PM75ufsijB+ukeVItkeM7R/g==
X-Received: by 2002:a17:90a:c08f:: with SMTP id o15mr1552021pjs.155.1584393841314;
        Mon, 16 Mar 2020 14:24:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u26sm749763pfh.193.2020.03.16.14.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 14:24:00 -0700 (PDT)
Date:   Mon, 16 Mar 2020 14:23:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Anton Protopopov <a.s.protopopov@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Subject: Re: [PATCH] seccomp: allow BPF_MOD ALU instructions
Message-ID: <202003161423.B51FDA8083@keescook>
References: <20200316163646.2465-1-a.s.protopopov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316163646.2465-1-a.s.protopopov@gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 16, 2020 at 04:36:46PM +0000, Anton Protopopov wrote:
> The BPF_MOD ALU instructions could be utilized by seccomp classic BPF filters,
> but were missing from the explicit list of allowed calls since its introduction
> in the original e2cfabdfd075 ("seccomp: add system call filtering using BPF")
> commit.  Add support for these instructions by adding them to the allowed list
> in the seccomp_check_filter function.
> 
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>

This has been suggested in the past, but was deemed ultimately redundant:
https://lore.kernel.org/lkml/201908121035.06695C79F@keescook/

Is there a strong reason it's needed?

Thanks!

-Kees

> ---
>  kernel/seccomp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index b6ea3dcb57bf..cae7561b44d4 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -206,6 +206,8 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
>  		case BPF_ALU | BPF_MUL | BPF_X:
>  		case BPF_ALU | BPF_DIV | BPF_K:
>  		case BPF_ALU | BPF_DIV | BPF_X:
> +		case BPF_ALU | BPF_MOD | BPF_K:
> +		case BPF_ALU | BPF_MOD | BPF_X:
>  		case BPF_ALU | BPF_AND | BPF_K:
>  		case BPF_ALU | BPF_AND | BPF_X:
>  		case BPF_ALU | BPF_OR | BPF_K:
> -- 
> 2.19.1

-- 
Kees Cook
