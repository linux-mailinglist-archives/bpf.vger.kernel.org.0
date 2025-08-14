Return-Path: <bpf+bounces-65621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A725DB261BE
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 12:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7579E69A5
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 09:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206B72F746B;
	Thu, 14 Aug 2025 09:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="O66COCqx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C882F60AE
	for <bpf@vger.kernel.org>; Thu, 14 Aug 2025 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165589; cv=none; b=f1WewZ95GuWUJJ97ai2x8ymhgZscH1oLlotgEhI74+MklT8rOUc3zrqOW2dBVzayS8//mFdQ8M5s49KoWjAr2416Fn0OZg/yQqtfX5URhjS4bqT95GIwRwvk3dEZobqVIY2fu5c8zWFSrOIFVGDHkqs2D1jZjCVcSkWdE9Qihhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165589; c=relaxed/simple;
	bh=9HOgiH5pJkJhAvZ0/FLD1f5y7V2iwD/GAx0voBqi0Gk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dvBJFa6zASb+8/S2LHEEz+IPcPuNMhdHk1BRTZPma5BItu3B6sX0J1QIbM88RbVO2n2pFbByLMchUBdUGyRm85L5naZ1Dv3NlOyjRbGMQlCFBD4QZVaZJJ9gRyCv7Xm+NFnQC3ypsSRMiLgI+RCXAZaTRWQkPkfiH0FMnrWZel4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=O66COCqx; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6188b794743so1270589a12.3
        for <bpf@vger.kernel.org>; Thu, 14 Aug 2025 02:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755165586; x=1755770386; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=314PM31sHN6MajJUuSWcL1nsLquUAPC0wj8JGYel1qs=;
        b=O66COCqxd+cd0URc2VG0aLVnwaR4FsAaaRrLVqKFrLrMtSwZNTxrdzUaCTNSz4e7My
         l4u7fFXCgOyUbFKOPK7yP9HoQ0zSTtDbIPcRsfjB2bnSdFazHNl+2wCVUMS/cfmtGHzM
         XI/ZOp9Q8V8fv1lBMtHcwBXMHmBf6wAh7J+3HfH4W06bNiYiwust/kYT+IrVUd2i9o3G
         cqBNloLVrtTeRzPgrLIPyMp38gjINd8fMoewlOMM+YOCyp7E7PX4dbSKeVLpLLal6rYn
         1eVJIvrW0SwlQk2jedvklFrQe3H1wzKzrXr6TmiSb/lojAWAdjGHHbHp7XnwGlxrCyCu
         namA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755165586; x=1755770386;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=314PM31sHN6MajJUuSWcL1nsLquUAPC0wj8JGYel1qs=;
        b=B6YELfvWgvxbeenjgQK2Us9VI+AlHSWqo7n3YttwtBZu2prEaE9T/UqgTErmNUAWZX
         Ozoy6Z5o91XdJAZ4v4DV/oExEt7Zr6vgOEkyaQ5+WDyT5pISuMCpgc56QEtKRMMkcBLC
         tq+YACBg6ClZmIFa35xo4K8DVRFkWA12lkKIvaIpRgvlk5lOsT/qNVmm4IuvIcsV7qjj
         JfvWLMQEw+fgIbfvoXUXwIqqa7svTL3AGcRHmO9ial9KjR/TbFDzqkp3PhevdNxSKAd0
         n/NDvRGE6wsU9U4YiZ7yxW5cFiR0Lsh/wFdWbJAYP2v808cNRYr5eUtjv/HHVoERIkmZ
         NwkA==
X-Gm-Message-State: AOJu0YyVV8C4M2kJqtFUaQq2xJyDeQPbFX/NszUqYDwaNnKdX48BnpUV
	tzBkDaKvpn1QMXDypUH6Zpdquq0TGZx38cPXcSHvyOU8id7Fd2jPZGN2bS+zYDxUm2s=
X-Gm-Gg: ASbGncuud1tVd+X6MqJfLMf5qlOqj7ebo4CHfiUyTZKA81oHiRvK71B6pnA9rJiFjtE
	j2CokO9Q4Pm8EACvKLMzdVYCAf93tbdPsNB3Vy5/Dm39tg97D9ZVNfjdXPUpCB4sAE/4qIic+wu
	PpzQot1yDDhs9Rg2m0Cu74eGeFNkaTqIjBx2gDJf97JIApvlhyQMELMH2/Y+VcifeRbl+n7Sbtr
	AQKuPzqd4qYZO+haDA1mU1Dl67mWj3ziaRs+x91G3V+dXF/1kKhSP+KrPb5c9r4n2zCB04o7IEC
	fNuWG4BtTLqkTVsvboPwyPlCdbLEKd1UPn8HfXm9xdL6El7gHFWqBQXl/+d9O6TWegshZwhKKeD
	fMoqFMwpY/iZ89Zs=
