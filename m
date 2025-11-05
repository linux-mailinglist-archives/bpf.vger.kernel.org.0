Return-Path: <bpf+bounces-73700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED985C37ADE
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 21:20:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B79D18C1855
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 20:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE71346794;
	Wed,  5 Nov 2025 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="HK/uDy85"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EA330FF2F
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373993; cv=none; b=ptIFbU+oqv9iQgVBIRjuGJ0UGWBxj+kiA1vgSJbtiN+jltPI2Av0lX1HgniXhB0/ds9cKXeozUD1E2GecX2iEZSsihNSER3RWGlXUc4ogOi4tDlQTcV7MailWkA1rGuky4uVv4Xk/e6a7oTySqcpdPkjEvB8Jk1MNaBmBh/9kqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373993; c=relaxed/simple;
	bh=oqLL1DtugD8nAtrKqXz62QpNO9cX3g0hubMgfsXD0SU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cvxGk73bE8s+H3BpHJUA8f1B/w5k6wOp8EdyzK1lzcMRWXgWrTYO0NHC2011o+Tkns5EBUOWXj0m3aHmHylwTsuIo0SYVKVBf8r4VvFUFBWi1ab2CJy0NMkysTDuj17F52rqYpxWPfEoRhAsiDJoSXLQe89F1l7chCgHEubRiMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=HK/uDy85; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b5a8184144dso29050566b.1
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 12:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762373990; x=1762978790; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uFgaH8SLJr+B2SQBY1Ucx/AZqiD6CEjxSo2nJurHPNE=;
        b=HK/uDy85B+APlWzGy4UdYzEZ04KhPbmr+7IcS1pvx4pINPavzo/w2BKk4YXFxa0+kd
         e0aoPCyNvip72DPs6p9HM3k3khFf6WzVRJCzCtkatplhMgLDptu6dYE/hQQssS+5NEB4
         jYWNlsPV7LaxumwDVlSDwDqk8TO8KaOfjbq2IqaWNPSSiDXFQpo3PkR7JBYhatW1KO/J
         ZBzETLSAyDDQNDmpCGwFQqlkkzRoB3oq1vA2y2b6MovTKIaatd8ZDAfJXxs7TQ4unBG2
         dja+W7oM3BqGcYOB6ydQanOlOYzw2k+wt8BArKEiVjKs6lIESTkoSeptIS2EiN3tiNO9
         gl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762373990; x=1762978790;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFgaH8SLJr+B2SQBY1Ucx/AZqiD6CEjxSo2nJurHPNE=;
        b=MvsVcFGD8gsZ8xGFQM9L+sDh19nL0CajIaEAh7/rpNTMWMymdakBVp+4MYH/xWlNyY
         O3dOX6qABXwCd26hMoeXFnX3annoiaAt+0ZYIAJgKH+3oMeHSeOLCLqCnWdN82Er44fS
         pzasDP+hPCV7ImyRc0gsKYm47V45BqahHacBmqUoEMegoekEbfei96R+Ye9j4KWCkT6i
         ETvVw08AM6sqEQaW1n9tKAPd+5usKdb8QAD+XA06S3KU8BCbeCL/tA8md9xrKDd7xt3b
         bF+wqJ4Vt9DYoDzr+zbiK2iyJgX8svwXNlWSy9nJ4yHQdyqt7XeTWKHnTrR/EPF1NYcP
         vxAw==
X-Gm-Message-State: AOJu0YxO3hVM6Z+BPJvgpthwPXIzWiSH+91HIhEKCpE3svX1my/fJJ3U
	qkVf9JxXcjOQYf/tpMH5AkzroyNv7Ajz8nnYpGfE/SMEw7Q84uYBA0WO2piD2ycHq9Y=
X-Gm-Gg: ASbGncthT9NpIoDNJRLAK6J7bYu9RBP8ovsbCZppwf/LXfZnoPG33ne0JwSAAMqlFt+
	2sNkcjMNOabTEdFtRPkXGizRZwVFmxfQPYIjerLtGNUR87X5u3Bwxqdpd+OdsXwiZYYYKunQw3A
	ssZnYWCI/xlz/BcJW631AKy6tw+wIGm5GUParLWfzeejNJua6zauRYm7NMqTHscUu/RsczM+rAh
	lpXRKUa5JH4I0hKG4v+FC5HNLoRueB36tcgQQ8Uxz+VXGLXLF+yotb08LgFzmPc62g9nZr2u4a6
	BkJtl348/wdvA1GvETZ58Evzxv37nGLOamxYiAAHCmMv44P30bz4h5ew3hAjs9+DnHvytaZ/ZeR
	dhEe0zMUn6+U23IsQdtWZ0wwPH3IMiusRC+Sins0Ox3xRZUC25D7hsSqSEvZV38AN7AbO3kMGUR
	xpGLbmXPwL3m8VUqd43vjxemHiDeheE5b6BamC3qpbq6/dZUkBA3tYIfaU
X-Google-Smtp-Source: AGHT+IGgKmw/nwJvQk629sp1HZOWYMtdWrcQL22UwZFNStAjV9bJUZ6ouvI3RYH2/GTnd5dORzWjnw==
X-Received: by 2002:a17:907:7f2a:b0:b3f:f6d:1d90 with SMTP id a640c23a62f3a-b7265156577mr380008366b.11.1762373990096;
        Wed, 05 Nov 2025 12:19:50 -0800 (PST)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289334288sm46065466b.15.2025.11.05.12.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:19:49 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH bpf-next v4 00/16] Make TC BPF helpers preserve skb
 metadata
Date: Wed, 05 Nov 2025 21:19:37 +0100
Message-Id: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFqxC2kC/23NzWrDMBAE4FcJOneLfmK7yinvEXLYlVa1aGIby
 TEOxu8e4UIpxMdhmG8WkTlFzuJ0WETiKebYdyUcPw7Ctdh9M0RfstBSV9JKA/mH4M4jQpphwLE
 F4kqSQdVgsKLMhsQhzht5ETQE6HgexbU0bcxjn57b16S2/pfV9p2dFEjw3EiJDZJydHa3/uHDD
 RN/uv6+iZP+U5RUe4ouSrBYfQXDVPt6VzH/FF3vKKYopnGOmchW3rwp67q+AMYjB81LAQAA
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

Changes in v4:
- Fix copy-paste bug in check_metadata() test helper (AI review)
- Add "out of scope" section (at the bottom)
- Link to v3: https://lore.kernel.org/r/20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com

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

Out of scope for this series:
- safe-proofing tunnel & tagging devices - VLAN, GRE, ...
  (next in line, in development preview at [2])
- metadata access after packet foward
  (to do after Rx path - once metadata reliably reaches sk_filter)

Thanks,
-jkbs

[1] https://lore.kernel.org/all/20250814-skb-metadata-thru-dynptr-v7-0-8a39e636e0fb@cloudflare.com/
[2] https://github.com/jsitnicki/linux/commits/skb-meta/safeproof-netdevs/

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


