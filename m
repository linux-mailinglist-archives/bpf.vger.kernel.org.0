Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D19A40A51E
	for <lists+bpf@lfdr.de>; Tue, 14 Sep 2021 06:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhINEK0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 00:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbhINEK0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 00:10:26 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5AAC061762
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 21:09:09 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id s11so25092692yba.11
        for <bpf@vger.kernel.org>; Mon, 13 Sep 2021 21:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6dUT5DvFbbYMaoEPiPLDAN+5dOCe4J7gs07f/JQLEu4=;
        b=J/wx5v2jZ0Heo5oVWltVNHdeOQREYdrh2D95/smvODoPomwE/csFmxg4onKdso9qR9
         EfFBXL2wHjX1fBOUF67wimCgII2bIWFK8xZZw9tKLsWuQKwo8wrM8VqjTjWQ6Akf5uLH
         nakQ4kSYuhEzwfLHPkW07LWmQ+sFlPMRzk+e4VzdoyRoEfRHoKSn82FIfkehZ1DAZ8u6
         ClhYEb4jsK8xm8n1xVWO8yKChQslWMK0fcZuyPY9s0t69ybkZiGM6UZNDz0dD5Pj7D+I
         Tk8Gh2p99gRTr9qH6v+wxLr8R92WMubX4N3Vn0y579w9XX2sQnkWRqgvTxb0WEk8CuW5
         BwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6dUT5DvFbbYMaoEPiPLDAN+5dOCe4J7gs07f/JQLEu4=;
        b=3e5zJivHxs7ex3n7YZZwHzQFqv00QNd6wyv55/KTRql4IjWYwFj4Ii9AVsnQSOsYRL
         JzJ7/5P2fr2o28rzpQXWBu4+OXGZpvfnpSstBJgDQfym3Gc7gyk8oYxhv8C1CGBaqFNd
         JCxPd/d6g2XmO1FjUtiT1dEXTuAuEAC2DoPCdtXvotmmGJMkEsSCIknzoXzS/doKGx3q
         Wn072TiFNRlYCLqHi8Sk1FpuxSpLM9Yi4ND7xuR0llwmIJhZ6/W+4g0HQLgttBYetd75
         QogErLcCmSll9gtfkhXPFGwIhTwooAp0HyVQ16jrNcXXWq/FgKgJprzSqg6EHHynZazN
         Q1Gw==
X-Gm-Message-State: AOAM533E5eu+YvxDulZ91zCbgn1sU6LTo3c7NUGq6p9y53KD05leMN8n
        +Dvd0LF5+F1oepno1Y8Pzt/a/1S8SBgsZdFegr0ARA==
X-Google-Smtp-Source: ABdhPJwCJhxawTUBec5yEZ7/qBFch1DFW9upEUAhpY7/jiLL7TbDR3W7kx6NFnU6+YjlrxyJbW4uxU2Pvw4nyFWW368=
X-Received: by 2002:a25:b904:: with SMTP id x4mr18387519ybj.48.1631592548588;
 Mon, 13 Sep 2021 21:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210909114106.141462-1-sashal@kernel.org> <20210909114106.141462-101-sashal@kernel.org>
In-Reply-To: <20210909114106.141462-101-sashal@kernel.org>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Tue, 14 Sep 2021 06:08:57 +0200
Message-ID: <CAM1=_QQUi2diFeB+CnMx1-1zdtp4uUMLCO7f5adcMB29UjD1pQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.14 101/252] bpf: Fix off-by-one in tail call
 count limiting
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sasha,

This patch should not be applied to any of the stable kernels. It was
reverted in f9dabe016b63 ("bpf: Undo off-by-one in interpreter tail
call count limit").

I don't think it will pass the CI selftests so maybe it wouldn't be
applied anyway, but nevertheless I want to inform you about it.

Johan

On Thu, Sep 9, 2021 at 1:43 PM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Johan Almbladh <johan.almbladh@anyfinetworks.com>
>
> [ Upstream commit b61a28cf11d61f512172e673b8f8c4a6c789b425 ]
>
> Before, the interpreter allowed up to MAX_TAIL_CALL_CNT + 1 tail calls.
> Now precisely MAX_TAIL_CALL_CNT is allowed, which is in line with the
> behavior of the x86 JITs.
>
> Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Yonghong Song <yhs@fb.com>
> Link: https://lore.kernel.org/bpf/20210728164741.350370-1-johan.almbladh@anyfinetworks.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  kernel/bpf/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 0a28a8095d3e..82af6279992d 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1564,7 +1564,7 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>
>                 if (unlikely(index >= array->map.max_entries))
>                         goto out;
> -               if (unlikely(tail_call_cnt > MAX_TAIL_CALL_CNT))
> +               if (unlikely(tail_call_cnt >= MAX_TAIL_CALL_CNT))
>                         goto out;
>
>                 tail_call_cnt++;
> --
> 2.30.2
>
