Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15265380F71
	for <lists+bpf@lfdr.de>; Fri, 14 May 2021 20:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbhENSN6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 May 2021 14:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbhENSN5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 May 2021 14:13:57 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B120C061574
        for <bpf@vger.kernel.org>; Fri, 14 May 2021 11:12:46 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id m9so201798ybm.3
        for <bpf@vger.kernel.org>; Fri, 14 May 2021 11:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9oT4wtVWFX0wa+r3uIhpOxKpmW+jcLy+4FqkDOmmLo0=;
        b=Cq/qywe0LsYYFsCgeY2g7J7IAydQi8CZBNGj9NiNMO9zkEyZ3cq3an1I95W2VbNeNu
         pFdbjtx2fQSMEBEUuH+VLmYk463aIkMai7I3BmsTlSNqSRJPi74+x03EBHfrDd61ZcGO
         4WbnUbWyZe/v8rtJgnfje6S7VqRD/Rh0fm1SeoD4A4TXKJFDJn3yor8MSa16sVG5+Fj0
         13rdpD1+zrkuyniXA6BXsyu2VA9fxq9UqrzCjUa4kCMFnxDnpHV3ID0eD6UgtRU3Liuu
         lh6MUE3axFF0BUc5x3HK29SpuE80ukYw5qa/m8q8232DPGib5lH1qMn1lGPGpw7K2uYR
         63Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9oT4wtVWFX0wa+r3uIhpOxKpmW+jcLy+4FqkDOmmLo0=;
        b=ovm+8x6E1ojoOB3rTIE9kUP+FvHjXuns2MKWCGb6WpEr/h5jXXiv7d4eYsSgRoWIXL
         vp+QJld6P+q58X9rBxeX5Hl4ScZJtp7KLDx9zvdnPPtumXqPTZFVAR5+lm97xL7E35gt
         uH/Z9rqWan3TNuv/mud7WvqgI0wV0zM7lbGAqw1I9Ma/4CX5VTwDmuWJh0XhlLqDvR5r
         3Rn0ss3MmZ4+drqhGXMaafp6GQJLEDdJebHvrgnfur7ki9sL85e7E9y/Z7TCUK+GU0iJ
         U/AERrJbPOEWtVTdW8+CHEwUPdR/pnya3c4guGN+lvaFibHhmb9abXalBD9ZaNcZ2+zB
         LpVA==
X-Gm-Message-State: AOAM532PmOsbCX8Tt8dPdhtzbIW9l3VTfx8bS2YDCC18fxmMJUPJzYCM
        zRa7Y/GWwJpuzp4lxS7r5fWpFRZuKpwAlHVbrlo=
X-Google-Smtp-Source: ABdhPJz/907Hmmtf5hTuXoUMSx3toVWzQH5BSUKdZGRHc6sJPZHz8plpNJWIiKQkd6lqmLUVZx4DTV5/VMDso5ELDmo=
X-Received: by 2002:a5b:f05:: with SMTP id x5mr20934132ybr.425.1621015965686;
 Fri, 14 May 2021 11:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210514003623.28033-1-alexei.starovoitov@gmail.com> <20210514003623.28033-8-alexei.starovoitov@gmail.com>
In-Reply-To: <20210514003623.28033-8-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 14 May 2021 11:12:34 -0700
Message-ID: <CAEf4BzZmRsjY3MEw5rK-xD61EHn_gVZfN_kWA9b948C+ZR=84w@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 07/21] selftests/bpf: Test for btf_load command.
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

On Thu, May 13, 2021 at 5:36 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Improve selftest to check that btf_load is working from bpf program.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  .../selftests/bpf/prog_tests/syscall.c        |  3 ++
>  tools/testing/selftests/bpf/progs/syscall.c   | 50 +++++++++++++++++++
>  2 files changed, 53 insertions(+)
>

[...]
