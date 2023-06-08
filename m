Return-Path: <bpf+bounces-2179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DF8728C0E
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 01:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 374B22817FC
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 23:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9D238CD5;
	Thu,  8 Jun 2023 23:55:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA1F21CEE
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 23:55:56 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571EA273A;
	Thu,  8 Jun 2023 16:55:54 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5147f7d045bso1814751a12.2;
        Thu, 08 Jun 2023 16:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686268553; x=1688860553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oB1HRRmWA9T+4j466bRwlKOXNo7IHrinjQwND3tn210=;
        b=F5J1RibhTyp3uTfsP/7odUXTa384aEczEO8zQgdqnXPQvpFFE1tu+SM8CLVyEZkRwc
         PjMO+u9LkN2QYgU/u6MkMaMV+A4CElGsFBe2lFY6uQ/190R2pv1jyBTXXw7WzZO5VHgL
         gocrBinn/NjL6m5vk4PlaiUSX07q/hHVfEaugDJ5GJoFNfz9UsPd+kKSej8L2VYIs916
         rrmKokehAiOx4NEG7/xprSDfasgbwtj344EKbV6q1+lzPSmdvRIYGTD6purS1lijGNXc
         JVYCaCtqidlnsxweGj3uUSEAvz3WpcHrFVvl62LMuvjUs+kEEj7VCEKKPW1/XpimXYuC
         0bhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686268553; x=1688860553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oB1HRRmWA9T+4j466bRwlKOXNo7IHrinjQwND3tn210=;
        b=QKC5SZfJ1K1L/JkpmRgUmAURYM5xwiuRT6U2Y8o53peQ3PG3WDdwoklwf62i02HhPu
         7JGaTIOrJWNgGwz7c7S8oe+AeBUUqcXcabhRBZq+uEqiTKcqEaPMB5ZzJ5a4IRIXu/3h
         9si9KGMLxzZB2Dq+/k6rCAs4G2SDAvSiA6lvPk9JlC2O13DPr+vtucoowhzRxWB/6NXL
         cIv+nSzUvdDZrmAlt/g3zENKzd0h3xO9DxSXoZrfR2q/VzBd0hjL0Ssk7Lh5eoZKzBGX
         v9cxbzGHMYXKKaOWPNXtxAMlV/anpOzXVdzP+nSyc7vn56AhLguhK7564c9Rms8vzo7v
         oYDQ==
X-Gm-Message-State: AC+VfDxXg3yF7BCCFasnwYuJYwXKYSiNudHefYYOGpGfVteLmfc3Fdd4
	/frw5CSM7e7qnPkocGY2g1XBfTvsr3qiyy2LXBc=
X-Google-Smtp-Source: ACHHUZ5duN9kFjDtY1t5viINpL/SK6JEmIZRlFkt0bTy+CPlpN+EwjZL6tR45V1hPkHAerkwjzwM6bNc1DOSU92BNgs=
X-Received: by 2002:a17:907:1622:b0:96a:90bb:a2d3 with SMTP id
 hb34-20020a170907162200b0096a90bba2d3mr8021ejc.71.1686268552592; Thu, 08 Jun
 2023 16:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230608212613.424070-1-jolsa@kernel.org> <CAEf4BzbNakGzcycJJJqLsFwonOmya8=hKLD41TWX2zCJbh=r-Q@mail.gmail.com>
 <20230608192748.435a1dbf@gandalf.local.home>
In-Reply-To: <20230608192748.435a1dbf@gandalf.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Jun 2023 16:55:40 -0700
Message-ID: <CAEf4BzYkNHu7hiMYWQWs_gpYOfHL0FVuf-O0787Si2ze=PFX5w@mail.gmail.com>
Subject: Re: [PATCH RFC] ftrace: Show all functions with addresses in available_filter_functions_addrs
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Andrii Nakryiko <andrii@kernel.org>, 
	lkml <linux-kernel@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Jackie Liu <liu.yun@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 8, 2023 at 4:27=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Thu, 8 Jun 2023 15:43:03 -0700
> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> > On Thu, Jun 8, 2023 at 2:26=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wro=
te:
> > >
> > >
> > > hi,
> > > when ftrace based tracers we need to cross check available_filter_fun=
ctions
> > > with /proc/kallsyms. For example for kprobe_multi bpf link (based on =
fprobe)
> > > we need to make sure that symbol regex resolves to traceable symbols =
and
> > > that we get proper addresses for them.
>
> I forgot, what was the problem with doing the above?

