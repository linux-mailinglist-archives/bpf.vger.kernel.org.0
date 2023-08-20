Return-Path: <bpf+bounces-8136-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB90E781FB2
	for <lists+bpf@lfdr.de>; Sun, 20 Aug 2023 22:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25145280F48
	for <lists+bpf@lfdr.de>; Sun, 20 Aug 2023 20:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD83F6FD1;
	Sun, 20 Aug 2023 20:27:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC027E6
	for <bpf@vger.kernel.org>; Sun, 20 Aug 2023 20:27:59 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9AE172A;
	Sun, 20 Aug 2023 13:24:00 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so3243079a12.0;
        Sun, 20 Aug 2023 13:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692563038; x=1693167838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2Xrn81pUm49X9JoaI8Eluw06pxka7n96wDGzMSJxcIQ=;
        b=AeUWhAIS6biBQQydsLAC3pS9PhO7XBw5dgnIIOn8a8CoAircTM2l1zcFCo4V/jJytl
         Bm70TjtkRi7KrGEd8t+rZIVUnZViS8Y3h9+URXFe5UBHjHGvLYSXC740ItcopZvA/cH4
         FdR9tmv9+PE+v7/BzAcJY9QqxbTgGYidoif26bio5HnZ/nLnNQ7KKOBKx7bgYXobZSBY
         mPH5MchFnzvLKY7wcxGI7rnUFzS3fBKEYFkBeJZqbAhfyVGK/ePrn45fvwq8MLLcwuyP
         RjiNRDE9xDQtcPFARQDCK1JND3aPdqiqpRmja6qhgv1IfOYARVd2Q+SXgy4rvnUuCsFO
         63ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692563038; x=1693167838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Xrn81pUm49X9JoaI8Eluw06pxka7n96wDGzMSJxcIQ=;
        b=RtZsMMBbaco+d+1w27Tk9Gfdm0Ney0Thx39ABt76KSK5YMcTR65w95PZ4WECE8/lZv
         RqyHRy1+b6rdxdiUZINJ2f0usasvflM8SjBwl3jkmkPuZ3u6JPDDxWlCwjMIruOP6JAq
         E913ePEzCTEt5hZutM0AnbmCkqDXaNIv0FyjZpj6Hirluu4W2HSd5QhJJe76FYEiVIuI
         MnGKkySe8nf1dq0LREV9rfn9qYkH4ZurggqTG/o/zMdumU9pz/jGVLCGkI/LlhPFQXtd
         /dXmgGTan5eVGauegi8jfk6H0X/Rqeyvp1EMURf/FsIrf4QAC5X84/MbdF9JfW/dpQLb
         oftw==
X-Gm-Message-State: AOJu0YykTtH6p/DWEh9wzKVzASIj2LnuCqUBE0IpQV2peqBcTI393y3A
	tRAXtpxFCMscLx+hJLd5+QT0pQLOHz0=
X-Google-Smtp-Source: AGHT+IFcSwQns/SylrwuDSB1Un4raL0PNYmP4JZf8LfSKdvQm+Z0DDH3TLods4qAQAZnNBxvAcgqHQ==
X-Received: by 2002:aa7:cd8f:0:b0:523:1053:9b50 with SMTP id x15-20020aa7cd8f000000b0052310539b50mr3864856edv.20.1692563038281;
        Sun, 20 Aug 2023 13:23:58 -0700 (PDT)
Received: from krava ([83.240.60.227])
        by smtp.gmail.com with ESMTPSA id u2-20020a056402110200b005231e3d89efsm4869592edv.31.2023.08.20.13.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 13:23:57 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 20 Aug 2023 22:23:55 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Francis Laniel <flaniel@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] tracing/kprobe: Add multi-probe support for
 'perf_kprobe' PMU
Message-ID: <ZOJ2W4O75BYP1uML@krava>
References: <20230816163517.112518-1-flaniel@linux.microsoft.com>
 <2154216.irdbgypaU6@pwmachine>
 <20230818220537.75ce8210c6a4c80a5a8d16f8@kernel.org>
 <5702263.DvuYhMxLoT@pwmachine>
 <20230819101105.b0c104ae4494a7d1f2eea742@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230819101105.b0c104ae4494a7d1f2eea742@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 19, 2023 at 10:11:05AM +0900, Masami Hiramatsu wrote:
