Return-Path: <bpf+bounces-70770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 824FDBCE4E8
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 20:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50BDB4F9817
	for <lists+bpf@lfdr.de>; Fri, 10 Oct 2025 18:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2F9301492;
	Fri, 10 Oct 2025 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKDoPdTN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0257620A5DD
	for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760122530; cv=none; b=dEIA5MZ9xK5aYTC7SPJVoCKmkskLU3CWvc1jbkTdPG7j5QhvMWVMHRfZ2xgTUHZOgk3FXze7HRxRgV/0BgGn95vT4SW5ZJ0eGJeeCOpFP/H2OFcAeT4VBf583gkmwQZ8IzsyyJk81UE6yhsdHx9OekGGRpTKAUTBnI8FDjGn5hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760122530; c=relaxed/simple;
	bh=npVbrD9jcPN3MO54+Q2/A4DReVoNnNeo91JkHkudlto=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hge/zjemtL7W3aPJDm6JEjPl41MmeCXHbcuSpq7BtdkDMU9eG+CCS2kFxDeNrmMUUXQd1elvp8K2cB+tcWlAV0Yzs1ufUg6KmwlgeG3bGJaQkrsXOmu5R0uuqYsRbTZ+GrfILN74J3azzxu354lG/owCKWlLeZj35hG6LwAh7MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKDoPdTN; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b554bb615dcso1623880a12.1
        for <bpf@vger.kernel.org>; Fri, 10 Oct 2025 11:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760122528; x=1760727328; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DlaJ/6AvVXUkXGRj+5X+fFEMgNImOtajCd+PpnPQ/h8=;
        b=OKDoPdTNBG70+u9wQrtEec9kevxOTxbTsd2yNTJfNp19hoZNmVi/RousvW5250ANgL
         TK0Tv+D3h+CWG85nHYS+qUX5zb29+aNdYgit5gnWTZVDMxpo5aZfynVIm2sOhNi8/Rhg
         nMyzL12smtwu21gL2nqPM7SbKuL3zcCBMlsOCA4Q/37VuhYA+/iidjRpEMFi/PY9s/Eh
         B8Iq7brsdhNOVIBCHZB3+bPKXiqEmU1QowJM2aqmPzou38OYlTkXDgZ7347RVLbPIZf6
         2MQhV5J4hpcyq3t9Ne9jJAEllCwHMOBwwu15lXYtRm8m0RxKd6x9QE/yBYCKFqc14uXT
         4xoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760122528; x=1760727328;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DlaJ/6AvVXUkXGRj+5X+fFEMgNImOtajCd+PpnPQ/h8=;
        b=si94KM9/leW7AxLCDX98uHHC7kJ6GKjg6Rdy4+A1I2F50Y5pwdz4nYhps0AGM1q0mE
         1cf9a1w9oj1jahkJDQoDP7Je4+YeFMBPKIE9q2XIrxU7J9rpBqYQRyNu9S14IdF+l9PW
         222HPu/1+wvoAgarOn9M5BT3dx0k0EJE2qbjGW6yU8A4oFr2G4K0mSCcqJixYzHAquxw
         n1bsp4+EGMDxIXe6wd+nPmfr+j4gQcH586y2psv/W8/4gHND7KBmG4tW2oZkdfyoByzX
         0mWDQXx+KB5jgp2CeSe5saiApeYDbxiY49kwXVQWiScl8Z/AgUc4q5GXoY3bRKwbvU9L
         J+uw==
X-Forwarded-Encrypted: i=1; AJvYcCUAXkffcTOhG/8Ggl5WqqjfD9w4h3tIkFQNYPQ767RZ6cW+n+cIxQT4fWggWJaT5t4kBw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoJQFU+DKqRicJYLbgYuJ59VpCkAovFc9SksEFS9suybH9ND0N
	ObpdMtc/H8gQgaGAob1gJDElTmcSHavvxM5GhZ8IOvWs4R/z1Ify+DlZ
