Return-Path: <bpf+bounces-62080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC40AF0DBE
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 10:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E09C7AC77B
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 08:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F03238C07;
	Wed,  2 Jul 2025 08:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VdH64LJn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E96199FAB
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751444461; cv=none; b=bpkAmhtUCZoDXzpSt42bPqz8Z31Le3lf8rSLbTaXJBnX0MeK0Ys8/1zSVS2s4Y4qrs6xziq9y8QPAuP/OOjRq8yUtlZi8iwPefQItB7mPK7Eg/iq69JksczCh6B+Who2slAFPSPiSPQSCNF1ZxIXGgC2gUbD63FxeQGPXJ9xzu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751444461; c=relaxed/simple;
	bh=Q+C9Exo8ofEtZ9Bq0cmtU9VsyDIQZRmTfqe3V9gXe7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fCgvgrEyPrsfyzmqAB9+i2Iv9ypDOc+ZS0vTOiCew1v+WQmA7+q1zFcPmmm2PA6ymuxfnBmDslD5IPKy06LeR+kzof6x+U7mb1jVj6OBm57S9cx5BIQ1pf42q+6ACkblrnBCkaKvIqherj/08ki3z9PZ8Nl7+a/OqWz/W0y/Y+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=VdH64LJn; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so8712146a12.1
        for <bpf@vger.kernel.org>; Wed, 02 Jul 2025 01:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751444458; x=1752049258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+C9Exo8ofEtZ9Bq0cmtU9VsyDIQZRmTfqe3V9gXe7c=;
        b=VdH64LJnq9Jf3uYnX53eFMdHSDV4N4QuNo5CkfHBFm+mrbJ2WSvson82e5NI8sClII
         zIni/xXO4NL85VDf4VPIo0tdrl7XQSJg41BEshnNyUs/3LlAItzAOr+DgONkymKF+skd
         kDOI2HKl8pp8iR6TwfLjCh4EpveZwIk/7E8XPER179pPI8qrHI4j437HQstZioHvJy5i
         wolooNQioj24yuKgJK5yv3iZhYPaKIyCgsSkVsAxkTNRU0qdVOUOVgk/dnvyn0+VhFzl
         IahEmJucwokHLDEcFV7ZI1j9v7wb5KdU2xCuCl8oJCorcCpUrXAclmnHtJ28qSI8jzmo
         NStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751444458; x=1752049258;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+C9Exo8ofEtZ9Bq0cmtU9VsyDIQZRmTfqe3V9gXe7c=;
        b=ltnXEnSLWU7nBnW+wNmUfHjxfyivToCgcDMuFQ0kznoHHjcEmchKAkPxj5oBoawK4g
         Cp/PnEQUDd+ItAIDHpkQu4MzlG85/iFh/unZWR7sjFsiet1W4mQVMONKgXysN9l0Zzc+
         RDVlzkLmM2Gaf1CrbHWLNNp09nBQ3JE96lIv2Mv4xf7B5IQkK7/Qxd7oQ7L+nPmjGUY3
         sJ0oOoUFxFLBYzHm0LMJUrboZRpCfyrj/W7xbcsybTWNe0lB6d6prPA8O9hj6Xa3mhgR
         9488Z2F3VgBOXl1jdoaKgtOgR5Ysa2wC0kq3cFfPcldZrF6gJS1PpiT1SErGBHC50kF9
         +aCg==
X-Gm-Message-State: AOJu0Yx711a7VQqLsaaIvP7hwfTP1quPG3MV3uSWQm3yIJUj8OtXXZnN
	7mu8eDDMRMHG4FQmyEM18q53ka5/ppeuLivDtYLSS3iQE+1B0US4Prd/xka6oiTWj1o=
