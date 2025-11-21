Return-Path: <bpf+bounces-75214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 02424C76FA2
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 03:14:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 985D835330F
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 02:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59CA24DD15;
	Fri, 21 Nov 2025 02:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEBT4eWS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A2D248F47
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 02:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763690756; cv=none; b=rImywvkc0SA20KKg433S8GL9SZJXDEIzB7JPhUDV9Q52gGmOwPeT0LvZty92k+e6gErBMNWWDKQlO7JK6fkW2U//fJqy0zo+6jAtVjwHpHIVzZBLHVxZB86wtKvAmIYnLRl6FOr5UAKKxjZolma+Udak7QYmZHaxlbaUpaYaENg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763690756; c=relaxed/simple;
	bh=5BhvHCfnC4zI2X4WQjqfxe0XS5P6hgA1mYoN7wJWMSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCk+dnmVsXDfV2RzPp/WEvHDJ8VLeKUtFaMzTZakzGz9mODKbixZI0M7DFijneBAtRj16kU0PH8Owln7EFhA9FhmaC53SNdeCzwLtea8EEGMm7nOTIgsTR8U9oVyx3sz64arTOVUbTRGFpYOPg+PpTNG6qGJcu12uGJIPmOw1io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEBT4eWS; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640fb02a662so2789a12.1
        for <bpf@vger.kernel.org>; Thu, 20 Nov 2025 18:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763690752; x=1764295552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVuoevcqA7pkSH5nH6WTShun8qwReN4X20j7oQ8WeQs=;
        b=VEBT4eWSTqk6M+dOkuU/+WUSoxFBvZVnU4JZoHxr4Et9C5cAcpf4SeYRiWtdGpwyX/
         HgyYuasAwVKbAA3Ej/vPNnJwCE89sCSmlyH3qnFz++49JA4mwzdAnQCx6fwMHqgs0TAc
         olgK/yyeBy2gH0OK6IwqxkrHpUeh5EozjqWsNoHARY9rZRGq0Bp57MDnY3FLqrVzXm0N
         EHbTJ7xQkPlstuCJDrUGoqAM9TsumFIb5XQ4sO/wIZFmTI9azLCtxGEt6qvpUyJ5OQ6m
         Mx9J6nmETFshkYjus0Md0R5VukL5eRacIOm5dRI801SM7oxd4lOQBhgEe3g7POGMius5
         RHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763690752; x=1764295552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YVuoevcqA7pkSH5nH6WTShun8qwReN4X20j7oQ8WeQs=;
        b=Jz2+58cLsVhuJQqHmeNlgnGpG/JlPUh0/ysVTPqL2B5++a5MB30Y/f5a5XvykEH0t+
         RLcdxDJNLH0prtEmkJUJLHTexgwzxkdvqJYmDalFJNUYVxaLezuT2vaoBMREuenxQNQh
         iC2tnrjY7b3HEotON7YVyJtFtm9syqLVa87KfNs42/n5Cf33PJlFXXomhmExD0XNHP0J
         hU5txC+nT8GyJ8en3VvS8okoC4BiIPuHxERGOmF/8IHQ6U0DmTog1FpdBhLUEEBvHLUD
         sUZ5Q//1MnT8rXjtl5/mF6nIdY3JjtoeOWGizPVZpCAk1k7vinmtD0e6OMisPUHcqwTy
         vNlA==
X-Forwarded-Encrypted: i=1; AJvYcCUJKLlHe6qP6TWTsuKRq+58PxpzC0j21Mh+5VBC3fQUDLtB7uA7KePforxF0qUFV6fOqqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO86zPgwETfTb0rZCBdMyLvokSQsnPdP5U8Qk4ljvmFT9Bm/AD
	YxHj/IViBVYkM6z3XrDtS+Puqjholk7p6GAkWuDPcNBMDV+/8DRgGcwaeNiaSRA+BAGHkoGX3s2
	3LPqofFj72Yfc8LuTVYBiJWyAgVqtqapdde+8s0kB
