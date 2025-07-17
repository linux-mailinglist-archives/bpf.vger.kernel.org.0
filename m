Return-Path: <bpf+bounces-63604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45957B08DF7
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 15:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280773B1645
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 13:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A352E49BC;
	Thu, 17 Jul 2025 13:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="iWfSQRtr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0E927281F
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 13:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758280; cv=none; b=fLilS7Sp3lkZEoFPCSNZg2lcW2wxTSnb46RQ6Xz2mTeILR9q31V2SGJw8yCEiBKUp9gCWqeyaR+ro1B9FPwsyDqckHFvWBP+NG+KHc8NSRNqps03kWORQPemcOruYC+l1A94BO61NZ+eN572uexGBDXdQOFhfx7CfGAf94y2q2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758280; c=relaxed/simple;
	bh=ZDviKLcvI9VrAI+wR/RQw9Ygk7b5+KAWd1c6p2r0hE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A98bmwDXBeGSSQQjxaXx7Vo5QycjXh+CVabbkyql0bF8XFQZwMxQ4cBYwcjJsw2t4mcdTbzCCFHOw6DcFYY9xzsYGmRqMhlH5hsH+5r3r5pvV9rcg07XchwIcod7wC+fRzvTNMwE7jokwoAl4V6USFKAXJAWoB0cXcxbRp5hIyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=iWfSQRtr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4560add6cd2so7879255e9.0
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 06:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1752758277; x=1753363077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDviKLcvI9VrAI+wR/RQw9Ygk7b5+KAWd1c6p2r0hE0=;
        b=iWfSQRtrFcaACc83FKbGj6jkzS/1AZDDKKIgEZwQ4n9Msae8ZYHbRoHBM9pQ/uQZB7
         /L2xlWb/O+RLCsWnbnSLb4qAIiLcS6nziyihSqSWmQKraUSR1xVm3ZNVfOLd/tiL8bl1
         zEyKN3nNsHktQnpJUOtN/7/XSqOeN1TeQIgbaHbcII3uiYL9CFyLI7e8I9k8AsxJgy70
         gi2jJSiE2ouXIQVyWt3vpfbl7rKQslmVLaGwDICMzHXn/Ov/jop90Xk9rmLftMgTbsmU
         V6sIGCRvRTfov6YlQf61QSYTGev5BbVMN6jyuqKeiZYfpPvh+FoqI9CgoNkS1HH7Xyli
         QCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752758277; x=1753363077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDviKLcvI9VrAI+wR/RQw9Ygk7b5+KAWd1c6p2r0hE0=;
        b=pknP0bAWF74hWqR1tbqMuKTJE4efp06bEC50MUBQFwT6NojxptEVEDjmWeGLYb7ine
         JlBjSfCEalvSAsRLlNDlSksFeEJVXJGAIHWNQeJRGN3ZZz+dQlWvUDrBGJ1zhf+LH5VN
         FLksNm80ikbXKdqzdygFg7jilhm7AnjejqVk40vZcdwxiX0NYpFf5HccATG/n7UKdbzq
         MnmSm6bOhgoriETVJwq/mbQG16NN04SHN9ax1kmLcHJzsduayp/nXFLJbK8TgHITccUQ
         qWbGirS0OiGg5uS38GlKlexOlmrfKR2o5cdmEBQXVl9MzqC4YyKXiQqyS8B4Br+gk3Ua
         PtDg==
X-Forwarded-Encrypted: i=1; AJvYcCU568Zn86Tg4EkzZEpojve0GqhLuKywwQE6F6ewS32gIFHjMiHZVnaldBaFoc536FoEsLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJJkf7Gw7O3Teyv6ptB4smBzwQsTyzVPIS7JvwvuMlqaiKW4D0
	Vav9Pn1wTAEjpsI+YX6xEtKveTk+E4TfIwh++BVSz/8zOidMaVBQneohRaSYiFAfPC6U8COGRRE
	XdVu/4vfnB1WgBBFk7w1IzS6/dCAZvaqH88j11ctmcA==
X-Gm-Gg: ASbGncuK0b6qNHXyAvjVc1drTcv38Xxfc6T5YfnOUad9/HVTw+IIv5ved3RI1OmOdkf
	IdDoqHetwv+uKsZTLflo43eZ9+Ca7PKS/n2PCLqhmpojw7fZ9FrfRR1vIcc3oOY8oHFhZkiIJTV
	paARfLQEjD734/Uaa7W9N9SnbomExR+61FNHo8m8WKuSDk2YKqWzK4wwNmLd7kNcfebXcOtTVea
	nejUQ==
X-Google-Smtp-Source: AGHT+IHWUpImxyj/M1iYj87ohSochOBEwmwUERfKvdToAyTI2JfgPVjFu+KTHMnlrSfiuDb5dWth2zr65OoSOyIcwLg=
X-Received: by 2002:a05:600d:17:b0:456:15be:d113 with SMTP id
 5b1f17b1804b1-4563451f300mr28829025e9.1.1752758276810; Thu, 17 Jul 2025
 06:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520-vmlinux-mmap-v5-0-e8c941acc414@isovalent.com>
 <20250520-vmlinux-mmap-v5-1-e8c941acc414@isovalent.com> <g2gqhkunbu43awrofzqb4cs4sxkxg2i4eud6p4qziwrdh67q4g@mtw3d3aqfgmb>
In-Reply-To: <g2gqhkunbu43awrofzqb4cs4sxkxg2i4eud6p4qziwrdh67q4g@mtw3d3aqfgmb>
From: Lorenz Bauer <lmb@isovalent.com>
Date: Thu, 17 Jul 2025 14:17:46 +0100
X-Gm-Features: Ac12FXzAj1uStiEkTmwdY3kJmq5UyFHyQ5GKtR_wcQY_1cDKPtpY4TzHkBJQvTY
Message-ID: <CAN+4W8hsK6FMBon0-J6mAYk1yVsamYL=cHqFkj3syepxiv16Ug@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] btf: allow mmap of vmlinux btf
To: Breno Leitao <leitao@debian.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Breno,

Thanks for reaching out.

On Thu, Jul 17, 2025 at 1:39=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:

> Should __pa_symbol() be used instead of virt_to_phys()?

I'm not really well versed with mm in general. Looking around a bit I
found some explanation in [1]. Your suggested fix does make sense to
me based on that.

Let me run the patch against bpf-ci and see what happens.

1: https://lore.kernel.org/all/90667b2b7f773308318261f96ebefd1a67133c4c.173=
2464395.git.lukas@wunner.de/

Lorenz

