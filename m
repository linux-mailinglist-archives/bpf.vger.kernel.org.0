Return-Path: <bpf+bounces-17307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD2180B1F9
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 05:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0799A1C20D18
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 04:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF4C1386;
	Sat,  9 Dec 2023 04:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1Rc2LU5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA6510F8
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 20:07:24 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3332ad5b3e3so2659661f8f.2
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 20:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702094843; x=1702699643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6dXJfiSet+dH1cJyAMjygm5tFS/GMGbGtoBp3hAO10=;
        b=e1Rc2LU5Qi1q4ifqOafvJFZKEpfs+FBBSw6A8scMxjs3XJr372o6j9BCYTe0bNmkPk
         WnOmvTLuDO5DDiyr8PcM4jt7N+zerKuZkSlOxlKhzZe70o/h/pEZB8oDtbdfOsQ7CqF1
         74RVHjBYNAHmXKEfj1YN17ftVkalEU3wge0mCbyzK6/p6JUKb4cgyEHp5Dh1DpF6785E
         tfpkenuDv7v/8enbVWg9d3CpEqlSNd64dlCtSM7/sVk42EFXanZBXKGSQxZ+Z5kVfpH3
         Ud+PPUlFP75EJmeExjDDjEFA6gKtQOeI/irPU/+0c2bxa/xWLEd7Xr4KwtQ33Twk0nNB
         LxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702094843; x=1702699643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6dXJfiSet+dH1cJyAMjygm5tFS/GMGbGtoBp3hAO10=;
        b=pO6Th6mfN6wBTfWSXL1/KGwIHn1yv8BdAbCAmJXYXGSrNJyqfkwrQgvoxqHpK5EGtJ
         Akw7zg4hHz9LgzjFVX2UFxXgRZVaE34Vvrt+d3plP0BTAF/i+qisuuQKTZhwPbf04WMj
         m0551ep4j55IzoKa+0A/DduZSd+o4Sdbp6qVEf0LNoCaVIxCyNUTBWxhrLDZONwGbgqY
         CXyGOQBh0Qce2Vx3WFXrG5ggOfIXFJId1uQHFTypHl/kvEgRbCVRtpKF0Si8YDebU/3M
         5veErM0K7Z3bBvf/uz1YT8pAeFZKwAkBDrIm9WPryIkPZIBUF0vkI3YCqxxK8eB/KVwi
         JbMw==
X-Gm-Message-State: AOJu0YzH4NoILsiYFvzgAqjgGz8ZWXQtmb2kdeTzVgMvzsGXA1n8HsF7
	bvrfHTUuGUWSjJKKEAAwYn89BmK7v1vnGsYc3Pc=
X-Google-Smtp-Source: AGHT+IEVMI69OL+Vwu7pv4kPIyzQ3iPTH+jIoEStwCE58t0P1eT/FdapMerTnxPyyz/qJC2pVLtGFTskcHlRAsiYwn4=
X-Received: by 2002:a5d:6242:0:b0:333:1faa:181d with SMTP id
 m2-20020a5d6242000000b003331faa181dmr594474wrv.0.1702094842805; Fri, 08 Dec
 2023 20:07:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206141030.1478753-1-aspsk@isovalent.com> <20231206141030.1478753-7-aspsk@isovalent.com>
 <CAADnVQ+BRbJN1A9_fjDTXh0=VM5x6oGVgtcB1JB7K8TM5+6i5Q@mail.gmail.com>
 <ZXNCB5sEendzNj6+@zh-lab-node-5> <CAEf4Bzai9X2xQGjEOZvkSkx7ZB9CSSk4oTxoksTVSBoEvR4UsA@mail.gmail.com>
 <8e75bdce562e1b27dcaa3a7ede74339d23c3fca9.camel@gmail.com>
In-Reply-To: <8e75bdce562e1b27dcaa3a7ede74339d23c3fca9.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Dec 2023 20:07:11 -0800
Message-ID: <CAADnVQL+X1zvJFeu9brgV=9rFJ2=4NBMcQB83OVn3-_5hWNciA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] libbpf: BPF Static Keys support
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Anton Protopopov <aspsk@isovalent.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 3:07=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
>
> fwiw, if relocations are used instead of IDs the new instruction does
> not have to be a control flow. It might be a mov that sets target
> register to a value that verifier treats as unknown. At runtime this
> mov could be patched to assign different values. Granted it would be
> three instructions:
>
>   mov rax, 0;
>   cmp rax, 0;
>   je ...
>
> instead of one, but I don't believe there would noticeable performance
> difference. On a plus side: even simpler verification, likely/unlikely
> for free, no need to track if branch is inverted.

'je' is a conditional jmp. cpu will mispredict it sooner or later
and depending on the density of jmps around it the misprediction
can be severe.
It has to be an unconditional jmp to be fast.

