Return-Path: <bpf+bounces-47025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1108D9F2B39
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 08:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C0F1620E5
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 07:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CC21FF7D8;
	Mon, 16 Dec 2024 07:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbknvN8I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7071FF7D0;
	Mon, 16 Dec 2024 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734335786; cv=none; b=R3/AoexMEWPluJ3lzJVRx6un3KlfyToW+WOqjuTWBXU2QuIq81jdykMbaJSLUgxGCEZvkHHyJ0IDlXHPWIMigrwYEiBQ/BlOwGSwDjaHsBxmuzKEn2UH8aUoKNDXT9JTBAUuwr7v/ttioPK52j/pkKwtx19UNYe24JuFce/4MXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734335786; c=relaxed/simple;
	bh=bSlERmMYSl7dopPQbjdQD2d1oHPFGiVS0aVu0lv4m5c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEsRueOEkK6f6ftEVnpWobKiPyirQa8W5/Jqp5KzCpqZJcouARXwZUnfZqw6qhaiQrTqrhCfIZ0je/G2+3z5eQO2n4p2DtWasvWvD3x/ReGMh4Uf+RJuUxgWdHE73Mk+4Zks6/SowFca8hMq0qg0tGQXaTI5rTBKIKyhxRwPEbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbknvN8I; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d647d5df90so3569233a12.2;
        Sun, 15 Dec 2024 23:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734335783; x=1734940583; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/vTcaQKwd8FYs5ftOR4sAUTa6EBjrQidDcX0mFSVSMA=;
        b=PbknvN8ICA7TldBCN8erjJCPPwNKtIpclusnuWKU6pzJ0CIB1VB2agRBC8uaX8bF9c
         H9EVUs98VO0quZiyU2AYF3gXa0i4fBrzjag1MLQvpKRR8aktqywwvAqchcF+FZ1WurSS
         QWah3BzluIhfyr1CdyyTwuZnrRhiyRnVacRGq2AeZ3CjXGV494vp+6qid7w8ozpkDke2
         OFQWhWw5DsdhEcEGet56Maiz/A6ZEzU6ceod5daDYyFfyPcHn7/atRndnZeTD+ck5mv2
         soEOpRGz97u9EtXrIx+6qGyJk1M5HziMDsMFMyoRBOVPIFJubjf7AzoE/nG6AM8hbbfI
         kCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734335783; x=1734940583;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vTcaQKwd8FYs5ftOR4sAUTa6EBjrQidDcX0mFSVSMA=;
        b=eGGdL+iHxuslkQQVtFJMxzgTjiNn7ivgl0G9XatApkMlapvdKvQE6VFUWrMTnXvDG1
         7r/fUOpUPtm9dwL7iEvg8dgDybDCkbitCeVG86YvjEV6j+HD9fwrLRAV2Q8Di1AAezXj
         kLKfjSIvHOvoM+ZJvye7h+hrD1wxewXbPfY2zyVu5dR3eDj7Ink19TxTcp+KExhXSDsP
         c8v7NFGbwNDwa0bZwE6Wzz8pXEWl0n3QB/X1VqMPk5WFb9kxduZ4EtMvhrT+MiiRBArv
         6qhaBE6rk/kn5KrQ8KCuZBZY6UT4MGlLHf+2gKMv5SKzgpUtPfQp6+96HltnDipqCHrZ
         khgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlZ1SAOaxPQEi3ZCYWCyJYKx1EV/T7/rF1wsIeGNMkmCGUi/YjEpp99OWsQxJtjZy1ErZ1F960pbn2N8JS@vger.kernel.org, AJvYcCVRxOZZZk5rJ+m9AU8m1a2wNHmTxNyGGbz10/fhMRlxu39Gk3YrEN+jf+02MFLI89y18OG/aJiqTCtLqV2iAA5vtyVF@vger.kernel.org, AJvYcCX2B+Y/J2iIcJlp+qAHsWej8+vsm/kdfgtE5k6g+sxHH7jLObVmGMOpLU9FHNZLDIbJ5OM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0q8Mscdida5p6DkysCadwn4hiEkt5yyJtjsEpQxOhwimtjlqy
	vJStHAi7NYiRbuUOWady6BfsMT7F8L4c+iApGh3VyxxdL7hDiSa2
