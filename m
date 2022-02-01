Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F3C4A546E
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 02:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiBABEk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Jan 2022 20:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiBABEj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Jan 2022 20:04:39 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8552C061714
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 17:04:39 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id e79so19204361iof.13
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 17:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yp/ZNrB2YOKIe7LderK+pnpBX9FIJpjIRoC88pgxD00=;
        b=JDu6JilFA2e4fgp/dDvXw/TPbOnt5uzDtAkgxGQWtEChzyjr1ZLRjzbmahx1p4rYO3
         LIPD+YEvntL7LoGy4/C3a40hVfdoTGVSdkQMIUU0aX2HQX1/ALfw4lzZyznUM1mhlBu5
         chapilT8C67dFU1FHYgCMH2pnbJS8R2vwlybivsRZ6CHo3eQkuyk/g1+WrN925vFw04L
         9mWvzRXoAij/OPfXW8s+xLf6naBdfmBPz6XlBDr/We0Aszcj4pYKYVpQ2bhjPkld5WLy
         ZWAt4HbZ69W5JRFhYg1pMfrBujy200/NoILr/5WAC9eokaOoNVTf7Unot3j0UGNv/jfV
         yCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yp/ZNrB2YOKIe7LderK+pnpBX9FIJpjIRoC88pgxD00=;
        b=4Jl43NIHQGTjlLaS/t942N5/ajo2hIXgjl+c8X0IQJ6xmlsSkUSJzZZPJNwVKXJ2ou
         y7lTq5rzTCoQo47rE1YxTe9ST/o+/sz7Qlkpla4Ml0CXBPuBhx+BLCdo0hXQGJW+4Oyq
         uFEg6Vbcpy2xUp5rLJGgicEw7tiBz/oitqD4BkfU/nukWbyAXa+bi9X7KQwGsSyZmcMQ
         z2FAeKe3BHehAu4gKCyW8y1eONdprbAmZQvilaVajJo9Pb/HFbkimBtAfsXoO4+H4ORV
         6iGpQCuEiwdsA4DWLWeCZVQpgY3i4un272w8+qAX+1e0mutGGrNIqUSRIp9kjOAjkINs
         cd+A==
X-Gm-Message-State: AOAM531M4714UjPPZH8CgFL41vSqOspDArMaGm+BNuxR3XjWLAUhhDwF
        o0DsOqhX7kGWjS9CgyJeOPJNeA2TpNm5pbsUe3luMW1X
X-Google-Smtp-Source: ABdhPJzzIOWPqJ4iJ/Suc2mjCcj9HAFI1I3HQip/dq/H9vDPzQ0CZeoo+luBJvsWK0Of91uKyQhmku5oxaL5371hbLs=
X-Received: by 2002:a05:6602:2e88:: with SMTP id m8mr6167877iow.79.1643677479179;
 Mon, 31 Jan 2022 17:04:39 -0800 (PST)
MIME-Version: 1.0
References: <20220128012319.2494472-1-delyank@fb.com> <310cca5f-ecca-5624-e4c2-e2ee79069e0b@iogearbox.net>
 <6025eb29983a0b7a6d62b845510f9e61480b745d.camel@fb.com>
In-Reply-To: <6025eb29983a0b7a6d62b845510f9e61480b745d.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 31 Jan 2022 17:04:28 -0800
Message-ID: <CAEf4BzY1oMMpVV9iZCyt-9aDsLRCGvRpwsrttsvx2Gg+AE_m2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/4] migrate from bpf_prog_test_run{,_xattr}
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "lmb@cloudflare.com" <lmb@cloudflare.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 28, 2022 at 12:12 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> Thanks for taking a look, Daniel!
>
> On Fri, 2022-01-28 at 14:07 +0100, Daniel Borkmann wrote:
> > On 1/28/22 2:23 AM, Delyan Kratunov wrote:
> > > Adding this behavior to prog_test_run_opts is one option, keeping the test as-is
> > > and cloning it to use bpf_prog_test_run_opts is another possibility.
> >
> > I would suggest to do the former rather than duplicating, if there's nothing
> > particularly blocking us from adding this to prog_test_run_opts.
>
> I looked into this a bit more. Unfortunately, bpf_test_finish unconditionally
> copies data_size_out back into the uattr, even if data_out is NULL.
> (net/bpf/test_run.c:180)
>
> This makes the ergonomics of reusing the same topts struct for multiple
> bpf_prog_test_run calls pretty horrendous - you'd need to clear data_size_out
> before every call, even if you don't care about it otherwise (and you don't, you
> didn't set data_out!).
>
> In practicality, adding the logic from _xattr to _opts results in a significant
> number of test failures. I'm a bit worried it might break libbpf users if they
> use similar opts reuse patterns.
>

Seems like kernel doesn't enforce that data_size_out == 0 if data_out
is NULL, so I'd say let's just keep bpf_test_run_opts() as is and
defer to kernel for error checking (e.g., for raw_tp data_out isn't
allowed to be NULL, but libbpf doesn't check that, right, it just lets
kernel do all the nuanced error checking).

So I'd say let's keep _opts() as is and let's remove parts of
prog_run_xattr.c selftest that check this specific error check?

> > As you have it looks good to me. One small nit, please also add a non-empty
> > commit message with rationale to each of the patches rather than just SoB alone.
>
> Will do!
>
