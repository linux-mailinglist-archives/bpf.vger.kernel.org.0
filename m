Return-Path: <bpf+bounces-66469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606FCB34F14
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 00:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BDFB486F76
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 22:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1CD29B237;
	Mon, 25 Aug 2025 22:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hV+3JRfA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041FF19D8BC;
	Mon, 25 Aug 2025 22:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756161391; cv=none; b=bTXHa4xxWr+kEpqY6oTEZE+9UauSSLQfhY+Alt9YNHDomzy7XqwzmOhrveLhRwwY3p3ZQTX5UBQ5DYECz86bQteNB5/ud+GfX4gXpOnlpIk6smP7Wc6xPwyj5XsN66i9kwTsWseDXx2+DwM3gX4RrIZq/HIel1v3/egDCVSvtnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756161391; c=relaxed/simple;
	bh=Re7raBYpwzWLhMdK466Jq8YEH0TDoPebw5tIeYmb6mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfW9/ytXtYvFw8VT6H8EiuZa5VC1msAhKxm/GCYlfLqz1MkpqmO8v3RCSga+b/S63tS4QBQtJFHJe9cT7CcojMlvqWhBsOfEqJkFVOfgChmuYPAn/XzXVK83+Ugi5Wwkj6CF9nTPlMQJJ4AKQXYCuAEgCZeMptxCFhH5yVnyVRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hV+3JRfA; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e95346fa32aso2040224276.3;
        Mon, 25 Aug 2025 15:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756161389; x=1756766189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/uFYFjrEgwg1306G4R+XnJ3rNvENpkzAhTjbwHJ6BGU=;
        b=hV+3JRfA1Ed5usxNwPm7OytM8NZQJ13QuXRgkE4bc7RG+ueiWmAj9D913DeZOdzOwT
         58JcNqAn1NnSdRudtLgDJOi2G5r82Ddqqv9sB6I/8XsmUR+1pwBT50qnkevwTkpbADUE
         gH/rDTpbFANNirAs6gUEorNWHIqEQFjRqgxCS9TO5zGEbBwWVRGhpd+lUnfoKO2WPtvS
         cwLpDHlvIwOQHDn3Ha0qxMS0IsXjJY/5kbcy439EbiYK/uJCevwavLvKqBdtMvJw1Vwe
         FW8jzuM/2uXWV75+69jlLujU94baOAh9Z+POz3d/F+gKADB74cpwFBJDkO6lsTf+G/cF
         FlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756161389; x=1756766189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uFYFjrEgwg1306G4R+XnJ3rNvENpkzAhTjbwHJ6BGU=;
        b=DX6RMP8f0l4WuTBYIMEVe5qJCOqkFKn18z9u8TOzd6UFzsaCqa6Lx6fbnpeapadUNJ
         xpZmnMf/E3/mZykZEt9Xje5fW1N9PhPLKBUajUdLi8UI810QW50c4Ch5lNCEpPElFi1y
         1kdhjKvpKrr35feua3R097dGXBn4wpjCy8p1iVOAOFLtifNNUIOmba149iLUH9YYD8Mm
         sKMwsOVpoAt2eUpSvDOo5FC3ZuKaJe0buQNtAUTrlWwBjhUvJEI9jVvjvU3EG69u5sdn
         RymDj8iD5v44JgwBBxiNwU4/auX3nLxZg1oxZkI8YjR2QVnW6K/7tO+Nv9f9P6NFvxLM
         etwA==
X-Forwarded-Encrypted: i=1; AJvYcCVgHS+CrTLNkImgLrPjSVsbr2ZWglb9VbhcQpcNjHWwDYLf82EwO1+cwJKRcsuEXEbVTT0XNo8i@vger.kernel.org, AJvYcCXiWy08AVPguvn+th6fxq3daimm8ViXGTFSPeKKE6mw/lSBxf6AWf3WL+0UTvdtnZNFndc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycM35vdlDUZepDp4Iy6RescuGk11mEh5+PAUJsz1bVf9ZFonqk
	q+ECpRYOEEc3FgbRqBpi6tR2buF5GJ4UsCUytW9gmxoWL/RVWG+U4kVvdGYSH80PqVrEgzYV/s+
	Mna2dp2Bnxbi6nO62hlLB2toOiD8JKjg=
X-Gm-Gg: ASbGncsxlC/BxjmEcJib7fPu6SLQi/GIrbNLPgQtRiWUA2SkJ3GvhdNecJg05gtjmG5
	HNG7woiD4zHquy1d2QwAYQaevn98QJqej1oelNqqknTAp1H4olo7daSs06cy7yBIDzguAJLJPxm
	4zXQIPFLoPMWDtpU0RgIPt0JvAGPS/W5KXo7IKkyGHMYI7ad0dIppZZXFYH1KBGhiuCXTTo6IQM
	wJ0JmI=
X-Google-Smtp-Source: AGHT+IGki4+jWSCgNXMsdXvoMb6RRvde+SEKF3K3j3XHF0cYxGxaPvwvzsPyV872AlydGFoo85vPXS+LElKQ8zSmopc=
X-Received: by 2002:a05:690c:4:b0:71c:1754:26a0 with SMTP id
 00721157ae682-71fdc2e8c24mr157808947b3.19.1756161388752; Mon, 25 Aug 2025
 15:36:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825193918.3445531-1-ameryhung@gmail.com> <20250825193918.3445531-4-ameryhung@gmail.com>
 <aKzVsZ0D53rhOhQe@mini-arch> <CAMB2axOkPx=5vseNXbwQtHQTFhdur6OSZ-HbNPUciwBmubQa1w@mail.gmail.com>
 <20250825152946.4c25c538@kernel.org>
In-Reply-To: <20250825152946.4c25c538@kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 25 Aug 2025 15:36:17 -0700
X-Gm-Features: Ac12FXyMFw_IVIa9lRPUYVglzneqKQ1R7lJ1A_s5NpboIUoIRkdV675zyGwukd0
Message-ID: <CAMB2axMxJT4UJjE+=zk-yTpptMW5ZcFTM09B86r_cdnJFfvfew@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 3/7] bpf: Support pulling non-linear xdp data
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, mohsin.bashr@gmail.com, saeedm@nvidia.com, 
	tariqt@nvidia.com, mbloch@nvidia.com, maciej.fijalkowski@intel.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 3:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 25 Aug 2025 15:23:23 -0700 Amery Hung wrote:
> > > > +     if (!len)
> > > > +             len =3D xdp_get_buff_len(xdp);
> > >
> > > Why not return -EINVAL here for len=3D0?
> > >
> >
> > I try to mirror the behavior of bpf_skb_pull_data() to reduce confusion=
 here.
>
> Different question for the same LoC :)
>
> Why not
>
>         if (!len)
>                 len =3D buff_len;
> ?
> Or perhaps:
>
>         len =3D len ?: buf_len;

... Ope. Thanks for catching this. I will fix it in the next iteration.

