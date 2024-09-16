Return-Path: <bpf+bounces-40005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F4597A804
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 21:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F78A28234B
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 19:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E77715C144;
	Mon, 16 Sep 2024 19:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="RD7rl4Ug"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB712E659
	for <bpf@vger.kernel.org>; Mon, 16 Sep 2024 19:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726516768; cv=none; b=Id8jBbJD0H010kgv53asP2L005yxJLzMBB6mMuQwT6Vtb+VBEiiXNoILHvQv2WWTMz04UCwd1v2Gb+Chn5Xg+EgS9DmWWLMzX4ki/TCLUyHnBLmzcaUwdzO9pO30IAjdvg5RFYQcQzd9j+w1zGb7CPF73RGUSikXp9XYQk1ylQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726516768; c=relaxed/simple;
	bh=2aP/yhGncrEQt3IQflU760fiq4klufQClPAUVslHYCY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=nHQHvKGVdYzbzi1pY2Gjc14JrtvxJfq1LqyVBw2vABhAvjr4R9/Qeh4eP2a56B7PUhucOACY6BbF/71iUowhMUInxs/97F2n4d6YzmMoICSbI/aITQrLlagyYlkGdEbwXqeIOSpmvLQBqW6FTMNEN4PEXNml0seiT3qlpKQRoiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=RD7rl4Ug; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1726516765; x=1726775965;
	bh=2aP/yhGncrEQt3IQflU760fiq4klufQClPAUVslHYCY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=RD7rl4UgQVyGH7sr9nOxy3STI3sFae9/Hsm0bQv2kv6n0/3GyPj2fwoig5kIM+20b
	 nYXBa6llzYizADFQvEr2e4jYInJBiDKXql6wFjB+tLKL+L05nV4qoMAHCYo3QC2o4u
	 ogvjPsxxhBP/CWvfCc6t//jAKlLxtlPFmOQ/f/7jYbll+5M0/TbLOY7tJEkYrC5ksU
	 i1X2kHs9dp45mk3d2Ti3vkPYR1DDXBlNejdNGxG414/RZYPpoid31+vWot7+mFRwc2
	 V3ZVxSTD9hMfW+jTrfuOq7JAX2rJrr9kTjdBNwrYSuPhmTO3CS5zF1QnK0Wo+a2Rom
	 0sSOsKOKwtD7A==
Date: Mon, 16 Sep 2024 19:59:22 +0000
To: bpf@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, bjorn@kernel.org
Subject: [PATCH bpf-next 1/2] selftests/bpf: remove test_skb_cgroup_id.sh from TEST_PROGS
Message-ID: <20240916195919.1872371-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 2e50422ea314ec3c3b75f89cee4af312cbb4826e
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

test_skb_cgroup_id.sh was deleted in
https://git.kernel.org/bpf/bpf-next/c/f957c230e173

It has to be removed from TEST_PROGS variable in
tools/testing/selftests/bpf/Makefile, otherwise install target fails.

Link:
https://lore.kernel.org/bpf/Q3BN2kW9Kgy6LkrDOwnyY4Pv7_YF8fInLCd2_QA3LimKYM3=
wD64kRdnwp7blwG2dI_s7UGnfUae-4_dOmuTrxpYCi32G_KTzB3PfmxIerH8=3D@pm.me/

Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 tools/testing/selftests/bpf/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index f04af11df8eb..df75f1beb731 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -132,7 +132,6 @@ TEST_PROGS :=3D test_kmod.sh \
 =09test_tunnel.sh \
 =09test_lwt_seg6local.sh \
 =09test_lirc_mode2.sh \
-=09test_skb_cgroup_id.sh \
 =09test_flow_dissector.sh \
 =09test_xdp_vlan_mode_generic.sh \
 =09test_xdp_vlan_mode_native.sh \
--=20
2.34.1



