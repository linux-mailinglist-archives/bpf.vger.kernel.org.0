Return-Path: <bpf+bounces-19719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90001830295
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 10:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4532F1F21ADF
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 09:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB1D1401D;
	Wed, 17 Jan 2024 09:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRrexsG/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC66D14003;
	Wed, 17 Jan 2024 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484688; cv=none; b=IAvkQ2ULg2MiNyS/tLLo8NkSompx12Gpm7zBL/A/nesnLy3IvBzBbK4hSCuKYtGeZme7vBnVFy0r+s6TbUd4dtH+OJxOJEuykAanmeXQx4/q1UdP9o6RF08/NT9oUBoYwFX3580iSnMxxvtrKn9rX2fp0kI07t5Fdxc/2XeASyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484688; c=relaxed/simple;
	bh=l0PkEeAvhIPy93Y3AIKp7rCxhbN2wMY5hHTk4Pq7NUs=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=OlK7Q9xCxcCDxW9WmrUGALOGAAa0hw8nzB9Mm9R7fbQlu8+CRA09tMS+6RbEyfyfoYX1b3KLgMYghTxKhfgQ2QyRLoaO7JJ6rmKPATKmdahwDabIkzIc6A9JpptqAIE4B/MIK2vnEgTNlnJ2SfhIsNRKrdPlfmc2rhkJWEqxAVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRrexsG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC06BC433F1;
	Wed, 17 Jan 2024 09:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705484688;
	bh=l0PkEeAvhIPy93Y3AIKp7rCxhbN2wMY5hHTk4Pq7NUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uRrexsG/zZn+1sHZRf92d4L5frAnNF0apqvnEvmkuAQjy+YnJ+qEISWN1Cjz9Le8K
	 G4arTAYhKaqzZcm7nTvqFJ3a+O/hir8cob5JbjJ2yqpFwzXNlrvbRD9L9sfr2c8PEA
	 ADYTEiB8/4AkV0ulmYlaEfVqiv7D5qsnnzXw1qT0dJ41aif4A7UE2NNs3qplvkjKWX
	 9B+FFSJTwt0vmuPCMCtmEuo3yM3/wuSR8rv0KCiyO7OlekyCllMkaG08i3AvP0zs6b
	 Ps5gXijbJbY9KKV+0H0r17GfMDlbxuOeOQm4ZJGjSIxO1/i7dNwG3oX3Qmx/i3YkUL
	 96AmcmzmtmUKA==
From: Jiri Olsa <jolsa@kernel.org>
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH stable 6.1 2/2] bpf: Add --skip_encoding_btf_inconsistent_proto, --btf_gen_optimized to pahole flags for v1.25
Date: Wed, 17 Jan 2024 10:44:24 +0100
Message-ID: <20240117094424.487462-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117094424.487462-1-jolsa@kernel.org>
References: <20240117094424.487462-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alan Maguire <alan.maguire@oracle.com>

commit 7b99f75942da332e3f4f865e55a10fec95a30d4f upstream.

v1.25 of pahole supports filtering out functions with multiple inconsistent
function prototypes or optimized-out parameters from the BTF representation.
These present problems because there is no additional info in BTF saying which
inconsistent prototype matches which function instance to help guide attachment,
and functions with optimized-out parameters can lead to incorrect assumptions
about register contents.

So for now, filter out such functions while adding BTF representations for
functions that have "."-suffixes (foo.isra.0) but not optimized-out parameters.
This patch assumes that below linked changes land in pahole for v1.25.

Issues with pahole filtering being too aggressive in removing functions
appear to be resolved now, but CI and further testing will confirm.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/r/20230510130241.1696561-1-alan.maguire@oracle.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 scripts/pahole-flags.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
index 1f1f1d397c39..728d55190d97 100755
--- a/scripts/pahole-flags.sh
+++ b/scripts/pahole-flags.sh
@@ -23,5 +23,8 @@ if [ "${pahole_ver}" -ge "124" ]; then
 	# see PAHOLE_HAS_LANG_EXCLUDE
 	extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
 fi
+if [ "${pahole_ver}" -ge "125" ]; then
+	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
+fi
 
 echo ${extra_paholeopt}
-- 
2.43.0


