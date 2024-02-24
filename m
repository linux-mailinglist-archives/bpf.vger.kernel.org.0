Return-Path: <bpf+bounces-22629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40C98620E2
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 01:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A14C286F19
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 00:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DCC66B25;
	Sat, 24 Feb 2024 00:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3AfYgHJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D0317C8D
	for <bpf@vger.kernel.org>; Sat, 24 Feb 2024 00:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708732836; cv=none; b=KYhXZJ9CeqX0k4FD4VeXtwyP+QYjqIbUEJykNSNplrDRoOgikhx+lTRKHVLozvWEmOdRodG9gMTvhwnI89DAPPpV/WZf6fUdWCN9f1yUyofxc5eG4qBatWssBpxLetnqinb9OC06GRzuSpWyDCtLG4IUaP///GwSussVTuiQf4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708732836; c=relaxed/simple;
	bh=v53x9TF6ZLu3rBGJnAaw7384KK7kwu9kDvUru6Sp+eM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j62wLiUX1FSb/mPQL5CsC5B7se3a6/gLZD8X08JTvcHyv/itOXZiNcjp4x1PfRNs9aYqWXP9gD2HG9vmATgTYafqO9e9stBVXcp6Zg8PTpSdwjT84mp8ExfxhwzB8m7sv2do7+b3+vvYlJM0ab2i2u3j4otI0+29eyijx3eGWo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3AfYgHJ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso186068466b.2
        for <bpf@vger.kernel.org>; Fri, 23 Feb 2024 16:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708732833; x=1709337633; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tKbe8JK338tFTPvDET2xmgNImTIu5k34sZFecmTjJg4=;
        b=h3AfYgHJ+cA6FBPfc8+LhAHNZzZHjfFrpt27XsWEgjNMPCUCTQ8ItV/kTL9TFmEMMh
         fM/tVHcq88aRb20KVqyEo4SsgyJxHgFGRLmNPL+2kXkB58xqXxrsZvei91F/yLHD6e5v
         AUzefijYYTSZFha3zDt5QqShtaYlWWdOEonQe39LFp0LKSNKApoUKQefeGaQIGjtMmPG
         nJwjFa7BChqrdRyekwpmM5IFqfWDOz+2jha+rwQdHmDodleEijrxLsEBbvZGATwRUO+j
         W7zF/D0gBvUxCorCwfRcgB9Qz0+JwF2PHrzTCsS360VkJ6HeGseYekxWCvb/B0R29slo
         3+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708732833; x=1709337633;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tKbe8JK338tFTPvDET2xmgNImTIu5k34sZFecmTjJg4=;
        b=TRCCyciCZyljKlVzBwkvpQLoisvxmbVTXhDuAcKFzl8nA/UqIuRjaYKoE6jnm2BHgg
         bQ3xbpusjn9H1rFJv8DcGRRMP2Kv50uFuXXwskNvfOfd7Fvk7qC2HgmFl37HTeqSlMFN
         Y00aEPdq+IbjNMlo6F9laMXFVSbFx33ArisbBoRsR3oYj29+djx9GP029cMF9TLu38i3
         vvCzRWq8Jo5DCWB32/PID3xumSgrsaOUdQ16SirDUsc8rSzklPJ67pQd5FSh3ASEDmm1
         paybAKEKBtQ6L7xznU1/yZMIA3jeUG+275P/IL9G4t9RSroLT69ed903shqC9KzKQgj8
         HxDA==
X-Forwarded-Encrypted: i=1; AJvYcCVDno0zxo0I40sJoH2R6hB/VTyzwzx98vSR3GMfMrtdzb6Z9mW1ZcazSl3t+4L7h60tW8iVDtzTUkmk/FtX2PJ76V98
X-Gm-Message-State: AOJu0YwVKdmMgSMiI/Utt9/qQON5UJJx/2RiNNFT+ArJ8i+dRni6MHf4
	jpRd7+OJTqz8ZpZb4ES/cRHolRvKn7reOiswUaTsFIYDBY8Lr07P
