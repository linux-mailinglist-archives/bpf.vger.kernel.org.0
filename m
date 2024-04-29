Return-Path: <bpf+bounces-28193-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3251F8B654F
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 00:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75B4CB21854
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 22:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995BD19069A;
	Mon, 29 Apr 2024 22:06:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB2A17798F;
	Mon, 29 Apr 2024 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714428380; cv=none; b=OLBEyHACJdmgheSCYUuKBJ+Y1RailB3SKOuvGeShQgZMwOmp7t4LrHUEAlCwKDPZAIEAAUFNJ+NH+CNUslGkOV7oyRhn3dzZG4ItUvcx22kOrjpA5Clho9goPLsbqzZmFuO+hk7ZcDtEqOPgrghpBkQclL4TaSoKFkRGzsa8Tec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714428380; c=relaxed/simple;
	bh=5dBBhWZySXo4xegH3vOIihKR7dTAWvBByCdDrLrAt9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffCMFR+xSddf2zRb2U6mrwTIyxPBRF7u3OJjYgFhdrpLEBCJnVXhlBxPVF7mMqC46dKbFuSRR8O/z5DWSfxdCPHHF494BJibMz3XeFBakGLCwCVGUrzE+7di4II7fz5eJvS59R6pEZzK+ndHtHC3h7n4UWXfy0G2jA8Lm5XaLnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7ee32c48f42so1956376241.0;
        Mon, 29 Apr 2024 15:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714428378; x=1715033178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibIJzCmwwnGDq7816A1xv5l0I73x7QtEVchHgbiU7WQ=;
        b=bUIE/BoipsaW1Fus0ECBxe36GM54TShqwDVJ8ITVyeqWBcLdO0Nv+6LfwuxOHuDlPi
         UM0R7HJ0njWAj0fVxEobUV5qbhnP3ocKLwxK5SDomqJ26LzBsEKp/6MTBNMuyoeJXGSy
         PM7PRCYM9atUifHqp52NpObRA1QU7UvU5HEuVnksijid9taOI0NiWMIgIhJ80rJvbIzK
         IH44ZJSwqL2MomDkwJ5wcmNMRrS6BBavChTW4KtWGYYcQJnGt6/gWywYjWgD/lgOOxcJ
         QNafpJFTsuEGj0s6Ud22THcYrzJQaP0VmQf2woUkwZ1UsJCjs8mfKZbc+daMTK0EDEUa
         rMkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUawDaor0qPCYpF82AnA9Tx6JGbD1Yjq+S8gyljA95np6QHupZiyCV2W7oc7y2jAC8UeS520NPGuvnynajrruQYIo91rpKszRQHymThwdZn3gaUVlI2t65KBicwg5l64jMv4/zaMAQQyLlDYMojlCUdRRbFvKFrzqMmP1G/8IwZpEAAqA==
X-Gm-Message-State: AOJu0YxMiOeiYMbyt7bIU1nTGkjl5WThGa9F7TSVh5zvaRRefSPPHMDk
	7RY8b9APqwaJ0ueYM/+Ucwo4aqm61LpdfBrpy0WEYly8buHcVq5Ium69LHB/MUDDPLozVfKVYhc
	gzhcl6Zh+4rzcmVrUsgWWF1BgROE=
X-Google-Smtp-Source: AGHT+IEq8BooOI6utZ4uLzHFMGEcw+s8BKXMKuvaCeXvj6AimgGWhJTYzn3FlxPazMO0Uz+0r07vxJwNzJm9v8STdZ4=
X-Received: by 2002:a05:6122:369f:b0:4c0:24e6:f49d with SMTP id
 ec31-20020a056122369f00b004c024e6f49dmr13138369vkb.1.1714428377792; Mon, 29
 Apr 2024 15:06:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422083645.1930939-1-howardchu95@gmail.com> <Zi_slOlsZBjTbNIH@x1>
In-Reply-To: <Zi_slOlsZBjTbNIH@x1>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 29 Apr 2024 15:06:05 -0700
Message-ID: <CAM9d7cjFYPPusN+yGEHe5B5hwPoiLqXj=Q0DqjBaZR9gTAADTg@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] perf record: Dump off-cpu samples directly
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, peterz@infradead.org, mingo@redhat.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	zegao2021@gmail.com, leo.yan@linux.dev, ravi.bangoria@amd.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 11:53=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Mon, Apr 22, 2024 at 04:36:45PM +0800, Howard Chu wrote:
> > Parse off-cpu events using parse_event(). Change the placement of
> > record__config_off_cpu to after record__open because we need to write
> > mmapped fds into BPF's perf_event_array map, also, write
> > sample_id/sample_type into BPF. In record__pushfn and record__aio_pushf=
n,
> > handle off-cpu samples using off_cpu_strip. This is because the off-cpu
> > samples that we want to write to perf.data is in off-cpu samples' raw_d=
ata
> > section:
>
> Hey,
>
>         This lacks a cover letter and the chainig of patches so that b4
> can fetch the series.
>
>         Also all 5 patches have the same summary and different
> descriptions and contents, can you please rework the patch series, using
> 'git format-patch', and make the description reflect what each patch is
> doing?

He already sent out v2.

Thanks,
Namhyung

https://lore.kernel.org/r/20240424024805.144759-1-howardchu95@gmail.com/

