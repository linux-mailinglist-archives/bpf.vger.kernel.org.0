Return-Path: <bpf+bounces-72231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DB9C0A93C
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 15:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA87189C7C2
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 14:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E50824166D;
	Sun, 26 Oct 2025 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="EGevNWVq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD52F213E7A
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488319; cv=none; b=gyVJjyvjgpcx4XP06neFz6JmMgCryvEg47Ekp5v8kfb5ZvpUWegzcA1hdSJ89gLPrWfRtRRfTiXiCCtxUSxfYuP1Ip4bltxAE53pjp0XjEtSAq9auNhCIwjYit7dN62hZy9G8Bs+W3/N1Qk3GPOvH5PMLPdsROu8BFV+PJewlrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488319; c=relaxed/simple;
	bh=uCkFSufQFZ7HFWxTTk7p88jt/0W3ryStBP8ftxN+t0g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SFJDrhIHxDI4sGIXVq8yAk8kPlNZPREUOZuhm52c5vGACFyYZNjMDFoZqqhXy4+PHG/trmt7dNMSdO0EExgBGGSQHvvhMiNjY/6v2h694lzsAuTboHtGL92Meoa49QeLFIa7yn5djIpEVw+yeN5kMoEQSMp/rRGSC32J9gD1m9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=EGevNWVq; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso407584366b.3
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 07:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488316; x=1762093116; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1zfwv/RUYuHDy5X2aWHYd9NaLbvMNGst97rjU1pFJgk=;
        b=EGevNWVquPrraDLBk67tPL2ylJXdauAKyZMpXDtjqTakIwqx8ufxDyoyS+hJRx5gC4
         4topeZGdFYrP6Uaxf8uFrRbQmg+uvmEiTEq7yoZZluN5jsL2ENckdZrYJPct2rZp3MTe
         jpB/Vafj5T82Oo8YPNEFj7GhApfazG58rfcyWSlqrlkoIAU1+UmaZnyo4oP/CDnCtyIk
         x38WQFZGXG1+5lFTK+GuLp1pQtH9OKkIpC5VLi0hckhGc9HWxL3Xdfz+KVKAQU8MpasX
         NnJyiascpohK0nVtKD8uQ6G5vVMp+vlHftD+JR8bc6JfGpSMMBlNZ6gw6rrPrRWrvgvK
         8nVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488316; x=1762093116;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1zfwv/RUYuHDy5X2aWHYd9NaLbvMNGst97rjU1pFJgk=;
        b=cVdXq5R2OciLyqFhp4vpN6XKFoMhsuoAOqDd0X9gMW9KaXBfJioZpCmIU74uwtQpGS
         Jof01dQPcvmrwm+3w7hhd0ZlY0DMqv2cBzKhf/YpxRebigVCtivdmxT33Jc/m9/OkpEr
         1VKgdOHCicy/H2DANqy0VbvTpfcIGV6nn/D0O7VMeVQRWHCLKAF/yPix/m7tR4QsTnyY
         QO0KBatLnns4CWeGIOiCZT3Sf/37MAyVaJ2Du0OOPHh83x2WGzoR3PfcO2ubD1xpPc39
         E7aBy++LdRdqO8igYxOjEBkjWEkRz/KQVLT/CmUWl8PQjDeo8jyC2yMTRY22tU7/0G7s
         yViw==
X-Gm-Message-State: AOJu0Yw3c+gIyvpyLmEJK9aHOaCDtG8yyGO1BEIvxvvFdT9YCTcCHtzx
	5MO90ElHrvO3cZsaqnereN8L4rHzNdJuNkriJF+u4Lli0P4ZGESaT5C17LAKAoaIkv0=
X-Gm-Gg: ASbGncs2WUF5N6G8XEtP2uXWIoJxWZM0LAJBq7BjOUyso0hLO82ruuCTl8dXJxp7Ezi
	6lZu92VN43FIF4UyotJmE+cux9naQAtUFvmRK/vyahJkceRD5ONLCw2UO2zrT0oUjUJHN18ORUQ
	EDeWim1EiaU8ilGzlt4Cuq5NuZPKaah61E5W6Qy1HRIsI6Gg2djuDk//pitICkh+9FOD8OCDRCF
	P0SjmogB2bCEEeIiB9Km+/P0Pt2jvilBh2HZQEZtaNCOatN32iEfnJPk/70PRWiTZD6n1CTrIH1
	g/DvW9ZzpFjkE2+O4p4zwPZv2JOJ9t1N9EuNDgSXADUBITS3mo9MCITa5DnEOnvbCwy7MKFQgT0
	hIux0wKPNdURpUyg+AaZMrEAdPM67AAgOQALBru8dsgd+qWOkfe3imNfTHRfRWgMvrd+WwX3Q8k
	nPOVHtB4dmvsMD/pmy7qw3H9Pt7GXuebB9frZyeSPd3/4czORU+alN9qQy
X-Google-Smtp-Source: AGHT+IFLGVilDlNj+sxzb+TcWj2MHhtcAlionRYHxHnW4/143W0R6dc68ajUvfHY+JfDSJpvYYQeDQ==
X-Received: by 2002:a17:907:6ea9:b0:b6d:606f:2aa9 with SMTP id a640c23a62f3a-b6d606f3a5emr1107160366b.65.1761488316143;
        Sun, 26 Oct 2025 07:18:36 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853077d2sm472225666b.3.2025.10.26.07.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:35 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH bpf-next v3 00/16] Make TC BPF helpers preserve skb
 metadata
