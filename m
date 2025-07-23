Return-Path: <bpf+bounces-64193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244F9B0F968
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 19:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F4616EDAE
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 17:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409AC1E5B63;
	Wed, 23 Jul 2025 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bQDMlSKp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FE922836C
	for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292213; cv=none; b=DBu877921/p2+hOVmOwSkvN9I4tTJACHCOzVl8zth7a+6X69ui+xESeOE2WfUZYf5RbP+LEfygoPn7n4s5ZvVsc+pqwAynom5FWflRAKSAhYINxygWIF6664BXHxDqGSlJD4nRPP1XBm2tB9yG450EjsYSLGpXbazSmQmZZOATA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292213; c=relaxed/simple;
	bh=BGm2ukabBejPap75JlSTwrFukpdyn3UUJRvuUCo/RHc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mM0lwsKaVt99KVqxsNL7Lz2Cy/bZIZe4bg+ri1X6mv1eXhTWF4VWd6EN3Z5mOydkPXTMwmvlQhv4sGOeT0sJFtdD166OB0wdLfumcLdNFxkYCf1lRQa3gNPtb6tZzUUAxMMuU5AoGkDF70PWqRZ09s1ygHZVDfUI2hF2FU4Tlis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bQDMlSKp; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0dad3a179so15018766b.1
        for <bpf@vger.kernel.org>; Wed, 23 Jul 2025 10:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753292210; x=1753897010; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3OrkDHN4Pu3640RJe+OMQQn8FEQX+p7+yP0jdnsqDiw=;
        b=bQDMlSKpIzBIqVQa/A+xTUOhPk+RyRHSDE05dYvk9iAHxUySGbEv5l3JKI/0wa+sSA
         7HkOG9LiwSPVBiGpvQqwtCiYuUPBxNNw5LB0eU1JL5/W5/pnrPDrqh8aTVzpOT6tftK0
         8bxAhXIPCCyBO46ZYkiluhZgW5k8Y2bMWGPAzzREq8/mfQR5STBnlWApJZP9Hh1mVsPc
         8ulPDt5skEfD5MKs8qePXHYMmjBzgTgBU8he+oPCidFakKkzwBhhACmSyHG5zxJjFD99
         k+hUNIhmuvpK17M0blSgWQHXc+2MaatKESQflB0V9XSJ66FTyHQQrNXAl5uFs6UsEawq
         a7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753292210; x=1753897010;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3OrkDHN4Pu3640RJe+OMQQn8FEQX+p7+yP0jdnsqDiw=;
        b=A48ELRul6XzGw+oAl5TTeUTZSqCGuBw7drmB4K3e8y/5yfwAu+1vTJsWv+0Vrgqcyf
         q25eoeZvVmcLZZ9v54OK3T5GDPfiq2AP1nSgCfs66PZPVdexMDbwvob1M3tzVGPf86qu
         u6XSHnHLpP5bEoMzDdKB3YEMSWMFnQrchbnKKYgo53rExiiMiu7oorPUpB18ESzyaulW
         odVVJljxbrZk4CC3oZOZsIrbxD7yyvfqxXPHz5lTsBW5ntvdHIr+w/Dm3Q2anzSC5qOw
         QuiXfe4uOXlI8fsinyh8NTOAElvOZyBFCnxv4rcu/Q4C+tlt9+aJKXDRS/wxlVWBMoBd
         qnAg==
X-Gm-Message-State: AOJu0YxNpDIc3iJYQvb0DpYXVH6vBtcm8kZHqM/GimGKHVIML085QcPg
	v/4GvmOBcbFlMt/NntJ+CDQQ3+Itxequ9/+iETMSHqSQKYxOW21y6+ZuwR6FkLoE6RA=
X-Gm-Gg: ASbGncv/z+zRnTyFkRZhpm1rDFOjs73Uv9VVnWUqJoL6qOx8WPRQXPV44Ta2sorV5hk
	HRpGtsA5bckOM9Bwch1wS1LYH11w0P7OWE8FlvH/Pa4z+GgLnCMC+a28KGdEvEXQxRptS88t3ua
	aZ2hwUmF+ZukiZ0F+LDx/4BcLvgFaIBQF3LauzwImHumDoDjYOlZoV4GN5Iizb8610HuYkhtDH3
	fPjpwNr20AJ7bN4xBQUc45SwKIAIQtFoZMYzoIaGeVW547gXPgfVQqGcW1UjujUx3TkybB9NigE
	yKPulAyKZnP2YPf9rq73UpYdyU/7VxL89jgXdpz0BqS/8ySSsxBA7/m/quvRdXnIxk4Phbf5lW1
	2Y770o0pwHsK+rjPHSTNju4AZagaPLi22lmiVCg9EjLOYkmPSq+oCKElvfR5lPIZAO+ylQF0=
X-Google-Smtp-Source: AGHT+IGdX1BtAcPU6NXapcTHJ4XJ3l3KZ7udHFpF/bYGsc+3o9bl8p1p/WT/ndlJtRRzjAI8J+Q4Uw==
X-Received: by 2002:a17:907:c26:b0:ae3:d5f2:393a with SMTP id a640c23a62f3a-af2f8d4c052mr339922066b.44.1753292209720;
        Wed, 23 Jul 2025 10:36:49 -0700 (PDT)
Received: from cloudflare.com (79.184.149.187.ipv4.supernova.orange.pl. [79.184.149.187])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca2ec42sm1080623766b.78.2025.07.23.10.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 10:36:49 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH bpf-next v4 0/8] Add a dynptr type for skb metadata for TC
 BPF
