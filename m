Return-Path: <bpf+bounces-63134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D496B03353
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 00:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A2B57A7A35
	for <lists+bpf@lfdr.de>; Sun, 13 Jul 2025 22:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995091F91F6;
	Sun, 13 Jul 2025 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1PyQ5cS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755944A00;
	Sun, 13 Jul 2025 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752446755; cv=none; b=U/DO0n2M4n3+Q71FvI/c8AIRlH0LzjvFClMj4qYoezIsVeFNmfeIMXf32QSlZuTV+kG8p5Z6Qvuru+oQ8k82+jNimnx0F6GO29dD1u70hs58hgznLai8Wk0fmu+JwjNmFgXH0eTrNn6QNAkxcv2l/h4S+1btzK+Sen5z2wiKICI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752446755; c=relaxed/simple;
	bh=kHn54of6+lS6CQ0dDfTBt+KD1kEqjsI2dGPg2xG+0pM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asQF32D9SC7+sM5WMKIYrLDbgnRilUYxX0yWNUO1n9b2n5o4kaLMx0RtkzPcSVH/h3KSAmcVN+JRhMq5WlHCPM7uAB2Y2TStpmBQZFMTBJWl7ETYA1ZZmrlFBNl/vkC6hneRKnc4ZHtSJyjLZq75hTw0y7e9hNv7YbiFihlYjjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1PyQ5cS; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-455fdfb5d04so8094655e9.2;
        Sun, 13 Jul 2025 15:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752446752; x=1753051552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOwYM/YE6DhKb/6E8m1su9Dle2Gqg0elxyjtG73mPGQ=;
        b=Z1PyQ5cSuzteO9kuk7U0908Qa3Yx+3drW4pxSKe9mNXlJwdep2TSmcLuPJuc+HiNqT
         6WzMnoTkx9wFuJq61Cc+iHu0zdExQJ0g9hY4WuI/im96TEdNjQ1D3ozVqkDHHp9+eGuz
         k3beo0XuicUXRnmbZs16c9siH+7M85b7D/9iYgTkbl1VvKbQ8IumVpAPEwL4udWcvXWU
         ObiTQAyyGaB3aUAb1nrK0/OMB8Fh/9krJ4+2/P+2zmAtSs+SU7OIJILEnepBlWNAdHzX
         Y8SVerJLWNh9axMgv0q6QgnJcoKaQFv4ca1A+pvbKsWqWvYCb8jQSR6/geEPhYtyhlDg
         JORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752446752; x=1753051552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOwYM/YE6DhKb/6E8m1su9Dle2Gqg0elxyjtG73mPGQ=;
        b=Xym3N60NNdBVPtAxrWMdt6oKPeqG3Ve9t8iQAynAkxR5s8gaNwD/sbOQRJJ8usTCVt
         Z4IXEEZOTZbtASz0DoE0Yf/3YdDwer82q/ICOXxUg5pvqd8T36Hzdeu+5dIEk3Qs5DZl
         RvV+TN5q5rZynbwC2Scq0LNOb1dNa68PnGLnjCHBF/DNGxHgVnjq7sI7HDOZ/iHw9TAu
         Aj298r8RTp5HrRhhTKtjASr1sBdmwyeaCZWzXYCmVIadfyrZojx4hbb9BcOrxKawttg4
         D3I1fXBRuoQgdwdt4t5KOsP5NkwSAIN1V0xDIMN70GHF5s3K3ocZGqpDjOpHft6L2tS1
         D2YQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1y99R65FKAuDQSYtZxGR54RZ6jLGl9T5aMyLzto+aJHFCKwOleEJWfS+evWeKEAgk8z4=@vger.kernel.org, AJvYcCUQqTo/eAPbwylJsuOV3PRKhK+0cLfntEzexnyZb73399/ds5QyW4q5Stubff+bceMabouuFs1v22RbHuyN@vger.kernel.org
X-Gm-Message-State: AOJu0YzEOqxDK0X9CSY9k4Ez23zmXt7dyrBOnMMy0qncRy4p4qt7f5Xj
	R2YLAfYENE587yyEeDYYjELvvBPo5FPKdamfkvmHWjVTzH850RkOGfY1wWJMvHxNNlzwVkzSrmb
	C8IhtAnvp0YtYcQKlz8p3I8i9NqwSLUQ=
