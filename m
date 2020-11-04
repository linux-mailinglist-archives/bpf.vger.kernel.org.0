Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12202A604F
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 10:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbgKDJKW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 04:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgKDJG0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Nov 2020 04:06:26 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347A8C040201
        for <bpf@vger.kernel.org>; Wed,  4 Nov 2020 01:06:25 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id w14so21151773wrs.9
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2020 01:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZVySsFYAxVyvKjZwFTKaFMnVATseHBsi4tJ0dIp9TLE=;
        b=K1+Rdz5ogf/5T2jMdF3v9m88jLY/gNqsMKJm061QdgaEQGjK4st39GT4kTZK6c7eAv
         3cJicgPoZBh9YEvxLFGZcZyHE0XnNqBy1XOiWQuoMPDL9faO4RhxQ9VP++HCtvthQR9S
         799P3oQD3ZEWTAn8Z+1PDWW2WOSIRjZ/YNizWauRHAov45YgSsQGFvDCGkpGdXI1KiOg
         QyMiZ+qAf84rNKlDHGrCMb3Z298LfBhK4STT2/MKrClXtDUj1+DxmNn50j9f2xT6h0lS
         2FLRla4Vx5B06Pb85+k62n0XQr8agXXsfRziu37OjAXEKgzSYzjV1kzmZ4S3HLfgeg3X
         jRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZVySsFYAxVyvKjZwFTKaFMnVATseHBsi4tJ0dIp9TLE=;
        b=hWZqLG6eh9LWp+3bnASkg3GR5ZDYkyUGE1qd/A5z7GZII1ym34EonwuKiwQcDLcPSO
         QE4AO42ooIpkvTYEg28f4oUnWMob+oWOuUUiGHuhZij4F5K5b2fiZCge0XdXD1bM6unX
         VulcbCUkxEP7/y6XTsov6CvSv5wGxCHW3ZToKcmL34kq8r/+Y1BtOTHvCqM4DloVXQYI
         6Pt24rDzjb9nwWbSMhFQP8KBTYqgbTRJXtNFBkIk3G1ltb8bcWgdVwOKPZEq3ScJWc3H
         vD43J7q1r/xarQgY9SijB8DTbJaDLmB794S0HNphmVCOkSGohhhnW7oA15LB4iL2Jlj0
         w3ww==
X-Gm-Message-State: AOAM531uj+j2xW64QB7R/D691KOBQ/qA4t5wchoYTFnzSs47noMA2QMW
        GDfOcJ/yS9P4gTGWwPtUK8AjOw==
X-Google-Smtp-Source: ABdhPJzn8d8Abh2QVS+FdXToKUqdpB6TwiMSAYlD5+ls0hMcq+h/pWmcBsJhdaEKInesWzdpNiQxsw==
X-Received: by 2002:adf:e384:: with SMTP id e4mr31089426wrm.227.1604480782887;
        Wed, 04 Nov 2020 01:06:22 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id e25sm1607823wrc.76.2020.11.04.01.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 01:06:22 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Dany Madden <drt@linux.ibm.com>,
        Daris A Nevil <dnevil@snmc.com>,
        Dustin McIntire <dustin@sensoria.com>,
        Erik Stahlman <erik@vt.edu>,
        Geoff Levand <geoff@infradead.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ishizaki Kou <kou.ishizaki@toshiba.co.jp>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Jens Osterkamp <Jens.Osterkamp@de.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Allen <jallen@linux.vnet.ibm.com>,
        John Fastabend <john.fastabend@gmail.com>,
        John Williams <john.williams@xilinx.com>,
        Juergen Gross <jgross@suse.com>,
        KP Singh <kpsingh@chromium.org>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Lijun Pan <ljp@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-usb@vger.kernel.org, Martin Habets <mhabets@solarflare.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        netdev@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
        Paul Durrant <paul@xen.org>, Paul Mackerras <paulus@samba.org>,
        Peter Cammaert <pc@denkart.be>,
        Russell King <rmk@arm.linux.org.uk>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Santiago Leon <santi_leon@yahoo.com>,
        Shannon Nelson <snelson@pensando.io>,
        Song Liu <songliubraving@fb.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Sukadev Bhattiprolu <sukadev@linux.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Utz Bacher <utz.bacher@de.ibm.com>,
        Wei Liu <wei.liu@kernel.org>,
        Woojung Huh <woojung.huh@microchip.com>,
        xen-devel@lists.xenproject.org, Yonghong Song <yhs@fb.com>
