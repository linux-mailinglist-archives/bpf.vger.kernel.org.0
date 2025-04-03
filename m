Return-Path: <bpf+bounces-55225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6B0A7A4C6
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 16:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F5F17668C
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 14:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644DD24EF94;
	Thu,  3 Apr 2025 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZUJjLtd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCD024EF86;
	Thu,  3 Apr 2025 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743689332; cv=none; b=RRDkZGyt+cq+xLqPAZ2EN3k5SMKmd97cNiM8Reri3hxuyK19TqaqTAIPhMEhHH/FtoIkPhP+fAnN/vTmHFvxwDxTJGnI0hJsUhBGgq214Q8zsU9qRDMgTHHb8Lhhv03prmV09VMheLNX1ua6+xYWlXMDHAOPCwcqBK4FWl4CWaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743689332; c=relaxed/simple;
	bh=8uYo024WLm4EllTFZpqKl5MM+ZCQE0UGN0kobHgcJVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p+BlHCWfaFg2Q6+5bAj6vTnbfdtFfRR5V7pPS4b2e4CDx07Rxg/Z3bxRt5lmJdfSxd4O6oMjDNceb6tuEgSCYi1KBwdwoPWVta5rBuX+hjoQ/9EsmW3Va84ToEp2cgWt3NCL2ex7JfJn57EXOebPaEgp1xldJIqDlr0knw9w2q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZUJjLtd; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8f6970326so8732116d6.0;
        Thu, 03 Apr 2025 07:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743689330; x=1744294130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Km5+XEZJNgqkv+i1cBiye0ejQCdeCAoxyfb3tPfnuA4=;
        b=NZUJjLtdbYFxAvPCDPIXC/elMrQMoohz2VGuoCwHt7IFs/Kc5wJvHU/cdaxybBBrWs
         burGPoj/rWLZFEk4DPzob8JK/e8Jx0KhWcmXJdPT4Cl+Fibc7BUAMCDx3ljzKCz+zlbi
         Ev065D8tSMgdpR8LrgsNcPy0ck/E5S6po81fcAyJoCYg+B/VoJARe4Vy2deyQcA51CRF
         7IKqFZL9nU3usMRDr7nvrXL+SIpYCMvus71m1lAvbZDRKTEqY3dziyY+SjuKU+ES0blM
         Z14V/s7YPLxN88AHzO/H6zkCqY/mrhiQrjGrFANB/VKjwO6A0mVh+zYnM2KnYPUghi2a
         bupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743689330; x=1744294130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Km5+XEZJNgqkv+i1cBiye0ejQCdeCAoxyfb3tPfnuA4=;
        b=c3gRoDY3T/fwk7aMZ2ftL2UJAqHpDdRRpCWTshGGQahN6/S350BJxlXWJd4GtlMRrK
         yEDBq0Y1blEEMKxMm1XdPYwlUE3g7fZ6OpOyJm+5G58oB2fV6zjKU24B+vUjegD4RVWE
         0k0jNPdFmHFM35HJn10thNdZ/lXwo/TZxi+5flF3v+9Mm9L7lwBrZLs0kjboAs+cyObK
         sNvWgyVTk/Ob3OY9mS+jqZvZVZlqi6fbePo73E8FWe1SlVIwSXDxEdATQNdcbFEy5SHV
         x7gy/oKp3FGariB4g+pe8cxVodPYwoKgfaBKKsY+JG+/FC555IF1aHRGNAy/OlyS3ruH
         RCqw==
X-Gm-Message-State: AOJu0Ywnt1/peIOZz0TzUDDzYEfWfKlJnR1d/eHNW95/NQckJg0mdPDu
	YBbU9pbDuoydtRLlUnOidRTx+lnoVIEQdsFaBc8fweYey4co7RqCLQJgIQ==
X-Gm-Gg: ASbGnctFbJywI1qXI86ffLYr48p0JWzSm9WJoenacA36sBzHvB0IRWUJL682mM70DvY
	ZeJ4/kTyaTHeGM5N8Pb31SIyr2ZhqUSX66l3WrOzVwk0DOE5yYNhPWxIo+lW0EbT5l1znsYau6f
	lKut98QLa0ER3S5XdJU9PRzTWNTRKV7DMtZKanoxRzHSu2DmtYKfdzLvTRoWTgu3sgCINt3n++A
	5Vc7OpXxoLm1NFVhyRUzkhrjXdxInSc806BZv9yZjvB82XFXHd6PovnbUrootn+Frsls6qJ090n
	P+jOL9x6AJePRqpypK//8V0nPVvFlRBd7mQ6CdbzMYcQqdr1pQoBH5fL1b+Y1PIwRF9COQkGiQO
	yIG3n12PmkorIHIEheADuZXfnBGBu/BClflkvHfVaucSf
X-Google-Smtp-Source: AGHT+IG8TsodMjYBZQkmYunDHbwX6AV5pGugniJewQMHCS8zd3LQnW9AvmIiLvO4CZPnFbNqaz4mFA==
X-Received: by 2002:a05:6214:2a49:b0:6e8:f4e2:26d9 with SMTP id 6a1803df08f44-6ef02d0d895mr97359936d6.35.1743689330020;
        Thu, 03 Apr 2025 07:08:50 -0700 (PDT)
Received: from willemb.c.googlers.com.com (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f16535bsm7895946d6.123.2025.04.03.07.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 07:08:49 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH bpf 0/2] support SKF_NET_OFF and SKF_LL_OFF on skb frags
Date: Thu,  3 Apr 2025 10:07:44 -0400
Message-ID: <20250403140846.1268564-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Address a longstanding issue that may lead to missed packets
depending on system configuration.

Ensure that reading from packet contents works regardless of skb
geometry, also when using the special SKF_.. negative offsets to
offset from L2 or L3 header.

Patch 2 is the selftest for the fix.

Willem de Bruijn (2):
  bpf: support SKF_NET_OFF and SKF_LL_OFF on skb frags
  selftests/net: test sk_filter support for SKF_NET_OFF on frags

 include/linux/filter.h                     |   3 -
 kernel/bpf/core.c                          |  21 --
 net/core/filter.c                          |  75 ++++---
 tools/testing/selftests/net/.gitignore     |   1 +
 tools/testing/selftests/net/Makefile       |   2 +
 tools/testing/selftests/net/skf_net_off.c  | 244 +++++++++++++++++++++
 tools/testing/selftests/net/skf_net_off.sh |  28 +++
 7 files changed, 317 insertions(+), 57 deletions(-)
 create mode 100644 tools/testing/selftests/net/skf_net_off.c
 create mode 100755 tools/testing/selftests/net/skf_net_off.sh

-- 
2.49.0.472.ge94155a9ec-goog


