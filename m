Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EDA4F1FE1
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 01:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbiDDXKG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 19:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242761AbiDDXJ5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 19:09:57 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877C1DF48;
        Mon,  4 Apr 2022 15:45:43 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id m18so9353056plx.3;
        Mon, 04 Apr 2022 15:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9XkilyyUYNIu4Q3RHDNyf31taWeKWC5BkvBL21mWPSU=;
        b=eSZSA29OSTSEp0kOl2zS4g6nxJQr1PmTHuIJuKFN0sFB3K3wZHIznyN+FdNPLcOxkS
         A0Zr2FjxOGOUIOx9eX91ldEQ0Xd5EoghPmsoqtF80tfVPBTL4roiZKFWffzrk28CpynL
         OfXuBzS73RLhxuu4gb2w+U+HC1TruFekGweBautH0MOYw99qC20jRZ+Z0OZXPYmc57pY
         NZ31uZpw4xk3IYZgJ+VINlpf/f2hy+FbSzPZMJ8pf+moIsN32xOzam3c8xK4y6vH3Ltg
         CxGWwV/NO2MJn1aCC73shwF7jRpDbinNmPBUtMbQNNja7hlKz9d9n+qdrOhz4M+YrKyJ
         MfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9XkilyyUYNIu4Q3RHDNyf31taWeKWC5BkvBL21mWPSU=;
        b=BQOP9x9vg0DNVouHYVgFjVWNrVrXIDVWr5/YCGh5HWDPE+q8SjsFRQQKCGITDFAiiX
         ptOqnrodtUzCwhiefgt5kgm2FIJIUEhsX1RJcBBegvqsjbeAi/VW8EZmPvdnu7RmVqVe
         CQdLkVDJz95abFJClPQp5Snz7PZWPlpIMGQ1pIcE10HZ31GlDEPjxjDMoVKU6Dy7ZHc5
         10/i+FVUZ+zsFr2UBBfy8IsoImaBPNhHCByqHTlDONgggnS863RaDW6FOq3pKLN4uwbz
         mcQXEGrATTnu8oSP3jCv8s2v73hVPY9hC8MADlBCp3FoS0DLEp8CuCtgZxGWe6c7If6b
         6Edg==
X-Gm-Message-State: AOAM533bZehBUEvg9Dvj2wC9kbHL4kGd2ZUiK1rd+6R2QicxJ+65LHIQ
        Telnoo13wJPE1nNFjxs+fHBbFISp50nOba9uwmU=
X-Google-Smtp-Source: ABdhPJxiCKFfkcGMtFQZjMAwER612fac8KxMOafNFnyc2DT2VWuVuz1b/99RZz1O5gO1awPLAGGbTnsEAJTMcBdy4BE=
X-Received: by 2002:a17:902:ba83:b0:154:727e:5fc5 with SMTP id
 k3-20020a170902ba8300b00154727e5fc5mr463137pls.55.1649112342937; Mon, 04 Apr
 2022 15:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220404220314.112912-1-mcroce@linux.microsoft.com>
In-Reply-To: <20220404220314.112912-1-mcroce@linux.microsoft.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 4 Apr 2022 15:45:31 -0700
Message-ID: <CAADnVQLqXKPpfe3M1fnrUj=Cq91KucX9R95eSF+ExavWo2Wv_Q@mail.gmail.com>
Subject: Re: [PATCH] bpf: make unprivileged BPF a compile time choice
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 4, 2022 at 3:03 PM Matteo Croce <mcroce@linux.microsoft.com> wrote:
>
> From: Matteo Croce <mcroce@microsoft.com>
>
> Add a compile time option to permanently disable unprivileged BPF and
> the corresponding sysctl handler so that there's absolutely no
> concern about unprivileged BPF being enabled from userspace during
> runtime. Special purpose kernels can benefit from the build-time
> assurance that unprivileged eBPF is disabled in all of their kernel
> builds rather than having to rely on userspace to permanently disable
> it at boot time.
> The default behaviour is left unchanged, which is: unprivileged BPF
> compiled in but disabled at boot.

That is an insane level of "security" paranoia.
If you're so concerned about bpf do CONFIG_BPF_SYSCALL=n
