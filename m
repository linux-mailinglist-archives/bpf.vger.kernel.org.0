Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D2E4356D2
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 02:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhJUAU3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 20:20:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29449 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229702AbhJUAU3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Oct 2021 20:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634775493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y9Y7hzxIeRjzddapp4B4sp40weziP9X+IKnwKSW55pQ=;
        b=GlT5VaAvAnnvr96/6E9XyoVLltUHvXWxlAMu/HRce0vb5WiIQTZ4WOlh35fGRBpj9twKBq
        P02VyI+c8YqvGlC7mudnElkv0XBz4bFT6IbQqum7OFsx+5h54CFDEHaSjub4GHGAZ6EP4V
        rO8a4jejxm1P8X6+M4EFMqs+1mh6GlI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-RPXBRcg8O-ixl6PAcWyULA-1; Wed, 20 Oct 2021 20:18:12 -0400
X-MC-Unique: RPXBRcg8O-ixl6PAcWyULA-1
Received: by mail-qk1-f199.google.com with SMTP id y5-20020ae9f405000000b0045fa3120bebso3318401qkl.17
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 17:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y9Y7hzxIeRjzddapp4B4sp40weziP9X+IKnwKSW55pQ=;
        b=Uz0x2TrJkZxJS3BWaY7HJWnrtBv0ZhDoayH68rFksJZjPKjc+yFxpMoc59htfEXM4C
         bAE8v6S6z29Vx8G/ltg9pjV3u1+5F4zo9axxXkx0iGAdRp5BBTEcacYrzFYZTznKufru
         o9cH8I76nbEe5M8YyPItC6L9hB4qL3oShGpPKfJ38lKLVJZ4dCNz0Jg50CA8D7z97xo5
         Xm3gk3UCFqQPJeBwN5mdx/7C5Y0eF8c+5/VWe6JSwha/8hUXE95EG0NtQoFi5IQUuMAC
         eiuAJ7k5FnXRCckX7YvrMpqtN1pKwak+mS2NcKlLehyMDgea+XR5VZSwkyfmKz20/Vw7
         +VSw==
X-Gm-Message-State: AOAM533DDk1UpWaf9tP66HZHWJvRoCAQ3F1G6XMI1JbeyjOriomHnzFh
        iTC8zqhQeoamnxrk78lkcPmtlP9uYKyj9iVct4vcrBUTwy2atTThkylWsIzmTENFxvMPKykZwLJ
        n19nI6ssOiTSg
X-Received: by 2002:ac8:183:: with SMTP id x3mr2726876qtf.270.1634775492170;
        Wed, 20 Oct 2021 17:18:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQH+mIBiVII1WLYqbEa5sUX+3H1BU4XLVzKDhQhE2Xyezhpp8g8l/1LyqVY4fTY3HsiriTTw==
X-Received: by 2002:ac8:183:: with SMTP id x3mr2726864qtf.270.1634775491987;
        Wed, 20 Oct 2021 17:18:11 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id o16sm1122070qkp.1.2021.10.20.17.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 17:18:11 -0700 (PDT)
Date:   Wed, 20 Oct 2021 17:18:08 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, bpf@vger.kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH v2 14/14] bpf,x86: Respect X86_FEATURE_RETPOLINE*
Message-ID: <20211021001808.3ng6qeggi5lfwx7k@treble>
References: <20211020104442.021802560@infradead.org>
 <20211020105843.345016338@infradead.org>
 <20211021000753.kdxtjl3nzre2zshb@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211021000753.kdxtjl3nzre2zshb@ast-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 20, 2021 at 05:07:53PM -0700, Alexei Starovoitov wrote:
> On Wed, Oct 20, 2021 at 12:44:56PM +0200, Peter Zijlstra wrote:
> > +
> > +	if (cpu_feature_enabled(X86_FEATURE_RETPOLINE_AMD)) {
> > +		EMIT_LFENCE();
> > +		EMIT2(0xFF, 0xE0 + reg);
> > +	} else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
> > +		emit_jump(&prog, reg_thunk[reg], ip);
> > +	} else
> 
> One more question.
> What's a deal with AMD? I thought the retpoline is effective on it as well.
> lfence is an optimization or retpoline turned out to be not enough
> in some cases?

Yes, it's basically an optimization.  AMD recommends it presumably
because it's quite a bit faster than a retpoline.

According to AMD it shrinks the speculative execution window enough so
that Spectre v2 isn't a threat.

-- 
Josh

