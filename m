Return-Path: <bpf+bounces-35321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 862029397E7
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 03:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413C9282BA3
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 01:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C60913699B;
	Tue, 23 Jul 2024 01:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAzNvmQh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBC9130AC8;
	Tue, 23 Jul 2024 01:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721698127; cv=none; b=cHF16ncLRr+Cvzwxt2r/1nCJZTwjNgKXcVnZYJcNLiPhrXIry8APWJyhQYM1c861QZA3ZBROEMnlFEWY5jDNy2shaaEPqh5DS5/gD1ntB4NJn+kfvgeo+N/vK0lo+1Dfmx+/yV36+ECGSi6lLT1VMERTk1FvUfO+BaKhcgJxsaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721698127; c=relaxed/simple;
	bh=SQ2IEf6uLbp6ip3VzFb1HBH6eJI/KPdxvaQkO5d7/N4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoDposVd6xDO2b6vCv11ralbMkmPYIHo8H/WhHWJvUELwcWmPzkYOB2bP/Mf8rbZzEng2d8xEDUtw3TgCo9vkWVnpXnROTi2rrlHFOE0cBDtGkM8uI3R9s4YywqSNqJtHzmL46Mz9fHyrBWa4ZP76OWS6hj1DOnK4daK72HuXp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAzNvmQh; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eecd2c6432so72488501fa.3;
        Mon, 22 Jul 2024 18:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721698123; x=1722302923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4neOAOvc/P0MwJqYTyLb2Lt2JFbT6AmM7NbvKiw+YxI=;
        b=kAzNvmQhWpIigg/UZDCXisK2hZLzuBxOS/IWc0hu2x+ofkJKjl3TV7246fli50T+x4
         XBWbxjURcJCRIYM6Owhg3K/0nFYwF1JQm0hDqabYz3s0wrRvKF1ugpSssbe8Fsy7kX7x
         w5voVcPiMjbIVln9cDfaNLTJxoa8GhWZK4wF820X1Hpe0zxAjBEdLhVYrEHxDbpb3OaT
         rBurU+0wys94SrYyy9eC6Edj2XJJGErPrQsMPngIph54jMBwmSc5GnC/PUo2ARmPMcnD
         NQTeq6OMzltnaTQqFtCWK0bTCYtT6xNov4OZ1PfX9ekfAjuxZSm1YGMO1pmknS8jKcVR
         oyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721698123; x=1722302923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4neOAOvc/P0MwJqYTyLb2Lt2JFbT6AmM7NbvKiw+YxI=;
        b=jIaGjQ0gqxhZxLydMHFk5PRduxe+PucU0NBU4zgHHQwqAQqajN82qQH1ACxyey/GfR
         MHlUy6urE431K5m5UzL+mdGDv8vhd8JLGq2n5REHpjieM2ZRaG9aPW1WW6EqBeSZT9kv
         zUxgETbMfpZppsn9x7ixOCxxYo8GbcZeGgrQ+8DDjAf7DWUYk33JlpsNX5iXgrkaVmO4
         uZw6ZvSYEaesmClf/cps4/Y6x1hCFvDiIONQ6smm5HdQJ5MuHpREpo4Vbh2qSl2qHiYY
         Y/+tlwFG12w9Hml/pcCPZqmFITvS7exgyaBje9DLYHRBBA9d7KTxXAeZoaY07yvFPiQP
         TZiA==
X-Forwarded-Encrypted: i=1; AJvYcCV61in7AIJHeO2Cx/zbUhQNohqpKBxkndP3OYDavsybOQTHheFoyiq0/i3k2WJK2jeGHvC23oR9gcloEWkkREcxrUZlh+Enr2mBkzJzrQonaSV0J7Kfb/kFAfPbLiLd8bTM3N0EefF6
X-Gm-Message-State: AOJu0Yy+F122ak56BzSsY0xUHeMmJbvMvUxVAbSmnagGmnIQSOHADZzn
	JtWCnz/IMq5WhulPhnWSsDwsz8JAHjnp2i1iS0tVop5wS9qSV7Jk
X-Google-Smtp-Source: AGHT+IGdZz22bCtlmaWj0785V4Ked6hpxrQ8/xVksAey/DHb1sLF5mQABKu/Nk03eDuJlaMebbr8zQ==
X-Received: by 2002:a2e:84ca:0:b0:2ee:8f3d:e68d with SMTP id 38308e7fff4ca-2ef1685d099mr78962171fa.44.1721698123225;
        Mon, 22 Jul 2024 18:28:43 -0700 (PDT)
Received: from lenovo.teknoraver.net (net-93-66-31-10.cust.vodafonedsl.it. [93.66.31.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a8f3a47d2sm31435366b.81.2024.07.22.18.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 18:28:42 -0700 (PDT)
From: technoboy85@gmail.com
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Matteo Croce <teknoraver@meta.com>
Subject: [PATCH bpf-next v2 1/2] bpf: enable generic kfuncs for BPF_CGROUP_* programs
Date: Tue, 23 Jul 2024 03:28:26 +0200
Message-ID: <20240723012827.13280-2-technoboy85@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723012827.13280-1-technoboy85@gmail.com>
References: <20240723012827.13280-1-technoboy85@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matteo Croce <teknoraver@meta.com>

These kfuncs are enabled even in BPF_PROG_TYPE_TRACING, so they
should be safe also in BPF_CGROUP_* programs.

Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 kernel/bpf/helpers.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b5f0adae8293..23b782641077 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3051,6 +3051,12 @@ static int __init kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &generic_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SKB, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_DEVICE, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCK_ADDR, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SYSCTL, &generic_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_CGROUP_SOCKOPT, &generic_kfunc_set);
 	ret = ret ?: register_btf_id_dtor_kfuncs(generic_dtors,
 						  ARRAY_SIZE(generic_dtors),
 						  THIS_MODULE);
-- 
2.45.2


