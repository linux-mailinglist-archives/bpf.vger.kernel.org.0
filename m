Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E414214F35
	for <lists+bpf@lfdr.de>; Sun,  5 Jul 2020 22:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgGEUSE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Jul 2020 16:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbgGEUSD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Jul 2020 16:18:03 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E28AC061794
        for <bpf@vger.kernel.org>; Sun,  5 Jul 2020 13:18:03 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c11so21416794lfh.8
        for <bpf@vger.kernel.org>; Sun, 05 Jul 2020 13:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bli7823nzgPd4+zzTvhEWYIQlQOolCEdTUm/wr04xHI=;
        b=R7tVqK4S06XyeSJoTsJjrNQfFwww4cEHoPm/CtrrugENTDy1vqCVO+sDyMGWTFks1W
         5RawwMRBiS/INbOjWFg3B9vdk7NUoOnjuO+5/kBRz+Eb+sT5BIBi86j23t13MrcW941E
         tjh8GC9eV5hPjYuXImtn6v1yDp1zlaW2xJOOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bli7823nzgPd4+zzTvhEWYIQlQOolCEdTUm/wr04xHI=;
        b=jlFc8NK4nnkLqGtBKWWicO35kzpo3snehDfaxNp2EkphMmyPqKtG3TcXK5DQgoQV/d
         ZW02YH8IFTngtU32REr7pFCOgQTjMQEvInHB0RnCNxcBRpAvLtGVb6Gi73zz0gGvHSHZ
         wITaHJ7yuHZYAJ7bnA/MaxL1BfaDI6wk7ov8JZqhNWjqiJkvTg9FO4YHMuDfq9QZNpig
         KHXLHiFXkVnIfOaHGBGSNVghCTA7VJEpSrmQEgeJVdlZrfJd+wJhvALmGlBMMcEuqMtR
         977uJLdP5bo652GY0cO+YZr4kMJMpqSZWGU4oapbHtqLNWC41yfhPkJBGId6fG45ascf
         kT+g==
X-Gm-Message-State: AOAM533sX+g0i6YBBt9w23hWsSkICjGxq5AwdJzoYdOnEnrbQ+7ea23p
        3hT+otluMsQDTBoXltnJVAfRARJUtik=
X-Google-Smtp-Source: ABdhPJyfcSJYsyUJJtnRrBO8mBfnYhMgSEAIRouDIAtjmZeKK5wI/y+mWGztOvbvr7HKqV8Uyb3W9w==
X-Received: by 2002:a19:4209:: with SMTP id p9mr28392254lfa.198.1593980281728;
        Sun, 05 Jul 2020 13:18:01 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id u19sm9826867ljk.0.2020.07.05.13.18.01
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2020 13:18:01 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id e4so42960582ljn.4
        for <bpf@vger.kernel.org>; Sun, 05 Jul 2020 13:18:01 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr24759339ljj.102.1593979869955;
 Sun, 05 Jul 2020 13:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200702232638.2946421-1-keescook@chromium.org>
 <20200702232638.2946421-5-keescook@chromium.org> <CAHk-=wiZi-v8Xgu_B3wV0B4RQYngKyPeONdiXNgrHJFU5jbe1w@mail.gmail.com>
 <202007030848.265EA58@keescook>
In-Reply-To: <202007030848.265EA58@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Jul 2020 13:10:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgEkTsNRvEM9W_JiVN6t70SnPuP=-1=LyhLS_BJ25Q4sQ@mail.gmail.com>
Message-ID: <CAHk-=wgEkTsNRvEM9W_JiVN6t70SnPuP=-1=LyhLS_BJ25Q4sQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] kprobes: Do not expose probe addresses to non-CAP_SYSLOG
To:     Kees Cook <keescook@chromium.org>
Cc:     Dominik Czarnota <dominik.czarnota@trailofbits.com>,
        stable <stable@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Will Deacon <will@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matteo Croce <mcroce@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 3, 2020 at 8:50 AM Kees Cook <keescook@chromium.org> wrote:
>
> With 67 kthreads on a booted system, this patch does not immediately
> blow up...

Did you try making read/write inc/dec that thing too? Or does that
just blow up with tons of warnings?

                 Linus
