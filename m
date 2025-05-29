Return-Path: <bpf+bounces-59282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B28AAC7BB5
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 12:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A98C716D998
	for <lists+bpf@lfdr.de>; Thu, 29 May 2025 10:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9392227E86;
	Thu, 29 May 2025 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Utx+Bfps"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD04DA55;
	Thu, 29 May 2025 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748514466; cv=none; b=ZjylK+eCDnqa/Zl7bBVoI4iwi+sZngeJGhgtzvpUXBvaczL7nfGcHlZ6xeNvYmThx91rXI/pbFKVdL+IisVZ6dA90SIOT95hn7Y+mVXfRA24BzCgf9vPLA+rdjyYnm9GOyjrZGEmoqBSbgmg6eIfhUukkFHju4r3eiSIUzuE1zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748514466; c=relaxed/simple;
	bh=xwXFY9UdZBSTps1MTWCZR1whskDuA0ViFIzrULuJ5Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aTH9firIc/4GXhzgnvTc+uxNXARMY5AyUUqgnEghoiCg+qS9lQ1x/2fFkdILQ8YD6DkRpx1mCZDYwmxcTmuQlIAKlJD1o6DOyu7yYFb8x0F34rPYEfDda07T4w2bbjHYS1cNADCASolouYf1wn5QpPQfQHoDxkpgAHglZWY2MMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Utx+Bfps; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so8280955e9.1;
        Thu, 29 May 2025 03:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748514463; x=1749119263; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N+AefZyy5EAJz83R2KsC5kPBXhXauBKCBzOFKZkWLAQ=;
        b=Utx+BfpsqRFd4PibHoxth2ThdSk18aiHv3UOpnRynTqfbkG8EFyji0J7T1eBBkvr0J
         IYuLs/0i3yCy5WpvBMOw70+Cq2ZNq35f+ZRgzenlIR69GAczcXs1PSxqizeCHX95FusS
         vvhmioY2I7WT+s9kOr1R/NYTHhiH+MiliYUv9TwcFwxa+Nx9H2xVzJ6xbKkEEiW/j5W8
         cWOBgPQqFPypBODTqak39Ij282SDy0OrPRyO0qtBcrnFP/YVwzS1RhtoEt9IY9OoEkF1
         pXcUqrLE0H76qWt31DfGhJy/zW6WAWaWAk9t07EQYj7qZNZeN3H1i4ZA8QXiSyWP955v
         rrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748514463; x=1749119263;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N+AefZyy5EAJz83R2KsC5kPBXhXauBKCBzOFKZkWLAQ=;
        b=dKlwRW5B5yU5dl7zJUZrPgNg6WDyv4OjgW3Z+FLTUjdsf0FnbGlv6shclPdY5H6Elh
         4patuuVkkwQoVs48JD45fbxjAW9l04GUc/U0rN7bk5n3/to/vUS79v0MtIuC73Esx8Dd
         iPRsqIRB591HjXw44Q5H+O5tLM4tOdXTGkzd8XC+b/3JIfDH4Q/s9K+KP1mt6PFmM9zN
         hDZgmxXkusz5DxRtBGsv4DU6quk+VZLq0FDLuSH9tTNkew7CaGDmeMbVGqhSF5qfm8lC
         ROaqUW9NECwa3pi/Su3Q2sTznf8G2ig0nsHJ2WwJPqZw5pAA/K4o3w61+WK9KstVMR7c
         Caxw==
X-Forwarded-Encrypted: i=1; AJvYcCU3thpmQsoAaIJ/kr6rQfdtlUeW8oSMZqyBv4w91+g+ePgxhH+8aIeeLkZHdePop5o/8VA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcSUfbucIdo33LcsqKab0YAZo26r25NLX7UiWYPvMoIUoFXxNN
	AWx3u9yNCqwBZiY/Bss5pUHdFP97Rrbcignpv24LMpUFfkXT5I3B1L+J5BLgG/Y/
X-Gm-Gg: ASbGnctpxfUV9MHXe7MtzrylzW/suvPyJ7Y0h4Zfus0vOu2PJrqnLM/cuc/Efer2VI+
	sWpeFtH+I4jV8xSeHw+TgTgnVzZzYwvUmXpOkBWA2xmzm+Zsu5TBpGut3bt8K/J+yCitwQvtBVG
	Y433POwlRmYMv0gkAVDCF1+H/D5IYtE0wxDdqXdS2uMbVb6/Tg/z+k8QrFiqAkmg7V7q09J2GWh
	a4uv4elj52hyFg3xN5RHGZ/P6DlZX7OR5ZZ3SJDcFFEMy+wXa2AJXTXzwXKPmn4ETLtgSc7uGVu
	diGHMg/PgnSWQwXzZdOvTQfAX9CN1yrkpcALibYiGZGPiKeQrUIpDxVMZB+1bbWfhM/lQW/wRS0
	EstldJ+G4NwcR+TE3i+Qr5Wj3Wc4Mc17c6VSdyArq5Ove+MThNjaWKnbhS01Y
X-Google-Smtp-Source: AGHT+IEnk39EgwFTzhew+vvAIglWFMhE6eZ3A3PYqgJ4o9slzcECgwXJwZntpV6M8cxXOMAOg2Nb8Q==
X-Received: by 2002:a05:600c:3f0c:b0:442:ccf0:41e6 with SMTP id 5b1f17b1804b1-44c917f6760mr244803945e9.3.1748514462788;
        Thu, 29 May 2025 03:27:42 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00bc44bdc1afbcf705.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:bc44:bdc1:afbc:f705])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc51633sm15732785e9.24.2025.05.29.03.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 03:27:41 -0700 (PDT)
Date: Thu, 29 May 2025 12:27:40 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, Tom Herbert <tom@herbertland.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH net v3 0/2] net: Fix inet_proto_csum_replace_by_diff for IPv6
Message-ID: <cover.1748509484.git.paul.chaignon@gmail.com>
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

Changes in v3:
  - Rebase.
  - Use proper tag for reference, per Paolo's suggestion.
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
 include/uapi/linux/bpf.h       | 2 ++
 net/core/filter.c              | 5 +++--
 net/core/utils.c               | 4 ++--
 net/ipv6/ila/ila_common.c      | 6 +++---
 tools/include/uapi/linux/bpf.h | 2 ++
 6 files changed, 13 insertions(+), 8 deletions(-)

-- 
2.43.0


