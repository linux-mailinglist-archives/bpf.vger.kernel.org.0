Return-Path: <bpf+bounces-50307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 340EDA24FFE
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 21:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82D518841A0
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 20:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445D42147E7;
	Sun,  2 Feb 2025 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g30oAvrh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310232AEF5;
	Sun,  2 Feb 2025 20:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738529509; cv=none; b=L3Qd74hDTpfUA6YiCuUxF7xdcYL5+x+ey2rYz89emhpY/CaBO5hgIqmPJarD40d+AHPeKbKNjYja0lXaSDStAAZ5QatetfTKJ67ngjkeCYdgxFjRrf6MAZS7cds/L1a7gt6VAU2tlp+YsyNZY96/L5ANKsXu8jZIPBLjIwY9uFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738529509; c=relaxed/simple;
	bh=lnB5myVrLcTIRNRx1VnpyasSN/I2UAAG/Su6XEQPbTY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdKKeK6v1BvZXF+IJI06pJZulIYREEXdayn6XKGmLuIeuVbfvz/1o9h7JCB5rEL9rGpK4268D77/JyXiXqCy3AYHF8xkvKBnePrhtVRy8SOIWuPo7H6shYcrRAZ9pESgllkz7LmVUjBAMwXZzzqMGjpR9lo/W2JWWHwrqSkDJcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g30oAvrh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4361f796586so42989525e9.3;
        Sun, 02 Feb 2025 12:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738529506; x=1739134306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9B4xUyH/GM9ZtDsfhVZI5rX/jOFgm/UURyHYF/tgiFE=;
        b=g30oAvrh0v3tlENz0UZiJWfN4NWyn95nw7KAnx10yOQLSJwno/ANjFAMZBVOZe0+gt
         +GaDySc3N5hg+P5JhpgrIX8CjdVZX4WOVx3zV9aaqVbrZSLI9sbXf5rRNNnkNHwxml3v
         k3q5tc80Zk7NC/bm0/YIaPAZzg8WULM4aa0yPSXvncwHBWQRUQPUWD/FvERxW4Yq5Pdp
         LzI7DK9qTpZBYq8tjAdyqugqbm0IYxujbTMHZUdsUSedREpcNvuUml4BpMxKXI0UTZgr
         H6r7BvlCPz7Z6Y/IvHLgiOyZl0QNnCerkU4gvv7fttroyGAxGQaAxzWRfgK2lslIljmP
         Ouug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738529506; x=1739134306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9B4xUyH/GM9ZtDsfhVZI5rX/jOFgm/UURyHYF/tgiFE=;
        b=ST+gjXkp5v+DdasKX53K0PAO4OaJDLx1me+rNF2a/8f/ThMnTBxeX6HiU+ScFWH2mh
         v8FuT7Fe05vUVH8/IYQCKY3exeGZtCdoysm2w3TY6OrFE/URMkQN8cZz5f7WGLkZIFbz
         sh9IQyzp0UR38Vt04UcTsnx55ENiZ2OY3kG6ifi4DHFBBakS7umTmOfxqSNTEl5fVpjQ
         /orakBrqgrqgTgKqTAoTK0u6OyeGNAVawAYerjV23BYQaaGxiYc5iYeuc9sanc3+Lvrk
         xMI5TeZCKahu/KJZcXH2xFf+aih2vy0A7u14df+BRmYJBWjSKVK9JIbFNOZbPAbCocxg
         ++Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUwZErNirj+2QKJNcgJubr9un57qSABxJFdXdPfMCJY3DnsyNfLIo9FLiyJAnuIgWJ+CMJELwzMv67RUA53Pq/W7fry@vger.kernel.org, AJvYcCVqP+gzV+guW7NEY6F8I6NZSozWXpm27SK1GLtAj9bMirtyUjzTpMdcG/S5UyWjFC7iN/PkJKNc/HInhGTT@vger.kernel.org, AJvYcCWjyNlqy9PlwP69vQ6bKZtBFBCv0WiM+FLr7ZTQyV8sWuTjxWkFh9JGpUyUQbaSRAmqDV0=@vger.kernel.org, AJvYcCXIUy6/pMyiNBpa+3FfgC89zdu/gYAIDT/sMMafHipPxJ7yZfqgPQCSwvvcIcOnWCwts0AIfrQ6jgcm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1TKa8yWQ9kcy6FBjMF2ONgruPLEE/0/QLbGOQjn6wTLDA4Wao
	5Ia4YGJaYREhlnn9ElzirceSpVv2bonqgv21QIp0mO2N+bkogL3AWHTmhy+/Bbw=