Subject: [PATCH 00/12] [Set 2] Rid W=1 warnings in Net
Date:   Wed,  4 Nov 2020 09:05:58 +0000
Message-Id: <20201104090610.1446616-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

This is the last set.

Lee Jones (12):
  net: usb: lan78xx: Remove lots of set but unused 'ret' variables
  net: ethernet: smsc: smc911x: Mark 'status' as __maybe_unused
  net: ethernet: xilinx: xilinx_emaclite: Document 'txqueue' even if it
    is unused
  net: ethernet: smsc: smc91x: Demote non-conformant kernel function
    header
  net: xen-netback: xenbus: Demote nonconformant kernel-doc headers
  net: ethernet: ti: am65-cpsw-qos: Demote non-conformant function
    header
  net: ethernet: ti: am65-cpts: Document am65_cpts_rx_enable()'s 'en'
    parameter
  net: xen-netfront: Demote non-kernel-doc headers to standard comment
    blocks
  net: ethernet: ibm: ibmvnic: Fix some kernel-doc misdemeanours
  net: ethernet: toshiba: ps3_gelic_net: Fix some kernel-doc
    misdemeanours
  net: ethernet: toshiba: spider_net: Document a whole bunch of function
    parameters
  net: ethernet: ibm: ibmvnic: Fix some kernel-doc issues

 drivers/net/ethernet/ibm/ibmvnic.c            |  27 ++-
 drivers/net/ethernet/smsc/smc911x.c           |   6 +-
 drivers/net/ethernet/smsc/smc91x.c            |   2 +-
 drivers/net/ethernet/ti/am65-cpsw-qos.c       |   2 +-
 drivers/net/ethernet/ti/am65-cpts.c           |   2 +-
 drivers/net/ethernet/toshiba/ps3_gelic_net.c  |   9 +-
 drivers/net/ethernet/toshiba/spider_net.c     |  18 +-
 drivers/net/ethernet/xilinx/xilinx_emaclite.c |   1 +
 drivers/net/usb/lan78xx.c                     | 212 +++++++++---------
 drivers/net/xen-netback/xenbus.c              |   4 +-
 drivers/net/xen-netfront.c                    |   6 +-
 11 files changed, 141 insertions(+), 148 deletions(-)

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Dany Madden <drt@linux.ibm.com>
Cc: Daris A Nevil <dnevil@snmc.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Dustin McIntire <dustin@sensoria.com>
Cc: Erik Stahlman <erik@vt.edu>
Cc: Geoff Levand <geoff@infradead.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Cc: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Allen <jallen@linux.vnet.ibm.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: John Williams <john.williams@xilinx.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: KP Singh <kpsingh@chromium.org>
Cc: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Lijun Pan <ljp@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-usb@vger.kernel.org
Cc: Martin Habets <mhabets@solarflare.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Cc: netdev@vger.kernel.org
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Paul Durrant <paul@xen.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Cammaert <pc@denkart.be>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Santiago Leon <santi_leon@yahoo.com>
Cc: Shannon Nelson <snelson@pensando.io>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.ibm.com>
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Cc: Utz Bacher <utz.bacher@de.ibm.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>
Cc: xen-devel@lists.xenproject.org
Cc: Yonghong Song <yhs@fb.com>
-- 
2.25.1

