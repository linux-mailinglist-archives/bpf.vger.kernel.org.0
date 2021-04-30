Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC9D36FC5C
	for <lists+bpf@lfdr.de>; Fri, 30 Apr 2021 16:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhD3O2U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Apr 2021 10:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbhD3O2Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Apr 2021 10:28:16 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F82CC06174A
        for <bpf@vger.kernel.org>; Fri, 30 Apr 2021 07:27:26 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id b4so3522099vst.13
        for <bpf@vger.kernel.org>; Fri, 30 Apr 2021 07:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p35HMelGMsZIEYttmbIOcneApR/xbqhfMO29nZlCehE=;
        b=XwMVU4JxTySE96o4dREpbxLPGl1hhfO197TAgkRhEKkJsZ10toPCy2ZYHhkHU+LuAQ
         m8FEFLyd2x3p6jDvvOx7PU4JFpxR+TVbWhaqtvw3EHPr3jW5ER0Q/ApeZpnzEXWlpr0X
         Kxau1JmcGRF891gbGZ5FjDZ0k8qyLITE/sFegQ84BW2+rDjggG+LE6QjLNbWADyETFQs
         u4svkxvFA/L6xOvgQCE3mc4DxUtiGo9xDvKQlYbQnQNoRKQ3kKlvKkVEKrWcAstwtiSy
         DcWQ5ANDDLQHGvBrpen65iFbxQeicla3Nl/XV3weIAGV6pl0Y3SUgmX7UnBXEBIjq3dO
         C3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p35HMelGMsZIEYttmbIOcneApR/xbqhfMO29nZlCehE=;
        b=k1RyBK0DWfFDhS0EEmCi2PSuJQOCk8lY++HqtHG6S+Xj1ncnfctdTZ176TE3b3nyR5
         2RNoWZOp3SbP4quRsBb8sfu0rUbK+8tWLvKgGmfJdlqErRwgAk+T2csbdxEmA3lmO4Jo
         qFfKojS8WndqlFH0KVvrbXLcCSuVTF3/xVYpvOF9dB10XY67EEqmj+rsenyLBISiz3Gz
         nuopcpq1GNPA4vOfyySVVfCGNXLqXZMFUm7Q13ZAu9S2e7CvjoCDlDtjx4lhJFziMP5j
         svt7LPEP3s0iwILI5+sjS2MrUaLDrmhedQYJaWJx1AOoG+9uuc87MK5irnpfASk37JnP
         NTVQ==
X-Gm-Message-State: AOAM53253WOTL1T91b+TA9jnl6DQPHvbUicDmZvCdGUKXb7YJRqQC/Dt
        +u+xu5DaYL/3TlthzkQ1DLNaD2NjdnuCMlYeh0wUJaUVhJo2EnFz
X-Google-Smtp-Source: ABdhPJy7GOt7MlpvSBvD+oPyClfJysR0Ef95BtTWe8UdkxC7QBDFFMB08NAM/b2BHMhJQkfl535L4VEj9HjcgkEAyhA=
X-Received: by 2002:a05:6102:38d:: with SMTP id m13mr6425876vsq.25.1619792845783;
 Fri, 30 Apr 2021 07:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210429054734.53264-1-grantseltzer@gmail.com>
 <877dkkd7gp.fsf@meer.lwn.net> <CAO658oV2vJ0O=D3HWXyCUztsHD5GzDY_5p3jaAicEqqj+2-i+Q@mail.gmail.com>
 <87tunnc0oj.fsf@meer.lwn.net>
In-Reply-To: <87tunnc0oj.fsf@meer.lwn.net>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Fri, 30 Apr 2021 10:27:14 -0400
Message-ID: <CAO658oUMkxR7VO1i3wCYHp7hMC3exP3ccHqeA-2BGnL4bPwfPA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Autogenerating API documentation
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 30, 2021 at 10:22 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Grant Seltzer Richman <grantseltzer@gmail.com> writes:
>
> > Hm, yes I do agree that it'd be nice to use existing tooling but I
> > just have a couple concerns for this but please point me in the right
> > direction because i'm sure i'm missing something. I was told to ask on
> > the linux-doc mailing list because you'd have valuable input anway.
> > This is based on reading
> > https://www.kernel.org/doc/html/v4.9/kernel-documentation.html#including-kernel-doc-comments
> >
> > 1. We'd want the ability to pull documentation from the code itself to
> > make it so documentation never falls out of date with code. Based on
> > the docs on kernel.org/doc it seems that we'd have to be explicit with
> > specifying which functions/types are included in an .rst file and
> > submit a patch to update the documentation everytime the libbpf api
> > changes. Perhaps if this isn't a thing already I can figure out how to
> > contribute it.
>
> No, you can tell it to pull out docs for all of the functions in a given
> file.  You only need to name things if you want to narrow things down.

Alright, I will figure out how to do this and adjust the patch
accordingly. My biggest overall goal is making it as easy as possible
to contribute documentation. I think even adding just one doc string
above an API function is a great opportunity for new contributors to
familiarize themselves with the mailing list/patch process.

>
> > 2. Would it be possible (or necessary) to separate libbpf
> > documentation from the kernel readthedocs page since libbpf isn't part
> > of the kernel?
>
> It could certainly be built as a separate "book", as are many of the
> kernel books now.  I could see it as something that gets pulled into the
> user-space API book, but there could also perhaps be an argument made
> for creating a new "libraries" book instead.

Yea if I can figure this out for the libbpf API it'd be great to
replicate it for any API!

>
> Thanks,
>
> jon
