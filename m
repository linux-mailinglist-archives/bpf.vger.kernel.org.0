Return-Path: <bpf+bounces-64620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97723B14C78
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 12:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A713B33D2
	for <lists+bpf@lfdr.de>; Tue, 29 Jul 2025 10:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8E428A1E3;
	Tue, 29 Jul 2025 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b="GVTnbsP1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD5281749
	for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753786101; cv=none; b=Sk67FIAcYN9AZ2sk7CtTK1sT/T9l0L/Y3OOdm0yaxhwikXZxRPrC6VWMtE0VnDn3YA0v9IdbmNYsGNVcEOTbKCIlWSHJcswPVgquRbHj6ikxn8MCwJUqt+/RGaioVSrCQL1qKsWXbOBvy4O2gEYmOSrb5tmqfwaMhjoH2CWD1Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753786101; c=relaxed/simple;
	bh=NFelHXVywwHzKj4UoAhZlts7rz/hLfXxyfPT7gqTTBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WQ44NvqqOasFwsQko5QI7VFtfYpYR1klfq8miv3JQ7ll0pD6gTWqcsnT0WSQSsCDrI5ZXT55/AgFC7Vh5SgCHUKxXsw168beFmg6g9cq7nSNhR9slr3566/28c9QON1biz6cbSE7VNEx4WQp1JSCi1mSdphq3eg8PJVL6eDru/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com; spf=pass smtp.mailfrom=siteground.com; dkim=pass (1024-bit key) header.d=siteground.com header.i=@siteground.com header.b=GVTnbsP1; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siteground.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siteground.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553ba7f11cbso5837761e87.1
        for <bpf@vger.kernel.org>; Tue, 29 Jul 2025 03:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=siteground.com; s=google; t=1753786096; x=1754390896; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iq2rLXupGZlNrpVi6ltbUFWldFuOFIJSLTiEUBR1b6w=;
        b=GVTnbsP15VsJWABfZM9dgZ8kEOM7QJBpeZ5kp91+zKpMww3FC/NRmCPyeLmpcLp0pq
         V37xjjya+yW64rrtif9VsJ3Tjehw8znwbqz76zMA/I3zPmWKUtWxheUWC/OGcNEetxSs
         EjUmsl+1gvePIcKuknx9uibsToAe+pNp+VHPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753786096; x=1754390896;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iq2rLXupGZlNrpVi6ltbUFWldFuOFIJSLTiEUBR1b6w=;
        b=ZgIx3xY1EtlESQVelNN+CyHoFvCpMd/cMZs692Y2HFW0AYWZnZJ2X3lS9JT05GqvMA
         75u/BYXnE/ybhy4N1Y8rUmkDCY9ERb+g182gy371qK/YADMOuI9/hfRv16ccl6fSX6jf
         36IrLNW3T2Wpup96Fmv0L0/nVgVI6pFYBGv0eZ/L9pvmnqYhQZPKikYwj7VKoRTgJ0eK
         iEEiBYL4stvDB6A7yN9mJFKUZPilZt/nayt5lKXUH0dp7iRNwkKVbu/Y4GouWx6xZJ13
         VlBGgeCGgM1DbsHGlzVKYZTq9KLrnKrvKtb57deyIlfNtltlWk7QCjusWxIKcThGeo6T
         VCoA==
X-Forwarded-Encrypted: i=1; AJvYcCWDsSkkq4Ajw0g0S8fa9rIpX5BysCgNECIPzD3SiZKdlOLqvycRKPsXf9yiL/gqHuBQPCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5czQ+uAHA4hdgPOvxPsoTF4cZLZu4d6gBkZ/bbT5rWSbpJMsY
	rLNu2S/+5ccnHlq9DV0UzuiW8yKa5ETeaaVFtuYZEyYb/jg/FBWSOgL+W15q08IkttZiCitcMD3
	w238r/U3Kg04ZZPGxHARDDPmLZeSGeI4si0pyLIYqWg==
