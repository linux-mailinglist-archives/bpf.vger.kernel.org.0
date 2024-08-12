Return-Path: <bpf+bounces-36954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A85C94F995
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 00:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CDE2B21BF0
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 22:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D6E1953B9;
	Mon, 12 Aug 2024 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7161sIX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53A8168C33
	for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 22:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723502097; cv=none; b=CRIotrIqKgb96mrgiJDBcZRhoqnM0awoZhoT5Wfx5wOjh3/60+UvDOF6l+hUTrc0FagTey5++L9mhtggrvE2KMYNOsM82L8z/RWpPczmQcB+5+WQp4BpVUFQ0a471tjDpp0RYIPKx1oJf7PoAbzV9yCq1vGLPE46MhbM8ooR7J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723502097; c=relaxed/simple;
	bh=wvgNlskddcuLliFQHt/JNNYYEtR96fSfwjykteAm57c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMvYkpPWtwftjG8RISbgSsB++HV7pMEJVmxr0p1+SLpp0z8OWKyk7bSVVWyhEPm6zXnQALKS2nRkb+3y7AlaiTgiqqBrw+enLTiNWGvLDxG6iRertTr3wt9WkV39Q4kM5GBuMH0DahTN8ww59yOqqKZ6cg8Tk/eSsbWdxRfja+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7161sIX; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-368663d7f80so2572783f8f.3
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2024 15:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723502094; x=1724106894; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oj6Uibu0p3WrWdxjQK6OpGcM9oMDgsfuGNPvgx0kcTI=;
        b=G7161sIXK/uWpwVPpOlP+rsHFy32/2jC1V9Mh0DQg/gmdZjSls9yp4UBpwhM3y+hWR
         qOj76/956VTsUiPCTDe6ONmpHOr0C6+FLDdOWPwRhJMasOXy3aNJgJAQrJ5l1wHSYBTL
         4iYkAFtfIzAz+eZ+7jRNnAjVmqLkWBZrV95C3LqyuSlylIEwpLvh/vh8gXvbkYEZB89O
         u4xcA5jcGkx1l30DK/sOBOZ0IxEEAKsXMcXhpWMqmP0Im26HqygLqxBh+AtEUPXRp7xN
         Itvni5fdSLS0WqLlwyXqwN7MrGfAbUNGOMKK1r+4680F+C4ZfwGEfhBZdkv1xZHrLhPV
         zuig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723502094; x=1724106894;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oj6Uibu0p3WrWdxjQK6OpGcM9oMDgsfuGNPvgx0kcTI=;
        b=bS97PDHAXEFZr74/HjRr6n2MTCEMzOzj1QnoWtgKfs4DVOusEK5g2qhz4UbBPb+aj4
         HbD62+Xng0LogOMFgmdkQM6wzIHZJ6/LBqiAKNa9iVkL/FE44kbHE3cHNjtJ7Pjkh221
         oRuqOtmCQimlLa/ghbkbfh/MUO7nx41Cgf3CTAVJ6e4HTWHHdRTccCdaO/wkHVARA60d
         +lNYnQCrtLWv24PTXDKR55ku7EC1hvLDDUd1SIdhIdwHmqxnlb3XRDHGANkLdgxjsiTC
         NWfif+E40kpIr7po+EyzgXoYuuzD9FyOK9VBTP8z94pOkDJTZRuus6RnFj+SRZyDtZ8N
         hOHQ==
X-Gm-Message-State: AOJu0Yz/pXDLldf3DHXVY4qpQG3ktKMG+QaJG7MuL+/pf52nhySqcoUz
	4pb25t4mAj+8dRwrnT72KK1ZWfZV0zo3aQ9lR3PitAREaAar36YEzqOSYyGrn1NkbSNA1bQBKb1
	hRnJRhbBapnAMJdUhapMtAxCibII=
X-Google-Smtp-Source: AGHT+IEn+S2knNN2YUasB8lCfttnYHpslFmvPn14dsrCY0DrqcFJOS+Y8t9sDm0A/5wkDk8I50PFSzccfSNBWOAkTNI=
X-Received: by 2002:a05:6000:178f:b0:367:8909:197b with SMTP id
 ffacd0b85a97d-3716cd2ea96mr1634766f8f.61.1723502093809; Mon, 12 Aug 2024
 15:34:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728114612.48486-1-leon.hwang@linux.dev> <20240728114612.48486-2-leon.hwang@linux.dev>
In-Reply-To: <20240728114612.48486-2-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Aug 2024 15:34:42 -0700
Message-ID: <CAADnVQK-f=dCsN4E2goj6YjDkTD4PhZK=VTZygaUsK9JPD=Wag@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fix updating attached freplace prog
 to prog_array map
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Tengda Wu <wutengda@huaweicloud.com>, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 4:47=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Fixes: f7866c358733 ("bpf: Fix null pointer dereference in resolve_prog_t=
ype() for BPF_PROG_TYPE_EXT")
> Cc: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf_verifier.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 5cea15c81b8a8..bfd093ac333f2 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -874,8 +874,8 @@ static inline u32 type_flag(u32 type)
>  /* only use after check_attach_btf_id() */
>  static inline enum bpf_prog_type resolve_prog_type(const struct bpf_prog=
 *prog)
>  {
> -       return (prog->type =3D=3D BPF_PROG_TYPE_EXT && prog->aux->dst_pro=
g) ?
> -               prog->aux->dst_prog->type : prog->type;
> +       return (prog->type =3D=3D BPF_PROG_TYPE_EXT && prog->aux->saved_d=
st_prog_type) ?
> +               prog->aux->saved_dst_prog_type : prog->type;

Sorry for the delay.
The fix lgtm.

I reworded the commit log, since it's too verbose and applied to bpf tree.
I will apply selftest to bpf-next when the fix makes it all the way there.
Otherwise there will be non-trivial conflicts.

