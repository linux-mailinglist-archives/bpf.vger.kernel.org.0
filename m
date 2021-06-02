Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE13399115
	for <lists+bpf@lfdr.de>; Wed,  2 Jun 2021 19:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhFBRId convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 2 Jun 2021 13:08:33 -0400
Received: from 136-58-83-85.googlefiber.net ([136.58.83.85]:34372 "EHLO
        jpsamaroo.me" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S229625AbhFBRId (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Jun 2021 13:08:33 -0400
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jun 2021 13:08:32 EDT
Received: from localhost (unknown [192.168.1.1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by jpsamaroo.me (Postfix) with ESMTPSA id ACD695E03BB
        for <bpf@vger.kernel.org>; Wed,  2 Jun 2021 13:14:23 -0500 (CDT)
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
Subject: LLVM bug when storing unpacked struct?
From:   "Julian P Samaroo" <jpsamaroo@jpsamaroo.me>
To:     <bpf@vger.kernel.org>
Date:   Wed, 02 Jun 2021 11:57:02 -0500
Message-Id: <CBTAHNOALDNZ.3N7KFDP60ZTUH@ares>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is my first LKML email, so let me know if I'm doing something wrong! :)

I believe I've found a bug in LLVM's generation of BPF bytecode, and would like
to get advice on whether this is truly a bug before considering writing a
patch.

When storing an unpacked struct such as { i64, i32 } to the stack (as part of
writing a struct-typed map key), LLVM 11.0.1 generates BPF bytecode like the
following:

...
2: (b7) r1 = 2
3: (63) *(u32 *)(r10 -24) = r1
4: (b7) r1 = 4
5: (7b) *(u64 *)(r10 -32) = r1
...
8: (bf) r3 = r10
9: (07) r3 += -32
...
13: (85) call bpf_map_update_elem#2
invalid indirect read from stack off -32+12 size 16

The verifier understandably complains about this when verifying a call that
uses these stack slots, such as bpf_map_update_elem, because the associated map
definition has a key size of 16 bytes, not 12 bytes as this bytecode would
suggest. In my particular case that generated this code, my frontend doesn't
have the notion of packed structs, so I can't workaround this by making the
struct packed.

My belief is that for unpacked structs, LLVM should emit these stores as 64-bit
stores, which should be OK since the padding bytes are going to be zero (from
my limited understanding of LLVM structs). Does this seem like a reasonable
change to make? I'm also unable to test this on LLVM 12 (my language hasn't yet
updated to support that version), so this could have possibly already been
fixed; please let me know if so!

Julian