X-Google-Smtp-Source: AGHT+IGdn1vvDgYPNUFhekmmnQ/ODCJomKknq6Rm95dARAxYil2XYqWpJeB+Jj7JvAQRmu44hnb3JQ==
X-Received: by 2002:a17:907:1c8b:b0:af9:36b3:d695 with SMTP id a640c23a62f3a-afcb99d797emr240490766b.43.1755165585810;
        Thu, 14 Aug 2025 02:59:45 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:f6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c050sm2559151966b.104.2025.08.14.02.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:59:45 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH bpf-next v7 0/9] Add a dynptr type for skb metadata for TC
 BPF
Date: Thu, 14 Aug 2025 11:59:26 +0200
Message-Id: <20250814-skb-metadata-thru-dynptr-v7-0-8a39e636e0fb@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH6znWgC/33QTU7DMBAF4KtUXmPkv7EDK+6BWNieMY1ok8hxo
 1ZV7o4Ji0YiZPk0mm+e5s5Gyi2N7PVwZ5mmdmz7rgb3dGDx6LtP4i3WzJRQIKy0fPwK/EzFoy+
 el2O+cLx1Q8ncBA/ORY0CDKvrQ6bUXhf6nYUh8Y6uhX3UybEdS59vy81JLvNfXov/+UlywZN06
 KW2CrB5i6f+gunkMz3H/rzIk3pobq/spKoGCRphjCOJaVPTK03JHU1XjV5UIABtpDObmllrekc
 zVfMiEZomRNRuU4OVpve6wc/fhEo2gG0ajJuafWj1JTuarZoA9EaIkLwJf7R5nr8BnThBoVUCA
 AA=
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
Changes in v7:
- Make dynptr read-only for cloned skbs for now. (Martin)
- Extend tests for skb clones to cover writes to metadata.
- Drop Jesse's review stamp for patch 2 due to an update.
- Link to v6: https://lore.kernel.org/r/20250804-skb-metadata-thru-dynptr-v6-0-05da400bfa4b@cloudflare.com

Changes in v6:
- Enable CONFIG_NET_ACT_MIRRED for bpf selftests to fix CI failure
- Switch from u32 to matchall classifier, which bpf selftests already use
- Link to v5: https://lore.kernel.org/r/20250731-skb-metadata-thru-dynptr-v5-0-f02f6b5688dc@cloudflare.com

Changes in v5:
- Invalidate skb payload and metadata slices on write to metadata. (Martin)
- Drop redundant bounds check in bpf_skb_meta_*(). (Martin)
- Check for unexpected flags in __bpf_dynptr_write(). (Martin)
- Fold bpf_skb_meta_{load,store}_bytes() into callers.
- Add a test for metadata access when an skb clone has been modified.
- Drop Eduard's Ack for patch 3. Patch updated.
- Keep Eduard's Ack for patches 4-8.
- Add Jesse's stamp from an internal review.
- Link to v4: https://lore.kernel.org/r/20250723-skb-metadata-thru-dynptr-v4-0-a0fed48bcd37@cloudflare.com

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

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Jakub Sitnicki (9):
      bpf: Add dynptr type for skb metadata
      bpf: Enable read/write access to skb metadata through a dynptr
      selftests/bpf: Cover verifier checks for skb_meta dynptr type
      selftests/bpf: Pass just bpf_map to xdp_context_test helper
      selftests/bpf: Parametrize test_xdp_context_tuntap
      selftests/bpf: Cover read access to skb metadata via dynptr
      selftests/bpf: Cover write access to skb metadata via dynptr
      selftests/bpf: Cover read/write to skb metadata at an offset
      selftests/bpf: Cover metadata access from a modified skb clone

 include/linux/bpf.h                                |   7 +-
 include/linux/filter.h                             |   6 +
 kernel/bpf/helpers.c                               |  11 +
 kernel/bpf/log.c                                   |   2 +
 kernel/bpf/verifier.c                              |  15 +-
 net/core/filter.c                                  |  57 +++
 tools/testing/selftests/bpf/bpf_kfuncs.h           |   3 +
 tools/testing/selftests/bpf/config                 |   1 +
 tools/testing/selftests/bpf/prog_tests/dynptr.c    |   2 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 218 +++++++++--
 tools/testing/selftests/bpf/progs/dynptr_fail.c    | 258 +++++++++++++
 tools/testing/selftests/bpf/progs/dynptr_success.c |  55 +++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 419 +++++++++++++++++++++
 13 files changed, 1027 insertions(+), 27 deletions(-)


