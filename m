Return-Path: <bpf+bounces-63897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DA4B0C1B8
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 12:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B449718C1FBD
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 10:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B0A28F92F;
	Mon, 21 Jul 2025 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Mp/k3dvm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006BD221D9E
	for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 10:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095204; cv=none; b=HCc6OQvogtnyyjum3Kznsyg8E9Z30lRzDTVbD/krrHFCLshLwgwSTuSXbye8tec58iePez/c0QcpAJUGZN1kwZg20s1GmB6CW6e+PxyIhin0yZxkFj3RFNkCh2zhjwq88G5t8GWJc3WuimfUp6DyAnc9Vdi3VTquRoMQjcj1hBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095204; c=relaxed/simple;
	bh=LEItttZjX1bMQpXOSX/GR5KmfSlnxSGq5f+QfeReYys=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aJGq/n3uO/HXXkaIHL8cy8vzGt12lnz9gbRC63YuztY/5DTTELzsTxhv3Eyc8Fhkw8xcF+hkECAxyC9zd4VRHy9h5R2eOrVv5yI0QbALKBbpy76FPuK2G41vUFFFyGQZOB9E3wUe0vmJfWDVNSIGJE1VMepBOMnS1SKSN5pB57g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Mp/k3dvm; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0a0cd709bso958006866b.0
        for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 03:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1753095201; x=1753700001; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ndCnRbbP5Fm8HlgAjoOw6EoZWW7eGi/twR9H6tYnrSc=;
        b=Mp/k3dvmAx3PUxL7SwSTU0syUyunyVAjIQJy5xmPZ/1CX0sQaA11jUPNqHpMfseCn1
         m44h4HC+b3L2BXd0gjoGfJ1aMYs8FLhNTrpUDyEcEp8i7Q1D7TgPQoADktbYWibnbdU4
         rAFjKcyUnauUxVIO+5N3h8hUrPupFoD1OIN1oBuKUGqI4r1v/ukFxOJen05IUQwf+nJu
         D59ov+aaz0q/gK4gGHlqpgF2PoxRHCvADHWypaWePiytHEuV5HXGXFrqLwsxM9Br6aE5
         w2p1q+vMkoNauHfkQJNjtN7l42qcT3BPfSnVarMFO+A7xKzTmmvYmfI/kseKzwcApsyl
         zGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753095201; x=1753700001;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndCnRbbP5Fm8HlgAjoOw6EoZWW7eGi/twR9H6tYnrSc=;
        b=Ws2N4WkN5N+KInn8ePPvgb6a20N6kml9JFHtdqZD2bSSkU7Ghq7M0mGAJAut4iQJVz
         C3288nt/r8C2enx5q1cnv1iK3PzyYQsHC1BA9pwC+BAuhcaqxnAdpESab1mtYSclSWnH
         nZ3V42m42gI0vgTFPDfI4GQl/uSkY6mLbYpMPLTGXOIbVp15WoQI55Wo4Chk0kiHtWbF
         6mVfzaZaqVaR8lHuDIWg31fIvU8UiFR6UyyKIyXIMI3z/aDyCI6xp/oPHhp/6DJLotR8
         14GjfhzNdAw9XKbrXlFKGLxOnWpc8flEZraMfjmKpBITspKfnFloaOJ/ZEEGluZcETLt
         hBnw==
X-Gm-Message-State: AOJu0YyobRhkpZ6Ma85akUCZmgmR/nXBSJTqnqEmwdBFxVhpOvl45gnU
	kEV+sAZzf+CqQ0bKVil7yDUgrrweM3HAdon9wFgZ7Qk/eSMStUfWtALHt4AGiF0QFow=
