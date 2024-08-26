Return-Path: <bpf+bounces-38079-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBADC95F336
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 15:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 250EF1F2244F
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 13:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A05C17C987;
	Mon, 26 Aug 2024 13:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTO3Hu1M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA92153828;
	Mon, 26 Aug 2024 13:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680139; cv=none; b=mppM4Hw0su2mxitmiKqF31odggW1IYq7ixg616nUNVovcDP0cjhouF71t1VCWzY4jMcX8rihPNI31fzndFJ4Khj0Eiy9ckLOm4Fl0KsSBGm0R1hB1wAm8MNuqMtHDVoXQbuXk/j4Vpjgv7LNWbKIzspsAskDRXWUc1SwEGy5XeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680139; c=relaxed/simple;
	bh=Z/HJJt/Fg7rwSJ/ePst/lRoG73U9XPBjCjvDkDKqIb0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVwJjeJIQkXno5jyXjHT1LzpuxycNWOerKJg+IpmovTh5caS6pa3r/43bEprrGfFfbSJYA2ezY6Klnpo7NotgKRVF7gWHg1eKnIffaGXXT3QBokQXtugtVy5VEyPCXGgdQr8mvxYlilWyXqHdHCEg6Sz8LNZ1l2fhv49HFcrguw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTO3Hu1M; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3718706cf8aso2498254f8f.3;
        Mon, 26 Aug 2024 06:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724680136; x=1725284936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L/1dDxymQY2q0jHJd/Qc6Etj6Jk8R4gGJoG1cFJtygU=;
        b=eTO3Hu1MDrcN18tW9tXMGsBHfKwYURDsvHDEMk3IUvF3Yql93adwa3LitdByOJ6yqd
         fhMAiUnksbVZp4wBJTW05E8Vcu3dp9bJk86BcqfLYTnVN+TaxDUgeaS+OT5hxtB4Wg/4
         Qo4rkH4P0Xi0A2ayiaxYjEFCA0nFab5WT6EhSBd0Lr5GYml5F8iPk9Z/EbHP6BVf2Hk3
         WjajtWQMJrPXob5FMbaO7IH2iQjntEMpHPwLgGEe9IRopk7CFZv6sl1RUk/3NHTzVsyw
         XE79SQZezj9aAxDYSLYk9Gp6vX1OZDo+yedA0CUdNMa6ApxVHn+CDNYDB1exYGM5OikA
         /9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724680136; x=1725284936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/1dDxymQY2q0jHJd/Qc6Etj6Jk8R4gGJoG1cFJtygU=;
        b=dKN7CZkQOYkB2sEmNGZ2HDwrBsEubQKvCw2Z1J+KaxK5huQgfGZWx3f1Qr+FhhdFDN
         nmrcF02yzHadKU3se3OaCCtnvvEy19Fwvw6Na9nuiZfjq1I+epuPrQBr5eOCeBfHj2ft
         KGligSKayw3PPnWCGfaT9WXhjAzdasde/Ln8JOIVbYUVEvBLbnVPAJdqIQTGTIx32Xuo
         Jpq0p/aH82u8odo2uvGMnaq/OLt90qpzZuek8cIj87tYf+TZ+jHx8XTQNhqCfoNdTgZd
         cCLsXgHEwTCc2TSa/TwfdHvcH9Yr7ijq+74fbWpp14x4zcO58sntw8CgmDIqmUMi/LJy
         vdbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXLGToWrjEFG68dCs8F5SoJrkHcp7p1OUPJZzeNNpDNF3KVGXRjhQooa5rhiCKyKm0xpw=@vger.kernel.org, AJvYcCWbOm9pMV94iNnVax+mOrKD5Y+UkbBn0O8VzOXJFDWxd3F0FBVOXwEMeCR+1BFG4J0rGVRVUCpSGV9g2J+hYqIHz8Tn@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkq9M5nSbY94OXXr1tkCND9U7xm9QdZho+FSb5wBvGDFDfDf29
	gFKWoonvQvbD1YrSSkgtqAqK99N0sulNFaAH3qARtLs9lLO3xsar
X-Google-Smtp-Source: AGHT+IHrhcgoOgjvYxzTNQoCZlmxoFMUdfceFMq9xd7w4/93UD525ZHfm2gCPPn35tCtP2ruPcmEcA==
X-Received: by 2002:a05:6000:2c2:b0:36b:357a:bfee with SMTP id ffacd0b85a97d-37311841b2dmr8125601f8f.1.1724680135817;
        Mon, 26 Aug 2024 06:48:55 -0700 (PDT)
