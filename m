Return-Path: <bpf+bounces-38539-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85E8965D5F
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 11:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99575282D4E
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 09:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A71179658;
	Fri, 30 Aug 2024 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4uEqh1w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983291531F4
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725011523; cv=none; b=UGqCJ9qz41eUfongdp6ulVeV5boewM2YP0br6MoaHh373CPioNsgJ1YteH/sucjcWsKFrhJnChpzI/E0QLVSXptbW17xIWzKk9okXKz6HaX7+mZXHyyO3kbSU+XAEdX8/i4PJSQ4c/ybrCkTqmqD+4G7StzKJDq4Z0DDmhg0fjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725011523; c=relaxed/simple;
	bh=scBnoADUbkX3m7BHVI6H1RilpDlr6MBU9gfdKY2dDAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sH4q/HHobASId12n4FOayOh1IkJ/qc7P6SdAEukWGyzmO4y85HUVFSEf6j8ajd0P8bIu06hraIYxaRFQAlWH+M0ZB0UGsDC/boFlf1A1NTFedcWACQf6pmw7A5iCAOX5qL8rN7J1zZh6R+anAppG+N5yjJhfpcuMrqiHtN/hGRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4uEqh1w; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2702ed1056bso989934fac.3
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 02:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725011520; x=1725616320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkTUoTuRHaDFBV6Xt1fxkV1+5elOBbNVEarklhktxMw=;
        b=V4uEqh1waSRIp/8j0E+wqh5RSWSfBe0cM5h62pbx/YopmkOGaxMgKAKJqt/9jaZEFO
         QSW5HoDRq8SUv5kp5IK11WhlNIJElE/rffPQERJmOPXfcmoYCaolpBhmxqWpKGz4AvVJ
         e/YNtgpPf6qy0EuHflZD7XBUNziL3ASXvE7VoNWsSpa8QiJ0K4VlFV/wh7VjndkUYSMN
         IBrijvjI1aM4XqhegCOXBHsII+haGWDhDCAk44OLz5HJrHv4YF5l0vyjBdhynFPoArHf
         xp/RETgoNNCMz5TI6w3Wxj2imCzLOwCFYGrYfdvMY+esR9pB19/D7a0cQOdmFAVIZTdy
         hAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725011520; x=1725616320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JkTUoTuRHaDFBV6Xt1fxkV1+5elOBbNVEarklhktxMw=;
        b=NeAPBAgjMErDsXeELOcxXGUQ4Dj4swMLtdyfP6hm7P65DJnkmP4ENpWi6w4c14/7lB
         gHC17yrh3PRKVdmlk52v6CuyYhuLg9AIsxhIJFoDy2SG2c24ZuWSaAdmNRUDOoBxHE/h
         SkTHm3Xf4n3IQ+22SrcbcAkq1VMFzJPRDUJKEvRSDO0dIgR9N2tJL1cxzJYKo/lrxWh5
         F6NUGJLpb3EwgAGiwdvtISJNGYUdcwmplEQaaY29MLRKThEWmUkZRR7UFSBLd1nyrQZG
         6C8x2go+mtTDIGnd+gqpNcZRx2WQltXUY/Lngp3N4VGHTLbmIqg9tFor4iyaadmGJZ0H
         EGjg==
X-Gm-Message-State: AOJu0Yz0DJ1WdG/KaLJAAk1S+0MShPAnF2U6N4Rx1+yAPLdxb+RcCRsO
	izLZ/wlxTYVvE8H8yh99URGzocjQGSoZwZ0wg35J0CHHHABmfN8kz4WkJQ==
X-Google-Smtp-Source: AGHT+IGpikJmmg0o5ii8I+Kds+Snck8CO+/8ug8s+VBbMT/ZfTRA1FVyd/Qxn3X9sqPojFxnayd8jw==
X-Received: by 2002:a05:6870:639f:b0:270:50f7:50c1 with SMTP id 586e51a60fabf-2779009ef7emr6214492fac.1.1725011520505;
        Fri, 30 Aug 2024 02:52:00 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9d512asm2590645a12.78.2024.08.30.02.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 02:52:00 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH bpf-next v1] libbpf: ensure new BTF objects inherit input endianness
Date: Fri, 30 Aug 2024 02:51:50 -0700
Message-Id: <20240830095150.278881-1-tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <5be4f797c3d5092b34d243361ebd0609f3301452.camel@gmail.com>
References: <5be4f797c3d5092b34d243361ebd0609f3301452.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pahole master branch recently added support for "distilled BTF" based
on libbpf v1.5, but may add .BTF and .BTF.base sections with the wrong byte
order (e.g. on s390x BPF CI), which then lead to kernel Oops when loaded.

Fix by updating libbpf's btf__distill_base() and btf_new_empty() to retain
the byte order of any source BTF objects when creating new ones.

Reported-by: Song Liu <song@kernel.org>
Reported-by: Eduard Zingerman <eddyz87@gmail.com>
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
Link: https://lore.kernel.org/bpf/6358db36c5f68b07873a0a5be2d062b1af5ea5f8.camel@gmail.com/
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/lib/bpf/btf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 064cfe126c09..7726b7c6d40a 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -996,6 +996,7 @@ static struct btf *btf_new_empty(struct btf *base_btf)
 		btf->base_btf = base_btf;
 		btf->start_id = btf__type_cnt(base_btf);
 		btf->start_str_off = base_btf->hdr->str_len;
+		btf->swapped_endian = base_btf->swapped_endian;
 	}
 
 	/* +1 for empty string at offset 0 */
@@ -5554,6 +5555,10 @@ int btf__distill_base(const struct btf *src_btf, struct btf **new_base_btf,
 	new_base = btf__new_empty();
 	if (!new_base)
 		return libbpf_err(-ENOMEM);
+	err = btf__set_endianness(new_base, btf__endianness(src_btf));
+	if (err < 0)
+		goto done;
+
 	dist.id_map = calloc(n, sizeof(*dist.id_map));
 	if (!dist.id_map) {
 		err = -ENOMEM;
-- 
2.34.1


