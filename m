Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEF51D1F58
	for <lists+bpf@lfdr.de>; Wed, 13 May 2020 21:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390726AbgEMThe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 15:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390623AbgEMThd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 May 2020 15:37:33 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E1DC061A0E
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 12:37:32 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 188so511939lfa.10
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 12:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5FRYECFHiQr3Nfb1uzqLNFih4Bcng0OOjZJ5V5m4DAs=;
        b=ZjLEDdjhfQ+ZsfStprzo3boptGtjEB8xMJMPV9hfgVHHrrYSleH8mLbHC8Rk2rWQqc
         NnCj3BIzoVOHPTIgSoBKM0vWlfW3SuT0UoYyIfcumKGQE/4wsqoLb39sPYuJ5/AuOelG
         tGQKJ8l9ywdlX+FMm4CTzGEq2pztEwBhTbMlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5FRYECFHiQr3Nfb1uzqLNFih4Bcng0OOjZJ5V5m4DAs=;
        b=b69G/Xd/4OgwPK4xotQ+lF7ckPKoebtlsNX/RK1xx+XiWdu6q0Fihl2wrzL3f7yYEi
         Vy6XS4gULnoIj5UoEQ4wgulJltIUm7u8gYLegrY6BfoqtYl6VxIyiOrpsbpdL86AjcBr
         /Sp0AzC/zXiEQ7C46a3/Ja6wF9D+1x1mE4bXmGQcOgJ8U9py1lA3eLs+MAmXrsjQdMNi
         FkkXdPAxErhpmppNaoJedu6StsdF5Lk8efcF3ocgo6Q3ELFoIyzApFrmQ893YCQuEgfr
         cInbszaRq8jYC6amyxigLhL1lfw5XKaat4Xfsg50CPo8LcdmKXo/t7cTbIZ/nfhYHBQI
         LJcg==
X-Gm-Message-State: AOAM533UbD6DCYeXk/9ttzm6tHCE+YYzq7LdAUGzuwq6YAuvYHkcm7KD
        GpjHqFxpJ5acxvEsXyCqdVhSS8aXzIU=
X-Google-Smtp-Source: ABdhPJxITX82Gs+F7FLTKT+ypYtZWWOhyisq5m6V4cCLakT+hiKX5Mwg3kGrYXWRKa1cO9H5xXyy5w==
X-Received: by 2002:ac2:5212:: with SMTP id a18mr680991lfl.83.1589398650086;
        Wed, 13 May 2020 12:37:30 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id n2sm308418lfl.53.2020.05.13.12.37.28
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 12:37:29 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id c21so548244lfb.3
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 12:37:28 -0700 (PDT)
X-Received: by 2002:ac2:4da1:: with SMTP id h1mr686949lfe.152.1589398648496;
 Wed, 13 May 2020 12:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200513160038.2482415-1-hch@lst.de>
In-Reply-To: <20200513160038.2482415-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 12:37:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wghd2efrE_DoJaC7nTkpCC1gPGp+xbNY7KWOE-7sa4h0Q@mail.gmail.com>
Message-ID: <CAHk-=wghd2efrE_DoJaC7nTkpCC1gPGp+xbNY7KWOE-7sa4h0Q@mail.gmail.com>
Subject: Re: clean up and streamline probe_kernel_* and friends v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 13, 2020 at 9:00 AM Christoph Hellwig <hch@lst.de> wrote:
>
> this series start cleaning up the safe kernel and user memory probing
> helpers in mm/maccess.c, and then allows architectures to implement
> the kernel probing without overriding the address space limit and
> temporarily allowing access to user memory.  It then switches x86
> over to this new mechanism by reusing the unsafe_* uaccess logic.

Ok, I think I found a bug, and I had one more suggestion, but other
than the two emails I sent this all looks like an improvement to me.

                 Linus
