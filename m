Return-Path: <bpf+bounces-54153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E4FA63A2B
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 02:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E0E3AECB1
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 01:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73CB84A2B;
	Mon, 17 Mar 2025 01:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKBlIwdW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC266481B1;
	Mon, 17 Mar 2025 01:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742174770; cv=none; b=Vqq2wmuKwimzCfYRpC5vzO57iFpRA43fAHlgd/zBlrza1hD1dDFZpLvVbcgi0zoN5G3araWhlIgrRTcL6o27FFQ/HHX927DtwHsJCiOj7kxD0JGr/UfhpFckDDDuM6DfX2H8E/0SyT91xnUtSaYRgdoAe7PMnQvbRIGa21Qzlik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742174770; c=relaxed/simple;
	bh=vh9xTMtufPDw2+00eoqL7kOeCts77NcSqZTpbcrx/ws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVkoiQr5O+z9fgTAJy5xqfhKKwVPckfCQ7WMNhHl9G/HX/EfH9UD32lbwdW4wGmQ8DF+1ou3xNNpdL9qBrNsHEOAmeLha5Rfwpruff0IFZKWo4MTsYWB/kPwWc1vLx2Glxs7HZbuSxrHtG0x28fjFWh76qeWzQMwqrEHhMUUdrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKBlIwdW; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ff07872097so30176177b3.3;
        Sun, 16 Mar 2025 18:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742174767; x=1742779567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+Z6MPDlHxM6XfzWRhi1r9HNAsbSPQrdOBmdmqDNu4U=;
        b=mKBlIwdW/O3KpzKoEfR/asAKK5Pcj1ZoINYgHW8Sy7Utpfu9pmBl6bQH9EiLuxZ4lU
         dPJKzCdTJ79nH/RJK2+kknpqenHkmRYPulRd0xi9VLSWWWcg3Zxi//rOxGVvHZjXU79Z
         J4TtM+FVu33uYoUhImB8PQPJuFe+KNvwpY3luLB0oGxFMX44kmQIXfHuJzTeLvMLE2ah
         FbIvfdkvpp8nEcXnFu3qStZkMTJUzGo0qqyOgIlE+7ZyLOMvyx+1gJlf0UtxtcfWtaSJ
         5W3yd2gKc3bdRb3y/yKr2/U9lJnYSoGDQOLdc0C7jq9P8AtCljdBORzk4otvm+288CWE
         kwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742174767; x=1742779567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+Z6MPDlHxM6XfzWRhi1r9HNAsbSPQrdOBmdmqDNu4U=;
        b=MMMOit09JrK9kCayGatkd/yJbU9TSZCU488kjAuqzsLi7PVdNEqe60BKdbDxdpqstj
         5+B9vZF0xwlH0Z4czq3nkxEw005sbg11AbIBQ0rIZQyTYz5nLiVGXIEmMJ3cVLmdetJ0
         hcN84NWKX4NQ9h1R2RgngAqEXD+d3FBTfDwYkiktsNlA3LSlv1mPSNNBKr6ynFGXwnFL
         0wznbgkE07pPROXblI+BKdfzjt7FQKv2MsUSXYLYXj9J0TpZRnBqxhKMO550tkLTPdIR
         lhR50xkgRE4//OcKJ+oswF/8CK7me4jyIF1E9gOpQGeglUxhpE36UBI1iTEV496xGMGi
         Y4Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUtV4kPbZvz7of01TitsiCet1OuP1+M/TZADcjxJ+v2rkNU3FH8jzlDlVd0EHZuZ4ynCSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7b2NoXWVAitMPLytVaIyQvAzM7Ohkq2eX7/AIHDZRtf9sxPBi
	T6PGEinPVOA8H0VR9//bwF4vrxKg4bJLsAq7/9JRCG7SMJdQq71xEUFURyDjXgEqVtVhBj+QLL0
	4XKU4Rb+x44VIrWoTGOFwH+BveKE=
X-Gm-Gg: ASbGncsO5Q88OjTTCCDd29m53UxQ4TKB6OZkXEZ+O9C8Gw2VrATwjo7nx3tvCxekJcw
	EUKKhuppsK+Cv/RoMDPPcYenR7uHX3hTiPvY9o25it9lQKaFnSJik95kUJ3xQixICLLqSy3Vv5h
	vIBhI2goJRUUHJw4O61FgBhmpWHQ==
X-Google-Smtp-Source: AGHT+IHYCm/m1R6Y3V3X7NdE295rMqWuWHr4lk46l1x1sPX0TS5ZMtvWIvJ3rIWNi11bGHNY2HzgdKF+3Oy2YIyC/pI=
X-Received: by 2002:a05:690c:c8e:b0:6ff:1c1a:f61f with SMTP id
 00721157ae682-6ff45fe5df5mr138365347b3.30.1742174766708; Sun, 16 Mar 2025
 18:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313190309.2545711-1-ameryhung@gmail.com> <20250313190309.2545711-13-ameryhung@gmail.com>
 <CAADnVQKrndZ25SuRj-Ofv8tA50XjTwVVyQWmasN94LT9zeV7JQ@mail.gmail.com>
In-Reply-To: <CAADnVQKrndZ25SuRj-Ofv8tA50XjTwVVyQWmasN94LT9zeV7JQ@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 17 Mar 2025 01:25:55 +0000
X-Gm-Features: AQ5f1JpAhL4FwuMUCfAellIo2hw6hNkqLXmHT0-zx8fuphRwh7V31zwhwYc7W1Q
Message-ID: <CAMB2axO9siaKQ6yLyzeFR8v1bxJLUo3Aiu-Cf2r9zxhY5LdyBA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 12/13] selftests/bpf: Add a bpf fq qdisc to selftest
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Kui-Feng Lee <sinquersw@gmail.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Stanislav Fomichev <stfomichev@gmail.com>, 
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn, 
	Peilin Ye <yepeilin.cs@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 8:35=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 13, 2025 at 12:03=E2=80=AFPM Amery Hung <ameryhung@gmail.com>=
 wrote:
> >
> > From: Amery Hung <amery.hung@bytedance.com>
> >
> > This test implements a more sophisticated qdisc using bpf. The bpf fair=
-
> > queueing (fq) qdisc gives each flow an equal chance to transmit data. I=
t
> > also respects the timestamp of skb for rate limiting.
> >
> > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > ---
> >  .../selftests/bpf/prog_tests/bpf_qdisc.c      |  24 +
> >  .../selftests/bpf/progs/bpf_qdisc_fq.c        | 718 ++++++++++++++++++
>
> On the look of it, it's a pretty functional qdisc.
> Since bpftool supports loading st_ops,
> please list commands bpftool and tc the one can enter
> to use this qdisc without running selftests.
>

Thanks for the suggestion. That should be very helpful. I will add the comm=
ands.

> Probably at the comment section at the top of bpf_qdisc_fq.c
>
> It also needs SPDX and copyright.

I will add SPDX and copyright as well.

Thanks,
Amery

>
> pw-bot: cr

