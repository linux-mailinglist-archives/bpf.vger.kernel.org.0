Return-Path: <bpf+bounces-31289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D888FA9F4
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 07:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2B91F24C0B
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 05:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FFA13DDBD;
	Tue,  4 Jun 2024 05:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcbbUTLj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7CC13D612;
	Tue,  4 Jun 2024 05:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717478613; cv=none; b=QZLJq4Wkx+iL1lrmUIjSZzh4sR5wpoUUb+TjfREAhYHJbCeSIv3XZ05v/xo8z+IMmFfR/ZqczcuZhZHgNJF1+MvsEEMQL73gF6tigLZ4Fnpwd4PXjLmgCeVdNLHv/dphBbPJAzx3wWx8G+8z+f3Jm9I2T4YFz0Dt1bn7jsJkdbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717478613; c=relaxed/simple;
	bh=gAwp8yYUnceVBn5scRDmLBn983/3nY5FUXQpnAfxA4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uNGblZ+lajTDpK46EM37wZt/zmwsyD9+D2afNHZ+DKOolaJ7UScXlZDyakWrzzNakyNTp8B9p9NIRNkH7wq6rM3W9J3HDSlnuU2+NXE8yut6QnUy62y3TJMCQAb3jAK0UAXMQp4doht6lhW/yFnnG24vsfizUQFEzQB+M24yf20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcbbUTLj; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5ba090b0336so2103671eaf.1;
        Mon, 03 Jun 2024 22:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717478611; x=1718083411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dV9DumgWigNz8izFoAXbyFQWDVcRbsgIhRa9w5EE8so=;
        b=AcbbUTLjAH8huKng5c9gGfNj2lPQgiA5kLGlAJheHCCiyoY8UMWHa7Yi0sqXqlbIr4
         8ym67Qihyec/KF+BIqPCZJ7FMc2EtjrkKm8yOO4YUI1wqKUX27n5UGwb+4MFmL9DO8ZD
         /uMoAu2o6asp0J4peJEWlH8YHL6IBkE6PWEG+cxFLKpYde02Ff4Cq+0AFVeZSIPqC5ZU
         dR0cYdMoKl0Nc7zPRGtZwVoEx0KnVjuVDzu2UP8jGAHg9Ppz6TO6vOUj7ltuNf2Flced
         UrNF+7J4TZNhhcJXtc4eR/ymY2XMoIJqJXu8iVTWQJxbelNrAfUecRcDbAwRNKzMgmuS
         ks5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717478611; x=1718083411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dV9DumgWigNz8izFoAXbyFQWDVcRbsgIhRa9w5EE8so=;
        b=dFxaWp0U6bpdJwYffQPnqYnOEU3AwUAjKSIvljkHpk5PaBg74jqfj/F4cDK7q+E7NG
         uA35dIklNisNmUJm7NI7Y9wju7QdkO0pEci0LSOKeIwuGzYbRSjuV03CyVq6NRz42JWT
         9V1wphcsst21FZwa7iXl3FcJlmHaqSXlC9gc2cW/ajlPjEKmT9WXA2nh2y3gPyECeaP5
         26kJ+RRa5T+9CBhoj5E3z/gzwJf7aGYSYQx+XATgXpd1FECDt5Yh28Jb8nBpbEL8fiTK
         CYXvy+lfEBiIGo36f2FTM+YZMw1dBKFoH2eBwH3yvqlpkvpnsB57zG8RFdSbWJWiGJ1j
         wx3w==
X-Forwarded-Encrypted: i=1; AJvYcCVs6hZW+sT9sLIVShmHq0h4Q32fDDTJWWvs0qFNwt+TFsop35YscH4DtBlIPadSGnAt3uoBeOizv5duN035IuWquo8TB8Yl
X-Gm-Message-State: AOJu0YwOtRK7GgU+9jheT3hAEK/mW/9xSBJTUzUsOtCnuM0ZvxQ7Qnda
	oxtwRqZtxSzZr3MjRLnpk6ueWbLVni892A7QlF12XR8eV0uPh2+igLm125wC
