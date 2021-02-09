Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0ED3158F0
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 22:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbhBIVrM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 16:47:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:47298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234395AbhBIVPF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 16:15:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5016864DAF
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 21:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612905262;
        bh=X9UeMDrl1OSXrDvp8ldu0yJ4pWNt4qbCQcQWJBckvUw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=r1ZAvUXwVXwY2hj8i6Tlty27HZLQlbv7H157Aqc6XaqrY6lpTknduhdBjP7kSVxjp
         rO9XU3OMoy+hOBN2eoWj14mxU8JX/pZYx8dNFQz4rI8m1Bxau/M5tbZlCOPQVZ4rPz
         tWlrQRtYWbr5WJtZ6Icu6TcSkEeRP9WLg4HtQdj36ggWqjntrHOBaGFulASR9PPoCT
         Wam+zGfle7q8qsnuOxjTDtTjyAUM+5PSnkN5VANSehs3kL0oEth3oDCON4qioLp+Qr
         taZCF0/GfGFhwVIHEETac/0o8nZwp2lkEpFmfQUdlR6RBZvdaTywWCIopeinWPTwax
         G07AyTinRRP/w==
Received: by mail-lf1-f48.google.com with SMTP id p21so30521994lfu.11
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 13:14:22 -0800 (PST)
X-Gm-Message-State: AOAM533vpvNlzRpZuCxpg3UiYs7aReVuyBZuCWZtW2rxev5wXstuNwbD
        0H27RovL106W8tvGGXVQDxt5jjER4tIo3qu5Gq6bhQ==
X-Google-Smtp-Source: ABdhPJxzCK0AY1HSKZRBHPv9sKMhJY0cBuzEoT0vb++CkfO4mzxvPjt1n0jFmNWrk0LQliwEcvzjS5Fc9vZiUaiQRWg=
X-Received: by 2002:ac2:44c3:: with SMTP id d3mr2435860lfm.375.1612905260534;
 Tue, 09 Feb 2021 13:14:20 -0800 (PST)
MIME-Version: 1.0
References: <20210209194856.24269-1-alexei.starovoitov@gmail.com> <20210209194856.24269-9-alexei.starovoitov@gmail.com>
In-Reply-To: <20210209194856.24269-9-alexei.starovoitov@gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 9 Feb 2021 22:14:09 +0100
X-Gmail-Original-Message-ID: <CACYkzJ4vGQuAXfjB_aH2ek7JUNByZLA4QTb5=GWeL0PLAbOQbQ@mail.gmail.com>
Message-ID: <CACYkzJ4vGQuAXfjB_aH2ek7JUNByZLA4QTb5=GWeL0PLAbOQbQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 8/8] selftests/bpf: Add a test for map-in-map
 and per-cpu maps in sleepable progs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 9, 2021 at 10:01 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Add a basic test for map-in-map and per-cpu maps in sleepable programs.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: KP Singh <kpsingh@kernel.org>
