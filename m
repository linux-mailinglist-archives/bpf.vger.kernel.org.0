Return-Path: <bpf+bounces-32429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B3390DC7A
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 21:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48891F232B5
	for <lists+bpf@lfdr.de>; Tue, 18 Jun 2024 19:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0F416CD1A;
	Tue, 18 Jun 2024 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPDB+/gN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428D7383A9;
	Tue, 18 Jun 2024 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718739187; cv=none; b=U79nzVLMafvK6jkV8dcI9j+Kvkjk40ruilvS2sTOr7pBq+Xq/2sNcJKl48rtTMr0zUvQAIL1gK/+S2cQI2noxmrMExANn+K0NWVZhCS9Z6VQPk/Nn+3ahDC5vSmqyBpkStq7K8Q3RHaFJfkJ5bqb+TRvNvH7drtpJsEisiYwYV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718739187; c=relaxed/simple;
	bh=VUvBzz2Z/and6J6nSKocBijrwYWOmX2GB4qFVT531Os=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jj2N6OxJZqnX5qfzwZS4DXi/N+1z1z2qmNCnyq/YNJ3F3Iys2KHWRL9bj/mFN+nqtMfuXAOHRTpPvC/UmvLE2wm9DW/eXLjGMZCQysXoep6N+wS07WtCYr017KMv28SdL1WgO/M3O1cN5oxTdFLsS4533mzhzcdLIUl+mIgJND0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPDB+/gN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4217d808034so51357745e9.3;
        Tue, 18 Jun 2024 12:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718739184; x=1719343984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j0vD2l/vVOYVP8iYynlVcBslPNbeS5m0SdBlQ3NqULQ=;
        b=aPDB+/gNyRkkxPmtUsDcRZveYYwxGqlOIKEvbeWXxL15gIke5sE9KQx861VWb0pPNw
         oElKF02853j3eM6SIuzhGoCHEsDL1vjzQIO3cXTHc9ggEMQlk98S8eZ5ShNST3cLY5j8
         uk5csUHL0hJrJQ0cmBy2OWnW4RvaW/hi38XVeAenyKe+USf3WZO5KCzbTJBsob6TxX4T
         GHCB10Veu/WIlK+1SUk28doaKqGkDfqEzWDfN+1sAaa/LI+iY7OWrhG7f3tXLrrcz0Ao
         EpLbSkUSM15toI9uwmAyuNaaSAwuBViWBzRlEv9brMbYbuCmWnykmf8IwCwZIWi77pLY
         HlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718739184; x=1719343984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0vD2l/vVOYVP8iYynlVcBslPNbeS5m0SdBlQ3NqULQ=;
        b=XLYyPe8ayTxEPOxk6B3koS5mr8V6NZhX/HOKwDr/rSD+/kniFiZCqTOEHRBtPqGFJN
         vnBP3qsIUeYDdlg/+D95kFPXHenWvNwOUMBCyr/02BcpxLHAMHw7/u3qFcglnymQJMjK
         /5l8D4X9WoMo7PFqC+IsadhmraN5A8wgoU9XzyA2esgH7xHkrzydXz5rmOgV7cA4f9AA
         i4PRphfxILgPPVAThGWzj1GQGREJB750mPq2YCUfDdire49VL13tAzGxC+rPZrEXXyvW
         0Xeq8RqxM3yFhCiP34wG9ApHzD/C1YVNfjATgZrXH0gX7b7BAq/V4Op5hITXXBcus6pi
         3itQ==
X-Forwarded-Encrypted: i=1; AJvYcCWc2tUY4RO3ZCP7/Nq50+X3pFnXXrzJ9xXaqz0NgiOcSBbDZkTM8ZjEcvWftFimPW/P8L3CafvfSiyxU/PsYW0nDfXaYdCqlP8O2/NKdzcT3S0z1e7T85GmmVpHXZmYKnd7Mk/rEnNh8YxtRO5C2/pOanK2GyUFW/7/QS7Tna6pZu4SPDUO
X-Gm-Message-State: AOJu0YxotIMKozOPpeGZjrzE5X20t5SHVNcs0owKzNEUQIQdZwFcjV8A
	OQHtce/tMsnvwvhh+mdbpiSyJgT/vD+k5L7xwhDDfEtNtclPDE5p
X-Google-Smtp-Source: AGHT+IGsAeY/mnzO/zRTKV6osae1bEuzaMDAaN1d4la7CpgGdB+zgzHfTxCpbW9WEcUmD73YAK5s/A==
X-Received: by 2002:adf:f78f:0:b0:362:fa6c:5a2f with SMTP id ffacd0b85a97d-36317d73646mr352849f8f.35.1718739184466;
        Tue, 18 Jun 2024 12:33:04 -0700 (PDT)
Received: from krava (85-193-35-215.rib.o2.cz. [85.193.35.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36289a4faeasm1489507f8f.95.2024.06.18.12.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 12:33:04 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 18 Jun 2024 21:33:02 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] bpf/selftests: Fix __NR_uretprobe in uprobe_syscall test
Message-ID: <ZnHg7tuVdfOc_5Dq@krava>
References: <20240614101509.764664-1-jolsa@kernel.org>
 <20240616001920.0662473b0c3211e1dbd4b6f5@kernel.org>
 <20240616011911.009492d917999c380320fd1b@kernel.org>
 <Zm9CNlPVfmV_Pc-S@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zm9CNlPVfmV_Pc-S@krava>

On Sun, Jun 16, 2024 at 09:51:18PM +0200, Jiri Olsa wrote:
> On Sun, Jun 16, 2024 at 01:19:11AM +0900, Masami Hiramatsu wrote:
> > On Sun, 16 Jun 2024 00:19:20 +0900
> > Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > 
> > > On Fri, 14 Jun 2024 12:15:09 +0200
> > > Jiri Olsa <jolsa@kernel.org> wrote:
> > > 
> > > > Fixing the __NR_uretprobe number in uprobe_syscall test,
> > > > because it changed due to merge conflict.
> > > > 
> > > 
> > > Ah, it is not enough, since Stephen's change is just a temporary fix on
> > > next tree. OK, Let me update it.
> > 
> > Hm, I thought I need to change all NR_uretprobe, but it makes NR_syscalls
> > list sparse. This may need to be solved on linus tree in merge window,
> > or I should merge (or rebase on) vfs-brauner tree before sending
> > probes/for-next.
> > 
> > Steve, do you have any idea? we talked about conflict on next tree[0].
> > 
> > [0] https://lore.kernel.org/all/20240613114243.2a50059b@canb.auug.org.au/
> 
> hi,
> I have one more fix to send [1] for this, please let me know which tree
> I should based that on

hi,
any news on this?

thanks,
jirka

> 
> thanks,
> jirka
> 
> 
> [1] https://lore.kernel.org/bpf/ZmyZgzqsowkGyqmH@krava/
> 
> > 
> > Thanks,
> > 
> > > 
> > > Thanks,
> > > 
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > > > index c8517c8f5313..bd8c75b620c2 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > > > @@ -216,7 +216,7 @@ static void test_uretprobe_regs_change(void)
> > > >  }
> > > >  
> > > >  #ifndef __NR_uretprobe
> > > > -#define __NR_uretprobe 463
> > > > +#define __NR_uretprobe 467
> > > >  #endif
> > > >  
> > > >  __naked unsigned long uretprobe_syscall_call_1(void)
> > > > -- 
> > > > 2.45.1
> > > > 
> > > 
> > > 
> > > -- 
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>

