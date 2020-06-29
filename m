Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA5D20DFF4
	for <lists+bpf@lfdr.de>; Mon, 29 Jun 2020 23:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbgF2UlX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Jun 2020 16:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730729AbgF2TOH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:07 -0400
Received: from sym2.noone.org (sym2.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573B8C0086E2
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 02:33:39 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 49wMk84CH1zvjc1; Mon, 29 Jun 2020 11:33:36 +0200 (CEST)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Wang YanQing <udknight@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, x86@kernel.org
Subject: [PATCH bpf-next 0/2] Factor common x86 JIT code
Date:   Mon, 29 Jun 2020 11:33:34 +0200
Message-Id: <20200629093336.20963-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Factor out code common for 32-bit and 64-bit x86 BPF JITs.

Tobias Klauser (2):
  bpf, x86: Factor common x86 JIT code
  bpf, x86: Factor out get_cond_jmp_opcode and use for 64bit x86

 MAINTAINERS                                   |   3 +-
 arch/x86/net/Makefile                         |   4 +-
 arch/x86/net/bpf_jit.h                        |  97 ++++++++++
 arch/x86/net/bpf_jit_comp32.c                 | 178 ++----------------
 .../net/{bpf_jit_comp.c => bpf_jit_comp64.c}  | 130 +------------
 arch/x86/net/bpf_jit_core.c                   |  76 ++++++++
 6 files changed, 194 insertions(+), 294 deletions(-)
 create mode 100644 arch/x86/net/bpf_jit.h
 rename arch/x86/net/{bpf_jit_comp.c => bpf_jit_comp64.c} (94%)
 create mode 100644 arch/x86/net/bpf_jit_core.c

-- 
2.27.0

