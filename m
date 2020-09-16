Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA2C26B92A
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 03:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgIPBAQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Sep 2020 21:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgIPBAP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Sep 2020 21:00:15 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63747C06174A
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 18:00:15 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id 8so459326ybu.4
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2020 18:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kdm5rBU4W0YYh8sXQnghJcbVvUUgHxZWmiFjDzL2Sck=;
        b=EwYuTXIEBua6E3qaClmP7939+lJR2I9UjCaS0NZvwHURxmRfBO0yY7RWGEp+FGU/Ay
         alWOHFoQ4YyHvAe4dfB01HOGD0hHK7vZErcZ6Gv6Kb95fYdaIFGSfWO4GD8dwG6axtnM
         N02wirjipKc7uDau2vjLJUphO9zU2I/GJmksA33PEGOP17K/wTgSweJjxkK0v+Idc6+f
         eKEFzHYCaXXoYxtC0fL2x2pF2/fERx6z1RwxXeTdZqcWNUq01jNB56R4JJtDA2Q5XRTj
         zkPe+6UpaXh0FLv97EvLvpedrydTCx0P0JAar5HS7RVH2DIVwqPOwppFl8mDCfNhCNQg
         kI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kdm5rBU4W0YYh8sXQnghJcbVvUUgHxZWmiFjDzL2Sck=;
        b=b/H/93AK27VsQzBapoZykfdk6EeqoUy+OafpcWJwYFnV96a1260UXgZa/VvKFkd31s
         X0dfmNQGOy57Ug6W30UHpwyMhMhOyo8J+wBa8n6/efIEoqtgb98ERjHRJjkoOWKRE3IA
         AZprusitEhS/8Y27RSYBJ85BtgncjcDvQWcVDMJ7XoMvtFQC7LnVgACACVPZQYuLtNGG
         VvvvHo5D1+bR7NssrmxYoHHOxs4w6HZcZCnEjG34nbwE9yMUIzzn+u7z44ZxO1+j+/eX
         T7mPioIh/aaBgvoKmVi0buphQukd2CgUesGR2AefQdn8AfU2zfRP/a9AqSWrSRQDBfdt
         Qzwg==
X-Gm-Message-State: AOAM531SZrRXqwvxDLzlo0kRaT9B4oTzM+67uCtNkVW0eCL0xVazvKyb
        MSjfpylmzTcDlMc9R4ZNNKD4Tmgd3uoIppmZj8v9DA4850wTRQ==
X-Google-Smtp-Source: ABdhPJz81dgPIXUXiVjiCqDOvJu8HwAD7VHKN7p8GFTi3fdaRoT/msLij30tjm/YQnjxiwiZnV0Naf/ICzRSZT3htfk=
X-Received: by 2002:a25:8541:: with SMTP id f1mr1167435ybn.230.1600218014704;
 Tue, 15 Sep 2020 18:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200915115519.3769807-1-iii@linux.ibm.com>
In-Reply-To: <20200915115519.3769807-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Sep 2020 18:00:03 -0700
Message-ID: <CAEf4BzZzqs6Z8E0imPOUdr2sSeAz_JvsEKgoy=7FsJnnK0Edhw@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next] samples/bpf: Fix test_map_in_map on s390
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 15, 2020 at 5:42 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> s390 uses socketcall multiplexer instead of individual socket syscalls.
> Therefore, "kprobe/" SYSCALL(sys_connect) does not trigger and
> test_map_in_map fails. Fix by using "kprobe/__sys_connect" instead.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>

LGTM.

Acked-by: Andrii Nakryiko <andriin@fb.com>

> Previous discussion:
> https://lore.kernel.org/bpf/20200728120059.132256-3-iii@linux.ibm.com
>
> samples/bpf/test_map_in_map_kern.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>

[...]
