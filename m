Return-Path: <bpf+bounces-35193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 170A493850A
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 16:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F57A1C209FA
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 14:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436D2166311;
	Sun, 21 Jul 2024 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+vdjDKX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7462116130C;
	Sun, 21 Jul 2024 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721572967; cv=none; b=osH57JOkFxNdh5eWHKyporBV8wEKcKmiUkow/G1jEL//RSJu6w3hxwifimAfxAke0iB2fEGFyMCPoVA+DhufiL1OkdNGkxV/my8vmhKKp3zLPBbMG5TTykVs8imti7DxXu7jR2C8LBV5IWDz1TkTtHezjIn0cfvoY8J2DbB6W2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721572967; c=relaxed/simple;
	bh=m9OV2vyggZf3v8X/HMlM1/4Z1zG2UYAHfwtwc2Ooc+0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W1UC1p7gWfLcgWXyHDgGtkSq1TBHSUO1HLgROkhBCNAUaPw2L0TAWiei55wSsNmGjr9+CKGoLZbbsHYFdBGB2875WxYNyisy3e8PSxTUte87vzZojYgD2K069dfjDvLy5I4avQWdBVnc7wSuSaSg3aXVijjOH2l4YuaXnFJG7Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+vdjDKX; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2642cfb2f6aso672845fac.2;
        Sun, 21 Jul 2024 07:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721572965; x=1722177765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B7PG2kYxfNyD8rSP7TLL6VX9svrQ8K/M9h3Idt3Jgyc=;
        b=m+vdjDKXu3rWnzDHCrKCQz0vjD+w7ggkrQDcVGfv6uQbbyyq36EMHutvAf44qVKRsm
         TPP0MoGk5thxX/OEvLmzMAN7WcEtwMD3W2I8n51flRJ4kIEnpo6Y7sV/XvI/MwuoK0mQ
         gK1ounA1FF7fQKN5RUmASQMemmnKI37kVTYaYkb3j50rgGOEw46Y0G0bEpzeyzk4kowX
         o4nedQoiqeKO5dPuNwScWx8j/kK67pnUDDcTgVmhWkeQBT+9rQc/gOT8XNFsgIVdz4te
         bQhLw6JZV02SLQ1mxfmtrwjb5Y0sPhlT6pMUHbnmlTFcLjIhI7zMIKolrzEZsvafahun
         3wTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721572965; x=1722177765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7PG2kYxfNyD8rSP7TLL6VX9svrQ8K/M9h3Idt3Jgyc=;
        b=S2c7nJ+MZrB8jOqkL70X5ID6yaV1fAYBYw1+82q3DuxQ+vxY/ggSqMJ8i5IVW0pNsS
         E5iT8HQzUHsKAENqtVzjgKmKFVLqjyRaoWgVHLmt01be/Dd0U5KuWUuWPhq61GTNktIt
         HaLwfNx8z8d64qV1pQmz/WbWei2aW8sj1RJeo2plehOL2Hbto9ekHEKOPQXjnu6ncj8b
         pzL+dMJw++UmRFWYDQGB1Z4VVofLR4iVGnT7xvniicORBlIyei9esBM1UfjF63KGaO0p
         5Vfwdn3/0qJ1hk+R910qPtQg7LGl2Z1kMoL2zb1FnJpOoN+wEv/I6BZxbBD1oZQMNpao
         J5/g==
X-Forwarded-Encrypted: i=1; AJvYcCU8fb98y7KBapjpm+axRkSmLREe70kSVQcNsG2vXDoqH78wmUHlm9+fhFTf9OMmImSx9LjFriR8E2G3C82hqsqkWT/fhAnV4GruBXu0WFLIisQEaJRlSO1N3SetbrPPkE8t
X-Gm-Message-State: AOJu0YwgaWHdK5axOa+0zxSaX4ifyzScL7Ya6yDYj6w3mVh30+Ll4U6J
	grhPLO3wg8szx34umYtIYNRPHTgs7bEqPfFmKpvljAal7ABBPBDoZnU2rg5O
X-Google-Smtp-Source: AGHT+IFFO3KIlp8gr5C98CjzWTw8lsWS74u3GLAtK6elf5cfBvtGipZeFO+3wgSBZ1jeXkPTtWCqaw==
X-Received: by 2002:a05:6870:5254:b0:25d:7cc4:caa8 with SMTP id 586e51a60fabf-26121321cedmr4799504fac.10.1721572965172;
        Sun, 21 Jul 2024 07:42:45 -0700 (PDT)
Received: from localhost ([117.147.31.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d17f9a11fsm1617555b3a.204.2024.07.21.07.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 07:42:44 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	chen.dylane@gmail.com
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [v3 PATCH bpf-next 3/4] bpftool: add bash-completion for tcx subcommand
Date: Sun, 21 Jul 2024 22:42:38 +0800
Message-Id: <20240721144238.96246-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds bash-completion for attaching tcx program on interface.

Acked-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/bpf/bpftool/bash-completion/bpftool | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index be99d49b8714..0c541498c301 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -1079,7 +1079,7 @@ _bpftool()
             esac
             ;;
         net)
-            local ATTACH_TYPES='xdp xdpgeneric xdpdrv xdpoffload'
+            local ATTACH_TYPES='xdp xdpgeneric xdpdrv xdpoffload tcx_ingress tcx_egress'
             case $command in
                 show|list)
                     [[ $prev != "$command" ]] && return 0
-- 
2.34.1


