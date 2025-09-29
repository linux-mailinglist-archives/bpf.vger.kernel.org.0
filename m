Return-Path: <bpf+bounces-69951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5D2BA97C4
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 16:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9229616661C
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 14:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43DD3090CE;
	Mon, 29 Sep 2025 14:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GCYix9qL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7603821C167
	for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 14:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759154959; cv=none; b=ppHn6MGuRhRqvDz0Nj0pOa0M4ZmrwqvcJE7uMOzLNf2X4MXbIACIP8aRFloz//nKS1xHzfgMzx96pigNDk/4MgDHy8Y1zJ/LggCCQ76vWnLQ9vIuk1qiuidS9CBOL5NVJLJ35Zm/EWZ7s/KNnRBZTQbCTx+3nR7PZj2B+omLn7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759154959; c=relaxed/simple;
	bh=48s8Hg61qVmVWj3SNE5V5DpYtluWFVwT7W9u4lbbMTU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=JhTfy4SjmKBBrhR1wlsSLOnKTXNqxCAtBG+jckGpqEp5ypJI7qiyXeAmhKlW2vqmuQ3buOFIHx8gKJPloVoVyZqF6uim46NWnPfkoUjaq1cMt5Q7YMldflaGyMj02lFcJwNPqk/t8pPRifyozyLUXnyr+14XwkA6eETXTI3em4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GCYix9qL; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb7322da8so919253266b.0
        for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 07:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1759154956; x=1759759756; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wN+LPFtxhJNfpbpMv95C2Zwlgczra1tC+I74+t8xWMk=;
        b=GCYix9qLfUqon5KEm+8QLSnCGPGvMLLKIqcdWgHAijLZx8wEaTyxHODcT8r8FVSPQc
         OlNsrAHknNwC2yEHKOMzhMb9ikKDkkAgMBgKkmWJOW4IPVXSlaLQjHyWn9DAaGAWbIma
         l5QkGjlj8pXxAhyqCTUwFMfqC0HjAgOswje3KNyVEqxJztViSkG1UKPWA3j6oKXypCtU
         TLvUE4rQml9e1rqpE4rx5U00UzvWFD+JVFB5w6PNIiuHGw0zepkAGYxbkXgbgkrDrpaB
         GWhs8yZQRrPnWW7K0GgyHzlv3A9fmzuO4WVsNUgPcM6CXQKFK6U+rP/WWk0bCisNlFs5
         UeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759154956; x=1759759756;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wN+LPFtxhJNfpbpMv95C2Zwlgczra1tC+I74+t8xWMk=;
        b=s00FljhGfXp6Dypo7YWnqvr7vONX7/y9lyxCpMsCuZYmK54cZwGN8YYMIorVUcboW+
         y/9LFEqcQsSMdZO+tGeIyjEWd+/eFwio8BNdBBKphJ0C1dcZ5B2vf81FT9IyFMJITzuJ
         /pjfHBAyrUwdBoQke0BdHucQYURHDYGCtV1aiguBy1Fz4tSUfXHxw02qUk57m3nF4t2v
         pXXv7EPvDL00DpmnUe5kaqXjpKjDPPdOjIaJ597YqlqVO1xn/pZtBPfG2SkYNbKuYFnZ
         wrtFpn5Kht16W4tMrgAZjZNRuFtk1yMu8AxxvmtEiWg/ZDT6fMX38VhTBZCQ8d7XhDQt
         /ZMA==
X-Gm-Message-State: AOJu0Yw9e4x/pYlJUHtPUvi7hE36rT89UUfuaaw7szkxkUmgrGTGPu53
	gi8W3Y1hGL6TLrBIhgYkhSHsFp7XqVuFXS9mda/akwlCdXucA2jqFS7Bx9mAkvvzCjw=
X-Gm-Gg: ASbGncs3UpvYFdOoAwJMoVPMV3KyX0+px9oqEyEmanMn8DXjaxYRllQGOupB09I+tbB
	Jf/Czxu8oboydYdVkvqUWdLMJyzQrTi2/BHlUc73g2LwXq6viM5O6tSa1eTu8VoXAjJN4aZdQHn
	b1Go0FZgj/37WkgWdDp92tdIsAA2md0iwrxWPeSTBIyLgu0JFnc8bZ3SgBs+/jWzzMqWLCi0q79
	v29TWHYpAYAlOLcy6s+1RPWap9KlJeLAzuXcIK7YmH5biqWqVikRFiv0pn+YpNeBIdxSzge1KbZ
	HWcEJJGIjk8C2bnhOMsG9leElQVPiCP0IeO1Ak1DVcR+QYOIncLtVscxrKD/PEXrTevccbDHJbZ
	OCLGBcTcJ1ddf8EX1S+jN8GBxvMRXk7RsU9Ce6rsRZXxnPLdidS7+ccEzv1ZI0o3WW6WOReQ=
