Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0262773BE
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 16:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgIXORB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 10:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgIXORB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 10:17:01 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4073C0613CE;
        Thu, 24 Sep 2020 07:17:00 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r19so1770422pls.1;
        Thu, 24 Sep 2020 07:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EATK8UYhF6QjpQ7ze5Yh7cYtMGpiiPgRYaZZWNM3PGw=;
        b=SJimvUVKP3YEpu5dbZp6nclj4PoP4GI+5FVjQ8crLl6qV9jI/jhWrK0lfimZtmOx6+
         mL4TiT24Ma+WYUyPm+d9i/NzLQTlpIIkM91dkJRza3wdWcUvcX5mO2ztLegu+Faz13bd
         aiYvSWKry4Go4mqNuA5xJHEhFAaeXzsmB0kYAg5AATlP8PnkJGbZCsxUOcfc4AYJt66h
         O7ToiK+nkRI+ZdMGXj7ytt9vV2U+R6zRBE/aCMP6VGIVfFUpwaCm65KWSw2OLULeAsLM
         2kBAw7c0HTRDuFAeQTVSMTpwMKMuvLnTsAN+qr4gGxfCU2iIa4w6Befzl0JtV/W8B7ks
         geOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EATK8UYhF6QjpQ7ze5Yh7cYtMGpiiPgRYaZZWNM3PGw=;
        b=hsz/qBwC4cxYixlW2CoDEKqz4YGV6rWIOwtxJv5D7ZlDgfR1u3MU+ggpMeNt/Z28+/
         +QWcw1l7f4e6OUVpBFLEVHQz+yKOehQ4eA+DNfIR4HUBRlyMoHAFAM9c42oZ6r5Z5suG
         /x+v3x27xoPy1g1BoXN0gmBMQTOa/BmiW9RfFgLra2ONNKDonRtYOM4pqkdC96+Ez4dw
         P+mBCzoqHGgTRAr55LAWF9XhpTfCsmPLCb7Z9SEIjRJVutnyc3smQ3MdCny6cjcFBNiU
         nFLPLYpAok76XRU6wSn6urQ+w7Q0vRQeccqJ01w80qBXdHh/u99cYwB2wg6Q/Y/i5OtD
         5oBg==
X-Gm-Message-State: AOAM5331FKPz2Uj76VqA/Dx1BmCLFYjgjynSfrI2oHp2MuZM1E0cibBe
        6SzVTLxd+NGdR2pvQWRwymm4uoX7Wja35n8J3kA=
X-Google-Smtp-Source: ABdhPJze9G2qwEgOsJcOLC/ZCpO1uGYoNBkKLhCAFaz0fKNffXetdfSN0Vxop7ofH0HuYNasmu+o57YdIiwKDNMuHvs=
X-Received: by 2002:a17:90b:3252:: with SMTP id jy18mr4034944pjb.1.1600957020491;
 Thu, 24 Sep 2020 07:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600951211.git.yifeifz2@illinois.edu> <20bbc8ed4b9f2c83d0f67f37955eb2d789268525.1600951211.git.yifeifz2@illinois.edu>
 <7042ba3307b34ce3b95e5fede823514e@AcuMS.aculab.com>
In-Reply-To: <7042ba3307b34ce3b95e5fede823514e@AcuMS.aculab.com>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Thu, 24 Sep 2020 09:16:48 -0500
Message-ID: <CABqSeASWf_CArdOzASLeRBPZQ-S_vtinhZLteYng4iAof4py+w@mail.gmail.com>
Subject: Re: [PATCH v2 seccomp 2/6] asm/syscall.h: Add syscall_arches[] array
To:     David Laight <David.Laight@aculab.com>
Cc:     "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 24, 2020 at 8:47 AM David Laight <David.Laight@aculab.com> wrote:
> I doubt the compiler will do what you want.
> Looking at it, in most cases there are one or two entries.
> I think only MIPS has three.

It does ;) GCC 10.2.0:

$ objdump -d kernel/seccomp.o | less
[...]
0000000000001520 <__seccomp_filter>:
[...]
    1587:       41 8b 54 24 04          mov    0x4(%r12),%edx
    158c:       b9 08 01 00 00          mov    $0x108,%ecx
    1591:       81 fa 3e 00 00 c0       cmp    $0xc000003e,%edx
    1597:       75 2e                   jne    15c7 <__seccomp_filter+0xa7>
[...]
    15c7:       81 fa 03 00 00 40       cmp    $0x40000003,%edx
    15cd:       b9 40 01 00 00          mov    $0x140,%ecx
    15d2:       74 c5                   je     1599 <__seccomp_filter+0x79>
    15d4:       0f 0b                   ud2
[...]
0000000000001cb0 <seccomp_cache_prepare>:
[...]
    1cc4:       41 b9 3e 00 00 c0       mov    $0xc000003e,%r9d
[...]
    1dba:       41 b9 03 00 00 40       mov    $0x40000003,%r9d
[...]
0000000000002e30 <proc_pid_seccomp_cache>:
[...]
    2e72:       ba 3e 00 00 c0          mov    $0xc000003e,%edx
[...]
    2eb5:       ba 03 00 00 40          mov    $0x40000003,%edx

Granted, I have CC_OPTIMIZE_FOR_PERFORMANCE rather than
CC_OPTIMIZE_FOR_SIZE, but this patch itself is trying to sacrifice
some of the memory for speed.

YiFei Zhu
