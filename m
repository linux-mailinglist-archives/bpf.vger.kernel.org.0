Return-Path: <bpf+bounces-51941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E06FA3BF5D
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 14:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 567C517B57C
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 13:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFAD1E5B89;
	Wed, 19 Feb 2025 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRlKAI4t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF731E285A
	for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969948; cv=none; b=FXBqR3Hf4tI952xAOdD7FVfdjdsxdft/xTfi+MceoTegX5H0xsDs96vISjngvLOEqVy3aVtuDtIpJbKwl2PmKZwa7PzrCXp75X8P/+xfWFWQKUx8QCsmE2B1EqsHAVWNAfLLCShwblFskGQHFYaOrMH9m6hs0a+/zCB/bIVZEZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969948; c=relaxed/simple;
	bh=pR4gHlP/itCPVXjlA0kyRasHHbGY54Uky7CCSiAmDlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eyg2tBr7RLkGEm1UOEz3MBj8FGRjrnWCgUfuRI5Ck/2+xaSsVyuAbbDYaneVB3HpGbcqQC93snond/yXkUFbwWGpMyGfERHncKdWPaVWX8g434DVKhbTjGjyKn2D7vNKVWw+IfgOjggll2WoTgeIz5wfp66aQPwAWfbc8C50PeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRlKAI4t; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5ded69e6134so10162836a12.0
        for <bpf@vger.kernel.org>; Wed, 19 Feb 2025 04:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969944; x=1740574744; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fy59ewG3SAffD8cXAC3pMXfgh1A8WxabREkFLND4+5o=;
        b=NRlKAI4t0HDw/uz4pJaiDHO3fNaNU9lVgfjP0y5xI5v18dAWiW6t0rjL+smBIK1aBh
         duQeYJCxVThJIdHTId87W7mvXszMoKn7Pnq70OaiZEi9VudKLbTPbz4cazkAaPBRYQLO
         MTG0/4UkkXMwax0ZGRY8aRBzqNjPZQObd0roIEV6gD7YS1Am87Gkf8n8U/mdUQd0jhUU
         axFASJM2yNgnTdFRcc5SNuybbju1+kEqk/PJe6d6+YJEENFHMiXxY+unPw9cm93iojIO
         oBtfap6Eu/OWsAL4CXgf1H4gY1RfcsrTJNod5BNE3MLOcej7pyIvD8wppHWVx8mpO4yL
         +1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969944; x=1740574744;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fy59ewG3SAffD8cXAC3pMXfgh1A8WxabREkFLND4+5o=;
        b=R3D/U/jiWAt8QOwvgZBUTzeVu1ryOHbc2Jw/G0l4oyZDBBasdcH0qVAr97MxPapZXc
         X0+yqux25EwcFumAJt0mfvZ5ogWGThdIhsUte2/6Z3eeiDJa6kXk6HEr+gjXJ04BlTSh
         474Npzo/Z7y/JiqxKo0JlS8MlQySLDfbJ/6GHQzZ8nz5/ExoWwL5qwBZGEvOhKWnqCwd
         e5ltjCzS6JF9G1sGiWBqY1Ci2qyUeJ9toN/wYpFeEk+sprMvst1YNdmwbn0hGwXMLQQ+
         cll+FnYNLwUyPXxaci/S1EuQ6xz0ROOXrBCzXeojvP0yF7/0Qm03d/X8b43lgCN03YKJ
         DIvA==
X-Gm-Message-State: AOJu0Yxhg8256gfemH/Ona99qXTpy8ptf/Ao67N34HIV+jrm+x5SSe97
	GMXnR2zRj87k13wqVltBDiNHkw0ShHiYivhBaeFwUzqXaPFi6whSJxeON7uc5rFMcRA40kRvTIL
	5hWEIH1MJEAb9zwO1pmZMs0z4fW/IGwiu+KM=
