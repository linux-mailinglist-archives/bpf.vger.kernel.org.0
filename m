Return-Path: <bpf+bounces-63444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B3DB07853
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 16:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3219188D4DC
	for <lists+bpf@lfdr.de>; Wed, 16 Jul 2025 14:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6F9262FC2;
	Wed, 16 Jul 2025 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxnAO2U+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC85119F40A;
	Wed, 16 Jul 2025 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676859; cv=none; b=MPK2yRTKQ3t1rPj4aMDp78WfbJMWskxF0c/rDhSjWwS9I4fAsO/ojqApuho9kZAn1rYCzd7uWrS9A0MayIYGS9qUE7PD04ysCOhkK16kEQmBO7h2cWabTScx3W+cuhIEX3cpO1jh4RkYDo6EpoCNHbcjfLTW0d6fjo9DSxE5HYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676859; c=relaxed/simple;
	bh=pfwYeQ0lSxFqkmbHNbtiMcwWyHLPm2mIdKPW8D3rFWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSSRLPHLdQvqxSWtKh3Xf20CFYKqbdmj6TVhBAZm2Vv3a+SEYrfAp5sVMlrKSfEOWqQ4TlNXWPObFx8Pkk56aSDck2V2YArz7P0Ad87CYi7EujIeqaMDRPikdF1AADFqQLKP2JvvLQqxlemp0z8iwSQ9mb31rsz6a0skWB+BEz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxnAO2U+; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e8bd171826cso315362276.3;
        Wed, 16 Jul 2025 07:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752676856; x=1753281656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfwYeQ0lSxFqkmbHNbtiMcwWyHLPm2mIdKPW8D3rFWA=;
        b=CxnAO2U+dEL/tkywJlpiZnh46YQfJZFgAQ2VXFpsR/EhweHqf5uSjgJlgpX0hFH5jz
         cMWZB8iJKS1KrR24wpDjabEFLJIcIwMpJJDPtUkq+zuenicwONYDOFNFqbZsIlFwT/An
         dzO0V3VzlO6ZSgycTY1+JkIpuZUM1UgtJZdqgL2DDINWcKr4hFdVssLRioxB/jjS2Yos
         70qqUgKU1b/QPSs2ERdZGiHGG/r9aD1RR7HjFrmAMetU+IXvGx5c71lSfjRb339DG1cV
         iP1mR7cUH5oEJWt0OkKYqrC9wB7IyzHAzy1mJm8JMkAc0DGzSHUZa1x4eDBaD2uUcby1
         VW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676856; x=1753281656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfwYeQ0lSxFqkmbHNbtiMcwWyHLPm2mIdKPW8D3rFWA=;
        b=gkUExtFWo8OzdS6+grI/8SRU6p2ZyfeXJpv//JTKTdCSlquoYPwc45/epyDx4n0v2r
         YDoGmbuHiwfszIw6Df1KROyEIO5/RYluW4leNOJI823EzsN25uRXHliFA+1WhlO8ZbX4
         ISTol/J0Rbr0WR8NniZB5HxYivAITj79ppbkhJpG19NEQZVSbYE1dJwcPokQUtaGv7sQ
         FgkJajn2yZFDf940xtJvk3SFokiupK8BU46131j4XKfli4hLih9J0xzd7zjrwQCX0tof
         aO+u2IFAwrsaTAGx8RuDO/OY/UnZpxzAiLX/cqVxnSdB9EUEdIQ1eAKzeoRdJiKrJxc6
         sWaw==
