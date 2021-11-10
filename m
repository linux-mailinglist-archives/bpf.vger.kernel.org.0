Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FFA444BAFE
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 06:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbhKJFVK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 00:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhKJFVJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Nov 2021 00:21:09 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA099C061764
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 21:18:22 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id x64so1583989pfd.6
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 21:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L2T1Ndy0vLfzpkDagdZTkmNPDlcNTU0Dcwt9N+X8qhw=;
        b=o0akGjJwLOo0+aoao8WvAbmcMIoOctl/G++Aa5jSEjHGc+myPrupw7mb04EwrwMVfY
         vrxU/QgTVV3iddKCdEX+bO/f0Fyr1t9lV1jwKnWITzNUfIsx0oKz6wzvjtUGzbKTHeFF
         6WCJahqszk0uCrjIIsETjOTNoLZQuZPh6Qx1p4PvkMym3EVx9h5rp0l4iAeR+dRhPRDf
         MHLXV4ro1cdvnW+ljfv6gD1LEYs0cAjlpK1Nux3nrFw9iUu6z6a4ooFVNFP6OOC98coS
         2gC3BUMXRBMj+IHEh1/yVBj8AY7L4WQH2d4bcAASTaHP22YjT3DxYzG5w95j7MMUHUTF
         zTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L2T1Ndy0vLfzpkDagdZTkmNPDlcNTU0Dcwt9N+X8qhw=;
        b=wvrxtvgEJMfCW44xvQKF4xh7kXFTA2l2dEbWJ9KWqL6Q8YcGNdDn7XXgMcNoWTbUFN
         w5KpwpeNFa6H83KJmKezA5exN7cIlPBgqGcLLgYtUHHeNbGlDnmxZyQDFwtd1ua3m0VX
         v4ccLxTZt1sbq81lP84LyU7M/sY9yWYNQo0Kl3YJA4BAVFs021pYYOnpT+zkL0Y4mgXE
         ZBjnN6+sE+2Gf4ffgNXhftTL6cA1v78sG5HLO9W/jLsgjWmnNjLZuyQGA7vc+EI58T2e
         OxusXPQg8qpus25zpCFS9bTNzvldRsTK+rngcvBQkvcMdKpAJtLoLdSCzWiqeOZt6lag
         xoow==
X-Gm-Message-State: AOAM530Rpx9qa0QB2KZz6Dq35/hAc9vCkM1gYzchHEpw0HxM6W7OHvml
        TJdVyuxhFVC+SrCQ8+wjkQM=
X-Google-Smtp-Source: ABdhPJzFWb/W96cKN55V2XWomGCjq/2lg+62igW+IXSvp+E9AZkMCt0J9jwvN4pjRZoJGnVZCqb+Hg==
X-Received: by 2002:a63:7141:: with SMTP id b1mr6218330pgn.321.1636521502221;
        Tue, 09 Nov 2021 21:18:22 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:8f53])
        by smtp.gmail.com with ESMTPSA id q13sm22951261pfj.26.2021.11.09.21.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 21:18:21 -0800 (PST)
Date:   Tue, 9 Nov 2021 21:18:19 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH bpf-next 0/9] bpf: Clean up _OR_NULL arg types
Message-ID: <20211110051819.shc7ozmymwy4eqn3@ast-mbp.dhcp.thefacebook.com>
References: <20211109021624.1140446-1-haoluo@google.com>
 <20211109182128.hhbaqv3j52fddayq@ast-mbp.dhcp.thefacebook.com>
 <CA+khW7hZC43ZrCSRL9SqffDPeDyxObzXtcvGneaEiW37=X11hA@mail.gmail.com>
 <CAEf4BzachpsSefRmoyLOdD3wY_+oihiB4uv=M9Yz5neNiOtLEA@mail.gmail.com>
 <CAEf4Bzav5H4cFjoa4Q=9XvgAghY7VXm5X-pMeGRNgLxAKEzRfw@mail.gmail.com>
 <CAADnVQKLWW_-HQ06SbZtWOZ0gE4bUun4CSD6eQxwfTRS7UfJ_A@mail.gmail.com>
 <CAEf4BzZgXTi_h0fL3uHxYM9DOqR=Z_1U6gAuYL3xu-5oMU9wkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZgXTi_h0fL3uHxYM9DOqR=Z_1U6gAuYL3xu-5oMU9wkg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 09, 2021 at 09:00:25PM -0800, Andrii Nakryiko wrote:
> 
> But also one specific example from kernel/bpf/verifier.c:
> 
> if (register_is_null(reg) && arg_type_may_be_null(arg_type))
>     goto skip_type_check;
> 
> Currently arg_type_may_be_null(arg_type) returns false for
> ARG_CONST_SIZE_OR_ZERO. If we are not careful and blindly check the
> MAYBE_NULL flag (which the current patch set seems to be doing), we'll
> start returning true for it and some other _OR_ZERO arg types. It
> might be benign in this particular case, I haven't traced if
> ARG_CONST_SIZE_OR_ZERO can be passed in that particular code path, but
> it was hardly intended this way, no?

I think it's an example where uniform handling of MAYBE_ZERO flag would have helped.
The case of arg_type_may_be_null() missing in ARG_CONST_SIZE_OR_ZERO doesn't hurt.
The subsequent check_reg_type() is just doing unnecessary work
(it's checking that reg is scalar, but register_is_null already did that).

I think such application of flags would have positive result.
Doesn't mean that we should apply it blindly.
There could be a case where it would be incorrect, but as this example
demonstrated it's more likely to find cases where it's safe to do.
We just forgot to include all of OR_NULL flavors here and could be in other places too.

I think your main point that gotta be very careful about introducing the flags.
That's for sure. As anything that touches the verifier.
