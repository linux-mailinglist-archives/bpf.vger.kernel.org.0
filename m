Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828F12E6E18
	for <lists+bpf@lfdr.de>; Tue, 29 Dec 2020 06:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgL2FPN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Dec 2020 00:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgL2FPN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Dec 2020 00:15:13 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAF2C0613D6
        for <bpf@vger.kernel.org>; Mon, 28 Dec 2020 21:14:32 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id j20so11018416otq.5
        for <bpf@vger.kernel.org>; Mon, 28 Dec 2020 21:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=r5oo3VFfrEVllqW4uZlFoy2f08XExYHzRVe9AkdK8KQ=;
        b=hxj9wSmpYHHDscEhXK+UyKaU1tIKQOK2bFTwy1F3bDWanG17uGelaAWTXO4oCmutXy
         kRMWj9xYSjaSv97UksmLRngfbin0wfz3FdKKdrldROJ4O+lNzwMHM+LTsSRMGlKh00Np
         9Wx8eT1Bj1LsVilvB3p8PZQp0Dg1za6VGhuYyg8Q4QitZn5yKz9z4jxcfS9+MOBIYVTG
         XXYRm5l0KAgiAfJdTNF2LGuB8nYRMzr0AaJU0fn4AZl8GR3p0iWn/E8zfMbvUKd7j3NV
         zK+N0+Y1fx41imn/N92KH/ln6P4LtyuQ206TPqbwjUdWu2CxSnsAtC76OiqHuXfnTKis
         3ZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=r5oo3VFfrEVllqW4uZlFoy2f08XExYHzRVe9AkdK8KQ=;
        b=KGVGycJ2CbouhjBBtsAE2jwoncPoBqnADq65/a0V6xFhHAOUychidHvJ/OT7ECT2uA
         pBRJ1jh/X3TVGRyNnI4CpplB6MPfsKcdQOXF30xpQ9KtodMUkcJSNp911mV8RAfGFJfN
         4A2FfPw+MVV8VOxEsrkx3rffmcIzxTNowzqdJDbVHcmBg/QIXLrcLuMtHRLIJ75v5sPA
         zf18PsM7AxT41/XMmuHn5dr3Euxd60smUhQZFLLRhLo2F2bs8rhTrS18eC71MhwI2W3U
         QtrCXMaNYh6w//B5NGEtsmtPyH0WQXrhWQ3OqPFDJqI/DTsnPvhoXntKYsfLQAJNn9m5
         GX8A==
X-Gm-Message-State: AOAM5312rgZd82sC2DYSdbZGuNHkkH7WHnj4QtBWk8JxDUCoMeK2+Zut
        VdNjGamBCTyIQZkS6Y+4C2c=
X-Google-Smtp-Source: ABdhPJxFrNOLOSKdmPxNsDBkMfYWFbobf7gEiOXDZRZ2kTnF9c/jWMFPTd0/4US1FFlahtQjNzbhIA==
X-Received: by 2002:a9d:875:: with SMTP id 108mr35024784oty.164.1609218872332;
        Mon, 28 Dec 2020 21:14:32 -0800 (PST)
Received: from localhost ([184.21.204.5])
        by smtp.gmail.com with ESMTPSA id s9sm9446063oie.53.2020.12.28.21.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 21:14:31 -0800 (PST)
Date:   Mon, 28 Dec 2020 21:14:21 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Song Liu <song@kernel.org>, Jiang Wang <jiang.wang@bytedance.com>
Cc:     bpf <bpf@vger.kernel.org>, cong.wang@bytedance.com,
        KP Singh <kpsingh@google.com>
Message-ID: <5feabb2d30e93_7421e208de@john-XPS-13-9370.notmuch>
In-Reply-To: <CAPhsuW4aYbyAdz0txmnudwe4E-NYoC3Up5oxd-LBzyfTtLGn7w@mail.gmail.com>
References: <20201224011242.585967-1-jiang.wang@bytedance.com>
 <CAPhsuW4aYbyAdz0txmnudwe4E-NYoC3Up5oxd-LBzyfTtLGn7w@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: fix a compile error for
 BPF_F_BPRM_SECUREEXEC
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Song Liu wrote:
> On Wed, Dec 23, 2020 at 5:14 PM Jiang Wang <jiang.wang@bytedance.com> wrote:
> >
> > When CONFIG_BPF_LSM is not configured, running bpf selftesting will show
> > BPF_F_BPRM_SECUREEXEC undefined error for bprm_opts.c.
> >
> > The problem is that bprm_opts.c includes vmliunx.h. The vmlinux.h is
> > generated by "bpftool btf dump file ./vmlinux format c". On the other
> > hand, BPF_F_BPRM_SECUREEXEC is defined in include/uapi/linux/bpf.h
> > and used only in bpf_lsm.c. When CONFIG_BPF_LSM is not set, bpf_lsm
> > will not be compiled, so vmlinux.h will not include definition of
> > BPF_F_BPRM_SECUREEXEC.
> >
> > Ideally, we want to compile bpf selftest regardless of the configuration
> > setting, so change the include file from vmlinux.h to bpf.h.
> >
> > Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
> 
> Thanks for the fix!
> 
> Acked-by: Song Liu <songliubraving@fb.com>
> 
> [...]


LGTM

Acked-by: John Fastabend <john.fastabend@gmail.com>
