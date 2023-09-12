Return-Path: <bpf+bounces-9845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE99179DCE1
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFEFA282042
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C6114002;
	Tue, 12 Sep 2023 23:53:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EB8BA33
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:53:42 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE3F10FE
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:53:41 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-502d9ce31cbso562481e87.3
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694562820; x=1695167620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28dDDJ4HtYPFgUJ0kAgxAXWhZkF+VGlLTa8knvjpdrE=;
        b=LJKJ07UjgASTOMGKacmHbxLn+QAaWG0dh7/fDsAs4l7G6aaR/C2iQR1wHOUKKEb26f
         lYFGEZKXet8uc7vxMunQlztZrSELEpryqVCguYgKnHtF7Tu3zndV8G1x9ocaK5HNTZBi
         iRBy/i1r8RNnXOu8Dc525CMbtTekL8VRivDSOhQam3tH1K0AtesWl8/pvoEMnyy3DCRX
         oWY7OwPYits1j+t7YItrZo4Uq5XlO19LfVeD74Pxv9gOdIJwRYRzq5OOH3LCR+/HQeDz
         UcqztkRXi7YPgkrge4mSfnKxviNAdec0Le7I+AcWjRNlpzBJaUGtHha1BuzsWjLPv4Ms
         swuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694562820; x=1695167620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28dDDJ4HtYPFgUJ0kAgxAXWhZkF+VGlLTa8knvjpdrE=;
        b=X3NW2SPH4ALXdMxGSESGPpWGPrba/JEgff2ognkcvjGyppYggO4yNFTZzLwlUbgj70
         uzGyyMjz02t0Sp4jIQ1/s/0CaLuU+asbwzkbm95hOe23Z66o0YeaKfjcIU9eo0/4fhXU
         9Wmt5r8Yz/6MEB7Tj8jWHrSfefVAOUQ1Iy9uWEOCraO8q2Nu7xaIwWtn2KVPHSp8X/KA
         pnIK7MpbzN/mPrN9R1ZmknHsEGAgm42ODUzqIfR4R3RZKc0IYvpMkXhX90smTercSaSA
         MGc+a0jDom2pNBWUGfXrvm5ijqm0jndGI0u8hhl6yUcvO38NU6GLjdSP+TV6Ikp1O2KE
         ey5Q==
X-Gm-Message-State: AOJu0YwG4qU5glo+euqPFi1V9nJr92bFxI9dnE2iOvorq3A91r6H7TY8
	/ZTLVBOgkBqlwY+9IQnbCafX0ehWesjmqxXxwfI=
X-Google-Smtp-Source: AGHT+IGvqqOp1EMIV1FTcF9qBEyva15tzs5EtVixjWVTb43XcDlynM2SFX6lUTTSCgPkav7MeO+yrV2TgRAZ5geP2MM=
X-Received: by 2002:a19:8c4c:0:b0:500:b14a:cc63 with SMTP id
 i12-20020a198c4c000000b00500b14acc63mr725518lfj.12.1694562819578; Tue, 12 Sep
 2023 16:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912233214.1518551-1-memxor@gmail.com>
In-Reply-To: <20230912233214.1518551-1-memxor@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 13 Sep 2023 01:53:28 +0200
Message-ID: <CANk7y0gsZb1EyjB251rE2MrvHv728_JPQBRF_yTNw2Ps4zEXfg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 00/17] Exceptions - 1/2
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 13, 2023 at 1:32=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> This series implements the _first_ part of the runtime and verifier
> support needed to enable BPF exceptions. Exceptions thrown from programs
> are processed as an immediate exit from the program, which unwinds all
> the active stack frames until the main stack frame, and returns to the
> BPF program's caller. The ability to perform this unwinding safely
> allows the program to test conditions that are always true at runtime
> but which the verifier has no visibility into.

I am working with Kartikeya on enabling this on ARM64.

Here is the patch:
https://lore.kernel.org/bpf/20230912233942.6734-1-puranjay12@gmail.com/

Thanks,
Puranjay

