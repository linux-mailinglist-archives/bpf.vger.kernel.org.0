Return-Path: <bpf+bounces-47027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E809F2B62
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 09:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90DE81690A3
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 08:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43F8203D7A;
	Mon, 16 Dec 2024 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE2K1SBt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664D02036EC;
	Mon, 16 Dec 2024 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734335958; cv=none; b=nQhnq4im26xK0AalbpuHHeFv++f+/GSkvWqXtgDF1mdioOctV69DNqqzwqS/nvOmeLtHL+fgC7sCMIyJP99kNFROSZgXyZLQaOrqXUlqE9l5vfGTWMK5DaTuAt9Rj+AkGTv2ttwZsltXbZJU4sJZaJFd0aT2VQ4FLQXh6BEbgAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734335958; c=relaxed/simple;
	bh=XjjqmXdnPoZMmJvsnN7Pl8dBlC1wyFsfE3PqKphn7Cg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFzgPfR2FkYw1ooPFKWOOtytV028jLFrgIXPDnLKGqNo3NrzokNGrao2HxoXLrINjsg3Idh9UhfPIzINbf1mlkHeltJgD4YzXWu6OI4iQH/feEZhhfip4ESepvS2uW0gL1Yx4BVck2KU7YeB/61sGqMcwxEqhzRCPVYtpVMix4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JE2K1SBt; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436345cc17bso14808515e9.0;
        Sun, 15 Dec 2024 23:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734335955; x=1734940755; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rfOCWBAffqFrJ9B6oNyv73TWjd/1dRRlf1O+ICA1gik=;
        b=JE2K1SBtA1Xgj7xBy0cjg6VZ8fP/iNOBYgS50GGyOfvTZytBTAsXMyF3KEg9w/f7c3
         xBb7o04hsqxEBtyn8Qmm86xDWUMW17owGtoejAeVD9WV//c/bqAyURvOlsH2t/ggsSa/
         4UqjaZ5DvX5jXV2lOJOQmfW14dlHeLVzopcaIQz7Jhd/Oqa+wbFSylojQ8SMS5HupgrT
         eY55H3kYXocjOhbASjLc6M0Q1dSCKLDhnnQguXCOxpGfkSH9NDkz9mVClL9j3m5t5K2V
         csdRXB7Ok8I1js6SMjJa0K6p/yhGR4xTFs2ZvMyUuEUyTRDmZ77+7g6+A+6aQoBx4STu
         Rlrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734335955; x=1734940755;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rfOCWBAffqFrJ9B6oNyv73TWjd/1dRRlf1O+ICA1gik=;
        b=tWC5MNaOQa4ZII9gut24bSsmlFIHUItMaeakRzZw5QKQmuKJf7S0t7UZb6LtgdPuRc
         wp9K12hpw5sCZ8Tt+SxFXjRYLPoLmJee6vvVU9eYwkeAXJkRLhpqHWeKgH76KlEbd5pS
         V/xoqgj9Ut8ySwZnUeb4OX94z9uoUi4NRy+REN9KaMhyidUoeMMBZ10Mv5Yi4YwailkA
         ysgHzI11lLgZ16ZO4Q4lzp0NVGCFga2J7zr3pr2DqyP5U6euVYDqcpIOH/Gwk73/X2zu
         oQvdV81ZbbQkqR0Rk91SJ/idBGGnlT/cjhqqgnlDoCaJyLEXkFMnQA1VXoYw3MCh5WIQ
         mh2w==
X-Forwarded-Encrypted: i=1; AJvYcCWOachEvPV1jDF71D7rCsdOGJBlMpNfenfibhSitKmyfCJT460YpzYlk69Ln6qNiYbOwRJx7a35bhzLfn2x@vger.kernel.org, AJvYcCX4kK+lBeCi34VRQsrfTS2kbhb2gGdB3OAugjhsJ9Zq5uri8HDp3oLomFw6QDyfhkxxsl45ZwSgD+Q375TAgyQ5sntG@vger.kernel.org, AJvYcCXEMLQye2MPRXSGBQVEghdxAnScYgY/UDMOFSWVpo09pr/JTnn2AJRMvY6J2cQrh2Tl/Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvuBfKsv3wPbhEs0Ul8y7qkEaC01D0ot1QKuiaCuNDREuIwMsD
	5hY4NlhnZ3SoujSI5vP4aep241rSFs3PKXgSH0JuLfo7pMP8aslZ
X-Gm-Gg: ASbGncsFq1wGtHY8m8AoKj/wEtwfzv9Id7wuewiMGPmUqQDjqVEKG4X9KkD/AO0z8Sj
	D1FcxBVrETrOR2JhxVx6KzHnhoLVU6kY9+4WQDUdM79Zr6GNpo1f9p84jI3nlQiZ3w819W2SNOq
	2fIum8/nKb2JjbIv3+kgW0KpWZDugxx+y7fhp+VWfLcVBIdW3i5WHpWucmWqzkPt4NdwGPbqcUR
	8DKznSfPnnIZbSChS0mPxduPzbqcOG1ExzbbJ4FCmAn8jkcn6ogb+UGSpUkaeo230CaE5aui5Td
	jJmB8VRDKUPEi6Keg2oKTeryi9ATpg==
