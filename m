Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0E833F80C
	for <lists+bpf@lfdr.de>; Wed, 17 Mar 2021 19:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbhCQSUS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Mar 2021 14:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbhCQSUQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Mar 2021 14:20:16 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5897EC06174A
        for <bpf@vger.kernel.org>; Wed, 17 Mar 2021 11:20:16 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 15so4463668ljj.0
        for <bpf@vger.kernel.org>; Wed, 17 Mar 2021 11:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hXBtxa2949+5hCtAmQNzADPKHhEJmzh3z7qttX3zS2U=;
        b=gGckk5xJHYxaxY3s/OIeNWXuHNsJnI3mR5365oqw55YmeMjRQrbpH5NsPFiNrIv1TG
         SHsooqdPVsFT9tEYhCPL4p3cFNBsUDvgXglGBU2m2CUxYcafPh4MI/8SbEvxKOGCYggo
         38OXwcIOjM4nWdWCWaAZPq8s1pzckJorlyi3bw3aZHEzA316Pv8bf4X+GZhf9dPmMIjV
         OpL5IgsYXn7DvnmC2bEE8pZgV6jYCYV/RUX1XWI+HTlwWWhteKSE7ktGq8wtmn796Xxp
         rCLD+ZapQo46iwjgndXh4ANjNhK5nlW/rmIZGEi6tXpSgtbBdy0IoR4URq4ZJK6M/PhL
         nPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXBtxa2949+5hCtAmQNzADPKHhEJmzh3z7qttX3zS2U=;
        b=G/R2wN+hEHSFvFgFqh0AWmNsUDoFTTivjG+lMHjbDe6Vp3HYlrij7Ab1GSvmKiiElX
         zSIlv2JlFRZlF0Ayz/negQD+Zbz22XzK/6UxgeGaFLjYYqWAHxUDFSGg9FnBnOVLFuW1
         z9+yGgxfOp5kOowruXOy/dvorqVpSaLitHIrWUNU0oORKGn6C9leNVE14o7ZGURCY2da
         PrxH9fsYal8JvHM1HR4YM3CAg/KsVIO9lHuUUv/mpPonLwqCCo342Bwjj1zh3a7Y0Sap
         U6Vt2q3AugDSTh/Q1lTAFVHbzg5XgwODdAbOci3KmFYmNsvW22g9w2ad1Zr5pLT9r6wa
         a+MA==
X-Gm-Message-State: AOAM531tNzVdedf/RmC47Zesjo5LhNUwPlyCzqttu5v4wF4iAax+UOdY
        MTzkBpHHFUtL/8qDnXxGM5voqpwVi8vfkz180WxFlYix
X-Google-Smtp-Source: ABdhPJx4Pfza4L1j3sn4vZg2Upl0bw5lldPYSf3vu5N/N/VJn6EiqGvxF+jZ4VDUsHiRJ6hMHcbaEV7JdpcJTDtiRXA=
X-Received: by 2002:a2e:b817:: with SMTP id u23mr3050740ljo.44.1616005214838;
 Wed, 17 Mar 2021 11:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAM_iQpXJ4MWUhk-j+mC4ScsX12afcuUHT-64CpVj97QdQaNZZg@mail.gmail.com>
 <20210310011905.ozz4xahpkqbfkkvd@ast-mbp.dhcp.thefacebook.com>
 <CAM_iQpXP-m03auwF_Ote=oSev3ZVmJ5Pj_5-8aJOTMz+Nmhhgw@mail.gmail.com>
 <CAM_iQpUvU3PQ9-i1n+YW7GU_FNSzURe1v61AkJw=QutxEZhakw@mail.gmail.com> <CAM_iQpU+9e5op7ZEgX1ThSfBxqOemw6Dy_hZFaBR0mHk1XePSQ@mail.gmail.com>
In-Reply-To: <CAM_iQpU+9e5op7ZEgX1ThSfBxqOemw6Dy_hZFaBR0mHk1XePSQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 17 Mar 2021 11:20:02 -0700
Message-ID: <CAADnVQLRSYr4AYZoNh589v0eBqw+f72iXmzhAqmzTK7kfVYmKA@mail.gmail.com>
Subject: Re: bpf timer design
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Dongdong Wang <wangdongdong.6@bytedance.com>,
        duanxiongchun@bytedance.com, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 17, 2021 at 10:26 AM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>
> On Tue, Mar 16, 2021 at 9:21 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > We still need a timer map:
> >
> > struct {
> >      __uint(type, BPF_MAP_TYPE_TIMER);
> > } map SEC(".maps");
> >
> > However, its key is not a pointer to timer, it is a timer ID allocated with
> >
> > u32 bpf_timer_create(void *callback, void *arg, u64 flags);
>
> Hmm, we do not need a map at all, because the verifier could check
> whether create() and delete() are paired correctly, so we can just
> have the following API's:
>
> u32 bpf_timer_create(void *callback, void *arg, u32 flags);
> void bpf_timer_settime(u32 id, u64 expires);
> u64 bpf_timer_gettime(u32 id);
> int bpf_timer_delete(u32 id);
>
> Pretty much similar to Linux user-space timer API's. I will probably
> go this direction, unless there is any objection.

I think a specialized map or hidden map that returns id like above
has plenty of downsides.
Please reconsider what I was proposing.
In the previous email I outlined the reasons why 'struct bpf_timer'
embedded in any normal map is more user friendly and more flexible.
I'd like to discuss those points first. It sounds to me that you disagreed,
but I couldn't find an articulation on why you disagreed.
