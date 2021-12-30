Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB6F48185A
	for <lists+bpf@lfdr.de>; Thu, 30 Dec 2021 03:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbhL3CGk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Dec 2021 21:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbhL3CGk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Dec 2021 21:06:40 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E761C06173E
        for <bpf@vger.kernel.org>; Wed, 29 Dec 2021 18:06:40 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id b22so20108784pfb.5
        for <bpf@vger.kernel.org>; Wed, 29 Dec 2021 18:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7SoaFM1hOktwzt+1C9KXwK6m6eP36tOjLikT7y3Hqxg=;
        b=Eyc4K7y22CKARk3sV2ZWNDffh6bb7/QCjqKkOyVu+E6gO2AhARLN+1x/7MWL5+3e3m
         7X8rI5pnm1x1hX2qAwJHAvTzlMpYdwa/nSxvf31tpZohptcQkF8JDjSmNOzg/ztWzPoo
         PrZthmIyPU+J+ZGbTUTnRB0NkWMpceYuFxso2UkLeOBgKIRozW33ldccZk/llXZzTFA7
         X0in0Uq6eUqRpXzn/vOINOfRIjfcXC6XQXx2pxdQLt0soSL0KETy0mKjd8eGMLi8VeGR
         h10EYRu/IB4DbMFkHj0l1Vr60x/1NYjDy6LKzYi1KCtkeyvBk9bbwdAvFQciwY2Xxf8v
         Q14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7SoaFM1hOktwzt+1C9KXwK6m6eP36tOjLikT7y3Hqxg=;
        b=EJ/e8dDqaULaO1NFSiwjn1eugIEaFhh6odYXkrUsZ1Nsu+3XCurYnVrFD5/py8ms+h
         HrmoM0bg8KwpKe4HTYHFRlZ9q/Nxkg5X/eaZYp8DKgQ8899DgchqH0iaNWQ/2pYEH6kp
         ZEHuflR67TnYO1d2Js5e86wjbfZnl1W1jM+dH/2Rm0CzfMUadgDm93Abm8wRovqvwhlp
         9wWzQUq4aKGB3xiWEBxSvOIMN0jpW1tBhlrurZSDk8sJHD+HeTsaDrkussRTCq8epeij
         OolBwW2sbAfmKOFtHPUEd4Pa5qNX1IuTN4vhcsO4vMUnCaM+EBzI1kHVQnEFxi8XKddK
         ciyA==
X-Gm-Message-State: AOAM5339pf++BlPr44a2cFcVLjKhUBUyCNX9Wom0GHb9ovEjdKIJte3A
        OYwF02jiO7EWw0YE+WCNbzlDljbXajJQLYEymD4=
X-Google-Smtp-Source: ABdhPJzl18y72YqkrUdBaegoEXuFS9JqecbJAzuqFR5czbHzbZeNMREszx3ww2GxyxfjesUh+DrLaIP5A+a1mrqIb34=
X-Received: by 2002:a63:6881:: with SMTP id d123mr25175382pgc.497.1640830000039;
 Wed, 29 Dec 2021 18:06:40 -0800 (PST)
MIME-Version: 1.0
References: <CAFbkdV3Bj=gM0dd6LBaXyc-V79Y0Ewy7xKF5TQT_6H0sCpxE6A@mail.gmail.com>
In-Reply-To: <CAFbkdV3Bj=gM0dd6LBaXyc-V79Y0Ewy7xKF5TQT_6H0sCpxE6A@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 29 Dec 2021 18:06:28 -0800
Message-ID: <CAADnVQJ9W99v-_P_zE+fPfnR45=jry7RxPNYRL1enYcKF547Hg@mail.gmail.com>
Subject: Re: Adding arch_prepare_bpf_trampoline support for aarch64?
To:     Huichun Feng <foxhoundsk.tw@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 29, 2021 at 2:12 AM Huichun Feng <foxhoundsk.tw@gmail.com> wrote:
>
> Hi Jean and the list,
>
> Attaching BPF to fentry/fexit hooks requires
> arch_prepare_bpf_trampoline(), which
> AFAIK has only been implemented on x86. Is there any related ongoing patch for
> aarch64?
>
> I've found a discussion [0] on this, and seems there has no further discussion.

No patches have been posted since then.
If you have cycles to pick up this work it would be awesome!

> Any thoughts?
>
> Thanks!
> Huichun
>
> [0] https://www.spinics.net/lists/bpf/msg35573.html
