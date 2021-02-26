Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335D83267B1
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 21:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhBZUF1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 15:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhBZUFY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Feb 2021 15:05:24 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5406DC061574
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 12:04:43 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id a17so15158799lfb.1
        for <bpf@vger.kernel.org>; Fri, 26 Feb 2021 12:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UndmRchlSFBmynfeaJ1NFZ8egZYXo7M13mJTXaW/8kc=;
        b=Epz8C7VwuOiSzNJK7a90x1M41lEwstfdqyRJ1yy4MiNiwzbQAmO0pzqNefkCKrkLt1
         4Op63FK9CkBzHRF2StRhdAyX3OshF5dL+1fuzDq4tMYF/m8X7L4xojYSCSvU6zjHmzRJ
         31cnKAdVB2LAsnfwC3UBzn20tYyrxfdB+hElP1ptC+C5hwiq3ZWyw5a3ZjllwEU3hY3m
         hR/3QBy5JnyiYNOBNedOescqTqRpfxp6mtp69fLS/yjErv30Krine25MICTcvXdYcfOh
         hscftzXcGuXX7pM/bCec2bADOcMi/mIXLF0vcus2OKy7yn4YKKuud3sTV1/AkrmmHTDT
         02uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UndmRchlSFBmynfeaJ1NFZ8egZYXo7M13mJTXaW/8kc=;
        b=MoLcStzSOjE0YsxIiZXM2gHxsGGacidYk2YNI1KirvVNX4JlDFnq0VwHKjR4jtv1Ed
         IGaieZKs9SrWcJ/G45zkUUKR+F5MumhmgyPQxhNqdYumxSofrIOt9AJNnxvnu6i+YAhj
         Yv2pXA91vhXAHIyRyUPkUbG13REzTM8ZnfWS2qH4NhKpCoQpCBjIXp0y480pXuagzy2R
         8PgSVdIXNSPx5bLz/V1ohu8u8eVu5A4haQqM1NOANYfBDCoucJIzzq1+swzIDZv9BUjx
         R9FYZAImNjyWPZc+7kEkbWKB5jUNGWc9j8pj+6ZnwTQpHLKddVy6qIUZQzIo7ViVUosr
         oAyw==
X-Gm-Message-State: AOAM533qS5bt4YWxvnCzWaaXu/ZrFr66F3NaA4nTpASSJSPGS5kxYw2l
        5wbTf0qR2cN+phsEgj6FrnjTlXRdfn8xy/fN98l5EOg1
X-Google-Smtp-Source: ABdhPJzByXMN39EsMhGWu6Bd09wxiGYPMlY3/E8sk6C14621uNm2JsbQKXVMhbm+vc8S0Cnh/Gce5w3Vr5vGezB4zv4=
X-Received: by 2002:ac2:5ec2:: with SMTP id d2mr2762613lfq.214.1614369881876;
 Fri, 26 Feb 2021 12:04:41 -0800 (PST)
MIME-Version: 1.0
References: <20210225202629.585485-1-me@ubique.spb.ru> <20210225215506.xktvt6kf3mpwyiii@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210225215506.xktvt6kf3mpwyiii@kafai-mbp.dhcp.thefacebook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 26 Feb 2021 12:04:30 -0800
Message-ID: <CAADnVQKS-qhJ+G=0SKmTe6=ZfJaeuucQvp7FEJ_EtvoEOgFHzA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: use MAX_BPF_FUNC_REG_ARGS macro
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Dmitrii Banshchikov <me@ubique.spb.ru>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Andrey Ignatov <rdna@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 25, 2021 at 1:55 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Fri, Feb 26, 2021 at 12:26:29AM +0400, Dmitrii Banshchikov wrote:
> > Instead of using integer literal here and there use macro name for
> > better context.
> Acked-by: Martin KaFai Lau <kafai@fb.com>

Applied. Thanks
