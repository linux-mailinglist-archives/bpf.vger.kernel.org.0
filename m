Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93041D1F9F
	for <lists+bpf@lfdr.de>; Wed, 13 May 2020 21:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390785AbgEMTtR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 May 2020 15:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390783AbgEMTtQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 13 May 2020 15:49:16 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3593CC061A0C
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 12:49:15 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id d21so909366ljg.9
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 12:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YO5CZycJoj3SG3fGwN+WTopK/LhbyP0lsfj2E+DRkX4=;
        b=PhubPRzpkCdl9mVPHrG9Oo8C+WwrKBHaeYw/BPL1ZhM7m32uY9vOkxzag4IPR45vmN
         nCyuee+AoItBB8/CS6j7/cO2lxt0a4Fuet7ze1acDgZYlgBMc3l9Izqr8rAmG81U3hf8
         E+jYDPSfclqu+31+e+LKbjbSmiBTvos3Qrvk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YO5CZycJoj3SG3fGwN+WTopK/LhbyP0lsfj2E+DRkX4=;
        b=BZKgL7WrNFypScsWdl8amxLTALE4RPl+ZSxeYWwhnZsx0OCAO/rI/sUcyiDmV/rHYQ
         s3zcFG9VwosgLeUQRsH27MqJ4tHG2lLQ1CdXmnIP/zMUSuOSiffwomipyHdDvJTTGfpi
         vQkngrQrMyiLtNiZj9ypYATZV3IUKCbu+6GPorRXJiyhCzN4njuLBYDOvtfIhghFXate
         xBftNW5B5kDdbPOruSw/ic8R2sVWgfQBLYmw0NNk9rkZHEnjvRxXOQuE9Id4SQRHQZsz
         MIQeGwJ5Urbb++brXVvyFDVPmk8RVJW39RciiMQLLc2xH8BccICFisjCJt9+lCR9w6sx
         3KnA==
X-Gm-Message-State: AOAM532+SY8rW/TxfTQm+H2gyvMxM4DKZiyCgTqT4spvPsyArDsbHXGv
        PJONLhyIluQlLvk8Lk4kgTAzZkS8hes=
X-Google-Smtp-Source: ABdhPJzjgBegKfaWK5RVAuq+imXf+uiT0Wpn8qgbiFJJ4i5Z6Ym3ryLP8DpruC2Y/6fgW4GLkajnIg==
X-Received: by 2002:a2e:2a82:: with SMTP id q124mr431252ljq.155.1589399352507;
        Wed, 13 May 2020 12:49:12 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id h11sm334159lfp.22.2020.05.13.12.49.10
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 12:49:11 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id r17so541283lff.9
        for <bpf@vger.kernel.org>; Wed, 13 May 2020 12:49:10 -0700 (PDT)
X-Received: by 2002:ac2:58c8:: with SMTP id u8mr739476lfo.142.1589399350490;
 Wed, 13 May 2020 12:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200513160038.2482415-1-hch@lst.de> <20200513160038.2482415-15-hch@lst.de>
 <CAHk-=wgzXqgYQQt2NCdZTtxLmV1FV1nbZ_gKw0O_mRkXZj57zg@mail.gmail.com> <20200513194003.GA31028@lst.de>
In-Reply-To: <20200513194003.GA31028@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 12:48:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whtGLxezkdMP6+859LFDgb++6dgYa6Vrc=zJ9+GB7UMFQ@mail.gmail.com>
Message-ID: <CAHk-=whtGLxezkdMP6+859LFDgb++6dgYa6Vrc=zJ9+GB7UMFQ@mail.gmail.com>
Subject: Re: [PATCH 14/18] maccess: allow architectures to provide kernel
 probing directly
To:     Christoph Hellwig <hch@lst.de>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-parisc@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, May 13, 2020 at 12:40 PM Christoph Hellwig <hch@lst.de> wrote:
>
> We do export something like it, currently it is called
> probe_kernel_address, and the last patch renames it to
> get_kernel_nofault.  However it is implemented as a wrapper
> around probe_kernel_address / copy_from_kernel_nofault and thus
> not quite as efficient and without the magic goto semantics.

Looking at the current users of "probe_kernel_read()", it looks like
it's almost mostly things that just want a single byte or word.

It's not 100% that: we definitely do several things that want the
"copy" semantics vs the "get" semantics: on the x86 side we have
CALL_INSN_SIZE and MAX_INSN_SIZE, and the ldttss_desc.

But the bulk of them do seem to be a single value.

I don't know if performance really matters here, but to me the whole
"most users seem to want to read a single value" is what makes me
think that maybe that should be the primary model, rather than have
the copy model be the primary one and then we implement the single
value case (badly) with a copy.

It probably doesn't matter that much. I certainly wouldn't hold this
series up over it - it can be a future thing.

         Linus
