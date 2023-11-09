Return-Path: <bpf+bounces-14587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A22A57E6D33
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 16:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE84A2810B9
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 15:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11A12030B;
	Thu,  9 Nov 2023 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RM+S4MSn"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D753B1D522
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 15:20:15 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076CC30E5
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 07:20:15 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5401bab7525so1611226a12.2
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 07:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699543213; x=1700148013; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7RKYNXJejBEONDmGwgGf+W6UuYeUMvkCmGS7VyELcDU=;
        b=RM+S4MSnVYjcrbxM6xSH6dV7VouaKJZdRDF5vO5hHo5k8+g+8QoeFEAw0kHL8qZ+3P
         WL1ayDRvzo2O7KX1qwPMZcsGe68erfiwQAhq2ebvsCElHaC0++PK2f2VW+mIXCC0l9xP
         tinpL+6RVpq8is6dc0S+CFxIY4ubUKjq2CxaDRUAgEvOSRGUqU034WnHFufV1DXEcB34
         jnFEmJ2MXO8wuIuwkJKyjqRS2u3AS09t1bkGPngqS2JYORh4Sf6EquBL3CALV/rureyo
         V8SQ1hd5ua6qtm10zx74dWUA9bFpsZe8TqOtnwP4YyCzeeu9xPGnKfv0kZOK/23ET8zz
         2XQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699543213; x=1700148013;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RKYNXJejBEONDmGwgGf+W6UuYeUMvkCmGS7VyELcDU=;
        b=gWRMbJspPtgXY4DZe9tWdfQR1zBbS37zKc3cZJgGWsxcWbcFuBzUHcQRrwFmK4KjQ4
         ZOd2pBItFW9j+OWo55UfdPEeagpnHKLPFQZkZVA6uM5NiSwqOXFTva7qJ8zCKPV7X0CV
         9kmdpOLdNuHjkRhh6qcvnU+0VXRo0AEJ0zLzUzmoU/0VQoM7gXqIBK5lgdeIhBoWSNyd
         XM//b/6tb3lQyxL72gZdvw3b4uZPHpcK/NCTs+q/awXypleQ7Z+572VhQXgAIGZ2OVej
         aGB2vjb7KSQ6nZm8/VJ5yDtrg0WJOc4Q8iItBOuXBb33GZv6DHMndeQYE/7Kcfz5FqoB
         7cGg==
X-Gm-Message-State: AOJu0YxF3qv8nekfOthKg9uAUOZsjMkZFUZamUJ5k0m13qp5zMFD5ZZE
	YtGn3WmA2zbEYAMca2PvWKg=
X-Google-Smtp-Source: AGHT+IEWAFuOIs7uiSa7vxmf3zMsRGQF/jfdBcrCrpLkJXwWKG5K4tn64hog0/npfowfWuhys7Gilg==
X-Received: by 2002:a05:6402:292:b0:53e:7cd3:9522 with SMTP id l18-20020a056402029200b0053e7cd39522mr3512209edv.39.1699543213195;
        Thu, 09 Nov 2023 07:20:13 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id c19-20020aa7d613000000b00537666d307csm8188030edr.32.2023.11.09.07.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 07:20:12 -0800 (PST)
Message-ID: <43f0d9f7219b74bfaff14b6496902f1056847de7.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: use common jump (instruction) history
 across all states
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Thu, 09 Nov 2023 17:20:10 +0200
In-Reply-To: <20231031050324.1107444-2-andrii@kernel.org>
References: <20231031050324.1107444-1-andrii@kernel.org>
	 <20231031050324.1107444-2-andrii@kernel.org>
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

On Mon, 2023-10-30 at 22:03 -0700, Andrii Nakryiko wrote:
> Instead of allocating and copying jump history each time we enqueue
> child verifier state, switch to a model where we use one common
> dynamically sized array of instruction jumps across all states.
>=20
> The key observation for proving this is correct is that jmp_history is
> only relevant while state is active, which means it either is a current
> state (and thus we are actively modifying jump history and no other
> state can interfere with us) or we are checkpointed state with some
> children still active (either enqueued or being current).
>=20
> In the latter case our portion of jump history is finalized and won't
> change or grow, so as long as we keep it immutable until the state is
> finalized, we are good.
>=20
> Now, when state is finalized and is put into state hash for potentially
> future pruning lookups, jump history is not used anymore. This is
> because jump history is only used by precision marking logic, and we
> never modify precision markings for finalized states.
>=20
> So, instead of each state having its own small jump history, we keep
> a global dynamically-sized jump history, where each state in current DFS
> path from root to active state remembers its portion of jump history.
> Current state can append to this history, but cannot modify any of its
> parent histories.
>=20
> Because the jmp_history array can be grown through realloc, states don't
> keep pointers, they instead maintain two indexes [start, end) into
> global jump history array. End is exclusive index, so start =3D=3D end me=
ans
> there is no relevant jump history.
>=20
> This should eliminate a lot of allocations and minimize overall memory
> usage (but I haven't benchmarked on real hardware, and QEMU benchmarking
> is too noisy).
>=20
> Also, in the next patch we'll extend jump history to maintain additional
> markings for some instructions even if there was no jump, so in
> preparation for that call this thing a more generic "instruction history"=
.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Nitpick: could you please add a comment somewhere in the code
(is_state_visited? pop_stack?) saying something like this:

  states in the env->head happen to be sorted by insn_hist_end in
  descending order, so popping next state for verification poses no
  risk of overwriting history relevant for states remaining in
  env->head.

Side note: this change would make it harder to change states traversal
order to something other than DFS, should we chose to do so.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]



