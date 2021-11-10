Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30E044C044
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 12:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhKJLtY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 06:49:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhKJLtY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Nov 2021 06:49:24 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F9AC061764
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 03:46:36 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d3so3488866wrh.8
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 03:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kjHd0Kr0ymQ3a10ENDIboaCgm2YTIHCHTF3U6cm7HUg=;
        b=smrMgPz/PdOvuy4BKoFdtbXDyOFYkAfUEbCjFH8yI/4ulUYkKidxaDqNe6F2Mm3ap4
         92bn8RGNDbepC8kqKFdGM1ehzQvTP8NHpl+cjvsKZ4+ewYbVQTz5pqlqChe1Qt3gv5zP
         1Jbt2/+vd72sTXheXp/cGlg6XGtMmtGn7KjZVeWz2RH+XS7G0D0XhFoOSl8Yi4v7Y15J
         azs0fLS1SC455Tc3OjU4tGTB6LKGVJFTl7ETuBEONoNo8O0T+Agk8228fblewZuAMYdw
         f4zcKJ+MRJ3jwhUrvo4s+Un5/0Swo6tHn5nSTvMLYljdGysc7DqRNJrFFF7tz20muV8N
         MmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kjHd0Kr0ymQ3a10ENDIboaCgm2YTIHCHTF3U6cm7HUg=;
        b=51BT3ydodb8CGpIZsolEI0gIt3Wxhh5hzEekzXC8WtFBn31yTm4r3eVjCriLX1KXXu
         PihxgNLrUGCWVmwYXwZItiDK9dFOw8ZxHX0IfK6Z+eVzk/0h/LXPONEO7e2jITta+QSu
         PSEqbNNP4z+A1RZf29+tkHldFOjvs86HAEXuUBRDkMc8regXyou944WFe9III8vWF1Fw
         +FUkQ4tYkCioDlQ/IiCG5xXelP1GEcTg836nDM8/igV7TE+GuGApYDX5SZf2sLgL7ULt
         08kMcoFDXD2miZXxXcg12XdkUXvjvPLuQkAkPUMRiP1xvMXppyJeAM4AnkCD0bwGoPFz
         eSDQ==
X-Gm-Message-State: AOAM532hgsGjm6Vd1pn/L9SJvwROBHczVIE0rRs7u5QjmM8EzCQjQPCR
        2t5O+rom+KJUtX3kbhkTgClfsESnOdFpMQ==
X-Google-Smtp-Source: ABdhPJy3MBxnYrFBRaaBIYguino2d8UdpUPEN6l1WISYeWXrbpo1Z2s8FmxmZtMpVhfc7/eojE76kg==
X-Received: by 2002:a05:6000:1201:: with SMTP id e1mr18403404wrx.298.1636544795181;
        Wed, 10 Nov 2021 03:46:35 -0800 (PST)
Received: from localhost.localdomain ([149.86.79.190])
        by smtp.gmail.com with ESMTPSA id i15sm6241152wmq.18.2021.11.10.03.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 03:46:34 -0800 (PST)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 0/6] bpftool: miscellaneous fixes
Date:   Wed, 10 Nov 2021 11:46:26 +0000
Message-Id: <20211110114632.24537-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set contains several independent minor fixes for bpftool, its
Makefile, and its documentation. Please refer to individual commits for
details.

Quentin Monnet (6):
  bpftool: Fix memory leak in prog_dump()
  bpftool: Remove inclusion of utilities.mak from Makefiles
  bpftool: Use $(OUTPUT) and not $(O) for VMLINUX_BTF_PATHS in Makefile
  bpftool: Fix indent in option lists in the documentation
  bpftool: Update the lists of names for maps and prog-attach types
  bpftool: Fix mixed indentation in documentation

 tools/bpf/bpftool/Documentation/Makefile      |  1 -
 .../bpf/bpftool/Documentation/bpftool-btf.rst |  2 +-
 .../bpftool/Documentation/bpftool-cgroup.rst  | 12 ++--
 .../bpf/bpftool/Documentation/bpftool-gen.rst |  2 +-
 .../bpftool/Documentation/bpftool-link.rst    |  2 +-
 .../bpf/bpftool/Documentation/bpftool-map.rst |  8 +--
 .../bpf/bpftool/Documentation/bpftool-net.rst | 62 +++++++++----------
 .../bpftool/Documentation/bpftool-prog.rst    |  8 +--
 tools/bpf/bpftool/Documentation/bpftool.rst   |  6 +-
 tools/bpf/bpftool/Makefile                    |  3 +-
 tools/bpf/bpftool/bash-completion/bpftool     |  3 +-
 tools/bpf/bpftool/common.c                    |  1 +
 tools/bpf/bpftool/map.c                       |  3 +-
 tools/bpf/bpftool/prog.c                      | 15 +++--
 14 files changed, 66 insertions(+), 62 deletions(-)

-- 
2.32.0

