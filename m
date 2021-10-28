Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B4543DAB2
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 07:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhJ1FTe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 01:19:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44661 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229836AbhJ1FTc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 28 Oct 2021 01:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635398225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tZgx1Bu9hAX0UQlH/oNEZR1u/6d60fhGvlu287SMYxE=;
        b=X9m7q9rj+Mg++98+g4+8yr+yDqliItJBeg7XdOFH1ksL8D4huTNKr2YvRwfUMWcvTb1W8z
        MR6bygN8DCYtxM6dihiLEi4hRGj3Wpl6z9iXFVoEP+Crdnrf4/jEGca3OBNawd29IkmsP9
        RTBFM2p3V5pu1NtVAYbvHYFuI2InY5g=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-lDJdbXAGMj-iVYYaOsg0IA-1; Thu, 28 Oct 2021 01:17:04 -0400
X-MC-Unique: lDJdbXAGMj-iVYYaOsg0IA-1
Received: by mail-qk1-f199.google.com with SMTP id l27-20020a05620a211b00b0045fbe374e2dso3148058qkl.10
        for <bpf@vger.kernel.org>; Wed, 27 Oct 2021 22:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tZgx1Bu9hAX0UQlH/oNEZR1u/6d60fhGvlu287SMYxE=;
        b=TBsQd4jF/70+eg9R3MlxRVIMdZayKndb9t2gFMjN9f/qoLSQA9p/lt0H4e4X56AvVx
         41S4TmambKFE+4r6SDklb/j7/95bYXVCiITSE2OE+mSaEiCvPuChK/ftnbyXE9X5bkHu
         yEbk2ERobSmc2pRlHURU3L6b9+bpAicQt4Wwiv1XI6oXXZgE6DbVetKJYMF4yi0uy3y1
         B0cA5LXOFuTMZG83W5jqnxWFBVhRkqzZvho25obeKdaZhsiwca81uDKpO1DXL82a1qRM
         vXPmJln4SeOma5juFflwFhVsMkG4nDmZFdXxUkIGqCfbdih8zgoxQDflbLCIOnhk0Wyd
         c6MQ==
X-Gm-Message-State: AOAM5308pQevdUa9zcwr3ZfSC/yal45Jv9vKoxAzgJm8e9oEgP/NHXpn
        2DxbLPbjSR9xZMNJ1GKupQzklRERo+wmGyr7sMQoi7UtWno3YAQ9stD79d4TlwIdeB4KHgia9zY
        RvFy+bLi7nd7L
X-Received: by 2002:a05:6214:248c:: with SMTP id gi12mr1833330qvb.14.1635398223791;
        Wed, 27 Oct 2021 22:17:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWTRGwYuG19Z+rsjyARLbj2Vq6k9UfVrQ10HGj0EwOZqM/1BTu+meVUyc4pklM6muZk3P/oQ==
X-Received: by 2002:a05:6214:248c:: with SMTP id gi12mr1833313qvb.14.1635398223558;
        Wed, 27 Oct 2021 22:17:03 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id g10sm1423680qko.38.2021.10.27.22.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 22:17:03 -0700 (PDT)
Date:   Wed, 27 Oct 2021 22:17:00 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com, bpf@vger.kernel.org
Subject: Re: [PATCH v3 00/16] x86: Rewrite the retpoline rewrite logic
Message-ID: <20211028051700.id3nbzextq6oevr5@treble>
References: <20211026120132.613201817@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211026120132.613201817@infradead.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 26, 2021 at 02:01:32PM +0200, Peter Zijlstra wrote:
> Hi,
> 
> These patches rewrite the way retpolines are rewritten. Currently objtool emits
> alternative entries for most retpoline calls. However trying to extend that led
> to trouble (ELF files are horrid).
> 
> Therefore completely overhaul this and have objtool emit a .retpoline_sites
> section that lists all compiler generated retpoline thunk calls. Then the
> kernel can do with them as it pleases.
> 
> Notably it will:
> 
>  - rewrite them to indirect instructions for !RETPOLINE
>  - rewrite them to lfence; indirect; for RETPOLINE_AMD,
>    where size allows (boo clang!)
> 
> Specifically, the !RETPOLINE case can now also deal with the clang-special
> conditional-indirect-tail-call:
> 
>   Jcc __x86_indirect_thunk_\reg.
> 
> Finally, also update the x86 BPF jit to catch up to recent times and do these
> same things.
> 
> All this should help improve performance by removing an indirection.
> 
> Patches can (soon) be found here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git objtool/core
> 
> Changes since v2:
> 
>  - rewrite the __x86_indirect_thunk_array[] stuff again
>  - rewrite the retpoline,amd rewrite logic, it now also supports
>    rewriting the Jcc case, if the original instruction is long enough, but
>    more importantly, it's simpler code.
>  - bpf label simplification patch
>  - random assorted cleanups
>  - actually managed to get bpf selftests working

Good stuff!

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

