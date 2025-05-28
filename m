Return-Path: <bpf+bounces-59046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6143CAC5E97
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E28A93A644E
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 00:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5B8154BE2;
	Wed, 28 May 2025 00:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k018IcL1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E21110FD
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 00:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748393935; cv=none; b=kblJ1efgemHJUZbogGOlctuzDh/rlo+DkwBJTGhsosILnuPr4NxPMAUIEfS/PbWesiJrt4ZEuZFFIBXkIv8xm6gGgSmuyPb5VxNdB2OUjFTxDWX0+QUytpZT49+L5JvuqnBo95HVlkmfmpBz5BOAM14pQZcJwoH32/NZjOAq+z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748393935; c=relaxed/simple;
	bh=Dk6yf3R2k1WnpcmqsS9mHlstGoVSt4iCb9G45y+6TSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkUtZgjpShbiZw+7WHHaCXyL67XZDQrvx/UwH9vd/1xp7hiIUfkICU0f98xg9d3YRoNjE8WeI1+vr5Et4OZ0EV2/Z0KUTW7IlfOpNvcbfTddWQCG2I3YVHu9GfLW73VoDPGLTeAvv+XfhP8X+oBtNGSUfRl47DVWuKUPjlYVNEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k018IcL1; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ad89c32a7b5so87434466b.2
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 17:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748393932; x=1748998732; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k06jwoR2fbnz0IsbzZKqtsnPALaWcx9YY6jMgHpEO7o=;
        b=k018IcL15UWbiuMDRj3wgNh1jFFHEqe2QDwmW9y/ELVTsrEH8EtvlDyf+8xV3LuC30
         JvA0CG3BUfXSVubNK9YKLId1O0Qpstkd3BzvQzSQ0t3WXTjS/l6qyv7pPnuZUgYS5oeJ
         ar2m3ySD6o26B1NP78qa/k2+Z3bleIRkVnJYtIoAz4FDO1AIjO6hFXYKe1/LWSauE7NA
         SBZrHQQ/8eAKHRhSWh+678Qzz+34HpQSEgE2Pk+k30qVlm7H3bGB2zUh1Wn4xTt5rQKI
         z6DululFluZe+iQxmntUu6JWQ1aKla7Piq4g8dKKc3taMP3l/LTxsD8N2ZVVQZYbX5dt
         HojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748393932; x=1748998732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k06jwoR2fbnz0IsbzZKqtsnPALaWcx9YY6jMgHpEO7o=;
        b=b5BpHdWZ2e957JJvOye3klc+cNYefGNFWiXcZ8HDU/KxBn1MTf4m2vabVy4HtRZlEO
         8lVnp/Sv+2kfKS83NweLACABWRmF+gNroU0ZC8LLU0AvODdozb/VQoq3It38dOlhBQZe
         IxjWc0B+pORHf9qeJnJRJNyClCSaKaCPC+RACKvg7ejKbUET7HmuNxQFuPzndvKsSOd1
         Rb1lQpRN5+ysJ+sc9+J9yWlfFvijkUETPHmDXbQCVi0g47/7pQTFjFuolR96JZpHEa0U
         soYTeFpqWKzURhSP3heKxqrHFbgQVEN9LgqWmEOMyZ7xiTnY2BW5V+aYKrgriBHBHO+0
         W2Gg==
X-Gm-Message-State: AOJu0Yzzrqy69VuPqYR/17WoiBDxH2JjeIt3KZkJ8gnHoRWSSZR+NhEQ
	gjv7tDe67uWAJngGuhJRlaZRsA8fW3PH576hfAfpeyFOBNf4H1hqM3JHdiUCj1ewdI9m8UeeFu8
	h0+GrLK05HvFdmE5D3ZGqjHh9lSTGxFKJ1R4h
X-Gm-Gg: ASbGncuDwB88YSsNtSrHowxBDbFn5AH4j7RlwuytDsnYlVt+PN/PYsGRoUzfZrg/dSg
	/jS4BvGRw5uNJ6htmW9QAylGJiQV6eDp6EmRsP1cLT40lYXLCKjiPqVMikqpmQ6Gmq2aeSYZi/C
	4QYXa3t8qR3kkMHV9poV/IFo64jVEmiDbLFRotlByaYETsd6vWow8t3JkJ7uL/xdN5huM=
X-Google-Smtp-Source: AGHT+IFKffAJKLhXtqR3l97jcMczIDTBXBWc34QFAdc5w1G2U7EUAcl9nUkC3NSfPwkl/VaUEvmOzwgbwgQXg7xjGKQ=
X-Received: by 2002:a17:906:cac7:b0:ad8:8364:d4ac with SMTP id
 a640c23a62f3a-ad88364db22mr671346266b.55.1748393932142; Tue, 27 May 2025
 17:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524011849.681425-1-memxor@gmail.com> <20250524011849.681425-6-memxor@gmail.com>
 <m2tt5536n8.fsf@gmail.com>
In-Reply-To: <m2tt5536n8.fsf@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 28 May 2025 02:58:15 +0200
X-Gm-Features: AX0GCFsB2yUI5G8MBJbJ5b4m5kYHx9450azj9S9ugaggTVgBMbcSN9H5WPu3DKk
Message-ID: <CAP01T74WSqhWPGVXrDfLRbtgM5Om0MiL4_x=1Od3QOPERj8BdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 05/11] bpf: Add dump_stack() analogue to print
 to BPF stderr
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 May 2025 at 02:45, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> Could you please modify one of the selftests to check lines reported by
> dump stack?

Ok, will try to do it with a regex pattern to match the overall layout.

>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 6985e793e927..aab5ea17a329 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -3613,8 +3613,10 @@ __printf(2, 3)
> >  int bpf_stream_stage_printk(struct bpf_stream_stage *ss, const char *fmt, ...);
> >  int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
> >                           enum bpf_stream_id stream_id);
> > +int bpf_stream_stage_dump_stack(struct bpf_stream_stage *ss);
> >
> >  #define bpf_stream_printk(...) bpf_stream_stage_printk(&__ss, __VA_ARGS__)
> > +#define bpf_stream_dump_stack() bpf_stream_stage_dump_stack(&__ss)
>
> I don't think we should add macro with hard-coded variable names (`__ss`)
> in common headers.

Hm, right. But this is supposed to be used within the stream stage
block, and we have __i variables in macros that wrap around loops
etc., hence the double / triple underscore to not conflict. Anyhow,
I'm open to other suggestions.

>
> [...]

