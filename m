Return-Path: <bpf+bounces-19769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE5C8310D9
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 02:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E7C4B22F8D
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 01:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA19F187E;
	Thu, 18 Jan 2024 01:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEzu3x+2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEAB1844;
	Thu, 18 Jan 2024 01:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705541235; cv=none; b=aqSDTZ16qo0fbYxMf1uDQoT+Yx9E585FpOWRa414dKgO0xZrT3KAcJg4LbyB4pLM+H8+hg/ytjsRPFb+rBXlpdgJok0eh36BDyflIp/64ECnnFKQKWiyBRrkhfwX29uRiqLMy6Adub4i7uBr3AAqyQiKVfW7I2IVEDIdwWtjczE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705541235; c=relaxed/simple;
	bh=Hk1KDxh3cvSmHJU8ScEGpXDI1peSvh9pQwnB28vVWbw=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding; b=KGdEkl0dg+wZxSdS1WlfJp9gQnZfBNZMvwjdwurBti/bOICcSDc6RvQ3Isz9hWEQ2aKT3WOOqLJCikbR7PW98xzRddyyb2g3fJ3p76SsW5YZ4AfTLSZqHDh5e80uOS9NzzrB5lpi/Fym/lTjuznaAH2F32628ngu0tcaG17kd3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEzu3x+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAA2C43394;
	Thu, 18 Jan 2024 01:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705541234;
	bh=Hk1KDxh3cvSmHJU8ScEGpXDI1peSvh9pQwnB28vVWbw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FEzu3x+2nEU5ma4yXLtNM6XnDcc5TAn4z80twzMg3qo5b1OoKyPk6o6v5F15GhsHU
	 ZCpZkSR4XUDYenUgHdlmN6PsYR9gZugAl6A0m8lDUozOFD2r+hRQhpymStLjktJXG7
	 ltmGkkPaxIx6QZZxE2NEt2umT8QO1tbd3e6H0dCsS84YBhgBlU882YzluyNmsRd6df
	 YyKYPr6R0YC5hqza+0qIsBpQcSpHjamR439o4vdfKlm6dmFfPbmVuxjOk99clBSJ29
	 2EwNsl01/90m2nSqcs4ONtrQbydO8o56/aGhnxRVsrPDuw2DBD4AXb2dhRZk0kAMVQ
	 Bz3Sk1kfDWR5A==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e7e55c0f6so14222176e87.0;
        Wed, 17 Jan 2024 17:27:14 -0800 (PST)
X-Gm-Message-State: AOJu0YzC4xmS+8ZcIMjx25x6Ukj6bKU9SuyJWp3DQsrC7i+BawZKCYB+
	oUmg1wISVl4rpVDRz5o8JuwEUXQ4TpSlz7K+SJZTYIHvigVVoAfRS+Xm2tQ21kX/P1iC+NC3oAE
	IScuVyiTo+PPHHQS6A9SaTFJCn9I=
X-Google-Smtp-Source: AGHT+IHFVj1h4NrUJM5DgTtZ3OazLBRUllGlFxuXXXAntr++swpTVCVGk7515X3yI+rbPMN+qFRcG59M4c71zEE4U3A=
X-Received: by 2002:a05:6512:3d04:b0:50e:76b8:e754 with SMTP id
 d4-20020a0565123d0400b0050e76b8e754mr23197lfv.141.1705541233006; Wed, 17 Jan
 2024 17:27:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117111000.12763-1-yangtiezhu@loongson.cn>
 <20240117111000.12763-4-yangtiezhu@loongson.cn> <CAPhsuW6mWoQQ1M-uPE_i+RWv=t5GaVqUDAObWgpEC-PCYSbwHQ@mail.gmail.com>
 <342f1c7f-a8d3-dbba-a45f-66fc672883be@huaweicloud.com>
In-Reply-To: <342f1c7f-a8d3-dbba-a45f-66fc672883be@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Wed, 17 Jan 2024 17:27:01 -0800
X-Gmail-Original-Message-ID: <CAPhsuW78ONz23-X_6AKt1SfVfepfNP=h=EUAjtUG+K1cKMVH2A@mail.gmail.com>
Message-ID: <CAPhsuW78ONz23-X_6AKt1SfVfepfNP=h=EUAjtUG+K1cKMVH2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 3/3] selftests/bpf: Skip callback tests if jit
 is disabled in test_verifier
To: Hou Tao <houtao@huaweicloud.com>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 17, 2024 at 5:11=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi Song,
>
> On 1/18/2024 1:20 AM, Song Liu wrote:
> > On Wed, Jan 17, 2024 at 3:10=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongso=
n.cn> wrote:
> > [...]
> >> @@ -1622,6 +1624,16 @@ static void do_test_single(struct bpf_test *tes=
t, bool unpriv,
> >>         alignment_prevented_execution =3D 0;
> >>
> >>         if (expected_ret =3D=3D ACCEPT || expected_ret =3D=3D VERBOSE_=
ACCEPT) {
> >> +               if (fd_prog < 0 && saved_errno =3D=3D EINVAL && jit_di=
sabled) {
> >> +                       for (i =3D 0; i < prog_len; i++, prog++) {
> >> +                               if (!insn_is_pseudo_func(prog))
> >> +                                       continue;
> >> +                               printf("SKIP (callbacks are not allowe=
d in non-JITed programs)\n");
> >> +                               skips++;
> >> +                               goto close_fds;
> >> +                       }
> >> +               }
> >> +
> > I would put this chunk above "alignment_prevented_execution =3D 0;".
> >
> > @@ -1619,6 +1621,16 @@ static void do_test_single(struct bpf_test
> > *test, bool unpriv,
> >                 goto close_fds;
> >         }
> >
> > +       if (fd_prog < 0 && saved_errno =3D=3D EINVAL && jit_disabled) {
> > +               for (i =3D 0; i < prog_len; i++, prog++) {
> > +                       if (!insn_is_pseudo_func(prog))
> > +                               continue;
> > +                       printf("SKIP (callbacks are not allowed in
> > non-JITed programs)\n");
> > +                       skips++;
> > +                       goto close_fds;
> > +               }
> > +       }
> > +
> >         alignment_prevented_execution =3D 0;
> >
> >         if (expected_ret =3D=3D ACCEPT || expected_ret =3D=3D VERBOSE_A=
CCEPT) {
> >
> > Other than this,
>
> The check was placed before the checking of expected_ret in v3. However
> I suggested Tiezhu to move it after the checking of expected_ret due to

I missed this part while reading the history of the set.

> the following two reasons:
> 1) when the expected result is REJECT, the return value in about one
> third of these test cases is -EINVAL. And I think we should not waste
> the cpu to check the pseudo func and exit prematurely, instead we should
> let test_verifier check expected_err.

I was thinking jit_disabled is not a common use case so that it is OK for
this path to be a little expensive.

> 2) As for now all expected_ret of these failed cases are ACCEPT when jit
> is disabled, so I think it will be enough for current situation and we
> can revise it later if the checking of pseudo func is too later.

That said, I won't object if we ship this version as-is.

Thanks,
Song

