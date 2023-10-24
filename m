Return-Path: <bpf+bounces-13085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE8F7D444A
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 02:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A69DB20EAE
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 00:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58F01854;
	Tue, 24 Oct 2023 00:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR/YohT7"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119191118
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 00:49:24 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D789D9B
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:49:23 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4084095722aso31744425e9.1
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 17:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698108562; x=1698713362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0ulcN82yK0xuUyD6lO765S1jHXQgEqCU5qPrV7DjcA=;
        b=PR/YohT7weLEr6bo6urS+tKvn03bBInLAVg9jmn3W04RcgRLMjgtC6J41QkFZuCzpn
         apvFPQPNwnIdGR5Rb1ZoRw9qth1x3/qfyjQWK/MJCmJa+RhflcizyQEmSAHvywp0HNRe
         +mtWrgLmg1ymwHD3lbNQnhY3yvKiQDbGR249wLCDeePl8c2NfxzRucFb+wi55Cv9zVKS
         M/kHI80F0iJx9QIj9dUzEnBhPw0IRWtIsXmCzxswDElaWOujxq8pOv7FJeqo/0rKoeWJ
         E2M7gZ9zE4KpNuJGMe/DH+72c2hKlrbnz6U9rb/Y44oD32Eq6v1Alqfg/o7hqFRWFICc
         NyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698108562; x=1698713362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0ulcN82yK0xuUyD6lO765S1jHXQgEqCU5qPrV7DjcA=;
        b=lRPNXRQ9GqcwDCmVTZZDRQvHQ4iRfFw0lJGYC7CdmO+nRQU8ZHgjYvzglezfXp0qKt
         4O/hu+TT5fEWH9x5weYVe81kVh8JbhSuYDFWbMc6+dLRn98DdqEW+moLSVINWXNbTxDe
         b/93Ov2IbTELng6dIj7QYu+CK610wjanpbK9iNyN7NvV0TcXJNu3v1sYOWQtJUwT4pFV
         YujCVbW7JGq9D5qKnTYICVrjrCcUMaHLF+iGBBrG2mVxdP+kS1qLbiW6BZW+MmJjL6kO
         pA14PvL565ava1rRqR0CjW1VgHmSO8AcPyOJazGR/+oRvgZJiql9BvL3jcpORa0VOdtQ
         eVtQ==
X-Gm-Message-State: AOJu0YxQXMZcrP4IpOwrkYDqi0awEHfH4z/leOKGg/Iev5f7WtbUcUSL
	7K/yvJMpy5u1o5KyQ0GtjKvHxuzR1nkK3N6+ogE=
X-Google-Smtp-Source: AGHT+IHalY8DpmhBkWTwFrbSLAnT2Y3uDHACwjVWv7OVsMZ4JkCE/5HfSxeT+0LBwHHuWPzkacC+KfRLUnhdeajgj6c=
X-Received: by 2002:a05:600c:474b:b0:3fb:feb0:6f40 with SMTP id
 w11-20020a05600c474b00b003fbfeb06f40mr8295710wmo.11.1698108562138; Mon, 23
 Oct 2023 17:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023224100.2573116-1-song@kernel.org> <20231023224100.2573116-4-song@kernel.org>
In-Reply-To: <20231023224100.2573116-4-song@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 23 Oct 2023 17:49:11 -0700
Message-ID: <CAADnVQJ-u_j8p7FMOpDHsUKjTa0E9sjA0G=zG8V484kuatNDvw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/9] bpf: Introduce KF_ARG_PTR_TO_CONST_STR
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, fsverity@lists.linux.dev, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Roberto Sassu <roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 23, 2023 at 3:41=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> +
> +        __bpf_kfunc bpf_get_file_xattr(..., const char *name__const_str,
...
> +               case KF_ARG_PTR_TO_CONST_STR:

CONST_STR was ok here, but as __const_str suffix is a bit too verbose.
How about just __str ? I don't think we'll have non-const strings in
the near future.

