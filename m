Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B86ABF1AF0
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2019 17:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfKFQQL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Nov 2019 11:16:11 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41845 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfKFQQL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Nov 2019 11:16:11 -0500
Received: by mail-lj1-f196.google.com with SMTP id m9so26750379ljh.8
        for <bpf@vger.kernel.org>; Wed, 06 Nov 2019 08:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGPUsPyyRZGBgRHd18+89r41fdXlQ11Y76Wnohi+zdE=;
        b=vXbJ1OgQKmrWn1KiwTYw/fUxuxOOIJkm5AIZvYCj0kryna6WVqIm6rgapWdy+KOK9U
         hGjIymWvbAzjWTWtj/1quIJY/eDvsGmB9JcMYlRy9K7h0IldyKkvdDcD+hI7s9d9PHqi
         qNOsZRxgHLnzuhFGSgC1rq2kp3zKQDzbVl089eT5PeG5eimyP9h6UvgpDyAUA+1qzv44
         qdmQqxJ/EVsFvL6bcFJZgRe1bDRGh+4rN3HJXg1uGHmLEeF7P8/3iR1qcBtcctT6HPGJ
         N7s/EsdUYlezuRLN7zMUTQKWp2Oa1HEVfJR2IpxtXTTYTzmLiZNEz4GYhbALF5Ph3uKM
         nlog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGPUsPyyRZGBgRHd18+89r41fdXlQ11Y76Wnohi+zdE=;
        b=O+QpmWMZGv9KxCtlbfw85o7bw21uYaORcsl1IDHqUrRWlB0OP6jr/8+kwlixWPmP+a
         7VI9H9++sAokfGbdqTPizMs6gdzw68Jn1skuTs4Tq1oJZikfCjkL2gqFcFSYzn1SD9B9
         LAVKFI2iwY/LnbOtYJvThwZ2YOK4Fz5KetbpgQTvxeMWXRm2Um4t4HqtUzzZ9Kg8JO9D
         xaQHIBs1qHX6+OQEEXWKsW3pihNVuzC6T5g4Eoyqhr5fQc5iEdSrtjZAIF0W5NxJ9k4u
         YDfOuh3d6eDdX1trt1PiIPl05La6oVUhb477iwkz7PtcyPKdDckwD7qWOrumNIU80P80
         ji7Q==
X-Gm-Message-State: APjAAAWRH15+FHhF3NM0RHtFK3BxfQ5zk97LPAl3wpZmCFgrHEWZrLHC
        axLMtz7TvyLGO1ki8MIWT62vzAGSDc1MJcDj1pg=
X-Google-Smtp-Source: APXvYqzOIfX1FNT/wT/BmMLT8C9TIlwKO8a670xGNkzmcHlcwNLhhO8N5i/P4YnhnG1XAGABzn0HxsCmbQ8ysag3rBc=
X-Received: by 2002:a2e:2e10:: with SMTP id u16mr2674632lju.51.1573056969024;
 Wed, 06 Nov 2019 08:16:09 -0800 (PST)
MIME-Version: 1.0
References: <20191106161204.87261-1-iii@linux.ibm.com>
In-Reply-To: <20191106161204.87261-1-iii@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 6 Nov 2019 08:15:57 -0800
Message-ID: <CAADnVQ+jOo61VoOp+CDAW7k+GnacgEB8Kge-4JsDBaF25sVhWA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next] bpf: allow JIT debugging if
 CONFIG_BPF_JIT_ALWAYS_ON is set
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 6, 2019 at 8:12 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Currently it's not possible to set bpf_jit_enable = 2 when
> CONFIG_BPF_JIT_ALWAYS_ON is set, which makes debugging certain problems
> harder.

This is obsolete way of debugging.
Please use bpftool dump jited instead.
