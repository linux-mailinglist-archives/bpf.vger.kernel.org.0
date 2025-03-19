Return-Path: <bpf+bounces-54404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF52A69B91
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 22:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 926E1981C74
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 21:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7611721C9E5;
	Wed, 19 Mar 2025 21:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNUsKkoh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F67621A43C;
	Wed, 19 Mar 2025 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421252; cv=none; b=p/qdORqfps+5gnxYM8Y1J1uwrG+AhEt9XTp769P5Mhqv1s7ZhZ/M+53WHDbX4CvWGbc5sxPg9r2VSMS6ssrBpWlTXzn0lF4AU4wR6MHPSApcGje1SmVllH8f2Yt3KAuE06YUcvaDOmORbDsvQwDBFbaH1VYB6yDvZdTcuOGSNzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421252; c=relaxed/simple;
	bh=neDbu40ISQ9T7NoG8b3vjY7df+tdCtsATiunE1RAx4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n47l8b8eEU/2+nJAkCr9uWtDxTMWDBE5y61ytT183/zJkfGoczEYHUrwf6EtltSnKYf0RIpZffRTe97ENpBkAfwod/KkOy5eRXjG7YLBsdd+SRQDbARaViIuFH+deBsUyvQBUxcN+xiWalTWZ+51sYtaP5vS4D/ZM7EeFAcDH1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNUsKkoh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-225b5448519so988135ad.0;
        Wed, 19 Mar 2025 14:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742421250; x=1743026050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lO/+kBviSk5Nk705Nhk0txXJBkcBVv7rbgcbEyDfqh8=;
        b=nNUsKkohtuOeUYh6YY+i8rG8r7S2T6aKSWGCYZPTTdLNpKfUA6J8f33fOdAmTe2rT6
         CLJZ3KloDdHl9oq3QiG4q47IiQjMvuNM1wfEUYPuTdgZxvwwh5L7Xcs2LNSbh2HO4NO6
         XKaHCDIbX3/tMpd55B95VhjyHb5o/L8AfVb298fLZgAFigHfbODKp7rFSY2EVYKinnmH
         CvvxhZwXRToNXuyN1pIDIq3+b3LjInD6HuGilwQyqlfwosPbb1aH90wxYaVdMxc6rRCu
         mfwmjvsbh8RkZWD0yVpm2I246Q9qgMeLlf2CIjTgvZZqyqhR+C/88WErk+DDIPYIOdaq
         mM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421250; x=1743026050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lO/+kBviSk5Nk705Nhk0txXJBkcBVv7rbgcbEyDfqh8=;
        b=WK6PPfABJOQ7IuZk9zUU+H/IVm9hoI36H7XLB3BFaUs2NCo5eVhIh+GFNGh3aXwjDv
         HZTljIEkRS5qCbBBKOw1NE4vE4rEKF2+9kRYKhz2blOc8fMr6RQbnOzPGKeY3gGZkQwe
         6mG4SCcAtYsC+assOQhqPN47mfvztxU78K54GX5KkE1POG5//5zQu6v2O+G5hAzVn/cZ
         bUQIWpL5TrgOyMO8jt9++xZc/3j6+FdmdHnMo3Spzd8XKG2/ww07y0efPgtRnIOvtQaE
         eqzm3B5ZGwA2bosLvH6MJxIj8+e3mBmMvg7M5oP8Mm/XK4S159hEmWTc5SPj45a5tupG
         UbcA==
X-Gm-Message-State: AOJu0Yx8J1RS0qJJsKu/z9NcIuwBu5QRAXdtBdadra29q/1doEOdUARh
	ghKstqQ7lTEVNAEwv3I+tk5pCmVwnACgVA2sNRdOWs4xiWD5RF/qczC6WHTSEZ4=
