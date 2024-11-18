Return-Path: <bpf+bounces-45077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D489D0BB3
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 10:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9907F282B9E
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 09:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E0A13DBBE;
	Mon, 18 Nov 2024 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQTjw0Rk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B25115442A;
	Mon, 18 Nov 2024 09:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731922156; cv=none; b=O1dSdehAEXL7INvBqWYA9mJvPBKDWm2d5bNtwMgIpexUEAJKNOPsmJ1tseblaNiqLv3WVElJgpC0wiJDKXCAkWY1XYq0QMNcWnhK3+hIU4s9mHH9K92j0lyoY6/XvzGvcbFFtjWZDb+HtAwLCCZmYB0bGcONF33CoJP3equfSyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731922156; c=relaxed/simple;
	bh=XMBYv9pbgjLjK9oOSPsxGOsLWyt8DrOi+QNj/+12aP8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsC+Dq5bfm9Okymm6ELfaIdVTnMHMclURCzpQ6AmTR69xfmQsWj8Yvth6a4FJ3hzquQImCiZfAZAJMaBM2Dh+Xi4nnveGFmNRoG5vIqY7WbY6lTgrmz27Iux72uBxLWWtAUhm+h7JfJIXhChmqWPEigqJC5RMQIZWp2k+pHmtU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQTjw0Rk; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so164376266b.1;
        Mon, 18 Nov 2024 01:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731922153; x=1732526953; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pEQEy7HVOv946SKUCqF/boSEKPZMqrMqF/TZkd8Mnmc=;
        b=ZQTjw0Rk7l690aXuj7ifbtIyo7wZFKAZ/hYS1F8vAQT0b4tdjwrjDZQiZ0MKedkSC0
         bREvQ3WkIKc53FNpLSsCOT7mOcU4vlN57/DFMFSylQdNvvkqKl40RBSiS4WzakbX6Sba
         5e4cyXhmQwkxx2cDXzs+pn4L1lrwkkqAvjVP5edrM1qzPuu7YgH4ykImjg43TcraMyIH
         BELb2kL5Lh51cM0YKNC+DFoA9WLMW9f+AozrKjTpIcnlGu/GS+/6yO9A++t2m+36djl2
         ATrCnJUqgwHcVhve8wiWZCdqWqvdkBpMnrvu24a4UZG8JD3lq+idA3wcsElzTa5c+1L9
         mong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731922153; x=1732526953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEQEy7HVOv946SKUCqF/boSEKPZMqrMqF/TZkd8Mnmc=;
        b=f2VWsHBqkKrnfR/5Ed2Ls9lpyWmOT7KVyavR3yWh3AyAKXZmTpJNY+/rBzv7J5mUnq
         XU9rNOhE0X22guR/wp11YWcb9NaNayNZxrHp10pbxkn2JkUgwhP6AHHtaBAvmSmOpPZS
         HLu7SaCmHnFxpRiUORyWG6eMfgxB86VfHDSuRFJb/xnMsSoVc+d0VAHajByqGRWFThZY
         Ssux4jQ9EcEfY29yNQf9irdmRexutsYDcxxSAfD+IY9oFG+HJ+UCEfq6wR4KCxl9ovjd
         FhcKAFqnuax+hC/JDi/lL72FgvIka3jQBLeTZS+vlvW+VDF+oCAsajeQ3Y6OyOdRbKv0
         Fotw==
X-Forwarded-Encrypted: i=1; AJvYcCVASZ4nc4pHZLnQ2FwesyvAXF7lub1R+RF88YEIsOtxFAU+pe236z2goaM32tmG6YslEFZeifRd2xkpPamV@vger.kernel.org, AJvYcCWh1jXTI+mk6a6dJc/jUCS8m1x9DMDPYO3HgT3WE0QVLcvpf21T9K1hnxh9q4yNhJGUAws=@vger.kernel.org, AJvYcCWpvQkLqtdEMIoa6D+bdHK/aG7xZlRAR/3p4KqAbGaiXkU1xlJ/pnur9vLNyh7OTdmiuXs64rm7zTJVQxyQOViK+NUx@vger.kernel.org
X-Gm-Message-State: AOJu0YycDjr3wViUeev4vdBSXL+OcQqoxdAIxLl9eqvbLQ1pn6GxH/SO
	mliCWexjmmymaECG+IsTLO03/nJxxCbHKrGSezlFD2a6JGFEFE/f
X-Google-Smtp-Source: AGHT+IEZgSzJEf5iPHV0TwDUiP7pt4NQ1fuClulT+9/+255bPWxST3/GrLB6f88Y9wQRAVdjFahTaA==
X-Received: by 2002:a05:6402:5cb:b0:5cf:634a:10ce with SMTP id 4fb4d7f45d1cf-5cf8fd2c9e4mr13221949a12.25.1731922152514;
        Mon, 18 Nov 2024 01:29:12 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79c1de36sm4352338a12.84.2024.11.18.01.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 01:29:12 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 18 Nov 2024 10:29:09 +0100
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC 00/11] uprobes: Add support to optimize usdt probes on
 x86_64
Message-ID: <ZzsI5V4v33nyNqPG@krava>
References: <20241105133405.2703607-1-jolsa@kernel.org>
 <20241117114946.GD27667@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241117114946.GD27667@noisy.programming.kicks-ass.net>

On Sun, Nov 17, 2024 at 12:49:46PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 05, 2024 at 02:33:54PM +0100, Jiri Olsa wrote:
> > hi,
> > this patchset adds support to optimize usdt probes on top of 5-byte
> > nop instruction.
> > 
> > The generic approach (optimize all uprobes) is hard due to emulating
> > possible multiple original instructions and its related issues. The
> > usdt case, which stores 5-byte nop seems much easier, so starting
> > with that.
> > 
> > The basic idea is to replace breakpoint exception with syscall which
> > is faster on x86_64. For more details please see changelog of patch 7.
> 
> So this is really about the fact that syscalls are faster than traps on
> x86_64? Is there something similar on ARM64, or are they roughly the
> same speed there?

yes, I recall somebody was porting uretprobe syscall to arm, but there was
no speed up IIRC, so looks like it's not the case on arm

I can't find the post atm, I'll keep digging

jirka

> 
> That is, I don't think this scheme will work for the various RISC
> architectures, given their very limited immediate range turns a typical
> call into a multi-instruction trainwreck real quick.
> 
> Now, that isn't a problem if their exceptions and syscalls are of equal
> speed.