X-Google-Smtp-Source: AGHT+IHradt+OP6BWyqXLvgKjEyqBuTLJMmPMSjGf66/oB4UN5WkjLiBIrxVigD19j0a6ynfCAuEMQ==
X-Received: by 2002:a05:6000:186e:b0:382:31a1:8dc3 with SMTP id ffacd0b85a97d-38880ae0f0amr8598577f8f.35.1734335954398;
        Sun, 15 Dec 2024 23:59:14 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80162b1sm7299787f8f.38.2024.12.15.23.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 23:59:14 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 16 Dec 2024 08:59:12 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 11/13] selftests/bpf: Add hit/attach/detach race
 optimized uprobe test
Message-ID: <Z1_d0Chz17VZuX9V@krava>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-12-jolsa@kernel.org>
 <CAEf4BzaSqWudSq6tEW3g+szAbcf+n4RO4T2wTnF2Kof0tSMW5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaSqWudSq6tEW3g+szAbcf+n4RO4T2wTnF2Kof0tSMW5w@mail.gmail.com>

On Fri, Dec 13, 2024 at 01:58:43PM -0800, Andrii Nakryiko wrote:
> On Wed, Dec 11, 2024 at 5:36 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding test that makes sure parallel execution of the uprobe and
> > attach/detach of optimized uprobe on it works properly.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../selftests/bpf/prog_tests/uprobe_syscall.c | 82 +++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > index 1dbc26a1130c..eacd14db8f8d 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_syscall.c
> > @@ -532,6 +532,81 @@ static void test_uprobe_usdt(void)
> >  cleanup:
> >         uprobe_optimized__destroy(skel);
> >  }
> > +
> > +static bool race_stop;
> 
> volatile?

ok

> 
> > +
> > +static void *worker_trigger(void *arg)
> > +{
> > +       unsigned long rounds = 0;
> > +
> > +       while (!race_stop) {
> > +               uprobe_test();
> > +               rounds++;
> > +       }
> > +
> > +       printf("tid %d trigger rounds: %lu\n", gettid(), rounds);
> > +       return NULL;
> > +}
> > +
> > +static void *worker_attach(void *arg)
> > +{
> > +       struct uprobe_optimized *skel;
> > +       unsigned long rounds = 0;
> > +
> > +       skel = uprobe_optimized__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "uprobe_optimized__open_and_load"))
> > +               goto cleanup;
> > +
> > +       while (!race_stop) {
> > +               skel->links.test_2 = bpf_program__attach_uprobe_multi(skel->progs.test_2, -1,
> > +                                               "/proc/self/exe", "uprobe_test_nop5", NULL);
> > +               if (!ASSERT_OK_PTR(skel->links.test_2, "bpf_program__attach_uprobe_multi"))
> > +                       break;
> > +               bpf_link__destroy(skel->links.test_2);
> > +               skel->links.test_2 = NULL;
> > +               rounds++;
> > +       }
> > +
> > +       printf("tid %d attach rounds: %lu hits: %lu\n", gettid(), rounds, skel->bss->executed);
> > +
> > +cleanup:
> > +       uprobe_optimized__destroy(skel);
> > +       return NULL;
> > +}
> > +
> > +static void test_uprobe_race(void)
> > +{
> > +       int err, i, nr_cpus, nr;
> > +       pthread_t *threads;
> > +
> > +        nr_cpus = libbpf_num_possible_cpus();
> 
> check whitespaces

ok

> 
> > +       if (!ASSERT_GE(nr_cpus, 0, "nr_cpus"))
> > +               return;
> > +
> > +       nr = nr_cpus * 2;
> > +       threads = malloc(sizeof(*threads) * nr);
> > +       if (!ASSERT_OK_PTR(threads, "malloc"))
> > +               return;
> > +
> > +       for (i = 0; i < nr_cpus; i++) {
> > +               err = pthread_create(&threads[i], NULL, worker_trigger, NULL);
> > +               if (!ASSERT_OK(err, "pthread_create"))
> > +                       goto cleanup;
> > +       }
> > +
> > +       for (; i < nr; i++) {
> > +               err = pthread_create(&threads[i], NULL, worker_attach, NULL);
> > +               if (!ASSERT_OK(err, "pthread_create"))
> > +                       goto cleanup;
> > +       }
> > +
> > +       sleep(4);
> > +
> > +cleanup:
> > +       race_stop = true;
> > +       for (i = 0; i < nr; i++)
> > +               pthread_join(threads[i], NULL);
> 
> what happens with pthread_join() when called with uninitialized
> threads[i] (e.g., when error happens in the middle of creating
> threads)?

yes, I'll do the proper cleanup in new version

thanks,
jirka

