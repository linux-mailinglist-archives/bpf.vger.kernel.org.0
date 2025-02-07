Return-Path: <bpf+bounces-50751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9411DA2BDB0
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 09:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201DA164E54
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 08:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC3E1A3056;
	Fri,  7 Feb 2025 08:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iz1Uawvj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C272F189F39
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738916263; cv=none; b=QnNEUaulOx9/DFKnrUxvp2th/tZvtbSu9iJMpCTF676NC9O7Ws9Qb10MaxPE4S3RfA9Gz/wyhntsYR4JeEWxtPXU5lo5MGJukMGMnHJ4vnPs2yuy0mnJrQww+C+t5SEUQNYRq7tWnwcoscSXsM0a8giOvI4UdUjPtP28pX28A0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738916263; c=relaxed/simple;
	bh=YwHZbFK3Jkg2meVSPJxvsXv0nwmyX8hMDuACI/7mFXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XogzAoBpleE0CJluSywYbsEy2E2jmt4ClSws0uKhYFNPaHfVMosYwai/1RiCCQn6Vw89Axo5B74Pq+hv6qykXRhidFJmgT65/GgBxRbA/qBjRca6wRooZez4e14sTRYY3y/hl52QKokcbSz8VF/7raZcYYLYhhnYLisvBP8E0Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iz1Uawvj; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-6f972c031efso24979577b3.1
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2025 00:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738916260; x=1739521060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFdmmjobLe6Nsm8LOL/n/pWPxwUxhlT7xt2lv2jG91o=;
        b=iz1UawvjAvlHR1gm7Yu0NpsMugEQ1bCZVkUmXD12jqb58JleaNgNZHOaXfsWBGhhee
         8E5A47h3lUh/EN9xGMX3Fh1+I5c2P30Bh9Kc4LI2FzRNBPd0LE5Q7Z9QQI/r13xDS/LM
         7kSi0P6SJQzlHDHkRqShQgyTeMNWLgM/TgmGxWB2vEYofLRfRfOHmEPrfmTE0vf2A+vd
         bPzexvssLoD064i04yhJ2YfpbnNwsKnMazzbd6ZmkKCCBIH1Z/uvJ2aUfyxJbvDG7u8Z
         tWe43zsjlWoKcLALroL/4oSQr1eL/oRdRrpcOA4trswHpGGW/SkaP2cR1rT476eaANrB
         +Dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738916260; x=1739521060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFdmmjobLe6Nsm8LOL/n/pWPxwUxhlT7xt2lv2jG91o=;
        b=AatIc1Al97IB5Mc9Eh6XyHlDQ5ES100xoI8WrzkaLohLIQ3o0r78aE4NJoRvfJwtNZ
         PEQBanvpblPTF3SsQ6FOaBEM7ymW1a0ervrG07eKIHzU7AUIQ7W3MqDAtvchhyyn0+io
         qCGPGD0PUiUxXgmsOm+az7vL+4IdoJcJ0WvoBZ6w9IPMIeVgVWJp/IQTLm6LxLN45KR9
         UpQXjQ47oD+d9yHWZwoTP1HhT0wMnlzvTk3NU8ktvhv55OmNcSISYYTRxfgTbpOhlL8C
         qzQQe3p3XXgZ0lchtXOpMSZ7fon3hJLY6Q8fnSuUCghGXJmGb1ruSqueON9rfePr16DM
         KlGg==
X-Forwarded-Encrypted: i=1; AJvYcCX3XK5jkokoqniOYIykZtBYyFFzB9Xk0dhugMrM+oh1UR8H6tsILOkxr2scQi6/U7ZSeP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKlEBiA5z1HwNM/2MumT4hCtbXqWGfiHclqi74IreUx7Zv+2RJ
	sbhKuea8pgbzTa2LKV2PT4J0zn0wu1+pjcPUC0yDu8TEjB8/JpJv43cfDMdvH4/ArqEIplHhDpk
	WBmJHCt60qTiHD0naJjKcYyF9nPvr1/9JQBM=
X-Gm-Gg: ASbGnctMAP3nc3cka+ZeCifSxVz1+95VG/VIFKLH/5Odx16C3fVjB5Ap1nHeXRWdIJq
	pwVv26LMs6qn95e7dMqEmGsP/dDyIuqhfWVWgqzs8+0f4DNsgrdB+hNxvFt69AavOC6LOnGoQ
