Return-Path: <bpf+bounces-35230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1593939072
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 16:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97EF01F2222A
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 14:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6AA16D339;
	Mon, 22 Jul 2024 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNW6tN4h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66BED2F5;
	Mon, 22 Jul 2024 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721657824; cv=none; b=WfwY8a0p6nD8wi0Gio5Br7EKXZiEAAgWWzrTp7jo5VgGXSVjN+jzAGvHigeW2pT40benSOH2yD4FT2yIsn0CxSsW9tI2fhJcfukYgNXiu25ZbQwcJg5GR+gtSUySNR703kYveln39vfXGca78SrP7ueLcZX88GZQqDJbGnp+ekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721657824; c=relaxed/simple;
	bh=Ko2Yxrd9A82RGO0V5UXcG4SDQffxJqnPcBN2Rk9wwLU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XHhMhoenRP83t9d2pZdcHrssgaBbzHJRqP3j8MuHucB0y8VR9lI8JarR4WHgAOJHRV8LsgK3yIl/48EBgYRqv7O3rQZEWgUtw4QPNOOfVw0npbyU65M/3zwTdkOhs+I+AtwAT5/pxS2dqxRbRjwKkcWYqZoMHR17XcySWdhSHhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNW6tN4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB464C4AF0B;
	Mon, 22 Jul 2024 14:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721657824;
	bh=Ko2Yxrd9A82RGO0V5UXcG4SDQffxJqnPcBN2Rk9wwLU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=nNW6tN4hkwMEY5JWOF7rlmzprQVbp2Rzlxjj9XFrPxumaiKU2FNL9ZEZSrsnDCQMO
	 Dd7Bo3gr3Jen5OTheNWdCOxQ200jH1HS0j7N6t+fAIVbTtpMfOw70GZnfCMklfspLo
	 tPnyfQU8Ds//hLptpoDd/04+P/xpP0Mnk6fUiQxO3d5jb7xJHRKbkuZRSqVCrwkCwI
	 mcx67nNz61c9xZbh75F93CIqI58tl7UKMBxezBSMav4bM9ttLWWffT+BbM+8Oldo74
	 MNuzZ2j29jaBJRaU4/yQqhTL2gUgntY/Nketld3E6ye24//Xg/yZtZr0PJ70h1ikBF
	 HdIUefSqJ5zKQ==
Message-ID: <7b02e164-c6de-41b5-b036-0d4b705a992c@kernel.org>
Date: Mon, 22 Jul 2024 15:16:59 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Quentin Monnet <qmo@kernel.org>
Subject: Re: [v3 PATCH bpf-next 2/4] bpftool: add net attach/detach command to
 tcx prog
To: Tao Chen <chen.dylane@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240721144221.96228-1-chen.dylane@gmail.com>
Content-Language: en-GB
In-Reply-To: <20240721144221.96228-1-chen.dylane@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-07-21 22:42 UTC+0800 ~ Tao Chen <chen.dylane@gmail.com>
> Now, attach/detach tcx prog supported in libbpf, so we can add new
> command 'bpftool attach/detach tcx' to attach tcx prog with bpftool
> for user.
> 
>  # bpftool prog load tc_prog.bpf.o /sys/fs/bpf/tc_prog
>  # bpftool prog show
> 	...
> 	192: sched_cls  name tc_prog  tag 187aeb611ad00cfc  gpl
> 	loaded_at 2024-07-11T15:58:16+0800  uid 0
> 	xlated 152B  jited 97B  memlock 4096B  map_ids 100,99,97
> 	btf_id 260
>  # bpftool net attach tcx_ingress name tc_prog dev lo
>  # bpftool net
> 	...
> 	tc:
> 	lo(1) tcx/ingress tc_prog prog_id 29
> 
>  # bpftool net detach tcx_ingress dev lo
>  # bpftool net
> 	...
> 	tc:
>  # bpftool net attach tcx_ingress name tc_prog dev lo
>  # bpftool net
> 	tc:
> 	lo(1) tcx/ingress tc_prog prog_id 29
> 
> Test environment: ubuntu_22_04, 6.7.0-060700-generic
> 
> Signed-off-by: Tao Chen <chen.dylane@gmail.com>

The series looks good from my side, thanks for this work!

Acked-by: Quentin Monnet <qmo@kernel.org>

