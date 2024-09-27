Return-Path: <bpf+bounces-40446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7942D988C84
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 00:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7941C20CC1
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 22:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481421B3F37;
	Fri, 27 Sep 2024 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btBELP5l"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8672F1B375A
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 22:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727476778; cv=none; b=l5gDqxmmQIKhyO+0p6gscCs3fsGLFzrKbGwBgaQvn4erf5hrea0YzNcO5rkvZqdxz3ndUB3zXlRCYOwJlsDu9ZBNydc+kbUNO77eydcyjj9M5pEBdfz8ys/rvRHwo7+eSx/fdRElJuY4cH6ccS0g4XsDZLumikcqYkIHi7XbDsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727476778; c=relaxed/simple;
	bh=lPRTwtG+5FdPy8gbKPkhDH1yGdKWYi+M9fAkj5gs6qQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jimMLkOMw3P7n6hlQ/G6MdKmYQULMsgDgJlVMU0FmEBfuspyFWXiAjHvdgzCIsNfeFyg08e61DCr3qam2J1NxMtqjhsnk0yYmqVQItWuX4/k8ujxm29vuQ6FD5SY9hL2BPRZInZ+dQgydunNh8AiU8602Gux+dfYsFkLOQ/KR0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btBELP5l; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20afdad26f5so34003695ad.1
        for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 15:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727476777; x=1728081577; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H23LgDB2UOPG4y5DPKuVkAW3XpwMyJx1PebN0Jf+wFc=;
        b=btBELP5l7meDTTvyWCf98YdKw+PmJ2nzqhQW3b2eRg1h46dzYeQ/mTGF96yggw68Tb
         XsHmGDIcJF11p8gQYtRl0GcFpTmEnrD1MyqWC8fUMRccFNO2bRBDFAN5RFCyvIAp4ZOA
         TdcUdEiVWF0tvr9cNYyhJ5CA0zBVRFONt5sEc2MG9kJWq7eKaR1mH0pUF9zWDzA91uSm
         opcypqHkXiZjjCj+Zg2tUCo/2MOimitoGDJkMIfaK60oUM8Gl+XOZxD8YeFc0UrPSfgl
         ayvBwhLt1mybPI6a5TqA90eKx1xs6jQRFuK2r8QTQfCstvkFyR6Sa6b5v1Syg+PuGGKn
         BfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727476777; x=1728081577;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H23LgDB2UOPG4y5DPKuVkAW3XpwMyJx1PebN0Jf+wFc=;
        b=E39Wn9B+xvHX6Cu0sXi+oZRdRnXylq++D2Sne+yYpQ8PfZn4Pi9z2t1UtLtQBolpEc
         PMDQU9Rl5OY5z2egViO5jX2kvjJ4ahezEAD1uDSudJ++3Tzjnz5zgKEjZXP1+ELw89SR
         RMlIxwg1G9rSxDo5gtJ+PoWdZtu5fMYPaEUgksYtU1rXSwpshqpm7DUnhm/RU/byUROf
         kPfgAEVG2GwPGcleQuxtDrI7NspydFoNQDt5CiY9bFxytV72AEwCgrPXp90blqciCXk9
         HxaSH9ggm+jazNJ29dkTyLa2a+qH7qOI/bULK1Hr7qxcJqjRqQE+7Y+0qkF6KftuRTZI
         ZHuw==
X-Gm-Message-State: AOJu0YxbNXGrfWVzA/PcdqXadouoB6R7poYyuhbeSTIhJ+1/uS0ZDElB
	Hy+kXgojA2mG4GmMAEQpMXXYYqcZPgweW0mV09PLdMdjahKsBLR6q3B1XCkN
X-Google-Smtp-Source: AGHT+IGA2QOGVLKF/0B/MR8phsuGXh1gHp8MK86aM3E/il9bPgEPV/CbNnnKPl3inhkNZF3WG34EGg==
X-Received: by 2002:a17:903:234d:b0:20b:5231:cd61 with SMTP id d9443c01a7336-20b5231d9f4mr22690575ad.24.1727476776643;
        Fri, 27 Sep 2024 15:39:36 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d8ed74sm18068375ad.81.2024.09.27.15.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 15:39:36 -0700 (PDT)
Message-ID: <514848caed1511bcb4f69a2dee7d927214929580.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: allow specifying bpf_fastcall
 attribute for BPF helpers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  arnaldo.melo@gmail.com
Date: Fri, 27 Sep 2024 15:39:31 -0700
In-Reply-To: <CAEf4BzZBoBgdSa-AU-0kJUXsv0yHt54BUOeBb4bBsNiSx-u7tQ@mail.gmail.com>
References: <20240916091712.2929279-1-eddyz87@gmail.com>
	 <20240916091712.2929279-2-eddyz87@gmail.com>
	 <CAEf4BzZBoBgdSa-AU-0kJUXsv0yHt54BUOeBb4bBsNiSx-u7tQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-27 at 15:31 -0700, Andrii Nakryiko wrote:

[...]

> @@ -871,9 +871,10 @@ class PrinterHelpers(Printer):
>                  print(' *{}{}'.format(' \t' if line else '', line))
>=20
>          print(' */')
> +        print('static ', end=3D'')
>          if helper.attrs:
> -            print(" ".join(helper.attrs))
> -        print('static %s %s(* const %s)(' % (self.map_type(proto['ret_ty=
pe']),
> +            print('%s ' % (" ".join(helper.attrs)), end=3D'')
> +        print('%s %s(* const %s)(' % (self.map_type(proto['ret_type']),
>                                        proto['ret_star'],
> proto['name']), end=3D'')
>          comma =3D ''
>          for i, a in enumerate(proto['args']):
>=20
> But now I have:
>=20
> static __bpf_fastcall __u32 (* const bpf_get_smp_processor_id)(void) =3D
> (void *) 8;
>=20
> and
>=20
> extern __bpf_fastcall void *bpf_rdonly_cast(const void *obj__ign, u32
> btf_id__k) __weak __ksym;
>=20
> and that makes me a touch happier. I hope you don't mind.

This change looks fine to me.

[...]

> Looks good to me, and I'm not sure there is anything too controversial
> here, so I went ahead and applied to bpf-next, thanks.

Great, thank you.