X-Gm-Gg: ASbGnctSNEchZukPry8m+z/gcf5B0SR4lykzHD3e0nq4NkRhU5mE8vOx1qj/DxMOzNy
	fjTetPILpKXJvrUP+S/I1UH7uA317flsf5atTNkMGnz+p7bt8kbPtHlMkcKpukT6BkzfwG+6c2m
	gURTRbtscorQSPR5Rl6fOzgHW5EXTrO0ppOWAPk5Rgo2UPAENPQcCcRhMI5mtG66pksSAWoyfXV
	sENHqWgxeeoA3/0aYZA9vuCX+6I67+POUXlfjWaNlMXGLanNe1gm2X0lpMSeNOKoG3gDvGW1sca
	c5NvPduvT7R23j7gZvKI3yWChfTJyySqOaf2fWakhnvim5ziY00BiqY=
X-Google-Smtp-Source: AGHT+IHB/112UNmwfsUeLQvKJlN3Wat7wE2v9dYNO2s1LNzvdZgBEsvS4PNyHTKZyMNjv53evbCYVQ==
X-Received: by 2002:a17:907:1c28:b0:ade:409c:2cb6 with SMTP id a640c23a62f3a-ae3c2e70058mr189921066b.59.1751444457889;
        Wed, 02 Jul 2025 01:20:57 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:e7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca1cb3sm1030803466b.157.2025.07.02.01.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 01:20:57 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Arthur Fabre
 <arthur@arthurfabre.com>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Jesper Dangaard Brouer <hawk@kernel.org>,
  Jesse Brandeburg <jbrandeburg@cloudflare.com>,  Joanne Koong
 <joannelkoong@gmail.com>,  Lorenzo Bianconi <lorenzo@kernel.org>,  Toke
 =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <thoiland@redhat.com>,  Yan Zhai
 <yan@cloudflare.com>,
  netdev@vger.kernel.org,  kernel-team@cloudflare.com,  Stanislav Fomichev
 <sdf@fomichev.me>
Subject: Re: [PATCH bpf-next 01/13] bpf: Ignore dynptr offset in skb data
 access
In-Reply-To: <CAEf4Bza_=HUKT6_sxrO=xC37DGyTgnvKtqd9Zdmq-crbtdTYSA@mail.gmail.com>
	(Andrii Nakryiko's message of "Tue, 1 Jul 2025 13:55:01 -0700")
References: <20250630-skb-metadata-thru-dynptr-v1-0-f17da13625d8@cloudflare.com>
	<20250630-skb-metadata-thru-dynptr-v1-1-f17da13625d8@cloudflare.com>
	<CAEf4Bza_=HUKT6_sxrO=xC37DGyTgnvKtqd9Zdmq-crbtdTYSA@mail.gmail.com>
Date: Wed, 02 Jul 2025 10:20:56 +0200
Message-ID: <87bjq3nguv.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 01, 2025 at 01:55 PM -07, Andrii Nakryiko wrote:
> On Mon, Jun 30, 2025 at 8:23=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.=
com> wrote:
>>
>> Prepare to use (struct bpf_dynptr)->offset to distinguish between an skb
>> dynptr for the payload vs the metadata area.
>>
>> ptr->offset is always set to zero by bpf_dynptr_from_skb(). We don't need
>> to account for it on access.
>
> Huh?.. What about bpf_dynptr_adjust()? This is a wrong approach to
> have some magical offset values.

Crap. I'm not gonna lie. I totally missed that.

You're right. It completely breaks down.

I was hoping I could piggyback on skb dynptr, but doesn't look like it.

> More general question about your patch set: is there ever a need to
> work with both metadata and data as one area of memory (i.e., copying
> both metadata and data in the same single operation, or setting it as
> one thing?). If not, why not have two different dynptrs, one for data
> (what we have today) and one exclusively for packet's metadata?

Having two dynptr kinds, one for payload, one for metadata, sounds like
a much better direction. I will pivot to that.

Metadata and payload are logically separate, AFAIK. It just so happens
that the metadata is currently located in front of the payload.

I asked around to find out why is it so - it seems that the decision was
made to place the metadata like that becase it saves you one additional
pointer load. Otherwise you'd need something like
__sk_buff->data_meta_end to marks the end of metadata.

