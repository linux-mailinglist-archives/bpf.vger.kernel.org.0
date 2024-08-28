Return-Path: <bpf+bounces-38300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E9B962ED8
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 19:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56D971F241F2
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 17:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE141A7065;
	Wed, 28 Aug 2024 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="WgzHiusl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481C047F46
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 17:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867194; cv=none; b=iTFwd/qxvHRyRHug5D+8i7JZ3R3iOu/i1NxGkDlMAQPV5n6phnkSBzXiALpsu8S15wl2plfqRioeHRlqp88YVeMYNtHuUhJT/uXTxWhaPXko/HgbVgm4Cy1TV92mvnrRO2hXcj2kgPDC0A3yWuXVr0+tedPaMhzsd4CWRdxz1tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867194; c=relaxed/simple;
	bh=A0wnW1NSnEJhZKlZZv/p1c9qcu8JL0YptFf+ftNW1So=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDDIf/XYcltN84X/InpuQwmV+hqwloTANOjgcoxJTCZO5esk1g5o+DhTWz4oB7oKGcbBC/JJ8B0cYCFFkLE0xM/OwXY56IfV2UeZVCsPt/gTGeuqkILBuRo25zqJErHj6v9VIAdtATfY8H+JoiyiJpbtw7I8I3OKxa49fw5/bIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=WgzHiusl; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1724867190; x=1725126390;
	bh=Et19RCXm340CBimjeN2JzvnctL6rRMpzTVztmVo5lqY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WgzHiusl8ASkx1S3PmcenbDgJJZaN2wPykqkm4AyMRmfin01vBhjyMWNWU7wgN8P1
	 CCUhIUebup+CM+X1TDDMhoXb2HDt8o1IVRqI/P4kufAH4qGsYT/JGHBVxDtDS8/LY5
	 giOvYxtqyNqdEHlPqO1HD+m5/x519lnQeWPmM4R+q+BQAolt9IyCT60Hp8RkiGpQ+i
	 8ZH0Xo4qUpadch3JvbyhGWfRrRzPrHPu1wOY9rWwN6EX7xFR1ZzUAb4P84XMo2j7ac
	 F/V1yCumSLiF+TNTKOri+nDj5bzM5ePYXaYF+qMnS/6BkBUAKl9/56ojxYzghMNkGK
	 ILUTZWd4sLeXQ==
Date: Wed, 28 Aug 2024 17:46:23 +0000
To: bpf@vger.kernel.org, andrii@kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com
Subject: [PATCH bpf-next 2/2] selftests/bpf: do not update vmlinux.h unnecessarily
Message-ID: <20240828174608.377204-2-ihor.solodrai@pm.me>
In-Reply-To: <20240828174608.377204-1-ihor.solodrai@pm.me>
References: <20240828174608.377204-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 0af206ba7cb27c82b8c223fb3ebe92bba0946649
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

%.bpf.o objects depend on vmlinux.h, which makes them transitively
dependent on unnecessary libbpf headers. However vmlinux.h doesn't
actually change as often.

When generating vmlinux.h, compare it to a previous version and update
it only if there are changes.

Example of build time improvement (after first clean build):
  $ touch ../../../lib/bpf/bpf.h
  $ time make -j8
Before: real  1m37.592s
After:  real  0m27.310s

Notice that %.bpf.o gen step is skipped if vmlinux.h hasn't changed.

Link: https://lore.kernel.org/bpf/CAEf4BzY1z5cC7BKye8=3DA8aTVxpsCzD=3Dp1jdT=
fKC7i0XVuYoHUQ@mail.gmail.com

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 tools/testing/selftests/bpf/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index 53cc13b92ee2..7660d19b66c2 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -399,10 +399,14 @@ $(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)=
/Makefile)=09=09       \
 =09=09    DESTDIR=3D$(HOST_SCRATCH_DIR)/ prefix=3D all install_headers
 endif
=20
+# vmlinux.h is first dumped to a temprorary file and then compared to
+# the previous version. This helps to avoid unnecessary re-builds of
+# $(TRUNNER_BPF_OBJS)
 $(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
 ifeq ($(VMLINUX_H),)
 =09$(call msg,GEN,,$@)
-=09$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
+=09$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $(INCLUDE_DIR)/.=
vmlinux.h.tmp
+=09$(Q)cmp -s $(INCLUDE_DIR)/.vmlinux.h.tmp $@ || mv $(INCLUDE_DIR)/.vmlin=
ux.h.tmp $@
 else
 =09$(call msg,CP,,$@)
 =09$(Q)cp "$(VMLINUX_H)" $@
--=20
2.34.1



