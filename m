Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493FE37FFA0
	for <lists+bpf@lfdr.de>; Thu, 13 May 2021 23:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbhEMVKn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 May 2021 17:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbhEMVKm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 May 2021 17:10:42 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ED6C061574
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 14:09:31 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id l7so36331543ybf.8
        for <bpf@vger.kernel.org>; Thu, 13 May 2021 14:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MHMGaXrOcoN8I1SBVylb2qKViu3ky2Cu5wTSxIBFDbA=;
        b=Ycyli/ZG61zGmdPnBB//k7yegbfX1ANICs3TCgzbbBPFi4MU8W746my/61tKWy+Np5
         xiayMRfYZdQyrsuSFigxIyO9rebLv1OBpBamQh9YBHXMb3J3RwfwuyPlnb1UrjHummoa
         9iXUoLtbtG3efb5vTA4kY5THKLBxLFw0mBM6n14fTB0PNbfse6FG1Xj0atF8zyyHE2Vn
         RmX7zKo29QS8B/b96bnQsNW6jBkvytiXUN6O/+Ibp6knC5Kv7QhkK/raqHpMo1esLk8E
         rPW7cSk38J9gRlsUbYAsxDp28E2d3iq1bkaNjXRfaypU9+zKeWaac8ZlLur24L61+iev
         a+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MHMGaXrOcoN8I1SBVylb2qKViu3ky2Cu5wTSxIBFDbA=;
        b=B6XaoO8QOXjS9ZXrfhDcyWz9zrEvJ84biRIsQ4vl9sQ51azAYI6nBvzxXHK1gPOr/6
         c6cL3n7S41vZ/+O51UuQ5Nim02uar5GUo4OuxoeDqU5BN+ONc4lgTGa5lCGs1sH2UL2q
         WlfGHxrsoUUsipjGoUofPbFPy1SZLmjc7Jg/2OATGVL+zo54Ep72RiA6BWjRE1U74oOl
         R/B8h+EnRI711cLH78QdVPinlK0IDEZkmMwIr4LZYR3XmVo8iWbhaqoYAaootL3jpRQt
         HeiMNbcVogGZTFVZ0hqAh/F6j2r92o/z8oc0EDrhCp04I5KO2jxYAtEyRUGqCjSJyqBr
         9uEw==
X-Gm-Message-State: AOAM530ABuhXtPJGLyV9nBbCd2xxcLCrd7lLqCfIkXr3RqTOc31uw61T
        Hs/TtBnOUg1aCnLelm6cLuwY+2ijuNZN82QSqS0=
X-Google-Smtp-Source: ABdhPJxbwwDrsrqyx69XNTJDItAsWVudjCoclUXbJkdj/vhH2itjm5vZGsb3abl1id5Y2ZFXgCxCTKOoO5s+agLNUFU=
X-Received: by 2002:a25:7507:: with SMTP id q7mr58994452ybc.27.1620940170602;
 Thu, 13 May 2021 14:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210512213256.31203-1-alexei.starovoitov@gmail.com> <20210512213256.31203-14-alexei.starovoitov@gmail.com>
In-Reply-To: <20210512213256.31203-14-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 13 May 2021 14:09:19 -0700
Message-ID: <CAEf4BzbysbvRAV9pUaBVm9JEgi+Sn41vm5hj3ZupkSc76rDpfQ@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 13/21] libbpf: Preliminary support for fd_idx
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

On Wed, May 12, 2021 at 2:33 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Prep libbpf to use FD_IDX kernel feature when generating loader program.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

LGTM, thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/libbpf.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
>

[...]
