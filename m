Return-Path: <bpf+bounces-66081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 693B9B2DC40
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 14:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1636C1C44B5A
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 12:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7079B2E7F13;
	Wed, 20 Aug 2025 12:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B52HnG/1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6846F2D6639;
	Wed, 20 Aug 2025 12:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755692354; cv=none; b=LvIVanDakXuYIpmZ2W2lIEmqLrco2I1Q16obsvuYZe3R6Jph1yAwEjOc8jtfXDKVA1d0Km7kfZ1VaG2tNufRayd69a8eRG6D0Q14SJnu35c6V9yD9nIZQ5gVrUvnzJrXONoFTnVeALKe/tEvdE01jk2difUq7H2tooBxmoffsz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755692354; c=relaxed/simple;
	bh=S6dzUGTLi+xBUepJZV56TWxo2puGfWHW1VleT9Pis94=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvWxCKlmvYelH7+dPYgNBloho0RhA/LpC3PIuY9pOarIbHibC3KTXF9fUC05M7tFG0OrwO5G4ZShRDWPkD70G14KVxY6+RopaDMQL7uYSOzK2+QLn9tO7Wq/gZHz2k7tmjZKXXh4YvjrxkuQd6Zf+LNfoUf9+Aes3ymdmDRV9UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B52HnG/1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9dc52c430so3265879f8f.0;
        Wed, 20 Aug 2025 05:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755692351; x=1756297151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dZ2ambSA7V273FGKCWZ+wCtXkWQJOxWKNrIvAhO8k6c=;
        b=B52HnG/1yLpvUO+9qc0ussM2Rh2lSoM+lzjxdKF2DZSHf7anlTPKGAXSMdlMuCpckc
         H/uff2nSyWhV7hWOxsqBrl2aaBjLh7vJi04FQ6YNklKKVyVSbg+cFeRyDcX6DU031FnA
         UsWd50+AeBc8g5sDCQHPA+IfGysydu/u3/WozwZYhWAfxqKCABXsOSvVwxH3jRnYilaT
         TfKJDo5MAg9BEPVMRRIcanmmuzF1fbqdF+NS9b5ZmvtMBM43N14DccTJnxqt4+kwDpgK
         F8CBuIS8cLeu9tH4RXV0/QXiEJKI9cDN8WUoGl9CrQBfx6iKq1lIpY1eJM80FTeJ6ORH
         pr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755692351; x=1756297151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZ2ambSA7V273FGKCWZ+wCtXkWQJOxWKNrIvAhO8k6c=;
        b=J7kqH0pXfpxLb/hGu1JbtVvroB3HREpParXshY0mcJINiNkGZpS7jlujFmSMHuRxWK
         M/cMvfpA5oe8pQO5yYPvgxhU/tMruew8uzZvYA9j6/0nlyxOsKdajTqFSoETDBnGFnFU
         h6PRcvLHgq6OEA8rNzxOCwTFJP5AY0oN7RGzQGvS60MALjw7Z7hP9qO5dwyTK/k+nsoa
         alYuD4LP5XCQkrtU+U3SMhXAUE/pHj5KFuEBK5uh+LFsE4THk9er0O4lhKyHlY25oyWN
         TGrAmykExw0urCrf0xBsafv7F4a/hi7DIWeJOOj3/rsCDAck6bE7Y8qKv2kCqvtPbUP8
         qJdg==
X-Forwarded-Encrypted: i=1; AJvYcCUftFu8cxfhQ/bv6vBd07llhMr2xdAQw6UPlReZR1Dq4ax2wY9m32v351ObNCGuwH5yrXiQBxWAhu2eIaVE@vger.kernel.org, AJvYcCVXnSWVxfzk221dhMnwCxZ7QP/CuP0W26QGi3qc8JgyjjKJO42lhOTiGItR7XZnrt9GXSE=@vger.kernel.org, AJvYcCWNoUs+od6ZJnvRLv2sCViM0Q2KsuDCkVNaOrcwmVnFTcNwp+VLOQ2TW6OZr9J7aSJX8MJ0mOvHlpcVoHUUmpPqSazu@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq3OOWklLB54TOswa5ri2aaTYqrl92st3oFVM/iLrsYHHS9Qlb
	+K3D588sVkWWOIjsZm1xBScYpG/P17yyb7KXi/wyUbG6V8mA2gOTHe0b
X-Gm-Gg: ASbGncuYnCcQXJ9yh2hVyShEPgOrptBZVaFVZ2D4W2CqvxvWyS3DGjd0KirNeYXfxr4
	OzkQKQoG+VLsUtq7QtrmWcRPSUkEDKcrOv9rv5w0iMUVa1wWYfXaOJQAWGmmLcgnKgLzVoeZ6l5
	g7seuWFode+WqIBBJa9a8CjNXHASWhKCoAPmqrbJ1h5retn9Al+e9g5wQNOnEtaAjbCMhUjIwJ5
	13iWxS8QV4YX59dXsPfIQsmHErI33rlgR85AiKZt7pjV3pnW8YXOEDKajn86exZAwWFmH5NzSyI
	fpPKZuf29gHiDoGtkSevNlYLXnf2GGoF5YufpFkcfG+qT9LQN3NxWUqHrKbQNInyvYpuHBLg
X-Google-Smtp-Source: AGHT+IFHeRcxQSMTbNXpG06x+OZzKAn2EkNpOt56sTXfJU5jYgLDUA6nd9u0Zgg7x0GzYnsoKeg+YA==
X-Received: by 2002:a5d:5887:0:b0:3b5:dd38:3523 with SMTP id ffacd0b85a97d-3c32c4345f5mr1745752f8f.8.1755692350610;
        Wed, 20 Aug 2025 05:19:10 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074d43bc6sm7501438f8f.25.2025.08.20.05.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 05:19:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 20 Aug 2025 14:19:08 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv6 perf/core 10/22] uprobes/x86: Add support to optimize
 uprobes
Message-ID: <aKW9PFYyTjCkkhF5@krava>
References: <20250720112133.244369-1-jolsa@kernel.org>
 <20250720112133.244369-11-jolsa@kernel.org>
 <20250725191318.554f2f3afe27584e03a0eaa2@kernel.org>
 <aIftAJg1hZGYp4NF@krava>
 <20250819191744.GN3289052@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819191744.GN3289052@noisy.programming.kicks-ass.net>

On Tue, Aug 19, 2025 at 09:17:44PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 28, 2025 at 11:34:56PM +0200, Jiri Olsa wrote:
> 
> > Peter, do you have more comments?
> 
> I'm not really a fan of this syscall is faster than exception stuff. Yes
> it is for current hardware, but I suspect much of this will be a
> maintenance burden 'soon'.
> 
> Anyway, I'll queue the patches tomorrow. I think the shadow stack thing
> wants fixing though. The rest we can prod at whenever.

ok, will send follow up

thanks,
jirka

