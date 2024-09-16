Return-Path: <bpf+bounces-40006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E35897A805
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 21:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E6E284098
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 19:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB96315C15D;
	Mon, 16 Sep 2024 19:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="DNg/pLXL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910ED15B0EB
	for <bpf@vger.kernel.org>; Mon, 16 Sep 2024 19:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726516778; cv=none; b=nRHaxX6q571e0R0jrzioqHv94CPQHty8gob6wxwRgQnRcnKoZ05uxAa4qQstou5448atfQ/re6V4uvPWvSlIYxEdh2doMzvCymM5TB9WpbN8dQYUxCrNrM58/LAxE5EW+M0z6SNhX1AwxpUTfhRCmnq41x26V6yqCvhoqktRK4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726516778; c=relaxed/simple;
	bh=hQZBL71A+6h8yI2OlTqFi1ETIaIJ1SfzQ7bGAfPwxSY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TMEg7DCnpl0yxKuZQpr582HeA/8j4MUJAo7rjV+p6mh2M01bnEsjRE5yg7riX3729PYuEjKTwQqfh9yt00g4/O41FycCP8kQukKNh+VwMF9n5cEgZQwch4NP//YQH/XwcrghrtPcTfJQrVIpwhOj5pIP1arlEmxzzZdvAx4fn6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=DNg/pLXL; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1726516774; x=1726775974;
	bh=hQZBL71A+6h8yI2OlTqFi1ETIaIJ1SfzQ7bGAfPwxSY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=DNg/pLXL/Zouhbqyb4fIe3ZrTuCHhbyqENPuc8QEiX0rXPh6vEy+A+jqOCvk8kmeq
	 hE/Z7LNlY/rPHodP8VEUrVmdyZyiHmag6/mB6vNhOTd6MuPqmvJWf1cRJm3PyC5SJm
	 mkGfyDvSmmyg10hmrzoSIvDOj0mAlEsTLkSTMJfyH9MqamrRqwY3AeSWCTFbRA2/f8
	 7iONX5+bBC/r9VnePwQ/5fbCGOm7H8ZMnoS2ruZD4NkBsP+tIuzg3mAqBSzXSkcMtB
	 bcPJlemjthlhbuo4TqRijMcyEZp4MaseTFtsgatlCqh7tk/r9vKHv68oaiRylBBe7k
	 mAKduGjLNngmQ==
Date: Mon, 16 Sep 2024 19:59:27 +0000
To: bpf@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, bjorn@kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: set vpath in Makefile to search for skels
Message-ID: <20240916195919.1872371-2-ihor.solodrai@pm.me>
In-Reply-To: <20240916195919.1872371-1-ihor.solodrai@pm.me>
References: <20240916195919.1872371-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: b02cb4556e3ac5faaa5ba24bbf2832ea00998c60
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Auto-dependencies generated for %.test.o files refer to skels using
filenames as opposed to full paths. This requires make to be able to
link this name to an actual path, because not all generated skels are
put in the working directory.

In the original patch [1], this was mitigated by this target:

$(notdir %.skel.h): $(TRUNNER_OUTPUT)/%.skel.h
=09@true

This turned out to be insufficient.

First, %.lskel.h and %.subskel.h were missed, because a typical
selftests/bpf build could find these files in the working directory.
This error was detected by an out-of-tree build [2].

Second, even with missing rules added, this target causes unnecessary
rebuilds in the out-of-tree case, as X.skel.h is searched for in the
working directory, and not in the $(OUTPUT).

Using vpath directive [3] is a better solution. Instead of introducing
a separate target (X.skel.h in addition to $(TRUNNER_OUTPUT)/X.skel.h),
make is instructed to search for skels in the output, which allows make
to correctly detect that skel has already been generated.

[1]: https://lore.kernel.org/bpf/VJihUTnvtwEgv_mOnpfy7EgD9D2MPNoHO-MlANeLIz=
LJPGhDeyOuGKIYyKgk0O6KPjfM-MuhtvPwZcngN8WFqbTnTRyCSMc2aMZ1ODm1T_g=3D@pm.me/
[2]: https://lore.kernel.org/bpf/CIjrhJwoIqMc2IhuppVqh4ZtJGbx8kC8rc9PHhAIU6=
RccnWT4I04F_EIr4GxQwxZe89McuGJlCnUk9UbkdvWtSJjAsd7mHmnTy9F8K2TLZM=3D@pm.me/
[3]: https://www.gnu.org/software/make/manual/html_node/Selective-Search.ht=
ml

Reported-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>
---
 tools/testing/selftests/bpf/Makefile | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index df75f1beb731..365740f24d2e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -622,10 +622,11 @@ $(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_OUTPUT)/%: $$$=
$(%-deps) $(BPFTOOL) | $(TR
=20
 # When the compiler generates a %.d file, only skel basenames (not
 # full paths) are specified as prerequisites for corresponding %.o
-# file. This target makes %.skel.h basename dependent on full paths,
-# linking generated %.d dependency with actual %.skel.h files.
-$(notdir %.skel.h): $(TRUNNER_OUTPUT)/%.skel.h
-=09@true
+# file. vpath directives below instruct make to search for skel files
+# in TRUNNER_OUTPUT, if they are not present in the working directory.
+vpath %.skel.h $(TRUNNER_OUTPUT)
+vpath %.lskel.h $(TRUNNER_OUTPUT)
+vpath %.subskel.h $(TRUNNER_OUTPUT)
=20
 endif
=20
--=20
2.34.1



