Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2C125DF7F
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 18:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgIDQNj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 12:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727037AbgIDQNg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 12:13:36 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9A6C061246
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 09:13:34 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l9so6589889wme.3
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 09:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5XwKJJOulBS/JAQ5qjXcGoOA/EcC/1Cru3JfpZwCM8U=;
        b=B3kUqCvQoH9U1ob0b6+LpDyQVAUts8lGfQL5uJk6M4kWxxSqUmULquNpEUJ/bDEg4w
         woPVuoh7kefsdaZsiIXqgrLccCmjLkOzwGVuXVzw2qVPrkKztuWLSbwlLn40D9R+xbmc
         LOSrM3i+ok4MQZohzYtthpPW1EnH+davEwmrA0RXUvuhwaKRQcsZTYmx7sCk6xDEmSgk
         lMiE6gmaENa+ob7l8rMsfXjoQ78yVVs1M33SbOJt2KDijqAFAWPk5UVP7FRT8Bkwgk5e
         +h0fwjvgQbQHuJHqIKNTH0woAv5dWgrSJ5uj6EhqToHEL4ZWj430Memy8E6TAVmay60X
         KjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5XwKJJOulBS/JAQ5qjXcGoOA/EcC/1Cru3JfpZwCM8U=;
        b=e5i9AmM+oj8aNm/4ATCPMJIgCpKvZe5xUQmQ2TALm4T2i43jg9TXAnkkxy4sRSAlOE
         ztjvf9HwIGeNGRUaoauznjresMAaYMz+8FFr7FcvnXCQYSPXzC+146v4blc+5wP1C+s9
         WN7iyTnRt9/yV1OcdKKeagfWHUW6ovkANyLR4tICZkQiN1iJ7zq1UJEVeq2Ua1s7i19F
         dcjYZxfu/fZ4nyBj/6gvk1P6sygVCCfyC4WBj37o5a/elDjoeekfSyaR1v8TKlUjE2G7
         mhDs+WLMUn7UZtA+QMxOs/RnPiWPIMhn769pNnMA3gSunK/+pCZGeGomiNE2tBHzKgxD
         1LeA==
X-Gm-Message-State: AOAM533BLz3s3Q6ZsxR58T0TeAJF1dtBeKaGNUvvH095ETcxVFCuYN8j
        buOz+T0xGri2j6AgBCp+be+L5YbcHhMIY6yl
X-Google-Smtp-Source: ABdhPJynph/2MaDoBgxX8x5WrKlgpTKOTsczn63kHdmbh9hEfGNMNxjE9RFqSLDhDp9w92mBDQNnog==
X-Received: by 2002:a1c:7d55:: with SMTP id y82mr8399491wmc.100.1599236010376;
        Fri, 04 Sep 2020 09:13:30 -0700 (PDT)
Received: from localhost.localdomain ([194.35.117.134])
        by smtp.gmail.com with ESMTPSA id a83sm11909611wmh.48.2020.09.04.09.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 09:13:29 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Martynas Pumputis <m@lambda.lt>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 0/2] tools: bpftool: support creating and dumping outer maps
Date:   Fri,  4 Sep 2020 17:13:11 +0100
Message-Id: <20200904161313.29535-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series makes bpftool able to create and dump the content for outer
maps (maps of types array-of-maps and hash-of-maps). The modifications are
rather succinct: dumping works if we remove the related restriction in
bpftool's code, and creation is just a matter of passing the relevant
inner_map_fd, which we do through a new command-line keyword.

Quentin Monnet (2):
  tools: bpftool: dump outer maps content
  tools: bpftool: add "inner_map" to "bpftool map create" outer maps

 .../bpf/bpftool/Documentation/bpftool-map.rst | 10 +++-
 tools/bpf/bpftool/bash-completion/bpftool     | 22 +++++++-
 tools/bpf/bpftool/map.c                       | 52 ++++++++++++-------
 3 files changed, 62 insertions(+), 22 deletions(-)

-- 
2.25.1