More code, more memory, more CPU to parse all the text files. Parsing
kallsyms is quite expensive, so avoiding this would be great.

>
> > >
> > > Looks like on the last last LSF/MM/BPF there was an agreement to add =
new
> > > file that will have available_filter_functions symbols plus addresses=
.
> > >
> > > This RFC is to kick off the discussion, I'm not sure Steven wants to =
do
> > > that differently ;-)
>
> I'm not totally against this, but I'd like to know the full issue its
> solving. Perhaps I need to know more about what is being done, and what i=
s
> needed too.

There are BPF tools that allow user to specify regex/glob of kernel
functions to attach to. This regex/glob is checked against
available_filter_functions to check which functions are traceable. All
good. But then also it's important to have corresponding memory
addresses for selected functions (for many reasons, e.g., to have
non-ambiguous and fast attachment by address instead of by name, or
for some post-processing based on captured IP addresses, etc). And
that means that now we need to also parse /proc/kallsyms and
cross-join it with data fetched from available_filter_functions.

All this is unnecessary if avalable_filter_functions would just
provide function address in the first place. It's a huge
simplification. And saves memory and CPU.

>
> > >
> > > thanks,
> > > jirka
> > >
> > >
> > > ---
> > > Adding new available_filter_functions_addrs file that shows all avail=
able
> > > functions (same as available_filter_functions) together with addresse=
s,
> > > like:
> > >
> > >   # cat available_filter_functions_addrs | head
> >
> > nit: can we have some more succinct name, like "traceable_funcs" or
>
>
> It's to match avaliable_filter_functions

it's minor, I'm fine with whatever name, I'm searching for it in my
history every single time anyways :)

>
> Another way is to add a tracing option to make the address show up in the
> available_filter_functions file. That would be my preferred choice.
>
>   echo 1 > options/available_filter_addrs
>
> Or something like that.

This would modify behavior for entire system, right? I think this is
very bad. Just because one application is aware of this option and
wants to turn this on, doesn't mean that all other applications that
might also use available_filter_functions should immediately break on
that machine.

Please, let's have a separate file. There is no downside to that.

>
>
>
> > something? And btw, does this have to be part of tracefs/debugfs
>
> Because it's part of ftrace, and that belongs in tracefs.

I can use ftrace (through BPF) without mounting tracefs, right? So it
would be good to have a list of attachable kprobes without having to
worry whether tracefs was mounted or not. It's no big deal, I was just
curious if there has to be a tie to tracefs.

>
> > (never knew the difference, sorry). E.g., can it be instead exposed
> > through sysfs?
>
> tracefs is not debugfs, as debugfs includes all things debuggy (and
> considered not secure). tracefs is its own file system dedicated to the
> tracing code in the kernel. It exists with CONFIG_DEBUG not defined, and
> lives in /sys/kernel/tracing. The only reason /sys/kernel/debug/tracing
> (which is a duplicate mount point) exists is for backward compatibility f=
or
> before tracefs existed. But that path really should be deprecated.

cool, thanks for explaining!

>
> >
> > Either than these minor things, yep, I think this is something that
> > would be extremely useful, thanks, Jiri, for taking a stab at it!
> >
> > >   ffffffff81000770 __traceiter_initcall_level
> > >   ffffffff810007c0 __traceiter_initcall_start
> > >   ffffffff81000810 __traceiter_initcall_finish
> > >   ffffffff81000860 trace_initcall_finish_cb
> > >   ...
> > >
> > > It's useful to have address avilable for traceable symbols, so we don=
't
> > > need to allways cross check kallsyms with available_filter_functions
> > > (or the other way around) and have all the data in single file.
>
> Is it really that big of an issue? Again, I'm not against this change, bu=
t
> I'm just wondering how much of a burden is it relieving?

Quite a lot, especially when you have to do all that in pure C.

>
> > >
> > > For backwards compatibility reasons we can't change the existing
> > > available_filter_functions file output, but we need to add new file.
>
> Or we could add an option to change it ;-)
>
> > >
> > > Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  include/linux/ftrace.h |  1 +
> > >  kernel/trace/ftrace.c  | 52 ++++++++++++++++++++++++++++++++++++++--=
--
> > >  2 files changed, 48 insertions(+), 5 deletions(-)
> > >

[...]

