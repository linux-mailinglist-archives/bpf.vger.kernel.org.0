Return-Path: <bpf+bounces-45862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE64F9DC0F1
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 10:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20CB4B20FFD
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 09:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EB7166F34;
	Fri, 29 Nov 2024 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KKEIJ26d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA82B143C40
	for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732870849; cv=none; b=K12r0IFvSqbLboM9LnTFYGTikEgmmdvDM3dqiq3e0x+tGc5Wem0Q6lGwMNHKOWcIbQAq/DLI6kroy4IAwt2o8rVpFYdAnVTIPuaiwWzfvocuc1cKPX3ricOJBQNoPuajH3iVXl5BQYMFA+qyD4MUjLzLPiysp1zFBqFvFaDpXZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732870849; c=relaxed/simple;
	bh=kFR9PUIfM5ND9o1WW+w41Hok+j3QIJY6jvBaATu8WzY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cCh1EuX3AOLBW9iVAt5i5yqrAYjoeiyF+dgumNiG7Wbhl80UMIJ+SEgRqZY0lqENVPnAOzsqHpUERfc/gZ/T/sGN9QkPmuky6SS8QACj0BtYF+jN9Zhh0TX9HxN6aaCA8nBnu9HL34h/xd/eo0V33HflNRc0wzXHdVV4WGqRNGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KKEIJ26d; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5d0bd0f5ee4so133067a12.3
        for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 01:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732870846; x=1733475646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3jMhxXVf1QUdWvEy2vp558o5guO3soGdUIj9ntlxOTI=;
        b=KKEIJ26df9CYYCZVH1gQqZzmdmiBw+Y0KjZaasM4Tc9kj/DwQFOipPL8zyt4Eo5AM7
         Q4vMD0DmBIke/vVwLyvzb29VY9yMOEY3pWX/trNFL6KmWek9h/XooEBtgWXP8h0qp7fh
         vNRQ0t9ACYCA+xJse/fLtyHkjokR0rOWg6+NwRSrzPa5G1Nr6lWEbs7PEIZB0AhWWC1p
         ebBhFfJThW6+GqGMPd68xplwh+DACLVIL6JjHz+LEVXhtVCMm4Wp8AEtKfyiJnrVr/YT
         uzuc5QAxDatd9mfqstuIYBebxHTJcmlSDkxdrnWpLLceZTYv6tu5x1z4j0V12sC33uWa
         zvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732870846; x=1733475646;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3jMhxXVf1QUdWvEy2vp558o5guO3soGdUIj9ntlxOTI=;
        b=af0nROr37einPrE/slmeTlKCjRIpiJAaUPUG0XOD2MXA3UTxuvF9kuqHeW5uhmfv8K
         9+fkx8nSmZTP1pLm+aCjDATed8j47My4SZD/Aw83f7MddRDYDHX1oSctxc9G3asJ0bUT
         ASCTja3ApMSOkIqiWoWiI9s/AzCzk4TXlQyMqoTjPjwhR4qJ7WY2DoHCMdT02Tx9LuQ+
         dwG/bjyUs9CAxRrZclBeF1s4drH0sesrn+bCX+uWa8LrMWOC2C1THpx/kkZxLni8w+E9
         BY0e9JI6uTQ63ru60/M5q9RE+lR/Ltgd4RZKV9qXBYgOvlueFY8eukRmVzX2WhnFSor1
         /5rg==
X-Forwarded-Encrypted: i=1; AJvYcCVgRedg+zTDSjcM72iDUZqlnSkaXIu/lnbXdQWwjKLO+/35Q5qOahRrXkmMkYK3Z6jopxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEMuFkUV2pYPl4+57jQmsTGZQlOqqNE5s8CIlHA3ZeWtiLJPeF
	sylhqYKrT11ANYSboETyqR8EMWk90Gcxr0UnT6cxeHhlRsNm8PFnWM+zWvzCK0BBWacddMEBIQ=
	=
X-Google-Smtp-Source: AGHT+IG9mRl6GExluYMkHBV45dwKpB6OXH/vz/+odQj2Yxo5GTjngyEuQTo0iu+v+9DVqfFoPyEKI6ujFQ==
X-Received: from edbca17.prod.google.com ([2002:aa7:cd71:0:b0:5cf:db39:7001])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:2353:b0:5cf:d198:2a54
 with SMTP id 4fb4d7f45d1cf-5d080c56e0cmr8017762a12.19.1732870846213; Fri, 29
 Nov 2024 01:00:46 -0800 (PST)
Date: Fri, 29 Nov 2024 09:59:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241129090040.2690691-1-elver@google.com>
Subject: [PATCH bpf-next v4 1/2] bpf: Remove bpf_probe_write_user() warning message
From: Marco Elver <elver@google.com>
To: elver@google.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Nikola Grcevski <nikola.grcevski@grafana.com>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The warning message for bpf_probe_write_user() was introduced in
96ae52279594 ("bpf: Add bpf_probe_write_user BPF helper to be called in
tracers"), with the following in the commit message:

    Given this feature is meant for experiments, and it has a risk of
    crashing the system, and running programs, we print a warning on
    when a proglet that attempts to use this helper is installed,
    along with the pid and process name.

After 8 years since 96ae52279594, bpf_probe_write_user() has found
successful applications beyond experiments [1, 2], with no other good
alternatives. Despite its intended purpose for "experiments", that
doesn't stop Hyrum's law, and there are likely many more users depending
on this helper: "[..] it does not matter what you promise [..] all
observable behaviors of your system will be depended on by somebody."

The ominous "helper that may corrupt user memory!" has offered no real
benefit, and has been found to lead to confusion where the system
administrator is loading programs with valid use cases.

As such, remove the warning message.

Link: https://lore.kernel.org/lkml/20240404190146.1898103-1-elver@google.com/ [1]
Link: https://lore.kernel.org/r/lkml/CAAn3qOUMD81-vxLLfep0H6rRd74ho2VaekdL4HjKq+Y1t9KdXQ@mail.gmail.com/ [2]
Link: https://lore.kernel.org/all/CAEf4Bzb4D_=zuJrg3PawMOW3KqF8JvJm9SwF81_XHR2+u5hkUg@mail.gmail.com/
Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
v3:
* Collect Ack from Jiri.

v2:
* Just delete the message entirely (suggested by Andrii Nakryiko)
---
 kernel/trace/bpf_trace.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 630b763e5240..0ab56af2e298 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -362,9 +362,6 @@ static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
 	if (!capable(CAP_SYS_ADMIN))
 		return NULL;
 
-	pr_warn_ratelimited("%s[%d] is installing a program with bpf_probe_write_user helper that may corrupt user memory!",
-			    current->comm, task_pid_nr(current));
-
 	return &bpf_probe_write_user_proto;
 }
 
-- 
2.47.0.338.g60cca15819-goog


