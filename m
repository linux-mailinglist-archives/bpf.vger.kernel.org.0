Return-Path: <bpf+bounces-40616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4F398AF88
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 00:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90905B23EDC
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 22:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D08C187560;
	Mon, 30 Sep 2024 22:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQVyDOj6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A8817F505
	for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727733647; cv=none; b=q+z2K22uvK5al8fF2SrUtcZo8QbwA2zF2OH+xU7IcACFPOu1nOZNwwdQ+JaHEbxOEODm+JFpNayMlhLhFej3wEbJYE+rkThiP26MyPJqSL42WtLumzfRjWlCFcxA5k6MZ+wI1yWqO6krgix00hHzUjHJCo3+PKEpG/5yfyuUDVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727733647; c=relaxed/simple;
	bh=Hou3Kdgt4yapHujcrnHCVyYFmc626AH71kQjYdmfqUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d0YRTDKjgGHwstbfqMMuL0LyoQH2nxWDuv6j7NHNaa4AOqrSQ8/bQT/9RVBa/Tlra9CCly4kOvNCHjPWb0zpPO0MRS04JNP+mnLosiPXzt6rh4ls2FXyvDtScqqQrzTQeDDJO8P2gOZq2juJVPsIzQARZpZhN5fiIsso9g9jvEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQVyDOj6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b6458ee37so27564885ad.1
        for <bpf@vger.kernel.org>; Mon, 30 Sep 2024 15:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727733645; x=1728338445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=javF89s5Qqo6U6NJbcQcdYbYUaSRrWB4RzzIk8jhLwg=;
        b=nQVyDOj63u5QuKoZii1u4whqVHXcIHQxIxojQQ92k9yFXKdEAcyx9Dof4kHsdkTjji
         pwNexgrZogOSACzpc5jT6sThE2P8IC/QHPa9n+LbJvLWVTcN6mW+5zENZGG1LaAccJKz
         DW7PyG5HHt8OoHSkU7oLDWIFIhtiKyAZFbZMlKcTr6lmQiQBzwRoPSTJShgVNtWm7w1y
         LrSfKJoIeXbgl3cHib9dgOIp6XN77eQNnXqEgDKyk4bQRSOfIi0GDd35oDm8H/5yjHd2
         x78rtFqGh6RH7OsxiiyqTgqqZ0FOh57urDtg4IAS4AD7S5Wg+xCqyZNtvVsL80+SvxIJ
         6F3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727733645; x=1728338445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=javF89s5Qqo6U6NJbcQcdYbYUaSRrWB4RzzIk8jhLwg=;
        b=cB4yZ0HMo30r62Vn9Qfd0gApdDItSOxecA1oDnoa5qrtXSPIpJN5CTy86X/lbTs4ys
         Ge204MWWS1IqB0pOVKjDqQgk4mUCCaDAkNz8K6v1GbMk5oe2PvPj+k2EzsIzLy3+7cGZ
         zk+d+x8qTOb0GqXQQdQX//4G6vsmUqsVBI1pW8Hm+py+QLiGHELI8jg4pR+6Zqb8H7cF
         6I1xzxWJaJmbHUhZK4mnN+DIk3HH1EYuo1Q96lI6MI8MqrE0Nji0KOauI0XWXQHXV2H6
         hp6dwM4VyQ4T8TLyK0rdrPHSCeA3/ezpbl9J9shRKf4cX0LOOXLKdNqpPsNF4hVXL2Ye
         SVfQ==
X-Gm-Message-State: AOJu0YyS2crs6Awz2udv0u/xz6zFyn0ZUrV6B0pJy3zLXu+BtZ/EtAlH
	b4ci4YcYKRnuCCSs+lA/sb/vZL3uRGG60N7EC0JF6nd7LTF/TlTp4dORcUtyBqnNmbM1MnTxP4v
	/IVzWGNf1PoZe/yk6DU7qMvUiaMI=
X-Google-Smtp-Source: AGHT+IEgpQ85Y9sCEpoiYUFVWDPB/E+38Y/9W1WcvUhwajJFP9mTWIn+CyarybaoEVTLShJl7JU9aZ7o86mWojcDUSs=
X-Received: by 2002:a17:902:c94f:b0:20b:9034:fb4a with SMTP id
 d9443c01a7336-20b9034fc7emr55951325ad.49.1727733644899; Mon, 30 Sep 2024
 15:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727329823.git.vmalik@redhat.com> <bc06e1f4bef09ba3d431d7a7236303746a7adb57.1727329823.git.vmalik@redhat.com>
