Return-Path: <bpf+bounces-62881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 378F4AFF93D
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 08:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E5D1C82CD2
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 06:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D202287276;
	Thu, 10 Jul 2025 06:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOQNwlyg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F948222584
	for <bpf@vger.kernel.org>; Thu, 10 Jul 2025 06:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127497; cv=none; b=QXXkGVIuWV9j5gCQU3qRQg7be34oyLjFW4pNKfcH72UnBu9rsoja/d5RIVPmCtmE/1ZpVRMTZpMrEmGfyN2Rak4PdQQZvpxbDExrgvQmovqAk1O01KWLdd825Avm4wxms46rDn025zOddPQUbAKJuFn1ydkFjII8/AaqVLLLsZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127497; c=relaxed/simple;
	bh=9yN45ecdkt3uE1LB+tupJv2FyYmz4yS9IpBeBlkBWAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBkFrLjQrEoOQP8KIZKUuNJH8AqJcou428KAtqxSitT8MY4MxZ6ntUMM4YjtvtyfCNh5r7ylKpCpOcMQ4kmkmYQtpeJngICB9H7TpjQ0BnPF6PQycO4YInSdpNboQiDaScMnD/U0bsim2bX7HHEUGdZzwVvq+xkmS+OitOYoipY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOQNwlyg; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a5257748e1so473371f8f.2
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 23:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752127494; x=1752732294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LFuChD9VNWu9zQJjX95eZz1Ida+D11ckR7ybbozqpsU=;
        b=OOQNwlygizg/CZK/A4bg0kkXE7Qa9yIKr9wsEILGiBxqxc5YupqxjOPAe0b0cJmJdx
         zpy7wrapyXkUCc/yRHqvFiKQMaGMA4RblpK96DtJTzEL71RETBs9P6wC8a3lXe1KFOHl
         xHQdlEGTu313EkDXnOydkV6mmgdUhzp/OTLP+pnMUWc+d2NY87ycHm5sNXixBuuyETRy
         UvX3TlluCDGUqnIbq9HSMaE8f5evRFgLZUjjxRuiuEeLKjh6tXa6I8dsBKFoas5ESEwk
         PNokK7OSyh6bmjT60yHYGroh8Lb6m831yjsR7dwyn0O8m5OS/a00kbCNoDB+6GnOkIdK
         IuGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752127494; x=1752732294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFuChD9VNWu9zQJjX95eZz1Ida+D11ckR7ybbozqpsU=;
        b=ZoB5hDKDO796vI5WuJrUw57tkZJLhbdLyQMXdsQqKDY87Afyo3Ib2RMnCZPEJOjRzO
         iqRwjaaVTLX7vk/sWVxTMvX+/spXHGKRlgxzHeawoj6R4XVgppoKM2IyetovdfrM2qU2
         IwGHno277c3jkh9NNRItr+ka4AZPR2b4ppX1x0m432Vn4SkFHNaGqLY+Mch1rZeSl7AE
         +PSzRPTyNxjQWiG9g+aucXMY+D3nq4YM5HXIS4D51Iud5mlEfoOQeGW5SUrcTLyUL+kw
         0CHhfuJurfLWF4P4gIZ6RTd1iGsXoUMzGM+EkarfTchnH6y4rg0UA77f73E3G7o0FXSE
         mZdA==
X-Forwarded-Encrypted: i=1; AJvYcCXCmsVFp4czfWEk3reaXczVyfYI60K0PbvDZ5qYG2ostE/4XkJbl7fNo1JiJ4rMFiTvzXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKDQRlMhgkLurxoJ61LWv9OthcU8dSxHuzSDk9vLh7nkWGApiN
	8B3js1xCx58H7DPtDwltZbXjcI9NMshyCQoYAJbenS52na8SFDMH+4P2
