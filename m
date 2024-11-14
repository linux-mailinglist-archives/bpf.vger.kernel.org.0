Return-Path: <bpf+bounces-44884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA3F9C951D
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 23:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9AF0B24B07
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 22:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3ED1AF0DA;
	Thu, 14 Nov 2024 22:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUsxOT+K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD451632DA
	for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731622850; cv=none; b=qn4v1Aa5GS1Er0+jAnlqLlFtHZyCPqGcLLrOecxrHl04bdZb3puVcgxGu2jvDZX6wY2DwqmZjptS0oPFtAuZDKtnpUuhNo6GSxhLk7aFlEb1Yb/sa86c6/JXlgtZCT5pf5B2ZiN+dIHjaJ/qzkwkBSj2vkeQ4UkZBH4Wo9G70U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731622850; c=relaxed/simple;
	bh=0cDD90WnpjDjEM7Lcr63IVJj0Ht4dVKRjsTKRYpdZjM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NA0g22qSb0aJ9XUSkW6Cx9AAvPxtKRlF0WCAYBCcorkOZbp1oMZz+bWw+a4PhZpLa0SUdWViEMnW/9S3qP+Qc3pVyJqPUCkIv07gWpTCBf+pGejAIztbi4PAv4PC4H+qNKKYMnhEXU287/pyNvUTWI9+TesW8eYGJmBb+SywsRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUsxOT+K; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-720c286bcd6so1022233b3a.3
        for <bpf@vger.kernel.org>; Thu, 14 Nov 2024 14:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731622848; x=1732227648; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4DRiJrAZAuoUYWy1Pw1yQ9xARlIsbZRqhoiCSiXtaqc=;
        b=MUsxOT+K1dc0TiWiUwfpB9xk1umC7o/EaWZOSzkaDyV6LGHJLIVsy7wDK7qXvEveZD
         oOFMbd/jiwHss7HhisUbNPn7iC2SXyRoftbrOemgR+UI5l0ch3nv37Ix+R+IPxCup5QW
         5LcnzoPc3eWYmyLy+Z6ZZTC07hEi4dQirO1HYXSIMxMQ7ENIXm/bvI45Bzx/tDyQeMke
         vqK9U+Bh5OyyMyBXSBprSQu53HOhR8n8UiLatxajlZ926d5Kntdl8W0Sr3Qkptj4zyct
         YkNJJfCVbBjJo/XKpk22SjCOSZhDovmQazOkmeUQtb3Dk5bHIBq5mM65jADYDLq0sD0h
         mMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731622848; x=1732227648;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4DRiJrAZAuoUYWy1Pw1yQ9xARlIsbZRqhoiCSiXtaqc=;
        b=kU8O0ClN3Y9grq3c4amIur8+n8NEHIlWCtFe/WpB/+7yqNcEQUSSLieVbtcKZfpY94
         9skD9aMTS4yA23D+pPs8urF1n9TlziNMlppwzI7dU1/qMczCukWN1S08CDtAyRniZsWr
         Jp5qLM4ewx5VVc0Ib3Op0M3Kbv6SjsRULcZ6HNsWfJljvdxPv4u1MWYTIoBsmfhojmYM
         th+I2qoHMAX+FCiZyU1EJWWt5IRFcigUxV4+HEll+bQDoOD2CU1wMWt84lFohOp3iQfH
         1t6iKp/zFBXtJ+0FRZVhCKbpfe2L3qrZcqrWltxx3yWJhpRaDr65XV0sw6Iif6J6vEsv
         /FJQ==
X-Gm-Message-State: AOJu0YwqXdkZRdUq2OuW/762fQ0pcWqsUgiPvUtODRiC9iTjVZRo3sQy
	ssYYx8Tdqpp4iTNKppIKYltijcVQow9q9gRJNumHMvTLeYNzsXAH9QPgEu1g
X-Google-Smtp-Source: AGHT+IGq+H/or0t4b4Kz6CpD3lMfGVv0C02cFAtVky4LPRsFmamEMgYTc8YVdHwLh13jA9znhGWOXg==
X-Received: by 2002:a05:6a00:1393:b0:71e:7b8a:5953 with SMTP id d2e1a72fcca58-72476cb4154mr602208b3a.24.1731622848221;
        Thu, 14 Nov 2024 14:20:48 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1afa67bsm142502a12.0.2024.11.14.14.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 14:20:47 -0800 (PST)
Message-ID: <0f0cf220fa711f0bd376bdb167c035e53dd409f9.camel@gmail.com>
Subject: Re: [RFC bpf-next 01/11] bpf: use branch predictions in
 opt_hard_wire_dead_code_branches()
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, memxor@gmail.com
Date: Thu, 14 Nov 2024 14:20:43 -0800
In-Reply-To: <20241107175040.1659341-2-eddyz87@gmail.com>
References: <20241107175040.1659341-1-eddyz87@gmail.com>
	 <20241107175040.1659341-2-eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-07 at 09:50 -0800, Eduard Zingerman wrote:
> Consider dead code elimination problem for program like below:
>=20
>     main:
>       1: r1 =3D 42
>       2: call <subprogram>;
>       3: exit
>=20
>     subprogram:
>       4: r0 =3D 1
>       5: if r1 !=3D 42 goto +1
>       6: r0 =3D 2
>       7: exit;
>=20
> Here verifier would visit every instruction and thus
> bpf_insn_aux_data->seen flag would be set for both true (7)
> and falltrhough (6) branches of conditional (5).
> Hence opt_hard_wire_dead_code_branches() will not replace
> conditional (5) with unconditional jump.

[...]

Had an off-list discussion with Alexei yesterday,
here are some answers to questions raised:
- The patches #1,2 with opt_hard_wire_dead_code_branches() changes are
  not necessary for dynptr_slice kfunc inlining / branch removal.
  I will drop these patches and adjust test cases.
- Did some measurements for dynptr_slice call using simple benchmark
  from patch #11:
  - baseline:
    76.167 =C2=B1 0.030M/s million calls per second;
  - with call inlining, but without branch pruning (only patch #3):
    101.198 =C2=B1 0.101M/s million calls per second;
  - with call inlining and with branch pruning (full patch-set):
    116.935 =C2=B1 0.142M/s million calls per second.


