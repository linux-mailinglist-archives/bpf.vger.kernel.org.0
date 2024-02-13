Return-Path: <bpf+bounces-21879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D703A853ADF
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 20:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07A731C20159
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 19:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C720160B8B;
	Tue, 13 Feb 2024 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfGkRC3/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D468B6089F
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707852242; cv=none; b=KOGzFYlp87xdSUeLkJ4yiJgC4HH1AAwc9X52XvXjNN9t/eu3I6I1wzT9fbuDLNvlwOloght1PQFqi48Bv9y/GjlD7D8u7nwIQOdEVVfg5n2F8HV9IGWCTmvsyzahF/ec0xGKXsQKnG1cSdqKGfaswKCRVgtGvzY26ooqeh+Njn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707852242; c=relaxed/simple;
	bh=9zOk1rWnPUhnOJKSpql+o3d/jdQFvfeMKHboF9P/JAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QzUnYysvTBBpF5XZ9NWmeygtFWlQbWY6KgHijJfggH/LDQMH7WgfwSpWPpTTxDq0iDe43o84sniUGAxHYAW312QYE1Gvj9Jw/9GawtlfJ99p+u5LkuAp6pxG5t4pirDz01b1SsshIqFjkJPxPXbgIQTqGzqcdzPHPR8L3YA85MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfGkRC3/; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d81b08d6f2so3701337a12.0
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 11:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707852240; x=1708457040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TAbWgoQ3usiqyBPxeWDgPAK+L7/0ewXY5l8+wsWur7M=;
        b=dfGkRC3/UJiVTaTK4568XtDqvj3N0Cl5kl55EsX7fRAwwRGrRwSpt/CcajRwk4y++r
         pKQAu+Z8Ny1DXw+AMH9eK0PKYpG4erV8ZaUS9BAZrPr6PeSCfUU6vQD4fCpT+G4NhnE/
         lBQh6gbLmCclM5tOdi6REd833EYhATa5yDs8l0o76+WoF81gXX3GjpJodM3WnzMkZI4w
         GfFX3LRxyQyNL9Xn6Iok5IZFLfu3U8xnOVdJJ8bJwJC4OQ/UqCNvhtuSla+tNnuUow23
         NdXDNSgE/N3DMMIHtX4nDFTHg/taYKAD8fS0b0mIYr5vlav84BkUCnNuOc+K04945afH
         rkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707852240; x=1708457040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAbWgoQ3usiqyBPxeWDgPAK+L7/0ewXY5l8+wsWur7M=;
        b=Mm6iCjtX3CxxFwtciQaBcSjxy29bBFoQgqDjjZviZY+Icjvle9VFYGr5HVP5VLmI5a
         8weESSMcwB3ismSipKSxs17kURWGw5Kb0So/Pdaxg555DUFeDUBRGtB0FkUsEPHwhYx/
         5r61QdCqtqeVrpQHnQHPpqe/HpUb8hDgKmD2S/661p+J04VG1g2UFBsw/mhYeoV3gzu9
         ELIkRRrshJXhFkQ5jQVOm+BUpWVo4kZoVSFL9AbyX98xINjBwK9my/DoA+XV+1Qj6nrV
         PXWfdVK8YIkJslV1QO7f5fXnfiCHK3sP6hHZdGoYS747beC1+PBow2Qn58Cak+2FEVWs
         L5RQ==
X-Gm-Message-State: AOJu0YwqTLoKeEZGwP3TVL7geklbNlzI7QLz6pfpXcTpLGi7+jIbYVlV
	v+RRHykZEoIr45eN+dil3Cj5kT67kk9SmKUbHoqymG3VFVBn7gPPbVY+YMO30CyVTB5V7OO5beB
	3LKbU1ZNpczOrNn4ncIjqmBfRVkJNj9z8
X-Google-Smtp-Source: AGHT+IEQW54LLoPgK9WV0iEMPWDUGb7zHDbzn1dr5Lx7YO61E/Z3Kceo6ehHM88Dsg6u2xAOcr0H83HXat5BDDcV+eM=
X-Received: by 2002:a17:90b:18e:b0:297:11b3:6064 with SMTP id
 t14-20020a17090b018e00b0029711b36064mr398797pjs.43.1707852239994; Tue, 13 Feb
 2024 11:23:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zcuj0zHhFMML8-mU@google.com>
