Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CD52D1847
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 19:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgLGSPD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 13:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgLGSPC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 13:15:02 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3B4C061749
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 10:14:22 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id a1so14685785ljq.3
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 10:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q4If43plamllKjhrMKwl+1SOz0Lg20MA17+5IYuyUsg=;
        b=t8EtgndlDk+OpFR8akB0UTjwPiuO3CAtwUDLdxM+3si5DpECvmHJmxkgKXb3mzw7vE
         ekFnHDvLMXdGH8GbpF1qzJML3Tvq+h7Ef1JxQYY83+SH8OwHit7Cr3+cLO7I9VR4HZQr
         jZo0AU+wRad8HL72Io9Q6HGDKIsG53S9ACiK833HcFtphMPiniW8ueWxm5klIyUHvZbx
         1VdxrdS9RK1mZ5rYijkMIYlKlhSdSDciwqRvUr2f8b6Wn8ZmD1+n3J+pmObvXhIjTJOd
         LsRmimXZlhGKPd+MpMu0YZHzC/pyPujhnrXExkOtFTScxqs5C6apRCn+QXw++DwEyhJw
         HKVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q4If43plamllKjhrMKwl+1SOz0Lg20MA17+5IYuyUsg=;
        b=nfh8WXmvDYpV9xfsVH2+wdvXozQcg95Aiskkgio8tDTBH/Ip6DnaY6MZAuQ7nMNJSn
         FmGM2Y6e9BDV4tCX0cDBOWVd8yVW/VKsjpPGNFxna+nuhtbGp/yuMyTaJI/djYo1c47Y
         VOb0/QZgFGbF1ceSDjPWCadqKdQk/lXxUk7FijnU6O6LAqTDA0FYAhuKewhQj9zCanf7
         v4GN2AYmTacvzsnYXupMyDZ9V3nY5NjICfkLGHQ5qhjNxSC+bQ8OhLanaTedjpMV6vCm
         vuree1XJQNA3it6WQxELVopTg1CvSE/lkwK665vyh7knmLRHQrp2ICLgBgTbuJZkkxGa
         Q+nA==
X-Gm-Message-State: AOAM531r6c59VaKv5Xmffn/yC0x/aIpm9hO8ZLXUJFXeTrPiLw2AT0Dh
        VhTIpLQLo24zgA1FPP9u7E53CcBQHFM5jEcFvcg=
X-Google-Smtp-Source: ABdhPJxMLIYo7n0YqkPOv+cksoZ5U7pW9nktcnQBGZY7lM2ChIczzEgN/utkK+55zaYpmqRKswvzmqCjrnvUYWGesV8=
X-Received: by 2002:a2e:b4b3:: with SMTP id q19mr1553513ljm.121.1607364860669;
 Mon, 07 Dec 2020 10:14:20 -0800 (PST)
MIME-Version: 1.0
References: <87lfeebwpu.fsf@toke.dk> <10679e62-50a2-4c01-31d2-cb79c01e4cbf@fb.com>
 <87r1o59aoc.fsf@toke.dk> <6801fcdb-932e-c185-22db-89987099b553@fb.com>
 <CAEf4BzZRu=sxEx7c8KGxSV1C6Aitrk01bSfabv5Bz+XUAMU6rg@mail.gmail.com>
 <875z5d7ufl.fsf@toke.dk> <CAADnVQ+qibC_8cDwaqOoAnL7CwXv85EjQ96Zcdtrm+86cgZq1g@mail.gmail.com>
 <878sa9619d.fsf@toke.dk> <CAADnVQKYaeF2KCC5SLBg3feUY_DBh-eq2_O=T10_+13z3wNm1Q@mail.gmail.com>
 <82dc6d2b-95b6-ab50-8bdb-6e90cfb32059@gmail.com>
In-Reply-To: <82dc6d2b-95b6-ab50-8bdb-6e90cfb32059@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 7 Dec 2020 10:14:09 -0800
Message-ID: <CAADnVQKdQdxAouvFGAWr+xT73=JZGkaKdTObsDW0GAnjcDzx9g@mail.gmail.com>
Subject: Re: Latest libbpf fails to load programs compiled with old LLVM
To:     David Ahern <dsahern@gmail.com>
Cc:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 7, 2020 at 10:02 AM David Ahern <dsahern@gmail.com> wrote:
>
> On 12/7/20 9:20 AM, Alexei Starovoitov wrote:
> > The user space library is not a kernel.
> > The library will change its interface. It will remove functions, features, etc.
> > That's what .map is for.
>
> So any user/package wanting to leverage libbpf can not expect stability
> or consistency with its APIs?

If you're talking about iproute2 and your own convoluted definition of
stability and consistency then certainly not.
