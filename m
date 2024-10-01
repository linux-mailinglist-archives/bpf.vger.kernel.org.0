Return-Path: <bpf+bounces-40663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6707D98BD4C
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 15:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9952A1C239DD
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 13:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E4B1C463B;
	Tue,  1 Oct 2024 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIFm/LrA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078011C3F2C;
	Tue,  1 Oct 2024 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727788686; cv=none; b=E/vxtX0wmdVnKkXDS+xfhWZUCjqGyerXdbORi3F6FTK4bnmNDJAMwEQiVx+BIIuQoDyf14FC3amgXgiqz7yyIsAfM/xep2kLbE+ukn+ho1jX8QBiO5qQw1Lhf3OtJbuizyhA1uITHB0RCeN3Bzg3RkDvxD6Ggx8Df5GGlx80mh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727788686; c=relaxed/simple;
	bh=DpSHN9WyPzcuhaxUgQoR5UMNYvF7CCvuYoz0s7YZ1H0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ix4o/8aZjQklXZIk6aEpk48mtjgvI9YxcEsCPLeD8Vkj/yksY/bhg0LNtAedsOWx8/27H1UlhhT73intQnvjCo3bNw92UJUW/TR9XiWv2DBbyet8sqRKaDv1waFhqdVhZWuMTyRzI1ByzHBcTNSJ6x1V8LhsyrbwARZlRi3DnFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIFm/LrA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so67812995e9.0;
        Tue, 01 Oct 2024 06:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727788683; x=1728393483; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jw3yE4PS9iBt54wAdW87Z+Kt/24JF7ifPKRy8oQxPqs=;
        b=aIFm/LrAjkBBEsdHEvxQ/3RGWrVT5sGROFsf3kNLNRVevoJirQVH6pkZqW/Uy5ZXef
         Cef51SC05U/+xVv79re9llDlj0R7de5PMKhhDXIq2Y2b427inux2JKWe2P0M5OYU6I1x
         wSUSbAt34aiBLL9SJv0oUhwNBgUjh5Da4QE0MRJege5pGaZnIIukBm0RPVfWcYFh2f5a
         sqjLH4CrqbNu/C/8kiGfvHmrvJlH5jh6JzD1t6FYIgD4OGgJfw4qmWQzSkDXwiAG1fyi
         305D0jEQROZ5vX2/Q/ovUGZmUJSSJuYSTtrALwq8/4qm8OK4dCJmbOlyedTTue9Fy8LW
         sm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727788683; x=1728393483;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jw3yE4PS9iBt54wAdW87Z+Kt/24JF7ifPKRy8oQxPqs=;
        b=nWh7vWppAWACUbslrogRjESHbNNQSorn+gaKD3VllnEfnJa3H/Gs/uDXIqRvCD9mLx
         FX/uyH5k4oWX1rtjo4MkTIdO4eQ5la36ZnSvQW1gQxKy453BVHKtS79AHzCjBnKCs+BN
         Sp5CE8WvxPBM2K0tovDIQqDddGIwbp2mkI6ayz6vaPzqLe3x1oA3iVO9Dt9aacNu8Uw7
         FQu4ImTVz9obNSrtZ+ykPTsveEFcBd76ROPFqLohEDjsxxNSCiudVlApDRvOkuz1IBVd
         +aMQPC8Yk/OFKGWW/KX8+mB1xN2CM3OcYXrzjFriuL3OsUTtUJs12RqoEQY7QiAX+bG/
         npMA==
X-Forwarded-Encrypted: i=1; AJvYcCUM+gi+72rtaqca0P7aX36CaNZRpHt39z987S7I92sN7nZDPrPkD0ihoDfob+jrWLxkoj9Xc5+LmFo1PXBT@vger.kernel.org, AJvYcCWLUSpIwbMUyXl5k2BCHq6r4jP7GPB6I4ijf+cjpnNdO0dxe/GIQthTyj5LoaWgTSmxGpE=@vger.kernel.org, AJvYcCWtQr07wH719Xo88zntTtPYcUDIi+CLZx2FDmB33NSBQnrWxvnMVy8wrdbuSstu6n78a8THC8sv1/wPctP9qt2SqxQb@vger.kernel.org
X-Gm-Message-State: AOJu0YxfZTEgMhVyxI+9kc/QBjlXEqVusXvi59NmVepDvU9Tbclypb3S
	zPJZSC939vPFGvuZdSmqWi9VRk8thnk3FJbETzwjre83UwbjV539
X-Google-Smtp-Source: AGHT+IEoWKexsNqOPOftKbw+HmSOkJKXWuUWjWlswkz6UpvXXMMqjiX8PF/Hli6OLqpddxKI8HHKLQ==
X-Received: by 2002:a05:600c:1988:b0:42c:bbd5:727b with SMTP id 5b1f17b1804b1-42f5849772dmr174507115e9.25.1727788683031;
        Tue, 01 Oct 2024 06:18:03 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f73d75941sm12555305e9.1.2024.10.01.06.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 06:18:02 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 1 Oct 2024 15:18:00 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv5 bpf-next 05/13] bpf: Allow return values 0 and 1 for
 uprobe/kprobe session
Message-ID: <Zvv2iBQPl5Nt-tqz@krava>
References: <20240929205717.3813648-1-jolsa@kernel.org>
 <20240929205717.3813648-6-jolsa@kernel.org>
 <CAEf4BzbeseQimT6OFjrvC+iWOk81wTQB8Zxf03QkcED58WaKbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbeseQimT6OFjrvC+iWOk81wTQB8Zxf03QkcED58WaKbg@mail.gmail.com>

On Mon, Sep 30, 2024 at 02:36:28PM -0700, Andrii Nakryiko wrote:
> On Sun, Sep 29, 2024 at 1:58 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > The uprobe and kprobe session program can return only 0 or 1,
> > instruct verifier to check for that.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/bpf/verifier.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> 
> Do we need Fixes: tag?

right, for kprobe session, will add

thanks,
jirka

> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 7d9b38ffd220..c4d7b7369259 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -15910,6 +15910,16 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
> >                         return -ENOTSUPP;
> >                 }
> >                 break;
> > +       case BPF_PROG_TYPE_KPROBE:
> > +               switch (env->prog->expected_attach_type) {
> > +               case BPF_TRACE_KPROBE_SESSION:
> > +               case BPF_TRACE_UPROBE_SESSION:
> > +                       range = retval_range(0, 1);
> > +                       break;
> > +               default:
> > +                       return 0;
> > +               }
> > +               break;
> >         case BPF_PROG_TYPE_SK_LOOKUP:
> >                 range = retval_range(SK_DROP, SK_PASS);
> >                 break;
> > --
> > 2.46.1
> >

