Return-Path: <bpf+bounces-41637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1459993AB
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 22:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F1A287143
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 20:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724BC1E0495;
	Thu, 10 Oct 2024 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQalCxqG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB5419C553
	for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728592119; cv=none; b=s4t67zD40yq4ax7CLzU1pahIUlKJIO1tmz6W+YU9BY5OaaqYtlje8uwyJFAxW8U5PCu6tywkVRfywtC95LHL+Au63CbGdSfZ2jrYDwXyQQ0WbWl+mcY53ISPz5wVG0OjTuQP1GD70RW+1vxQCsANQYD16gdPs0Ul0lBaZPlkbv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728592119; c=relaxed/simple;
	bh=KUvQJA3/Yu2pTYe3+H9U/jBbHv0N8IyIYh7H/KecYQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ctj6t4CBbpu96pVKQb3mbnPgeBinSnfQEyOchdXJF9exqXFB1xLNRMsHvS1M+D0aRFnCeqXGHa9hI7AtYm8iA9eobjyVMDq7MpcwMdhBU/z9v9e3nA7czYzYPU027Zm+dWEkUjCmh8sg5kH7ZQhVeYq0tsJU9OgBXnLEhJ0yjdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQalCxqG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4311ac1994dso6012715e9.1
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 13:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728592116; x=1729196916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tumHWjf+hl/M6Xb4HWw/VY1e7xSx0guDffw06q9dm5c=;
        b=nQalCxqGsUbfBokvrzqE+ju+BaFxXbwsuCAEO7/futkDSVgyPa7nw6I+adWRQP+6nJ
         IAVTrMmTsAN49+rV3iXgBq5JaOrYhe7e9OZgPQFI6FskqlW5wn2or0pYpA3/fG2JjYa1
         WfphsYOovRz/GykZFT+04FOYdaiSCn0qcwtfcKUrcF5c5xGfBT80KHbAUKkzKjeJPRNJ
         SN3qoJTGs/yxw6X5jjacgUpXvzXa3+tMFKnoTGVfbaickKPBpIuxFg8p/YA0NWMDhAdH
         VlsLfEoruipayHoaPIjB6RqGebcZCC06Isx8ScFZ/Rrv5mwJJWKBu4c3TIdyeGPFOkZn
         Jxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728592116; x=1729196916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tumHWjf+hl/M6Xb4HWw/VY1e7xSx0guDffw06q9dm5c=;
        b=vZmCVwSL5pt+NNkH2r9k+n3ryNv1DhXUaW/ecD06lSLduOqaGfq1+sn6N7t7prsiX2
         vaqgfZ153GwyEmMU4dz33C9Z0UC21WIlw6KaEudsR8mIRVU/7YRCxawv7Zmn4w5oV5tX
         TyFf4Q/tFY0SxTBGRX5SBLMc/0UP01LpszFmrtNAwt8mp6MpQpTWHTSRi37RFx6iPhUi
         6GXXGVkgpQ8raWptJAdHZ8Hs5tktpMcf6rq5DMvaH/O42eTH32DoVBjlinq4jk8OL60f
         fKYYhB3bz6NUSLr/2YrZrZEyohGlX8B70/X04VIH9rhcCSpMqWkiWhdAOcMgLdacsAOh
         etiQ==
X-Gm-Message-State: AOJu0YxVrIZMsy53jnf3CH2/l2ooaYc5FIppMyVy3RL/AXSX4+L0rHja
	7fqd+Y4pBPBtrwFzGp7Q1DY7UPCdaVqun2Fj8wB/pkK4NWUXQPm0x+d4FxuiWxKOaKemRVAEQpC
	YRDZuyDbG/R46JwnILKHCJ+2kZo0=
X-Google-Smtp-Source: AGHT+IFsFDwTH3v4qlhxumNDv0I7Jav72cwzWZpqkGy3a+fzb50y6jCmJgQrooaYw31QBENh11zsv8sKaJXSvmwXDmI=
X-Received: by 2002:a5d:456f:0:b0:37d:2d45:b3d4 with SMTP id
 ffacd0b85a97d-37d552caa3bmr239244f8f.52.1728592115628; Thu, 10 Oct 2024
 13:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010175552.1895980-1-yonghong.song@linux.dev> <20241010175628.1898648-1-yonghong.song@linux.dev>
In-Reply-To: <20241010175628.1898648-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 10 Oct 2024 13:28:24 -0700
Message-ID: <CAADnVQJMuR_riNLghmr0ohrEZSj-8ngcFQRn3VkdDyJAFakqKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 07/10] bpf: Support calling non-tailcall bpf prog
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 10:56=E2=80=AFAM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
> A kfunc bpf_prog_call() is introduced such that it can call another bpf
> prog within a bpf prog. It has the same parameters as bpf_tail_call()
> but acts like a normal function call.
>
> But bpf_prog_call() could recurse to the caller prog itself. So if a bpf
> prog calls bpf_prog_call(), that bpf prog will use private stacks with
> maximum recursion level 4. The 4 level recursion should work for most
> cases.
>
> bpf_prog_call() cannot be used if tail_call exists in the same prog
> since tail_call does not use private stack. If both prog_call and
> tail_call in the same prog, verification will fail.

..

> +__bpf_kfunc int bpf_prog_call(void *ctx, struct bpf_map *p__map, u32 ind=
ex)
> +{
> +       struct bpf_array *array;
> +       struct bpf_prog *prog;
> +
> +       if (p__map->map_type !=3D BPF_MAP_TYPE_PROG_ARRAY)
> +               return -EINVAL;
> +
> +       array =3D container_of(p__map, struct bpf_array, map);
> +       if (unlikely(index >=3D array->map.max_entries))
> +               return -E2BIG;
> +
> +       prog =3D READ_ONCE(array->ptrs[index]);
> +       if (!prog)
> +               return -ENOENT;
> +
> +       return bpf_prog_run(prog, ctx);
> +}

bpf_tail_call() was a hack during the early days,
since I didn't know any better :(
I really don't want to use that as a pattern.
prog life time rules, tail call cnt, prog_array_compatible, etc.
caused plenty of pain. Don't want to see a repeat.

Progs that need to call another prog can use freplace mechanism already.
There is no need for bpf_prog_call.

Let's get priv_stack in shape first (the first ~6 patches).

pw-bot: cr

