Return-Path: <bpf+bounces-19466-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD9582C52D
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 19:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133A01F232B4
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 18:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E061AABB;
	Fri, 12 Jan 2024 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WdbASQOM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WdbASQOM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DBB17C8D;
	Fri, 12 Jan 2024 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 965851FCE7;
	Fri, 12 Jan 2024 18:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705082808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ie5t95U12SvIYn0Ymuu06e9r7g/gfEKTgTlhyAcyn3A=;
	b=WdbASQOMV6ypKNMmu9yy8GpUXIQxCUqArJ9rAnhWYDvRkHUHx+SW7F1Wzb2i9IQgkaM+e4
	hWv0wKda6uP5L9kMdoE2RnI8TJRzMrfZpHXaeoewWsBegZVrMN0X77z4mYyzdhHAiMAveL
	PRfeZP6wdg2ZTu0ngKZKAZiqWuNYSPc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705082808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ie5t95U12SvIYn0Ymuu06e9r7g/gfEKTgTlhyAcyn3A=;
	b=WdbASQOMV6ypKNMmu9yy8GpUXIQxCUqArJ9rAnhWYDvRkHUHx+SW7F1Wzb2i9IQgkaM+e4
	hWv0wKda6uP5L9kMdoE2RnI8TJRzMrfZpHXaeoewWsBegZVrMN0X77z4mYyzdhHAiMAveL
	PRfeZP6wdg2ZTu0ngKZKAZiqWuNYSPc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16F95136A4;
	Fri, 12 Jan 2024 18:06:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rUi1BLh/oWXLQwAAD6G6ig
	(envelope-from <mkoutny@suse.com>); Fri, 12 Jan 2024 18:06:48 +0000
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cake@lists.bufferbloat.net
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Petr Pavlu <ppavlu@suse.cz>,
	Michal Kubecek <mkubecek@suse.cz>,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v3 0/4] net/sched: Load modules via alias
Date: Fri, 12 Jan 2024 19:06:42 +0100
Message-ID: <20240112180646.13232-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ******
X-Spam-Score: 6.30
X-Spamd-Result: default: False [6.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RL63s8thh5w8zyxj4waeg9pq8e)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[28];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,gmail.com,resnulli.us,iogearbox.net,linux.dev,toke.dk,intel.com,networkplumber.org,suse.cz,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

These modules may be loaded lazily without user's awareness and
control. Add respective aliases to modules and request them under these
aliases so that modprobe's blacklisting mechanism (through aliases)
works for them. (The same pattern exists e.g. for filesystem
modules.)

For example (before the change):
  $ tc filter add dev lo parent 1: protocol ip prio 1 handle 10 tcindex ...
  # cls_tcindex module is loaded despite a `blacklist cls_tcindex` entry
  # in /etc/modprobe.d/*.conf

After the change:
  $ tc filter add dev lo parent 1: protocol ip prio 1 handle 10 tcindex ...
  Unknown filter "tcindex", hence option "..." is unparsable
  # explicit/acknowledged (privileged) action is needed
  $ modprobe cls_tcindex
  # blacklist entry won't apply to this direct modprobe, module is
  # loaded with awareness

A considered alternative was invoking `modprobe -b` always from
request_module(), however, dismissed as too intrusive and slightly
confusing in favor of the precedented aliases (the commit 7f78e0351394
("fs: Limit sys_mount to only request filesystem modules.").

User experience suffers in both alternatives. It's improvement is
orthogonal to blacklist honoring.

Changes from v1 (https://lore.kernel.org/r/20231121175640.9981-1-mkoutny@suse.com)
- Treat sch_ and act_ modules analogously to cls_

Changes from v2 (https://lore.kernel.org/r/20231206192752.18989-1-mkoutny@suse.com)
- reorganized commits (one generated commit + manual pre-/post- work)
- used alias names more fitting the existing net- aliases
- more info in commit messages and cover letter
- rebased on current master

Michal Koutný (4):
  net/sched: Add helper macros with module names
  net/sched: Add module aliases for cls_,sch_,act_ modules
  net/sched: Load modules via their alias
  net/sched: Remove aliases of act_xt and sch_clsact

 include/net/act_api.h      | 1 +
 include/net/pkt_cls.h      | 1 +
 include/net/pkt_sched.h    | 1 +
 net/sched/act_api.c        | 2 +-
 net/sched/act_bpf.c        | 1 +
 net/sched/act_connmark.c   | 1 +
 net/sched/act_csum.c       | 1 +
 net/sched/act_ct.c         | 1 +
 net/sched/act_ctinfo.c     | 1 +
 net/sched/act_gact.c       | 1 +
 net/sched/act_gate.c       | 1 +
 net/sched/act_ife.c        | 1 +
 net/sched/act_ipt.c        | 3 ++-
 net/sched/act_mirred.c     | 1 +
 net/sched/act_mpls.c       | 1 +
 net/sched/act_nat.c        | 1 +
 net/sched/act_pedit.c      | 1 +
 net/sched/act_police.c     | 1 +
 net/sched/act_sample.c     | 1 +
 net/sched/act_simple.c     | 1 +
 net/sched/act_skbedit.c    | 1 +
 net/sched/act_skbmod.c     | 1 +
 net/sched/act_tunnel_key.c | 1 +
 net/sched/act_vlan.c       | 1 +
 net/sched/cls_api.c        | 2 +-
 net/sched/cls_basic.c      | 1 +
 net/sched/cls_bpf.c        | 1 +
 net/sched/cls_cgroup.c     | 1 +
 net/sched/cls_flow.c       | 1 +
 net/sched/cls_flower.c     | 1 +
 net/sched/cls_fw.c         | 1 +
 net/sched/cls_matchall.c   | 1 +
 net/sched/cls_route.c      | 1 +
 net/sched/cls_u32.c        | 1 +
 net/sched/sch_api.c        | 2 +-
 net/sched/sch_cake.c       | 1 +
 net/sched/sch_cbs.c        | 1 +
 net/sched/sch_choke.c      | 1 +
 net/sched/sch_codel.c      | 1 +
 net/sched/sch_drr.c        | 1 +
 net/sched/sch_etf.c        | 1 +
 net/sched/sch_ets.c        | 1 +
 net/sched/sch_fq.c         | 1 +
 net/sched/sch_fq_codel.c   | 1 +
 net/sched/sch_gred.c       | 1 +
 net/sched/sch_hfsc.c       | 1 +
 net/sched/sch_hhf.c        | 1 +
 net/sched/sch_htb.c        | 1 +
 net/sched/sch_ingress.c    | 3 ++-
 net/sched/sch_mqprio.c     | 1 +
 net/sched/sch_multiq.c     | 1 +
 net/sched/sch_netem.c      | 1 +
 net/sched/sch_pie.c        | 1 +
 net/sched/sch_plug.c       | 1 +
 net/sched/sch_prio.c       | 1 +
 net/sched/sch_qfq.c        | 1 +
 net/sched/sch_red.c        | 1 +
 net/sched/sch_sfb.c        | 1 +
 net/sched/sch_sfq.c        | 1 +
 net/sched/sch_skbprio.c    | 1 +
 net/sched/sch_taprio.c     | 1 +
 net/sched/sch_tbf.c        | 1 +
 62 files changed, 64 insertions(+), 5 deletions(-)

-- 
2.43.0


