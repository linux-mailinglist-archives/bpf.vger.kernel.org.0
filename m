Return-Path: <bpf+bounces-38299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19898962ED7
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 19:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9FF4282995
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 17:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3341A705D;
	Wed, 28 Aug 2024 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="bKxxT+qb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973C21494AC
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867180; cv=none; b=T4afJGxQmY73cpxN2s/S5eY87vTT3mR77ZpJJZKt3sZtWcY+fx9E59gh7Bnnfamj7xLld2vNjpGgslUU49CpRexQxyzXH3FRr2h1aHmif8asCrVlDDj1Am2AWMslL5LnVkRSbHaDoSU8AYLGe2zhJE8xFHbshcQQtN1oAZz+fGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867180; c=relaxed/simple;
	bh=nkCcXQDV/mdZLX18VUtj4JuBZeCvMj1Cf+DewzIYzww=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Nj3wHKIy0jT5PVA2txOYMqNilKzvbTmVNrQqf98ziizQ/YW8YIBZfdLmyzbBqAjve8u6+BKqH3xllf7AxVz87uDJB8b83b1mtHnfxqmEM1TfpjQuZ63SCtwLFQRAskKAj+HV8aVhRI4EHMo4z1JeS6eDtH5CJCExHJJotQesJV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=bKxxT+qb; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1724867176; x=1725126376;
	bh=tTEFrSeRUTfQXamaeVUCKec9AJ5LPsMxJSjJ8kzhlG8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=bKxxT+qbyY5NLJ+6L+LfVVpHO0YtRbvtfBxsSPqDihhIltKyjvpb4zuS6MQ0Src8s
	 a8hvziRuVQkCsTbdrpmU3rq5b5kZzqQIRItWNeZFspqLxFlfGJdQD3aFGDcF9OA9ai
	 AFPV6BgpM5ySdrW7ekvlwIFP75Exn9FVCwAIOzOj3+pJ8AzcbD+XxQMtFN9iu1KbzK
	 rmhUMbp4OSG06PHKygTwxlL6Aqu2xoQfa5+qn+h6Ug8IOWbNlFjjpz1IDcr0z+jvY6
	 w1hidMCepdqQha1faI/O4SnaIWaszl1wiNZAVcITmbMFR12rDCgRe46XGd6fiHpOEY
	 kN1p1gFv/Miog==
Date: Wed, 28 Aug 2024 17:46:14 +0000
To: bpf@vger.kernel.org, andrii@kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com
Subject: [PATCH bpf-next 1/2] selftests/bpf: specify libbpf headers required for %.bpf.o progs
Message-ID: <20240828174608.377204-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 221ce0a4ffcdcf5c23a252a751abf3bbf020d665
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Test %.bpf.o objects actually depend only on some libbpf headers.
Define a list of required headers and use it as TRUNNER_BPF_OBJS
dependency.

bpf_*.h list was determined by:

    $ grep -rh 'include <bpf/bpf_' progs | sort -u

Link:
https://lore.kernel.org/bpf/CAEf4BzYQ-j2i_xjs94Nn=3D8+FVfkWt51mLZyiYKiz9oA4=
Z=3DpCeA@mail.gmail.com/

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 tools/testing/selftests/bpf/Makefile | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index c120617b64ad..53cc13b92ee2 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -516,6 +516,12 @@ xdp_features.skel.h-deps :=3D xdp_features.bpf.o
 LINKED_BPF_OBJS :=3D $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
 LINKED_BPF_SRCS :=3D $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
=20
+HEADERS_FOR_BPF_OBJS :=3D $(wildcard $(BPFDIR)/*.bpf.h)=09=09\
+=09=09=09$(addprefix $(BPFDIR)/,=09bpf_core_read.h=09\
+=09=09=09                        bpf_endian.h=09\
+=09=09=09=09=09=09bpf_helpers.h=09\
+=09=09=09                        bpf_tracing.h)
+
 # Set up extra TRUNNER_XXX "temporary" variables in the environment (relie=
s on
 # $eval()) and pass control to DEFINE_TEST_RUNNER_RULES.
 # Parameters:
@@ -566,8 +572,7 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:=09=09=
=09=09\
 =09=09     $(TRUNNER_BPF_PROGS_DIR)/%.c=09=09=09\
 =09=09     $(TRUNNER_BPF_PROGS_DIR)/*.h=09=09=09\
 =09=09     $$(INCLUDE_DIR)/vmlinux.h=09=09=09=09\
-=09=09     $(wildcard $(BPFDIR)/bpf_*.h)=09=09=09\
-=09=09     $(wildcard $(BPFDIR)/*.bpf.h)=09=09=09\
+=09=09     $(HEADERS_FOR_BPF_OBJS)=09=09=09=09\
 =09=09     | $(TRUNNER_OUTPUT) $$(BPFOBJ)
 =09$$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,=09=09=09\
 =09=09=09=09=09  $(TRUNNER_BPF_CFLAGS)         \
--=20
2.34.1



