Return-Path: <bpf+bounces-35374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1885939AC1
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 08:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80BC1C21B9E
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 06:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E7D14F9ED;
	Tue, 23 Jul 2024 06:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPo7vGxN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026F814F9E8
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 06:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717143; cv=none; b=nuRXkNhhjX+gqsL/b8WLqvc3jSCv4oQ1OeW3LP0YJI7Kmo/jRQwJoUBYOeLOf1r0K2wuK6nToY7V+qGHteQHce8bC1t8ngjJlxDJWpP9IOBa9pmokDErL6LMhNTQzMCvCkepF1EmB/sa6mBvjX1VuUL3vR6PoR1xcGh6xUbPHUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717143; c=relaxed/simple;
	bh=nz2YRgjvpN2Mw9C+ZM6X2RKR5ZPSUD4TyUqIH/p1Dak=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:Cc:Date; b=rg3dPquBRvILYjxggyEzFQ8D/SBhf53L7riTJlBNVKCaFjHL++32jd7WR5EnI6H1+eQnfKzhqRqTFTgA5paYbzJtexSrmvDimRJ3qKS15QpOY0/DsRcuu3C3W0arTO9nxMibqIJCkfSb8wziVeAn8KGrb2EM3dlZzQer74N6kWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPo7vGxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783C5C4AF0C;
	Tue, 23 Jul 2024 06:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721717142;
	bh=nz2YRgjvpN2Mw9C+ZM6X2RKR5ZPSUD4TyUqIH/p1Dak=;
	h=In-Reply-To:References:Subject:From:Cc:Date:From;
	b=ZPo7vGxNOU/ZFVPWbl8ct5N56SJE13NCkG9fF+7CTy5S8MACO33uTdfTdkO7T6kf+
	 eoOS60dqkt8R8m0VavxRs1WsBttby2obxADTa9E8fDzyqoChecB5B1i+Bv+erm17yF
	 gRdQxJYpD2ayEFrtGxN9EwfopMM38DOlqouSxehYNFPbWnATAA/xdrM6Toli149SpC
	 7h86O4nRid2MjrfW+1zqiQiBO/oL8WoL5AU10LmvCoQ1vXrdMFoZC078kHWM0N7Vyq
	 p5+dZG477h8HSs2QeEY3mWSN0RlzUJ8fTeuh9XdSEU8U9pEa24Uf34lw3OMvNr5PFI
	 vf9JbtFtMN1MA==
Content-Type: multipart/mixed; boundary="===============0112221765544347700=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0ef5a4d0ff320f0ad7fcc1b0e775f96bea9d3255dfee37a81fbbea95c3255873@mail.kernel.org>
In-Reply-To: <cover.1721713597.git.tony.ambardar@gmail.com>
References: <cover.1721713597.git.tony.ambardar@gmail.com>
Subject: Re: [PATCH bpf-next v1 00/19] selftests/bpf: Improve libc portability / musl support (part 1)
From: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 06:45:42 +0000 (UTC)

--===============0112221765544347700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next,v1,00/19] selftests/bpf: Improve libc portability / musl support (part 1)
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=873126&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10053605528

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============0112221765544347700==--

