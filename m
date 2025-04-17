Return-Path: <bpf+bounces-56163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02633A92C07
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 22:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A231B65D83
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 20:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335482066D8;
	Thu, 17 Apr 2025 20:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4otZ9+O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226AD1FF1D1
	for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 20:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744920511; cv=none; b=IhOj1lA0d64OO30JsUs/7ja4cwkJK6FENPpX3i4sbRYL0AUKv62eI5v8sGJaQktgShyYfY6QNTwg/WJv106hTCduBjoP45vk6I6i2V/PjYwFjp0YfVaKIxBWf5I5fZGQEqVp3Zl0pygPdwxymPpS39KGMUMAKHtDO5tejD7pZhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744920511; c=relaxed/simple;
	bh=RInTdMjgjUd9r6xrB+lgsQIhSpK1suI+UmhZA4lgDd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kM1W0F9dF+kSLcnuVDDoIUfpHHoaGRVHFEzlXlVjlR5gIF+dNBfgEbHlwlsYBGTZxhhRZBDmQgs0Smtxb67wjNAArzQG9GGwpKCIPdqqqUC8G2AFdj9Ce+a0ZVQ5b5SVuZE1yUd81+qL6OEHioUle/mMUnGJDMFfePGszrBTTjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4otZ9+O; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5f4c30f8570so2393486a12.2
        for <bpf@vger.kernel.org>; Thu, 17 Apr 2025 13:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744920508; x=1745525308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RInTdMjgjUd9r6xrB+lgsQIhSpK1suI+UmhZA4lgDd0=;
        b=K4otZ9+OCwBWpjYmw6KWJik9jdILF6X/VmD25uZAhbUTAaf/3h6LK6Jshb6iZdRpns
         GcFQwFYfBVW3wXbOSTcwQZjyrDdkmBAQhV2Oe/QHa5CLnByDKtWMV6QPsa34eEwT8szk
         MjVRu0fFHfNcXITOpOe1YXQGD4vdDVJLQ6uioVhi/kIkEs4KhFpKXkHe1vnWfOCL9U70
         UR6n0kog7bZkmsaNYCNFbHkuBb79PTjjRUmpD9CCh3aZgPsTH4+zM1jOq1yS15+uzWIs
         paS3Cu4KFgLpPFXPj6DJeMoYn7F07jPa0AjQQo9zaIliauV/U6muu3h02kcvcn8v1xIj
         Bw7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744920508; x=1745525308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RInTdMjgjUd9r6xrB+lgsQIhSpK1suI+UmhZA4lgDd0=;
        b=PjXKLgLgEMIIsj/9L2UHhKs2zqMwCcgxt1oK1AAALEEi964L6hgsPShCWNlGyRG6UL
         lJfHA35SfJ2746gVQ9inpomRqMm021YhrHLrHKduX3jyLz9X5ycKen2Sx9djE+A/bH2B
         JkFcpg38Nrd1OKC9EzbadTbUE4lLXwJotD3dDMeyT2sPPyKY9KB3kuoZuc3gIMHSeoDT
         YuCi760eMJnFbMQFnKrMq2LGY9wPjaEP6kYHeBfCdye6dpKobcOLxLyRtqX8IsXva0Zc
         3yPypqbB/KeFW/jElaQwukrpLZk5L4axpdIKjF1OTjZHegRC1A5h/Phjp3Il8xIXBdZq
         +cVg==
X-Gm-Message-State: AOJu0YyjSGXUjn72nSBf4dRuC2oCb9dhVDqJXYYKL1XgwbYPtcLhqIlR
	1EIORKj1xZ7FI8dZhATRbGn+eU5jxYCpYfZOwGnAQ6QztFwhClzAaN/ALKQ8DS3gymTga4csCR5
	vO5o7aXde1HXHZeN2PCPj8Vc8now=
X-Gm-Gg: ASbGncte1B84vCt6YxxHxNRB1R4uMHtmxfOB/acewW1Xl69WLtlmbAWt0FHJIl9WIKk
	Lr+qZ7IJ3csyMQFSH9sR5l+QoqkVjMpXIhvjvhmQyYfk7+gKsGbGW7yxLv0iXn+W3G76Iv2gRy3
	VS3cHqU4xzrk20i0jxPjARcIr0UHnu9JzL6toYh0DiQ2o=
X-Google-Smtp-Source: AGHT+IEmoARd2S9Eh386XgPS4Af+n39NcNMp+eVyTvleZEUyOAkjZyXciZZL+0SqvdEnkRJXE1IcvTCCScrd/yTqQ0w=
X-Received: by 2002:a17:906:d542:b0:aca:c9ac:139e with SMTP id
 a640c23a62f3a-acb74b51644mr16770066b.24.1744920508164; Thu, 17 Apr 2025
 13:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414161443.1146103-1-memxor@gmail.com> <20250414161443.1146103-7-memxor@gmail.com>
 <m2r01suhyc.fsf@gmail.com>
In-Reply-To: <m2r01suhyc.fsf@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 17 Apr 2025 22:07:51 +0200
X-Gm-Features: ATxdqUEiLs9tcgLDa6azl83VMbKOJ4QlHBybgyyi0SdC1ItuwtIV2T5P52qxhKM
Message-ID: <CAP01T77nBG=cMAqTBWzUjsomobEW=UBU+q66VBTR2xYhU=9YhQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next/net v1 06/13] bpf: Introduce bpf_dynptr_from_mem_slice
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Barret Rhoden <brho@google.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Apr 2025 at 19:36, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> > Add a new bpf_dynptr_from_mem_slice kfunc to create a dynptr from a
> > PTR_TO_BTF_ID exposing a variable-length slice of memory, represented by
> > the new bpf_mem_slice type. This slice is read-only, for a read-write
> > slice we can expose a distinct type in the future.
> >
> > We rely on the previous commits ensuring source objects underpinning
> > dynptr memory are tracked correctly for invalidation to ensure when a
> > PTR_TO_BTF_ID holding a memory slice goes away, it's corresponding
> > dynptrs get invalidated.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> If I remove KF_TRUSTED_ARGS flag from the function nothing fails.
> But that's because with current interface slices will always have a
> ref_obj_id, right? And pointers with ref_obj_id are always trusted.

Yes.

>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]

