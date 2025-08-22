Return-Path: <bpf+bounces-66299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B3DB3225A
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 20:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DDC4B21B0B
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 18:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D2C263F4E;
	Fri, 22 Aug 2025 18:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K8Ll51w5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B022874FC
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755887856; cv=none; b=ZxAwH5I8zxu/cq74UvmaAB5oOIVzbvhUfp2TXKZx9ZlK5HsiIBaM0fh5ILP6qgUw1jUJcosae8BJEy4m/irRSPQNa0LVg8/sK9XPp70dwwVqwIBUfq4LK/MMBhszAICy7volVVOfwPofVOq/UIeaXnQ3KGhQIrHtvzW0Fwg5TbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755887856; c=relaxed/simple;
	bh=zst1GYGGvgtpDg+8Ta3K0VI7BZ14/G4a+5cCZYBrcIU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sStE4KsEkunEu99jpMtn7nxg+HnJdA3CZPyAD4xNa8V8h2Fnid2ms1s7s7qRMH2rHVD/EoSsSyJm7qbOhwvvm0/60lDXE1KA7vjB01IAufNnsVT0n5E2yJI4QJNo7JS515hhezTq/q7PEjlChFK/z/BkANMdGRh252zptWahPv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K8Ll51w5; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b475dfb4f42so1633526a12.0
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 11:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755887854; x=1756492654; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9l6QrC0CabjVLK7R+LHdXubOAVdY3tRewSAY06u/8qg=;
        b=K8Ll51w5mBCGJoCXVvYnLWV3Qe7xbRWLxgHw3K5Ts2bkvuRVm9xVHpan21spSgqOa3
         mho2uiKo3cAXe2YLOMWycMl1+GMoeU6OV7nMCmlv6xQ7v4EPrM44roLHOBnCMTjtqvH6
         Ws7+BUlDbFC7U3w0RXEAohvp+VDm/PQq/1ERJlZ4XC5PtNpgdASByCULA+hmwBWpMc/D
         ctoP2e0a7P2ywfd+j6Gg1QQN+OEXhQjJPnbce/xbCPyoLJdGDCFqQ2UHJeK7hPZ020yT
         Bqx88Bq5tvRizAEiGdT9uaaUShFhbQcUdzN5VFchwe1bniqjFZccShjI/N1xoDneRMt8
         abEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755887854; x=1756492654;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9l6QrC0CabjVLK7R+LHdXubOAVdY3tRewSAY06u/8qg=;
        b=PFlHCfumcO4y0w7ItJPHdbvEsNhKHY7WY8h32NeRZm/dQ3FeNokSE63WIxv2zopYMT
         eS73g6d5KKSWZ+3RFlvQs2EoOBB9xxMsOiT8uygD7qOkMHY6oPHgsuINBZFZhsvN2rFP
         U/+Hkliy5KK7nokwNUvoUMc2Vyr+M8Lc1fuBC1c6GA8Sz0AcDGDNhhghzJUWGIau87y5
         PKB+TSjetTaRiEI00xBXObwKKA8h7IEbasYZeCHC+ymBdj6QAZofU5pbF2CjrJXi0xm2
         4tsOTB83LLjKc01B+7sVrwNM4SyZ0HY2vi7gfxPnE5W6L97w7vzEe5ZQaf1OY+47dNiJ
         HBQw==
X-Gm-Message-State: AOJu0YzHnU5d13Q8SfHyK1Ru3fjQExlMhNDS+Bz8BA0yi1eoQ2SUlQ64
	TJDVn0zGcRREdEfoFehmf5ZKFeRAjEAc1B4C82ZZ+zjDJmMa2Pqi8jfj
X-Gm-Gg: ASbGnctHIhWSNgSYZSAF0K10VoX1SsuTZsnMkdgk4xjwc/ltDaoFUskciw75JoWLEEq
	bGiegpQ5s/zKKDlULlbGiqHbFanWZtyd8d7uoauTDo0JGMvJRdEzvLR3v7U5X3nmlIdDFqeiJbt
	gZzR9/kqAHEcx2WRN/4eSbYSXaEo09cuC6HeSQnfZZ8x3kbOwfy42OpMVLw5yakGOTmN6rrbzgW
	pu3JpJMDZ30bDiKemQMdOqSYFXY0+vhzo3kaSv3Z5S8ioFOObtlHulUbCI5HaRiw+NUnNe1ubzW
	pYNy0HeF8HkKFrzzCuhnOMzTQIvmn0spkcpH1jxCYlByqJF/CCuX8xvBGLgBXdpvqp7i/pj4ILO
	O/5SnhPgUUf/D0oITHAQ3ZQWx9OEf7Q==
X-Google-Smtp-Source: AGHT+IHguyJMYbbKqg6KyG/cPVi9QtbmDCZBU29JUg5CTPMhwvTETZpiavUAMHQmWfbDLCEXMcsy2w==
X-Received: by 2002:a17:902:f211:b0:242:fe99:eb20 with SMTP id d9443c01a7336-2462edd7d90mr29950575ad.9.1755887853489;
        Fri, 22 Aug 2025 11:37:33 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466886479fsm2873865ad.75.2025.08.22.11.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 11:37:33 -0700 (PDT)
