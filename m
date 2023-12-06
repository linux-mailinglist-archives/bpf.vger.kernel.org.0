Return-Path: <bpf+bounces-16920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F69B80788C
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 20:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10F41C20F41
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 19:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB756EB78;
	Wed,  6 Dec 2023 19:28:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8345BD5A;
	Wed,  6 Dec 2023 11:27:57 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4EA5C21D33;
	Wed,  6 Dec 2023 19:27:55 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 774D713403;
	Wed,  6 Dec 2023 19:27:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id jgDGGzrLcGUeYAAAn2gu4w
	(envelope-from <mkoutny@suse.com>); Wed, 06 Dec 2023 19:27:54 +0000
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
Subject: [PATCH 0/3] net/sched: Load modules via alias
Date: Wed,  6 Dec 2023 20:27:49 +0100
Message-ID: <20231206192752.18989-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
	spf=fail (smtp-out1.suse.de: domain of mkoutny@suse.com does not designate 2a07:de40:b281:104:10:150:64:98 as permitted sender) smtp.mailfrom=mkoutny@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_SPF_FAIL(1.00)[-all];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
	 BAYES_HAM(-3.00)[100.00%];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.981];
	 RCPT_COUNT_TWELVE(0.00)[28];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,gmail.com,resnulli.us,iogearbox.net,linux.dev,toke.dk,intel.com,networkplumber.org,suse.cz,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 15.00
X-Rspamd-Queue-Id: 4EA5C21D33
X-Spam: Yes

These modules may be loaded lazily without user's awareness and
control. Add respective aliases to modules and request them under these
aliases so that modprobe's blacklisting mechanism (through aliases)
works for them. (The same pattern exists e.g. for filesystem
modules.)

Original module names remain unchanged.

Patches were generated with the help of Coccinelle scripts like:

cat >scripts/coccinelle/misc/tcf_alias.cocci <<EOD
virtual patch
virtual report

@ haskernel @
@@

@ tcf_has_kind depends on report && haskernel @
identifier ops;
constant K;
@@

  static struct tcf_proto_ops ops = {
    .kind = K,
    ...
  };
+char module_alias = K;
EOD

/usr/bin/spatch -D report --cocci-file scripts/coccinelle/misc/tcf_alias.cocci \
	--dir . \
	-I ./arch/x86/include -I ./arch/x86/include/generated -I ./include \
	-I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi \
	-I ./include/uapi -I ./include/generated/uapi \
	--include ./include/linux/compiler-version.h --include ./include/linux/kconfig.h \
	--jobs 8 --chunksize 1 2>/dev/null | \
	sed 's/char module_alias = "\([^"]*\)";/MODULE_ALIAS_TCF("\1");/'

Changes from v1 (https://lore.kernel.org/r/20231121175640.9981-1-mkoutny@suse.com)
- Treat sch_ and act_ modules analogously to cls_

Michal Koutný (3):
  net/sched: cls: Load net classifier modules via alias
  net/sched: sch: Load qdisc modules via alias
  net/sched: act: Load TC action modules via alias

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
 net/sched/act_ipt.c        | 2 ++
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
 net/sched/sch_ingress.c    | 2 ++
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
 62 files changed, 64 insertions(+), 3 deletions(-)

-- 
2.42.1


