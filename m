Return-Path: <bpf+bounces-72149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A076C07D1F
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 20:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0A8E188AD08
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 18:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF3934B190;
	Fri, 24 Oct 2025 18:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWQafwot"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB3933B976
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331878; cv=none; b=h2URv89kNJxOSsxADZtUsMvHkhGZDm8CXcPsfa1PznuZoM/JdFwWdIZWKYRJeadAVxDpOzwhMyONr9Jw3kP0WW/19orYB4hewI4L/s2jFri6HrfC0TtmuX3T/bk44Z1IK8oB4avrl3Iy2N1rI3qQQmw800jZwYNfbBpjCXdB2Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331878; c=relaxed/simple;
	bh=zqrGjUJ698YClDJ3TmjkNWOOnDHqX8WFVTQRYlec0CU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QhPKFse9kT7ZBJey65RbElAhT65xD3l536VGGCLAKQA81YaR6k6frpt0ByUHYNjWKQZ8kiBMdHDJ1UKH9xOFiOVwrkdHXU06r5ko/6eIXuS7FTuDwQtidyIomwMgwkWDIUn2qmJ4EdzpU1rLDUJ6K4YMCvNXObgd5TPK/4kKNtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWQafwot; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so19277235e9.2
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 11:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761331874; x=1761936674; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t7Zh6pNkF+WOivDtJP8tmFei4F0isWrVIg6ZCiyVzgI=;
        b=SWQafwotXo9+XoJUvyuIlOCHTeIhxPYjaTSZ8xKGyxAKqUSK5yRuq47LsJtKr4FE3m
         Z4ESjxMa/X5iXzyLApJ1gjTWJRMBHR7YSda1uXu41UiP+LSvK4+h1moCQLmt5PA3w+er
         X24/7OqsW0RKQIo1oLmMxkNP67GIodwIFwdHGdhxCYD9qcToSj+9JX4oP0SOq6OBbU7u
         TqLdF1rEUpaBfvsClTMkAgz3fa6JGmdm/B/iiewRLVXRKitS+2g7+C0xJ0D+IbVmTHHa
         PRlNi51i0UVD+Tv1FOsbPsp9dW9dXsq2i41UH2KECX1vGJeaKP3nY/S7ePVqplJEkBUS
         SdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761331874; x=1761936674;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7Zh6pNkF+WOivDtJP8tmFei4F0isWrVIg6ZCiyVzgI=;
        b=McYSTCd9efhK9p+wOOK+F3242WvfXqU95GhuhxlkL6EdCYs//arxpYAQsKT4Z3k7Pp
         mIvd2hHBj9wCEB8Fb+CnrCUCRZv7a9uHzU3mssy0Ax4J11w2+2pybMstHyVRzTcNy4PC
         eAQe5+sigaeejWyqrciZaHXOs+Bpe0RmlSw7suro7a+I/6ezhqVYrigPw8fX+SAvWGn3
         q4wXRN4RxRhPUfBm2mP5T0+lZbum793ViSge03GBqg0kg+/IV3bUqvaHuZNwStWz+bBk
         fOWiVtnu5pxpTDpGk4wCuHLx13an+AVLsYlpp8OERPX4t8E6uCBN1F7Q7q0ucQrPrso+
         a6ig==
X-Forwarded-Encrypted: i=1; AJvYcCVY+G7OttrBbrsNQlc2gs9HJu6QQvfdWFBH4FYrJfrSZqXuPqO3w7xvI/8t1YSsfwTqJys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJaBN24r/5/r/jEaHVJUq9Nk6b+FVxUXi+vJsErmHDj4o6y1Pj
	p6Sh09MsK2aD3PjxKQ86HGGm1kya/+aGtTNsWI72C9q0h7LojRxkhfseZbw7SA==
X-Gm-Gg: ASbGncvxEwqzbt5wcD6kGhPRaLQU2Xcex3yI7Lj1DuVCcBdte+0yxT9jPvo4p0UzZ1y
	6H2o4JlOsnjeQJ4lp66/JHelT54folH+ghcNH1gppAupS4g1R1TEFUwkHJaQ9cP19AsgItGCgIA
	SGaM5yiGXU27UcFVGZglgatfc/MQ/xTe875VmpDeZLmqrWYrwe+/2xV8n8wy8xrS36D1Voddiiu
	vFr75MQC6nmJPTJVotRYhekAoG/BoVAWVFWUMBaCDuEHqq2N6Zx4UqHCG/thRp17flJfTnIn1T1
	Q819t+yNcGgX+f6IE4/puRK1uiBvmxAjJehc0jHCt8Dnt4k7ThfQipCxAE47eCk2+aYnAadUxwy
	UXTyrbwxNCZrl3O8l81jNDTak5x9RnSvDFSRIHmYjOcUOuHulkb/RQ/CxNAC47sbI
