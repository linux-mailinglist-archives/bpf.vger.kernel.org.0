Return-Path: <bpf+bounces-39336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA594972110
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 19:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F7EFB23F3F
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 17:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B131417799F;
	Mon,  9 Sep 2024 17:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRWg58FO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD5817F4FF
	for <bpf@vger.kernel.org>; Mon,  9 Sep 2024 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903000; cv=none; b=PVyflGw917d8zEgTPkOCVFA3jb/JsSxI6RFL4wix1NvfezDlLwQWpK7HmBaUiDc7GFjNeeAlLmhQXnUKngkWyyK7Sd7KEdAz0nMLIAc+CuWg8ythW8LmoWETSYZBh+BrN705iVcmP2SiEqZlNLBgOC0QzX1q7ANf8XbSeW2S1hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903000; c=relaxed/simple;
	bh=vLyUVkFUyH30TdEzbFTfcu68uyxDOzRUo86l9l52zvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=so0kpOukJU3ASDHSM55PyfYiVXvWkcI46OltVLX9XJNJagjfbn5/eHlGpx4ho35uBnGLTW6p92pDWC+OHGAfC/D8VejGit/kcqvKJ5U4OdmHvoS0cTrdaoH3TjF/M3WM12drLADaOCx4mOGJUQjO3qRkgngu5w5PmP67b+opZLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRWg58FO; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so39713355e9.2
        for <bpf@vger.kernel.org>; Mon, 09 Sep 2024 10:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725902997; x=1726507797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLyUVkFUyH30TdEzbFTfcu68uyxDOzRUo86l9l52zvo=;
        b=KRWg58FOZ6SwEwD+EG/VfRYcQ7/51mqbtuPB34oaQAouwdob/f4ubGzJzfzIz2Gugp
         KfO4nZSGEcwkOlJjMQEOMmelneqlZoGuBuLQEh3keBq0QY6CPpxdW44rEDMSNbNn+xqO
         JndK3Hmtv0wzCASjLK4vUzMdw6QfE22RRU4+JdaBMk3SY3lbvRzI3hrvLMaoHFkaG0Ps
         KGGoIl6cxpbUTNXwC3TndhSNsuFvbaXq9XfMqXuEp/rg6SP5neQt6gck2d1EQ1QDqLsB
         Jha1k0EPhjpi9YWuWtSTiX6GzbsS9MU+2+jplGTnEekl2LRM9jYNhUOot97a4JF2f34t
         swOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725902997; x=1726507797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLyUVkFUyH30TdEzbFTfcu68uyxDOzRUo86l9l52zvo=;
        b=OcR3GVJHlmVzDfMshKeIE2R2z/1IUty9ZlOKxh+PcgMeJ1A8VxCr+8NTE1i8vm91R/
         MKM0iQ3Sjc2PUu5U3kZ+6/q919DlLAhgWiZkU1QPxuMg2kq6gQTWtuCnZJpFszG9sp+9
         nV05XskcHnMjsnMoap+thiZ9NphTPbfK/zA7aVeJmaX8Nogfjkv3fTuEC58uH+ImiBw9
         NMdbCgZlnvM2yzQbsLqP55/Ahme7FGLm3bLcWu8m9pyU1qqLhfOaXglxulFxPoKuuwjU
         BGrEFC94jyt3uw8dxNtxnD612rcPOCGKsrp8pmrhLjx54JiEEttdQ6l8BBdUstQQEMGd
         WhpQ==
X-Gm-Message-State: AOJu0YxAcNmjqG2IxZqHGeqTi8znlTsM6iQxiF4UOVTpg0Eje82GyQwW
	He0ilt/1qSwZrHQDxNBQDjKZ2ABZDM5um2rCBM9XIW9QRciBdgdZbdoRSJWdklkbV8sgf/soTmE
	42l73whfLP+d01zEYRRpUo3dHtAvPKwAI
X-Google-Smtp-Source: AGHT+IGAtLX/2jhIpo3c7sy+ZV4oDO5lkzimS6DGX/46KVhAZQFjEB+W9hS9cHYf0AlkjMNwh9PDmVTaKLzpy1hZTZk=
X-Received: by 2002:adf:e550:0:b0:36b:aa9d:785c with SMTP id
 ffacd0b85a97d-378896c7cccmr6966263f8f.52.1725902996630; Mon, 09 Sep 2024
 10:29:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZpAaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=@protonmail.com>
In-Reply-To: <tPJLTEh7S_DxFEqAI2Ji5MBSoZVg7_G-Py2iaZpAaWtM961fFTWtsnlzwvTbzBzaUzwQAoNATXKUlt0LZOFgnDcIyKCswAnAGdUF3LBrhGQ=@protonmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 9 Sep 2024 10:29:44 -0700
Message-ID: <CAADnVQ+o1jPQwxP9G9Xb=ZSEQDKKq1m1awpovKWdVRMNf8sgdg@mail.gmail.com>
Subject: Re: Kernel oops caused by signed divide
To: Zac Ecob <zacecob@protonmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 10:21=E2=80=AFAM Zac Ecob <zacecob@protonmail.com> w=
rote:
>
> Hello,
>
> I recently received a kernel 'oops' about a divide error.
> After some research, it seems that the 'div64_s64' function used for the =
'MOD'/'REM' instructions boils down to an 'idiv'.
>
> The 'dividend' is set to INT64_MIN, and the 'divisor' to -1, then because=
 of two's complement, there is no corresponding positive value, causing the=
 error (at least to my understanding).
>
>
> Apologies if this is already known / not a relevant concern.

Thanks for the report. This is a new issue.

Yonghong,

it's related to the new signed div insn.
It sounds like we need to update chk_and_div[] part of
the verifier to account for signed div differently.

