Return-Path: <bpf+bounces-63858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DF4B0B706
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 18:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963D33B76A6
	for <lists+bpf@lfdr.de>; Sun, 20 Jul 2025 16:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06DA21CC48;
	Sun, 20 Jul 2025 16:48:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A76B28E3F
	for <bpf@vger.kernel.org>; Sun, 20 Jul 2025 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753030089; cv=none; b=Jy/Zz0PtmV42F7cX5t7bZYQ6o8LBYED4oHvuMLAbaSiTaA0vIeIvIyxA2xmvi2iwrJvG88ijKwplhd8uUOOh+WpWjWuhSaM84cHDv3DdDr87LHJdwyCXuwAEvxsuUbOgDN07pQo0FL25W3YbgYyRZPErutAJKlIeZb/308/E+E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753030089; c=relaxed/simple;
	bh=ED89noAsXTBPMM4lTHg2/VIScLIMz9rEczxR2DFsXTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=an2xhyQJXNN8EuVYrrmQDltSi7PIf2YBFRgXX3FSFwp6yjZ5VdLyhqkhkRjMEmWIVNlzRu5g8UwmAvgfZPbLadajVL17Mx2dEqRjCBI7jqlLVr071Id48hkwBQJIxCMz0yaRfyKWufiU+Nj1IO/GP8bjD7iqkKywVmRmJEVnIyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id CCB17BFC9B02; Sun, 20 Jul 2025 09:47:54 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next] bpf: Use ERR_CAST instead of ERR_PTR(PTR_ERR(...))
Date: Sun, 20 Jul 2025 09:47:54 -0700
Message-ID: <20250720164754.3999140-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Intel linux test robot reported a warning that ERR_CAST can be used
for error pointer casting instead of more-complicated/rarely-used
ERR_PTR(PTR_ERR(...)) style.

There is no functionality change, but still let us replace two such
instances as it improves consistency and readability.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507201048.bceHy8zX-lkp@i=
ntel.com/
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 72c8b50dca0a..2e1c0eab20c0 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -707,11 +707,11 @@ static struct bpf_prog_list *get_prog_list(struct h=
list_head *progs, struct bpf_
 	if (is_link) {
 		anchor_link =3D bpf_get_anchor_link(flags, id_or_fd);
 		if (IS_ERR(anchor_link))
-			return ERR_PTR(PTR_ERR(anchor_link));
+			return ERR_CAST(anchor_link);
 	} else if (is_id || id_or_fd) {
 		anchor_prog =3D bpf_get_anchor_prog(flags, id_or_fd);
 		if (IS_ERR(anchor_prog))
-			return ERR_PTR(PTR_ERR(anchor_prog));
+			return ERR_CAST(anchor_prog);
 	}
=20
 	if (!anchor_prog && !anchor_link) {
--=20
2.47.1


