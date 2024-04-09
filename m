Return-Path: <bpf+bounces-26264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E877489D5FD
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 11:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71423B22B5D
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 09:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCC18003B;
	Tue,  9 Apr 2024 09:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yz7vnSYM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438717FBBC
	for <bpf@vger.kernel.org>; Tue,  9 Apr 2024 09:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712656332; cv=none; b=P5mA0rYtQ1quyADvsmJVZkY88P3uXlydt5DdNJgYXN7dfivxG6jV98k3YEW4OOeSCW0k1vHT8kVpEwFTP1mfScFWPCpb+KPPeTRc07sLcXAuoBpyycLUdWgi+hlONNc3JXBXxuptoXR2293JLW5rcXxLwd8FmnOqSJLMFOOjXU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712656332; c=relaxed/simple;
	bh=SFMeeK94Q1RLmkJcLV5J5xcEE/ViAMCF0V+2XlZMrn4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qHyg/FcvmvAMD4Js8bWp6cQxef1WKmEl3EBz9O5sQr5Ym4KLLwt+l9+M1SIX/k5IT9iy1hn/wRTipMwWdAde2Zwz1SKhSqtYD9S4VRN90j9+vIUnh4DSKvSMPTHgSSCVP2/rbqqhcbhJrwoQSQJLWjhEs8Ze8vcP6WzutCb9MeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yz7vnSYM; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46ea03c2a5so899527966b.1
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 02:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712656329; x=1713261129; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LZwtKOfpmvkSTGGhwKzgjM+Ga62zAyrYrU3UCAr0048=;
        b=Yz7vnSYMI/BLJxfiopDGUEE6kreXNGaRLvqy/ixk5PB2W1wDRUh1ugrNbI/g2wnSLA
         Aigwmh7qCco3I1InUytk9Pc18LZcjMg5yabT5tWAnVo+y8R9FwKb8IFf7OUriLl6OS2B
         btn076gSY6WXZDa12eTUrERjFN+rcIAwoLVNlt44mS0/sddhy0ERMzZBNR5zAwuejk6o
         SyNHl2YNhG+mMn37TdOJpHIYxDLu5tG/jAqoAGv1U+6vdxXeb1dPp2Nk98EeXA0vX/O1
         2JhL25ztEPde91EtF6VSjuBgjjTSqLPRWgcQU5LEJPf+A4/jypm4poWO6FpU4CO/H3/f
         BRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712656329; x=1713261129;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LZwtKOfpmvkSTGGhwKzgjM+Ga62zAyrYrU3UCAr0048=;
        b=BdcaURiuGsm6kMnuUzS/v7VcODw+QEXE9gRsLuIIO5lhZLlNF64nGxCuZctZRARjHm
         BzIqjqSGIDRyF0w0Midt7o5O28Wu+dPqn0pcuu0p9dLIZXEacV6ftvdlzmLhgauWe4q2
         vWGkfyAwve6KT3pGOVUcxVKp5Q3atvsZBFe68Cax2hWpqKtpAPI8VLbgdl3BMcKiwcFk
         uCLaEV5qoh/Hv2BnMhQmHeSXZr8IfOCF0nfrTdPvrTCtG1HqDcUb0lEuZ6+UKZC96cBj
         AXS3LsGG8BdfYVj02XTVD02Tg6q4dbVbEWukIVh4AKYP9qKmDTQuFNwntLnGDCBdZlUe
         f7lw==
X-Forwarded-Encrypted: i=1; AJvYcCWJnfzkdHb0aYi2FEW0IuyxfiCczT56HWwDQoZVckW9EezIEblq6Kur+pbBxEJasYn+NJNPsu3qFkDhs2NiPLMuZZWV
X-Gm-Message-State: AOJu0YwBuKxsWMmjwNvNNMisSUzYmwRPlUaLzgH/Oq0UqdHqZ9bKGa4s
	LyPUt/tuT9E22Rbl9GgBDX0/hSV5wJTOzts0d+D4zXRU5mjZfD9K
X-Google-Smtp-Source: AGHT+IHnK32FtrC5VbJXwqiTU0UTukB1EkZEEjqnYy2W4LPkbQy19dTm9ANOAYOy9R1IfLTRr+5bsw==
X-Received: by 2002:a17:906:ce4b:b0:a47:3766:cfec with SMTP id se11-20020a170906ce4b00b00a473766cfecmr1937164ejb.9.1712656329373;
        Tue, 09 Apr 2024 02:52:09 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id v20-20020a1709063bd400b00a473a1fe089sm5501963ejf.1.2024.04.09.02.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 02:52:08 -0700 (PDT)
Message-ID: <b5df14d028562c863e65c27af82250c14395f513.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 1/5] bpf: Add bpf_link support for sk_msg
 and sk_skb progs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Jakub
 Sitnicki <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Tue, 09 Apr 2024 12:52:07 +0300
In-Reply-To: <20240408152431.4161022-1-yonghong.song@linux.dev>
References: <20240408152425.4160829-1-yonghong.song@linux.dev>
	 <20240408152431.4161022-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-08 at 08:24 -0700, Yonghong Song wrote:

[...]


> +/* Handle the following two cases:
> + * case 1: link !=3D NULL, prog !=3D NULL, old !=3D NULL
> + * case 2: link !=3D NULL, prog !=3D NULL, old =3D=3D NULL
> + */
> +static int sock_map_link_update_prog(struct bpf_link *link,
> +				     struct bpf_prog *prog,
> +				     struct bpf_prog *old)
> +{
> +	const struct sockmap_link *sockmap_link =3D container_of(link, struct s=
ockmap_link, link);
> +	struct bpf_prog **pprog, *old_link_prog;
> +	struct bpf_link **plink;
> +	int ret =3D 0;
> +
> +	mutex_lock(&sockmap_mutex);
> +
> +	/* If old prog is not NULL, ensure old prog is the same as link->prog. =
*/
> +	if (old && link->prog !=3D old) {
> +		ret =3D -EPERM;
> +		goto out;
> +	}
> +	/* Ensure link->prog has the same type/attach_type as the new prog. */
> +	if (link->prog->type !=3D prog->type ||
> +	    link->prog->expected_attach_type !=3D prog->expected_attach_type) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	ret =3D sock_map_prog_link_lookup(sockmap_link->map, &pprog, &plink,
> +					sockmap_link->attach_type);
> +	if (ret)
> +		goto out;
> +
> +	/* return error if the stored bpf_link does not match the incoming bpf_=
link. */
> +	if (link !=3D *plink)
> +		return -EBUSY;

Hi Yonghong,

Sorry, this was a mistake on my side,
this needs a 'goto out' in order to unlock the mutex.

Thanks,
Eduard

> +
> +	if (old) {
> +		ret =3D psock_replace_prog(pprog, prog, old);
> +		if (ret)
> +			goto out;
> +	} else {
> +		psock_set_prog(pprog, prog);
> +	}
> +
> +	bpf_prog_inc(prog);
> +	old_link_prog =3D xchg(&link->prog, prog);
> +	bpf_prog_put(old_link_prog);
> +
> +out:
> +	mutex_unlock(&sockmap_mutex);
> +	return ret;
> +}

