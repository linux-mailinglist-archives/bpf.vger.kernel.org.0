Return-Path: <bpf+bounces-78005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE1ECFACD7
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 20:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 735FC313DF18
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 19:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBAD83559ED;
	Tue,  6 Jan 2026 19:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="J1ZBZfYB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF153559CA
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767726781; cv=none; b=BEu+tRWhk07aezljhfTm/0wS9q9fIO9knLhg5BU0RxBL81yIb9c2zk4323ZKphGlWoR9+6XXgFLYVJxzNladddtH7Rm6B0OINCgyF3hHSfkwwg8cplGKVPvwhaSpsVNc750kNUAX7D/MDBjGOqc1NsZMiXj3kvu8ckns/Lzo+9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767726781; c=relaxed/simple;
	bh=MTcyF5b+m7Nyqandj8JtczWsOLQSOo5LeGjHtbxWriw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jxLHV7k9mZhtnt2YRK7+3pKlm7WCv/iqnZJrE/Ty4OQX/ds4/IkQS050pxk8YlnywlF0hPecGZMUzru/ouPCgdfGMT8ojOtubGTQzjHmdEI7rAjGvbYAG/XprLWM8RI5O1vklD+GshizyloliOe1hoPBKfiDRhXcMpqCReBnkyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=J1ZBZfYB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8440cb2dbeso53617066b.3
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 11:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767726778; x=1768331578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXWpgxUwvI+z5T2g0AYqNsPXHVO8gEezrOfJieXUNiU=;
        b=J1ZBZfYBN/5Aqgd1hJT8EvXHE+m2mSbf6ghC7xxsR/O1bXxPVJ9TeF09lQq4rWbeBO
         W2yCD7rvqI7+UWO/1L3W6rkbGBDygal0nssDjKyOx5s/YnfXTO9M+AczvxNQ75uzKMc2
         OwMmdZ0Vahj4gAClUs1TJwdUNOrhudbVmfX+BLn23ratB5M5tkJHTf/8eltiEBCqx5YV
         3Ilo+c+2VjixeugzzvRvdEaeP1Ps5I3GqnkkreyGoCqs3YQAW5S//rzUHzCWTyNG41aF
         3kOBAYZ0l7Dr4nPgk42BPmU9s8ZOVkO1qg6GR4xm1poKxokoqPodgDAjifDaE3x7/nK5
         Jyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767726778; x=1768331578;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NXWpgxUwvI+z5T2g0AYqNsPXHVO8gEezrOfJieXUNiU=;
        b=g6Bl+kDZgQ89hFpCh2FGZ6Lr3JdoViGH8cPVK2+pcMhUbRNVj38vX5x5IK2f7GrPjs
         HZjEWSpPNxWf6mAGZ5qvEhZmVdD/sc6Dgst4IV4w4bDcFmGMOCIsFiHzKFpc03l7tzsh
         +HItWSmrBzk7ajkZxExOdJaxcYxkLKh46F9L7kfbkdN3hBZmXfKb2MGA1LOAhiaJNUv8
         Lb+o7ZrkMoDyMRFjt2XmTBl7LuXe7RI1usFlya/6N9TjUEQpQgvN3WnQueuhfI93DXhr
         XUm9OfYYV8CJ2RWz+z3YL7t3Lf3TFXjHx1Hci+OuAyqqI1aj2BRFVqTHC5n1285CqSvj
         UhGA==
X-Forwarded-Encrypted: i=1; AJvYcCU7WrUGeL4Jlz580z3cuhwyQHZEllZsaBf1CTd6B4SnWR03KvoqVPiaOiyKfdgMlHQGC/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrp3msQqH4XJ53arawaZQ8mF8n5GKfkZimZt+CfZ4Y0mLuSnLk
	RDUERBWfArMck5ngy7LN4Bbpl0F9/RtX2PTj1p7N/g23UtDGBe1BJJAWiTpHdgf4KIA=
X-Gm-Gg: AY/fxX7ftpRbJFX4NKaFKn56LJaui/HkFnbAXBlCwt1hoCxAdJUlXoG8gbIHc9WtXg6
	gEDKSFJmQNSorAUWzyDGOeChh6aFCWeyWpM4VJBM5LElOXlk58pAodsEyBvbiT5eKPYdq75r7b8
	CPIHN1+QZeK3egRnWcdKuRhL2M/qArFEbCZDVQSkbr/aOm16RNUJaQuvZTE6F1W3m/B2+T6sciU
	TmmI7YI3j7wjEvwPyGfciqTPu7t6Dni7TlyzUQ/yfZgf0hsktBCm9d7snHvcxIapj/5ZIRh0S/Y
	7ykttlDnhRBtB4qNntLpv7NjzhtL6CcFd/DbAluLthGDvMXLYbIWADEzuai7M1IfLArix9SezG/
	V+gl+/W3XBK5cpxI9rbS2MTCQn/BvimEvvnSA4/dI12pssnfehSz2cviZqWsjbKX0WFiKr12O5f
	PsVg==