X-Gm-Gg: ASbGncuu0/PpR2PFWyJnj6GtvWscwDU2U8gy3iujPJP7NO02RWwgKqWbfeGWDzzE6Nm
	nIgjFf4OY9+lxUpiTdmQZCkO8g2i7hFJz9mpgcvrGQoq+ENn8Auhdjr2rFRIUa8/4pyLx86JuFB
	K5F4pv3DE+pMoKjhxZdmrqPA97Gmpl6Rxl6BklK0HjVEuWfj3hLoqsy0fPpuEXEL9Ch9rS0K1QK
	0Bqtsb7FFvvzrLU3vhY+KBWCz0hPsR6KmxUorBgDqMSE1grqP2MOjm4DI/f8Rko0vIvxVUgnJYF
	f8+AYNMbuGkpisrSRRLuL24Af6NCTMhWDEgh
X-Google-Smtp-Source: AGHT+IH6DHYh5JGECWdcVzvp7S5ap1T6O/cn8UXunbhreDxsl8LmHrnS2J/ixs1h+fzDbLi5wwqz7t6wtPhDmSRVWys=
X-Received: by 2002:a05:6402:1214:b0:634:90ba:2361 with SMTP id
 4fb4d7f45d1cf-645548332cbmr14010a12.7.1763690752229; Thu, 20 Nov 2025
 18:05:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121015933.3618528-1-maze@google.com>
In-Reply-To: <20251121015933.3618528-1-maze@google.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date: Fri, 21 Nov 2025 11:05:39 +0900
X-Gm-Features: AWmQ_bns8KI6l0tdM1trjanOC4_BBHZiO9q6iBWK3rx6nXFmVOq6Vx-qDdkylFY
Message-ID: <CANP3RGeK_NE+U9R59QynCr94B7543VLJnF_Sp3eecKCMCC3XRw@mail.gmail.com>
Subject: Re: [PATCH net] net: fix propagation of EPERM from tcp_connect()
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lorenzo Colitti <lorenzo@google.com>, Neal Cardwell <ncardwell@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 10:59=E2=80=AFAM Maciej =C5=BBenczykowski <maze@goo=
gle.com> wrote:
> bpf CGROUP_INET_EGRESS hook can fail packet transmit resulting
> in -EPERM, however as this is not -ECONNREFUSED it results in tcp
> simply treating it as a lost packet resulting in a need to wait
> for retransmits and timeout before an error is signaled back
> to userspace.
>
> Android implements a lot of security/power savings policy
> in this hook, so these failures are common and more or less
> permanent (at least until something significant happens).
>
> We cannot currently call bpf_set_retval() from that hook point
> and while this could be trivially fixed with a one line deletion,
> it's not clear if that's truly a good idea (would we want to
> be able to set arbitrary error values??).
>
> If the hook *truly* wants to drop the packet without signaling
> an error, it should IMHO return '2' for congestion caused drop
> instead of '0' for drop.
>
> Another possibility would be to teach the hook to treat (a new)
> return value of '4' as meaning 'drop and return ECONNREFUSED',
> but this seems easier... furthermore EPERM seems like a better
> return to userspace for 'policy denied your transmit', while
> ECONNREFUSED seems to suggest the remote server refused it.
>
> Cc: Lorenzo Colitti <lorenzo@google.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: bpf@vger.kernel.org
> Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> ---
>  net/ipv4/tcp_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 479afb714bdf..3ab21249e196 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -4336,7 +4336,7 @@ int tcp_connect(struct sock *sk)
>         /* Send off SYN; include data in Fast Open. */
>         err =3D tp->fastopen_req ? tcp_send_syn_data(sk, buff) :
>               tcp_transmit_skb(sk, buff, 1, sk->sk_allocation);
> -       if (err =3D=3D -ECONNREFUSED)
> +       if (err =3D=3D -ECONNREFUSED || err =3D=3D -EPERM)
>                 return err;
>
>         /* We change tp->snd_nxt after the tcp_transmit_skb() call
> --
> 2.52.0.rc2.455.g230fcf2819-goog

Perhaps I should have sent this as an RFC, as I haven't had the
opportunity to test this fix in the full blown environment where we're
running into problems.

I'm hoping to at least get feedback on whether this is acceptable
and/or even the right approach -- or if someone has a better idea or
if there's some fundamental reason we cannot return EPERM here.

