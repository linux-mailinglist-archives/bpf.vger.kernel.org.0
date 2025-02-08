Return-Path: <bpf+bounces-50875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E897A2D8F3
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 22:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C053A4C3E
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 21:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A65E1487D5;
	Sat,  8 Feb 2025 21:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxdR39B4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C71244E8E;
	Sat,  8 Feb 2025 21:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739050260; cv=none; b=sqwDP8V1QvDRS6qS9tHkJSxOSAZAXN+HbvK7eLn8Hd1WXqH/Rr1JR/mlR7vFbjPEw5N3fcKoMuEfWbK05dXmz2OZrXeX3mU1lRwLIRFf7zyhQK4WC/KNl013cUzhl8VobzzhYAyar6a+n7D9de7DPavnHTi3qRnPQRDtaeY59bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739050260; c=relaxed/simple;
	bh=I7TWitL6B3XzA7VM4K4Rc8PviMZKmMeCw+xeYSM60uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHeftgd0bcNZFl3IXgGbe0nL4sT1EtNmT2FJwy18I/v4mTZJnhiQMlDK41IHcXHJWv2pWC226dHrHNIFwqJIDrEPShI7f7WWpm/rZ3tgU5mR1u2cSSkKBv9y9peiD8ZLhmOlYdSZbAbWxl0GcHFXcZ6buHf1bf2p6WQC1p3YF40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxdR39B4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361815b96cso21121445e9.1;
        Sat, 08 Feb 2025 13:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739050257; x=1739655057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeLogvOTrg3hgl5TU48qPOFJSwSkerHCTCM95+nKuv0=;
        b=bxdR39B4ypKR/Vn0RyKZ9gjL/vYvnS7C3QPgwG/+KdBm8CL+2PogljgPPCqtK+U12i
         ToYIhhsduxzEYdqHFNvNf/Zprtgkfo2vhx2XcDla30g9CpFOBlMqbViVE/WR041UiJ1g
         6BJd4zqkocgw4daOgQ4PP+O8EczjenW28ipFjWpYJqVEQ5EwKRGKs1qc1/txaQyzZP8c
         /GPwucAMfLU5JQ1kuyDX+hGC499ekQYcLXEJggVjv4fBUwpaPXoyyq9l7LYPhHAPWNC2
         XGLdQRy2/3NLlQ+Sd+IGwlwDwl/3Y/FV3Y2FQOAJPwK5v7MdgG4oPmHy/A5WsUzL8fEy
         4QkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739050257; x=1739655057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MeLogvOTrg3hgl5TU48qPOFJSwSkerHCTCM95+nKuv0=;
        b=OXqPLdkYQEy+XMkFGQROr5Gaht334kmKhHxBPtzVpEWLXUFUAVMsfydzJG1JKqZx+5
         g9c7NMhOy598tEWlghY5qdoNmTMZGVotU1j7u4aKfTEwuQTfkUdvKN5eQ5efCFr8btPX
         jiUK2ZhMxZGiIRNdlFcz0RZ1aLQ77GXUJtp16UH2IODsLxz/kjjb7a4gTaFAX99DtAqa
         yQ8XiNZ8+XkH7zootwXtB0cP7AWz8d31NLmYcDVCpZzyHBAdG1DAcQ1N+hOjp0Jgx3Hh
         7F7fWH1Cj1jL0Yti75t0tjn8ty7aGXk4SfipBWSemWjg4rO+P8cgGoLbFP3MqXpcZ7kz
         12Sg==
X-Forwarded-Encrypted: i=1; AJvYcCUsrJHnXRYYJ1uffYzkvEht4gcZDTYyiXABbNKtlGgNQBjrfTLQ9mjt6VxVv5knwfK2A7nZPcku2Topg+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDM0lMGuYDNTAHpKEx5Pyr4VXmRzjuReouJRScvwl/CP71r//k
	FRkJlrBIxeUMsjmoKTRedherxbxJW5yRAvkfvanKsEMVCNSYPRF4n/sLa8l5kcwXzzkqweG53nL
	23yal9lJUE6tv+mGBgZr6fNx2AgA=
