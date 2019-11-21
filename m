Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8C65104C23
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2019 08:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfKUHSH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Nov 2019 02:18:07 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:40738 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfKUHSF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Nov 2019 02:18:05 -0500
Received: by mail-lf1-f54.google.com with SMTP id v24so1709352lfi.7
        for <bpf@vger.kernel.org>; Wed, 20 Nov 2019 23:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=sHDD4rZjcvAKSZL0sB2cnt1gkKhkiAqFUr7Nwb4duCU=;
        b=EhqskhIhN7Kzl9Py8useMCWBkBso6B1TCzeVFKsP5WNi6nmOUYWSwMMga9U8/jJe6S
         Y453aOvnz1bdrrcJkaz3jS7D6JUBlstWEP08pdNWlhRxbj80wTD5au28gdjwlePWFbiO
         uBBbm8yz5aa0DsMQWMWWTtDdL2d1N+lc7AVY5OnTm2da/XIPKsonvRbgf/BtpTw1aC2K
         HI4dxw5M1Ad4wUWyWMQWkchxi+DIJqrCG4r0Sk0SV+ZcFkQsjhVgfkxBG2U2207qulyn
         muL3C61G2Z92w+hztWVKvvjHohPiuCzE49FWGIXfdcQSlzC5yI1dUcI2fr3oNdfZk9Qc
         QtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sHDD4rZjcvAKSZL0sB2cnt1gkKhkiAqFUr7Nwb4duCU=;
        b=TwTkJ2GCAcI0yG1/iBZcXZEGytla0ko1u1u9uLGIYf2udEsYkp+fG1tHQvrXmenqgZ
         HR7JMB0PWtutpI3HbzzuRIX3e2pcKPmPyICvsmY2XDKTyMcnz8OJVUFWpZmWik3Lhi2U
         BarYGczxVaPNFLNGUSPEhTeWRsS+J62lepATbSfvXmzj0Q+xUsVFGpPNNcUHMfzLqdhB
         /Q0CSbeRu6P7YX85GZZkSBR/S2QmlMAYG4AUJcnJEoczxn4bbKTqL//8e/aSwPqwJk7g
         uMFhw4rc40P0PDY1SPuh6Bnx4YvV56RGHl+/yue/QF0qnlz3ZfjexSzM5qS5ubzEWeid
         HzXQ==
X-Gm-Message-State: APjAAAVmXM2OxiYJB6op5GmNOZ/YYZZKEeGA8J8BQWHpZ86ovnWaLvrA
        rnbKiRGKVH0hC4CsyyUz3aC2I3sMDG7zl09A3j4=
X-Google-Smtp-Source: APXvYqzO15NdwrAImDU0kPkTCMTNp1m28yKJvnMXpjrieVAEBgCcTNfArcccEmYTA7AqJCIA1aXEGkGkdtDhtlU0w0o=
X-Received: by 2002:a05:6512:511:: with SMTP id o17mr6238648lfb.167.1574320682120;
 Wed, 20 Nov 2019 23:18:02 -0800 (PST)
MIME-Version: 1.0
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 20 Nov 2019 23:17:50 -0800
Message-ID: <CAADnVQJ8NN3YV3Dws_V0gAiM21dH0=UDw6G=2O0OhYQ7Jj1CuA@mail.gmail.com>
Subject: test failures after merge
To:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

after bpf-next got merged into net-next new failures appeared:
./test_progs -n 5/1
test_core_reloc:FAIL:check_result output byte #0: EXP 0x01 GOT 0x01
Could you please take a look?
Thanks!
