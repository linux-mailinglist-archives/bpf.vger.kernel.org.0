Return-Path: <bpf+bounces-5200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A124758906
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 01:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB02E1C20EB3
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 23:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A5F17ACD;
	Tue, 18 Jul 2023 23:21:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF6AF51D
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 23:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C452BC433C7;
	Tue, 18 Jul 2023 23:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689722499;
	bh=HEoYxr1Q0eWhCNbZroe0oS5/iqjnBEypxbEtpRyC30M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NAmWFf48pDjTN0vrH0Bh7fepD3FgNjpV1rFfrKYuuo3rh7rJlLlrqL5YMbW7+PPxY
	 AvJAPRnvHR5uQGuP3U5CIFgcc6tC3IfE2V0EvKqPBU0rOoT8k6oD716Vy1b/NB2v9I
	 nzMyzLqLv8d1eboalUc0lQGeYWUO0e+jdRvsF0wNbGSVlwh/6w/6QGniLUTPT9hqgO
	 O811FVTe7oLRUvOBXllvcT7gmqCP54bmMAJVMHp4F1jq+svwlkzny1Xb5xzEGLdrHt
	 l5JuV5pvFrcFGslsE58y6E8sR5MzZiYkLx76CHbbCQGwuUAoNyWebzD5kuoq3LRWX0
	 eXyE36/DOay1Q==
Date: Tue, 18 Jul 2023 16:21:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Rosenberg <drosen@google.com>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko
 <mykolal@fb.com>, LKML <linux-kernel@vger.kernel.org>, "open list:KERNEL
 SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Android Kernel Team
 <kernel-team@android.com>
Subject: Re: [PATCH v2 1/3] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
Message-ID: <20230718162138.24329391@kernel.org>
In-Reply-To: <CAADnVQ+3Bmm0DgGBgh_zkA1JeK7uApo_nnJ+=Sgf4ojGX2KrHQ@mail.gmail.com>
References: <20230502005218.3627530-1-drosen@google.com>
	<20230718082615.08448806@kernel.org>
	<CAADnVQJEEF=nqxo6jHKK=Tn3M_NVXHQjhY=_sry=tE8X4ss25A@mail.gmail.com>
	<20230718090632.4590bae3@kernel.org>
	<CAADnVQ+4aehGYPJ2qT_HWWXmOSo4WXf69N=N9-dpzERKfzuSzQ@mail.gmail.com>
	<20230718101841.146efae0@kernel.org>
	<CAADnVQ+jAo4V-Pa9_LhJEwG0QquL-Ld5S99v3LNUtgkiiYwfzw@mail.gmail.com>
	<20230718111101.57b1d411@kernel.org>
	<CAADnVQLJBiB7pWDTDNgQW_an+YoB61xkNEsa5g8p6zTy-mAG7Q@mail.gmail.com>
	<20230718160612.71f09752@kernel.org>
	<CAADnVQ+3Bmm0DgGBgh_zkA1JeK7uApo_nnJ+=Sgf4ojGX2KrHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jul 2023 16:17:24 -0700 Alexei Starovoitov wrote:
> Which would encourage bnxt-like hacks.
> I don't like it tbh.
> At least skb_pointer_if_linear() has a clear meaning.
> It's more run-time overhead, since buffer__opt is checked early,
> but that's ok.

Alright, your version fine by me, too. Thanks!

