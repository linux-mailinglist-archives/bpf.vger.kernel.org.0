Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6341432584
	for <lists+bpf@lfdr.de>; Mon, 18 Oct 2021 19:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhJRRxZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Oct 2021 13:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229980AbhJRRxY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Oct 2021 13:53:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7204461027
        for <bpf@vger.kernel.org>; Mon, 18 Oct 2021 17:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634579473;
        bh=u6QWqiUgWbhMy5kKtY+v7uHICEhXmfC7GiaP0uPCtPs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fV9Hf5j3M2d4GUiGk4pnwvnAnVEOraznewoAXT3KIBAlxMkCYvR9AM/xKNQooFijI
         GGsspItVFzJLE4fT2foDA8GDsY+eIuUZ2rnXLqSFEkzRw6qiYNxMFhG2k1jnocq2R+
         aVl4hsmccUqAuLDY+rYmtzXNHaljV0AUgNvx5N2s3cv/XBWKFJfTlo62yq39BoqVel
         87bmijGcyDXEA+dAvWQ2kk2sbzF0Bs6pdd1QR93OwJ+lAqFfnbqIYYNh58lx74M6xs
         2AkJNDI3hXrJDuOeuh6L4Hy4B4BpSHDlu8Fi+Z9A2OBlduF26vzI/f30BSWIVHgnRe
         /LQY9Phbpjl3g==
Received: by mail-lj1-f172.google.com with SMTP id s19so1169033ljj.11
        for <bpf@vger.kernel.org>; Mon, 18 Oct 2021 10:51:13 -0700 (PDT)
X-Gm-Message-State: AOAM531y129zCkOGpezSJfvWFQa/4w9t/fXeDVsnlYwcEqlUqDRFLYIS
        Wvc4YTZPPge/vGrj945qisCE/2VxaHVzVeOHEfo=
X-Google-Smtp-Source: ABdhPJy9YRBp8QdA7AL4ZxZnhNm/nmBI/KtO2qoWfyWuxSCeyfNbzWCWgI/ED5mOal6NuLPEWi/jKxAEDyAKuw7XT3Q=
X-Received: by 2002:a2e:6e0b:: with SMTP id j11mr1194551ljc.527.1634579471676;
 Mon, 18 Oct 2021 10:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1633535940.git.zhuyifei@google.com> <ee26bf5f68535bdb902b711a36f6334fad36d58d.1633535940.git.zhuyifei@google.com>
In-Reply-To: <ee26bf5f68535bdb902b711a36f6334fad36d58d.1633535940.git.zhuyifei@google.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 18 Oct 2021 10:51:00 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7TGVFN8Pf58_8c+s8EJtvgm14fDmb+enYtBR8kRFYZNA@mail.gmail.com>
Message-ID: <CAPhsuW7TGVFN8Pf58_8c+s8EJtvgm14fDmb+enYtBR8kRFYZNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Test bpf_export_errno
 behavior with cgroup/sockopt
To:     YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 6, 2021 at 9:05 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
>
> From: YiFei Zhu <zhuyifei@google.com>
>
> The tests checks how different ways of interacting with the helper
> (getting errno, setting EUNATCH, EISCONN, and legacy reject
> returning 0 without setting errno), produce different results in
> both the setsockopt syscall and the errno value returned by the
> helper. A few more tests verify the interaction between the
> exported errno and the retval in getsockopt context.
>
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> Reviewed-by: Stanislav Fomichev <sdf@google.com>

Acked-by: Song Liu <songliubraving@fb.com>
