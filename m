Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E2332E008
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 04:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhCEDXk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Mar 2021 22:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhCEDXj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Mar 2021 22:23:39 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33142C061574
        for <bpf@vger.kernel.org>; Thu,  4 Mar 2021 19:23:39 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id u4so1259491lfs.0
        for <bpf@vger.kernel.org>; Thu, 04 Mar 2021 19:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oYWN8pmjARA1N2Q8EtDl3vFktiw9p7M+PIdprvPshOk=;
        b=PmMdO5jbYQfl7nYtktrauJBMWWn1ZFSdEZ+kEGu3+uzRZZkyLOG5ejZRuftUaOg4ov
         FcXp2yqhWf8nnAdk0Fa26VcXqr97B1zGoaZN3tA+CbDPzl5JsZbGI5dBXPWD40FlG6+f
         L2L9dcCRSV5xnW1FvKAZnYnjwmcC5ToKwTWLskRDLJ1sG8BkW687JCrij5sQhCz+Kf7N
         et+5/1V2QzWYnxQ7FjaygoPKmylU1XUa13mRCUGT19VDZjsGr2xBCZYknKYgoWKPl5JZ
         ro8E+iJplIwZWakg91cHgTTKAufr0b7QD804rZy07fGKgKYxT9YCDfORQhqKI+8pqXvV
         ITjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYWN8pmjARA1N2Q8EtDl3vFktiw9p7M+PIdprvPshOk=;
        b=Tj4+KTQ9N1jWRwbxaR92NiK4KrqWB6P9MLeiZp8WQKSCOoO2+Q5zGGkx8ejqguWkr3
         zXhPoBmgO6LgeeUGJeTLBBcnMj3zmd5IiImIAbnWAPkMeyzsbaM1F9yVqPG6gcZ/QERz
         KT7FpylGZypbGyzLPh9qlceNQxRArEqvPnL3EDghmJzu0Zvn1XoE/byNk/6NECg+q+zS
         tgAJgtJBVbiIm15GWl8pP6pdgDvnldMWUr/r+NLBeb9iBn+cO3jC6Asa2mMMZ/pXBavd
         dZHl883Y0Kez9pPDIJPxSnliQDy1aTxqHO7SWLdMIHkZUwsTz55QXlSKegRp23DyBof1
         GE4w==
X-Gm-Message-State: AOAM533QC40i7dvsK++OEBUfRn+74jtRtwzvbi6LZWJi0NTgkdGTWb6B
        meq6E18c1QngLTD3LWEdCm0X0/BxV48F/69vYPI=
X-Google-Smtp-Source: ABdhPJxFX1iI4RvKuKqCW/mGHvNGdzev7CXQPyHL2g0EhpghdfFTMcDhf3m0MrDCAae2Rj4sBAyxjo0YVbJqovfxWEU=
X-Received: by 2002:a05:6512:2254:: with SMTP id i20mr4239896lfu.534.1614914617650;
 Thu, 04 Mar 2021 19:23:37 -0800 (PST)
MIME-Version: 1.0
References: <20210304233002.149096-1-iii@linux.ibm.com>
In-Reply-To: <20210304233002.149096-1-iii@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 4 Mar 2021 19:23:26 -0800
Message-ID: <CAADnVQKierffrU3V0Yo65aTMb8g_TbwaXnJyvW9D=wK7=5msyQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] s390/bpf: Implement new atomic ops
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 4, 2021 at 3:30 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Implement BPF_AND, BPF_OR and BPF_XOR as the existing BPF_ADD. Since
> the corresponding machine instructions return the old value, BPF_FETCH
> happens by itself, the only additional thing that is required is
> zero-extension.
>
> There is no single instruction that implements BPF_XCHG on s390, so use
> a COMPARE AND SWAP loop.
>
> BPF_CMPXCHG, on the other hand, can be implemented by a single COMPARE
> AND SWAP. Zero-extension is automatically inserted by the verifier.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>
> Note: this patch depends on [1]; posting now to get some feedback.
>
> [1] https://lore.kernel.org/bpf/20210303110402.3965626-1-jackmanb@google.com/

lgtm.
This patch will sit in patchwork until bpf is merged with bpf-next.
