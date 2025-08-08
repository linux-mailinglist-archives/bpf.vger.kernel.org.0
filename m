Return-Path: <bpf+bounces-65277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F010B1EDFE
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 19:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE3B3ACBDC
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 17:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D574E1E9B2D;
	Fri,  8 Aug 2025 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rv3DNxZu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14B676410;
	Fri,  8 Aug 2025 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754675077; cv=none; b=I4pdtTSOCkcKoJuVWCaHYf4DeCrfIYDLVsZleDjDIYL0D9MqYNIF1PldE75CeqOz9JyZJggKcF46hUpb4RAWwfVFxiwg5wM7smR/NsEhf/rj+7ABv5KqGEYq+muOEcaHbjPvw/qTzenh/mEi9BSE5HpAAMkkN0Ke0/lD4dmIQtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754675077; c=relaxed/simple;
	bh=s+LBECE+2LzYLSmkDOJlVd7/BbbnwCvUyReHbQDf/Fk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqltoji1ZIMQMdzKWMR16pwwKUXJZdBE0OkCT5KyOQYOAiwbp3kbU0ZpYhsgHrrKWEqAveibafATqZ7+CaifxxqGivFMMoqxvbFqXMpuPhHB3jyqx6S1nRmq14wDFSseb2IBemD5HbQfwDZbr00qQ4zhD8cEs7OZ5nS7AbH5YTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rv3DNxZu; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-af96524c5a9so334583866b.1;
        Fri, 08 Aug 2025 10:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754675074; x=1755279874; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3bf5nYdMvJMDEHtJmd0hkQpyGsljs8nCBx7SGOq0gFM=;
        b=Rv3DNxZuhILjZodS3jBgXh/WAnN++7pEsDhl1n1GKR3ngKhQ8l7Qz0+U8zDZI2Mhrd
         GT3XorkfBtjJ2iBcjDZvSrL/r5fzRnjpdg5Y9j9g0ag0A3KWWkqKilHw6YuL1RWRqWj8
         FLx24zq/QP52TFidudn9XZcpFRSTZxbUn8/LLFo5hGi/UupiKTp/z5aVg27IWytAkZiH
         iAbfX4mwhG71uH/ReQwli7FjC4Ctxli2mll6uYvt0jz33ecSbXp7AfjBkys3P1/GG2Fl
         PLyi1K2dir+b+f6Zl/iomKez/KKyPMMh029qEOXoygl4FFOAxlyr5an5bw8Wj63neBHX
         carw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754675074; x=1755279874;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bf5nYdMvJMDEHtJmd0hkQpyGsljs8nCBx7SGOq0gFM=;
        b=gTRSnM4f7I+Ht5HM3jxWF9tQ5nuSH2yBOXHS4Qxt4f9sSbMqpDFOindH4dcoevM8Lj
         qA4Zyg3VyZV3q4sAofbGI8w6AecOaif1wLugqIyS3/3n8Tk0d+LPV51oWeK+1z6z1eJM
         2MWuqKGW5qXNI3O4g6WmE3lISXlvuQWB/sLy4RWG8FmI65wPdILhoDoU7J91bygMX6jB
         KFT6TUiekr/e4VSyYZL39cNvuFurQq6pD7Vh0h+S5N/eTXYokDENU2x0RtB1+k74P1Ti
         Af/m+a5Fpt9+9+e5cZFpcukD4LF2CZ5IdEPCvyaNoTTmm2pk7RAkm0yTz9CDEBe/WD8p
         PNqw==
