Return-Path: <bpf+bounces-54601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89178A6D60A
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 09:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3253AEA9E
	for <lists+bpf@lfdr.de>; Mon, 24 Mar 2025 08:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD4E25D206;
	Mon, 24 Mar 2025 08:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TYYnAoTn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5207E25D1FA
	for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742804432; cv=none; b=m1GHku/5JTYzwtoBBjDuv2BOkZKeespy/qmdAX9W06nGglCU/lkjATXRprdzn2ttoUq09a2K8g2ExEcZehhcuhUAx9GWUpZzGrGP70cHieUeq8WZJImt6u0HuWCjSS2Ry6wIhzZWVmUjRjhetpfCOSP8EnxAdZV2yxCFoTs7khM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742804432; c=relaxed/simple;
	bh=bvJLWrUebpGV6FDtNE0QGcbeP26Bs8OHf+Yq+BDE/5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ronx7q2PFKOOz1XLGyHGRLnsa8Bx2LvN7xzOqPgFJDY5B/DV7dHe5ISWZiR2iZfcxNl+NaV3aCMJGnBNfGEwjYNrwSjRMNJdlQ2xSjOWAKZzh5TeOQPyT5jJkldKqpPZXs3/rO1Z563870Ry5zuC6a0e9HUf2YmKrE5RfaxGlGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TYYnAoTn; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-476af5479feso38325131cf.2
        for <bpf@vger.kernel.org>; Mon, 24 Mar 2025 01:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742804430; x=1743409230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIX6vnpb6jg1VF+cazhNY7gMi3sGru+8oXiV5dHUNp4=;
        b=TYYnAoTnYw+rcP+qrCM46XqbkFecl+Za+eFe7UOWVLxaKm2JWw0N/dukDPoxscvLcE
         SGDcz70X5XuSgQoKooMQ+C850mWZ+towohuBZ1NoqnkDmg5CxnVCL4DtQPeXNFcjfRmp
         /6cw3Frn1b88FleBxlz/CfygjUagU6i+oWVbsVsBodDY/ZdAjly+7laQE2kaFe5qU55R
         ZM6wMHRJ1nwMVUP7su6M+0bM61DyXh3MiacTq9CD0eRUBQurrCbN8/qu+gkWFh/d9eOH
         iHWjaAhK1WygVYcJdswu43kT1C6UtNBuINE4cCNf7qr9ztO2KQWuS/A2gPSGt06qhg6T
         GYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742804430; x=1743409230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIX6vnpb6jg1VF+cazhNY7gMi3sGru+8oXiV5dHUNp4=;
        b=FIoE70EWR9f79OshlUvbv6lmRhwcLoTJYiWiB5zm9WhLufuAIN2fHZ7yo3FMiKJh5p
         STxi8GzWbph+majnCQJPqR2obUpflwRmNqXdS0Bj3+JuCHKQ3w57g63OWd+l63W6WX/2
         LYpOYR8XkXbt4S05hEMhCqcZQmiPnIWeOoQu6POK3tYrSj90mrV9OJqDGX9X3M0ssd/v
         TDBkcbASTfyphFrrUl8cUPKCYDBsasFRN/yoj+IKEwidy7pFSdVAGuNo1Hz4LqrlZzjc
         lVsyWnaQy834YwrViLB4s8loRuC8GeqVdsxv1KGAJxG91U+nTM7gNsM1jrYpD6VCwow9
         LxmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUD9qLP1nEJrOuZzbkO+ipq2ghqGIvuW/1veCprL6QtgbBGaVfx2OulTlgbOYCTk9MHJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWGKZaMbXsAnbNVCsHRrX3xPvADV1SP1knzJNgMcP2JZrDv3Zr
	/cWfNmPQy26fS2S/md4oJ4I27DUDYmQD2hLHjgy57kjlJCPIIIiJ/RtD3eujoXPYyK9UNLscExB
	mQLo7HkvWntjWFEvjG6nW3/hzEymNuUV4QqRP
X-Gm-Gg: ASbGncsm6X0my/tCeEw+dsDjZHJFwN629DhAI8c+EJBL0/1XP5kL9aoFGeeu0Ygh1ja
	EN8Gt9UqW7BVeZ8BatnHHBjFqOi5P83qijETybXewwO1ZVG9FnkL82WpJo3jnBykDTaczIDjbnJ
	t9i665+rfQqAOaGRi/ts6AHFnwYn9iiI+BGPzbZA==
