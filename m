Return-Path: <bpf+bounces-30593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 575858CF087
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 19:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F791F21792
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 17:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1E5126F14;
	Sat, 25 May 2024 17:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Whhm+Ghs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C30D1292DD
	for <bpf@vger.kernel.org>; Sat, 25 May 2024 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716659061; cv=none; b=O9ib6eXj2wjRGYmOvIGQoSngeZezk+4TNFVol9AP2ch9AxHEkQIWNfWVtPXNGT/f0VkI0NUltl9tkflbXsg7i8Hu6dnbF4UvNhhz5QnkcKkIXDRHSx6GmBpvRthrqBL/LRgA75XZAmbLOmGnQIivXNYVs1vW6bnI9m5gIkpzDgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716659061; c=relaxed/simple;
	bh=7STiQZHGcIvPHhTQd3sAxEUPJ2dZV0IPQ7f1BCB5Z8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGTds57FS2LQQl9/flwRjJ/VvNGn0+n+aKOM5GzNjorqHD33Fo63rHUiUnnXKjuPy5wM7Bxi65QbdVXEjSdmykCRZn5hHNEFeELugTawGwNGRkj5s14F8/za3yalKtchSvOGa+WQLU4Y/Q/6GTQAAldHUHdkjnAFbuX1YWY/7A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Whhm+Ghs; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-354f5fb80d5so2658394f8f.2
        for <bpf@vger.kernel.org>; Sat, 25 May 2024 10:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716659058; x=1717263858; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Y/6C/E6yC7jwML4/leNnl/R6IKBwOgYlfjScoft7K0=;
        b=Whhm+Ghs8lUwmaWimzKyR2rpvI3dNqyVrs3/43RQKn0XEYfiu4XECpMqljUy6giHU4
         s11Qtc2S4DJ9dBM0DWQkIuz+dN3IZZlQ+JQhQW+CxlW0g6eWsddEu7P7eSbWgzLz/kEN
         ivzGEmn8s8sRTaYmF59DLlwczaVXe7GHtMShvumVCE3jBXdM4qStY+9mQNA11l9cnqpS
         6iprUzd8dzQARFTxnp9dC9JgamBLLClNy+ieExew4MnDThGDxrGV6WIBLyoI0Ve4CgB7
         mhuHN06uht7UYdO9BxVwATcgEN4JurM86o4aAmSg9CCrF50hKHWNW7EBO7m4DgpnCJUs
         oErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716659058; x=1717263858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Y/6C/E6yC7jwML4/leNnl/R6IKBwOgYlfjScoft7K0=;
        b=XCK5Yz5xCkqfiwf045d+j8s92wRcO66SxoxlBBelX6RqHr5KuTbCGzZTMRWpLgria4
         qqlOp3npgE9lhuvHwjsTPaUkaf5XRmYrlEyPAp2WvX9wSgmYlk0LgIsrVbRt/Cl3Sn6D
         S+DKcKx3mTX8RM8HeBdGXqweF7iLHhr4Q4Qxc41QjDjLnFCbAbmjzNDigtd7udBNmvcL
         UDlhG4Q60ydJarXp6itGfW8Jh1febVb1sT6NhBd/GlzT2cnp1B8hmuS4BdE9A1MA3N6k
         dFxC8F5QY2mJ2pT61wPUgSI7K6sDNICAjCZ3wUjV/PNqwCmr1xHHNkz4Xv+DACMlM30C
         YN8g==
X-Gm-Message-State: AOJu0YzPcpcIT2Lnj0szH6uVDVqXgcuMjx5sA9wA1DOFhd7jptm7Ol8A
	I4cyLJVZluVREP3syLjjesjbbw+XKkQeekGG9eCOmpxoc1o2czJvxi80qRdFVCpgJCKizAZKAER
	W7n5pO0bo8oHYqnsoI/Nv7g3PAgI=
X-Google-Smtp-Source: AGHT+IEeR8EHRpQXHrkAGqBMMvLFMsaOON/YjrJMVVHxP4+6gP4dg5VC6TvmrNjBEQG20nScLxHC9XugbGvt4sabVLA=
X-Received: by 2002:adf:fa49:0:b0:34d:b549:9465 with SMTP id
 ffacd0b85a97d-35526c5a5acmr3647801f8f.32.1716659058480; Sat, 25 May 2024
 10:44:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525153332.21355-1-dthaler1968@gmail.com>
In-Reply-To: <20240525153332.21355-1-dthaler1968@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 25 May 2024 10:44:07 -0700
Message-ID: <CAADnVQLr4BGA=CORgcHh0QxWjHhk6p_jHiUY-1iCuJdL1kj7+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, docs: Clarify call local offset
To: Dave Thaler <dthaler1968@googlemail.com>
Cc: bpf <bpf@vger.kernel.org>, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2024 at 8:33=E2=80=AFAM Dave Thaler <dthaler1968@googlemail=
.com> wrote:
>
> In the Jump instructions section it explains that the offset is
> "relative to the instruction following the jump instruction".
> But the program-local section confusingly said "referenced by
> offset from the call instruction, similar to JA".
>
> This patch updates that sentence with consistent wording, saying
> it's relative to the instruction following the call instruction.
>
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
> ---
>  Documentation/bpf/standardization/instruction-set.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index 00c93eb42..6bb5ae7e4 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -520,7 +520,7 @@ identifies the helper name and type.
>  Program-local functions
>  ~~~~~~~~~~~~~~~~~~~~~~~
>  Program-local functions are functions exposed by the same BPF program as=
 the
> -caller, and are referenced by offset from the call instruction, similar =
to
> +caller, and are referenced by offset from the instruction following the =
call instruction, similar to
>  ``JA``.  The offset is encoded in the 'imm' field of the call instructio=
n.
>  An ``EXIT`` within the program-local function will return to the caller.

I reformatted a few following lines to make it fit into 80 col while
applying. Thanks!

