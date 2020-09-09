Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E972633E2
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 19:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbgIIRMC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 13:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbgIIRMB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 13:12:01 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4E1C061573
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 10:12:00 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id m6so3820273wrn.0
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 10:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+XkicBoWVoBwbnPi36grnpDy7gmoB4y9RalPVI9W9Tw=;
        b=t/FKsga7y07OhQZW0GakeV2PGpypT6bKR2VP40c1p/P4blnK/NUAPTyOASZa8Ia++/
         53CuzClmKZ5b4b61zEeHrkhFW5BZO4wf9jjYeiNFc5SHu6IqwVngnCBeOwwNL6BTd1dG
         HKAV/jUDER3p9OyMqeaGuRK8QMG/MaLxWGVbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+XkicBoWVoBwbnPi36grnpDy7gmoB4y9RalPVI9W9Tw=;
        b=H12SPqAlxRC1NeQMIslZKjqhy/uQlpaVRFqmybJulcObKvafVTU9YZKbTKcZQ/g2RY
         k7keD4/wazaCofPYueizLZHGf4/PbfHKB0OnVfK5l6dR5V0Xn2i25RmZMVMnr7A0+SXo
         gDG03794s2jypVj//kD4IpyTjlDdCWgh6qXzLjLbNu4MTQrUQDeejZrsWNMAoRrZF3Db
         yZvhn4UW01NYZhn4lsWg/DQ2r7UCaOh1lwPzjFDumsvLi8mDb29UWexZp5qeHpInV9su
         5cXtkBd+eDDhBfe5j1tgiR/r+u1Rz9fU2zlYdqP5xoI38ATk7tWRLHTeVtN71QmaBgIL
         O2Hg==
X-Gm-Message-State: AOAM5328S5aSnlPJpOg6p//e9bVpLEjD7ipmIYcms0DgJZDuLSVmxi43
        pkYMds6AcWRRxEWaub8Dm2JB5A==
X-Google-Smtp-Source: ABdhPJw17zom4vnHIoD2vaQqkF+7AvloMjntuUQdtXLGEyCTuN/p0HsLm1we74XqjO3ytvQ+q6bKsQ==
X-Received: by 2002:a5d:684b:: with SMTP id o11mr5122833wrw.101.1599671519509;
        Wed, 09 Sep 2020 10:11:59 -0700 (PDT)
Received: from antares.lan (1.3.0.0.8.d.4.4.b.b.8.a.1.4.5.e.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:e541:a8bb:44d8:31])
        by smtp.gmail.com with ESMTPSA id g131sm3746743wmf.25.2020.09.09.10.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 10:11:58 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v2 00/11] Make check_func_arg type checks table driven
Date:   Wed,  9 Sep 2020 18:11:44 +0100
Message-Id: <20200909171155.256601-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks for all the valuable feedback! The series now doesn't depend
on sockmap iterator anymore. All of this is refactoring, no
functional changes are intended.

Once this + sockmap iter are merged I'll submit a series that
introduces ARG_PTR_TO_SOCK_COMMON_OR_NULL which aliases with
a BTF struct sock_common*. This in turn will allow me to call
map_update_elem(sockmap) from bpf_iter context.

Changes in v2:
- Make the series stand alone (Martin)
- Drop incorrect BTF_SET_START fix (Andrii)
- Only support a single BTF ID per argument (Martin)
- Introduce BTF_ID_LIST_SINGLE macro (Andrii)
- Skip check_ctx_reg iff register is NULL
- Change output of check_reg_type slightly, to avoid touching tests

Original cover letter:

Currently, check_func_arg has this pretty gnarly if statement that
compares the valid arg_type with the actualy reg_type. Sprinkled
in-between are checks for register_is_null, to short circuit these
tests if we're dealing with a nullable arg_type. There is also some
code for later bounds / access checking hidden away in there.

This series of patches refactors the function into something like this:

   if (reg_is_null && arg_type_is_nullable)
     skip type checking

   do type checking, including BTF validation

   do bounds / access checking

The type checking is now table driven, which makes it easy to extend
the acceptable types. Maybe more importantly, using a table makes it
easy to provide more helpful verifier output (see the last patch).

Lorenz Bauer (11):
  btf: make btf_set_contains take a const pointer
  bpf: check scalar or invalid register in check_helper_mem_access
  btf: Add BTF_ID_LIST_SINGLE macro
  bpf: allow specifying a BTF ID per argument in function protos
  bpf: make BTF pointer type checking generic
  bpf: make reference tracking generic
  bpf: make context access check generic
  bpf: set meta->raw_mode for pointers close to use
  bpf: check ARG_PTR_TO_SPINLOCK register type in check_func_arg
  bpf: hoist type checking for nullable arg types
  bpf: use a table to drive helper arg type checks

 include/linux/bpf.h            |  21 ++-
 include/linux/btf_ids.h        |   7 +
 kernel/bpf/bpf_inode_storage.c |   8 +-
 kernel/bpf/btf.c               |  15 +-
 kernel/bpf/stackmap.c          |   5 +-
 kernel/bpf/verifier.c          | 332 ++++++++++++++++++---------------
 kernel/trace/bpf_trace.c       |  15 +-
 net/core/bpf_sk_storage.c      |  10 +-
 net/core/filter.c              |  31 +--
 net/ipv4/bpf_tcp_ca.c          |  19 +-
 10 files changed, 227 insertions(+), 236 deletions(-)

-- 
2.25.1

