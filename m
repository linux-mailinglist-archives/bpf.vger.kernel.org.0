Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824FC37B203
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 00:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhEKW6z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 May 2021 18:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKW6x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 May 2021 18:58:53 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3D5C061574
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 15:57:45 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id r8so28454699ybb.9
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 15:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YcGM474I+bzgd2iKT8VtlWk5/jAAvFIghDpcjrbAMRo=;
        b=P4WzOdlYWyy2RM6kEl+vZ4oYwjx4PDzPRn93PnWn8MnckQTclxPbhjkPgl1gjx4Xha
         R8ySyfk3l2DoCB5wahPCRPpXZYjpJS6JVb5hZwmBzvHMOk82KKP3SdkLXE5voUvFMwOB
         LuvUee71DVL64KwJVzlzH81CylmsFjyMP4KCKdAGpv8qxwKj5mpxINQ3FDbJklpvZ37I
         U3hskPKYgRWM8UbQgKaMA9MG+nduTQH1RsRQdgAjBaDHeQ3EORv/bwnkFJR/cJ4ysPa1
         LdUdjuRVcuGrVuvhWCr3WYK8N+PJuR1nS/XW56rcOE3RerZ4UsZkbBW/mQ5JY1tD+p/H
         X+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YcGM474I+bzgd2iKT8VtlWk5/jAAvFIghDpcjrbAMRo=;
        b=Dmg4Ns173kou/StY3c3P9MTHEMUixpLIVhK0A4o9DNEiZxiXp6e3SmmC3zZQXYFa7M
         vSf5z/yWO6sElJEvvqOlAYgfv8PTaVx7sXqSSGMcxPYD81KqcXiHxmnAvnWUQjas0rMu
         QMzclS7kV6ZlDjVnsKR11U2pD+ni0OIAm1S1iQ6x07fwbZQ3kgXjw8HpSiZlivF/uLS/
         9HRg3oDOPkHbTY2tylFVnbqapZPJFEkASYIyB9Ad02ojUKv+5VDG7ovzqg1reJ9KbA25
         cDM4crVOM5yixb0Mz96s34bZ7/ZYClIYmSXoVIv5M9WGVNu3pnBJr3l1I7A0lWt9GUIZ
         tYCg==
X-Gm-Message-State: AOAM533ywUSAxXNihcZ2p0RvKh84CiQio8AieVCCkC/gCfijgNdDuI6w
        BPCleexMlbNZ0KS6KjNP1T1D6pYQE70isVKmLsI=
X-Google-Smtp-Source: ABdhPJw5yobqxslUhdoyNEA6FytrlSUM1y08ug80gZtL5xFQE8B4KUR9i66sexXNNQ9YS1u8Rmwc6HymMDPnNgkJCVU=
X-Received: by 2002:a5b:d4c:: with SMTP id f12mr19532479ybr.510.1620773865263;
 Tue, 11 May 2021 15:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com> <20210508034837.64585-10-alexei.starovoitov@gmail.com>
In-Reply-To: <20210508034837.64585-10-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 May 2021 15:57:34 -0700
Message-ID: <CAEf4BzYZFYSs-Vf5Qdx5Jx-m3PUcqekLGfjY_Z0qy_s1qXcK8w@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 09/22] libbpf: Support for fd_idx
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 7, 2021 at 8:48 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Add support for FD_IDX and make libbpf prefer that approach to loading programs
> to make testing and bisection easy.
> The next patch will fine tune libbpf behavior to use FEAT_FD_IDX only when
> generating loader program.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Patch #15 pretty much undoes this patch, but leaves unused FEAT_FD_IDX
and probe_kern_fd_idx() lying around. Is there a problem to just put
bpf_object__relocate_data()'s changes into patch #15?

>  tools/lib/bpf/bpf.c             |  1 +
>  tools/lib/bpf/libbpf.c          | 73 +++++++++++++++++++++++++++++----
>  tools/lib/bpf/libbpf_internal.h |  1 +
>  3 files changed, 68 insertions(+), 7 deletions(-)
>

[...]
