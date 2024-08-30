Return-Path: <bpf+bounces-38567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB9396666F
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 18:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A7AB26539
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 16:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7C91B3B1A;
	Fri, 30 Aug 2024 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHTAIkQl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2516D192D94
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033847; cv=none; b=mOsVVfv0tKRLRfsGH0q10FmgoNheYH3UypJOcTXIpIUe0hnQ6d+7zMvi+otWHXZ3+qp3TKNLr2qjrEY1bIiFfWpw0Xqq7dPf0YDx5F4Kop3uWBnT4L1UcgUHEeqZKoIzd7lXRjKWgfpmSRTw1c6sFjw8QIE6MkF0uOoCsluO8Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033847; c=relaxed/simple;
	bh=zjCmMzWXLiTPlYT09oDO9UZSCLDM00SNdheBMzKLbZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HAQfPxDXkFlzbn3Sif1Xnvhxqh+wb8SLZXB+ShZG/NVRUMz/tJyMBHwXlcAMT/AQQ+AF7bGIbTURW91MWZ2PBsqnLiw6/J1eWxK2rLTs93hEgv4m572aD9ji8NB7AJtkEDik9g/fIAPEAF8HgYvnV7pKGa83B+bttna2VHrktrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHTAIkQl; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428243f928fso22496755e9.0
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 09:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725033844; x=1725638644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bb3gV5BVChgyU1C5122zNOxpeqG27cZeIPIzI5Tt29M=;
        b=ZHTAIkQl3MWNbAieiL/Nzge5iO4Xd4dHAxhI+bpXumtxxrXYS3UxpckZCpE3eyGjZJ
         WKt+dWaWywebENwCswU/E4XI2sifzAAOVilFJRyhBXeAgcNIZ+/LEsO7wlsehIa47GOU
         7jB+dw8cEp0s0d/PujhF22E7Tn/4xY6CObgp7Pcyr66sdBFL+1meUzv61yaA+w+yYqVz
         FA4zgFqawVUXY90QVlg9ZthOSEjmfD8x0i1qVMPYhuF8gz/1+MMa07mH1FRr5rG7YRjH
         ePCAy1rZ25x1dYlLDU3eX6qz3U4zGwQhT1hxpldDMG2Q1HQdCQx+MMBd3o7CSBbmFydn
         IWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725033844; x=1725638644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bb3gV5BVChgyU1C5122zNOxpeqG27cZeIPIzI5Tt29M=;
        b=mK7AKs2jz8BjNifoBUKHL5ltbk2Nx/eERwuzilOpOaZTy2XTsbp7CHSwzML99wVFzk
         JvBGw+LX0v2LsxOWLaIfisuCp9yUG390bG2fuzDPCLnIHRwMbpbns9i6WItKW5FAs5zJ
         3Nz2hp0SsV9Rhft9Mn07ZO1zMQMaV7pRkW+DpG/H35AmYJIJyRJXf0OUzy0Sc9HaNiOo
         i0i6oZePWyaSuDDBlugj7/h0xniw50vGFQHanQ61md6sH8cfa7WLF14xVNd/9yQo8w5o
         JNTdY+R3fSGIN96Rz8EEsvxwQGHl3C5hp3C49EamdFHWJnPgfFpZUxJpBRLWWjTVQo/4
         Qbfw==
X-Forwarded-Encrypted: i=1; AJvYcCUoMwkYT2rnOmqS/+0cOdYgg/AuAwgH+qlolUEF5gHtFo+R9F2/+E7DjXJHcgW+yk8wzZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIdFY5mAAAHpkvpp8EtWvEPuQy/+TK+xl7KQ9uCu1i+1rKfuOb
	GAA1cs9xivOm9t9fLYtSlV8xhAU3VyZroYNvlFK5e06EgoSFosQJ+18sCnefTu+0J1QPlJtQss9
	Ao5NPM6oNR+axGdRzSAsLctUu83k=
X-Google-Smtp-Source: AGHT+IGM3YjZnvfwVno5kkBQpYKvfxn5n+7X7rgk66WBn2vCBulB2kgd66PHL+ScNAG8rVL/p2Tp0xH3ER3hZCcP1zU=
X-Received: by 2002:a05:600c:4684:b0:426:593c:9359 with SMTP id
 5b1f17b1804b1-42bb020bf2fmr72222995e9.32.1725033843866; Fri, 30 Aug 2024
 09:04:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240825130943.7738-1-leon.hwang@linux.dev> <20240825130943.7738-3-leon.hwang@linux.dev>
 <a9ce98d0-adfb-4ed9-8500-f378fe44d634@huaweicloud.com> <0900df03-b1cd-41fb-be04-278e135cc730@linux.dev>
 <0f3c9711-3f1c-4678-9e0a-bd825c6fb78f@huaweicloud.com> <9968457f-f4c2-42a1-b45d-44bdf745497e@linux.dev>
 <d9d5cf5d-5137-484c-8c87-0853072385b7@huaweicloud.com> <3e74d96a-fb74-4ec7-8f9e-185fc39449ef@linux.dev>
In-Reply-To: <3e74d96a-fb74-4ec7-8f9e-185fc39449ef@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 30 Aug 2024 09:03:52 -0700
Message-ID: <CAADnVQ+xR9TrO7o7zxR1ByV8s4pcgPPxTt6k3W-jSxoVHsBV+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf, arm64: Fix tailcall infinite loop
 caused by freplace
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 5:11=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 2024/8/30 18:00, Xu Kuohai wrote:
> > On 8/30/2024 5:08 PM, Leon Hwang wrote:
> >>
> >>
> >> On 30/8/24 15:37, Xu Kuohai wrote:
> >>> On 8/27/2024 10:23 AM, Leon Hwang wrote:
> >>>>
> >>
>
> [...]
>
> >>
> >> This approach is really cool!
> >>
> >> I want an alike approach on x86. But I failed. Because, on x86, it's a=
n
> >> indirect call to "call *rdx", aka "bpf_func(ctx, insnsi)".
> >>
> >> Let us imagine the arch_run_bpf() on x86:
> >>
> >> unsigned int __naked arch_run_bpf(const void *ctx, const struct bpf_in=
sn
> >> *insnsi, bpf_func_t bpf_func)
> >> {
> >>     asm (
> >>         "pushq %rbp\n\t"
> >>         "movq %rsp, %rbp\n\t"
> >>         "xor %rax, %rax\n\t"
> >>         "pushq %rax\n\t"
> >>         "movq %rsp, %rax\n\t"
> >>         "callq *%rdx\n\t"
> >>         "leave\n\t"
> >>         "ret\n\t"
> >>     );
> >> }
> >>
> >> If we can change "callq *%rdx" to a direct call, it'll be really
> >> wonderful to resolve this tailcall issue on x86.
> >>
> >
> > Right, so we need static call here, perhaps we can create a custom
> > static call trampoline to setup tail call counter.
> >
> >> How to introduce arch_bpf_run() for all JIT backends?
> >>
> >
> > Seems we can not avoid arch specific code. One approach could be
> > to define a default __weak function to call bpf_func directly,
> > and let each arch to provide its own overridden implementation.
> >
>
> Hi Xu Kuohai,
>
> Can you send a separate patch to fix this issue on arm64?
>
> After you fixing it, I'll send the patch to fix it on x64.

Hold on.
We're disabling freplace+tail_call in the verifier.
No need to change any JITs.

