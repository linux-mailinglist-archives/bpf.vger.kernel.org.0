Return-Path: <bpf+bounces-16396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DF7800ED0
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 16:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C151C20ECA
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 15:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE024B5C4;
	Fri,  1 Dec 2023 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDlDmkTT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02AC10F9
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 07:51:18 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a00d5b0ec44so328033766b.0
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 07:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701445877; x=1702050677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wrQ28LtUnMnchjO/KcvlJOOtYN8sc2BC6uf4N3mZ/MU=;
        b=fDlDmkTTujf3iJuk0zkph+dP7/qvedm8P6ci+H7YxWhlrBdc74cKEgZ8QithclSrfp
         7qCYaJattenQQqK89ZYbUTPmuRsW+SVO/xn8BLkdKxLmJrVjD/i2DMB1dNz43N0t+X/W
         xZLBa/wZEvx4f/sRj7S8m+Xrq81LEjqoeAo68of4SvVHCBrL3L+F690kHvSJPcpBYz8i
         MH1iSyDakSagE/V8czMZPyi668krinBwXwudz7CCw88+f8lwz3Vj1Wi1vaM+Rba8EB2N
         z8Ej6KeDbHGlor4p3kw8DF2cr1zjS7gbJ36DHxgj83e6lgc9J1pujsFrwkhhJFhUvQjU
         5FmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701445877; x=1702050677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wrQ28LtUnMnchjO/KcvlJOOtYN8sc2BC6uf4N3mZ/MU=;
        b=rGE8IZaId1FCMc0Ajc6eRw6eNSTnAxHWUm/FCNMlFrGLFWBYUFL4HZRXTPX6Z+yoJP
         5fUu3oWiH382rfD6v5YZlQf2pUZSSMDt0Qhp/HjbfHAgL3dYgLg+LuvTZPM+bNS/Aggq
         hz7cmOrE+2xmXIVxHpCJGhOcoSwr/MnRFn/fre8PqTt9FG749A7ZgKlIJzzatG82sZ40
         Zne+UdXCoR1uusnt1RzgrxTtkaw83+rfjia/AE1bYW69Vz85u/x9/SYwmA5VxvRB5l3w
         tWbkwQJNUv1EOWKipF0ZHk70lQ2Rm86SFCxVgTFMI1YtxHTB/SvQ9Ma1m95/t5t1CSIz
         Tycg==
X-Gm-Message-State: AOJu0YwBE8LeQV4Ldpr+rCp9R/XxA9rvyVtP11u/9N8Ct+bFbYc2KOWn
	R8VokNZhITsGxfYAIVJ+UGxUXsBBYwQCSw==
X-Google-Smtp-Source: AGHT+IHa93WK6HT34YYAvveXbi6hj/P/Shg0yJIz9+DksO61UayiCQ10r1UnaG92WHifFr6MKHmKyg==
X-Received: by 2002:a17:906:14d:b0:a19:a19b:4222 with SMTP id 13-20020a170906014d00b00a19a19b4222mr695757ejh.141.1701445876801;
        Fri, 01 Dec 2023 07:51:16 -0800 (PST)
Received: from erthalion.local (dslb-178-005-231-183.178.005.pools.vodafone-ip.de. [178.5.231.183])
        by smtp.gmail.com with ESMTPSA id k22-20020a170906159600b00a16c1716a20sm2033118ejd.115.2023.12.01.07.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:51:16 -0800 (PST)
From: Dmitrii Dolgov <9erthalion6@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	dan.carpenter@linaro.org,
	olsajiri@gmail.com,
	Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH bpf-next v5 0/4] Relax tracing prog recursive attach rules
Date: Fri,  1 Dec 2023 16:47:29 +0100
Message-ID: <20231201154734.8545-1-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, it's not allowed to attach an fentry/fexit prog to another
fentry/fexit. At the same time it's not uncommon to see a tracing
program with lots of logic in use, and the attachment limitation
prevents usage of fentry/fexit for performance analysis (e.g. with
"bpftool prog profile" command) in this case. An example could be
falcosecurity libs project that uses tp_btf tracing programs for
offloading certain part of logic into tail-called programs, but the
use-case is still generic enough -- a tracing program could be
complicated and heavy enough to warrant its profiling, yet frustratingly
it's not possible to do so use best tooling for that.

Following the corresponding discussion [1], the reason for that is to
avoid tracing progs call cycles without introducing more complex
solutions. But currently it seems impossible to load and attach tracing
programs in a way that will form such a cycle. Replace "no same type"
requirement with verification that no more than one level of attachment
nesting is allowed. In this way only one fentry/fexit program could be
attached to another fentry/fexit to cover profiling use case, and still
no cycle could be formed.

The series contains a test for recursive attachment, as well as a fix +
test for an issue in re-attachment branch of bpf_tracing_prog_attach.
When preparing the test for the main change set, I've stumbled upon the
possibility to construct a sequence of events when attach_btf would be
NULL while computing a trampoline key. It doesn't look like this issue
is triggered by the main change, because the reproduces doesn't actually
need to have an fentry attachment chain.

[1]: https://lore.kernel.org/bpf/20191108064039.2041889-16-ast@kernel.org/

Dmitrii Dolgov (3):
  bpf: Relax tracing prog recursive attach rules
  selftests/bpf: Add test for recursive attachment of tracing progs
  selftests/bpf: Test re-attachment fix for bpf_tracing_prog_attach

Jiri Olsa (1):
  bpf: Fix re-attachment branch in bpf_tracing_prog_attach

 include/linux/bpf.h                           |   1 +
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/syscall.c                          |  16 +++
 kernel/bpf/verifier.c                         |  33 ++---
 tools/include/uapi/linux/bpf.h                |   1 +
 .../bpf/prog_tests/recursive_attach.c         | 117 ++++++++++++++++++
 .../selftests/bpf/progs/fentry_recursive.c    |  19 +++
 .../bpf/progs/fentry_recursive_target.c       |  31 +++++
 8 files changed, 205 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/recursive_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_recursive_target.c


base-commit: 40d0eb0259ae77ace3e81d7454d1068c38bc95c2
-- 
2.41.0


