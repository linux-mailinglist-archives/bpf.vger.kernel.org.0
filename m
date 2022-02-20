Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE914BD276
	for <lists+bpf@lfdr.de>; Mon, 21 Feb 2022 00:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245233AbiBTXLP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Feb 2022 18:11:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245232AbiBTXLP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Feb 2022 18:11:15 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373A02409C;
        Sun, 20 Feb 2022 15:10:53 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id gb39so28521274ejc.1;
        Sun, 20 Feb 2022 15:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6j1RUXCva8ZMkW9Fdwk3mt0oyRudrNViKQtoLjRiuNs=;
        b=JBCLX+ryGqJtx2u95SQwxAfg8uApYZOaR9h/mYgi040iUWnPaHOZcM36OumDtdKhA9
         3W395NNjNlpvR8WXby49I7imT5pXluLDMkk0a9yU5P+QnKthIikDmw+2xKtFbwXyhECw
         2vIWu6DAg5IDmCguUxvEF3BXwTPIWN92ebPOXqxL6YqmEC2hWVzHX1S4KSVCwnro5NeR
         zgdwGf1ZGivAxiE31fqVNpxAUi85D9myYKKr4D5fW3I1gGzoB6W4W4sTOI9SrMjBqUe1
         /Ih3BHsCYavq+jA4/lDL9IMEnXPHP/G1tw4Ido0LCKbx6DQYD+F3+HZx7O/KlDvMNXQO
         OOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6j1RUXCva8ZMkW9Fdwk3mt0oyRudrNViKQtoLjRiuNs=;
        b=d9qqzsjTyupga7+xwTvaU+oEMn0IshvHHVS9kmosSg/yk7QhzGowwSgaHtyGAOwmpE
         d3eSsYr6wTsCBLnKVLMBvOREsUBFYCJ9gkvSgrRG2sfgpFTN1W+3oxDdT5rQoQIyrHp7
         feH6lGEzN22yduRgNtTqRwmUre5HqF1WzZ7ldw3rA0OOQjZIazyiUTPaII/H0JFzxThU
         znjK+L8C0+3M4tpOX8qjjp6ovNyfP/3U49VRxkn7/HOPzXVCkp6ILmxX3/QwFIz/h59w
         CmFqVc7tK2+iXvx2dCHCN4dlHwD37NobfvAGfr0xJIvnwKcGZSotGGEztEt7KHlEi/D4
         HcmQ==
X-Gm-Message-State: AOAM533WCEdQ4gVLDnihy7M2CFuO7FUZP24kDV9psZ0c5S2ZagCdS+ge
        /fJtUDKwluyYajP/l1RioeE=
X-Google-Smtp-Source: ABdhPJwxNHuwFil8ZwBsmFK+FAE8xpK8vqVvnhFZ7KWoXhFwQLEZu5sWPcJNn8z0wfCxjS7excxu3Q==
X-Received: by 2002:a17:907:9870:b0:6d0:ebb7:d4e1 with SMTP id ko16-20020a170907987000b006d0ebb7d4e1mr6929193ejc.471.1645398651540;
        Sun, 20 Feb 2022 15:10:51 -0800 (PST)
Received: from krava ([83.240.63.12])
        by smtp.gmail.com with ESMTPSA id r22sm7542513edt.51.2022.02.20.15.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 15:10:51 -0800 (PST)
Date:   Mon, 21 Feb 2022 00:10:48 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 3/3] perf tools: Rework prologue generation code
Message-ID: <YhLKeAShYUtELvTJ@krava>
References: <20220217131916.50615-1-jolsa@kernel.org>
 <20220217131916.50615-4-jolsa@kernel.org>
 <CAEf4BzYP7=JuyuY=xZe71urpxat4ba-JnqeSTcHF=CYmsQbofQ@mail.gmail.com>
 <Yg9geQ0LJjhnrc7j@krava>
 <CAEf4BzZaFWhWf73JbfO7gLi82Nn4ma-qmaZBPij=giNzzoSCTQ@mail.gmail.com>
 <YhJF00d9baPtXjzH@krava>
 <aa29a73b-b40d-6adf-2252-308917603f05@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa29a73b-b40d-6adf-2252-308917603f05@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Feb 20, 2022 at 10:43:42AM -0800, Yonghong Song wrote:
