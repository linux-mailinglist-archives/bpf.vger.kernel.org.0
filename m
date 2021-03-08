Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C05331946
	for <lists+bpf@lfdr.de>; Mon,  8 Mar 2021 22:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhCHVU1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Mar 2021 16:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhCHVUG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Mar 2021 16:20:06 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F17C06175F
        for <bpf@vger.kernel.org>; Mon,  8 Mar 2021 13:20:05 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id f33so10657186otf.11
        for <bpf@vger.kernel.org>; Mon, 08 Mar 2021 13:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FqhqeZr2mP2g3hEZS37A37xiT1GPHwZWQBfQupiXH30=;
        b=ahF8ZpY5aS9BUJuXYF4jVKVBTNDL690Cx7GLbfjBpTt5c9gZ8q/QcXzIvw8kJ8zi8z
         YL++V2vWR93vH4UgccdaCP3yDW3JGrZ+bFHZNSCxCmsm0S9HWwANlEkfTZz6KjSiKr80
         dYExmlGIIYwsnwCOXbxyJyeRoEz2Zmkn9ilUDFqz6+2BSQUQYwUf68XtIGfOlDTTQjzx
         t7FRiEgwsk5MkeMsrD3L4TT7GecF4qRSB70Q14PL5lnp+AbvJ4bfbCFLV2GZcb6Qb7Ha
         hn8s4xD1pG8cOvtS40YJ91aKGDcEk5+BDmrRde2vhgUTRtVn1+ce0fEA+jxKeAdpE8Nw
         E9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FqhqeZr2mP2g3hEZS37A37xiT1GPHwZWQBfQupiXH30=;
        b=PjGDaXgdd4ghDJGi6Us9lbbJhnzwKru7CFxRmI5bvW8tSDvzInN717FdrydvcYbAT4
         ZrekK3kIbAdLrlyxFUd9cTV8hl1PjBPURd/QvCSKpH+KorGHG3OgK+MEoGMOjiPFbXuY
         VERsYHKS7IJmG2moqXWGP+nMxLedF1J8nmqDE0ZtwDjXDk9kwTDtIuzBCiMiIi3WPCl3
         QJ15fRSH+qjYt2JCqtgLwH87peyk8ezjQUEmaIJoYcnw6pInEJN7hHZt4yXrob4dxQoq
         PbU+hROtMzcPnsbRNLh+CKF/gYDnMOc4iVCWgIhxSp/VgBQxTLMJpN4g75a1QKA2h/yC
         Segg==
X-Gm-Message-State: AOAM531D0zH3GsVL5mwflAwtVPH0nHHrvpaxMz/NEaeKuqhtjxEBmHf2
        nJ3yV1kaJx6Uud+UGbb4wXPWbTO4HvYa9I02sP9gIg==
X-Google-Smtp-Source: ABdhPJwMChhvW0J5qVGiKwmT8+qXpOHEaHOaMDplKmxkeUv65+4bqIlOdB8cHzBqXGJrGRNTSBLug2GL0kvnBXGolaY=
X-Received: by 2002:a05:6830:15d2:: with SMTP id j18mr2640239otr.75.1615238405176;
 Mon, 08 Mar 2021 13:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20210308182830.155784-1-jean-philippe@linaro.org>
In-Reply-To: <20210308182830.155784-1-jean-philippe@linaro.org>
From:   Joe Stringer <joe@cilium.io>
Date:   Mon, 8 Mar 2021 13:19:31 -0800
Message-ID: <CADa=Ryz__dmwK7J--Tjt73_WvFrta=uJWcqt9GXsUqH_4zj1Zw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix typo in Makefile
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     shuah@kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, andrii@kernel.org,
        linux-kselftest@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Joe Stringer <joe@cilium.io>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 8, 2021 at 10:29 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> The selftest build fails when trying to install the scripts:
>
> rsync: [sender] link_stat "tools/testing/selftests/bpf/test_docs_build.sh" failed: No such file or directory (2)
>
> Fix the filename.
>
> Fixes: a01d935b2e09 ("tools/bpf: Remove bpf-helpers from bpftool docs")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Thanks for the fix.

Acked-by: Joe Stringer <joe@cilium.io>
