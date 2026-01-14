Return-Path: <bpf+bounces-78884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 057BFD1E9E6
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 13:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 78C5D3017F9C
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 12:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84EB397AB1;
	Wed, 14 Jan 2026 12:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5Fh3b9/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D6B396D12
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768392106; cv=none; b=cfHusav+3LrwQnd/UhYUykBBA1PJeTP0awxIwuPW2LkIjpXDVSKxWrwVpWCt8vv8rma6TKF+iwNgsL1pBBXuTdPWv9bwk9KakD4RKS0ZEIjgSCq+KYoTAbpn7cMWbpKDwkaeu8WYQgzXZ6/jSPoZ03k5b1amJrRq6G4SWW92anI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768392106; c=relaxed/simple;
	bh=z9jk+o4mdAYdNmtJgSJSqtJIdlOMC0fhl4qH1ZuC0+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDQV0sXIJsYZwLqBguUlcH2dzbmMpcLJ3XAm9fhTHYlO4HO0gX3sbsB/UEyiTUU79VaxILZ/diZZn7yAG5eb8yfa5/jTi1XnMavORmPjS3uCg69wukb/XpRf4AAlsQ+DGbdMXFUNfwj0+ejkuwj+8p2xFexLQmNyG+IV1lAc6Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5Fh3b9/; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1233b953bebso140008c88.1
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 04:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768392097; x=1768996897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9jk+o4mdAYdNmtJgSJSqtJIdlOMC0fhl4qH1ZuC0+A=;
        b=I5Fh3b9/rDe0XZ2bOy7PJ9ZvW8z3ENq4j36uYp3BxD0wyMqr4hBgEIPpEP0AbxF3XH
         yPqMJJbGNuy7Om6C6aLmU/ilSBxM6p14gkPfG7XrAaUnWTzFTvzB662XJuCignxitaOF
         rcqMUBwyF8FHf8MkUPEOXj3nfkM/cd/LL8eQLkLGFTegoKx7OQh6Q2fx5jBrNXlgSm81
         A7fA4sYsllIaNWYiR23AbzPxScETOGI69aAuEL4Fuuw9RZ9I4Fbh9hJ8PAHD0RGP/cqc
         3D6XFs/nQMkdVsMaR630ayyuHiwDaR2yW0puyJVLpDF+20wwStvS7ldlbasy28Au92zA
         lvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768392097; x=1768996897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z9jk+o4mdAYdNmtJgSJSqtJIdlOMC0fhl4qH1ZuC0+A=;
        b=Rhlf6gwgroinP8wGA+De5fBvM93E3h8foblzXJZeQDFZMPT1hsagdF89KwuL5igYmc
         mm6x9wLwpKGTIeyWBdoGIYnlEU+dBUa8dXkkypYtUjwHgnCxehEyVFtLQMJKO4ElT0Hz
         Buf8Z7DKvdwyrXNlclja9TkbNXUTAww/YpSL6VL3wp1sjQDJnxfldz0QlkRuwqkrmdCs
         Q773x3y6fShM9+iAyJWNf8CMyBeKdzB9madKW1AHDWOOqcFT+uxqu0HQ4ogCLMEX1QoJ
         HfWGE1wACktyODyikwQTiJRbAL3mmRm+PZDPO9ETPfvc6myPtzTJ8deLjERd4He0+DWY
         jS3w==
X-Gm-Message-State: AOJu0Yxl+Ld703drz/80ma8J0iMCqEIKUL4SxucVXBuv8Hnc1bOMDS8j
	BdSSCJ940gCy5soO97Z3hSeuMrw72CapyIDNXLNPKi+DT2yCT6CADjL56parjyO/aTYdRiUzYlN
	SShFohjJajgwv1+8R5RN2Q9UgiYwoZQ0=
X-Gm-Gg: AY/fxX5SCIl3TufivfAbVX6GgpTdsBz/8f1JiBuajWAi72j0FKHwGkg/K3/oCtY8sD3
	AwkDMjlB+Cs0jKEVkUhtRwvI8epOuCxT0f7vecrJRUn+0GClNIX4IrSVTyHw6cTQzkgFPDv7jHJ
	5ach6zGf94qwBMmh2lLfH/Sc1LFuskuUVAiDxF4WleDoaeZ5FKuiSmfAvuRz2iOlCK9RurDJAiq
	QYLCLvEklNNllVLaqGnTaK4IMfZ3Rx6MFFvMapdqjES2l+fnLqz5TYg2euAbECOC/gxRUZO8vbS
	r9tIsfs=
X-Received: by 2002:a05:701a:c94a:b0:119:e56b:c73e with SMTP id
 a92af1059eb24-12336a15cf9mr1986570c88.3.1768392096540; Wed, 14 Jan 2026
 04:01:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114060430.1287640-1-saiaunghlyanhtet2003@gmail.com>
 <87h5so1n49.fsf@toke.dk> <CAGF5Uf48mRAuUZpTAGCGQtveDoDpF_1SKXFoBECqYzU4+dVwwg@mail.gmail.com>
 <87bjiw1l0v.fsf@toke.dk>
In-Reply-To: <87bjiw1l0v.fsf@toke.dk>
From: Sai Aung Hlyan Htet <saiaunghlyanhtet2003@gmail.com>
Date: Wed, 14 Jan 2026 21:01:25 +0900
X-Gm-Features: AZwV_Qhu5tei1ty2iQZIrCW0s6ZLZofeQXrrVLB2j11oX0iZ3zsna0P7VxhCkho
Message-ID: <CAGF5Uf7FiD_RQoFx9qLeOaCMH8QC0-n=ozg631g_5QVRHLZ27Q@mail.gmail.com>
Subject: Re: [bpf-next,v3] bpf: cpumap: report queue_index to xdp_rxq_info
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 8:39=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:

> Yeah, this has been discussed as well :)
>
> See:
> https://netdevconf.info/0x19/sessions/talk/traits-rich-packet-metadata.ht=
ml
>
> Which has since evolved a bit to these series:
>
> https://lore.kernel.org/r/20260105-skb-meta-safeproof-netdevs-rx-only-v2-=
0-a21e679b5afa@cloudflare.com
>
> https://lore.kernel.org/r/20260110-skb-meta-fixup-skb_metadata_set-calls-=
v1-0-1047878ed1b0@cloudflare.com
>
> (Also, please don't top-post on the mailing lists)
>
> -Toke
>

Thanks for the pointers. It is really great to see this series. One
question: Would adding queue_index to the packet traits KV store be
a useful follow-up once the core infrastructure lands?

- Sai

