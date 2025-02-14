Return-Path: <bpf+bounces-51514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE44A35538
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 04:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 627FC7A46CE
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 03:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26631519A9;
	Fri, 14 Feb 2025 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUGQAzpE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E121E2753FD;
	Fri, 14 Feb 2025 03:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739502621; cv=none; b=hrEmnpDjUVFdk4dRoCAecm2Y4WTy3AebiAHBfFCEd80Hf0q4PeWds07nw1iycd6/YryWfJfAJsMcqUzJaqcBusuwCE9O7LjI+c5vsG71miikQlfZLDb0KKxtKUAtXPCEpB7MsF1uQJztAL1EZU6jpvcwPl5Um97LKIzmFADA4+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739502621; c=relaxed/simple;
	bh=A65U+faa4oNOa5ylsWolb+GmQIu3g+Rry+N6W9V4a3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovez29y5gTTTC/yejW1KsAbicK7peWUzXYnKdtvpNeeVBtkBAdI59Oj/sImP3l95FvGVrSXja4Ouv7jzz8HvjMWfvT69Ix2XkqguTn8Rh4+HeE1adjUfmBsAAuHdx1lkQcZhtVUdjsU+v2VNysNTlwxVntC8XusVbnJiJgoeGjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUGQAzpE; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d19e40a891so523535ab.3;
        Thu, 13 Feb 2025 19:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739502619; x=1740107419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sr7VtscEnLfkXHzMmEefMyB7dFFB5djMVQi/VXYO6Q8=;
        b=JUGQAzpEPclcgotvDwc4sbxgf/HlEDlcBeIICOEgo0T3cTIpxK8zRaYHZt8nh5XGSp
         ZxdY+TLhU+yvlkXqVb6xDzJoSHIEyOuKUUk/ih983wpGRbM8HioYj6QLp0CDubJnPxIU
         ijalJqWbzQZGn/Q6IqMGJfnuKk8D3fqQmKLlhqq0mV1MFA+d1W4C2VQu9+KIK0B6LYm7
         b6W9KKRQhmG1ha9tSd18pHIt+f00ZtxSBULfS9Pq9aze2oAgtcXiOmZZLWBM76Yu9JMt
         Xsl/AWKYFMXBuMiy5aJYx4Vh/HWZkoxZ/ZBSxgCXYLeQkqMRUpUhTH42O/AsUGFlD43s
         w9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739502619; x=1740107419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sr7VtscEnLfkXHzMmEefMyB7dFFB5djMVQi/VXYO6Q8=;
        b=hZ22oyYK19AOmYwNnpuwkGis3Pr6/JPBAUDRrGXejW6UE+Tp8cz1Cj4CC8edJ7mlOB
         Hoz+L5vRJPSnrCKSk5lROhf3AKCrPWnZqSpUxWjEJCluxsGqP+RSfhkvmrKqhRirUTa9
         cuBsiyOmehBkUmJlrm4DR3lYmm9zHmP7+xKvOqkmyTTUE47cLV9PYiUF6lrLEqx+qBRH
         SwQT8QNvNnwXtHftX4f+th/kvZoJWkKh63LFuvHrG8Mk4XjR3wgsHMOMDN8dZvA9PyI+
         lkQW8XnbfMRRnjLNNfGlPS6e12kWZGWgz5x21wCgfN66tzSoq55fTM4xK4Jgq8ok+dCN
         os5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWvMSxJo+l8pIZy3Wj9H5yIYVZCxOzLFESkMvMknIugD3zscGIyzgM5LuObithU6rJJGc=@vger.kernel.org, AJvYcCXfB/IeS8OhGhmj1dMsozMvKHs77blVO/fj92MHLsyGJUV9M4fLxC3k5OBCtGTsR8Kv8VocG5pm@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8kaa3j+oLaNr5+nF0+G2khalX8ns9S2SKFm9jIyWA4S/ZXujd
	JYMyWSS9l+ZwTzbOFtTKK2WyqqactszErKY4WYrTbt5u7xmfyCJ2ynqDakO1pDFwgIX6EWdlYw1
	WJpgkcDf3F2K687IsZQK0yKMK+Yg=
