Return-Path: <bpf+bounces-20015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA85C836EC7
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 19:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BEE7B32BA8
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 17:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4875E46429;
	Mon, 22 Jan 2024 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="T72kJfp2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D4646424
	for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 16:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942514; cv=none; b=uuwE0E01a3aONVQE3TQ5VszAeJq/BMnOIGO/+SXfHyS0D244dmjMQPt3tKRf7AOxVWUQClvt6/YCSWa1DXoupUE0fQAQlBKYbhglKjrpQjiPma/K002D2st5J2T6Vkd4PAzI1CMrKjP//GMJMMvLBdC8Pz73zR7E/nrldaZ7Zj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942514; c=relaxed/simple;
	bh=xcOZXOmW4CiwlKXjgrn3cgZx0jiY+xMPgXhtUVfdwT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=miu+Ymm9Y8Adn1LK3zRb2YnvS5N26EsFQG9gV9FiJMIc5SFh5SO4camLdSw09mtJrruPzQtwnXqmtpkg9DpAhbW+rewA3uEIIbQsvhhHImdj+DXGKRE6hldzlnMyz711UDv2NgipjLHrocq6OGaj9rtX5mhEkPwkgSkXt7CftEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=T72kJfp2; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-339261a6ec2so1970768f8f.0
        for <bpf@vger.kernel.org>; Mon, 22 Jan 2024 08:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1705942511; x=1706547311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=79znhBKmtgq0b3DHGIoQWAjOyEBRxcrjW8aw4DLlRfM=;
        b=T72kJfp24TaTuW8YLo411ShzU6y6WLjNu82NOWLehg3+dAGoaN80e0GTsoDonqL2zY
         mU6riLjy8OqLdVl7q1h0zdujH2uu9qsDgEN616cvTWmUo8jtwZ/pEQSCtAgoeb2SCnTt
         u6sZBZ4sGQUf9pHZois7fK2TA4ef60zRcgbx9w72RK7TTVMLpiCBFxFUG2GvI1KSHBgG
         R9ZT7Qxj4o58en0l/lMvbMROsSl6RmRffn+X0ExlfEr5Z4Pb/psyq30sh6oTPRyJMEd+
         fj2ZBz13UxMwlnFU54bg4J7VYR2MEwu0gwoOvTHsHs0LpiVkzkN/BBA4xkuuHF5JCBa9
         VFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705942511; x=1706547311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79znhBKmtgq0b3DHGIoQWAjOyEBRxcrjW8aw4DLlRfM=;
        b=MCoKb8OlhEmeSOxPRjYD4EzvKKhFEDTXQjv0njTL51iaLnL4MbU2Q4y7ammaczf9tN
         hebRt750oDsvNEzaJJVUMUp9fMwh+h3vBf5uxnBCoZc2PZrY2mfzXaYbyMEW41o+0dP4
         5SByIs6Hhi7Oqahr0MeMH7gYNXd5BvYVt0xT4iDS5ZZOALfpjcd78aT4NWp1DyhdJVoC
         ELX1LecTVuuGyt2WvC3Qjt98Hg1TbyVTSmA7CKb/a3wwDLErJPC76zIvk8oM3diqTH+q
         SmqMnE6N/CnqzsrpSB7Pc/Voz3U8B16pPuklcDN84gaHqe9n3sJWGutOgne6Ocs7v3CT
         395Q==
X-Gm-Message-State: AOJu0Ywz8MSuMMfyL8SKReWKawqzUrF1ac8p4eNFSlLqTC88HCpKisrD
	NiJUF2J+IwRSCZG0/AU1AjMw0GBI2UwE+3eZY8aKvd/2FIk65CyWwD1bPz3GXmw=
X-Google-Smtp-Source: AGHT+IH9zoy6mxpNT6lsOvUDNT5Btq9ApZCQ2cpAo05EGdDUbxljC+Aken4xl7wqNL105lWNYsKL/A==
X-Received: by 2002:adf:b343:0:b0:337:3977:5b42 with SMTP id k3-20020adfb343000000b0033739775b42mr2742569wrd.28.1705942511241;
        Mon, 22 Jan 2024 08:55:11 -0800 (PST)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id i7-20020a5d6307000000b00337d71bb3c0sm10402466wru.46.2024.01.22.08.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 08:55:10 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiri Olsa <jolsa@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [RFC PATCH bpf-next 0/5] static branches
Date: Mon, 22 Jan 2024 16:49:31 +0000
Message-Id: <20240122164936.810117-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for mapping between xlated and original
instructions offsets, mapping between xlated and jitted instructions
offsets (x86), support for two new BPF instruction JA[SRC=1] and
JA[SRC=3], and a new syscall to configure the jitted values of such
instructions.

This a follow up to the previous attempt to add static keys support
(see [1], [2]) which implements lower-level functionality than what
was proposed before.

It's RFC because 1) to run self-tests it requires a patched llvm
(https://github.com/llvm/llvm-project/pull/75110, thanks a lot
Yonghong!) 2) before spending time writing selftests and proper
bpftool updates [this time] I would prefer to get some initial
feedback first (for examples, see below)

The first patch is a formal fix.
The second patch adds xlated -> original mapping.
The third patch adds xlated -> jitted mapping.
The fourth patch adds support for new instructions.
And the fifth patch adds support for new syscall.

Altogether this provides enough functionality to dynamically patch
programs and support simple static keys. See the third patch which
displays an example of mappings between xlated->orig, xlated->jited.
See the last patch which includes description of how to implement
simple static key functionality.

This would be also interesting to hear what people think about more
high-level api where one "key" controls a set of static branches in
multiple programs and can serialize access to all the branches. What
kind of BPF object can represent such functionality, besides a map,
if any?

  [1] https://lpc.events/event/17/contributions/1608/attachments/1278/2578/bpf-static-keys.pdf
  [2] https://lore.kernel.org/bpf/20231206141030.1478753-1-aspsk@isovalent.com/

Anton Protopopov (5):
  bpf: fix potential error return
  bpf: keep track of and expose xlated insn offsets
  bpf: x86: expose how xlated insns map to jitted insns
  bpf: add support for an extended JA instruction
  bpf: x86: add BPF_STATIC_BRANCH_UPDATE syscall

 arch/x86/net/bpf_jit_comp.c       |  71 ++++++++++++++++++-
 include/linux/bpf.h               |  11 +++
 include/linux/bpf_verifier.h      |   1 -
 include/linux/filter.h            |   1 +
 include/uapi/linux/bpf.h          |  26 +++++++
 kernel/bpf/core.c                 |  69 +++++++++++++++++-
 kernel/bpf/syscall.c              | 112 ++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c             |  58 ++++++++++++----
 tools/bpf/bpftool/prog.c          |  14 ++++
 tools/bpf/bpftool/xlated_dumper.c |   2 +-
 tools/bpf/bpftool/xlated_dumper.h |   2 +
 tools/include/uapi/linux/bpf.h    |  26 +++++++
 12 files changed, 375 insertions(+), 18 deletions(-)

-- 
2.34.1


