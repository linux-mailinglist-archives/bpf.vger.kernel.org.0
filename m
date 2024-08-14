Return-Path: <bpf+bounces-37230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0649952663
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 01:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42A00B2437B
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 23:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED9D14900E;
	Wed, 14 Aug 2024 23:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/faR22m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B8114F9D9
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 23:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723679907; cv=none; b=pqq4gHS5S1fHHQ9XHPOkDDMTNACbti0JOH9yu83P9e8BLQKD/RrIVWpZe54JM8LI9/UiLGgNKsRPXzM15+/CZG7ywjKzbwZlCDO017Ptl0vNIZH0wav2iwQoD9KWnpKOOroRgOBZ/cJxvuGHf0FufYgV1/VG2GIKjpbiAP4yKmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723679907; c=relaxed/simple;
	bh=2HTaOT0VsRh8V+1IZg+6G3ZQvChBDY9unY4ZmDn/x+I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UiZH0H68snLKpBOQHsm0OpqQtypyjvenAuiql2VZBEH6jrE3uFhYbdJpk+P29/RngPcvIO5E5v0HbGrkPmMbPoVoVYQG0TDzOOtgGiOncNkym36/YmlpF3Ik7XiUWwwV7whVSDahup918P3tTpKbXODMRVzPgZK49NaMrHy/6jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/faR22m; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so199407a12.3
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 16:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723679905; x=1724284705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BRJokMTcs64VJHknYnsxDilDKSbjJnDAhgxAir1bugs=;
        b=l/faR22m6njyWmT41hVOLNxsedWqz+ovJgImaOH3oJbA6XObTqXbdcc2XKKc9kEiWL
         yez9/+OtzXdpsU5BIN2DewiIyEsGZ6Oy5ea0bVNgWG5qJw3uE1NUbQB7vWmufVSgVN5e
         YgYXKhOu9MPW3jzz8663KOC7P4MStWCkNvKr9DbAxfcJaPKhBx35ircsseoH3EtBYWsZ
         LN4lZ8YERKk2ZJYV9BTZpQOd3UO3hjxkmmh3pIiWpsuSlUhPm8bw5TYV1PXahdoeIks3
         Ah8FZoGZi2c/w1zPvf13dQlOlWFJjqmN0KzEQ/ZjtjDVQYn1RyXj6EyJSZ8ogLPInRgx
         neZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723679905; x=1724284705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BRJokMTcs64VJHknYnsxDilDKSbjJnDAhgxAir1bugs=;
        b=DEjL01fO3ePW6Q9aVt9x0IFz0dpELkrEe2yHKaQw2FrtFXBz8pp09pdRhz0svL9Os4
         Lm3lh4Eu7VBZjpPA/4Y4MdDno0Fbh5olAo4SiZLBIqHCGBVkod2FYtIEx4Dp57VJXaGI
         dDW/cKW+wc4r/3hrwakIX4bvkLWvdqbfebWbX0VVS3NhV94b7DHr1zt/T8DCvUHQdkeP
         Q0XesUCkg8NP7IrNoVlq0Foe6B2GuhuUNsEWVV0l4mvgeK1reaWxnJaKpVGHJjOL5hDg
         +ru0/Wj4fYIbErOFGjrNTXhnYJZN69oXAlGJ+zLOBk7Zu0E8LorT/dsy2EA3TlG+Sbj0
         ookA==
X-Forwarded-Encrypted: i=1; AJvYcCVHqCAfS82mlvM4Kh0vsCVvwi1EskEv9jBZw7U33t7t+hGjmndPHZqPGAojH1dk45BQQCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1bftxMwzPzAQVqkdaEsH9gCWhR4M7UUeIWvHrfB5hkmDzOirB
	2MaZYs2yPtnEVrLy1PsSf50zCjATaahn8Z9OrJq0WPgQE7X8lIch
X-Google-Smtp-Source: AGHT+IGcbXezCLOxbSzPwH6TWzOstpqaP+H34QpjDVtKrZFQIVk73qnnbeS04VEkf3UWHYiU0tCMUA==
X-Received: by 2002:a05:6a20:c78e:b0:1c0:ed80:6e69 with SMTP id adf61e73a8af0-1c8eaf5f205mr6338304637.39.1723679904156;
        Wed, 14 Aug 2024 16:58:24 -0700 (PDT)
Received: from saturn.. (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127aef5229sm127264b3a.107.2024.08.14.16.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 16:58:23 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: andrii@kernel.org,
	ast@kernel.org,
	eddyz87@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 2/2] bpf: allow kfuncs within normal tracepoint programs
Date: Wed, 14 Aug 2024 16:58:00 -0700
Message-ID: <20240814235800.15253-3-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240814235800.15253-1-inwardvessel@gmail.com>
References: <20240814235800.15253-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Account for normal tracepoint programs by associating them with the kfunc
tracing hook. This allows kfuncs to be called within tracepoint programs.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 kernel/bpf/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 520f49f422fe..8b844d6fd041 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8303,6 +8303,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 		return BTF_KFUNC_HOOK_TC;
 	case BPF_PROG_TYPE_STRUCT_OPS:
 		return BTF_KFUNC_HOOK_STRUCT_OPS;
+	case BPF_PROG_TYPE_TRACEPOINT:
 	case BPF_PROG_TYPE_TRACING:
 	case BPF_PROG_TYPE_LSM:
 		return BTF_KFUNC_HOOK_TRACING;
-- 
2.46.0


