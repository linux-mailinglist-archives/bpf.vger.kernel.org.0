Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2BB37B227
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 01:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhEKXH3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 May 2021 19:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKXH3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 May 2021 19:07:29 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3945AC061574
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 16:06:21 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id v188so28478573ybe.1
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 16:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0jIeB9NZXXySusATL9acF3pU1kf8oMyb6ufI2WdKtco=;
        b=aYZeBNiDkh1mseoVC2nzJ9wUESTfPzQ217u0iA+LKpXuqBGJU8O4yt1OENhCckqBmU
         blv0H0r6P6INdIdE14rEp7sNQvTwzofDiyNSlzILt4uaUl0Gr+JKWQIY2UzdQ7u+dJ87
         gBMKdWGW0ajVqNWrgRgC3QW3XBo+KHPqZts2cqxcOXIrC2hF2FVXd8maCHivOuGdEf5X
         82hBEGPjqjxAx3rTsFu9EcHnAXFL4dpTz2Bpzvz7pWJ9D8xA5xNZeKslQXibPUPghQb+
         mcNPUuFRk2eZlNXP/reDvS6xzKIj3btHv0hm14i2vnXN2hkghsqS3jFBj51D+4WDTtnW
         lWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0jIeB9NZXXySusATL9acF3pU1kf8oMyb6ufI2WdKtco=;
        b=APr/YWT2CeeM5GYP7QsODhbHYdMOa/0LcuBp60rxOOXY88YonSHzEOlhSCLuB/Ihag
         PSZVrlTxglQ87rIfyPAYTwWbK80j6h8uaZ1jYFiF2HFY9TMLdOl/z9j6pXQsnnfXwKiY
         XfnzYiR3HODF4xGyN+27VGrvsAcDQg9HtXjMMnCjmlV2TgCN3tfS4ipMCAR9Jw6ugdW3
         SoJH3jdQHoGfO4gzIaPck3KjTOu/owWDYjBOzs8NggYBVRoRq1DhY2O4Kyhn6rg5gkVA
         suJxpWUzLcr2jgd6tvutz0ZtwxX/jkH+bqrdQX9pGrtq2KxUaVe0xMADTxfkq2nfkrBM
         QBng==
X-Gm-Message-State: AOAM533OoNjR3UDmKlu8BHsrh2wg5PfvCXEjW8/W2y134Hds3Bm2eUpA
        bPt+Kplw+7Aji5wO4nEZMvWm3T/SOdicRDsMBqM=
X-Google-Smtp-Source: ABdhPJyu0FmMS9NE5mOJikC0zSVJ7lpPTUBb+jABfW0PNdvtaOLnIa1p5Zwk7XzSX0UnExVX7hB6TrBCXW7ATn9dy/o=
X-Received: by 2002:a25:3357:: with SMTP id z84mr43350138ybz.260.1620774380612;
 Tue, 11 May 2021 16:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com> <20210508034837.64585-13-alexei.starovoitov@gmail.com>
In-Reply-To: <20210508034837.64585-13-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 May 2021 16:06:09 -0700
Message-ID: <CAEf4BzYKEsyWckaks2T_OawfnzVc_xCYSkiyKQPWGDQmOQ9urg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 12/22] libbpf: Change the order of data and
 text relocations.
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

On Fri, May 7, 2021 at 8:49 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> In order to be able to generate loader program in the later
> patches change the order of data and text relocations.
> Also improve the test to include data relos.
>
> If the kernel supports "FD array" the map_fd relocations can be processed
> before text relos since generated loader program won't need to manually
> patch ld_imm64 insns with map_fd.
> But ksym and kfunc relocations can only be processed after all calls
> are relocated, since loader program will consist of a sequence
> of calls to bpf_btf_find_by_name_kind() followed by patching of btf_id
> and btf_obj_fd into corresponding ld_imm64 insns. The locations of those
> ld_imm64 insns are specified in relocations.
> Hence process all data relocations (maps, ksym, kfunc) together after call relos.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/libbpf.c                        | 86 ++++++++++++++++---
>  .../selftests/bpf/progs/test_subprogs.c       | 13 +++
>  2 files changed, 85 insertions(+), 14 deletions(-)
>

[...]
