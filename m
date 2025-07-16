Return-Path: <bpf+bounces-63451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E7BB07AE8
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 18:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D353BEC0C
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 16:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CE72F5336;
	Wed, 16 Jul 2025 16:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="d/XuzjrU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C3A19E97A
	for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752682666; cv=none; b=FaYbwPls6WBb4ALd7udppKPh4jwHaAZNITGa9pa8YYicaS+4a80LlCqKMv3tZg/4GpV9oBo8y71faETh58/YsmyxwIu6VG+v3qRgwN4AxFNG1HiHEvONILQpfpeYhWGYkHwwkHeFn4EluT/ySXyQ3dvZ3ewFSJmDdjQWJAnaHo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752682666; c=relaxed/simple;
	bh=1VJtPNGbROKVsideNfAgV8MORdQhSxjibgQBilQkHDk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=i1qjmRpEjv2NE9RM1j3yN429tZH0lpapzOOSfLIbuGulYGHOQ9p//0iuEMLXgmh4jMQe9r4ZudOzIQFoKanso958GI7CxDbdFrzCiGpLqG7DZHNMAsX+hToGBLE/OEcVXTqE0smiDxj71etVWbyTjShMbLOdllIIHCNdK1cJuGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=d/XuzjrU; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553ba7f11cbso61485e87.1
        for <bpf@vger.kernel.org>; Wed, 16 Jul 2025 09:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752682663; x=1753287463; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E8eSpfc8m1rvKi1VRzFG1ovfEWMP6uadxfpw/U197c8=;
        b=d/XuzjrUjtYjNDr/R5SUMYdinR3+6NKSek46NiEVboRoqi0wE/evPDsQ5V3/heMBSO
         MeJC/4b2J12lMuYxvinZ3qFSbAQmsRCygmSYW6T8mhJnlcPG2/4bP0239yxYuKblmVDj
         c1sKUmTDrgWg34efuHk95aWeyxjyRA1pc1Tx35hlSPuBdr/wjCmPiyA/56k8A2RrYnKJ
         RWGIHKpSnU5lPAKELSaXhCXX93JX0iCNIuBr9ENecMl0diuFeWmozbg2yyyPrQpgZWul
         vwftF9vA/Co7ICX/yFuA/Et6DdfuH/hCH2VcCZBitDGwxnt+Rwgm78g991vM6YUnE7Wv
         gL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752682663; x=1753287463;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8eSpfc8m1rvKi1VRzFG1ovfEWMP6uadxfpw/U197c8=;
        b=vBIoe1+BvOBbkrgLg5lkL+LFvLILtvUavTpXZ768nhPPT13wllkGkvRJOz1d1wFnOX
         AsFXqcTI7S3/x1JBqm1Hvni9y+a8ZIy1Mlp4Vzi7kZw+qwQBaFTcKog1wlsaCa9aZeAh
         LG81JEsSgPrLNQ9Y6jdJp3JOOalmvYymG3teSlxKjxZEC2nPzdXqNRd5E4utw8FPIs6Q
         EpG6V3EbNnaMmpdcv9M+IZmJNuQQbc01GkzubIVB4iKE6ejjMBybGvvvMDKgHuc3KnXa
         khu1DhS7/EovYY0lwHJPisIJX6cdL/4IHD/N67OWRGYYZmc7SzaukuuqmYZESmFlx4ef
         iTbw==
X-Gm-Message-State: AOJu0YyZc0GDin/8Dux9R//gRjjJ7RW5OA1xHhCn9GgvocP+YvNOoC4I
	p7EYPOmXbw/846CVSBt6EW8TL7klWNoLqFmBygW9XyDW8W23ksw6vsrW186RTSTf44g=
