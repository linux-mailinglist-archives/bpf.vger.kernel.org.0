Return-Path: <bpf+bounces-51098-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FF1A30187
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 03:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F5AB1666EA
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 02:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597471BD9FA;
	Tue, 11 Feb 2025 02:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCvhyOfo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8255726BD94
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 02:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739241260; cv=none; b=LR38VgPJsijtWwANj9d+WSwFx0eY7bvpC/aV6ks9tQDDcnYcSGC6mPjGKlj9LuxLaQR2m0ZJbthu1R7KpG2o2kWRqlPnJu63LsCNpszopgwpdUFJuT7aAKNHuwPShg5L0j+WUKJfuoIGYSX1ajzd2ioIyS9dVzpQW3C8mdxptRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739241260; c=relaxed/simple;
	bh=PNb4nx6c4eH5GxmnQLhyqHS3eEw4uTDVsJ42HqUlnZo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eI3g12plLz1BgoMvt5dbsy7AuXPvddz841bRYFxt1Ucp84Mz4mns++bwtijunoVi4AuV/zUnpaMZx4gOHx+zY5gleqlW2ogHUHORObQP1IBn2DoI8pvnJDlugEjrnq0rXMLo+dhCHOGu4RqqRq07TnDd1Fat/MVCYj/S2n+rMB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCvhyOfo; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f464b9a27so83318555ad.1
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 18:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739241259; x=1739846059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rltQy1FuDuVxvAEZ9lW2pJYDqxoMqNfjhfsWeEibVY=;
        b=BCvhyOfoSq9hJN2JRBgs4WWLUnR44SNJRw6ME3GNl7y+z3yDyv7v/rsbJgJt/UAAn0
         P/zEDSbrgkNWMC9RiSMJBAGZD5fn5hGptyBz5iR3/nvQxtsWLckJqBUgQ3uQjXySoUle
         9KmTcNMOvUhoDjBRoE4O4lNRVgrjb35VQfe7RdBusKOCakLdd118fG5vbDn8BjHxXNPd
         KR2Cf5Sf4YJlziRiZA4blXu0xb/GxYzt4kKN/ZxjNa+nmWhMIcHc29lubopYtmEfMOSw
         jmlXWOdoJ7sWBMvlIwTYU8KOxXxJ3EKb5enge8hacLoOU01583iD6xw9k9tA/qndp5u1
         UFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739241259; x=1739846059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8rltQy1FuDuVxvAEZ9lW2pJYDqxoMqNfjhfsWeEibVY=;
        b=KeaTgpRSz4rsG57JRehYHmMXGyb3sdDMYhvz0XpQE4djSpPcww9mDi7CBZLqOUsSRa
         iV00tTIEH7jBNH9h03aPl1ZKc40c2F8Fm3hYdbJ/pjcsSebwRqUUzIVcMZRiQYRcTuUr
         L4UC3BkjVBZQ2b57DaDv47IMC+bsea2LvSwYS4RXwRN5Ftw8iHmKBRdiytGD3nXoNAD0
         bgS74dtYd4typnpOXwoUTKqybFxHOkKoISU0sA8eZbCjFM0Nz1CHnqgJHU0cTQxbak9j
         ciNGkLJrpP9dmPB/ueCErnR8Q6yk810Y5q3PzAoZUjGbX/77TKnzjs26u7jVfiEm+4Uu
         ni3A==
X-Gm-Message-State: AOJu0YwTpW9Lkmnogh4tHgHD7GeVhfa+gJF+dpTilHAwvMWJ96WwJYI7
	AEEJ5UVRGVCiOglmswjFgr5yt/xbL+RAV0VN12iu3wm3d5c34S4i
