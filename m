Return-Path: <bpf+bounces-64645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD9FB1528C
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 20:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BBD618A4A51
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 18:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5D3235345;
	Tue, 29 Jul 2025 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yrJG7Cdq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297058F54
	for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 18:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753813065; cv=none; b=Ge+01dR5CbaY95Vu522CugcoFlZRaiQ5vtUojXXu2Z7O8DfdfGiwOk1gXNpp44GcCjCbarkJKdudeo8rtg/YNeF6NqvuV5a/qQIeIGrTBQ7k/UFU9N9s/T81PhsNTE7jEEEZT5Ohy2erW2WXsCZQRyFBBAOlTYKN3lkJlqlBck4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753813065; c=relaxed/simple;
	bh=90zZj2Wi/jSSStHprtwOYJEKOACLou5BBOJZbWY93Rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ut+zzdZ7wSFVB6NPT57j0mq90nxxeWIqeZG5557XQnBHPekwqPA7J7FiR/vzH+68/62g2wd9lLs0iR5laRkLcBjBjR/poc/eJucm425WqsfWaxjskMThiruxA/GMaYd68XSZrb+Iy1ctZjMQ69qJnDoUsKlIkYXBEWDYnGsfKQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yrJG7Cdq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-240708ba498so23485ad.1
        for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 11:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753813063; x=1754417863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrELFtAsQyNIYUQCqV5rIFM2vQCd45+6wkPo96+Xm4M=;
        b=yrJG7CdqcQNaR4l81QKevCF+jrOAgwAlYklwQl7+TWhiNpRxitjMTbnmIx8pbVInbs
         M+gt1KliRRCEtc8ekJc8ORdjjBm03q9Q3jxQ5WoyAwD291+GYEoKtmBvDZw5gfLzrrxV
         LKJerj891HEjUvr7j+oL6yAL4n7z25LG1IFIHb9GL2IPdBv4hpluhYtkbqpWCZHoCrZJ
         EE7AdqW2xBmvsaWaSYj2SM9t9LNKVS6tYKdsU9hTgRjLZC1ycpCQF6Eof7aeG5NMMoDq
         pMwJH/9gLtbQoa0YxVMNf0Ipz/ApbZ/Cl0bE6HPDbxiZ0WvaEPUqV7TAbjrcz43PMXgm
         al7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753813063; x=1754417863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WrELFtAsQyNIYUQCqV5rIFM2vQCd45+6wkPo96+Xm4M=;
        b=GCcqWvbMtFxiKltaUj48ZK8u4DGVki3wyg8P+AgX9yaZILvtM/vr7GRf+zfVJ4vPrm
         aivpN5sI+AGUDn8Ie+O7srKosTw7jU5oGNqFvRxiv4LcKc936aSg7TKeJiRSEOH53WHl
         +3OvIbAMQpe6W6v5o4ruO1fgOKlyAG8TZ9D24k57KpOEWzyveUMrYyLrYVpxeTwCWgUS
         vUF2IGLxGeXULKVzKw1gD05kXlQrMj5Vh/doMdyWi4MZPPyDcq5L+P1EThbGSLNKYa7W
         JIZOYlyVTIdAlvdUn9xf9z0HQs7X0udB4ZtKzs7W2yXol4f/uxyG6zV4yT3zS/NdoV7+
         J40Q==
X-Gm-Message-State: AOJu0Yw5xWqq+F936fS3ZKCmF/a/VUXDazswRCdr62zyPh36ja/55ioT
	Rf3Mrm0zKRx8b9g9lEYo9UWjW3BR4vbsN3bLLXFblqpRFd2ro44/VqXZ8zPuAo6/324M08LmUDO
	4soS2FrbniYi9/rSEjpLrJ0fUK1NfVeWTm2g3vVhm
X-Gm-Gg: ASbGncvWRFlcFqrQ2SWncXw5hGEtyAUqkread6+mZj0pnanmmdEk6+VrzODbOburoTV
	EZYpW1WzqMwXD+Pxg4t168Zo0d6J52DJ2z/C0E5GaaRNHAHZQC04T3/2SEaRlXBX8vkA/bBEiVB
	/6szL86wU598oix0Y4fR8SHAdFD9sYpSyztCyHFkMI9xOMjBfBS0qUH6ar5XqRc2SNKqz3bxtGE
	pCF
X-Google-Smtp-Source: AGHT+IH/JGiXh5XiKWwlu4CDnIGhqRo+jwrPA9qHfnd8CZIjwn6cTGQgk7e/thnN52vXlk8rPFqbbZX1d9enm1CVFgo=
X-Received: by 2002:a17:902:e80d:b0:240:469a:7e23 with SMTP id
 d9443c01a7336-2409a044697mr269765ad.20.1753813063049; Tue, 29 Jul 2025
 11:17:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250728202656.559071-7-samitolvanen@google.com> <202507300122.RpqIKqFR-lkp@intel.com>
In-Reply-To: <202507300122.RpqIKqFR-lkp@intel.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 29 Jul 2025 11:17:06 -0700
X-Gm-Features: Ac12FXyTkIKUF3oE37TmSDCsrlZi0YemuCpY3RAC5JJl1HoxExctdyr3bgTjL2E
Message-ID: <CABCJKudjiU8KZoBa+0k9ey5ccPp5E0JhUc5n-DRKbOamSO==VQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: crypto: Use the correct destructor
 kfunc type
To: kernel test robot <lkp@intel.com>
Cc: bpf@vger.kernel.org, oe-kbuild-all@lists.linux.dev, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 10:54=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
>
> Hi Sami,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on 5b4c54ac49af7f486806d79e3233fc8a9363961c]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Sami-Tolvanen/bpf-=
crypto-Use-the-correct-destructor-kfunc-type/20250729-042936
> base:   5b4c54ac49af7f486806d79e3233fc8a9363961c
> patch link:    https://lore.kernel.org/r/20250728202656.559071-7-samitolv=
anen%40google.com
> patch subject: [PATCH bpf-next v3 1/4] bpf: crypto: Use the correct destr=
uctor kfunc type
> config: alpha-randconfig-r111-20250729 (https://download.01.org/0day-ci/a=
rchive/20250730/202507300122.RpqIKqFR-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 8.5.0
> reproduce: (https://download.01.org/0day-ci/archive/20250730/202507300122=
.RpqIKqFR-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202507300122.RpqIKqFR-lkp=
@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
> >> kernel/bpf/crypto.c:264:18: sparse: sparse: symbol 'bpf_crypto_ctx_rel=
ease_dtor' was not declared. Should it be static?
>
> vim +/bpf_crypto_ctx_release_dtor +264 kernel/bpf/crypto.c
>
>    263
>  > 264  __bpf_kfunc void bpf_crypto_ctx_release_dtor(void *ctx)
>    265  {
>    266          bpf_crypto_ctx_release(ctx);
>    267  }
>    268  CFI_NOSEAL(bpf_crypto_ctx_release_dtor);
>    269

__bpf_kfunc_start_defs() disables -Wmissing-declarations here, but I
assume sparse doesn't care about that. Is there something we can do to
teach it about this?

Sami