X-Google-Smtp-Source: AGHT+IGOJ2HowDuzFPdE49LeeFFxM4Ibpy622YXnKRZJ9nZeLtPjH2GSOXup26UH/HX1uoAiAita+A==
X-Received: by 2002:a05:600c:64c4:b0:471:60c:1501 with SMTP id 5b1f17b1804b1-475d2ecaedemr36421515e9.28.1761331873671;
        Fri, 24 Oct 2025 11:51:13 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496d4b923sm87163955e9.14.2025.10.24.11.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:51:13 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 24 Oct 2025 20:51:11 +0200
To: Song Liu <songliubraving@meta.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Song Liu <song@kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
	"ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"andrey.grodzovsky@crowdstrike.com" <andrey.grodzovsky@crowdstrike.com>,
	"mhiramat@kernel.org" <mhiramat@kernel.org>,
	Kernel Team <kernel-team@meta.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH bpf-next 1/3] ftrace: Fix BPF fexit with livepatch
Message-ID: <aPvKnzOFQWVr1E4Y@krava>
References: <20251024071257.3956031-1-song@kernel.org>
 <20251024071257.3956031-2-song@kernel.org>
 <aPtmOJ9jY3bGPvEq@krava>
 <F4D3E33F-C7AB-4F98-9E63-B22B845D7FC2@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F4D3E33F-C7AB-4F98-9E63-B22B845D7FC2@meta.com>

On Fri, Oct 24, 2025 at 03:42:44PM +0000, Song Liu wrote:
> 
> 
> > On Oct 24, 2025, at 4:42 AM, Jiri Olsa <olsajiri@gmail.com> wrote:
> > 
> > On Fri, Oct 24, 2025 at 12:12:55AM -0700, Song Liu wrote:
> >> When livepatch is attached to the same function as bpf trampoline with
> >> a fexit program, bpf trampoline code calls register_ftrace_direct()
> >> twice. The first time will fail with -EAGAIN, and the second time it
> >> will succeed. This requires register_ftrace_direct() to unregister
> >> the address on the first attempt. Otherwise, the bpf trampoline cannot
> >> attach. Here is an easy way to reproduce this issue:
> >> 
> >>  insmod samples/livepatch/livepatch-sample.ko
> >>  bpftrace -e 'fexit:cmdline_proc_show {}'
> >>  ERROR: Unable to attach probe: fexit:vmlinux:cmdline_proc_show...
> >> 
> >> Fix this by cleaning up the hash when register_ftrace_function_nolock hits
> >> errors.
> >> 
> >> Fixes: d05cb470663a ("ftrace: Fix modification of direct_function hash while in use")
> >> Cc: stable@vger.kernel.org # v6.6+
> >> Reported-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> >> Closes: https://lore.kernel.org/live-patching/c5058315a39d4615b333e485893345be@crowdstrike.com/ 
> >> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> >> Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >> Acked-and-tested-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> >> Signed-off-by: Song Liu <song@kernel.org>
> >> ---
> >> kernel/trace/ftrace.c | 2 ++
> >> 1 file changed, 2 insertions(+)
> >> 
> >> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> >> index 42bd2ba68a82..7f432775a6b5 100644
> >> --- a/kernel/trace/ftrace.c
> >> +++ b/kernel/trace/ftrace.c
> >> @@ -6048,6 +6048,8 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
> >> ops->direct_call = addr;
> >> 
> >> err = register_ftrace_function_nolock(ops);
> >> + if (err)
> >> + remove_direct_functions_hash(hash, addr);
> > 
> > should this be handled by the caller of the register_ftrace_direct?
> > fops->hash is updated by ftrace_set_filter_ip in register_fentry
> 
> We need to clean up here. This is because register_ftrace_direct added 
> the new entries to direct_functions. It need to clean these entries 
> for the caller so that the next call of register_ftrace_direct can 
> work. 
> 
> > seems like it's should be caller responsibility, also you could do that
> > just for (err == -EAGAIN) case to address the use case directly
> 
> The cleanup is valid for any error cases, as we need to remove unused
> entries from direct_functions. 

I see, I wonder then we could use free_hash to restore original
direct_functions, something like:

	if (err) {
		call_direct_funcs = rcu_assign_pointer(free_hash);
		free_hash = new_hash;
	}

we'd need to keep new_hash value

but feel free to ignore, removal is also fine ;-)

thanks,
jirka

