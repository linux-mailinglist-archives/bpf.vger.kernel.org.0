Return-Path: <bpf+bounces-68407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C3DB58256
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 18:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E95AD7A1ECA
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 16:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCEB279DBA;
	Mon, 15 Sep 2025 16:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTVRhyO5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983D91F419B
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954628; cv=none; b=oAStWa7AkX80YUJVGlFEOCcdNUqwRS0b08rjR+2mVoSwA8nFThMoBq6oqEld6ERzVTAu5htHQMzlb8b4SRXb6BUPReSB4hps80yerGzTh3aScV3KPFFiDeiZYp8wh4dzyPzUQ+pRVQlMLIGXSHi6y6JE99WqZl/n1M+YoYbO7BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954628; c=relaxed/simple;
	bh=xkXfYbWIDEUWnyGsAfdnw3AuPZ6KLRDrEvvkbKypt/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CV5NgZwecM1Vm13zJvWsWDYJ3YuURPA/E2OkyhSr/UNHuujUFVnWgHVGhM+eOukk4hfE2BTCaqU2D4WcEB50QJREBkEg8gWFyRefQPoCABF9aDvawQSm9FKDoXjLo3Up5DJRkyu0dz9IfgZ9WFIkBxMlt8iugmfLEuEB6spKEMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTVRhyO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F37C4CEF1
	for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 16:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757954628;
	bh=xkXfYbWIDEUWnyGsAfdnw3AuPZ6KLRDrEvvkbKypt/4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kTVRhyO5NelnSUygWG6OZRSHdiSBfeT6VeHDHKoBelJmA5PaIBfHM/rBd7vgf3uDO
	 xNwEPK5TOicQSxMTRQ6BZGuWtrD4FoX2CsY5JOYaWZBtyGDw37E+JC5h9TlzcXJNM9
	 ZeS7p77yQYjQW5G3jGFaJZ7nkva/MapbUUKfeTZuAzd8l0/He0jYxk/bo5enyX41rH
	 cEBLCAbXGur2nueGY8nYIJ7Q4u77oHobzIb8V5r1ihABtBqmCg2blSja5nte+hgHmC
	 wuL9cV6b9aXPC0J8g83jRL+BhUcZCpWo1V/hDkRcMTwiY9rp3f19CuNGHRpwC39V1l
	 v7VOqOq8ExKFg==
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b60144fc74so48758551cf.2
        for <bpf@vger.kernel.org>; Mon, 15 Sep 2025 09:43:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWSTtyj8MszbDtQcImf8uJeFcLUusZvkIsCz82P3xES1ctFN9vrPWTQypo41KDxOS3QFVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvxU2jAlh/LhOjEw2FPp/gVCaV9yQPRge4sVQPVOXqbSTyWSoP
	GbphQpx8f4LfGVVpCmgMCDYv1jPLwVoHfWVtl8g3BB2MQZN1XD8uNir8Cp7hKMu+DQjJnyYblUa
	ofjWQ8pshDSFh4yx+GhcpQULHNqu0q0I=
X-Google-Smtp-Source: AGHT+IEsS0zMZqCp8O6H3genJnRRjd8gV66oLBJSEuyuaGeiEZx+R6yacFaqmBu8hQlzU/+Pog0FmJsf3ryH4Gp+qYI=
X-Received: by 2002:a05:622a:5443:b0:4b7:a9e9:88db with SMTP id
 d75a77b69052e-4b7a9e98f23mr22440971cf.1.1757954627323; Mon, 15 Sep 2025
 09:43:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828013415.2298-1-hengqi.chen@gmail.com> <mb61pjz2nmyu4.fsf@kernel.org>
In-Reply-To: <mb61pjz2nmyu4.fsf@kernel.org>
From: Song Liu <song@kernel.org>
Date: Mon, 15 Sep 2025 09:43:35 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5-Q7F9-6hUWJ9XhS37fZrJjk7YNmbHriQM_rDW07X5KA@mail.gmail.com>
X-Gm-Features: Ac12FXx5WYYzXt5EurpSPAnOZogOP6b42OjKIGjzROGttany-z2VaqbPJozmibQ
Message-ID: <CAPhsuW5-Q7F9-6hUWJ9XhS37fZrJjk7YNmbHriQM_rDW07X5KA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, arm64: Call bpf_jit_binary_pack_finalize()
 in bpf_jit_free()
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, xukuohai@huaweicloud.com, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the late reply.

On Thu, Aug 28, 2025 at 5:10=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
[...]
> Thanks for this patch!
>
> So, this is fixing a bug because bpf_jit_binary_pack_finalize() will do
> kvfree(rw_header); but without it currently, jit_data->header is never
> freed.
>
> But I think we shouldn't use bpf_jit_binary_pack_finalize() here as it
> copies the whole rw_header to ro_header using  bpf_arch_text_copy()
> which is an expensive operation (patch_map/unmap in loop +
> flush_icache_range()) and not needed here because we are going
> to free ro_header anyway.
>
> We only need to copy jit_data->header->size to jit_data->ro_header->size
> because this size is later used by bpf_jit_binary_pack_free(), see
> comment above bpf_jit_binary_pack_free().
>
> How I suggest we should fix the code and the comment:
>
> -- >8 --
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
> index 5083886d6e66b..cb4c50eeada13 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -3093,12 +3093,14 @@ void bpf_jit_free(struct bpf_prog *prog)
>
>                 /*
>                  * If we fail the final pass of JIT (from jit_subprogs),
> -                * the program may not be finalized yet. Call finalize he=
re
> -                * before freeing it.
> +                * the program may not be finalized yet. Copy the header =
size
> +                * from rw_header to ro_header before freeing the ro_head=
er
> +                * with bpf_jit_binary_pack_free().
>                  */
>                 if (jit_data) {
>                         bpf_arch_text_copy(&jit_data->ro_header->size, &j=
it_data->header->size,
>                                            sizeof(jit_data->header->size)=
);
> +                       kvfree(jit_data->header);
>                         kfree(jit_data);
>                 }
>                 prog->bpf_func -=3D cfi_get_offset();
>
> -- 8< --
>
> Song,
>
> Do you think this optimization is worth it or should we just call
> bpf_jit_binary_pack_finalize() here like this patch is doing?

This is a good optimization. However, given this is not a hot path,
I don't have a strong preference either way. At the moment, most
other architectures use bpf_jit_binary_pack_finalize(), so it is good
to just use bpf_jit_binary_pack_finalize and keep the logic
consistent.

In the longer term, we can consider refactoring bpf_jit_free so that
multiple architectures can share code. After this patch, bpf_jit_free
for x86_64 and arm64 are very similar to each other. There are
likely some opportunities to reduce code duplications.

Thanks,
Song

