Return-Path: <bpf+bounces-51123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93007A3064D
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 09:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD6518837AF
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 08:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7218A1F0E31;
	Tue, 11 Feb 2025 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="dQ90eyP+"
X-Original-To: bpf@vger.kernel.org
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2773C1EF08E;
	Tue, 11 Feb 2025 08:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739263851; cv=none; b=hexNLDygeMWd7pXhjNu0DiH0HB81ZcH36HPvl0oMTmbaghVKG/xI5xDif3QGSSbcliiWfCFNUTvpNl5ffoKakTcVULJ9c68FV6xz3t/PfkMD8g3zZjDWEyXyeIIBUg0YvO5G8kxOFolGXiHO9nTV/jZr9fvVuyuEmLXyA4uUgUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739263851; c=relaxed/simple;
	bh=pX9pHwaUjLngOHdoa2cVMfUDj5A16e9+71bjuDNwWMI=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=NW2C+zHdx1//3220/E6v9Y6UIiS7oif5qCr8cLaez1z7BAvWhebubemR6PhBR+bjsFn9gHM5kAsXX70ocS5nkEFG4GZ6qU2GFML0LtmHO+dWidK2j5vaY+1UMBw79lW62N5zBEI5ZeeNheTa9GkEvgGQDIIgFsxVNl6jF/XFOXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=dQ90eyP+; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1739263536;
	bh=hrMQEhImTIKvSo/AGFMJLy4JukFIFOnqO2xOG81GvR4=;
	h=From:To:Cc:Subject:Date;
	b=dQ90eyP+kpGUnFL9R1KnJPVzV5NlbcbX9KfgBE47JVpyjdP+JmcMqoRzkZQq/mPre
	 rTmgawh6Y1x8dYirgmnZjYnQrOOUng9j18jBp547JpPLxQ9BsCKxCrB8hf/vJZd0Uy
	 IreFxhdBoOZvZlg/o5se19ntnAhSqGSheFEfPzYs=
Received: from NUC10.. ([39.156.73.10])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id B600862A; Tue, 11 Feb 2025 16:45:32 +0800
X-QQ-mid: xmsmtpt1739263532th8rdcz1b
Message-ID: <tencent_1C4444032C2188ACD04B4995B0D78F510607@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUAFZpyS7yx/QYIReJQYqmHLQXZbSfY53cxJDOVbmTuE780VTQTFc
	 L7XSj+lgW+LGjLqhCE0Gp9vUwTnrC4JI5isDopyww3Yjzeo09eml+kFKsg00zAB3nWZX873WkimR
	 CzokrMcLYjK2ir1JNaDcmVs/ZrERsMDOq5N2hSIKuD5RV28cs4JTQbjWF+nNh0ZiEjIa0MdnFYmL
	 V4ME3vAMbzyPsDgNHj5wmKXyaQfSy2U3caTkhj7dt2QKnvajj+xHdKjBnt26bK0/u36QpVDbMjw4
	 Yl8hPsl46lOkcS047K4fhxuS59/HRrv3C82md/yN93eCrA9Yp2ia3ogp0C8O5nDbC/iObJYRVhad
	 hkN6Jzz+MMJZiEf4czEhS+jKFe9GxRDOuldUA2axs7mBMDX4WqG+a963UGDxZ1EE7XRMXNkpHete
	 sEm5lJXWPTL7fQcF1jQaYyoLcgmjmdq1Plxp9+pnhs9SLxFl9lgfqIb6oFcXuq0a+VnEhuUlOrUt
	 xMfRBqvqzTxyU9gfJZG/xeu4CfF4lu/+SvfWLES5KPvv5W8BHY3H8JbntiOFUqPJd+ZVaUAMJDA1
	 SVnuFgrn3S0GTA3sqEKC5smmwNeuBjRxm5y+jdFUmenrmn+jerJPXayNkQo5YaRteFvQZqnSZwt5
	 80zh2kJTiBC2WIXRf8lXLIr7qqnf7S9JWsUxvD/E33f7UipzhR0HH5qC8hJ5RTpl5IawhjvWmQrx
	 Smub9Jfa3A8Y3WTm/npd+jnxDzi+MCv+bAKZhvwRCauYWw/XXsbcc4Ox3FFANT76DVaEt25eBh4j
	 OtEVvYc1AN3sBRSdZaZAhicf9wds4OZy2BYCU+MeWSfUtg++4XXebHx/n5jQMBkw23fh2hAcrAJy
	 6iwkQLJJDWLh+h8N1OY59BKcptndLBMtjxlej2Noknn7VSSf7BJFXQfZA1OqdDVp3fQS7dlrRN2Q
	 dAYIZOD+Dhg0Y8vLg4rQr0Wygpi+1FbU5j2maESTo=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Rong Tao <rtoax@foxmail.com>
To: qmo@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	rtoax@foxmail.com
Cc: rongtao@cestc.cn,
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
Subject: [PATCH bpf-next] bpftool: Check map name length when map create
Date: Tue, 11 Feb 2025 16:45:30 +0800
X-OQ-MSGID: <20250211084530.36325-1-rtoax@foxmail.com>
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
 tools/bpf/bpftool/map.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index ed4a9bd82931..fa00f7865065 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1330,6 +1330,12 @@ static int do_create(int argc, char **argv)
 		goto exit;
 	}
 
+	if (strlen(map_name) > BPF_OBJ_NAME_LEN - 1) {
+		p_err("The map name is too long, should be less than %d\n",
+		      BPF_OBJ_NAME_LEN - 1);
+		goto exit;
+	}
+
 	set_max_rlimit();
 
 	fd = bpf_map_create(map_type, map_name, key_size, value_size, max_entries, &attr);
-- 
2.48.1


