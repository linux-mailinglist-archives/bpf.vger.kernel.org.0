Return-Path: <bpf+bounces-13240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B9B7D6AF9
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 14:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E3D1C20DF4
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 12:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FED27ECB;
	Wed, 25 Oct 2023 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="St3P1CfK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9ED1D55F
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 12:14:33 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9E4182;
	Wed, 25 Oct 2023 05:14:31 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-53e08b60febso8579940a12.1;
        Wed, 25 Oct 2023 05:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698236069; x=1698840869; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mjXStcUt9Iguy5smRWKpn6s+oJAKiIOpUoRTCMmhueI=;
        b=St3P1CfKAHPWitDvjlNQOQmMksLayGIY/dKhsZ9/8rR5+XHjyUlE6GsXvye51NImPz
         0H9Q0UVtxXk64ushty8UVkON14nDb/tevnCS6irTERZdJYC20XrLcaj9Wn3qiz710EP6
         VAjO0icYApxm8r5WSnHFPoEc28CVKquLktcaOeRYWkJcnBRKgi4EaiPrAPZJYgyY2uia
         igOv1xi8piTYnJVQYme3p7nApakT0a2TlHUDPjGqhb7vPi/HV4qmivnkrH0TAZctVwDn
         yMQlvN9BQcFJFxwlBX1Plp1+KojiiuFC+P5ch13P1G1klvq5B/ZH2rcVFoOcX8xZVf+f
         NFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698236069; x=1698840869;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjXStcUt9Iguy5smRWKpn6s+oJAKiIOpUoRTCMmhueI=;
        b=I9B9qxuCKWUoIA5z87k2IyybkOXlWe4UZg3qbLJ+LJis2CmWhfjKpB4/JoOxTtZzAK
         DuC6I0yWXVZzkgqw1LjxsuiikgVb3DvwraXxbASG+K3UIfakwMRHo7J2+b41FBdOZd7r
         FOQkL3xAfcgM4XfnJcP4JaW5UdBI+nVajLyYxcR5KnCekTmFWFIclrv9PIylFXt9Haq0
         YY9RTsVlw73ERBij85UFcGg9xCAQhIl+28nX2zFiP+wbo8RXR0UTCOyKVgP/rOEHuURj
         CTDHxKozuTtm0L/rHDW+VfNSID1JkEoYZCG8h9+2ZD2fb8nTDMtXpfNbobgyW/GGu9fR
         H/bg==
X-Gm-Message-State: AOJu0YzSzxGCdWn+Ci3EbtxALhfgtO01ffV2dqAOlW9AiZitoJK0bxfK
	A98+9aWItjHGeq8StIFv3Y0=
X-Google-Smtp-Source: AGHT+IG4K//lUoGVaZxJDWWI+11BjVh8sHP99EZg7E7wAjdHtOJoJ8whP+K1049KAHHUhD52O9FLAQ==
X-Received: by 2002:a50:aa93:0:b0:540:9b47:4f70 with SMTP id q19-20020a50aa93000000b005409b474f70mr3344005edc.26.1698236069130;
        Wed, 25 Oct 2023 05:14:29 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id w12-20020aa7cb4c000000b0053e7809615esm9347644edt.80.2023.10.25.05.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 05:14:28 -0700 (PDT)
Message-ID: <17e03fa708cf0c1d297c2fa3d139a22a358a65e7.camel@gmail.com>
Subject: Re: bpf: incorrect value spill in check_stack_write_fixed_off()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hao Sun <sunhao.th@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Linux Kernel Mailing List
	 <linux-kernel@vger.kernel.org>
Date: Wed, 25 Oct 2023 15:14:27 +0300
In-Reply-To: <CACkBjsYXA8myxoP0Naz=ZxB0FWG-xS9e28CSFffGk1bA_n5RXw@mail.gmail.com>
References: 
	<CACkBjsYXA8myxoP0Naz=ZxB0FWG-xS9e28CSFffGk1bA_n5RXw@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-10-25 at 11:16 +0200, Hao Sun wrote:
> Hi,
>=20
> In check_stack_write_fixed_off(), the verifier creates a fake reg to stor=
e the
> imm in a BPF_ST_MEM:
> ...
> else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
> insn->imm !=3D 0 && env->bpf_capable) {
>         struct bpf_reg_state fake_reg =3D {};
>=20
>         __mark_reg_known(&fake_reg, (u32)insn->imm);
>         fake_reg.type =3D SCALAR_VALUE;
>         save_register_state(state, spi, &fake_reg, size);
>=20
> Here, insn->imm is cast to u32, and used to mark fake_reg, which is incor=
rect
> and may lose sign information.

This bug is on me.
Thank you for reporting it along with the example program.
Looks like the patch below is sufficient to fix the issue.
Have no idea at the moment why I used u32 cast there.
Let me think a bit more about it and I'll submit an official patch.

Thanks,
Eduard

---

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 857d76694517..44af69ce1301 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4674,7 +4674,7 @@ static int check_stack_write_fixed_off(struct bpf_ver=
ifier_env *env,
                   insn->imm !=3D 0 && env->bpf_capable) {
                struct bpf_reg_state fake_reg =3D {};
=20
-               __mark_reg_known(&fake_reg, (u32)insn->imm);
+               __mark_reg_known(&fake_reg, insn->imm);
                fake_reg.type =3D SCALAR_VALUE;
                save_register_state(state, spi, &fake_reg, size);
        } else if (reg && is_spillable_regtype(reg->type)) {