X-Google-Smtp-Source: AGHT+IG8ZUQJ2MKJPm6k+4REUWeQbBnmHCKYES9QZv9JQHcFsnBpSWlzdUQHFeIL00+Gdja9OgEDiQ==
X-Received: by 2002:a17:906:3587:b0:b3d:4ab4:ea2f with SMTP id a640c23a62f3a-b3d4ab4eeefmr474118666b.19.1759154955716;
        Mon, 29 Sep 2025 07:09:15 -0700 (PDT)
Received: from cloudflare.com (79.184.145.122.ipv4.supernova.orange.pl. [79.184.145.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3d277598bdsm316166766b.3.2025.09.29.07.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:09:14 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH RFC bpf-next 0/9] Make TC BPF helpers preserve skb metadata
Date: Mon, 29 Sep 2025 16:09:05 +0200
Message-Id: <20250929-skb-meta-rx-path-v1-0-de700a7ab1cb@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAGT2mgC/x2MQQqDMBAAvyJ7diEqInoVfIDX0sOmbnQRY0hCC
 Yh/b+xxBmYuCOyFAwzFBZ6/EuS0GaqygM9GdmWUJTPUqm5VrxoMu8aDI6FP6ChuqLlVuqGqI9N
 DzpxnI+m/fME8jY/TzqDlFOF93z/W6b4rcwAAAA==
X-Change-ID: 20250903-skb-meta-rx-path-be50b3a17af9
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

This patch set continues our work [1] to allow BPF programs and user-space
applications to attach multiple bytes of metadata to packets via the
XDP/skb metadata area.

The focus of this patch set it to ensure that skb metadata remains intact
when packets pass through a chain of TC BPF programs that call helpers
operating on skb->data.

Currently, several helpers that adjust the skb->data pointer or reallocate
skb->head do not preserve metadata at its expected location (before the MAC
header) after the operation. Affected helpers include:

- bpf_skb_adjust_room
- bpf_skb_change_head
- bpf_skb_change_proto
- bpf_skb_change_tail
- bpf_skb_vlan_push
- bpf_skb_vlan_pop
- (did I miss any?)

Sadly, in TC BPF context, metadata must be moved whenever headroom changes
to keep the skb->data_meta pointer valid (unless someone can come up with a
workaround for that...).

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

This RFC implements option (1), expecting that "you can have just one
memmove" will be the most obvious feedback, while readability is a somewhat
more subjective matter of taste (which I don't claim to have ;-).

TODO:

- Extend skb metadata tests inselftests/bpf. So far, I've only adapted
tests for cloned skbs. However, the changes have been tested using a shell
script–based test suite [2], which allowed for faster iteration in this
early phase.

PTAL. Early comments and feedback much appreciated.

Thanks,
-jkbs

[1] https://lore.kernel.org/all/20250814-skb-metadata-thru-dynptr-v7-0-8a39e636e0fb@cloudflare.com/
[2] https://github.com/jsitnicki/skb-metadata-tests

---
Jakub Sitnicki (9):
      net: Preserve metadata on pskb_expand_head
      net: Helper to move packet data and metadata after skb_push/pull
      vlan: Make vlan_remove_tag return nothing
      bpf: Make bpf_skb_vlan_pop helper metadata-safe
      bpf: Make bpf_skb_vlan_push helper metadata-safe
      bpf: Make bpf_skb_adjust_room metadata-safe
      bpf: Make bpf_skb_change_proto helper metadata-safe
      bpf: Make bpf_skb_change_head helper metadata-safe
      selftests/bpf: Expect unclone to preserve metadata

 include/linux/if_vlan.h                            | 13 ++-
 include/linux/skbuff.h                             | 74 +++++++++++++++++
 net/core/filter.c                                  | 16 ++--
 net/core/skbuff.c                                  |  2 -
 .../bpf/prog_tests/xdp_context_test_run.c          | 20 ++---
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 94 +++++++++++++---------
 6 files changed, 156 insertions(+), 63 deletions(-)


