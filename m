Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9268F4235D2
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 04:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbhJFCaM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Oct 2021 22:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhJFCaM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Oct 2021 22:30:12 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A74C061749
        for <bpf@vger.kernel.org>; Tue,  5 Oct 2021 19:28:21 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so1185419pjb.0
        for <bpf@vger.kernel.org>; Tue, 05 Oct 2021 19:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XyplLc5CMj8W2rzH3RrNXTbzIemIRz7JbH8pHpdtc6c=;
        b=AU7JI7C/Wr3K6pKrL2BJSjwamssFxEUy2d5486zKjBuTBtSwW8hUpAdAlXLzxpQsDj
         wdHU5LDaBXiNpRMD17+c9Me+ttUi8grDiEBPmfSoVareRapPAQHB7BFRGMbPAIHSg17X
         7eHaRcDJ7rwa39Hkc1nLqko1Q4rYxZFIHHnbBucLeA6kq/Ae5UefdNSqCFprJGjtH9KX
         plupG/wA6EiJZmByPVga1C9F3iqtW9++FvXcaQy8MmGeNgy9kBhQSRT+/jE5kQezfDzG
         D3ReE+wUkeyjCv97sJkU3rvo1lASIN6LQ6xLoblwCTGs6ldo7z9x9Eb+gyTN9KnSiM7r
         BL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XyplLc5CMj8W2rzH3RrNXTbzIemIRz7JbH8pHpdtc6c=;
        b=g4IExFNVSms6JA+aTyBuLyfW/humL5xYclJWrPU3BfS5gxt72E1/Gwo+DA/VMkTPjB
         3jVRmvGcZAGSPqp06AbP3MRsjvGoH+XISjlfgagtZlZcrYMeWPdTlW4+rRIVKzC6l5GB
         hWoHIld4zZ1f6250nRX9saPAnccMSHDW7nO8qTr9D9Np0wX1EaAlEriG+ZTCK3YdsD60
         TuUJNmKrxuyeHrrKVURr3NWjAxiIJJTWJmmLns6evwoWsBr5q7S83DGevFmUT2RMhMgH
         2OmdiFZ7y3wiohgPG27FiR4S3wYdobXyruaL3QOHVdKgdUGVjJTH0ooOCwyGTAJYDOYE
         AHhA==
X-Gm-Message-State: AOAM531RFDFcUxJ0hag9xrhhrwrum3Cm9Xa7zUtcLSfbk0Xm3yZotaTh
        kzo0b8Fp9+Bksu2PbMieR1YptWQFz4YmChCLRD/mUTDs
X-Google-Smtp-Source: ABdhPJwGo9VWfpjOQc4uvTsWGj0BkH98w4KghIPf7T6eZLR2f/Xf0Enka+MWkWfAfn91Qk/Lsctw9jS9xZU65MPubaQ=
X-Received: by 2002:a17:902:7246:b0:138:a6ed:66cc with SMTP id
 c6-20020a170902724600b00138a6ed66ccmr8540898pll.22.1633487300542; Tue, 05 Oct
 2021 19:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211006001838.75607-1-rdna@fb.com>
In-Reply-To: <20211006001838.75607-1-rdna@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 5 Oct 2021 19:28:09 -0700
Message-ID: <CAADnVQ+oP-6aUze0h2CQOmnprcZxxmuQkbSf=JaNq5xMZribKw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: avoid retpoline for bpf_for_each_map_elem
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 5, 2021 at 5:19 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> Before:
>
>   IngressMatchByRemoteEndpoint                                80.78ns 12.38M
>   IngressMatchByRemoteIP                                      80.66ns 12.40M
>   IngressMatchByRemotePort                                    80.87ns 12.37M
>
> After:
>
>   IngressMatchByRemoteEndpoint                                73.49ns 13.61M
>   IngressMatchByRemoteIP                                      71.48ns 13.99M
>   IngressMatchByRemotePort                                    70.39ns 14.21M

Nice gains :)
Applied.
