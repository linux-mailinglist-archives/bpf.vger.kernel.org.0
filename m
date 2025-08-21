Return-Path: <bpf+bounces-66256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B75B3033B
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 21:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BC93A8485
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 19:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E522D34AAF6;
	Thu, 21 Aug 2025 19:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXL975h4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6D82E8B80;
	Thu, 21 Aug 2025 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755805928; cv=none; b=fzGf1htHOQY/MaXTLvzRNO6KGWzNOAIWn8h9Xur4/soFw0bSw12yE8uBgTPJYwbwfoxW63yjRQfND1F+nl2NnFbeMu9k651j1MAuP6CgF0qUZ9tbYs8INHZdmKVQxW0itabLl6fNPAGFkVI8mNslIps4+JLaq+hLiBozvXgOXO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755805928; c=relaxed/simple;
	bh=7yfRVH0Exkcd8xeLJq3hMuK4KEE+AmC9kn+l/e51Szk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SO4e8wqkvRNuWtAYthgBAsL5mrIUe/A0F2gwovZbZoJ1d4JhMWT0l7+CX8CEK/usHe+Fr5ljleX1EKZRFSb1aeiGNHIwRGxzwlNeg+xINI+5XxXq35lEV0kLlIiS5UBfbRsJ5DoLWYYRgESiML+Dp5tmzjTqRtf3jbTKXmIeuqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXL975h4; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6188b70abdfso1696992a12.2;
        Thu, 21 Aug 2025 12:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755805924; x=1756410724; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tzR/Xe8h3Jn6NuxNeYxIa3+YKBUyNP35PoWSLkLcgJ8=;
        b=UXL975h4+STne1k5BzaT1JGveNTNVDVv6WdJPI50d1XjLVr0bg5ZlWMUBZKRpQ3Y39
         clwy6kei7Hg2X+frS0Y3NuCiaRLWTRy+sM8ibA5vXsZ9PmPzNMEHEn+iwceCr4UMQBDw
         svnAsVNsNHf23sfMiVct5t6L/S3IFQVQEn50n8+KNY2Ljf1q2flJZPFs4s0ZoUoQwpRl
         TL0UtOt/L1DbuBQdhvYQ/6tR/EdbyR0j4FwbeR66mlvOPh160Ykw5voFzt2iNVt5X6p1
         ylg9lTpNCSm4Zo9zmrpkm9p/c+DsSkM4URGJVHyc8jeadGumf5pJ0rlJX9DiudK7YSQr
         Qswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755805924; x=1756410724;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzR/Xe8h3Jn6NuxNeYxIa3+YKBUyNP35PoWSLkLcgJ8=;
        b=kblh+8sJEmIypCVy9j/DZ4carz+iOl9OP/hc1xjNQfADFMktM+0wMEwGy19Ys4041a
         lF1wkelJCHo2OhEL+ET7xYGT25qSmF0PY3Pl/DYRLy5B5EUaIfp8pOfL9N298703DK7+
         oResXlMdjiC5jmsphKWu7fGqC1SzBgV0fdLQsxNY/ZC2p5jwKFpEg7tLCxcW6f5ztIME
         NMI3W+yT/i/bFIS5YlYMMk5RUnrEzo8qOcwFwm90T54k1hscgmS7z0nq9hYKJP8Oo2Mp
         zFCr84SZqLlefQsQw9qNvp1tlo37P4iLpc/B/dpuucVoAwxm2cq2/8HGcOMPCSpuW5Es
         Bpmw==
X-Forwarded-Encrypted: i=1; AJvYcCV1iMx4pd+h9uDhkTQkSWQqkzhksxLwwhA2d7nazg9eK3rUCWhiyRuG3FJqZm7dvDfD2MJ3LDSmz/G0dX8z@vger.kernel.org, AJvYcCWNxnPEFqwt/Ju1KhZD1vhFyYS3TQNNKiNyDyEOVZfM5uaZjs5C/KkZ4cQ3FlbZfTzUwzk=@vger.kernel.org, AJvYcCX4YYJ2lSk4s4RL8trXdehPxHzSjt+Lt/dB0nKwcKXvwtalr8E3zc4IRZPciuJkKreEwAyua8WYqPB63GRhPjtMstG+@vger.kernel.org
X-Gm-Message-State: AOJu0YxDYxhn3nFZ0R6RcvkyFrXgCs7qo+6sVvZHXwD+piazLrHvHPsa
	Z1hER8dp3by6a9mu8C7TCDHWbDwEXfQMZROGsEFfSzSb0VFKldE5qXJ4
