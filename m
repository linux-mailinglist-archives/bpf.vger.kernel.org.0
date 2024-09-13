Return-Path: <bpf+bounces-39859-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D498978915
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 21:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B79C21C22CE4
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 19:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF6D1474BC;
	Fri, 13 Sep 2024 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrdLjmlm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55D984DE4
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 19:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726256655; cv=none; b=Eb/pfB9rxqe6aJuIMHiXvrx504+Wb+I4BcOSyfeDKbd2ba20co8kbMrCZtuU5bz7h64jMS1RRsWrcrbtibJThOrM9tdZtHP1mQ1xSQ5f+M/pkYDH5TdQFcHQhq76KMkpsu3NGglS8ueIUMIfHEbDLQnkDW2R8GepDYCwAP7htpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726256655; c=relaxed/simple;
	bh=WDqChenHl39+IOAZ5EkSyJdJoNGnpuFYJgXoGpCO6QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEC8Q6HzkssUalq6XCTQSIiPYBGY//dLna2wkGV7rfOZrjLuHd3Kn5rC+Lal/KcCr0vQiRvhLyf8DjyXNCCPVJUem43S4V2lVXESv9noSzWK6lieXxIMII0ZZ/9OgyzqWptQZ1FthPI7BJdmO7wKGMWnaOcdHvcwZ6hbYXfs+9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SrdLjmlm; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-374c1963cb6so1724453f8f.3
        for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 12:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726256652; x=1726861452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2teaB/SNolWfLn7iNKZSt8/xKyIJgK9ssBPsBFCoN6c=;
        b=SrdLjmlmq5g+yf+uUF6rs+1x7SAqhAsjEczoMGRybbuj5R1e8gUPeyg8Qe4SFDRaZU
         pchKDsTR+S1O2qFd9efhhOLfYKOOYPpx+tv31uOkRMS0NSGnA/16chToSG4mfqs55QBG
         +U/dPOA5fKzFslJyFBc9wKrNZ51tbuYZIN1YeBjiWWYsFUcNR1F03bh+nZncClqgor14
         cNPZrFuSmCpokiUrlUuIKcdUrFF7GbjC9DLYb+bVWxS7/ZS1Wbfl3wj8lrFi4/7beFW8
         umsJHsHMupn2T3mGFcHy4XIrSRtz9L0oSBzpNJIshBCUK7ONTWNz88ElGj4RisFb6/Au
         uoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726256652; x=1726861452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2teaB/SNolWfLn7iNKZSt8/xKyIJgK9ssBPsBFCoN6c=;
        b=rMpTVmkuERMJLuAYl+C2F/wy9B9aSdNhNfD0qzlxl9fPq9Mdng6vF/CSe5CJZRJ3oP
         Y0SaOwgJkVdgyQDtdOJtpGpTungk7lLqGTzVGaokWLuAK7l5mr0fYJzSdNF3oRDj4CAD
         YLxeZU9ZJOJ66Cj9fZdlf722KW7igU2BBDS/bMax9qaYBegYIzm7kzvFSjxGD/ajt/AR
         eWiZKcCz1lwRHVvJM/u6lCmiEeKec9wSOogECvgML88VPTmjPt5cOqasswG0yjEF2Ztn
         1oQieGgkPKWya3aM5/1zuwc8izuWczCvlzUrH7g68YEh/BI85nXNnLeIaJTDZg+OB9FU
         CZdQ==
X-Gm-Message-State: AOJu0YxWSTNv8Y9WRvL+ejoKDjsQJWuCsA9hETy4MTw6u42/+ig8TV+K
	vULp5WZzoDy5SnqZYu7/yZYIvDW/F12LRrvygEUuz0v0HXQWpN9mJyZcKPqsv12Cz4SzJSgE+rk
	SGojiAek8iC2sYW4Kp1B5eLZbifk=
X-Google-Smtp-Source: AGHT+IG9ohVuu+z4/pM7chNqDLfv7tT8/xK4ANn53VKA6t737CLpx2FpPUR7KRmGZphRKMVHDqa0zRY9LpLQ0OpZvjA=
X-Received: by 2002:adf:e684:0:b0:374:c56c:fbb4 with SMTP id
 ffacd0b85a97d-378c2d0627dmr4421750f8f.22.1726256651603; Fri, 13 Sep 2024
 12:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913150326.1187788-1-yonghong.song@linux.dev>
In-Reply-To: <20240913150326.1187788-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Sep 2024 12:44:00 -0700
Message-ID: <CAADnVQ+RgqfSTOoWVVokk5zXkeUE1ZxF_neH=HMyKwEeFAJ_aA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fix a sdiv overflow issue
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Zac Ecob <zacecob@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 8:03=E2=80=AFAM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> +                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU)=
 |
> +                                            BPF_OP(BPF_ADD) | BPF_K, BPF=
_REG_AX,
> +                                            0, 0, 1),
> +                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32)=
 |
> +                                            BPF_JGT | BPF_K, BPF_REG_AX,
> +                                            0, 4, 1),
> +                               BPF_RAW_INSN((is64 ? BPF_JMP : BPF_JMP32)=
 |
> +                                            BPF_JEQ | BPF_K, BPF_REG_AX,
> +                                            0, 1, 0),
> +                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU)=
 |
> +                                            BPF_OP(BPF_MOV) | BPF_K, ins=
n->dst_reg,
> +                                            0, 0, 0),
> +                               /* BPF_NEG(LLONG_MIN) =3D=3D -LLONG_MIN =
=3D=3D LLONG_MIN */
> +                               BPF_RAW_INSN((is64 ? BPF_ALU64 : BPF_ALU)=
 |
> +                                            BPF_OP(BPF_NEG) | BPF_K, ins=
n->dst_reg,

lgtm, but all of BPF_OP(..) are confusing.
What's the point?
We use BPF_OP(insn->code) to reuse the code when we create a new opcode,
but BPF_OP(BPF_NEG) =3D=3D BPF_NEG and BPF_OP(BPF_MOV) =3D=3D BPF_MOV, so w=
hy?

If I'm not missing anything I can remove these BPF_OP wrapping when applyin=
g.
wdyt?

