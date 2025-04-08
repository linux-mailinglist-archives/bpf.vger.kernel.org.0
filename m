Return-Path: <bpf+bounces-55454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C833A80C70
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 15:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC0D4C58E1
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 13:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398DF18DF6E;
	Tue,  8 Apr 2025 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnvV1DTE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA118CC15;
	Tue,  8 Apr 2025 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744118919; cv=none; b=qHJjLHuP8Fy1V/6gadFIYVA+V8oFz1jq6aERqpukKbQGrg8Ls4yDl6Jdk1q7XYiWrqOEXHwXl9xfdiMdLKyhA/TeMz+zJ3xTWbNhBVzW1RMHPAzWWSXo90SLAYKk6YZalWvwjuWmD8B2Nn4Jw77zlhiV9J4uMPZ1tX3NFp/Vxd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744118919; c=relaxed/simple;
	bh=21j9da7q3NlFSSx2GtZUa9Xb4NUiXz9aRzERPoFZ6To=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i7wRZO96LZp24SzSi9hSz7XOFYJuKPgKqYhmhbahB6fUCTLTiFJfAT+mA8O8nISYjCHus5LUsx6XiVXGh+bhR6RGm8HVlOotWxH+MK6NqGuWPCxFa4LrfNTMzW8/50YASC8iW33vnou4W/VA7swbrB0C1UwC/m+OcfnbHAbFBVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnvV1DTE; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-476977848c4so54827081cf.1;
        Tue, 08 Apr 2025 06:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744118917; x=1744723717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7+iaTxL8ARtdWzLgOQEU2xCbHULLRFHtSfntbcQs7c=;
        b=EnvV1DTEiy5SJ1Mr0wzaJke9Pag9yrpIhmwRtQWLBDlpNzspMHANjtAl1By0HvVsix
         AHg3OjLj0uLJWMzrRy5NX7k9Lu/9aQML+VFzts66FGiB2TGVfFpv61E+ejKRb39jlOyn
         ek8EoWU7Pg6AuTBts93NbfQHtgrnkeJvH5ruP1eS1It378fYrriVN6WNJbEZ5aPrgvO9
         zzKZ586l3ZXiScK2lvfu/Z1JXUySP+tfaXPkuNSsCjMEB0dAYG8S/qi3l1Ea4JWZiBCc
         out/iyteuU2w+eQmxG0bhOJoz1GQv6q1EtIVwm5xyPdKuuujqBa0KYkNUPcEDsemIAcn
         s6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744118917; x=1744723717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7+iaTxL8ARtdWzLgOQEU2xCbHULLRFHtSfntbcQs7c=;
        b=PK9wraPOY0lNCw/Hes4mAZnVaT6aMq7jZwi07uOdknpNsfe7T2bnKZgDfG4ln/+GzJ
         50/3bZ5vL8Ogs7BDRz3RcKPTG0nAXFKR+wdA4228hTnwc+KVJLK12rT6tg6H7so17qtv
         wWeYWrsCfsJuTA9Jp3yYVWwKFsLH3UQSDlxmzcHBmqSjgnFVDoyYTkAqBRNwPwYvjht8
         EG9nByPpzQBzMnFQfdI0pYCLf4y7+m2i4lwb+6goCXe0n6t9tzmuR1B2ne3ni3wf1bLA
         ziwrdRLM3o2h3NkRTwPKB68oMvzyntIB7pItNeddyZ+ptv8baywxpe7tWvmSI3WW45WD
         jZxw==
X-Gm-Message-State: AOJu0Yxl/TVCie8yGc81ctVxxXng/g+nrssccpMc9/tTOZz4LdfMD6kG
	1e9KAn/02MBYdePlQi8KA3io42NYjd/pNhTp2kS+RAZlv3/TqtFw4bPbSg==
X-Gm-Gg: ASbGncuUhy8S2StuhMDPWUfbyC4+em0AFrOvT+LnWuFwZT7kmRlDQ7cUyRwjVhDmQtj
	V0HPB3YJK1jxrDx6pk+6CFVr54DQw6GMwx3eIzw467Zb5XUtVlc+79s3CSjlYy6Z9Wa/oOonayC
	OjW9XpdAGTg4y8//iAY4kNB3QuP92847885vYYyfn1LBYuoAKNf4b+J3pWICMtzlBxwI+ycB8Na
	3FmmfUOzTczSt81nUjolp685PP3TSYOvbyz0NUjpxKFXxfoWTl68hr06/91Znyu0s+xQq0sDMig
	I4tvtfSRKQV7MHk3u5Nx2grKouf4h9ouViC8KWpvG8EtkH/z2SgyGcFWZcaNoDSG6QYWwkH3lrs
	XMX3z0Abq+QH0rpgvJ3WZinsV+9yLyr5WkuMgxXMh/RI9
X-Google-Smtp-Source: AGHT+IG+mRJGEXDnFEZI5+ypK2ZGvv+xb4VlZlRO9ygDphP0ApHgZfMOGgtAalznWuES5iWjuaBkCQ==
X-Received: by 2002:a05:622a:1984:b0:477:13b5:f25d with SMTP id d75a77b69052e-4792594f24fmr219901521cf.15.1744118917020;
        Tue, 08 Apr 2025 06:28:37 -0700 (PDT)
Received: from willemb.c.googlers.com.com (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4791b07125asm77413551cf.20.2025.04.08.06.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 06:28:36 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH bpf v3 0/2] support SKF_NET_OFF and SKF_LL_OFF on skb frags
Date: Tue,  8 Apr 2025 09:27:47 -0400
Message-ID: <20250408132833.195491-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Address a longstanding issue that may lead to missed packets
depending on system configuration.

Ensure that reading from packet contents works regardless of skb
geometry, also when using the special SKF_.. negative offsets to
offset from L2 or L3 header.

Patch 2 is the selftest for the fix.

v2->v3
  - do not remove bpf_internal_load_pointer_neg_helper, because it
    is still used in the sparc32 JIT

v1->v2
  - introduce bfp_skb_load_helper_convert_offset to avoid open
    coding
  - selftest: add comment why early demux must be disabled

v2: https://lore.kernel.org/netdev/20250404142633.1955847-1-willemdebruijn.kernel@gmail.com/
v1: https://lore.kernel.org/netdev/20250403140846.1268564-1-willemdebruijn.kernel@gmail.com/

Willem de Bruijn (2):
  bpf: support SKF_NET_OFF and SKF_LL_OFF on skb frags
  selftests/net: test sk_filter support for SKF_NET_OFF on frags

 net/core/filter.c                          |  80 ++++---
 tools/testing/selftests/net/.gitignore     |   1 +
 tools/testing/selftests/net/Makefile       |   2 +
 tools/testing/selftests/net/skf_net_off.c  | 244 +++++++++++++++++++++
 tools/testing/selftests/net/skf_net_off.sh |  30 +++
 5 files changed, 321 insertions(+), 36 deletions(-)
 create mode 100644 tools/testing/selftests/net/skf_net_off.c
 create mode 100755 tools/testing/selftests/net/skf_net_off.sh

-- 
2.49.0.504.g3bcea36a83-goog


