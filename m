Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E38127B641
	for <lists+bpf@lfdr.de>; Mon, 28 Sep 2020 22:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgI1U1k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Sep 2020 16:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgI1U1j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Sep 2020 16:27:39 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3DBC061755
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 13:27:39 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id n13so3345166edo.10
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 13:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DF2/eLTFuB8N9fv1SG404jyibEGpFwRqzB5MphuCUCo=;
        b=FDm9xHh4uzjI+xv+2D4L4CbDtIDiH0fPLhQVCkijHgNOej1fL8YdRGnr0k9p4hEg/e
         RpD/EV6otStcbWvj7cifdYSnUu3UOnbPB/Bcwd2vlz0MIMabIkHEhkhcoel4PDea3gL/
         9kZN/okb8dmGGPZngJjIz+J84j7YSkJmPPD/nVF9ClE070EBbsBkMfJJSR6v3D1epUBl
         3z8CLmGY/RY44YWdA9ZyztooES6kyDRotWGdjK7ZQ6UwYK9jLTBaour30ZCeQLW/uYzc
         99spm7A/M2gqI5ROE4P9dmcO5z/3xm+m1W8YztsG5UAYTqu3W9Ld8w4UvqDeeyzxSHiU
         ygrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DF2/eLTFuB8N9fv1SG404jyibEGpFwRqzB5MphuCUCo=;
        b=i1E5zU+Gh43UbdUt0cjryKgLT3ZgGfNePg1TpVUL75BHmybLlWf745jD3OFj8I2Keh
         sKjjP/tNYdtKyFNI8pC25TZg+s0UJd+pOTyJE1DMWADIg+LoRVG5qAKZccLQx4DInwAV
         KkiDB4oUOtCR4bATPKZ5HOYV/RaYE4gCcVK90OLuqLc5ja+ZGYNEXB0lI1aXvv2mxEk4
         JaOdPuL75QqOwFtz9QMLffGay4w1EEnbp8NYNGLHfseaGZfbjZum3zD/GQ+ubwLdMUfY
         aFnjyekQ2jFgOUwGcNNt8BzDojMqOo/Lvnvs1Pk4y5e3bLUSi0F6QWNf6aGlHTTt7r3a
         Vmig==
X-Gm-Message-State: AOAM533XuCeykyQCEW7ucNGiYG1PR4LYtUweCsLRMtkXM/jb/nZNDdGG
        LaJZe/OPohymXK+lmcRdoILTsus0KuIUOnsmO0PCfw==
X-Google-Smtp-Source: ABdhPJye/8Mf9eEEdorCA613tHzKBM/brDodk4qDkUtGbl4/OXToAm0ni/zu9Tqrhk385KSgafVT37P6LIir30k313I=
X-Received: by 2002:a05:6402:64b:: with SMTP id u11mr3617070edx.147.1601324857889;
 Mon, 28 Sep 2020 13:27:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGftE8ipAacAnm9xMHFabXCL-XrCXGmOsX-Nsjvz9wnh3Zx-w@mail.gmail.com>
 <9e99c5301fbbb4f5f601b69816ee1dc9ab0df948.camel@linux.ibm.com>
 <CAEf4Bza9tZ-Jj0dj9Ne0fmxa95t=9XxxJR+Ce=6hDmw_d8uVFA@mail.gmail.com>
 <8cf42e2752e442bb54e988261d8bf3cd22ad00f2.camel@linux.ibm.com>
 <20200909142750.GC3788224@kernel.org> <CAPGftE8jNys9aVfUZW2iE5vB=QWKEmmwwWuWq9ek0ZXp-Aobkg@mail.gmail.com>
 <CAEf4BzYDm3QOOgND9p+LR21bn98QMjE+VYspQSvi4ebG9EdW0g@mail.gmail.com> <CAEf4Bzb7LZX8Y=qKpO5j3eUYU=tJzvNRYd1CdXXxq8Y-V4=+Vw@mail.gmail.com>
In-Reply-To: <CAEf4Bzb7LZX8Y=qKpO5j3eUYU=tJzvNRYd1CdXXxq8Y-V4=+Vw@mail.gmail.com>
From:   Luka Perkov <luka.perkov@sartura.hr>
Date:   Mon, 28 Sep 2020 22:27:27 +0200
Message-ID: <CAKQ-crg3qdQ6=STwQd5NrWWdQSpuKQptUMfZU50sYATfkqf1cw@mail.gmail.com>
Subject: Re: Problem with endianess of pahole BTF output for vmlinux
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Tony Ambardar <tony.ambardar@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org,
        David Marcinkovic <david.marcinkovic@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Jakov Petrina <jakov.petrina@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Andrii,

On Mon, Sep 28, 2020 at 10:19 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> Question to folks that are working with 32-bit and/or big-endian
> architectures. Do you guys have an VM image that you'd be able to
> share with me, such that I can use it with qemu to test patches like
> this. My normal setup is all 64-bit/little-endian, so testing changes
> like this (and a few more I'm planning to do to address mixed 32-bit
> on the host vs 64-bit in BPF cases) is a bit problematic. And it's
> hard to get superpumped about spending lots of time setting up a new
> Linux image (never goes easy or fast for me).
>
> So, if you do have something like this, please share. Thank you!

We thought this would be an issue and we have been working on this but
didn't finalize it yet.

We'll speed it up and send you an easy way to replicate the
development environment.

Luka and Juraj will also share some of our additional findings
regarding 32bit ARM.

Thanks,
Luka
