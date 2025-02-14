Return-Path: <bpf+bounces-51535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440F9A357E4
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 08:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D56BE16B95B
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 07:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A71420AF77;
	Fri, 14 Feb 2025 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fbh4Hi/N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195A11FFC7A
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739518222; cv=none; b=ug+Ew+hIXJbzRDh3LyNQ/iuc1bsFlwGAk6ni7YR2IcEFbhgumpfeBTkMpDbRXlYgj9SBnsuh2bu4vaNbUbhVPWHxkL9QAjxW4hqD+8bWSSpYswAMh7KyZ/uqljQO0rTvZ38K4jd2QSzVN9nJmAY5FZ2q6YLfkkQCXKImAGMSqpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739518222; c=relaxed/simple;
	bh=pul39928vHfFR3jg4kfCeKwP6f7x+zAnR8o6tv4BBfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+qLLQiFC2gqWiOwSq4q87cxTiKjzVfG4NRyIn4m8P+EDB6zlvNu1Eb0LLqz+0zf+JsuidOyvQIzrS85k/5VcunUsNrtaF56564DxTzPjsuNFtQkRUqliLWgzTIbu9y0hZHY9x9HFAm+4T0mtKAI2VhEiPJvG0TrIlJOyLe0jFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fbh4Hi/N; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c0819d8ebcso77648385a.2
        for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 23:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739518220; x=1740123020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ikH/71niBzEWOD62pHPWy7gRohVEVPo2yfOM5Kcn8YQ=;
        b=Fbh4Hi/Nym/tRkaJVbklKqPS8xvkuXN2RBUhLN2IQMeePvrPYQPKdmT5MCqtSRYlQt
         1IxJrKyjGunzYdmO+Z28NVOETz4MSfPa8FdYDlsFiIZvV/v6vHa0Q9oyJ1r8NQWvsXaZ
         z7X2RH5VdEgRvR1CgPFhPeEbt9wYREpaLd5f32AGXDbQihzcabl0GTevWhW8PiuQtZIX
         qhdYJaS7Dhpghjun64e6L5CQCBDHHJKqsdcfcgZ850tcRpMYFo8j1ORZRGWcRfkNnIPc
         Rze2xvwykfSsHnDY8qcSjPGkCJf/6v35UQpWDH/0aKgAZ+RcjDTMSBXuaSVQ0aHPMkT/
         uYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739518220; x=1740123020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikH/71niBzEWOD62pHPWy7gRohVEVPo2yfOM5Kcn8YQ=;
        b=TvUAvbQbIYWtNbm1Jg3UT61jQ7jiqyuZG2yrQduyk7CjLsfbpsiGrFzlPZA1mxfWwr
         P36wAWbghn8RqraTBgnf0aMsL/5GF6yg7A95P+FRRhrg6wa0SAfp4Iv7zWF6VsCjLfv2
         viNnvDdliwcc6wg2oQ8+EBvB9FotSyyuzdo8hOjRxo8lohO/NdMmlydAr9ZRI2/nGyu8
         ZUFkyRZGQCuHbE/CV3Jul/sqWaFxPASjrA3qsy16XjF1/N7NtqBF2GFJp45hu5caNU1L
         oelqMYwSZ69ajh0407X2/bpQ4osOclFWlIvzjQPbr09d/Ebo75Q7rV/lAohG2/0CvXaW
         Zu4A==
X-Forwarded-Encrypted: i=1; AJvYcCWd22S3KsLav5OL/O1O8RyJJREmZX2U6LAM+gZg6M4QRnn5Y5xvDDAAZ/wSiHT5bzJHVWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycZ1w9HWHov8AnfnEUIRAvwX5mBwymzNDgF9R3UO17b259BVLq
	XoWO24A5T4QMmWwLzPHT7KH3SHIf89YEdxwv0CKb0PB3NtC2R+Xr9iVV7dyyUK5XNVLsK/e0HfU
	pyqziauB7Upr06ZKUS3Bz83TwKEg=
X-Gm-Gg: ASbGncssKjkIGg6baLkgoquWGhM4OCqJ7ekcLKlIIi3Ls7MPTejfXp4BVw946/JJLO8
	T2hup1A0JFDakVREArKW6/QU9KWwNUNCP+0HuDB0ojeRRZOiT/u0QBcAeCV7d/ZxZb9h6BLH5rs
	8=
