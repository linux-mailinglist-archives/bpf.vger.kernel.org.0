Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4B761AC23D
	for <lists+bpf@lfdr.de>; Thu, 16 Apr 2020 15:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895136AbgDPNXx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Apr 2020 09:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895064AbgDPNXj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Apr 2020 09:23:39 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3931BC061A10
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2020 06:22:53 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id t11so5568790lfe.4
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2020 06:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ghI5WBqdl870WOE8SE5UO5Yl3nEjaDEWsi+NZM23pY=;
        b=wL7Q0gPf1pOG5mpwohfKkO+zHQJzeFIgDMOlXgthXC9kCDgo3A7DD5pysOL3BHoeod
         9XSu8hDaxyyuh7eoujNL7pHKDV5/1LuFvn2pDWwWZ4jc6neNJ8uKftpodRcTX67KUlsx
         fexJIz75CoqVryD54Bsk8MrFrBwykj61Qb8mG4kNMDVQ6FRzkxckoxDdAu/ami5maQeV
         c5Uba+Lu/rQG7nrGTdwIukGU4NevTWa2wQxjDbrZBOeeWlug+8NVsPwTpTRyofKSwXoY
         qpK1Bzc6r7+rQqoSa1wuwKVOL3bQXczAy72GWXvV5vrM16D2iGMDg7xTX41johkrwoo/
         JeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ghI5WBqdl870WOE8SE5UO5Yl3nEjaDEWsi+NZM23pY=;
        b=H0kBfyJOqsGvzonfHGCC/VJQIG4lErzckiVmSa82Sa2k7/wpKdyEmuHNc2DY53+FTY
         g2d1H/175Pvzwg2sQHMJKCpdvub1Nl1DE3yK8F5D9C5vXW+5oRN9SZgydvS5p5Ue5DWh
         noWDRBjEC2I8KCkhRZur9JIys67BPXZEGJ5XAYOPoWcknq8OFKSofkYYx5LIz46r3y3u
         B2Bm02Si7IGRJDJN0FLcyZvzxS4nIKgYm7qJZq3ptzma0s7xxSFzPMP12QDWqil7vsgC
         6yu6lNLYp6KBM+8lxCSDPoR6TA4UjOKRiV6WT8SYOtE5W2VeDpsRRCQYtCNL5HnbaVHu
         7jGA==
X-Gm-Message-State: AGi0PuZw5G2vRBhv6hArc07Ai4qh6w8OSVKWYR8p1BqLNLKt+Lkjjlnb
        y0nkjlUO37F2MxEBziWXjWCn9s90+BAl5yO0VIqt5A==
X-Google-Smtp-Source: APiQypI8lGR85RQI+rU+pCf9V2Sn5n7Mvg4Ykbb7nhe56xJbWhdmIJaMewqk1OlOrMbaRXyV8387wTS3UaZFas2e/P8=
X-Received: by 2002:ac2:5dc6:: with SMTP id x6mr6011166lfq.108.1587043371445;
 Thu, 16 Apr 2020 06:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200415222312.236431-1-jannh@google.com> <20200416030232.15680-1-hdanton@sina.com>
In-Reply-To: <20200416030232.15680-1-hdanton@sina.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 16 Apr 2020 15:22:24 +0200
Message-ID: <CAG48ez2TPqUnDpuQOmmTw7WeMH3+zOJWG=zYzExEb8yPYQQ3uQ@mail.gmail.com>
Subject: Re: [PATCH] vmalloc: Fix remap_vmalloc_range() bounds checks
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 16, 2020 at 7:02 AM Hillf Danton <hdanton@sina.com> wrote:
> On Thu, 16 Apr 2020 00:23:12 +0200 Jann Horn wrote:
> > remap_vmalloc_range() has had various issues with the bounds checks it
> > promises to perform ("This function checks that addr is a valid vmalloc'ed
> > area, and that it is big enough to cover the vma") over time, e.g.:
[...]
> > @@ -3082,8 +3090,10 @@ int remap_vmalloc_range_partial(struct vm_area_struct *vma, unsigned long uaddr,
> >       if (!(area->flags & (VM_USERMAP | VM_DMA_COHERENT)))
> >               return -EINVAL;
> >
> The current kaddr is checked valid by finding area with it despite
> there is room for adding change in checking its boundary in a valid
> area.

I have no idea what you're trying to say. Could you rephrase, please?
