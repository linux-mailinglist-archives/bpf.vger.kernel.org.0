Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B2E2CB4B6
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 06:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgLBFuy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 00:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgLBFuy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 00:50:54 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC8BC0613CF;
        Tue,  1 Dec 2020 21:50:13 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id o24so1297200ljj.6;
        Tue, 01 Dec 2020 21:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cuyoXm7dOSGvQx2nmPKoNCKA8r1kDXEpd1G9Bc+G7jI=;
        b=kkz2KPZr5BAFIvoXjhm5E7LmxdTQBqcc0ZyGYSqNtrqbxXK97MQlMKwMyccRrSZNHm
         Lzuz2kta7bvtHLOOt3/yB36m3Bb7c9lD9YAZwSmD52u8R6J81EYl+g4WQiSUc3OjXVbH
         R1CYwPUTIgrUnkqHQBtpxASSlVki78BxavmYXBs9z2xJyLNDIx33YDFwOHNKoN65RMaS
         zZ//OuRjgKXcVJQ3qxsgbbRseTAc9sQQRp4td3SRezmmhgowRK7gH46T96oTrnTlq/W8
         B3ajO85YAShsFu3c8c8t0+PW6LZrZwEvkPGLzEkWnbhXbPIir33/waXfxvi9G5QlZoxT
         fM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cuyoXm7dOSGvQx2nmPKoNCKA8r1kDXEpd1G9Bc+G7jI=;
        b=E1mBk5N+FwZpRGYEHuystKj7MdUTVc17iMtpHgd8Xu4qS8trC/lrrcNxJm0yVGWZFZ
         G3RgQ1LYPnaDYccZL2HA1WD4587/EpH3wuWTRDasscRj/bY71b/Fs7XFzHfVQldh7kg/
         Q0xi1RwPWK4pFCTz08Q6N1AcuJenT7aPHgboHuW+Ky48OZTqvbzwohAj3mn6I5g6rSSx
         usi7ABLpnjqV9W7AUbR9vGVVsEvJlzKqEEWKw3KTySxRJ2XGC705y0cCalE1hToij1Vl
         3oovBA9//DHCCR3O4s06A71o5QLZv6W0PSoTLlPkIFq4M2CRZpNyjQr70btE0WEIyaR1
         cwbw==
X-Gm-Message-State: AOAM531YtxXxQo3Y2yoPiO3Cne6DTb/wcmi9qNja3nyMpBezulproZLr
        sSYibvmakic12agHNah5vFsmqZY5/wtrpshejEg=
X-Google-Smtp-Source: ABdhPJyef1QKjISb8CUPhjRDqUrTYGlEs/BmicYrObheTT1prYWd9+Y9Nne+bKfFvZnS17eBEMml91uxFDa3RR66xHY=
X-Received: by 2002:a2e:9681:: with SMTP id q1mr445104lji.2.1606888212071;
 Tue, 01 Dec 2020 21:50:12 -0800 (PST)
MIME-Version: 1.0
References: <20201127175738.1085417-1-jackmanb@google.com> <20201127175738.1085417-2-jackmanb@google.com>
 <20201129011552.jbepegeeo2lqv6ke@ast-mbp> <20201201121437.GB2114905@google.com>
In-Reply-To: <20201201121437.GB2114905@google.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 1 Dec 2020 21:50:00 -0800
Message-ID: <CAADnVQJci_Fqq7d6GbUtivcmSgnPLbkwuH9MN30BhFomff=5rg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 01/13] bpf: x86: Factor out emission of ModR/M
 for *(reg + off)
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 1, 2020 at 4:14 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> On Sat, Nov 28, 2020 at 05:15:52PM -0800, Alexei Starovoitov wrote:
> > On Fri, Nov 27, 2020 at 05:57:26PM +0000, Brendan Jackman wrote:
> > > +/* Emit the ModR/M byte for addressing *(r1 + off) and r2 */
> > > +static void emit_modrm_dstoff(u8 **pprog, u32 r1, u32 r2, int off)
> >
> > same concern as in the another patch. If you could avoid intel's puzzling names
> > like above it will make reviewing the patch easier.
>
> In this case there is actually a call like
>
>   emit_modrm_dstoff(&prog, src_reg, dst_reg)

emit_insn_prefix() ?
