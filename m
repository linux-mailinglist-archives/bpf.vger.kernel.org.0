Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07AE8265456
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 23:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgIJVms (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 17:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730474AbgIJM5o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 08:57:44 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790CAC061573
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 05:57:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id k18so5684004wmj.5
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gG4XJdaS4DleTuGpwAXD1/JzFt1hqa3YSjLjeS4l0ZQ=;
        b=AUMWtDRIOEiUtB+DmmOkltmAlB/1ZM43sVWMTIMQNpxFjIVDeQZ0QFC8ZljJj2UjL2
         Fc40dxRUlDCnc269vDmHSSrr8Oz4XWgOWDZ5ZXj/6yLkx68R2awHTV8HLyJVqFv5Dzhe
         sSYuBoacY4Fiy5W/mkslsUJMN3cCSruHK7zZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gG4XJdaS4DleTuGpwAXD1/JzFt1hqa3YSjLjeS4l0ZQ=;
        b=E46+bbozfKQytKgRzLlT3UiJTUuDcM/8ylf8OijY+W1SQf7CB6L05DtmP3m3d6jWRF
         DexNvpHILlH3eFr5I0KrRuvb6vzOzf2/VHC8IBzxZfhN3cz180SFNe4eyczxVEqzRBln
         pfH2Db0k9EGQ8jkTgthqpRStQns5fMK9RPJB7jEhtOWd0DjpbwKIPOeqZc33yDgR7Dsh
         c6cLQjwvOGBphFI5elIspBKBQw8zSMyUkh2blCqK4ufOv/M4MQQpgqLDzcyDS2c8RR19
         HVXvJY8PvlzODAAswjl1ui8Ldu6osptq3mqv8+EQAdDbyt3qWxl4WQHc4AYi3dkFG4A9
         y3eg==
X-Gm-Message-State: AOAM532BogyxBgXKInenfJmkSnL7faX+f09DXbGskLwm90QCySkO+eSr
        IlTtUi64mdPVDlxHPzzxW7j2/XKDS8ixxw==
X-Google-Smtp-Source: ABdhPJziibVkNZECco5jjwnkzZ4wyN5zvqENNY6+Rl9Qlze4FmSayDpA9QELuRcxVr1g7OJvI5v5iw==
X-Received: by 2002:a7b:c753:: with SMTP id w19mr8199113wmk.157.1599742640020;
        Thu, 10 Sep 2020 05:57:20 -0700 (PDT)
Received: from antares.lan (6.9.9.0.0.d.a.3.9.b.d.2.8.1.d.7.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:7d18:2db9:3ad0:996])
        by smtp.gmail.com with ESMTPSA id v6sm8737400wrt.90.2020.09.10.05.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 05:57:19 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com,
        andriin@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next v3 00/11] Make check_func_arg type checks table driven
Date:   Thu, 10 Sep 2020 13:56:20 +0100
Message-Id: <20200910125631.225188-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Another round of review from Martin, thanks!

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

