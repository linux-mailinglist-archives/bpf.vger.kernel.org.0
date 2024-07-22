Return-Path: <bpf+bounces-35221-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28329938D86
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 12:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962171F21AA9
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 10:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFC44414;
	Mon, 22 Jul 2024 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IpzFJImo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C4D16B3B4
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721644214; cv=none; b=k0HulEC7b6zLhCxkn9IyOSI8MJFWkUQjMovC2csQcSCYX6jxfbztuB8XoASASyJ7NG1nsHT4H9DU2j2Shpblp4QMWRk8vV/ku7dokOjYJYmXyiFI0Z35ebNWFw6ggOR1W6w5Wh8K3nQylE8LDvaKDDAPkDN8nx2wkB9f5qAcOwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721644214; c=relaxed/simple;
	bh=DF8RaEAMTvCMC45rKV4gJZMAuTmZjT2agGvviterzWk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JSOSGT1LqqhEEr0PwBBAF06Ahrxlt7ZWm1MB3iQuF1pbUy+8gjQycg9VUeVr7v5tm7VjlD5AntgWfTbFPhyhcNyvsRdLHuB+sSD7v7I/V+0Ofjd1lBZNo846FlbieCKDbs7MNYywWDfKHzAoLrx+CE492N4sFUmMp4kfSSofkss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IpzFJImo; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eeec60a324so53925931fa.2
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 03:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721644210; x=1722249010; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UfGhHEMXbKpPGmQteGSQkJOVbEo05mTnOullcGLHw00=;
        b=IpzFJImotFy0eF09LmN06FMF2iMB1Y3sn3n7wSLg1rmZnj9tBcf+rnFVgO/ySSUSa6
         WD74uUvkV6pjQ0SBzruFKjCf7v9Xr4nSoyEd5Ol8n4LV+BnOdgAi8eNGj2yzKjVR0Ff+
         93kmkuiXmihNevo/rabqOTD8PXotCzTsd6PCoUo+izZ7HhEFKI7FAz3QcswvZAHBEHYb
         5ncIh5Hw0bHafu168xhmvURa3JFlUijDgRdyOVytmen071vm45k2s6vhkqdbsMqurMtS
         0HtDNhucV01jfDJ9sy4ijJQxfwonHgWyedGRj0NIdMUKf2gPrSx7p0QXa/AQgHqsugCy
         oyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721644210; x=1722249010;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UfGhHEMXbKpPGmQteGSQkJOVbEo05mTnOullcGLHw00=;
        b=jNZg6PBNGYOxJ/d/3i0JiYU4o5A6/8XAb9rVOwOqB9k7dk3HrIZwVGe1ouP95cd8L2
         sDPQpzD3zlzuzDjQccCBqC9UFPy1hpKlCK96xfMEMcyTh7o3XYmBvR6oYZPHlVXG66SR
         9tPDFYNCYfl2LIL9eKUhqo7EkLYKUyW1jj06gfnEIKqgMS3okFjHBgDtH9Co9R/MCOPl
         w3vxUtSzw00l5dNJ/Q/u71RtN5BeNY9BwQ8xwk/8QeVbweZ57zy3gx4ceql11mnYh0Wt
         jrB5rLyH+S8K9Ye/hu8Lb00191foX0I4tQtmMzieEFLaWSwDT7j5fIApoHXLLbXKsBrQ
         SUqA==
X-Forwarded-Encrypted: i=1; AJvYcCXfAvQunfULw8UMkhMXURwKQk6tkJ7nlJtc3X9WtclXKoitoVqYhzAOkViUS3YnLujeVeHFKzua5pf9FKb43gEa4Qfx
X-Gm-Message-State: AOJu0YwNlWRXWPW6SZg3Alc1sjLZJFxzxm3u4KQeNaPNKp+G54OhQ5OE
	BPIC2avRkBUwOPgahWLYIq6oMgIMhUc9gVBX5Fqsd8Axjz1Qz+uB
X-Google-Smtp-Source: AGHT+IGM1dPJU+LUXHZzMlarLyDPmfGVJyF7LeYT/2V05lIdm/Z6q0w3+eMV0mEFHDMb+cAjCHqG6g==
X-Received: by 2002:a2e:be26:0:b0:2ef:29cd:3191 with SMTP id 38308e7fff4ca-2ef29cd333emr32054721fa.35.1721644209969;
        Mon, 22 Jul 2024 03:30:09 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c7d32c6sm5825579a12.90.2024.07.22.03.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:30:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 22 Jul 2024 12:30:07 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCHv2 bpf-next 2/2] selftests/bpf: Add uprobe multi consumers
 test
Message-ID: <Zp40r6ziSh_5Yil6@krava>
References: <20240718132750.2914808-1-jolsa@kernel.org>
 <20240718132750.2914808-3-jolsa@kernel.org>
 <CAEf4BzaSM1iBuC0kL8s2J_Xh1BxE90QE-8ypsqJKb1TP8t48Cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaSM1iBuC0kL8s2J_Xh1BxE90QE-8ypsqJKb1TP8t48Cg@mail.gmail.com>

