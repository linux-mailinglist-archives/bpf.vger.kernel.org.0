Return-Path: <bpf+bounces-46482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2229EA713
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 05:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68335169130
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 04:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132622248AF;
	Tue, 10 Dec 2024 04:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEC7XksG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C33F41C6C
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 04:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733803875; cv=none; b=mn6E/80RDmXe5qJ8BQhtO28Mdh7pWQ9yHhEHelzqfrTTxWEfqYMhlcmsgRTh4jMCcB+fG7/NZIYHiFp9OAAm9pxEAWzCoIwteoM6BtTIac40S1SH8xttHS/lH9qO5kq654czT5otJpdWY5QlsdPzGK14+3leBE1Q46AoJBU+GHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733803875; c=relaxed/simple;
	bh=gavOXAYOXp/lMaST0Z3A+OZ9Dgubzi16F483fiqLP7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tIvDCQwR+nLnTlWuhNvnLjEvUKLEDJ44BgtcCkRPDvgKoJxIu67fOEbJMxm160XSA+mnZUfQHxpCbmgZezkb9HhpPLiR34LpA/1nlasAhqpKIjM9Ic5wMM9Dzo/4gtFJ+xiB7OfucIOiwvAxd0yr9BBu4WjncYBnGimCWoYoE8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEC7XksG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2166022c5caso11539815ad.2
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 20:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733803873; x=1734408673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WVRdn8ymwDb86lYpiMqdT79OxWskdPc6YoMqevy8Q5c=;
        b=eEC7XksGpS5dmUzGi1ikZP1kmdSvBXmtss0/vxY0G13/eK87xsfHkjBL2qc7tp32Ls
         zIPY7j6hNuOwl5lB+zjOZIa8JTEfobWFyrj88YxQayCW8IPbx89Uxh1ein9OwVy5/dmn
         Kk9jauAt33tblni2xuGh6dm9A8OoxA0pBMHDEo/uU4k+Pk8x2VVlR0dm2wF7FdIiPxjm
         dcwZ3y0bc6Vz+jCf5bGnttmaCzcsDO8llJLEabJInettItpIolcTO3wYeHRAGLEUNl6T
         jLPu1Waz80FafVkvEjuwF25aDr7iTh8DxUfuybnZLnOn63PxqA6V30+uIJiXlgnfv8Ac
         5kug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733803873; x=1734408673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVRdn8ymwDb86lYpiMqdT79OxWskdPc6YoMqevy8Q5c=;
        b=GlzEiKt0MDzyDdNTkdd4sQZpIDJ5s8AuwHNlhONuqdFeGTOSymV9c3fm1GiJFEvwFj
         t/XHcF2dHiSJtFeDJ1hW0eTFiGq0lPnxT4jsBkgBNpdzJSLail3SqFEPg5Q6ANngL+Ux
         1ZpB6QzfyhetaFG3AMOXuNn01UEQMz/0e602If+GMlgX3KaSV2+neGQkDXbGQot6X47o
         XbgIfSWxnNHh5Kwgz0wpq9RBj6A6Ll1P2UAHhSN982bMVG8wy5rwP7CUZA7WkokcndnH
         GqrwUOgWT6YugiTpcz4fVCLKyh2khIjNtFfUdpfXBkWm/kn95STnZHyW8aJKTgdtW1qo
         ePMg==
X-Gm-Message-State: AOJu0Ywz+rE87scrwqEeb4umPTDU7zQtrr4EBgdGRYUh8wwsaXXg+zPZ
	3fJTtmqjDj8C6XQV5phwTGyUVKTDr4YAi13ueSfpoET7enAL13gzlutcjw==
X-Gm-Gg: ASbGncsK3Ofid7zVRc9dFcyt9M8Oit+l7WxmOzm+80cjqs8ZbFN7tyB0SPl4dFBoHIX
	2tUWDirnjdc9428gy9vM2PmtBygMR1sLGgqxP3+iNz2u5ezkPnQVj1s4HbK3W7iQr3Om7uEuiwd
	7GBBMs3gmf6eAMiXiD0XQBhNeH9+b5oVqGuhVlZ9bd4gPQgr8jKrXu0BgY3yFwm9RPsemFtsvq1
	/8ONHr5p0o5j3+mauILDSUKZ5it4ViDgKA3nnGUGFvmz3gu/g==
