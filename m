Return-Path: <bpf+bounces-71895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C11C00B0B
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 13:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC7B84E756F
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 11:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BF430DD05;
	Thu, 23 Oct 2025 11:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biB1smbd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE5E307AF6
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218463; cv=none; b=s7ScARipnPFM/nvhs7rhmXSIKxrij9t43kSyz5/1ix+PIXPlFI6I08RVUcAse5W34ozaY4hs2uA2UBwEr7qFGfUyXOjczo2Eai/e9Q9aaLGphq8FgeRPaUCDVLFVn0gH/hofHj8eMFzQTq+CPQTwSFzXG4iXQPmf6jZJu+DTWjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218463; c=relaxed/simple;
	bh=q/qJpLLyrX5Nc3Q2omEC8YYlMcA+3Kq6qylaMFQ9vec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YG1zyM1hB0Xw+s67HWAr//LGMt1UIiBtdtEMdV8wmlCylTvHXo0/4xQA3Z7I+ffKnzfzjHO8EwHHaUrbNrzDubYnA9RnaibUSMekzhlXPulz7tfq64gIHhBrSdy/cNwE8vvTTDry52JepyFbxJWVH3ZbMnnA4S8OOA62LtjF/bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biB1smbd; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63e18829aa7so978221a12.3
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 04:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761218460; x=1761823260; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20wqx529NmUv2TAIjzcQAgielck21eRDYr7Trm09NWM=;
        b=biB1smbdAHigm7WVn406+ivwKctGXaLBdP+ux3WLCTqXpZW+TvcGRBR6+moUScJsZT
         CyojP3Yn16p3If6c3HVl7uKm6xT3NKwaH5WvgbDF6XKdG9WDj5/qp2VZbmusxKMvaBrj
         3EO7+zs7aDuW3tObZf27W6GIWtqBHjJnVUd/eU5mkWTKZfv2Tx7izMj2rddAvjqiUu8b
         hoLHuzIP429lsVbhnT3Kctf0IZ/PhSuP94luWrpB57CNTSCTN1anWsOS2gxgvBJmGw6b
         Y0C2xTV2XCequKK++GOfFHZ0bZi493hjxv3hsAIfVe9pyH51VrbNObp2VkoIt4Mkl4kU
         Quwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761218460; x=1761823260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=20wqx529NmUv2TAIjzcQAgielck21eRDYr7Trm09NWM=;
        b=lYL7iVahR2J3j7D0+C61APRJlTrj3eUPeKpfL+5psrxQI5V3az7gbPQRD6oHIglk8U
         04YjjHAnr9PrVSi++dq7S7UZYdBVuDgbcJFpVPQthevH1Vy7YzeJftE8telf+749GybL
         5smpEYNuvzdmOXcNOe3I3r7AIdMGkxBHU9fUZVmGghGqcrHIlF/XwYdovVw98Zey7PCv
         MEqpd26Yz3rE8h58LislwF6PLtXMVE1E89uMOMtj5JxNWDrjN5oxLHaU7qFZYnGE4E/N
         iEWkhA0erjglooRiF3icIOhevx46gNX0X+7o3Ts9S4p+d7HOBnAd8JK36683pwprjjg8
         iBxA==
X-Forwarded-Encrypted: i=1; AJvYcCXUCekHfq6q4mKzh4it4iF3wvMHbS9cwvf7nTNdlTDS7/PlzRVesscOttVZ8aFZZpuPyME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn0mfsVtmp6C9TdIIaW7/5FmaMa2w4U7V/i9XIVQQspTFO46Xg
	mVjJV9QVTIYqOgbkKVgx3pEtJAinyRY0sDAuKqdf0znYbKdajYcvbytg5xd9OFPvxhht8GBiPZ3
	inLLptWScbvbvXu8jpAkE2s87Xv7cgJ8=
X-Gm-Gg: ASbGnct601kRDIVjsaw5FgSEXkECzcv5hS5JoR7n0zdFhgTb22FYJYDvqJfqfpun0OP
	czkT9tX38B1aZ+oBAWwM+FyK6m6VfOAlWqt4e3//xKGV3AltQVtTwSE+1ksCXJQxHyS8oMtstGZ
	4HJikpb1NfpXeIIWDC5DEpJlBeLuoXPdKFeF1tk4Mhm3McH2q0BjykJGv+bZaQA8zk3R9ZQ381n
	9LmWoxFDMHuNRcDiVGfqZa2WVzDf3ntZ6RV080AB2QFKp17mQtC48UjPQUsL0CXjSZUXu/l
X-Google-Smtp-Source: AGHT+IECMTs07V+C8/F4VRvVGlIMJgQ3W/ZfLjGZF9KufbRJpag6/hAomvYZxGBIvmY1gHksfnM+tDSbC1u/macZLbM=
X-Received: by 2002:a05:6402:2791:b0:63e:23c0:c33e with SMTP id
 4fb4d7f45d1cf-63e23c0c43amr5617590a12.27.1761218459828; Thu, 23 Oct 2025
 04:20:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
 <20251020093941.548058-5-dolinux.peng@gmail.com> <ec7ecc7d47540bba04f6a0b7e0cf74f4ef7a84bb.camel@gmail.com>
In-Reply-To: <ec7ecc7d47540bba04f6a0b7e0cf74f4ef7a84bb.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Thu, 23 Oct 2025 19:20:48 +0800
X-Gm-Features: AS18NWD5siYzpgEti8IF-bhopY-X3-rGAw9ck7MaAicD2GKSDf0VbnqIZZ8PYa4
Message-ID: <CAErzpmt4ju_YhNm5CiZqDc_o12jOhMwDA0bNkP_ZoYUOJohhDg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] selftests/bpf: add tests for BTF deduplication
 and sorting
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 3:07=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:
>
> [...]
>
> > +{
> > +     .descr =3D "dedup_sort: strings deduplication",
> > +     .input =3D {
> > +             .raw_types =3D {
> > +                     BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, =
32, 4),
> > +                     BTF_TYPE_INT_ENC(NAME_NTH(2), BTF_INT_SIGNED, 0, =
64, 8),
> > +                     BTF_TYPE_INT_ENC(NAME_NTH(3), BTF_INT_SIGNED, 0, =
32, 4),
> > +                     BTF_TYPE_INT_ENC(NAME_NTH(4), BTF_INT_SIGNED, 0, =
64, 8),
> > +                     BTF_TYPE_INT_ENC(NAME_NTH(5), BTF_INT_SIGNED, 0, =
32, 4),
> > +                     BTF_END_RAW,
> > +             },
> > +             BTF_STR_SEC("\0int\0long int\0int\0long int\0int"),
> > +     },
> > +     .expect =3D {
> > +             .raw_types =3D {
> > +                     BTF_TYPE_INT_ENC(NAME_NTH(1), BTF_INT_SIGNED, 0, =
32, 4),
> > +                     BTF_TYPE_INT_ENC(NAME_NTH(2), BTF_INT_SIGNED, 0, =
64, 8),
> > +                     BTF_END_RAW,
> > +             },
> > +             BTF_STR_SEC("\0int\0long int"),
> > +     },
> > +     .opts =3D {
> > +             .sort_by_kind_name =3D true,
> > +     },
> > +},
>
> I think that having so many tests for this feature is redundant.
> E.g. above strings handling test does not seem necessary,
> as btf__dedup_compact_and_sort_types() does not really change anything
> with regards to strings handling.
> I'd say that a single test including elements with and without names,
> and elements of different kind should suffice.

Thanks for the suggestion.

>
> [...]

