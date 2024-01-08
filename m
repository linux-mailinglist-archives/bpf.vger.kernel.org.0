Return-Path: <bpf+bounces-19231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B57827B5B
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 00:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57AF7B22AEE
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 23:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8214153E1F;
	Mon,  8 Jan 2024 23:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqNkjJwK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C896D56740
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 23:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d40eec5e12so19084165ad.1
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 15:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704755824; x=1705360624; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mxEt8//a9tk6CLrSUF1WftcF2StETIlvw7vdnyy+NI0=;
        b=lqNkjJwKHoGV8hc7Ahm4RGu5UACoMqzvHoZ06QpVFNMPbetRtqQL0jC3XJrwIi76I3
         nZ28BtGisGV3+lEPZnKHn6ixQ6osl87iBUW+tX21mPliv/goBl1aAp+38WKLHD10afXe
         7rggq9EQ8S+GLp+G78pfF2drOrbqYugCLO2Z3wxIdcKHhdRDDXxa9EGWPtogJqDmy0+1
         tOuL79UVq55kf82Fe2TKj0kp/vFgG5Kh5eYcndyLgl+QfDId+tPl1iiSiDn21nFLNWw5
         gdIL0Gj2ka09q3zuhOfj1OcIuJTdjHWw8UIC1YjwsX0FtE4nVoY2CtCfSJbGWs5iIlTI
         mTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704755824; x=1705360624;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mxEt8//a9tk6CLrSUF1WftcF2StETIlvw7vdnyy+NI0=;
        b=mzhaJBdAjiUs4HsWI+vFEdeJyZwVmLN0K+h7zy+44FtRdxKAT34Yc0kGn3Kd22pxti
         Cb6kKfj0AJOBVLzfizZ6EyAbAFC6QMJCB1v1IZd3ifI6J3y7274DcCl04obbczer43X3
         s8Z7XQsuQhEGzNuyWnQC9zMEiOhSUrEugMOaxjpsXkJ6O2lfeAKCQGICJCBzFI2BW+zr
         uKwQaSaFSocljxEEmdWd7EzUEtZVhe0nLHrr8gqQNP+S3fp5Pu0AMZzRtl6Mo7yNhnGM
         4638Rw8vWPeRzNb76XGqYF6VOioTEHC1vm5vbkwocxGabA0zLOmQZYc2BcshXmXsE5K+
         qJ2A==
X-Gm-Message-State: AOJu0YxXoB/yCducER+P989Kjw+9AVBfVCjXAUBanwEhvYdszhG0aWfy
	bAtnD2ljZteYM+6OXZhqk3Y=
X-Google-Smtp-Source: AGHT+IGHJKGDNZ/MVClgntnHNTwSjFngLW2Vj7RPy7o0rFeMckOsXbYb9iqKKrRX0oC3yY5qtrbnJA==
X-Received: by 2002:a17:902:b907:b0:1d4:fda1:e355 with SMTP id bf7-20020a170902b90700b001d4fda1e355mr4370366plb.94.1704755823970;
        Mon, 08 Jan 2024 15:17:03 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id n10-20020a1709026a8a00b001cfc35d1326sm416763plk.177.2024.01.08.15.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 15:17:03 -0800 (PST)
Message-ID: <c38e87c8301aa383ae622a14c75c39b2dc4f7989.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/5] bpf: Introduce "volatile compare" macro
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>,  Martin KaFai Lau <martin.lau@kernel.org>, Daniel Xu
 <dxu@dxuuu.xyz>, John Fastabend <john.fastabend@gmail.com>, bpf
 <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Date: Tue, 09 Jan 2024 01:16:58 +0200
In-Reply-To: <dc6ce5dc-afb9-4b5b-a99a-1577b99f6a96@linux.dev>
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
	 <20231221033854.38397-3-alexei.starovoitov@gmail.com>
	 <CAP01T77fbW-9N+Z-2LFS=174HN6v_OJAbR_s6EOfLLW8Oceh_g@mail.gmail.com>
	 <CAADnVQKY4hB4quJX_oyq4GULEJkehXWx6uW1nAYHveyvdyG8sw@mail.gmail.com>
	 <CAADnVQ+tYBpt_aRG5aU3sAYEysKxUOKQ24dBG4bP2kLy8nmmgA@mail.gmail.com>
	 <44a9223b6638673487850eb9d70cc01ef58e9d93.camel@gmail.com>
	 <dc6ce5dc-afb9-4b5b-a99a-1577b99f6a96@linux.dev>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-01-08 at 13:21 -0800, Yonghong Song wrote:
[...]
> Thanks for the detailed analysis! Previously we intend to do the followin=
g:
>=20
> - When 32-bit value is passed to "r" constraint:
>    - for cpu v3/v4 a 32-bit register should be selected;
>    - for cpu v1/v2 a warning should be reported.
>=20
> So in the above, the desired asm code should be
>=20
>      ...
>      # %bb.0:
>      	call bar
>      	#APP
>      	w0 +=3D 1
>      	#NO_APP
>      	exit
>      ...
>=20
> for cpuv3/cpuv4. I guess some more work in llvm is needed
> to achieve that.

To make clang emit w0 the following modification is needed:

diff --git a/llvm/lib/Target/BPF/BPFISelLowering.cpp b/llvm/lib/Target/BPF/=
BPFISelLowering.cpp
index b20e09c7f95f..4c504d587ce6 100644
--- a/llvm/lib/Target/BPF/BPFISelLowering.cpp
+++ b/llvm/lib/Target/BPF/BPFISelLowering.cpp
@@ -265,6 +265,8 @@ BPFTargetLowering::getRegForInlineAsmConstraint(const T=
argetRegisterInfo *TRI,
     // GCC Constraint Letters
     switch (Constraint[0]) {
     case 'r': // GENERAL_REGS
+      if (HasAlu32 && VT =3D=3D MVT::i32)
+        return std::make_pair(0U, &BPF::GPR32RegClass);
       return std::make_pair(0U, &BPF::GPRRegClass);
     case 'w':
       if (HasAlu32)

However, as Alexei notes in the sibling thread,
this leads to incompatibility with some existing inline assembly.
E.g. there are two compilation errors in selftests.
I'll write in some more detail in the sibling thread.

> On the other hand, for cpuv3/v4, for regular C code,
> I think the compiler might be already omitting the conversion and use w
> register already. So I am not sure whether the patch [6]
> is needed or not. Could you double check?

Yes, for regular C code, generated assembly uses 32-bit registers as expect=
ed:

echo $(cat <<EOF
extern unsigned long bar(unsigned);
void foo(void) {
  bar(bar(7));
}
EOF
) | clang -mcpu=3Dv3 -O2 --target=3Dbpf -mcpu=3Dv3 -x c -S -o - -

...

foo:                                    # @foo
# %bb.0:
	w1 =3D 7
	call bar
	w1 =3D w0
	call bar
	exit

