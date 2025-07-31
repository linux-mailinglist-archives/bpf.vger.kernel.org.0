Return-Path: <bpf+bounces-64792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EA7B16F7E
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 12:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98FBA178E73
	for <lists+bpf@lfdr.de>; Thu, 31 Jul 2025 10:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C002BE05E;
	Thu, 31 Jul 2025 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KVdpxBZs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA862BE035
	for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 10:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957714; cv=none; b=CVCgnf3MdK3fjxC9myPg7o7IvgHeCQjinZkKNKWmU2w3xwqb0sxFz7h3nexhqW+0yJhqsuafZ1a+yMxH9txhj1G3lXJgW8aCFQYa4ut9C/EbcU5iS7mhdjXUkol0WDTp+wnLRwPY11vJLNssvtuxzOyqZWq9ocH99BF1lF7/ou0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957714; c=relaxed/simple;
	bh=cQGcSTa929DpA4+Rgf/ctX3f1eTiH9dw7oUvgn9p4Kg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jKThJNQhaV2UZd0ywUunJmfHOqiK/v9th1uPn8s7haI+KyrbroN3VvQqPxLBQYtRNjjL/qbFc5gVC8OqWK7qgn05HoFp+kXjwpeVWpQT+xI1Sfei7ybHvGmYxt5zPu/9bbwZpw+4d8hKwXxouMyXlvdthJCQazOq0W0Cpkee7n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KVdpxBZs; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-615378b42ecso1272343a12.0
        for <bpf@vger.kernel.org>; Thu, 31 Jul 2025 03:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753957711; x=1754562511; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w7oVOtYXrEIxoQve/4ESaYH8OzkO/m1Pf2/qCcCi5Iw=;
        b=KVdpxBZs47xhoeCtYl3obOzyTCYWB9USWh0S5UGQoAb5N/OErXjbLu1J3xx5LH5ivN
         Zll+rdl+FB5lp835hUGJr+tEu6YzeOSuTU1Gc1xyNPN82IIVhi1FDAmttQC7kO2q6fmu
         +g1t3NsY8WPSON7XD/Ab/u7OqaiERBOeuZ0eIql83wLSX7T02J07Y8yoo1qt0yVZbM3X
         mXwE+k0VPo3LznPAsYOtOblPgCe8ut3VbDi+71w8HF54XtGxTW9bJMdJMsKcwcFKXFAy
         RVkNieSrVpTxo9tnWUK5r/8Bu0AUQU29myMjPJDXQ6FbWr8x+TU63upK2l+C3EM7x2B8
         drFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753957711; x=1754562511;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w7oVOtYXrEIxoQve/4ESaYH8OzkO/m1Pf2/qCcCi5Iw=;
        b=hvzaLdA9O+75O7Mm1ztHMVCVXtqof3SsPROxYG5Iw04U4kIaObvxawt6lSGLqWJcph
         lFV27CDn0IiAxVlRfebz5biwzWQvdV2HMlRrYhGUutqQpyfHJ8EB4TvagM12szKYYvyT
         Q4z1a81yOY3kvH2nr2ta8pCoFaVRVR6eesxqx+QMeHN0niIwaDOBCM5wAeUausYY8tx4
         ZGJf9z99nRIWjGTAdI6w0Ms3to71W8gHZwNoU+lH5kcDYi1jz/afaFzA+V1IwE7BU6ec
         95m8pKwx7m2NhoedBghQFHW1qUW43jR532eLpE3Bimb2XZD048g2t9aKAAcpn7dLNpt/
         IyNA==
X-Gm-Message-State: AOJu0Yz9t1bLO3h1Ef0XMV56oub36Z+3tyGpDeMsBRA77ZRPv27CUZdo
	zlgxgNTgkZ4c6nfyiKcFC3/CjgPWLR0KxGTI3hGJRu98kxeb1QzWeTJXhgBfprHi8Kw=
X-Gm-Gg: ASbGncsi3QvyDZ0yyHYAaZm+cZy7UrnAkTGbDCp4Gkyao56BHPAQgshZD04ldbNTXi2
	TmiHmgUQv7IOdHp7sxEJja8cFTIDwE1ohpHhh976421hFOlpS3r9BYvzkWCUFiofYj0Gz7DaCxe
	FG8PsHZKs0Xw496diUjz57Owi5Polhagywt/FIZHuRd9lnrnd0aGsa0rHRqHXAEuPcyLy9oIeXx
	7vOgaQYMVDA1+qF8k2nUaPm8oPNm3BexlqHmOpwflGr993Tgb885ajhNbJ6uK66rDGpqH0R4CK6
	L8fb3xrJaH1oK9LhwmBLFCflDLjRRyBPlB4VDbR64rixiKsKtbePGAkg5VwrZdTbbI+Vi55Rn4q
	Rw+73LDTf0+W6JpI=
X-Google-Smtp-Source: AGHT+IGXNhddvo/r6PK5ZgKhoB4gWehfGRbOn8w7qnQYKtmywJjPwWLOPmGKi2BZbnYLWFchd8xXhg==
X-Received: by 2002:a05:6402:270f:b0:60c:60f7:ec9b with SMTP id 4fb4d7f45d1cf-61586f2d1cemr5835206a12.12.1753957710669;
        Thu, 31 Jul 2025 03:28:30 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:eb])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a9113e40sm888840a12.57.2025.07.31.03.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:28:28 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH bpf-next v5 0/9] Add a dynptr type for skb metadata for TC
 BPF
Date: Thu, 31 Jul 2025 12:28:14 +0200
Message-Id: <20250731-skb-metadata-thru-dynptr-v5-0-f02f6b5688dc@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAD5Fi2gC/33OTW7DIBAF4KtErEvEr3G76j2qLoAZYpTEtoCgR
 JHvXuQuEqmpl09P8725k4wpYiYfuztJWGOO09iCftsRP9jxgDRCy0QwoVnHO5qPjp6xWLDF0jK
 kC4XbOJdElbPaGC+BaUXa+ZwwxOtKfxE3BzritZDv1gwxlynd1s3K1/6Xl+x/vnLKaOAGLJed0
 NB/+tN0gXCyCfd+Oq9yFQ/NbD1bRdN00D1TyiCH8FKTT5rgG5psGr4Lh1pLxY16qalnTW5oqmm
 WBQTVOw/S/NGWZfkBUHKRYLkBAAA=
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
 tools/testing/selftests/bpf/prog_tests/dynptr.c    |   2 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 202 +++++++++++++--
 tools/testing/selftests/bpf/progs/dynptr_fail.c    | 258 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/dynptr_success.c |  55 ++++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 280 +++++++++++++++++++++
 12 files changed, 865 insertions(+), 27 deletions(-)