X-Forwarded-Encrypted: i=1; AJvYcCU2YUWbOzRt68e4k6cbxN+cYqjbS1Vjx3vspDpnCULkfmkYs419t9GwdaWo5+/lHHI3MEDMNvfsF3iEz+7a@vger.kernel.org, AJvYcCU8aDc4uAsVlX3HEmownYcqJIurqz1g+iFuCrT1Hxj1hN+jPTxiZqu9pifjTJmZ0bxh9s+3YLRx@vger.kernel.org, AJvYcCUR701OLNhTic/i0UVnJx6uKMovU09sWvsw+0B1NVIfCDyPMp8lX7mNua6wR7kVhCvdVXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYrTlwbCActBEG9qS345Ar2XUtg1ewUNNuqI/uNn5FyD6/N7SS
	2YRVgpYu7G+6xXBftRCXs4+71csYfUMuL8880bJPv5t3cA6TyH3Zhlfk8Qws7wMOaoXwWwP8DYO
	6sTYexg/krcLZaC2M2GmjoBo7zg2263W2GpQ7q5pLYA==
X-Gm-Gg: ASbGncvLivG/ftp0L90vALGXQ+CpGpdRHVRg83USKiDy7pFXMOSMYTjyH4v26KAWHlr
	llVHlHhP+z0LDa2NidILZ8OAs2Wk3PdesgTtC86VelQlEqyaBK0efVBbd3blmozOpRzTC9UgbhN
	my0pD0VcG8qmc+O0uBjVhCQqY37vQtiJgyXv0WLxq8wYrbmVDFv2d+nAATC4EqUJSluMpwKXPyL
	URJG0o=
X-Google-Smtp-Source: AGHT+IEEsGkjeJRr+4AxB4v8yEdFBdHjv0f7mCtSLB+EbeD9EY0YJN/yeyk9YT3I1MCKXufJeinGe9qxBV4f6r3UUfs=
X-Received: by 2002:a05:690c:3693:b0:710:f09c:b00f with SMTP id
 00721157ae682-7183712dc18mr40453547b3.15.1752676855537; Wed, 16 Jul 2025
 07:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-3-dongml2@chinatelecom.cn> <CAADnVQKP1-gdmq1xkogFeRM6o3j2zf0Q8Atz=aCEkB0PkVx++A@mail.gmail.com>
 <45f4d349-7b08-45d3-9bec-3ab75217f9b6@linux.dev> <CAADnVQ+7NhegoZGHkiRyNO8ywks3ssPzQd6ipQzumZsWUHJALg@mail.gmail.com>
In-Reply-To: <CAADnVQ+7NhegoZGHkiRyNO8ywks3ssPzQd6ipQzumZsWUHJALg@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 16 Jul 2025 22:40:54 +0800
X-Gm-Features: Ac12FXwhFnOEikntgmWcObUoZ2zctoMhZNba-RlPeEbc7K2an5Dl4pIZ79cUM88
Message-ID: <CADxym3bT8P796Qqcd0mtJwR09bgs0Bc45GuPkb39ELLsg1MQ_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 02/18] x86,bpf: add bpf_global_caller for
 global trampoline
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Menglong Dong <menglong.dong@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 12:35=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Jul 15, 2025 at 1:37=E2=80=AFAM Menglong Dong <menglong.dong@linu=
x.dev> wrote:
> >
> >
> > On 7/15/25 10:25, Alexei Starovoitov wrote:
[......]
> >
> > According to my benchmark, it has ~5% overhead to save/restore
> > *5* variants when compared with *0* variant. The save/restore of regs
> > is fast, but it still need 12 insn, which can produce ~6% overhead.
>
> I think it's an ok trade off, because with one global trampoline
> we do not need to call rhashtable lookup before entering bpf prog.
> bpf prog will do it on demand if/when it needs to access arguments.
> This will compensate for a bit of lost performance due to extra save/rest=
ore.

I just think of another benefit of defining multiple global trampolines
here, which you may be interested in. In the feature, we can make
the global trampoline supports functions that have 7+ arguments.
If we use _one_ global trampoline, it's not possible, as we can't handle
the arguments in the stack. However, it's possible if we define
different global trampoline for the functions that have different arguments
count, and what we need to do in the feature is do some adjustment
to CALLER_DEFINE().

Wish you are interested in this idea :)

Thanks!
Menglong Dong


>
> PS
> pls don't add your chinatelecom.cn email in cc.
> gmail just cannot deliver there and it's annoying to keep deleting
> it manually in every reply.

