Return-Path: <bpf+bounces-61698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC53AEA585
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 20:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860651C42775
	for <lists+bpf@lfdr.de>; Thu, 26 Jun 2025 18:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2289B2ECE94;
	Thu, 26 Jun 2025 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfEFeX3p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BB41DF739
	for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750963218; cv=none; b=Mqp98tXAREZAOUjuo0MUg/D8EtN9dsO6VHqZ8dtJ8RYv4L+tXsPKKOW+56G/O0zwtnN+t7ZRVTDCL5mSxbZqF6k4XqZfYA9fFS/0nXf0hU7UwiEOqAQct5wQLLVf4zWbSp6lcmzsQ9s3824LKG5uADdgck6BH7xKStTJDy15FqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750963218; c=relaxed/simple;
	bh=EDiwhGmOzDblJHMqi6lqzNzsXPbOQduJiQ+Cd1T/0KM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d+jmhzm5OAQIT2qL+/oCtGhrKe+A3qzGWwKlnsAsO+I1DVvs1WwIdaOGY0ZDso2w1VJ49fFK68+Aeg1CbxIPxx49fBel+T2ZKlzj4HYEgrffP6DJW0HkybiA7gt2Eh1QNkXyzauG44s7MFk54ShuD8e5dHnnXYHHUo2jdu+DHPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfEFeX3p; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-235f9ea8d08so14772785ad.1
        for <bpf@vger.kernel.org>; Thu, 26 Jun 2025 11:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750963216; x=1751568016; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AAQ2iHTUZ1+ipSIXO+N4t6psMHJaN/MGTlACrZx782M=;
        b=MfEFeX3pGkDOAvPD4+3/HEBmZ2vvQXPPvqqXUqLfVjJs7ajVY+zhamMRAwsUi7UL6d
         FtcdJt7SlJ1Z/PlvHli7kh8vppZ+gk6BFuDPFQ+iw/FWUNj9qtP89U7I7cGWF3eWCtib
         9o/niHQ5eWeejoOry5kfd+sGLTXaW0IjPL8zQG+6C1eGVd2urkbvBxvt34iv750ylhln
         5ZyXJOJqT46RM/p026sTQAUt3CuxNWzjP6rzdQ8qWl1WO4xRcszKaau5T92hz6+UH60k
         /bLjp8h/vRgDBpnfV94WAbItFw+TTqeHN0Y8FZewOHP2Yen6JO6AC+shD3p6oOFtKf8M
         yjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750963216; x=1751568016;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AAQ2iHTUZ1+ipSIXO+N4t6psMHJaN/MGTlACrZx782M=;
        b=s1PcSaOZotorOU40cIct7bqxMBn1T7UvdiKsUr9w31eZwKAIBD4JyZQw+X9OMYBNQw
         HAEOWiF/ARl/ztRzA3Rxerj/LIqaKAQDTVNcgozucjiQi3ujl+uquPVwbJu790CL7HKG
         dRGUhrJJAgJ7YGXYqQFURc/0L1TXh9gQ4LQd5mdOgRqhZ5HhwiEePcsASlKK1sBg3hg3
         sPYsnZAucIL7OE0GTupOJAubEBM3/NFpi0BeLVUyqRQ1jDJIybMC856gb1JiaIV3Je/o
         lO+mT6/QCw8BlinQuplCm/JcFVJDQeXLwRnXmqucIX7S6NLwmF11zbrgl9pwUWWzxmF6
         0XnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKNvQvOpYjcERXqWxwUP3n+U2yIX22ia/mu5te/xFD6u4LMquYAJgLMcTutoAqDBXeDVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMWRA68XJSFYvdppfhnLgmT4rqailSvJW0AfxPzZ/oAHtr+L11
	dtpO3fwc5Bq0l5yXuT8TLkE+5vS4Q9SADWEYlvd5VTJRJJb7p8YHz56l
X-Gm-Gg: ASbGncvj7I6Q1T5XfcdHoIweu7NZd9rtn833nteN913HxdNhxb0Qx7Qzx/Ey0EJVXeY
	qQUvnvBM3Y7GZAm+pT0UGwkxhtW5CXv6Veby1ZJoP2TcnLpGUKCJ/78CHXgLpMr9zLunHPMuk7y
	Ocz49hN1jSEbkKhkWtfWTIJepjqxzZ9EdYDWwM5ZmTjWuaCifFJLMEt+Go22hKbYZXvMv/3C9s9
	u2zg3CJdxUU+bDvsP49pgFJdVw9ISAZqIW9WJYZc2v02rIvacKBS3lpql+kXt/KlajTRlLLTzps
	vSeV/X/o5YkqAtpivpxfX+Py4jpF4X/QBEffcTIXYA5N2lMVDxiBjHURsSY=
