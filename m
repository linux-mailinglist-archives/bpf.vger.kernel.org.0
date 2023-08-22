Return-Path: <bpf+bounces-8292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93BD9784A97
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 21:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3B4281169
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 19:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE41134CCC;
	Tue, 22 Aug 2023 19:39:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A030A34CC5
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 19:39:29 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5CCCDD
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 12:39:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c8f360a07a2so5522660276.2
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 12:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692733163; x=1693337963;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EodueCB6MBjkrakddlRe7HyP2pccydDQpTXXUjmwly8=;
        b=Mq0P/uAqdUYg+oVnLjp419DmSs2laB0hjFDKhRKRzloIaRjzqDA5eS4v7lU/Tjaged
         MN6QmhMymoAEUzc30Vj+J1EnRA4bjnfd5xsIu40vcxFAfWMkeWQA1mBonuWMaIjQ+MGm
         MHb/edvUe+17/doRkOj6KH+xIR5XJbP6h+rk0hwIZhCmgV/ZbGyjmMgqma92CXLgHjI9
         thsF7fFTVYVz4gOI3FFpUYlsvVzUixRO+hhbU4DmLZGdlX+1+eCyvwTVjBZc0lMdXtYd
         lm47z/W0tKWwmxF7FsQYm1PNPTlu/Dm92s4t/E8M/xNotVQVWoB5bQEfeOcPbxwkkLAL
         7WpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692733163; x=1693337963;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EodueCB6MBjkrakddlRe7HyP2pccydDQpTXXUjmwly8=;
        b=VhO4ERgK9+lyxpBvxqKqXv1DPabCcjqoQlsghAgRcg+TYVDNvWcANsOVUA4AePlXRz
         lAVJL1h+o9+9WXBlHJQYWHaa6bzyXbeDKEXuUVNwwmajEsf3xycUemanXTa0x6ZzZ1rj
         yRMBnl0kUZoLaX//SOJs+yPZjzNWuYML3/R6jWdTas6dAtl9jKYFCkQok2n5POeqsyr9
         EhEfzIgS1nBGJzvk3T6/UFaVf0nWqsw3xayxmfeBiZzp24CErvmquVj5fZnLGh0qnn1q
         k+sa6od/dN5T9XiNsAPBIhd3KodfpUdnDPkE1YG49n5Lj+XCJBsDkSre625IY5vrxBmA
         azUw==
X-Gm-Message-State: AOJu0YyVInEyWWb6n4ilXcHJRJ5DstknZbUDBJhoZRFQt8W9+bwe1YYU
	HUHlHaFJP3on0pL1fzec4i9fIpYxobHp+PJCvbpdC0R2i6Twe/qBB7wGrIL+OEgyv4ESz5K5I2U
	/PBdWZCyXL8WHyoHBzjjCJhk1VsR5vc1CvytaJaIFAsqJ1Bsb9jTqjefwpQ==
X-Google-Smtp-Source: AGHT+IGlAvuXUKTgHTQQQlL7EgwWFNA1njNFRuqPjn+J0y3yeCCDdrq6waMKStrV9BmLCvOhHvpVk1jwRsI=
X-Received: from haoluo.svl.corp.google.com ([2620:15c:2a3:200:c775:b5a0:a799:12e3])
 (user=haoluo job=sendgmr) by 2002:a5b:b86:0:b0:d74:cdb:adb5 with SMTP id
 l6-20020a5b0b86000000b00d740cdbadb5mr100154ybq.2.1692733163060; Tue, 22 Aug
 2023 12:39:23 -0700 (PDT)
Date: Tue, 22 Aug 2023 12:38:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230822193840.1509809-1-haoluo@google.com>
Subject: [PATCH bpf-next] libbpf: Free btf_vmlinux when closing bpf_object
From: Hao Luo <haoluo@google.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, martin.lau@linux.dev, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I hit a memory leak when testing bpf_program__set_attach_target().
Basically, set_attach_target() may allocate btf_vmlinux, for example,
when setting attach target for bpf_iter programs. But btf_vmlinux
is freed only in bpf_object_load(), which means if we only open
bpf object but not load it, setting attach target may leak
btf_vmlinux.

So let's free btf_vmlinux in bpf_object__close() anyway.

Signed-off-by: Hao Luo <haoluo@google.com>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b8afe2f5bc93..4c3967d94b6d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8423,6 +8423,7 @@ void bpf_object__close(struct bpf_object *obj)
 	bpf_object__elf_finish(obj);
 	bpf_object_unload(obj);
 	btf__free(obj->btf);
+	btf__free(obj->btf_vmlinux);
 	btf_ext__free(obj->btf_ext);
 
 	for (i = 0; i < obj->nr_maps; i++)
-- 
2.42.0.rc1.204.g551eb34607-goog


