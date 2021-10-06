Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C5F42376A
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 07:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhJFFNE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 01:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhJFFND (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 01:13:03 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCB3C061749
        for <bpf@vger.kernel.org>; Tue,  5 Oct 2021 22:11:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id on6so1258617pjb.5
        for <bpf@vger.kernel.org>; Tue, 05 Oct 2021 22:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4a16EFieGcN3Rxrx1Y//2vpykmLURRyPsMmWWglAq+I=;
        b=DGic4mi9S1aT2UO8FR1EjyUfwUiFh7nscxk6vy2aggtVL86t1a3Oxa679+yWiAUsP1
         N12Fd4NJMvM5iWQYUYGq9VCh/bD+biDQ90ETS72uRPVqQ5hgTx+0wB3uyZ8OP6iWZzB+
         GMqh5JJJsM8jdpauLzINSOin7LAMynpnPNLdjsHJOFVChTHKy8JV9QSK72j5ABOl0+gU
         39P7fYNabkggmAqs2ueoGkoy1L42wjGkbgsGo0ehfw5RYnyHECffiW2CUJPJRL+Yqg77
         Kls7AYjCuhbY6gln0/RlpXF70rb2Zo5PbZm7d5naZxosRPo8SuYQno6cuRTp/4HeKZ9l
         1JHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4a16EFieGcN3Rxrx1Y//2vpykmLURRyPsMmWWglAq+I=;
        b=Q6gGw6IRyFsVXzTu3NnrBbEOCHc6P99qyaFMWNbw6KQNR5ZJqRXtmhwDK7+PARCN0d
         yN0VYzfp5x4UGESZBgql6Z0Xlf0sO9oK5An6V1bmY8yqnOUuZKcpP+BWKF7S0EIsMP/G
         bNJly9O09lcA6p7yJygm0J/Q3HhLCyQS5KielDTw6bY2MGZvNagfZSlDv4nyNs1+BDZi
         HNPiohMnz+7K58kBaEFq5PLnijKfVyj7+BquisjYdFUAYnOl/CyNmpsnXG44IgqgjUWP
         O9SBheuJPIyu/TOEiVp3szfQxbqgcj0tUsGbfxTR/1AepG06GB7se5J0gA6rHYGd0nCL
         IO/w==
X-Gm-Message-State: AOAM530Wf5rCcp/QRuEXze5ueQBzyaecUXMj3WpJa299TNVShtjvJthn
        7fG+4JnoctRLYxaXTfFLV3nZjMQhNLJo1A==
X-Google-Smtp-Source: ABdhPJxTBHgKeYYybyF8F25XeICxuxRbdEXC/BwWkNIOUjGEyB2Vl9UnDgSikllvZfVKV+rIoBsLig==
X-Received: by 2002:a17:90b:1bcc:: with SMTP id oa12mr8478438pjb.212.1633497071563;
        Tue, 05 Oct 2021 22:11:11 -0700 (PDT)
Received: from andriin-mbp.thefacebook.com ([2620:10d:c090:400::5:b85c])
        by smtp.gmail.com with ESMTPSA id i2sm659687pjg.48.2021.10.05.22.11.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Oct 2021 22:11:11 -0700 (PDT)
From:   andrii.nakryiko@gmail.com
X-Google-Original-From: andrii@kernel.org
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v2 bpf-next 0/3] libbpf: add bulk BTF type copying API
Date:   Tue,  5 Oct 2021 22:11:04 -0700
Message-Id: <20211006051107.17921-1-andrii@kernel.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

Add bulk BTF type data copying API, btf__add_btf(), to libbpf. This API is
useful for tools that are manipulating BPF, such as pahole. They abstract away
the details of implementing a pretty mundane, but important to get right,
details of handling all possible BTF kinds, as well as, importantly, adjusting
BTF type IDs and copying/deduplicating strings and string offsets, referenced
from copied BTF types.

Also, being a batch API, it's possible to improve the efficiency by
preallocating necessary memory more efficiently.

This API is going to be used by pahole to implement efficient parallelized BTF
encoding.

v1->v2:
  - fix typo in doc comment and selftest clean up fix (Song).

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>

Andrii Nakryiko (3):
  libbpf: add API that copies all BTF types from one BTF object to
    another
  selftests/bpf: refactor btf_write selftest to reuse BTF generation
    logic
  selftests/bpf: test new btf__add_btf() API

 tools/lib/bpf/btf.c                           | 114 +++++++++++++-
 tools/lib/bpf/btf.h                           |  22 +++
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/btf_write.c      | 141 +++++++++++++++++-
 4 files changed, 270 insertions(+), 8 deletions(-)

-- 
2.30.2

