Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F34F221054
	for <lists+bpf@lfdr.de>; Thu, 16 May 2019 23:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbfEPVy1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 May 2019 17:54:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34199 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbfEPVy1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 May 2019 17:54:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id c13so2214749pgt.1
        for <bpf@vger.kernel.org>; Thu, 16 May 2019 14:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dV/b0Qwbf8GVpXLrVD68yCDd7N1yRx9xZr9MIrQ8ZV4=;
        b=LcKpG7Y/wnv0ZfplT8mAqT4rajsEPcoDUYSXZRpi3eIWNBIj0o5n93bgtdItB6yc98
         71RVKKS79lTfZzn6A0POzCXtE8TDW/arTU0CSXsIAU5PHs4SPnc1fYeTHcIp5estVMH0
         Ho5KdDJ308LGIddoX+bVmIBA0pdGLE8kBbt6OoAuvEgUTB+9hbAouar1L3sfCV5y1Xjh
         OTAjN6qYYp/hQ0KlgEFGAsDBjSbPjo8Evfzmj6OAuY+/tO9qXNtnl5rf1x8c+fXKVGcA
         L+T5OFVz/JgEOrYCkC53qzMKzi8LPpjxW5OtkU4gGYiugGQis0hUoEx4b7I/oCT/6upn
         rF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dV/b0Qwbf8GVpXLrVD68yCDd7N1yRx9xZr9MIrQ8ZV4=;
        b=NpzvlBXWCPNcCE08NU83VJNzIxn2OCG4BKViJAav8E8ZNNVFWt38wOdcoThcIs0BhD
         KJ9NUFehw3beOyuSeR1Sv5FiTuFyNtx9vSguil2/CAAUCgZ8X9N5ihgE7V/c6dDlSg17
         T4nj2xcjX3V+en5p+Xj12rJdby49Ng684tGCI8vU0lJt4w/JvqpofonQOvoxDGbuxipw
         6NagTJvzZiFFGkJ/tKAMqGKNiEyNKhoKbs6lB9aT9trelIMImA32YJvyv8/RpGO6fcSF
         a/xP1zZ8oZvdhdfhrv5bx4wMV4sD977nPKkSuEuiyT9rOE3HQ3nPUD1dL+R6fxvqm+mZ
         drEg==
X-Gm-Message-State: APjAAAWXOdOZOpywhVKWLyh4HaCNabTv4hZdKvdnXtv1nw7RG+tDibrW
        xlbpA/4MgOpR+jdTalYcQmNGOA==
X-Google-Smtp-Source: APXvYqzNml/yINEOj+EkVBYAxZnhih8cosJmtNOBH9Q8dr/XrqjHhUGwQnj4/KLTT3m8ExIjT0XyVQ==
X-Received: by 2002:a62:470e:: with SMTP id u14mr57232563pfa.31.1558043666345;
        Thu, 16 May 2019 14:54:26 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id d15sm19842506pfm.186.2019.05.16.14.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 14:54:25 -0700 (PDT)
From:   Stephen Hemminger <stephen@networkplumber.org>
X-Google-Original-From: Stephen Hemminger <sthemmin@microsoft.com>
To:     netdev@vger.kernel.org, davem@davemloft.net
Cc:     xdp-newbies@vger.kernel.org, bpf@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH net 0/3] XDP generic related fixes
Date:   Thu, 16 May 2019 14:54:20 -0700
Message-Id: <20190516215423.14185-1-sthemmin@microsoft.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set of patches came about while investigating XDP
generic on Azure. The split brain nature of the accelerated
networking exposed issues with the stack device model.

The real fix is in the second patch which is a redo
of earlier patch from Jason Wang.

Stephen Hemminger (3):
  netvsc: unshare skb in VF rx handler
  net: core: generic XDP support for stacked device
  netdevice: clarify meaning of rx_handler_result

 drivers/net/hyperv/netvsc_drv.c |  6 ++++++
 include/linux/netdevice.h       | 16 ++++++++--------
 net/core/dev.c                  | 10 ++++++++++
 3 files changed, 24 insertions(+), 8 deletions(-)

-- 
2.20.1
