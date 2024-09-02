Return-Path: <bpf+bounces-38718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDA5968C11
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 18:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811951F233B5
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 16:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1771A265F;
	Mon,  2 Sep 2024 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdJ8ya2g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA9F38DC0
	for <bpf@vger.kernel.org>; Mon,  2 Sep 2024 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725294845; cv=none; b=AO6fnnNukPqDzUzKz+s1vHZ4Im2xtC4JoOTYU/YZLzUcS/3PdaEiOy96ln7xo27UnRngcW70wW6an3hexaacrhulrT83w2YmFI1ugLoAKkFA1lOWuRIeD0kom1ZX34cMWDJwJsYATt/mCNy6O0hhj20UXxO+E/NnB6MksL3Kwtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725294845; c=relaxed/simple;
	bh=ZLMKetLU8CNfZ+7/OyLk0B8NXATlW1CdMB03FNsP3aY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3LzsyK9RpIuUIZ1AjpF+zf5QKCF76zZuszgwKH9hiJ/qFwDjCdH/GJKtaNUEQ55G+Or38zQ4J1QZwq6sJewNmby4H7LJmReTmv0WRdP3GKte3H2Ryb//R7048RbIBLUH2n77GYohLPTb52JjS+dm5LVAYXvW9XwRd+bOr4TZog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdJ8ya2g; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-45677965a3cso12692611cf.0
        for <bpf@vger.kernel.org>; Mon, 02 Sep 2024 09:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725294842; x=1725899642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLMKetLU8CNfZ+7/OyLk0B8NXATlW1CdMB03FNsP3aY=;
        b=gdJ8ya2gVLti8MXdO3TWXIHKXOnjc/KvYQmNoo4N/+eLksoxSXFqP2EvOTly0v2jcc
         N1H0qnzksdSFJmw3/jYZ0U6Ms+DeRMf1lUtxEim3k78lDf3oxcibNmF1iDcQgx4AmL+p
         QXfGoimwDWPfSkFomPSVQULYW7Wnaxsz1Zao2E5u4KyGC2WQXe3t6DQYiupRKX3k07c4
         Fe3oBfZOKcZORLJ+miYMKe4LufjjESuAFC/n2MvDzbjmBZhQRxlljpnnwi8qaqMzNHpt
         s8kL5R0JoCv7q3BPihcKh+hXvn+zQhSLopcgqxb6ryfa0aDRFB6F0d0j1Th0G1puvnO8
         6nBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725294842; x=1725899642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLMKetLU8CNfZ+7/OyLk0B8NXATlW1CdMB03FNsP3aY=;
        b=YUPJ6rGsBj5fe2UAEGHpeqPK9AeFTpzOUZB27E0cPYnTJe05YDhHgaby7cojCSty/D
         I5TLzzgb7BaH9zH7VN9M6hwCA1ZTT306NJv7tuj8/72naq9PzgFPaTldtEhkQdk/imZ0
         rwDFL7Hob84Aqi/m9Pgy+bH3mW/shvtGMEMVtcOaBahJcsUJF4kgY4w2xXUPk6nDLAui
         zQVE2ZINQcWCqqlCChLFJluBx/ZDpfowiKKZZTR45MZsEokB4Fx9y9uRxZWnYlYdoFd4
         vGIQq4+waTUMaPC1Cpto7NOgIy7tWJXA0t0mb2RIFJTwG7ofh9WmmlnlGxM8WkCTURgG
         NZ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfMiQ6PZVGXBmR7n7qBFK7+aycGrf/A8USG6YOvEyAdT8jVz/iuQf2r7JSuAEeCJwoW0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhB3OiJB1QE3uaQ+ZlR0oYNu8fX7woV+s+czZ6XFzNd+yIiEx1
	SCpYbeKsXDcgMMlFnO1MjO/4kI7i9zrgHIHQrCn4EqMvPJ5deMeyOAgliKmR6rENPMbA8J91PGk
	aSMzV7s8oe/buYu5KnoBHLP//ZlQ=
X-Google-Smtp-Source: AGHT+IGdCGOEya32UJxh7J1NOVVAzEb9CrE3w2iq9bsugbk+XqBTX2TT+lB/CKne8GJYJ6mL4mY0OTM73z3MThIBGtY=
X-Received: by 2002:ac8:4f52:0:b0:455:a05:b477 with SMTP id
 d75a77b69052e-4567f4e4942mr138823211cf.12.1725294842158; Mon, 02 Sep 2024
 09:34:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825130943.7738-1-leon.hwang@linux.dev> <20240825130943.7738-2-leon.hwang@linux.dev>
 <699f5798e7d982baa2e6d4b6383ab6cd588ef5a9.camel@gmail.com>
 <dc2d2273-6bd7-4915-aa77-ad8f64b36218@linux.dev> <CAADnVQJZ_jyDzpW8rMuOH2jkiP6mAXMn21DDvF=PA9L8xYt3PQ@mail.gmail.com>
 <87mskquzlg.fsf@toke.dk>
In-Reply-To: <87mskquzlg.fsf@toke.dk>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Mon, 2 Sep 2024 09:33:51 -0700
Message-ID: <CAK3+h2ztPMW7gCTXgQp+MT9bme5TycCHk93B8h8bva2EeT_MEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf, x64: Fix tailcall infinite loop caused
 by freplace
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Leon Hwang <leon.hwang@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Ilya Leoshkevich <iii@linux.ibm.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 3:20=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Tue, Aug 27, 2024 at 5:48=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> > I wonder if disallowing to freplace programs when
> >> > replacement.tail_call_reachable !=3D replaced.tail_call_reachable
> >> > would be a better option?
> >> >
> >>
> >> This idea is wonderful.
> >>
> >> We can disallow attaching tail_call_reachable freplace prog to
> >> not-tail_call_reachable bpf prog. So, the following 3 cases are allowe=
d.
> >>
> >> 1. attach tail_call_reachable freplace prog to tail_call_reachable bpf=
 prog.
> >> 2. attach not-tail_call_reachable freplace prog to tail_call_reachable
> >> bpf prog.
> >> 3. attach not-tail_call_reachable freplace prog to
> >> not-tail_call_reachable bpf prog.
> >
> > I think it's fine to disable freplace and tail_call combination
> > altogether.
>
> In the libxdp dispatcher we rely on the fact that an freplace program is
> equivalent to a directly attached XDP program. And we've definitely seen
> people using tail calls along with the libxdp dispatcher (e.g.,
> https://github.com/xdp-project/xdp-tools/issues/377), so I don't think
> it's a good idea to disable it entirely.
>

Thanks Toke to mention this use case, I have xdp-loader to load DNS XDP pro=
gram
with tail calls to do DNS ratelimit and DNS cookie verification
see here https://github.com/vincentmli/xdp-tools/blob/vli-xdp-synproxy/xdp-=
dnsrrl/xdp_dnsrrl.bpf.c#L635-L644
and I have it as part of XDP DDoS in an open source firewall project
https://github.com/vincentmli/BPFire.

I hope this is continued to be supported in future :)

> I think restricting the combinations should be fine, though - the libxdp
> dispatcher will not end up in a tail call map unless someone is going
> out of their way to do weird things :)
>
> -Toke
>
>

