Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5294123165B
	for <lists+bpf@lfdr.de>; Wed, 29 Jul 2020 01:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbgG1Xj1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jul 2020 19:39:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730252AbgG1Xj1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jul 2020 19:39:27 -0400
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96512207FC
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 23:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595979566;
        bh=o/TZSIWlBu3Fg99ClCeRJa2HWjaJaYjsM1s6e9myl28=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W7jC3OY910HIteiHegQfc9wPAcovHsAHWXXnIKvLRv5Ca/dKLegyG6t2maiJLiMY/
         d9NwskBordWSrSMrOXhfw1X60Km0bNuA2f1S7B8xi9Y4fja1F2JKzmfc6KMrdAv2jy
         Fqvzw3d7tsSiSgxWJh4xA3QmnUB40B2fXogwa0iw=
Received: by mail-lj1-f174.google.com with SMTP id b25so23054585ljp.6
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 16:39:26 -0700 (PDT)
X-Gm-Message-State: AOAM5330N2RtaGx8Vlzk3KOd9w+zMhJ/Q6M9rmCroGUfbAy1zi6XFZTq
        Wuwec0ZsdkKUOC0bssJgclZQvZUe05IdmX/5gZA=
X-Google-Smtp-Source: ABdhPJyZU+VJWXfhNcI57lSLzf6yv5Sk4/eyhpBsSuClRsm23G7boy5QMmWl5aZqBH0O/3gg6qzXKsPxgmwmSinP9WQ=
X-Received: by 2002:a2e:9996:: with SMTP id w22mr14776616lji.446.1595979564906;
 Tue, 28 Jul 2020 16:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200728221801.1090349-1-yhs@fb.com>
In-Reply-To: <20200728221801.1090349-1-yhs@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 28 Jul 2020 16:39:13 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7QRpWMNUGNZ7cGpDk95Lw57YALF80Bir1GwKS77T+Org@mail.gmail.com>
Message-ID: <CAPhsuW7QRpWMNUGNZ7cGpDk95Lw57YALF80Bir1GwKS77T+Org@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add missing newline characters in
 verifier error messages
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 28, 2020 at 3:18 PM Yonghong Song <yhs@fb.com> wrote:
>
> Newline characters are added in two verifier error messages,
> refactored in Commit afbf21dce668 ("bpf: Support readonly/readwrite
> buffers in verifier"). This way, they do not mix with
> messages afterwards.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>
