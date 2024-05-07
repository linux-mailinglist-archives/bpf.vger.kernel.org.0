Return-Path: <bpf+bounces-28769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757F58BDCA8
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 09:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B844285B13
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 07:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E09913C809;
	Tue,  7 May 2024 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6yLdX/O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC813C3E2;
	Tue,  7 May 2024 07:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715068027; cv=none; b=eClr/XTeKsN+2a1cItAq3oLDO2kLP/hxUgjmR6tZzBQ5NXWcnfRQ8Yq5N5hw9Nit1m6lUJ46y54uwCCFkJXBoXxlsQvR2NgL5dRY0cvyKuFPKUPc+LXve+EzyA28NTz0FP/HqXEyNWxUH6+ieQivky6DOMX3zJdT38LD/0nTHso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715068027; c=relaxed/simple;
	bh=yf4Yg/+Zl+Y89cEZ893/e5GdcQqcjBTYy7kKVYel4w4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shqJJTF5Bo6YWQfd5pZAX10weFsjh38AHaBznaAqetpcljhzhXeRK9KN+Jxl2uJxPhGzVcqCgnPu9SFc0SJBmq8iJJFhCkXrm3V779gSniW3wztWiQgPv8ve5mllVaI4JHdAwoW1qtHsOmDgigHvdJ7yWie/lQ1yc+BeCHcm5fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6yLdX/O; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41b79451128so18982705e9.0;
        Tue, 07 May 2024 00:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715068024; x=1715672824; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7W8Lgnc2QmcYuA3PD75NwVh4l9qkIidlX6ZKt/45er0=;
        b=Y6yLdX/Ozo/hVRqaKh/PCZRZcGCetgUSnoJzo8zsSBACd0DgjeOv1g0jqkXFHzR1ZN
         RGoRaluxoVDznDc2kJls718pQ/G7wE/3qtKlFsSwNm+MWIf113MSyWrZ1TuzPYmrMk6V
         RQyZdMJVWp7zAInSB9bmWBFN1zSOICKhaGQ6Vxa4JdbR0OXqqw2LNxrvfBBoAxT1ds+1
         IE16cZdJGdJBzzWaD0r0m19UhuI4ivpKlyX7441QhgsMAYl3l3ldfhIdibh/YWkPmnWZ
         JUbr8e3ZNRfpnRACL/NYwyoZPMtcpsXzbZtByG8wgP6nkelZaL3IlGph7m0plXMQegS2
         Xg3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715068024; x=1715672824;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7W8Lgnc2QmcYuA3PD75NwVh4l9qkIidlX6ZKt/45er0=;
        b=kbgEnkYdRoCKT2M0C6XUFH+jflhtz3+H/ExeFAI67yw/hjFkVtjMC+GBeqXAjAh/xx
         I73zdh9Jq8yg8gKE8qHVlDT3GVywNyvd7WtdKIdPln15WAveqYXBl2KH9GvplKIEh9kW
         jhGAcyDmrKCLs/2MH3cdMyLYCrbYsPKGJ+ViLX9g+esgNzwaRChQSPOmZ/MLn8LRbzZ6
         e1nH/ne1spAKZTYOMjhVDIcIRLYmrmLc2motmH3eFuY2dztgm9tyKuRQBmctsq/+WSh6
         Vko/x+XvexDiJV1lLveoNHW5qju33l7bV3JTWImzPguwzoUi0qUWQe3lpEXGIgz7tl6h
         K++Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkDZu4wHlzSQq5ihGA9HqMgqCX8KvQWkqs20+q6GF36YcRvIG8TCJn6/CJ6HX7K7zxdB9Oj6XhuQa+v7j7N3ARW7icN33BKRGy/bz1TlnXxfX2e5hoFGGWc0OdED9gVQ/xC48qgRFCZVcNrzShfT+mFLeBL5cztaYMKJFkDhXVTA7P4UiA3PMfTV5PVQWzja/YajnupEBqKryWqgKE5eFXUFYUiB+sJlim8AalE1krg1M8tDBFSoql7ZLt
X-Gm-Message-State: AOJu0YyOOApIaISHBr3cvka2BuRa+4jqdBUIElO8UgIsw549Rh9Q+XSQ
	oFWaqBpHN6JYGiUdj2ybKQ1bKceNQuHS+z/UMM5XFz8z/F4Yeqqu