Date: Sun, 26 Oct 2025 15:18:20 +0100
Message-Id: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKwt/mgC/23NzQ6CMBAE4FchPbumPwGsJ9/DeNjCVhqRkrYSD
 OHdbTDxgsfJZL5ZWKTgKLJzsbBAk4vODzmoQ8GaDoc7gWtzZpLLkmuuID4MPCkhhBlGTB0YKrl
 RKGq0muXZGMi6eSOvzIwWBpoTu+WmczH58N6+JrH1X1bqPTsJ4NBSzTnWaERjLk3vX63tMdCx8
 c9NnORPEVz8U2RWrMbyZBWZqq12yrquH7glmqkFAQAA
X-Change-ID: 20250903-skb-meta-rx-path-be50b3a17af9
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

[NOTE TO REVIEWERS: I will be AFK from Oct 28th for around two weeks.]

Changes in v3:
- Use the already existing BPF_STREAM_STDERR const in tests (Martin)
- Unclone skb head on bpf_dynptr_write to skb metadata (patch 3) (Martin)
- Swap order of patches 1 & 2 to refer to skb_postpush_data_move() in docs
- Mention in skb_data_move() docs how to move just the metadata
- Note in pskb_expand_head() docs to move metadata after skb_push() (Jakub)
- Link to v2: https://lore.kernel.org/r/20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com

Changes in v2:
- Tweak WARN_ON_ONCE check in skb_data_move() (patch 2)
- Convert all tests to verify skb metadata in BPF (patches 9-10)
- Add test coverage for modified BPF helpers (patches 12-15)
- Link to RFCv1: https://lore.kernel.org/r/20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com

This patch set continues our work [1] to allow BPF programs and user-space
applications to attach multiple bytes of metadata to packets via the
XDP/skb metadata area.

The focus of this patch set it to ensure that skb metadata remains intact
when packets pass through a chain of TC BPF programs that call helpers
which operate on skb head.

Currently, several helpers that either adjust the skb->data pointer or
reallocate skb->head do not preserve metadata at its expected location,
that is immediately in front of the MAC header. These are:

- bpf_skb_adjust_room
- bpf_skb_change_head
- bpf_skb_change_proto
- bpf_skb_change_tail
- bpf_skb_vlan_pop
- bpf_skb_vlan_push

In TC BPF context, metadata must be moved whenever skb->data changes to
keep the skb->data_meta pointer valid. I don't see any way around
it. Creative ideas how to avoid that would be very welcome.

With that in mind, we can patch the helpers in at least two different ways:

1. Integrate metadata move into header move

   Replace the existing memmove, which follows skb_push/pull, with a helper
   that moves both headers and metadata in a single call. This avoids an
   extra memmove but reduces transparency.

        skb_pull(skb, len);
-       memmove(skb->data, skb->data - len, n);
+       skb_postpull_data_move(skb, len, n);
        skb->mac_header += len;

        skb_push(skb, len)
-       memmove(skb->data, skb->data + len, n);
+       skb_postpush_data_move(skb, len, n);
        skb->mac_header -= len;

2. Move metadata separately

   Add a dedicated metadata move after the header move. This is more
   explicit but costs an additional memmove.

        skb_pull(skb, len);
        memmove(skb->data, skb->data - len, n);
+       skb_metadata_postpull_move(skb, len);
        skb->mac_header += len;

        skb_push(skb, len)
+       skb_metadata_postpush_move(skb, len);
        memmove(skb->data, skb->data + len, n);
        skb->mac_header -= len;

This patch set implements option (1), expecting that "you can have just one
memmove" will be the most obvious feedback, while readability is a,
somewhat subjective, matter of taste, which I don't claim to have ;-)

The structure of the patch set is as follows:

- patches 1-4 prepare ground for safe-proofing the BPF helpers
- patches 5-9 modify the BPF helpers to preserve skb metadata
- patches 10-11 prepare ground for metadata tests with BPF helper calls
- patches 12-16 adapt and expand tests to cover the made changes

Thanks,
-jkbs

[1] https://lore.kernel.org/all/20250814-skb-metadata-thru-dynptr-v7-0-8a39e636e0fb@cloudflare.com/

---
Jakub Sitnicki (16):
      net: Helper to move packet data and metadata after skb_push/pull
      net: Preserve metadata on pskb_expand_head
      bpf: Unclone skb head on bpf_dynptr_write to skb metadata
      vlan: Make vlan_remove_tag return nothing
      bpf: Make bpf_skb_vlan_pop helper metadata-safe
      bpf: Make bpf_skb_vlan_push helper metadata-safe
      bpf: Make bpf_skb_adjust_room metadata-safe
      bpf: Make bpf_skb_change_proto helper metadata-safe
      bpf: Make bpf_skb_change_head helper metadata-safe
      selftests/bpf: Verify skb metadata in BPF instead of userspace
      selftests/bpf: Dump skb metadata on verification failure
      selftests/bpf: Expect unclone to preserve skb metadata
      selftests/bpf: Cover skb metadata access after vlan push/pop helper
      selftests/bpf: Cover skb metadata access after bpf_skb_adjust_room
      selftests/bpf: Cover skb metadata access after change_head/tail helper
      selftests/bpf: Cover skb metadata access after bpf_skb_change_proto

 include/linux/filter.h                             |   9 +
 include/linux/if_vlan.h                            |  13 +-
 include/linux/skbuff.h                             |  75 ++++
 kernel/bpf/helpers.c                               |   6 +-
 net/core/filter.c                                  |  34 +-
 net/core/skbuff.c                                  |   6 +-
 .../bpf/prog_tests/xdp_context_test_run.c          | 129 ++++---
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 386 +++++++++++++++------
 8 files changed, 475 insertions(+), 183 deletions(-)


