Return-Path: <bpf+bounces-61837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9476FAEE192
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 16:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 365443A682F
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 14:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D5D28C87B;
	Mon, 30 Jun 2025 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eIZaIdyz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7223825A32C
	for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751295354; cv=none; b=ZC9CkXzBxRzbSm3hbsbsIKEN4zzzN7cBqgJbTcVyu4XHDK8Cmm6A8JWI22RLBD53dM2WfncuJPxHIDf3RENSyARq7k11yFKMhnNM5Dx+AuDU2SLWCH785/1NNd6lLEMSlAF9Wzs4EzfchbuH2VS+tYCJBpb3RHhI8bALojH26dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751295354; c=relaxed/simple;
	bh=ZJqmvniFMX4XUhe75n9Boxe1iERP6S83FqOmnL+lYyA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qzy3mu6YisvNAmxBfF4Euhexc9o53xfswT0SLlZLNP/x0AKM25GubGaos96PTnTVy5P6/3usrfy+daoLox1/lZickctT/8abW8K+Tor3vBcflZOGXiEGFbZ5xbWjp8IzqlFZDxOfromb3HPVWxYqmwU/JQIbgcXmfpF2OQH0sNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eIZaIdyz; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60c01f70092so7754902a12.3
        for <bpf@vger.kernel.org>; Mon, 30 Jun 2025 07:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751295350; x=1751900150; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uXMF1bMJVAy/JxAwyg6/YYGwbBD0IUDbCLswPPMo1gg=;
        b=eIZaIdyzgTdtgqJSCAAlkP+Jsw2+K7c8K8AUkKi0/lcu7rBoH0zwNLQTzipNa3xPDX
         XsvaqZdO8tjSVdxLaxUlsAMWSK2z6rD9yQtomW624qTZd+wus2vsjoYLFESjX6Wfx9uF
         GZfy7LL9bcRCFhcNd/4lkrhwIutgFzZ5Vd2Ft8cVbXSmfQmejKSh2iS4JSd/7nqja5r0
         LEJJX/AC36ILPynXdWOtkEUe+aJjesUM1uJZmTtPLoPQ7aVXfAtNDg/8o2PTcqMxYCWc
         vuz7dwx2+GMw1JIgwpdwDiglN//eER3mTgQVuyF/sNtEMEjBT6ye/0tdSWZlyTpYFwFv
         vIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751295350; x=1751900150;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uXMF1bMJVAy/JxAwyg6/YYGwbBD0IUDbCLswPPMo1gg=;
        b=YoE1CYWptk0NvDiyjn3Xradfd3CGQ42bZn/IhatpkuxQTk6GIPM3cx5NRvaK1xixYA
         /jzp5/tBw2X5iDCKAYqSQgr4jlB7rDoChwMYfBC2J4ldlN0uki9IWU3RC13ggljb4RPj
         85scccK4tpgU9hTVpxKbXI1Ff+WtM3reJLarx4bmVJKcW65Xjdqwh02Or02FUKcKI2SJ
         D0pLjXMMzlOYLRe6rMMgXLYH//AVDfDLzjSFovV7ywqbRmh2+DP0C5gi27xSQ4+QbqIz
         dz7CHkKeDBh4pJupkkfUjzrwP69UyokeEgVusEUw9354//lEsxbKxqCqnE9+1ZTJf+pe
         YLVA==
X-Gm-Message-State: AOJu0YxrSaY61EyqyeLo32tGmQRzaLkoKzntQnwVM5/OMY654Arnlwam
	mAa1SufmP/CoBP7kl4h8pdqNvdCG9Koaz9cs5itixqITnR/35Bg12ELqVScQUZTDrdo=
X-Gm-Gg: ASbGncvV/sGppiX8DFD/Qg03yiTCpy7A4Y1aoKdCDREjbhVF0Kx0SpjbTrtIlTz8dn8
	F4bZzLBma0IntbCQiM2MefQFPfqRgeIWBppZchwV/dsSmM6oy2V+BDtsU4ATgUpUZEn+qV2cuns
	WBR68XLtWiZcijT6U45Tv23gumauMizzSlMpGRRVBZV8Yui0zqTTQ+RNQ9Jz8Auvo76Bvaxpzko
	/O8VzFYGs3fxJj3VOTkPls2/WYXnukXHMJNRvoon12t8AsLtQwz0mOp8YBK34MDnwg4urvVa/Xf
	ivRaPKe+7pvgYPSAICN7aacRU9IC2+bEW5apDDgBrjHtQ64gbBjd9dk2UiErsn0Z
X-Google-Smtp-Source: AGHT+IHV3ysTdOGShPm0baiE6A6iGQCNOjE79x1nfX2HGrcdah+u108I5dRkwxaYLylF6WTz6veY/w==
X-Received: by 2002:a17:907:3d8c:b0:ae0:1fdf:ea65 with SMTP id a640c23a62f3a-ae34fd8821fmr1248099166b.17.1751295349536;
        Mon, 30 Jun 2025 07:55:49 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:10a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bc2dsm695731866b.136.2025.06.30.07.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:55:48 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH bpf-next 00/13] Extend skb dynptr for metadata access from
 TC
