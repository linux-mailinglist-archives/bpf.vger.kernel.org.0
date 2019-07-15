Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F40A6992C
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2019 18:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbfGOQkA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Jul 2019 12:40:00 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:46446 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729533AbfGOQkA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Jul 2019 12:40:00 -0400
Received: by mail-qk1-f201.google.com with SMTP id c79so14205478qkg.13
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2019 09:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zqi7JK7p7sEMZ3kNIQuShGNc5UyRefvzgKB5PI244CY=;
        b=Z8bZPuaErJntn61Lw1Rkrz7GD5/KD0g4S4lHgP9Zz7m/pSObW3j7eJI0UP8c7q7WiK
         Nj9HDE0gOuYtg31lo6no4UQWR9gdxueM/tSyUe9j09U/B0+adF2wx2Dalpx8wQJ6SBKA
         G14AeKI/gJMaYbVv/TRfaGmKla3JuZm3X37a3mJhqvfawS5vCdInuAapwVGYN17LgAjg
         bpKF9o7nZodL2shQuI+iuyqDnR6iw0Q20A3ZPPm37gv0gV83baWpEogqklIx1N0/BU9p
         YuSR95iJsx1mNo87jDwH2z+kDEJ5QdfEymeLr+FS6vTh/+IXZdr2Zf5JmXTllbxWM1xI
         6WZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zqi7JK7p7sEMZ3kNIQuShGNc5UyRefvzgKB5PI244CY=;
        b=Hmwi8eF8cIUuGFfzQKVY9qwQPNlGiRTyCyTVNEe5vRx7hdrKmX3b9HO4ToudvBVt2r
         3c6Hgzi6A/S5fQrdQmEfvbVOAySiPrrPAQFd5LBgceeklgT/zoIEmEQebvp9MS7SZoIj
         MN2ocK9A/Ly8Cig2gfSRxJbWkC6kcgAma+JZffAS0GoQsPn34I8fdRuuaqcwVgpvNre4
         v2tgapa2DkZGkokmOX3wHINasYFRO/GNmIly8IjSrEjNjgKiivv5CvsWf3KrML5WsYH/
         2a2eo6omGSDGHlve7+5dDIP83pmtrAFRK54Thvyh0ofiFF8/cOP6ry3j3U3cpIrqw8dV
         ryQw==
X-Gm-Message-State: APjAAAVicrIjzyw7RuB34426wCDYaJPJWaFOBUqMImudol4iAG8wsJvZ
        mdteNrI0DUTdSq+v3p5NabNxgAo=
X-Google-Smtp-Source: APXvYqy8Ka9hJf5QpKak7Yr1lb+BGgMRdy6z9twN1c/jCeNrcSC3n3bgOMBAcodIodPtLLN1abcBzM0=
X-Received: by 2002:ae9:eb16:: with SMTP id b22mr15266729qkg.160.1563208798802;
 Mon, 15 Jul 2019 09:39:58 -0700 (PDT)
Date:   Mon, 15 Jul 2019 09:39:51 -0700
Message-Id: <20190715163956.204061-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH bpf 0/5] bpf: allow wide (u64) aligned loads for some fields
 of bpf_sock_addr
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When fixing selftests by adding support for wide stores, Yonghong
reported that he had seen some examples where clang generates
single u64 loads for two adjacent u32s as well:
http://lore.kernel.org/netdev/a66c937f-94c0-eaf8-5b37-8587d66c0c62@fb.com

Let's support aligned u64 reads for some bpf_sock_addr fields
as well.

(This can probably wait for bpf-next, I'll defer to Younhong and the
maintainers.)

Cc: Yonghong Song <yhs@fb.com>

Stanislav Fomichev (5):
  bpf: rename bpf_ctx_wide_store_ok to bpf_ctx_wide_access_ok
  bpf: allow wide aligned loads for bpf_sock_addr user_ip6 and
    msg_src_ip6
  selftests/bpf: rename verifier/wide_store.c to verifier/wide_access.c
  selftests/bpf: add selftests for wide loads
  bpf: sync bpf.h to tools/

 include/linux/filter.h                        |  2 +-
 include/uapi/linux/bpf.h                      |  4 +-
 net/core/filter.c                             | 24 ++++--
 tools/include/uapi/linux/bpf.h                |  4 +-
 .../selftests/bpf/verifier/wide_access.c      | 73 +++++++++++++++++++
 .../selftests/bpf/verifier/wide_store.c       | 36 ---------
 6 files changed, 95 insertions(+), 48 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/verifier/wide_access.c
 delete mode 100644 tools/testing/selftests/bpf/verifier/wide_store.c

-- 
2.22.0.510.g264f2c817a-goog
