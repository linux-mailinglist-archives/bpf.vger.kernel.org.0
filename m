Return-Path: <bpf+bounces-16017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B3C7FAF91
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 02:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A71A1C20DCD
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 01:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F49A4A2A;
	Tue, 28 Nov 2023 01:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cn5rXm/F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEC1BD
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 17:33:40 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a00a9c6f283so657404266b.0
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 17:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701135218; x=1701740018; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CFv+0SoKmU3cYPZ70tFP/aTIyPRhroimMwfsSLVCdc8=;
        b=cn5rXm/FOyAqc3WUQXJbgBlH6k6qbRl0h607eXEFtJmaQrpUPIhraFbMSaePuE/tIE
         TUBJpjdBdJCX8+sY1JmZE1tRpLAu8MdGB97TFB6PKL06wXlwQkd8jgOeI6DnjtbIoDnL
         VPTw2AsUqETA0irXBtUSzVfQh8YITCB27qRzU6dlKHRCtbHufqsDAd25iPH+fkExPAhu
         Vj8utUeZyDeKKJ2SP1pzbDV/xasssom+0ve7ego5uYLiJe+gsrUR0IuusrgBp5VVJQxZ
         J3Q8pel3/efLVz9ruwcAB1Rpd54P5Jnz6rjtKsbm4laJP53E/jBpHQIfRbv2oD8GHao0
         22tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701135218; x=1701740018;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFv+0SoKmU3cYPZ70tFP/aTIyPRhroimMwfsSLVCdc8=;
        b=thkYtKd4GkfewOrFdKTBiN74LjoyWVH25V26PhvLMyzFWcDZVLnye9Xy6ZJIHgS+hk
         +rM8KycY4OxZpJ1Ngo2u77SsBZlCW5Qq/d0OW+ZtJDxYxYbB1Th7wlVukE9hwQCz7mZZ
         mPivJznQkHQSNM5S8RYI6GusZ5+vBSo6JUkkecArsZc6bl54fjxyjHhGkrMbmrI63O4A
         DdGCRu83W08hep64ixhocET5EwQ6W8JC+ligCgGRHoBm/SBvwu0z01ByCNU1mxUIxXFT
         rey5vmGGKWSMl137YLM5NLK35eSJYsaqnI6HGHBYzyXI7oWigWLtjIrjvOSUH5dqi+Tw
         gY/A==
X-Gm-Message-State: AOJu0Yw8DLRc1kIO/oPz2IUfhPGuoLBMk3038sBcXOPsNoIK2HY+m8XS
	j6F0rE4g1wlyDsjQNOzS92c7WxY1eOPiIg==
X-Google-Smtp-Source: AGHT+IHpWeB3GbKNBsTp8YfEjiQjM4urtvrW/eh5lXVsZb7Kmp9hUahdDrUO6aasOr91zlotEu2Crg==
X-Received: by 2002:a17:906:3117:b0:a10:ce3a:ea44 with SMTP id 23-20020a170906311700b00a10ce3aea44mr1915283ejx.50.1701135218087;
        Mon, 27 Nov 2023 17:33:38 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id m23-20020a1709066d1700b00a121e5d002bsm553991ejr.174.2023.11.27.17.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 17:33:37 -0800 (PST)
Message-ID: <2facccd4023ee77059fe483e0b1a21f6ef36e16e.camel@gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: fix accesses to uninit stack slots
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrei Matei <andreimatei1@gmail.com>, bpf@vger.kernel.org, 
	andrii.nakryiko@gmail.com
Cc: sunhao.th@gmail.com, kernel-team@dataexmachina.dev
Date: Tue, 28 Nov 2023 03:33:36 +0200
In-Reply-To: <20231126015045.1092826-2-andreimatei1@gmail.com>
References: <20231126015045.1092826-1-andreimatei1@gmail.com>
	 <20231126015045.1092826-2-andreimatei1@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-11-25 at 20:50 -0500, Andrei Matei wrote:
> Privileged programs are supposed to be able to read uninitialized stack
> memory (ever since 6715df8d5) but, before this patch, these accesses
> were permitted inconsistently. In particular, accesses were permitted
> above state->allocated_stack, but not below it. In other words, if the
> stack was already "large enough", the access was permitted, but
> otherwise the access was rejected instead of being allowed to "grow the
> stack". This undesired rejection was happening in two places:
> - in check_stack_slot_within_bounds()
> - in check_stack_range_initialized()
> This patch arranges for these accesses to be permitted.
>=20
> This patch also fixes the tracking of the stack size for variable-offset
> reads. This second fix is bundled in the same commit as the first one
> because they're inter-related. Before this patch, writes to the stack
> using registers containing a variable offset (as opposed to registers
> with fixed, known values) were not properly contributing to the
> function's needed stack size. As a result, it was possible for a program
> to verify, but then to attempt to read out-of-bounds data at runtime
> because a too small stack had been allocated for it.
>=20
> Each function tracks the size of the stack it needs in
> bpf_subprog_info.stack_depth, which is maintained by
> update_stack_depth(). For regular memory accesses, check_mem_access()
> was calling update_state_depth() but it was passing in only the fixed
> part of the offset register, ignoring the variable offset. This was
> incorrect; the minimum possible value of that register should be used
> instead.
>=20
> This tracking is now fixed by centralizing the tracking of stack size in
> grow_stack_state(), and by lifting the calls to grow_stack_state() to
> check_stack_access_within_bounds() as suggested by Andrii. The code is
> now simpler and more convincingly tracks the correct maximum stack size.
> check_stack_range_initialized() can now rely on enough stack having been
> allocated for the access; this helps with the fix for the first issue.
>=20
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Fixes: 01f810ace9ed3 ("bpf: Allow variable-offset stack access")
> Closes: https://lore.kernel.org/bpf/CABWLsev9g8UP_c3a=3D1qbuZUi20tGoUXoU0=
7FPf-5FLvhOKOY+Q@mail.gmail.com/
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> ---

I think these changes make sense.
Question: would it be possible to recover some of the tests (those
converted from failure to success) by changing execution mode from
priv to unpriv?
 =20
Also, I think there are some tests that do oob stack read in branches
that should be proven unreachable, with expectation that if certain
verifier logic does not work as expected stack access would serve as a
canary. Have no idea how to identify these tests, though.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
> @@ -1697,6 +1699,12 @@ static int grow_stack_state(struct bpf_func_state =
*state, int size)
>  		return -ENOMEM;
> =20
>  	state->allocated_stack =3D size;
> +
> +	/* update known max for given subprogram */
> +	u16 stack =3D env->subprog_info[state->subprogno].stack_depth;

Nit: 'u16 stack;' should be at the top of the function.

> +	if (stack < size)
> +		env->subprog_info[state->subprogno].stack_depth =3D size;
> +
>  	return 0;
>  }

[...]