X-Forwarded-Encrypted: i=1; AJvYcCUyHGIUqPKT9VNogI3Schs+TWtOwFi/RuGM8jh4QIUucNBMymdw+qclcVTeejyRpvqyVIFfCfmheNWZB8oDJKg3eqTQ@vger.kernel.org, AJvYcCVYZuXzh+uNKAZsotY3m4zuYkYVm4zZXzH1A2USJyQjaYYd83KwUpE4FSVsat+Z2xPH4r6d9y1h2kJsMzyO@vger.kernel.org, AJvYcCVvLoN32KUYCHRAmVmN2sWRaUUHyt72V8OQEUDnWTQDLh2vmukHjxIUjsIKr+qfcVzRac0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQB8PnfJU/o1Zl2T0TjIakN0lXGNRXbrfNjqCgKVuTeyVLuF2P
	enhW+ksibUKCyScjk61PgqjsnjbSUm/LgXOQrLYlDlJv9+PIXa5bvjju
X-Gm-Gg: ASbGnctwXhCORcRakM9Wl+97F7GbsXr7EX82yXSnmg/wRx67REgnSmYXIrQGOSrVwRH
	I8a1h8sODsysozcDTtJhgROBS3Vs0Sp62h1SFQt91clv8/qlHcVIKAMOITU5fv8w6zNbwulJnuA
	tldKJWqyMiodQ8YIgiHWNAvRNJ1qKjimrG3TcgEz8uuS7Ws1vWm7nLEGKl26PQSvT+sqCH3jEr+
	JdGKi/pUfFmY+HMh1hU2Wv0qB20xtznJ6CrA1NdVtusmZtEG1SERcg8JEh/ijTRMngDZyAco2rl
	OnGHG8zoHEpZuyaGxCfhPKG1SuuyA9Jj5TXHKhYEokvGTuQvydVoNV38Dk/gPNwSbNX3r+g/mV2
	8dzEx5LAinF322A==
X-Google-Smtp-Source: AGHT+IEdQTZfGPAfeBpMEHztO58s9jOjbs9/AN6r5ls0Ur7sxq/Pp19NE99l/pTadKgrKQ13wTytEA==
X-Received: by 2002:a17:906:f59f:b0:af9:1be8:c2aa with SMTP id a640c23a62f3a-af9c6506ab9mr365820666b.45.1754675073582;
        Fri, 08 Aug 2025 10:44:33 -0700 (PDT)
Received: from krava ([2a00:102a:406f:c1c4:19f6:67fa:c879:8862])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a076aecsm1518238066b.9.2025.08.08.10.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 10:44:33 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 8 Aug 2025 19:44:29 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Jiri Olsa <olsajiri@gmail.com>,
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
Message-ID: <aJY3fXqnD7MkxDMm@krava>
References: <20250720112133.244369-1-jolsa@kernel.org>
 <20250720112133.244369-11-jolsa@kernel.org>
 <20250725191318.554f2f3afe27584e03a0eaa2@kernel.org>
 <aIftAJg1hZGYp4NF@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIftAJg1hZGYp4NF@krava>

ping, thanks

