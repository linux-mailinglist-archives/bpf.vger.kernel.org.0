Return-Path: <bpf+bounces-61138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87493AE1177
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 05:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC26D7AA0FC
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 02:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9B51DC075;
	Fri, 20 Jun 2025 03:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ch7S/74U"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183471C8632;
	Fri, 20 Jun 2025 03:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750388413; cv=none; b=MLNTY8LJcjpkVPormPYPY5qyGDqk5MLcCw7uffIs8ZRJqx8Mco/9VZCR6gJwChEKOKTTH27QdRfntmtSTikc9OxMJfFSsA7ZTCi1Ss6gaTDvNiP5Cwz4UJ4+Ir2Ffsn99BFkwEGbLqoajGukdBcvbL7MyFRLCFqCXf7zWT+lT0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750388413; c=relaxed/simple;
	bh=492FkEcbUqlitli7afwsSzul8nCEhg3OOiELnPHhD0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eApFHcZNWjFt6us0rJrtMkYr4ZfA4qDRaNTyZiM4ePj1RrMWmQB1C14ahmZzYCCJDPCklmTil91TVbGWIs+3brPvohdjrJAmmVEH+rNt6JdQoExcQxsZXu9bGPr9VFw2AgXjJ/gJODEO6hGOXMTfeWZOXn1O0CAYpfZg8V9pfHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ch7S/74U; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-450cfb79177so7152785e9.0;
        Thu, 19 Jun 2025 20:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750388410; x=1750993210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ap5dRT8eTtOkg8Wh5kHr4/xuZQ7FxGdTJiWZWoXWBZA=;
        b=ch7S/74UGPW5tqHHhimIC6AlsThoNicwoRNPMmXjtoSuoEHCBiK7ChldCDxOSjURKH
         e/uibot8bJbu9/885u2B+ooI7BHwsKW5Ht3PcPzn0bZyBI7UZpWdEUAjHNZVwhWxf30m
         NKxccYV5nry9Gh2mbt8xmXAtFhqezlD343Cl3RoPFxW9X/exmNUw/BmZOLucGdAVEOT0
         8zIDt4gUNeBmC43IwLkGtni9u442yf8qo52IgHi9eYGeTAgm+e5MxXTO+/eHv8mPNyiu
         zpqmKSTBhd9WprBbBTrk/lmY1mqSUOAPnttHMll2Qso1zPw6OW4tbUOViA6xsURyUDaR
         jaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750388410; x=1750993210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ap5dRT8eTtOkg8Wh5kHr4/xuZQ7FxGdTJiWZWoXWBZA=;
        b=AeR7ZncJrVlBAlVTBfYT+/VDVDNFZpQi2klTCQuJU9/2B1pDxGxS7JSDnFwbGOx8o/
         FCnuREMVrDGBsRLLgCVEnE6Ztb3zEHXO5c0+HgrqfBbfcIEgdU5gG5QBSQFRQmutRbWk
         5oVKFlGbDOqck6kqVJPoLdGFrrvoApb5i9Bq6WfRCXDn0p+C9JvmIo3ELrscxPq/g/Od
         ELxBoA7q/f2JGHjjCUpSSRpxL8PYrCztGQYMCgqdBzfOQLLIpfkaxlduqLTvHm4W0fKp
         BE86mjgq0Xlp6reGVtgv/N+81Jzvh5/st4IH1dt6QIVBtKpiUzl7tmINTfIC0OOOwz6R
         5dcg==
