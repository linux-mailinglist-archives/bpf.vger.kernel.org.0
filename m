Return-Path: <bpf+bounces-45746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FC89DADA4
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 20:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E29165EA5
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 19:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4059202F76;
	Wed, 27 Nov 2024 19:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="gfoR/ncG"
X-Original-To: bpf@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193E1200100;
	Wed, 27 Nov 2024 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732735251; cv=none; b=BGvOxYV/0od+0GsEbyIZcjvb4RGJWuMpdzl1pzkML8CCF96p6aXKm3pvKl2bvIXJWIm5GC57uk9XEppKoWpx6hYEvBqwqQ/Bgyp/qxlesB92dqarpzmNjbO2A+BmdmOlUWYZ27lUfToExl1wkvkUH5fvtvdSKNCtJoWtA0lX3Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732735251; c=relaxed/simple;
	bh=zC0ViIiYdKsbVqeJfJUG3RgY2nrR+ULONrnm6jK1PYA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HisSkWGu2ZHU2YJoTuzuSvfSv28Y66KLL2AvO6OmXet1YO5fyCb6Js7Sh/rfMIaZVfywPJFQPITnApY36cTLb3bJ1wqmhtQ5OwFLQaizMfIlZQAWT32eJtYVVDzVvflyMpCjCqDEEcdeViCEiDXkX8RjBGtihIDIsYVUYLcGZFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=gfoR/ncG; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1732735245;
	bh=zC0ViIiYdKsbVqeJfJUG3RgY2nrR+ULONrnm6jK1PYA=;
	h=From:Subject:Date:To:Cc:From;
	b=gfoR/ncGvuCTb4B+50mjWOUOjuwdb1/ZJZKr03VqAgL0hjj+TqOI642/ypapPq21m
	 Zvcpj0QZIHXlLk/krWIam+wUKWSBimMsG9JD00ccfepk+e46w68YjV9vwBGwCsFMe9
	 1LsDiTPAGvitIbTNaTbFXxPcyTB0F21+54rQ5hAQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH bpf-next 0/9] bpf: Constify BPF ops
Date: Wed, 27 Nov 2024 20:15:19 +0100
Message-Id: <20241127-bpf-const-ops-v1-0-a698b8d58680@weissschuh.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMdvR2cC/x2MywqAIBAAfyX23ELak34lOlSutRcVN0KI/j3rO
 DAzNwhFJoGxuCHSxcLeZVBlAduxuJ2QTWbQlW6U0j2uweLmnZzog+BijB66bq1V20NuQiTL6f9
 N8KmO0gnz87zgjR7DaQAAAA==
X-Change-ID: 20241127-bpf-const-ops-add2866b3157
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
 Kui-Feng Lee <thinker.li@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, Tejun Heo <tj@kernel.org>, 
 David Vernet <void@manifault.com>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-input@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732735245; l=1323;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=zC0ViIiYdKsbVqeJfJUG3RgY2nrR+ULONrnm6jK1PYA=;
 b=ySK54si6Ag6rcojkx7OIsS9WP8sr4LPXu+9XrODrxc3Uh2Zl4ToNUwiMWlcOTa/vu12B06OvE
 rvFYs2UjQD/CX5F/kTcWJT6XRTzsOhms6mKqG3GaGYQhAgdudk4kn/7
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Move struct bpf_struct_ops into read-only memory to protect against
accidental and malicious modifications.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (9):
      bpf: tcp: Remove inaccurate comment about extern
      bpf: Move func_models from bpf_struct_ops to bpf_struct_ops_desc
      bpf: Allow registration of const struct bpf_struct_ops
      const_structs.checkpatch: add bpf_struct_ops
      bpf: Allow registration of const cfi_stubs
      bpf, net: tcp: Constify BPF ops
      bpf, net: dummy_ops: Constify BPF ops
      HID: bpf: constify BPF ops
      sched_ext: Constify BPF ops

 drivers/hid/bpf/hid_bpf_struct_ops.c |  4 ++--
 include/linux/bpf.h                  |  8 ++++----
 include/linux/btf.h                  |  2 +-
 kernel/bpf/bpf_struct_ops.c          |  8 ++++----
 kernel/bpf/btf.c                     |  4 ++--
 kernel/sched/ext.c                   |  4 ++--
 net/bpf/bpf_dummy_struct_ops.c       | 10 +++++-----
 net/ipv4/bpf_tcp_ca.c                |  7 +++----
 scripts/const_structs.checkpatch     |  1 +
 9 files changed, 24 insertions(+), 24 deletions(-)
---
base-commit: fc39fb56917bb3cb53e99560ca3612a84456ada2
change-id: 20241127-bpf-const-ops-add2866b3157

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