In-Reply-To: <Zcuj0zHhFMML8-mU@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Feb 2024 11:23:48 -0800
Message-ID: <CAEf4BzZUZ7ksw5ipH-Z7Wbmc+oRs=NRj0mQFboHCCLDPPvdZ5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: make remark about zero-initializing
 bpf_*_info structs
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 9:16=E2=80=AFAM Matt Bobrowski <mattbobrowski@googl=
e.com> wrote:
>
> In some situations, if you fail to zero-initialize the bpf_*_info
> buffer supplied to the set of LIBBPF helpers
> bpf_{prog,map,btf,link}_get_info_by_fd(), you can expect the helper to
> return an error. This can possibly leave people in a situation where
> they're scratching their heads for an unnnecessary amount of
> time. Make an explicit remark about the requirement of
> zero-initializing the supplied bpf_*_info buffers for the respective
> LIBBPF helpers to prevent exactly this situation.
>
> Internally, LIBBPF helpers bpf_{prog,map,btf,link}_get_info_by_fd()
> call into bpf_obj_get_info_by_fd() where the bpf(2)
> BPF_OBJ_GET_INFO_BY_FD command is used. This specific command is
> effectively backed by restrictions enforced by the
> bpf_check_uarg_tail_zero() helper. This function ensures that if the
> size of the supplied bpf_*_info is larger than what the kernel can
> handle, trailing bits are zeroed. This can be a problem when compiling
> against UAPI headers that don't necessarily match the sizes of the
> same underlying bpf_*_info types known to the kernel.
>
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---
>  src/bpf.h | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>

Doesn't apply cleanly onto bpf-next, please rebase and resend. Otherwise LG=
TM.


> diff --git a/src/bpf.h b/src/bpf.h
> index f866e98..568bcb3 100644
> --- a/src/bpf.h
> +++ b/src/bpf.h
> @@ -500,7 +500,10 @@ LIBBPF_API int bpf_obj_get_info_by_fd(int bpf_fd, vo=
id *info, __u32 *info_len);
>   * program corresponding to *prog_fd*.
>   *
>   * Populates up to *info_len* bytes of *info* and updates *info_len* wit=
h the
> - * actual number of bytes written to *info*.
> + * actual number of bytes written to *info*. Note that *info* should be
> + * zero-initialized before calling into this helper. Failing to zero-ini=
tialize
> + * *info* under certain circumstances can result in this helper returnin=
g an
> + * error.
>   *
>   * @param prog_fd BPF program file descriptor
>   * @param info pointer to **struct bpf_prog_info** that will be populate=
d with
> @@ -517,7 +520,10 @@ LIBBPF_API int bpf_prog_get_info_by_fd(int prog_fd, =
struct bpf_prog_info *info,
>   * map corresponding to *map_fd*.
>   *
>   * Populates up to *info_len* bytes of *info* and updates *info_len* wit=
h the
> - * actual number of bytes written to *info*.
> + * actual number of bytes written to *info*. Note that *info* should be
> + * zero-initialized before calling into this helper. Failing to zero-ini=
tialize
> + * *info* under certain circumstances can result in this helper returnin=
g an
> + * error.
>   *
>   * @param map_fd BPF map file descriptor
>   * @param info pointer to **struct bpf_map_info** that will be populated=
 with
> @@ -534,7 +540,10 @@ LIBBPF_API int bpf_map_get_info_by_fd(int map_fd, st=
ruct bpf_map_info *info, __u
>   * BTF object corresponding to *btf_fd*.
>   *
>   * Populates up to *info_len* bytes of *info* and updates *info_len* wit=
h the
> - * actual number of bytes written to *info*.
> + * actual number of bytes written to *info*. Note that *info* should be
> + * zero-initialized before calling into this helper. Failing to zero-ini=
tialize
> + * *info* under certain circumstances can result in this helper returnin=
g an
> + * error.
>   *
>   * @param btf_fd BTF object file descriptor
>   * @param info pointer to **struct bpf_btf_info** that will be populated=
 with
> @@ -551,7 +560,10 @@ LIBBPF_API int bpf_btf_get_info_by_fd(int btf_fd, st=
ruct bpf_btf_info *info, __u
>   * link corresponding to *link_fd*.
>   *
>   * Populates up to *info_len* bytes of *info* and updates *info_len* wit=
h the
> - * actual number of bytes written to *info*.
> + * actual number of bytes written to *info*. Note that *info* should be
> + * zero-initialized before calling into this helper. Failing to zero-ini=
tialize
> + * *info* under certain circumstances can result in this helper returnin=
g an
> + * error.
>   *
>   * @param link_fd BPF link file descriptor
>   * @param info pointer to **struct bpf_link_info** that will be populate=
d with
> --
> 2.43.0.687.g38aa6559b0-goog
>
> /M