X-Gm-Gg: ASbGnctciiBdZU2/upr3TFSEOn7D5nEa2e7XOBvDM5l7lXkUjDAY6qR0zTaV89i0mmr
	xlosfU4iGTSrxX786uZyX63pg5IGW+TloBUFpAOzcnTefxQkI50bcFIxqvbwKhJN7vHDnm8nw4l
	69CFHbiAc8n7DMA4MpZnu8aMcUmelNbXEeYptM+ztKhATeU24uBd/1vY+0lDhfb6AD0LpHdMXgK
	1Bxdra7eCzGZ6hVaoe/QZF6RmOq45EOt6u58EiMQl5G8NE=
X-Google-Smtp-Source: AGHT+IGxtZk5dym5B6Nn7vqW/Cd+Tz8WgO8RtC7jJCKkX6tU1zKQiyrObQKyybLO02oUqYHx7fN4z5SzjWopY0j/S4M=
X-Received: by 2002:a05:600c:3589:b0:456:1c7c:73df with SMTP id
 5b1f17b1804b1-4561c7c7797mr5066875e9.27.1752446751391; Sun, 13 Jul 2025
 15:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7e6c41e47c6a8ab73945e6aac319e0dd53337e1b.1751712192.git.sam@gentoo.org>
 <c883e328-9d08-4a6c-b02a-f33e0e287555@iogearbox.net> <87a558obgn.fsf@gentoo.org>
In-Reply-To: <87a558obgn.fsf@gentoo.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 13 Jul 2025 15:45:40 -0700
X-Gm-Features: Ac12FXxO8RBBMsOn0Sw-Rgbqri2k6HE1O2cfcIv93IFywuatfBZMsmTEa54cOSY
Message-ID: <CAADnVQJTHnOVX9uBtTS_7bfiS2SoDL4uL7wJWd0CzbXf08_dyg@mail.gmail.com>
Subject: Re: [PATCH] tools/libbpf: add WERROR option
To: Sam James <sam@gentoo.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Quentin Monnet <qmo@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 12, 2025 at 11:24=E2=80=AFPM Sam James <sam@gentoo.org> wrote:
>
> Daniel Borkmann <daniel@iogearbox.net> writes:
>
> > On 7/5/25 12:43 PM, Sam James wrote:
> >> Check the 'WERROR' variable and suppress adding '-Werror' if WERROR=3D=
0.
> >> This mirrors what tools/perf and other directories in tools do to
> >> handle
> >> -Werror rather than adding it unconditionally.
> >
> > Could you also add to the commit desc why you need it? Are there partic=
ular
> > warnings you specifically need to suppress when building under gentoo?
>
> Sure. In this case, it was https://bugs.gentoo.org/959293 where I think

I don't recall it was reported on bpf mailing list.

> it's fixed by
> https://github.com/libbpf/libbpf/commit/715808d3e2d8c54f3001ce3d7fcda0844=
f765969

and looks like it was fixed by accident, so..

> (and the corresponding commit in the kernel tree proper). Backporting
> that was a bit too big for our tastes.
>
> The real issue is just that -Werror when we have users who might be
> testing with in-development compilers or with alternative options
> results in a build failure when you didn't expect one.
>
> >
> >> Signed-off-by: Sam James <sam@gentoo.org>
> >> ---
> >>   tools/lib/bpf/Makefile | 7 ++++++-
> >>   1 file changed, 6 insertions(+), 1 deletion(-)
> >> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> >> index 168140f8e646..9563d37265da 100644
> >> --- a/tools/lib/bpf/Makefile
> >> +++ b/tools/lib/bpf/Makefile
> >> @@ -77,10 +77,15 @@ else
> >>     CFLAGS :=3D -g -O2
> >>   endif
> >>   +# Treat warnings as errors unless directed not to
> >> +ifneq ($(WERROR),0)
> >> +  CFLAGS +=3D -Werror
> >> +endif
> >
> > Should we also add sth similar to tools/bpf/bpftool/Makefile and by def=
ault
> > enforce with -Werror with the option to disable?
>
> Yes, that sounds good to me, though I was nervous of stumbling onto a
> philosophical debate about -Werror and wasn't sure what y'all preferred
> :)
>
> I can send v2 with an updated commit message and this change. I'll wait
> a bit for further comments based on my two replies here.

No.
We want Werror to be there by default and it shouldn't be trivial to turn o=
ff,
so that people report and fix issues with new compilers.
Like in this case, looks like it was a legitimate error of
in-development gcc-16.
If it was reported to us and turned out to be not a libbpf issue than
gentoo should have reported it back to gcc devs to make sure they don't
add bogus warnings to the compiler. Win-win.

You're right, in many ways it is a philosophical debate.
We cleaned up libbpf and selftests/bpf from warnings and
we don't want them to reappear. So we don't want an easy way
to silence them. Report issues instead.

