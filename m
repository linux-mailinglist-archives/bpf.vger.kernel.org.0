Return-Path: <bpf+bounces-58981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1C3AC4BBC
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 11:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB5916A8A6
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 09:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2261B253949;
	Tue, 27 May 2025 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIKuJYXN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9082475E3;
	Tue, 27 May 2025 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748339259; cv=none; b=aJertq3buDiZ2xyDHbqcUjUYsDqACV/DvdqAPM4spPLOgiTdsMUqIMyek4pXTrfSqlOW9PjlPn859ht+Yj70o6Sl/tlFKgeHAuxh9Ue2S/5v9qP9mqmZlN4M8aSt1XA5hQfZ2+QOjoObH0xDA2Jf3fud3IBWK0C1DoQEjfOsscM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748339259; c=relaxed/simple;
	bh=ZsPin+K2mtI/KUrLFJKqVhO3swVqLydjccPtBeJ+MAo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SHy2jLeYSiyJIi1hbQ3R3muat6MqRHXlxpkUyLkWL4kWWVFB8aRe949gkwdhsj6LkI24NeDyevDX/cI6Vl84VTDFC5WbQ3YHpvOUxkrNf/pLVnfmjxEyfL5VZkSaqVESNtxQ/LywVyWF6bCMy0X7vgZZtUZnGQ5M0rBsOd3JSBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIKuJYXN; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4dba2c767so1215795f8f.1;
        Tue, 27 May 2025 02:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748339256; x=1748944056; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c0CxjOcM5ja+NTdUtvuvYQPI3PuggwbDposRudOjRPI=;
        b=JIKuJYXNPl0a5Syfn3ZlwNnAncjdgPW+0vZRlBEmyw9+bq+1JFpCXa8DgymK+mvFf5
         XYnYJVl5vM0IEpgXBUcRTDcDTYrqSaJUsbatF3Zd2NDuivndfwXj1tSsWk3ffb+Qq+TC
         5/vBFHVq5Gn3xXT7JEniSNnOwoczDyAjbgYkP2vx6DEobnFGN6qckhhl7feqiMZMUD8X
         DuiB3scfUKBWDpPngUVGkYzh/Rg+8BNTsLA6bPjtYTf2HjVwXbSUKk9JyqQOH+SYfQ1W
         LOw3XZDPPEZHjlEB1DqLeb3iF6phQsd3DCzz/202kMQ7Eo1dZi/UbCnEafAznt1Wa/Se
         fuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748339256; x=1748944056;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c0CxjOcM5ja+NTdUtvuvYQPI3PuggwbDposRudOjRPI=;
        b=AhaR+xnkjjz0PY20ybzJBCsoclYSx99qJgJmACWQDq+EzPnyZ1Fj//jiH1h2GX8y+x
         xyenwVt0+eds7h7SwwOA5A0yxh4iP617/jEdPUiJhVcXQTvcbjD8pC0T7PFe5g8MMS8+
         +DvIvi/3binKbOCDZHvtuqtRWqD91Lo4RTQjZKqIX4CR9NlWHseiXteHb760xsqvdPVd
         HvrdPahjscXRIZbfrC5jG1uWoCdSKL9jqu4em77RLTfhyCFwHwZYEjyUHDfIGpiNvc04
         TQp96zgv/722YvyiVbxM0BHV4SU/JIntvg14U8JQQrHGEwodY+6NFTmIAPVLeiamn26C
         UNoA==
X-Forwarded-Encrypted: i=1; AJvYcCXNF5Qdpat15SORXMqJPbgYcaVgdiz7X+4NoE7h8DDTzVmoa78unKSU5QwdiGDhcJ+XWjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlcwXRvUoTeV1iiLGbgZa5ga9+OZP5zQNMphEoOAvQYJ/mAnnC
	rqKIefVLodmR3XTPOwcLn9g59PFprAzzcVeCbsfC3V9xLd3A0MMeZRWCDHuL6XiK
X-Gm-Gg: ASbGncthpxnViM/3l+meP1Y76GXxHWV2S+K/Hb4K/jfiidNn5z9cC0GH70lwbTfNpXj
	0xINLBJ1M6Uxh+sHey8DD1IFraRKo0iLwvc3DpUxA2O6+eHg54vmi4YKkDzTlEP512sp3LS+fCJ
	b99NIsxPvlwpFsh8xfkTxQnbr0gIt//8YED995fbyprFEeeqBMyTC7tSku0RRLBD4b7fWgtgYpC
	OkpCXNpX2c8tw/51TKCW3MxCjFJZ4MCjUbmu5RL1xXBYc3L17MdrWWCck6IOg8jxIZdaXxqjFIy
	7+wqU0+X35l/z4k8gS4MSGGZRlMMfpyHosGoIvpV0h2pha7241Y4zQi402ZeYANjwhywCjZ/EO+
	7mWafuoMFed78EihiHM3D87mzzzdwiDjKC05lSkaoX/OXLj1J
X-Google-Smtp-Source: AGHT+IHb19+UT7TOz0T2Qt6LXfP+LKceFYMw0c6xw9gLy5w5+e29NLGpTnoYjdLIm5/+jmQt3/4GEw==
X-Received: by 2002:a05:6000:2401:b0:3a4:de01:ff2b with SMTP id ffacd0b85a97d-3a4de01ff83mr4312691f8f.14.1748339256092;
        Tue, 27 May 2025 02:47:36 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00f6e2550003dabfc0.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:f6e2:5500:3da:bfc0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f73d4a3csm269599945e9.22.2025.05.27.02.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 02:47:35 -0700 (PDT)
Date: Tue, 27 May 2025 11:47:33 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Tom Herbert <tom@herbertland.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH net v2 0/2] net: Fix inet_proto_csum_replace_by_diff for IPv6
Message-ID: <cover.1748337614.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patchset fixes a bug that causes skb->csum to hold an incorrect
value when calling inet_proto_csum_replace_by_diff for an IPv6 packet
in CHECKSUM_COMPLETE state. This bug affects BPF helper
bpf_l4_csum_replace and IPv6 ILA in adj-transport mode.

In those cases, inet_proto_csum_replace_by_diff updates the L4 checksum
field after an IPv6 address change. These two changes cancel each other
in terms of checksum, so skb->csum shouldn't be updated.

Changes in v2:
  - For BPF, pass the new flag is_ipv6 to
    inet_proto_csum_replace_by_diff directly instead of calling
    inet_proto_csum_replace16.
  - Document the new BPF helper flag.
  - Fix the usage of inet_proto_csum_replace_by_diff in ILA in a
    separate patch.
  - Rebase on net tree.
  - Link: https://lore.kernel.org/bpf/aCz84JU60wd8etiT@mail.gmail.com/

Paul Chaignon (2):
  net: Fix checksum update for ILA adj-transport
  bpf: Fix L4 csum update on IPv6 in CHECKSUM_COMPLETE

 include/net/checksum.h         | 2 +-
 include/uapi/linux/bpf.h       | 4 +++-
 net/core/filter.c              | 5 +++--
 net/core/utils.c               | 4 ++--
 net/ipv6/ila/ila_common.c      | 6 +++---
 tools/include/uapi/linux/bpf.h | 4 +++-
 6 files changed, 15 insertions(+), 10 deletions(-)

-- 
2.43.0


