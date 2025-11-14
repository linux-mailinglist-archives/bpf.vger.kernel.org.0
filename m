Return-Path: <bpf+bounces-74595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C96BC5F903
	for <lists+bpf@lfdr.de>; Sat, 15 Nov 2025 00:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE3C14E720F
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 23:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5BC306498;
	Fri, 14 Nov 2025 23:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sYTcqJmX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A44298CC0
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 23:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763161600; cv=none; b=K4X3x0M38QjObfpHr8tMs9PrAbUzguWcgbUv4NYVXEvr4u7+lBaHupmRjkH7mYvVpHDT7glmZlKXHkVJaFqeVhjROt6uDivuwDnCwhuASxx9Ow3COoMK2bk97W7ATtOlOggAM4kn7AR6riaygiQ6uD63eWd5pv2BhcnR703Gqhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763161600; c=relaxed/simple;
	bh=TcvTf2UD5vj+h49ddT67q9OYGxb3x1nSZ+wiIRQCoaI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ys1itglqD4YX7J4HbIq+T2XnCUZ6lVjDOg6u3v1d8ZIqsf57HuTfUpl34SGjChZ+HFo2CeMucg/JLneDqHgxZJQhd5Zbz6+vQKLcrOfC5r/kY/WRz7EKYRCmmVdLCZ3BYapVXz4kKXY5vlXA195t8fsI/7G0j0Bsqz5q0XYeZMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sYTcqJmX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1260C4CEF1;
	Fri, 14 Nov 2025 23:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763161600;
	bh=TcvTf2UD5vj+h49ddT67q9OYGxb3x1nSZ+wiIRQCoaI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=sYTcqJmXZGvK621hP0aYOq9/pOWgXYrFDuL2699pSBh0ArXExwkdk4+V2o27fLo2q
	 4R0e+2EF28glbnMHELWb9HqPMKpN6sKOhmoXRJAoAFjtQvMUVPXB5J3d8V//tsLkkO
	 anBsjhBqe2R+yCmaupuvFNBIW554eqfW6Ozd4Xcgc/DskCnBwjhMWdOjiErCirHb03
	 zbYK3XTFt4UhnWMw9qmbw4EBHHzYdcigrXgVNUYap3fNyWIDjk60g074zRARA9dYQT
	 JClIGn1B+KHp0ao7AVGufi4iqnoPA4rv0mfTwFWkCtL7aUyyuSfq3ia9YabghRfIXP
	 P3DC23d4VgzZw==
Content-Type: multipart/mixed; boundary="===============3945166357026313020=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ab8f0f2626eea5beee45b6c6418f976a3cf060aba80320d0d9f13ebb814a9436@mail.kernel.org>
In-Reply-To: <20251114222249.30122-3-alan.maguire@oracle.com>
References: <20251114222249.30122-3-alan.maguire@oracle.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Allow selftests to build with older xxd
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,qmo@kernel.org
Cc: kpsingh@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Nov 2025 23:06:39 +0000 (UTC)

--===============3945166357026313020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 34ea23c63..8687c17c5 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -731,7 +731,8 @@ $(VERIFICATION_CERT) $(PRIVATE_KEY): $(VERIFY_SIG_SETUP)
>  	$(Q)$(VERIFY_SIG_SETUP) genkey $(BUILD_DIR)
>
>  $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
> -	$(Q)xxd -i -n test_progs_verification_cert $< > $@
> +	$(Q)ln -fs $< test_progs_verification_cert && \
> +	xxd -i test_progs_verification_cert > $@

Should the symlink test_progs_verification_cert be added to the cleanup
targets? Currently it's not included in EXTRA_CLEAN (lines 903-909), so
after running "make clean" the symlink will remain as a dangling link in
the source tree. This will appear as an untracked file in git status and
is not present in .gitignore.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19379374420

--===============3945166357026313020==--

