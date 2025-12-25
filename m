Return-Path: <bpf+bounces-77435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D92CDD937
	for <lists+bpf@lfdr.de>; Thu, 25 Dec 2025 10:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A9AA30146DE
	for <lists+bpf@lfdr.de>; Thu, 25 Dec 2025 09:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888203195EF;
	Thu, 25 Dec 2025 09:22:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from chinatelecom.cn (smtpnm6-01.21cn.com [182.42.159.233])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007A92F5A0D;
	Thu, 25 Dec 2025 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=182.42.159.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766654533; cv=none; b=SXJQ8BeTZgM7JkCN1Dj4fhcPKZCUkXJTnAZC5NovFbLLoqtxCNmZEVa+BuLjW88gUOJvOC/BquwboH05Yoch0KcvUcuXIO78lazARHSWzKkRDYft9qb0b4iy4ds6FMMjGyclcz6FXcg5twHKXOq/eqvnj/AumOl81q8PRzJsnwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766654533; c=relaxed/simple;
	bh=VBKSYg5quzAcIf8QlT0PjiUQ1PAiSRMywyzWhLQ2ptE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=u6y6DUfVhA6mWOCENcItuQWEbOPlGv+5DzKnX+i+ZG3nsxbDqJu8A+k8velHUuiTK3M9Jd/CyRbQEWRWND3EEKsNxJ2iZdbcyRjShQHszMznq0QnnKZ0QNvW7YKQ76TD3yyU9gfHGsw/w1V4RK5M4IUFqaKWWiW5/VMbk3nPJ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn; spf=pass smtp.mailfrom=chinatelecom.cn; arc=none smtp.client-ip=182.42.159.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chinatelecom.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chinatelecom.cn
HMM_SOURCE_IP:172.27.0.100:0.1853048837
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-101.227.46.167 (unknown [172.27.0.100])
	by chinatelecom.cn (HERMES) with SMTP id 68CD0CAF3D;
	Thu, 25 Dec 2025 17:14:13 +0800 (CST)
X-189-SAVE-TO-SEND: +niuwl1@chinatelecom.cn
Received: from  ([101.227.46.167])
	by gateway-ssl-dep-55bdcd6d8-lhb6k with ESMTP id c33f190ec59849b6a676bd3b584ff7f1 for qmo@kernel.org;
	Thu, 25 Dec 2025 17:14:31 CST
X-Transaction-ID: c33f190ec59849b6a676bd3b584ff7f1
X-Real-From: niuwl1@chinatelecom.cn
X-Receive-IP: 101.227.46.167
X-MEDUSA-Status: 0
Sender: niuwl1@chinatelecom.cn
From: WanLi Niu <niuwl1@chinatelecom.cn>
To: Quentin Monnet <qmo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	WanLi Niu <niuwl1@chinatelecom.cn>,
	hlleng <a909204013@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpftool: add missing --sign option to help output
Date: Thu, 25 Dec 2025 17:13:52 +0800
Message-Id: <20251225091352.3048-1-niuwl1@chinatelecom.cn>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: WanLi Niu <niuwl1@chinatelecom.cn>
Co-developed-by: hlleng <a909204013@gmail.com>
Signed-off-by: hlleng <a909204013@gmail.com

---
 tools/bpf/bpftool/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
index a829a6a49037..3b4987a2f1bb 100644
--- a/tools/bpf/bpftool/main.c
+++ b/tools/bpf/bpftool/main.c
@@ -66,6 +66,7 @@ static int do_help(int argc, char **argv)
 		"\n"
 		"       OBJECT := { prog | map | link | cgroup | perf | net | feature | btf | gen | struct_ops | iter | token }\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
+		"                    { {-S|--sign {-k|--private_key_path} {-i|--cert_path} } |\n"
 		"                    {-V|--version} }\n"
 		"",
 		bin_name, bin_name, bin_name);
@@ -452,6 +453,8 @@ int main(int argc, char **argv)
 		{ "debug",	no_argument,	NULL,	'd' },
 		{ "use-loader",	no_argument,	NULL,	'L' },
 		{ "sign",	no_argument,	NULL,	'S' },
+		{ "private_key_path",	required_argument,	NULL,	'k' },
+		{ "cert_path",	required_argument,	NULL,	'i' },
 		{ "base-btf",	required_argument, NULL, 'B' },
 		{ 0 }
 	};
-- 
2.39.1


