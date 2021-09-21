Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277544132D6
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 13:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhIULve (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 07:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbhIULvd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Sep 2021 07:51:33 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745D3C061574
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 04:50:05 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id p29so79429230lfa.11
        for <bpf@vger.kernel.org>; Tue, 21 Sep 2021 04:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=4ajJC0iuI41q/Xn34MY7MO7NfPjANKFwO1425fGvuic=;
        b=m/iEVKhj2vYqo4hUio4dpgjf7DY7A35MJ7phTtMlkfCR5aevYKER+cjeHTvxBW5/mn
         77XXNg03iqY6eFk6cOjUXUyY4JbOSCk1yRez2eXG9Nz95kMaoF/u2g32ko33sISOQIXr
         YgP6xOB0EbnKmiu7XaF5fzZZWQXTQ9Fbykw7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4ajJC0iuI41q/Xn34MY7MO7NfPjANKFwO1425fGvuic=;
        b=AmbgF8eP8fM1ZTtJeFK4LiHl8XTyrmMBhDiuuqgIYqW//U9nKmNmIEprnlPuCfrLCd
         EqvJ1WvEtbup9ftN4a/KMFACvMXPyzJrdpeV185W35dPHMOOCr2E8x0lbmmJak9e/42y
         YDjA5bOFpq/yD3u0laJtYVEm1JlUR5s9UMHlTqUeCfOkyovligRVv29CGEgbhl/q6ODD
         AzZn7VHOLcJVuwqEa/OFAQrAaIQUtMZK98Kqd6pPn/T73c+g3mtB3EXeSp9fMYt1fTS+
         3HeoRZ/GDmC2tRiu778VDMpU5gUJIN6jL4VuxpaV4oBLX22e40e3MMtNiD5hsR6XIN/6
         MSnQ==
X-Gm-Message-State: AOAM5339Wb8YHGI0zMZWijnBYqzgYItShx6+x9pEmCVV4SoQmXIB9ZhK
        sWPLDe5pcat5/j4MJL51D5aZynizJa98iqiVZsjJq9JN4io=
X-Google-Smtp-Source: ABdhPJxNoETARkKM5BC4qNQ4IazAp0PnaNJcmqTO1rUD1VcUBaOdmwh2/AJn3k2K4+ZWx4Fc70xrVgL9U9VbW5FnKJ4=
X-Received: by 2002:ac2:5b10:: with SMTP id v16mr22134450lfn.331.1632225003392;
 Tue, 21 Sep 2021 04:50:03 -0700 (PDT)
MIME-Version: 1.0
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 21 Sep 2021 12:49:52 +0100
Message-ID: <CACAyw9_TjUMu1s46X3jE3ubcszAW3yoj39ADADOFseL0x96MeQ@mail.gmail.com>
Subject: bpf_jit_limit close shave
To:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

We just had a close shave with bpf_jit_limit. Something on our edge
caused us to cross the default limit, which made seccomp and xt_bpf
filters fail to load. Looking at the source made me realise that we
narrowly avoided taking out our load balancer, which would've been
pretty bad. We still run the LB with CAP_SYS_ADMIN instead of narrower
CAP_BPF, CAP_NET_ADMIN. If we had migrated to the lesser capability
set we would've been prevented from loading new eBPF:

int bpf_jit_charge_modmem(u32 pages)
{
    if (atomic_long_add_return(pages, &bpf_jit_current) >
        (bpf_jit_limit >> PAGE_SHIFT)) {
        if (!capable(CAP_SYS_ADMIN)) {
            atomic_long_sub(pages, &bpf_jit_current);
            return -EPERM;
        }
    }

    return 0;
}

Does it make sense to include !capable(CAP_BPF) in the check?

This limit reminds me a bit of the memlock issue, where a global limit
causes coupling between independent systems / processes. Can we remove
the limit in favour of something more fine grained?

Best
Lorenz

--
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
