Return-Path: <bpf+bounces-69582-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1BDB9ACC6
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 18:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976632A4E1A
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 16:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511A122256B;
	Wed, 24 Sep 2025 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJxutCxs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20DB3128DE
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758729633; cv=none; b=f/286CJusny/sEelj3M6oTu2ULmnyevQqlvxqgPHSZbJC6jLxcttRueenJFbrIOkw0Yo0vEq/c1Zp+702X2w3pFIcPel3C/Cx4ot5U94R6TnIdmFAK8Nw/dIwY5+mssRcM/7+br2Y7DBB4UKo3bETeUqFgMJklzkAkVI15ZTzMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758729633; c=relaxed/simple;
	bh=jEEjzmNz+gmk5ZgeibUNddmKR2RxdfJxzRrshLcdK0s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ac9qDHFoA3Poto+kTMKa/Bk1w8lP8tGW9BK75sJToKtWZFdSra5+pziX6wZWIcdHCyU24Ne9PD7AonShf9oNDkxrWtSNCjrEePoSXm8TS6BC2wBp5o3RCD2UhS1zdaBDs40PVJPonNFkuADhEpY1eUmOrWpLtEK/lBhmYo7t4G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJxutCxs; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46b303f755aso39837365e9.1
        for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 09:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758729629; x=1759334429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=750rYEAHSQ0UWuveAndSH+YLhrYLDuMy4II+d7YdJQE=;
        b=lJxutCxs3RZMFeCOOS2VTbsDXy7S9D/5OVh2iuo0bwAN3PJRKHX9n7hVerFj11aX3s
         96KTehdHee/QXiBSGdzxgkdEAGsXVUyoGCjqjPmhdPsgnRAkD9NJ8FTuNhThGx4St3Wp
         239cC1fzNJi9dWsrYcB+P8OKPOuxVfx9STNs6bOx2hrn5jlqvDVBJjhqiTt6SkEOjCbY
         LiiYxml+zSh8kXr9uzJ3vk0ZlHzbcW5hJwlPfMONE7XDz8ACoiN0KhUes4o5yttog3oV
         QkNNlNT/p0zo14xF3L8xD7CIW4yqlRHxNwqEjcNwZhS0L7QFLhmF0P9HGXX8IdLHmveB
         ZPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758729629; x=1759334429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=750rYEAHSQ0UWuveAndSH+YLhrYLDuMy4II+d7YdJQE=;
        b=hy+wocjt99hT7fGq3QNJysJkg4lPaSscdNIVPtTMAwjc2vKzZb2+cEDkATWnAKxNbm
         rVtNkDOuK896lrvPU5Vorz91guYl7h8LLhThtCOF2gWRRbYjONvila0hAIFIotTxBIRm
         6Sh7I3/k0c8D+VdTNcnz2mW5UC5j6pHBYLydpl9XWlJp6w55xPLeGQ3N2kh/vRdvDSr5
         7DmzzgK2h66uRUtB9UobuBKZjvya6P+5HtX7u+MFMvSz3YrwplrITwSlnyL3MGW3CyTG
         51A3kFqplwZDCBJGCzTScZwnIS6J1uk2KnYZzewOgkGTeYZjKie2dpte/mK2Ew0USQP0
         o1IA==
X-Forwarded-Encrypted: i=1; AJvYcCWj6HhanRteQfrN8iZSpHAaG7UlvcrccH0nE6O3QVJqVn68OGpN8gatGYltXmUtgtPXu1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrrGcQ1FOx8LxULFsJMX5tHoJFebtGeCIxynS9eWs0lhjVdHOr
	QrfH3pVfejsXyrb2b8gJ7Cy2676yiGj2eeZm/H0IGO3i8KZZb59WRPzW
X-Gm-Gg: ASbGncvVNaavzrPSXmx1s7nofrkEZL4HFW3cF2gnbgCCsRv3BNF7LHh1CRr2kdoUWqw
	AuwSwbWtEIFAxZTtAkOnxt3Q5q6zXsfXi/jiRuJgEg/1GyKpDBcgkIkVZVRZmfzAY41AtcjZ6dV
	LclnjsXyRg56h8T0IpgamHaA4CRQzesMNSjgmb5FXe8KhS3K/HD2ZWX9NehzYJ7TP8TCbOPM7s7
	uMiK/nySH8Y1fq0wmuwEkXu9keG/HG0qrPRfCG+Phc6QpLDZJ0l0rj4lXnh2Nmbv8X/p70cv4cx
	MOdhKo8pOI/aipdfeqti63vAYYSNcq7RjMDjROQJY+rBYVM4QzDbn8G5eZORJPJ39MR+NcFC
X-Google-Smtp-Source: AGHT+IGS1uVQdvHmWTJ9aInOCYB0BEj+cPbPcp0L0eplHLPsYT5p2wId+q3+D0Z2kfEz6FOGX5pf3g==
X-Received: by 2002:a05:600c:1d16:b0:45d:f7cb:70f4 with SMTP id 5b1f17b1804b1-46e329bca25mr3761415e9.13.1758729629203;
        Wed, 24 Sep 2025 09:00:29 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee07407d33sm28837786f8f.18.2025.09.24.09.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 09:00:28 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Sep 2025 18:00:26 +0200
To: Steven Rostedt <rostedt@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Florent Revest <revest@google.com>,
	Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>
Subject: Re: [PATCH 2/9] ftrace: Add register_ftrace_direct_hash function
Message-ID: <aNQVmrGCW08zF9Kp@krava>
References: <20250923215147.1571952-1-jolsa@kernel.org>
 <20250923215147.1571952-3-jolsa@kernel.org>
 <20250924050415.4aefcb91@batman.local.home>
 <aNQCDwYcG0Qo00Vg@krava>
 <20250924110703.2a0ced1b@batman.local.home>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924110703.2a0ced1b@batman.local.home>

On Wed, Sep 24, 2025 at 11:07:03AM -0400, Steven Rostedt wrote:
> On Wed, 24 Sep 2025 16:37:03 +0200
> Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > I have bpf changes using this that I did not post yet, but even with that
> > there's probably no reason to export this.. will remove
> 
> I'm interested in seeing these patches, as the ftrace hashes were
> supposed to be opaque from other parts of the kernel.

branch:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/log/?h=bpf/tracing_multi

used in this commit:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?h=bpf/tracing_multi&id=8814108949537edaae84fbeee1cbc28280590b7f

background.. it's poc code for bpf tracing-multi attachment. Most likely we will
go with Menglong change instead [1], but it could use this direct interface in a
same way for speeding up the attachment

jirka


[1] https://lore.kernel.org/bpf/20250528034712.138701-1-dongml2@chinatelecom.cn/

