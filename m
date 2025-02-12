Return-Path: <bpf+bounces-51198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDF0A31B2B
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 02:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D316A3A640A
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 01:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0E72C859;
	Wed, 12 Feb 2025 01:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="fLVGjX+i"
X-Original-To: bpf@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCEDAD27;
	Wed, 12 Feb 2025 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739323786; cv=none; b=pwtziUS+sBOjyhk+aBvg+O3L6naKXOlM+Y8YbZuC5zo15wIeQBd2m9U+yFcDHD7hBjLqgvoQ5ANl0T+Na6gbBstff8ayQQO0CfzYOJH889DNH/8VDycbeZldf2X6eWv5XrfjelPea5gdzf+0Tt8poyH0aul7DKWW2hqr/lNNAT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739323786; c=relaxed/simple;
	bh=93VfGGxp9bDVjLPuPlcrPa9irsDjQc3C/amhn3XmjtM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Bzoqaby/mD0efury0WYf/GjPP4ZU1uHDSQC/XjcFO7UK41ZrUlbYZb0Q5h5Z26Up9yZKxaF549b2XhFlg2ff+HQV3k6XsS8tcDPN9Os4M3qIftdWxpAOnH49JNe1cZCrxkqUaSHFRszU4zz4o/c7l7kj/GV2RvPq+c5clCmKFkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=fLVGjX+i; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1739323772;
	bh=ljA0W5xtMbewVjeQFdHOJlXOQpYykejr/VKAcc/lcbY=;
	h=From:To:Cc:Subject:Date;
	b=fLVGjX+iJ+Lvao4OZsxv+6JPDpCW9GBGANo/3y4iJ+3nCNrwbGtaBHM+GN1maRNtj
	 PT+i3mSBf2ua+wQ/AfgRHCUISFJSw6Si7iYTExFua1uq9vPFft/s2KNrw4H9kfHarJ
	 OaAJMRmkNH6RBstx6TphP1qqMkGN4r7LvIQQSDr0=
Received: from NUC10.. ([39.156.73.10])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 53B304D2; Wed, 12 Feb 2025 09:20:59 +0800
X-QQ-mid: xmsmtpt1739323259ty60p11s6
Message-ID: <tencent_AF066A426F591F977D2A73AF00A34A883808@qq.com>
X-QQ-XMAILINFO: M9VsxC5s0NEwobLBGcXuh2E3HsCEfrCiXs3M+lgxvqPb7zbttK7bce+SZdu/8G
	 y4zSlhND4OYcLSj90MlmyafjaC0dYYH/GhJAtNOkisCYTs1zcst57ts+s1fa6IudWT1kGkdDbRMZ
	 JmJvx3yobHJDJ95R+EAa7XYHUSDRXnX2CELKMN8k4wUQQsJ5a4mgVeOT1YblYeNr97w+M0UeLIp9
	 WXtJDbWPSwWXYb+XtYjRtQYzJ6jd7qOzJbWpSHvhn7MNDzn1p+JyrsHHn5C72Cm0BMn1iwMwk60p
	 jp+ttriXYT0Ly8BfZj++eECoCvlGf9u6HWn5aDA/mOMS3I9t28g4EgugnInI5/VUKtTRk8rX7cfD
	 oEdWVHfO6y7DcIjB83BOztcSV5XnAqtg3bCrkIk1KWx1HEVy9f0SjkWgqU20JB3RlGaGQqpETAAw
	 4GE9QgnhzSKQ+1dF3nzFNxoN+MMV5graG1RfO3TUQcMew0jLxPBf+PHa/af0qGMXvFtngOe+BqVQ
	 F54BbQ8zU83FSRjnu/OBqgvQtQYcnypjeeLdw3VwXSNAp43fw3l/KQnRRRGa3MK9FEY07PaG4/ch
	 5jOQCGvPnVEKjUkt4CRVrYpRqlAYlKqtC5MRPTuOC6UUMUaZQxvdcATh/fREDQq8/mxij/u3SbaY
	 zMk7/4yzxR9ggO0BPHhkO9c+92GfSp/JMNMLw9Ccp17A6luYMaYUGWDVcphNC4vE0U0G2udUJQRD
	 VyGn0FcL4YmfnQZwC5PA5LGy93LjpFDTPiaoC/yF+DDc5fjH9TQHC2CcKW3ICImb/6LB3DIT7qIh
	 1K03iF5cBv5C18jdqrZH1Qi0S+Dp03XubtsO+7TJXx6/X0utGcS31C74/sxqHzlht6jseHEFy6KK
	 r/VfwDAYla4o2cne5rOK4YziA2bYdN0ZfoesmrFtOkwB+k3qf0IkmEHETpNYo3qP7Kr9fkQTvxTI
	 QrXdlNouStH+1PPeKF2mwLiBhx2DB/VOEzvQwbUYiL4xxpFhM0SBuUvwmnvCLCWBQ0DSHq+cKf2q
	 KMVmk5Cg==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Rong Tao <rtoax@foxmail.com>
To: andrii.nakryiko@gmail.com,
	ast@kernel.org,
	qmo@kernel.org,
	daniel@iogearbox.net
Cc: Rong Tao <rongtao@cestc.cn>,
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
Subject: [PATCH bpf-next v3] bpftool: Check map name length when map create
Date: Wed, 12 Feb 2025 09:20:57 +0800
X-OQ-MSGID: <20250212012058.93986-1-rtoax@foxmail.com>
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
v2: https://lore.kernel.org/lkml/tencent_26592A2BAF08A3A688A50600421559929708@qq.com/
v1: https://lore.kernel.org/lkml/tencent_1C4444032C2188ACD04B4995B0D78F510607@qq.com/
---
 tools/bpf/bpftool/map.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index ed4a9bd82931..9617e64d3d11 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1270,6 +1270,10 @@ static int do_create(int argc, char **argv)
 		} else if (is_prefix(*argv, "name")) {
 			NEXT_ARG();
 			map_name = GET_ARG();
+			if (strlen(map_name) > BPF_OBJ_NAME_LEN - 1) {
+				p_info("Warning: map name is longer than %d characters, it will be truncated.\n",
+				      BPF_OBJ_NAME_LEN - 1);
+			}
 		} else if (is_prefix(*argv, "key")) {
 			if (parse_u32_arg(&argc, &argv, &key_size,
 					  "key size"))
-- 
2.48.1


