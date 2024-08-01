Return-Path: <bpf+bounces-36237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0FE945131
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 18:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D943C1F23BB6
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 16:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA111B4C5D;
	Thu,  1 Aug 2024 16:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jITEccrr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419B113C9A3;
	Thu,  1 Aug 2024 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722531558; cv=none; b=VS+zdeYMuFh6PC3UYjRh7czlVJ+piXU4oprEZh2+t3b/YwiowPD6acfADE4oDFsFEfpCvKc6NrPp53kSxDiZRQMw+5/isVmykudkN1Ggxy2sd64rh/UKXBUmcJV9gayKTX/TM9MXP9c9ex/nhKOvfBKvKh6v+OgzLcoJEraFdps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722531558; c=relaxed/simple;
	bh=p4Qq9uIdJs58wMaAl65FJLXAPV2TDD3znAAl5VsvGOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jBBC0v6933RF66Xx+v+939eDNYJlNgTfeYHCxowcx0PoSTNn2P7aNPLGxRFEdBCKBxmUe3RHnCA6V3iDrAYo6t3Ylzp0kfCm0h+VR+E4P0WyeUhQoizhBqDqpg/scNexCENeyNUyY5VQhTGg28GwfiQJagwSiNSSWViRlnSHucQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jITEccrr; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7a18ba4143bso5241559a12.2;
        Thu, 01 Aug 2024 09:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722531556; x=1723136356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4Qq9uIdJs58wMaAl65FJLXAPV2TDD3znAAl5VsvGOo=;
        b=jITEccrrTVMWLw+43QhrZn5uU4INzerx+qCpGt0jPKMWYadKMNu2veM96xmBzAZCuA
         sFFqPE9U01xN81nlsk8lvdTObXsU2XcVfDAB2njBG6z8epg9U5MHWGc57JGkGwBHvVi0
         XuqudfNSDaBb/wFa7k2cZCdQYSIhoiMQFllNo8eSDwuF3gBwLQEOALovV+/l7/x6bcdp
         qFuazzSlwvYhf3K6MzViznRPiUHg8vNsmPUjoih9O9itgm3NHGhm7DcKgw7WozogmYsx
         SHO01lzyJeU8mXLLpaJwJz9/fo63RQqy/EeK4aYQI/Iz7O/UsBGLZiAZ93HkSbuEgDlh
         wh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722531556; x=1723136356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4Qq9uIdJs58wMaAl65FJLXAPV2TDD3znAAl5VsvGOo=;
        b=wulwXtYbsWdVgYFua/GAYSNhsQ9za+lZe4cYrmMpxs2IA7CKAP5wQSEDqlJF2nF/J5
         dPoDL4HumigEDiI0B5BYcs34yF+NuDOS5HnFYcibZvOkRB2Mg8JRcGeJmEAtkvdZK9Z0
         b29KsRtGeM79VKs7BpjNB7pnd+5rF9JwfOUZKmOBGJ9Xv2/u0lDOH4fD0awGda2ijxAh
         87fSN1OE+vBf7UBy0zdq69oeLJhxONOY58iAyPQIEQK+DFY33jPZNVhdGQcJ72DZyrTa
         pZOUx1OoH6OzFuFtHiO8bRVzoVMpE/MWopA3DnuGkJREbMdgJpHKtULI/Ip0fo3yJ+35
         1Izw==
X-Forwarded-Encrypted: i=1; AJvYcCXYzLX8+TxVu8YSQoeo+JffrFTkQ/x9K5AtlXR/E6HuzMrWsjAnFjo2YEG5EcbOOYJe6Eeajd2x5mLFeo3UOx1xuxtXbtIdzmKK/sY1YnCpi8a886YOdl3FZjXVGS7IcpIj
X-Gm-Message-State: AOJu0YxhdhtfH/goJpUObR+GOB5oGD2UGQAzubXNf+sHUnu/rn7B3R86
	CHjVcBdJbdDwBziFK2bAPhpKkWOnzrHfqTqSb5FnEacQhQZv2dsJSAGn9RddnjY3WmKjHW8Uv1h
	V5if6lZFno+oI3djPGNNoBhSF4Pw=
