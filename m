Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D108E2F8649
	for <lists+bpf@lfdr.de>; Fri, 15 Jan 2021 21:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbhAOUJ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jan 2021 15:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbhAOUJ4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jan 2021 15:09:56 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6298C0613C1
        for <bpf@vger.kernel.org>; Fri, 15 Jan 2021 12:09:15 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m187so2217678wme.2
        for <bpf@vger.kernel.org>; Fri, 15 Jan 2021 12:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c+7DadD0dH9745VxT7RGgUcZc8wWMxigcxcfDKgHA0M=;
        b=NGmfFs6An4O5Z1bTOhZvumD/b4aFaBLo5GodZjrpzZAET9hm3fXvg9Nat+QCjYyvUd
         Cu51qhHS/zcfGaUQTdOBKgaBLX6K/BCwPlrksmeEtHwUoIUBY9nB42PNg0260erKlRlj
         2DUVbt/VkBrxXGJW9CIugFaL8RtaUt01KqIeKMDG289Vs46noZhkbpHesaP2CnwmRG2N
         iXVwbCu6GW+WxsV6056N191kIDEz/EmAxTeGZW8Zy7NCzdpFepH5NSB8fni7nBIYJ763
         fxfAEDkdKoVffdFqVIJMUAuFA2wHGu9xpBnfqJK/+at08FCDWczw/hm8ESWiPSMbuGdq
         zWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c+7DadD0dH9745VxT7RGgUcZc8wWMxigcxcfDKgHA0M=;
        b=rKGszRNOhyiv94r5SZs6jcIbCL4Wr1bREiu1mzPCPtm4CUM5bLl4InG+4jVy5gdV4i
         PWCHdg1d71EKaQf2cDf+taRl6Qh8S+VBpTeLEyVsY5B1Kq5Gi9723a26lIEEbqZRW/7C
         2x7c6EorLD2PlVODvU+wB4S55TXEBTBZiKnXLvqf3wFtuojzeeJJJukgg5fMAx7POMek
         F+BQtKr01R+fvU+ECdqoGPMdXOHCowohH0KvFOCWm3VyAaN6dsSu9riBkgyVi7Ydpu7L
         9okvGtuKdwP7Dxh5zDxH4NSkSG6AukXXwvQ8mm7sOBFwmVebh6XlSIivNF7rFeBG2SCc
         /LoQ==
X-Gm-Message-State: AOAM5300HZybpbmlj+3h/dc6tqJPublR5Er/NvjihcYxsw+Muzb2y/7H
        6SmBUakZLK8J7DetDz4ZuVhhvQ==
X-Google-Smtp-Source: ABdhPJzRbd30yjZefst2rKry0v+qGXIk906iFx/zco+XZMf5YM39ujaWaXx9Rhy6Yqec4ppN1urxlA==
X-Received: by 2002:a1c:a707:: with SMTP id q7mr10222048wme.15.1610741354435;
        Fri, 15 Jan 2021 12:09:14 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id d85sm9187863wmd.2.2021.01.15.12.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 12:09:13 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Dany Madden <drt@linux.ibm.com>,
        Daris A Nevil <dnevil@snmc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Erik Stahlman <erik@vt.edu>,
        Geoff Levand <geoff@infradead.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ishizaki Kou <kou.ishizaki@toshiba.co.jp>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jens Osterkamp <Jens.Osterkamp@de.ibm.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Allen <jallen@linux.vnet.ibm.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Lijun Pan <ljp@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>, netdev@vger.kernel.org,
        Nicolas Pitre <nico@fluxnic.net>, Paul Durrant <paul@xen.org>,
        Paul Mackerras <paulus@samba.org>,
        Peter Cammaert <pc@denkart.be>,
        Russell King <rmk@arm.linux.org.uk>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Santiago Leon <santi_leon@yahoo.com>,
        Sukadev Bhattiprolu <sukadev@linux.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Utz Bacher <utz.bacher@de.ibm.com>,
        Wei Liu <wei.liu@kernel.org>, xen-devel@lists.xenproject.org
Subject: [RESEND v2 0/7] Rid W=1 warnings in Ethernet
Date:   Fri, 15 Jan 2021 20:08:58 +0000
Message-Id: <20210115200905.3470941-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Resending the stragglers again.
This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.                                                                                         

No changes since v2, just a rebase onto net-next.

v2:                                                                                                             
 - Squashed IBM patches                                                                                     
 - Fixed real issue in SMSC
 - Added Andrew's Reviewed-by tags on remainder

Lee Jones (7):
  net: ethernet: smsc: smc91x: Fix function name in kernel-doc header
  net: xen-netback: xenbus: Demote nonconformant kernel-doc headers
  net: ethernet: ti: am65-cpsw-qos: Demote non-conformant function
    header
  net: ethernet: ti: am65-cpts: Document am65_cpts_rx_enable()'s 'en'
    parameter
  net: ethernet: ibm: ibmvnic: Fix some kernel-doc misdemeanours
  net: ethernet: toshiba: ps3_gelic_net: Fix some kernel-doc
    misdemeanours
  net: ethernet: toshiba: spider_net: Document a whole bunch of function
    parameters

 drivers/net/ethernet/ibm/ibmvnic.c           | 27 ++++++++++----------
 drivers/net/ethernet/smsc/smc91x.c           |  2 +-
 drivers/net/ethernet/ti/am65-cpsw-qos.c      |  2 +-
 drivers/net/ethernet/ti/am65-cpts.c          |  2 +-
 drivers/net/ethernet/toshiba/ps3_gelic_net.c |  8 +++---
 drivers/net/ethernet/toshiba/spider_net.c    | 18 ++++++++-----
 drivers/net/xen-netback/xenbus.c             |  4 +--
 drivers/net/xen-netfront.c                   |  6 ++---
 8 files changed, 37 insertions(+), 32 deletions(-)

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Dany Madden <drt@linux.ibm.com>
Cc: Daris A Nevil <dnevil@snmc.com>
Cc: "David S. Miller" <davem@davemloft.net>
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
Cc: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Lijun Pan <ljp@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: netdev@vger.kernel.org
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Paul Durrant <paul@xen.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Peter Cammaert <pc@denkart.be>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Santiago Leon <santi_leon@yahoo.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.ibm.com>
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Cc: Utz Bacher <utz.bacher@de.ibm.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: xen-devel@lists.xenproject.org
-- 
2.25.1

