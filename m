Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E19D149BAA2
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 18:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbiAYRxN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 12:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346936AbiAYRw4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jan 2022 12:52:56 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DED6C06173B
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 09:52:55 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id p15so32229257ejc.7
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 09:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=aekE5iZiOgiVAIj2A6gPXaIV4IFk4R2gLmjZTD+2API=;
        b=mdeKP/epeQbj7XdV3pM5LAyG4MAwyPRyQr9fP/6V0o50Ya4OdSHkm/W+hYeLf+6cWR
         wBleL1cpA8s6Jc2lEVhMAc0GTNgdPsXdPoHdNicwuRrACr2r3KcqOzxluHZuq9Rh5l1o
         CSuopAEhhlm+pang0YW7yTSXB5koReIDyDdbiWETSHIWjfUuFp46A5vvzWn9mwkXTWra
         0MjoLh82kUdajxy2w8s4XfsJXGYFMg8Ib+/sdl8WH8y79fjBl7iQaVPLozynxiipLwgo
         Bzqlv8BrOeJYtUkXBeuMILIYWvvkiM3xumGxhIufDGT94WDpYE6xbqUcZdgldZLE+Cy0
         8lVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=aekE5iZiOgiVAIj2A6gPXaIV4IFk4R2gLmjZTD+2API=;
        b=Sd6HZ4qvjJFeSftahQO7/f0SYR/5tc1JDP/yj61uXV6w1xwbSQzHNTdKwKeocgA41P
         36ZYS4OsJoGHMXiQouSxQyA82J0T4AssZiGgz4w/P+sM3lss3NLdLZTD1KzoVqQpWkDX
         UxNP9V11inbWpSCDr2CVwzKBTIDG1wk+6JZWyhwqrflHCHJRphw3w8JFXG2F9eiauUeq
         5W2uZV+3F5hCfis8xJ7viWGIFKihU9XA7jmXYNMcDABK5dKzfehhcYV5NKgYfBM6EyNT
         ChmvAc2UvW5tjB4E1ghSbAeFg4DcPyEgODon7oqOTrzLE32r1o7L9MsmULVksyklkRg/
         c1TQ==
X-Gm-Message-State: AOAM531d/oRVIWYgqfo7w3vDdrvAJN7GFBho3rIOtgzwOAW/yBGAD/dC
        PjrVq/KnOJujVwMv3p0pPqTJc5aDIv3noaQFfjSy8B3PQnlsiQ==
X-Google-Smtp-Source: ABdhPJwabbgoJUafvU71lLKbaUlivza6bkDT/Dq6ydjGfHoqyj15+JVlfc4S0PezUw6+tOeQ44UVkfyWG4BiYp3PyMY=
X-Received: by 2002:a17:907:3fa3:: with SMTP id hr35mr12201000ejc.677.1643133173893;
 Tue, 25 Jan 2022 09:52:53 -0800 (PST)
MIME-Version: 1.0
References: <CAK3+h2wcDceeGyFVDU3n7kPm=zgp7r1q4WK0=abxBsj9pyFN-g@mail.gmail.com>
In-Reply-To: <CAK3+h2wcDceeGyFVDU3n7kPm=zgp7r1q4WK0=abxBsj9pyFN-g@mail.gmail.com>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Tue, 25 Jan 2022 09:52:42 -0800
Message-ID: <CAK3+h2ybqBVKoaL-2p8eu==4LxPY2kfLyMsyOuWEVbRf+S-GbA@mail.gmail.com>
Subject: Re: can't get BTF: type .rodata.cst32: not found
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

this is macro I suspected in my implementation that could cause issue with BTF

#define ENABLE_VTEP 1
#define VTEP_ENDPOINT (__u32[]){0xec48a90a, 0xee48a90a, 0x1f48a90a,
0x2048a90a, }
#define VTEP_MAC (__u64[]){0x562e984c3682, 0x582e984c3682,
0x5eaaed93fdf2, 0x5faaed93fdf2, }
#define VTEP_NUMS 4

On Tue, Jan 25, 2022 at 9:38 AM Vincent Li <vincent.mc.li@gmail.com> wrote:
>
> Hi
>
> While developing Cilium VTEP integration feature
> https://github.com/cilium/cilium/pull/17370, I found a strange issue
> that seems related to BTF and probably caused by my specific
> implementation, the issue is described in
> https://github.com/cilium/cilium/issues/18616, I don't know much about
> BTF and not sure if my implementation is seriously flawed or just some
> implementation bug or maybe not compatible with BTF. Strangely, the
> issue appears related to number of VTEPs I use, no problem with 1 or 2
> VTEP, 3, 4 VTEPs will have problem with BTF, any guidance from BTF
> experts  are appreciated :-).
>
> Thanks
>
> Vincent
