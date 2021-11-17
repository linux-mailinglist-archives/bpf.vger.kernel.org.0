Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3AF453F4B
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 05:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhKQEQz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Nov 2021 23:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbhKQEQy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Nov 2021 23:16:54 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4A9C061570
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 20:13:56 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id e71so3316244ybh.10
        for <bpf@vger.kernel.org>; Tue, 16 Nov 2021 20:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oMH0Eqff2CaJQ6IvGiie5voB30Xd7rftWDJhdw1pT2Q=;
        b=o+vW5JWZsGRb7xi9qux2N00LNSsa0B6mUqdc2JWCyVryVFhFnuDSu8Gfk3Y8KyMtaC
         XE789j0TJnfdB4ZtJJsGeZF/tK0VHmem4gcdWox2iR2U6JuSWn4cIGWc5IQvEQF3HrA2
         3lbrSz+KZksuPzcPk6oqqfOLtUbIeJ+z0v5p+CT2oVEB+vr7Sh9259iK1xkjzFq+0q8O
         ORdEnpDFu7X+YirsY7/8kY+/pdlvj6pRnWpi2p/4COSVYRpDq5HlZHuBHFYqgXpxQuOw
         xCxqJ3fxQP4UeBIRG/6wySaKaMbcZ9K+QOLdNEb+yKm7k4Sg5TjOXor3sBANvl0dCWoG
         Hu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oMH0Eqff2CaJQ6IvGiie5voB30Xd7rftWDJhdw1pT2Q=;
        b=AcbEZGs+/mUfMp7IGkBWubWA5H4t2In2Ub6FSLORnXyJQcqji2+qaqgMCg8ND43EQu
         FIvZwD3TBvh994HT8LQXIIwNwSd3tJTrKBoYrDSyFV41Oj48wTfQLsBdNzZdOl+f+EZ8
         609zJhlz3lnXrDD+q7CTt63jMl7LUfyG1Vr8HyG6H+9+qx8yPn89mcbn0gOF3WI0eWT9
         81TIPfvYdwBArUJvIXJQD88svTyHaShMT/GRIkgKfpD413QeCUo0UK5BvKF/javr3s/1
         1xS5GbIrn57wBbDtFsvaEgKfXREh04AV57ysHlNSVgaYjA9l0pBKiTm6rnwWshT9NZJM
         cF3Q==
X-Gm-Message-State: AOAM533VUg4zYW6/DQMDFTLCT0Vi2PnA2yyiD17hIitujSaZP7ZgNnMB
        88tsIhBgvMa8L/lsN+ci/njrxa7xmyZXtjvY9+4=
X-Google-Smtp-Source: ABdhPJz9zuOXTjukCVx9qW58QSYo2wuW/zmV5+V+7TT05iLm+ynn66/gXJBcy5uepUwwq4Z1iFeg4dwCgKpVo/IiXxw=
X-Received: by 2002:a05:6902:1023:: with SMTP id x3mr13967044ybt.267.1637122435583;
 Tue, 16 Nov 2021 20:13:55 -0800 (PST)
MIME-Version: 1.0
References: <20211112050230.85640-1-alexei.starovoitov@gmail.com> <20211112050230.85640-10-alexei.starovoitov@gmail.com>
In-Reply-To: <20211112050230.85640-10-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Nov 2021 20:13:44 -0800
Message-ID: <CAEf4BzbNDKA4ZuL4MrxmKBU557hBTTw5TKwPtEskioOd_3p9fA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 09/12] selftests/bpf: Convert kfunc test with
 CO-RE to lskel.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 11, 2021 at 9:02 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Convert kfunc_call_test_subprog to light skeleton.
>

Let's keep the libbpf variant of the test as well. Both kinds of
skeletons can co-exist, we already have tests like that that test the
same functionality in both modes.

> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile                |  3 ++-
>  tools/testing/selftests/bpf/prog_tests/kfunc_call.c | 10 +++++-----
>  2 files changed, 7 insertions(+), 6 deletions(-)
>

[...]