X-Google-Smtp-Source: AGHT+IFYrmd+B21iaow8sKxHkD1/et3H5KLzOxaPPiErENaGVRkdY0kckkQCWolbNyf+XCPVKJB2+xBREM3dfowFXUo=
X-Received: by 2002:a17:90b:4ac7:b0:2ca:8684:401a with SMTP id
 98e67ed59e1d1-2cff952809fmr937025a91.32.1722531556385; Thu, 01 Aug 2024
 09:59:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725051511.57112-1-me@manjusaka.me> <08e180da-e841-427d-bed6-3ba8d73e8519@linux.dev>
 <c7952df9-5830-45d3-89bb-b45f2b030e24@gmail.com> <6511ce2a-1c7d-497c-aeb6-d4f0b17271ed@linux.dev>
 <2c6b1737-0a96-44ed-afe9-655444121984@gmail.com> <CAEf4BzbL0xfdCEYmzfQ4qCWQxKJAK=TwsdS3k=L58AoVyObL3Q@mail.gmail.com>
 <0f5b7717-fad3-4c89-bacf-7a11baf7a9df@gmail.com> <CAEf4BzZCz+sLuAUF65SaHqPUemsUb0WBhAhLYoaAs54VfH1V2w@mail.gmail.com>
 <a1ba10df-b521-40f7-941f-ab94b1bf9890@gmail.com> <CAEf4BzZhsQeDn8biUnt9WXt6RVcW_PPX76YFyZo6CjEXGKTdDg@mail.gmail.com>
 <9f68005d-511f-4223-af8f-69fb885024a1@gmail.com> <CAEf4BzbzM85_946eB95e9U6stknBh4ucLMKVo5SEqUsihe4K1A@mail.gmail.com>
 <951159c7-08b1-4b15-9dd7-e1a6589ce2ce@gmail.com>
In-Reply-To: <951159c7-08b1-4b15-9dd7-e1a6589ce2ce@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 1 Aug 2024 09:59:04 -0700
Message-ID: <CAEf4BzbbyojuFSS7xQ3+jZb=dHzOaZfMbtT+WnypW2LPwOUwRw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Add bpf_check_attach_target_with_klog
 method to output failure logs to kernel
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Zheao Li <me@manjusaka.me>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 8:31=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
>
>
> On 31/7/24 01:28, Andrii Nakryiko wrote:
> > On Mon, Jul 29, 2024 at 8:32=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.com=
> wrote:
> >>
> >>
> >>
> >> On 30/7/24 05:01, Andrii Nakryiko wrote:
> >>> On Fri, Jul 26, 2024 at 9:04=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.c=
om> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 2024/7/27 08:12, Andrii Nakryiko wrote:
> >>>>> On Thu, Jul 25, 2024 at 7:57=E2=80=AFPM Leon Hwang <hffilwlqm@gmail=
.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>
> >> [...]
> >>
> >>>>>>
> >>>>>> Is it OK to add a tracepoint here? I think tracepoint is more gene=
ric
> >>>>>> than retsnoop-like way.
> >>>>>
> >>>>> I personally don't see a problem with adding tracepoint, but how wo=
uld
> >>>>> it look like, given we are talking about vararg printf-style functi=
on
> >>>>> calls? I'm not sure how that should be represented in such a way as=
 to
> >>>>> make it compatible with tracepoints and not cause any runtime
> >>>>> overhead.
> >>>>
> >>>> The tracepoint is not about vararg printf-style function calls.
> >>>>
> >>>> It is to trace the reason why it fails to bpf_check_attach_target() =
at
> >>>> attach time.
> >>>>
> >>>
> >>> Oh, that changes things. I don't think we can keep adding extra
> >>> tracepoints for various potential reasons that BPF prog might be
> >>> failing to verify.
> >>>
> >>> But there is usually no need either. This particular code already
> >>> supports emitting extra information into verifier log, you just have
> >>> to provide that. This is done by libbpf automatically, can't your
> >>> library of choice do the same (if BPF program failed).
> >>>
> >>> Why go to all this trouble if we already have a facility to debug
> >>> issues like this. Note every issue is logged into verifier log, but i=
n
> >>> this case it is.
> >>>
> >>
> >> Yeah, it is unnecessary to add tracepoint here, as we are able to trac=
e
> >> the log message in bpf_log() arguments with retsnoop.
> >
> > My point was that you don't even need retsnoop, you can just ask for
> > verifier log directly, that's the main way to understand and debug BPF
> > program verification/load failures.
> >
>
> Nope. It is not about BPF program verification/load failures. It is
> about freplace program attach failures instead.

Ah, my bad, it's at an attach time. Still, I don't think a tracepoint
for every possible failure will ever work. Perhaps the right approach
is to wire up bpf_log into attach commands (LINK_CREATE, at least), so
that the kernel can report back what's the reason for declining
attachment?

>
> As for freplace program, it can attach to a different target from the
> target at load time, since commit 4a1e7c0c63e0 ("bpf: Support attaching
> freplace programs to multiple attach points").
>

[...]

