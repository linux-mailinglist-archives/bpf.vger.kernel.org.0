Return-Path: <bpf+bounces-71558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E90BF6721
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 14:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 70C0E3500BE
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 12:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0AD2F5A2C;
	Tue, 21 Oct 2025 12:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SE+tjIlH"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0834E2FB637
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 12:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049687; cv=none; b=h1JXQEI+1ugBDHsHy1kXZyhkEXIBo0aANEdu9uo9uleZ0Z5afyXD/fsbv5KxBLpEj+KrqmM61v1DvJuNOYcuSUbHnOLEu73MljFr7DLwEhY70B2xowFZgvR7wfYnoYpbJwRH0w64MIrCa5zF6RsTsVXLt18mVybh6kPsyVvE6Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049687; c=relaxed/simple;
	bh=x3tqhV9Olle7rmOnzByYzJ9ESWOMGf4vmEoK23iSpLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=he0TTtEeOR6lcYgTRM9RY+3F0+cmhjwQjgzSVd6XOA3Ra+u96pDpoJWEA7/sR/+VRHPfv/aL7Z2koyv08p3uv89iURYMHabUMc78Uu59SmfDLLYHcYKMuWI3JNevrTGjwtFxAKYqArVcN6u46a1bfVUYNxHQNLETFOStCMTEPLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SE+tjIlH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761049683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H/vDFAbjmKyadjE9sNvUJxRLO0/03Ztq1NP0dJrlB4s=;
	b=SE+tjIlHupYbs9XkqMf6g3b358M3OhAosC63rPSImiYEl0pJ+/5Dy7tN+j8m9jHjdMFomk
	VncNCHPtnTekr1rYoSWwoy9N4sHFDICmskLKGM+pVlUyxzgqshQvlzQV5b+DTWBeb8DiNd
	7ZNlyuOpANQxH7SMOZDbeeSHpmO7JXw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-3B_Ol6NwOEWRzXbC9y57VQ-1; Tue, 21 Oct 2025 08:28:02 -0400
X-MC-Unique: 3B_Ol6NwOEWRzXbC9y57VQ-1
X-Mimecast-MFC-AGG-ID: 3B_Ol6NwOEWRzXbC9y57VQ_1761049681
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-40cfb98eddbso3156864f8f.0
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 05:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761049680; x=1761654480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/vDFAbjmKyadjE9sNvUJxRLO0/03Ztq1NP0dJrlB4s=;
        b=sidQMbJuAucDWcyG9Zn1en4Cwgjm7M+UIVTqd5l34SqBgxmnNHumzZmSR3OD2DrE1+
         yXmZjsIBPPVMtFh/GiTnapr4ulaV0iJbrVDQiUJJYSmSBcCFPIUYQhsTaVcVrcIqf9kp
         59Fv/FjNeXIbVJkv8d6g1EmewdexUK0UogeCCRxl7jnMGNqlHgRbdC744jZxun/3i4cX
         e5t93B3K8jqlcALJu07CKxZLIOB0qaOenFBD2K08MQ+mth8eZrMqnZSBiOuB7qfbHH4h
         iKDEllxzwoYc2SBHLPEobuiAwbxhxtEPZUJT2oe/ajHsXSqAOsS2qWNXweqweSADMgS8
         T90Q==
X-Gm-Message-State: AOJu0YwqTLaAMi8YgFPvxgLxVL3UzNKcIvnFf+TXtiBWq7E2Nb951o51
	L0nDKnhgjVdrUcWG+hSTdwECKlntK2zvafv3W6T2BNqPugUBPl6JAXlMAlQ8Dc0Ve/LiSvHLqNc
	5dBoIXIeRv7o3bQ9O5k05lvzsjjvA7JrljaE7x39gU0fkF/oXt8VBlKEgqJ9uZQ==
X-Gm-Gg: ASbGncvArD7BYzY0rNVCqWGsWuDEdZw8NYOAS2CckwnRtIbWHaS/59283HCu70RrdkF
	6XSJtwSEScOKhr7F8Qmlg1RrB0cGQolmDsLP9zMc+sQ7umlnVS0iwgdD+1cEi5+RYdKc8Mo3XoY
	h6+yd+Di7IrQzmdqMGn3a9FUJP3hiW/ehRfNHZwDEm5O3bQhj3H3+3XWFsy9/PFT8LKklI2jaAO
	ZRz97X4Ip6jIGYCPCm8JQbsIaZEtcpDSVY2IRcVcnmsEMjTpSpJiHUGBo7FWjPfVtWKNkV1tUea
	Gdfovt57Y/nIYRfDsrMVaI2m16Sj0AVHkPjXzMqgBsmO73HFhgGbT6St7ghAjBxFAw==
X-Received: by 2002:a05:6000:3108:b0:3df:9ba8:21a3 with SMTP id ffacd0b85a97d-42704bc0d07mr12668345f8f.18.1761049680405;
        Tue, 21 Oct 2025 05:28:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1T4QV5qRlsX4CYwsG5oN1xf2PIguQmX22CXcPAmlJ9zIRBsNadHzlZspnxlqbPcWGqFc5PA==
X-Received: by 2002:a05:6000:3108:b0:3df:9ba8:21a3 with SMTP id ffacd0b85a97d-42704bc0d07mr12668326f8f.18.1761049679993;
        Tue, 21 Oct 2025 05:27:59 -0700 (PDT)
Received: from fedora ([85.93.96.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5bbc50sm20425188f8f.21.2025.10.21.05.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:27:59 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	"Serge E . Hallyn" <serge@hallyn.com>
Subject: [PATCH v2] x86/bpf: do not audit capability check in do_jit()
Date: Tue, 21 Oct 2025 14:27:58 +0200
Message-ID: <20251021122758.2659513-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The failure of this check only results in a security mitigation being
applied, slightly affecting performance of the compiled BPF program. It
doesn't result in a failed syscall, an thus auditing a failed LSM
permission check for it is unwanted. For example with SELinux, it causes
a denial to be reported for confined processes running as root, which
tends to be flagged as a problem to be fixed in the policy. Yet
dontauditing or allowing CAP_SYS_ADMIN to the domain may not be
desirable, as it would allow/silence also other checks - either going
against the principle of least privilege or making debugging potentially
harder.

Fix it by changing it from capable() to ns_capable_noaudit(), which
instructs the LSMs to not audit the resulting denials.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2369326
Fixes: d4e89d212d40 ("x86/bpf: Call branch history clearing sequence on exit")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

v1: https://lore.kernel.org/selinux/20250806143105.915748-1-omosnace@redhat.com/
Changes in v2:
 - just silence the audit records instead of switching to bpf_capable()

 arch/x86/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d4c93d9e73e40..de5083cb1d374 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2701,7 +2701,7 @@ emit_jmp:
 			/* Update cleanup_addr */
 			ctx->cleanup_addr = proglen;
 			if (bpf_prog_was_classic(bpf_prog) &&
-			    !capable(CAP_SYS_ADMIN)) {
+			    !ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)) {
 				u8 *ip = image + addrs[i - 1];
 
 				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
-- 
2.51.0


