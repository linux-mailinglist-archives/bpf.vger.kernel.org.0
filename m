Return-Path: <bpf+bounces-55134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4DDA78C51
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 12:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578D6189238B
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 10:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C69D236A61;
	Wed,  2 Apr 2025 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjMalyPr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE3E236454;
	Wed,  2 Apr 2025 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743589672; cv=none; b=PcVrdY/bMxSPzLlHFcI1SevqJQt2j3I7lV8jXb7nyisaFDFCqBbi8hv3RjaGbdoLk4u32GJQkBvHneA3WbsEoj/3ArgUUMNy2JwKvxqPwuMXmAtMiQ00E+4PANPsQiUzMoMNLppjAIvWs5B5/TzlgMVkuY3ZYfAh+h7xVe4MruU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743589672; c=relaxed/simple;
	bh=eeLoqleT0q+WUMWnv3fDw55O+C1cpprufM4gJ9k/rd4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpqOkCMGwbw2AesC1l6eD8cFErMye6TcG5AwTdDBA5+V3Zf/pmrh9sw2Y9EeY6bDuFAEQR3JTGGA12XSxtNORwgX95z1hqQej9K2Tv5xmTlPL81eGNVRoCEtQw1MiU3IgWo1fXUWZCpjO7CRu3ootWv7inR8JnEQ4hZqdUM5NlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjMalyPr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d0782d787so43199325e9.0;
        Wed, 02 Apr 2025 03:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743589668; x=1744194468; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+k78tSb5ZA1zmXxb3m00fnDBewWredn7OcohwmOAeu4=;
        b=PjMalyPrLAiQtT7u2pMITMyICfPFLl1fqEn6HwTdVNz3dBbceeBYb4uBb1eI0v7nKI
         HhDVs3yFjkUM/Z4yc8b+M8CItRJP4xoHUdBPByuZtFCuA3hZ233boHfx8Y8L+xtEWBu1
         QrDj98zx5PBb9ZltPvblk7AnN+zL9VTMy9041RFVhK3RIka/x9JwwqoyBsj6r7lf4FFt
         +71YlKuomBSYUp8WbKHcfL+aQuYHGPkItI1UqaUpt/ex8gTZ15TuyuCnByCLkps5rXPZ
         9CuHM/E4GwxJ04JIziGsoXdXTOVtpwNJCIEgBxTiNBhtEBnGXQwxnE4PlyCCCyiivJFZ
         cvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743589668; x=1744194468;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+k78tSb5ZA1zmXxb3m00fnDBewWredn7OcohwmOAeu4=;
        b=TLjsKNlA5TIZ6vmU2fIOggqmOOTj1Uzj46OFjOtJazzX5XN8GvEnTSPqIaYNOahifu
         VMbsR9wV+F3dB7wujx0Sp80w8PsYDu6SIl6V2vpkvgUgYEXOYws5kw+9uBKYi1ZgLQG/
         HaUhGAhTeWcGkG8H4uFWaU2oeRLdsqZe3I0znvSCXPBjFOjo2oSn7Xki/1Ny7qhz/cCW
         c55742OiILGda95ILOJag8d+rTVV6TbeKy/Drh6jALEh+ctsY2VSHgTorWt1jZ/nJDbX
         NMydAYgAU699GUTYG0M8hQ42mdhqGKLOMN4UHl0j+XdGehwLGf5ilZf7kVVfgQgHXVVF
         26MQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3Q+5Fg+25C8X+NWNXcGLKqlBlSsoiRW4WHda71sTX6jJZo36vImr/DZsGQh5xQNcCrD/qwSz9OF6DOHCj@vger.kernel.org, AJvYcCWssWXdNNLkH70kKsnwNUSEnB0tnjMB9LJfcvh6TQnratSa7R4XosrCtNCCmMgRZUxWevQ=@vger.kernel.org, AJvYcCWtXa+nteArVEXovTtg8xbWb7QKQZU75hCCCqmi0OYZ4me2boNRaZulh2oNG2j0DN08ZGYJQRU5Jfitkcs7qoRC1jFU@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc6NTra5/QVvhfXTmQIxSqcwMZwfGItleWMb84XwcDbvDz7tu3
	UyWJ9bSJg5KGk1EAWxpU5IoCUL9RzJhl5paMJSwH9bhzQBrE+u4s
