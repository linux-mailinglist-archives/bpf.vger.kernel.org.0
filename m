Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5BED44BC1F
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 08:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbhKJHfa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 02:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhKJHf3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Nov 2021 02:35:29 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86025C061764
        for <bpf@vger.kernel.org>; Tue,  9 Nov 2021 23:32:41 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id z21so6799912edb.5
        for <bpf@vger.kernel.org>; Tue, 09 Nov 2021 23:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ubique-spb-ru.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cTGGejto87Yfd+Or/2wKl4kYNhFQUtAwvWH4+KBmqxE=;
        b=QvFgqt3SoZ0dEcn17ueum3F0xdQXmTB4iSfy+gpVZTOt18jCs1QTzsKWfHkQFlYhHd
         mFHpYaI4wPLhFJ2/vFOR1LxSE87/IIqzzQSMOjY2gC44qr/EcR3/4hnKxuWLen1mNoeH
         L85QyeB/5eeKxD3YnFd1gg9euJolxHWNVOz+QCUQvdjIz3/InTuslqUp9Gz4CRRy2ceP
         L+djcDD6iJg8e4zKmZhfnCWmtVfijGEsZVbZghssZSeKsMgFaJrEDd8oVc8epx4gm8uE
         Pb299secRd8L4HHu+7qj9957liXGfgQno0w+Wpk8oTlOXu1YLgCIkQQKLP0POv/gjWDo
         DDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cTGGejto87Yfd+Or/2wKl4kYNhFQUtAwvWH4+KBmqxE=;
        b=zbO6ECsRu+H2QA9QbHqNU4duF5514p3ntkl5ut6pLnWpW98adECTo+X6w/IMmAXhOv
         FaVc79n+r7T7e3SC8XKxEll00k2K9uVOhkNr+uXNBhEVY9JkE6BRR/vEgNjhePtEIJm7
         EYnrhOLmS2PCrsDBncT3INXQpyuD56IFdjWF2ISR6KC8+AX4JV8JRz9QBVadorvjmpTD
         6kSW6S4jhy74/Q/q1BcOrC+ur/MFZWyew4JD5kU75aLAFX4Xo4of+KGiLgpZ4HEEJh8O
         nK2cGWcPgd5iYw6jYBoDQdKSrLulSGWtqDFfaPmvLoVXwXYixjq802rcoqZ5+jvPB6Zs
         wiwQ==
X-Gm-Message-State: AOAM531yrSlcZcUeHpIZt8qA5SHQmrVx7C5UcjRHskLQr8MedanmhBYF
        8Z5lI/D2iF24e8HjLjPmRy+NAw==
X-Google-Smtp-Source: ABdhPJwH2aZjv32N451FhTF+POV6sP3TK89HDiOvhg5szh+G/+tDUQIBgTt3nZElVD3ziLBhj0rgtg==
X-Received: by 2002:a17:906:52d8:: with SMTP id w24mr18402197ejn.296.1636529560062;
        Tue, 09 Nov 2021 23:32:40 -0800 (PST)
Received: from localhost ([154.21.15.43])
        by smtp.gmail.com with ESMTPSA id w25sm4127656edv.57.2021.11.09.23.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 23:32:39 -0800 (PST)
Date:   Wed, 10 Nov 2021 11:32:35 +0400
From:   Dmitrii Banshchikov <me@ubique.spb.ru>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Andrey Ignatov <rdna@fb.com>, john.stultz@linaro.org,
        sboyd@kernel.org, Peter Ziljstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, rosted@goodmis.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add tests for allowed helpers
Message-ID: <20211110073235.4cwxqxeit3hgdluf@amnesia>
References: <20211108164620.407305-1-me@ubique.spb.ru>
 <20211108164620.407305-3-me@ubique.spb.ru>
 <20211109064837.qtokqcxf6yj6zbig@amnesia>
 <CAEf4BzbaFSwSA9R1FgeD=CXdOi3iWW1QR7cF0jEnRmw6tZpiAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbaFSwSA9R1FgeD=CXdOi3iWW1QR7cF0jEnRmw6tZpiAQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 09, 2021 at 05:16:14PM -0800, Andrii Nakryiko wrote:
> On Mon, Nov 8, 2021 at 10:48 PM Dmitrii Banshchikov <me@ubique.spb.ru> wrote:
> >
> > On Mon, Nov 08, 2021 at 08:46:20PM +0400, Dmitrii Banshchikov wrote:
> > > This patch adds tests that bpf_ktime_get_coarse_ns() and bpf_timer_* and
> > > bpf_spin_lock()/bpf_spin_unlock() helpers are forbidden in tracing
> > > progs as it may result in various locking issues.
> > >
> > > Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
> > > ---
> > >  tools/testing/selftests/bpf/test_verifier.c   |  36 +++-
> > >  .../selftests/bpf/verifier/helper_allowed.c   | 196 ++++++++++++++++++
> > >  2 files changed, 231 insertions(+), 1 deletion(-)
> > >  create mode 100644 tools/testing/selftests/bpf/verifier/helper_allowed.c
> > >
> > > diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> > > index 25afe423b3f0..e16eab6fc3a9 100644
> > > --- a/tools/testing/selftests/bpf/test_verifier.c
> > > +++ b/tools/testing/selftests/bpf/test_verifier.c
> > > @@ -92,6 +92,7 @@ struct bpf_test {
> > >       int fixup_map_event_output[MAX_FIXUPS];
> > >       int fixup_map_reuseport_array[MAX_FIXUPS];
> > >       int fixup_map_ringbuf[MAX_FIXUPS];
> > > +     int fixup_map_timer[MAX_FIXUPS];
> > >       /* Expected verifier log output for result REJECT or VERBOSE_ACCEPT.
> > >        * Can be a tab-separated sequence of expected strings. An empty string
> > >        * means no log verification.
> > > @@ -605,7 +606,7 @@ static int create_cgroup_storage(bool percpu)
> > >   *   struct bpf_spin_lock l;
> > >   * };
> > >   */
> > > -static const char btf_str_sec[] = "\0bpf_spin_lock\0val\0cnt\0l";
> > > +static const char btf_str_sec[] = "\0bpf_spin_lock\0val\0cnt\0l\0bpf_timer\0";
> >
> > There is extra null byte at the end.
> 
> Won't hurt, probably. But I wonder if it will be much easier to add
> all those programs as C code and test from test_progs? Instead of all
> this assembly.
> 
> You can put all of them into a single file and have loop that disabled
> all but one program at a time (using bpf_program__set_autoload()) and
> loading it and validating that the load failed. WDYT?

Will give it a try, thanks.



-- 

Dmitrii Banshchikov
