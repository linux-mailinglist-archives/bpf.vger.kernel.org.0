Return-Path: <bpf+bounces-21811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 255BF852582
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 02:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580801C23917
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 01:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2771775E;
	Tue, 13 Feb 2024 00:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiJR3BBo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9E9CA47
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 00:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707785115; cv=none; b=Agzo9u0bQfxs+akLbwMDoMXge8RJtFLsDjCxJpmQq+24XDr1Sg5qsAelLhICfyrc6Kle0EFIqrRBJK3uxDh7T0AAfCd0nkqwkyE5wiHFahM2bnaaSanpnFyeYAQq0zmDsPMupBBu4gAp0vzHVh5EvGSZoUJhTLb++KQt43OiN0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707785115; c=relaxed/simple;
	bh=aKa4QYLTRJ5eSNeSPPnRAE/LTKBvLuPfq10qGBQPSqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yag5Joy9uoKF4+c/c0m52KNxWdCEkd2s9lm4yzrhqV6LHyl4+uVW6Ieu+VNAjylGPJDeL3B6RH2roI86F87n2fb95zKqGvpu6vq4CxnFGMArAWgo0BKAtIrxNOBvXDFZc8XGPSfxJy3ogouu2Dcnw9QLWSMh5YVCD4IW0P8Lv/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiJR3BBo; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-337d05b8942so3176404f8f.3
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 16:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707785111; x=1708389911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uD96BWjfWvHgSMWnXXTL7kIKqCF77WFRauw+Qxj0jA4=;
        b=fiJR3BBoNg9CeCe8fi7w4mOXhk7IOoWMY34NRDmsDwfrkhQbUjQ+pmMW9D2R5UMr+P
         a+Y5tbME424VHswRhvYAN6+JS7juhUsMEifJ76qLQryLslVnnpncLdh/HHtuB+dopbG5
         Hz4SWPUuTecm1tlVeo6lv2Q0Q7knzrJSBwluhm+0cBFIFg/gpyycJZQhtkzOPT8qUxvN
         epxrZ+XMihZ7BMyqdxEBgtK9PuZB6AcR2cEi6ncbJlRUaJVrUzo7xhJc3T94s2+Ib4Ey
         nv+eHNZ7fIIy+/SPjPbAAqHrG/ialVkMfXqFi2EqVgJgWR5raNKmyi7bSGSs52m0jHKh
         hL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707785111; x=1708389911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uD96BWjfWvHgSMWnXXTL7kIKqCF77WFRauw+Qxj0jA4=;
        b=DT8hMEHAWaLWO9GAmo2y0fVFLVEtTES/+uj2609KUO6htzUWZD+wkD7gtrMGP4cTuI
         1hmYYvuao3Hkv1W008TyYI9U/g5WCAu1cy/qjliixcmE+V5L0TPum/W547wZKMIr1xaA
         +6eTny3z7888MQpbq8h3Kd60+QDxpwxbNWSgkZ7v5fHA3k/ZoqeyMHwjw61UcKdTfuPe
         puZhUAJG4KJ5sT8XOXJigSoocxrPThGkx/7avzoJqxmtvg4UV4Ag4Ar3sHrmxXzO4m9P
         z7uzRfHlm4LJZKlhtfu8PxTVz1+q9IzSl3K2zwko4TUAQ2KA37mXGKO/6CV3oD/JPft5
         anvg==
X-Gm-Message-State: AOJu0Yx0k6e5Htm1RdIy0QQcv8gFaNyqDrCofypyRgFIw/dVDf6iHA9b
	w0iWiuC13KZ96c+48P4mw3xjbP+iJR8xCI/CjB61zS4x3MNvwsOB2yRbY0pLiTXQCBP/oRSNM7I
	1io2Vl8h2+4F3oMxJR2VLtMRjfeS12JLpfAc=
X-Google-Smtp-Source: AGHT+IFQXs/sIvqmfsvQjhZCAIdpqZewcOOEM+r0JKEBYRkjLfnAvLNvjQ+FCxsh0SYKEm2/9mxVVKGS+enAhJ3ge+0=
X-Received: by 2002:a5d:5101:0:b0:33b:7655:824 with SMTP id
 s1-20020a5d5101000000b0033b76550824mr4906024wrt.2.1707785111342; Mon, 12 Feb
 2024 16:45:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-15-alexei.starovoitov@gmail.com> <d84964662e2e11e6c94da99c7c3e8a8591d1376c.camel@gmail.com>
In-Reply-To: <d84964662e2e11e6c94da99c7c3e8a8591d1376c.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Feb 2024 16:44:59 -0800
Message-ID: <CAADnVQKTHfRWxBm08O7CcKri1NOSTS8vby3+ez2gRVM_XYEfKg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 14/20] libbpf: Recognize __arena global varaibles.
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 4:34=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2024-02-08 at 20:06 -0800, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > LLVM automatically places __arena variables into ".arena.1" ELF section=
.
> > When libbpf sees such section it creates internal 'struct bpf_map' LIBB=
PF_MAP_ARENA
> > that is connected to actual BPF_MAP_TYPE_ARENA 'struct bpf_map'.
> > They share the same kernel's side bpf map and single map_fd.
> > Both are emitted into skeleton. Real arena with the name given by bpf p=
rogram
> > in SEC(".maps") and another with "__arena_internal" name.
> > All global variables from ".arena.1" section are accessible from user s=
pace
> > via skel->arena->name_of_var.
>
> [...]
>
> I hit a strange bug when playing with patch. Consider a simple example [0=
].
> When the following BPF global variable:
>
>     int __arena * __arena bar;
>
> - is commented -- the test passes;
> - is uncommented -- in the test fails because global variable 'shared' is=
 NULL.

Right. That's expected, because __uint(max_entries, 1);
The test creates an area on 1 page and it's consumed
by int __arena * __arena bar; variable.
Of course, one variable doesn't take the whole page.
There could have been many arena global vars.
But that page is not available anymore to bpf_arena_alloc_pages,
so it returns NULL.