X-Google-Smtp-Source: AGHT+IHdM7rUMCQMN/sujQj+4M/X8EyyFslK93xqwuhsOdDK/CwhRoIsvEfwNGnERdkgk2iJDRoi4oQ3TqrHdDzvGZM=
X-Received: by 2002:a05:690c:a85:b0:6f9:c146:131e with SMTP id
 00721157ae682-6f9c1461b6cmr365287b3.1.1738916260535; Fri, 07 Feb 2025
 00:17:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADxym3anLzM6cAkn_z71GDd_VeKiqqk1ts=xuiP7pr4PO6USPA@mail.gmail.com>
 <20241220140058.GE17537@noisy.programming.kicks-ass.net> <CADxym3Z5GKJB_+m4iyw-Ycy98usMvwHr6jBwW_zBiwX+mdPW5Q@mail.gmail.com>
 <CAADnVQJct=ANAmXCSancBjm7k7uThEOau3u_e8Pe3Mf9jrDzYg@mail.gmail.com>
In-Reply-To: <CAADnVQJct=ANAmXCSancBjm7k7uThEOau3u_e8Pe3Mf9jrDzYg@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 7 Feb 2025 16:16:34 +0800
X-Gm-Features: AWEUYZm2ERGZjd-GJeDrm6b0E7zCjR5mQfMXg9hBxs5SakSF8TwhuPP3VAWAu_0
Message-ID: <CADxym3af+CU5Mx8myB8UowdXSc3wJOqWyH4oyq+eXKahXBTXyg@mail.gmail.com>
Subject: Re: Idea for "function meta"
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 4, 2025 at 3:28=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Dec 24, 2024 at 7:25=E2=80=AFPM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > On Fri, Dec 20, 2024 at 10:01=E2=80=AFPM Peter Zijlstra <peterz@infrade=
ad.org> wrote:
> > >
> > > On Fri, Dec 20, 2024 at 09:57:22PM +0800, Menglong Dong wrote:
> > >
> > > > However, the other 5-bytes will be consumed if CFI_CLANG is
> > > > enabled, and the space is not enough anymore in this case, and
> > > > the insn will be like this:
> > > >
> > > > __cfi_do_test:
> > > > mov (5byte)
> > > > nop nop (2 bytes)
> > > > sarq (9 bytes)
> > > > do_test:
> > > > xxx
> > > >
> > >
> > > FineIBT will fully consume those 16 bytes.
> > >
> > > Also, text is ROX, you cannot easily write there. Furthermore, writin=
g
> > > non-instructions there will destroy disassemblers ability to make sen=
se
> > > of the memory.
> >
> > Thanks for the reply. Your words make sense, and it
> > seems to be dangerous too.
>
> Raw bytes are indeed dangerous in the text section, but
> I think we can make it work.
>
> We can prepend 5 byte mov %eax, 0x12345678
> or 10 byte mov %rax, 0x12345678aabbccdd
> instructions before function entry and before FineIBT/kcfi preamble.
>
> Ideally 5 byte insn and use 4 byte as an offset within 4Gb region
> for this per-function metadata that we will allocate on demand.
> We can prototype with 10 byte insn and full 8 byte pointer to metadata.
> Without mitigations it will be
> -fpatchable-function-entry=3D10
> with FineIBT
> -fpatchable-function-entry=3D26
>
> but we have to measure the impact on I-cache iTLB first.
>
> Menglong,
> could you do performance benchmarking for no-mitigation kernel
> with extra 5 and extra 10 bytes of padding ?

Hi Alexei,

(Sorry for the late reply, I was celebrating the Spring Festival a few
days ago :/ )

I did some performance benchmarking recently with sysbench.
The only case that I did is threads creating benchmarking:

  sysbench --time=3D60 threads run

I disabled mitigation, and compile a 5-bytes padding kernel with
following changes:

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2485,10 +2485,10 @@ config FUNCTION_PADDING_CFI
 config FUNCTION_PADDING_BYTES
        int
        default FUNCTION_PADDING_CFI if CFI_CLANG
-       default FUNCTION_ALIGNMENT
+       default 5

 config CALL_PADDING
-       def_bool n
+       def_bool y
        depends on CC_HAS_ENTRY_PADDING && OBJTOOL
        select FUNCTION_ALIGNMENT_16B

I did this testing in a kvm in following steps:

1. isolate 4 cores in the host by adding following params to
   the cmdline:
   isolcpus=3D0-3
2. run a kvm, and isolate 2 cores in the kvm by adding
   "isolcpus=3D0,1" to the cmdline of the kvm
3. bind the vcpu threads of the kvm to the CPU that we
    isolated
4. run the following command to performance the benchmarking
   in the kvm:
   taskset -c 0 sysbench --time=3D60 threads run
   and do the statistics with perf meanwhile:
   perf stat -C 0 -- sleep 10

