Return-Path: <bpf+bounces-39366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCE1972563
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 00:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8B52838C6
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 22:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7554B18CC19;
	Mon,  9 Sep 2024 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCaUtScL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB82B18C923;
	Mon,  9 Sep 2024 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725921519; cv=none; b=VzddYWCBWsYLjHEvPRx83i4V1gpJZptCzyGhe/OBdAxNlxwQmebzJWgYhrHBgXRV0nbVyc/Y3diT5rodL3dUmJMaj+0TZOZeLKIE8Gvmxnurx9v3tMRDRV8hQMB93dnyY5UJZmVaRxN7yBYj7Fk6s/qRfz60WpYiYslfEf5laHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725921519; c=relaxed/simple;
	bh=f9MTJckK/S6UWuhW0Pc9Mk0IskeoqK/kZPK0BCiking=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nd4Rgq+hTtE4cXalxUGqKIxMwL5qKoLxEkIhz6x23/PFvb+fJ57+2AA3ggBUMDmIFMe5dJhG8tLO2yBgE/4phWmZIGiuFnLxOSUJWqAi4H5iQu1EhQdjlSIJvYzYVJN+7CUfptzezL/WoVa+guB2MCmcwN328ja3Fr+2McKxlVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCaUtScL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645A6C4CEC5;
	Mon,  9 Sep 2024 22:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725921518;
	bh=f9MTJckK/S6UWuhW0Pc9Mk0IskeoqK/kZPK0BCiking=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OCaUtScLHrRgQVJui32sOoKl2ehQ+VnICYUqbhlnrlzK4I6a9l0p5Onr+udNe9WEf
	 +8/3SJ+/sAbr3zP0W/0UZpKO1Z7xHId19hYk0/YBaJngrwbnvsshy/hPaUtlzx6EFH
	 Ghy3AopJLqMIHIhbErU8cy0+1HwSwow0wqqIves6zwRtdGDBpWZDP/SmCd+lB9b7A1
	 iCTuwhhvDSuI1F+9dbvLCtDRefYDKtTdBfG9Avrmh0jMVwjOdTeTrch/NqVBH4Goc1
	 iEFQTe869YvnHVNTjcGqHtoJSwdOG4ps2J5YdY7BaBbVaxX0pcEDw2F/ZKYQvbB3WI
	 pxO0vtIAp++PA==
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39d3872e542so20914255ab.2;
        Mon, 09 Sep 2024 15:38:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHkkdwCZCzVdciF0JPeKJjoecX4hVn5WQwszkuJNxgkSNEreRqvXfD1AV3BaUDJRleMYhZfjkF2f3Sfmhp5U56@vger.kernel.org
X-Gm-Message-State: AOJu0YwVSRH9mDzqRdUDS91gHOXHePMcp7rZPpR/5qiB+ZQ6QQB3Nhv5
	RryieQt96C7VK8+bfHOctETyIeO/mKdrHp5d5EozVrbL7+ngMzFUwt8g7O8C4d1seowfOdrNHXG
	E/4FIOdyrhV/YvIItHOspyhhAVoY=
X-Google-Smtp-Source: AGHT+IHwA0y7bgW+izmOWWa4PYal4009LCqKzisJVL6z4fjF98DUMEECFsg6Vjm+y4SuQyfTcUeeBEQkcakSUr+cL2w=
X-Received: by 2002:a05:6e02:18c7:b0:375:c443:9883 with SMTP id
 e9e14a558f8ab-3a04f0db9ffmr162288585ab.21.1725921517812; Mon, 09 Sep 2024
 15:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909190426.2229940-1-andrii@kernel.org>
In-Reply-To: <20240909190426.2229940-1-andrii@kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 9 Sep 2024 15:38:26 -0700
X-Gmail-Original-Message-ID: <CAPhsuW77CR5RfG8g2Oax62tb39X3iV=1_wdfAs5W97oiash9LQ@mail.gmail.com>
Message-ID: <CAPhsuW77CR5RfG8g2Oax62tb39X3iV=1_wdfAs5W97oiash9LQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] MAINTAINERS: record lib/buildid.c as owned by
 BPF subsystem
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, akpm@linux-foundation.org, 
	linux-perf-users@vger.kernel.org, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 12:04=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Build ID fetching code originated from ([0]), and is still both owned
> and heavily relied upon by BPF subsystem.
>
> Fix the original omission in [0] to record this fact in MAINTAINERS.
>
>   [0] bd7525dacd7e ("bpf: Move stack_map_get_build_id into lib")
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Song Liu <song@kernel.org>

Thanks for making buildid parsing more reliable!

Song

