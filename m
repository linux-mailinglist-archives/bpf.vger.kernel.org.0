Return-Path: <bpf+bounces-15793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BF67F6AFA
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 04:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23EB1C20C00
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 03:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B26815B7;
	Fri, 24 Nov 2023 03:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSwkSnum"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD6FD59
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 19:39:36 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9c41e95efcbso198813166b.3
        for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 19:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700797175; x=1701401975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AxM/397NlPzNRK/H7SySe3WL2qSduvfIVBxrFcCqxM=;
        b=NSwkSnumK9FHP8EZ51xbUtsECFfSJJQaoEyZcAmKEp8NML4KrP3iIrhrY9KU9IAx3f
         oTcZ+kLEWQAKpZrAnrnBiQDNMIUFoLJd0OnZsun13wozujTsjxWZuMzudSD265S6UYZ8
         UjyASo9tqzXLmZZHrn6IV0oSSRyWRN/dpr6URxUMFLF0MrXswY98Sz58pODx9GBt/4yy
         WadpsAWZ7Ujtwz864f6qz2QwPtPJ+rRBpJ3lxe+7H2jbgr/T61xg7kmgAEl9ysQOJM7Q
         PoEwkItvXz3eQg8KAYiv7RGa6mNfndIo9kUnuHyCKDfsUET0lLz8tXt3HaC2wnBthbii
         MV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700797175; x=1701401975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AxM/397NlPzNRK/H7SySe3WL2qSduvfIVBxrFcCqxM=;
        b=PhuzPkCV6knZkpOPu8oscSX+DkBjzckNEQdRa1+osi+A5qAb6awRx2XYZJIwQ1RVdp
         5eN8+v4MGqQQ9RFcAsXz7L3NYUskab1EllcMtoxvnqhv/PKOcjtYAPiOufIwIm9HAy+1
         aQ8w9wVD4kY2GPFnvDuH0GBty8BdGwipmdRCUKxMFTV+uurjJNxdRvcPaNNCjsTJZEu6
         Dz9YDJ/TcvjHmcsiN/oSl8kBs9Mu+9cNHAdT/hP2kdcbtVWZVZxHfLBOlvrKC4owEzI8
         wRAwuNzhEEpmk3VTgp6gHTe6yk+dV45SzJp9lFn9ljFQjsoxIbpxE2mfJN7dx8tPRg70
         zGgg==
X-Gm-Message-State: AOJu0Yyogk5YcNLAdbgkoHXIrEIoWXkW7T+SnkyDYTXMGPkts8OYr1Nz
	uXkZf0pAtjK7iQIAZhyL//wkD6mJotYLuIyhii0qlQsU
X-Google-Smtp-Source: AGHT+IEUiSHmVFOH900LpL1fGMinfbPh2+sNZxj3mU0avhbn6jL+kewljnM+6e8kqaCdzSZtJhrQdj9phYTDAMpgWYE=
X-Received: by 2002:a17:906:74c2:b0:a01:a1d0:9431 with SMTP id
 z2-20020a17090674c200b00a01a1d09431mr805399ejl.1.1700797174905; Thu, 23 Nov
 2023 19:39:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122011656.1105943-1-andrii@kernel.org> <20231122011656.1105943-3-andrii@kernel.org>
 <20231123014416.sm2pcgsfiptan6wf@MacBook-Pro-49.local.dhcp.thefacebook.com>
In-Reply-To: <20231123014416.sm2pcgsfiptan6wf@MacBook-Pro-49.local.dhcp.thefacebook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 23 Nov 2023 19:39:23 -0800
Message-ID: <CAEf4BzZj9p7jsp8EkR+NzEZsnnAxqecT_JC+aPGNFYh9r-0tNA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 02/10] bpf: provide correct register name for
 exception callback retval check
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 5:44=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 21, 2023 at 05:16:48PM -0800, Andrii Nakryiko wrote:
> >  SEC("?fentry/bpf_check")
> > -__failure __msg("At program exit the register R0 has value (0x40; 0x0)=
")
> > +__failure __msg("At program exit the register R1 has value (0x40; 0x0)=
")
>
> While at it...
> should we change tnum_strn() to print it as normal constant when mask=3D=
=3D0 ?

sure, I can add that as another patch, because I suspect even more
tests would have to be adjusted

