Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE6DE338F
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2019 15:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502379AbfJXNLl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Oct 2019 09:11:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51120 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502245AbfJXNLk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Oct 2019 09:11:40 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5CD1781DE3
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2019 13:11:40 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id i23so1001360wmb.3
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2019 06:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=PAejp8l76RHaTyUKRg9ZexROX6ZjX1qWgzEtWv6KLrM=;
        b=VWy4MTFlOtqN4gyp2rhFBlgSnaTaWC6UNOhPZCXZOQSuCTmLWOztigYdXSHjDUpPID
         fEcEfAvZvhNrAUX/FtkAw45Za4Fwl5gRcNB6ivG2VsIXQtlqSsaZNY1dLoEF1JFfvicA
         z1v+6GrocQqF8wd5m41hc4qaZYeQNTMHqdeGeh9TNnx3MbAXuZeqDHdPrhi8X6E04Dqt
         tyw0+N+wXJs2uYaTJzxiLV51nOOymgC6q0F59/ni+Ea/gY+M+8k1CjUS0JBD686iEiwP
         HR19HiltdfXDcitiuerN7/mYnuDweoFqjr2sCXcd2Skc66Kyhr5lkSH7wDnRPjZeTEU2
         TMjw==
X-Gm-Message-State: APjAAAU78dJB6Udxx0TeST5pHwpKJ+k+qr958F0zBAMCPoLGKSte5CIq
        4bhOFyhH6jmxCNq39OLDP2LhSsRorTDB431B7lXBnNTpYEPq1vYWpr6L+vsTelIBcWuyUiBfZEd
        sBFRTxI0le4sN
X-Received: by 2002:adf:eed2:: with SMTP id a18mr4092795wrp.273.1571922699023;
        Thu, 24 Oct 2019 06:11:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwSUanx3+3wNzwpFqslVcnf4zuZ4ncS5JdP6tsKVmSoKAKNQua72qSZmzqmtr2k/j657uHL8g==
X-Received: by 2002:adf:eed2:: with SMTP id a18mr4092781wrp.273.1571922698793;
        Thu, 24 Oct 2019 06:11:38 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id m7sm27606536wrv.40.2019.10.24.06.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 06:11:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 86F121804B1; Thu, 24 Oct 2019 15:11:37 +0200 (CEST)
Subject: [PATCH bpf-next v2 0/4] libbpf: Support automatic pinning of maps
 using 'pinning' BTF attribute
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Thu, 24 Oct 2019 15:11:37 +0200
Message-ID: <157192269744.234778.11792009511322809519.stgit@toke.dk>
User-Agent: StGit/0.20
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series adds support to libbpf for reading 'pinning' settings from BTF-based
map definitions. It introduces a new bpf_object__pin_maps_opts() function which
accepts options with the new options struct definition style. This allows the
caller to configure the pinning path, and to use both old-style "forced pinning"
where all defined maps are pinned, and the new pinning that is based on the BTF
attribute.

The actual semantics of the pinning is similar to the iproute2 "PIN_GLOBAL"
setting, and the eventual goal is to move the iproute2 implementation to be
based on libbpf and the functions introduced in this series.

Changelog:

v2:
  - Drop patch that adds mounting of bpffs
  - Only support a single value of the pinning attribute
  - Add patch to fixup error handling in reuse_fd()
  - Implement the full automatic pinning and map reuse logic on load

---

Toke Høiland-Jørgensen (4):
      libbpf: Fix error handling in bpf_map__reuse_fd()
      libbpf: Store map pin path and status in struct bpf_map
      libbpf: Support configurable pinning of maps from BTF annotations
      libbpf: Add option to auto-pin maps when opening BPF object


 tools/lib/bpf/bpf_helpers.h |    6 +
 tools/lib/bpf/libbpf.c      |  379 +++++++++++++++++++++++++++++++++++++------
 tools/lib/bpf/libbpf.h      |   33 ++++
 tools/lib/bpf/libbpf.map    |    6 +
 4 files changed, 366 insertions(+), 58 deletions(-)

