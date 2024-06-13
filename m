Return-Path: <bpf+bounces-32016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC34906188
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 04:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4D0F2844B4
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 02:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065DC22F03;
	Thu, 13 Jun 2024 02:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b="B9S/JyhC"
X-Original-To: bpf@vger.kernel.org
Received: from ha.d.sender-sib.com (ha.d.sender-sib.com [77.32.148.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737157F9
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 02:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.32.148.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718244473; cv=none; b=kjIgsJm3uOUDGhL58iMbegGLZ/SI4fhjPrP7aLBmP+wQP7b1Y3TSXP5ttIu7LTiNLivK4BECXDyzg8vplFfd6hiu2dJpLWwn9Bo8og8M+qslkhDHhfs71lc02wfHwzdKwBQNhfekP6dLG6/ynl5qIBUl1Yrq/HtRqil9fZrQkOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718244473; c=relaxed/simple;
	bh=JWnLsL90lOd+5snVGTs7d/oE1SEzC6gTrMRzT7IdgS8=;
	h=Date:Subject:Cc:Mime-Version:Message-Id:To:From; b=CFK5bwoY00L/eehfk2RYICotwtbvguagF0EHrnpJ+fOA1AmrvRTCP3da+FLqeC6DuEqu//0+/rgsBLW9tsgLAqtUhZ3acHErpL/+5eHFCRT6BqmYHkVT5Jw+oesoqmLVUnEHSxMWr5yNq+ThI472CUsceCo4235ctGrsHVnZ91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me; spf=pass smtp.mailfrom=ha.d.sender-sib.com; dkim=pass (1024-bit key) header.d=rcpassos.me header.i=@rcpassos.me header.b=B9S/JyhC; arc=none smtp.client-ip=77.32.148.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rcpassos.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ha.d.sender-sib.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rcpassos.me;
 q=dns/txt; s=mail; bh=5z64jXnyq0QJkDyxB94kOUZkmWAcqWYAl+OzUr2TMVM=;
 h=from:reply-to:subject:date:to:cc:mime-version:content-transfer-encoding:x-csa-complaints:list-unsubscribe-post;
        b=B9S/JyhCwKSJMRcTwHEnDjhYB4YxMyMLFv6kv4NzG1mIcVlpU0T6Pt4lDpIfNIxF8p6DS651o6Em
        TYE19oSEkTVYVpiDVpCZVmlXzWKyzb9AS3JfBRzP2xeeF63bEuI4u/McFUeRs5YTPZhq+QwXgb+M
        1vvVQ692Ahr6/fHPRg0=
Received: by smtp-relay.sendinblue.com with ESMTP id 32b460a6-822d-41bc-9800-4268496e8efd; Thu, 13 June 2024 02:07:42 +0000 (UTC)
X-Mailin-EID: MjM2NzcxMDk4fmJwZkB2Z2VyLmtlcm5lbC5vcmd%2BPDIwMjQwNjEzMDIwNzI5LjQzOTUzLTEtcmFmYWVsQHJjcGFzc29zLm1lPn5oYS5kLnNlbmRlci1zaWIuY29t
Date: Wed, 12 Jun 2024 23:03:11 -0300
Subject: [PATCH bpf-next 0/3] Fix compiler warnings, looking for suggestions
Cc: "Rafael Passos" <rafael@rcpassos.me>, bpf@vger.kernel.org
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: Rafael Passos <rafael@rcpassos.me>
Message-Id: <32b460a6-822d-41bc-9800-4268496e8efd@smtp-relay.sendinblue.com>
Origin-messageId: <20240613020729.43953-1-rafael@rcpassos.me>
To: <andrii@kernel.org>,<ast@kernel.org>,<bp@alien8.de>,<daniel@iogearbox.net>,<davem@davemloft.net>,<dsahern@kernel.org>,<mingo@redhat.com>,<tglx@linutronix.de>
X-sib-id: 9JBFXkkhIAneCmbXhaqs9MfyTe73y_G2Lkvl76bjjjyRjPhZXSgLshyCAPlAL2XO68Yu0Ty1OQ6UMtSzqn-cdIJjwaPyiZa-E0LxiKTsMVl3keWoIrcYmuJoidbitTdLWuGngwxoy8nwW0Qdg-1aMl4v-5EJt8pt7Me1IREZzZmQ
X-CSA-Complaints: csa-complaints@eco.de
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Feedback-ID: 77.32.148.27:6736438_-1:6736438:Sendinblue
From: "Rafael Passos" <rafael@rcpassos.me>

Hi,
This patchset has a few fixes to compiler warnings. I compiled and tested =
it.
I am studying the BPF subsystem and wish to bring more tangible =
contributions.
I would appreciate receiving suggestions on things to investigate.
I also documented a bit in my blog. I could help with docs here, too.
https://rcpassos.me/post/linux-ebpf-understanding-kernel-level-mechanics
Thanks!

Rafael Passos (3):
  bpf: remove unused parameter in bpf=5Fjit=5Fbinary=5Fpack=5Ffinalize
  bpf: remove unused parameter in =5F=5Fbpf=5Ffree=5Fused=5Fbtfs
  bpf: remove redeclaration of new=5Fn in bpf=5Fverifier=5Fvlog

 arch/x86/net/bpf=5Fjit=5Fcomp.c | 4 ++--
 include/linux/bpf.h         | 3 +--
 include/linux/filter.h      | 3 +--
 kernel/bpf/core.c           | 8 +++-----
 kernel/bpf/log.c            | 2 +-
 kernel/bpf/verifier.c       | 3 +--
 6 files changed, 9 insertions(+), 14 deletions(-)

--=20
2.45.2



