Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404DD3199EC
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 07:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhBLGZe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Feb 2021 01:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhBLGZc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Feb 2021 01:25:32 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1A3C061574
        for <bpf@vger.kernel.org>; Thu, 11 Feb 2021 22:24:52 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id e18so10239946lja.12
        for <bpf@vger.kernel.org>; Thu, 11 Feb 2021 22:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AvyRMHBm9gtXtfvrKVWZYuV4qys6+kM9QiqMsPcCJyU=;
        b=tATCQlkjRwAG2mWAOoHMat3np5ci1Xy5ytrAq16GOQKTq0H4b02rk1sXWW96TD00ql
         i3oO1AMhUlsba/jvi4thxu2jV8cgFbv5BOpUnZSbLHsl6WYIJrHnYYceSLtSFoao7zMZ
         eAmB5jeuOJol2y9CaQjDI4LBpKNmxkL+13Pbh+gpadbuHMqQ3/6FZkTBgldewAFy+kOT
         mWBrkUN8OO/KtoSXOkfIFRQCh2X6F8UbURN8pu89UdLBxjYuuHm4Fe1mEZWOlUE4nOqH
         j1FR0t3Vxk8vO87WhbgowNueRQVPnIl6cY/Ep2s4tvw50FRPIEz6JWRVU1Wu0rr/YZLx
         7LrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AvyRMHBm9gtXtfvrKVWZYuV4qys6+kM9QiqMsPcCJyU=;
        b=adxG+lXu0J32JUgqbOdEyqoFgF9ZzBsKuDfQ/EqII0Lc+vJHo1bVXy0wt0GMQSRvts
         gsS1pI95rw5ZUdeVcjlYdoqox/QcLgg/qFKUw7/UZt+KsUFHEHwN2Nod0I2aAd7qMw/y
         uD55Zp/N1p9gpQqnx5Kz6O8qqe6IISIQyil3ltSx7Anfo2PUelCV2Q6oKjic3bRz6JIb
         Uw6auYKnLGRB32axiU8y6gujWkU5jAFbr8/BYPezlYP48qHBIPJxoM7Kryw1XVWOIadP
         umhNDX0sF8oEUhT2DFPQeLxplvRKDVUZ0gUOBPgmefKk2XNy/3Tzjm7dfq2UOIWqCfd3
         H6ew==
X-Gm-Message-State: AOAM530TsAFmIRcMWuF3ftoIQgA5bKNc7mIF7v7z8gtUmOgRqF4aRx9S
        ctDB1U9InitAqSd7zKxrleNcFyj0Ar+0C8C9L+4=
X-Google-Smtp-Source: ABdhPJw/OwK05wZVRujPQ1VM5iq7veXZHQHaWI9fOXM/pnT6zqUNKlfKJ/yyKX0Z6z/SZrlGilAsI5UOYFzfQpRgZJY=
X-Received: by 2002:a2e:596:: with SMTP id 144mr838537ljf.258.1613111090960;
 Thu, 11 Feb 2021 22:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20210210204502.83429-1-iii@linux.ibm.com>
In-Reply-To: <20210210204502.83429-1-iii@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 11 Feb 2021 22:24:39 -0800
Message-ID: <CAADnVQLzyQC4x=yxKDvsdiWHL62BkHZKcYsoiVy-osGmTXP_SQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Fix subreg optimization for BPF_FETCH
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 10, 2021 at 12:45 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> All 32-bit variants of BPF_FETCH (add, and, or, xor, xchg, cmpxchg)
> define a 32-bit subreg and thus have zext_dst set. Their encoding,
> however, uses dst_reg field as a base register, which causes
> opt_subreg_zext_lo32_rnd_hi32() to zero-extend said base register
> instead of the one the insn really defines (r0 or src_reg).
>
> Fix by properly choosing a register being defined, similar to how
> check_atomic() already does that.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Applied. Thanks
