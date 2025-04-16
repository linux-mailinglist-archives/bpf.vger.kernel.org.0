Return-Path: <bpf+bounces-56020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D858BA8AD9E
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 03:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5502440FC2
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 01:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A62227BB5;
	Wed, 16 Apr 2025 01:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcCe6TsA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2AB1487F6;
	Wed, 16 Apr 2025 01:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744767851; cv=none; b=oTgo/JLAI0ex/852F4LcLz76Fya07RXgcxuN/v+55xJ1c6elBc1mQ1aYnrmFFP6/9XnOh/qG+QJhNqxgfY1ZTdaDihcXMDLTQUezGI0ecK8Pi/ARM5IXJQGVxuwf8Ct51qHLkIJ0vEInLjbhmo+moqE7DpB1/OACzkN0TGb4LFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744767851; c=relaxed/simple;
	bh=GEMcvyPiZzpSS7hXVD07wkYpGnCUHENPQn8LCsdj+AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rd3MVdaIs2oWNdvnV35jbFlLFvHaMp7cmcLlR5WaBOLZVLQVnzm0OpIuYMyykNZxlTNdJEg0pM8peR9CVOsz5FPv+fonDgDOavaNfY6YERGNHrXXRQvcSv7fbMbYKGw0UnDqp3P5PluVS957ukec3yHA0MJgKVgpgIoRt45w/J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcCe6TsA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso60112345e9.2;
        Tue, 15 Apr 2025 18:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744767848; x=1745372648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPi3hjYx27/qXOgWPVJYl+kJtHh8j7ve528OXx4eSSM=;
        b=TcCe6TsArotkGcYh6jNiNJDQbsrXcVB4Fktf1yxPOe/DjTRMX2K8TCkS6ttXlZrMwM
         V3LbPjwOTqmeizQUpqj7Fa+6B5IoVhwwRo+3WSuxYiZ+Kd6h8/EsXKJvvG9W4kN18fn8
         eWN1C5njxp48wPDHT7TStrROl/mp91jkl+yynVufeXMX0SxVLlPLIl8dRmhdxpkyt3NJ
         xOwaO5XBQISaidSIhrd3gdME5U3pIHYo88K8fhff6Vz3K7BuSCugAdb2PonjPxCfskwe
         c9Up2bKJqaHp2ohbbkc5/en/3tfp7FNptytHlkYDbzQqUBCfBoJHK4UUDRTLzLl19klF
         +10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744767848; x=1745372648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPi3hjYx27/qXOgWPVJYl+kJtHh8j7ve528OXx4eSSM=;
        b=og1pQOit076YS8PeI34EXPeUx1XQqYTDeUq3N135oGbAUkn1ZAaOIyc3JW+N4Ph6FC
         mwYweZ+nTjP6lHLDJT44ZVPSx6pxdtBvnYbk93jFKp+UczD3mTNsab5WLzAWspQxhtDx
         n3wO5oEl6T6LphQpwFcf89jjsCoktZJsKItfpUEbsGAUerbie6gHvxmT4k9dliaBKTL5
         Q5QRO5j2KNlsZQek/Mv1hnJtTg0D/S4p5GHnI6akh/qL3uQ70/NsHXqha3wYZBNqPMa1
         cXqMOzNnNK4DUeEXq49LflWkgGfZ8m7rlODT1ZwzuBx1ZMDW9JwwBMVxvybXa8SUEp7W
         kkWA==
X-Forwarded-Encrypted: i=1; AJvYcCVHxDxn/6LfQRVs4AKKDROaZ+vJXJ5oiFnpmQvOx7kaX8a8vOUnujhjy5bJIDqMIAvuVBYbr/qS@vger.kernel.org, AJvYcCWJs2lFCfRGBsEAPJZ5MRtstCGaX2Eozv+VKeAvFbIAy6/2/a5fW/Oz6V2JAhMiuSnJcrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNhQ9cm1B28x1rJTZqkrZDskIRmFcQ/Rb6KRBFAHcyw9SkkjUa
	7+khBADmUM+1zTgluhKHDQA0gBTQ8rjRxB/bZCBLkWNM0VngT3n+TpPRBJbXR5VtJggZ6oLKCUX
	sETmtzfU0Gtrdy331wHiaKNpdi7A=
X-Gm-Gg: ASbGnctOiXNAoz+j45O6nVfKgbFK8Rwj5jcOjspApcgfttdWn6rp2KT9sz/FJJt4Qnp
	J6mQ/4UhhTttmxoFDpD3GtMOZpu3mN7zKQNIQH9BoQcosb2bE/KojFUcpfYSz45VIn+v9vFBrbT
	jrMBd2UHb2Llq3DJ7be2X3qyliBvIPyYl/wcoqXVktPX6s5OkF
