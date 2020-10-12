Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CEF28BE95
	for <lists+bpf@lfdr.de>; Mon, 12 Oct 2020 19:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390534AbgJLRCE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Oct 2020 13:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390355AbgJLRCE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Oct 2020 13:02:04 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16C0C0613D0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2020 10:02:03 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id c3so13944849ybl.0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2020 10:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TcvsnlnuuguVUDRzwLQn5+1SPwNNMDTQ/0rcYHqiRzs=;
        b=rYaLbBXXXhCZWpYHdG1q8SS2xZ5o1xpNSiybAl4eUluhIoEWdGZg1IuEBBf8qe3cmG
         znxc1BVYWn+1fu0eX7ojk+l0b+hI+yoiNSVYFskiMnosQI0Psu36kT1ZnzQUiXMmNSaC
         mtdPUxz0V3kg1eOVkOQpgtfvJu5DCwS5/RIXSSpNX2hB4GsELkjHiYlHY8Y0DMNm52Al
         K/LkHHO9+B+Se1X7k+gsbq/kYM1NMQRXuujIg7F7/fXO0ndYpTIgniRUdPo36JzOXvjK
         aljmuzUeLnrlnh5Unu8vNDUlA8jFd8cdf80uM0jqMlpWYgJeA+32ViYuj91wi7ej7VfO
         z6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TcvsnlnuuguVUDRzwLQn5+1SPwNNMDTQ/0rcYHqiRzs=;
        b=Hmzt+2aW5B3U47SBdEqtm1Z4gTPGAWDpPt/WyxNFCX9BHsklO0xTBmqFi7wbLMY7Z1
         hsNGu2bM4up3yDRJbs1LNvIa0137dlHr/T/m0t17uVoc/9WJXAvDRWcLjvHZPhkqzp/0
         Y7TKE30aePmU60cQokLD1nM3hLqD1ZMcv+uGahWJNqBwo4GVU4fpEs5PN/TssZjfKwFI
         wrCCjKL3uL3hpy9EnyUF0CaVqb2424AniWKfNF+oJvYOnBxxMBoaG33JQwQCb89nU0fE
         AKXd0C8N7RMauqTxl7VOenPnfG2rbS/goGa1TCJ6IEJBxUld0hWv3r78fRUEiNwDimZ+
         6HbQ==
X-Gm-Message-State: AOAM533n+KMMYv6mSLsMDiw53qNsqMJTW40tAiTT6hs7E10Z+wZNW8li
        jfb4uEVuJRO/OQV7TWW/gFcndAgWe1RLd2jRrdo9hsdBKig=
X-Google-Smtp-Source: ABdhPJyZm9hIj3mLnsBzMXwUxCnvlY54zgsZsgseSl5XW03ApJ7oA5fJyMwxAP4l+Hn3inDGpWaQw+zPBentuPjQgQ4=
X-Received: by 2002:a25:5f08:: with SMTP id t8mr10171651ybb.260.1602522122735;
 Mon, 12 Oct 2020 10:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAMy7=ZWoL7w97aR5_02OEjKEkJT8R7OEzpL5Zp8Cycm=yZSLJQ@mail.gmail.com>
In-Reply-To: <CAMy7=ZWoL7w97aR5_02OEjKEkJT8R7OEzpL5Zp8Cycm=yZSLJQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 12 Oct 2020 10:01:51 -0700
Message-ID: <CAEf4BzYnELT0tE8Y4goPWxuBGN+G-37A8A1yjspFL=LK842geQ@mail.gmail.com>
Subject: Re: libbpf: Loading kprobes fail on some distros
To:     Yaniv Agman <yanivagman@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Oct 11, 2020 at 7:10 PM Yaniv Agman <yanivagman@gmail.com> wrote:
>
> Trying to load kprobes on ubuntu 4.15.0, I get the following error:
> libbpf: load bpf program failed: Invalid argument
>
> The same kprobes load successfully using bcc
>
> After some digging, I found that the issue was with the kernel version
> given to the bpf syscall. While libbpf calculated the value 265984 for
> the kern_version argument, bcc used 266002.
> It turns out that some distros (e.g. ubuntu, debian) change the patch
> number of the kernel version, as detailed in:
> https://github.com/ajor/bpftrace/issues/8
>
> I didn't find a proper API in libbpf to load kprobes in such cases -
> is there any?

Yes, you can override kernel version that libbpf determines from
utsname with a special variable in your BPF code:

int KERNEL_VERSION SEC("version") = 123;
