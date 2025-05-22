Return-Path: <bpf+bounces-58734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBCAAC1075
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 17:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78A85015E8
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 15:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA9E29A9DD;
	Thu, 22 May 2025 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e67gMmcH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4712980B
	for <bpf@vger.kernel.org>; Thu, 22 May 2025 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747929365; cv=none; b=Yl8lLl7ClbPKtkWKXsl9ZAA7NBFiQCMWPECxDfQ6rZf5nhC3DH7H9fmCgku0oMvTno+9jbt7/VG4GF1yRvXi7PE7xaFcG+dOzo2OHAR84DvAFLzxbPV9u9isvg317EtzHatGyZpxQkKjzr4GrdvIBnPN4+m3abnzgPi402f1VPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747929365; c=relaxed/simple;
	bh=/RSChDiIGzZ/oRk0OaLzaorGlj4qzM15F7TPFZbFhZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTiniZYyTY7yPSly7dit0zLvzkVKQD86zCjDfvSgKNXd4H//0BRSrATxJjO66E9CEuWxRJietpDE9lIGU0ZB+ps15uPpCzf8deuidoy9HJZ5ILa2LhBjAQQJ5QMs0ninpdL0KY/i+m54RMTQYrLfjKBiCL0Jhv27cbJ5WMV/bOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e67gMmcH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a363d15c64so4082572f8f.3
        for <bpf@vger.kernel.org>; Thu, 22 May 2025 08:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747929363; x=1748534163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tw+mavjaZsSuZ6ssUDJ6pLa/w1pQaonTUQGOEv6hmGY=;
        b=e67gMmcHvzz276N88m6t0PFIB4gresxoYUbVhpQv4fOlxT2rNnEnBfoxpgOK7vjfzd
         dt8HjcP7/YCsdNrgZe54ChsfQ6b6oTRejqmNCXpQfSoUwrrsVjdh1o5ePG7GwEtVk+rW
         oH6aKPbbfhevW4SLKYA2bTJ50ih+buslFfUcvtQI4WecrNE6+JeEmACeb7tOgJtpW66F
         N2BdrZY0Aw7tlwptZJyMAW9X67wWjIG6S8FsydWRNU0DWNY6LHiOCQ7AtW5XpQsrQpxe
         Uz0fifLXvehgdrCRqj6mr4hABNevTci/Vx2ZXALgv956J/rc8RTAa7jKY9TJZexhDUGp
         ylMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747929363; x=1748534163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tw+mavjaZsSuZ6ssUDJ6pLa/w1pQaonTUQGOEv6hmGY=;
        b=oIKRYBkfJBi2DjlIMuBVIGtw17lGhNN1btRBaE9SftVL5J+CNSLPgRjZxsbze/0GZ8
         Cnr+6QUeWy0tR56qecHm91KL1M1zZ71K+3aknvO9IMCtcVx/wNZsMOK60gT6Zw0MsRl0
         JDMKlMG/Yxc0AQRgulFPn65JAtVhC231t8k+LnczBJjzVL5XDnKq0UPQDmRy/Xs3lSrl
         fpykwmzynpjsi8RpkwT02bSDisuwXc63jBn5e+T4Y1go7Kr/T79INQcewSM3dsuQzAoo
         xNIQi78tr0d8VZlmOL9gr77EBnDvJkIvtVulQNwWoHfr1Lnsmg1xGNYSaOSoZ2I2owfs
         Tqgg==
X-Gm-Message-State: AOJu0YxZcWuD9gEtD9sUw3yAkylHT8g8+RVv/LDisNJsYK1mfBdGaDxG
	RNdwallRqT51uN3cmvBquWrif+B7vhwBWapDKo2EIZQNzQkU+qoPyVJy/iJ+KfIv3lVT2HKkasg
	d/xR7wq8C9j2njX1TFQnNa733pS42ZDw=
X-Gm-Gg: ASbGncteNc06pjdJgGj5GYT6LA2RNkS3m8/zQlT22gNteMvZJ0QPbL6mSv4DwD1dyFl
	BVj6319IFW2DCN3tWYovJrkmFTocdCRS/RRVRj24+iTd5KPhDqIthJ51NAhn/VdPjytUWh4ZrJc
	tUxpV7JYQqyPIozuexiP1+502EIg1i/hnugQEvRTLDQa6lWGUXucVq6gVQTOuPRQ==
X-Google-Smtp-Source: AGHT+IEl2ARdryEEH19LEUZT5jEezIWhbQraqUkOQZkH1xRpFRxaKvL79Qx1ctldt/NmcBE9YmE3Q5/QTiYITcH+L5Y=
X-Received: by 2002:a05:6000:180e:b0:3a3:62e1:a7db with SMTP id
 ffacd0b85a97d-3a362e1a997mr16443435f8f.3.1747929362451; Thu, 22 May 2025
 08:56:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521032047.1015381-1-yonghong.song@linux.dev> <20250521032052.1016178-1-yonghong.song@linux.dev>
In-Reply-To: <20250521032052.1016178-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 May 2025 08:55:51 -0700
X-Gm-Features: AX0GCFsxkkVeKU7G-KDNgPLaX8MhtPVYhOKnSu6WiPZz-TgsIlSc2CbmXjii8pE
Message-ID: <CAADnVQJm8oPuhCfw8TuvgywE-RDtv-bdSw=ueinLLdXYr74gtA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/3] bpf: Remove special_kfunc_set from verifier
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 8:21=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> +static int check_special_kfunc(struct bpf_verifier_env *env, struct bpf_=
kfunc_call_arg_meta *meta,
> +                              struct bpf_reg_state *regs, struct bpf_ins=
n_aux_data *insn_aux,
> +                              const struct btf_type *ptr_type, struct bt=
f *desc_btf, bool *done)
> +{
> +       const struct btf_type *ret_t;
> +       int err =3D 0;
> +
> +       if (meta->btf !=3D btf_vmlinux) {
> +               *done =3D false;
> +               return 0;
> +       }
> +

I don't like 'bool *' approach, especially when it's not set
in all branches, but implicitly initialized by the caller.
Let's signal by returning 0, 1 or negative error instead.
#define KFUNC_OK 1

> +               ptr_type =3D btf_type_skip_modifiers(desc_btf, t->type, &=
ptr_type_id);
> +               err =3D check_special_kfunc(env, &meta, regs, insn_aux, p=
tr_type, desc_btf, &done);
> +               if (err)
> +                       return err;
> +               if (done)
> +                       goto check_kfunc_ret;

This will be:

err =3D check_special_kfunc(..);
if (err) {
  if (err < 0)
     return err;
} else if (btf_type_is_void(ptr_type)) {

