Return-Path: <bpf+bounces-46767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C68E39F008B
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 00:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524341881A39
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 23:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E261DEFC1;
	Thu, 12 Dec 2024 23:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXNfIm3w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF19E1547F5;
	Thu, 12 Dec 2024 23:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734047598; cv=none; b=RrOQ28piP9pQKFA6yv2aO9f5k5wd8kq6JvgqtFwZlL/GvYv8vHXHn6tb6xXF7aGyXooFWYdJk/MHcC5EGLFis+b9wnFdvZlGFhFYjV3geZfHgi2uRkvAp8YI+ieCoArNxTmZnCGNz+Qy9N37ZU46RHWfFigc3C5nzv2MQViDmsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734047598; c=relaxed/simple;
	bh=q/BFDvTD+XNDmTs8p8/kib7zSnWMPGFmxweFAg1eUuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WY3o0m8sdQ4l/VnCxTEpawQXyS+k0cnLSrT/uw7KYMdgOwACXMkkwqEot7LiVsmi+JC5oBoxo7YHoJwGosDfBcnWkvmmTVb6Z8FuiS2GaMAsePmlI/s30j1tuXQf6e5EfXAf9iE+b0FOKf1t31eTMhyn0MFH5v1NlyEbbgRbTtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXNfIm3w; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2ee67e9287fso1034174a91.0;
        Thu, 12 Dec 2024 15:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734047596; x=1734652396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QXCu0v5SnxIo/0aSLhOo9DU4qZRN1PKMZDr7ioEmoo=;
        b=mXNfIm3wXu+j+di6DT7QDbrskx/5bIGGOKhPNLZuGzj235F8jeByAF5OPYvjuVIlfy
         EejwyI5mJyCQnyoTGpnU4Smog82TAlJ8faWmtJJVj6/1UvBgmPXgka2K4fepq7LT7BKj
         RhpkFhejNLIEohffCT5hBMoOp9vrajNxWIqrY1Fzm9vJdK2vB3SkJ68htVErl4nGnVEf
         A08+93JWXu+n4ICHqcemI0lTCl2cUvvxkuBOIouAVgTXk9VbCvaHg2beQL82AOWfoTaO
         5PoVt+Nt5FxCKJFdRbVtgdimvhXl3CdkZXxJrqMP0e+Wp0a80jPc2YXXqBgEdZDVxS5i
         LqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734047596; x=1734652396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QXCu0v5SnxIo/0aSLhOo9DU4qZRN1PKMZDr7ioEmoo=;
        b=WYnqBQ0r7hw9Pnl+d7Hg6vvlT25+mKCxPmUwOgh7/PsEB0Xrz7hqXZmSw2Z1F4uEe9
         fzevWimJVgigj8Khuf1xgvhDn9AcPEPRt8a77yAt+CWb2kROlBVlR7MLdaeg3d80lMne
         ekZpPTS0qgKc/IuVdN4OivEPVuOoGZj0N1/tbgkscXs8Z+3sfR6bVG2o0UFJ2U+S2lk2
         bBRN7AwH+l3/49p0y2n5w/zukLpZxZKUP1iKmb9MN7gz+TA5agImArx4Q+HOu3aXOGuI
         L6NveWYS6CtbQRV3SzbaNBiluPd8iJWMniFU9xjR62d5OLTlFY7hg4h1MnNM2yohm5R9
         l5/A==
X-Forwarded-Encrypted: i=1; AJvYcCU1GIaGb8Fo7c1OsI1K+Sa9JvNvkVmkHnsDzNSfH+zoRhUswaHYZ0ejn+es7EDdwQG35L5GOpzpU+TctX14Tgyevg==@vger.kernel.org, AJvYcCUI8thUqF8/cAzZ4jOqNkiH2rF/gSG94JIgbnb5frPLBg+QWLLelCUY342pVzfRKrXV1b8=@vger.kernel.org, AJvYcCWJoEP3+T37ENW335LXbkl6bUX9Ng6MINcUeuRGRGZWaPZ5SjW/2bL/dxNmGRb8r3nvQ6L5C7X9NMfNyU/7@vger.kernel.org
X-Gm-Message-State: AOJu0YwABFTPDw/k8dgRaC1FHsyxW4rg3HWCDURD146HkFqqR//x2HEj
	iEJrCDRJARLDlmooJj0yM6TRkWcKZx76KE6KII7oUCeyauh15I59XnMCqNnKHBsCt06vUyBBYKD
	n1eVLIp/EKLbTYeOybFK6V7VnFa8=
X-Gm-Gg: ASbGncvJmNQbs3gDG84abtwhCOaIguZks/tjwtQEJvwBV6DNdhLoG6ioK0IiS4eWmcT
	PqR8aG8097OSNZ3hdbQco6rOhLVjDMacruPyj+Cs/yYQJCD3UnVbLDg==
X-Google-Smtp-Source: AGHT+IHhbAiFyFvd1Mfo23FPBSYkHdTUphfvtJyTgTXBo8HJBq5GRGK9fuMA3UKGzWz63K+XgLlcQXDkhtdDrlN44qQ=
X-Received: by 2002:a17:90b:548b:b0:2ee:fb6b:7d7e with SMTP id
 98e67ed59e1d1-2f2900a9fe7mr1013356a91.30.1734047595981; Thu, 12 Dec 2024
 15:53:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211093114.263742-1-leo.yan@arm.com> <Z1mREhJElE6cSrPT@x1> <20241211202630.GA3169297@e132581.arm.com>
In-Reply-To: <20241211202630.GA3169297@e132581.arm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Dec 2024 15:53:03 -0800
Message-ID: <CAEf4Bzbu_4sgb_cfC0K3fR+AMfAivJyprsENNZf129qieFCitg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] bpftool: Fix the static linkage failure
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Quentin Monnet <qmo@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Nick Terrell <terrelln@fb.com>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Guilherme Amadio <amadio@gentoo.org>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 12:26=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
>
> On Wed, Dec 11, 2024 at 10:18:10AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Dec 11, 2024 at 09:31:11AM +0000, Leo Yan wrote:
> > > This series follows up on the discussion in [1] for fixing the static
> > > linkage issue in bpftool.
> > >
> > > Patch 01 introduces a new feature for libelf-zstd.  If this feature
> > > is detected, it means the zstd lib is required by libelf.
> > >
> > > Patch 02 is a minor improvement for linking the zstd lib in the perf.
> > >
> > > Patch 03 fixes the static build failure by linking the zstd lib when
> > > the feature-libelf-zstd is detected.
> >
> > So, this was originally reported as a perf build failure when trying a
> > static build, so something not so common, no urgency, I guess, but it
> > involves a tools/perf/bpftool/Makefile change, I think I can process
> > this as I'll then test it in the many build containers for old distros =
I
> > have, ok?
>
> As Quentin said in another reply, there is a delta change between the
> Linux perf tree and bpf-next tree.  So this series has a conflict on
> bpf-next tree but it can be applied cleanly on perf tree.
>
> Before I respin to update the commit logs based on comments, I need BPF
> maintainers agreement with Arnaldo on proceeding on which source tree
> to proceed with.
>

I think it's fine to route this through a perf tree.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> Thanks,
> Leo

