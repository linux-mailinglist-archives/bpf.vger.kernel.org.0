Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909B620FBEE
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 20:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgF3Sms (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 14:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgF3Sms (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 14:42:48 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F26C061755
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 11:42:47 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f5so7921704ljj.10
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 11:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=28+DM1cpio7TJHEp6TrIhTbdoj76eSdZmTNivaIY23M=;
        b=pdW+i6XzRO5Ubnrvds1apqPq9KMBTSExU3CdorPyr6z7aLcTBcZju5MW1eWsLgZJLG
         GvyjAVxtn5ZNIeXxDe3wWWTI3L/qcsw+J7tP/P9UIBalYQvKH4gVcAxDYBFxnWHnljbJ
         GUs/aT2lEdku54dB/sU6xHisr72BCinvtMbOpkNAXNq5sU8Qe6XWDPr64/dfY9ZLsk/a
         /cG2NhLE8oSam3v4//t45o6b3O5ZjMON/F2887ifNhjOO2oAv3qo8vJ+rI9SOFbqS6k5
         jixmVb3iYLaUBSaa5E29mhINCfv/dlUb+4niyIZhLKjTAGX+B9OKEalDvY6xPnuqfst4
         z2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=28+DM1cpio7TJHEp6TrIhTbdoj76eSdZmTNivaIY23M=;
        b=P9boNn/OOA7wYWYmnbKuMmP+XI7xIDwsRAxyNpbxjTDaiyNRW2fH7p4tWP7P4Kmctl
         CcayOnu+qWxLmj5V9MTI9FR77ZR26uCA5vEPIbCyxAtsQdVgqr4ffHk4ESzu9N83f76y
         kFwaC6GlA4X0n+tL6QxY1Qq+CQCDtTcQObedhvYXBET0za1zi0YQGMLEAgaOHme7QEUs
         ZfDKdyyJNsutdmpjXTyYMliOKkhxvGnFHb4YehKVUvsaowR1lJB9LeagX5vZ59XdXQzM
         atSCUpO9Du/Vau6NU3zkzNw0MJh/kHgXBrfzbeuAu5dh4H6rtthoCpL/QvdYiSJf9uIQ
         Sxzg==
X-Gm-Message-State: AOAM531ureOemwM8qRe1G9YDb609JMNIl7w26VVJsInggJdNqpy4oYpW
        2sRj2k+LtMKo1WHg3fs2Xhy530sejWYlqyZGcn/DIg==
X-Google-Smtp-Source: ABdhPJx8JS/GhqfaME4gQVdDkRAVxpRWKZl+lo1zH4knfM+Bj07U0xitzSAmbwilwgXAPiUJgj5KgN6aPkHd4pos124=
X-Received: by 2002:a2e:8ec8:: with SMTP id e8mr1608503ljl.51.1593542566274;
 Tue, 30 Jun 2020 11:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200629095630.7933-1-lmb@cloudflare.com> <CAADnVQ+VN6nUCQC51nByeKa+uHG=O-GyzeEpWQgJ8OP815RB2A@mail.gmail.com>
 <878sg4mmlm.fsf@cloudflare.com>
In-Reply-To: <878sg4mmlm.fsf@cloudflare.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 30 Jun 2020 11:42:35 -0700
Message-ID: <CAADnVQJ6ZxCwik7r-XW3bt+h5p37Uq3WL=Rm=yChbkHQSHaj-w@mail.gmail.com>
Subject: Re: [PATCH bpf v2 0/6] Fix attach / detach uapi for sockmap and flow_dissector
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 30, 2020 at 11:31 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>
> But if you decide to keep my patchset in 'bpf', then can you please also
> apply the today's fixup [1]? Or I can resend with correct subject prefix
> tomorrow.

Already did.
I found it in patchworks, but not in my mailbox.
Please cc myself and Daniel in the future.
vger can be unreliable some times.
