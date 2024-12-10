Return-Path: <bpf+bounces-46524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BC39EB57C
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 16:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE134283696
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 15:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A335E22FDFC;
	Tue, 10 Dec 2024 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxNtStWp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844D419ADA2
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733846235; cv=none; b=V+cgwm2RYkg3LEvTRpZAIpc9QY7tfA3D3dX2Fcx8eK2GXubMhm23SO5Foj3MamY6bfC12EENYF0kMOBDFKPhOcK587BI02pSx9+e8d8YSO/ACzZysMYpmz41B7b/F8lsXPP4+dK970H2z/9YxVTF5e6h6HEis5WGdxTjVWDWyHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733846235; c=relaxed/simple;
	bh=oitWE5XaqMG7OdMPVDRBlfpg3bpR3YYHHGeSzCo5u1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=InGWU7qpTCUmx8ys63ncqz9eZl6Ii3IfIpIT4rNjU28X8vk5qsHgHCDmIMAykSmS86BTW1sxt2DiV6uLlptOaHTjNff6Vh90nPVaJGro5ntCXM3F4C7HXnyWLkXw4tA+qOxqf65yhdYHfpSffqit7pSqVpAWRZ9TYsoElLqApY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxNtStWp; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385e3621518so3798614f8f.1
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 07:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733846232; x=1734451032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xgJC/roxJR0iyE0LEc3IYZ4dUxnZ3ApZCDyQMQSyBw=;
        b=LxNtStWpHqATE2DFWE1gqsEhJf2MWK4ePzGj+XXtVNm+/+7e5tKjWyDYegjFZJFqzg
         xi4pZ8FNmv6BNvNgW5If1/8ZvXHonQdGPt/sgw9gzdHqhxnrBtWqyQ2yKp0w1QgHBda0
         ZTI1nPPyLIF4ha7r0N77Yqq24lMFqDDhlIOSyx0AsPgdDMC0EvDRa1i1LkaEhG6YCmq1
         0fJ83ndyRv9lftOwomxcEU9lh5xN3SVe75cFXaJYDBnSX/ChI/P83SpttYyfIA1FuL9D
         nRbll2mthgzG2UGTEVGlttGNNawuY128kklkBt+jpULnUJ3dyy1rD7NXL5NRuw9sgBz5
         5d2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733846232; x=1734451032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xgJC/roxJR0iyE0LEc3IYZ4dUxnZ3ApZCDyQMQSyBw=;
        b=ZcbyZeyH5uqTJxHXsB/Qoa8QDegAhgZV+jefDhooawbb9+QkJevftgzQg0+o2O6Sqj
         vRos4x5k7J89ryEEFrvTucqWJNbf+zEo5TjYY2A3sMzB4TfiMGp98KCw8NCVBJWwFcax
         dH1+miU61MHnWm4YdsRc5BA7naOHnxKywdlJdhtlGKte528Ut639MQ+7l6RiQX6tmqM4
         aNWFgC30+6eBLgJs7MUc/rh4FfQOcrBwKlgDief3x/tujC85Rk9bn7MSmcvv8Xj3voKN
         AlS56QBc1Bmhz5tjP+NcwjA3k+k0jaybOx2zqt2OT8tlLbCxYU+r18HFUuKB38QgHsCx
         TYVw==
X-Forwarded-Encrypted: i=1; AJvYcCVuROoSA3sWUby4abFEXCYmaWtqAHhav5Lo8UcZE44qXuUZpw1pU+pzNC5iEIOXDeSDkTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKpyCK/z03Cf7OlpioTEp9KQciu/yeWeOIEBGcEAw5sOcbHFgt
	J/+lkNuYbkxr7LfOq9ZM7XimiVYDUycmO9qfUzBBdXd0DukR/n9L/Qeo0zFGlVIAj9dFyzt5GJP
	YHyTBSD1sKFK5Rk3Xms+2vv/QHNE=
X-Gm-Gg: ASbGnctVv4hlKEtrQc09Hnv9URiFjeoo9BFhsFtppAv+2euOR7XtL6RSvc2EakEfNra
	N1c9nHYSZXFw8N6/y1mYyClP9uJiyNjOLgrLjQKrZxvJOpGnwCoo=
X-Google-Smtp-Source: AGHT+IH2KxcFywAJCiNtnbp4s+Faag3Q5hDg5/Vpf6ogzwb1Ot89J/Sk2P4SwatE9oao99N3efaNTcRq1avEBsR3UgM=
X-Received: by 2002:a5d:59a9:0:b0:385:fb59:8358 with SMTP id
 ffacd0b85a97d-3862b3e3196mr12389345f8f.53.1733846231446; Tue, 10 Dec 2024
 07:57:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203135052.3380721-1-aspsk@isovalent.com> <20241203135052.3380721-4-aspsk@isovalent.com>
 <CAEf4BzZiD_iYpBkf5q5U9VoSUAFJN8dxOBWNJdT5y9DxAe=_UQ@mail.gmail.com>
 <Z1BJc/iK3ecPKTUx@eis> <CAEf4BzZVkNRV+8ROMMM-oGdHd1HUSx3WVv77TK+H4Fr8PhHHBQ@mail.gmail.com>
 <Z1FnPIuBiJFMRrLP@eis> <Z1gCmV3Z62HXjAtK@eis>
In-Reply-To: <Z1gCmV3Z62HXjAtK@eis>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 10 Dec 2024 07:57:00 -0800
Message-ID: <CAADnVQJyCiAdMODV3eVxk-m6C3xAR0mKCJYgYqUzcXypKcWwcQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 3/7] bpf: add fd_array_cnt attribute for prog_load
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 12:56=E2=80=AFAM Anton Protopopov <aspsk@isovalent.=
com> wrote:
>
> >
> > This makes total sense to treat all BPF objects in fd_array the same
> > way. With BTFs the problem is that, currently, a btf fd can end up
> > either in used_btfs or kfunc_btf_tab. I will take a look at how easy
> > it is to merge those two.
>
> So, currently during program load BTFs are parsed from file
> descriptors and are stored in two places: env->used_btfs and
> env->prog->aux->kfunc_btf_tab:
>
>   1) env->used_btfs populated only when a DW load with the
>      (src_reg =3D=3D BPF_PSEUDO_BTF_ID) flag set is performed
>
>   2) kfunc_btf_tab is populated by __find_kfunc_desc_btf(),
>      and the source is attr->fd_array[offset]. The kfunc_btf_tab is
>      sorted by offset to allow faster search
>
> So, to merge them something like this might be done:
>
>   1) If fd_array_cnt !=3D 0, then on load create a [sorted by offset]
>      table "used_btfs", formatted similar to kfunc_btf_tab in (2)
>      above.
>
>   2) On program load change (1) to add a btf to this new sorted
>      used_btfs. As there is no corresponding offset, just use
>      offset=3D-1 (not literally like this, as bsearch() wants unique
>      keys, so by offset=3D-1 an array of btfs, aka, old used_maps,
>      should be stored)
>
> Looks like this, conceptually, doesn't change things too much: kfuncs
> btfs will still be searchable in log(n) time, the "normal" btfs will
> still be searched in used_btfs in linear time.
>
> (The other way is to just allow kfunc btfs to be loaded from fd_array
> if fd_array_cnt !=3D 0, as it is done now, but as you've mentioned
> before, you had other use cases in mind, so this won't work.)

This is getting a bit too complex.
I think Andrii is asking to keep BTFs if they are in fd_array.
No need to combine kfunc_btf_tab and used_btfs.
I think adding BTFs from fd_array to prog->aux->used_btfs
should do it.

