Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D0D2A7CD0
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 12:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgKELVc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 06:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgKELVc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 06:21:32 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FFEC0613CF
        for <bpf@vger.kernel.org>; Thu,  5 Nov 2020 03:21:32 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id m8so1192429ljj.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 03:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=84ZWSQjWBn1znvrh47o6MT+MDkoQVyTF6e6fQOBczfY=;
        b=Zsx2P+vnAfME3FkzPONpusLaY7ctXzuC04MKpYz4z54PuXHgLTOZ7FV0hp9e7mfbUw
         ZCc/YugI1wWS6hJ1HKTCyVq0kz/EXbgyjyj71Wvai9+bfRf7FauqwaWTi+iyZq3+190t
         MQmmlAuXyD7vk8OaauKECQ153nhNDAzUgxENQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=84ZWSQjWBn1znvrh47o6MT+MDkoQVyTF6e6fQOBczfY=;
        b=mPLWgo5gT7OSuHohtZZg0wg8GkmCxSl2bo7hl9NNK4dQMwQi+df2tgpddXCXv0IJdI
         /jtmGqkl4LN89qAETjF0yM0wP0cjHdyEchIOIHHYXbXz5R5co+uaMYm19DUkyJtOV9q6
         38AwnqOwXLAozbQ7a6TwKnD7MpMb/kBPug8Pfb06sWpDkgvJ5x9UfNOibh3PwTUZn0j6
         E3pGwnj9O2VfrlJd84vASAhr+eluW4J1hJCsjeSMbh9EnIY4OwoqnrhkeM4iNUqNhIC7
         U0yVgfUyGFTI2HLtbXRr77h9VdnZf2IiY5lLNZTacGo/i65qi9dKR7BrEkYg8nokIaKu
         VBBA==
X-Gm-Message-State: AOAM533O/1ghlTGLRfmUI0fT0IFqN16wiaS8C+D0wWR7yDi/F63HNgds
        BNH91+LffKwpmQXCbihGZuu2aQTt8CkYM+nwmAyZhQ==
X-Google-Smtp-Source: ABdhPJxXqQnio+Mn+x4VgFP2r3oKv4IkH/WqiN/0cbmLmPwCe3+lxVJlHwVBYMwtgnbLGh/mkTR6JmnFPuPhkrbjIcE=
X-Received: by 2002:a2e:8757:: with SMTP id q23mr702366ljj.82.1604575290757;
 Thu, 05 Nov 2020 03:21:30 -0800 (PST)
MIME-Version: 1.0
References: <VI1PR8303MB00802B04481D53CBBEBCF0DDFBEE0@VI1PR8303MB0080.EURPRD83.prod.outlook.com>
In-Reply-To: <VI1PR8303MB00802B04481D53CBBEBCF0DDFBEE0@VI1PR8303MB0080.EURPRD83.prod.outlook.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Thu, 5 Nov 2020 12:21:20 +0100
Message-ID: <CACYkzJ7uUb97TeWi+r8zLAOMUMk8z_zVvQ=c7p8z2gAP0X5C3A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Update perf ring buffer to prevent corruption
To:     Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 5, 2020 at 11:41 AM Kevin Sheldrake
<Kevin.Sheldrake@microsoft.com> wrote:
>
> From 8425426d0fb256acf7c2e50f0aa642450adc366a Mon Sep 17 00:00:00 2001
> From: Kevin Sheldrake <kevin.sheldrake@microsoft.com>
> Date: Wed, 4 Nov 2020 15:42:54 +0000
> Subject: [PATCH] Update perf ring buffer to prevent corruption from
>  bpf_perf_output_event()
>
> The bpf_perf_output_event() helper takes a sample size parameter of u64, but
> the underlying perf ring buffer uses a u16 internally. This 64KB maximum size
> has to also accommodate a variable sized header. Failure to observe this
> restriction can result in corruption of the perf ring buffer as samples
> overlap.
>
> Truncate the raw sample type used by EBPF so that the total size of the
> sample is < U16_MAX. The size parameter of the received sample will match the
> size of the truncated sample, so users can be confident about how much data
> was received.
>

I don't think truncation without any indication to the user is a good
idea and can lead to other surprising problems
(especially when the userspace expects the data to be in a certain format,
which it almost always does).

I think the complete sample should be discarded if the size is too big and an
E2BIG / or some error should be returned.
