Return-Path: <bpf+bounces-27864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3D38B2D7D
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 01:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904121F22D37
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 23:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9602115664A;
	Thu, 25 Apr 2024 23:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abxRX3f8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C597884D0D
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 23:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714087084; cv=none; b=OZUviJYo1ZUqNkhJyRt7GM96W0gwwvwGuj9Be3FO1NBD2I3KVEG9p+uboqlh8CdgAF40FnhBts1dLo4w2d6fj2LMylP1lcuexqH8bGiq4rD0AIDC9EHQ3H2F5LaQcwA3o1NgA4HzR6pH6UX+pQzLsL2HrE0he9qYuxD5hlenMYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714087084; c=relaxed/simple;
	bh=H1sLpQ6V8ZVN/lL+X1VorkSEPLX/fps1TlPZb1+MHJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G45GGvCeybGXVj98T7ImMDnL8vY0ht9wJgK9ifcav3gYxykg3VpcKcBo//TtB2ROvMvPOCUjb637UE6cUtJWnNYIxFJgthwEoqH4N7WNLY9e4hnmfcH5BqdRdGKEJsn4wnp9sNuboEq6VmWb7yP+MWbxDdj1vsVMzrQvMa9eO6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abxRX3f8; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a4df5d83c7so1149469a91.0
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 16:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714087082; x=1714691882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+Lvw4YwBnMI0BLpV+4f0iVFu+KRWgRj70dqTPVQi1s=;
        b=abxRX3f8r23jpVzoKnEs77gG2HweVbgzNMQ3HH+1m1+7xaf+gUFEtM+FEWPGMgg85d
         w8HNcDuAZJAsZLWlaDjx9DZLRMWJ9wjc0tlJio83OvgXKaJZW3uImhLDDoxotOtIl4Aj
         fJKpk5zS+p73nBDqMvMrGA5pxL8zb14/40kCngMYGvfV/7MCkfI630niy285seD4X7a1
         EB+R/2W82WmtSZ6XddvKOEU//QFQGJdhgvDz4bbEPt0UJvakHP4TWLIvT5GgEae9BMQp
         +1t/GnkcmEW22+hsadkG6BeSy8ov2Bm5G523WWwqF1ThJFhZ7RAe/FkBPPOzmxWmM6w/
         NEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714087082; x=1714691882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+Lvw4YwBnMI0BLpV+4f0iVFu+KRWgRj70dqTPVQi1s=;
        b=XEHB+DEoCcbkoQsBXoJcat/xRaA0zXkIqvhoiZ27t77tpzIf+Jkl0sEypQZi8wAcUh
         pNvuEpQ9CwXi5whPd1r9qV92mLpK7GADk9qLwXL+B0EKMB+Q1NCJRyIXwzaRBKt8nO1v
         fvV9qJcfS90c7zWCfH+HQOHduzVonZSYBLFxaCBqVGFZXzjPsI79ulXkJT79TESeLh7n
         f8JU5R11XrbtgKNHJgCVGaEy3c2cz66+HWXqSB3sBlP3/b4V3F/MHT3c3EMICQ3cV9Yn
         Cb05v3QmqwfIT4yI9vQxPUiBFoYkYWK7t05oJ6wjsBABWfOX+i355hTmAKjZ1w8Uvl5P
         Cqig==
X-Gm-Message-State: AOJu0YyqCeh0jDFbRpRXdCugKaSdDM1aKOdOxmW6MepI0xn6PH475PEN
	zmGcyHCIN+dEvrjNwAUj+ZlzOMaQM2cBnqkAAm0Tmhavg9bC7tKJvcjZt/RBf3JtHegL51Z3h/N
	QXHdzHKGbFWDpmcjX2+mEIsumDZk=
X-Google-Smtp-Source: AGHT+IE8+UaCbNSA7eZfnZ0wQDKU+tz1Go1fY8CTggVhsm8iHfLsPTwFLJETNdNs0qNGGMdt+qYYiyWnoSaGEyywAl8=
X-Received: by 2002:a17:90a:ab97:b0:2ae:1316:a4a with SMTP id
 n23-20020a17090aab9700b002ae13160a4amr1106916pjq.4.1714087082114; Thu, 25 Apr
 2024 16:18:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424224053.471771-1-cupertino.miranda@oracle.com> <20240424224053.471771-5-cupertino.miranda@oracle.com>
