Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907E12A8770
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 20:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732011AbgKETiH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 14:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729783AbgKETiH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 14:38:07 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195CDC0613CF
        for <bpf@vger.kernel.org>; Thu,  5 Nov 2020 11:38:07 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id y184so3960866lfa.12
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 11:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HGWJtcQNnm3K36JrtOkHsUzRCxE8Lsgy2QQjiwOzQ7g=;
        b=Hwcll39O4vz6ApWY8Q3SItpvETQHag92R3GyLl67eQBVZslB+8H+RuWEmhG3bFVEI/
         u66zBpqTUcPmBkSC/OXXzk8N9gTg73zOz5zwB2tARfmHe6D15poNjk/3HQEzZqfn77gI
         WtNHRIUHVA5zNnnzy1zPxRlSPNDqFO8cENowE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HGWJtcQNnm3K36JrtOkHsUzRCxE8Lsgy2QQjiwOzQ7g=;
        b=RGbZQqhRJeh8d2NTeYWMOm5eTQy7CB+1uR2atWE4P/dYFbKSr5TKfnm70c8mRmDZ+p
         vgmkmwGsHM3dOEDph3Ev97enZnuURp8vq/744Ot3bMKpcc7xWRk6lzPEwokU6GMebojK
         VhljZSAu7PzdIYOMFYa26ufTpMd81JaNwpdY7lsJSbpusMq2Hd+0axZsjHDZY3xd+dq9
         blPSWTVGG9o7Sai/Dq7EOw6gzOog3uAzSZpbxV/PZyqXjKj2/jDCIcapyfOMdMIN1pHL
         D9TbFYVYYUmmX/sKk1nhi1bAsJ8jvwqHAQ5rNGkK1O5SjVXde7aOwuK7LsJY5il4uoH4
         DwFw==
X-Gm-Message-State: AOAM532DXooq227Fvkda6OQQe4jKaAnlKFI+91THZej7KWDzpJsIziUL
        W6lxBa7yxotT6GyRIOOh/IV42uv5yaKH2YpYnzZ2Ng==
X-Google-Smtp-Source: ABdhPJxob24SiMj9UUZklhhDUgti0FEUIOLu5HxStACeUUHIKm1wpPBilYYhHbjaG3HVfvtFCkBVH14yidpfkLft+IA=
X-Received: by 2002:a05:6512:3102:: with SMTP id n2mr1539451lfb.153.1604605085605;
 Thu, 05 Nov 2020 11:38:05 -0800 (PST)
MIME-Version: 1.0
References: <VI1PR8303MB00802FE5D289E0D7BA95B7DDFBEE0@VI1PR8303MB0080.EURPRD83.prod.outlook.com>
 <CAEf4Bza0unqU9QWBtuh_y07OGnC_HxOK_RwO+UTJ_0XhQdm1Vg@mail.gmail.com>
In-Reply-To: <CAEf4Bza0unqU9QWBtuh_y07OGnC_HxOK_RwO+UTJ_0XhQdm1Vg@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 5 Nov 2020 20:37:54 +0100
Message-ID: <CACYkzJ5paau+vEoQv5NYKCDmJ=D_u178HhYp9Lrfyp2-u=S8jQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] Update perf ring buffer to prevent corruption
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        KP Singh <kpsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 5, 2020 at 8:07 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 5, 2020 at 7:16 AM Kevin Sheldrake
> <Kevin.Sheldrake@microsoft.com> wrote:
> >
> > Resent due to some failure at my end.  Apologies if it arrives twice.
> >
> > From 63e34d4106b4dd767f9bfce951f8a35f14b52072 Mon Sep 17 00:00:00 2001
> > From: Kevin Sheldrake <kevin.sheldrake@microsoft.com>
> > Date: Thu, 5 Nov 2020 12:18:53 +0000
> > Subject: [PATCH] Update perf ring buffer to prevent corruption from
> >  bpf_perf_output_event()
> >
> > The bpf_perf_output_event() helper takes a sample size parameter of u64, but
> > the underlying perf ring buffer uses a u16 internally. This 64KB maximum size
> > has to also accommodate a variable sized header. Failure to observe this
> > restriction can result in corruption of the perf ring buffer as samples
> > overlap.
> >
> > Track the sample size and return -E2BIG if too big to fit into the u16
> > size parameter.
> >
> > Signed-off-by: Kevin Sheldrake <kevin.sheldrake@microsoft.com>
> > ---
>
> LGTM.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks for tracking this down and fixing it!

Acked-by: KP Singh <kpsingh@google.com>