On Mon, Jul 28, 2025 at 11:34:56PM +0200, Jiri Olsa wrote:
> On Fri, Jul 25, 2025 at 07:13:18PM +0900, Masami Hiramatsu wrote:
> > On Sun, 20 Jul 2025 13:21:20 +0200
> > Jiri Olsa <jolsa@kernel.org> wrote:
> > 
> > > Putting together all the previously added pieces to support optimized
> > > uprobes on top of 5-byte nop instruction.
> > > 
> > > The current uprobe execution goes through following:
> > > 
> > >   - installs breakpoint instruction over original instruction
> > >   - exception handler hit and calls related uprobe consumers
> > >   - and either simulates original instruction or does out of line single step
> > >     execution of it
> > >   - returns to user space
> > > 
> > > The optimized uprobe path does following:
> > > 
> > >   - checks the original instruction is 5-byte nop (plus other checks)
> > >   - adds (or uses existing) user space trampoline with uprobe syscall
> > >   - overwrites original instruction (5-byte nop) with call to user space
> > >     trampoline
> > >   - the user space trampoline executes uprobe syscall that calls related uprobe
> > >     consumers
> > >   - trampoline returns back to next instruction
> > > 
> > > This approach won't speed up all uprobes as it's limited to using nop5 as
> > > original instruction, but we plan to use nop5 as USDT probe instruction
> > > (which currently uses single byte nop) and speed up the USDT probes.
> > > 
> > > The arch_uprobe_optimize triggers the uprobe optimization and is called after
> > > first uprobe hit. I originally had it called on uprobe installation but then
> > > it clashed with elf loader, because the user space trampoline was added in a
> > > place where loader might need to put elf segments, so I decided to do it after
> > > first uprobe hit when loading is done.
> > > 
> > > The uprobe is un-optimized in arch specific set_orig_insn call.
> > > 
> > > The instruction overwrite is x86 arch specific and needs to go through 3 updates:
> > > (on top of nop5 instruction)
> > > 
> > >   - write int3 into 1st byte
> > >   - write last 4 bytes of the call instruction
> > >   - update the call instruction opcode
> > > 
> > > And cleanup goes though similar reverse stages:
> > > 
> > >   - overwrite call opcode with breakpoint (int3)
> > >   - write last 4 bytes of the nop5 instruction
> > >   - write the nop5 first instruction byte
> > > 
> > > We do not unmap and release uprobe trampoline when it's no longer needed,
> > > because there's no easy way to make sure none of the threads is still
> > > inside the trampoline. But we do not waste memory, because there's just
> > > single page for all the uprobe trampoline mappings.
> > > 
> > > We do waste frame on page mapping for every 4GB by keeping the uprobe
> > > trampoline page mapped, but that seems ok.
> > > 
> > > We take the benefit from the fact that set_swbp and set_orig_insn are
> > > called under mmap_write_lock(mm), so we can use the current instruction
> > > as the state the uprobe is in - nop5/breakpoint/call trampoline -
> > > and decide the needed action (optimize/un-optimize) based on that.
> > > 
> > > Attaching the speed up from benchs/run_bench_uprobes.sh script:
> > > 
> > > current:
> > >         usermode-count :  152.604 ± 0.044M/s
> > >         syscall-count  :   13.359 ± 0.042M/s
> > > -->     uprobe-nop     :    3.229 ± 0.002M/s
> > >         uprobe-push    :    3.086 ± 0.004M/s
> > >         uprobe-ret     :    1.114 ± 0.004M/s
> > >         uprobe-nop5    :    1.121 ± 0.005M/s
> > >         uretprobe-nop  :    2.145 ± 0.002M/s
> > >         uretprobe-push :    2.070 ± 0.001M/s
> > >         uretprobe-ret  :    0.931 ± 0.001M/s
> > >         uretprobe-nop5 :    0.957 ± 0.001M/s
> > > 
> > > after the change:
> > >         usermode-count :  152.448 ± 0.244M/s
> > >         syscall-count  :   14.321 ± 0.059M/s
> > >         uprobe-nop     :    3.148 ± 0.007M/s
> > >         uprobe-push    :    2.976 ± 0.004M/s
> > >         uprobe-ret     :    1.068 ± 0.003M/s
> > > -->     uprobe-nop5    :    7.038 ± 0.007M/s
> > >         uretprobe-nop  :    2.109 ± 0.004M/s
> > >         uretprobe-push :    2.035 ± 0.001M/s
> > >         uretprobe-ret  :    0.908 ± 0.001M/s
> > >         uretprobe-nop5 :    3.377 ± 0.009M/s
> > > 
> > > I see bit more speed up on Intel (above) compared to AMD. The big nop5
> > > speed up is partly due to emulating nop5 and partly due to optimization.
> > > 
> > > The key speed up we do this for is the USDT switch from nop to nop5:
> > >         uprobe-nop     :    3.148 ± 0.007M/s
> > >         uprobe-nop5    :    7.038 ± 0.007M/s
> > > 
> > 
> > This also looks good to me.
> > 
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> thanks!
> 
> Peter, do you have more comments?
> 
> thanks,
> jirka