X-Gm-Gg: ASbGncv+vSj5MJ8djSrh3M57cf8Nm4zg7yAhROtR6WqrMIDwkjQcTotb3Bj/daLPo4U
	lQiywYCfuavQtWfcJL33gflOcEjPXFdnsdodd8utfH13CjK2HhI/h4JyRfzU1bN9xpxAKLih/np
	XJRcIp3QV2ilu9Ldg+1/8SqmTc9tFKX6tsZpj2scRzm3ygJxxxeHk2iPR9Q7Y+WEENP7B/4VfX/
	MN7HxwMpJuuI6Tsc2ObjkhLtCsi0r0xuLmNB925hkusbPPYIVXebgMGzu72mh9BNqC5M+Sz8lrl
	C7nZ7JXMQiGhOIoEvuZhQhbGB7QTnBp9q8q2CkH0cJPkozOuZVN87LyAUfY4RdSPxdHug9SIdsm
	to6nwCvPE42Hyx2mfitU=
X-Google-Smtp-Source: AGHT+IH4XHushp9PaBlooyao7NdNpW6DLjoJ2WtLDhNpr5S8gJy23IHoI881753FFd6Cn3wO3McZ3Q==
X-Received: by 2002:a17:903:1d2:b0:21f:85d0:828 with SMTP id d9443c01a7336-22649c8f940mr71956625ad.41.1742421249633;
        Wed, 19 Mar 2025 14:54:09 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b0e8asm12175596b3a.158.2025.03.19.14.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:54:09 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	xiyou.wangcong@gmail.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	juntong.deng@outlook.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 01/11] bpf: Add struct_ops context information to struct bpf_prog_aux
Date: Wed, 19 Mar 2025 14:53:48 -0700
Message-ID: <20250319215358.2287371-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319215358.2287371-1-ameryhung@gmail.com>
References: <20250319215358.2287371-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Juntong Deng <juntong.deng@outlook.com>

This patch adds struct_ops context information to struct bpf_prog_aux.

This context information will be used in the kfunc filter.

Currently the added context information includes struct_ops member
offset and a pointer to struct bpf_struct_ops.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h   | 2 ++
 kernel/bpf/verifier.c | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 973a88d9b52b..111bea4e507f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1521,6 +1521,7 @@ struct bpf_prog_aux {
 	u32 real_func_cnt; /* includes hidden progs, only used for JIT and freeing progs */
 	u32 func_idx; /* 0 for non-func prog, the index in func array for func prog */
 	u32 attach_btf_id; /* in-kernel BTF type id to attach to */
+	u32 attach_st_ops_member_off;
 	u32 ctx_arg_info_size;
 	u32 max_rdonly_access;
 	u32 max_rdwr_access;
@@ -1566,6 +1567,7 @@ struct bpf_prog_aux {
 #endif
 	struct bpf_ksym ksym;
 	const struct bpf_prog_ops *ops;
+	const struct bpf_struct_ops *st_ops;
 	struct bpf_map **used_maps;
 	struct mutex used_maps_mutex; /* mutex for used_maps and used_map_cnt */
 	struct btf_mod_pair *used_btfs;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9f8cbd5c61bc..41fd93db8258 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22736,7 +22736,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	const struct btf_member *member;
 	struct bpf_prog *prog = env->prog;
 	bool has_refcounted_arg = false;
-	u32 btf_id, member_idx;
+	u32 btf_id, member_idx, member_off;
 	struct btf *btf;
 	const char *mname;
 	int i, err;
@@ -22787,7 +22787,8 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
-	err = bpf_struct_ops_supported(st_ops, __btf_member_bit_offset(t, member) / 8);
+	member_off = __btf_member_bit_offset(t, member) / 8;
+	err = bpf_struct_ops_supported(st_ops, member_off);
 	if (err) {
 		verbose(env, "attach to unsupported member %s of struct %s\n",
 			mname, st_ops->name);
@@ -22826,6 +22827,9 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 		}
 	}
 
+	prog->aux->st_ops = st_ops;
+	prog->aux->attach_st_ops_member_off = member_off;
+
 	prog->aux->attach_func_proto = func_proto;
 	prog->aux->attach_func_name = mname;
 	env->ops = st_ops->verifier_ops;
-- 
2.47.1