X-Gm-Gg: ASbGncuuyIfmdoEZZuUs0lmwnw/j4CugR9Re305bNtp0TUl/sFGh7/oXanzb0Ga5CS3
	T6jgylp+GgydR3JwfLUq5x3/12tTe8FfStFYEdvWdhPvqinwoRVE4wZHh+jR71fo7E2Ovh6Ky+D
	G97lrSSWtrLQXnL6Im2I3CycJRE7KrueNLIBN8JNH8ZHS4pvNboLMddiaUOXvLmOTKsQ+nIhH4C
	uyYM1CrVbHVq+DLTrqZX4HM8gLY1emqClCjelnbOmNeqqBJAlqKoMtvgv98WZg+77BhH5rYCPYR
	5KiR4uAeR04O3lUpd3VAcIW484EHxcEU7+fevBc=
X-Google-Smtp-Source: AGHT+IELQ/d0+mbWED1D6XHT4QqdXo22H01tPLjETg529NZ41TjRKY2arrVMpyoD/h09sYWBskT/eg==
X-Received: by 2002:a17:903:32cd:b0:21f:1096:7ce with SMTP id d9443c01a7336-21f4e6ada8emr242160715ad.17.1739241258808;
        Mon, 10 Feb 2025 18:34:18 -0800 (PST)
Received: from localhost.localdomain ([58.37.132.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f8dc43971sm30916315ad.66.2025.02.10.18.34.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Feb 2025 18:34:18 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 2/3] bpf: Reject attaching fexit to functions annotated with __noreturn
Date: Tue, 11 Feb 2025 10:33:58 +0800
Message-Id: <20250211023359.1570-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250211023359.1570-1-laoar.shao@gmail.com>
References: <20250211023359.1570-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we attach fexit to a function annotated with __noreturn, it will
cause an issue that the bpf trampoline image will be left over even if
the bpf link has been destroyed. Take attaching do_exit() for example. The
fexit works as follows,

  bpf_trampoline
  + __bpf_tramp_enter
    + percpu_ref_get(&tr->pcref);

  + call do_exit()

  + __bpf_tramp_exit
    + percpu_ref_put(&tr->pcref);

Since do_exit() never returns, the refcnt of the trampoline image is
never decremented, preventing it from being freed. This can be verified
with as follows,

  $ bpftool link show                                   <<<< nothing output
  $ grep "bpf_trampoline_[0-9]" /proc/kallsyms
  ffffffffc04cb000 t bpf_trampoline_6442526459    [bpf] <<<< leftover

With this change, attaching fexit probes to functions like do_exit() will
be rejected.

$ ./fexit
libbpf: prog 'fexit': BPF program load failed: -EINVAL
libbpf: prog 'fexit': -- BEGIN PROG LOAD LOG --
processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
-- END PROG LOAD LOG --
libbpf: prog 'fexit': failed to load: -EINVAL
libbpf: failed to load object 'fexit_bpf'
libbpf: failed to load BPF skeleton 'fexit_bpf': -EINVAL
failed to load BPF object -22

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/verifier.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9971c03adfd5..f7224fc61e0c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22841,6 +22841,13 @@ BTF_ID(func, __rcu_read_unlock)
 #endif
 BTF_SET_END(btf_id_deny)
 
+/* The functions annotated with __noreturn are denied. */
+BTF_SET_START(fexit_deny)
+#define NORETURN(fn) BTF_ID(func, fn)
+#include <linux/noreturns.h>
+#undef NORETURN
+BTF_SET_END(fexit_deny)
+
 static bool can_be_sleepable(struct bpf_prog *prog)
 {
 	if (prog->type == BPF_PROG_TYPE_TRACING) {
@@ -22929,6 +22936,9 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 	} else if (prog->type == BPF_PROG_TYPE_TRACING &&
 		   btf_id_set_contains(&btf_id_deny, btf_id)) {
 		return -EINVAL;
+	} else if (prog->expected_attach_type == BPF_TRACE_FEXIT &&
+		   btf_id_set_contains(&fexit_deny, btf_id)) {
+		return -EINVAL;
 	}
 
 	key = bpf_trampoline_compute_key(tgt_prog, prog->aux->attach_btf, btf_id);
-- 
2.43.5


