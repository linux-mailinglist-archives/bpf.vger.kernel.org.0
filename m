Return-Path: <bpf+bounces-20290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5C383B75F
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 03:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 675BBB2409F
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 02:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD511FB2;
	Thu, 25 Jan 2024 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTC3uz0k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00CF6ABA
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706151091; cv=none; b=YlIIyuRSDJiuBgar/h14oTiCyZiCevBiNKc6D/flvEnqZYskgGnXRhkpK5twNzwx40KhMiWxF2ltNavfOOzKsa4nvJ0iwRPZQR8JG8y9V2EmmXqJ6muCNATyptRi9hADuDGn7bCKHDZK5Z343xv3o43B04g679ptahqdmrHQ/9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706151091; c=relaxed/simple;
	bh=OWHCaxty9B+6FiBjuIuGiPARETmu69uFU32tT9X+OM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+VnOLjXFjcBamzlQyhdyjL0STKl8F7vgK0jMQ+WVTl65c4yCkxhN9/eOL1zFn5acCLmfxvQConAMmnUHhsoPhn3kRm5H45qOJ7uHqojMjMx1a+lnsc3saWQJNmYZtqi1JLUOyVL4BxYz9HTLiAX0CZEKWOS6GVVmEGFLmCO5wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTC3uz0k; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-339237092dcso4447851f8f.3
        for <bpf@vger.kernel.org>; Wed, 24 Jan 2024 18:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706151088; x=1706755888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brWuhPv08m5IHqo2Fx2aVHV5rCfwWbI9NZG9MaN0KwU=;
        b=GTC3uz0kqt39ZF1MuX14BG61BqFam9CWnJ1hVsFrEp/c4HYTO98VpKtX2xRBwVz3Cm
         jQlkqthFa0MnGJKYJi5noDUag5sN7xsy6Xi2mfJzh0QgMYSOAGcAYYKuWBGUQTMEFa7/
         KKyYOWdPbsfZcDYfntTFYXXQZWIIDy0emnfWOA7aUK3tqYYxVC0lBAp/Iz9FkVr93IOk
         YA36Hma/IZZ+LPNvjJr/bv4T7Lsri8TX3W/Dt44vQxryAo4+41GhHOtXl2VDpd0STaB2
         FnS52nLCwsWA7bhtOWhdMgxhDLunaelolH7dY8Fu//gCXRbIp1ahwjAx1FcR4DQ3dOdW
         lF2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706151088; x=1706755888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brWuhPv08m5IHqo2Fx2aVHV5rCfwWbI9NZG9MaN0KwU=;
        b=Ury5QndZzeMUH0kno4hWYYFes4XmGGoIWERlgj8VAzExDrXB3LYszWmsX+2k9lClTj
         iKZRVbWnjrDI6uGafeB6XFROrPxLXZykVnrZfbCYmxbRuWIW5XA+sQy+sdC4/3jmvEz7
         AQBPHY4zA7BCGKHoRDmQMzJZBPoXD/78/4tF7gcVhZwdRJ1Swx2xKAlFZ8Jyhz+egMtN
         BS47r1Fa1ZuKcpuODKN/1rcUFfBW/O0QbFFvlbYMrwRKT8ObWERkXPZk9DQhbAcbBLBU
         D3XOAn+/phgwSbF97YhAc7apbKvxqSIMb/CxkGQCaIq9YbITb/Gq02wbJLDH76SeLudl
         XDrw==
X-Gm-Message-State: AOJu0YyqqUX6a/vIVcuVmQ7frBtxBJQ3rZCuO5ImvMtJgDJg9gp6nj43
	uB0IZzMILhxHHNQhmmnY9wZwgOglGTgsnyWo8eq12AmsaUHY6/zw0xf3OlmerDKdN/tXU4oD7G1
	X3iPilxW6ayBOGYlmgbTqXOSVNBM=
X-Google-Smtp-Source: AGHT+IF4VAHiiFinwZ6qaHTmt83F1jaKQA1bfTfDoTM/+zm9H1I/M2FBjrQ5st+f4+BQZl7+SsJ0C8QCgzuOh8UaIPQ=
X-Received: by 2002:adf:f549:0:b0:337:2994:15b1 with SMTP id
 j9-20020adff549000000b00337299415b1mr106934wrp.135.1706151087602; Wed, 24 Jan
 2024 18:51:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1b5d01da4e1b$95506b50$bff141f0$@gmail.com> <20240123213100.GA221838@maniforge>
 <1e9101da4e44$e24a1720$a6de4560$@gmail.com> <20240123215214.GC221862@maniforge>
In-Reply-To: <20240123215214.GC221862@maniforge>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Jan 2024 18:51:16 -0800
Message-ID: <CAADnVQLFc+32+5yTrONYhw-HGheYRK2nSEgMoteXdwc_Q2Tw1Q@mail.gmail.com>
Subject: Re: [Bpf] Standardizing BPF assembly language?
To: David Vernet <void@manifault.com>
Cc: Dave Thaler <dthaler1968@googlemail.com>, bpf@ietf.org, bpf <bpf@vger.kernel.org>, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 1:52=E2=80=AFPM David Vernet <void@manifault.com> w=
rote:
> > > > A second question would be, which dialect(s) to standardize.  Jose'=
s
> > > > link above argues that the second dialect should be the one
> > > > standardized (tools are free to support multiple dialects for
> > > > backwards compat if they want).  See the link for rationale.
> > >
> > > My recollection was that the outcome of that discussion is that we we=
re
> > going
> > > to continue to support both. If we wanted to standardize, I have a ha=
rd
> > time
> > > seeing any other way other than to standardize both dialects unless
> > there's
> > > been a significant change in sentiment since LSFMM.
> >
> > If "standardize both", does that mean neither is mandatory and each too=
l
> > is free to pick one or the other?  And would the IANA registry require =
a
> > document
> > adding any new instructions to specify the assembly in both dialects?
>
> Well, if we're standardizing on both, then yes I think it would be
> mandatory for a tool to support both, and I think instructions would
> require assembly for both dialects.

I think it's obvious that there is no way we will add gcc's flavor
of asm to kernel and llvm.

> Practically speaking that's already
> what's happening, no? Both dialects are already pervasive,

They are not. There are thousands of lines of asm written in pseudo-c
used in production applications and probably only ubpf/tests and gcc/tests
in that other asm, since gcc bpf support is not yet in the released gcc ver=
sion.

There is also this asm flavor:
https://github.com/Xilinx-CNS/ebpf_asm

Which is different from pseudo-c and ubpf asm.

I don't think asm syntax should be an IETF draft.

