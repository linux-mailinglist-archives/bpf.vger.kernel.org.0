Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E95826C6A3
	for <lists+bpf@lfdr.de>; Wed, 16 Sep 2020 19:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgIPR4v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Sep 2020 13:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbgIPRyS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Sep 2020 13:54:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A88C06174A
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 10:53:31 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z4so7853120wrr.4
        for <bpf@vger.kernel.org>; Wed, 16 Sep 2020 10:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eVZDtIYLLKpSADsOjK7RRLgddTAamvFeSVhId/1V2Gk=;
        b=Otyi0+6PHN8+a5kbjQ4eipTCbgWajd4H1TZ+KTnb7Zq6GoEp+tzs2cL2PKejysnmPn
         Y28a2i46BpprdSvfwhr8yJONCQSN9t1NzjTz/bighGL1kB4VNYramNcqsSWKdb4A+iKY
         nhisZofk1sXXG6mxgnGo9KtwJsrlMQuA0barg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eVZDtIYLLKpSADsOjK7RRLgddTAamvFeSVhId/1V2Gk=;
        b=qEE25x5EQpcgxb1BsagX53Axlx6llz0e9aGTXvMff2HSiNeJ4r5cEBMNwT0fnqw8U8
         rXTbhIWfYLtJ0Ha1remrUEta3Sxsaj+w/+WOywe+no4kGyBKSXFDOXRzjRKIdF645bNx
         3BCMuzg1jqmmSHC+DbmXK+bJRGIWtEqP2/bBUuECDPpGeU6Sz0d172oPZ1ze3uxiFY6O
         n4axk15y6pnaV+DI0EGLJR18siI8p5XTMyJlamvezXXCKaaK94IfXQYgyljaGtRhbT5v
         SrfkW1/CpdjmWSs8ai4YL2a9AD652cQuVCCpbYVch496GHYYf7nY10vU7QlntlDp0ru5
         mukg==
X-Gm-Message-State: AOAM530mxSqGiF09Rk8qqbSt3C2JsWuoarl1HHFRm0yoOO2cdOE+JKZg
        54G9In/CzCBWTz3Qm/sxSJcCcA==
X-Google-Smtp-Source: ABdhPJzceJWI37UQ6YYj8CBtZFCrnqgu9yyyO2+uu1+nCBDSzQu1VZ2O76ApbGOzU1sV37fU7O2dKA==
X-Received: by 2002:a5d:4448:: with SMTP id x8mr29883805wrr.207.1600278809813;
        Wed, 16 Sep 2020 10:53:29 -0700 (PDT)
Received: from antares.lan (5.c.5.5.a.2.f.6.a.a.d.6.3.1.9.1.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:1913:6daa:6f2a:55c5])
        by smtp.gmail.com with ESMTPSA id v17sm34177508wrr.60.2020.09.16.10.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 10:53:28 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v4 00/11] Make check_func_arg type checks table driven
Date:   Wed, 16 Sep 2020 18:52:44 +0100
Message-Id: <20200916175255.192040-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Changes in v4:
- Output the desired type on BTF ID mismatch (Martin)

Changes in v3:
- Fix BTF_ID_LIST_SINGLE if BTF is disabled (Martin)
- Drop incorrect arg_btf_id in bpf_sk_storage.c (Martin)
- Check for arg_btf_id in check_func_proto (Martin)
- Drop incorrect PTR_TO_BTF_ID from fullsock_types (Martin)
- Introduce btf_seq_file_ids in bpf_trace.c to reduce duplication

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

 include/linux/bpf.h            |  21 +-
 include/linux/btf_ids.h        |   8 +
 kernel/bpf/bpf_inode_storage.c |   8 +-
 kernel/bpf/btf.c               |  15 +-
 kernel/bpf/stackmap.c          |   5 +-
 kernel/bpf/verifier.c          | 338 ++++++++++++++++++---------------
 kernel/trace/bpf_trace.c       |  15 +-
 net/core/bpf_sk_storage.c      |   8 +-
 net/core/filter.c              |  31 +--
 net/ipv4/bpf_tcp_ca.c          |  19 +-
 tools/include/linux/btf_ids.h  |   8 +
 11 files changed, 239 insertions(+), 237 deletions(-)

-- 
2.25.1

