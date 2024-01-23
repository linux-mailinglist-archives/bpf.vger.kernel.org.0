Return-Path: <bpf+bounces-20111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655578399E2
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 20:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1625B283EBB
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 19:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CFD82D77;
	Tue, 23 Jan 2024 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ym7vxU2D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342E3823D4
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706039695; cv=none; b=sX+7NphsfazfnrseLVeHELiQ3tlyTkWho1u74Og0Yh+vCAC8hO2xJ3wp1hpDgVBn/vWzkeS8M+NEhXHUK+h5gDdnyCB+cLTlAsse5y/q/BerNkLa6A1EatNxDHCP+ARhRVBl9ioGSBo1KB1ht6s2EGVmI8zi9n3VltDjZjj2a/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706039695; c=relaxed/simple;
	bh=HsE80BSDf3dP7dp3QIx/zCpzJs9ZWELkp2KEUKffScw=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=f4qtfN/PCB+R3XrJz8we4IVT535Yt/TzCqLKWCmYxP5Zl+YncbYll7ui+ZBVvLwOjE/N27/HlDoQ55nSVCkSayoM8nBQ/OTVyBPbej/IjBiKGrs7s/TvUxgjxC2Ep8AKjCmlpkHna0njzqlsxuGQm9k+BP+IBXwj+tJZPjpLJ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ym7vxU2D; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbdb46770d7so6719769276.1
        for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 11:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706039693; x=1706644493; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JhpX9hlE2Pci6VpOvhAwdkAo2oTmPgpj24BygTfmpHM=;
        b=ym7vxU2DD1SekWj+p8oY6xNLs/mGDhMzcWceyyPljE/L5dBzR3Ozz/7uTTRAssq2Ve
         GtsakM9yZA2SZT7QwhCU8FRiDrS3ti6mZOslkbfqiqXPEqxWy8a9AQ5O8+O9vpLVXbPe
         lT1WJGi1dmDhZlwVd/coY8xEhilGwIf1w0HPE6GfuvgGXTbUW2hbba1Ar0ZfB9YLkDSl
         n2Dsx8E2AC1p6hmv9PhCproTCAenKW5egLVixaaGuG7Ht8F5ac9a9lhTQ9SENH/6Et7Y
         IBtttE7yCsRNoZad5LGerQ7nYSH/sll+Rzp0GHVDvfcH+vtCxcg+ttNK7A/zbDsbv8Y4
         6O5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706039693; x=1706644493;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JhpX9hlE2Pci6VpOvhAwdkAo2oTmPgpj24BygTfmpHM=;
        b=JJOgLHWknMO4pQtyb134XuFrtpaRznjUoSyWAU2Z9T8InSjYlb/mbFXUQUvHJIwBb1
         ZxAtdCP8+63wbAB1QcV19bRaE2pyJQIuMLtZ+sw/n3h7/Ea1twNp1GLAsYIR7fcF/j2d
         adesnJ8880ySLp0MzVqPodtZPLun3OvOQfxM3dYRpxja2eqwc8VhC/16pDl0F4pQtPuz
         JrtAlMN1dp7KN7ADZe+Hnu+vZN173DKPIv1r0y+/1oFokeFMUVUX8MGkZZfbD0ewHAWJ
         Z9fzfYeiB309w2YM7TsTC1Q+3CYSHfrjzVvoIAQS5+bJ3FxaMpS0NfDXw9x9WzNHJeV6
         TICg==
X-Gm-Message-State: AOJu0YwvxOxSFBm0idziU260LqmJdFdzPgOfWt0pvZ1CWkK3FzHNVfyp
	yyUjUVAh/v4oy3/H3WdFXvrBR1MMJNz13h85Wwwz5lYj5BBTW2dpqIoM78ZkotlXdfX4Y0oD4dy
	StH5ggw==
X-Google-Smtp-Source: AGHT+IGAmS9Av+aJTpDnAXc+u2Z8XPgjzx85lccoKtnPOVvsWpoyTGg+NCMM7VkLAT8XQa12c5Cht0GU8BAs
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b37:2438:2b2f:daae])
 (user=irogers job=sendgmr) by 2002:a05:6902:1b12:b0:db5:4766:e363 with SMTP
 id eh18-20020a0569021b1200b00db54766e363mr2807736ybb.6.1706039693262; Tue, 23
 Jan 2024 11:54:53 -0800 (PST)
Date: Tue, 23 Jan 2024 11:54:49 -0800
Message-Id: <20240123195449.1303643-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Subject: [PATCH v1] libbpf: Add some details for BTF parsing failures
From: Ian Rogers <irogers@google.com>
To: Alan Maguire <alan.maguire@oracle.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

As CONFIG_DEBUG_INFO_BTF is default off the existing "failed to find
valid kernel BTF" message makes diagnosing the kernel build issue some
what cryptic. Add a little more detail with the hope of helping users.

Before:
```
libbpf: failed to find valid kernel BTF
libbpf: Error loading vmlinux BTF: -3
libbpf: failed to load object 'lock_contention_bpf'
libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
```

After no access:
```
libbpf: failed to find a kernel (typically /sys/kernel/btf/vmlinux) for BTF data
libbpf: Error loading vmlinux BTF: -3
libbpf: failed to load object 'lock_contention_bpf'
libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
```

After no BTF:
```
libbpf: failed to find BTF in kernel (was CONFIG_DEBUG_INFO_BTF enabled?)
libbpf: Error loading vmlinux BTF: -3
libbpf: failed to load object 'lock_contention_bpf'
libbpf: failed to load BPF skeleton 'lock_contention_bpf': -3
```

Closes: https://lore.kernel.org/bpf/CAP-5=fU+DN_+Y=Y4gtELUsJxKNDDCOvJzPHvjUVaUoeFAzNnig@mail.gmail.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/btf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index ee95fd379d4d..505c0fb2d1ed 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4942,6 +4942,7 @@ struct btf *btf__load_vmlinux_btf(void)
 	struct utsname buf;
 	struct btf *btf;
 	int i, err;
+	bool found_path = false;
 
 	uname(&buf);
 
@@ -4951,6 +4952,7 @@ struct btf *btf__load_vmlinux_btf(void)
 		if (faccessat(AT_FDCWD, path, R_OK, AT_EACCESS))
 			continue;
 
+		found_path = true;
 		btf = btf__parse(path, NULL);
 		err = libbpf_get_error(btf);
 		pr_debug("loading kernel BTF '%s': %d\n", path, err);
@@ -4960,7 +4962,11 @@ struct btf *btf__load_vmlinux_btf(void)
 		return btf;
 	}
 
-	pr_warn("failed to find valid kernel BTF\n");
+	if (found_path)
+		pr_warn("failed to find BTF in kernel (was CONFIG_DEBUG_INFO_BTF enabled?)\n");
+	else
+		pr_warn("failed to find a kernel (typically /sys/kernel/btf/vmlinux) for BTF data\n");
+
 	return libbpf_err_ptr(-ESRCH);
 }
 
-- 
2.43.0.429.g432eaa2c6b-goog