Received: from krava ([213.235.133.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42abeffe43esm189721925e9.44.2024.08.26.06.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 06:48:55 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 26 Aug 2024 15:48:30 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Tianyi Liu <i.pear@outlook.com>,
	andrii.nakryiko@gmail.com, mhiramat@kernel.org, ajor@meta.com,
	albancrequy@linux.microsoft.com, bpf@vger.kernel.org,
	flaniel@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	linux@jordanrome.com, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <ZsyHrhG9Q5BpZ1ae@krava>
References: <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
 <ME0P300MB04163A2993D1B545C3533DDC9D892@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240825171417.GB3906@redhat.com>
 <20240825224018.GD3906@redhat.com>
 <ZsxTckUnlU_HWDMJ@krava>
 <20240826115752.GA21268@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826115752.GA21268@redhat.com>

On Mon, Aug 26, 2024 at 01:57:52PM +0200, Oleg Nesterov wrote:
> On 08/26, Jiri Olsa wrote:
> >
> > On Mon, Aug 26, 2024 at 12:40:18AM +0200, Oleg Nesterov wrote:
> > > 	$ ./test &
> > > 	$ bpftrace -p $! -e 'uprobe:./test:func { printf("%d\n", pid); }'
> > >
> > > I hope that the syntax of the 2nd command is correct...
> > >
> > > I _think_ that it will print 2 pids too.
> >
> > yes.. but with CLONE_VM both processes share 'mm'
> 
> Yes sure,
> 
> > so they are threads,
> 
> Well this depends on definition ;) but the CLONE_VM child is not a sub-thread,
> it has another TGID. See below.
> 
> > and at least uprobe_multi filters by process [1] now.. ;-)
> 
> OK, if you say that this behaviour is fine I won't argue, I simply do not know.
> But see below.
> 
> > > But "perf-record -p" works as expected.
> >
> > I wonder it's because there's the perf layer that schedules each
> > uprobe event only when its process (PID1/2) is scheduled in and will
> > receive events only from that cpu while the process is running on it
> 
> Not sure I understand... The task which hits the breakpoint is always
> current, it is always scheduled in.

hum, I might be missing something, but ;-)

assuming we have 2 tasks, each with perf uprobe event assigned

in perf path there's uprobe_perf_func which calls the uprobe_perf_filter
and if it returns true it then goes:

  uprobe_perf_func
    __uprobe_perf_func
      perf_trace_buf_submit
        perf_tp_event
        {

           hlist_for_each_entry_rcu(event, head, hlist_entry) {
             if (perf_tp_event_match(event, &data, regs)) {
                perf_swevent_event(event, count, &data, regs);

        }

so it will store the event only to perf event which is added for
the task that is currently scheduled in, so it's not stored to the
other task event

in comparison with uprobe_multi path, where uprobe_multi_link_filter
will pass and then it goes:

  handler_chain
    uprobe_multi_link_handler
      bpf_prog_run
       - executes bpf program

the bpf program will get executed for uprobe from both tasks

> 
> The main purpose of uprobe_perf_func()->uprobe_perf_filter() is NOT that
> we want to avoid __uprobe_perf_func() although this makes sense.
> 
> The main purpose is that we want to remove the breakpoints in current->mm
> when uprobe_perf_filter() returns false, that is why UPROBE_HANDLER_REMOVE.
> IOW, the main purpose is not penalise user-space unnecessarily.
> 
> IIUC (but I am not sure), perf-record -p will work "correctly" even if we
> remove uprobe_perf_filter() altogether. IIRC the perf layer does its own
> filtering but I forgot everything.

I think that's what I tried to describe above

> 
> And this makes me think that perhaps BPF can't rely on uprobe_perf_filter()
> either, even we forget about ret-probes.
> 
> > [1] 46ba0e49b642 bpf: fix multi-uprobe PID filtering logic
> 
> Looks obviously wrong... get_pid_task(PIDTYPE_TGID) can return a zombie
> leader with ->mm == NULL while other threads and thus the whole process
> is still alive.
> 
> And again, the changelog says "the intent for PID filtering it to filter by
> *process*", but clone(CLONE_VM) creates another process, not a thread.
> 
> So perhaps we need
> 
> 	-	if (link->task && current->mm != link->task->mm)
> 	+	if (link->task && !same_thread_group(current, link->task))

that seems correct, need to check

> 
> in uprobe_prog_run() to make "filter by *process*" true, but this won't
> fix the problem with link->task->mm == NULL in uprobe_multi_link_filter().
> 
> 
> Does bpftrace use bpf_uprobe_multi_link_attach/etc ? I guess not...
> Then which userspace tool uses this code? ;)

yes, it will trigger if you attach to multiple uprobes, like with your
test example with:

  # bpftrace -p xxx -e 'uprobe:./ex:func* { printf("%d\n", pid); }'

thanks,
jirka


