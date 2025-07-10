Return-Path: <bpf+bounces-62879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9ADAFF853
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 07:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF881C8348A
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 05:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB66220680;
	Thu, 10 Jul 2025 05:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChLj4j8M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2188286334
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 05:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752124272; cv=none; b=et4VadyXj6YFjt2vYe0j0LTNkE6vCmt9NW6L1aQdfvi9voyK+F6LS6anRPlCqbX1IddqYkeQpUAyfFJMK5B8VWyfWSpa1edj7nHjTVFiCNIFAapVTJRYU8/qXOTHIdu3hKW4m/zMxP6QzQXwEmbi1YeOxyptLIJ2yHWcu2hhDlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752124272; c=relaxed/simple;
	bh=UFQbDQd7w7am40EqQUFsalPXneKG43TM1Xr6EB2LB88=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XZ4+m4UurN37LvE1PfDJvmTxY1393MslkhaFPkuIdJE5lBU8R6QXGXmKfjk9GrgRHQmW+HNTXJ5MwyptTrg2x61WGatsKtO6tjAAoaOsiukvOjCQ0+XkYWmSl2q/3D1gwNhygeRBZ9hhBmU/wW7/faKpoI82wiAv/zDyy2HuqN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChLj4j8M; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-235ef62066eso10086025ad.3
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 22:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752124270; x=1752729070; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HR5Xj0YvMaoDoyvMKRcohDWQuaVOiBi1ktD1dNNacEQ=;
        b=ChLj4j8M1H81ItBkoaMWTJgzBrt92Sr1UhKGw4o3/p3P8P7N8wwl0blz767OcrmYBK
         vpR9NCT0ALX8BdyEDhdypGKCJaPe7UXKZJTz2/hIImXnra/8LZ3xzcL8wo4XspWfJGot
         dN86+us8rDPUpzQDHSxKNjaDQlb7ajpZ9UDcGmHG2ds7Cxwv07BqsHFp3jwpvQPlV44U
         Y7A4Ofpfm0gee78waNnktAmltOBE/Mdkg8hy3eRpNFrwZ9vz8c8n4rwxJjtTY3QUK/rI
         HKYjEbkt/wGf6nAYEx9ovOuN/EJ197pZ1c82TYzFafdZ0eiphB8yaKtuG87MDky2CRSt
         xMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752124270; x=1752729070;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HR5Xj0YvMaoDoyvMKRcohDWQuaVOiBi1ktD1dNNacEQ=;
        b=jZ5mlPf1KYXZNibxolYfm/FKi5owub68IvEs9camiCrq1zEmi+ZYCZ5MIIUuMcr1QV
         0JzDFExVY0sVAgM9h9LF/60zth/TSDxpXrK9QF80rGIF1/1rz2hi9jfnJMhHFGj4760i
         K1bwbohUTGVfzBrbOXXw2HsPKvrxsd0NQiDItq61YemPWLrzThDX4tLQlQUKZQO5Sfil
         S3TV8wQ5464S+jH+EamO7XschiKsbvAiwRVjjopMJsfSnIN+MxkZ1NLD/6DGuBiLOi2P
         lpWcT260z4B/aeVGmmZKQ0Z9+Lnoj2xXRfo39VAwTpR4FZVKf60yr5hmIHMoWuPx+5jb
         R7RA==
X-Forwarded-Encrypted: i=1; AJvYcCVYsmc+r2emVwVwcVXiAxhT8vS6Ce4SqthShqjpHJXlZ8NVs/afYzF0P5Pgtrrm4ZeIR/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBbYt/Z+2uDZ4ibVIpJUklGmE2rsSwPpdCyh3x9yZtUPSS1YmL
	9p1MT9ZLoxaNwYdE83RfItZjvSDCx11Qq4puyjK2+z0ssXddkdxuHBkm
X-Gm-Gg: ASbGncvufRIpRFsTNLOxug34JTNDLYNjAQE63S3uxQf0/2MUm54dQ0NKhlUwEtF+4cV
	GCdmST6uwz1YIhT6LU8IPMNEPgCxxAMDaOm5lMysebeu/hYcPWFAeQfzCaMjMjtTxgifdutuvCL
	6LHFYtVWgwwzl9+ND145esuarwvNiCz8yuGEpah99peGAMo4PC4D1bqRZBQHFWgbQE37Mel/Axw
	1WHXZgdZQNycrAjX0Mh+7I3SDY+zthJRSd+qJXI6touGxIBihSra54RuIez0YCR4KnNND1nPoYA
	+iNgCxm64HCYR21l91zrutrg1kDJUxtnRw1FesaVile7ki2aa4hi8k8rBQ==
X-Google-Smtp-Source: AGHT+IHVOmMDAUKI+92dcoTIWT9MQ4qm+DbccYB/61rI14eV/A46EMauRl+78ehxoI9hEtwf+EDyrA==
X-Received: by 2002:a17:903:fa4:b0:236:15b7:62e8 with SMTP id d9443c01a7336-23ddb2f2bdbmr85270815ad.25.1752124270318;
        Wed, 09 Jul 2025 22:11:10 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4323f0asm9721765ad.115.2025.07.09.22.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 22:11:09 -0700 (PDT)
Message-ID: <6254d58b01b255943269948ba4853afdcb9e9318.camel@gmail.com>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf
 <bpf@vger.kernel.org>,  Alexei Starovoitov	 <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Anton Protopopov	 <aspsk@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Quentin Monnet	 <qmo@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>
Date: Wed, 09 Jul 2025 22:11:06 -0700
In-Reply-To: <f38d1a6ff69991230b929f2cad5776f500a2a57c.camel@gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
			 <20250615085943.3871208-9-a.s.protopopov@gmail.com>
			 <CAADnVQKhVyh4WqjUgxYLZwn5VMY6hSMWyLoQPxt4TJG1812DcA@mail.gmail.com>
			 <690335c5969530cb96ed9b968ce7371fb1f0228a.camel@gmail.com>
			 <aG3/MWCOwdk5z0mp@mail.gmail.com>
		 <f90ea7ec00265ab842e373a69f0ffdbb374f7614.camel@gmail.com>
	 <f38d1a6ff69991230b929f2cad5776f500a2a57c.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-09 at 01:38 -0700, Eduard Zingerman wrote:
> On Tue, 2025-07-08 at 22:58 -0700, Eduard Zingerman wrote:
>=20
> [...]
>=20
> > This seems to work:
> > https://github.com/eddyz87/llvm-project/tree/separate-jumptables-sectio=
n.1

[...]

> I think this is a correct form, further changes should be LLVM
> internal.

Pushed yet another update. Jump table entries computation was off by 1.
Here is a comment from the commit:

--- 8< --------------------------------

Emit JX instruction anchor label:

       .reloc 0, FK_SecRel_8, BPF.JT.0.0
       gotox r1
  .LBPF.JX.0.0:                          <--- this

This label is used to compute jump table entries:

                 .--- basic block label
                 v
  .L0_0_set_7 =3D LBB0_7 - .LBPF.JX.0.0    <---- JX anchor label
  ...
  BPF.JT.0.0:                            <---- JT definition
       .long   .L0_0_set_7

The anchor needs to be placed after gotox to follow BPF
jump offset rules: dest_pc =3D=3D jump_pc + off + 1.
For example:

  1: gotox r1 // suppose r1 value corresponds to to LBB0_7
     ...
  5: <insn>   // LBB0_7 physical address

In order to jump to 5 from 1 offset read from jump table has to be 3,
hence anchor should be placed at 2.

-------------------------------- >8 ---

Please let me know if this works end-to-end.

