Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F02686D07
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 18:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjBARbN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 12:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbjBARav (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 12:30:51 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0D97D287;
        Wed,  1 Feb 2023 09:30:22 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id g7so1886401qto.11;
        Wed, 01 Feb 2023 09:30:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DcdaAefeXwbBbBzc2pDkWla3pIt9NRsXAraujgnF9fc=;
        b=ChZaPXcMgr0EpzX7chCBiQZdFfhh7Lics0hxhuH7mQVjJgdUxIcLPxJSb5cAYiEaDO
         ciI0lk9wU3uZ491jkgwEazo3dw6bT34IReLrBO1ELNN/cuACDsymTrz3bWAXV9dQPoUm
         oTdnIbrd4MirugzfmLf1fFwWLGgxS3aoKMKbocuedZkhujMrlmT1rQbV/KlaiZ+5E/AY
         cpRd06HVbqiKzmmRqM/lL2aaeVAvpr6oklxJwgWXq+4x5F6J+ey+LbKvU0C9vhM4UMEG
         GFh78y70qh8EobYqmufeYs76EUNbyXdNcJy44pPnXJzVR9+rv7UO6i4jHfNssnk7GKLH
         skkA==
X-Gm-Message-State: AO0yUKUO5GgdbJ5M+64I3gX0CI2md7ys5K7r+lQOeYdFn/eyqBFjTw9e
        qfHJ/QzH/yflcbz2sEB7Zd6gZKBwk2zpxeez
X-Google-Smtp-Source: AK7set+VqfsQuoay9QwgadI7iOhd2rcEec7RTkCwz5zAefOg9FNdxDP8mQoHG6s3kGvVIsmf8F+luQ==
X-Received: by 2002:ac8:580a:0:b0:3b9:b2ba:9b3f with SMTP id g10-20020ac8580a000000b003b9b2ba9b3fmr5679174qtg.52.1675272620899;
        Wed, 01 Feb 2023 09:30:20 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:1971])
        by smtp.gmail.com with ESMTPSA id z77-20020a376550000000b00706c1f7a608sm6809701qkb.89.2023.02.01.09.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 09:30:20 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@meta.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, corbet@lwn.net, hch@infradead.org,
        acme@kernel.org, alan.maguire@oracle.com
Subject: [PATCH bpf-next v3 0/4] bpf: Add __bpf_kfunc tag for kfunc definitions
Date:   Wed,  1 Feb 2023 11:30:12 -0600
Message-Id: <20230201173016.342758-1-void@manifault.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is v3 of the patchset [0]. v2 can be found at [1].

[0]: https://lore.kernel.org/bpf/Y7kCsjBZ%2FFrsWW%2Fe@maniforge.lan/T/
[1]: https://lore.kernel.org/lkml/20230123171506.71995-1-void@manifault.com/

Changelog:
----------
v2 -> v3:
- Go back to the __bpf_kfunc approach from v1. The BPF_KFUNC macro
  received pushback as it didn't match the more typical EXPORT_SYMBOL*
  APIs used elsewhere in the kernel. It's the longer term plan, but for
  now we're proposing something less controversial to fix kfuncs and BTF
  encoding.
- Add __bpf_kfunc macro to newly added cpumask kfuncs.
- Add __bpf_kfunc macro to newly added XDP metadata kfuncs, which were
  failing to be BTF encoded in the thread in [2].
- Update patch description(s) to reference the discussions in [2].
- Add a selftest that validates that a static kfunc with unused args is
  properly BTF encoded and can be invoked.

[2]: https://lore.kernel.org/all/fe5d42d1-faad-d05e-99ad-1c2c04776950@oracle.com/

v1 -> v2:
- Wrap entire function signature in BPF_KFUNC macro instead of using
  __bpf_kfunc tag (Kumar)
- Update all kfunc definitions to use this macro.
- Update kfuncs.rst documentation to describe and illustrate the macro.
- Also clean up a few small parts of kfuncs.rst, e.g. some grammar, and
  in general making it a bit tighter.

David Vernet (4):
  bpf: Add __bpf_kfunc tag for marking kernel functions as kfuncs
  bpf: Document usage of the new __bpf_kfunc macro
  bpf: Add __bpf_kfunc tag to all kfuncs
  selftests/bpf: Add testcase for static kfunc

 Documentation/bpf/kfuncs.rst                  | 20 +++++-
 Documentation/conf.py                         |  3 +
 include/linux/btf.h                           |  8 +++
 kernel/bpf/cpumask.c                          | 60 +++++++++---------
 kernel/bpf/helpers.c                          | 38 ++++++------
 kernel/cgroup/rstat.c                         |  4 +-
 kernel/kexec_core.c                           |  3 +-
 kernel/trace/bpf_trace.c                      |  8 +--
 net/bpf/test_run.c                            | 61 +++++++++++--------
 net/core/xdp.c                                |  5 +-
 net/ipv4/tcp_bbr.c                            | 16 ++---
 net/ipv4/tcp_cong.c                           | 10 +--
 net/ipv4/tcp_cubic.c                          | 12 ++--
 net/ipv4/tcp_dctcp.c                          | 12 ++--
 net/netfilter/nf_conntrack_bpf.c              | 20 +++---
 net/netfilter/nf_nat_bpf.c                    |  6 +-
 net/xfrm/xfrm_interface_bpf.c                 |  7 +--
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  2 +-
 .../selftests/bpf/prog_tests/kfunc_call.c     |  1 +
 .../selftests/bpf/progs/kfunc_call_test.c     | 11 ++++
 20 files changed, 176 insertions(+), 131 deletions(-)

-- 
2.39.0

