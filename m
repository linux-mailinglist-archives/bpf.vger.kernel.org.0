Return-Path: <bpf+bounces-46668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DB19ED814
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 22:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FEA31883E8A
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 21:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2DF22967B;
	Wed, 11 Dec 2024 21:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaYbOhr3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7252288F8;
	Wed, 11 Dec 2024 21:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950921; cv=none; b=oWgbYP13dNIWBB7Qe/zRrYBB0dpSR/V/fj9zkNhofxD1JmttaWyS6hy0dGethE2OF8GKvkPNQLQ9ak9lAPJcKK3nvdZZo5DlyPHeD0GeRNejJSZ/MyOr+uWtrukthkplXvkI6kpONKeUhtoAhqV5J3wffIZZkxGYyTrhTl3LRJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950921; c=relaxed/simple;
	bh=csRRiiiCzytZrQ1H3djksmI7gzoy+IoGC+kcZP8RbxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dv5AWjNHvFyNwk7zuhUU/+jqErnadEM6KkbPeTZxXgJRWO9OdVv0iGtcN6D80lf6i2y+z4BZ6oRiRCRAKU341GWWCiiAzgZL+m+Ef7bkLfgFQPbHAi45RDMqkgNnVV6SwZ5l2bX2XwzRnsNyygy6h9S5PZPvNfxGWVpcfJ9RKRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaYbOhr3; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so9055066a12.3;
        Wed, 11 Dec 2024 13:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733950918; x=1734555718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZLUcIyBJLBGX0tnLYx2jvxZ90xBkaHyASTogx6sSHc=;
        b=XaYbOhr3OewxxgOL33F6vKhhK0nFotK/knufRYnYzD43mZJzYFB3Cy3VR5xr6fcKmE
         CGLmNtYV2V/8jgtpqooqzrO3EDoY+aBLLVrdX7Tn+MCkQIsPf1JFzs+YMKn6Zl6jL/jb
         Tno9W/kZUgn8LGaZrl1hYBgHBUXFwDF6Gxx3PNcO1RfveuLQkjy1OJiztzKiPDw66qtd
         Zmow6DTp2kdj5CknK2QepA6T+X3I1SqC13Sp0tQdsmXa6mKUNRSSHLDT24RuD8i+yti+
         cmoz4cF1RPdanMaommtI/Udh5AtL+XFiI3ENXXDE2Fz2JgiW4uiXeZRaWCwbq+BelJDL
         IBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733950918; x=1734555718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZLUcIyBJLBGX0tnLYx2jvxZ90xBkaHyASTogx6sSHc=;
        b=At1mdYiS/QAethCLd8KcnLkKEShZXDjXjsBUE7mYeiT8g7y8q5JXrS6XDxKHoeqp3j
         ORZrstttvA+8KCFu4FhGE9MFSiZ8Q+edg/ATnI7Q+tL627yL3aiaZXphWtm6BLncML3N
         nV+OylX/4kNTTFXnX4uQIuzXKZQqkbbWc09lL0rhiQMXmiQ/mCp7/SnaovMEF3MkTd0U
         sxwTNAODyd+r/YnyTLKJGR6Ldy7IdsIwx8pb0qtudgd3fUOQgT36HB0R2xZDjUhUX5ZO
         2mUdW8eFak6dLu2iKbMMQuWABfQg8wIJI8jluAftGgIpgD9lO7kppzT8gADcf5D5Y7sa
         XQIA==
X-Forwarded-Encrypted: i=1; AJvYcCV0EGsANGU8nkS5M+wnDtyPAudxkWtbMG/ff2H2UrFD64Zcp/uJubyCXLtbxs6to/WdLgs=@vger.kernel.org, AJvYcCXfRHLW+5NcKiPF96rTQyTOwMP1Z3tcDNe0H7mcmBNhygDaulwRhv5sw5/3NtaeK18jhgnzjpE+CDx4G3ye@vger.kernel.org
X-Gm-Message-State: AOJu0YyKTA5HUriDwkrifmyK/th7eqriPRvszL0RCcfbfn3ElJhmBAMZ
	13+5druIMoNTkk99WDwcg1ZbqE65vk/iOq//n4Mo5FmuDUtBlHdKgv/A2kR+Pq2RJbXpf9Va8nf
	rEkz7JS4xU2cRDhAQISgJmZQuTtM=
X-Gm-Gg: ASbGnctFk86R9iBnrhQ2HZgn9ToQVta3Pr8emyLuXavWN1EqxCnCQYEBHgzrLjmE5pN
	tmSn1GmXMM59ZEmkDf0UHcIhTKVpve4qzobRY2KDi/LgM1iVnIs8C9gqIZ7Q86psjDyiQlA==
X-Google-Smtp-Source: AGHT+IHvi08f2+n6H7kVZ0qWpFsipQ+IcyQVueerNKjbo72o/zKWf1JOHNFPgXPrN20QmPj0cQWONxwDXEP5VwifPts=
X-Received: by 2002:a05:6402:35c6:b0:5cf:c33c:34cf with SMTP id
 4fb4d7f45d1cf-5d4330aa57bmr4789012a12.15.1733950917870; Wed, 11 Dec 2024
 13:01:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210185321.23144-1-pvkumar5749404@gmail.com> <CAADnVQJvhkDe9t4GuoHrApBeJ+q7ROjq-665CGbusMA-r+tBdQ@mail.gmail.com>
In-Reply-To: <CAADnVQJvhkDe9t4GuoHrApBeJ+q7ROjq-665CGbusMA-r+tBdQ@mail.gmail.com>
From: prabhav kumar <pvkumar5749404@gmail.com>
Date: Thu, 12 Dec 2024 02:31:45 +0530
Message-ID: <CAH8oh8XxqBSvgk4LXSarLbLr7bSK7z7RySZMtLBT6j0FnUsdyQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] BPF-Helpers : Correct spelling mistake
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 12:31=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Dec 10, 2024 at 10:53=E2=80=AFAM Prabhav Kumar Vaish
> <pvkumar5749404@gmail.com> wrote:
> >
> > Changes :
> >         - "unsinged" is spelled correctly to "unsigned"
>
> Is that the only typo in that file?
> I doubt it.
> Fix them all in one patch.

Yes, This was the only typo to correct in the file.
>
> pw-bot: cr