Message-ID: <7d150bc2d3ef8691c440f03bc5e57e92cda10a26.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/2] bpf: improve the general precision of
 tnum_mul
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Jakub Sitnicki	 <jakub@cloudflare.com>, Harishankar Vishwanathan	
 <harishankar.vishwanathan@gmail.com>
Date: Fri, 22 Aug 2025 11:37:25 -0700
In-Reply-To: <20250822170821.2053848-1-nandakumar@nandakumar.co.in>
References: <20250822170821.2053848-1-nandakumar@nandakumar.co.in>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-22 at 22:38 +0530, Nandakumar Edamana wrote:
> This commit addresses a challenge explained in an open question ("How
> can we incorporate correlation in unknown bits across partial
> products?") left by Harishankar et al. in their paper:
> https://arxiv.org/abs/2105.05398
>=20
> When LSB(a) is uncertain, we know for sure that it is either 0 or 1,
> from which we could find two possible partial products and take a
> union. Experiment shows that applying this technique in long
> multiplication improves the precision in a significant number of cases
> (at the cost of losing precision in a relatively lower number of
> cases).
>=20
> This commit also removes the value-mask decomposition technique
> employed by Harishankar et al., as its direct incorporation did not
> result in any improvements for the new algorithm.
>=20
> Signed-off-by: Nandakumar Edamana <nandakumar@nandakumar.co.in>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


[...]

> diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
> index fa353c5d550f..50e4d34d4774 100644
> --- a/kernel/bpf/tnum.c
> +++ b/kernel/bpf/tnum.c
> @@ -116,31 +116,39 @@ struct tnum tnum_xor(struct tnum a, struct tnum b)
>  	return TNUM(v & ~mu, mu);
>  }
> =20
> -/* Generate partial products by multiplying each bit in the multiplier (=
tnum a)
> - * with the multiplicand (tnum b), and add the partial products after
> - * appropriately bit-shifting them. Instead of directly performing tnum =
addition
> - * on the generated partial products, equivalenty, decompose each partia=
l
> - * product into two tnums, consisting of the value-sum (acc_v) and the
> - * mask-sum (acc_m) and then perform tnum addition on them. The followin=
g paper
> - * explains the algorithm in more detail: https://arxiv.org/abs/2105.053=
98.
> +/* Perform long multiplication, iterating through the trits in a.
> + * Inside `else if (a.mask & 1)`, instead of simply multiplying b with L=
SB(a)'s
> + * uncertainty and accumulating directly, we find two possible partial p=
roducts
> + * (one for LSB(a) =3D 0 and another for LSB(a) =3D 1), and add their un=
ion to the
> + * accumulator. This addresses an issue pointed out in an open question =
("How
> + * can we incorporate correlation in unknown bits across partial product=
s?")
> + * left by Harishankar et al. (https://arxiv.org/abs/2105.05398), improv=
ing
> + * the general precision significantly.
>   */

Nit: The above comment is good for commit message but not for the code itse=
lf.
     Imo, commit in the code should concentrate on the concrete mechanics.
     E.g. you had a nice example in the readme for improved-tnum-mul.
     So, maybe change to something like below?

     /*
      * Perform long multiplication, iterating through the trits in a:
      * - if LSB(a) is a known 0, keep current accumulator
      * - if LSB(a) is a known 1, add b to current accumulator
      * - if LSB(a) is unknown, take a union of the above cases.
      *
      * For example:
      *
      *               acc_0:	    acc_1:=09
      *               		   =09
      *     11 *  ->      11 *	->      11 *  -> union(0011, 1001) =3D=3D x0=
x1
      *     x1	          01	        11=09
      * ------	      ------	    ------=09
      *     11	          11	        11=09
      *    xx	         00	       11=09
      * ------	      ------	    ------=09
      *   ????	        0011	      1001
      */

>  struct tnum tnum_mul(struct tnum a, struct tnum b)
>  {
> -	u64 acc_v =3D a.value * b.value;
> -	struct tnum acc_m =3D TNUM(0, 0);
> +	struct tnum acc =3D TNUM(0, 0);
> =20
>  	while (a.value || a.mask) {
>  		/* LSB of tnum a is a certain 1 */
>  		if (a.value & 1)
> -			acc_m =3D tnum_add(acc_m, TNUM(0, b.mask));
> +			acc =3D tnum_add(acc, b);
>  		/* LSB of tnum a is uncertain */
> -		else if (a.mask & 1)
> -			acc_m =3D tnum_add(acc_m, TNUM(0, b.value | b.mask));
> +		else if (a.mask & 1) {
> +			/* acc =3D tnum_union(acc_0, acc_1), where acc_0 and
> +			 * acc_1 are partial accumulators for cases
> +			 * LSB(a) =3D certain 0 and LSB(a) =3D certain 1.
> +			 * acc_0 =3D acc + 0 * b =3D acc.
> +			 * acc_1 =3D acc + 1 * b =3D tnum_add(acc, b).
> +			 */
> +
> +			acc =3D tnum_union(acc, tnum_add(acc, b));
> +		}
>  		/* Note: no case for LSB is certain 0 */
>  		a =3D tnum_rshift(a, 1);
>  		b =3D tnum_lshift(b, 1);
>  	}
> -	return tnum_add(TNUM(acc_v, 0), acc_m);
> +	return acc;
>  }
> =20
>  /* Note that if a and b disagree - i.e. one has a 'known 1' where the ot=
her has

[...]

