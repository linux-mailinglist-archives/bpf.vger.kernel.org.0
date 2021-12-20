Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1DA47B43A
	for <lists+bpf@lfdr.de>; Mon, 20 Dec 2021 21:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhLTUOb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Dec 2021 15:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhLTUOa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Dec 2021 15:14:30 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FA2C061574
        for <bpf@vger.kernel.org>; Mon, 20 Dec 2021 12:14:29 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id a1so10861239qtx.11
        for <bpf@vger.kernel.org>; Mon, 20 Dec 2021 12:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tfnn/ot4ATgAAJ497pIGc+b/k/W8s20cdxtoOaUGiGs=;
        b=V1+e7KxvPZRQ2j9uKvZr3iyfL7pb6BRhaRz5h1To5h2pDFWJaxfSQWCpHAIYYE7o5F
         40N66JJnzLvFKHFHGz6MBEDCFQvvc1J0reFsJkvB6ZLRsZ3cYHAb7hHtGdpRByYHrZhz
         Hjz3FKcc/leKHXg/Sj6iLHiGWm9WaFl+ib8yEsTf30ovemVLbn2bWmv3H2nKicaJ/sni
         rNR0xjpwHSm+q7nQ0kyugNlIdyHrmwHvC7U9SqdCz/lugQN9+PNdY7mRGFJrlLTRkxrZ
         zmZJqdj77TFZx9X1lkAyRgx0EFFIHHwu/gIXrhZooBHwu9zYD2Z6SdAl4UKWdZ16gYYq
         AiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tfnn/ot4ATgAAJ497pIGc+b/k/W8s20cdxtoOaUGiGs=;
        b=p1mLpK0uAYIubYpl3THai1n+FKb0NCZPrdIalX4bjA9i07pKd3cYV1XXkHRTo3y+8y
         vJZ482DuJPKZJy7Yu5UNBl1V6Lhh4QCVAhoqjtzWrTqsVVivVxIGu2CEY2jE5HR9zjO4
         pKf5NOa1mxfCsmhECRcYVCics3Cw48HLyF9jwA7tCw2/C4hwZLYVKO0mA23HxJG8b+37
         0622vrgsCYI3RTazi1DH6EcYWMrvVLZbGIL64ZdUYSKZOlAil5JMAOYnNFHaZMr00th8
         o69Stsl0Xw4L5NjjwGUhuMu1iszlAp5fQz40B9D0SbeOq1//FcJfRXZc/YNsSsGv/0SL
         RsAQ==
X-Gm-Message-State: AOAM532kp2jMf9xOLzCm/WtVH1tc0jYCRUPRA1xA/+xcJiJu53krYA2A
        UdJ00+ARheUNtkhj3xvJqQt6N7PkQhXe/wTSi2ox/A==
X-Google-Smtp-Source: ABdhPJyQBcmILaJUP9uuaO52sfLuuacoY0VNOL3urK7c69BnU09ArR6FELMhb/dHf5agzRn0itx+2/U4N1x/LztiM68=
X-Received: by 2002:a05:622a:108:: with SMTP id u8mr5344834qtw.333.1640031268822;
 Mon, 20 Dec 2021 12:14:28 -0800 (PST)
MIME-Version: 1.0
References: <20211217003152.48334-1-haoluo@google.com> <20211217003152.48334-9-haoluo@google.com>
 <CAADnVQLYrP0P5CZj1domV3n3oHJsDYRbbk+1tym223-Z=Tk54A@mail.gmail.com>
In-Reply-To: <CAADnVQLYrP0P5CZj1domV3n3oHJsDYRbbk+1tym223-Z=Tk54A@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 20 Dec 2021 12:14:15 -0800
Message-ID: <CA+khW7jvBb+_5g93PATeMB4weYBihtEngx8kX+m-ny4p9yUZzg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 8/9] bpf: Add MEM_RDONLY for helper args that
 are pointers to rdonly mem.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Sat, Dec 18, 2021 at 1:49 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Dec 16, 2021 at 4:32 PM Hao Luo <haoluo@google.com> wrote:
> >
> > Some helper functions may modify its arguments, for example,
> > bpf_d_path, bpf_get_stack etc. Previously, their argument types
> > were marked as ARG_PTR_TO_MEM, which is compatible with read-only
> > mem types, such as PTR_TO_RDONLY_BUF. Therefore it's legitimate
> > to modify a read-only memory by passing it into one of such helper
> > functions.
>
> I've added ", but technically incorrect" to the above sentence.
> Otherwise it sounds like it was an ok thing to do.
> I've considered adding a set of Fixes tag, but there would be too many
> and it's a laborious task to look through all such helpers just
> to beautify the commit log. This patch set isn't going to
> be backported anyway due to complexity.
>
> Please add a test to make sure that bpf_d_path on rdonly buf
> is rejected.
>

Done. Just sent out a selftest patch for that.

> Thank you very much for doing this work.
> It's a great improvement to the verifier type handling.
>

No problem. I'm really glad to help there. :)

> There is a concern that generality of flags may cause
> a regression, but no amount of code review will reveal that.
> Please watch out for strange verifier issues.

Sure thing.
