Return-Path: <bpf+bounces-21181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7389F84916C
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 00:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02CA81F21A99
	for <lists+bpf@lfdr.de>; Sun,  4 Feb 2024 23:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC1C881E;
	Sun,  4 Feb 2024 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsRL0R8r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBF7BE4C
	for <bpf@vger.kernel.org>; Sun,  4 Feb 2024 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707087757; cv=none; b=HVjyF/CruuGn4LKoHcJI54PR7UKFqmK/se57teOWWbP5XLx48anvUGwtyZqepRBMUiTmuuH11Rk5oXsqOlI3Iak76wvfQsH5qZYcRUW6uxGPClv+X2x6e8S5F8euxvLqrkJDwYlC3nGNScCdWCN+Venwd9LsmNY4qDdqCm43pXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707087757; c=relaxed/simple;
	bh=L8LWotlhArwoeo2Q1RVALC5PqGKOZRAUNCo7GqXBpEg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TsCswAf3ZPywPF4WJEcrFYamCwWYv7rRwX5hzZItq9Le4K1hVtaeivT50CZrvM/+uvQJU9gT/0ZYjBI8JQ4SIx/L8wgtO7TqKiHfSxaP1OZfVh5SFAf9iGWGvUjKtj1QFE1lA6LdNxFqWU7xrSeU3Ykiht0viYGDjjv3DiVQqcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsRL0R8r; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a370e63835cso266276166b.1
        for <bpf@vger.kernel.org>; Sun, 04 Feb 2024 15:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707087753; x=1707692553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SOlICQskXbyYksNOAL6dY+eaHGOg9cBGMOuUDHjMDdY=;
        b=jsRL0R8rL2ees3GovMTOW9ZfeCdsCVyQYNn+3yJ4HDVVi15SdLSUKy7PqzXFjBo+Ze
         QhQIAKF4zWswa7qQbG+hJylV/mCWOofh8GHZY/9sfStRpcfN256+TPAJpiXWB+vnM5sd
         rpA/0K1MhxtWGsFBAYMKmXRG+vvdciCkMd6aXo8lG/VtKvm8pH2uZ3P967wk8PQEEzTH
         jDgyOLC+MqJ6cf3BjWyy1xY9sZIwY/7eEtTHy1JVBR0Qm/urwoTJCQY6cJC2bw9J5C/X
         Zynf8gqY3zZn2eodrUY6cCkelIR20LT2Gd2ElwfKEeWvyLOq5RqpXdYzzX+Ht3dYqxPF
         4s/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707087753; x=1707692553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SOlICQskXbyYksNOAL6dY+eaHGOg9cBGMOuUDHjMDdY=;
        b=NJn3xWCYpn10uHQADW6vJ4Y6jG5Cpc2jP6LkqVpJUsA8dfogjgzzjTf/FJT8R/hMRe
         zsUMpxAWdCTpzC8dGxgIwK0TJQRdNp6GNIUyp5ntEac1f+Q3dfV4uvARjxLz8M8dP8jZ
         DRUdemikWKsJVscHe9nDPZZwzEwLdwYX1TW7pNonJy/fA39NAJB5CbkVTU7bYqtP1Rx8
         fdlEErzSA5cALt/E0X1yTqDS0muDiT9b2ckXKSysM+ah0Qaq0Zge9V8Q9ZIbludz9imD
         fWfQYWh8n8eW2WvJcRkijK0qE5fNZuDceAbEi2Vw5+VHllrXsm9dJjXe7L7wYPyLlbF5
         ZjSg==
X-Gm-Message-State: AOJu0YwgtqdJzPzlaqViN5u+/xVcUin5HKJ+sNzN7iNHHxg/iNO/G3lf
	quC2ZymBvtl76i3NSfCKEDadcYowXZpt/Npc5vvJOKHTs06c8i4HIa/GIrU47M0=