X-Gm-Gg: ASbGncsmURGp4mADvZPvtB1ng6MPuQkxv9VAOUTtH6B4O6JYH6uWOSMMWzvf+gyhlV2
	fgbTL69E97TPCvxR39rqZdJIzy8zH1w4OBCOil7Eo11dFlb3LJHKDAoxAwjJC7rTQORYSmkfOjn
	Hhwwqk6weEDsfwRtRnOMp8dPJEe2lb3HM+t+u5eWRMnjNcQs0VdvzfMIE9pL4ra1yBFBI0aEkkp
	Z98YtXJUogmUfVYNReUPwodiV7+j3jaF8GhQRsfvLvFJQKxK1znvSUNEzSuUhL1eBLnlTip8O5o
	LI5VV4ZYjI1woY3vOOICU/eaQMfE39zDcoU/CYnyAwGD0caIxiCDOPA4OfujkW0iRXrcDAlp/XW
	pm+7BjLDAZ6rG8DwL16FicM1wuRfzGYJAvwIsGMxHyQnSkHAp8+O8ZgWBwpO3s0x7edXY
X-Google-Smtp-Source: AGHT+IEKjY1Hp9qtD+vxAuSDxSReNN0P7lT6p0ozVKLkEwrm1T/eUykKgrDUAgi2dWoCxvk1GNU2Ow==
X-Received: by 2002:ac2:593a:0:b0:553:30fc:cedf with SMTP id 2adb3069b0e04-55a2339af22mr1139271e87.38.1752682662350;
        Wed, 16 Jul 2025 09:17:42 -0700 (PDT)
Received: from cloudflare.com (79.184.150.73.ipv4.supernova.orange.pl. [79.184.150.73])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55943b7139dsm2693881e87.196.2025.07.16.09.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 09:17:40 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH bpf-next v2 00/13] Add a dynptr type for skb metadata
Date: Wed, 16 Jul 2025 18:16:44 +0200
Message-Id: <20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAG3Qd2gC/3WNwQ6DIBAFf8XsudsAijY99T8aDwhLJbViAI3G+
 O8l9tzjZPLm7RApOIpwL3YItLjo/JhBXArQvRpfhM5kBsGEZDWvMb47/FBSRiWFqQ8zmm2cUsC
 qU7JpdGmYrCDPp0DWrWf6Cd1kcaQ1QZtN72LyYTs/F376X75k//MLR4aWN0bxshbS3B568LOxg
 wp01f4D7XEcX1bu9g7PAAAA
X-Change-ID: 20250616-skb-metadata-thru-dynptr-4ba577c3d054
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

TL;DR
-----

This is the first step in an effort which aims to enable skb metadata
access for all BPF programs which operate on an skb context.

By skb metadata we mean the custom metadata area which can be allocated
from an XDP program with the bpf_xdp_adjust_meta helper. Network stack code
accesses it using the skb_metadata_* helpers.

Changelog
---------

Changes in v2:
- Switch to a dedicated dynptr type for skb metadata (Andrii)
- Add verifier test coverage since we now touch its code
- Add missing test coverage for bpf_dynptr_adjust and access at an offset
- Link to v1: https://lore.kernel.org/r/20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com

Overview
--------

Today, the skb metadata is accessible only by the BPF TC ingress programs
through the __sk_buff->data_meta pointer. We propose a three step plan to
make skb metadata available to all other BPF programs which operate on skb
objects:

 1) Add a dynptr type for skb metadata (this patch set)

    This is a preparatory step, but it also stands on its own. Here we
    enable access to the skb metadata through a bpf_dynptr, the same way we
    can already access the skb payload today.

    As the the next step (2), we want to relocate the metadata as skb
    travels through the network stack in order to persist it. That will
    require a safe way to access the metadata area irrespective of its
    location.

    This is where the dynptr [1] comes into play. It solves exactly that
    problem. The dynptr to skb metadata can be backed by a memory area that
    resides in a different location depending on code path.

 2) Persist skb metadata past the TC hook (future)

    Having the metadata in front of the packet headers as the skb travels
    through the network stack is problematic - see the discussion of
    alternative approaches below. Hence, we plan to relocate it as
    necessary past the TC hook.

    Where to relocate it? We don't know yet. There are a couple of
    options: (i) move it to the top of skb headroom, or (ii) allocate
    dedicated memory for it.  They are not mutually exclusive. The right
    solution might be a mix.

    When to relocate it? That is also an open question. It could be done
    during device to protocol handover or lazily when headers get pushed or
    headroom gets resized.

 3) skb dynptr for sockops, sk_lookup, etc. (future)

    There are BPF program types don't operate on __sk_buff context, but
    they either have, or could have, access to the skb itself. As a final
    touch, we want to provide a way to create an skb metadata dynptr for
    these program types.

