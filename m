Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFDF27FA99
	for <lists+bpf@lfdr.de>; Thu,  1 Oct 2020 09:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbgJAHtW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 03:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgJAHtW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 03:49:22 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28CEC0613D0;
        Thu,  1 Oct 2020 00:49:21 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x14so4463555wrl.12;
        Thu, 01 Oct 2020 00:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+NcXdkZLuqZEhsrjLZ9EomnWbR0CtRb+cHGEY+PT1Ow=;
        b=iPFug+KDfRfSjnv8hr1xM23l+L9MwjkEkMoNtiau31vGWusKlYxGwKmr8yZ1elD1rt
         E1wi3701TuTqy/vljRGWKqWgztLAX00MBnVXCGq69fg+bCptBy7U+3Ep56DG9xW7ZYh7
         6Jqvw8r/E88ACAm6V/9nwKIeBN8CjqBTojTqP9rHYiXsVSTd5WpnxNYZJpH1ZdQkd1XS
         yEBFgcMs8RNLrc9qh/ojt7zWiSsqfrqQlqIqW8d6ooLedRHqwAkClZu7n85/q5hvhDzW
         iR1uu9MKfWxf56o5xh6sFzwjBxFqzGCTuEwD1jB0FTyeNH0ab6ygPdmGkQMsKtXVJMnG
         Je8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+NcXdkZLuqZEhsrjLZ9EomnWbR0CtRb+cHGEY+PT1Ow=;
        b=cFuMZ7TrZGguomTrjCLqxbkmIU9vEiWnAMNwRVcBwf+VCE/Z83qz0j2nVxyhrNIXiL
         VDbYPrZ15nwCNnFpnK/N8dYGRdufW/9NtuNqnnjXypYIywZdGeFOLUXLASPOOVvl98ox
         1rmsVU3vs5oB4YjmUAShSp5lESEzGw7fDXPtaqOwrt0w6EOar2PEUoP4PTtdfOS/Bfa/
         TiZAJeqGo6YkwpL7XSnbv3/NGpMPUKUq1n/cbLE1mcJ2RNp9Yv20UmwY8s/5HE02AEYI
         rhkIbGLHY+pff4KLk6CLhyw1Oct9S0JTEWpN/wLvJaFwYJM1PU0P2F4qc9aOgJ+xldjt
         8jbA==
X-Gm-Message-State: AOAM530w9zlQNCAC8u83BpIqqfxS+Q/suER/8q61XzK1r62OY52C2JVC
        m6Qf77oAbVq6l4F9ompttvQ=
X-Google-Smtp-Source: ABdhPJxihcQDVW1G0d43dfFRvyTn9xsOufQiCocx9h1OGoc1GRDSIrP+1BQ44PkXDiveoDcyuO7mlw==
X-Received: by 2002:adf:fe42:: with SMTP id m2mr7149297wrs.367.1601538560582;
        Thu, 01 Oct 2020 00:49:20 -0700 (PDT)
Received: from ?IPv6:2001:a61:2479:6801:d8fe:4132:9f23:7e8f? ([2001:a61:2479:6801:d8fe:4132:9f23:7e8f])
        by smtp.gmail.com with ESMTPSA id u2sm8313285wre.7.2020.10.01.00.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 00:49:19 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Drewry <wad@chromium.org>, bpf <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.pizza>
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
 <20200930150330.GC284424@cisco>
 <8bcd956f-58d2-d2f0-ca7c-0a30f3fcd5b8@gmail.com>
 <20200930230327.GA1260245@cisco>
 <CAG48ez1VOUEHVQyo-2+uO7J+-jN5rh7=KmrMJiPaFjwCbKR1Sg@mail.gmail.com>
 <20200930232456.GB1260245@cisco>
 <CAG48ez2xn+_KznEztJ-eVTsTzkbf9CVgPqaAk7TpRNAqbdaRoA@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <f70836c2-927d-6de5-3022-4ffac2cba924@gmail.com>
Date:   Thu, 1 Oct 2020 09:49:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez2xn+_KznEztJ-eVTsTzkbf9CVgPqaAk7TpRNAqbdaRoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/1/20 3:52 AM, Jann Horn wrote:

[...]

> I guess this is a nice point in favor of Michael's usual complaint
> that if there are no man pages for a feature by the time the feature
> lands upstream, there's a higher chance that the UAPI will suck
> forever...

Thanks for saving me the trouble of saying that (again).

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
