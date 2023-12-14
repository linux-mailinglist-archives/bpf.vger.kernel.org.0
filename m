Return-Path: <bpf+bounces-17864-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 616B181370C
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 17:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19334281AA7
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 16:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AD0363DCD;
	Thu, 14 Dec 2023 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGzqCcYS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333A8114
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 08:56:25 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c2718a768so81143355e9.0
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 08:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702572983; x=1703177783; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eJ2/wpsBlPkryZiMlJPcB0RBdh823TTqrEMyydKrJqg=;
        b=iGzqCcYSaqjxuNUZMPA+JAfVcSuJP+TGXA3TvsaGP0lXtKJtyB/Ma9aGyIfJpWdgoj
         CHA/CJCuY6O0E7X/Mocp++qeV/XXvE1V1qzahPbENSr+x5xNnNfkll2m98w7hImBDquc
         fnIvRkfVKTmav0ejG1bTLGUGV+GkZb9LUvz9eYvpZrpWl6G+fnkhW9YaDPxwLh5HHZpA
         Iw7UpkzTv3Wdk+wstq4SEgyGcUiLx+nzpZPVUk9Jd4wwLB96tVL9e7M6Vv5Grz6Z+w5o
         sboBLjzFdr1uddNrdkJEuJqMEAONGdgxO3+M020TP1EiHEi8gFqluJ4sWADp5040YoH0
         nV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572983; x=1703177783;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJ2/wpsBlPkryZiMlJPcB0RBdh823TTqrEMyydKrJqg=;
        b=R8ROhHNQtFe/5J7m2lZEzgVXdVZIdod6u0tkfdPnaGhQucQkI7iECxN+qW2KQ/7H/b
         u2R1at4djeuXtZcpQnK/a4SDJ/Zpnbbj7vNfR/t9BWw6cEIwKw2lqyDTRVkKHug1OVYv
         O4SfpMErV3h84SQ/j6kteHkWs+2x/IO7ZgmR9hHPeF7PcpQFHwbOY/1zLTnzvmHKXVpH
         IXpx6EbXG9hnlFSNqjhTbaEyGfz4j8h6buDAsRqaSJ3RDITkdvERVs3dwsLSMewprB9K
         2WH1N3GsxGgiuZSedR+UdgzZsO0OiIdCANS6RNy1hUElUZDbEyjExPx42ZHNmW6TOgEt
         CeYw==
X-Gm-Message-State: AOJu0Yyj/Jk96kb4Jk6vXtQ60T8YbGBk6Mx33pHNi5+GNrxvxsyN4j3m
	1EYSnPGmXVhNowrAPiCiUD4=
X-Google-Smtp-Source: AGHT+IEG4xi+Ph0ibxibXriJM13A0oce3ew1anIbMEIyIAopr/2+hnFjNsj6K+FAjg6BJgDmyFYOMA==
X-Received: by 2002:a05:600c:450e:b0:40c:2b4c:ea8 with SMTP id t14-20020a05600c450e00b0040c2b4c0ea8mr5637730wmo.113.1702572983363;
        Thu, 14 Dec 2023 08:56:23 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id bg16-20020a05600c3c9000b0040c517d090esm10819331wmb.15.2023.12.14.08.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:56:22 -0800 (PST)
Message-ID: <546dd6a51df11fec339f009115f6d96084b95e8d.camel@gmail.com>
Subject: Re: [PATCH bpf-next 6/7] libbpf: BPF Static Keys support
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>, Anton Protopopov <aspsk@isovalent.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov
	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
	 <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau
	 <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, bpf
	 <bpf@vger.kernel.org>
Date: Thu, 14 Dec 2023 18:56:21 +0200
In-Reply-To: <b0530d96-ab92-47e7-94e9-61b961a73557@linux.dev>
References: <ZXNCB5sEendzNj6+@zh-lab-node-5>
	 <CAEf4Bzai9X2xQGjEOZvkSkx7ZB9CSSk4oTxoksTVSBoEvR4UsA@mail.gmail.com>
	 <CAADnVQJtWVE9+rA2232P4g7ktUJ_+Nfwo+MYpv=6p7+Z9J20hw@mail.gmail.com>
	 <bef79c65-e89a-4219-8c8b-750c60e1f2b4@linux.dev>
	 <CAADnVQJd1aUFzznLhwNvkN+zot-u3=4A16utY93HoLJrP_vo3w@mail.gmail.com>
	 <85aa91f9-d5c0-4e7b-950d-475da7787f64@linux.dev>
	 <CAADnVQKZjmwxo0cBiHcp3FkAAmJT850qQJ5_=fAhfOKniJM2Kw@mail.gmail.com>
	 <3682c649-6a6a-4f66-b4fa-fbcbb774ae94@linux.dev>
	 <8e45c28fa0827be2b01a7cd36aa68750ceff69f5.camel@gmail.com>
	 <CAADnVQ+RhX-QY1b5ewNp_K9b+X96PZNbxG8GSpC2xfhwULRNqA@mail.gmail.com>
	 <ZXg1ApeYXi0g7WeM@zh-lab-node-5>
	 <CAADnVQ+b3_5qzaR9pr6B23xDxCO10iz685tHfsakW3MnoVYMbg@mail.gmail.com>
	 <b0530d96-ab92-47e7-94e9-61b961a73557@linux.dev>
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

On Wed, 2023-12-13 at 19:04 -0800, Yonghong Song wrote:
> Slightly different from what Alexei proposed, but another approach
> for consideration and discussion.

It looks like Alexei / Yonghong focus on individual addresses,
while as far as I understand Anton's original proposal is more about
program wide switches. E.g. there is some "DEBUG" flag and from
application point of view it does not matter how many static branches
are enabled or disabled by this flag.
In a sense, there is one-to-one vs one-to-many control granularity.

Here is an additional variation for one-to-many approach, basically a
hybrid of Anton's original idea and Andrii's suggestion to use
relocations.

Suppose there is a special type of maps :)=20
(it does not really matter if it is a map or not, what matters is that
 this object has an FD and libbpf knows how to relocate it when
 preparing program for load):

    struct {
        __uint(type, BPF_MAP_TYPE_ARRAY);
        __type(key, __u32);
        __type(value, __u32);
        __uint(map_flags, BPF_F_STATIC_KEY);
        __uint(max_entries, 1);
    } skey1 SEC(".maps")

And a new instruction, that accepts an fd/pointer corresponding to
this map as a parameter + a label to which to jump if static key is
enabled. E.g., as below:

    __attribute__((naked))
    int foo(void) {
      asm volatile (
                    "if static %[skey1] goto 1f;" // hypthetical syntax
                    "r1 =3D r10;"
                    "r1 +=3D -8;"
                    "r2 =3D 1;"
                    "call %[bpf_trace_printk];"
            "1:"
                    "exit;"
                    :: __imm_addr(skey1),
                       __imm(bpf_trace_printk)
                    : __clobber_all
      );
    }

This "if static" is relocated by libbpf in order to get the correct
map fd, when program is loaded.

In effect, each static key is a single entry map with one to many
relationship to instructions / programs it controls.
It can be enabled or disabled using either map update functions
or new system call commands.

What I think is a plus with such approach:
- The application is free to decide how it wants to organize these FDs:
  - use one fd per condition;
  - have an fd per program;
  - have an fd per set of programs.
- Embedding fd with instruction removes need to communicate mapping
  information back and forth, or track special section kinds.


