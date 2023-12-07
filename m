Return-Path: <bpf+bounces-17023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7EF808F96
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 19:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D4C28160D
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 18:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32374CE14;
	Thu,  7 Dec 2023 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyFdm3yz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BB510EF;
	Thu,  7 Dec 2023 10:09:33 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c2d50bfbfso3463175e9.0;
        Thu, 07 Dec 2023 10:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701972571; x=1702577371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n5ZRbFTxvl5gVQWRXKJWEF7nKXIu01Clbw3olLA/fCQ=;
        b=RyFdm3yzSsl960UwhIGewoEz9GFnQayU/vHKRTxhQhEKfZfBtACNg6LPPteLmQ6nzG
         zrrA6tIlmET/SGgpdH2mVsIaQ/R70vMN43w8oJKcPZF8iZEX4aoI/WuNbcv6XLuUUYhv
         fYeAA4q4dwfTNbxTd51QX/Bg2mEsm7/E5uyLnQr7nbLoXs7kfEddHRtAjTQygAHIRkP7
         m6MzaZv5VR4fws7C7ERlhnoI+vRFC7svBjXpAUo1PmBtAbzpbKdospha9iAJtbSanqPa
         LtFG7r8xcc4qWDS3PtyeNzqDxLdagqJrkrd2ESAPCG+lh/Fkumx7mrVW3bXMW2Ahr9K1
         LyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701972571; x=1702577371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5ZRbFTxvl5gVQWRXKJWEF7nKXIu01Clbw3olLA/fCQ=;
        b=elVx6moT+4seluOtyEw/uk5ar3xo8jgNqNwUTtckhz/toXpczAiafpotG8fY/pjZZS
         H2fBi+XTJutOWoHku/MxfIbF0nRpHEgJPRKAIC0TzrU00f8pyFv5E8ptcB6U/r11GALH
         87pWWfZ+hkkbYzGofZk/XiUqPPHgdczFBj6wLFdjdDvsMUzPMuqeDCH8ool+JjBNv1XA
         pkwHySpxhAPuhseURyppwyaiwLLIw6hfQgK2bY98wyCfIXPexglpfFNYUYUz3HmmZvS/
         PutPQzWwMMAdSDMwizkzUspsk1j5Pl0cvB3njzX7Q5IBMSWuIRdpfZr4R8NwRHN9yuNR
         wzkw==
X-Gm-Message-State: AOJu0YyFyk7GbZENKdUZRdlwxGPG5IAoiE0VMoaRvOakrDbN8CwTVJk8
	SltpnMfUKOAxNo1wX/qra7I=
X-Google-Smtp-Source: AGHT+IHZAXkSmZQqB9z+1AqDiUbZeS4/8xz5Dhc+U7CesSrublwy8/I0tLRPl3cQl5XGwCzyydffiw==
X-Received: by 2002:a7b:c4da:0:b0:40b:5e4a:234d with SMTP id g26-20020a7bc4da000000b0040b5e4a234dmr2876477wmk.79.1701972571228;
        Thu, 07 Dec 2023 10:09:31 -0800 (PST)
Received: from nz.home ([2a00:23c8:a613:101:600:de73:7edb:4f76])
        by smtp.gmail.com with ESMTPSA id s12-20020adf978c000000b003333a0da243sm218359wrb.81.2023.12.07.10.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 10:09:30 -0800 (PST)
Received: by nz.home (Postfix, from userid 1000)
	id 9608F139EC7060; Thu,  7 Dec 2023 18:09:29 +0000 (GMT)
From: Sergei Trofimovich <slyich@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Sergei Trofimovich <slyich@gmail.com>,
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
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH] tools/lib/bpf: add pr_warn() to more -EINVAL cases
Date: Thu,  7 Dec 2023 18:09:19 +0000
Message-ID: <20231207180919.2379718-1-slyich@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before the change on `i686-linux` `systemd` build failed as:

    $ bpftool gen object src/core/bpf/socket_bind/socket-bind.bpf.o src/core/bpf/socket_bind/socket-bind.bpf.unstripped.o
    Error: failed to link 'src/core/bpf/socket_bind/socket-bind.bpf.unstripped.o': Invalid argument (22)

After the change it fails as:

    $ bpftool gen object src/core/bpf/socket_bind/socket-bind.bpf.o src/core/bpf/socket_bind/socket-bind.bpf.unstripped.o
    libbpf: ELF section #9 has inconsistent alignment in src/core/bpf/socket_bind/socket-bind.bpf.unstripped.o
    Error: failed to link 'src/core/bpf/socket_bind/socket-bind.bpf.unstripped.o': Invalid argument (22)

Now it's slightly easier to figure out what is wrong with an ELF file.

CC: Alexei Starovoitov <ast@kernel.org>
CC: Daniel Borkmann <daniel@iogearbox.net>
CC: Andrii Nakryiko <andrii@kernel.org>
CC: Martin KaFai Lau <martin.lau@linux.dev>
CC: Song Liu <song@kernel.org>
CC: Yonghong Song <yonghong.song@linux.dev>
CC: John Fastabend <john.fastabend@gmail.com>
CC: KP Singh <kpsingh@kernel.org>
CC: Stanislav Fomichev <sdf@google.com>
CC: Hao Luo <haoluo@google.com>
CC: Jiri Olsa <jolsa@kernel.org>
CC: bpf@vger.kernel.org
Signed-off-by: Sergei Trofimovich <slyich@gmail.com>
---
 tools/lib/bpf/linker.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 5ced96d99f8c..71bb4916b762 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -719,13 +719,22 @@ static int linker_sanity_check_elf(struct src_obj *obj)
 			return -EINVAL;
 		}
 
-		if (sec->shdr->sh_addralign && !is_pow_of_2(sec->shdr->sh_addralign))
+		if (sec->shdr->sh_addralign && !is_pow_of_2(sec->shdr->sh_addralign)) {
+			pr_warn("ELF section #%zu alignment is non pow-of-2 alignment in %s\n",
+				sec->sec_idx, obj->filename);
 			return -EINVAL;
-		if (sec->shdr->sh_addralign != sec->data->d_align)
+		}
+		if (sec->shdr->sh_addralign != sec->data->d_align) {
+			pr_warn("ELF section #%zu has inconsistent alignment in %s\n",
+				sec->sec_idx, obj->filename);
 			return -EINVAL;
+		}
 
-		if (sec->shdr->sh_size != sec->data->d_size)
+		if (sec->shdr->sh_size != sec->data->d_size) {
+			pr_warn("ELF section #%zu has inconsistent section size in %s\n",
+				sec->sec_idx, obj->filename);
 			return -EINVAL;
+		}
 
 		switch (sec->shdr->sh_type) {
 		case SHT_SYMTAB:
-- 
2.42.0


