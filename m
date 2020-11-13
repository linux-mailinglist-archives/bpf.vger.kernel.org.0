Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8C12B2456
	for <lists+bpf@lfdr.de>; Fri, 13 Nov 2020 20:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgKMTRz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Nov 2020 14:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgKMTRz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Nov 2020 14:17:55 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEFBC0613D1;
        Fri, 13 Nov 2020 11:17:55 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 62so7846237pgg.12;
        Fri, 13 Nov 2020 11:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XXBW0bBmLsTXT6Yxa7bmTghcfTK7RHVDHVQ7u0buSxY=;
        b=vVJCzfngaYfoHchJ6jinD2XojkeeQ1Rr6EaRx4R+fe4r9CbSLBgwS8an/mxGHcIX+8
         gqqIBDyEcupPvkXwbzzLMEi6vncwOmBihKN/InTNgBIwlcFzbam+FzvqRSFhxr6HPp4j
         jh8tNeIJs3pNiJvx3Wc0rsil5mMOwzu7/2hva1wVxauYqEjRCyA84jva/hzDNM2DG/dQ
         2+d6HAbCYuK/z7gcvzJQzmWatMX0f3knD5k20oqKA6nJcKPiOHj/OXjD5gwoRzoweAYk
         W+rvdIitB5OFDVMdAWlMEvPr8vwsArsoVg7GTc/B0w59wnPK8cXc9Xh9xCSaw6v/JaUS
         3SNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XXBW0bBmLsTXT6Yxa7bmTghcfTK7RHVDHVQ7u0buSxY=;
        b=WWVStPoCr4N++X0EE4ZJfJwXjDjp7g2T558eQJC1xK/yWSFlyIa3UJex1ihbkxiszO
         h1oWl3QTq8yx3u/xMkoUpTiYinWEsiLLPwl1mSHAmjAW3UaJc3CxnKCl/5WSqBx9w6Wl
         PKKBcw2J4UJvd/lic6jLKiLxvQwMc9eXYERuDwUjHweIiUEbih1274OSCb6dARpefiOQ
         SSvvNgUS0icIZd5CDMR+39pbLkOUFtBxE4x1nfeGsqU0DA5rlgnsu6MEyzzGuWOUv4zA
         UeD9BJ9MKOcsnPvhperPww3013ZGiZo1+mvPJS40wVqVfriumoDpMMIf0emPksUjcyRt
         gopw==
X-Gm-Message-State: AOAM5303WSnOYlbK1+AXwgD1VIC+811rqFzO7j5HAVtps+gcwPqUjuYu
        G5KB4TmcDRVJpZpLFPA9oEs=
X-Google-Smtp-Source: ABdhPJwMOFXtNMWzgiSib24bM04SgIp0h7EatmOjAJzi1GgNFmJqAS6VkNEJuSwZfayUSWIIR7UxLg==
X-Received: by 2002:aa7:8744:0:b029:18b:a9e1:803d with SMTP id g4-20020aa787440000b029018ba9e1803dmr3220928pfo.50.1605295074654;
        Fri, 13 Nov 2020 11:17:54 -0800 (PST)
Received: from ast-mbp ([2620:10d:c090:400::5:b8c0])
        by smtp.gmail.com with ESMTPSA id a10sm11246946pjq.17.2020.11.13.11.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 11:17:53 -0800 (PST)
Date:   Fri, 13 Nov 2020 11:17:51 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf v5 1/2] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
Message-ID: <20201113191751.rwgv2gyw5dblhe3j@ast-mbp>
References: <cover.1605134506.git.dxu@dxuuu.xyz>
 <f5eed57b42cc077d24807fc6f2f7b961d65691e5.1605134506.git.dxu@dxuuu.xyz>
 <20201113170338.3uxdgb4yl55dgto5@ast-mbp>
 <CAHk-=wjNv9z6-VOFhpYbXb_7ePvsfQnjsH5ipUJJ6_KPe1PWVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjNv9z6-VOFhpYbXb_7ePvsfQnjsH5ipUJJ6_KPe1PWVA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 13, 2020 at 10:08:02AM -0800, Linus Torvalds wrote:
> On Fri, Nov 13, 2020 at 9:03 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > Linus,
> > I think you might have an opinion about it.
> > Please see commit log for the reason we need this fix.
> 
> Why is BPF doing this?
> 
> The thing is, if you care about the data after the strncpy, you should
> be clearing it yourself.
> 
> The kernel "strncpy_from_user()" is  *NOT* the same as "strncpy()",
> despite the name. It never has been, and it never will be. Just the
> return value being different should have given it away.
> 
> In particular, "strncpy()" is documented to zero-pad the end of the
> area. strncpy_from_user() in contrast, is documented to NOT do that.
> You cannot - and must not - depend on it.
> 
> If you want the zero-padding, you need to do it yourself. We're not
> slowing down strncpy_from_user() because you want it, because NOBODY
> ELSE cares, and you're depending on semantics that do not exist, and
> have never existed.
> 
> So if you want padding, you do something like
> 
>    long strncpy_from_user_pad(char *dst, const char __user *src, long count)
>    {
>          long res = strncpy_from_user(dst, src, count)
>          if (res >= 0)
>                 memset(dst+res, 0, count-res);
>         return res;
>    }
> 
> because BPF is doing things wrong as-is, and the problem is very much
> that BPF is relying on undefined data *after* the string.
> 
> And again - we're not slowing down the good cases just because BPF
> depends on bad behavior.

You misunderstood.
BPF side does not depend on zero padding.
The destination buffer was already initialized with zeros before the call.
What BPF didn't expect is strncpy_from_user() copying extra garbage after NUL byte.
I bet some kernel routine would be equally surprised by such behavior.
Hence I still think the fix belongs in this function.
I think the theoretical performance degradation is exactly theoretical.
The v4 approach preserves performance. It wasn't switching to byte_at_a_time:
https://patchwork.kernel.org/project/netdevbpf/patch/4ff12d0c19de63e7172d25922adfb83ae7c8691f.1604620776.git.dxu@dxuuu.xyz/
but it caused KASAN splats, since kernel usage of strncpy_from_user()
doesn't init dest array unlike bpf does.