X-Google-Smtp-Source: AGHT+IFDia9M6Zu6w50QK9PfD4uYs9ngrKi5Ip+94L4RB7W/0/lPDLJI2ve5oaypTzXP1BjF3nEjlA==
X-Received: by 2002:a17:906:19b:b0:a36:fd11:984 with SMTP id 27-20020a170906019b00b00a36fd110984mr6361390ejb.5.1707087752514;
        Sun, 04 Feb 2024 15:02:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVRIpaGg56y/qGIihq9hQQqIEgCUtou508FDo9uO0U840xdYid9BokAqL4sqdmQGBw/i/FYmOleQo8HIxkpQ4hdWFTjZbG/2XnWWW2QKJHS+/jykBIJRe4Wm5jwpAiOahT1P10yiBqigJEkv5z3mC0thiJIwt5cl7uX/JkBlW9fsRdv8xgW8dq5m2F5zV0JBUuhFbWOfl74pl6f2vez6AS35OVtRNgSR/ocVg==
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id vb9-20020a170907d04900b00a36814670cbsm3614077ejc.62.2024.02.04.15.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 15:02:32 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v1 0/2] Transfer RCU lock state across subprog calls
Date: Sun,  4 Feb 2024 23:02:29 +0000
Message-Id: <20240204230231.1013964-1-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1245; i=memxor@gmail.com; h=from:subject; bh=L8LWotlhArwoeo2Q1RVALC5PqGKOZRAUNCo7GqXBpEg=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBlwBeAvDqTPCSXD5knhWz47Hm1AettXMuQQzP1Y CG1hepadc2JAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZcAXgAAKCRBM4MiGSL8R yrWLD/0aoiq2tyyp4npKbtaMrMFkjiu5AxyTv9s7G0JV+E7upDwza38V6uqq90N82nIKu4dC54T uc17yHok3HNqUhm72T2AmVrqOhRF8fHBNyceXXDvrkJ2Pc4y7HfU0oCcF37N+t/x/oLK1zWHfJP 4dreDHrIJWrYYazwFZAj7/aCEoiH0zgHZKPD0nKlrU04J8T0wohynhmX21oieXknLCF4Wkq99/6 f7N1gQAnlNrHj7uA28TwlKy7Fbyz57xjwmaffRrMXjHvvDcNgVTfd9cZX6zuq+Rm9gL9lgLZ2Sj KUao5Maz1IiFfX0QQMEtnIUhjDpxgDxG1XbtXq1ngaCtwkpZ0+pX/fFDrz8ASTnc7TUQFIf7cWU lXE1TqtT80prCxtKW2p3UDBVwu2OUyXfCljlMVk5COg+FPJTX0aqUSVmYWqczVyIHZt1MPEQXlP q+tH7NfTjqZhBDrJoYbaoyE9wB7Un+lEbanIVIpai2IpYlEDEv4WlVTFqXQ4J2UN8VB2Tx5JbxI 1sXqXINs/h2UTQlf39X7vloqRb7vMX/xXa7ZSwLSwGZYe2RLyNGGWKh1B59dTlUKHk6DW838kBL t/LfV7LJBXM8OL4QVoU5wO2RimsG97LpuJofOsZgyhPwR4zazT9bnOkUOFnSroZ4HLpcgCjZOaM LebihXfcD4f2z0w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

David suggested during the discussion in [0] that we should handle RCU
locks in a similar fashion to spin locks where the verifier understands
when a lock held in a caller is released in callee, or lock taken in
callee is released in a caller, or the callee is called within a lock
critical section. This set extends the same semantics to RCU read locks
and adds a few selftests to verify correct behavior. This issue has also
come up for sched-ext programs.

This would now allow static subprog calls to be made without errors
within RCU read sections, for subprogs to release RCU locks of callers
and return to them, or for subprogs to take RCU lock which is later
released in the caller.

  [0]: https://lore.kernel.org/bpf/20240204120206.796412-1-memxor@gmail.com

Kumar Kartikeya Dwivedi (2):
  bpf: Transfer RCU lock state between subprog calls
  selftests/bpf: Add tests for RCU lock transfer between subprogs

 kernel/bpf/verifier.c                         |  3 +-
 .../selftests/bpf/prog_tests/rcu_read_lock.c  |  3 +
 .../selftests/bpf/progs/rcu_read_lock.c       | 64 +++++++++++++++++++
 3 files changed, 68 insertions(+), 2 deletions(-)


base-commit: 2a79690eae953daaac232f93e6c5ac47ac539f2d
-- 
2.40.1


