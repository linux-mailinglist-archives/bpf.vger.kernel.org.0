Return-Path: <bpf+bounces-16333-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839657FFE7A
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 23:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E33828106D
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 22:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C6061FC6;
	Thu, 30 Nov 2023 22:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdHCMXki"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECD910F3
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 14:30:33 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40b57fa7a85so8923745e9.1
        for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 14:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701383431; x=1701988231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L1pLcfBY3mKKdJkHFr3AN++OVfYnCm6E4OUlDi2s6OU=;
        b=hdHCMXki2J+2dgxLPSySHoZySedlQMCGZoFcdzKx9uvYLrPtWZO3o3whKk3Ri5ipPB
         HiCoWtcEqjXnVU+Znw39eeQW3BuuaF6K2Kz85jddC54PgWNSOaixSc+E/RvwrnWPfDvV
         yT/ZcEkAT7KZUwLyfCk8tmsVMSTwndqz3GlpUUcrTPXrVAdSku2AnM0pLMWwYtzDCGo1
         1LEPyfCjiLp1HVbqrp1u3vh6Nxmcw921cK0ssKGKRIwmSxuUOAtGxYWnBqWV7nl2IMUG
         nWbdnLOzmFamRanAzOYeUUwNdzkaICq2gXTc5IODlhNS4ZWiZZ0qtAa0SOuKjXFK0++y
         DkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701383431; x=1701988231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1pLcfBY3mKKdJkHFr3AN++OVfYnCm6E4OUlDi2s6OU=;
        b=S2+Z6XOLps/+BmXKga8s85IKBhkbR46aD54bCRJOk/kHK1Qgc0DvYz+eM2QrjfmYCN
         ksZ8mmaYdew2Q3VOzsszJBm1lWEk31kzXv/LR3i6p9dpvBEnR9Eo5m1+0q7ZAWHn48im
         izWERs5QV357dswhN0VOdaV3Rz4QhVj0H7x+b60+mdc6VaS/jMDKvxj4TW6PIodqcEnk
         MrUel1oXUw+5cZIq3VVogMg44FXaD0Abnusuhr1OQXx6eXz9JXmbBrsrSgHu4cuHmtNk
         bxB3iMmf1W1QNWQ868NnjOlwObUOOZfIYtREyA3lJ4vgZ+OCsnee9usxD9y3hyN5dkQF
         M1hg==
X-Gm-Message-State: AOJu0YwjulpWD6i4CzrXNAzDO3ALADF5rE0K3K2NuglZo2cDvqFTBAv4
	Ob3w32WonZEIYlYv37+f3wk=
X-Google-Smtp-Source: AGHT+IFOxmGO0lOLdZdrlJAjQwpQs4LXiL7tToge1X2chK/Rm3RTI1ygR+v8bCSeT5GgEJzizyQ+vg==
X-Received: by 2002:a05:600c:294c:b0:40b:5e4a:234e with SMTP id n12-20020a05600c294c00b0040b5e4a234emr93037wmd.80.1701383431254;
        Thu, 30 Nov 2023 14:30:31 -0800 (PST)
Received: from krava ([83.240.60.31])
        by smtp.gmail.com with ESMTPSA id t4-20020a05600001c400b00332cb0937f4sm2562468wrx.33.2023.11.30.14.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 14:30:31 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 30 Nov 2023 23:30:29 +0100
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Dmitrii Dolgov <9erthalion6@gmail.com>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	dan.carpenter@linaro.org
Subject: Re: [PATCH bpf-next v4 3/3] bpf, selftest/bpf: Fix re-attachment
 branch in bpf_tracing_prog_attach
Message-ID: <ZWkNBR-1RF8r4deG@krava>
References: <20231129195240.19091-1-9erthalion6@gmail.com>
 <20231129195240.19091-4-9erthalion6@gmail.com>
 <ZWim7zRLA-cgVQpr@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWim7zRLA-cgVQpr@krava>

