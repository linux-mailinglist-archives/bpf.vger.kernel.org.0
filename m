Return-Path: <bpf+bounces-39475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81630973B92
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 17:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35241C20BC1
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 15:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE839199FDB;
	Tue, 10 Sep 2024 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdOhLs26"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD999199E9D
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981725; cv=none; b=iqaWVHD1yf4wM97rMP8RVdRwlc+Hn48x7qTe4XwzeWwb1tUoB9JLo32U/mQ0AkiOAZ9FPzWdAzO4MG30QWXkwjA0j5dzg4Gjifa8eNJHDli23eq0Ajgo6mQ79NP7k8p935hV01YvrxTRUWpLPOKjtDHC2FL92pe0EzlTsAFuxyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981725; c=relaxed/simple;
	bh=YVaJCbmwqZ9T+Vn1A8wO0tO+3GfLpuBr5gMHx+2u7fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=afhUHKxkL648/ae0dOjfzVa7Jm1oa5SAbpBnm6R5/Rj6KkohjNgOmfbENIYeL6/5fQoLa2+0yxUIcmJQRTDPv05gh1ijoHg42EHG1u/EH01kHyQsuh1gTxYlaXn8HoYxHUxV0Ln6nVl4JTOXjScXjpc33AM1zXwcExHNocFs6p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WdOhLs26; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374c7d14191so3735421f8f.0
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 08:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725981722; x=1726586522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eztpq4LSwyqv96pfc0vrmH5u/rGMn1L8U1YkPeb5UqY=;
        b=WdOhLs26xqGqjHzJHJ/94YDD63dHdbtnxcdRPyAu6qeEr7duEZb+RJJ89tXQAlDIZL
         K6ONgo6NXZKbM1kxfVqhNXNcqlRxHJMT+jEXyiWbGlR2SFiqOII9oG+2pxRkvh5JLJC9
         hIMc4ASoOY1KouikZZhdO9lYiQOfjmgnsG/dLRLyuN0AmBYwLG4yGoXQd34TLw45qj2J
         +APSH24qgmnkzcCL6Bv12R3JxH6IFnI/CrZGO0jwpFRODfGT2rmUvl04pWxIm7CixUMy
         7hr2lIH33WtiPD1U1g2kD39fCfaQfTTE5wkzs+aOpN/zGAWR0an+jZlHItyrxrJ4YxHK
         qZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725981722; x=1726586522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eztpq4LSwyqv96pfc0vrmH5u/rGMn1L8U1YkPeb5UqY=;
        b=WGmoscUpmYPJ+TNc0iVhsDqu2ZkehenJozMVJLpl81X2lEsgdSnQ1iep8fcXM/BXXy
         7cYhqW6areTwuxkxqOUmaH1ck12cI1px6QDQVqZCdk2NzAPfwrxsyqNrM90IaX/ZjhBq
         mse5DFBNmSFQHFEK9djLjENlk/iIjzn8gXhKG2psfTfa9eBq9p6VETza4XWziLf+/8tl
         t3K+IAE9RIWWfy9ogQGLONornz8j/R/WZXUXph99WevWEPHBX+ydB8rMynvwSVO7BF0p
         iWtAJWtRMrSrr5BxGYmhFqY5t7GbBlCsUKvapu1ZVNEFLq2l697ODq6cpoILj5MlY9Oc
         KSxA==
X-Forwarded-Encrypted: i=1; AJvYcCUj6SvkVgqPPiIeVpREK7wh8O1tNx6qMpcVG93m74JcUrUsD/Y2EkcISdh+FEiOtP2Zjyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt9ztkHLAtrHeWZ6n2qF3AYGHbtmqfaZj3UXZ2MbkxoajTgdSa
	Am8hIi1gN/0hBxluVp4HwfX4yM1XfAQM7PgDly9/kmuugb89ZjDC8Uq41lBpfLF+OAqPepsKcBR
	/Xd2xxk7IYpTqvapt+91pkfbgiUI=
X-Google-Smtp-Source: AGHT+IEVue2OWwly8zTlWbTLYdXLEorJzw8v/qKQTnVjwjnkVijv5CSmAc/aWq7/lFnFMVAzPjPK6CtGdEckV24Yruo=
X-Received: by 2002:a5d:4ec9:0:b0:374:c4c2:5ad5 with SMTP id
 ffacd0b85a97d-378a8a792fcmr2204948f8f.27.1725981722274; Tue, 10 Sep 2024
 08:22:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZpAaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=@protonmail.com>
 <CAADnVQ+o1jPQwxP9G9Xb=ZSEQDKKq1m1awpovKWdVRMNf8sgdg@mail.gmail.com>
 <1058c69c-3e2c-4c0b-b777-2b0460f443f9@linux.dev> <18d101db038f$f3c2d400$db487c00$@gmail.com>
 <ff27a7ba-e3b3-4cd9-85a8-55c10756df5d@linux.dev>
In-Reply-To: <ff27a7ba-e3b3-4cd9-85a8-55c10756df5d@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Sep 2024 08:21:51 -0700
Message-ID: <CAADnVQKNG-EAv6t-CuCWCOX-Tm9=b6fHD3bwWgJirnQ93V=tzw@mail.gmail.com>
Subject: Re: Kernel oops caused by signed divide
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Dave Thaler <dthaler1968@googlemail.com>, Zac Ecob <zacecob@protonmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 8:18=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 9/10/24 7:44 AM, Dave Thaler wrote:
> > Yonghong Song wrote:
> > [...]
> >> In verifier, we have
> >>     /* [R,W]x div 0 -> 0 */
> >>     /* [R,W]x mod 0 -> [R,W]x */
> >>
> >> What the value for
> >>     Rx_a sdiv Rx_b -> ?
> >> where Rx_a =3D INT64_MIN and Rx_b =3D -1?
> >>
> >> Should we just do
> >>     INT64_MIN sdiv -1 -> -1
> >> or some other values?
> > What happens for BPF_NEG INT64_MIN?
>
> Right. This is equivalent to INT64_MIN/-1. Indeed, we need check and prot=
ect for this case as well.

why? what's wrong with bpf_neg -1 ?