X-Gm-Gg: ASbGncunu1rGLLS2SnmR2NS0HwRaTJhTYY+FTt1FfaqoR8obob21Tn2HLGhsZXl6Tei
	G4eQEkkJZAmhAcL3P9MfMfzI+kFaBgq50xdqKf96HPtRT3N1nS7t/T8Auvleou0NPXe+IcXL91V
	6AjpIlrGLwvR5L9FgN2E8hKZatFQH2FslMFU2anweDU00cpkuUtLGkigXEEg+XFFWhXK4LuFpkS
	DxTIu9NdNc+AO+idy88Fu2UCL6kgr1o6wXz6LgOSGDQdYUfzQqDi+EWeU3+cB6pMi/haPS1dIQ1
	/kjIVODFhyTqbvxvU8oCZdtDynjy7HZM2X4XW2blDcjJ2H6pkWlop2BRGx0PmapRd+7PSgugaDY
	HfE60IMDMp0w=
X-Google-Smtp-Source: AGHT+IH778s67WtruPY+IS73DW+rHO3RZ7KXDei0AMh8p7I9gPgsWz0IrJBn7b7ETcvr8u6oY3Ri+g==
X-Received: by 2002:a17:907:7f89:b0:aec:5a33:1549 with SMTP id a640c23a62f3a-afe2953976cmr27483966b.40.1755805923456;
        Thu, 21 Aug 2025 12:52:03 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afdf63c85efsm359520966b.10.2025.08.21.12.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 12:52:03 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 21 Aug 2025 21:52:00 +0200
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "olsajiri@gmail.com" <olsajiri@gmail.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"songliubraving@fb.com" <songliubraving@fb.com>,
	"alx@kernel.org" <alx@kernel.org>,
	"alan.maguire@oracle.com" <alan.maguire@oracle.com>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"mingo@kernel.org" <mingo@kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"David.Laight@aculab.com" <David.Laight@aculab.com>,
	"yhs@fb.com" <yhs@fb.com>, "oleg@redhat.com" <oleg@redhat.com>,
	"kees@kernel.org" <kees@kernel.org>,
	"eyal.birger@gmail.com" <eyal.birger@gmail.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"thomas@t-8ch.de" <thomas@t-8ch.de>,
	"haoluo@google.com" <haoluo@google.com>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH 0/6] uprobes/x86: Cleanups and fixes
Message-ID: <aKd44ArsaKg9kl73@krava>
References: <20250821122822.671515652@infradead.org>
 <aKcqm023mYJ5Gv2l@krava>
 <a11bdc1f59609073f182c2c04dbd72cecde61788.camel@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a11bdc1f59609073f182c2c04dbd72cecde61788.camel@intel.com>

On Thu, Aug 21, 2025 at 06:27:23PM +0000, Edgecombe, Rick P wrote:
> On Thu, 2025-08-21 at 16:18 +0200, Jiri Olsa wrote:
> > hi,
> > sent the selftest fix in here:
> >   https://lore.kernel.org/bpf/20250821141557.13233-1-jolsa@kernel.org/T/#u
> 
> I tried for a bit to run the BPF selftests, and ran into various issues. Did you
> have access to CET HW to test?

yes,

  # cat /proc/cpuinfo  | grep user_shstk | head -1
  flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc cpuid aperfmperf tsc_known_freq pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch cpuid_fault epb ssbd ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid rdseed adx smap clflushopt clwb intel_pt sha_ni xsaveopt xsavec xgetbv1 xsaves split_lock_detect user_shstk avx_vnni dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp hwp_pkg_req hfi vnmi umip pku ospke waitpkg gfni vaes vpclmulqdq rdpid bus_lock_detect movdiri movdir64b fsrm md_clear serialize pconfig arch_lbr ibt flush_l1d arch_capabilities


also I had to merge in bpf-next/master to be able to build it,
what issues did you see?

jirka

