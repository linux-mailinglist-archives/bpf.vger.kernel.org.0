Return-Path: <bpf+bounces-64990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFDFB1A246
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 14:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAAAE18867CA
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 12:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793CA26058D;
	Mon,  4 Aug 2025 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Aoc2pvC5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2863260580
	for <bpf@vger.kernel.org>; Mon,  4 Aug 2025 12:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754311965; cv=none; b=s9I8Cza3+w0lOvayM+xnzkyZZ9DCbycVLiTdpU4gB3TIRaGMHfMeUanS7uo4RfJ35QXEr2e5Mv3csQZgZgGCAuHdDbWzMfVE9u6cQyyxJrB4oaQlQU9Tuw7s28Oc7Anc2dNhtHtHWGOTWoQy4XRuwC/MVk7Mz1VPrNvS1dqPPHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754311965; c=relaxed/simple;
	bh=HbS8jz8oHN4EM7Spl+6qMeVrbTVGln88E8oa2zU9tO0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OXUliDfI5T+524Guzl2uTnfWXquukT8arChK2TGA22H4n0AJDFHo5nwNDOCk7wEemHLrC2cEAz+spmsZQA4vGgjzpXN+5UwNEmCu/4bkOR8INFj/sEg/LMawHSi7+ZP90ZDfmt3MLX+vffYrjoHZdO5bqdc10n5XRkK2VBxfKNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Aoc2pvC5; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6157ed5dc51so7675647a12.1
        for <bpf@vger.kernel.org>; Mon, 04 Aug 2025 05:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754311961; x=1754916761; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I+nJNk/z3LXWzMW8gVhVyymqsd5ZTEL/QizCTBlgH7s=;
        b=Aoc2pvC55CIu312r8UfgCr7rQ78vNvPb/f5obMMJNo6GmCvGh5QlEiF7NCEXHAVtFC
         oK6d9aqPoEcFGQUeqRmSySi+QuZ56/IYxrKj+WJfr4Wl9snQNGRDP1o6QHNU+r9ejwmF
         IxFHocTjMpTHeTsGdPMrM/iLl+Z0FPoRauFUXU/7FD3wT5kFG4Pp/MyPe90A61Uq4Hdj
         cPQgtqxar46oRDu9h3fo4BocRWUbsaJgNfDqto+3Jvqj4gLICPFyEnJko5u0u7jGXYDK
         J+ycezwvT2EfSIjguqOdMk4r8mnELnmJ0jUNZNn9bORgEKPMW7OiRxpGbHgCpfHpqcxn
         7Mxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754311961; x=1754916761;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+nJNk/z3LXWzMW8gVhVyymqsd5ZTEL/QizCTBlgH7s=;
        b=Jsr8DjE0AJPKU0CPqZLQiz03wX97FYSU7VEFBXYPN8QhyVSP3AoiU56C2W+KzSsvXw
         Lzl42n/kPQddlsqDy3HRcoDBv5fgim2grlaF+Q0kvMQ9eqlQweBpx+461d0/6qf8N2LU
         TVn52GRyKbX9KpI6ZdL73afxaTy3vFPIp0hVkQ3HCBNalvH0RhwuU5UKMUDISTWwPjtG
         Ae9W+6MHo2gdPwAExoCWbjajTPCgG7NVKOs5QiUcde/UwksB0vB383DQmJPU2PDhVm5p
         mzBmgks2bBAUlLZL1k5pUmyldjMIz1NPo86MB6otwkpbgffVi1/U0LZBPGj1qSo5WdN6
         2fpg==
X-Gm-Message-State: AOJu0YyF51DZ+dDcZRA7xxu/6LMmyUv4fLY12EVH/daxk8IBf/x/6YhM
	IASYxhJ1GW3n7PHdKCxhhMbk4JhBX50IXcCnFJrAs7UDmwiiv+gaf5bfFJSS/gKuzzs=
X-Gm-Gg: ASbGncvkCMMp31e1Fy0oxnweSilHryOz6MwxI2PUEjdxa8zPdvQ9RgsqIKIwswbgw2z
	ySYO+wjP1HjgqxJPAt6KseZNvkC65OQ6LbtigLMsbpcJxHRRlU9Qs8Zb+HN+O3aJCNpIm+fl1sR
	DxiSd/zto0V6b0Tn4Nu0DPjNl5H+qcVDK4bUT5x10iUL/ifLs7hzFCCHSUSf7kF7cxQ3Uf0lPPz
	FkhxRSat/xMfBtz8aqfIC6htXJCYktZqti9UMnJAdOS07VgC0FPGPW1Pj5myuiBKBHR2o/Ev2hS
	Z8yHBmOK6qTrtLg1kvcPi7xARGenn28mDAW4u/IHxSAUC4ZylaVVZJEaJKUGn/wQLcc2OQK4BZw
	RMt/8iStwBwCPSQewtVxZaawXB+M5zSs=
X-Google-Smtp-Source: AGHT+IHwDGlH4SOWfBAoELknWyEMKBS6ldlhubyLBPZasYHc67KPmuamFtjC4dAueOyiUPheLtRzEg==
X-Received: by 2002:a05:6402:5201:b0:615:eeb4:3a26 with SMTP id 4fb4d7f45d1cf-615eeb43e5fmr7015377a12.17.1754311961008;
        Mon, 04 Aug 2025 05:52:41 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:75])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f26cc6sm6832568a12.23.2025.08.04.05.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 05:52:39 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH bpf-next v6 0/9] Add a dynptr type for skb metadata for TC
 BPF
Date: Mon, 04 Aug 2025 14:52:23 +0200
Message-Id: <20250804-skb-metadata-thru-dynptr-v6-0-05da400bfa4b@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAetkGgC/33Qy2rDMBAF0F8JWldFr5HcrPofJQs9RrVoYhtZM
 QnB/x7VXdRQ18vLZc4M8yAj5oQjOR4eJOOUxtR3NeiXA/Gt7T6RplAzEUwA01zT8cvRCxYbbLG
 0tPlKw70bSqbKWTDGy8BAkTo+ZIzpttAfxA2Rdngr5FSbNo2lz/dl58SX/oeX7H9+4pTRyE2wX
 GoBoXn35/4a4tlmfPX9ZZEn8auZvWMnUTWI0DClDPIQNzW50gTf0WTV8E04BJCKG7WpqbUmdzR
 VNcsiBtU4H6TZ1GClyb3b4PtvTETtQDdN8H+0eZ6fZOTR3QcCAAA=
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
 net/core/filter.c                                  |  51 ++++
 tools/testing/selftests/bpf/bpf_kfuncs.h           |   3 +
 tools/testing/selftests/bpf/config                 |   1 +
 tools/testing/selftests/bpf/prog_tests/dynptr.c    |   2 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 202 +++++++++++++--
 tools/testing/selftests/bpf/progs/dynptr_fail.c    | 258 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/dynptr_success.c |  55 ++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 280 +++++++++++++++++++++
 13 files changed, 866 insertions(+), 27 deletions(-)


