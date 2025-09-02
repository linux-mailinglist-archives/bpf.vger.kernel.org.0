Return-Path: <bpf+bounces-67232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A57B40FF3
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 00:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23EE65E2E61
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 22:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E71275AFA;
	Tue,  2 Sep 2025 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJtXFWcf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8117623D7ED
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 22:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756851671; cv=none; b=IaL5f2W+MuCNvmnXSfitXAij9NarByRqMTRmZDxGpWEQOk0I1nI5wg6IrAmPlhp6COy4sLTt5UclkFjKdZmlgSMTuUQSK+klbOVgAO6pX0tqN0UVRcNbbaZswB3nhW5k9rh8JR77y7USI/V9XVU2kLzimfaggnxJbQUaGQi160k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756851671; c=relaxed/simple;
	bh=OvAj/Oemb997fnFjRSfudQFn277bbgZlk67Klm4TPDE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nrv8EEKUQchRL3o+G4fHdkuJ6tQHPMD3jt6KwLILgS5OZSg1+c40oSmoMpLB5K8mDyOI4otgfid5vQbikrnbZfLEI99FmD2oXkOa0vxzjjBwA1cMT+qXRdb0DiSIkVaY8oNyYwAV5AJT2fRe9mpR437bj+R5rV9yELXHul+21js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJtXFWcf; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77250e45d36so2254870b3a.0
        for <bpf@vger.kernel.org>; Tue, 02 Sep 2025 15:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756851670; x=1757456470; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjW9I1fumeeimP/vzGQ/5tGrn7+6zjAbPdS9bJrXgqE=;
        b=dJtXFWcfLho2f8a8fjin4t6i9U3/NEHOMabrKSldEuK7CopyJJchGqsWsmYBadxCpf
         oIKATbagt8v2N7LBtWad/Tnldyiq35UaI9GAXOPfBiwxXNviwi+m/EtkbBDRMr2CDVmQ
         uwFRiGiWmDy8dBaRAV6vM3YEmTUtz8Halc/SjdUNv3qipj+U6L2c1/M1fKkEL0IRQjP7
         UBZIcuvDLpfepHfN3Sg9r4TRnQQhZhcGYD+zi9RVyVIDSjAsaAL0PhIPxiVVW5u0Fee/
         tARxyLTiZdxSjNPBqQOUIfKhqD/LixmxtfhjdCkGDNGUdpqGLzSBhFVgGaYF2MajJNOh
         kx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756851670; x=1757456470;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YjW9I1fumeeimP/vzGQ/5tGrn7+6zjAbPdS9bJrXgqE=;
        b=Wtn7vtuGKoc5HqX9FE1PznqcO/TK59BrTkxuQX0793gQVuc0cXqFzO8axtafdmo7E/
         ZVIF9OS9ZVgnonGGVFx2MKIKW4oPx3EA7y3AV4JV3sMwOcdaZPVurlQbrBMxQrGAdu/P
         LB+ZKm02aUg7hvh0PzAJ8SGXAXPrC3lYJp9IjGaSjEt96fMBaDwNkARjdOeIuVQ6lVsM
         nZbBKub6WXfoQaI4kxUooLYEevJbhZdnACsq6hn/kIpmOZeYcHl/S27g8GJBUGu+mHJQ
         SC2nyFBGjN6t01/OO7ZZ8YIENGDXZJ3boAkElNVGqot+M7WSS/Y/J0PcjW2AkoB/Na4s
         YAag==
X-Forwarded-Encrypted: i=1; AJvYcCXLu8AjJzO6/0pCAOY1sAxIetYJXuytCP465BgtP4ro9Q6nF5oz/jExfHCAGMNe/T5v550=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywig6zHZoolP5bzUQ31keZEWWfbZeav86Ww1C1p6s9teiwZTcRw
	zWt83lxWuquxT48JJJUF24+J8olfK8TxBU4rIqnCX8JEA5Sx/WV8oCaZ
