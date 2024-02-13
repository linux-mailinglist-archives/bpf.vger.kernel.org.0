Return-Path: <bpf+bounces-21822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62005852743
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 03:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BC4287253
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 02:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B2115B7;
	Tue, 13 Feb 2024 02:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNZW6EbS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E63816
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 02:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707790098; cv=none; b=eGJzbbsPdCzmYXnti7xos1HbhL3aDzwDhfP1H4mueow/FO6uibXi/nFWPYQHp4+0IsQsmNjdC08aScy8Bs7ELMrrD6e8+YqkSXEqpE8Xysiqwah/RNd8Dq8ozd/lcNWXL8DTPc4RI6Nad11vl1XaQviZ4EVB8YhcKTT39jn7L9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707790098; c=relaxed/simple;
	bh=oSodDE7yNTpgzE3idJKNbwq574JSSee2fjvnhay8wBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0cN5wFPHQ3mBrwaM9BE6pPub4Sqjos9u0LrCiT5PZyH81h9ISDS52EdaqLHcY4GDAmRt9FmyqbU7MRHvxzOJp/+/BFjw3rlNg4JuWXVrcLO3X/ajgakb5heqR+f2at4FWiQPp8JSu9HnbAatqqN2C0xiZuCSKV/mBJjJhbGjss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNZW6EbS; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33b8441198cso741833f8f.2
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 18:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707790095; x=1708394895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCVPGq7xkTZZj+31+inSh51d7yxblFaxniCEk4ehpcI=;
        b=jNZW6EbSauM9sJzECDz3/pKj9lAVtJM0CZBBCaYslSVJYm48GMgO3wcqFqkS+Ugsfk
         1sEssbU85MYcsYPCvotwE7aSVf12VAbQPVtVgo88VoD2DbE5jZn/YwKu2813rypgCl9R
         oK6uCILWo8mXck+PZAfaDRR/nakZObPTTpDPHoEtM5i3vEvRT/n6FeKFzZtnV3vU2YP5
         csMTB+MDNx7q+02gZThiIVgiKLYQL+JWurQj98IXYLOC6s31mHW6/DFGiovhnBLMB8z0
         cEqCy8oUsd7ZAAuNGGwMasbiAgCbLs9qkroDjMFG5vtJGdV3JxurVL2nrIEitt8e9NjI
         sR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707790095; x=1708394895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCVPGq7xkTZZj+31+inSh51d7yxblFaxniCEk4ehpcI=;
        b=o5lazhkzmIvdHLTukhNQsznW7JA9VZ/LYKGFU/+ZogF6/Lc/uKL8Xs21/xxZNHOvUW
         6ojnpZyzSI4DguAemGT0H/BX+S3MNMkUgjqyheWySzn4l9/iwIQwId7BgXumu17e8wCB
         ujWqYJwZ3PUt7K+kZnpmqRyyGSw/frimKOmCyn3b4JjfdiSnIir4009nHQJtoF0QlYDn
         /254WRvyL8mOBVHn3EpfwgjlClKxo+ZeMX1oec6VG+iXcY7Wd8N8TP09c8fUE8LWyEEe
         b5gVbqukh4EoTAovP2A0hTB4b21EjTBTK14tcPB2CjuS8yjKzDySa9VF2sM4NxVk57lo
         Hu+A==
X-Gm-Message-State: AOJu0YyDjsDSGCVfM+fw31CEjiDvNojh/Vt333gjd6U8yhu4BJzaFpkB
	XH4zJVwXncckPi9GThKPkxS5PCTB7H+1as/ji0lkoOQsn0P94i9+W5KGstnHqbIbwoUzE6DFtPm
	cc+ahLk3N0RORm8PS5eAydFfpPSw=
X-Google-Smtp-Source: AGHT+IENG2Apsdf5ZioK1UUsKy3MrIM2d3d5X0J5qVxfcC51UXW8pB+wVVh8dHIS5bolNIP/auhdhhtjOLA8i80TuLs=
X-Received: by 2002:adf:ead1:0:b0:33b:87c2:725f with SMTP id
 o17-20020adfead1000000b0033b87c2725fmr2070418wrn.64.1707790095023; Mon, 12
 Feb 2024 18:08:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-15-alexei.starovoitov@gmail.com> <d84964662e2e11e6c94da99c7c3e8a8591d1376c.camel@gmail.com>
 <CAADnVQKTHfRWxBm08O7CcKri1NOSTS8vby3+ez2gRVM_XYEfKg@mail.gmail.com> <d5b827ea37af7b5ac71bede71f17c96e8c434422.camel@gmail.com>
In-Reply-To: <d5b827ea37af7b5ac71bede71f17c96e8c434422.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 12 Feb 2024 18:08:03 -0800
Message-ID: <CAADnVQJTQueWz8prUcodxWd4XVX9o+p1h+5R4m9VEFtFyvSkoA@mail.gmail.com>
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

On Mon, Feb 12, 2024 at 4:49=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2024-02-12 at 16:44 -0800, Alexei Starovoitov wrote:
> > > I hit a strange bug when playing with patch. Consider a simple exampl=
e [0].
> > > When the following BPF global variable:
> > >
> > >     int __arena * __arena bar;
> > >
> > > - is commented -- the test passes;
> > > - is uncommented -- in the test fails because global variable 'shared=
' is NULL.
> >
> > Right. That's expected, because __uint(max_entries, 1);
> > The test creates an area on 1 page and it's consumed
> > by int __arena * __arena bar; variable.
> > Of course, one variable doesn't take the whole page.
> > There could have been many arena global vars.
> > But that page is not available anymore to bpf_arena_alloc_pages,
> > so it returns NULL.
>
> My bad, thank you for explaining.

Since it was a surprising behavior we can make libbpf
to auto-extend max_entries with the number of pages necessary
for arena global vars, but it will be surprising too.

struct {
  __uint(type, BPF_MAP_TYPE_ARENA);
  __uint(map_flags, BPF_F_MMAPABLE);
  __ulong(map_extra, 2ull << 44);  // this is start of user VMA
  __uint(max_entries, 1000);       // this is length of user VMA in pages
} arena SEC(".maps");

if libbpf adds extra pages to max_entries the user_vm_end shifts too
and libbpf would need to mmap() it with that size.
When all is hidden in libbpf it's fine, but still can be a surprise
to see a different max_entries in map_info and bpftool map list.
Not sure which way is user friendlier.

