Return-Path: <bpf+bounces-71294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9111BEE527
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 14:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10C71896416
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 12:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547692D3EEA;
	Sun, 19 Oct 2025 12:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IwvSDmXU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D268F4F1
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760877939; cv=none; b=stso9vdA+2ySSANxZnVjmyyM3jsgcFMTEH4LUxS4e1wcFtc0O7Vv0JW4NVGk0L+7jDosEHQPYSFoVq2emx42oVXldRGyiqeTLNW8lEBMQMxVK4p4mZQEWgl1xOKffM2z7nYzzcxOXIVrmowP9Y4LWJGLC+n9RQ0t7EMJx6L6hn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760877939; c=relaxed/simple;
	bh=GjUl5p7WYCvSIxPoWwpdkPGP2x6l5lB78cRtlz5MC5s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uhCqKhHq14vfDB1p+DPhAQX5Es8rm4cyP6abQC1HhArNb9dbBW+BLGjdKcY5SjH76+kmLl0gnLc2Jzjlx95lbcWOXWDqBiNPCEbmNULlBxHBgWgeG4FLwP7isINtISPI4mfxaFx+5krhhSJfFIG2qO5jz28CkQcKjDJjOVcYyYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IwvSDmXU; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b463f986f80so691414666b.2
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 05:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1760877936; x=1761482736; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OPesFPw/mEXNA4diiwfx+Q6fda27v3D04HEPTNdnNkw=;
        b=IwvSDmXUFC6emO6SLl2HGwT3O5ihrGJ7cCHTGmzkPEJJw2A8+y/tpGE8VfRMYfAre7
         xwz68K7QrM+1xsjxtspVwQdhGHOB4bzcYpYCsx89jOhvA9h1VCpbSKjkkurPJ4We0EsL
         CGQUt89DZaQbcCfaAmJc0xgMUJFMJNhf3h3eFE6/UXYIFddVcjk8IpdaWLM5LFgBSKzf
         mjDBS0bAwUFbHIopn5sIhBBwXDQWFHmIqVea4H+evXbMDB24uLRDBpYdxS4QgGISpFuu
         E3rGpvgh0O2OUIcuW+XbS+5bkZzPAtZc5z8GeqG4T5N/l8oMLvM3Z2kz/lJPowBqDXRj
         oRJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760877936; x=1761482736;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPesFPw/mEXNA4diiwfx+Q6fda27v3D04HEPTNdnNkw=;
        b=MGFgA+VAp+3uONHrlXfZaux6oQMeNTClEJBwvtowlIyUPJd4d/Ch0iQZIXGp0cBxy3
         HVsHNj2dr6IQZFfnxAHQP+LpCZK6ovETR8N/Xdp7FU0S6XhVSqMehcQ42Eu7lOeTz0UF
         OkOBx1A3REkUvspiMcX/kBFiV2WYiNmFfCdmnj3f1UeL63YwNSCaWwW79UGcO6KLxSYt
         rqsEGeKjA5om2cEwd4v+x4uV8Sl3lsN3kIvtPSRVrGNznJiyue3MDPTCLM7/22AvGXLq
         SgZUwtSLYXcIl7oGjCOew2c5GPHRnPxag0MkSdQuQEOnGugCcfmtioeWexKlT2dxzu36
         Uiew==
X-Gm-Message-State: AOJu0YyP1vN4m9PX5MP69CpownewBpzagUrNoFsEo3bayZQ16+7oSsPT
	6cP+JHaIlJcgASqQajTW7PvtRoWvsnX6aZ/yT/vL5DAjMRF0sKnOe8IiWG9CRBuSNUg=
X-Gm-Gg: ASbGncvBPwqo1tUQS1dv0OSRlcoS266jA73Gn2cCLvVMpAf5dneaivCTw7Z3hhsnAvc
	0cnI67D5cQTtJ1SBIdeLH8O9Xkg04ELgNFJWWlWMghIxBpu4XT+CREYF5+ZuThKJmVbiTJG/P5K
	eY2Zo0S0o4PLY3TxSUIk0LMGAlzjEF9rF0OZSSxKgf7NwRrEusNceRHC9aT8lhgQRafIlQlRINL
	E5Yb8LoXMpulZ3tUfVYl0U2DedgPcqcn/zqmCh4RjQTICTo++rbFCqHZkHlr4w9hTtBd5Vs+Keh
	YlDpLluSQO+3ypPaPxH7lstA2RyLer0Um5qY3p1gKdaDwVhTAqCLB+OWk07B09Czwcn5/MGcOwh
	iRjqBO2pvolw2vgzr/WQVI1yKuwHd6ASZXfrcvH9hkKoYBLoQtdcEFzrzj3j98Yjwtt76wprqmT
	+UTX8PfFErbZNu26BtKNLKDUw20wCBbd3dQz6EzUzxTSPpsg9EtVc5S5OUoAk=
X-Google-Smtp-Source: AGHT+IEt+M49aC5QEvJTTVznZrz3M40EqduyXEn85X7sLX7tS2hGJd/jTumAMfb9gAt5VgoZTFEq2Q==
X-Received: by 2002:a17:906:c116:b0:b46:8bad:6970 with SMTP id a640c23a62f3a-b6474939520mr1134427166b.36.1760877935894;
        Sun, 19 Oct 2025 05:45:35 -0700 (PDT)
Received: from cloudflare.com (79.184.180.133.ipv4.supernova.orange.pl. [79.184.180.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb526233sm498562766b.63.2025.10.19.05.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 05:45:34 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH bpf-next v2 00/15] Make TC BPF helpers preserve skb
 metadata
Date: Sun, 19 Oct 2025 14:45:24 +0200
Message-Id: <20251019-skb-meta-rx-path-v2-0-f9a58f3eb6d6@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGTd9GgC/2WNQQqDMBBFryKz7pQkImJXvUdxMYmTGqpGkjRYx
 Ls32GWXj8d/f4fIwXGEW7VD4Oyi80sBdanAjLQ8Gd1QGJRQjehEjfGlceZEGDZcKY2ouRG6Jtm
 S7aDM1sDWbWfyAXq1uPCWoC9mdDH58Dm/sjz9L6u6/2yWKHDgVghqSUuj72by78FOFPhq/Az9c
 RxftB/CxL8AAAA=
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
 netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

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

We can patch the helpers in at least two different ways:

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

- patches 1-3 prepare ground for safe-proofing the BPF helpers
- patches 4-8 modify the BPF helpers to preserve skb metadata
- patches 9-10 prepare ground for verifying metadata after BPF helper calls
- patches 11-15 adapt and expand tests to cover the made changes

Thanks,
-jkbs

[1] https://lore.kernel.org/all/20250814-skb-metadata-thru-dynptr-v7-0-8a39e636e0fb@cloudflare.com/

---
Changes in v2:
- Tweak WARN_ON_ONCE check in skb_data_move() (patch 2)
- Convert all tests to verify skb metadata in BPF (patches 9-10)
- Add test coverage for modified BPF helpers (patches 12-15)
- Link to RFCv1: https://lore.kernel.org/r/20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com

---
Jakub Sitnicki (15):
      net: Preserve metadata on pskb_expand_head
      net: Helper to move packet data and metadata after skb_push/pull
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

 include/linux/if_vlan.h                            |  13 +-
 include/linux/skbuff.h                             |  74 +++++
 net/core/filter.c                                  |  16 +-
 net/core/skbuff.c                                  |   2 -
 .../bpf/prog_tests/xdp_context_test_run.c          | 127 +++++---
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 358 +++++++++++++++------
 6 files changed, 434 insertions(+), 156 deletions(-)


