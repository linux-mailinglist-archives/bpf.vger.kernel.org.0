Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D02025D74F
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 13:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbgIDLaT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 07:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbgIDL0C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 07:26:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75847C061232
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 04:24:13 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a9so5746108wmm.2
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 04:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xm0+KsSuHVMMfGfvo78IYgG2d3fw7Qi+hTvoHgXduiM=;
        b=uYPV/b6/d86Dnb/3WTgGeuUrrXOfQuvjrQjoL0zR/k9y48OnyxQexuKFqoSZicelMU
         EdmABLVFGHM6lusAoR9ejTQJgEmhYaz/NbJ7/bi7+aHmB/BbrbQelyY609iuh/FP+W7n
         ZwlJv5OIKIlmFAIRGaMQdyi3yvGsfi7uAET6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xm0+KsSuHVMMfGfvo78IYgG2d3fw7Qi+hTvoHgXduiM=;
        b=t0IfZmCt6n3X5qlzO8iQM2A5p9JD3jdxP7YTeoFBahA0WQdm6ISF0K5+A2O56/FSKz
         MV9L0tIMSFi4JqsZtrfyj+tSRgAgal9zyW1RvA6xHS3DQJ4h9blA8Qm7/ubfmeeghcrM
         OE2MzGSiMex0PXr2CTyJl52qk4VttG3+LuF0qmvJDsdeErN1+qf2Vnd0HRFti1zEVRsL
         fgifQRp9IVlLWVVHDmeHufWYmRQ14K9ejdvgGD78X2wRQwapmk+N/rz9HV0Ddjkf3oi7
         Uu0oFumfGI7r/INZC7rWE6JWKWeEB+X+Os+BD3L6JcEtReBO/iHxIh8HhQKqxa/Qrs04
         LPdg==
X-Gm-Message-State: AOAM532IrjtqRl7fDXPZ/DxXHEAXVuBGtVr4ghWUoZ1kvHNucKq7ETVM
        FLAYoRjhWpqzbqrr25LJ8z4NDA==
X-Google-Smtp-Source: ABdhPJxZOIHvF+7C+Ks1EMuf5uO63xrk6RJAqg9G5QDvbANb2fBtprSlGPE5vn57gMJVcJXeUmyoAw==
X-Received: by 2002:a1c:1fcc:: with SMTP id f195mr6841121wmf.127.1599218652137;
        Fri, 04 Sep 2020 04:24:12 -0700 (PDT)
Received: from antares.lan (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id v2sm9104408wrm.16.2020.09.04.04.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 04:24:11 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next 00/11] RFC: Make check_func_arg table driven
Date:   Fri,  4 Sep 2020 12:23:50 +0100
Message-Id: <20200904112401.667645-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is what happened when I got sidetracked from my work on sockmap
bpf_iter support [1]. For that I wanted to allow passing a BTF pointer
to functions expecting a PTR_TO_SOCKET. At first it wasn't at all
obvious to me how to add this to check_func_arg, so I started refactoring
the function bit by bit. This RFC series is the result of that.

Note: this series is based on top of sockmap iterator, hence the RFC status.

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

I realise there are quite a few patches here. The most interesting
ones are #5 where I introduce a btf_id_set for each helper arg,
#10 where I simplify the nullable type checking and finally #11
where I add the table of compatible types.

There are some more simplifications that we could do that could get
rid of resolve_map_arg_type, but the series is already too long.

Martin: you said that you're working on extending PTR_TO_SOCK_COMMON,
would this series help you with that?

1: https://lore.kernel.org/bpf/20200904095904.612390-1-lmb@cloudflare.com/T/#t

Lorenz Bauer (11):
  btf: Fix BTF_SET_START_GLOBAL macro
  btf: add a global set of valid BTF socket ids
  btf: make btf_set_contains take a const pointer
  bpf: check scalar or invalid register in check_helper_mem_access
  bpf: allow specifying a set of BTF IDs for helper arguments
  bpf: make reference tracking in check_func_arg generic
  bpf: always check access to PTR_TO_CTX regardless of arg_type
  bpf: set meta->raw_mode for pointers to memory closer to it's use
  bpf: check ARG_PTR_TO_SPINLOCK register type in check_func_arg
  bpf: hoist type checking for nullable arg types
  bpf: use a table to drive helper arg type checks

 include/linux/bpf.h            |  25 ++-
 include/linux/btf_ids.h        |   7 +-
 kernel/bpf/bpf_inode_storage.c |   8 +-
 kernel/bpf/btf.c               |  24 +--
 kernel/bpf/stackmap.c          |   5 +-
 kernel/bpf/verifier.c          | 355 ++++++++++++++++++---------------
 kernel/trace/bpf_trace.c       |  15 +-
 net/core/bpf_sk_storage.c      |  10 +-
 net/core/filter.c              |  38 ++--
 net/ipv4/bpf_tcp_ca.c          |  24 +--
 tools/include/linux/btf_ids.h  |   7 +-
 11 files changed, 269 insertions(+), 249 deletions(-)

-- 
2.25.1

