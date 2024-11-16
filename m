Return-Path: <bpf+bounces-45002-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D09E9CFBC0
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 01:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7C8C28370C
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 00:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D705C96;
	Sat, 16 Nov 2024 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b="O+1d46gY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6654B4A31
	for <bpf@vger.kernel.org>; Sat, 16 Nov 2024 00:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731717376; cv=none; b=jhoEgagpDCcB58teTfwI6AXPhgGLQRzxx12yRwrviBVcE+u1W8aZxR1ebd7E510ZbuCeMq1NKbitDUSo+HdG32r38N+YL25cBxPC4CRLJG57PsOd6Rv7zd9l4QiK78dQ3pvlhW58bGqC3+exiLoOuHLC+GFzJ1SEk579FBHbFZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731717376; c=relaxed/simple;
	bh=RQdd57iRz0CvjpF9ML9OvvqQd3DNHBVZL9GzAnBolBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rag5syJIjX8H+zsMx4797AnRK4QmGXl7uTOAV/WVRV5QerZ2Pjw3y4AFKYJ+RwQvSN8klGCAtel5hOnQLlQm4k0nsem3IDCtltkFZ5H+lp/c3Ojb5RFn0ub9Z3U0xQl0tJWGi1sanHnqF1TG4/p/Yb6UKuAPuE+9INAdqYwFcOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai; spf=none smtp.mailfrom=furiosa.ai; dkim=pass (2048-bit key) header.d=furiosa-ai.20230601.gappssmtp.com header.i=@furiosa-ai.20230601.gappssmtp.com header.b=O+1d46gY; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=furiosa.ai
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=furiosa.ai
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7246c8b89b4so1672109b3a.1
        for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 16:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=furiosa-ai.20230601.gappssmtp.com; s=20230601; t=1731717374; x=1732322174; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+uE+atgt1vtE/elxwOSmphd/thEwXR+0AG9SDju+aII=;
        b=O+1d46gYHeu5FwlW5p7XzHy1DAJScJiPEhbHheiQV5oInOpI7iXJE3nGX5vzUZyRTC
         7iDLbl3AQCxv4GUPlEWfwBhQ5CW3FqhgY3FvCn1XwxSJA/FcR0USvUOia8hXOKhKJJHc
         A2yF5qs8dbp2XiUpC70BtMyosxcypLvLa1mgZhN2VRK2Tgvs9WNX8OV2fw8aw/Ex4LUL
         zFh+fuCZL9CRRSI36uh2eexDv/HjVaaR27Dq9YfP4KEMiKw8XpC80YdTwVPEoJPQ3rER
         rl27hidpRJ3ZFfurl+vZkoBkaSP7WJcQz5a3Tll9l5K9PlKPKFG01vRqdq+t1qn3wNkD
         bnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731717374; x=1732322174;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+uE+atgt1vtE/elxwOSmphd/thEwXR+0AG9SDju+aII=;
        b=B8CIIVZDPScAftfhxQDoZKqvNnJZYsnVStodwhFcjZRG0jelaIP43xQ8UQL4wOliB2
         nLiyH17LtdscghC3IkHiBf9ahSCfyP5AODJraJxNEpxlMT3huHbDx8i0ZWyqdeYY6+gp
         VFQKn+45aop/1pBuc6D+u7p6/4pJ032xwCyu3yrbpIt+E4M5WuI4+6HjO08/qCRlcpfj
         L8UL0bocYZo9dXyzoI3PN1WH/aglbFV+yA2BXg/XneOgvI8ABvgj+jobQC5HoJG58w0h
         aX8dkYnuUzsN0Bra9cRj8KvxCkrGcY7hUAnNWe3L2Z5Io0cMnoJisJgfHyXv2Z4l/kdR
         c3CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOUyQ6gbGG8ITurvcPN7YMhzFnmNr0gI7hFXFyCIlzscWJ8zbrqG+mEC5L1iQAeEYZfJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJkHj9UWVDqPM4qoDyPsV6SuL9yvA+PzvziItFdTZWHqn2TARY
	AQBlgRrbCqqyORtXakAz/30qGxzped5y7SCmwabuvwGtEUMZkWELTcccQ0bzXyo=
