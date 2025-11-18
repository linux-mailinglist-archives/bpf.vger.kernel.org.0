Return-Path: <bpf+bounces-75003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA503C6B76A
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 20:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 66369352649
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 19:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21CA2E8DEB;
	Tue, 18 Nov 2025 19:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCPbXMhv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9162E2DF706
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763494496; cv=none; b=r6E912dAY+wcbv+WnU6XeJYS2LXRlHWqzUadP/hyA+GD8Yhrhq6ySyy5L70Phfgb16pZviXEiGGaOCSf2BpcCmp6r5gsTbVWmcJCCONKG6TBVM4nPjmcYFEGQBuRx3qYN32LKZiK87SJFArO6D9ldFjhP1IxGEJ70a5noE2Hl18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763494496; c=relaxed/simple;
	bh=SZASRL1eaq2Z9koSnqTIek22ReKPeVhfSqqw1kAIWzQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hd0KhQ7tycnE2tdb5bLmfXl+OxJuhmQBLGTMrQEviN1upKgJ11ewW7eUdlewzohTH44E7BFVMj0GW3eb2gQos2g/zdzprjGsTK9PjJi/aoNbeG/NM9hR+M1tzEAYrSrSJ5FKCMcLjgaZldvpfgr/a8I1EZwyRbCcPXv2VeiMjQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCPbXMhv; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-343ff854297so6666837a91.1
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 11:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763494494; x=1764099294; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vr05ubOKGqkROEe4evQSyg4dyB1h7iitnqsoMqohlto=;
        b=aCPbXMhv/w6PjeGujmO9XJ/1ZoUDSYGjxFz7HXJ186jfYpIBjeVSS2zeHej5q9Joq/
         6qjOf6G5Q8P1Bc7118Xp1p4/h8dTPVwXGMGEouc9CQDx+oW2quY4R+hko40OC1mSxVtE
         MKUglbbb7EAXKUAnK0quchc7VvpfgkIqg6GHqCob9S9XoFRtxxZBUjWl1JM6FNUDZa4n
         0INNM0sBcz4JDXWqA5RnSL2aUweRPvVI8ntHomxR46GAK9ZV4BhQvUYMfIbe2hJ+0OS1
         /70MM8y450aNJFnJgouDibvuEkXoVCTVeKSZljp8/LrgbGvayNJkCB5y5rhQUCJaYMDP
         rKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763494494; x=1764099294;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vr05ubOKGqkROEe4evQSyg4dyB1h7iitnqsoMqohlto=;
        b=Xr+xE1hMU6x0jkKn6yIo7fZJf7qWQUgYuzP6xxxVAfQIoUiPWXj35CMtymMtWmokXh
         SYgefbzG4dSky/p9nHe7cjZYjtBtDsRw8akxDFPRGdOcAf8a/xPlakLAGYbnKUzU0WfV
         ETdpPFUnxoWcJClUXLS1wyBm2jlc9gcASu6HA639+AqgS+Xb2MkeefzJTEeBwfBskwTc
         RtgjHGJlgS9M6+y4EYczb5/xTE4Ek4OVNz/6Tq2GFYJFZXX1nW1j3ELZbayp5R+ldbik
         mlfjPoB84V0ghlArk4WKV2UzdH1bCAI7RbYbU+pTma/+MO88YJ8jhyXeLvgjVLkfsXyH
         iA+A==
X-Forwarded-Encrypted: i=1; AJvYcCV7GOV2e9fueatrojhRQf4hbaLF/NZ3DPjxjo3V4wCTKLmR3mFqsl542ZTzvl/MU+OIQfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjjBCeD0RTIhGaY1VeAR7SyUUyTgCegtrtnapROryJlaf0jSDt
	+OoRTKtaTeX0WG5Ye9q6kUrZWvpNMd+QPmyn2LJK4s2RvLObw+ng3ujA
