Return-Path: <bpf+bounces-58387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A77AB96CB
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 09:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B61501A41
	for <lists+bpf@lfdr.de>; Fri, 16 May 2025 07:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EA322A7FC;
	Fri, 16 May 2025 07:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fByWf7El"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD251229B23;
	Fri, 16 May 2025 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747381700; cv=none; b=s16ynJJxB88VK9uZTz8r4pLDdPA5jzK/j7bzgjG1xTgp4ObccMRTQpzlRhvLHSPn6R69a7AH1aM7QANBI1j9xC6WaDjKOVB+/5O+IuNEMqjuvphjz5yyFmfT7zuRsdYYJKVoUTVH6yGdp44ypphSI6Juhc9RPLJ7y4S+dR6zyqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747381700; c=relaxed/simple;
	bh=aHU9BkOiWPz0W7SgeBJtFfgnX1JrevC7v3V7mSP2xu0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSI8g/zcmyxZe8k1qMV6B4BhvL14Trl9JCLWNdFWjLSR+vzCwXeWbWfjyfRX+0BMPEF7YhLkFNOAAJGLrrXWUvFLIWbi3YqvhWQT6iWSkjkQx4o+o/G88c8rbd0GS6eh7d3rVHEMsc9mlhnDYUjkH6oNvdyZVQ7eJIgfj0Ivvv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fByWf7El; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfe574976so11930845e9.1;
        Fri, 16 May 2025 00:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747381696; x=1747986496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iea2KBGhuX+X3B5IwokVwAMngxE9zC3wkNecLtzJuIY=;
        b=fByWf7ElJXPDwfYizACbB6oedfDfYEiEgjF87XIT8WE8BzJEFKyW1RIFSqozLuHNYx
         HlRMq7+1MP2js/3Ed/ORK/JCrqCe2y2K379zlVIdupVWWyVQWeZ9Hk7zbhc6N371f6Fl
         QBZhIWEKr+Y6Zld1BT2bFeeX9tIa/xX26KvKYuJuxzrwCtIs8E8W1Ar2jKost99+R9D0
         Omimk3ocGL2KkVLbzvAOek0wV+4yLSLIfm5Q5Q2kkd88/o/SbhQPKB4a8s8OO4MrHIFm
         A1PuZNIJCSAc0vJqi0pK8uxvGW1aPBp8gronGH0HjuveCnVvEI4t7VxvuWxadGGsL9wQ
         tALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747381696; x=1747986496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iea2KBGhuX+X3B5IwokVwAMngxE9zC3wkNecLtzJuIY=;
        b=ascFcWK0ZrVTYaEHfHmsxZmXFe95eorcE2IKgOWQPt8Qrp4u5kxn1BguISYMrm/GJL
         oCqbSv8tUS7OKsFHPhJXZJRIU3BAWUDJJAmwf4KKzwv8RY9+TeMtOUIpL0wtMxMljnWn
         j6hYatqXDp76OBODuDXoKpdpzWAQ12btKGZHyPhPm6uVxNI4iBcXGD+3L76itTTG2gEI
         WEB9mSqdw2avJ5AvVFQ+XpH4xeG8MH+JObq8e1t0uJbEZDTtdyt7rNkK1Bs4tbxqEZ4h
         6r7jAVzRetxJKWpF7PgctejvCwnylfm2WPjHN3ZFmJZv4eKn49DwwN7i7+gCbnQoDKBP
         4f9g==
