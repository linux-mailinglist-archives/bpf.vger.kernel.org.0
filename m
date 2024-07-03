Return-Path: <bpf+bounces-33795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFF0926837
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 20:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75919B26C7E
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 18:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8003188CBC;
	Wed,  3 Jul 2024 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chi9m5jO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA13018732E;
	Wed,  3 Jul 2024 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720031485; cv=none; b=qGKJlbIhhvgJNMQd+jIb9o/66f51rAKwdKAPVikR5FDPZARvM9DEjsWuTntJ5tAzf9Evkp0m6MSa3xe1qH2iofcbcGqRm/iE3GQAoQregX99dsRIbu3qET2yW8Sb40ghtYtJ2DCRvMtce+oW4/RWnKmFUaK7FI7c+7QIOT/XGRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720031485; c=relaxed/simple;
	bh=V4S0CxMRnSvYvHzN0GPGie7qQ36EqwM5p/rZ9YCmFhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LGmZ7F9Bs7Wn91PAcr1NdQ1XUlNSjmUNG1ItcX60KvJa5t1bMOKXm8sL8lLMlBE+KC3XAsrK6JP3bggPNoW4br118QZGIEZcZi2GkWlVxZQW/1/ooaBl1Ctyb0Tsbpq4lHkxGKtld/7fh8Hs5rUY7VWPdW84Yk8QCfoIp59PkYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chi9m5jO; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7066c9741fbso4805263b3a.2;
        Wed, 03 Jul 2024 11:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720031483; x=1720636283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SI/keeN8Nl9itzHGPtTwBVhxNzJqF/p8dsd8W3ACB/s=;
        b=chi9m5jOFUHdsFTW5OV0kRBGMdYBA94cEz9rYVODSPgXbdu0/s0ibE+7F2DPxBs6O4
         TORJ4DV93kgn2EqnZqhC6b5W7gHVciDR/o9lT7WjfrE12lmCwV12yhbv4Yu4MM26AkaY
         oJ/zs2TSE5Y9zIfibznGERC4/O85/AIPfkwD8/10Mewu4oGdrxvlrybpH6a3u/Sd3YCt
         6//O0sD+vjQ3gKj41LGHwHypG+xQhj8wVY7dg+2XYb6zMqqCF5qRw+jXk7k9LVMT440Z
         FyNWkzgwIPX9JXIf+c+0F3s0oZC0uB1+Zv2eHy2I5yt8XoNWumUCYO31LxiirlxHpvyQ
         2CqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720031483; x=1720636283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SI/keeN8Nl9itzHGPtTwBVhxNzJqF/p8dsd8W3ACB/s=;
        b=LatHOhF8mDLQD/1jC7jh6inlU4wX6arWuGhiW2+Fn8G/fcku92T1XN+hgtyUfaRNkZ
         A4NBTcjvhwAT+RyJfeCRiXqnWXZQj6oXVhJwDJmDjPmV/tIx9tn73eqoYVeDkZdXvAC3
         mEJa4b8f/jYfOaQ7/NA0Il+2XnTeJNveNg6Kvd+MMmehKDX5q04wSTuuJJJ9Lh5mWVbx
         4slAx+EoHTco45i7KaZlKi7pcsA7/LZ24KMQGYP197G6qttTus1P54M0pHjBjEUyPygU
         hTey5fCoTjOr3b0to48ivVfEtHJ/7tjLKXms42xMkLOYp8edMg+TKppntmfiR2RDeaPD
         jqIg==
X-Forwarded-Encrypted: i=1; AJvYcCUDil5j8qGcQjhNtLqRT9w1RF6kK1KeztTbHSVwQYVa5kmlIfXbmB9owdSJt/vWQk/rRP94h5eFL81U9iV8eseCK2bjkhoKxLyya5qhcT+iBRigNKLn88oDMZJjtIcU2Lro4Cb3uDj9OUd465FyqKiYkgT3/M81UxK8nRBqdNSPVfDRK9Rl
X-Gm-Message-State: AOJu0YxUPplYmXJUixHY0ZQ4DYc2ifDK4LGHElyWwtfmOEinkRCGvqH/
	nMhHY7yryKCvSBBoNJ8y5hbrZKeNHn+6b/0qjIoGrkuwDEge2/9IFLfdwPntkvZQvc/EXP2CUXy
	3vWpWNzsNsrp/RIPgsjLenZd6Gg7AVA==
X-Google-Smtp-Source: AGHT+IH1xp8xLLWC3tFFjccqs4QekcasHtnptMSUwODJPuX9Lro3P1489i2UXWeHxhZt+VLtbioPR67Qaamqx1SYjbk=
X-Received: by 2002:a05:6a00:3e11:b0:708:d6cc:82fd with SMTP id
 d2e1a72fcca58-70aaad3aed1mr14658614b3a.13.1720031483108; Wed, 03 Jul 2024
 11:31:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701164115.723677-1-jolsa@kernel.org> <20240701164115.723677-2-jolsa@kernel.org>
 <CAEf4BzZaTNTDauJYaES-q40UpvcjNyDSfSnuU+DkSuAPSuZ8Qw@mail.gmail.com> <20240703081042.GM11386@noisy.programming.kicks-ass.net>
In-Reply-To: <20240703081042.GM11386@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jul 2024 11:31:11 -0700
Message-ID: <CAEf4BzY9zi7pKmSmrCAqJ2GowZmCZ0EnZfA5f8YvxHRk2Pj8Zw@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 1/9] uprobe: Add support for session consumer
To: Peter Zijlstra <peterz@infradead.org>, Kees Cook <keescook@chromium.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 1:10=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Tue, Jul 02, 2024 at 01:51:28PM -0700, Andrii Nakryiko wrote:
> > > +static size_t ri_size(int sessions_cnt)
> > > +{
> > > +       struct return_instance *ri __maybe_unused;
> > > +
> > > +       return sizeof(*ri) + sessions_cnt * sizeof(ri->sessions[0]);
> >
> > just use struct_size()?
>
> Yeah, lets not. This is readable, struct_size() is not.

This hack with __maybe_unused is more readable than the standard
struct_size() helper that was added specifically for cases like this,
really?

I wonder if Kees agrees and whether there are any downsides to using
struct_size()

struct_size(struct return_instance, sessions, sessions_cnt) seems
readable enough to me, in any case.

