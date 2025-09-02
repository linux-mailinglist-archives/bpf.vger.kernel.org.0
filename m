Return-Path: <bpf+bounces-67156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D25B3FA09
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 11:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49C707AE0A0
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 09:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A0F26A0D5;
	Tue,  2 Sep 2025 09:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSogPvC4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB26F19D06B;
	Tue,  2 Sep 2025 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804678; cv=none; b=NwwZrgtmOScffvOT1W4C/gFkR4d3pDGuCk67B/bMFPQyFQxUGgBQt7ISYXKm2xEm/HWdOLYfNpYFVCdOe7rvtAV7pyFtaMUiNqKr6tiw1rYBHB51Kxg1/rNPSyKoVRuyIX6x8VyM6oRDTTjsbLtEWd/pEt/+7tfct0irU1FwVA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804678; c=relaxed/simple;
	bh=ZMYyEAscphgdmWWTvHvYvdsj1M79rUZLDhkB0ChvVfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+uGVqwcy5s798bS/ETozfye4kfYvI78eJ+Z36KLVsYGMbPBXF4KQ0Y6sFVE1Cj5wZg9S0egrQaDKIPrCx0k7sl+OG3ngaXeQaUtRGsMSV866rRLo6shxVo6nSOXVnkZnUdW2ibHJyMW99nAY7Ttym+mtCiCldYTfHvtqTbxJl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSogPvC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD55C4AF0B;
	Tue,  2 Sep 2025 09:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756804676;
	bh=ZMYyEAscphgdmWWTvHvYvdsj1M79rUZLDhkB0ChvVfI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SSogPvC47cUZCsDMNRs/xEtm7GbdryLFVf7rbbut4qu/COO054bmqYMHvGOqKPj8C
	 4WQIFIAxyAs1Btc6qI0nbhZH47eakAKggQMPVCu9MmZMH+fOPmLpP7FWxg2iklszDU
	 P11+o8IxhZ83eg8pz+rL/uBifdI59v4W2zFMCPIfZsA32s8UDpCknJZkQAZTyn32hS
	 WPvkhK2d4ItgNqLa4nhxbxQguf/owynucBhD42W30nJDHVIsQcLWQyERcrQCx5zadT
	 cxrma3I8paF3bbwDOs8Z5NAY53IhMrBfCR9e7uJGskVQ3Yghvp+z/eN5wcTR3Frvpm
	 s2RwjebaeIkWA==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7454fee9da0so1997698a34.3;
        Tue, 02 Sep 2025 02:17:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAZVr4OaFCR6yVJjn7/8XFyeXC7SnEXwkCPWQJz/q3r7F4Ea/1A5+UUVgOixkYo149p6EPJbF0kvc=@vger.kernel.org, AJvYcCXFlSfYDhNYCfw8jAXXsyRLZf1WVkGFGl/JrnRKT1Ce3I1JhZLfkbz+WtMnIXUQcRsUBgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7mCI3ApigpHxha6x4Zkxq/VbW/+6VuHu3QlMNFmpjsrudsOdw
	wLX7JEJ+NKz5/AmabjNSs9V+mh8z0hgjxzgv2tWiyZ2/SG6jTbSIJiZDhC1Jlj/JQCN0crE642q
	j/5wBwsdjuS3+J/jq0B6Sb9nFc13RzyM=
X-Google-Smtp-Source: AGHT+IGnmwFytAaUo/rNskEciUlItMGJvwPzNYbXbvPvfUgvZGROLofCCzcfubCSSRfabxf38ciNem+d8tn1olpF6Vo=
X-Received: by 2002:a05:6830:6aab:b0:743:7ea:67dc with SMTP id
 46e09a7af769-74569d782b7mr6902862a34.2.1756804675680; Tue, 02 Sep 2025
 02:17:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829101137.9507-1-yikai.lin@vivo.com> <CAPhsuW4PGfmFnJ-huFFELRQDJ7SpgWOLxYVBhRtsZnsLZhB6rw@mail.gmail.com>
 <37d6f4a3-89dc-464a-b5fe-dcfb3e7882cc@vivo.com> <CAPhsuW4h_-Vskzxjt19b_muULJ+wAfze6izswjVS4XN2daUTmg@mail.gmail.com>
 <42c374fe-3ffb-4285-b982-add2a14fb65e@vivo.com>
In-Reply-To: <42c374fe-3ffb-4285-b982-add2a14fb65e@vivo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Sep 2025 11:17:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jGSJrjJnUdAqvSTxT47Lzo-RPfQr4wEaPzOr0qQH-DnA@mail.gmail.com>
X-Gm-Features: Ac12FXzJBC5wNKllmDCL-NSVuoSkzamcgTeQi5qlmB-EsTquWwoclWRSshdtMhc
Message-ID: <CAJZ5v0jGSJrjJnUdAqvSTxT47Lzo-RPfQr4wEaPzOr0qQH-DnA@mail.gmail.com>
Subject: Re: [PATCHSET V1 0/2] cpuidle, bpf: Introduce BPF-based extensible
 cpuidle policy via struct_ops