X-Gm-Gg: ASbGncvaaWcz48Wzn64mtS3ITW6NE7YQ4rE0BIUMglbPXdZvXF0rVZG6ojkFl5MLrMW
	p3/QeIshlxNWISCxHkcrN4uONTX12zEO4H+ciGLcsd6H1kNSNL6swazhJNg8U1uEGATyEc8usGt
	5ESlxVuGEsnDDMqKArgNvWDDqIrplhi6G3rk5B/fAEg75D2L8SjL8Penp37mRhTs/7Ycxgqsvbk
	qHW1NiBScQh+yskFTzpe5Q9fJVnNgXLEP9liawTjwLhu54rToYRI94kZxfrLsr+N9zsWNQ8nvvo
	QgW0BMRF2zYCz4SbPMMpdKbStbYVch1it/X1OJULgZ7DnYZTi/lvLwYqOpxrm8jSa6IY3Rs+BbK
	LFP6afUlwarFYzVlTQiH2AtM6BIcAUVUzQltD29yYv27IW3cZo5fA797+v6yE29LxUw==
X-Google-Smtp-Source: AGHT+IHeWKPLJf1YnZgJ8mQxBiUkHyLKgv/P+D1FaJ/vyeBufx1XcfVPQPq0hF9mfyos8PqBo/MJBw==
X-Received: by 2002:a17:903:1aa3:b0:269:9adf:839 with SMTP id d9443c01a7336-290272b3357mr162724315ad.19.1760122528050;
        Fri, 10 Oct 2025 11:55:28 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:ddee:16b9:c5d2:a3a9? ([2620:10d:c090:500::7:25f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034dea083sm64462435ad.24.2025.10.10.11.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 11:55:27 -0700 (PDT)
Message-ID: <f9be7eda8fb72ad6a7a730023244409ee065ea60.camel@gmail.com>
Subject: Re: bpf_errno. Was: [PATCH RFC bpf-next 1/3] bpf: report probe
 fault to BPF stderr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Menglong Dong <menglong.dong@linux.dev>, Kumar Kartikeya Dwivedi	
 <memxor@gmail.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, Leon
 Hwang <hffilwlqm@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Menglong Dong	
 <menglong8.dong@gmail.com>, Alexei Starovoitov <ast@kernel.org>, bpf	
 <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-trace-kernel	 <linux-trace-kernel@vger.kernel.org>,
 jiang.biao@linux.dev
Date: Fri, 10 Oct 2025 11:55:25 -0700
In-Reply-To: <3349652.5fSG56mABF@7950hx>
References: <20250927061210.194502-1-menglong.dong@linux.dev>
	 <0adc5d8a299483004f4796a418420fe1c69f24bc.camel@gmail.com>
	 <CAP01T77agpqQWY7zaPt9kb6+EmbUucGkgJ_wEwkPFpFNfxweBg@mail.gmail.com>
	 <3349652.5fSG56mABF@7950hx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-10 at 20:05 +0800, Menglong Dong wrote:

[...]

> save errno to r0(Eduard)
> -----------------------------------
> Save the errno to r0 in the exception handler of BPF_PROBE_MEM,
> and read r0 with a __kfun in BPF program. (Not sure if I understand
> it correctly).
>=20
> This sounds effective, but won't this break the usage of r0? I mean,
> the r0 can be used by the BPF program somewhere.

What I meant is that for cases when someone wants to check for memory
access error, there is already bpf_probe_read_kernel(). It's return
value in r0 and is defined for both success and failure cases.

The problem with it, is that it has a function call overhead.
But we can workaround that for 1,2,4,8 byte accesses, by replacing
helper call by some `BPF_LDX | BPF_PROBE_MEM1 | <size>`,
where BPF_PROBE_MEM1 is different from BPF_PROBE_MEM and tells
jit that exception handler for this memory access needs to set
r0 to -EFAULT if it is executed.

The inconvenient part here is that one can't do chaining,
like a->b->c, using bpf_probe_read_kernel().
One needs to insert bpf_probe_read_kernel() call at each step of a
chain, which is a bit of a pain.  Maybe it can be alleviated using
some vararg macro.

[...]