Date: Mon, 30 Jun 2025 16:55:33 +0200
Message-Id: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGWlYmgC/x3MwQqDMAyA4VeRnBeozirsVcYOqY0zjHUlzYZDf
 HeLx+/w/xsUVuECt2YD5Z8U+aSK9tLAtFB6Mkqshs513g3tgOUV8M1GkYzQFv1i/Kdsin0gP47
 TNTrfQ82z8izrub5DyDMmXg0e+34A1AfnBnQAAAA=
X-Change-ID: 20250616-skb-metadata-thru-dynptr-4ba577c3d054
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Arthur Fabre <arthur@arthurfabre.com>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jesse Brandeburg <jbrandeburg@cloudflare.com>, 
 Joanne Koong <joannelkoong@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>, 
 Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com, Stanislav Fomichev <sdf@fomichev.me>
X-Mailer: b4 0.15-dev-07fe9

TL;DR
-----

This is the first step in an effort which aims to enable skb metadata
access for all BPF programs which operate on an skb context.

By skb metadata we mean the custom metadata area which can be allocated
from an XDP program with the bpf_xdp_adjust_meta helper. Network stack code
accesses it using the skb_metadata_* helpers.

Overview
--------

Today, the skb metadata is accessible only by the BPF TC ingress programs
through the __sk_buff->data_meta pointer. We propose a three step plan to
make skb metadata available to all other BPF programs which operate on skb
objects:

 1) Extend skb dynptr for metadata access from TC (this patch set)

    This is a preparatory step, but it also stands on its own. Here we
    enable access to the skb metadata through a bpf_dynptr, the same way we
    can already access the skb payload today.

    In the next step (2) we plan to relocate the metadata as skb travels
    through the network stack. That will require a safe way to access the
    metadata area irrespective of its location.

    The checks relying on pointer arithmetic - __sk_buff->data_meta and
    ->data - were not built for that. They require the metadata to be
    located right in front of the payload. Otherwise their guarantees break
    down.

    This is where the dynptr [1] comes into play. It solves exactly that
    problem. The dynptr to skb metadata can be backed by a memory area that
    resides in a different location depending on code path.

 2) Persist skb metadata past the TC hook (future)

    Keeping the metadata in front of the packet headers as the skb travels
    through the network stack is problematic - see the discussion of
    alternative approaches below. Hence, we plan to relocate as necessary
    after the TC hook.

    Where to? We don't know yet. There are a couple of options: (i) move it
    to the top of skb headroom, or (ii) allocate dedicated memory for it.
    They are not mutually exclusive. The right solution might be a mix.

    When? That is also an open question. It could be done on device to
    protocol handover or lazily when headers get pushed or headroom gets
    resized.

 3) skb dynptr for sockops, sk_lookup, etc. (future)

    There are BPF program types which don't get an __sk_buff as a context,
    but they either have, or could have in some cases, access to the skb
    itself. As a final touch, we want to provide a way to create an skb
    dynptr from these special contexts.

TIMTOWDI
--------

Alternative approaches which we considered:

* Keep the metadata always in front of skb->data

We think it is a bad idea for two reasons, outlined below. Nevertheless we
are open to it if necessary.

 1) Performance concerns

    It would require the network stack to move the metadata on each header
    pull/push (see skb_reorder_vlan_header() for an example). While doable,
    there is an expected performance overhead.

 2) Potential for bugs

    In addition to updating skb_push/pull and pskp_expand_head, we would
    need to audit any code paths which operate on skb->data pointer
    directly without going through the helper. This creates a "known
    unknown" risk.

* Design a new custom metadata area from scratch

We have tried that in Arthur's patch set [2]. One of the outcomes of the
discussion there was that we don't want to have two places to store custom
metadata. Hence the change of approach.

-jkbs

PS. This series is not as long as it looks. I kept the more granular commit
split to "show the work". I can squash some together if needed.

[1] https://docs.ebpf.io/linux/concepts/dynptrs/
[2] https://lore.kernel.org/all/20250422-afabre-traits-010-rfc2-v2-0-92bcc6b146c9@arthurfabre.com/

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Jakub Sitnicki (13):
      bpf: Ignore dynptr offset in skb data access
      bpf: Helpers for skb dynptr read/write/slice
      bpf: Add new variant of skb dynptr for the metadata area
      bpf: Enable read access to skb metadata with bpf_dynptr_read
      bpf: Enable write access to skb metadata with bpf_dynptr_write
      bpf: Enable read-write access to skb metadata with dynptr slice
      net: Clear skb metadata on handover from device to protocol
      selftests/bpf: Pass just bpf_map to xdp_context_test helper
      selftests/bpf: Parametrize test_xdp_context_tuntap
      selftests/bpf: Cover read access to skb metadata via dynptr
      selftests/bpf: Cover write access to skb metadata via dynptr
      selftests/bpf: Cover lack of access to skb metadata at ip layer
      selftests/bpf: Count successful bpf program runs

 include/linux/filter.h                             |  25 ++-
 include/uapi/linux/bpf.h                           |   9 +
 kernel/bpf/helpers.c                               |  10 +-
 net/core/dev.c                                     |   1 +
 net/core/filter.c                                  | 104 +++++++++--
 tools/include/uapi/linux/bpf.h                     |   9 +
 .../bpf/prog_tests/xdp_context_test_run.c          | 194 +++++++++++++++++----
 tools/testing/selftests/bpf/progs/test_xdp_meta.c  | 171 ++++++++++++++++--
 tools/testing/selftests/bpf/test_progs.h           |   1 +
 9 files changed, 446 insertions(+), 78 deletions(-)


