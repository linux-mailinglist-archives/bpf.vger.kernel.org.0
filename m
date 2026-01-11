Return-Path: <bpf+bounces-78499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A3AD0F8DE
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 19:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E118C30222F8
	for <lists+bpf@lfdr.de>; Sun, 11 Jan 2026 18:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A64A346AF5;
	Sun, 11 Jan 2026 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGlo2NKr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7F31F03D2
	for <bpf@vger.kernel.org>; Sun, 11 Jan 2026 18:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768155604; cv=none; b=U5FGDxP3MvOY/0mCcMMSS1jS0K8DIx9XQR4g+RwcdzJQAZyEhZP+2EWflwUohVM0fKRYXXHICxQocyjUXyU7WfkfHarTvrT0PEamChueJc3nuV7G3JNv1z0HmuNe9lCO8/wKFaFtWyi8c+NklN/UQAfxZLXPNF/m045LogXdcCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768155604; c=relaxed/simple;
	bh=WymWNbIQciCU5EbBq8ElcTDUqCPmTo/gV0/C1bg9nzw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NIOmGtpTA7gZpaxuxMaf/9sIp4mab3UC8TgJjySTVdATNQ6kGsHWnEpRIhCGk2ETOjUUA7V7NBgKya6oY7Y44dg07gsm1/kgpCrWuVv4GFxIf9loy4+A+I2LqbSz44KJv6mxGe6G3APHSBV9vJiCBSvzWiGdRX/NNNwP8Bo0U+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGlo2NKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF76C4CEF7;
	Sun, 11 Jan 2026 18:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768155604;
	bh=WymWNbIQciCU5EbBq8ElcTDUqCPmTo/gV0/C1bg9nzw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=PGlo2NKrO281FBabjp4WQoRDGDKJwpQGrGWGWpX7lM4urZENyMmnYlOgCx/UuaOVH
	 NEObW0VGbHNxlbrghmR5bgv+neHviwS//hewCCAQ3iY3fEsFgTlL2bRFyfqA+cqVGa
	 oSlRJLFwOKJfGo9QDxvOaf/I5WoC0G8w96YzYudZMnAuSu+QiRC7OpCVY1F0A0DAwQ
	 zQQKuj7VxHIiJdSTMpbr+7bwam078dl3Y4V1PGUD6ptea91KMYeCF5yEyZbooUaGIJ
	 NTGdHgYKJqqSV7Jfg0SU1STEDbfOKUKX+3owMuyQHBroCzFxVcUh5I0PWebKPr3SME
	 iZLFKZ6kOqUgg==
Content-Type: multipart/mixed; boundary="===============7762207774725564671=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fc6647632698325f86e40bd2d6d19f1255ab3c9621e0b875965abfed07e99fe2@mail.kernel.org>
In-Reply-To: <20260111175813.2252-2-qikeyu2017@gmail.com>
References: <20260111175813.2252-2-qikeyu2017@gmail.com>
Subject: Re: [PATCH] selftests/bpf: wq: fix skel leak in serial_test_wq()
From: bot+bpf-ci@kernel.org
To: qikeyu2017@gmail.com,andrii@kernel.org
Cc: martin.lau@linux.dev,bpf@vger.kernel.org,qikeyu2017@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 11 Jan 2026 18:20:04 +0000 (UTC)

--===============7762207774725564671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/wq.c b/tools/testing/selftests/bpf/prog_tests/wq.c
> index 15c67d23128b..d000d9dbdf46 100644
> --- a/tools/testing/selftests/bpf/prog_tests/wq.c
> +++ b/tools/testing/selftests/bpf/prog_tests/wq.c
> @@ -17,7 +17,7 @@ void serial_test_wq(void)
>
>  	wq_skel = wq__open_and_load();
>  	if (!ASSERT_OK_PTR(wq_skel, "wq_skel_load"))
> -		return;
> +		goto clean_up;

Is there a clean_up label defined in serial_test_wq()? Looking at the
function, I only see wq__destroy(wq_skel) at the end without any label.
The only label in the file is out: in test_failure_map_no_btf().

This appears to cause a build failure since the goto target does not exist.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20899649668

--===============7762207774725564671==--