X-Gm-Gg: ASbGncuFlD5hMChqEI5qEHj5IuXBqWuucEytZzrpOapbKJfLs+7+9MMupURBBrICr0j
	eB0EMMZgf+ifKdjOHLY/Ltq42+qvj9SqXPt+ipH5xS/t1YpZQzEi3ZTS06XR+iStoZ7aFvS1vxF
	nRWCbvrSyjDu90v82eMAHwfp+p1KuG
X-Google-Smtp-Source: AGHT+IEP0vhMZghv54Q+6Voz3luuHMi0bOzgdsxcCEz++Zjhl9x/NdVS4KE4GKQfNkGM7Bwk01RIJ1lfPbZtfTdWZPQ=
X-Received: by 2002:a5d:6d04:0:b0:38d:d9b3:5916 with SMTP id
 ffacd0b85a97d-38dd9b359ddmr121320f8f.1.1739050257177; Sat, 08 Feb 2025
 13:30:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738888641.git.yepeilin@google.com> <d03d8c3305e311c6cb29924119b5eecae8370bbc.1738888641.git.yepeilin@google.com>
In-Reply-To: <d03d8c3305e311c6cb29924119b5eecae8370bbc.1738888641.git.yepeilin@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 8 Feb 2025 13:30:46 -0800
X-Gm-Features: AWEUYZkrJWmpVXeIIF_fMq9Qy1erCPKH-mY9gn4_cLquOtiI9oiPRGGrxOURbaQ
Message-ID: <CAADnVQ+L0h8qXfYkC3+ORyQkXFJ2MgO8FDHr_Ha0QMAtS_ujag@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/9] bpf: Introduce load-acquire and
 store-release instructions
To: Peilin Ye <yepeilin@google.com>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, bpf@ietf.org, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	David Vernet <void@manifault.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Yingchi Long <longyingchi24s@ict.ac.cn>, 
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>, 
	Benjamin Segall <bsegall@google.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 6:06=E2=80=AFPM Peilin Ye <yepeilin@google.com> wrot=
e:
>
> Introduce BPF instructions with load-acquire and store-release
> semantics, as discussed in [1].  The following new flags are defined:
>
>   BPF_ATOMIC_LOAD         0x10
>   BPF_ATOMIC_STORE        0x20
>   BPF_ATOMIC_TYPE(imm)    ((imm) & 0xf0)
>
>   BPF_RELAXED        0x0
>   BPF_ACQUIRE        0x1
>   BPF_RELEASE        0x2
>   BPF_ACQ_REL        0x3
>   BPF_SEQ_CST        0x4

I still don't like this.

Earlier you said:

> If yes, I think we either:
>
>  (a) add more flags to imm<4-7>: maybe LOAD_SEQ_CST (0x3) and
>      STORE_SEQ_CST (0x6); need to skip OR (0x4) and AND (0x5) used by
>      RMW atomics
>  (b) specify memorder in imm<0-3>
>
> I chose (b) for fewer "What would be a good numerical value so that RMW
> atomics won't need to use it in imm<4-7>?" questions to answer.
>
> If we're having dedicated fields for memorder, I think it's better to
> define all possible values once and for all, just so that e.g. 0x2 will
> always mean RELEASE in a memorder field.  Initially I defined all six of
> them [2], then Yonghong suggested dropping CONSUME [3].

I don't think we should be defining "all possible values",
since these are the values that llvm and C model supports,
but do we have any plans to support anything bug ld_acq/st_rel ?
I haven't heard anything.
What even the meaning of BPF_ATOMIC_LOAD | BPF_ACQ_REL ?

What does the verifier suppose to do? reject for now? and then what?
Map to what insn?

These values might imply that bpf infra is supposed to map all the values
to cpu instructions, but that's not what we're doing here.
We're only dealing with two specific instructions.
We're not defining a memory model for all future new instructions.

pw-bot: cr

