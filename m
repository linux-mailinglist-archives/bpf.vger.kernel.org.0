Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B29C466E3E
	for <lists+bpf@lfdr.de>; Fri,  3 Dec 2021 01:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349618AbhLCAFD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Dec 2021 19:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377751AbhLCAFC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Dec 2021 19:05:02 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855F2C06174A
        for <bpf@vger.kernel.org>; Thu,  2 Dec 2021 16:01:39 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id d10so4384181ybn.0
        for <bpf@vger.kernel.org>; Thu, 02 Dec 2021 16:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zSHH350WkDmn5mMI1i3mzR5CX0gPXTU+97jdQDvaDSA=;
        b=myH0WW/t4BhzYfxICNxQsbJ5n5/uSSpkbWcZSqioGhadtFL0OVbHdINrNloIGz2CyF
         +pP7mqJUPNoCWHRulv9gokGH1Z9o7z8bi3zjLFVQCXn96fLnDrqRBduHJhPzFq6jh7lk
         GDt/m90qIn1ItZOh+L5Dbm6i4aRTqebTWvunMe+6XCJ+KtsttuKtw51AkU3OK++tfg91
         eKrTNJurXNYufMai8QKfEP+Q3XgLqxeKg6J6pc0UjFWwG9DZNiCGCFHTY2Az1fs784IP
         r/LWG4bYiBjURqQekDeCKimC4Krk+pIhXrKMAbVjCEXTUNDmJHzTDBMp8OB/z0ZnYnK/
         xpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zSHH350WkDmn5mMI1i3mzR5CX0gPXTU+97jdQDvaDSA=;
        b=SxSwLprj7d9Ev2WSksmTTBDflSu+aeu35r+S+gHJWQ6Oug4Yf/wwZnfW13Ob9fzBE9
         WqZLbRoANoLAKadk83mduLzjZaJk/RtmQrEWJ7kypQEX1I2GcRbaKfPZxEy2353Pmnw3
         B/1LBMd9Y4Ate63gb/hpQ4VWEuZ+Pupp/sm2avPsBw7NIH8dl0wRPETDwy51THsYxsCK
         CuhEzDSTvqpK/GEjcISp7V7QnjgcSfYi/siwwU2tBKyNHc7Y3fED2YSwSPQlWbJ+7C/+
         1se2PNvtLR28hHCr3DDAsldknRSlkmpGkXXQxpiR8K9uK2V5+S9sq/eiZ4+T61ftmMKR
         VviA==
X-Gm-Message-State: AOAM533xq5V9kMklil0bjPghoTLwnhv3Wv+sDYtvabhO1QHCPXcb06KC
        mweMF+Kofk7LPNeLemPbtEPdMfDi4y0TI/M2jz0=
X-Google-Smtp-Source: ABdhPJxonmV+pmT0I7Vijm/SLl07MGqTzihk95vBOT/cTk0rLlPOhFi3t+H/QAZ6dTp88fnCW8T5CAFda3rMuB3bjzw=
X-Received: by 2002:a25:abaa:: with SMTP id v39mr19136597ybi.367.1638489698606;
 Thu, 02 Dec 2021 16:01:38 -0800 (PST)
MIME-Version: 1.0
References: <20211202220933.1155174-1-fallentree@fb.com>
In-Reply-To: <20211202220933.1155174-1-fallentree@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 2 Dec 2021 16:01:27 -0800
Message-ID: <CAEf4Bzazs6DNm47o5Omqi1Dg2c4Nq9=tq_xxgtJuKrb=jjQT6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Fix null pointer when using old pref_buffer__new()
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Yucong Sun <sunyucong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 2, 2021 at 2:09 PM Yucong Sun <fallentree@fb.com> wrote:
>
> Passing opts point to new function so program using old interface won't
> segfault.
>
> Fixes: 417889346577 ("libbpf: Make perf_buffer__new() use OPTS-based interface")
>
> Signed-off-by: Yucong Sun <fallentree@fb.com>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 1341ce539662..dac4929e5810 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10812,7 +10812,7 @@ struct perf_buffer *perf_buffer__new_deprecated(int map_fd, size_t page_cnt,
>                                        opts ? opts->sample_cb : NULL,
>                                        opts ? opts->lost_cb : NULL,
>                                        opts ? opts->ctx : NULL,
> -                                      NULL);
> +                                      opts);

perf_buffer__new_v0_6_0() doesn't need non-null opts, OPTS_VALID(opts,
perf_buffer_opts) handles NULL perfectly fine. After that we never
dereference opts. That NULL there is intentional.

>  }
>
>  DEFAULT_VERSION(perf_buffer__new_raw_v0_6_0, perf_buffer__new_raw, LIBBPF_0.6.0)
> --
> 2.30.2
>
