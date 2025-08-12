Return-Path: <bpf+bounces-65476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89644B23C28
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 01:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4050E1B61A15
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 23:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF87E2DC343;
	Tue, 12 Aug 2025 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWkEC9ta"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9292D9787;
	Tue, 12 Aug 2025 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755039606; cv=none; b=REzDmrKpUMACMnT5h3SorDpyWFj98qs7YlNVlLWh1ii/SNpNShNMVzOwi+i03ear6V1KbW1wYYR/gttEo7D5EkjtzbZ7316SumCiW1sougapojmRtZPePDCLFLyJm7hQDCevZ3umvwd2blwCgdZIHwIIfWlYddy1SigPqAvjnL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755039606; c=relaxed/simple;
	bh=WSO2BcJG/GwX1GQjgMeXXXKPUA9sh33in9+xLkssH3g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gMF6EhwyWoJ0GbtVdmZK6Sxc2j6JZ7vBECDXMZZLyJRlQSokFBWMe/AWP0EeXojbqfGO5lf0IVoFu8Y9BeFMrtqAm77RdZ/1QKFx5rWmjoEspwqwQkNtdEN3QmkaKHZ/lOj/FpF5aS4lbPo7KC0N0Eufcv+NPpXz2cb8KW/e8F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWkEC9ta; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC71C4CEF0;
	Tue, 12 Aug 2025 23:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755039605;
	bh=WSO2BcJG/GwX1GQjgMeXXXKPUA9sh33in9+xLkssH3g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dWkEC9taJIwPeAnHPyX6fxsSsCx5E1mXT5sWrtwMwKWTAUAigh5b9b+ucOnxCdYUQ
	 eGdRGL6EufCIzBrezJZkSydNtAacpRIF6pNMc5JlBCLNcAdkYUCHSk1zD/+j585mPk
	 VQ4RE5l9lpKRLCK94Mu9b/563cZu51q7LpFhSdcSl2wo7IhkZVfod/F6JnOC3wtwk3
	 Oa4DIaxFYxcCTQltMoacyCpmqIWjW3sk0H4SFjh1mUkG2qvglcRAdQ0SuJYXmrX/ky
	 7htf/ERVPPn04HnQbQZNPJ/CiCnoZuiS90SeYLulUUOK2n92h7l6SjpQDE9Jy/2WrB
	 tMHne8lvSlU5A==
From: Nathan Chancellor <nathan@kernel.org>
To: linux-kernel@vger.kernel.org, masahiroy@kernel.org, ojeda@kernel.org, 
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, kernel-team@meta.com, linux-pm@vger.kernel.org, 
 Eduard Zingerman <eddyz87@gmail.com>
In-Reply-To: <20250606214840.3165754-1-andrii@kernel.org>
References: <20250606214840.3165754-1-andrii@kernel.org>
Subject: Re: [PATCH v2] .gitignore: ignore compile_commands.json globally
Message-Id: <175503960408.1315825.6402987041334486305.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 16:00:04 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev


On Fri, 06 Jun 2025 14:48:40 -0700, Andrii Nakryiko wrote:
> compile_commands.json can be used with clangd to enable language server
> protocol-based assistance. For kernel itself this can be built with
> scripts/gen_compile_commands.py, but other projects (e.g., libbpf, or
> BPF selftests) can benefit from their own compilation database file,
> which can be generated successfully using external tools, like bear [0].
> 
> So, instead of adding compile_commands.json to .gitignore in respective
> individual projects, let's just ignore it globally anywhere in Linux repo.
> 
> [...]

Applied, thanks!

[1/1] .gitignore: ignore compile_commands.json globally
      https://git.kernel.org/kbuild/c/f7cc3caea0005

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