> Hi Francis,
> (Cc: Song Liu and BPF ML)
> 
> On Fri, 18 Aug 2023 20:12:11 +0200
> Francis Laniel <flaniel@linux.microsoft.com> wrote:
> 
> > Hi.
> > 
> > Le vendredi 18 août 2023, 15:05:37 CEST Masami Hiramatsu a écrit :
> > > On Thu, 17 Aug 2023 13:06:20 +0200
> > > 
> > > Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > > > Hi.
> > > > 
> > > > Le jeudi 17 août 2023, 09:50:57 CEST Masami Hiramatsu a écrit :
> > > > > Hi,
> > > > > 
> > > > > On Wed, 16 Aug 2023 18:35:17 +0200
> > > > > 
> > > > > Francis Laniel <flaniel@linux.microsoft.com> wrote:
> > > > > > When using sysfs, it is possible to create kprobe for several kernel
> > > > > > functions sharing the same name, but of course with different
> > > > > > addresses,
> > > > > > by writing their addresses in kprobe_events file.
> > > > > > 
> > > > > > When using PMU, if only the symbol name is given, the event will be
> > > > > > created for the first address which matches the symbol, as returned by
> > > > > > kallsyms_lookup_name().
> > > > > 
> > > > > Do you mean probing the same name symbols? Yes, it is intended behavior,
> > > > > since it is not always true that the same name function has the same
> > > > > prototype (it is mostly true but is not ensured), it is better to leave
> > > > > user to decide which one is what you want to probe.
> > > > 
> > > > This is what I meant.
> > > > I also share your mind regarding leaving the users deciding which one they
> > > > want to probe but in my case (which I agree is a bit a corner one) it
> > > > leaded me to misunderstanding as the PMU kprobe was only added to the
> > > > first ntfs_file_write_iter() which is not the one for ntfs3.
> > > 
> > > Hmm, OK. I think in that case (multiple same-name symbols exist) the default
> > > behavior is rejecting with error message. And optionally, it will probe all
> > > or them like your patch.
> > 
> > I am not sure to understand.
> > Can you please precise the default behavior of which software component?
> 
> I meant that the behavior of the kprobe-events via /sys/kernel/tracing.
> But your patch is for the other interface for perf as kprobe-event PMU.
> In that case, I think we should CC to other users like BPF because
> this may change the expected behavior.

it does not break bpf tests, but of course we don't have such use case, but I
think should make this optional not to potentionaly break existing users,
because you get more probes than you currently ask for

would be great to have some kind of tests for this as well

SNIP

> > > > > > +		/*
> > > > > > +		 * alloc_trace_kprobe() first considers symbol name, so we set
> > > > > > +		 * this to NULL to allocate this kprobe on the given address.
> > > > > > +		 */
> > > > > > +		tk_same_name = alloc_trace_kprobe(KPROBE_EVENT_SYSTEM, event,
> > > > > > +						  (void *)address, NULL, offs,
> > > > > > +						  0 /* maxactive */,
> > > > > > +						  0 /* nargs */, is_return);
> > > > > > +
> > > > > > +		if (IS_ERR(tk_same_name)) {
> > > > > > +			ret = -ENOMEM;
> > > > > > +			goto error_free;
> > > > > > +		}
> > > > > > +
> > > > > > +		init_trace_event_call(tk_same_name);
> > > > > > +
> > > > > > +		if (traceprobe_set_print_fmt(&tk_same_name->tp, ptype) < 0) {
> > > > > > +			ret = -ENOMEM;
> > > > > > +			goto error_free;
> > > > > > +		}
> > > > > > +
> > > > > > +		ret = append_trace_kprobe(tk_same_name, tk);
> > > > > > +		if (ret)
> > > > > > +			goto error_free;

this seems tricky if offs is specified, because IIUC that will most
likely fail in the __register_trace_kprobe/register_kprobe call inside
the append_trace_kprobe ... should we allow this just for offs == 0 ?

jirka