X-Forwarded-Encrypted: i=1; AJvYcCV6p4JN9JuP0HeEcJaFFuY28QahhsR7ut+Lwc121W4+9at74EhVQV4UnrISdKEZH95ONoOwawsAkqJrZ9E4k7wdilTD@vger.kernel.org, AJvYcCVq+Lz1vs9rK/Fa7E2rSyaqkYvHD0ye2wnILPzi7ptGJOfW0Hpp3wHzm2pyhdK37winvxhowfnqbpzpCoab@vger.kernel.org, AJvYcCXNRHji9m09eTjEK3A2g+BzGg3X01ycXAxNwVMA7TLLWRYZzya7pgwceotpVz9pZo1EvEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy35cH12Beo8R4DaYp4JpQryFFLfAXTMnJwh0nAjeVdIH02zAOU
	GcanvuMzDEXF/vzmOjpZgtotW8sXxD+IRm1l7XBjr6TO5JVg28/J0kftoXPvx1ZBxAWCRWb/gpK
	g5rUEL4SFTm3TF4M8EVam8vmJ+P4SR0Q=
X-Gm-Gg: ASbGncvo6FQoiizkIX69rxsL0YHPojEJQJJ2RdRHRDdrOB1f1A3G8Vn7IXw5zZYawPS
	ZW1vsPHL72LNJ5yNbMilDeyRe+ti1bZ/O1CvM5UlGw6Zk90r2F7/j4cwMBiUcqk4rGyFyyCky9W
	3R16E/WHfRX5UtVUP+zNLgfNAcJtoiFopWbbo7YNdr82I8MRV4DhlgiURFoftw2K5c+/R/LP5fr
	tnRwxDXTHs=
X-Google-Smtp-Source: AGHT+IGsnhG6fTAAT1UObGDFDFR647lPms9A8JEG/JJiKLiJ1UD/icxHvsb5XUs4Md6E5j0VCaYuwe5RdMxO1nOqvSk=
X-Received: by 2002:a05:6000:4182:b0:3a4:eecd:f4d2 with SMTP id
 ffacd0b85a97d-3a6d12dafc8mr721486f8f.38.1750388410067; Thu, 19 Jun 2025
 20:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619034257.70520-1-chen.dylane@linux.dev> <20250619034257.70520-2-chen.dylane@linux.dev>
 <CAADnVQLyAeo9ztPoJzU1QJUQf6SMptVNoOzZza02xPuXO1ES2g@mail.gmail.com> <9eedd830-9222-4ac0-8ccd-72499fb85b13@linux.dev>
In-Reply-To: <9eedd830-9222-4ac0-8ccd-72499fb85b13@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 19 Jun 2025 19:59:58 -0700
X-Gm-Features: Ac12FXwaZwTIE2k7zGGdi2J1vur8ZmKROFqRXFOqv5Xmlf0XVxISh9G5k-LHsFc
Message-ID: <CAADnVQJcdVCKPu8aPPj5hZExNTFYAYTd5xkF=Ljfm__+ugirGg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] bpf: Add show_fdinfo for kprobe_multi
To: Tao Chen <chen.dylane@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 7:46=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> =E5=9C=A8 2025/6/20 01:17, Alexei Starovoitov =E5=86=99=E9=81=93:
> > On Wed, Jun 18, 2025 at 8:44=E2=80=AFPM Tao Chen <chen.dylane@linux.dev=
> wrote:
> >>
> >> Show kprobe_multi link info with fdinfo, the info as follows:
> >>
> >> link_type:      kprobe_multi
> >> link_id:        1
> >> prog_tag:       a15b7646cb7f3322
> >> prog_id:        21
> >> type:   kprobe_multi
> >
> > ..
> >
> >> +       seq_printf(seq,
> >> +                  "type:\t%s\n"
> >> +                  "kprobe_cnt:\t%u\n"
> >> +                  "missed:\t%lu\n",
> >> +                  kmulti_link->flags =3D=3D BPF_F_KPROBE_MULTI_RETURN=
 ? "kretprobe_multi" :
> >> +                                        "kprobe_multi",
> >
> > why print the same info twice ?
> > seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
> > in bpf_link_show_fdinfo() already did it in a cleaner way.
> >
>
> link_type only shows 'kprobe_multi', maybe we can show the format like:

Ohh. Especially so. It would be wrong and confusing to display:
link_type:      kprobe_multi
type: kretprobe_multi

Let's fix 'link_type' to display it properly.

