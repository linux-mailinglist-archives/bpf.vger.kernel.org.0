Return-Path: <bpf+bounces-22179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1AE858636
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 20:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6369B2095C
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 19:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C61E1369BE;
	Fri, 16 Feb 2024 19:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fo/s7x8J"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773BA135A62
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 19:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708112083; cv=none; b=ktsJXFxtDQSg6NjWQ5PUow5MyyO/2r3wV/PURMMHtD/PjMgsHBi4ZSlnNSjcJBMDhHZRifQRY+tLrAKNHSHe5/pyA1y5VXAAYs4kkWmG01MtTQwe9SVXLGbH5Palgnd/s2QDMmPps8Jf78NKHPAnxKWL4d3D8M87zB3GwN031UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708112083; c=relaxed/simple;
	bh=i+Xhnu2emPM8c3ZSTUcSQSlVRJkZNYRsb+nGgWaEsf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sHMoh+Y5E8E9FLGIFVYFhYU/5tV3Bd86RSCFDNSRhqul6T/m9ISEDFKOaGld40uFcuH7Ih1Ei2smlmZqfwQkpPYTCB0cumm4dShE9PWIPl17e/2vevclMMYo0o0OotMFsYYRi+HtWwlSD72YmyljrUbacOx+88dayQWWQ2JMIME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fo/s7x8J; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-607e60d01b2so6573347b3.1
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 11:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708112081; x=1708716881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abRQKB3Tjfx1ABWZplXt9I8J14hGcd94gAE4dJYLpFw=;
        b=fo/s7x8J+B7GpN3qGpCs6wSchBQZLvBSLofFOa/hBY6CBb+3fRiFEFPULSQyvXB1Hv
         MmNLDDwex3uQlbPO8eg02I0XTbf9KuEO4w68s5sru0jY80SH7eBKDcS20FRevTibEyWG
         gwPwqkt7fcWmCuFmjJM/t+wYkomOeKrAn5RHmG5gxHuw4soa/VV5vY8FG5qKjBzeO83E
         XDJbIb96xYfQKXITRV5p+fiCCTYOz1+MoCOaqviN2zEparW291vIMRMIj7MfmkONJx9R
         WfNAFSv15sRY0G8zP5/r7vOOUcmC8nIxugGN15TuR0XfgBZrvWJiQX4drvQyx0tg4Hul
         v0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708112081; x=1708716881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abRQKB3Tjfx1ABWZplXt9I8J14hGcd94gAE4dJYLpFw=;
        b=w6KkU03+Xd0wgR6CHJxESUtPaB9Q+HjaAmjJemYVHUx+OumcZz2AA+Uvpog6u0+oUs
         +EpzXT9VragVbzd1vP+i9AbeqkO2sUx09iuXj12kHrwFA5nGuCPVPEvkOmf9ai0YOQWF
         /uK0tFeGoc5XJerCljnI6yE5bTFQHjrQr15GxMcR4Rsj/I10PDSxzyQo5E6bXPa6coLN
         ZJ4JTnNxq0/lW8X9WgGRs880kpXs4Al1h1X3q/XS8LbNIe1aMPHADxQIYjm/3OKQbgiP
         +7qiL/lkl66xORjAtgX75uGM3tgriYw217Bm4TIQQTD6Pi3iT0+wW2GeW5pSONWIF2Bs
         VRcg==
X-Gm-Message-State: AOJu0YzRlF6r3QUbQ5IjPJ4KEtHD1VuKMALfOl399HQ1eQVZ65K4Jh0p
	oM/DxtQhvJ7GeAP9NU9FNT3t8rCX+aZit4UwOUKPz3BCttiHmM2DNgh1/EBZ
X-Google-Smtp-Source: AGHT+IF2ibV647IB2IBCeSj6mM8Uo14ZuDyFOeWj33PbfLmfk+lIWX6VHgUgh9Ydte+cpjrZyrpAgQ==
X-Received: by 2002:a05:690c:714:b0:608:98d:6f77 with SMTP id bs20-20020a05690c071400b00608098d6f77mr759874ywb.0.1708112080890;
        Fri, 16 Feb 2024 11:34:40 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:6477:3a7d:9823:f253])
        by smtp.gmail.com with ESMTPSA id i126-20020a0df884000000b00607c2ab443dsm470785ywf.130.2024.02.16.11.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 11:34:40 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH bpf-next v3 1/3] x86/cfi,bpf: Add a stub function for get_info of struct tcp_congestion_ops.
Date: Fri, 16 Feb 2024 11:34:32 -0800
Message-Id: <20240216193434.735874-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216193434.735874-1-thinker.li@gmail.com>
References: <20240216193434.735874-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

struct tcp_congestion_ops is missing a stub function for get_info.  This is
required for checking the consistency of cfi_stubs of struct_ops.

Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 net/ipv4/bpf_tcp_ca.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index 7f518ea5f4ac..6ab5d9c36416 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -321,6 +321,12 @@ static u32 bpf_tcp_ca_sndbuf_expand(struct sock *sk)
 	return 0;
 }
 
+static size_t bpf_tcp_ca_get_info(struct sock *sk, u32 ext, int *attr,
+				  union tcp_cc_info *info)
+{
+	return 0;
+}
+
 static void __bpf_tcp_ca_init(struct sock *sk)
 {
 }
@@ -340,6 +346,7 @@ static struct tcp_congestion_ops __bpf_ops_tcp_congestion_ops = {
 	.cong_control = bpf_tcp_ca_cong_control,
 	.undo_cwnd = bpf_tcp_ca_undo_cwnd,
 	.sndbuf_expand = bpf_tcp_ca_sndbuf_expand,
+	.get_info = bpf_tcp_ca_get_info,
 
 	.init = __bpf_tcp_ca_init,
 	.release = __bpf_tcp_ca_release,
-- 
2.34.1


