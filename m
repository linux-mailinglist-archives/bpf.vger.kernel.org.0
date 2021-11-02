Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865E44429FE
	for <lists+bpf@lfdr.de>; Tue,  2 Nov 2021 09:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhKBJBT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 05:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhKBJBQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Nov 2021 05:01:16 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA187C061767
        for <bpf@vger.kernel.org>; Tue,  2 Nov 2021 01:58:41 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id l43so1395100uad.4
        for <bpf@vger.kernel.org>; Tue, 02 Nov 2021 01:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0FWFvooRQ3BCwiPpGESwloG7M4vgQJZw1xUg3WsuB0=;
        b=UulFceFSyolVQHNdc74HQV97H9vMH1jLPyOScQRdjH8pnMQHkXEpkKACTveEWW1i/P
         QelI8WHY8JoDNXa8Jd6oz6xhK/mLJoWSy1gpx5WZLn3GzCr01mYqnvI1tgazlkl6ywve
         6zPQ4ps0+XRPgwhfZtzV1vGj1qcEim9Kh6ZcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0FWFvooRQ3BCwiPpGESwloG7M4vgQJZw1xUg3WsuB0=;
        b=X1Lwps9U/lND0lYPS6OYfP6uzk8NLzdEZUoDFsDnYipuoTkIgH0F8uX5xVvT1Fgx1K
         ZkUGDo/jdNcOMEY2gM6XEaLwO3cQQ2LUyMysXm6Jtodgcjk+hUfR1rIzNQaknVukPK3a
         X70yEHHCQ/zazMkeWYw1HfnmK0muugq+34CHG77j0jl1RF+UW/HKgQC3uumkXWNIqqID
         lJHncpcEoIKSGM6yZgWxqIRl3g1U5rDYZVachB46hRJPIdxRx+Oz9M1HYjLSrk3JBJC/
         wTrxr2qzidV0h0O5zYgnybL7GS60uJbS+5M2PWlH0r/xA08wkTxgLldyUXxVIlnklWjz
         NYyg==
X-Gm-Message-State: AOAM532vvv83T0SLzH72qL3CdqzevuX7DuDsM3eYLtC4E7RnopPyHrwK
        rcGEP/dnN3KKac3XjklJGdLvUGepse+ui3oh7a7bFQ==
X-Google-Smtp-Source: ABdhPJxAcIRp5bCsboq/PHYTKXzOWFkcsHz8w/RuffGqkbIhOtm2luASGgkXadtOCQo26oyx2n0EEQnk1jbsY8EYL4Q=
X-Received: by 2002:ab0:3d07:: with SMTP id f7mr14584946uax.11.1635843520868;
 Tue, 02 Nov 2021 01:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211028094724.59043-1-lmb@cloudflare.com> <20211028094724.59043-2-lmb@cloudflare.com>
In-Reply-To: <20211028094724.59043-2-lmb@cloudflare.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 2 Nov 2021 09:58:30 +0100
Message-ID: <CAJfpeguhq69y5jxDfV7pCeTJHbrqvBw-9-=YRzVJeGYL9gS+gg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] libfs: move shmem_exchange to simple_rename_exchange
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        network dev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 28 Oct 2021 at 11:48, Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> Move shmem_exchange and make it available to other callers.
>
> Suggested-by: <mszeredi@redhat.com>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>
