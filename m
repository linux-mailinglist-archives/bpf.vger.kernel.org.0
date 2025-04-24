Return-Path: <bpf+bounces-56594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC08EA9ADE9
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 14:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6BC4670BD
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 12:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B3E27C869;
	Thu, 24 Apr 2025 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDqQZMw0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FBD27C178;
	Thu, 24 Apr 2025 12:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498977; cv=none; b=j+Xm0sbi3FTe57uAZ0DC0UtxvNUa7m427to2rQ+qGZsDx0mIl9kE8YvLtWLyHUIH5m3Ne4QCg5ykCqeoGKyeWnRu+y6axgC6y3n2CIb07LkYRIB/l7qNiVtDqc3EmeZXhmDEsD7KO9ZUheXRMy0LSHgrttLMUU2CoRPnMNa0mtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498977; c=relaxed/simple;
	bh=ARVO6wi0rJHAK85dPXs6pHXmFUFswuNoQSAAriQmLMY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKq5DuLxpTOrG57DWaw24ydch8MJeV6c+urJB5lVMizqAdoFcNXP2JD/L4yi9Wrlj4x0sU11ewny7awSm0/8aSnHoI9yvDXkcusbZxiZyb42PMuRxfgZcScJvceKxBW2YaDnpdmat+x1gQ8QFR6ODqq7CUfaBg2qi7SmHW9+NoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDqQZMw0; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac345bd8e13so148012466b.0;
        Thu, 24 Apr 2025 05:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745498974; x=1746103774; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hhanhASE/YzT68T6Z7r9A1GJR6VWNb/hW+1VEv10VBk=;
        b=NDqQZMw0TingtmKAKArC73mUb0Ni/CJyP2aRyvXvL3qg8V0A4zj53pWfGCfZ2gStFB
         TrRdRXQ2XOcIQ7NfLgrYYO+49LJDmUJl0cPiCcxjpJl2R06QD4toNGf3K8aHWW8atbbw
         TWuaUu/oV8W93qB3txq1kAptDk79IxDPiQSRvjbGXCIwe3DI1SsSEsLa1G/ZpIzpSQxr
         cZ78G9Td8qveULK2lIBQ4jbJjNPNc+Gdf8z425SXAjqgHQycRSZbjfB0LIrUH8+FGBJo
         GFFvRkzc2e++RdAddWcaRlwq/VEDoOVDndh23udJLGEkFahdCvcgBj4BSg8xlX/IhPV9
         wuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745498974; x=1746103774;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hhanhASE/YzT68T6Z7r9A1GJR6VWNb/hW+1VEv10VBk=;
        b=MK+DgBQTP6iqb0lQf2IK2HT6ZZjolXXMzckzF1aoyil8Mp3WJgE231mc29yDOdmT5E
         lfI55HtQzcEtS/Mg3p6sKcF9i+a1aAS1MB993AGSN8B1/gQMzjZ9fRHDHqgUkMbyNAKe
         XUdxmMxKXpS26FrMMQ5Klefqh/HF1GDaHHC1dhaTY0B7Eg2GZogtUVkqQYoeSGAxuWx0
         ZbGpxV97IioY+5KHKNg4ZqrFZQRUTdJ1Vus+EsruRnq5iHyuSocVY+cY6kFb2Wfj7jkY
         vY3Bf4tDqbv5XJ6J+U1J9vPhGrtHGdsy6WkPaZ5JqpGvTXMkvb7BGoppqei8o9pVj9c4
         3BUA==
X-Forwarded-Encrypted: i=1; AJvYcCUvMLiZh4GPqdSJGeLkX4KmYZcQs5J05RJg+cqC69j+2pNkWSN0VPrmylqUGiTXnXLLRmU=@vger.kernel.org, AJvYcCV/5/xGsBXkYcClAWgfJMXBxjKBSwneWx/jqCXNxZ/2dH2wtqntANoDH/PZo0tnfpX8j3iEZ9rxtnSo3C52@vger.kernel.org, AJvYcCXNqwzJPH4d/mqAeseiyPaUqlhb0su8Dhxv/hJKdctKNmEyNMWmFjCHmadzzqBNMgyQPFKA8eR2D1OLGTDg9EGkTqwA@vger.kernel.org
X-Gm-Message-State: AOJu0YxLfU/FRaFy4/mgy8KdhpgB9ge07WVHojVkNexTp5fvsSjnPaRM
	YmJbsNwgT0LMstsgaVLv/GrYo5dUZMHytpVDznyMPAbf5fMtn+PDHLmxlbfy
