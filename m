Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8BE31132C
	for <lists+bpf@lfdr.de>; Fri,  5 Feb 2021 22:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhBEVMq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Feb 2021 16:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhBEVMT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Feb 2021 16:12:19 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731EEC0617A7
        for <bpf@vger.kernel.org>; Fri,  5 Feb 2021 13:10:12 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id o14so4575217pfp.16
        for <bpf@vger.kernel.org>; Fri, 05 Feb 2021 13:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=PWPQxeCAdhLh3iBL7DE/6gQVuXBKlPLZEtdhRuCjmxw=;
        b=NVSHL24F+1cvfoWwSWqqObWmcSZ+jmqBVq/c4//iEhKqhjfAp3ck1OyTyQIfo6vOwq
         IzvZWR1V+fZmIKTRY6keeQrrjFffwzyRbKg3KIWQTXZG0lh7XU9IgpA+YOZv+FIAZcRT
         Y+vHWkVnhODRGhUCp43s+0N8646L9yGlYSaJMHPWkJcbGyxE6mfFn2GgozQvGnNmv/hx
         DOC8+qufXNZX+iIhg7SxYhq7Zs8t7mHXlFelstQIOF6k3tYIMUgbiCKZ1vrIn7pt4aLn
         VPPBnli46CbhzX6rWKn9wdj2s6mcob+dODr4z/GN36VnNl7wnwOxI27Y/AXrcLtdrIDP
         saug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PWPQxeCAdhLh3iBL7DE/6gQVuXBKlPLZEtdhRuCjmxw=;
        b=R52YI7yRPtpm/sZPtQxtlEKEkt1g8ARYeE0gdi4rDmLQWBsh3kmc+PYmEgsjrTmyej
         nuCAU3A0oowpiNu+FOQ1dM4uc9yncUmDU7Lk5gh0DGHacJL5l3wER6Z4iECQr6FU61GC
         bREhrhEqCAQPnjaofvfucUA8RIyMITTNN4Pq3JiWxiZ9IACTkYgYYUCLP1kbh2Lt7d/H
         moh/Jw5h5o7EtTG4aHRFfs3M2IN//ndNc+CS9MwZJYpaCywbiaSpP6rbOXImgi6kSfTq
         voYWselaOHrRh298dPrhYqyE/q8UGdrdHLf6Y8Cq+CyDmQe1JWypevNHxQz3UunHc2YF
         ln4g==
X-Gm-Message-State: AOAM533TnqPRp7RYavJQezMiDecaea686oLOy0FO+eYdmiyKUw+XImSX
        8rnmTSUTi17ZV1ar3DTqsoW3N2FzmfqRfWgR0lg=
X-Google-Smtp-Source: ABdhPJxExyVCuSceD3ifRJmPh4e6qYieel8G6WM1s0Z4zTD3g3ANK25YrnpQAQC6Cgtpy/n50ph6dZ0xx7gfZ2oOuns=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:fce9:1439:f67f:bf26])
 (user=ndesaulniers job=sendgmr) by 2002:a17:90a:2b8c:: with SMTP id
 u12mr5684697pjd.98.1612559412019; Fri, 05 Feb 2021 13:10:12 -0800 (PST)
Date:   Fri,  5 Feb 2021 13:10:10 -0800
In-Reply-To: <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
Message-Id: <20210205211010.2764627-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CA+icZUVQSojGgnis8Ds5GW-7-PVMZ2w4X5nQKSSkBPf-29NS6Q@mail.gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     sedat.dilek@gmail.com
Cc:     andriin@fb.com, arnaldo.melo@gmail.com, berrange@redhat.com,
        bpf@vger.kernel.org, cavok@debian.org, dwarves@vger.kernel.org,
        jengelh@inai.de, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        mjw@redhat.com, omosnace@redhat.com, paul@paul-moore.com,
        tstellar@redhat.com, yhs@fb.com, zzam@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Hi,
> 
> when building with pahole v1.20 and binutils v2.35.2 plus Clang
> v12.0.0-rc1 and DWARF-v5 I see:
> ...
> + info BTF .btf.vmlinux.bin.o
> + [  != silent_ ]
> + printf   %-7s %s\n BTF .btf.vmlinux.bin.o
>  BTF     .btf.vmlinux.bin.o
> + LLVM_OBJCOPY=/opt/binutils/bin/objcopy /opt/pahole/bin/pahole -J
> .tmp_vmlinux.btf
> [115] INT DW_ATE_unsigned_1 Error emitting BTF type
> Encountered error while encoding BTF.

Yes, I observe this error, too.

https://gist.github.com/nickdesaulniers/ae8c9efbe4da69b1cf0dce138c1d2781

via v9 of my DWARF v5 series, which should help make this easier to
reproduce:
https://lore.kernel.org/lkml/CA+icZUW3sg_PkbmKSFMs6EqwQV7=hvKuAgZSsbg=Qr6gTs7RbQ@mail.gmail.com/T/#m45ec7e6df4c4b5e9da034b95d7dfc8e2a0c81dac
