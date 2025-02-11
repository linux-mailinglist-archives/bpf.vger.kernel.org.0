Return-Path: <bpf+bounces-51133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82467A30963
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 12:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F82E1633A8
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 11:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C511F4E3B;
	Tue, 11 Feb 2025 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="xlPf9l4s"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A9D1EF09C;
	Tue, 11 Feb 2025 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739271842; cv=none; b=AV5+MTQhwrG3hBNdEp45s3mjcYezDH3NhunkcWDzGHhaNqXneL7JDyqfVeAQJQZwZwGpfWS05hbmfkK7tUr0T31YBJlxWc+Xp0e19x5hPJzk1tbsVEeSwQmOw6JTYCBx6kdglYVUBYBmKBeC9JZ10X6mlBbblzN1/dnTINTFAt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739271842; c=relaxed/simple;
	bh=HR1cTfPtrYMFL/U4XOfH554Bii/BquLSLW6LMqX7uEs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=DhMBYOTd9Jr5V7POxicSkR9FByyNL6TKyL570SoRK8BXyVnygCuo26hPBMueSK1a4B6D2CKDxalQFZpkN3ER7GI/5btRgKruTYi8CyvHP5CjnnhkEkPcKbjuh4dVqKjLfgawn6PjHkFDBY+KnCdRTLuVhYZ8Y5SuuMv2Dkfg9bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=xlPf9l4s; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1739271832;
	bh=7vU21O8iptioA5gcEabn8Xg1heHT33nvWJUkTyHR0os=;
	h=From:To:Cc:Subject:Date;
	b=xlPf9l4su4JlE7qUG3AhCWEJYGWyeRMKhkv7nE57xnrT1q6fHCFbe9fQjASYt5ADs
	 +whwWbE5ashqrD5wC01aa9Kt8ppGl/p0w6rYcHS/ntzIm3sIzOY/t3aXLbo7EPei92
	 NUqxTC3bh455BTUYfWs0FIgKcDAV+AzwWFEVM2OM=
Received: from NUC10.. ([39.156.73.10])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 995B283F; Tue, 11 Feb 2025 18:38:21 +0800
X-QQ-mid: xmsmtpt1739270301tjrgpmued
Message-ID: <tencent_26592A2BAF08A3A688A50600421559929708@qq.com>
X-QQ-XMAILINFO: OATpkVjS499u55ORrONqKpZxP8ux/uuWT7idW6LGyoibpoEN688/lCMWtE5foc
	 6S/5M7RK+I29VWAXxV1/s/lO7SS+fyn9c6/33F5wiWtvSzJvp+KNtsPDgcubbyjMLixV9lpyILCg
	 EKnkH1jB8TZyJcXKmZCuFteUT3ljiDrTCZB542O5sEv6uNgDzbT3qkIFTvv6IKosj+M6mgKLmIri
	 u1v4XW9t7XQQP9B+/+DbgiBAJz0DOruDUNq2sCgFzQ522LhNl62hOAnsqMfhBCgwes3R8Xbd0U4g
	 7eNTSUYDmGbbkiWZVtpA0yAWc5H/lg7dqBYtcJNqwqHaaA2xf3P9gbVwMSpje62q3EJGGNkcCeZg
	 xyhPmjyds33AniBjJ/f2IwotpxQEfVNLIw6VdOl+t3u/bYM3ibkrQrrdjj+OP2H6P+G717ddQmlG
	 14EAFddtQuMdcjfeCgA6xyQAAlRr42HrEmgbFizowK+NiB3PodwfEeA1NvvrgwT01VOXmBPjjZPd
	 T5SGFvUYxDXP5Qbb1ehTFBkQOQid9DqKy7EVvganIkOIDbvsfbG89HA7+g/dqWFq0Uk9peBqHCB/
	 q3BZGzovsaZRSBo8mx/qIvUyR1toO4neY0MLfiLETUtsqPn0avW4FOwvv92nLb3RnsQm0/qsHr+T
	 ChTsMoFlTi1aYY0kW5bYFVcRnTlOL7KZxjfb45pLO1NmJCTPgDXryJ7hyzkTLaNzDm2tiOwHWiTJ
	 EsXF2Hd4YeyrhvT3hZzncraAWFQcRL5FVfcFCJJZu6ireJuL8vWZ6CZsR8wSMINWgephbnDqmU9C
	 LH/Ai9oWgkVD8RXlESuvDVZTx9YotBCcD7h6W7FqjCezzYGyxy+ZWz/mAuNmcr2iM0qbY2l3QQt9
	 +eqamtZ9pfapIwB0TBszYqVTnafUI26aU6GWA9dcLGYmpP59cRMBh6CJP0ZJEZDs5iklKqfKs9D4
	 Sfs2Z95pfXQ/p7/LG5kRuF3RvYHdBZLEkdm8NcIpoVA5UlRPCq0g==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Rong Tao <rtoax@foxmail.com>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: rongtao@cestc.cn,
	rtoax@foxmail.com,
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
	bpf@vger.kernel.org (open list:BPF [TOOLING] (bpftool)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next v2] bpftool: Check map name length when map create
Date: Tue, 11 Feb 2025 18:38:20 +0800
X-OQ-MSGID: <20250211103820.61883-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rong Tao <rongtao@cestc.cn>

The size of struct bpf_map::name is BPF_OBJ_NAME_LEN (16).

bpf(2) {
  map_create() {
    bpf_obj_name_cpy(map->name, attr->map_name, sizeof(attr->map_name));
  }
}

When specifying a map name using bpftool map create name, no error is
reported if the name length is greater than 15.

    $ sudo bpftool map create /sys/fs/bpf/12345678901234567890 \
        type array key 4 value 4 entries 5 name 12345678901234567890

Users will think that 12345678901234567890 is legal, but this name cannot
be used to index a map.

    $ sudo bpftool map show name 12345678901234567890
    Error: can't parse name

    $ sudo bpftool map show
    ...
    1249: array  name 123456789012345  flags 0x0
    	key 4B  value 4B  max_entries 5  memlock 304B

    $ sudo bpftool map show name 123456789012345
    1249: array  name 123456789012345  flags 0x0
    	key 4B  value 4B  max_entries 5  memlock 304B

The map name provided in the command line is truncated, but no error is
reported. This submission checks the length of the map name.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/bpf/bpftool/map.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index ed4a9bd82931..bd5df44e2420 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1270,6 +1270,11 @@ static int do_create(int argc, char **argv)
 		} else if (is_prefix(*argv, "name")) {
 			NEXT_ARG();
 			map_name = GET_ARG();
+			if (strlen(map_name) > BPF_OBJ_NAME_LEN - 1) {
+				p_err("map name must be no longer than %d characters\n",
+				      BPF_OBJ_NAME_LEN - 1);
+				goto exit;
+			}
 		} else if (is_prefix(*argv, "key")) {
 			if (parse_u32_arg(&argc, &argv, &key_size,
 					  "key size"))
-- 
2.48.1


