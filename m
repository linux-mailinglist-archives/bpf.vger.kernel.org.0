Return-Path: <bpf+bounces-41689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE8B999A5E
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 04:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75FAFB228E8
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 02:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3759D1F1303;
	Fri, 11 Oct 2024 02:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOfKu7mR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722081EBA12;
	Fri, 11 Oct 2024 02:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728613459; cv=none; b=qlFmx8+BFGrP59uYqnl4wpCluSfNZsDMEUIw+A79RacaKdKvQVBENPONNvOM8fUpB9qU+yl8SrikrLUu+/m/nYNopn8sueiKsivnn0XGuLP4Dh6sMGUZgZa44yxlvB9qnx4wyvmJOppd24qgqhL4qg0BNpapeZ5D5bSze8E2hcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728613459; c=relaxed/simple;
	bh=9ztHxmSrToNsdDIpLi7GhZAB4bElEtlTyZvrCU+eIBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3YwrP4HtelZBHrXXZ93i4zRsM4hBB7bHEb/lcSsvS/cIzZHzKvDDMJm5jvYqlcEIVzgsImzSQw/xmBqLOECNwOerVMtXUnFeosxOyr5EiwPRCffegiLCMw3fAE50zjHqLkA8CcFTJIW7ah/Or2DAb03TpmgIQKayIG1Qw8Duxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOfKu7mR; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e18856feb4so1482590a91.3;
        Thu, 10 Oct 2024 19:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728613458; x=1729218258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXf6jkrRce5/ocvUAMTnc8Jn/sXw+jgw1Gddu4BNoNY=;
        b=eOfKu7mRo0Px9WwRw1kxBm0hpGdvBKFqKLJK3a8ugNnL6OATVr/vkdv04MGM5zIMG2
         jaItrYB2l4qzCtEcZXOVG/wcwVowbTn39JenDhdYHy5ZW/02CQaMqw6w1GoQnWILTQYS
         4P344Ivg7GIePPYZdtwFAC1MN8c7SIPIYSJd42ap+TKPX+r3lGM4s+lYLjGse0AFcYVl
         EkP252ds7PhazyDR9dtEf10jk9WvrRyhHOY0Oi5lEx0mUe4DO7kS71n7mI/RO8nO7jGG
         4FP5crakc2CC1IvAB/Btewl57G+8MkBHHcwx2HiIgnXZsImUTNs51ZyEVLS41k/oixmG
         AgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728613458; x=1729218258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXf6jkrRce5/ocvUAMTnc8Jn/sXw+jgw1Gddu4BNoNY=;
        b=rb6T+a5EkRMHPAwmLM23mpqIeRIsNP04CItEEdFmD1yZRLT6A1xwwKzy7bzS/9I8tp
         dYIddsHAWXwt2rizgbaPqG/UtZgAZhkFvvrVsMdVI/DvIUiK4H0yzsxXnZs3DLNKtOh6
         nKUfUAMn7/oE3rimsF2+I7SwoGZDrWrwRFaFE8LnaNj/Z6v52pRIeArrYwbtdgdNaxBT
         9vKiYVr93nXqOhoqwyVl3vwqQ5ZJpElmAcWWkbnhexOykhJQESXQ0A6f1Qqgnf4RYJN5
         AwzKTgniw1gUWuM4dkSXxa4SsJ/mj/HzPBmPuNEqVcnhlX3qEKDFbhWZ8MLsKn/jkzMf
         GThw==
X-Forwarded-Encrypted: i=1; AJvYcCUEH6LpN/VDl1UBWCy8pDxQ911xo8n8QoxzPVyJfRK/hxetRjNcfNmIbJkH/iQxv82CEJE=@vger.kernel.org, AJvYcCWA56GIFQDB3JZX2PI93zZawIQc2saTCHVgYjUScbtC1RKp0mCTsQ35UBPL5tBPYaeWuKQmqnKaGHGQmOcj4vJSmHEG@vger.kernel.org, AJvYcCXotz19HV3apdH8zOcPF5Jyk6LRxy5KUwNqpGLxmR0EHbJybr+3Gmwi6OB2h70JxAGjzaYkmdoIxCnP33Y/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ZPkkNmTbFG6R52StE3//tmafu8VFx8rm801DjkK6vn1UG+SX
	g9Jj6goK0U6lh5PvUNfxroyT5YdcLx/DVpPe10Ph1/VzwZeZlFcTiPNWCbroMrTSDXss4pXhIlN
	sjKQBnNtgGKLZBIkW+cGvsaOzOHA=
X-Google-Smtp-Source: AGHT+IGlS/HUji6dHe6ubBiE2BR5uAHgtZvrGULN5UTtQso7K8DtjuGnxHA35ZSJNhqP9zvg7eAQwKAXJOMl6OIxqxk=
X-Received: by 2002:a17:90b:4f87:b0:2cd:4593:2a8e with SMTP id
 98e67ed59e1d1-2e2f0a6e9a5mr1647275a91.15.1728613457760; Thu, 10 Oct 2024
 19:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010200957.2750179-1-jolsa@kernel.org> <20241010200957.2750179-13-jolsa@kernel.org>
In-Reply-To: <20241010200957.2750179-13-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 10 Oct 2024 19:24:06 -0700
Message-ID: <CAEf4BzZgyWvH0861qu5w_r=4-K2khd-06bcB5H-VtzLi38qR7w@mail.gmail.com>
Subject: Re: [PATCHv6 bpf-next 12/16] selftests/bpf: Add kprobe session
 verifier test for return value
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 1:12=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Making sure kprobe.session program can return only [0,1] values.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../bpf/prog_tests/kprobe_multi_test.c        |  2 ++
>  .../bpf/progs/kprobe_multi_verifier.c         | 31 +++++++++++++++++++
>  2 files changed, 33 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_verifi=
er.c
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

