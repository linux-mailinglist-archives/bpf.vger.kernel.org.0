Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B8A473851
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 00:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244127AbhLMXPZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 18:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244058AbhLMXPZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Dec 2021 18:15:25 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DB4C061574
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 15:15:25 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id f9so42111405ybq.10
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 15:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q3oWQzP90YpHeGgmHBSNT4PloLrBvVerWVX4c1HBjJU=;
        b=Jp0xuSTk/shHcCUKvGaWXcYahFCVfAcDFKafV28hsA22UWvA/f1DAFWIE82N2Gm3vr
         JROPiXTGNenjqE6XrfYzNtjW65742j8/HLok1AS9DCWAieaLutEQcNDVNTQRRLjhJEX1
         +Cqw8+TYIKKXxRqUGtvvih42b+xdHC4SVc6/wLNZ9z7rcM7Ir5BZYIn/vBmEsJtzM/SH
         MSBLMAQKWQ4cy8IuRclUvfbkwaTuDa7fPskd6P60j8Rfmx6rai5OZEP+zzpkjnBFf066
         Gn82Ier56gfFIbK3s+nDKc16+UD/1GsKgkgkTbWxODr4xRNGduDx3Jojfm5fPgA4Q3aj
         6Fnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q3oWQzP90YpHeGgmHBSNT4PloLrBvVerWVX4c1HBjJU=;
        b=sTzsaOuIrT/SrDPI7/Mo0wR0JbxKHB+d+GpMKyVSMGRjIczHLqcqK4eWRQOEk7j1JZ
         sBumpVZje5+nkA31SQhRBXg0E6SC5JvK8j2rk/DoLlZIIUoAl9PQf2E5QxCizIe9WvLe
         bWX8E1afQdeeMCmFXuxvpZ2Hn3/Z0PtTCcK7pT43uTrC4JjAQp6pCSfW3MWfCbpzvw54
         EtckQ99PhOeGgjp14W6/mw0Egg0yCumQmH4Y0XqaMWmoMqMu0YvN4Osfm0B8tMz6E8gN
         1F24qIiH2f8++oB49sWZOgLIv/M+SzZp4RsRRunhMXpbo33AFLtnjylVurWbW8gryRm9
         NQYA==
X-Gm-Message-State: AOAM532lAzFXxyCVkbyvcxAghInC9hwySZNnGUp5PFr1ePjDIjW1bi6X
        KDsHHca7brs4pVPfdJ+coMCH2JtZBO1PkF6kSew=
X-Google-Smtp-Source: ABdhPJxfNXZYmlATefBhjpthOhxvy3E79eNcPsbyrzZIpTpPrW3R82YkGxCzlq5+tWu/EA7kzsgq0aYKKzq3phwovF0=
X-Received: by 2002:a25:37cb:: with SMTP id e194mr1768345yba.449.1639437324355;
 Mon, 13 Dec 2021 15:15:24 -0800 (PST)
MIME-Version: 1.0
References: <CAO658oUqd5=B3zkDhm2jVQxG+vEf=2CE7WimXHqgcH+m0P=k_Q@mail.gmail.com>
In-Reply-To: <CAO658oUqd5=B3zkDhm2jVQxG+vEf=2CE7WimXHqgcH+m0P=k_Q@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 13 Dec 2021 15:15:13 -0800
Message-ID: <CAEf4Bzb5TMHkct=uh2OHnDaTtnvyLwvHjueN1Lm8vqTF6BDaSw@mail.gmail.com>
Subject: Re: Question: `libbpf_err` vs `libbpf_err_errno`
To:     Grant Seltzer Richman <grantseltzer@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 13, 2021 at 3:10 PM Grant Seltzer Richman
<grantseltzer@gmail.com> wrote:
>
> I'm using libbpf and want to make sure I'm properly handling errors.
>
> I see that some functions (such as `bpf_map_batch_common`) return
> error codes using `libbpf_err_errno()`. My understanding is that since
> libbpf_err_errno() returns -errno, these function calls can just be
> followed by checking the returned error code.
>
> Some functions (such as `bpf_map__pin`) return `libbpf_err(int ret)`
> which sets errno and returns the error code. In this case, does errno
> even need to be checked?
>

No it doesn't, checking directly returned error is enough. We set
errno always for consistency with APIs that return pointers (like
bpf_object__open_file(), for example). For the latter, on error NULL
is going to be returned (in libbpf 1.0 mode), so the only way to get
details about what failed is through errno.

so doing:

if (some_libbpf_api_with_error_return(...)) {
  /* errno contains error */
}

is the same as

err = some_libbpf_api_with_error_return(...);
if (err < 0) {

}


But you only can use:

ptr = some_libbpf_api_returning_ptr(...);
if (!ptr) { /* errno has error */ }


I plan to remove libbpf_get_error() in libbpf 1.0, btw. The pattern
above will be the only one that could be used.


> Why the inconsistency? I'd like to document this, so anything else
> that you can add on error handling in libbpf is welcome. That includes
> example usage.
>
> Thanks!