X-Google-Smtp-Source: AGHT+IFrw8BZjCuFOhVuzoGoPggvVoVPDjLQI9IquDm89HE/yE1Cc7iKOjXMbMu33z6N/acS7eu/8v8uiC8o3Cr4QNA=
X-Received: by 2002:a05:622a:5c9a:b0:476:5fd5:4de6 with SMTP id
 d75a77b69052e-4771de31d7cmr179792471cf.40.1742804429994; Mon, 24 Mar 2025
 01:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250323072511.2353342-1-edumazet@google.com> <Z-B_R737uM31m6_K@gmail.com>
 <CANn89i+fmyJ8p=vBpwBy38yhVMCJv8XjrTkrXSUnSGedboCM_Q@mail.gmail.com>
 <Z-EGvjhkg6llyX24@gmail.com> <CANn89iL8o0UZTpomaT1oaMxRTBv1YdaXZGwXQn3H0dDO81UyGA@mail.gmail.com>
 <Z-ERhIEtrVpTIdJb@gmail.com>
In-Reply-To: <Z-ERhIEtrVpTIdJb@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Mar 2025 09:20:19 +0100
X-Gm-Features: AQ5f1JoeBJ2YoHAwqNQPuYM4cFwyNDx_0TESh55iDTyLRnIzHIb9sowT5jpoRqg
Message-ID: <CANn89iK56=V+YQRUx_a0ax4jy0NkDMRfmXPq8Mh8Qg5esCKBVA@mail.gmail.com>
Subject: Re: [PATCH] x86/alternatives: remove false sharing in poke_int3_handler()
To: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org, 
	bpf@vger.kernel.org, Eric Dumazet <eric.dumazet@gmail.com>, 
	Greg Thelen <gthelen@google.com>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 9:02=E2=80=AFAM Ingo Molnar <mingo@kernel.org> wrot=
e:
>
>
> * Eric Dumazet <edumazet@google.com> wrote:
>
> > Do you have a specific case in mind that I can test on these big
> > platforms ?
>
> No. I was thinking of large-scale kprobes or ftrace patching - but you
> are right that the text_mutex should naturally serialize all the
> write-side code here.
>
> Mind adding your second round of test results to the changelog as well,
> which improved per call overhead from 36 to 28 nsecs?

Sure thing, thanks !

Note the 36 to 28 nsec was on a test host, not really under production stre=
ss.

As all of our production runs with the old code, I can not really tell
what would be the effective change once new kernels are rolled out.

When updating an unique and shared atomic_t from 480 cpus (worst case
scenario), we need more than 40000 cycles per operation.

perf stat atomic_bench -T480

The atomic counter is 21904528, total_cycles=3D2095231571464, 95652 avg
cycles per update
[05]                                                    7866 in
[32,64[ cycles (53 avg)
[06]                                                    2196 in
[64,128[ cycles (81 avg)
[07]                                                    2942 in
[128,256[ cycles (202 avg)
[08]                                                    1865 in
[256,512[ cycles (383 avg)
[09]                                                    4251 in
[512,1024[ cycles (780 avg)
[10]                                                    72248 in
[1024,2048[ cycles (1722 avg)
[11] ***                                                438110 in
[2048,4096[ cycles (3217 avg)
[12] ***********                                        1703927 in
[4096,8192[ cycles (6199 avg)
[13] **************************                         3869889 in
[8192,16384[ cycles (12320 avg)
[14] ***************************                        4040952 in
[16384,32768[ cycles (25185 avg)
[15] ************************************************** 7261596 in
[32768,65536[ cycles (46884 avg)
[16] ******************                                 2688791 in
[65536,131072[ cycles (83552 avg)
[17] *                                                  253104 in
[131072,262144[ cycles (189642 avg)
[18] **                                                 326075 in
[262144,524288[ cycles (349319 avg)
[19] ******                                             901293 in
[524288,1048576[ cycles (890724 avg)
[20] **                                                 321711 in
[1048576,2097152[ cycles (1205250 avg)
[21]                                                    6616 in
[2097152,4194304[ cycles (2436096 avg)

 Performance counter stats for './atomic_bench -T480':

        964,194.88 msec task-clock                #  467.120 CPUs
utilized
            13,795      context-switches          #   14.307 M/sec
               480      cpu-migrations            #    0.498 M/sec
             1,605      page-faults               #    1.665 M/sec
 3,182,241,468,867      cycles                    # 3300416.170 GHz
    11,077,646,267      instructions              #    0.00  insn per
cycle
     1,711,894,269      branches                  # 1775466.627 M/sec
         3,747,877      branch-misses             #    0.22% of all
branches

       2.064128692 seconds time elapsed


I said the  atomic_cond_read_acquire(refs, !VAL) was not called in my tests=
,
but it is a valid situation, we should not add a WARN_ON_ONCE().

I will simply add the unlikely()

Thanks.

