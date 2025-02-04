Return-Path: <bpf+bounces-50438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009EEA27997
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 19:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C437F1629BE
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01313217651;
	Tue,  4 Feb 2025 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEtyCEKj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B7821767A;
	Tue,  4 Feb 2025 18:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738693067; cv=none; b=iWXPRHBJsJL+te37oq8coOpUfK3FfDeHDc8C0g0Ypfym9WxhzL5lan3wGp2rGunqJSJLd/WIJLKZ357ZtK/JrLmSjGd6IZskOI+Ye370ibGAy2TzLwdvk0lf7dadyPbuf6GLbL+rO7AsTytuSFEYph+QEMsiD9RyTZ1OYXYULRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738693067; c=relaxed/simple;
	bh=KPVeBz0SWa6qjwv7eHWyY+fjdV93kp8SSrgjv9BPOuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DhBaFCBwN1Xb1jqsv/+V8eN71HF7leJpRqEPtPUojGgMECidl7ELEcuwDYd4J+rH/Lo5SMa9Ky4HFagqTDpfciM28PI0PtHjRCwsZbFVsoyKk5W8RcOOJ/S63OdYUawm1KbkrUOBUHY22DSsEkO1qCQO94aAWfoba/X04Q2MFdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TEtyCEKj; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so5053370276.3;
        Tue, 04 Feb 2025 10:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738693065; x=1739297865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hh1ZvtbHsl2Y+EOTOMjwX7uyQ0eyt9YhGECmUVxcQvU=;
        b=TEtyCEKjwZzAzzBgRbzn8+rPc3DglbGYzepclKeyyTRIvN/txEVjW4EAfVrc+L6Td2
         DxLEl9OV8ZmCkQ67hCCA1TIh2k9B9OvwOv8loZSG1bX+N/JgnqFAN3QbBLU34pcz10W+
         nCDXr0+wkceTQLfQfaE+0Iim1PDsiZS82ZmA+pTUw/JQ8x/lT6P/jVdZKcDqZy80KT8R
         SbuvbOUSLZlCrraCHmXZBEv2yFHI5ZI/8ZC332WscVM5Zzm/r+ff6TjQJ2y0rJr3VPSZ
         vlBm+GhjnSam0Tin71cgrWnyJiBpEMYWs0TJDQs/uLVevbkgr9hgjbe8lo4AmI/v5w0x
         VMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738693065; x=1739297865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hh1ZvtbHsl2Y+EOTOMjwX7uyQ0eyt9YhGECmUVxcQvU=;
        b=jUqxXmPwwubm+gTKlyzNFIQ+p+bu8T44uB5iCGeHtDvPXWDd7ANx05lZyRNm4bkFME
         23KNVjftpajYeKPxeLTTiZR/Vi9ye7puCAnw8asJrg/DK3PtCkVm/hB3vgmPwJK3+nvj
         dCC2dM76jgEod8O8P092UkU2HCdUG4EtmMOLdJ5xsTmi1Du+AHWfcezXbthxwAZwiwsn
         Asc5S3jjU00yDoPMdHsYCMgoaJZgrjKaTxsRCjxmdKXm1PDzTBrlltgmiKnFwLN+d3mq
         qP5wrrfuJzNSpKKF1oX141CCjUJYR6CfTVlazFdJQ18X3r3EZfBpFcRJa65uqVwHRBYN
         afpw==
X-Forwarded-Encrypted: i=1; AJvYcCVzw3c32UgMrow0pNtb8shQWZmFxaSiqphV053YJfsiloTi887FH/uoBr1cr7FRDoPTyAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz2ClcW0DqgrAwuJrTVaUTGb42mkzhzY7o6J+iBa/5GbCheeKA
	PaiZ1M2DbUSL/pjgGpT0ZHVIz7LapvwKSmow35eNQAF7oYoNj6RZLLXQhuBCbyMYpbCJbyoNyNB
	xAyOVj4hYOZInDUAnwSC5+qopvr4=
X-Gm-Gg: ASbGncvAY34VsV84tnDk5eyQQ+Z1socTD4ZOFuuJZso56huesREcuSctQvCGNSZvwuf
	ikjCjXPMKsFRuNR56ZsQIpwSIWSePDhaoCkqJmRENLq7IvNF2ZzEpJsG0I/Qz/4yv57fmLyz9Cw
	fdAl0U4PJinXGm
X-Google-Smtp-Source: AGHT+IHscn+73qeGvOlZ36mYTUosmtaEFvS1sTch5qV8+DqR84ESMWl65Ji/acjcqIXOHuYWZljmKnYiAd6ioUNFw1w=
X-Received: by 2002:a05:6902:2d03:b0:e48:5b35:af2e with SMTP id
 3f1490d57ef6-e58a4bbe7damr22139992276.33.1738693064763; Tue, 04 Feb 2025
 10:17:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131192912.133796-1-ameryhung@gmail.com> <20250131192912.133796-19-ameryhung@gmail.com>
 <857a9d504cccaf046d869c34a85e970513a403af.camel@gmail.com>
In-Reply-To: <857a9d504cccaf046d869c34a85e970513a403af.camel@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 4 Feb 2025 10:17:31 -0800
X-Gm-Features: AWEUYZlXKrUQUPPBN9OKUleD1ykIWzsqs_swK3rGk9YOAkM7-vRlX1LqsNwBelU
Message-ID: <CAMB2axPYaEMkv8W9MWNTYsr=+1w9xUUs6FUcW6zJDMyg=giJ7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 18/18] selftests/bpf: Test attaching bpf qdisc
 to mq and non root
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, alexei.starovoitov@gmail.com, martin.lau@kernel.org, 
	kuba@kernel.org, edumazet@google.com, xiyou.wangcong@gmail.com, 
	cong.wang@bytedance.com, jhs@mojatatu.com, sinquersw@gmail.com, 
	toke@redhat.com, jiri@resnulli.us, stfomichev@gmail.com, 
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn, 
	yepeilin.cs@gmail.com, ming.lei@redhat.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 9:58=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Fri, 2025-01-31 at 11:28 -0800, Amery Hung wrote:
>
> [...]
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c b/tools=
/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> > index 7e8e3170e6b6..f3158170edff 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c
> > @@ -86,18 +86,125 @@ static void test_fq(void)
> >       bpf_qdisc_fq__destroy(fq_skel);
> >  }
> >
> > +static int netdevsim_write_cmd(const char *path, const char *cmd)
> > +{
> > +     FILE *fp;
> > +
> > +     fp =3D fopen(path, "w");
> > +     if (!ASSERT_OK_PTR(fp, "write_netdevsim_cmd"))
> > +             return -errno;
> > +
> > +     fprintf(fp, cmd);
>
> I get the following error message when compiling these tests using
> clang 19.1.7:
>
> <kernel>/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c:97:14: error:=
 format string is not a string literal (potentially insecure) [-Werror,-Wfo=
rmat-security]
>    97 |         fprintf(fp, cmd);
>       |                     ^~~
> <kernel>/tools/testing/selftests/bpf/prog_tests/bpf_qdisc.c:97:14: note: =
treat the string as an argument to avoid this
>    97 |         fprintf(fp, cmd);
>       |                     ^
>       |
>

I am removing the use of netdevsim and along with this function in the
next version. The warning should also disappear. Thanks for the
review!

> > +     fclose(fp);
> > +     return 0;
> > +}
> > +
>
> [...]
>

