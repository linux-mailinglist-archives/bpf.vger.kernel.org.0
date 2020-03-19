Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5056C18B4DE
	for <lists+bpf@lfdr.de>; Thu, 19 Mar 2020 14:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgCSNNW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Mar 2020 09:13:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:55031 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729141AbgCSNNT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Mar 2020 09:13:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584623599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/JXninvH+RdnStJw90/1R2Gh04fLw+7yo4mXtcZuoRo=;
        b=WCoSg3bpcwZHYXYMCLpY67PGKFKpKyjBxNkLF9p+dXH4A7b77XtyT6tHgLMsNJpbyZvdHJ
        m/bmxbslLpJwNj9OhaOoZMFmlC1dATmySnpHpROLuD/+JL3pkUvglNiP5jaDeMOI73h8MA
        2m/M//vgswGPpunc/cW1R9Roy9+Bp/Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-jiWaIOLOPk2HYjgIXVRpQA-1; Thu, 19 Mar 2020 09:13:14 -0400
X-MC-Unique: jiWaIOLOPk2HYjgIXVRpQA-1
Received: by mail-wm1-f72.google.com with SMTP id 20so981209wmk.1
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2020 06:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=/JXninvH+RdnStJw90/1R2Gh04fLw+7yo4mXtcZuoRo=;
        b=I+6TK4kkU2IfJYH/LSRxtnis/kzSJNNc9vdMTi/60G36CDK2Jn9hXCjY/PfncI/Xdd
         d8JhuwRI59kEh6VXMaIFzLvbf1wqMn7okPoG7+O7feeTxGGEiNHK656rR4QIvqiS2zj1
         fzljXcMZN9qNydrEUjJ2nIWsn8tuo8DbOmFVXj30x3H2zFMpd7bESycDpo1g1NAHPa1R
         1tI5BGSvM7qrMr+27S3ls9lSGNJmgdwqVnOp7KBlAt24gtUUNpQma7mt9AoNZ2+G3kn0
         6Jnj4PpCtPkFDVc4rxYC2sEkqg4lbc3LngUHkIVNFwa9d4istrOs04vQYvb9VNz6sEFz
         JpzA==
X-Gm-Message-State: ANhLgQ2XYubW99g8qYbQyvHC12+uFPGqrMAi1SioX4swnHcowL//dHs2
        wnTXZY6SKF7uTwOf7rpi6SrcBJRFn+CzBQdPwCb+OzmIIiptkfw9D6d7O5iHwT2Z8jehPl0Hlai
        tVkFGigso19MH
X-Received: by 2002:a05:6000:10c6:: with SMTP id b6mr4195808wrx.130.1584623593595;
        Thu, 19 Mar 2020 06:13:13 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsHs7Csf5zw3jTuAfcePVNSFZzN1H/mq5k3NBtrL03r2aaKDqaLsbrQPFLeKHjc4oDSFFTKfg==
X-Received: by 2002:a05:6000:10c6:: with SMTP id b6mr4195781wrx.130.1584623593428;
        Thu, 19 Mar 2020 06:13:13 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id r3sm3588487wrw.76.2020.03.19.06.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 06:13:12 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 24A9C180371; Thu, 19 Mar 2020 14:13:12 +0100 (CET)
Subject: [PATCH bpf-next 0/4] XDP: Support atomic replacement of XDP interface
 attachments
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Andrey Ignatov <rdna@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Thu, 19 Mar 2020 14:13:12 +0100
Message-ID: <158462359206.164779.15902346296781033076.stgit@toke.dk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series adds support for atomically replacing the XDP program loaded on an
interface. This is achieved by means of a new netlink attribute that can specify
the expected previous program to replace on the interface. If set, the kernel
will compare this "expected fd" attribute with the program currently loaded on
the interface, and reject the operation if it does not match.

With this primitive, userspace applications can avoid stepping on each other's
toes when simultaneously updating the loaded XDP program.

---

Toke Høiland-Jørgensen (4):
      xdp: Support specifying expected existing program when attaching XDP
      tools: Add EXPECTED_FD-related definitions in if_link.h
      libbpf: Add function to set link XDP fd while specifying old fd
      selftests/bpf: Add tests for attaching XDP programs


 include/linux/netdevice.h                          |  2 +-
 include/uapi/linux/if_link.h                       |  4 +-
 net/core/dev.c                                     | 25 ++++++++--
 net/core/rtnetlink.c                               | 11 +++++
 tools/include/uapi/linux/if_link.h                 |  4 +-
 tools/lib/bpf/libbpf.h                             |  2 +
 tools/lib/bpf/libbpf.map                           |  1 +
 tools/lib/bpf/netlink.c                            | 22 ++++++++-
 .../testing/selftests/bpf/prog_tests/xdp_attach.c  | 55 ++++++++++++++++++++++
 9 files changed, 117 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/xdp_attach.c

