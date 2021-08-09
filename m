Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD4B3E4866
	for <lists+bpf@lfdr.de>; Mon,  9 Aug 2021 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbhHIPM0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 11:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbhHIPM0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Aug 2021 11:12:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36685C0613D3
        for <bpf@vger.kernel.org>; Mon,  9 Aug 2021 08:12:05 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m36-20020a05600c3b24b02902e67543e17aso159935wms.0
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 08:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cilium-io.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=YTIqNpWcR7ZSMh6S/6bEELgHeoLKVjnxKPs7OdYSS5g=;
        b=kqSWT1bB6GUDcXZbZeE2jj3iMVYpveORHRCeZ1WEV1f8AmfTT/ZTYfaNO7HC0Y7QK7
         +v6yyh5bylm3pWzzoYJvp6/8y3A1Z0agLKsVIvIHUwvdWQ7weN2RW230StSi//T8CKh1
         JDpYtvOIeRFhSpmiH/dvBQyQY+OLjqwuJmrwBdcvZlbarVB9E5gqxxeVxJTo6EbpidWT
         JwICG1wGLnUpLN5rRk/b08Dnd+g1GQx/fb0Rn4yoOCz1Rj10uApwYLrDx/AT3K88yHPQ
         N+h5zFbwRIVPiaQzQCBVGIoiTPDdlinNFUkdtpr18KHYygfY1aTgDpmLdQ7iNbrfu7Yt
         Uxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=YTIqNpWcR7ZSMh6S/6bEELgHeoLKVjnxKPs7OdYSS5g=;
        b=GIidKwAlXw5zWarF3DKvq0laR/wTtyYzcJV/74le3uFr8pYsPZB/bcJu8TPxg8JUEl
         zmLX7l33KagZFNhE8kx7csmJ00Jbq3fJh9lORZDgEWWQzjOSoKTXRKSQXybcF0hqBtOV
         xHd6UZSh/qd3uZxXwoWLY9d0TWvI5dKYbu/rK/RS+OtkpmM8EFezLzd0y7Y+eg4yzFvj
         T7gkKCtPU5p4b0IzyyBbaENH/AjNaXV9wpeYyzzD/DwGaQ48ubOc4WA2I5kNPebiKU80
         TCKK+XAL/RqYaJ/EZmtpaoGcOupQ5Ng3nOganbxHMQXjqZhiahVHvk0WWd2eTr4z9K5y
         Lp1g==
X-Gm-Message-State: AOAM531oiyE7aeQbfxmbLKCf++OxXK6uju2Y1CS8tGwQnpySYvDraHEL
        hzhEPak+vonD6KAqbLB5KJ+Sp9IOHatW1yPmBw==
X-Google-Smtp-Source: ABdhPJyRiZcaF3DQcMvhefli0Eav6fOgkQTEwCETCi/5V57S14PW/zxp6YzDu1zU70+J7rHgB8IEiQ==
X-Received: by 2002:a05:600c:b52:: with SMTP id k18mr3070392wmr.46.1628521923746;
        Mon, 09 Aug 2021 08:12:03 -0700 (PDT)
Received: from Mem (2a01cb088160fc00b0c62f777661db06.ipv6.abo.wanadoo.fr. [2a01:cb08:8160:fc00:b0c6:2f77:7661:db06])
        by smtp.gmail.com with ESMTPSA id r18sm2269590wrt.76.2021.08.09.08.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 08:12:03 -0700 (PDT)
Date:   Mon, 9 Aug 2021 17:12:02 +0200
From:   Paul Chaignon <paul@cilium.io>
To:     bpf@vger.kernel.org
Cc:     Yonghong Song <yhs@fb.com>, Martynas Pumputis <m@lambda.lt>
Subject: R11 is invalid with LLVM 12 and later
Message-ID: <20210809151202.GB1012999@Mem>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

While trying to use LLVM 12.0.0 in Cilium, we've noticed that it can
generate invalid BPF bytecode:

    $ clang --version
    Ubuntu clang version 12.0.0-++20210409092622+fa0971b87fb2-1~exp1~20210409193326.73
    Target: x86_64-pc-linux-gnu
    Thread model: posix
    InstalledDir: /usr/bin
    $ make -C bpf -j6 KERNEL=419
    $ llvm-objdump -D -section=2/20 bpf/bpf_lxc.o | grep -i r11
         171:   7b ba 18 ff 00 00 00 00 *(u64 *)(r10 - 232) = r11
         436:   79 ab 18 ff 00 00 00 00 r11 = *(u64 *)(r10 - 232)
         484:   bf 8b 00 00 00 00 00 00 r11 = r8

That bytecode is of course rejected by the verifier:

    171: (7b) *(u64 *)(r10 -232) = r11
    R11 is invalid

LLVM 12.0.1 and latest LLVM sources (e.g., commit 2b4a1d4b from today)
have the same issue. We've bisected it to LLVM commit 552c6c23
("PR44406: Follow behavior of array bound constant folding in more
recent versions of GCC."), but that could just be the commit where
the regression was exposed in Cilium's case.

--
Paul