To: "yikai.lin" <yikai.lin@vivo.com>
Cc: Song Liu <song@kernel.org>, bpf@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 9:23=E2=80=AFAM yikai.lin <yikai.lin@vivo.com> wrote=
:
>
>
>
> On 9/2/2025 1:51 AM, Song Liu wrote:
> > On Sun, Aug 31, 2025 at 11:59=E2=80=AFPM yikai.lin <yikai.lin@vivo.com>=
 wrote:
> > [...]
> >> Thanks very much for your comments.
> >> The cpuidle governor framework is as follows,
> >> and I will include it in the next V2 version.
> >>    ----------------------------------------------------------
> >>                   Scheduler Core
> >>    ----------------------------------------------------------
> >>                       |
> >>                       v
> >>    ----------------------------------------------------------
> >> | FAIR Class | EXT Class |           IDLE Class           |
> >>    ----------------------------------------------------------
> >> |            |           |              |
> >> |            |           |              v
> >> |            |           |      ------------------------
> >> |            |           |          enter_cpu_idle()
> >> |            |           |      ------------------------
> >> |            |           |              |
> >> |            |           |              v
> >> |            |           |   ------------------------------
> >> |            |           |       | CPUIDLE Governor |
> >> |            |           |   ------------------------------
> >> |            |           |     |            |           |
> >> |            |           |     v            v           v
> >> |            |           |-----------------------------------
> >> |            |           | default   | |   other  | | BPF ext  |
> >> |            |           | Governor  | | Governor | | Governor |
> >> |            |           |-----------------------------------
> >> |            |           |     |            |           |
> >> |            |           |     v            v           v
> >> |            |           |-------------------------------------
> >> |            |           |           select idle state
> >> |            |           |-------------------------------------> 1. It=
 is not clear to me why a BPF based solution is needed here. Can
> >>>     we achieve similar benefits with a knob and some userspace daemon=
?
> >>>
> >> Each time the system switches to the idle class, it requires a governo=
r policy to select the correct idle state.
> >> Currently, we can only switch governor policies through sysfs nodes, a=
s shown below:
> >>     / # ls /sys/devices/system/cpu/cpuidle/
> >>     available_governors  current_driver  current_governor  current_gov=
ernor_ro
> >>     / # cat /sys/devices/system/cpu/cpuidle/available_governors
> >>     menu teo qcom-cpu-lpm   =E3=80=8A=3D=3D=3DHere we can switch gover=
nor policy by echo this node.
> >> However, it is not possible to change the implementation of this polic=
y through user interfaces.
> >
> > It is still not clear to me why we need this feature in BPF. From the
> > overview, we need two different governors for two different scenarios,
> > which can be achieved with a much simpler interface.
> >
> Thanks for your comments.
>
> Below is a comparison of traditional governor methods
> with a BPF-based approach for dynamic optimization of the cpuidle governo=
r:
>
> 1.Agile Iteration
> -Traditional:
>    Governor policies require being predetermined and statically embedded =
before kernel compilation.
> -BPF:
>    Allows dynamic policy iteration based on real-time market user feedbac=
k
>    User-space components can be updated via cloud deployment,
>    eliminating the need for kernel modifications, recompilation, or reboo=
ts.
>    It is very convenient for mobile device updates.

But surely you can add control knobs to a cpuidle governor?

> 2.Dynamic Fine-Tuning
> -Traditional:
>   Involves replacing the entire governor, which is less granular.

Same here.

> -BPF:
>   Allows granular tuning of governor parameters.
> -Examples:
>   --Screen-off music playback: dynamically enable the "expect_deeper" fla=
g for deeper idle states.
>   --Gaming scenarios: Allows idle strategy parameters adjustments via use=
r-space signals
>     (e.g., FPS, charging state) =E2=80=93 metrics often opaque to the ker=
nel.
>
> So, by exposing tunable parameters through BPF maps,
> user-space applications could make more run-time parameters adjustments, =
enhancing precision for specific scenarios.

You may as well expose tunable parameters of a cpuidle governors by other m=
eans.

> Conclusion
> ----------
> This approach aims to preserve the common logic of existing Linux governo=
rs
> while adding flexibility for scenario-specific optimizations on certain S=
oC platforms or by ODMs.
>
> Welcome any additional insights you might have on this.

I'm still not sure why BPF is needed for any of the things you want to
be able to do.

Thanks!

