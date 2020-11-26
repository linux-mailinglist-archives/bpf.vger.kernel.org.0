Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951922C55E4
	for <lists+bpf@lfdr.de>; Thu, 26 Nov 2020 14:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390316AbgKZNjB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Nov 2020 08:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390297AbgKZNjA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Nov 2020 08:39:00 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86746C061A04
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 05:38:58 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a3so2433577wmb.5
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2020 05:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eLYy9GrW221tE7bgw0J/86UTqSktvqRhGJxBlLeC3CQ=;
        b=l8uEDUWZzvTPhQEmHkZEDzGn+Iktals9WkH8ixtmNOmOetN+vKndogKyVo59zGXYLz
         XRXvLUk5/+I04WWy7FCL0sLq4G94vw7QdXKfevLaySsnixEVKYZjC38zOVHNwqTkRYLN
         La8EC6Kxt6FBWP9D25iK6dlCY0QSnmFPjI0JmdW+T/tdAWhzrLYaOiJHbt1NLSwEkhEx
         Y5DRG1yTcLpH7SVmPZVFWQDYEG3aMUf+bQ4cF2ARtkMOy6ywbUIdkC/0GkwZWXKV+ZrI
         GJxdb71yq3kNI4ucwGOAP83wwCKHEcGCH1dgmfnG+q6ylSw4bmYBixyYObvyjE2aYJuI
         JqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eLYy9GrW221tE7bgw0J/86UTqSktvqRhGJxBlLeC3CQ=;
        b=VfmQ+p4w87K1oYdQgLHcLFn09OiUuiN+feGOE02jlxY0PXgRJgG3SZuFb9Dr7a+kGW
         8KnX4mmKV2TCU25MCl/1YscRuW/cw0duxFAOBUdcpeW3UhUWkDtYFkpoVIVXbfnyMk73
         6PNAjs6wB3OaAMoM6MjEXNUhXhbnawjfbiwwG0uIMS1Y0rULJ4dOwyLs6CSypKXpslVk
         ztRlpqR3IZTwUCW+QUFVSzfO/JrQLCwR0fDW7fTnEvq6+dcc/mO5tT3PCa2FwBe5dGHc
         qLajBE5PlXlVWAKCuDUh3cRWttdcgD2vMNcU7R/sYQyV8pBGoYRYONBVnNmKQp3kvvq7
         oECw==
X-Gm-Message-State: AOAM532XvHJQSqPemDu8EFSrkLVneACfeUmBUN+m2qQLE7f41A65clbW
        rToNQKhJxPIYeIhKVIU1ZkcYAA==
X-Google-Smtp-Source: ABdhPJyX27kWdIdFacrNhU+B2wpKeoJmDR9OAO7qJiUZ6oA3MPy3XKvt03Krjrfl2kApfFtGjVazXw==
X-Received: by 2002:a1c:dc82:: with SMTP id t124mr3481528wmg.94.1606397937237;
        Thu, 26 Nov 2020 05:38:57 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id s133sm7035825wmf.38.2020.11.26.05.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:38:56 -0800 (PST)
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
Subject: [PATCH 0/8] Rid W=1 warnings in Net
Date:   Thu, 26 Nov 2020 13:38:45 +0000
Message-Id: <20201126133853.3213268-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Resending the stragglers.

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (8):
  net: ethernet: smsc: smc91x: Demote non-conformant kernel function
    header
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
  net: ethernet: ibm: ibmvnic: Fix some kernel-doc issues

 drivers/net/ethernet/ibm/ibmvnic.c           | 27 ++++++++++----------
 drivers/net/ethernet/smsc/smc91x.c           |  2 +-
 drivers/net/ethernet/ti/am65-cpsw-qos.c      |  2 +-
 drivers/net/ethernet/ti/am65-cpts.c          |  2 +-
 drivers/net/ethernet/toshiba/ps3_gelic_net.c |  9 ++++---
 drivers/net/ethernet/toshiba/spider_net.c    | 18 ++++++++-----
 drivers/net/xen-netback/xenbus.c             |  4 +--
 drivers/net/xen-netfront.c                   |  6 ++---
 8 files changed, 37 insertions(+), 33 deletions(-)

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