> 
> 
> On 2/20/22 5:44 AM, Jiri Olsa wrote:
> > On Fri, Feb 18, 2022 at 11:55:16AM -0800, Andrii Nakryiko wrote:
> > > On Fri, Feb 18, 2022 at 1:01 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > > 
> > > > On Thu, Feb 17, 2022 at 01:53:16PM -0800, Andrii Nakryiko wrote:
> > > > > On Thu, Feb 17, 2022 at 5:19 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > > > > 
> > > > > > Some functions we use now for bpf prologue generation are
> > > > > > going to be deprecated, so reworking the current code not
> > > > > > to use them.
> > > > > > 
> > > > > > We need to replace following functions/struct:
> > > > > >     bpf_program__set_prep
> > > > > >     bpf_program__nth_fd
> > > > > >     struct bpf_prog_prep_result
> > > > > > 
> > > > > > Current code uses bpf_program__set_prep to hook perf callback
> > > > > > before the program is loaded and provide new instructions with
> > > > > > the prologue.
> > > > > > 
> > > > > > We workaround this by using objects's 'unloaded' programs instructions
> > > > > > for that specific program and load new ebpf programs with prologue
> > > > > > using separate bpf_prog_load calls.
> > > > > > 
> > > > > > We keep new ebpf program instances descriptors in bpf programs
> > > > > > private struct.
> > > > > > 
> > > > > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > > ---
> > > > > >   tools/perf/util/bpf-loader.c | 122 +++++++++++++++++++++++++++++------
> > > > > >   1 file changed, 104 insertions(+), 18 deletions(-)
> > > > > > 
> > > > > 
> > > > > [...]
> > > > > 
> > > > > >   errout:
> > > > > > @@ -696,7 +718,7 @@ static int hook_load_preprocessor(struct bpf_program *prog)
> > > > > >          struct bpf_prog_priv *priv = program_priv(prog);
> > > > > >          struct perf_probe_event *pev;
> > > > > >          bool need_prologue = false;
> > > > > > -       int err, i;
> > > > > > +       int i;
> > > > > > 
> > > > > >          if (IS_ERR_OR_NULL(priv)) {
> > > > > >                  pr_debug("Internal error when hook preprocessor\n");
> > > > > > @@ -727,6 +749,12 @@ static int hook_load_preprocessor(struct bpf_program *prog)
> > > > > >                  return 0;
> > > > > >          }
> > > > > > 
> > > > > > +       /*
> > > > > > +        * Do not load programs that need prologue, because we need
> > > > > > +        * to add prologue first, check bpf_object__load_prologue.
> > > > > > +        */
> > > > > > +       bpf_program__set_autoload(prog, false);
> > > > > 
> > > > > if you set autoload to false, program instructions might be invalid in
> > > > > the end. Libbpf doesn't apply some (all?) relocations to such
> > > > > programs, doesn't resolve CO-RE, etc, etc. You have to let
> > > > > "prototypal" BPF program to be loaded before you can grab final
> > > > > instructions. It's not great, but in your case it should work, right?
> > > > 
> > > > hum, do we care? it should all be done when the 'new' program with
> > > > the prologue is loaded, right?
> > > 
> > > yeah, you should care. If there is any BPF map involved, it is
> > > properly resolved to correct FD (which is put into ldimm64 instruction
> > > in BPF program code) during the load. If program is not autoloaded,
> > > this is skipped. Same for any global variable or subprog call (if it's
> > > not always inlined). So you very much should care for any non-trivial
> > > program.
> > 
> > ah too bad.. all that is in the load path, ok
> > 
> > > 
> > > > 
> > > > I switched it off because the verifier failed to load the program
> > > > without the prologue.. because in the original program there's no
> > > > code to grab the arguments that the rest of the code depends on,
> > > > so the verifier sees invalid access
> > > 
> > > Do you have an example of C code and corresponding BPF instructions
> > > before/after prologue generation? Just curious to see in details how
> > > this is done.
> > 
> > so with following example:
> > 
> > 	SEC("func=do_sched_setscheduler param->sched_priority@user")
> > 	int bpf_func__setscheduler(void *ctx, int err, int param)
> > 	{
> > 		char fmt[] = "prio: %ld";
> > 		bpf_trace_printk(fmt, sizeof(fmt), param);
> > 		return 1;
> > 	}
> > 
> > perf will attach the code to do_sched_setscheduler function,
> > and read 'param->sched_priority' into 'param' argument
> > 
> > so the resulting clang object expects 'param' to be in R3
> > 
> > 	0000000000000000 <bpf_func__setscheduler>:
> > 	       0:       b7 01 00 00 64 00 00 00 r1 = 100
> > 	       1:       6b 1a f8 ff 00 00 00 00 *(u16 *)(r10 - 8) = r1
> > 	       2:       18 01 00 00 70 72 69 6f 00 00 00 00 3a 20 25 6c r1 = 77926701655
> > 	       4:       7b 1a f0 ff 00 00 00 00 *(u64 *)(r10 - 16) = r1
> > 	       5:       bf a1 00 00 00 00 00 00 r1 = r10
> > 	       6:       07 01 00 00 f0 ff ff ff r1 += -16
> > 	       7:       b7 02 00 00 0a 00 00 00 r2 = 10
> > 	       8:       85 00 00 00 06 00 00 00 call 6
> > 	       9:       b7 00 00 00 01 00 00 00 r0 = 1
> > 	      10:       95 00 00 00 00 00 00 00 exit
> > 
> > and R3 is loaded in the prologue code (first 15 instructions)
> > and it also sets 'err' (R2) with the result of the reading:
> > 
> > 	   0: (bf) r6 = r1
> > 	   1: (79) r3 = *(u64 *)(r6 +96)
> > 	   2: (bf) r7 = r10
> > 	   3: (07) r7 += -8
> > 	   4: (7b) *(u64 *)(r10 -8) = r3
> > 	   5: (b7) r2 = 8
> > 	   6: (bf) r1 = r7
> > 	   7: (85) call bpf_probe_read_user#-60848
> > 	   8: (55) if r0 != 0x0 goto pc+2
> > 	   9: (61) r3 = *(u32 *)(r10 -8)
> > 	  10: (05) goto pc+3
> > 	  11: (b7) r2 = 1
> > 	  12: (b7) r3 = 0
> > 	  13: (05) goto pc+1
> > 	  14: (b7) r2 = 0
> > 	  15: (bf) r1 = r6
> > 
> > 	  16: (b7) r1 = 100
> > 	  17: (6b) *(u16 *)(r10 -8) = r1
> > 	  18: (18) r1 = 0x6c25203a6f697270
> > 	  20: (7b) *(u64 *)(r10 -16) = r1
> > 	  21: (bf) r1 = r10
> > 	  22: (07) r1 += -16
> > 	  23: (b7) r2 = 10
> > 	  24: (85) call bpf_trace_printk#-54848
> > 	  25: (b7) r0 = 1
> > 	  26: (95) exit
> 
> Just curious. Is the prologue code generated through C code or through
> asm code? Is it possible prologue code can be generated through C

it's C code in perf generating bpf instructions:
  https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/bpf-prologue.c?h=perf/core

> code with similar mechanism like BPF_PROG macro? Or this is already
> an API which cannot be changed?

do you mean to have some stub like:

  int bpf_func__setscheduler_stub(void *ctx)
  {
          return bpf_func__setscheduler(ctx, 0, 0)
  }

  int bpf_func__setscheduler(void *ctx, int err, int param)
  {
          char fmt[] = "prio: %ld";
          bpf_trace_printk(fmt, sizeof(fmt), param);
          return 1;
  }

to make verifier happy

then we'd need instructions for bpf_func__setscheduler

it looks like subprogram instructions are appended and we should
be able to locate bpf_func__setscheduler start in instructions
returned in bpf_program__insns ? anyway does not look nice ;-)

jirka