X-Google-Smtp-Source: AGHT+IEeb1uHcUnW4uBXUxKodpyhnXpKjhN2X9G3qQ8zFqRJi0O1gzI9GjDNN35l59Iw9RQTEbLWpw==
X-Received: by 2002:a17:903:943:b0:235:f45f:ed49 with SMTP id d9443c01a7336-23ac4633a56mr4648515ad.33.1750963216197;
        Thu, 26 Jun 2025 11:40:16 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23abe3d97fdsm4131245ad.107.2025.06.26.11.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 11:40:15 -0700 (PDT)
Message-ID: <e8e3837bbf31353e597e2bd0a4818d6d91658e02.camel@gmail.com>
Subject: Re: [RFC PATCH 1/3] bpf: Fix aux usage after do_check_insn()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Luis Gerhorst <luis.gerhorst@fau.de>, Paul Chaignon
	 <paul.chaignon@gmail.com>, bpf@vger.kernel.org, Alexei Starovoitov
	 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
	 <andrii@kernel.org>
Cc: syzbot+dc27c5fb8388e38d2d37@syzkaller.appspotmail.com
Date: Thu, 26 Jun 2025 11:40:14 -0700
In-Reply-To: <20250626124933.13250-1-luis.gerhorst@fau.de>
References: <8734bmoemx.fsf@fau.de>
	 <20250626124933.13250-1-luis.gerhorst@fau.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-26 at 14:49 +0200, Luis Gerhorst wrote:
> We must terminate the speculative analysis if the just-analyzed insn had
> nospec_result set. Using cur_aux() here is wrong because insn_idx might
> have been incremented by do_check_insn().
>=20
> Reported-by: Paul Chaignon <paul.chaignon@gmail.com>
> Reported-by: Eduard Zingerman <eddyz87@gmail.com>
> Reported-by: syzbot+dc27c5fb8388e38d2d37@syzkaller.appspotmail.com
> Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> ---

The fix makes sense to me, please remove RFC and submit.
Is d6f1c85f2253 a part of a current kernel release?
If so, looks like this fix has to be routed through bpf tree.

>  kernel/bpf/verifier.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f403524bd215..88613fb71b16 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19955,11 +19955,11 @@ static int do_check(struct bpf_verifier_env *en=
v)
>  			/* Prevent this speculative path from ever reaching the
>  			 * insn that would have been unsafe to execute.
>  			 */
> -			cur_aux(env)->nospec =3D true;
> +			env->insn_aux_data[prev_insn_idx].nospec =3D true;

I'd say it would be more convenient to have a temporary variable of
type `struct bpf_insn_aux_data` here. Otherwise `prev_insn_idx`
indexing would always be something to stop and think for a moment.

>  			/* If it was an ADD/SUB insn, potentially remove any
>  			 * markings for alu sanitization.
>  			 */
> -			cur_aux(env)->alu_state =3D 0;
> +			env->insn_aux_data[prev_insn_idx].alu_state =3D 0;
>  			goto process_bpf_exit;
>  		} else if (err < 0) {
>  			return err;
> @@ -19968,7 +19968,7 @@ static int do_check(struct bpf_verifier_env *env)
>  		}
>  		WARN_ON_ONCE(err);
> =20
> -		if (state->speculative && cur_aux(env)->nospec_result) {
> +		if (state->speculative && env->insn_aux_data[prev_insn_idx].nospec_res=
ult) {
>  			/* If we are on a path that performed a jump-op, this
>  			 * may skip a nospec patched-in after the jump. This can
>  			 * currently never happen because nospec_result is only
> @@ -19977,6 +19977,8 @@ static int do_check(struct bpf_verifier_env *env)
>  			 * never skip the following insn. Still, add a warning
>  			 * to document this in case nospec_result is used
>  			 * elsewhere in the future.
> +			 *
> +			 * Therefore, no special case for ldimm64/call required.
>  			 */
>  			WARN_ON_ONCE(env->insn_idx !=3D prev_insn_idx + 1);
>  process_bpf_exit:

Maybe change this to simply check that nospec is not set for
instruction of class BPF_JMP?