X-Gm-Gg: ASbGncsC8NgNtginlN1MVxpmtgTqzvg3Opb/NfYZ9EWjZmwtUZyKgj2ITtAEqtCaNny
	MH8D66hGDGJR/c0JDLHLhJEOqRTVk9Ktk13enPXOduJbFzF42M2FOj2ZfYaP3FI1aBFjd6scV6O
	lYB9yjKKmG/pd3jEdwr+dNf7f33oE5WCSPHmcTnd5MvgWyMj9kTf8UNNXbve9f0o8mw0HAWZlow
	aOp5Mc579CviOipaBNq4vpkZROHu7GTyN4Dkp144JWZGsP/p1XSGgJOnijYIUekFtPVyFD1bUe7
	raw5bEMRbeRi0z70c1Tj4Vr/BTRvNa61ad3kxJth69YQnhwY94NCSsUEjR0Jh7HibI4DW+siS59
	poEh4EY0oINgItg==
X-Google-Smtp-Source: AGHT+IG5mcaGoy+aJipIop3dDEkOgqoQe1F7IY6QnEgJ/IWSagkQnu2CGEImCQlgbTpxnxK1Okmr7A==
X-Received: by 2002:a17:907:3f90:b0:ae3:f3d7:d302 with SMTP id a640c23a62f3a-aec65ff8188mr1433839066b.18.1753095201183;
        Mon, 21 Jul 2025 03:53:21 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d9e72sm658811966b.59.2025.07.21.03.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 03:53:20 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH bpf-next v3 00/10] Add a dynptr type for skb metadata for
 TC BPF
Date: Mon, 21 Jul 2025 12:52:38 +0200
Message-Id: <20250721-skb-metadata-thru-dynptr-v3-0-e92be5534174@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPYbfmgC/33OTQ6DIBAF4KsY1p0GUMR01Xs0XaAMldS/ABKN8
 e4ldtFF0y5fXuZ7sxGPzqInl2wjDqP1dhxSyE8ZaVo1PBCsTplwygUtWQn+WUOPQWkVFITWzaD
 XYQoOiloJKZtcU1GQdD45NHY56BupJwMDLoHcU9NaH0a3HpuRHf2bz+lvPjKgYJjUiuUlF7q6N
 t04a9Mph+dm7A858o8m/z0bedKEERUtColMmy9t3/cX2jpmdx0BAAA=
X-Change-ID: 20250616-skb-metadata-thru-dynptr-4ba577c3d054
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, kernel-team@cloudflare.com, 
 netdev@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>, 
 Stanislav Fomichev <sdf@fomichev.me>
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

    As the the next step (2), we want to relocate the metadata as skb
    travels through the network stack in order to persist it. That will
    require a safe way to access the metadata area irrespective of its
    location.

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
Jakub Sitnicki (10):
      bpf: Add dynptr type for skb metadata
      bpf: Enable read access to skb metadata with bpf_dynptr_read
      bpf: Enable write access to skb metadata with bpf_dynptr_write
      bpf: Enable read-write access to skb metadata with dynptr slice
      selftests/bpf: Cover verifier checks for skb_meta dynptr type
      selftests/bpf: Pass just bpf_map to xdp_context_test helper
      selftests/bpf: Parametrize test_xdp_context_tuntap
      selftests/bpf: Cover read access to skb metadata via dynptr
      selftests/bpf: Cover write access to skb metadata via dynptr
      selftests/bpf: Cover read/write to skb metadata at an offset

 include/linux/bpf.h                                |  14 +-
 include/linux/filter.h                             |  22 ++
 kernel/bpf/helpers.c                               |   7 +
 kernel/bpf/log.c                                   |   2 +
 kernel/bpf/verifier.c                              |  23 +-
 net/core/filter.c                                  |  76 ++++++
 tools/testing/selftests/bpf/bpf_kfuncs.h           |   3 +
 tools/testing/selftests/bpf/prog_tests/dynptr.c    |   1 +
 .../bpf/prog_tests/xdp_context_test_run.c          |  92 ++++++--
 tools/testing/selftests/bpf/progs/dynptr_fail.c    | 258 +++++++++++++++++++++
 tools/testing/selftests/bpf/progs/dynptr_success.c |  22 ++
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 182 +++++++++++++++
 12 files changed, 682 insertions(+), 20 deletions(-)


