Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8C246297C
	for <lists+bpf@lfdr.de>; Tue, 30 Nov 2021 02:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbhK3BRR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Nov 2021 20:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbhK3BRR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Nov 2021 20:17:17 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC33C061574
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 17:13:58 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id e136so47490274ybc.4
        for <bpf@vger.kernel.org>; Mon, 29 Nov 2021 17:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MMwI8OUTVktLM8oijwbxAP7Et5KNeaQtmI0gG6WJC2M=;
        b=HU5EmemRqW6yaBw1K+HKkTcsMAO8Q6WtTewRtrCWiCsuaajul3krhup3lr6ziEv+Dz
         pl2YzMDqO6eJY8BrcfeNYWVHAGcgz2CIIXvcDY5WkfCAo/5haYI1JJ+y8VpO/T1cWo8+
         Y0FN+5osE0EoQyMIEAg3lH0+CEw4bNS1YvW+kr7tBCUR0xnPoyJLU2xKIRRV5tKQfAUL
         QBKLelKnAH8T+gNiC/KmuoEEps9j3cyvdJ99z/ozO6F+bDJiykvs2cFn8nKYCXRCtTMk
         qib8mNDPBslpFJ9y/ZX7wht1TDi2xMfcieZHy5x6+TL7Ds/UNnIgZeN9dWC2m3Dk4l5y
         PFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MMwI8OUTVktLM8oijwbxAP7Et5KNeaQtmI0gG6WJC2M=;
        b=tTO4+Bs/R9S/ZR00Dtt3ixqf/NFyPrtH+sV1r5bvmnRQLKJUVF8NwslHxZm7S2ibEg
         x+yl0g3Rv7eUpRToNNfi0SmQ5T4/PBhevptemLwcxsnxIWV4V6GFeQRVlzS5ylnAu4Kr
         RVjXEp8jvZL1db9aZ4q4Zl+W00lbxZ457e3KIiCYHZs+6T/U9ehV9kivWMfQuxun6gTW
         aC+IHFNUF5nw/G9mGVPw68z8HiE3fQ8Z/JHwmzW9/1+/sf6rA1rbTWnLtoo6sLtnnK3L
         /xD7/flBRgMpFWGg6hoUAXC3lL3KQQMUVxQeTj64MhEN+ZzEBy95HSUG7TleaYAm+4UN
         njpg==
X-Gm-Message-State: AOAM531Ar7iS4U0Fx41ftrUA00R96UQGQ49I/2MyrCWWHecivv8oVAb0
        3inja8OIH+nnHbyCozJsA9GchK39pD5SxS54SzU=
X-Google-Smtp-Source: ABdhPJyh4afWlUlZprRTKDQnTo4y4LRq29Hnf1d4mOYLgJi0SZKoEvhFUMcz2SDzaETO7Z4uMO45MzURrGGq3S1luZE=
X-Received: by 2002:a25:e617:: with SMTP id d23mr9976025ybh.555.1638234838209;
 Mon, 29 Nov 2021 17:13:58 -0800 (PST)
MIME-Version: 1.0
References: <20211124060209.493-1-alexei.starovoitov@gmail.com> <20211124060209.493-15-alexei.starovoitov@gmail.com>
In-Reply-To: <20211124060209.493-15-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 29 Nov 2021 17:13:47 -0800
Message-ID: <CAEf4Bzac5JZyQ26fQTiXoMYB-bPBMPWfEFoWNgeU--JtH88AOg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 14/16] selftests/bpf: Additional test for
 CO-RE in the kernel.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 23, 2021 at 10:02 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Additional test where randmap() function is appended to three different bpf
> programs. That action checks struct bpf_core_relo replication logic and offset
> adjustment.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/Makefile          |  2 +-
>  .../selftests/bpf/prog_tests/core_kern.c      | 14 +++
>  tools/testing/selftests/bpf/progs/core_kern.c | 87 +++++++++++++++++++
>  3 files changed, 102 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/core_kern.c
>  create mode 100644 tools/testing/selftests/bpf/progs/core_kern.c
>

[...]
