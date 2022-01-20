Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1296149568E
	for <lists+bpf@lfdr.de>; Fri, 21 Jan 2022 00:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233856AbiATXBQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 18:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378092AbiATXBP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jan 2022 18:01:15 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F370C061574
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 15:01:15 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id d3so6257934ilr.10
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 15:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y65eY2rbT3oEoU2d0kJhobZ6IrhR4/QNrE+yfvGpzFc=;
        b=cZltSoPc5o+btRAJYNQQOCDd5o9fJuJdW8DzfVUkRCGCdfeDwyj0UdF84oTZQhcKPn
         MXlYM4QYKuCJo+eT89AJQ7xYc3baKVkvjPnK0AfKT9xoN27N6CRUcS3im6XbNUgxQSjY
         esqxl97sW/mSBOMYk9jbdok2TW4L2ADxJUlKueFobC/l6PQwn1K2fFNERwKQ/WLE9LZt
         UGFWfL9sWPm8mmG6RGkXm/rxG36OIhwb40OE/qQZh2DQ0XrUeG2X9RMcjMBHxtuX5eMW
         y2luvIGU1qUTksH9KSu6tVBeTf1RLDZe5fd4mgdnvLgN3jLMyL2y8K+0Xj3ilY7eE8Ga
         zaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y65eY2rbT3oEoU2d0kJhobZ6IrhR4/QNrE+yfvGpzFc=;
        b=l+nk4TviA3b38Futr3eFCZnGpzEqozYQgvxcM5VzuHOv8nS/685JIMZNT5BzHQBxB+
         xM4nVFVOH3mG68CTjxcEUbzPzzDOPLxH2dL6RTxNhfz/oWftA+Qx857aTH7syI9ixbvj
         Dvflab1MS8OqytIZLGYO5roQfGK7T1sAK1msG2fl5Lwk66KAVKywOaBXMo+pUoCPukR6
         BtQR6XHiAr2VyDDJ02Hyi56l+jqIV3Jd72EnmHQtJmL4iKeI3L3LTLSsG9Msudm77tkb
         sI04cbcK8NsP9XL8Eao2bWoNIpKGDJSljUt8MG/SqIXYbnCVYRKerAUAVcZNBJDP9FHn
         mr0w==
X-Gm-Message-State: AOAM533YP2ej4vcSx/mGNd8BDncvD51ZSI8M6DPzFPLn8j8Qq1IYusv5
        3xszPg5tx9mJEPw6NUzMzGO3+wVjrWzqfcphXv4=
X-Google-Smtp-Source: ABdhPJwEvaVyGDABBMwNmSSaQyIT0PS1Oo2X9aT9IrRtUPeQqAGSWVH0bX+0OmxxtomOg2cX32jE/iquv0Y3TF4OASk=
X-Received: by 2002:a05:6e02:178d:: with SMTP id y13mr622943ilu.71.1642719674823;
 Thu, 20 Jan 2022 15:01:14 -0800 (PST)
MIME-Version: 1.0
References: <20220119131209.36092-1-Kenta.Tada@sony.com> <20220119131209.36092-3-Kenta.Tada@sony.com>
 <CAEf4Bza9A+iC49bZRiSPWNuy+=qG3sc=_XvKem4Fj2zZF8merg@mail.gmail.com> <TYCPR01MB5936508A473D90FCA8C779E9F55A9@TYCPR01MB5936.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB5936508A473D90FCA8C779E9F55A9@TYCPR01MB5936.jpnprd01.prod.outlook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 20 Jan 2022 15:01:03 -0800
Message-ID: <CAEf4Bzb5ShGTVwf-62rYzA0EKqSd=HkMuWeaO=Og4xyN8k6=AA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] libbpf: Fix the incorrect register read for
 syscalls on x86_64
To:     Kenta Tada <Kenta.Tada@sony.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 20, 2022 at 2:57 PM <Kenta.Tada@sony.com> wrote:
>
> >did you check PT_REGS_PARM4_CORE() definition? This should be
>
> In my local test, this wrong code can pass the correct arg4 because the test just checks the value.

The biggest problem is the lack of bpf_probe_read_kernel(). Your
definition does direct memory read which won't work if pt_regs is not
an input context to the BPF program. Which is exactly the case for
syscalls.

> Anyway I should attach the test for CORE variants at first.
> Sorry. I'll fix the issues and add tests for CORE variants this weekend.