X-Google-Smtp-Source: AGHT+IE/js+WvJk0YVdmLgPoAFzJj83+zkdgW3yVOeRnlofyqMsmumrHQaU2cQSpGc964R/DcsUv0v6a8meUbIIhefs=
X-Received: by 2002:a05:6000:258a:b0:39a:c9d9:8f95 with SMTP id
 ffacd0b85a97d-39ee5bad5f7mr28382f8f.52.1744767847931; Tue, 15 Apr 2025
 18:44:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415163332.1836826-1-ihor.solodrai@linux.dev>
 <3cb523bc8eb334cb420508a84f3f1d37543f4253@linux.dev> <02aa843af95ad3413fb37f898007cb17723dd1aa@linux.dev>
 <CAADnVQ+5_mqEGnEs-RwBwh7+v2aeCotrbxKRC2qrzoo2hz_1Hw@mail.gmail.com>
 <b787119e15a218cc10a850f2c774fd328d53ef55@linux.dev> <cfc371285323e1a3f3b006bfcf74e6cf7ad65258@linux.dev>
In-Reply-To: <cfc371285323e1a3f3b006bfcf74e6cf7ad65258@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 15 Apr 2025 18:43:56 -0700
X-Gm-Features: ATxdqUFnxByBQJSfSW0RZ_Yv0qNfFs4GYbYzuwMR0MYe9WLQw5XeNU0Jkbo6BmY
Message-ID: <CAADnVQJqnOO0fPn00w=xePAP6qqP32GxR3jZYWsmOXnNS6A2Jg@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: remove sockmap_ktls
 disconnect_after_delete test
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Mykola Lysenko <mykolal@fb.com>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 6:10=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> April 16, 2025 at 01:37, "Ihor Solodrai" <ihor.solodrai@linux.dev> wrote:
>
>
>
> >
> > On 4/15/25 10:05 AM, Alexei Starovoitov wrote:
> >
> > >
> > > On Tue, Apr 15, 2025 at 10:01 AM Ihor Solodrai <ihor.solodrai@linux.d=
ev> wrote:
> > >
> > > >
> > > > On 4/15/25 9:53 AM, Jiayuan Chen wrote:
> > > >
> > >
> > >  April 16, 2025 at 24:33, "Ihor Solodrai" <ihor.solodrai@linux.dev> w=
rote:
> > >
> > >  "sockmap_ktls disconnect_after_delete" test has been failing on BPF =
CI
> > >
> > >  after recent merges from netdev:
> > >
> > >  * https://github.com/kernel-patches/bpf/actions/runs/14458537639
> > >
> > >  * https://github.com/kernel-patches/bpf/actions/runs/14457178732
> > >
> > >  It happens because disconnect has been disabled for TLS [1], and it
> > >
> > >  renders the test case invalid. Remove it from the suite.
> > >
> > >  [1] https://lore.kernel.org/netdev/20250404180334.3224206-1-kuba@ker=
nel.org/
> > >
> > >  Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> > >
> > >  Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> > >
> > >  The original selftest patch used disconnect to re-produce the endles=
s
> > >  loop caused by tcp_bpf_unhash, which has already been removed.
> > >  I hope this doesn't conflict with bpf-next...
> > >
> > > >
> > > > I just tried applying to bpf-next, and it does indeed have a
> > > >  conflict... Although kdiff3 merged it automatically.
> > > >  What's the right way to resolve this? Send for bpf-next?
> > > >
> > >  What commit in bpf-next does it conflict with ?
> > >  In general, avoiding merge conflicts is preferred.
> > >
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/co=
mmit/?id=3D05ebde1bcb50a71cd56d8edd3008f53a781146e9
> > https://lore.kernel.org/bpf/20250219052015.274405-1-jiayuan.chen@linux.=
dev/
> > It adds tests in the same file. The code to delete simply moved.
> > I think we can avoid conflict by applying 05ebde1bcb50 to bpf first,
> > if that's an option (it might depend on other changes, idk).
> > Then the version of the patch for bpf-next would apply to both trees.
> > If not, then apply only to bpf-next, and disable the test on CI?
> >
>
>
> I'm not sure whether we can cherry-pick the commit to bpf branch.
>
> I believe it would be more convenient for the maintainer to merge the
> patch that only removes 'ASSERT_OK(err, "disconnect");', as this change
> will not introduce conflicts with the bpf-next branch.
> Once the bpf branch is merged into bpf-next, you can then remove the
> entire function in the bpf-next branch.

Let's do that. Pls prepare such single-liner against bpf tree.

