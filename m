Return-Path: <bpf+bounces-40069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAEA97C08F
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 21:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECFE8282376
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 19:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099611C9ECD;
	Wed, 18 Sep 2024 19:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="h9GN/g7E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC56712B17C
	for <bpf@vger.kernel.org>; Wed, 18 Sep 2024 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726688011; cv=none; b=I4ypdxJ9beFD7ledTerrhF5oF1dsz27PQMXbQseeGGL/Tjd3rP+etLbsZs0qHocE+FwUVZPNyxzMzXjSUexK5XroV+zY6/YL+PBuFW+IIXb63VUPSllniCloKVez1HdaNIZB85KKn7jEnxu6M+A30XLWmfnDAPKwXYLhNu83Zgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726688011; c=relaxed/simple;
	bh=oQLKF63sbb7ME34qfF3w1z5z75Fq2JOwScuNDPMpmzQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=QiodOvzeO4KKGbgOzBRy+a/JAI5w9BbYts8k3/Ikf5RgFySa8joNTNWG+FoMKsphyuwGwIHxybgBFUpQ0ubd4+bVwC8GeNVM15jS2TOqpPeJh6LkrONQQHNc7QuWs1bs+EEY9FqveW+t0bs1sBWCBmiaPlctb7LQ2MRdwRClV3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=h9GN/g7E; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1726688007; x=1726947207;
	bh=8NuMayBKBM4+C4bSmqsdvawOpW/E/2TAvO55Tn8XKps=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=h9GN/g7EMGv1TWlvE/tYIGcvYBnQ9XHJgy9lyfq3lRvx5VKqzq6ZaWVWAfmV8u13B
	 RvedSuFQGsnmrHXzJ0STPKCbnkr9HROq2EXnQWV0oiyy9PAkptfme/pN2cobciv2p1
	 ssVSYjVSXlpG8O9H5FAG0swXmwy+nNlG0RMv1O+0X+D/RegOklzLa4eMzXCW86T9Pd
	 AyVILCwyPkQUrSPafK9vewCvqdDTC9GrvD7X8ib2pFvfTGiKcK8ZMJ3Ys4LmCcwh2J
	 C/Ua6zECx90Ax0rLfzwvA6QpwHIRYuXeboFqBMSOUBDJJuBUCph7sWM8qT20pvT/kY
	 Ik7woGV8n6X4Q==
Date: Wed, 18 Sep 2024 19:33:22 +0000
To: bpf@vger.kernel.org, andrii@kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com
Subject: [PATCH bpf-next] libbpf: change log level of BTF loading error message
Message-ID: <20240918193319.1165526-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 7676296ea97efc4e841f8429c8d6e795629b8587
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reduce log level of BTF loading error to INFO if BTF is not required.

Suggested-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 tools/lib/bpf/libbpf.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 219facd0e66e..b8d72b5fbc79 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3581,11 +3581,12 @@ static int bpf_object__sanitize_and_load_btf(struct=
 bpf_object *obj)
 report:
 =09if (err) {
 =09=09btf_mandatory =3D kernel_needs_btf(obj);
-=09=09pr_warn("Error loading .BTF into kernel: %d. %s\n", err,
-=09=09=09btf_mandatory ? "BTF is mandatory, can't proceed."
-=09=09=09=09      : "BTF is optional, ignoring.");
-=09=09if (!btf_mandatory)
+=09=09if (btf_mandatory) {
+=09=09=09pr_warn("Error loading .BTF into kernel: %d. BTF is mandatory, ca=
n't proceed.\n", err);
+=09=09} else {
+=09=09=09pr_info("Error loading .BTF into kernel: %d. BTF is optional, ign=
oring.\n", err);
 =09=09=09err =3D 0;
+=09=09}
 =09}
 =09return err;
 }
--=20
2.34.1



