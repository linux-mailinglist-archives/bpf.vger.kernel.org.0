Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE6B4A038
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2019 14:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbfFRMGE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Jun 2019 08:06:04 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35744 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfFRMGD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Jun 2019 08:06:03 -0400
Received: by mail-lj1-f193.google.com with SMTP id x25so3254714ljh.2
        for <bpf@vger.kernel.org>; Tue, 18 Jun 2019 05:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=eViPuB4mPRtq99GLUYp5aCnnWrpv2fPxaUrqbtshaow=;
        b=OzFHA/skb+Cd3TvWb0I7U3fqoUbEdeAqdN4ud+HZoRnMK7mDQ/vDiz2gc8bfTm+QTg
         oeqqo6aT01GA6E5/kqnmzskzYTF8tBSW8k17FIKLDlQS+5YI2eGyQfgYK29K3shxEUzz
         O4ckLDcVheu7R0/1qdxRgcwXxvoWYbN+8p85sQbLGqoSIIh0MNmhHyWAWBZPZzLfwUvy
         9FTigcgftBfssg9DERYI8X1JJc3SiGtqwT07bDp/iZb+I477c4fnrpgXrqyE1cC+jfoi
         Qzx4J9FPnRKGo4YGVqFJWuhuuWPGdGa/lJlpLIzvJ9HUe+hapnsISe1qzXNxuasMRcaW
         nZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=eViPuB4mPRtq99GLUYp5aCnnWrpv2fPxaUrqbtshaow=;
        b=LUdtl3pCiqhYHY+odt3BQNqu+WgwSktBrd3ZZHmRtgJldyEW5NSBHwpsVW0Hh2c4S/
         gF1BizTfLqe0Si9rG2RpL0QJM+xDFyLJ/BensCwDRxQcZT+15WdYKuR8bE7B0AdwvTW9
         pVxcIf/H+xb8x8sFf21lMKvj01ftBZd/DaQPY/wUv0fX09xJk44fOOktaTJL4jZD0eV2
         zk6kWDuNJ7/O9CcepWPeqt1bvcsk4b/Rl8fvvUvPBfsDsGQu2LBazHoRV5EjUHgkh7mh
         YpDsf3WTDFbeSxNW3Di8q6YCI581XHbRJVEzz5UZUQUZtW9VprbiQLKBdoHHqHHDRX4d
         Ta4g==
X-Gm-Message-State: APjAAAVu6Rk4Tdd3uZ7tORN6ERpuShwBzq3z3bwHoGUBCrMjyvubypN+
        jmRhgDdqc56vcQRCD5LgjphzvLwn94/az9PLWyzJxg==
X-Google-Smtp-Source: APXvYqynedWWS6RMfN+pXeWLkf2H5DM5H4yMJ5FcjVlUXuJ+N1JPU/Ap4AsjrjX3+umUXW+mGzRZGfQvvOr3ws24C8w=
X-Received: by 2002:a2e:8495:: with SMTP id b21mr21465480ljh.149.1560859561469;
 Tue, 18 Jun 2019 05:06:01 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 18 Jun 2019 17:35:50 +0530
Message-ID: <CA+G9fYufHb5N_NMd4RQnr3jJjqQ8b4Nj1CZXecWvDQPohFUewA@mail.gmail.com>
Subject: next: arm64: build error: implicit declaration of function '__cookie_v6_init_sequence'
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>, kuznet@ms2.inr.ac.ru,
        yoshfuji@linux-ipv6.org, ast@kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, kafai@fb.com,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Linux -next build failed on arm64 and arm.

In file included from net/ipv6/af_inet6.c:41:0:
include/linux/netfilter_ipv6.h: In function 'nf_ipv6_cookie_init_sequence':
include/linux/netfilter_ipv6.h:174:9: error: implicit declaration of
function '__cookie_v6_init_sequence'; did you mean
'cookie_init_sequence'? [-Werror=implicit-function-declaration]
  return __cookie_v6_init_sequence(iph, th, mssp);
         ^~~~~~~~~~~~~~~~~~~~~~~~~
         cookie_init_sequence
include/linux/netfilter_ipv6.h: In function 'nf_cookie_v6_check':
include/linux/netfilter_ipv6.h:189:9: error: implicit declaration of
function '__cookie_v6_check'; did you mean '__cookie_v4_check'?
[-Werror=implicit-function-declaration]
  return __cookie_v6_check(iph, th, cookie);
         ^~~~~~~~~~~~~~~~~
         __cookie_v4_check
  CC      net/core/net-traces.o
  CC      drivers/char/tpm/eventlog/acpi.o
  CC      fs/proc/page.o
cc1: some warnings being treated as errors
scripts/Makefile.build:278: recipe for target 'net/ipv6/af_inet6.o' failed
make[3]: *** [net/ipv6/af_inet6.o] Error 1
scripts/Makefile.build:489: recipe for target 'net/ipv6' failed
make[2]: *** [net/ipv6] Error 2

Best regards
Naresh Kamboju
