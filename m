Return-Path: <bpf+bounces-27107-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E1E8A918C
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 05:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106EB282CB6
	for <lists+bpf@lfdr.de>; Thu, 18 Apr 2024 03:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF6750A7E;
	Thu, 18 Apr 2024 03:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1lwy4Tw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A412B4F8A0
	for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 03:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713411064; cv=none; b=Z9aA4UQxuVHJT+pQvd7oMxitN5jVW9CEifZ/w6WCZgxUMjHn2qQcl7X66VTJDVcDmUQfDbRrLMiXPVFiOGLBBERtYpiT2B/EtZtB36AmeT5bvGlCOgs2vazMs/I7oKo0z8ZYwjIYGyruKHmm86UgbPXYh1Mx56Pv7PlVteIYuTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713411064; c=relaxed/simple;
	bh=7qRl7qip4LXYP0FniVpNHb68BY8j4lUe/5hZ1t/B7Ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ijEjr5B2BLRYEpVlUpS9T8kBPi/ZQlUqkFcTNInFYw+ZGV2u12kKj9Hc0ZOZgDOwGk6OBxL4uEziw2ndCvk9fwoqZCsojWQF8r4F0pcb+afo+HCC3DmQB04N7izCsUxzuPX0b936Nwr+VYganvAvFZ3lTO751OD+DMaJ2b3Lg7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1lwy4Tw; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-343d2b20c4bso247188f8f.2
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 20:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713411061; x=1714015861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DPoEJmJUyqkFYSRU9lTfYZLrtEAwknPXi53UWk+nwU=;
        b=L1lwy4TwkPSJfrO1k8/Ot0IQTPq/RnFonxDX3DVuceEH68TI2EZZ4Yasa+OKkh6Z+X
         jxzXVNhmIN9x7sKK2kksXgmrfg/umkt5Kwp+ghk9fiHag/3PsPOwTCW+eddVaWy5wvTd
         34EXU/+m3+VtLVx+cGC7Rfvn2INodrhWcoTGGhk8Nd0mHaJMMPR7Y+oaJ4YXinOn5UqW
         H3Cu648oWoGdIhGej54iGvrWvZUIoZT3J8JOVt4sVMdK7NUBTFxcrBkdLheUkslglNNJ
         qx3uwyTrZ8USX66cRH+/klkQ8bDfcbgQOPLavFDuWJ175ypw6I7WI80UktSH+ttAYUhe
         cF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713411061; x=1714015861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DPoEJmJUyqkFYSRU9lTfYZLrtEAwknPXi53UWk+nwU=;
        b=LTKBi2jhGNdzcK50WJ7JFax3yMo7YNdqXPjC4mfeGTPx99hYoPvxB+3LPSRaYOJzEF
         AKo2qO62/mwtN3SBiU2n56YUgvsKMotNEBxjldGfgrysIUJz98X0bJSY5K6ZWaMzI3Fg
         iGFQlBsQVb9CoyUrPcz502S5mqvDr1PdU6AWgosHF3IRqKJOy8LEftyG7XgBcNtB6Gar
         ui8hx/j2ISSH8JP2Qxk9kofiZ4jnUJzbyaRLuahEtERxzlhPAqVHWlpicVlNVa0EtUBu
         0GPw7IpaMy7/ik5yA+mD05zepvpPxrCp7gfC24GHfDtuVL+quCNOtCpWf8ONKiS+tk30
         1N4g==
X-Gm-Message-State: AOJu0YwV3/znTmScH/O1vsUU9h/INv4BD4eM3mFEjyNZF7q0y91bzRrV
	Mb25G/8Enjh71BNDZ7BglIPsTsM8lHtvdeMqOQGI8IpDrRnW8UkhAA6pvSteg+sMkBhG3alFpzO
	nkV6nshP8cBWNSgzPCIODZO8sLBfqQtyx
X-Google-Smtp-Source: AGHT+IEydl/lWkrVFcdnn2a9MJlw9TcU72OjXUMswlUSD9s/TB+jz3pKZU/iO1sW1QeFT3/xqfzPCExIKH1e+YPIZDM=
X-Received: by 2002:adf:a41a:0:b0:345:e409:7be2 with SMTP id
 d26-20020adfa41a000000b00345e4097be2mr595816wra.45.1713411060688; Wed, 17 Apr
 2024 20:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412210814.603377-1-thinker.li@gmail.com>
In-Reply-To: <20240412210814.603377-1-thinker.li@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 17 Apr 2024 20:30:49 -0700
Message-ID: <CAADnVQKP4HESABxxjKXqkyAEC4i_yP7_CT+L=+vzOhnMr5LiXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/11] Enable BPF programs to declare arrays
 of kptr, bpf_rb_root, and bpf_list_head.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 2:08=E2=80=AFPM Kui-Feng Lee <thinker.li@gmail.com>=
 wrote:
>
> The arrays of kptr, bpf_rb_root, and bpf_list_head didn't work as
> global variables. This was due to these types being initialized and
> verified in a special manner in the kernel. This patchset allows BPF
> programs to declare arrays of kptr, bpf_rb_root, and bpf_list_head in
> the global namespace.
>
> The main change is to add "nelems" to btf_fields. The value of
> "nelems" represents the number of elements in the array if a btf_field
> represents an array. Otherwise, "nelem" will be 1. The verifier
> verifies these types based on the information provided by the
> btf_field.
>
> The value of "size" will be the size of the entire array if a
> btf_field represents an array. Dividing "size" by "nelems" gives the
> size of an element. The value of "offset" will be the offset of the
> beginning for an array. By putting this together, we can determine the
> offset of each element in an array. For example,
>
>     struct bpf_cpumask __kptr * global_mask_array[2];

Looks like this patch set enables arrays only.
Meaning the following is supported already:

+private(C) struct bpf_spin_lock glock_c;
+private(C) struct bpf_list_head ghead_array1 __contains(foo, node2);
+private(C) struct bpf_list_head ghead_array2 __contains(foo, node2);

while this support is added:

+private(C) struct bpf_spin_lock glock_c;
+private(C) struct bpf_list_head ghead_array1[3] __contains(foo, node2);
+private(C) struct bpf_list_head ghead_array2[2] __contains(foo, node2);

Am I right?

What about the case when bpf_list_head is wrapped in a struct?
private(C) struct foo {
  struct bpf_list_head ghead;
} ghead;

that's not enabled in this patch. I think.

And the following:
private(C) struct foo {
  struct bpf_list_head ghead;
} ghead[2];


or

private(C) struct foo {
  struct bpf_list_head ghead[2];
} ghead;

Won't work either.

I think eventually we want to support all such combinations and
the approach proposed in this patch with 'nelems'
won't work for wrapper structs.

I think it's better to unroll/flatten all structs and arrays
and represent them as individual elements in the flattened
structure. Then there will be no need to special case array with 'nelems'.
All special BTF types will be individual elements with unique offset.

Does this make sense?

pw-bot: cr

