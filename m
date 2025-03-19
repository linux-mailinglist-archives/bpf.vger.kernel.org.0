Return-Path: <bpf+bounces-54379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86928A69310
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 16:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647418A5B70
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 15:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39DB2147E0;
	Wed, 19 Mar 2025 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDRGnehV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7201E9B39
	for <bpf@vger.kernel.org>; Wed, 19 Mar 2025 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396823; cv=none; b=EqvUktQScE02YdS0eqxEeUBXGWl5zFa7CbBtR/ZOku8q+wP1zd+vQhRWx6gbasm2xnEmlnympsgQ0Tgk7kRWDy0QWVvE4qTvkDtWqh+EZsloGEVqTRdMwtYVR3/BgCSpM/6ove7h4J/0cgO/UeL0khI1Mus32qYHwHfh2gMiE1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396823; c=relaxed/simple;
	bh=TAAegN+iRE5AjnZX4PKdUU/kbnXJof9mCvrrXQvNPdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4A/hKL1A7cuIzCFNgulvoBTf4z9wj8bbRX80EmR7p+tvs6pixebKQc8cXgpYzZYq5qxMChpNvi4QlAzkP13LmQ3Mzjj6i2th19AbR1hPrCjz4aE2PvU1qdyuJvH3NgN/kJxT8Wv1qqDy6FwdvnXIGPo3Yju1EmuI47qrqC04yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDRGnehV; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3913958ebf2so5786119f8f.3
        for <bpf@vger.kernel.org>; Wed, 19 Mar 2025 08:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742396820; x=1743001620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPx7We1qtL94qUlg8rua2F9v5uIF9SPHuQKc2ANkpPI=;
        b=HDRGnehVVxqofCedmcKBWBxcoRwNn1BZ2eK0NsiopJqhGYg+7KnAv2ns4iKoalXB3v
         ZfYg8WXAwOEThRJhlrmYqAFGSqLHRmOnSHpJkwdxIXuFO0b+t1pSUhJGiy8sdX0aR5FL
         Yn3Rq9+1iJm/q0+gYamEQoaJtN0dSGrzXhyJh8ZAlfp/DBiq/qo3KD7Pp6ofp5zIomjv
         lZaPGJIKipiMMj9yorgy9vws/SshmHjcRA4PYUXnEvOX3f/tOa8PU4Y4rvDLsVwpwBNA
         azoHEp+BowvbTLOrT4p+4eybc8PDCrgPgY1yQwN7nLesoCXn+WKP5R2wXatrRS+yyVhS
         EeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742396820; x=1743001620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JPx7We1qtL94qUlg8rua2F9v5uIF9SPHuQKc2ANkpPI=;
        b=KtIIYuZ3BH8qNLBitS7vxJqF02PK69rE5bshd5CQ3x62S6e0OBdDUk+fMQhfA2Dmmg
         aZasUpbSXQdFTTwAWba9sK1L01hihBTviLxuORvz15jvBCTkDI2TYcY/WWxogALnQfkp
         NCQf1cOQutKawyRaxDbeVvDBx5Tb77TTCEaoc6a7W3VdWsLXe/YaA2QWFjtxIFNAk0ru
         jxs/zW8gBkGCcE/fRDv0duO/zRepHi6c9GcKulDSf7EDIpaMnaRYY6dUYZaauG756h7C
         9CW46syZqx2DGs3BA2rQpgpq/XTbFzbhVQE/7YlmC51WGlZx0iE9HLUEj/SFtVSdWmxf
         SUsQ==
X-Gm-Message-State: AOJu0Yx3YRQKoQUuynlkiXKrPNuwVLiTU+wubHpL+5stCTJRptTCMldK
	F9ny3aANIGYiTbTlYLL0QPLZ5pVllNqqB6kuDdGy/9BE9lArXBhXk31OaK/+RDSI4LQov3uvJL8
	gzQi6SaGXQ+VTnbCDeUbHwx+aoy0=
X-Gm-Gg: ASbGncs656PcuHGuzR/u0QRG/iZppPVri7HWuGgBuebNoaJ2PXHx3AWd1xtutOirb82
	WjTE2PSjGHqxQTtJD1rTTRPq403Bp4k/Th9/DjmNK7QVd3yjI77HZQ9vS0EouvSO3sfa8tHlZNo
	ucRV9ER/Ckcrg1IOTXdvT63X90BCSeU2PnMZIVjmfk8+HwTvQXTOgrFbRAzUY=
X-Google-Smtp-Source: AGHT+IH/6VQBsXFZ7uscdLtotfTIHej2CzjKybr77r9dCW5rqAeQVFfmBO3zGYSxUV+hCRCIQpeI3YMcqMOLM2d2fCc=
X-Received: by 2002:adf:a3c5:0:b0:391:4873:7935 with SMTP id
 ffacd0b85a97d-399739c8eabmr2787749f8f.28.1742396819929; Wed, 19 Mar 2025
 08:06:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319133523.641009-1-memxor@gmail.com>
In-Reply-To: <20250319133523.641009-1-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 19 Mar 2025 08:06:48 -0700
X-Gm-Features: AQ5f1Jr0WxTF6Szo3tKn6SF7Uz3K3twwU42lSL0KTU5YAauc0ENUi6VrzpHLSrI
Message-ID: <CAADnVQJtgnhA+HLQqYHSZY5os_vSXXwyYxhaFAEtj-M7mUR=8Q@mail.gmail.com>
Subject: Re: [PATCH for-next v1] locking: Add __percpu tag to decode_tail
 qnode argument
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 6:35=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> The decode_tail function now takes a qnode argument to use distinct
> qnodes for qspinlock and rqspinlock. Add a __percpu tag to avoid
> warnings and errors and reflect that the qnodes are per-cpu. There
> is no actual bug here as the value was not dereferenced directly and
> passed to per_cpu_ptr, so this is just to suppress the warning/errors
> at compile time.
>
> Fixes: 06988910ee2d ("locking: Move common qspinlock helpers to a private=
 header")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/locking/qspinlock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/locking/qspinlock.h b/kernel/locking/qspinlock.h
> index d4ceb9490365..f63b6e04ddd4 100644
> --- a/kernel/locking/qspinlock.h
> +++ b/kernel/locking/qspinlock.h
> @@ -59,7 +59,7 @@ static inline __pure u32 encode_tail(int cpu, int idx)
>         return tail;
>  }
>
> -static inline __pure struct mcs_spinlock *decode_tail(u32 tail, struct q=
node *qnodes)
> +static inline __pure struct mcs_spinlock *decode_tail(u32 tail, struct q=
node __percpu *qnodes)

Applied. Decided to squash it in and adjusted to
new line to make it shorter.

