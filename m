Return-Path: <bpf+bounces-65019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36585B1AA31
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 22:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74D53B698E
	for <lists+bpf@lfdr.de>; Mon,  4 Aug 2025 20:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A470E238C07;
	Mon,  4 Aug 2025 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzI3PgT+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3C8231842;
	Mon,  4 Aug 2025 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754340063; cv=none; b=gKHBWh4oMCK9Acx2RUu+FzxmTFRh52WMAk+QAQQVevozd6NaHvlb1XmmflganaodIhxi8TMfRlGGQs1jeS9SnQ1Nx1HrDiRgO7FDOWx+5HPr0sKcE5oQFSCMsWcnfXyXQq+FxbPW776IJMbRYcieldJEIFt780kDuU0EuHshbOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754340063; c=relaxed/simple;
	bh=9eAvV9+NQOhCQGj2xEDwZ+ZARU2tdDyFH3888WUmqVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NvU0l0H8quxOci/G10kZhUBzncc2XRpgLuylFbxwhNPWvN9kk0//fTj1Ti9cXp0VxpIah/9+kv5yU1nNbEbLQsbQQfLizakv2nycq3/x13gfoT+v40qLyWwzcd8iftuI4PYkZqG04kY+oaxi3LYjxM8a6eLLY4pfyn4vQHXlyUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzI3PgT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26153C4CEE7;
	Mon,  4 Aug 2025 20:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754340062;
	bh=9eAvV9+NQOhCQGj2xEDwZ+ZARU2tdDyFH3888WUmqVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RzI3PgT+EsQMvzjzNNKXZUi6v3EmOqmyIEPTb8hgjHPWM4AO/IErS8rEPTsKJ1skB
	 1P6/3QC5d2v6szNCEBMhTw/MsmVlTzCBYI7/LkvX58gmMBWX1ASL1nl5TEfncVzhfF
	 WbVMp4x401uBsqSiXikCfETtXYJ+vgX/nBYE+EiB61BUOsRXIyRPjXjrRPCR9HX2wY
	 WUDYrNvBLakqetrk2wfaKxUIDgR0ZtQGmwyE666uItbC/9J04BeiIJmaj9iSVtUcm+
	 N2pFdZwU5TlZJryNPospy2ah+Q9VlLG6MrQaL/52DEqw/03iu6UL/YBfsS72PMOsAP
	 eSzpLAtS7+3fw==
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
Subject: Re: [PATCH bpf-next 07/10] riscv, bpf: Optimize cmpxchg insn with
 Zacas support
In-Reply-To: <20250719091730.2660197-8-pulehui@huaweicloud.com>
References: <20250719091730.2660197-1-pulehui@huaweicloud.com>
 <20250719091730.2660197-8-pulehui@huaweicloud.com>
Date: Mon, 04 Aug 2025 22:41:00 +0200
Message-ID: <87a54e3jmr.fsf@all.your.base.are.belong.to.us>
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
> Optimize cmpxchg instruction with amocas.w and amocas.d
> Zacas instructions.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