Date: Wed, 23 Jul 2025 19:36:45 +0200
Message-Id: <20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAK0dgWgC/33OywrCMBAF0F+RrB3Js1FX/oe4SJuJDWpbkjQo0
 n831IWCj+XlMufOnUQMHiPZLu4kYPbR910JcrkgTWu6I4K3JRNOuaIVqyCearhgMtYkA6kNI9h
 bN6QAsjZK60ZYqiQp50NA568zvSf14KDDayKH0rQ+pj7c5s3M5v7JC/qbzwwoOKatYaLiyq53z
 bkfrTubgKumv8xy5i9N/3s286Ipp9ZUSo3Muq+aeNM4+6OJouGG16iUkEzLD22apgdQDDdLawE
 AAA==
X-Change-ID: 20250616-skb-metadata-thru-dynptr-4ba577c3d054
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Eduard Zingerman <eddyz87@gmail.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

TL;DR
-----

This is the first step in an effort which aims to enable skb metadata
access for all BPF programs which operate on an skb context.

By skb metadata we mean the custom metadata area which can be allocated
from an XDP program with the bpf_xdp_adjust_meta helper [1]. Network stack
code accesses it using the skb_metadata_* helpers.

Changelog
---------
Changes in v4:
- Kill bpf_dynptr_from_skb_meta_rdonly. Not needed for now. (Marin)
- Add a test to cover passing OOB offsets to dynptr ops. (Eduard)
- Factor out bounds checks from bpf_dynptr_{read,write,slice}. (Eduard)
- Squash patches:
      bpf: Enable read access to skb metadata with bpf_dynptr_read
      bpf: Enable write access to skb metadata with bpf_dynptr_write
      bpf: Enable read-write access to skb metadata with dynptr slice
- Kept Eduard's Acks for v3 on unchanged patches.
- Link to v3: https://lore.kernel.org/r/20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com

Changes in v3:
- Add a kfunc set for skb metadata access. Limited to TC BPF. (Martin)
- Drop patches related to skb metadata access outside of TC BPF:
      net: Clear skb metadata on handover from device to protocol
      selftests/bpf: Cover lack of access to skb metadata at ip layer
      selftests/bpf: Count successful bpf program runs
- Link to v2: https://lore.kernel.org/r/20250716-skb-metadata-thru-dynptr-v2-0-5f580447e1df@cloudflare.com

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

    As the next step (2), we want to relocate the metadata as skb travels
    through the network stack in order to persist it. That will require a
    safe way to access the metadata area irrespective of its location.

    This is where the dynptr [2] comes into play. It solves exactly that
    problem. A dynptr to skb metadata can be backed by a memory area that
    resides in a different location depending on the code path.

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
    either have, or could have, access to the skb itself. As a final touch,
    we want to provide a way to create an skb metadata dynptr for these
    program types.

TIMTOWDI
--------

Alternative approaches which we considered:

* Keep the metadata always in front of skb->data

We think it is a bad idea for two reasons, outlined below. Nevertheless we
are open to it, if necessary.

 1) Performance concerns

    It would require the network stack to move the metadata on each header
    pull/push - see skb_reorder_vlan_header() [3] for an example. While
    doable, there is an expected performance overhead.

 2) Potential for bugs

    In addition to updating skb_push/pull and pskp_expand_head, we would
    need to audit any code paths which operate on skb->data pointer
    directly without going through the helpers. This creates a "known
    unknown" risk.

* Design a new custom metadata area from scratch

We have tried that in Arthur's patch set [4]. One of the outcomes of the
discussion there was that we don't want to have two places to store custom
metadata. Hence the change of approach to make the existing custom metadata
area work.

-jkbs

[1] https://docs.ebpf.io/linux/helper-function/bpf_xdp_adjust_meta/
[2] https://docs.ebpf.io/linux/concepts/dynptrs/
[3] https://elixir.bootlin.com/linux/v6.16-rc6/source/net/core/skbuff.c#L6211
[4] https://lore.kernel.org/all/20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com/

---
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Arthur Fabre <arthur@arthurfabre.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Cc: Joanne Koong <joannelkoong@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Toke Høiland-Jørgensen <thoiland@redhat.com>
Cc: Yan Zhai <yan@cloudflare.com>
Cc: kernel-team@cloudflare.com
Cc: netdev@vger.kernel.org
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

---
Jakub Sitnicki (8):
      bpf: Add dynptr type for skb metadata
      bpf: Enable read/write access to skb metadata through a dynptr
      selftests/bpf: Cover verifier checks for skb_meta dynptr type
      selftests/bpf: Pass just bpf_map to xdp_context_test helper
      selftests/bpf: Parametrize test_xdp_context_tuntap
      selftests/bpf: Cover read access to skb metadata via dynptr
      selftests/bpf: Cover write access to skb metadata via dynptr
      selftests/bpf: Cover read/write to skb metadata at an offset

 include/linux/bpf.h                                |   7 +-
 include/linux/filter.h                             |  18 ++
 kernel/bpf/helpers.c                               |   7 +
 kernel/bpf/log.c                                   |   2 +
 kernel/bpf/verifier.c                              |  12 +-
 net/core/filter.c                                  |  66 ++++++
 tools/testing/selftests/bpf/bpf_kfuncs.h           |   3 +
 tools/testing/selftests/bpf/prog_tests/dynptr.c    |   1 +
 .../bpf/prog_tests/xdp_context_test_run.c          |  97 ++++++--
 tools/testing/selftests/bpf/progs/dynptr_fail.c    | 258 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/dynptr_success.c |  22 ++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 228 ++++++++++++++++++
 12 files changed, 704 insertions(+), 17 deletions(-)