On Fri, Jul 19, 2024 at 10:58:07AM -0700, Andrii Nakryiko wrote:
> On Thu, Jul 18, 2024 at 6:28 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding test that attached/detaches multiple consumers on
> 
> typo: attaches
> 
> > single uprobe and verifies all were hit as expected.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../bpf/prog_tests/uprobe_multi_test.c        | 211 +++++++++++++++++-
> >  .../bpf/progs/uprobe_multi_consumers.c        |  39 ++++
> >  2 files changed, 249 insertions(+), 1 deletion(-)
> >  create mode 100644 tools/testing/selftests/bpf/progs/uprobe_multi_consumers.c
> >
> 
> LGTM, took me a bit of extra time to validate the counting logic, but
> it looks correct.
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > index da8873f24a53..5228085c2240 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > @@ -6,6 +6,7 @@
> >  #include "uprobe_multi.skel.h"
> >  #include "uprobe_multi_bench.skel.h"
> >  #include "uprobe_multi_usdt.skel.h"
> > +#include "uprobe_multi_consumers.skel.h"
> >  #include "bpf/libbpf_internal.h"
> >  #include "testing_helpers.h"
> >  #include "../sdt.h"
> > @@ -581,7 +582,7 @@ static void attach_uprobe_fail_refctr(struct uprobe_multi *skel)
> >                 goto cleanup;
> >
> >         /*
> > -        * We attach to 3 uprobes on 2 functions so 2 uprobes share single function,
> > +        * We attach to 3 uprobes on 2 functions, so 2 uprobes share single function,
> 
> this probably belongs in patch #1

ugh yep

SNIP

> > +static int uprobe_attach(struct uprobe_multi_consumers *skel, int idx)
> > +{
> > +       struct bpf_program *prog = get_program(skel, idx);
> > +       struct bpf_link **link = get_link(skel, idx);
> > +       LIBBPF_OPTS(bpf_uprobe_multi_opts, opts);
> > +
> > +       /*
> > +        * bit/prog: 0,1 uprobe entry
> > +        * bit/prog: 2,3 uprobe return
> > +        */
> > +       opts.retprobe = idx == 2 || idx == 3;
> > +
> > +       *link = bpf_program__attach_uprobe_multi(prog, 0, "/proc/self/exe",
> 
> 
> this will crash if idx is wrong, let's add explicit NULL checks for
> link and prog, just to fail gracefully?

ok

> 
> 
> > +                                               "uprobe_session_consumer_test",
> > +                                               &opts);
> > +       if (!ASSERT_OK_PTR(*link, "bpf_program__attach_uprobe_multi"))
> > +               return -1;
> > +       return 0;
> > +}
> > +
> > +static void uprobe_detach(struct uprobe_multi_consumers *skel, int idx)
> > +{
> > +       struct bpf_link **link = get_link(skel, idx);
> > +
> > +       bpf_link__destroy(*link);
> > +       *link = NULL;
> > +}
> > +
> > +static bool test_bit(int bit, unsigned long val)
> > +{
> > +       return val & (1 << bit);
> > +}
> > +
> > +noinline int
> > +uprobe_session_consumer_test(struct uprobe_multi_consumers *skel,
> 
> this gave me pause, I was frantically recalling when did we end up
> landing uprobe sessions support :)

rename leftover sry ;-)


SNIP

> > +               } else {
> > +                       /* uprobe return is tricky ;-)
> > +                        *
> > +                        * to trigger uretprobe consumer, the uretprobe needs to be installed,
> > +                        * which means one of the 'return' uprobes was alive when probe was hit:
> > +                        *
> > +                        *   idxs: 2/3 uprobe return in 'installed' mask
> > +                        *
> > +                        * in addition if 'after' state removes everything that was installed in
> > +                        * 'before' state, then uprobe kernel object goes away and return uprobe
> > +                        * is not installed and we won't hit it even if it's in 'after' state.
> > +                        */
> 
> yeah, this is tricky, thanks for writing this out, seems correct to me
> 
> > +                       unsigned long installed = before & 0b1100; // is uretprobe installed
> > +                       unsigned long exists    = before & after;  // did uprobe go away
> > +
> > +                       if (installed && exists && test_bit(idx, after))
> 
> nit: naming didn't really help (actually probably hurt the analysis).
> installed is whether we had any uretprobes, so "had_uretprobes"?
> exists is whether uprobe stayed attached during function call, right,
> so maybe "probe_preserved" or something like that?
> 
> I.e., the condition should say "if we had any uretprobes, and the
> probe instance stayed alive, and the program is still attached at
> return".

yep, looks much better, will rename, thanks

jirka

> 
> > +                               val++;
> > +                       fmt = "idx 2/3: uretprobe";
> > +               }
> > +
> > +               ASSERT_EQ(skel->bss->uprobe_result[idx], val, fmt);
> > +               skel->bss->uprobe_result[idx] = 0;
> > +       }
> > +
> > +cleanup:
> > +       for (idx = 0; idx < 4; idx++)
> > +               uprobe_detach(skel, idx);
> > +}
> > +
> 
> [...]

