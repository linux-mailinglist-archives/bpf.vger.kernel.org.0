Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1576424C747
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 23:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbgHTVqF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 17:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbgHTVqB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Aug 2020 17:46:01 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35F9C061385
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 14:46:00 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y206so11471pfb.10
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 14:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lAdAyYh5aN2j5JPQrGtT0EfFNZkeh1mFjZ/MnX14mHg=;
        b=jqlWDd6sxFDmFJ/KUiqRGFnNyGKWDiNJLpoSwupzugFLhqCN9ZS6qtccF0An5Z2pAp
         nwBWlzga+bXknE60CNsiILhMirgchDDV2Vj7hY7IEMtxh8h6VGzn+3wNGo2+F7ea9pJx
         uume6sU6+RSqa4UeUUuBxrG3vOAzelifZxGgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lAdAyYh5aN2j5JPQrGtT0EfFNZkeh1mFjZ/MnX14mHg=;
        b=RtONRuuxD/fD5vJQaSA639PzzqkGpKksWxxzP191pS/mAHH995AOHXwEf06jAxfU/A
         tG0HEpuvDOwTVkSAesAgTObymzq6mPhY/Yrlospr8TPuHGnECTAwdUh0+1dvVrAxyFVQ
         IMbQC0F3u5jV165IzBcB5lNgMGKc821rYrtbQw84WWx7DtAlbwWSJQe6gZt2Gp0gZ6jj
         /TqCsh35y+hBxVNo/+hZDV1cMeb1QvrspMDVkV/7S5k+jMySaFI36yBbk7BIARo6tKG6
         0xJymGFhs0H6C3CY6NWAujB7yiTvYIaK56qVUrx/Wgf/CETjQ44PvV6FBThpHaaq7JOv
         TFrg==
X-Gm-Message-State: AOAM532gWOlUx0qmX96uu+U01BfweJfmMzGC5B5GXGTSHpXCVovcf3aO
        zRGCVFOdB1ftXYTrHi2ywt5ku6B52v08zQ==
X-Google-Smtp-Source: ABdhPJy7ns/mk8REZldx/9DoA3Zk3IWns4swu15vQGd9bLEgzAMf1K45e88Ruhw0luZiFw52DoX76w==
X-Received: by 2002:a65:66c4:: with SMTP id c4mr64065pgw.442.1597959959876;
        Thu, 20 Aug 2020 14:45:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k21sm4159pgl.0.2020.08.20.14.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 14:45:58 -0700 (PDT)
Date:   Thu, 20 Aug 2020 14:45:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Jackman <jackmanb@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Paul Renauld <renauld@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>, pjt@google.com,
        jannh@google.com, peterz@infradead.org, rafael.j.wysocki@intel.com,
        thgarnie@chromium.org, kpsingh@google.com,
        paul.renauld.epfl@gmail.com, Brendan Jackman <jackmanb@google.com>
Subject: Re: [RFC] security: replace indirect calls with static calls
Message-ID: <202008201435.97CF8296@keescook>
References: <20200820164753.3256899-1-jackmanb@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200820164753.3256899-1-jackmanb@chromium.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 20, 2020 at 06:47:53PM +0200, Brendan Jackman wrote:
> From: Paul Renauld <renauld@google.com>
> 
> LSMs have high overhead due to indirect function calls through
> retpolines. This RPC proposes to replace these with static calls [1]

typo: RFC

> instead.

Yay! :)

> [...]
> This overhead prevents the adoption of bpf LSM on performance critical
> systems, and also, in general, slows down all LSMs.

I'd be curious to see other workloads too. (Your measurements are a bit
synthetic, mostly showing "worst case": one short syscall in a tight
loop. I'm curious how much performance gain can be had -- we should
still do it, it'll be a direct performance improvement, but I'm curious
about "real world" impact too.)

> [...]
> Previously, the code for this hook would have looked like this:
> 
> 	ret = DEFAULT_RET;
> 
>         for each cb in [A, B, C]:
>                 ret = cb(args); <--- costly indirect call here
>                 if ret != 0:
>                         break;
> 
>         return ret;
> 
> Static calls are defined at build time and are initially empty (NOP
> instructions). When the LSMs are initialized, the slots are filled as
> follows:
> 
>  slot idx     content
>            |-----------|
>     0      |           |
>            |-----------|
>     1      |           |
>            |-----------|
>     2      |   call A  | <-- base_slot_idx = 2
>            |-----------|
>     3      |   call B  |
>            |-----------|
>     4      |   call C  |
>            |-----------|
> 
> The generated code will unroll the foreach loop to have a static call for
> each possible LSM:
> 
>         ret = DEFAULT_RET;
>         switch(base_slot_idx):
> 
>                 case 0:
>                         NOP
>                         if ret != 0:
>                                 break;
>                         // fallthrough
>                 case 1:
>                         NOP
>                         if ret != 0:
>                                 break;
>                         // fallthrough
>                 case 2:
>                         ret = A(args); <--- direct call, no retpoline
>                         if ret != 0:
>                                 break;
>                         // fallthrough
>                 case 3:
>                         ret = B(args); <--- direct call, no retpoline
>                         if ret != 0:
>                                 break;
>                         // fallthrough
> 
>                 [...]
> 
>                 default:
>                         break;
> 
>         return ret;
> 
> A similar logic is applied for void hooks.
> 
> Why this trick with a switch statement? The table of static call is defined
> at compile time. The number of hook callbacks that will be defined is
> unknown at that time, and the table cannot be resized at runtime.  Static
> calls do not define a conditional execution for a non-void function, so the
> executed slots must be non-empty.  With this use of the table and the
> switch, it is possible to jump directly to the first used slot and execute
> all of the slots after. This essentially makes the entry point of the table
> dynamic. Instead, it would also be possible to start from 0 and break after
> the final populated slot, but that would require an additional conditional
> after each slot.

Instead of just "NOP", having the static branches perform a jump would
solve this pretty cleanly, yes? Something like:

	ret = DEFAULT_RET;

	ret = A(args); <--- direct call, no retpoline
	if ret != 0:
		goto out;

	ret = B(args); <--- direct call, no retpoline
	if ret != 0:
		goto out;

	goto out;
	if ret != 0:
		goto out;

out:
	return ret;


> [...]
> The number of available slots for each LSM hook is currently fixed at
> 11 (the number of LSMs in the kernel). Ideally, it should automatically
> adapt to the number of LSMs compiled into the kernel.

Seems like a reasonable thing to do and could be a separate patch.

> If there’s no practical way to implement such automatic adaptation, an
> option instead would be to remove the panic call by falling-back to the old
> linked-list mechanism, which is still present anyway (see below).
> 
> A few special cases of LSM don't use the macro call_[int/void]_hook but
> have their own calling logic. The linked-lists are kept as a possible slow
> path fallback for them.

I assume you mean the integrity subsystem? That just needs to be fixed
correctly. If we switch to this, let's ditch the linked list entirely.
Fixing integrity's stacking can be a separate patch too.

> [...]
> Signed-off-by: Paul Renauld <renauld@google.com>
> Signed-off-by: KP Singh <kpsingh@google.com>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

This implies a maintainership chain, with Paul as the sole author. If
you mean all of you worked on the patch, include Co-developed-by: as
needed[1].

-Kees

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

-- 
Kees Cook