X-Gm-Gg: ASbGncvU0Vga5eYt9CxrOX/qhkUSpg5i6egQZQ3Je/mS4zkGmX4AKJ7GBuhs06Ll3b6
	b8QzUwiutZasbwOG0fdP9wOPSzQkD5jUePICZw1+xf5l8/QoMtUT0ZzhjlSjogkf/4+NfwjnyoJ
	ELwun10BhFmYNlbUVLt54h8y1TyI/A6u7PglhC/835aXQWx4AVdYZhajeLLak4ke7kthXkg6gFd
	Ia+A4QcWV96W+F/C9JeH7FZ/TyyBln0Z/mCAcbqk0DgGI03L2rKnT4APtYt+t6aahQz+GRUih7Q
	5ZOtn7F4Ippsr/PIZwWo/tXFxMhnve6+hq+ATsN48WFWQOcw
X-Google-Smtp-Source: AGHT+IFjWz65PWK3SQfKwyxv2oDDgUkvBKIfZuV8OxxMy32OA4i5Dbf4ud1G0/rV4VvDGbW9fNcPUw==
X-Received: by 2002:a05:600c:4fc1:b0:436:1ac2:1acf with SMTP id 5b1f17b1804b1-438dc40d55emr173427055e9.20.1738529506182;
        Sun, 02 Feb 2025 12:51:46 -0800 (PST)
Received: from krava (213.11-246-81.adsl-static.isp.belgacom.be. [81.246.11.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c139bafsm10984286f8f.58.2025.02.02.12.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 12:51:45 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 2 Feb 2025 21:51:43 +0100
To: Eyal Birger <eyal.birger@gmail.com>
Cc: kees@kernel.org, luto@amacapital.net, wad@chromium.org, oleg@redhat.com,
	mhiramat@kernel.org, andrii@kernel.org,
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
	daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org, linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] selftests/seccomp: validate uretprobe syscall
 passes through seccomp
Message-ID: <Z5_a33NQwrVC9n3r@krava>
References: <20250202162921.335813-1-eyal.birger@gmail.com>
 <20250202162921.335813-3-eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250202162921.335813-3-eyal.birger@gmail.com>

On Sun, Feb 02, 2025 at 08:29:21AM -0800, Eyal Birger wrote:

SNIP

> +TEST_F(URETPROBE, uretprobe_default_block)
> +{
> +	struct sock_filter filter[] = {
> +		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
> +			offsetof(struct seccomp_data, nr)),
> +		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_exit_group, 1, 0),
> +		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL),
> +		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
> +	};
> +	struct sock_fprog prog = {
> +		.len = (unsigned short)ARRAY_SIZE(filter),
> +		.filter = filter,
> +	};
> +
> +	ASSERT_EQ(0, run_probed_with_filter(&prog));
> +}
> +
> +TEST_F(URETPROBE, uretprobe_block_uretprobe_syscall)
> +{
> +	struct sock_filter filter[] = {
> +		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
> +			offsetof(struct seccomp_data, nr)),
> +#ifdef __NR_uretprobe
> +		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_uretprobe, 0, 1),
> +#endif

does it make sense to run these tests on archs without __NR_uretprobe ?

jirka

> +		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL),
> +		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
> +	};
> +	struct sock_fprog prog = {
> +		.len = (unsigned short)ARRAY_SIZE(filter),
> +		.filter = filter,
> +	};
> +
> +	ASSERT_EQ(0, run_probed_with_filter(&prog));
> +}
> +
> +TEST_F(URETPROBE, uretprobe_default_block_with_uretprobe_syscall)
> +{
> +	struct sock_filter filter[] = {
> +		BPF_STMT(BPF_LD|BPF_W|BPF_ABS,
> +			offsetof(struct seccomp_data, nr)),
> +#ifdef __NR_uretprobe
> +		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_uretprobe, 2, 0),
> +#endif
> +		BPF_JUMP(BPF_JMP|BPF_JEQ|BPF_K, __NR_exit_group, 1, 0),
> +		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_KILL),
> +		BPF_STMT(BPF_RET|BPF_K, SECCOMP_RET_ALLOW),
> +	};
> +	struct sock_fprog prog = {
> +		.len = (unsigned short)ARRAY_SIZE(filter),
> +		.filter = filter,
> +	};
> +
> +	ASSERT_EQ(0, run_probed_with_filter(&prog));
> +}
> +
>  /*
>   * TODO:
>   * - expand NNP testing
> -- 
> 2.43.0
> 

