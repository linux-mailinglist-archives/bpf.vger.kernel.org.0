Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6142276435
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 00:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgIWWzD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Sep 2020 18:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWWzD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Sep 2020 18:55:03 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7B4C0613CE
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 15:55:03 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t7so536599pjd.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2020 15:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j5gedaAOsIrZq5PKp+0Jk61jv8ft5ubFJ6EeG7chCIU=;
        b=oqxS8qNogb1fOb/klYC76hy0bcc41q0PuzY3CDj6tCV0lcb956gAkHxiZj3rU9k0+8
         uZB7vX8Uma+S1r656ayq5CQA23gyP7By5daJaKsoZZgW7Q+/5Wvfl2f2tenLY8t8kreg
         XyxjAExc9P4c0jEkXHMJpwLc+oqXrcybu2y5hSOJiH4I64Uq3f96zEVLFA8Slrhw6yYc
         YBsho4nPU0JSMVcNrEt/+Y1wUZ6xZ/ULuH4Lsrf7xpRf1Na0AxY63IVz+RAq8GAO3KpO
         zWq8HFKk5yMQ7ezF454KzOahj6mNFd/SWrdIqK3isAyqBgayqQHSwVQLP5n3GbY11LkM
         XbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j5gedaAOsIrZq5PKp+0Jk61jv8ft5ubFJ6EeG7chCIU=;
        b=g86r4uSl43P7CKTShSLVdFaTblbT9L9Xospv2ijj1eOglMY6qkMRCOr3HTjQKyqf5t
         qxdndFd7uJg1/sel2lzEZN8fYWtmiDS/8U6hxoWWIGGinbYekHNpT2IC2KE3wMQPO9wY
         QHyucjK58E6A+hzu6O7lIvkFAM84OTU/rEkEPe05ifOMSEQDVB3r0KH/UVQafYinr/Pb
         n2nbykXbxlZskHifAr0gUzTN35Xg8SQoK8snEqVg/EK76zzM5qeQcUXmb/knDlrnAOOe
         nNUYNYIJIcWVnz+24DtsbXOFgRxuVkVhonnrMcWDMncdXCmHU323sz/cGsBr82Mq3lD1
         8Qtw==
X-Gm-Message-State: AOAM530gj0zVIEAZV8o3G3Gzfr2Iaq2dQTIiGeVP5y9LU/uHKB04yO0P
        0av9UtloNqBKnkwl3VLVYdKEeu7a694+7+F3vKA=
X-Google-Smtp-Source: ABdhPJwWSQ9+l2sCXZKxSDP+41/D+lmN46Z+3/yUp8q+V4zRWvBBiZCDqQZudlbnm+7yPGL7OLs4b0hruVR4z8E+SrQ=
X-Received: by 2002:a17:90b:3252:: with SMTP id jy18mr1305967pjb.1.1600901702921;
 Wed, 23 Sep 2020 15:55:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600661418.git.yifeifz2@illinois.edu> <202009231224.21BCB3BC6@keescook>
In-Reply-To: <202009231224.21BCB3BC6@keescook>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Wed, 23 Sep 2020 17:54:51 -0500
Message-ID: <CABqSeAR+69BQ7OKJ9o2DD1=uz8ZozY8ygu41oodn-GUYb_gVmQ@mail.gmail.com>
Subject: Re: [RFC PATCH seccomp 0/2] seccomp: Add bitmap cache of
 arg-independent filter results that allow syscalls
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Valentin Rothberg <vrothber@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 23, 2020 at 2:26 PM Kees Cook <keescook@chromium.org> wrote:
> Did you see the RFC series for this?
>
> https://lore.kernel.org/lkml/20200616074934.1600036-1-keescook@chromium.org/
> [...]
> Which also includes updated benchmarking:
>
> https://lore.kernel.org/lkml/20200616074934.1600036-6-keescook@chromium.org/

Nice. I was not aware of that series. Looking at it, it seems that our
reasoning for checking arch and nr only, and verify if the filter
accesses anything else, is the same. However, the approach in that RFC
used was some page table dark magic, and it has been concluded that an
emulator is superior. Was there a seperate patch series with emulator?
If not, would you mind me cherry-picking some of your changes in that
series?

Also, I see that BPF_AND is said to be used in the discussion of the
linked series. I think it wouldn't hurt to emulate a few BPF_ALU so
I'll add that.

YiFei Zhu