In-Reply-To: <bc06e1f4bef09ba3d431d7a7236303746a7adb57.1727329823.git.vmalik@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Sep 2024 15:00:32 -0700
Message-ID: <CAEf4Bzas4ZxiyJp7h7N5OGmPSMRfZDgPUgEAdTmir3n-4cx-xg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add kfuncs for read-only string operations
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 11:18=E2=80=AFPM Viktor Malik <vmalik@redhat.com> w=
rote:
>
> Kernel contains highly optimised implementation of traditional string
> operations. Expose them as kfuncs to allow BPF programs leverage the
> kernel implementation instead of needing to reimplement the operations.
>
> For now, add kfuncs for all string operations which do not copy memory
> around: strcmp, strchr, strrchr, strnchr, strstr, strnstr, strlen,
> strnlen, strpbrk, strspn, strcspn. Do not add strncmp as it is already
> exposed as a helper.
>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  kernel/bpf/helpers.c | 66 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 1a43d06eab28..daa19760d8c8 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3004,6 +3004,61 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, =
u32 dst__sz, const void __user
>         return ret + 1;
>  }
>
> +__bpf_kfunc int bpf_strcmp(const char *cs, const char *ct)

I don't think this will work as you hope it will work. I suspect BPF
verifier thinks you are asking to a pointer to a singular char (1-byte
memory, basically), and expects kfunc to not access beyond that single
byte. Which is not what you are doing, so it's a violation of declared
kfunc contract.

We do have support to pass constant string pointers that are known at
verification time (see bpf_strncmp() and also is_kfunc_arg_const_str()
for kfunc-like equivalent), but I don't think that's what you want
here.

Right now, the only way to pass dynamically sized anything is through
dynptr, AFAIU.

pw-bot: cr

> +{
> +       return strcmp(cs, ct);
> +}
> +
> +__bpf_kfunc char *bpf_strchr(const char *s, int c)
> +{
> +       return strchr(s, c);
> +}
> +
> +__bpf_kfunc char *bpf_strrchr(const char *s, int c)
> +{
> +       return strrchr(s, c);
> +}
> +
> +__bpf_kfunc char *bpf_strnchr(const char *s, size_t count, int c)
> +{
> +       return strnchr(s, count, c);
> +}
> +
> +__bpf_kfunc char *bpf_strstr(const char *s1, const char *s2)
> +{
> +       return strstr(s1, s2);
> +}
> +
> +__bpf_kfunc char *bpf_strnstr(const char *s1, const char *s2, size_t len=
)
> +{
> +       return strnstr(s1, s2, len);
> +}
> +
> +__bpf_kfunc size_t bpf_strlen(const char *s)
> +{
> +       return strlen(s);
> +}
> +
> +__bpf_kfunc size_t bpf_strnlen(const char *s, size_t count)
> +{
> +       return strnlen(s, count);
> +}
> +
> +__bpf_kfunc char *bpf_strpbrk(const char *cs, const char *ct)
> +{
> +       return strpbrk(cs, ct);
> +}
> +
> +__bpf_kfunc size_t bpf_strspn(const char *s, const char *accept)
> +{
> +       return strspn(s, accept);
> +}
> +
> +__bpf_kfunc size_t bpf_strcspn(const char *s, const char *reject)
> +{
> +       return strcspn(s, reject);
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(generic_btf_ids)
> @@ -3090,6 +3145,17 @@ BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
>  BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_strcmp)
> +BTF_ID_FLAGS(func, bpf_strchr)
> +BTF_ID_FLAGS(func, bpf_strrchr)
> +BTF_ID_FLAGS(func, bpf_strnchr)
> +BTF_ID_FLAGS(func, bpf_strstr)
> +BTF_ID_FLAGS(func, bpf_strnstr)
> +BTF_ID_FLAGS(func, bpf_strlen)
> +BTF_ID_FLAGS(func, bpf_strnlen)
> +BTF_ID_FLAGS(func, bpf_strpbrk)
> +BTF_ID_FLAGS(func, bpf_strspn)
> +BTF_ID_FLAGS(func, bpf_strcspn)
>  BTF_KFUNCS_END(common_btf_ids)
>
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> --
> 2.46.0
>

