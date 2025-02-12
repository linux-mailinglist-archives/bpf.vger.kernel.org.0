Return-Path: <bpf+bounces-51248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AD4A3264C
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 13:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21301691E6
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 12:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26B620D4E1;
	Wed, 12 Feb 2025 12:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="RnqjVrAS"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5102046B5;
	Wed, 12 Feb 2025 12:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739364743; cv=none; b=hMWR0f7z0J+zKPwUN+UKMevUL9hZukRbKzvJ7+kGuaytHXkrheeie/70GnnyeYnDVz9OuOG0FHEdzLb6Qnejc3dnrGII5WIJM5xt3XkTTojtfOkLK47saeyLI/fcrHr5cIaSZo7nLCFvZZSj5HCkO2MsXPyZZL2wiurw0I+1Xxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739364743; c=relaxed/simple;
	bh=0HUJCUu1wgMcgDDTi7Bg/sYak+QPi7iL6RR8eCGvuUM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=iGGWjDV7quwpi3PELMdnY2thArirOPwwfvq8GfWCbZsQs66sLIUUXaTE4iR/7WA/07oQhKRpyuenH54cK8CBMxjg1W5AbaLY7Z73R0/iCLAqTZZ/8svtM62EjvpUXjlSXwhr+qwbn2tdnDJFqWFErKqDw+lYQJ7Q8+jA1QrAdGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=RnqjVrAS; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1739364726;
	bh=+XIDPqjGUvxmjKTI7q2+Nz1Yuu2Dud+hxdGsctS0pCM=;
	h=From:To:Cc:Subject:Date;
	b=RnqjVrAS5ToUAMZ4e/ATqtEkPmwTFWL50N/eICCOaGWR2nGcwxX+0Dz/JR2muHLqJ
	 LxPI+vG6m7gSJzEHOJUzTi6scc8Imauk61Ud+KGSZ5eJahyDt6EqZmXg74pC++TGnq
	 MsAUWPcpDxI27GAlsLkLOJL/SxTwdnZz/k6TbydY=
Received: from f41.lan ([240e:305:1b95:d110:7285:c2ff:fe86:1af4])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id B758387A; Wed, 12 Feb 2025 20:45:53 +0800
X-QQ-mid: xmsmtpt1739364353tcm46gffh
Message-ID: <tencent_B44B3A95F0D7C2512DC40D831DA1FA2C9907@qq.com>
X-QQ-XMAILINFO: N2bAIxLK0elnyafZvAS7NlnEeBNBU/rEwUIhb3bMQDt445BhsBLzRZX+Y/XPhu
	 daivaUk+OV7owFM2QKnC/yqkalI6HNlPutLjgFrFWAsRYcNLdtuTSPkUKapeyd7z1yCKP6ehXYu2
	 o+u86QgQd102TcsTdtIMD6ZtOU5V2dwYZaryuO5fKPT6BuLfdXzVKAyah7OrQ1fWoIAdsEBGmH4K
	 bhJ819uxIIEhL+Tp3MJQqovaQGu0jAp/+gsM+bWtxVfcSY7qPAAHEn8cismo9SOTYh/DKwJrJyMd
	 TofmE45VkmdLXh+S4wyedoXG3S/8zO3ojBDLuUQiz9ChX56OF5Oa/1Kf3uZg8S+Mpd4FkausBwDo
	 AITFU2CAEOKGeQ4tbhq3Abo+YhwEGRW1GYvwJSEOzxCPYaloEDVXBzYcpKSmv4ScUra9CjxkZdZ3
	 atyj0QTyhgKzo5SS8WGe4/8wgP5u9kQqDEqPSBrXYRMy9RgvWmkeP8jg6f6/tzoXIH6YeJuKiqL7
	 qzTs0PxvqfycTokxh8CV2ZMBD4G18eyIb0rSlLtSESPMa/RbiRvrB64dtlHqVO3wa/+LsJCfneDa
	 O2Som2NC9dHTis5Q/77BL9AjKkseuEmV6rRasW2txq1Z0s8+nB+iOIhcN1wtDLTPa3vgEftCW71B
	 hxjI9jutCxvYCPBhmeob3KuMQ4PWjDpzMXh6R6QSpK5p64szp5Tf2cX5THaYu7TannLbv/yonjR3
	 IgBsVG253+ccraaB+m9vK9nyM8Ktxf8itC4zGkIXlqe9nxu5cLSq2PHHs5E4lE8yqAgYPdcGzxrw
	 9rdsH4Y5k0oaRWSY1xN6C/sloc43k0GnbH6d+rjl7l+DTWXAcD/LilkccLVmXDvakOxT34U5uz2Z
	 7sBY6alEgm+BWvp/xAMA/TtyRieVZYVObBpsUklNEf0B9AS82UAKDVtmZaKHpEeDyppUTxTZZkH5
	 TA1ZjMVOp02Ohzs9j2ctGEl0M6nxFHeqOxA/g+CTNp6BkByfVD6mmZOlFDAa4mEgyc5XMBEyw=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Rong Tao <rtoax@foxmail.com>
To: andrii@kernel.org,
	qmo@kernel.org,
	ast@kernel.org
Cc: rongtao@cestc.cn,
	rtoax@foxmail.com,
	Daniel Borkmann <daniel@iogearbox.net>,
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
Subject: [PATCH bpf-next v4] bpftool: Check map name length when map create
Date: Wed, 12 Feb 2025 20:45:52 +0800
X-OQ-MSGID: <20250212124552.9247-1-rtoax@foxmail.com>
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

The map name provided in the command line is truncated, but no warning is
reported. This submission checks the length of the map name.

Reviewed-by: Quentin Monnet <qmo@kernel.org>
Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
v3: https://lore.kernel.org/lkml/tencent_AF066A426F591F977D2A73AF00A34A883808@qq.com/
v2: https://lore.kernel.org/lkml/tencent_26592A2BAF08A3A688A50600421559929708@qq.com/
v1: https://lore.kernel.org/lkml/tencent_1C4444032C2188ACD04B4995B0D78F510607@qq.com/
---
 tools/bpf/bpftool/map.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index ed4a9bd82931..81cc668b4b05 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1270,6 +1270,10 @@ static int do_create(int argc, char **argv)
 		} else if (is_prefix(*argv, "name")) {
 			NEXT_ARG();
 			map_name = GET_ARG();
+			if (strlen(map_name) > BPF_OBJ_NAME_LEN - 1) {
+				p_info("Warning: map name is longer than %u characters, it will be truncated.",
+				      BPF_OBJ_NAME_LEN - 1);
+			}
 		} else if (is_prefix(*argv, "key")) {
 			if (parse_u32_arg(&argc, &argv, &key_size,
 					  "key size"))
-- 
2.48.1


