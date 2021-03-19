Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9F9341B76
	for <lists+bpf@lfdr.de>; Fri, 19 Mar 2021 12:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhCSL2J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Mar 2021 07:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhCSL15 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Mar 2021 07:27:57 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EDBC06174A
        for <bpf@vger.kernel.org>; Fri, 19 Mar 2021 04:27:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k128so2859816wmk.4
        for <bpf@vger.kernel.org>; Fri, 19 Mar 2021 04:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TOlvnyfNxwscsRV9gwN9ZMU5izCUjzblb5m1olq3kjA=;
        b=rnnwiUAR2iaNqdPxPqv7eilSH7y5yhgG4cMnBjQI40NvMcQJSPM8aJa6hOlnsW7zMv
         stJpxJH/HVXL8043bxmHg8+ZOsBBh0Bd5ksP42XkhLZAUxVvM36zRc3pYlQVBsARBZZl
         YMOwlu2wRMWkPk3Fnb4YMrr9V9a9roweYkN94nSAThbQc9SRhhwkeqM8ydW5fm+Ynmsb
         V4pKmtf3FfU9ykhoQOGEwRCRFSyKgihsy4Mymvm09TDv0uC3pQzs0Tyktt9PhyZokmrn
         KdqyaF3p2mKwCc7mbOS2iAtzVAqopi1c49L7i5iJ/lKmAMjXUB132rY4BktBYbZ8bCPY
         RZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TOlvnyfNxwscsRV9gwN9ZMU5izCUjzblb5m1olq3kjA=;
        b=JoM0v2Vy1zoHuGoRGOQVUlQoKLusYWgR8A0shDr6mTZftqJhzHS3U6V2BpCZyeVVnC
         KKXDqPZWNGNrszXba0Nw11/thqVcXQITLD67c87BF3Iq7q3js7xJS9rGch8LnNNT1Cdj
         3yE7fpW1o7Yby3acf0dcJNT9NLeVt/3t23IJWOnPOohaikCNHi6InrxkWiQGaF/5CsxI
         xrhQJC1x+FrCxeUHpT3vteOd+xGiiiqKo7TMw0GhfM6xAu8RwMhnUu4spsZ399Zgo7Cf
         IQxK8QKjc6cRa0igRC4lHzjk91fykL2jPH22K6x9txMxGHmWHzTvJ5RMId3OWlI4PynB
         /hgA==
X-Gm-Message-State: AOAM533uYWlr8AikdLCjFa2WTXyVObgvpQuF3b90ed0IXLsq2L3ycSFD
        wJfWm0xFohE89f/yyBD+aOWO0w==
X-Google-Smtp-Source: ABdhPJyh/WlAmxglzWDyQFOQidFfG81znVraJm06NJc9luVVUaSP7lEbh6gY99i4DdOzi/RI+ut4Ww==
X-Received: by 2002:a7b:c151:: with SMTP id z17mr3297262wmi.189.1616153275482;
        Fri, 19 Mar 2021 04:27:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id c2sm5969706wmr.22.2021.03.19.04.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:27:55 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf v2 0/2] libbpf: Fix BTF dump of pointer-to-array-of-struct
Date:   Fri, 19 Mar 2021 12:25:53 +0100
Message-Id: <20210319112554.794552-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix an issue with the libbpf BTF dump, see patch 1 for details.

Since [v1] I added the selftest in patch 2, though I couldn't figure out
a way to make it independent from the order in which debug info is
issued by the compiler.

[v1]: https://lore.kernel.org/bpf/20210318122700.396574-1-jean-philippe@linaro.org/

Jean-Philippe Brucker (2):
  libbpf: Fix BTF dump of pointer-to-array-of-struct
  selftests/bpf: Add selftest for pointer-to-array-of-struct BTF dump

 tools/lib/bpf/btf_dump.c                                  | 2 +-
 .../selftests/bpf/progs/btf_dump_test_case_syntax.c       | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.30.2