X-Google-Smtp-Source: AGHT+IE3z7Gjd92GDSE6PNW2kogYeyhE4xgee7+KnxQ3/NwdbhBSJKfxfIGkZrdtzTRaaf5Uhcw0Uw==
X-Received: by 2002:a17:907:3d0b:b0:b83:1326:7d45 with SMTP id a640c23a62f3a-b8445345f6dmr14494766b.32.1767726778155;
        Tue, 06 Jan 2026 11:12:58 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:295f::41f:a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a4d0290sm291076166b.32.2026.01.06.11.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 11:12:57 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Amery Hung <ameryhung@gmail.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>,  Martin KaFai Lau <martin.lau@linux.dev>
Cc: Martin KaFai Lau <martin.lau@kernel.org>,  bpf <bpf@vger.kernel.org>,
  Network Development <netdev@vger.kernel.org>,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Jesper Dangaard Brouer <hawk@kernel.org>,  John Fastabend
 <john.fastabend@gmail.com>,  Stanislav Fomichev <sdf@fomichev.me>,  Simon
 Horman <horms@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>,  Eduard
 Zingerman <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  kernel-team
 <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 15/16] bpf: Realign skb metadata for TC
 progs using data_meta
In-Reply-To: <CAMB2axNnCWp0-ow7Xbg2Go7G61N=Ls_e+DVNq5wBWFbqbFZn-A@mail.gmail.com>
	(Amery Hung's message of "Tue, 6 Jan 2026 09:46:49 -0800")
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
	<20260105-skb-meta-safeproof-netdevs-rx-only-v2-15-a21e679b5afa@cloudflare.com>
	<CAADnVQJbGosoXOCdyi=NZar966FVibKYobBgQ9BiyEH3=-HOsw@mail.gmail.com>
	<CAMB2axPivi+mZOXie=VnJM8nscqkHDjSrKT=Dhp5z_copEwxLQ@mail.gmail.com>
	<e969a85c-94eb-4cb5-a7ac-524a16ccce01@linux.dev>
	<CAADnVQKB5vRJM4kJC5515snR6KHweE-Ld_W1wWgPSWATgiUCwg@mail.gmail.com>
	<d267c646-1acc-4e5b-aa96-56759fca57d0@linux.dev>
	<CAMB2axM+Z9npytoRDb-D1xVQSSx__nW0GOPMOP_uMNU-ZE=AZA@mail.gmail.com>
	<CAADnVQJ=kmVAZsgkG9P2nEBTUG3E4PrDG=Yz8tfeFysH4ZBqVw@mail.gmail.com>
	<877btu8wz2.fsf@cloudflare.com>
	<CAMB2axNnCWp0-ow7Xbg2Go7G61N=Ls_e+DVNq5wBWFbqbFZn-A@mail.gmail.com>
Date: Tue, 06 Jan 2026 20:12:56 +0100
Message-ID: <87qzs2imh3.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2026 at 09:46 AM -08, Amery Hung wrote:
> On Tue, Jan 6, 2026 at 9:36=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.c=
om> wrote:
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -21806,6 +21806,14 @@ static int convert_ctx_accesses(struct bpf_veri=
fier_env *env)
>>                         env->prog =3D new_prog;
>>                         delta +=3D cnt - 1;
>>
>> +                       /* gen_prologue emits function calls with target=
 address
>> +                        * relative to __bpf_call_base. Skip patch_call_=
imm fixup.
>> +                        */
>> +                       for (i =3D 0; i < cnt - 1; i++) {
>> +                               if (bpf_helper_call(&env->prog->insnsi[i=
]))
>> +                                       env->insn_aux_data[i].finalized_=
call =3D true;
>> +                       }
>> +
>>                         ret =3D add_kfunc_in_insns(env, insn_buf, cnt - =
1);
>
> And then we can get rid of this function as there is no use case for
> having a new kfunc in gen_{pro,epi}logue.

Happy to convert bpf_{qdisc,testmod} gen_{pro,epi}logue to use
BPF_EMIT_CALL instead of BPF_CALL_KFUNC.

If it's alright with you, I'd like to kill kfunc support in
{pro,epi}logue as a follow up.

Looks like there will be a bit of churn in selftests to remove the
coverage. And this series is getting quite long.