X-Gm-Gg: ASbGncvkqC4Giv/4u/pnUakfVufkbKxogAso+qyud59tj9qLsj0nWZWPPsFE3k0/Ln6
	kiyyl0XXJy7b+9ibobfsgBoGHh3QNqdNiFHNT97nZq8STC4JYm6FbhhYe2FR3K8Z6EtOP3IZyZ3
	vNfuD250XfDIp5b81+Y/xJTqfFbtqrQohe+xECBVbN83ozODSeLsnws1MV2Zp9ezHwqDcNoex+Q
	TYSKx6lwQe7iZGcXqaSvNevK460bdz2qbVymCRN7i7iry/Qr1PjYH5xvRzTTAhluMyHZECUgS3N
	bMC2Bkf22XSBu0XbnsXryOGtbiflUTSdBhVfQjy+EHzgNm+4xUzb1oGMDr6HzoWwl1U/d/w/xND
	hnqgoYmXnDJ/gBqluJ+pnZ+JDdIITg1ctINQqBy69WA2xr6uKYNbwzBhHW43DYEZtry3YWahs5r
	QrRQw2BvY55m9pYxBVaEQgXHkpA0kzogSeo67LzEAdrSfLWgnn4jXagVI9aA==
X-Google-Smtp-Source: AGHT+IHKfNQSuEhvwnxyXNhmAikwNvvuefOGn9OKXymcQaOchEdYnGwj861BbL4h2AzmFoFmUzQ8Ow==
X-Received: by 2002:a17:90b:3b45:b0:33e:1acc:1799 with SMTP id 98e67ed59e1d1-343f9edf47dmr19899197a91.14.1763494493544;
        Tue, 18 Nov 2025 11:34:53 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4f58:7af7:80e3:c4a9? ([2620:10d:c090:500::4:78f6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345bc111e72sm252749a91.15.2025.11.18.11.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 11:34:52 -0800 (PST)
Message-ID: <622f4e7645e426ae180e4511877eb90ceb1b1063.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/4] bpf: properly verify tail call behavior
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin Teichmann <martin.teichmann@xfel.eu>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org
Date: Tue, 18 Nov 2025 11:34:51 -0800
In-Reply-To: <20251118133944.979865-2-martin.teichmann@xfel.eu>
References: <4952b7bf8a0b50352b31bee7ddf89e7809101af6.camel@gmail.com>
	 <20251118133944.979865-2-martin.teichmann@xfel.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-11-18 at 14:39 +0100, Martin Teichmann wrote:
> A successful ebpf tail call does not return to the caller, but to the
> caller-of-the-caller, often just finishing the ebpf program altogether.
>=20
> Any restrictions that the verifier needs to take into account - notably
> the fact that the tail call might have modified packet pointers - are to
> be checked on the caller-of-the-caller. Checking it on the caller made
> the verifier refuse perfectly fine programs that would use the packet
> pointers after a tail call, which is no problem as this code is only
> executed if the tail call was unsuccessful, i.e. nothing happened.
>=20
> This patch simulates the behavior of a tail call in the verifier. A
> conditional jump to the code after the tail call is added for the case
> of an unsucessful tail call, and a return to the caller is simulated for
> a successful tail call.
>=20
> For the successful case we assume that the tail call returns an int,
> as tail calls are currently only allowed in functions that return and
> int. We always assume that the tail call modified the packet pointers,
> as we do not know what the tail call did.
>=20
> For the unsuccessful case we know nothing happened, so we do not need to
> add new constraints.
>=20
> This approach also allows to check other problems that may occur with
> tail calls, namely we are now able to check that precision is properly
> propagated into subprograms using tail calls, as well as checking the
> live slots in such a subprogram.
>=20
> Fixes: 1a4607ffba35 ("bpf: consider that tail calls invalidate packet poi=
nters")
> Link: https://lore.kernel.org/bpf/20251029105828.1488347-1-martin.teichma=
nn@xfel.eu/
> Signed-off-by: Martin Teichmann <martin.teichmann@xfel.eu>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 098dd7f21c89..117a2b1cf87c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[...]

> @@ -11970,6 +11979,25 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
>  		env->prog->call_get_func_ip =3D true;
>  	}
> =20
> +	if (func_id =3D=3D BPF_FUNC_tail_call) {

[...]

> +		if (env->cur_state->curframe) {
> +			struct bpf_verifier_state *branch;
> +
> +			mark_reg_scratched(env, BPF_REG_0);
> +			branch =3D push_stack(env, env->insn_idx + 1, env->insn_idx, false);
> +			if (IS_ERR(branch))
> +				return PTR_ERR(branch);
> +			clear_all_pkt_pointers(env);
> +			mark_reg_unknown(env, regs, BPF_REG_0);
> +			err =3D prepare_func_exit(env, &env->insn_idx);
> +			if (err)
> +				return err;
> +			env->insn_idx--;

This insn_idx adjustment is a bit unfortunate, but refactoring getting
rid of it is probably out of scope for this series.