X-Google-Smtp-Source: AGHT+IG89GBUNlekxbTSBy2hNv8x8Vj3CFa+zfgmdf+YxhawT1wDVtWheDO+AjPwb5K3zRy6WRdjl5YCku3lcNcAWLY=
X-Received: by 2002:a05:620a:4809:b0:7c0:7922:367c with SMTP id
 af79cd13be357-7c079223855mr983141085a.29.1739518219823; Thu, 13 Feb 2025
 23:30:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211023359.1570-1-laoar.shao@gmail.com> <20250211023359.1570-2-laoar.shao@gmail.com>
 <50d8dd8af3822f63f1a13230e6fa77998f0b713d.camel@gmail.com> <20250211161122.ncnrwinacslvyn6k@jpoimboe>
In-Reply-To: <20250211161122.ncnrwinacslvyn6k@jpoimboe>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 14 Feb 2025 15:29:43 +0800
X-Gm-Features: AWEUYZmiQDBDx5ijM5HQjbJ8zAeQhrewaBD7eYSKahWhwd7mKfj7Lw4tXMNSOI0
Message-ID: <CALOAHbCkpSrCTmEBzS141f+B4Ux3+vEa5u1DgBsDsXUwy9bogQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] objtool: Move noreturns.h to a common location
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, peterz@infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 12:11=E2=80=AFAM Josh Poimboeuf <jpoimboe@kernel.or=
g> wrote:
>
> On Mon, Feb 10, 2025 at 08:12:32PM -0800, Eduard Zingerman wrote:
> > I'm probably out of context for this discussion, sorry if I'm raising
> > points already discussed.
> >
> > The DW_AT_noreturn attribute is defined for DWARF. A simple script
> > like [1] could be used to find all functions with this attribute known
> > to DWARF. Using this script I see several functions present in my
> > kernel but not present in the NORETURN list from this patch:
> > - abort
> > - devtmpfs_work_loop
> > - play_dead
> > - rcu_gp_kthread
> > - rcu_tasks_kthread
> >
> > All these are marked as FUNC symbols when doing 'readelf --symbols vmli=
nux'.
> >
> > 'pahole' could be modified to look for DW_AT_noreturn attributes and
> > add this information in BTF. E.g. by adding special btf_decl_tag to
> > corresponding FUNC definitions. This won't work if kernel is compiled
> > w/o BTF, of-course.
> >
> > [1] https://gist.github.com/eddyz87/d8513a731dfe7e2be52b346aef1de353
>
> I also suggested this, I agree this is a much better way to go.
> noreturns.h is manually maintained based on objtool warnings and
> I'm not surprised it has missing entries.
>
> Alexei mentioned 30k+ noreturns, but when I eliminate dups and
> __compiletime_assert_* it's a much smaller list:
>
> $ ./noreturn_printer vmlinux |sort |uniq |grep -v compiletime_assert
> arch_cpu_idle_dead               external idle.c
> arch_cpu_idle_dead               external process.c
> cpu_startup_entry                external cpu.h
> cpu_startup_entry                external idle.c
> do_exit                          external exit.c
> do_exit                          external kernel.h
> do_group_exit                    external exit.c
> do_group_exit                    external task.h
> do_task_dead                     external core.c
> do_task_dead                     external task.h
> doublefault_shim                 external doublefault_32.c
> ex_handler_msr_mce               external core.c
> ex_handler_msr_mce               external extable.h
> __fortify_panic                  external fortify-string.h
> __fortify_panic                  external string_helpers.c
> i386_start_kernel                external head32.c
> __ia32_sys_exit                  external syscalls_32.h
> __ia32_sys_exit_group            external syscalls_32.h
> kthread_complete_and_exit        external kthread.c
> kthread_exit                     external kthread.c
> kthread_exit                     external kthread.h
> machine_real_restart             external reboot.c
> make_task_dead                   external exit.c
> __module_put_and_kthread_exit    external main.c
> __module_put_and_kthread_exit    external module.h
> nmi_panic_self_stop              external panic.c
> panic                            external panic.c
> panic                            external panic.h
> panic_smp_self_stop              external panic.c
> play_dead                                 process.c
> rcu_gp_kthread                            tree.c
> rcu_tasks_kthread                         tasks.h
> rest_init                                 main.c
> rewind_stack_and_make_dead       external dumpstack.c
> start_kernel                     external main.c
> start_kernel                     external start_kernel.h
> stop_this_cpu                    external process.c
> stop_this_cpu                    external processor.h
>
> Also, for objtool we could use something based on your program to
> autogenerate noreturns.h.

Automatically generating noreturns.h is a great idea, as it would make
the file accessible for use by others as well.

> Only problem is, objtool doesn't currently
> have a dependency on CONFIG_DEBUG_INFO.

Is there any reason we can't make it dependent on CONFIG_DEBUG_INFO?"

>  Another option we've considered
> is compiler annotations (or compiler plugins).

--=20
Regards
Yafang

