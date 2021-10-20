Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D1243561D
	for <lists+bpf@lfdr.de>; Thu, 21 Oct 2021 00:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhJTWwX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 18:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhJTWwW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 18:52:22 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D5EC06161C
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 15:50:08 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id 2-20020aa79102000000b0044c216dd8ecso2610806pfh.18
        for <bpf@vger.kernel.org>; Wed, 20 Oct 2021 15:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OcgFrrYD37Wn+oCtjGIiFNqHOQIgGNIkkT6mluEZSUI=;
        b=Dbu9DCn91W3CuRQvfdNw+Gl6CZoi2li0KOs8NOxI3mvH/KofGOHYcnaVRH94hLVH7y
         Yj8S7gWTHPHoBr04QB27UbZGjLx48QiW7ovFEl60UryUnzyUvXJ0Z+dVM3KYhM/UMimA
         gAqkwttMu6RfePiusMQ8rh6DUmKe5XbQvyfZzM40I9xTl9HsjxKEX83FSDerCvvcJ3aV
         QqHuhZklkUdeiYIThG2oU9BpBXfx+plARncES2bs02TJ5GjsJ6d83QNbFCOip9Xyws2Y
         7Jytlgg2uiCx7jlcykQqb7WsRgsmRC2dsUyEUPaPFcNiw7H2eukURfjub2Cmvz5qqEjf
         fHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OcgFrrYD37Wn+oCtjGIiFNqHOQIgGNIkkT6mluEZSUI=;
        b=nfpFwPBpSt83zqQnaaNYTgegRH2YKY4zjbDpgWynI+SE2XC1DM/0NkxDmwdeYVIMXL
         /0Qx5TzLnWHDeFOzMXjD6WCsbb5x27slZRioVrtCv+HbDnI+1irQGll3bVQLIX5p60XS
         GjKrmtul/PwMl88NSdTGUV099OFA3GUfbDnejalCbkNAt+qzVsaNV3Kwuu4R336f0cbO
         e1Om4eVtaLmEx//d4fKMP3w7GVLVgr/2tC7N8kJkvRFl1Gd8Kp1zUQ/QkcuRw7mP9Vs4
         AaXsd6OAopXjnJLgSCHkXdPxFzw5EW9W1rovQhHOWWijVXkduRq37+/aH/wTcvFUEPxU
         OLCw==
X-Gm-Message-State: AOAM531HkMJv1GNnbMX54SPLEy3exbyvjQZMR4i/SG/9Cld2Ldo4PJ0v
        3g3ZkE+JU5pGDM03uErDsKnhlCY=
X-Google-Smtp-Source: ABdhPJzbNJ2hvEgX0+bNfa2nXNzYb50IQAFyhfFSmDJZcwmtxAC8M6c0ejmfO90Z+RlppX061RcodIk=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:dcf9:6f58:d879:8452])
 (user=sdf job=sendgmr) by 2002:a17:902:758b:b0:13e:8b1:e49f with SMTP id
 j11-20020a170902758b00b0013e08b1e49fmr1848732pll.6.1634770207600; Wed, 20 Oct
 2021 15:50:07 -0700 (PDT)
Date:   Wed, 20 Oct 2021 15:50:02 -0700
Message-Id: <20211020225005.2986729-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH bpf-next v3 0/3] libbpf: use func name when pinning programs
 with LIBBPF_STRICT_SEC_NAME
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 15669e1dcd75 ("selftests/bpf: Normalize all the rest SEC() uses")
broke flow dissector tests. With the strict section names, bpftool isn't
able to pin all programs of the objects (all section names are the
same now). To bring it back to life let's do the following:

- teach libbpf to pin by func name with LIBBPF_STRICT_SEC_NAME
- enable strict mode in bpftool (breaking cli change)
- fix custom flow_dissector loader to use strict mode
- fix flow_dissector tests to use new pin names (func vs sec)

v3:
- clarify program pinning in LIBBPF_STRICT_SEC_NAME,
  for real this time (Andrii Nakryiko)
- fix possible segfault in __bpf_program__pin_name (Andrii Nakryiko)

v2:
- add github issue (Andrii Nakryiko)
- remove sec_name from bpf_program.pin_name comment (Andrii Nakryiko)
- add cover letter (Andrii Nakryiko)

Stanislav Fomichev (3):
  libbpf: use func name when pinning programs with
    LIBBPF_STRICT_SEC_NAME
  bpftool: don't append / to the progtype
  selftests/bpf: fix flow dissector tests

 tools/bpf/bpftool/main.c                       |  4 ++++
 tools/bpf/bpftool/prog.c                       | 15 +--------------
 tools/lib/bpf/libbpf.c                         | 13 +++++++++++--
 tools/lib/bpf/libbpf_legacy.h                  |  3 +++
 .../selftests/bpf/flow_dissector_load.c        | 18 +++++++++++-------
 .../selftests/bpf/flow_dissector_load.h        | 10 ++--------
 .../selftests/bpf/test_flow_dissector.sh       | 10 +++++-----
 7 files changed, 37 insertions(+), 36 deletions(-)

-- 
2.33.0.1079.g6e70778dc9-goog

