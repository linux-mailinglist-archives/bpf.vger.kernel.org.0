Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 383049755F
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2019 10:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfHUIw3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Aug 2019 04:52:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36024 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfHUIw2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Aug 2019 04:52:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so1284073wme.1
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2019 01:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Mh1QkTp/8kRIpEYY+6mzm9fBLUWPKfIMrbMeRlFQ5Vk=;
        b=dCuuw8qazVWlJrR5QGVGraJSUvizOCICo20mvjsZtxziMRpea2sPZ3lPOgrR1pl6iT
         FIiKElVsJsv4Mtn3mtGr8bR+nA9iAJvadPvjKrcuc5Bw6ImY5PAE2y8pg/Ez4oPVuKrp
         zrvFGzPrPBYIgCX/SnQyfHoxWdbFMCOEB5LOuA9RwLRFJJ39vuuQGRSHtT4R3/pdS7bk
         Ipb/eiqOM9RBoPAknsz/BdV2t18/uFiRa3OZdtBskR5fo5i212nIQKLkmg/OtPW+5aPZ
         iOMnB31ZQ26QHiqwBQMrSCQkudeibvjfb230A/RFbc56oLvegpf+jcWts6DrfB44WYtu
         9P5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mh1QkTp/8kRIpEYY+6mzm9fBLUWPKfIMrbMeRlFQ5Vk=;
        b=TcSCWOK5hu69qMiqu9xXP0+WyvSFJVRR3SOTO7uaTlXiHUmMD8B9Qtq+j0beFe8pgv
         9M5zH7gkECwsUOS7ZPytpa7gKQMKp5fq1g60JxW29wwFn8FCqGBXdp5xnOxhxppY6z7b
         Qr/eYs33ckpPYl467KhmkXyzVjpnZK/lMnS9mg/Fi1oYuMbnfNthH7vpHFZDgMBk9kSI
         QsXep7XNvMD4LhYhygCKMLTDpKzVwGJSpSGDxiox72amqe90AWN8OTLtfR4KOLSvyJxB
         9exC8ysPe9Pg539PgHTAPdppwnbU0SYSLfR22+Ax7UtXh8Frl8Iwf0EMpoo6ixd3k+Fg
         mgRA==
X-Gm-Message-State: APjAAAXkdn4vomNS3/Q/2MNocs+J2QGIDiGY8zd06tofCYpRl/nm2HTN
        5KewaQoDYiRPsdZoOR83sNAkww==
X-Google-Smtp-Source: APXvYqxOpEYX6XapHM3cLUdsfVg2aAOhgFYN/HV7FoUtDTjc2rhCPmJk4cuQMmxBS4vTJcNC0M/wgA==
X-Received: by 2002:a1c:61d4:: with SMTP id v203mr4914481wmb.164.1566377546397;
        Wed, 21 Aug 2019 01:52:26 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id p7sm2040165wmh.38.2019.08.21.01.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 01:52:25 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next 0/2] tools: bpftool: work with frozen maps
Date:   Wed, 21 Aug 2019 09:52:17 +0100
Message-Id: <20190821085219.30387-1-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
This is a simple set to add support for BPF map freezing to bpftool. First
patch makes bpftool indicate if a map is frozen when listing BPF maps.
Second patch adds a command to freeze a map loaded on the system.

Quentin Monnet (2):
  tools: bpftool: show frozen status for maps
  tools: bpftool: add "bpftool map freeze" subcommand

 .../bpf/bpftool/Documentation/bpftool-map.rst |  9 +++
 tools/bpf/bpftool/bash-completion/bpftool     |  4 +-
 tools/bpf/bpftool/map.c                       | 64 +++++++++++++++++--
 3 files changed, 71 insertions(+), 6 deletions(-)

-- 
2.17.1

