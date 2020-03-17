Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40F42188EDD
	for <lists+bpf@lfdr.de>; Tue, 17 Mar 2020 21:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgCQUU7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Mar 2020 16:20:59 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39214 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgCQUU7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Mar 2020 16:20:59 -0400
Received: by mail-pj1-f65.google.com with SMTP id ck23so240799pjb.4
        for <bpf@vger.kernel.org>; Tue, 17 Mar 2020 13:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9OK68t7TUQtw3LyqGzDkiyJ3oB07lydjnI/8ZCLVjiA=;
        b=cDuzR/o52T2Hh4/O479e/RTlekL5mxBre7cYIj0XZoI4PyYPkn7+0PhzuplUknZKGj
         M8Pb5DqcQracDAOHvDrkuyEyb1WzfghxMRd7jeJs2zroVt62lYa4rOJqOi9DxXscZseg
         JYWvdXoeVPI+hKqRqvZcRz6WDkZiwSXGq5hrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9OK68t7TUQtw3LyqGzDkiyJ3oB07lydjnI/8ZCLVjiA=;
        b=PdK66RBgsVCjD4ZFBxMB6cW/3sBlDG1wDviYpMjCm2AIlio0WXnn3GkWAn4UDPjgrP
         mQ9Ph4O5xcqzjwJ+1gSwkuffhrh1GDu12dINJu5YdcmDkmd7CLchbrhDu4UfZNZFGoHU
         0v0QsCZwU/51bd2CAIhDKUrbwZ5S69rAQzG6E6EoTHQVljsE/l4tTDc+6comvlGTWruO
         7C5CtVoIAbZ0M8y4qEYXEP8yjB7fBhSSUVFVF9bfEnT8qE5QczPEUhK7Z2eemeXXMZYu
         UZ8GEuW/5QbTIa700Bnh1rLD3udZ3ntsJnaYcs33uSQaWW1hOJJvBh5LoUfqecfrR4pb
         oc9w==
X-Gm-Message-State: ANhLgQ39QloG7/xoyJSHbwBqd/a14me/Mb6NiCKJyYw2PhRhxGQyqKpR
        IyTsW0gmteBffnnHaCahqm+ESA==
X-Google-Smtp-Source: ADFU+vvYV0kEPv1VNXIa+fmKBL/iOs6miQA9gPwamG4IvHuKcJ03IQ/1U+4O/NAmOlwwzniOHlF9ew==
X-Received: by 2002:a17:902:e981:: with SMTP id f1mr416010plb.103.1584476456804;
        Tue, 17 Mar 2020 13:20:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x18sm4033833pfo.148.2020.03.17.13.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 13:20:55 -0700 (PDT)
Date:   Tue, 17 Mar 2020 13:20:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Anton Protopopov <a.s.protopopov@gmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] seccomp: allow BPF_MOD ALU instructions
Message-ID: <202003171314.387F3F187D@keescook>
References: <20200316163646.2465-1-a.s.protopopov@gmail.com>
 <202003161423.B51FDA8083@keescook>
 <CAGn_itw594Q_-4gC8=3jjRGF-wx90GeXMWBAz54X-UEer9pbtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGn_itw594Q_-4gC8=3jjRGF-wx90GeXMWBAz54X-UEer9pbtA@mail.gmail.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 16, 2020 at 06:17:34PM -0400, Anton Protopopov wrote:
> and in every case to walk only a corresponding factor-list. In my case
> I had a list of ~40 syscall numbers and after this change filter
> executed in 17.25 instructions on average per syscall vs. 45
> instructions for the linear filter (so this removes about 30
> instructions penalty per every syscall). To replace "mod #4" I
> actually used "and #3", but this obviously doesn't work for
> non-power-of-two divisors. If I would use "mod 5", then it would give
> me about 15.5 instructions on average.

Gotcha. My real concern is with breaking the ABI here -- using BPF_MOD
would mean a process couldn't run on older kernels without some tricks
on the seccomp side.

Since the syscall list is static for a given filter, why not arrange it
as a binary search? That should get even better average instructions
as O(log n) instead of O(n).

Though frankly I've also been considering an ABI version bump for adding
a syscall bitmap feature: the vast majority of seccomp filters are just
binary yes/no across a list of syscalls. Only the special cases need
special handling (arg inspection, fd notification, etc). Then these
kinds of filters could run as O(1).

-- 
Kees Cook