X-Gm-Gg: ASbGnctoO/i0mbzW1kdvOh0DKOhopXvFfu7zN6Ps5+s4jF2MttF9Ax8sYaNPzZm7ZIv
	rWVYHAGywR45ZvL40uRkdy51z9r0dSqg+SKA408ttESFtr436HjDxIiZfzGodW4R/znek6m8uSY
	QVaaLyb6n3zZFgYHcEmhhbDoWJ2APP4DPUz5QKegLP7/EJEjJoVAeLH7tQRb9pfWgsnHSkP1PDN
	+V+3z3J3C51fSKa9ROaZ4LfhsXMamOATI2LF651Pcs7KRBrmJDmGYAhpsMiHi1lG23MgFALYsrC
	8szcN5Yrzm60JeMch2I/49ETg7iJppZmy3U9Sg==
X-Google-Smtp-Source: AGHT+IErSZdlWG7fDQwXp8ywmMuv6lppaihtTnJ7v0E8AtMrMLKxCub1upgDag7NHTZ8D7sVNZf3dQ==
X-Received: by 2002:a17:906:4fcd:b0:aca:a347:c050 with SMTP id a640c23a62f3a-ace56df7545mr247774466b.0.1745498973887;
        Thu, 24 Apr 2025 05:49:33 -0700 (PDT)
Received: from krava ([173.38.220.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace59830f51sm103273466b.5.2025.04.24.05.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:49:33 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 24 Apr 2025 14:49:31 +0200
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
Subject: Re: [PATCH perf/core 13/22] selftests/bpf: Rename
 uprobe_syscall_executed prog to test_uretprobe_multi
Message-ID: <aAozW6C9IZULY3CL@krava>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-14-jolsa@kernel.org>
 <CAEf4BzaseiF10Ady4FCCx=ii+es9vkcbRYLBkdaDRZ_tH8NzdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaseiF10Ady4FCCx=ii+es9vkcbRYLBkdaDRZ_tH8NzdQ@mail.gmail.com>

On Wed, Apr 23, 2025 at 10:36:22AM -0700, Andrii Nakryiko wrote:
> On Mon, Apr 21, 2025 at 2:47 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Renaming uprobe_syscall_executed prog to test_uretprobe_multi
> > to fit properly in the following changes that add more programs.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c   | 8 ++++----
> >  .../testing/selftests/bpf/progs/uprobe_syscall_executed.c | 4 ++--
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > index 2b00f16406c8..3c74a079e6d9 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > @@ -277,10 +277,10 @@ static void test_uretprobe_syscall_call(void)
> >                 _exit(0);
> >         }
> >
> > -       skel->links.test = bpf_program__attach_uprobe_multi(skel->progs.test, pid,
> > -                                                           "/proc/self/exe",
> > -                                                           "uretprobe_syscall_call", &opts);
> > -       if (!ASSERT_OK_PTR(skel->links.test, "bpf_program__attach_uprobe_multi"))
> > +       skel->links.test_uretprobe_multi = bpf_program__attach_uprobe_multi(skel->progs.test_uretprobe_multi,
> 
> this is a bit long, maybe
> 
> struct bpf_link *link;
> 
> link = bpf_program__attach...
> skel->links.test_uretprobe_multi = link;

ok, thanks

jirka

> 
> ?
> 
> But other than that
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> 
> > +                                                       pid, "/proc/self/exe",
> > +                                                       "uretprobe_syscall_call", &opts);
> > +       if (!ASSERT_OK_PTR(skel->links.test_uretprobe_multi, "bpf_program__attach_uprobe_multi"))
> >                 goto cleanup;
> >
> >         /* kick the child */
> > diff --git a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
> > index 0d7f1a7db2e2..2e1b689ed4fb 100644
> > --- a/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
> > +++ b/tools/testing/selftests/bpf/progs/uprobe_syscall_executed.c
> > @@ -10,8 +10,8 @@ char _license[] SEC("license") = "GPL";
> >  int executed = 0;
> >
> >  SEC("uretprobe.multi")
> > -int test(struct pt_regs *regs)
> > +int test_uretprobe_multi(struct pt_regs *ctx)
> >  {
> > -       executed = 1;
> > +       executed++;
> >         return 0;
> >  }
> > --
> > 2.49.0
> >

