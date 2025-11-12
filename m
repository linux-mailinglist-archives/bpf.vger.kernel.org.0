Return-Path: <bpf+bounces-74293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 837BCC5287B
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 14:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8FDDC4F6DB4
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 13:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C9433891B;
	Wed, 12 Nov 2025 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHQrqU+G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BFE335574
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 13:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954551; cv=none; b=gYI7t6XxneifWTVeJ4+aHFLr0OWWfe6iHo2m1INxSdyAAhMsAztpKVOdB5nK3rt/nrHul2Pttl1/Ftfaf4nYVwnE9rP650+3IzTDoxwTsnWCYbv6eajvfrAZaLqmY3WnfUHjnoW0djVd3HV453NWLMrsScpns1lZ+u8dnaCPi/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954551; c=relaxed/simple;
	bh=/Brd79tWNwS4wv+IDvBNr6c5hIBAjx2K749TKeHBGs0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YLfHvwM+uLXE/XKsPbQKDXR3XsCmPGz1Klp05ND4JY+cFEiUZZsgBC0lJxrr2YtBHBzCiWnD3TrEGQtMR4URViBROWtX4UrxZ2OIl4yA6mpg9uT3rYaM5F2t3PQ5pxuaDZvI87xCzQhFqFoT1u8QIp3q/BG2w96i+2nrPv58NUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHQrqU+G; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b38693c4dso400218f8f.3
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 05:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762954548; x=1763559348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7H7Z174BA0f5baKU5PBBRs+kyychkUp/6tsJBIR6AU=;
        b=gHQrqU+GB+1WCPxfWAjOWxTmc/xGbZsb7W1E19zX8/vKqE3F4lXR0/imNKquQ7ZJdu
         cqbSTYkwPy9X21CVf6aPsNiD+ljLWidKxbOoApxEjgp94H1ZKHNZUwItBJ5qDX6X+X+7
         j8ONQhvF/ctX1lTg28jDlmWiGRk2CwrEohztVHV9s0yDAayNbpXZW3k+IsuegCtK67KR
         SnQjPSufrXoadKYpmxtHp3lGnQdfYCWsrwQaDKj8YDTy+VRpiXC3HS/JVHq2H9tf/bOR
         lrOr8shVHLiz9AhmMOtmt9VG7q30eTM9p4+LmeyS9ZviyZm0P6QAHHHplrIOaYN4Kn9Q
         YujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762954548; x=1763559348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y7H7Z174BA0f5baKU5PBBRs+kyychkUp/6tsJBIR6AU=;
        b=CAoOk1gQwzlrjZjNQObiT5ceMiAz6zpf7zNI1dYgRRs/tYnqGeTaG0r8x96/X+ikxB
         NdAduCdOx69TqQTGzrM8bS6qKAM6d/UZOLNztKs9ZTCKAvVz2qdKTTtij2UM3+2nMIib
         uJaRKVyG+MlJci8lY+5/Q45fdq3FJAvucKDunoRw0uKysb3VQRCs/N78VE8FJ+r5pj34
         K+kINA1rAMYgrw425MJgVa0HSiO/tTTLF/Oy4R/8J8EUDykH9Xlp8FEY+KOqoWl/ARo4
         wRW37ocM+P46w12iz6mzy/BrskfhXPDCgAeN4OiTbiiLe1V8yfWzpq7IrfhLfUYnhMPr
         IpIw==
X-Forwarded-Encrypted: i=1; AJvYcCXGgT7mi0fJVaLQbWpKPIHofot0NJO78106vcxRJiBbvIMbGI+8BHkEcE9kKj2VZjQlwtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7MVXF/YlBsH9APypCsquTCNnpXEsyi2tTsDt0IYfAiiowuw/Y
	Y62mVPAlI3j7YbC1JZ6mHn1lCaBkcTCoxKGh4LWar2lqbzkXhqZJEp7V
X-Gm-Gg: ASbGnctv3ia/fdFDsKGK+MV2n+08FjtC0Ah/hCRyUsqGas3CdkNu/TzpeGydNDMIVuA
	AbmOqJ0LZyu4GIXUKBEYXmSvky4bS46mn1aLcFVvuEOucVQq81c1BfzuzKUm2u2/28q20zKDwXr
	M57lZnMBOfOph2kFnwUO/mqfUA/sLTh0BsNUWE13KR+A4Qtxfkqr2RQhuPE/ReLp6mkl9yrtl+/
	TF3GojnOOvAKWV4iSLw2wQxGCsXI6MNaOTCAfjCCtK5QWYtOPsHPBszxhkYYG+0syPkZJaD7M64
	6g55TPlfNsmmLMy0zQ4u/XufrirSMHXoxHcn5CuUWdzf62SuGcm9VOQgSyQp52XS7bsfTD+HbHO
	WfQvp2DYBGm1P7Dxw7Id43ojEkLrT8zo/6oj/ANH4D8QTR0NAvX6l2obet2GvSK65tOm8Tsc0wi
	3omTKVHhy6902AZ17wJdnozHJpC+N5ZGIjBM26XSoGcA==
