Return-Path: <bpf+bounces-54282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6558A66E67
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 09:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E9C3BA395
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 08:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7556E1F875C;
	Tue, 18 Mar 2025 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IddWpiE0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CAF1993B2
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 08:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286961; cv=none; b=uMSqMDT9RNylfqcwp3pjHe0LXQFtn2zY9g4mSG9v4txKVC4WzPK9mp8Nn8ciOOebNBAWD9+fcUfGSjfW8S7ywbLsl5bn7hhGTGuL0g3LQlo5BAnr0Tg3bWEb+kOOERKTKvAdRQuHHXcI9RVJ/XtbcAcbRjWenIJ6OxpwuGkOTZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286961; c=relaxed/simple;
	bh=ofHQXrOci6TdGiHJcpZUGt8ernJPxhSeLSQt7wgr2zM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ei1kInhHvIAU8vYjF3cqC2tQ50jfswAc3dcKxOWr6R/pnV187qPfm9iZLJUQ4SVQTB3ktopcQZCfaaGlEB0COMblrwCVN9yf5Fbz/DU2DsoYOTVucZb9m0VYeECFkvw0Dnd7ipfiPvmEocXcnblXaOA4h+bfpXas60GjQKG5KcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IddWpiE0; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e673822f76so8854775a12.2
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 01:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742286957; x=1742891757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q2VPnGRBzcv+Kb08eyb1zKUI7ekF3pqYETYwQknPA3E=;
        b=IddWpiE0+xUS3r8/NCJ2IuJ7Ar6RQ4KAinFE1vZOlYGX9QONVTMyLfuCXitt0V8WYW
         wm4SfPJAbuHbcMydy5/pKUsyRzPyTDnVNI9F8/o2vCyjSu6/l5MNn/LdgnfqJLl6viX/
         m1N6arvgEDCrr4yrcw+cVfQ3tM/z8tLDY8DOQOGnTFPM7AIC6xKplCYYdtf7x5OWhyGZ
         dkYPt4gwPqL3owsQsJa9a8NAFqg228TapCCWOdjnotQEo0K6D+9gBcrnYq8Eq0zflH6M
         vVShafxb+Zk3rwWTg5VRTM2uo5hKAnn2lO6HIJqWGDbdzD2iE6Z5OsEe+IpJ5HBfxfzX
         /h2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742286957; x=1742891757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q2VPnGRBzcv+Kb08eyb1zKUI7ekF3pqYETYwQknPA3E=;
        b=qazZR+8e6WyTDniToTLGdqT7bC6FKoogEVhvM4sOKRiQ4nMFskl3oPn0yLCEikBeqS
         A8fN7dmT0ysckyICefucczpgU1oYCjnYQSOPypvdDgtkazY7IUV4WbKCBWjLQ9YqU0/9
         fJ3IdVZvS9SNb/jr94Zdyu/GaXGHa+nRXIDu6EPTbH0s4LoEbDfJUw44miF04K+yItr6
         UyMm2aOsq4X7HS5CfrS24EVc7M9nQwsz+enV6dWb2z3uQGwIdko3vy2cG4HQezGlaGIC
         W0M+NAn7yIooY06sOephsxOr8BQivDV4k8RBo9msDS0PoIxCysVTrU32g3V1WUw04GSv
         WbVA==
X-Gm-Message-State: AOJu0YzndoOTH0QKbsNJWZO2y+ERvkeaPjp/B7uy005qVBqTgQP0amso
	fLtJQl3DX5zVLSTRGto4uBPaCqINfPXbg/KxQ31sKuvbc+mSnJQNP2O7WaeA
X-Gm-Gg: ASbGncvJ+9woundqD0Htc9ARs8X6BL2TNarRNBnm/mqrzv+vo5yAehr4CsKUwx6MevT
	B9xcOHjbn8rmuNQnXe+YjZIyLCEPuPPP6J9KvxcKi6DDMwomVbCyRkWjCsrL1h3ltKKHtRUwJU2
	epV2NpZdsB9u0bc5JVPTd5ASVX5oCzTFsDrBhAhnoZB/70ojRmB9XQuzGt6Dpv1rVKlCgKoQJBm
	TT86+v1+Yhux63YcDMdF6UbmQwN+WoW8LYDgHsRrEp4dAXPbMTPfz8kxnsTiApgpYBRj68IQmNp
	2aQcvMrVlB5roKympUqLnQ3AG6/b31Y24u6N6Ft803qkXIYsscgX0EdP
X-Google-Smtp-Source: AGHT+IEJhK2yOsxTuXsF2I1d/sA9sGkjqOqTBtLRa9tdImPoqoB64Bik/0Tf1sSH/i/OrDAxEoARkA==
X-Received: by 2002:a05:6402:1d53:b0:5e7:88d8:30a6 with SMTP id 4fb4d7f45d1cf-5e8a0421852mr13377090a12.20.1742286956530;
        Tue, 18 Mar 2025 01:35:56 -0700 (PDT)
Received: from andrea-terzolo.. ([151.33.82.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e816977a5fsm7194853a12.32.2025.03.18.01.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 01:35:55 -0700 (PDT)
From: Andrea Terzolo <andreaterzolo3@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrea Terzolo <andreaterzolo3@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf] bpf: clarify a misleading verifier error message
Date: Tue, 18 Mar 2025 09:35:45 +0100
Message-ID: <20250318083551.8192-1-andreaterzolo3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current verifier error message states that tail_calls are not
allowed in non-JITed programs with BPF-to-BPF calls. While this is
accurate, it is not the only scenario where this restriction applies.
Some architectures do not support this feature combination even when
programs are JITed. This update improves the error message to better
reflect these limitations.

Suggested-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Signed-off-by: Andrea Terzolo <andreaterzolo3@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3303a3605..2e94fe5ea 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9887,7 +9887,7 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		if (map->map_type != BPF_MAP_TYPE_PROG_ARRAY)
 			goto error;
 		if (env->subprog_cnt > 1 && !allow_tail_call_in_subprogs(env)) {
-			verbose(env, "tail_calls are not allowed in non-JITed programs with bpf-to-bpf calls\n");
+			verbose(env, "mixing of tail_calls and bpf-to-bpf calls not supported\n");
 			return -EINVAL;
 		}
 		break;
-- 
2.43.0


