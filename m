Return-Path: <bpf+bounces-33648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A30A4924326
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 18:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BA228C158
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 16:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76701BD01C;
	Tue,  2 Jul 2024 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2KpePO4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3127214D42C;
	Tue,  2 Jul 2024 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936311; cv=none; b=E0TX/Nnf6xAwr1ZOZ6p2jYVQBoY+pHB9EyHcHW/DIyzOr5DDE0O4c+q/HkEMbXHeVxmiB5noGpbLFYlgXphyHIMCWc68CLfxSx/nHUbv+s5BYj9m2sJCIyK8k3FMGkg3La7r71str/jc/95151npPkWe9r0DrajR/aqRxlF8lZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936311; c=relaxed/simple;
	bh=gcPZu10Fun4CSdDBFTvZqP809dlNmXQL0R/O6Jbl7Pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RT2FAHSQYOfQrtzFsAlqqLsj220mzodc/XQ3csFo47LiC2K3BQNP5/wak2nOoyYdXmqAheCzSLvV+tuMdK+iN9sPXEvgyHzBgqm+3xHftn8lzShs4qr9Mw3crPU6bj5Ok/2FFdoK3zs8+boc9Gt5mfx/bRoU+5K3h2Z4jI7XD3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2KpePO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00769C116B1;
	Tue,  2 Jul 2024 16:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719936311;
	bh=gcPZu10Fun4CSdDBFTvZqP809dlNmXQL0R/O6Jbl7Pg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l2KpePO4t11G+vPXMFznq4GeBoJO+vQ3xre1jn9wq1fRsZicA0Wjr47jXlP5PhU+W
	 QC0jr6l+vpiAd6aXVRWleW/v6gSjtOJIDzyG6U0jlLDEPxutoY2KXORErqZ1JYMwVJ
	 zhDbA0HG881HGqW05bW6cW+CrdH8Bf/FIXkPH4tQfzKDSVaqZdXKAK41Ns9Nkk6DW3
	 fUBHGjkqckjwS9EQUqE9PZskNLN8JYftzWRUYRm6hlb/tpw5PA3arpZ5IGjlTnWVpb
	 K/1BVvzzZEHWbJIRm/6ZauoiSl8Hg/vf5cTx4pIc6gNOlfRGZTk4B7jV1Dlhm/qCD1
	 bPuPa0Gu8eUSg==
Message-ID: <a095e65d-fdde-4bb4-832a-daa8ea999f2d@kernel.org>
Date: Tue, 2 Jul 2024 17:05:06 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next] bpftool: Mount bpffs when pinmaps path not under
 the bpffs
To: Tao Chen <chen.dylane@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, linux-kernel@vger.kernel.org
References: <20240702131150.15622-1-chen.dylane@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240702131150.15622-1-chen.dylane@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/07/2024 14:11, Tao Chen wrote:
> As qmonnet said [1], map pinning will fail if the pinmaps path not under
> the bpffs, like:
> libbpf: specified path /home/ubuntu/test/sock_ops_map is not on BPF FS
> Error: failed to pin all maps
> [1]: https://github.com/libbpf/bpftool/issues/146
> 
> Fixes: 3767a94b3253 ("bpftool: add pinmaps argument to the load/loadall")
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>

The patch looks good, thank you!

Tested-by: Quentin Monnet <qmo@kernel.org>
Reviewed-by: Quentin Monnet <qmo@kernel.org>

