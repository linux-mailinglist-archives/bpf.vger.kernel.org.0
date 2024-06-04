Return-Path: <bpf+bounces-31385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27D48FBD14
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 22:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9665C28248F
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 20:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC2214B06E;
	Tue,  4 Jun 2024 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nn+oj0VZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0C71350FD
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531828; cv=none; b=TwiurTnDCSS7anTSaEeQaihi1VOnHy0OJYMfrzszQ1OH7KU8Yqnuwt5iu97v22ubynTVEWxyP071gme5HZqoBytcIrWam3liHqtwKmgA8JpiGt4aRqo6E7sjbMk4J2QyBAfJTUr7zOK7GWXe1aR8sUuZGxK6npie/vhdBbOeX34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531828; c=relaxed/simple;
	bh=Z/+c5sJjBLcoKZQ2EFUDlW57Vu6vJNpMoVcVY+6swMc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SLUYyetiIa+kLyhkfYoRprj71vX/PmVPRBe8783yTenotphbwhnUpPZ1FvX5Gxi9hFhTmx/OZT8Lf0tzJSpW0PunhDBcFu671GrKG2n0QerxhdWdNCvapD2ajGGgfVggur3jzc1FD91aga4T1FVkQgb1+Ub+nx4RwFQgZEUGigg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nn+oj0VZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99645C3277B;
	Tue,  4 Jun 2024 20:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717531828;
	bh=Z/+c5sJjBLcoKZQ2EFUDlW57Vu6vJNpMoVcVY+6swMc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Nn+oj0VZkKIffYLWLqla2rspHkV7+CfKSNm8EnNo0YNRWjBXwqDDrV78wsfd0Lwrn
	 k1U1k3CD8k1lC+wkgV4ul5YJMn1OofrhwGh7Xlwb2PJO75x+yjJjX66rCvCYq5w/AD
	 49o+5UZKsXsR1+m2Wib0ZWx1iOF14eP9EVsWoJH49+WFziKrjfbwlycxfqqZH/5Dyn
	 liH2J2iUWBLybj+dI5F0trQGz+zbNSJ2Ff6wgB81lxEwv53S413fmnlcQdobvI1EKW
	 EZbhNylO07Tkdlbz+KIRhfyKMHG63OuTO0FxiUeUx5jMCyhTn9Au3kJL/Zdyn/L9R6
	 ARIqDgGJkVJzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86FFCC43617;
	Tue,  4 Jun 2024 20:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Ignore .llvm.<hash> suffix in
 kallsyms_find()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171753182854.20801.387571766862079900.git-patchwork-notify@kernel.org>
Date: Tue, 04 Jun 2024 20:10:28 +0000
References: <20240604180034.1356016-1-yonghong.song@linux.dev>
In-Reply-To: <20240604180034.1356016-1-yonghong.song@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kernel-team@fb.com, martin.lau@kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue,  4 Jun 2024 11:00:34 -0700 you wrote:
> I hit the following failure when running selftests with
> internal backported upstream kernel:
>   test_ksyms:PASS:kallsyms_fopen 0 nsec
>   test_ksyms:FAIL:ksym_find symbol 'bpf_link_fops' not found
>   #123     ksyms:FAIL
> 
> In /proc/kallsyms, we have
>   $ cat /proc/kallsyms | grep bpf_link_fops
>   ffffffff829f0cb0 d bpf_link_fops.llvm.12608678492448798416
> The CONFIG_LTO_CLANG_THIN is enabled in the kernel which is responsible
> for bpf_link_fops.llvm.12608678492448798416 symbol name.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] selftests/bpf: Ignore .llvm.<hash> suffix in kallsyms_find()
    https://git.kernel.org/bpf/bpf-next/c/898ac74c5b5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



