Return-Path: <bpf+bounces-17811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 720A0812BCE
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 10:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77DD81C21518
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 09:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870532F86B;
	Thu, 14 Dec 2023 09:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7/jLAXc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19202B7;
	Thu, 14 Dec 2023 01:38:15 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c2c5a8150so71996535e9.2;
        Thu, 14 Dec 2023 01:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702546693; x=1703151493; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rK0C4aMy8QMncw2+AvjJTa+x6xbu5A04cIs/3cSfgDQ=;
        b=J7/jLAXcuLL02NbmKEBhH29D86dV4xjof0Yq/pTLyWh7vAAiy4/kz+7hl3MTnPBTL5
         pyYuRokm2DpNorwdy425rrANeazojugnUT0kZ0XqJH38+Q0jTFtfMdlAxNQ06QaFbQIw
         CJ4QaAAMVbC7OXrow2Ws4Qk63K5GC+yNLFkN4n02zIe0vn1OclQ8OPf5AWahgRZz6Vi8
         aJUGP71x8uJiFebB6Q8EfUATbmV61KFOcvXPb5JOvErxzG5qeR7wFDofc2A7FWIZ/gQG
         Hgb7+8zTNXYmSpZWaR5YHOoN4L/fs0EdgyVZFWTLAcdPZkjVWE++zATLloQB8gbaeFUE
         aLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702546693; x=1703151493;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rK0C4aMy8QMncw2+AvjJTa+x6xbu5A04cIs/3cSfgDQ=;
        b=NPDli65HVuTV+NCd3y/AuzP1P+Li/fAdhfhloQIPX/gC6SRsjPwju9bKHyle5mkq1i
         9TXX84yq9Ri2IviVcpj+ha9IZqFfDf0RWOffkoqgSxkao7YZnZJcoGdSOEgALPlOUDV2
         B5M4BZ8u07PhztFZCKVj7qcvjRAT7q3WZyKzzXB+W8Vslj9tHwKNdBH446btGXtBq1hu
         Yko5btx9xHzPxwSxIJpEc2GpDFWSBhRb4gusum5iflW7o9o7o3et0/MyF24FLT19G11Z
         6ISonkdz7EorRcQ4k5YJftjVU8ZsTry3IIxZp3MHoawMcIPZ9N/oBzCbH51h7vmi1Ypt
         W3pw==
X-Gm-Message-State: AOJu0Yy5NgKH9cik8t3La4g2lgYfSE8wUqLT7Og2LrS5hBotHWwsOfED
	QnwzzLlidbxACZOnmCYSNA==
X-Google-Smtp-Source: AGHT+IHJUcLukE9d0TXWC9F45DY2RhWm844h3jamDGpiV9uWbivoGXzp+gxVWSZWZhbEke7YWkXuMw==
X-Received: by 2002:a05:600c:21c9:b0:40c:2323:6ffe with SMTP id x9-20020a05600c21c900b0040c23236ffemr5264055wmj.152.1702546693223;
        Thu, 14 Dec 2023 01:38:13 -0800 (PST)
Received: from smtpclient.apple (xdsl-31-164-25-225.adslplus.ch. [31.164.25.225])
        by smtp.gmail.com with ESMTPSA id u21-20020a05600c139500b00405d9a950a2sm25929176wmf.28.2023.12.14.01.38.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Dec 2023 01:38:12 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [Bug Report] bpf: incorrectly pruning runtime execution path
From: Hao Sun <sunhao.th@gmail.com>
In-Reply-To: <480a5cfefc23446f7c82c5b87eef6306364132b9.camel@gmail.com>
Date: Thu, 14 Dec 2023 10:38:01 +0100
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 bpf <bpf@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <917DAD9F-8697-45B8-8890-D33393F6CDF1@gmail.com>
References: <CACkBjsbj4y4EhqpV-ZVt645UtERJRTxfEab21jXD1ahPyzH4_g@mail.gmail.com>
 <CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com>
 <CACkBjsaEQxCaZ0ERRnBXduBqdw3MXB5r7naJx_anqxi0Wa-M_Q@mail.gmail.com>
 <480a5cfefc23446f7c82c5b87eef6306364132b9.camel@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
X-Mailer: Apple Mail (2.3774.200.91.1.1)



> On 14 Dec 2023, at 12:35=E2=80=AFAM, Eduard Zingerman =
<eddyz87@gmail.com> wrote:
>=20
> On Wed, 2023-12-13 at 11:25 +0100, Hao Sun wrote:
> [...]
>=20
>> I tried to convert the repro to a valid test case in inline asm, but =
seems
>> JSET (if r0 & 0xfffffffe goto pc+3) is currently not supported in =
clang-17.
>> Will try after clang-18 is released.
>>=20
>> #30 is expected to be executed, see below where everything after ";" =
is
>> the runtime value:
>>   ...
>>   6: (36) if w8 >=3D 0x69 goto pc+1    ; w8 =3D 0xbe, always taken
>>   ...
>>  11: (45) if r0 & 0xfffffffe goto pc+3  ; r0 =3D 0x616, taken
>>  ...
>>  18: (56) if w8 !=3D 0xf goto pc+3     ; w8 not touched, taken
>>  ...
>>  23: (bf) r5 =3D r8     ; w5 =3D 0xbe
>>  24: (18) r2 =3D 0x4
>>  26: (7e) if w8 s>=3D w0 goto pc+5    ; non-taken
>>  27: (4f) r8 |=3D r8
>>  28: (0f) r8 +=3D r8
>>  29: (d6) if w5 s<=3D 0x1d goto pc+2  ; non-taken
>>  30: (18) r0 =3D 0x4      ; executed
>>=20
>> Since the verifier prunes at #26, #30 is dead and eliminated. So, #30
>> is executed after manually commenting out the dead code rewrite pass.
>>=20
>> =46rom my understanding, I think r0 should be marked as precise when
>> first backtrack from #29, because r5 range at this point depends on =
w0
>> as r8 and r5 share the same id at #26.
>=20
> Hi Hao, Andrii,
>=20
> I converted program in question to a runnable test, here is a link to
> the patch adding it and disabling dead code removal:
> https://gist.github.com/eddyz87/e888ad70c947f28f94146a47e33cd378
>=20
> Run the test as follows:
>  ./test_progs -vvv -a verifier_and/pruning_test
>=20
> And inspect the retval:
>  do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
>  run_subtest:FAIL:647 Unexpected retval: 1353935089 !=3D 4
>=20

Thanks for the runnable test!=20

The reason why retval checks fails is that the way you disable dead
code removal pass is not complete. Disable opt_remove_dead_code()
just prevent the instruction #30 from being removed, but also note
opt_hard_wire_dead_code_branches(), which convert conditional jump
into unconditional one, so #30 is still skipped.



> Note that I tried this test with two functions:
> - bpf_get_current_cgroup_id, with this function I get retval 2, not 4 =
:)
> - bpf_get_prandom_u32, with this function I get a random retval each =
time.
>=20
> What is the expectation when 'bpf_get_current_cgroup_id' is used?
> That it is some known (to us) number, but verifier treats it as =
unknown scalar?
>=20

Either one would work, but to make #30 always taken, r0 should be
non-zero.=