In-Reply-To: <20240424224053.471771-5-cupertino.miranda@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Apr 2024 16:17:49 -0700
Message-ID: <CAEf4BzZRC=pCk=NFpFxdej3XfGnLv5zWkOtQjZLGZ2r-oO_ojQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/6] selftests/bpf: XOR and OR range
 computation tests.
To: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, David Faust <david.faust@oracle.com>, 
	Jose Marchesi <jose.marchesi@oracle.com>, Elena Zannoni <elena.zannoni@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 3:41=E2=80=AFPM Cupertino Miranda
<cupertino.miranda@oracle.com> wrote:
>
> Added a test for bound computation in XOR and OR when non constant
> values are used and both registers have bounded ranges.
>
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: David Faust <david.faust@oracle.com>
> Cc: Jose Marchesi <jose.marchesi@oracle.com>
> Cc: Elena Zannoni <elena.zannoni@oracle.com>
> ---
>  .../selftests/bpf/progs/verifier_bounds.c     | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/=
testing/selftests/bpf/progs/verifier_bounds.c
> index 960998f16306..aeb88a9c7a86 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
> @@ -885,6 +885,48 @@ l1_%=3D:     r0 =3D 0;                              =
           \
>         : __clobber_all);
>  }
>
> +SEC("socket")
> +__description("bounds check for non const xor src dst")
> +__success __log_level(2)
> +__msg("5: (af) r0 ^=3D r6                      ; R0_w=3Dscalar(smin=3Dsm=
in32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var_off=3D(0x0; 0xff))")
> +__naked void non_const_xor_src_dst(void)
> +{
> +       asm volatile ("                                 \
> +       call %[bpf_get_prandom_u32];                    \
> +       r6 =3D r0;                                        \
> +       call %[bpf_get_prandom_u32];                    \
> +       r6 &=3D 0xff;                                     \
> +       r0 &=3D 0x0f;                                     \
> +       r0 ^=3D r6;                                       \
> +       exit;                                           \
> +"      :
> +       : __imm(bpf_map_lookup_elem),
> +       __imm_addr(map_hash_8b),
> +       __imm(bpf_get_prandom_u32)
> +       : __clobber_all);
> +}
> +
> +SEC("socket")
> +__description("bounds check for non const or src dst")
> +__success __log_level(2)
> +__msg("5: (4f) r0 |=3D r6                      ; R0_w=3Dscalar(smin=3Dsm=
in32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D255,var_off=3D(0x0; 0xff))")
> +__naked void non_const_or_src_dst(void)
> +{
> +       asm volatile ("                                 \
> +       call %[bpf_get_prandom_u32];                    \
> +       r6 =3D r0;                                        \
> +       call %[bpf_get_prandom_u32];                    \
> +       r6 &=3D 0xff;                                     \
> +       r0 &=3D 0x0f;                                     \
> +       r0 |=3D r6;                                       \

what if we make this case a bit more challenging and interesting and
have some known bits in r0? like add `r0 |=3D 0x1a0;` before doing `r0 |
=3D r6;` and make sure that we have a few known bits in var_off() and
range is extended to be 511?

Maybe do something like that for xor case as well, making sure that we
have some bits known to be either zero or one?

> +       exit;                                           \
> +"      :
> +       : __imm(bpf_map_lookup_elem),
> +       __imm_addr(map_hash_8b),
> +       __imm(bpf_get_prandom_u32)
> +       : __clobber_all);
> +}
> +

do we have an existing case for AND as well? That seems to be an
interesting one, as verifier should be able to infer [0, 0xf] range

>  SEC("socket")
>  __description("bounds checks after 32-bit truncation. test 1")
>  __success __failure_unpriv __msg_unpriv("R0 leaks addr")
> --
> 2.39.2
>
>

