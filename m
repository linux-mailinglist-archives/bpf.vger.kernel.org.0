Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28BD63A9528
	for <lists+bpf@lfdr.de>; Wed, 16 Jun 2021 10:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhFPIkS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Jun 2021 04:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhFPIkS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Jun 2021 04:40:18 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899CDC061574
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 01:38:12 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bp38so3071932lfb.0
        for <bpf@vger.kernel.org>; Wed, 16 Jun 2021 01:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WFlnUn032A3seAXpAp6nFnShtPEpjQiw0z6fxXB+pZ4=;
        b=b3K52WbdGg5tekx45Z37HAb5PSXE3GMizKZxePqRmWm0jQzTsetoH1jlsEuuM/Hmne
         vpp3LynrMhhaqCRphXEPSN2y6GbjXQiQ7JEHrdxItM99A9JtSZiIXUCgYgjc2emwD6S/
         nWvjl0bMIpRx4bxtaq3d5eLD4QwAd4URfAoo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFlnUn032A3seAXpAp6nFnShtPEpjQiw0z6fxXB+pZ4=;
        b=tuCAKzD2+0kXGuZlqKJaaadnIXZURlX3WDYsWgp1Cxb605y7Wyvn1U23PPdd75Hlhe
         3CmPqo10QW51h81tBS0/vmV7HWD/GU4ZbOUPGHXOqE7r89wYJEkQ5H55GyhksALjIJmC
         gwmthuTI645ufwPlmLzmYH5SMzRxuL5FqJL/0jfwCrufEGouHpnOjf7unQr4J3UwBtwT
         Twoi1Svp21Hfq+1rFkpstn/5m5/jvfuwuBswlsk9swIIKEfy7ee1jMdYkytVoVrXguFQ
         BtPsbOq+nepShVnxX7pDVSCO9CqNmfARjYhaAyW4Y2LHVuWuTEuDbV6q3c5i3/dVNdgO
         hTqQ==
X-Gm-Message-State: AOAM532B5uj4Dwz6NQQSLWDxofqMrbtC0xHPuIEkx0DfedNuxSPyhMEL
        B2e4i8Nf88OxtkKE3CFDYxBfJdLEtxQpojAEgVtKIg==
X-Google-Smtp-Source: ABdhPJwRxd6lm+ds5Zj/j54RacqU0f8ihD+i9c3wZFFsgxdb7Zb9po6mq0its+tBeiWwpvvkHDMZgMTUJCJwUZtP3w0=
X-Received: by 2002:a05:6512:32a5:: with SMTP id q5mr2748291lfe.171.1623832690875;
 Wed, 16 Jun 2021 01:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210610161027.255372-1-lmb@cloudflare.com> <CAEf4BzZDDuyybofAjxm8QG9VYFMGAF8gZ9g-rnoD1-8R_9LExw@mail.gmail.com>
 <CACAyw9-UbOD_H5=KfscPHzwOHL13nTUpojhtQnOTNJpTS-DVzQ@mail.gmail.com>
 <CAEf4BzbFhGkRi0YSa0pB+2SFYtJKXLEVKx=hQpVbBO_D4KUjtQ@mail.gmail.com>
 <CACAyw9-0qDakujnUBT3uZcgnBZr0dZ8o=GbLx_OEiF1xXvRdzQ@mail.gmail.com> <CAEf4Bzb8piZg29fTpfSqUPEE69hHEqdnFbYHN-bp3qEossLkww@mail.gmail.com>
In-Reply-To: <CAEf4Bzb8piZg29fTpfSqUPEE69hHEqdnFbYHN-bp3qEossLkww@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 16 Jun 2021 09:37:59 +0100
Message-ID: <CACAyw997Rnnz6xGVu3faHbYMA6Xis_=h6F96i9G+uQY00M2jgQ@mail.gmail.com>
Subject: Re: [PATCH bpf] lib: bpf: tracing: fail compilation if target arch is missing
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 15 Jun 2021 at 19:53, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> >
> > > >
> > > > Without it we sometimes get an integer cast warning, something about
> > > > an int to void* cast I think?
> > >
> > > hmm.. ok
> >
> > This is the error I get:
> >
> > progs/lsm.c:166:14: warning: cast to 'void *' from smaller integer
> > type 'int' [-Wint-to-void-pointer-cast]
> >         void *ptr = (void *)PT_REGS_PARM1(regs);
> >                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> oh, ok, but then those zeros probably best to mark as longs, not long
> longs (even thought for BPF it's the same), as (unsigned) long is a
> logical equivalent of a pointer, right?

Ack, that seems to work as well. I sent a v2, also renamed
__bpf_target_missing to __BPF_TARGET_MISSING.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