X-Google-Smtp-Source: AGHT+IFsPr91yEVktw+9zOEmqEeRPgSJYJvxvCq62TCHBnCk09rlnxT7KPaqnY3oHV1wY+8b0MIIfA==
X-Received: by 2002:a05:6000:1a8d:b0:42b:3592:1b92 with SMTP id ffacd0b85a97d-42b4bdb8eefmr2538034f8f.47.1762954548135;
        Wed, 12 Nov 2025 05:35:48 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b30dd4d86sm25445445f8f.26.2025.11.12.05.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 05:35:47 -0800 (PST)
Date: Wed, 12 Nov 2025 13:35:46 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Brahmajit Das <listout@listout.xyz>
Cc: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 contact@arnaud-lcm.com, daniel@iogearbox.net, eddyz87@gmail.com,
 haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
 kpsingh@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, sdf@fomichev.me, song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v3] bpf: Clamp trace length in __bpf_get_stack
 to fix OOB write
Message-ID: <20251112133546.4246533f@pumpkin>
In-Reply-To: <20251111081254.25532-1-listout@listout.xyz>
References: <691231dc.a70a0220.22f260.0101.GAE@google.com>
	<20251111081254.25532-1-listout@listout.xyz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 13:42:54 +0530
Brahmajit Das <listout@listout.xyz> wrote:

> syzbot reported a stack-out-of-bounds write in __bpf_get_stack()
> triggered via bpf_get_stack() when capturing a kernel stack trace.
> 
> After the recent refactor that introduced stack_map_calculate_max_depth(),
> the code in stack_map_get_build_id_offset() (and related helpers) stopped
> clamping the number of trace entries (`trace_nr`) to the number of elements
> that fit into the stack map value (`num_elem`).
> 
> As a result, if the captured stack contained more frames than the map value
> can hold, the subsequent memcpy() would write past the end of the buffer,
> triggering a KASAN report like:
> 
>     BUG: KASAN: stack-out-of-bounds in __bpf_get_stack+0x...
>     Write of size N at addr ... by task syz-executor...
> 
> Restore the missing clamp by limiting `trace_nr` to `num_elem` before
> computing the copy length. This mirrors the pre-refactor logic and ensures
> we never copy more bytes than the destination buffer can hold.
> 
> No functional change intended beyond reintroducing the missing bound check.
> 
> Reported-by: syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
> Fixes: e17d62fedd10 ("bpf: Refactor stack map trace depth calculation into helper function")
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---
> Changes in v3:
> Revert back to num_elem based logic for setting trace_nr. This was
> suggested by bpf-ci bot, mainly pointing out the chances of underflow
> when  max_depth < skip.
> 
> Quoting the bot's reply:
> The stack_map_calculate_max_depth() function can return a value less than
> skip when sysctl_perf_event_max_stack is lowered below the skip value:
> 
>     max_depth = size / elem_size;
>     max_depth += skip;
>     if (max_depth > curr_sysctl_max_stack)
>         return curr_sysctl_max_stack;
> 
> If sysctl_perf_event_max_stack = 10 and skip = 20, this returns 10.
> 
> Then max_depth - skip = 10 - 20 underflows to 4294967286 (u32 wraps),
> causing min_t() to not limit trace_nr at all. This means the original OOB
> write is not fixed in cases where skip > max_depth.
> 
> With the default sysctl_perf_event_max_stack = 127 and skip up to 255, this
> scenario is reachable even without admin changing sysctls.
> 
> Changes in v2:
> - Use max_depth instead of num_elem logic, this logic is similar to what
> we are already using __bpf_get_stackid
> Link: https://lore.kernel.org/all/20251111003721.7629-1-listout@listout.xyz/
> 
> Changes in v1:
> - RFC patch that restores the number of trace entries by setting
> trace_nr to trace_nr or num_elem based on whichever is the smallest.
> Link: https://lore.kernel.org/all/20251110211640.963-1-listout@listout.xyz/
> ---
>  kernel/bpf/stackmap.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 2365541c81dd..cef79d9517ab 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -426,7 +426,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>  			    struct perf_callchain_entry *trace_in,
>  			    void *buf, u32 size, u64 flags, bool may_fault)
>  {
> -	u32 trace_nr, copy_len, elem_size, max_depth;
> +	u32 trace_nr, copy_len, elem_size, num_elem, max_depth;
>  	bool user_build_id = flags & BPF_F_USER_BUILD_ID;
>  	bool crosstask = task && task != current;
>  	u32 skip = flags & BPF_F_SKIP_FIELD_MASK;
> @@ -480,6 +480,8 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>  	}
>  
>  	trace_nr = trace->nr - skip;
> +	num_elem = size / elem_size;
> +	trace_nr = min_t(u32, trace_nr, num_elem);

Please can we have no unnecessary min_t().
You wouldn't write:
	x = (u32)a < (u32)b ? (u32)a : (u32)b;

    David
 
>  	copy_len = trace_nr * elem_size;
>  
>  	ips = trace->ip + skip;