X-Gm-Gg: ASbGncsvyiX7eUi+1dPhLjuICqL6KyWSgybIOa7wuAdDbTIdmsR5228xg4LUgvcMt2z
	GpAKD0SD7PLJNSmRKqA9VRcYwFKuhBDS3JX3qpddM0ppe6lz+dsgyX/K2xCPNObBu1b1eva8Y5y
	qqZWoWE/0aCMNMOBOAiua1H35014feYiSDGL81w59/eehtefuRcMqJx4wAFN9+xYhkvszVnnNk2
	E9te2nXMddvzkqyFSY=
X-Google-Smtp-Source: AGHT+IFYtf+vOd2uRskucPJeHxEVNVgFsLmJeZ50w1ZoDzNvqeGb5PDq+cBuX+zNE7MGFzOnpWQq6ZgdEVyVxl+PMJw=
X-Received: by 2002:a05:6512:3e1b:b0:553:a740:18aa with SMTP id
 2adb3069b0e04-55b5f3ee5c3mr3835516e87.22.1753786096100; Tue, 29 Jul 2025
 03:48:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2eb5612b88b04587af00394606021972@epfl.ch> <tkwmhg2u6qjjqkncnem3vzpprsnisdoh7ycpxtsstlry45vtjp@wvsve7i2hjtg>
In-Reply-To: <tkwmhg2u6qjjqkncnem3vzpprsnisdoh7ycpxtsstlry45vtjp@wvsve7i2hjtg>
From: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>
Date: Tue, 29 Jul 2025 13:48:05 +0300
X-Gm-Features: Ac12FXzzQ1wOBfTGdkWMnb-kNZi00o6j_Tm1Akp64VTwHbcqEmdqPXpwvcL0Abg
Message-ID: <CAHx3w9K32xd2kwT4Px+3apyK7=m5PJokp3Y6wG9gNehaCQkB6A@mail.gmail.com>
Subject: Re: A summary of usability issues in the current verifier
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Tao Lyu <tao.lyu@epfl.ch>, Paul Chaignon <paul.chaignon@gmail.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 29, 2025 at 10:52 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
>
> I would say it is just not as precise, rather than inaccurate. But your
> point remain, the verifier was not able to come up with [0, 0] as the
> range after instruction 11, and we end up with [S16_MIN, S16_MAX]
> instead.
>
> Dimitar has a patchset[1] that make better use of tnum for sign
> extension, which should address this.
>

Hi and thanks for the nudge.

Agreed, to me this looks like the standard worst-case-scenario bail in
coerce_reg_to_size_sx() when the sign bit is unknown, and more
specifically the higher bits uniformity check here:

    u64 top_smax = (reg->smax_value >> 16) << 16;
    u64 top_smin = (reg->smin_value >> 16) << 16;
    if (top_smax != top_smin)
        goto out;

In this specific case, reg->smax_value >> 16 is
0x7fffffc000000000 >> 16 = 0x7fffffc0000 and shifting it back gives
top_smax = 0x7fffffc000000000. reg->smin_value >> 16 is
0 >> 16 = 0 and shifting back gives top_smin = 0 so we end up with the
large range defaults.

> Dimitar has a patchset[1] that make better use of tnum for sign
> extension, which should address this.

I have a simple out-of-tree checker which compares the resulting tnum
for different implementations of said scast. I haven't drafted any tests
to verify this exact scenario end-to-end, but the patch tries to deduce
the bounds from the tnum, so I ran it for this case with my proposal,
as well as Eduard's version of tnum_scast and they seem to agree here:

    ./tnum_scast_compare 0x0 0xffffffc000000000 2
    Input:  value=0x0000000000000000  mask=0xffffffc000000000  size=2
    tnum_scast   -> value=0x0000000000000000, mask=0x0000000000000000
    tnum_scast_2 -> value=0x0000000000000000, mask=0x0000000000000000
    Result: PASS (identical)

Sorry for the delay on this patch on my part. I'm still having a fair
amount of trouble on getting the whole changeset to work with the already
present __update_reg64_bounds, as well as writing some adequate tests.
I will follow up with these blockers on the original series.

