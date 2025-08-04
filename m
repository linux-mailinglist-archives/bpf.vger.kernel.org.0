Return-Path: <bpf+bounces-65014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E254CB1AA1F
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 22:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34B218A3472
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 20:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3816A2376F2;
	Mon,  4 Aug 2025 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jz81xEhX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B0A232785;
	Mon,  4 Aug 2025 20:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754339232; cv=none; b=ellcEPjBgGRehizT91qvlY1O1wxPjYL3cBgq9dYnd+vUpE/Q4OKseeFV8aByw3h+VRnQm2zmbKgAxxe5WFj2DpkdN2G4n1uZTex4jnii08s5KSu/Ch05q0tWHB2lOPOlSfgb8SvgD2ORWD8kSdQ4+F65cXrVvu55IjuZaz8RD/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754339232; c=relaxed/simple;
	bh=k5iYYySHG/5Vfd/EFSgIWIBri0jYjQoozxrWTGCJIc8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tqly6sDLbUooDq4VHQdOTAUPILogdQmL/HOwi3miGKdtvrezK6Sfaa0Y8e/ucUuUoEIhUPBLLhRNlyjOYpEYj2EnBeapZw80M1gsUSulkkE0Z1mfQ5py8qiMkORj3dkWXQOvyuy7qRvmiXQMAq42oVS0JWFHCdhPjL8Y1q2F11A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jz81xEhX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C7FC4CEE7;
	Mon,  4 Aug 2025 20:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754339232;
	bh=k5iYYySHG/5Vfd/EFSgIWIBri0jYjQoozxrWTGCJIc8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Jz81xEhXHgQTDGtffbAFiQrMddlJq+HKTHTbuSwG+khg7OC80YrMcEzbbz4n6c8C0
	 IMKUlfyKUrSQvKI9jvSTbtp42M+M6mtFuAUIcJeEbOXJm+M14gOO3TemuKsyPVbqxx
	 k2IUQ3UfFH1YdxGsAfWddxjG63QNRM6dyM45isTWFFIPN5fS+O+kk+foEa0cPuV7p0
	 giqfltC+FXZ8NPLGAfJxP3J1J/SdNi35u+XA28PDROuGRZiucs6llc5zrnhxl7H24m
	 k4rdTYhoTvrFmWqVopmLYM2HhKNHWzbedFx0Z+KTzvogyrEWgWMbXIgPbWMRrVwdVV
	 WlWleDHgw59hQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Puranjay Mohan <puranjay@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Pu Lehui
 <pulehui@huawei.com>
Subject: Re: [PATCH bpf-next 03/10] riscv, bpf: Extract emit_ldx() helper
In-Reply-To: <20250719091730.2660197-4-pulehui@huaweicloud.com>
References: <20250719091730.2660197-1-pulehui@huaweicloud.com>
 <20250719091730.2660197-4-pulehui@huaweicloud.com>
Date: Mon, 04 Aug 2025 22:27:09 +0200
Message-ID: <87v7n23k9u.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pu Lehui <pulehui@huaweicloud.com> writes:

> From: Pu Lehui <pulehui@huawei.com>
>
> There's a lot of redundant code related to load into register
> operations, let's extract emit_ldx() to make code more compact.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

