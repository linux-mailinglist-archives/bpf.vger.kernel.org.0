Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF64D2D4C5F
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 22:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgLIVAJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 16:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgLIVAD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Dec 2020 16:00:03 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C973C0613D6;
        Wed,  9 Dec 2020 12:59:23 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id d2so1918036pfq.5;
        Wed, 09 Dec 2020 12:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pYWbWncWHL5hPUtr0/h39G2nFyFj5DZJ+1NpptfUOGE=;
        b=qT81RrUelSi4/9CGafxmK+ntZGoAphMgJz0lBOeFpN3C60ZLVZglbdD1va6XQWsZlX
         2WCX4IBP+W4m0JM3FvevJc050fRyP9kdAUPqRi9p9jkLvWiTA/YVHjLxhI1eHYlIGg6M
         B+NNGssSvi1qsa54mziU8lbu8JCSuZi/FA3msuK40BX+B9UcqRtHVPEW2imISObDrBV+
         BUqB024a9NyQEFiVSvAShjT4gbCCFtH4JqBTOw8i5WnTeeRWHsidllpZ5UckgW/4pmsd
         dw1DLTaQ5mzOWw+qSee0Ku5S0TXglz06ZHSaUezYzGCrZUxjrXM68rdwn2GTMRaHoH1F
         AlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYWbWncWHL5hPUtr0/h39G2nFyFj5DZJ+1NpptfUOGE=;
        b=Lk98twughkZQnxWKKIbkMTwbLHEiU2WrCYD795/cUlMqIRlYx9719wWH5rfT3HjsrO
         hbvAi8IU34AqcMdkt/eOXzgp87GHF79+UHjWOcP1dvslznEWUH8+q0kWG/5mY11jzNAO
         QIXL93eLZ5hZbWSiQiTKbanWLoeI2tX+4hFej97s0q7/Or+V8YMPuWR7KQs3dPDfc3aP
         2oqoBcZAIBjofa5GXFaAyxX77FzDNZIYlyYqWw5YwvYk2jynOMrTJdWSi664+EY+xS+J
         FBRsRcDxVhglk0d+t3J2ykyYTt8iMfXglC4s4JTOBUyeid0LV5Xl76+G/oHe8Pc8kuev
         +B+w==
X-Gm-Message-State: AOAM533swLLjdKqO+Fxp80Toz5SYlXXkg5IjRUDoO3LJbxgL3Vi6NOnn
        Tnebxvzl/2/iKhoJ4gdVR/7y8HpuPMkBSqfEYNM=
X-Google-Smtp-Source: ABdhPJwJqp11WPmMBZbUh5oaeLciMyK4cwqSph9CTeKi9zlgKVe4qyo4RcU2rt3kmRYA+yUTAYEjbif1YrqDluzctI8=
X-Received: by 2002:a63:e30b:: with SMTP id f11mr3611905pgh.149.1607547562970;
 Wed, 09 Dec 2020 12:59:22 -0800 (PST)
MIME-Version: 1.0
References: <1604661895-5495-1-git-send-email-alex.shi@linux.alibaba.com>
 <CAFqt6zZU76NOF6uD_c1vRPmEHwOzLp9wEWAmSX2ficpQb0zf6g@mail.gmail.com>
 <20201110115037.f6a53faec8d65782ab65d8b4@linux-foundation.org>
 <ddca2a9e-ed89-5dec-b1af-4f2fd2c99b57@linux.alibaba.com> <20201207081556.pwxmhgdxayzbofpi@lion.mk-sys.cz>
 <CAFxkdApgQ4RCt-J43cK4_128pXr=Xn5jw+q0kOaP-TYufk_tPA@mail.gmail.com>
 <CAADnVQK-EsdBohcVSaK+zaP9XuPZTBkGbQpkeYcrC9BzoPQUuw@mail.gmail.com> <20201207225351.2liywqaxxtuezzw3@lion.mk-sys.cz>
In-Reply-To: <20201207225351.2liywqaxxtuezzw3@lion.mk-sys.cz>
From:   Tony Luck <tony.luck@gmail.com>
Date:   Wed, 9 Dec 2020 12:59:12 -0800
Message-ID: <CA+8MBbLLcNwnegX9eA2AP8ymbbS28ivVeoQntKKsM4MfGzYw+g@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: add static for function __add_to_page_cache_locked
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Justin Forbes <jmforbes@linuxtx.org>,
        bpf <bpf@vger.kernel.org>, Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 7, 2020 at 4:36 PM Michal Kubecek <mkubecek@suse.cz> wrote:
> Not removal, commit 3351b16af494 ("mm/filemap: add static for function
> __add_to_page_cache_locked") made the function static which breaks the
> build in btfids phase - but it seems to happen only on some
> architectures. In our case, ppc64, ppc64le and riscv64 are broken,
> x86_64, i586 and s390x succeed. (I made a mistake above, aarch64 did not
> fail - but only because it was not built at all.)

x86_64 fails for me:

  LD      vmlinux
  BTFIDS  vmlinux
FAILED unresolved symbol __add_to_page_cache_locked
make: *** [Makefile:1170: vmlinux] Error 255