X-Google-Smtp-Source: AGHT+IEdxeEjz09+FO3uavBBt0AAnX1tBSFOFscFyEd7xzuRcMmOsX7zrb/OEpecE/mL8fRqj+5eOQ==
X-Received: by 2002:a05:6358:a094:b0:198:ee95:e50f with SMTP id e5c5f4694b2df-19b48d78c49mr1398823955d.10.1717478610563;
        Mon, 03 Jun 2024 22:23:30 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c35937a496sm5303785a12.73.2024.06.03.22.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 22:23:30 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
To: bpf@vger.kernel.org
Cc: Tony Ambardar <Tony.Ambardar@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	kernel test robot <lkp@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf v2 2/2] bpf: Harden __bpf_kfunc tag against linker kfunc removal
Date: Mon,  3 Jun 2024 22:23:16 -0700
Message-Id: <e9c64e9b5c073dabd457ff45128aabcab7630098.1717477560.git.Tony.Ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1717477560.git.Tony.Ambardar@gmail.com>
References: <cover.1717413886.git.Tony.Ambardar@gmail.com> <cover.1717477560.git.Tony.Ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF kfuncs are often not directly referenced and may be inadvertently
removed by optimization steps during kernel builds, thus the __bpf_kfunc
tag mitigates against this removal by including the __used macro. However,
this macro alone does not prevent removal during linking, and may still
yield build warnings (e.g. on mips64el):

    LD      vmlinux
    BTFIDS  vmlinux
  WARN: resolve_btfids: unresolved symbol bpf_verify_pkcs7_signature
  WARN: resolve_btfids: unresolved symbol bpf_lookup_user_key
  WARN: resolve_btfids: unresolved symbol bpf_lookup_system_key
  WARN: resolve_btfids: unresolved symbol bpf_key_put
  WARN: resolve_btfids: unresolved symbol bpf_iter_task_next
  WARN: resolve_btfids: unresolved symbol bpf_iter_css_task_new
  WARN: resolve_btfids: unresolved symbol bpf_get_file_xattr
  WARN: resolve_btfids: unresolved symbol bpf_ct_insert_entry
  WARN: resolve_btfids: unresolved symbol bpf_cgroup_release
  WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
  WARN: resolve_btfids: unresolved symbol bpf_cgroup_acquire
  WARN: resolve_btfids: unresolved symbol bpf_arena_free_pages
    NM      System.map
    SORTTAB vmlinux
    OBJCOPY vmlinux.32

Update the __bpf_kfunc tag to better guard against linker optimization by
including the new __retain compiler macro, which fixes the warnings above.

Verify the __retain macro with readelf by checking object flags for 'R':

  $ readelf -Wa kernel/trace/bpf_trace.o
  Section Headers:
    [Nr]  Name              Type     Address  Off  Size ES Flg Lk Inf Al
  ...
    [178] .text.bpf_key_put PROGBITS 00000000 6420 0050 00 AXR  0   0  8
  ...
  Key to Flags:
  ...
    R (retain), D (mbind), p (processor specific)

Link: https://lore.kernel.org/bpf/ZlmGoT9KiYLZd91S@krava/T/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202401211357.OCX9yllM-lkp@intel.com/
Fixes: 57e7c169cd6a ("bpf: Add __bpf_kfunc tag for marking kernel functions as kfuncs")
Cc: stable@vger.kernel.org # v6.6+
Signed-off-by: Tony Ambardar <Tony.Ambardar@gmail.com>
---
 include/linux/btf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index f9e56fd12a9f..7c3e40c3295e 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -82,7 +82,7 @@
  * as to avoid issues such as the compiler inlining or eliding either a static
  * kfunc, or a global kfunc in an LTO build.
  */
-#define __bpf_kfunc __used noinline
+#define __bpf_kfunc __used __retain noinline
 
 #define __bpf_kfunc_start_defs()					       \
 	__diag_push();							       \
-- 
2.34.1