X-Gm-Gg: ASbGncv6c2rxrKBJrgezeoH2hNXkdcOLN0BJ20xoh3Ej0IRMV1KW6otLUSZsX+CU8Gg
	4j+yEsxR3jNuarC1omZTC5NWDv48HsIfGAHDOCMyKIYlJQO+/WQCra3S/F87JWQCiAIuUDwwFsX
	pG3FVm9hqyGs41lrOkj4Fh4wJcm7vxQpFAC4JbraEEgoWy+4c1IpneMQ9N/AA0XzEKjicBeky+X
	lAXMmNDzSod57ybCz/9kNb02r4dQnk/ZQ2P28JSmMNHSnE1N0181HOLM4ziONxVEX2O0Wf2z/lY
	ofbgeZoAYtcaXhCiChh60+WYHZy1RnZ3voJ9dLRBrxCHlnZ9BKYKc8B2Hz/dAmCVeM2ABUpnZUp
	q39l60+2xkSjlr6LpeQKQD3zYCRK0KzxUJnnzzAl7MHppyVMPGG5Su5LDkeQrAxcLaknCgQ==
X-Google-Smtp-Source: AGHT+IH2p7yl86kPRg7049kiVE9NDd6IfNALTmpAUFMXq9Q1+AyyifTFJLTs+9/fJyKk//CvqQP9jg==
X-Received: by 2002:a05:6a20:1595:b0:243:beb8:1f41 with SMTP id adf61e73a8af0-243d6ddae6fmr17431465637.1.1756851669641;
        Tue, 02 Sep 2025 15:21:09 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:8bb9:7ccc:ab52:ac92? ([2620:10d:c090:500::6:ea99])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4fa1a29cedsm760609a12.46.2025.09.02.15.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 15:21:09 -0700 (PDT)
Message-ID: <3105c65cd99c483ecb4eb63d590fcec9601891bd.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 4/4] selftests/bpf: Add tests for arena
 fault reporting
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon	 <will@kernel.org>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, 	bpf@vger.kernel.org
Date: Tue, 02 Sep 2025 15:21:07 -0700
In-Reply-To: <20250901193730.43543-5-puranjay@kernel.org>
References: <20250901193730.43543-1-puranjay@kernel.org>
	 <20250901193730.43543-5-puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-01 at 19:37 +0000, Puranjay Mohan wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/test=
ing/selftests/bpf/prog_tests/stream.c
> index 9d0e5d93edee7..b2a85364e3c4f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/stream.c
> +++ b/tools/testing/selftests/bpf/prog_tests/stream.c
> @@ -41,6 +41,22 @@ struct {
>  		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
>  		"|[ \t]+[^\n]+\n)*",
>  	},
> +	{
> +		offsetof(struct stream, progs.stream_arena_read_fault),
> +		"ERROR: Arena READ access at unmapped address 0x.*\n"
> +		"CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
> +		"Call trace:\n"
> +		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
> +		"|[ \t]+[^\n]+\n)*",
> +	},
> +	{
> +		offsetof(struct stream, progs.stream_arena_write_fault),
> +		"ERROR: Arena WRITE access at unmapped address 0x.*\n"
> +		"CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
> +		"Call trace:\n"
> +		"([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
> +		"|[ \t]+[^\n]+\n)*",
> +	},

I commented when prog_tests/stream.c was first introduced but it was
decided to postpone the change back then.
It would be nice to have the above expressed in terms similar to
bpf_misc.h:__msg() macro. E.g. name it __bpf_{stdout,stderr} and
have something like this in the progs/stream.c:

  SEC("syscall")
  __success __retval(0)
  __bpf_stderr("ERROR: Arena WRITE access at unmapped address 0x{{.*}}")
  __bpf_stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
  ...
  int stream_arena_write_fault(void *ctx)
  {
	...
  }

Now that more tests are added, what do you think about such extension?

>  };
> =20
>  static int match_regex(const char *pattern, const char *string)

[...]