X-Gm-Gg: ASbGncu/uPG8aNPCqgqW7uIvZuHSr2v7dN1Ud/E8tyOqnFCqbFfwfNrmC6cRTos62Ng
	uzVO4K651iqSaM0fZQ5vFx6EuD1/CHvhgsrsrdF+al89TXArFxW/eA9CfukgcJq04b+OK3riuoi
	+ug9jJYriAnxSrBSZsVwQKtRMoy2cw/yu5d8t/GFo5zKC9+Pq91BuLDGUJ0f9ZHQfm+vk/H5nPP
	Xc9aw4ioDseEB52so4JDL5I2dMoSP3FjimIH/MqAVYiyVUpGIYHOkqz5Ztg3A6Ev/rdTR0jkP4x
	5lb422DDFqjlnXq0N6FHM61i6SL38WhAMQHwNnAe4xL56G85tS2mAMq5o2l8l1tMMxgd9A==
X-Google-Smtp-Source: AGHT+IFleKFYOWRpC3v9vuGJk33DcAzU872/yQKBydvXVfpJMSmUuNbUIfy+XpRWiVZAvuvoODgrEA==
X-Received: by 2002:a05:600c:314b:b0:43c:ea1a:720c with SMTP id 5b1f17b1804b1-43db624b452mr173766045e9.18.1743589668387;
        Wed, 02 Apr 2025 03:27:48 -0700 (PDT)
Received: from krava (pokorny-hyundai2.faster.cz. [77.240.177.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43eb5fd0d36sm16067175e9.10.2025.04.02.03.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 03:27:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 2 Apr 2025 12:27:45 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	mingo@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, mhocko@kernel.org, oleg@redhat.com,
	brauner@kernel.org, glider@google.com, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org
Subject: Re: [PATCH] exit: add trace_task_exit() tracepoint before
 current->mm is reset
Message-ID: <Z-0RIXmHHGrXb5HH@krava>
References: <20250401184021.2591443-1-andrii@kernel.org>
 <20250401173249.42d43a28@gandalf.local.home>
 <CAEf4BzYB1dvFF=7x-H3UDo4=qWjdhOO1Wqo9iFyz235u+xp9+g@mail.gmail.com>
 <20250401181315.524161b5@gandalf.local.home>
 <CAEf4Bzbq1AMdpBysK-OqJPwrKpibyLk9RffiwEU9xdGwwHC_3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzbq1AMdpBysK-OqJPwrKpibyLk9RffiwEU9xdGwwHC_3w@mail.gmail.com>

On Tue, Apr 01, 2025 at 03:17:01PM -0700, Andrii Nakryiko wrote:
> On Tue, Apr 1, 2025 at 3:12 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Tue, 1 Apr 2025 15:04:11 -0700
> > Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > > How bad would it be to just move trace_sched_process_exit() then? (and
> > > add group_dead there, as you mentioned)?
> >
> > I personally don't have an issue with that. In fact, the one place I used
> > the sched_process_exit tracepoint, I had to change to use
> > sched_process_free because it does too much after that.
> 
> heh, I ran into that as well just recently and also had to use
> sched_process_free instead of sched_process_exit, because between exit
> and free we still can get sched_switch tracepoint trigger (so it's a
> bit too early to clean up whatever per-task state I maintain in BPF
> program).
> 
> So yeah, I'm up for that as well, will send v2 just moving and
> extending the existing tracepoint. Thanks!

+1, it'd be great to have the group_dead info, we also need
to have some workarounds for that

thanks,
jirka

> 
> >
> > OK, let's just move the sched_process_exit tracepoint. It's in an arbitrary
> > location anyway.
> >
> > -- Steve
> 

