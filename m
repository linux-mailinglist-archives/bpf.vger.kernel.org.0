Return-Path: <bpf+bounces-7241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67126773D7D
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 18:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF56280F67
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 16:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564281549E;
	Tue,  8 Aug 2023 16:09:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3157D1427F
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 16:09:40 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EE97D78F
	for <bpf@vger.kernel.org>; Tue,  8 Aug 2023 09:09:23 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686fc0d3c92so3965460b3a.0
        for <bpf@vger.kernel.org>; Tue, 08 Aug 2023 09:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206; t=1691510929; x=1692115729;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iitn5cuOhlQstNpnubJ9xUVqIDI2aiSTMtUo1rg4ji8=;
        b=UrZYxnPX6wJckLqe+jHS3YavknBWzDGsZVaSQcowb/6drHVG5WTFt/e2c+tnfwi9XI
         WSWbIvmK2HuHalP3bQO/ORywMviWjLTgM/fZLeeWonueuvPNciSz+q0DBP5t7QsKE0nC
         aU571hs+oXkjBZ5hGWq6QJOU7DICgyw4X2reQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510929; x=1692115729;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iitn5cuOhlQstNpnubJ9xUVqIDI2aiSTMtUo1rg4ji8=;
        b=FgCw7dTbv2b+ECe6G1hmgiT//IN8m0NUC+phaE8GTxuc8AEoigsm4iSs20TohELeZh
         uFWVZ2CEgrBjeQNkZQxfWHD6ocJmJmVSL026msWqRFRdEJIfn1cKhAu3SH5vdnYjnGzh
         vhK6czCrFD2VBqgzK3+VCBB2VwuGGS0DwkN2UHxH7VXeZHWMpZYiM94eFwLCdsi3rPUj
         1ybGIIfv/iuOvXGFFDo4Q64eDNmsNArOYoVjDdxzZMTCY2Iuc6rgWYvdu7XdzfWGG3bk
         ZLlJsipclFdp+QjH3asfoV/zjzCTISmMkmWDrdG+L/KkqFqk9HjZaPzAoHT5PI/Jo0Eb
         yDjg==
X-Gm-Message-State: AOJu0YyXVF4qW15M4Ux7YsYTwlEnPIrGba1neHhLUA+IeGdcvnJJOw69
	ZMzI4DZ/L1eCOJfPNrdtf+6SKw==
X-Google-Smtp-Source: AGHT+IH9xX8PBCYOqX2E3rrxg3GkW9lN4OG91y7i8oztvn0MuJt/DKC0is4yyOhgYYOSjd717Yd8Bw==
X-Received: by 2002:a05:6a20:8e0b:b0:13b:1482:261 with SMTP id y11-20020a056a208e0b00b0013b14820261mr13582306pzj.44.1691510929663;
        Tue, 08 Aug 2023 09:08:49 -0700 (PDT)
Received: from smtpclient.apple ([50.234.50.204])
        by smtp.gmail.com with ESMTPSA id n12-20020aa78a4c000000b00682af82a9desm8497446pfa.98.2023.08.08.09.08.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Aug 2023 09:08:49 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH bpf-next] riscv/bpf: Fix truncated immediate warning in
 rv_s_insn
From: Luke Nelson <lukenels@cs.washington.edu>
In-Reply-To: <b85bcf1d-9467-4df6-da11-8f0b24165ada@huawei.com>
Date: Tue, 8 Aug 2023 09:08:38 -0700
Cc: bpf@vger.kernel.org,
 kernel test robot <lkp@intel.com>,
 Xi Wang <xi.wang@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CC58CCF3-1994-4C50-B8FC-E1520ED743BF@cs.washington.edu>
References: <20230727024931.17156-1-luke.r.nels@gmail.com>
 <b85bcf1d-9467-4df6-da11-8f0b24165ada@huawei.com>
To: Pu Lehui <pulehui@huawei.com>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>>  static inline u32 rv_s_insn(u16 imm11_0, u8 rs2, u8 rs1, u8 funct3, =
u8 opcode)
>>  {
>> - u8 imm11_5 =3D imm11_0 >> 5, imm4_0 =3D imm11_0 & 0x1f;
>> + u32 imm11_5 =3D (imm11_0 >> 5) & 0x7f, imm4_0 =3D imm11_0 & 0x1f;
>=20
> Hi Luke,
>=20
> keep u8 and add 0x7f explicit mask should work. I ran the repro case =
and it can silence the warning.
>=20
>>=20
>>   return (imm11_5 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) =
|
>>   (imm4_0 << 7) | opcode;

That does fix the warning, but I think explicitly declaring imm11_5
as u32 is more clear here than the current code which relies on
implicit promotion of imm11_5 from u8 to signed int in the expression
(imm11_5 << 25).

Because of the promotion to signed int, (imm11_5 << 25) is technically
signed overflow and undefined behavior whenever the shift changes
the value in the sign bit. In practice, this isn't an issue; both
because the kernel is compiled with -fno-strict-overflow, but also
because GCC documentation explicitly states that "GCC does not use
the latitude given in C99 and C11 only to treat certain aspects of
signed '<<' as undefined" [1].

Though it may not be an issue in practice, since I'm touching this
line anyways to fix the warning, I think it makes sense to update
the type of imm11_5 to be u32 at the same time.

> Nit: maybe use "riscv, bpf" for the subject will look nice for the =
riscv-bpf git log tree.

Sure, I can send out a new revision with an updated subject line.

- Luke


[1]: https://gcc.gnu.org/onlinedocs/gcc/Integers-implementation.html

