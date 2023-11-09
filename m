Return-Path: <bpf+bounces-14599-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87787E7010
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 18:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CAF3B20C2A
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 17:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4BE2232C;
	Thu,  9 Nov 2023 17:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUxFDMea"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DBD1DFCB
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 17:20:55 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872C130D5
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 09:20:54 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso180227066b.1
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 09:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699550453; x=1700155253; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zo+ltWD1vHWMul5qaXHJPskNF8TYrcxhYl9hV01js2U=;
        b=RUxFDMea8EtoM4YPKvBK9dS85KUCJh5Hiv0IjA+XG7Yz0fqR7Wko3H6fG+/br/RD0y
         3SGd6+u0U/8OmwnlRfPyJ6detrwr6BlL5Ho7+PgVzBcsYeRr/PPp5WXODlfpSATMip+l
         aEjtSI77jpz/gmum7Y2GXxcCVh/wFYzMpO9t76iwoxAr5+03LqtPxDTzUonoxMRYte5E
         ZtULv9xkTaHnufDCEqQqMBPTDudyH1L3iOBZU5QZEoDJ194rawMFSjtxOgrobh2settI
         B8BURMZ3+TtWfx6eJVR73yE1P0PfCTy5FMse7QcPX4y5X/NTNU6JHY5MBsyHh9jwuoAj
         4u8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699550453; x=1700155253;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zo+ltWD1vHWMul5qaXHJPskNF8TYrcxhYl9hV01js2U=;
        b=tBip2CxES5jCTYb2wy2H1jCNBW60DPwFGbjw4CV2VU9lqiqG0h3fd4OIeHrEctcaCf
         dlH8ar47UO+3GDa1ZpUfn3uZs25x5ylPFtBbbqj31Db7gADlsN7fwPWdCTCEQe9w6jna
         /8supi1HFLZIKpmyduGZmLYbTgASdhYq4Ah0od3vPBKwva/i1Pqg9Uz26ptF9MLtIyHN
         Ymxgxl6hf9iRZs0erGOjN3SAzXuETwgPxKrst+zzSviVGBesJ9Qu+jEfW2ig7GE6B6gh
         r/PbbjKEcO5lF/pDVPhoiCHVEm9PNPaZMYQJoW1owukc2TgGNzRMzPQZtaXgs+QYRiKn
         CLtA==
X-Gm-Message-State: AOJu0YyJrbJwscadoApcdQk1BLteCzN3Q3puV3Z0/x3SxeCtfmXzetuM
	dDZUDqKqkMDmaPZSTfTIAGiCY/GlxqQ=
X-Google-Smtp-Source: AGHT+IENuGCGpG5Rv9r3Z85hpDPt46Zw6j+QUjMoRGpr/oFPdP6Qa6e77RfGaXJHjwOQ2e5Nhc7jBg==
X-Received: by 2002:a17:907:2cc7:b0:9e3:5c27:8862 with SMTP id hg7-20020a1709072cc700b009e35c278862mr4847240ejc.27.1699550452807;
        Thu, 09 Nov 2023 09:20:52 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id o19-20020a1709061b1300b00991faf3810esm2855583ejg.146.2023.11.09.09.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 09:20:52 -0800 (PST)
Message-ID: <3ff0d703846a10d2a84ae5086511793a2aba5c08.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: fix precision backtracking
 instruction iteration
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Thu, 09 Nov 2023 19:20:46 +0200
In-Reply-To: <20231108231152.3583545-3-andrii@kernel.org>
References: <20231108231152.3583545-1-andrii@kernel.org>
	 <20231108231152.3583545-3-andrii@kernel.org>
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

On Wed, 2023-11-08 at 15:11 -0800, Andrii Nakryiko wrote:
> Fix an edge case in __mark_chain_precision() which prematurely stops
> backtracking instructions in a state if it happens that state's first
> and last instruction indexes are the same. This situations doesn't
> necessarily mean that there were no instructions simulated in a state,
> but rather that we starting from the instruction, jumped around a bit,
> and then ended up at the same instruction before checkpointing or
> marking precision.
>=20
> To distinguish between these two possible situations, we need to consult
> jump history. If it's empty or contain a single record "bridging" parent
> state and first instruction of processed state, then we indeed
> backtracked all instructions in this state. But if history is not empty,
> we are definitely not done yet.
>=20
> Move this logic inside get_prev_insn_idx() to contain it more nicely.
> Use -ENOENT return code to denote "we are out of instructions"
> situation.
>
> This bug was exposed by verifier_cfg.c's bounded_recursion subtest, once

Note: verifier_cfg.c should be verifier_loops1.c

> the next fix in this patch set is applied.
>=20
> Fixes: b5dc0163d8fd ("bpf: precise scalar_value tracking")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Funny how nobody noticed this bug for so long, I looked at exactly
this code today while going through your other patch-set and no alarm
bells rang in my head.

I think that this case needs a dedicated test case that would check
precision tracking log.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

