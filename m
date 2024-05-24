Return-Path: <bpf+bounces-30523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B21B48CEA51
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 21:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544AA1F232BC
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 19:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FE75D477;
	Fri, 24 May 2024 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuQQw5jh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EF41CFB2;
	Fri, 24 May 2024 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716579243; cv=none; b=sDZGJB4DIYYlAV8nFs9nTZacXUSVkyfvvTmi0uyq2yuhkVaCx1KhPwnqX4Rw+Ea7i3iBnjp2rOfbi49wq7tyA9v+PbGdMLlqxV27q95dO2VDSQ59dW4VdRhvzwZZ7aVCDgatGvA4VJG9YlFNol+ewl9oOkTtofZxbtF2oOxrJCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716579243; c=relaxed/simple;
	bh=5owtB7N7sYNPWMNez38xq1JpwdPsm3eY7gGG9HRQMLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljFySFGxzmpOM7ub8yQPs+cKmsZbqP3oEBErseD83aKTkfVYPH7CQKiqYo2Ku5eu+3Aw5FifrZDYdfdtJW0kr64Xd8d87M5HfJelwe9ie7SNJo8ttDd1BKrwvj3KiD6ZtLZutG32g6dvas21mSHlSLcN6NLCRpvjuhylJnTuBsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuQQw5jh; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-351d309bbcfso2394882f8f.3;
        Fri, 24 May 2024 12:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716579240; x=1717184040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5owtB7N7sYNPWMNez38xq1JpwdPsm3eY7gGG9HRQMLg=;
        b=kuQQw5jh2U7ynZ8CqOUNjX/73FDIiHPSwtivAiqj1K3BmmZrFmnnmZUI1+Htly12WQ
         4YGoWiwct3rN/cBXFbzFQuxdAQREwrG7sxPhRUHJRUnPV241VkJalwR3qH8szyxym12r
         LU6TRZGA2wVh74KHJcX48YkVYm+XcFG5LDU5nmAoUtpUzmBZNQYbiJGMCbK+FSKJst3l
         8uuzxTrDFuzfc6o+8lw+FNkDBYszV9TPE3cBeQj4i+xk22kVq1KbWwEn19mBNfg0OLET
         QaXdlcXA8JiVszE9lTbAQjz8paTMplUG7bDkDAlY3cLHYxqViiJGHWuqg9nw4jp6biSp
         bGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716579240; x=1717184040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5owtB7N7sYNPWMNez38xq1JpwdPsm3eY7gGG9HRQMLg=;
        b=Zee+hIGtNPzn6Szl25xyN5qsoJhSwvxp8mPIOTvoiHmy/JjY+2eObOlH/CKPpAquiy
         FSDj9rl13RYdX9ODSmxogob6al31ITerOtdEfxHf4c76sVZhJXABq2LOc3lUGSZdgXFs
         tGug9RjbNzZ2xA49UTtld6poIEhQFk58BgYwCkT91mp7yOf+qEmxhphjnzzjF4MUYOmq
         uDWf0VQ1Kdv87rl+bPo0Gg9WifIv/xj8QPrJGWeT5+SswdhUWYK4a6mVnGrSumM0nMag
         I5IDfclFl9ESf5XgCMv0p6XFcjkXo5UlEZjTR++TBhhN47PTZxZCSV/5fQrvTgyu/HEG
         xcBg==
X-Forwarded-Encrypted: i=1; AJvYcCXqZU3KKB/K1sT0b9o+40CEgA6edMXPPNu+G7vn1yCjQazcQURWgpthi4tKR+5y3oH59/adsmj20PreVmy4oGBDky8xiwHLW/LfvwdbIp7dAglc0hCRX+GXcEQV
X-Gm-Message-State: AOJu0YwOuJ8Od8m4Sc9g5+nFuxaTsByiUICCkAYtN9OpA46ADCGI6or1
	i94oFnH5QYuxyFYeRD4AjsugEwjg7oRBeBSS/ONLkIA51r/DsbEi6mqCasYWBlMR0Lqr8gPYQst
	G6YPlMlzCgcThvP9g/8qUeHYPKS8=
X-Google-Smtp-Source: AGHT+IGF+DtPnkp/OUyjdDrjTVCLmbxKWp4HcZUGyz+IcSi2Bk7m0AS5OW0YzvDXoy+bse4Pr9W4CZ7ZyVyFWyX9GI4=
X-Received: by 2002:a05:6000:d88:b0:354:f34c:646f with SMTP id
 ffacd0b85a97d-3552fe020afmr2168724f8f.58.1716579239553; Fri, 24 May 2024
 12:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510192412.3297104-1-amery.hung@bytedance.com>
 <20240510192412.3297104-19-amery.hung@bytedance.com> <6ad06909-7ef4-4f8c-be97-fe5c73bc14a3@linux.dev>
In-Reply-To: <6ad06909-7ef4-4f8c-be97-fe5c73bc14a3@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 May 2024 12:33:47 -0700
Message-ID: <CAADnVQLLqy=MTK_u2FMrxUEZRojYPUZrc-ZG=Gcj-=SaH9Q=XA@mail.gmail.com>
Subject: Re: [RFC PATCH v8 18/20] selftests: Add a bpf fq qdisc to selftest
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Amery Hung <ameryhung@gmail.com>, Network Development <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, yangpeihao@sjtu.edu.cn, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kui-Feng Lee <sinquersw@gmail.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Stanislav Fomichev <sdf@google.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Peilin Ye <yepeilin.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 11:25=E2=80=AFPM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> > +
> > +unsigned long time_next_delayed_flow =3D ~0ULL;
> > +unsigned long unthrottle_latency_ns =3D 0ULL;
> > +unsigned long ktime_cache =3D 0;
> > +unsigned long dequeue_now;
> > +unsigned int fq_qlen =3D 0;
>
> I suspect some of these globals may be more natural if it is stored priva=
te to
> an individual Qdisc instance. i.e. qdisc_priv(). e.g. in the sch_mq setup=
.
>
> A high level idea is to allow the SEC(".struct_ops.link") to specify its =
own
> Qdisc_ops.priv_size.
>
> The bpf prog could use it as a simple u8 array memory area to write anyth=
ing but
> the verifier can't learn a lot from it. It will be more useful if it can =
work
> like map_value(s) to the verifier such that the verifier can also see the
> bpf_rb_root/bpf_list_head/bpf_spin_lock...etc.

Qdisc_ops.priv_size is too qdsic specific.
imo using globals here is fine. bpf prog can use hash map or arena
to store per-netdev or per-qdisc data.
The less custom things the better.