X-Gm-Gg: ASbGncu/gNmfzjmjnI7WEL/mvNpnrEfCtt1BmZznMydwEFz8/nw6LOGnhUkkB9ed5xb
	NQINrD1JbkMyA8HlEEDuOMsq4e2ucOnWRwc+AjjQpnY21IGBdoNk1BV1GAj7PQKHxgrNoVOWSZN
	m6+SJFhagaG05wFa84rA==
X-Google-Smtp-Source: AGHT+IFl2b1BRIKI3zPWAklNmwpWRWLC48KADrhZNIfsQgZO0m3AeXZfrqilfQeNRFhoJVFPfHTug8ry8VKzYx2/61Q=
X-Received: by 2002:a05:6402:2394:b0:5e0:9269:f54e with SMTP id
 4fb4d7f45d1cf-5e0926a07e0mr933653a12.14.1739969943934; Wed, 19 Feb 2025
 04:59:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219125117.1956939-1-memxor@gmail.com> <20250219125117.1956939-2-memxor@gmail.com>
In-Reply-To: <20250219125117.1956939-2-memxor@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 19 Feb 2025 13:58:26 +0100
X-Gm-Features: AWEUYZlw3fRCDPa7LyLG-rIEMt58dc9h8GIRsgQlNszt2H_ffDo_CZRAG34aKc0
Message-ID: <CAP01T74S_8O9ehhmY4G-xGtypnqpdD2u0FKgDKqvtHoDniH5iA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 1/2] bpf: Explore PTR_TO_STACK as R0 for bpf_dynptr_slice_rdwr
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Feb 2025 at 13:51, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> For the bpf_dynptr_slice_rdwr kfunc, the verifier may return a pointer
> to the underlying packet (if the requested slice is linear), or copy out
> the data to the buffer passed into the kfunc. The verifier performs
> symbolic execution assuming the returned value is a PTR_TO_MEM of a
> certain size (passed into the kfunc), and ensures reads and writes are
> within bounds.
>
> A complication arises when the passed in buffer is a stack pointer. The
> returned pointer may be used to perform writes (unlike bpf_dynptr_slice),
> but the verifier will be unaware of which stack slots such writes may
> end up overwriting. As such, a program may end up overwriting stack data
> (such as spilled pointers) through such return values by accident, which
> may cause undefined behavior.
>
> Fix this by exploring an additional path whenever the passed in argument
> is a PTR_TO_STACK, and explore a path where the returned buffer is the
> same as this stack pointer. This allows us to ensure that the program
> doesn't introduce unsafe behavior when this condition is triggered at
> runtime.
>
> The push_stack() call is performed after kfunc processing is over,
> simply fixing up the return type to PTR_TO_STACK with proper frameno,
> off, and var_off.
>
> Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  [...]
>         }
>
> +       /* Push a state for exploration where the returned buffer is pointing to
> +        * the stack buffer passed into bpf_dynptr_slice_rdwr, otherwise we
> +        * cannot see writes to the stack solely through marking it as
> +        * PTR_TO_MEM. We don't do the same for bpf_dynptr_slice, because the
> +        * returned pointer is MEM_RDONLY, hence cannot be used to write to the
> +        * stack.
> +        */
> +       if (!insn->off && meta.arg_stack.found &&
> +           insn->imm == special_kfunc_list[KF_bpf_dynptr_slice_rdwr]) {
> +               struct bpf_verifier_state *branch;
> +               struct bpf_reg_state *regs, *r0;
> +
> +               branch = push_stack(env, env->insn_idx + 1, env->insn_idx, false);
> +               if (!branch) {
> +                       verbose(env, "failed to push state to explore stack buffer in r0\n");
> +                       return -ENOMEM;
> +               }
> +
> +               regs = branch->frame[branch->curframe]->regs;
> +               r0 = &regs[BPF_REG_0];
> +
> +               r0->type = PTR_TO_STACK;

I forgot to fold in a hunk.
This needs to be marked PTR_MAYBE_NULL (preserve the set reg->id).

> [...]
>