X-Gm-Gg: ASbGncuFNwm42bc3oKgChUue/N0vVVpy3BJLb6YlThXFeCmk+E7yZaudXHxOFkf1ZLg
	M7+1fvWzzLM6MUV6xxPyQKlflchoWDhtxJJ/xs6RZjcAcdQCTlGxDuGIc8KJN+Aju4xWEL9aj
X-Google-Smtp-Source: AGHT+IEfGVOyU//v0eco6EEni1bDVW5yC4amkhgfCf1HJIMYXicK+XJ5DgN+Qx3tjnUJVf6rESUufXJIkLz83N31V4E=
X-Received: by 2002:a92:c569:0:b0:3cf:b9b8:5052 with SMTP id
 e9e14a558f8ab-3d18c21e82cmr53181895ab.3.1739502618941; Thu, 13 Feb 2025
 19:10:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213004355.38918-1-kerneljasonxing@gmail.com>
 <20250213004355.38918-3-kerneljasonxing@gmail.com> <Z66DL7uda3fwNQfH@mini-arch>
 <CAL+tcoATv6HX5G6wOrquGyyj8C7bFgRZNnWBwnPTKD1gb4ZD=g@mail.gmail.com> <039bfa0d-3d61-488e-9205-bef39499db6e@linux.dev>
In-Reply-To: <039bfa0d-3d61-488e-9205-bef39499db6e@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 14 Feb 2025 11:09:41 +0800
X-Gm-Features: AWEUYZlRUwUUBMhsCxGmt2NwtwzeGsWopF-CpgoUIlSrK9GVl3AZE_DOTnxYLIA
Message-ID: <CAL+tcoBAv5QuGeiGYUakhxBwVEsut7Gaa-96YOH03h57jtTVaQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] bpf: add TCP_BPF_RTO_MAX for bpf_setsockopt
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org, 
	ncardwell@google.com, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 10:14=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 2/13/25 3:57 PM, Jason Xing wrote:
> > On Fri, Feb 14, 2025 at 7:41=E2=80=AFAM Stanislav Fomichev<stfomichev@g=
mail.com> wrote:
> >> On 02/13, Jason Xing wrote:
> >>> Support bpf_setsockopt() to set the maximum value of RTO for
> >>> BPF program.
> >>>
> >>> Signed-off-by: Jason Xing<kerneljasonxing@gmail.com>
> >>> ---
> >>>   Documentation/networking/ip-sysctl.rst | 3 ++-
> >>>   include/uapi/linux/bpf.h               | 2 ++
> >>>   net/core/filter.c                      | 6 ++++++
> >>>   tools/include/uapi/linux/bpf.h         | 2 ++
> >>>   4 files changed, 12 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/n=
etworking/ip-sysctl.rst
> >>> index 054561f8dcae..78eb0959438a 100644
> >>> --- a/Documentation/networking/ip-sysctl.rst
> >>> +++ b/Documentation/networking/ip-sysctl.rst
> >>> @@ -1241,7 +1241,8 @@ tcp_rto_min_us - INTEGER
> >>>
> >>>   tcp_rto_max_ms - INTEGER
> >>>        Maximal TCP retransmission timeout (in ms).
> >>> -     Note that TCP_RTO_MAX_MS socket option has higher precedence.
> >>> +     Note that TCP_BPF_RTO_MAX and TCP_RTO_MAX_MS socket option have=
 the
> >>> +     higher precedence for configuring this setting.
> >> The cover letter needs more explanation about the motivation.
>
> +1
>
> I haven't looked at the patches. The cover letter has no word on the use =
case.

I will add and copy some words from Eric's patch series :)

> Using test_tcp_hdr_options.c as the test is unnecessarily complicated jus=
t for
> adding a new optname support. setget_sockopt.c is the right test to reuse=
.

Will use setget_sockopt.c only.

>
>
> > I am targeting the net-next tree because of recent changes[1] made by
> > Eric. It probably hasn't merged into the bpf-next tree.
>
> There is the bpf-next/net tree. It should have the needed changes.

[1] was recently merged in the net-next tree, so the only one branch I
can target is net-next.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/co=
mmit/?id=3Dae9b3c0e79bc

Am I missing something?

Thanks,
Jason

>
> pw-bot: cr

