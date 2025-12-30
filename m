Return-Path: <bpf+bounces-77531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F48CCEA747
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 19:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38E65301AE02
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 18:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308B12E7F32;
	Tue, 30 Dec 2025 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCsjpqPd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04A81A23A4
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 18:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767118853; cv=none; b=VHlyGf4P462t6QdWcP3yocEwPFVIovpSkDcz3D66ynY6Xz5Cc9RasO5qconoBgNym7XKLWOxLu2t8LhS0rIV6/rGFxufK3NRUNLBNYG2618v7pTqntX334ZtITXhGLQYyt9nMBjyJKi1A/kzlN+568pMD6GGCI4gsuu64ODdDQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767118853; c=relaxed/simple;
	bh=DjsYg9RABeCOzIi/VVJJg55gdLB4L0Xy7eA6JjLkkq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hCMz3PJBDQwkzFNtN2qiO/hbflIHaUIWjkVT+T6NldOlL2DNZNCSdmBETdASok2yLfOboX2/YzwVJIKDcilb1ZKM7CgFjZ9KEm93tW9xw9Vl2rqc1pEM5weNxpLgtn7pQLJ5Wmiw0fSm1rVq55DLuWluW7g7pL8mQlfl4/h1aRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCsjpqPd; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42fb2314eb0so7873132f8f.2
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 10:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767118850; x=1767723650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUf6q6itEACCb732QD4lwJfN2sH1cCir07Fliqvkcig=;
        b=NCsjpqPdPd+KrwKpSwL88SzL2tQOT97bNlSQogXSLX7WlO13FXawD8jlJKDyDwrmo5
         Fbb3MkmraK9jxqBMLra09pbUFsNUTf/TDfdok/WjxhJZ1YNw2UsqMbbBtd93E6S0bIGK
         LySb0dMuC7IMVmElhl6BP2Bwt8cnvr+OO+9S+NFw+oS31g4dL3TVwQNl2rFp5NIqQ5XL
         XIUfzNpH2iyejrJoid3QNYSQ785WZ13sKUTgImsdKXaj2qsuhPu8fsrcwQCwD9MkGUSH
         AfD3mZMFEJIul3Fq6wuiGVuK3LDE+77QsOX0nmAUj4qIogZAUxqrDrQdo7eoRzjxTGyf
         a88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767118850; x=1767723650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YUf6q6itEACCb732QD4lwJfN2sH1cCir07Fliqvkcig=;
        b=tL6qHo8121RCwI4gYexOAAnWsNm6FJI98qm76gUsihlUgJujCyBtTRpKFfXD13FGlF
         QGZNt7sb8mJfjXWM61faEOxYtkMVu3CnE6fkSCMGafoSXIMOnP75LntfAKv9V1FwdNLE
         H4VkRbFeoD0Dk2yxuPLoyPMX3xUhpcq/dsMwifFZqADQveneFXEsXUFSXEQVoAvJaElT
         dw72HXMnAl6nPuRmPDQ1hHtYPRIgvFDRhtGPKj9602vLxoQGw5Qr1FVZRg0Hg4znIUBV
         uJ64sdQy4vgsmrC6EUzEfysw5oQk+X57m3YOf4LdmSKnR5VpIrXWr8yWAPEzOdLfTtSU
         4kGQ==
X-Gm-Message-State: AOJu0YzXsnSlz67hIhsxGJjcJNeTNnkKHPS6aOjBD+QK1FDjZh4Hc9oc
	7aeKJmSymAyWmY0b3oJav3d27Zt8RYmVqZF2HEABxhBhvtU1I+GlaBJhoSf1WcNlfHm1BMcbXpJ
	LUjPlQIitZmkgCMC98uBV5J9IERgNzeA=
X-Gm-Gg: AY/fxX4d0D/ySfj4N0RVloApNkFx31JHDTu1L8k9b6LoN8J/12czvIppT2Cu2ZDBJ81
	zE3HXcZnU1IBNgo/Fssv5N6FLjU2IXJeg+RIJDLasy8JBZiZI1Nje5qCIcivBM4TbgZkr2zDcbe
	e79R4Wd3qWlDEJQlkXNEtfGePW8xdNV5zjM705CKQmA2C6BNXdDmgtmBXFDroi4+KQ1k0Mo0a6R
	EuNCxdmqBv1UEAJxmsQG3BVmdyIVfTNfM6Br7hJQ2bFvILq0Bq7YTqLFomC8vqyopQz7xCzW8eB
	cxgHjrnk2XqOgLGHCA4CRJ5PX7IG
X-Google-Smtp-Source: AGHT+IHgmg+V700bfMp+f/NOEfUiwlO8nGKFWGFaraDIRysO8U1C+LgV47XXfeXQJoza0dR+qGdPBpRKuW65UwCZA9U=
X-Received: by 2002:a05:6000:2909:b0:42b:2dfd:5350 with SMTP id
 ffacd0b85a97d-4324e7077c8mr45891448f8f.56.1767118850032; Tue, 30 Dec 2025
 10:20:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251227081033.240336-1-xukuohai@huaweicloud.com>
In-Reply-To: <20251227081033.240336-1-xukuohai@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 30 Dec 2025 10:20:38 -0800
X-Gm-Features: AQt7F2ovLUIlZDlvvAljLOMXpnPY_g8ETFMjy2hA5P7laVN10rANwy1yNQezEUM
Message-ID: <CAADnVQKJk7pGW50JHj6tZAeHLxCbgmHBdhwZCY4NT-6MTg7=sQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: arm64: Fix panic due to missing BTI at
 indirect jump targets
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2025 at 11:49=E2=80=AFPM Xu Kuohai <xukuohai@huaweicloud.co=
m> wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> When BTI is enabled, the indirect jump selftest triggers BTI exception:
>
> Internal error: Oops - BTI: 0000000036000003 [#1]  SMP
> ...
> Call trace:
>  bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x54/0xf8 (P)
>  bpf_prog_run_pin_on_cpu+0x140/0x464
>  bpf_prog_test_run_syscall+0x274/0x3ac
>  bpf_prog_test_run+0x224/0x2b0
>  __sys_bpf+0x4cc/0x5c8
>  __arm64_sys_bpf+0x7c/0x94
>  invoke_syscall+0x78/0x20c
>  el0_svc_common+0x11c/0x1c0
>  do_el0_svc+0x48/0x58
>  el0_svc+0x54/0x19c
>  el0t_64_sync_handler+0x84/0x12c
>  el0t_64_sync+0x198/0x19c
>
> This happens because no BTI instruction is generated by the JIT for
> indirect jump targets.
>
> Fix it by emitting BTI instruction for every possible indirect jump
> targets when BTI is enabled. The targets are identified by traversing
> all instruction arrays of jump table type used by the BPF program,
> since indirect jump targets can only be read from instruction arrays
> of jump table type.

earlier you said:

> As Anton noted, even though jump tables are currently the only type
> of instruction array, users may still create insn_arrays that are not
> used as jump tables. In such cases, there is no need to emit BTIs.

yes, but it's not worth it to make this micro optimization in JIT.
If it's in insn_array just emit BTI unconditionally.
No need to do this filtering.

pw-bot: cr