X-Google-Smtp-Source: AGHT+IEzJq3ZF1gSX7zEro8gp0KD50msaVqg1twIRbOyUMP0aQtrXRhqwDTD93IqhR0/2bDNyM+aew==
X-Received: by 2002:a17:90b:17d1:b0:2da:88b3:cff8 with SMTP id 98e67ed59e1d1-2ea14e1c1a1mr7261531a91.6.1731717373687;
        Fri, 15 Nov 2024 16:36:13 -0800 (PST)
Received: from sidongui-MacBookPro.local ([61.83.209.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea06f9c64esm3478725a91.42.2024.11.15.16.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 16:36:11 -0800 (PST)
Date: Sat, 16 Nov 2024 09:36:01 +0900
From: Sidong Yang <sidong.yang@furiosa.ai>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] libbpf: Change hash_combine parameters from long to
 __u32
Message-ID: <Zzfo8YCeNkbCQDTg@sidongui-MacBookPro.local>
References: <20241115103422.55040-1-sidong.yang@furiosa.ai>
 <CAEf4BzYape9gtc7k1NQMD5BrfakzDXV_9SHNqZeamcaSKn744Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYape9gtc7k1NQMD5BrfakzDXV_9SHNqZeamcaSKn744Q@mail.gmail.com>

On Fri, Nov 15, 2024 at 11:57:24AM -0800, Andrii Nakryiko wrote:
> On Fri, Nov 15, 2024 at 2:51 AM Sidong Yang <sidong.yang@furiosa.ai> wrote:
> >
> > The hash_combine() could be trapped when compiled with sanitizer like "zig cc".
> > This patch changes parameters to __u32 to fix it.
> 
> Can you please elaborate? What exactly are you fixing? "Undefined"
> signed integer overflow? I can consider changing long to unsigned
> long, but I don't think we should downgrade from long all the way to
> 32-bit u32. I'd rather keep all those 64 bits for hash.

Hi, Andrii.

Actually I'm using libbpf-rs with maturin build that makes python package for
rust. It seems that it uses zig cc for cross compilation. It compiles libbpf
like this command.

CC="zig cc" make CFLAGS="-fsanitize-trap"

And hash_combine's result is like below.

0000000000063860 <hash_combine>:
   63860:       55                      push   %rbp
   63861:       48 89 e5                mov    %rsp,%rbp
   63864:       48 89 7d f8             mov    %rdi,-0x8(%rbp)
   63868:       48 89 75 f0             mov    %rsi,-0x10(%rbp)
   6386c:       b8 1f 00 00 00          mov    $0x1f,%eax
   63871:       48 0f af 45 f8          imul   -0x8(%rbp),%rax
   63876:       48 89 45 e8             mov    %rax,-0x18(%rbp)
   6387a:       0f 90 c0                seto   %al
   6387d:       34 ff                   xor    $0xff,%al
   6387f:       a8 01                   test   $0x1,%al
   63881:       0f 85 05 00 00 00       jne    6388c <hash_combine+0x2c>
-> 63887:       67 0f b9 40 0c          ud1    0xc(%eax),%eax
   6388c:       48 8b 45 e8             mov    -0x18(%rbp),%rax
   63890:       48 03 45 f0             add    -0x10(%rbp),%rax
   63894:       48 89 45 e0             mov    %rax,-0x20(%rbp)
   63898:       0f 90 c0                seto   %al
   6389b:       34 ff                   xor    $0xff,%al
   6389d:       a8 01                   test   $0x1,%al
   6389f:       0f 85 04 00 00 00       jne    638a9 <hash_combine+0x49>
   638a5:       67 0f b9 00             ud1    (%eax),%eax
   638a9:       48 8b 45 e0             mov    -0x20(%rbp),%rax
   638ad:       5d                      pop    %rbp
   638ae:       c3                      ret   
   638af:       90                      nop

When I'm using libbpf-rs, it receives SIGILL for ud1 instruction.
It seems more appropriate to use u64 instead of u32, doesn't it?
I'll work on it.

Thanks,
Sidong
> 
> pw-bot: cr
> 
> >
> > Signed-off-by: Sidong Yang <sidong.yang@furiosa.ai>
> > ---
> >  tools/lib/bpf/btf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 8befb8103e32..11ccb5aa4958 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -3548,7 +3548,7 @@ struct btf_dedup {
> >         struct strset *strs_set;
> >  };
> >
> > -static long hash_combine(long h, long value)
> > +static __u32 hash_combine(__u32 h, __u32 value)
> >  {
> >         return h * 31 + value;
> >  }
> > --
> > 2.42.0
> >
> >

