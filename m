Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCD13F21A3
	for <lists+bpf@lfdr.de>; Thu, 19 Aug 2021 22:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbhHSU3m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Aug 2021 16:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbhHSU3c (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Aug 2021 16:29:32 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFA6C061764;
        Thu, 19 Aug 2021 13:28:55 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id p4so14663576yba.3;
        Thu, 19 Aug 2021 13:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3JaPtcqrHK3x2IZkmKJJcMMIIG+3GBYSfgxgI5nptg4=;
        b=BrBcWMVxFbTXFX2cZ0lfnv47tqAm1CU/b2leevF91AYjOs7dN7avp40NlrwQrnAHot
         hlh5F95zsuKVuJkD5PmftRww9yhv4ZofUCyhU2ywgnEIYqJHrs/JaG9bppfu9kD1dj3D
         RlOEe/3ReXH0PxmbV9ytl5q3yssvZNBXLU+360azaOg2pUP8fDIx8VUY6cUEVFwwjcXV
         X4vH0iFc7BxjZy/T8SD+XVhFlJ+CoC15V99FgtZ/spZ5JZNHX6WmaCwtx8iDjqtmQAm1
         tGIXly8FzBPpqOYJsIg5NLNJbqLmdkcIpQ5oI02jkfcOU/7xOYnsYr+igPSK1HQZTnFM
         BC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3JaPtcqrHK3x2IZkmKJJcMMIIG+3GBYSfgxgI5nptg4=;
        b=rG109w3gpC740ADsNKekVhCx8pZ2LTyURtgrvZkR1WNMGCOYMa4I+GTlbZ5a9QNAT7
         hv+SzZLaZP87jawwpxy9G7WbHtCmn/siMECr+p/QO+ubPGdsQxmvp3wXOv5+NQaEX8mD
         peJrjnYEDfyEYoEBOs/u82vgPCkAX+4wtfDqcwj/JlaXAnFk9bshwNYWHpWxkoiJRF41
         tXtiNfFuenqBs5pdU0GlBPfvxnYTH4d/Wiw58UJ13V2OUmA4GXtJVdZg96a+a7Li0VPk
         pqONe8YG5Wb1DkT8qwcNP/sqUrgmN1Y0wjq95snMtDJdpEDByLq6iQl0am0QEqaHcHf/
         sAfw==
X-Gm-Message-State: AOAM5322SUA7Ons4I+v1Nf35+TBSPfWE3JKAjkoAo6+1NS4dLwdDZEKT
        sTzfbPwFBEbUb14Y4IH8zU4AD6qD9p9EuQZvvJk=
X-Google-Smtp-Source: ABdhPJw8gPzzoa56sgLVt//G60P+znYcqrH5C/V3M2aVK64nHihKgN6rWcItr2890+MQmsWeMRjuNzz5nwgp2U9hv6E=
X-Received: by 2002:a25:1e03:: with SMTP id e3mr2086596ybe.459.1629404934957;
 Thu, 19 Aug 2021 13:28:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1629329560.git.dxu@dxuuu.xyz> <dda52cfef588adf7cf231af7c247b526868c5aef.1629329560.git.dxu@dxuuu.xyz>
In-Reply-To: <dda52cfef588adf7cf231af7c247b526868c5aef.1629329560.git.dxu@dxuuu.xyz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 19 Aug 2021 13:28:43 -0700
Message-ID: <CAEf4BzYgZ3PTNhZfEfKiZOeQOk143ze9Ef+01WbfcSm3NOgdwQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: selftests: Add bpf_task_pt_regs() selftest
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <kernel-team@fb.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 18, 2021 at 4:43 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> This test retrieves the uprobe's pt_regs in two different ways and
> compares the contents in an arch-agnostic way.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---

Please use ASSERT_xxx() macros for new tests.

>  .../selftests/bpf/prog_tests/task_pt_regs.c   | 50 +++++++++++++++++++
>  .../selftests/bpf/progs/test_task_pt_regs.c   | 29 +++++++++++
>  2 files changed, 79 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_task_pt_regs.c
>

[...]