X-Google-Smtp-Source: AGHT+IGsz8f0uMjryXajrRZUilHY9JjH8CEEtXxBaBPMnzG03cteHqU06c9qmaP7T8e5hgNlLiPcnw==
X-Received: by 2002:a05:600c:3c93:b0:419:f2a0:138e with SMTP id bg19-20020a05600c3c9300b00419f2a0138emr9382664wmb.34.1715068023534;
        Tue, 07 May 2024 00:47:03 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id g7-20020a05600c4ec700b0041902ebc87esm18626956wmq.35.2024.05.07.00.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 00:47:03 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 7 May 2024 09:47:00 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCHv4 bpf-next 0/7] uprobe: uretprobe speed up
Message-ID: <ZjncdFBtsZnABvva@krava>
References: <20240502122313.1579719-1-jolsa@kernel.org>
 <CAEf4BzYxsRMx9M_AiLavTHFpndSmZqOM8QcYhDTbBviSpv1r+A@mail.gmail.com>
 <ZjPx0fncg-8brFBk@krava>
 <CAEf4Bzb-dM+464JvW96KuxwOTfRQA1pxZRWM+pA7AfSWtWwqZw@mail.gmail.com>
 <ZjVLedyQFBoHh-T_@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZjVLedyQFBoHh-T_@krava>

On Fri, May 03, 2024 at 10:39:21PM +0200, Jiri Olsa wrote:
> On Fri, May 03, 2024 at 11:03:24AM -0700, Andrii Nakryiko wrote:
> > On Thu, May 2, 2024 at 1:04 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Thu, May 02, 2024 at 09:43:02AM -0700, Andrii Nakryiko wrote:
> > > > On Thu, May 2, 2024 at 5:23 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > > >
> > > > > hi,
> > > > > as part of the effort on speeding up the uprobes [0] coming with
> > > > > return uprobe optimization by using syscall instead of the trap
> > > > > on the uretprobe trampoline.
> > > > >
> > > > > The speed up depends on instruction type that uprobe is installed
> > > > > and depends on specific HW type, please check patch 1 for details.
> > > > >
> > > > > Patches 1-6 are based on bpf-next/master, but path 1 and 2 are
> > > > > apply-able on linux-trace.git tree probes/for-next branch.
> > > > > Patch 7 is based on man-pages master.
> > > > >
> > > > > v4 changes:
> > > > >   - added acks [Oleg,Andrii,Masami]
> > > > >   - reworded the man page and adding more info to NOTE section [Masami]
> > > > >   - rewrote bpf tests not to use trace_pipe [Andrii]
> > > > >   - cc-ed linux-man list
> > > > >
> > > > > Also available at:
> > > > >   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> > > > >   uretprobe_syscall
> > > > >
> > > >
> > > > It looks great to me, thanks! Unfortunately BPF CI build is broken,
> > > > probably due to some of the Makefile additions, please investigate and
> > > > fix (or we'll need to fix something on BPF CI side), but it looks like
> > > > you'll need another revision, unfortunately.
> > > >
> > > > pw-bot: cr
> > > >
> > > >   [0] https://github.com/kernel-patches/bpf/actions/runs/8923849088/job/24509002194
> > >
> > > yes, I think it's missing the 32-bit libc for uprobe_compat binary,
> > > probably it needs to be added to github.com:libbpf/ci.git setup-build-env/action.yml ?
> > > hm but I'm not sure how to test it, need to check
> > 
> > You can create a custom PR directly against Github repo
> > (kernel-patches/bpf) and BPF CI will run all the tests on your custom
> > code. This way you can iterate without spamming the mailing list.
> 
> I'm running CI tests like that, but I think I need to change the action
> which is in other repo (github.com:libbpf/ci.git)
> 
> > 
> > But I'm just wondering if it's worth complicating setup just for
> > testing this x32 compat mode. So maybe just dropping one of those
> > patches would be better?
> 
> well, we had compat process crashing on uretprobe because of this change,
> so I rather keep the test.. or it can go in later on when the CI stuff is
> figured out.. I got busy with the shadow stack issue today, will check on
> the CI PR next week

ok, it's not as easy as just adding the package.. I don't want to delay
this on my missing github skills, I'll skip the test in next version and
submit it separately when the github ci is ready for that

jirka