X-Forwarded-Encrypted: i=1; AJvYcCVlq7M+2RddexYQcfddfMUGbbAQyRp0YZM6BwDPPfLaXHLNpip7s8vON7N+E6RQBOaP8lA=@vger.kernel.org, AJvYcCWjDQuNgXnXuL6lannjw41ZvApOjYzPfO8hn/E8TcjsBMS4HZdvSpWdv4Ah07omX98KgoszrM33pODXvsb1frErux40@vger.kernel.org, AJvYcCXoTJoCObZ1IZ1TgHiRSawwekjLSmyODz4xVeVH2+NmaloFP4lJNE4rDOUoJYj68jANj0Bc8g+75VWujCNU@vger.kernel.org
X-Gm-Message-State: AOJu0YzMTdiAZI0jyCRg0a7hIs62AvtexmybaPZX+8CLMHGErR0OBSqq
	A/2XP/jZ7WlIsWWExpPKq2cQ6mMnHJFUdTr2t0FQEZKOdOs4CYck3X1L
X-Gm-Gg: ASbGnctkRz/MU8DK9m4aDIz0m0jmQ10tMYVhPumg2Dip68GdJvgOlJOx68vfnRTMAy8
	ecOOfgFr86aPSv3bNcCu6QCqwo7ATnHUcnYEoFwhqhLQKGFGg8R/K4pco6myIgXIbNqMAagM9+s
	fikweuShSAO6n8ZfQvfGMBQ6UIa65CTbBXBeWAOKzWe3Qa5OHXgsyKMRiRvBTtEMlR934k/qNEl
	uRqXL6eXA4vj2EhFmk6lnDRW+aAja9WAY2PpFseQh5KN4lGFrvY9Xo6OW3apbmANNuGqlPdW4pL
	FuVmXEAxRfy22Hm+QgzrS9eIGjy86jq7zKiUS8ro+l+n
X-Google-Smtp-Source: AGHT+IGQ+NOoE9SmiilWjuHQSHVFmRvd6nruvsoD0CaRSvyKLFALVWv9yv4FTaMJyFRhS43gFw4FBA==
X-Received: by 2002:a05:600c:35c8:b0:441:d43d:4f68 with SMTP id 5b1f17b1804b1-442fd63c6b7mr25677055e9.15.1747381695662;
        Fri, 16 May 2025 00:48:15 -0700 (PDT)
Received: from krava ([2a00:102a:401a:bc81:9db7:192e:9f02:9c0c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd50b9b2sm24420585e9.12.2025.05.16.00.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 00:48:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 16 May 2025 09:48:11 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv2 perf/core 13/22] selftests/bpf: Rename
 uprobe_syscall_executed prog to test_uretprobe_multi
Message-ID: <aCbtu2LQxHo6pgVH@krava>
References: <20250515121121.2332905-1-jolsa@kernel.org>
 <20250515121121.2332905-14-jolsa@kernel.org>
 <CAEf4BzZ4975boVLbDXhVkjbiY_gp=RTTzJZ9zhfXc0zrgs4obw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ4975boVLbDXhVkjbiY_gp=RTTzJZ9zhfXc0zrgs4obw@mail.gmail.com>

On Thu, May 15, 2025 at 10:24:42AM -0700, Andrii Nakryiko wrote:

SNIP

> > diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
> > index 0d7f1a7db2e2..c4c3447378ba 100644
> > --- a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
> > +++ b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
> > @@ -8,10 +8,17 @@ struct pt_regs regs;
> >  char _license[] SEC("license") = "GPL";
> >
> >  int executed = 0;
> > +int pid;
> >
> > -SEC("uretprobe.multi")
> > -int test(struct pt_regs *regs)
> > +static int inc_executed(void)
> >  {
> > -       executed = 1;
> > +       if (bpf_get_current_pid_tgid() >> 32 == pid)
> > +               executed++;
> 
> it's customary (and makes sense to me) with filtering like this to not
> add nestedness:
> 
> 
> if (bpf_get_current_pid_tgid() >> 32 != pid)
>     return 0;
> 
> executed += 1;
> return 0;

ok, will change

jirka

> 
> >         return 0;
> >  }
> > +
> > +SEC("uretprobe.multi")
> > +int test_uretprobe_multi(struct pt_regs *ctx)
> > +{
> > +       return inc_executed();
> > +}
> > --
> > 2.49.0
> >