X-Gm-Gg: ASbGncvvhY2seOVfB02xxXw4GApBwr4fKxUFjPxYHYfnFix8Dw6nIwLpi1O/Svvd3q4
	TK8TZ0s3/myb5+UnIEmX7P/3OPF5duQadTTFHezU2GffGaNrR3G9r6OWNwzo7Q4V0n/oNyIx43L
	BjQFgFkfe8NJKII2Efr+uZOSpthtwsDEXqCtRNwtErq1AQ8nlOcnRdKEElT+KuiyFj6bufFc1V3
	cWH4YtTXHk7OrGdaqFxInLUD53Fhu8TvmbmxH9z4HicopCpTejQUx1ih5DCJRHYqBE6c2Qz0PX3
	qj6/XWmB6eCf8GHsaOAhtznwWyPR/ABZBLC5EN/xjP7XALbGy3AWjkz4EtAe8yBOMs1wAP/4qA=
	=
X-Google-Smtp-Source: AGHT+IEdCwNkf3Cu1b2yxjbj03D20i0vXHe7E/ycBc96geLv3Ck0zhMDnPVIh1xWLpCwhii9/ahkbA==
X-Received: by 2002:a05:6000:643:b0:3a4:f72a:b19d with SMTP id ffacd0b85a97d-3b5e866ca30mr1013507f8f.8.1752127494190;
        Wed, 09 Jul 2025 23:04:54 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e1d5sm878963f8f.78.2025.07.09.23.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 23:04:53 -0700 (PDT)
Date: Thu, 10 Jul 2025 06:10:38 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
Message-ID: <aG9ZXg6z3HC2ycZq@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-9-a.s.protopopov@gmail.com>
 <CAADnVQKhVyh4WqjUgxYLZwn5VMY6hSMWyLoQPxt4TJG1812DcA@mail.gmail.com>
 <690335c5969530cb96ed9b968ce7371fb1f0228a.camel@gmail.com>
 <aG3/MWCOwdk5z0mp@mail.gmail.com>
 <f90ea7ec00265ab842e373a69f0ffdbb374f7614.camel@gmail.com>
 <f38d1a6ff69991230b929f2cad5776f500a2a57c.camel@gmail.com>
 <6254d58b01b255943269948ba4853afdcb9e9318.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6254d58b01b255943269948ba4853afdcb9e9318.camel@gmail.com>

On 25/07/09 10:11PM, Eduard Zingerman wrote:
> On Wed, 2025-07-09 at 01:38 -0700, Eduard Zingerman wrote:
> > On Tue, 2025-07-08 at 22:58 -0700, Eduard Zingerman wrote:
> > 
> > [...]
> > 
> > > This seems to work:
> > > https://github.com/eddyz87/llvm-project/tree/separate-jumptables-section.1
> 
> [...]
> 
> > I think this is a correct form, further changes should be LLVM
> > internal.
> 
> Pushed yet another update. Jump table entries computation was off by 1.
> Here is a comment from the commit:
> 
> --- 8< --------------------------------
> 
> Emit JX instruction anchor label:
> 
>        .reloc 0, FK_SecRel_8, BPF.JT.0.0
>        gotox r1
>   .LBPF.JX.0.0:                          <--- this
> 
> This label is used to compute jump table entries:
> 
>                  .--- basic block label
>                  v
>   .L0_0_set_7 = LBB0_7 - .LBPF.JX.0.0    <---- JX anchor label
>   ...
>   BPF.JT.0.0:                            <---- JT definition
>        .long   .L0_0_set_7
> 
> The anchor needs to be placed after gotox to follow BPF
> jump offset rules: dest_pc == jump_pc + off + 1.
> For example:
> 
>   1: gotox r1 // suppose r1 value corresponds to to LBB0_7
>      ...
>   5: <insn>   // LBB0_7 physical address
> 
> In order to jump to 5 from 1 offset read from jump table has to be 3,
> hence anchor should be placed at 2.
> 
> -------------------------------- >8 ---
> 
> Please let me know if this works end-to-end.

Thanks! I will be testing this today with my patchset.