X-Google-Smtp-Source: AGHT+IHyUhvfUxkSyo5B/LBwmQRtULtnU46TrZvEZhUbOu8RIV0rRp2L9hFxKzWYetiflHFdngdtGg==
X-Received: by 2002:a17:906:1c08:b0:a3d:6f47:6bf7 with SMTP id k8-20020a1709061c0800b00a3d6f476bf7mr821787ejg.12.1708732833025;
        Fri, 23 Feb 2024 16:00:33 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id w13-20020a17090633cd00b00a3f2b4e702dsm59173eja.206.2024.02.23.16.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 16:00:32 -0800 (PST)
Message-ID: <53cc7e1fea7efb557cd4d65fdff5642c0047f255.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Introduce bpf_can_loop() kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com, kernel-team@fb.com
Date: Sat, 24 Feb 2024 02:00:31 +0200
In-Reply-To: <20240222063324.46468-1-alexei.starovoitov@gmail.com>
References: <20240222063324.46468-1-alexei.starovoitov@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-21 at 22:33 -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> While working on bpf_arena the following monster macro had to be
> used to iterate a link list:
>         for (struct bpf_iter_num ___it __attribute__((aligned(8),        =
               \
>                                                       cleanup(bpf_iter_nu=
m_destroy))),  \
>                         * ___tmp =3D (                                   =
                 \
>                                 bpf_iter_num_new(&___it, 0, (1000000)),  =
               \
>                                 pos =3D list_entry_safe((head)->first,   =
                 \
>                                                       typeof(*(pos)), mem=
ber),          \
>                                 (void)bpf_iter_num_destroy, (void *)0);  =
               \
>              bpf_iter_num_next(&___it) && pos &&                         =
               \
>                 ({ ___tmp =3D (void *)pos->member.next; 1; });           =
                 \
>              pos =3D list_entry_safe((void __arena *)___tmp, typeof(*(pos=
)), member))
>=20
> It's similar to bpf_for(), bpf_repeat() macros.
> Unfortunately every "for" in normal C code needs an equivalent monster ma=
cro.

Tbh, I really don't like the idea of adding more hacks for loop handling.
This would be the fourth: regular bounded loops, bpf_loop, iterators
and now bpf_can_loop. Imo, it would be better to:
- either create a reusable "semi-monster" macro e.g. "__with_bound(iter_nam=
e)"
  that would hide "struct bpf_iter_num iter_name ... cleanup ..." declarati=
on
  to simplify definitions of other iterating macro;
- or add kfuncs for list iterator.

Having said that, I don't see any obvious technical issues with this partic=
ular patch.
A few nits below.

[...]

> @@ -7954,10 +7956,14 @@ static int process_iter_next_call(struct bpf_veri=
fier_env *env, int insn_idx,
>  	struct bpf_reg_state *cur_iter, *queued_iter;
>  	int iter_frameno =3D meta->iter.frameno;
>  	int iter_spi =3D meta->iter.spi;
> +	bool is_can_loop =3D is_can_loop_kfunc(meta);
> =20
>  	BTF_TYPE_EMIT(struct bpf_iter);
> =20
> -	cur_iter =3D &env->cur_state->frame[iter_frameno]->stack[iter_spi].spil=
led_ptr;
> +	if (is_can_loop)
> +		cur_iter =3D &cur_st->can_loop_reg;
> +	else
> +		cur_iter =3D &cur_st->frame[iter_frameno]->stack[iter_spi].spilled_ptr=
;

I think that adding of a utility function hiding this choice, e.g.:

    get_iter_reg(struct bpf_verifier_state *st, int insn_idx)

would simplify the code a bit, here and in is_state_visited().

[...]

> @@ -19549,6 +19608,8 @@ static int do_misc_fixups(struct bpf_verifier_env=
 *env)
>  			delta	 +=3D cnt - 1;
>  			env->prog =3D prog =3D new_prog;
>  			insn	  =3D new_prog->insnsi + i + delta;
> +			if (stack_extra)
> +				stack_depth_extra =3D max(stack_depth_extra, stack_extra);

I don't think that using "max" here makes much sense.
If several sorts of kfuncs would need extra stack space,
most likely this space won't be shared, e.g. bpf_can_loop() would need
it's 8 bytes + bpf_some_new_feature() would need 16 bytes on top of that et=
c.
So some kind of flags indicating space for which features is reacquired is =
needed here.

[...]

