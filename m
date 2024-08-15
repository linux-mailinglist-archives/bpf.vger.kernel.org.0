Return-Path: <bpf+bounces-37285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFE59538D6
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 19:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684AC1C23A4D
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 17:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A181AED40;
	Thu, 15 Aug 2024 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4qV2I42"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1354205D;
	Thu, 15 Aug 2024 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723742136; cv=none; b=vFegWo9Osay6p+i3Z9Go9c9ivcnx3/ICy2US0tW1Y8lNJf6TYfdYz11HROg+yHwlpgx7jVhidgQoOFpMiQ5/pmLaMEuz57ArA1Fq32T0/PGsAzRKVcYVyIcA4za865wtaVYksrpJUfp5fiK6shhCs/bkqoH4WhSl4Fqog+R9wrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723742136; c=relaxed/simple;
	bh=3o1KU/XW0J5AKMh8GaefkND2pRfNYfsVX9jGw3iVM/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1HVLFGjeB+M6f6COMoPahqwnPHDpSPk9RSMlT5xD42vnF0TY8y61PLLYFPo6K6S6vEMraxMr3QPNjXy7e79P5BUgIEgEBbnfmOo69Kow+ARotvYE4AFUttbzjQb9VlDj9+Y5hpzM8eXNyLDZtHGIOMzJYZ5i13yYitjCYoEyd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4qV2I42; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7106cf5771bso974274b3a.2;
        Thu, 15 Aug 2024 10:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723742135; x=1724346935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TF+mb2hXO94it/ZuRGN2AFBr1zfyutJww+KrOEj/A8k=;
        b=k4qV2I429jS8EK7s3iiaQRFuQ4mivLnGeG5Ie6KRRT5X1tSiZ0wwq95FvbQRWbXbef
         x7InIj2p6tMiNFAC5p4nvHQCQG9/sgz7/gNLVZaQ+uIOej1jY3tt9ybM7I6UmUkv52VI
         unEtdEQar8rtO/lK9y9LTlz22H9+bwTkJTgKrUKCqcrRhi50KjWKJdKDlKwNiKkK1vX+
         AKZTFCLeJnOmpdY66n/V6v4xVVGgnOmPd16cv2UZqNNEvz4RJMVWmtMhSS5Cwr1Yfrw3
         obOGK/IHXUZiVmg41SANePcTcVKRsr9CIoZqPnLB5L/gJYA2lGD6VBsraHYBKQwl76wv
         wCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723742135; x=1724346935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TF+mb2hXO94it/ZuRGN2AFBr1zfyutJww+KrOEj/A8k=;
        b=mcLQAxYSN+SPXR6zd7/6cwYs0b51YNKudvfIw7+kb7fNAS6pUKSSoDmpKWzRcuLtJ3
         Gjej3/F6JmxARY4rvoqDdtWYeh73etydaZ9gz0n62ZO8zTsJJJu+/uO7d8SFEmizwqDw
         alMsY3VpE6wdZD80D7jPNUsLy+9C6rCO+tTp8/+Zvh5tKWjo/QkH5hCyAYtVWYTg2uXO
         qSjPdDH2Ru1I7t2rLkeYveC1YawtOulNV6iIKMFftnZDSmQUNBlsQ8jFg88JPOBiaMi6
         cWxuHc2X4+rxezyminFMdOwh6WilG123ipJuPf9vFSoePKSgrovBKk+TRdrNjJsc7wH9
         oVWw==
X-Forwarded-Encrypted: i=1; AJvYcCX4ccrkAVGlljNYW2jOsbGFJixfheUdFhKNLHCOploC8DnukSz5MFOZRLXM1lOBSKdBGmZ5by3x5XkzW4dN@vger.kernel.org, AJvYcCXg1z3XvDMRKKtSOzGzhkNq53RMQQItqZnZcknnJf1MP4c8z+i7U/PBM4zsl3mhNm5xeoA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3m4ZOSwHc1VlMlVJc+wK2Lv30XyZ66HU1wxikaiNkb3HSTuJ2
	UB94UE6/K3waYrQ1GZyhTNgDPtcJpUFWahqvH/94XxDL+jBEV5x6xeUwKP5qKs+48PN2D1Dcxsp
	UrYqCeMIqLF3BnedwfF4FZOG6yxg=
X-Google-Smtp-Source: AGHT+IGEdTuVPO65h8TZ+PesbbLjZfcRqbd1qGcdfUH/pyVoCgJRyGDTaiPYngMenuxJaiw2La88yDlNza3T6smIY0U=
X-Received: by 2002:a05:6a21:3a82:b0:1c4:936e:b8a2 with SMTP id
 adf61e73a8af0-1c904fbb5c1mr371141637.27.1723742134695; Thu, 15 Aug 2024
 10:15:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB58489794C158C438B04FD0E599802@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB58489794C158C438B04FD0E599802@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 10:15:22 -0700
Message-ID: <CAEf4Bzb3XbGx+N5yrYELNAkaABP9fyifAQhTP1VHSvVycG36TQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Make the pointer returned by iter next
 method valid
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 9:11=E2=80=AFAM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> Currently we cannot pass the pointer returned by iter next method as
> argument to KF_TRUSTED_ARGS kfuncs, because the pointer returned by
> iter next method is not "valid".
>
> This patch sets the pointer returned by iter next method to be valid.
>
> This is based on the fact that if the iterator is implemented correctly,
> then the pointer returned from the iter next method should be valid.
>
> This does not make NULL pointer valid. If the iter next method has
> KF_RET_NULL flag, then the verifier will ask the ebpf program to
> check NULL pointer.
>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>  kernel/bpf/verifier.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ebec74c28ae3..35a7b7c6679c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12832,6 +12832,10 @@ static int check_kfunc_call(struct bpf_verifier_=
env *env, struct bpf_insn *insn,
>                         /* For mark_ptr_or_null_reg, see 93c230e3f5bd6 */
>                         regs[BPF_REG_0].id =3D ++env->id_gen;
>                 }
> +
> +               if (is_iter_next_kfunc(&meta))
> +                       regs[BPF_REG_0].type |=3D PTR_TRUSTED;
> +

It seems a bit too generic to always assign PTR_TRUSTED to anything
returned from any iterator. Let's maybe add KF_RET_TRUSTED or
KF_ITER_TRUSTED or something along those lines to mark such iter_next
kfuncs explicitly?

For the numbers iterator, for instance, this PTR_TRUSTED makes no sense.

>                 mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
>                 if (is_kfunc_acquire(&meta)) {
>                         int id =3D acquire_reference_state(env, insn_idx)=
;
> --
> 2.39.2
>