I did the testing not only for 5-bytes padding, but also for
1-bytes, 3-bytes, 4-bytes,5-bytes, 6-bytes, 7-bytes, 8-bytes,
10-bytes, and following is the results of this testing:

| PADDING(BYTES) | RESULT | cycles    | IPS(insns per seconds) |
stalled cycles per insn | stalled-cycles-frontend |
| ------------ | ------ | --------- | ---------------------- |
----------------------- | ----------------------- |
| 1            | 120577 | 4.790 GHz | 3.05                   | 0.04
                | 12.18%                  |
| 1            | 120657 | 4.815 GHz | 3.05                   | 0.04
                | 12.04%                  |
| 1            | 120172 | 4.789 GHz | 3.05                   | 0.04
                | 12.25%                  |
| 3            | 117454 | 4.804 GHz | 2.98                   | 0.04
                | 12.97%                  |
| 3            | 117418 | 4.815 GHz | 2.98                   | 0.04
                | 13.12%                  |
| 3            | 117864 | 4.815 GHz | 2.98                   | 0.04
                | 13.06%                  |
| 4            | 120825 | 4.767 GHz | 3.08                   | 0.04
                | 11.02%                  |
| 4            | 121361 | 4.816 GHz | 3.08                   | 0.04
                | 11.00%                  |
| 4            | 121227 | 4.792 GHz | 3.08                   | 0.04
                | 11.04%                  |
| 5            | 120214 | 4.804 GHz | 3.05                   | 0.04
                | 10.91%                  |
| 5            | 120295 | 4.772 GHz | 3.07                   | 0.04
                | 10.99%                  |
| 5            | 120980 | 4.798 GHz | 3.07                   | 0.04
                | 11.00%                  |
| 6            | 120151 | 4.776 GHz | 3.05                   | 0.04
                | 11.73%                  |
| 6            | 119700 | 4.803 GHz | 3.04                   | 0.04
                | 11.77%                  |
| 6            | 120030 | 4.789 GHz | 3.05                   | 0.04
                | 11.88%                  |
| 7            | 115081 | 4.789 GHz | 2.93                   | 0.05
                | 13.77%                  |
| 7            | 115681 | 4.795 GHz | 2.94                   | 0.05
                | 13.37%                  |
| 7            | 115954 | 4.817 GHz | 2.95                   | 0.05
                | 13.46%                  |
| 8            | 119675 | 4.768 GHz | 3.04                   | 0.04
                | 12.10%                  |
| 8            | 120442 | 4.824 GHz | 3.05                   | 0.04
                | 12.06%                  |
| 8            | 120260 | 4.793 GHz | 3.04                   | 0.04
                | 12.21%                  |
| 10           | 116292 | 4.788 GHz | 2.97                   | 0.04
                | 12.69%                  |
| 10           | 116543 | 4.815 GHz | 2.97                   | 0.04
                | 12.74%                  |
| 10           | 116654 | 4.794 GHz | 2.97                   | 0.04
                | 12.81%                  |
| 16           | 120051 | 4.786 GHz | 3.05                   | 0.04
                | 11.21%                  |
| 16           | 120450 | 4.808 GHz | 3.05                   | 0.04
                | 11.19%                  |
| 16           | 120562 | 4.831 GHz | 3.05                   | 0.04
                | 11.22%                  |

I haven't found the rule of the impact of the space we padding,
but we can see that the performance is ok for 1,4,5,6,8 bytes
padding, which means that the performance is the same as 16-bytes
padding. But it's not ok for 3-bytes, 7-bytes and 10-bytes padding.

I didn't do the testing for all the possible padding bytes, it consumes
time :/

So it seems that we can add extra 5-bytes to the padding and
don't have performance loss. But I'm not sure if it has any other
impacts.

So we have two ways to implement such a function:
1. add extra 5-bytes padding when necessary. This will make the
   vmlinux is as small as possible.
2. make the FUNCTION_ALIGNMENT 32-bytes, which will make
   the vmlinux ~5% larger.

BTW, we don't need to do anything if CFI_CLANG is not enabled,
as there is 7-bytes spare padding in such cases, which is enough
for us.

What do you think?

Thanks!
Menglong Dong

>
> Since we have:
> select FUNCTION_ALIGNMENT_16B           if X86_64 || X86_ALIGNMENT_16
>
> the functions are aligned to 16 all the time,
> so there is some gap between them.
> Extra -fpatchable-function-entry=3D5 might be in the noise
> from performance point of view,
> but the ability to provide such per function metadata block
> will be very useful for all kinds of use cases.

