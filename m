Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0CC596E5
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2019 11:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfF1JGH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jun 2019 05:06:07 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34856 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfF1JGH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jun 2019 05:06:07 -0400
Received: by mail-ot1-f67.google.com with SMTP id j19so5300763otq.2
        for <bpf@vger.kernel.org>; Fri, 28 Jun 2019 02:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WeO5JTNTbN5Pes6w6eEphdcv7Qn+nFED7FaaFx6h1y0=;
        b=Mwvl80FlXqJrzBLIksBsYc4hmQWvfdbeVOrWxZ9EiE4YINaFI9SRlFzEe/ADVBhK1T
         ZOVxMGV5IPdP04SzIbZjp2e/YJZctbEN6dY+GNO5taUh3Gk/dR2fDLCNLbjhrPI//oAB
         rtP8neVQWw+zpfkeDrqxuRTA0pd2/jfnXsZFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WeO5JTNTbN5Pes6w6eEphdcv7Qn+nFED7FaaFx6h1y0=;
        b=LkHxkoEmQbyXBMwfYS3p9obvmb5H5WyOb0zCGA3Fk7XCrv8dIefaw4rrTKpbV7Y3kT
         hn7EaFVbydPJu186N8Ws0eEg/v5kor9S6nqHdmGdvcmG2FLswhHBNWqOMRSsI8vYJHnM
         tGL5BbGPbTgnPdTGMOlSVAen8qLy2zhYv4uRxl+NZ32QMo4TjdKFUmplwTXtr/tJuk60
         yoVisVtqzcs6sSOR7XUZQetfYUuSPgzsDIOaj3HD8Ib0CyoLrh2Hd65Ck1LyynYE6Ggi
         dRfRjnIBfzSaYP3xXlMj5M//5thOOAoqrf7U+cvjC1tiydHhb1uUYI65hG17bgZUvqfN
         bbNw==
X-Gm-Message-State: APjAAAU5prQ2RVNpgbqEwUaaVHEUOBGLA7MJpMPOSmTscI24FuaoytFY
        ObElHg2SwjVD3xUEVRHBeH5NPtG5OR6thtIGMj/HIA==
X-Google-Smtp-Source: APXvYqxS90VALAc1Mw4oeranbJW1WyAt33C8rQTBwVGMPDPAAt5uAUvioxxYy0/1pP2GXzfVZFDMHcSQbHewAlDBixw=
X-Received: by 2002:a9d:28:: with SMTP id 37mr6901286ota.289.1561712767032;
 Fri, 28 Jun 2019 02:06:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190627201923.2589391-1-songliubraving@fb.com>
 <20190627201923.2589391-2-songliubraving@fb.com> <21894f45-70d8-dfca-8c02-044f776c5e05@kernel.org>
In-Reply-To: <21894f45-70d8-dfca-8c02-044f776c5e05@kernel.org>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Fri, 28 Jun 2019 10:05:56 +0100
Message-ID: <CACAyw9-AXy9UFdGkDaaNxw9T8meB+NAH5Yp_0G3nuw1AN5impQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: unprivileged BPF access via /dev/bpf
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Song Liu <songliubraving@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Jann Horn <jannh@google.com>,
        gregkh@linuxfoundation.org, linux-abi@vger.kernel.org,
        kees@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 28 Jun 2019 at 00:40, Andy Lutomirski <luto@kernel.org> wrote:
>
> I have a bigger issue with this patch, though: it's a really awkward way
> to pretend to have capabilities.  For bpf, it seems like you could make
> this be a *real* capability without too much pain since there's only one
> syscall there.  Just find a way to pass an fd to /dev/bpf into the
> syscall.  If this means you need a new bpf_with_cap() syscall that takes
> an extra argument, so be it.  The old bpf() syscall can just translate
> to bpf_with_cap(..., -1).

I agree, this seems nicer from my POV, since it evades the issues with
the Go runtime I pointed out in the other message.

It also seems like this wouldn't have to create API churn in libbpf? We can
"feature detect" the presence of the new syscall and use that instead. If
you want you can even keep the semantics of having a "global" credential.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
