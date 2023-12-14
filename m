Return-Path: <bpf+bounces-17860-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0467D813626
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 17:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65850B210E6
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 16:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505D05F1FA;
	Thu, 14 Dec 2023 16:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSuX2lt5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABEF11A;
	Thu, 14 Dec 2023 08:26:16 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40b5155e154so94667175e9.3;
        Thu, 14 Dec 2023 08:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702571175; x=1703175975; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zdH9gMnQNKHXOKBUC+84ODN/O33buQFJ4juryMWVkgI=;
        b=RSuX2lt56KLhnnZWvvuvOqsJDlE1uOM/kuk+JXTv0yk+Xuj1i3n09hHvk4fdTMzajd
         BZILWW5nMfM8j1Vi8V0gH0P+L+bp91h30FymBh2PcS4XRhfLzcajHWagb9K51IayXMbx
         r8IG2Gy2aiaNV1pclypufqWNJXE3zBAi6iyxxZYV8EZ8JAIgIH1jUTz+gawn4KQ9OzeC
         8fPuFDbg4vTrVAb7QYC0bDFHt5Jn9fwenn4e32FCCDmeyq1uvODsYDoqhBbsTjBqvK15
         P+3Kybfv0oEQ2NR5LerqQI2dYnSfvN0f6VJLKI3tsCmXYgnektPcCKLrPnk5XNb52ecQ
         JdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702571175; x=1703175975;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdH9gMnQNKHXOKBUC+84ODN/O33buQFJ4juryMWVkgI=;
        b=D9LpyLC6Ta5DMIUr/2I+UH0lOMIJtUjWqpZWlgO+DUVuxC2b48dYKuXIaYRiT4EwEr
         OIHzeGzLhiG8YUyIjZva7LHt4hhlq20WF/IEp+YD+Ufbv35y2VNAumiuApBMcbYova7p
         6jZ1Pd0Jn/m5hTBLDICvYV5mttutlEOOW96n5c22wzz63MJCpnPTJFfpTgaIG96Y6u2+
         Xn8UrvRNQQDna70wq5qcTsNHE1qERJ1vAlTHAfJoSfoCrXg28RrXIh9QGEwvP3bhjwSg
         V4HiaVuzQz2LQYrPRJY6btGgQrqD3wCf0/od9CONYq80lo878V3M5aGLA+d5AMsV/ABK
         kkvA==
X-Gm-Message-State: AOJu0YyK+Q8/9VkDLl0mmn3BjE8GmkZDKoG9kbsi9ModF2Og1s/c75Vp
	vMvQThsavxhNiJ2cCcic7kU=
X-Google-Smtp-Source: AGHT+IFSvs7inmRD3CjtZ1DiI/02fJjItdpi0G7+kaDgomGVUYnPJ4Sgw2GkbyVc7gp4TR+YbZn3eA==
X-Received: by 2002:a05:600c:4e8d:b0:401:b6f6:d90c with SMTP id f13-20020a05600c4e8d00b00401b6f6d90cmr4917532wmq.35.1702571175243;
        Thu, 14 Dec 2023 08:26:15 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s18-20020a5d4ed2000000b00336421f1818sm3978765wrv.112.2023.12.14.08.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:26:14 -0800 (PST)
Message-ID: <73d021e3f77161668aae833e478b210ed5cd2f4d.camel@gmail.com>
Subject: Re: [Bug Report] bpf: incorrectly pruning runtime execution path
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hao Sun <sunhao.th@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>
Date: Thu, 14 Dec 2023 18:26:13 +0200
In-Reply-To: <9dee19c7d39795242c15b2f7aa56fb4a6c3ebffa.camel@gmail.com>
References: 
	<CACkBjsbj4y4EhqpV-ZVt645UtERJRTxfEab21jXD1ahPyzH4_g@mail.gmail.com>
	 <CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com>
	 <CACkBjsaEQxCaZ0ERRnBXduBqdw3MXB5r7naJx_anqxi0Wa-M_Q@mail.gmail.com>
	 <480a5cfefc23446f7c82c5b87eef6306364132b9.camel@gmail.com>
	 <917DAD9F-8697-45B8-8890-D33393F6CDF1@gmail.com>
	 <9dee19c7d39795242c15b2f7aa56fb4a6c3ebffa.camel@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-14 at 17:10 +0200, Eduard Zingerman wrote:
> [...]
> > The reason why retval checks fails is that the way you disable dead
> > code removal pass is not complete. Disable opt_remove_dead_code()
> > just prevent the instruction #30 from being removed, but also note
> > opt_hard_wire_dead_code_branches(), which convert conditional jump
> > into unconditional one, so #30 is still skipped.
> >=20
> > > Note that I tried this test with two functions:
> > > - bpf_get_current_cgroup_id, with this function I get retval 2, not 4=
 :)
> > > - bpf_get_prandom_u32, with this function I get a random retval each =
time.
> > >=20
> > > What is the expectation when 'bpf_get_current_cgroup_id' is used?
> > > That it is some known (to us) number, but verifier treats it as unkno=
wn scalar?
> > >=20
> >=20
> > Either one would work, but to make #30 always taken, r0 should be
> > non-zero.
>=20
> Oh, thank you, I made opt_hard_wire_dead_code_branches() a noop,
> replaced r0 =3D 0x4 by r0 /=3D 0 and see "divide error: 0000 [#1] PREEMPT=
 SMP NOPTI"
> error in the kernel log on every second or third run of the test
> (when using prandom).
>=20
> Working to minimize the test case will share results a bit later.

Here is the minimized version of the test:
https://gist.github.com/eddyz87/fb4d3c7d5aabdc2ae247ed73fefccd32

If executed several times: ./test_progs -vvv -a verifier_and/pruning_test
it eventually crashes VM with the following error:

[    2.039066] divide error: 0000 [#1] PREEMPT SMP NOPTI
               ...
[    2.039987] Call Trace:
[    2.039987]  <TASK>
[    2.039987]  ? die+0x36/0x90
[    2.039987]  ? do_trap+0xdb/0x100
[    2.039987]  ? bpf_prog_32cfdb2c00b08250_pruning_test+0x4d/0x60
[    2.039987]  ? do_error_trap+0x7d/0x110
[    2.039987]  ? bpf_prog_32cfdb2c00b08250_pruning_test+0x4d/0x60
[    2.039987]  ? exc_divide_error+0x38/0x50
[    2.039987]  ? bpf_prog_32cfdb2c00b08250_pruning_test+0x4d/0x60
[    2.039987]  ? asm_exc_divide_error+0x1a/0x20
[    2.039987]  ? bpf_prog_32cfdb2c00b08250_pruning_test+0x4d/0x60
[    2.039987]  bpf_test_run+0x1b5/0x350
[    2.039987]  ? bpf_test_run+0x115/0x350
               ...

I'll continue debugging this a bit later today.