TIMTOWDI
--------

Alternative approaches which we considered:

* Keep the metadata always in front of skb->data

We think it is a bad idea for two reasons, outlined below. Nevertheless we
are open to it, if necessary.

 1) Performance concerns

    It would require the network stack to move the metadata on each header
    pull/push - see skb_reorder_vlan_header() for an example. While doable,
    there is an expected performance overhead.

 2) Potential for bugs

    In addition to updating skb_push/pull and pskp_expand_head, we would
    need to audit any code paths which operate on skb->data pointer
    directly without going through the helpers. This creates a "known
    unknown" risk.

* Design a new custom metadata area from scratch

We have tried that in Arthur's patch set [2]. One of the outcomes of the
discussion there was that we don't want to have two places to store custom
metadata. Hence the change of approach to make the existing custom metadata
area work.

-jkbs

PS. This series is not as long as it looks. I kept the more granular commit
split to "show the work". I can squash some together if needed.

[1] https://docs.ebpf.io/linux/concepts/dynptrs/
[2] https://lore.kernel.org/all/20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com/

---
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Arthur Fabre <arthur@arthurfabre.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Cc: Joanne Koong <joannelkoong@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Toke Høiland-Jørgensen <thoiland@redhat.com>
Cc: Yan Zhai <yan@cloudflare.com>
Cc: kernel-team@cloudflare.com
Cc: netdev@vger.kernel.org
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

---
Jakub Sitnicki (13):
      bpf: Add dynptr type for skb metadata
      bpf: Enable read access to skb metadata with bpf_dynptr_read
      bpf: Enable write access to skb metadata with bpf_dynptr_write
      bpf: Enable read-write access to skb metadata with dynptr slice
      net: Clear skb metadata on handover from device to protocol
      selftests/bpf: Cover verifier checks for skb_meta dynptr type
      selftests/bpf: Pass just bpf_map to xdp_context_test helper
      selftests/bpf: Parametrize test_xdp_context_tuntap
      selftests/bpf: Cover read access to skb metadata via dynptr
      selftests/bpf: Cover write access to skb metadata via dynptr
      selftests/bpf: Cover read/write to skb metadata at an offset
      selftests/bpf: Cover lack of access to skb metadata at ip layer
      selftests/bpf: Count successful bpf program runs

 include/linux/bpf.h                                |  14 +-
 include/linux/filter.h                             |  22 ++
 kernel/bpf/helpers.c                               |   7 +
 kernel/bpf/log.c                                   |   2 +
 kernel/bpf/verifier.c                              |  23 +-
 net/core/dev.c                                     |   1 +
 net/core/filter.c                                  |  66 +++++
 net/sched/bpf_qdisc.c                              |   1 +
 tools/testing/selftests/bpf/bpf_kfuncs.h           |   3 +
 tools/testing/selftests/bpf/prog_tests/dynptr.c    |   3 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 201 +++++++++++---
 tools/testing/selftests/bpf/progs/dynptr_fail.c    | 297 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/dynptr_success.c |  62 +++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 244 ++++++++++++++++-
 tools/testing/selftests/bpf/test_progs.h           |   1 +
 15 files changed, 891 insertions(+), 56 deletions(-)


