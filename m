Return-Path: <bpf+bounces-57816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99361AB067E
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 01:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007761C257D2
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 23:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5867E230BD9;
	Thu,  8 May 2025 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw7VpgQb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B592221D88
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 23:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746747001; cv=none; b=G6W7L1fuPAu+m9uu/u/j01dWaqDL34CqQFiqjuKXf3hwp68zrY780hLcyIRu3bBt0Lf2XFlWvMGq9XV0Bn/Nd3mNKEHC1zBuV7N1bK16dpzjDoP1qI5ZHsO2a5bAPsX/XjBSO5sO4d6jZUpLSI+hMSujT1qp3u+cmaAf+Fsqkf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746747001; c=relaxed/simple;
	bh=tWm97DKt6SLp1KvDyqx+xBYLmIXfxo/4buW22YhTvZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kISOKVI3KuCwQHDPQlhQ+Elm6TvgMJJ8CUFAG2VikUXyR7ojzfHpVl691pWDwzeis+5WqsCfFbhRH3W3v08c66kvAsM+vl9GNs+E0SufA83VLziQlvp06GdaicZpDAxCwzLZofgVPmpZNeprDi5FIwHYGIkJtHLnTMGLw76D80g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hw7VpgQb; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ad1e8e2ad6bso306188666b.0
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 16:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746746998; x=1747351798; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l1zUsQbJbjAtQGhovnVyCEpCeilmX9zDKCeBjuv8taI=;
        b=Hw7VpgQbaQ0hEMTiGRmv9KGEkALlF7SH+Wnj6Lvnk9zpY2jB4ZqvXG2fijskGGun+p
         hYQE4TGJBnAqGcShQFQeY6nwfb9NOjTdpKadfBQbIo+GykcWa9DDs18OlQjJYHOEfplF
         rh2yQOlun8HrSep0IFnOeOyGYe9CeFZTfzPefFhMbA3pFlPBo9wKsMrgeYRIf/85JqGM
         qbU7F6xi4cBEMHCV+ouasPKuhBIvVVaoqldhnkUShaptUPAXe9BdxopF2g1PdTfiW4fe
         6qmvos14l80xVgfeP0egtdhctaO8juteLAa9PVRHRKKeLJjHYX+QGJpfINZRl/ZKgQh1
         4YQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746746998; x=1747351798;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1zUsQbJbjAtQGhovnVyCEpCeilmX9zDKCeBjuv8taI=;
        b=i5z3cb887uRX2AMx9XBUI9yXGUbQgT9S5ZV60sEQHzylEjQ9OAPsjsHMDNd/3opYaw
         g+hCLFBPCqpOvDNxHk9FksOyBmLwzbLuvJ7YbjMBAj8I+DLDi/QaKokq5k2WIO5HSJIC
         soqZxF4wcmGU+bd//Dj5OOYHX+4uJafapa3DPsuC4FbhGwvfpVK40/4X9wwcdN6qfJRO
         scoN4qjyFCV186q1LADyy/tf6U/ngMYB2lEZ01j9K24Is4vgDIltXpIqHwcXhcGO/iiw
         D9bWUMUVHxLEaJx/n2BMY+ooXmdAkM8U7KF9R875E9wG4gXwuogJV1CPHvFRYhfoiMZ2
         qGLQ==
X-Gm-Message-State: AOJu0YyCE95k4pGScmADAeAIIC9HzTms/VCu8VWfIRm2WMuUk0ECV4vl
	w4WVgXsJevgqa8FZbzDGUcTaHoJBllNuDyr0rTBh452IwYg+Jn/FHSSZRgbwMVVmVj5Oaflo6Fh
	DO/QdsSNz4+GyLdN/K9v9Gzw6Es8=
X-Gm-Gg: ASbGncsC3i+rjyBMqXBGSs/HkVLi2DB/SaKvi+wW0U6TLN+8Ak2D/iiwFbx2Url204K
	FkrI3LxZyJti4snqcveMX7qie7eN8MzGckIOVUEVEttXZ7OPoQkhgeUIfzQxBcxlD6o7gdzviMz
	4ec5mkbBJXmh+qM9EnLfOL1SC1VJrrAUWY1Mkawwm8qPEKzaSK2/SYCizP
X-Google-Smtp-Source: AGHT+IGLkKVQ0PFfaSV3bQWZwaZo+FTi5vLvnDcL4ltMgXk8laDGgxH1b0omhoO0DocoH0UcBCNUx8SRN3EAY6R+V3Y=
X-Received: by 2002:a17:907:96a4:b0:ac7:971b:ffd with SMTP id
 a640c23a62f3a-ad218e5358cmr153316366b.10.1746746998282; Thu, 08 May 2025
 16:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507171720.1958296-1-memxor@gmail.com> <20250507171720.1958296-6-memxor@gmail.com>
 <d2d0c67e57cc14bcc186f4a5b744ec1a01630721.camel@gmail.com>
In-Reply-To: <d2d0c67e57cc14bcc186f4a5b744ec1a01630721.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 9 May 2025 01:29:21 +0200
X-Gm-Features: AX0GCFt0hm9dUlm6rVxIxc3KgvXYnLZv0ctMcVS_3C8ufI6KPCJJmGHwQdjsqHw
Message-ID: <CAP01T77+LmWBhL3_stoS0hzTM4_Lrvh8-s1F1m6Q3P2fL7WbHQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 05/11] bpf: Add dump_stack() analogue to print
 to BPF stderr
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 May 2025 at 00:38, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2025-05-07 at 10:17 -0700, Kumar Kartikeya Dwivedi wrote:
>
> [...]
>
> > +static bool dump_stack_cb(void *cookie, u64 ip, u64 sp, u64 bp)
> > +{
> > +     struct dump_stack_ctx *ctxp = cookie;
> > +     const char *file = "", *line = "";
> > +     struct bpf_prog *prog;
> > +     int num;
> > +
> > +     if (is_bpf_text_address(ip)) {
> > +             prog = bpf_prog_ksym_find(ip);
> > +             num = bpf_prog_get_file_line(prog, ip, &file, &line);
> > +             if (num == -1)
> > +                     goto end;
>
> Should this be `num < 0` ?
> bpf_prog_get_file_line() can return -EINVAL and -ENOENT.

My bad, I modified the error code when cleaning it up but forgot to
change caller, thanks for catching it.

>
> > +             ctxp->err = bpf_stream_stage_printk(ctxp->ss, "%pS\n  %s @ %s:%d\n",
> > +                                                 (void *)ip, line, file, num);
> > +             return !ctxp->err;
> > +     }
> > +end:
> > +     ctxp->err = bpf_stream_stage_printk(ctxp->ss, "%pS\n", (void *)ip);
> > +     return !ctxp->err;
> > +}
>
> [...]
>