X-Gm-Gg: ASbGncupZcXtLAfGm6cYhPR5BaXLZsagiES+OdApLLcYwsMc8+wRuGze4nMzX+Bz1Ax
	74puNgC6MTxf1PGXRNo9Z4W7XRu9DfJx0roMiL7tfsIpolwXYd9Xl3WVYJ7sXGoh0Xb3IwCXZ/M
	zwzh16OKB+3OnBu8U6I/zney6bseiIEdiWO7m+9vHd4FkD5s4nScrEmfx98fbxZF4ky73CXvsG0
	tiScIQyrMR6u5ihDI1tDyNCBhTEIRUM3ZIe6sdODLrCfBDi5ATs9ciaX7m1vNueRYlQLgqEdxJR
	ukPFPl2WZbALnc1fOx8hwtvvDL+8ng==
X-Google-Smtp-Source: AGHT+IEo5XlTc7xrSCK3CcJK+pHVJ3ufXsaL/ChLZ1HGl/lNJOhPv044YxeiUr1vNFlFw1ZMURHFdA==
X-Received: by 2002:a17:907:7204:b0:aa6:3de7:f258 with SMTP id a640c23a62f3a-aab77e9d1e3mr1081031366b.37.1734335782598;
        Sun, 15 Dec 2024 23:56:22 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96006c3asm300376266b.19.2024.12.15.23.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 23:56:22 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 16 Dec 2024 08:56:19 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 13/13] selftests/bpf: Add 5-byte nop uprobe
 trigger bench
Message-ID: <Z1_dIwRiqbsuWgvF@krava>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-14-jolsa@kernel.org>
 <CAEf4BzZPCdRPyXH1xDed2m3VvNkzzpY33Gbd_vWxivxLZQCdLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZPCdRPyXH1xDed2m3VvNkzzpY33Gbd_vWxivxLZQCdLQ@mail.gmail.com>

On Fri, Dec 13, 2024 at 01:57:56PM -0800, Andrii Nakryiko wrote:
> On Wed, Dec 11, 2024 at 5:36 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Add 5-byte nop uprobe trigger bench (x86_64 specific) to measure
> > uprobes/uretprobes on top of nop5 instruction.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/bench.c           | 12 ++++++
> >  .../selftests/bpf/benchs/bench_trigger.c      | 42 +++++++++++++++++++
> >  .../selftests/bpf/benchs/run_bench_uprobes.sh |  2 +-
> >  3 files changed, 55 insertions(+), 1 deletion(-)
> >
> 
> [...]
> 
> >  static void usetup(bool use_retprobe, bool use_multi, void *target_addr)
> >  {
> >         size_t uprobe_offset;
> > @@ -448,6 +462,28 @@ static void uretprobe_multi_ret_setup(void)
> >         usetup(true, true /* use_multi */, &uprobe_target_ret);
> >  }
> >
> > +#ifdef __x86_64__
> > +static void uprobe_nop5_setup(void)
> > +{
> > +       usetup(false, false /* !use_multi */, &uprobe_target_nop5);
> > +}
> > +
> > +static void uretprobe_nop5_setup(void)
> > +{
> > +       usetup(false, false /* !use_multi */, &uprobe_target_nop5);
> > +}
> 
> true /* use_retprobe */
> 
> that's the problem with bench setup, right?

yes, but there's more ;-)

we also need change in arch_uretprobe_hijack_return_addr to skip
the extra 3 values (pushed on stack by the uprobe trampoline) when
hijacking the returm value, I'll send new version

jirka

> 
> > +
> > +static void uprobe_multi_nop5_setup(void)
> > +{
> > +       usetup(false, true /* use_multi */, &uprobe_target_nop5);
> > +}
> > +
> > +static void uretprobe_multi_nop5_setup(void)
> > +{
> > +       usetup(false, true /* use_multi */, &uprobe_target_nop5);
> > +}
> > +#endif
> > +
> >  const struct bench bench_trig_syscall_count = {
> >         .name = "trig-syscall-count",
> >         .validate = trigger_validate,
> 
> [...]