X-Google-Smtp-Source: AGHT+IFoTLxa1SAdKK8utMX3yqDP0hR8lfNXsNwRO6+BVn9A0sx8pNbjdj9EzqUJoy8Kv5eQpyLVDw==
X-Received: by 2002:a17:902:ced2:b0:216:4972:f8e0 with SMTP id d9443c01a7336-2164973002fmr81020995ad.44.1733803873159;
        Mon, 09 Dec 2024 20:11:13 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21631d6b3b8sm44296265ad.136.2024.12.09.20.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 20:11:12 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	mejedi@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf v2 0/8] bpf: track changes_pkt_data property for global functions
Date: Mon,  9 Dec 2024 20:10:52 -0800
Message-ID: <20241210041100.1898468-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nick Zavaritsky reported [0] a bug in verifier, where the following
unsafe program is not rejected:

    __attribute__((__noinline__))
    long skb_pull_data(struct __sk_buff *sk, __u32 len)
    {
        return bpf_skb_pull_data(sk, len);
    }

    SEC("tc")
    int test_invalidate_checks(struct __sk_buff *sk)
    {
        int *p = (void *)(long)sk->data;
        if ((void *)(p + 1) > (void *)(long)sk->data_end) return TCX_DROP;
        skb_pull_data(sk, 0);
        /* not safe, p is invalid after bpf_skb_pull_data call */
        *p = 42;
        return TCX_PASS;
    }

This happens because verifier does not track package invalidation
effect of global sub-programs.

This patch-set fixes the issue by modifying check_cfg() to compute
whether or not each sub-program calls (directly or indirectly)
helper invalidating packet pointers.

As global functions could be replaced with extension programs,
a new field 'changes_pkt_data' is added to struct bpf_prog_aux.
Verifier only allows replacing functions that do not change packet
data with functions that do not change packet data.

In case if there is a need to a have a global function that does not
change packet data, but allow replacing it with function that does,
the recommendation is to add a noop call to a helper, e.g.:
- for skb do 'bpf_skb_change_proto(skb, 0, 0)';
- for xdp do 'bpf_xdp_adjust_meta(xdp, 0)'.

Functions also can do tail calls. Effects of the tail call cannot be
analyzed before-hand, thus verifier assumes that tail calls always
change packet data.

Changes v1 [1] -> v2:
- added handling of extension programs and tail calls
  (thanks, Alexei, for all the input).

[0] https://lore.kernel.org/bpf/0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com/
[1] https://lore.kernel.org/bpf/20241206040307.568065-1-eddyz87@gmail.com/

Eduard Zingerman (8):
  bpf: add find_containing_subprog() utility function
  bpf: refactor bpf_helper_changes_pkt_data to use helper number
  bpf: track changes_pkt_data property for global functions
  selftests/bpf: test for changing packet data from global functions
  bpf: check changes_pkt_data property for extension programs
  selftests/bpf: freplace tests for tracking of changes_packet_data
  bpf: consider that tail calls invalidate packet pointers
  selftests/bpf: validate that tail call invalidates packet pointers

 include/linux/bpf.h                           |  1 +
 include/linux/bpf_verifier.h                  |  1 +
 include/linux/filter.h                        |  2 +-
 kernel/bpf/core.c                             |  2 +-
 kernel/bpf/verifier.c                         | 78 ++++++++++++++++---
 net/core/filter.c                             | 65 +++++++---------
 .../bpf/prog_tests/changes_pkt_data.c         | 76 ++++++++++++++++++
 .../selftests/bpf/progs/changes_pkt_data.c    | 26 +++++++
 .../bpf/progs/changes_pkt_data_freplace.c     | 18 +++++
 .../testing/selftests/bpf/progs/tc_bpf2bpf.c  |  2 +
 .../selftests/bpf/progs/verifier_sock.c       | 56 +++++++++++++
 11 files changed, 280 insertions(+), 47 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/changes_pkt_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/changes_pkt_data.c
 create mode 100644 tools/testing/selftests/bpf/progs/changes_pkt_data_freplace.c

-- 
2.47.0


