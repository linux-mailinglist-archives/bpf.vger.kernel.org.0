Return-Path: <bpf+bounces-31171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A698D7932
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 01:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4871F2211B
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 23:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C35E7E586;
	Sun,  2 Jun 2024 23:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="l9WBlT7Q"
X-Original-To: bpf@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F402C36126;
	Sun,  2 Jun 2024 23:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717371696; cv=none; b=O/43s4O7JxJH5PcTMKYeqD1lmMuqR9oMkC4EXLb9ckgnXvHuVhXCKVU93tR/WuFPnb13kM9CSifVE5z/gQHipFjZzjs4izz/3QwcW1dfhIs75LuHJ1sFrFJN+7QQEKnoyFJyOO1v8W1pVxPpTTTkZFj7HYeoziG4+sGL52NSNgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717371696; c=relaxed/simple;
	bh=6lCSZZ5+cuu+s1oGH6U5gRl3+upNlfK/UoI5yiogqtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iRtJQMaTo0RxAAIcq7G4vDkaLA7RraowJ/RcqXSNCrRorE0n8YSXQAvDsDz5i8zX4QLvudHcDr6P3BoRDhFd+nevneCmRlp5sk7tEykxlVm7/Cs/VDYIODmOPlN0FPkCuFhdzDfwOrlaOgEIeB8HcY/lCmNwFq/3swBxxNZvP/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=l9WBlT7Q; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Z6jbCqP8Vd0dTBaITigzPsL4JWEJ0koZNpN7pbAHi0I=; b=l9WBlT7QfTjjoFVw
	H7sPw67qF3jA4wTxTS+axDvp53mn0ySSNDlgVzWYQQpZhZcjmWjgeMnpLRQom0Q8beOR9xqB/xIqv
	zricFgeVStKHg6+JrsYuYwWKYf4EGoo+CA9RapsPFdtd/Nmem3CTQw5GwLx7Wa0uZ/iIA66vCN3uw
	qF+CAvUiUqQKz+NbQWG0br5qt09EugbpUg+bkFZIyuClizz9l4b+d5L8/Xf5SUNk/MRSpd8pqoRIo
	p+kfasNAqUuGTAdNoXZCg5t9yLAhzcXOpTzihHUV0qYNE7iVpR4uR9pl0Z9NryL9RAFTcm+dmeFly
	qAFZl1Ac3DXdXdhcUw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sDupO-003r31-08;
	Sun, 02 Jun 2024 23:41:30 +0000
From: linux@treblig.org
To: andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	kpsingh@kernel.org,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 1/3] selftests/bpf: remove unused struct 'scale_test_def'
Date: Mon,  3 Jun 2024 00:41:10 +0100
Message-ID: <20240602234112.225107-2-linux@treblig.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240602234112.225107-1-linux@treblig.org>
References: <20240602234112.225107-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'scale_test_def' is unused since
commit 3762a39ce85f ("selftests/bpf: Split out bpf_verif_scale selftests
into multiple tests").

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
index 4c6ada5b270b..73f669014b69 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_verif_scale.c
@@ -45,12 +45,6 @@ static int check_load(const char *file, enum bpf_prog_type type)
 	return err;
 }
 
-struct scale_test_def {
-	const char *file;
-	enum bpf_prog_type attach_type;
-	bool fails;
-};
-
 static void scale_test(const char *file,
 		       enum bpf_prog_type attach_type,
 		       bool should_fail)
-- 
2.45.1


