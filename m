Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9569A479DA4
	for <lists+bpf@lfdr.de>; Sat, 18 Dec 2021 22:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbhLRVtK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 18 Dec 2021 16:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbhLRVtE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 18 Dec 2021 16:49:04 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0805C061401
        for <bpf@vger.kernel.org>; Sat, 18 Dec 2021 13:49:03 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id l10so5626654pgm.7
        for <bpf@vger.kernel.org>; Sat, 18 Dec 2021 13:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=749Sb3zqCynaFBje7je7EI1NvLdt1VndpKdgC/q7CMU=;
        b=MP5EvYI6Hcm3/FrHEyW8DhEfR/JDjktWl2AgmoXHYXsC8moE3HoWyq2BnleM7Z+pgV
         QTgO/1jgN1ofF1ixJbPc+k526rMhdePUdUebVDCKz0gI4Q6WZiEGpRMRCBKu7KIeKMIh
         X8riGh/Iqn8lkRuaDINLjc/k7M+7MOa0PPk44HsKdgDLREjs5orXLRGSAmLcjHVtqRFc
         Cc1ioOxluW9m/mfI9+0yNXJGdrHkZgm8jqlgxmU8PjVl/2moLmDKsNa3NVdcWraSHa+c
         v06wZ+pP0yO2n3CqMPXQgU7YQgfPV4JaaG5zV/XmeWAoI4lCELi74aRpt2Lk5k4xzUr9
         PTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=749Sb3zqCynaFBje7je7EI1NvLdt1VndpKdgC/q7CMU=;
        b=2jvUVkirgb8WfMYHsPGzhdvei/I1SDoPa/L9+ux/Jh+CLOdfw5P5QMBuygk9+F1WXu
         DOuat22u9ommfVfIU16RxwoZMnAF7/bXI5+AYz8ow93CvbMbANv3rtF3kkTS4mNXXyY8
         Ce/N+1kgP4wF7jKOuVZ6P6YwXy4iH6DMQO/wKI+P2kFfr1cwB/KsrZ2mZkvqDqarAnR9
         wACQxQjmUWRPHQPmDsBvv6ITKa2ep1r2rL2UBvVmk51pEGz0CUXnuZqnszoeuE87894Y
         wTBHFxTbojL/RP2sOppHZLhasrWZkiuXGbtsrXm23L29X0XlgVK5EWp/4cHCeZoOoA8C
         YMXA==
X-Gm-Message-State: AOAM533NbBknJpzTxYfhQlFf3xw7YvBPdu8SICzpdIxNH4PFKqRmjqix
        M4NJ5G2k0arOY6nZXdXr1ODsfemWO8jwWa0RoLs=
X-Google-Smtp-Source: ABdhPJyWM0dlAE7vUfBva7fogHktT/yZ1sKiabdmTdC8hugIXzsHv5R8lgJdQoyqIGyF2kdJGkCKRl6LUkj1EGyN3+0=
X-Received: by 2002:aa7:81c2:0:b0:4ba:81a8:645d with SMTP id
 c2-20020aa781c2000000b004ba81a8645dmr7811828pfn.77.1639864143430; Sat, 18 Dec
 2021 13:49:03 -0800 (PST)
MIME-Version: 1.0
References: <20211217003152.48334-1-haoluo@google.com> <20211217003152.48334-9-haoluo@google.com>
In-Reply-To: <20211217003152.48334-9-haoluo@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 18 Dec 2021 13:48:52 -0800
Message-ID: <CAADnVQLYrP0P5CZj1domV3n3oHJsDYRbbk+1tym223-Z=Tk54A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 8/9] bpf: Add MEM_RDONLY for helper args that
 are pointers to rdonly mem.
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 16, 2021 at 4:32 PM Hao Luo <haoluo@google.com> wrote:
>
> Some helper functions may modify its arguments, for example,
> bpf_d_path, bpf_get_stack etc. Previously, their argument types
> were marked as ARG_PTR_TO_MEM, which is compatible with read-only
> mem types, such as PTR_TO_RDONLY_BUF. Therefore it's legitimate
> to modify a read-only memory by passing it into one of such helper
> functions.

I've added ", but technically incorrect" to the above sentence.
Otherwise it sounds like it was an ok thing to do.
I've considered adding a set of Fixes tag, but there would be too many
and it's a laborious task to look through all such helpers just
to beautify the commit log. This patch set isn't going to
be backported anyway due to complexity.

Please add a test to make sure that bpf_d_path on rdonly buf
is rejected.

Thank you very much for doing this work.
It's a great improvement to the verifier type handling.

There is a concern that generality of flags may cause
a regression, but no amount of code review will reveal that.
Please watch out for strange verifier issues.
