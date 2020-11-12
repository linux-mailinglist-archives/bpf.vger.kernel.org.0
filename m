Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6062B109A
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 22:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgKLVsk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 16:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgKLVsk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 16:48:40 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF25EC0613D1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 13:48:39 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id j205so10746771lfj.6
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 13:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XMzqJA/g9Ml7RxT+L6FzvTPiS/+31o715qZjyZXr5zU=;
        b=oLWtIOgcOxfLPFvmYnAFCgB8c+9fYXFPie/NwYZXsok/aOldLI269ARRTY6UlCxI5O
         FpqPts307UBfm9w45JEN9/LuLP0b+i/4/AeMhYeeUGXsMBwrCrEdHvdz9zwBgdGxQXXU
         UZ9pktXlrVxd8oCN/wbzIpqNA3RgwhFz8r0+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XMzqJA/g9Ml7RxT+L6FzvTPiS/+31o715qZjyZXr5zU=;
        b=jvfDYuqSNnyPPU3hWmOcR1sV88eEIqJ6pS62s72MP7iUrO3vGMdldO6Cmn8c++lsGX
         j8oJQoKDnTIBREpA8oy/KlWcvZsnYUiMjh3zvOybU1jo2AkwfmC01WfY6mIXGZMeLrq7
         q4WTsHLyMWuG+kDPT+El1BLF42loYnx/xznBGVTVck93oZhWKEDOIY72ydKixDhfFbyU
         qsw1qO7vODmHKGx/Cnp2X1r85rO7VUFZS4CRybtM4UbGGJK7uz9+xpF5v+ygluOfFs8O
         svmb3XeFYacxV0hCk+glvIrXUkk3UIsWP8mI3/U5temvowxfVmX8cTmEDc0PFP4Mmgct
         IEXA==
X-Gm-Message-State: AOAM533hiILBT0DjZABgXzKp+BqFI7HlWr9vRPY4E38t3gH8xz+oBAbO
        sgT6pIkGYbl3H+7oHgCbr3X8jSaZ1kD/9zvvrYBkbg==
X-Google-Smtp-Source: ABdhPJxxVc0EpNEqKkjp6k4LbJ4UaAhnD8TWopQsK2vPo50HFDLbAOTVSasb9CLUy3tsARW501FMNkIfcnRHz8wkpaQ=
X-Received: by 2002:a19:4a:: with SMTP id 71mr554171lfa.167.1605217718402;
 Thu, 12 Nov 2020 13:48:38 -0800 (PST)
MIME-Version: 1.0
References: <20201112211255.2585961-1-kafai@fb.com> <20201112211301.2586255-1-kafai@fb.com>
In-Reply-To: <20201112211301.2586255-1-kafai@fb.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 12 Nov 2020 22:48:27 +0100
Message-ID: <CACYkzJ6ppfsvX9_ujSCg2r0=b8bP4O2QX_HL_kuURvw8pY96qA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: Folding omem_charge() into sk_storage_charge()
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Networking <netdev@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 12, 2020 at 10:13 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> sk_storage_charge() is the only user of omem_charge().
> This patch simplifies it by folding omem_charge() into
> sk_storage_charge().
>
> Acked-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>

Acked-by: KP Singh <kpsingh@google.com>
