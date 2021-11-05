Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2280A446AB5
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 22:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhKEVwa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 17:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhKEVwa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 17:52:30 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81539C061570
        for <bpf@vger.kernel.org>; Fri,  5 Nov 2021 14:49:50 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id a129so26087301yba.10
        for <bpf@vger.kernel.org>; Fri, 05 Nov 2021 14:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z6IwAnrvj6qJru0OrLePZgNiridhWuY+chm09OF1XJw=;
        b=ANIJc2BHkFgZM+A/1lo+QW20HcfaZAeCVkjUS6sUnuhRJbUisht1l9p9vORfDR5ezD
         JneurA/jHGUYDTjXuh+4YDRsmh25OAfA8VX+fhX4YiNd/llxHPmoglFzRNT/2uU3UX16
         39/xxPJBew4AZxhDWMu06UVrYalkGoWlZWZ2S55AIwrTRz+6Wg0PzsdLPgVyoOEnQnpV
         fAA+rp85WE0uzKYy+eddVhFeSdezg9Iq6UlG85aQVSIHZaOdQxdSOdcmX/7knThjyHjX
         b7XIdAOLxhym5Oa+IkAD5jdcAAcfdzzZTSItfGjX0X5rwyExu1yF6fbwwfSiqag1e85+
         kKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z6IwAnrvj6qJru0OrLePZgNiridhWuY+chm09OF1XJw=;
        b=CuleiBtlE8L0omdnFDdB5j/yQ/WlSj3KsXvbj4Z673wAMSYnHi8k1ZZaHN7bokVjF6
         qeJExXExkRQxpRq0Dy641npPFAU5nC2soratxexEE8eQZ3otGWr3pB+Rtjyixds6r4lJ
         ksbqTq+wieln8UMnjsRd2JxY6OnQ4aNU2JFy0HwkeycPtiejCOWAywFyfbKhEtnBhYiQ
         J8eC1ggE0RYZVdUBGpZqD70jD96lh1kiHSr6bsoo/hOvgVk3KhTrn7EJAAlg4z9ZybgR
         BKLq8WbbSXe77y2UZJEPY4Owb+niykLsA3KDvIcVzlO+fuEjEQqdViZMGVsbxTRador6
         3X8A==
X-Gm-Message-State: AOAM5306e4oOH6WRJ5gJ8FcPitxowvixo/JlbKF72y71T3/LUqCGonYv
        Wypag5Y+1zpbIAg+6967Z4K7SSPiPCCFM7ZWY37WA52G
X-Google-Smtp-Source: ABdhPJy8AE9PiKPjIiYG+0azSsdFX6XLivkTBidlWdhaA7xkPyES0cL8QcTKt90inR3yYfWHZs8+jZdg3KCD/ySBZaY=
X-Received: by 2002:a25:cc4c:: with SMTP id l73mr65388071ybf.114.1636148989804;
 Fri, 05 Nov 2021 14:49:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211105191055.3324874-1-andrii@kernel.org> <20211105204051.v7wzca6fryb774m4@apollo.localdomain>
In-Reply-To: <20211105204051.v7wzca6fryb774m4@apollo.localdomain>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 5 Nov 2021 14:49:38 -0700
Message-ID: <CAEf4Bzb83Nz3iRa1t8+EknuowkkbYwf+zjwRj_SJSvh0ewfa+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix non-C89 loop variable declaration in gen_loader.c
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 5, 2021 at 1:40 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Sat, Nov 06, 2021 at 12:40:55AM IST, Andrii Nakryiko wrote:
> > Fix the `int i` declaration inside the for statement. This is non-C89
> > compliant. See [0] for user report breaking BCC build.
> >
> >   [0] https://github.com/libbpf/libbpf/issues/403
> >
> > Fixes: 18f4fccbf314 ("libbpf: Update gen_loader to emit BTF_KIND_FUNC relocations")
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> Thanks for the fix, and sorry about that.
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>

No worries, we just need to figure out which compiler flags we need to
catch this. I'm surprised BCC build caught this and neither libbpf's
Makefile nor selftest did. Selftests are definitely too permissive
w.r.t. stuff like this.

If you could take a look and see what we'll need to lock it down a
bit, that would be great. I've also requested help from the original
reporter of this issue (see issue on Github).


> > [...]
>
> --
> Kartikeya