On Thu, Nov 30, 2023 at 04:14:55PM +0100, Jiri Olsa wrote:
> On Wed, Nov 29, 2023 at 08:52:38PM +0100, Dmitrii Dolgov wrote:
> > It looks like there is an issue in bpf_tracing_prog_attach, in the
> > "prog->aux->dst_trampoline and tgt_prog is NULL" case. One can construct
> > a sequence of events when prog->aux->attach_btf will be NULL, and
> > bpf_trampoline_compute_key will fail.
> > 
> >     BUG: kernel NULL pointer dereference, address: 0000000000000058
> >     Call Trace:
> >      <TASK>
> >      ? __die+0x20/0x70
> >      ? page_fault_oops+0x15b/0x430
> >      ? fixup_exception+0x22/0x330
> >      ? exc_page_fault+0x6f/0x170
> >      ? asm_exc_page_fault+0x22/0x30
> >      ? bpf_tracing_prog_attach+0x279/0x560
> >      ? btf_obj_id+0x5/0x10
> >      bpf_tracing_prog_attach+0x439/0x560
> >      __sys_bpf+0x1cf4/0x2de0
> >      __x64_sys_bpf+0x1c/0x30
> >      do_syscall_64+0x41/0xf0
> >      entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > 
> > The issue seems to be not relevant to the previous changes with
> > recursive tracing prog attach, because the reproducing test doesn't
> > actually include recursive fentry attaching.
> > 
> > Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> > ---
> >  kernel/bpf/syscall.c                          |  4 +-
> >  .../bpf/prog_tests/recursive_attach.c         | 48 +++++++++++++++++++
> >  .../bpf/progs/fentry_recursive_target.c       | 11 +++++
> >  3 files changed, 62 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index a595d7a62dbc..e01a949dfed7 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3197,7 +3197,9 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
> >  			goto out_unlock;
> >  		}
> >  		btf_id = prog->aux->attach_btf_id;
> > -		key = bpf_trampoline_compute_key(NULL, prog->aux->attach_btf, btf_id);
> > +		if (prog->aux->attach_btf)
> > +			key = bpf_trampoline_compute_key(NULL, prog->aux->attach_btf,
> > +											 btf_id);
> >  	}
> 
> nice catch.. I'd think dst_trampoline would caught it, because the
> program is loaded with attach_prog_fd=x and check_attach_btf_id should
> create dst_trampoline.. hum

looks like we don't handle case like this one:

  1) load rawtp program
  2) load fentry program with rawtp as target_fd
  3) create tracing link for fentry program with target_fd = 0
  4) repeat 3

in 3 we will use prog->aux->dst_trampoline and prog->aux->dst_prog
(set from fentry loading) to attach the link, and then set both to NULL

in 4 we have:

  - prog->aux->dst_trampoline == NULL
  - tgt_prog == NULL (because we did not provide target_fd to link_create)
  - prog->aux->attach_btf == NULL (becase program was loaded with attach_prog_fd=X)

AFAICS we can't do anything here, because program was loaded for tgt_prog but we
have no way to find out which one.. so return -EINVAL, like in the patch below

jirka


---
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5e43ddd1b83f..558ce7bdd781 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3180,6 +3180,10 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	 *
 	 * - if prog->aux->dst_trampoline and tgt_prog is NULL, the program
 	 *   was detached and is going for re-attachment.
+	 *
+	 * - if prog->aux->dst_trampoline is NULL and tgt_prog and prog->aux->attach_btf
+	 *   are NULL, then program was already attached and user did not provide
+	 *   tgt_prog_fd so we have no way to find out or create trampoline
 	 */
 	if (!prog->aux->dst_trampoline && !tgt_prog) {
 		/*
@@ -3193,6 +3197,11 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 			err = -EINVAL;
 			goto out_unlock;
 		}
+		/* We can allow re-attach only if we have valid attach_btf. */
+		if (!prog->aux->attach_btf) {
+			err = -EINVAL;
+			goto out_unlock;
+		}
 		btf_id = prog->aux->attach_btf_id;
 		key = bpf_trampoline_compute_key(NULL, prog->aux->attach_btf, btf_id);
 	}

