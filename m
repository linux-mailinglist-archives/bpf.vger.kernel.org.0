Return-Path: <bpf+bounces-52502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19193A43FAF
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 13:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7303AD5BA
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 12:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC80268C42;
	Tue, 25 Feb 2025 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsutDUls"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494D720F076
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740487857; cv=none; b=bUqWec8nEfRm/NgoAUg2IFes7mrk4vbhA8EJ9RsOyjOHPzeeAIiS7uC/zEoG1Id1NoUCvN+3x7tAcKzBzqkWGsWEFDHCMxfUDnV0evSPX7+uk05+L/DlJypEBtU/HncJYgh1Py1J+q6WWzrG38+Ub6eOF++swAYjyFO6SEGlm7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740487857; c=relaxed/simple;
	bh=zuuaeT7k7ObWA72KwJ6gla10Lt3QEmlpIldiUMnKii0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L/nwQ6jnDE1C7Nr+hhfMeR++l7FtzJNul/rYsan/uVqDLDAJlXdwHPayrzNeFhKaPLvFvs3dMDz5ii7TeNPaswYXBqKpFQZMTyZJvMeSSGUfGRdKgoZvY4xs8ZQreO8dEqqMIIcc6xlbM176hWKA9Y9PLL7SEOr5/3pQTOhaKZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsutDUls; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43996e95114so36445865e9.3
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 04:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740487854; x=1741092654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cWiQyK4ZdwKcFeHK3xe7qcRy9uI1f2Soyvje88uIM70=;
        b=GsutDUlsu2MDEfK0Y7jmjVlzhOpKRMkJhFQRZlSBBamvmAukrUXQ1Lg97HsHjO4dNy
         waCm6A1shbJH6BSTv5xRTSkN+7bWNhFi7GUodN9HVIre3Sjrnw0fecPGusu/EEv7orX1
         HWfDQvzxqWi4ZFKCJInTb8pjOHucgIieLuAm0vj8nusMoxFs2mbrkYe8z9j+eOXkfHmN
         c4ms+6UJvnNJXr5cXy7tXvIFH7ymGexO49Zd8umrY7oK9raExwUQVhOeMmvP1Vl3zJnE
         CpgFFeItV5cVjLZQkDsdMlFI/wgbGPCEtWfygCmVgz15YvqAIMKgpIFpDJzELJuvyxKa
         uFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740487854; x=1741092654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWiQyK4ZdwKcFeHK3xe7qcRy9uI1f2Soyvje88uIM70=;
        b=fYMB52PStfdHkupWSqoLWpHGk47XGeUYEouFShI2mTGKL923dHBVOa2Y1cu7xKk/5J
         fLYBLbUamIe3+XqsyVgmeD3SOH8Dyd3YDjArpeWvgPq5BpIwCQTaVyI/2PgFZgsdOhzn
         SgTtv6YKHxjKWv7aZOlk3yV5OIpJZTPNMacImHtWU4BiBY50jMv2Ytvk2nMtAlO26N9t
         BC6AGj/DX5iQXQUnYSepr524iLC/ZntJu1fLo0WlWjW0QgbqIokXsew9zgFLgWSdsyLw
         vMyVYeWQ2jECEVtre2YA4XCqSlVqkOUhWgH7Vt7bB/KPeF0AwOtcQP0Q2Pz+R97NVxdj
         tI1Q==
X-Gm-Message-State: AOJu0YyZDdwrEmZS8OwIyznD0OF1CNUuQU3iuXkAMd70jW6XMvaBVxY5
	0+MTZxybkU43/TIuxDUnWu2R6JynjUtPYQfTTWQ4NDjECxBRqslqwgRwILIj4bs=
X-Gm-Gg: ASbGncv5HNy1DxTvFgUlWAmb+45V43DOfHeLBf4D/Z8NNUWQtDK6P/KrxaWDhlEkzr9
	Tvpxf4yKLn9SPDVt5M5jZou/j/vCdiZ9Ri+se4viKPsEGKadZ6KpaHSF2cxa6yB036MtvoPmOQ2
	Uuz/mbZQbef7g+3/iY/CxAwRG+/voA82Cpu7Ntb0/A3yvbrrdl4zz/E+XthFrexJDo2EKGrQkEO
	qmF7T5a+FDhaC5QBAsc1eFp9RU1d7JQix/U84qchCypiMuWyiFfO8sOO+C3bUM6Z36iIPVu081p
	SNFceb7VSC7j5RoZgWuZUSGrURDpUP20dijT9DLxcEQoupX7/j03XhAPdzRNje/7MgqS5OdzXBJ
	ey7oAap45WCMKJ4uaLd+jPTaZlykUWO8yhZKjjQ==
X-Google-Smtp-Source: AGHT+IFHq0dhfv/2LPMUG/Lj0wRNDmma2H/iehc5wKPYFHgonkoL0Gb5v4jdznXSTZnjMkeuLp/7jg==
X-Received: by 2002:a5d:648d:0:b0:38d:d701:419c with SMTP id ffacd0b85a97d-38f708279c3mr14740390f8f.41.1740487854387;
        Tue, 25 Feb 2025 04:50:54 -0800 (PST)
Received: from mtardy-friendly-lvh-runner.c.cilium-dev.internal (72.253.76.34.bc.googleusercontent.com. [34.76.253.72])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-390cd8e7165sm2194754f8f.73.2025.02.25.04.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 04:50:54 -0800 (PST)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: add get_netns_cookie helper to cgroup_skb programs
Date: Tue, 25 Feb 2025 12:50:30 +0000
Message-Id: <20250225125031.258740-1-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is needed in the context of Cilium and Tetragon to retrieve netns
cookie from hostns when traffic leaves Pod, so that we can correlate
skb->sk's netns cookie.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 2ec162dd83c4..827108c6dad9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8075,6 +8075,8 @@ sk_filter_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return &bpf_skb_load_bytes_relative_proto;
 	case BPF_FUNC_get_socket_cookie:
 		return &bpf_get_socket_cookie_proto;
+	case BPF_FUNC_get_netns_cookie:
+		return &bpf_get_netns_cookie_proto;
 	case BPF_FUNC_get_socket_uid:
 		return &bpf_get_socket_uid_proto;
 	case BPF_FUNC_perf_event_output:
--
2.34.1


