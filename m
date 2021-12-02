Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA53F466AC1
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 21:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344719AbhLBUMa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Dec 2021 15:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242416AbhLBUMa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Dec 2021 15:12:30 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658C1C06174A;
        Thu,  2 Dec 2021 12:09:07 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id v64so2827154ybi.5;
        Thu, 02 Dec 2021 12:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CoVbhq6s5tCP8FAuR3nfitUe1jUjFsGTnmv4eKJnELo=;
        b=Kb/IwSerDzjZbTnkxe499mxNj9bWyt3wnHCLUhwEHJiYmHfKkrTeoyrS0WZKjXHz6f
         zwPgVmXEgTuXXzqd/iR07DRuIdLFilFEGS+886fv6Zi6IvtBMaILSwG/3QUVhUwHD70q
         9Up9H4jdDsxZiutufdfuummLiMfx5Fu0RiGlr3UWpC6PJ+NU0UbM2b2OdSpr5A49dRrU
         dl4cWRtON96Er/11WMYCGC5Qteun6VgYpcRzPLRyswH61j55q/LO3jH5uVoGzaPHB0jw
         ABeGvAOj5Nqq8ks6UJfyDp49nn8b6daFRsHfFLKjYXXrR1z2dhZimF5WwoE5boGpLbWV
         +yew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CoVbhq6s5tCP8FAuR3nfitUe1jUjFsGTnmv4eKJnELo=;
        b=ovG3miZVIKcEbHevGDBnFsmnMOOFjsGa07ae6pjTLACUls/zPim+piVcZefH+taD4g
         H4w7yZuGx6sQXIoqUee+lM+0XXzbKfHJ/chkEs8C61wSPTTyNl2QzYcuPGPMCMH9E0a3
         /jsFmku72khIY3IvsXgYKlpH0puatAulCDzZ2YWescLp5hAFsLU14UNoSNbODwiCmdvV
         yzU2b5AmSfUJitU1ZcdwKAFTPX4AbmUTjovWqO/XWqVNSey2AdvwbyNKYXnUxaw2+KSB
         APhf1/t04GybUxxoJRgrphttlPjL9ICo14zhWzsEvps+pUmC/JnsAmFgmxcdTbWHZdcM
         1EOA==
X-Gm-Message-State: AOAM530BBLkgFX4IB4AZa3hvUND+Y5j0LoFc2wi8S+NqXhCq9ILc325q
        schvPSV/0V/+xtT36Z0Qep/8Yb+b3/Pxeh46+N8=
X-Google-Smtp-Source: ABdhPJxwUsgpO1tyhqmnR0hgupBuctu6p4tQ304M0T+bAp0TxDtibZ0B/l0ABOXM88YWS9hE6u++JvAkD04rWuc+ERw=
X-Received: by 2002:a25:54e:: with SMTP id 75mr16942774ybf.393.1638475746518;
 Thu, 02 Dec 2021 12:09:06 -0800 (PST)
MIME-Version: 1.0
References: <fb36291f5998c98faa1bd02ce282d940813c8efd.1637684071.git.dave@dtucker.co.uk>
 <9b20a6e558008b8d422db1008dd2b5c8ff18ce46.1637684071.git.dave@dtucker.co.uk>
In-Reply-To: <9b20a6e558008b8d422db1008dd2b5c8ff18ce46.1637684071.git.dave@dtucker.co.uk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 2 Dec 2021 12:08:55 -0800
Message-ID: <CAEf4BzYYMwGZ10NuZZCYVb=e8bpf3vkLYn_g0B7Roi5cPJRrCw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] bpf, docs: document BPF_MAP_TYPE_ARRAY
To:     Dave Tucker <dave@dtucker.co.uk>
Cc:     bpf <bpf@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 23, 2021 at 8:24 AM Dave Tucker <dave@dtucker.co.uk> wrote:
>
> This commit adds documentation for the BPF_MAP_TYPE_ARRAY including
> kernel version introduced, usage and examples.
> It also documents BPF_MAP_TYPE_PERCPU_ARRAY since this is similar.
>
> Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
> ---

It looks good, thanks for the update. But it seems like all the
Documentation/bpf/*.rst are 80-char wrapped, can you please wrap the
lines to fit within 80 characters for consistency? It also helps
immensely when reading source text files and not the HTML-rendered
version.

>  Documentation/bpf/map_array.rst | 172 ++++++++++++++++++++++++++++++++
>  1 file changed, 172 insertions(+)
>  create mode 100644 Documentation/bpf/map_array.rst
>

[...]
