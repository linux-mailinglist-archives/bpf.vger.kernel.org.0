Return-Path: <bpf+bounces-27767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5778B17CC
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 02:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4761F24553
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 00:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98D6A38;
	Thu, 25 Apr 2024 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR39c2Va"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE8B386
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 00:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714003811; cv=none; b=oofbhiJ4xWbZas0ByplXnojrQzcPOjSgsy/FootsQpOhgho4JQHPVuyfefcGF+LXgrD0B/KKoRgfX/NW3UFHar1Hy0dIdhG46sAITQjSn9+HYFoYt28U40y4JYv4gY2240OOEiUhVPnzG4eDAv1e0+ZwRH3oTi9UYccGimyVYkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714003811; c=relaxed/simple;
	bh=lmOxA76wxHEfVbi3tuKQ2Hz7XO0QIn/Q9Ez2eV+cCPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jaSR1bE52CnVqHQHV7PxrMGtzBtYjgO7uxi1L4VOjjpGcagiHAdcwSOCgd2zQlqD2hY02H3jZQbIJy6QcWG+h6Tavk2b97vKF3bBPmRNOEXUDssff3u6+LgtRjFgjeTGxFuAJE2yqTPBC39bj+kpZnLxIu1QDDQ4WOorp7xdugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fR39c2Va; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ecec796323so492344b3a.3
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 17:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714003809; x=1714608609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWC/+Umc6aoN24kSGdEpV6rytDVsFSucj9lWuMWLt7I=;
        b=fR39c2VajFVFBtG19UMjvzkCY3WWUK4IiuM6kwV35AlHxNWp8vVODdZU9JOv2V9Rid
         YOuMXAfHvOP90HPlK31LnvKh9jLAAXKEfQ7w3sMbkbAppAY6dfltTmh9g5vTpLspyJAp
         zMt25zD4fObxWukD2zvyfPamT2s+DuAX2Jbde+ge1OzdtFy1qh4xzKhMrrBrLOp7DRiQ
         wSM1o7brvfwrhoKXtpKsMRamQwFWzwMgjMQVbuGS5irgbHTh4QmlJ4LR4E3cgnvq2m3K
         fHARl6beAjkX7Fxa2t2eFqfnJshyejDNRXKVhEw8/CwVZymJfoE7KY5wKbtpzKKsMnS0
         vTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714003809; x=1714608609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWC/+Umc6aoN24kSGdEpV6rytDVsFSucj9lWuMWLt7I=;
        b=h5S4uUJh/mb/cCm9V6hoRDq0j0EzT049jqUtXGe/TYAlsA7rjZtKphNhzSXu0QHq2c
         g6zx4sJitg+vcOL2zzey8Nh+zs4c8r8nrULUbAmahfDvjN5DJYmNb2arj56hmPOTYRa1
         zpRuy8thhfv4Z/ra9NQHakUeJRzwizInff7WcXPX0nwgGL90nkCf6o56909JD/qn8HQp
         mk847XI5l9EwG35LmXVj1JPXaDv1EtMOmsJaQq41txbEwM+gJGEtNWBc06xLHjDXaZG6
         WjwK7Y3gnnABYsesqNVR5hM+m6mI2OSPqRvVzai1uS+FzKFADPlr/UoKj49DSoGHl6F+
         aGUg==
X-Gm-Message-State: AOJu0YyansA+VUcRIemzvCf0yHoi+IZaSXZFSgaWvPQaiyAuNLw/XzoX
	fdNCVnggvU8PlN/4DVOsvpJG6lW4gqFT44ilz809lH/hzx21v2Wt0TjnR6N7LmHK6PLxYB6qaEz
	QVnWeKK0/9WfV0Yu4KtquSHQIQ8jkfA==
X-Google-Smtp-Source: AGHT+IGMCa6Y5/HbyvSoqW08/wl7SoF2Rf9mDWgLSMAKtEOxLZYDrzrGvfrYsZ5Z69iDahMgRpkpnBO1hY9lqY6CeHg=
X-Received: by 2002:a05:6a20:9484:b0:1a3:e2c4:956e with SMTP id
 hs4-20020a056a20948400b001a3e2c4956emr3818533pzb.25.1714003808774; Wed, 24
 Apr 2024 17:10:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418163509.719335-1-thinker.li@gmail.com> <20240418163509.719335-2-thinker.li@gmail.com>
In-Reply-To: <20240418163509.719335-2-thinker.li@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Apr 2024 17:09:56 -0700
Message-ID: <CAEf4BzYMZYJa3mTjgp7uY6Xw==SAgbvjar2xYHXCE-eqXj8_Kg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: enable the "open" operator on a
 pinned path of a struct_osp link.
To: Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, sinquersw@gmail.com, 
	kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 9:35=E2=80=AFAM Kui-Feng Lee <thinker.li@gmail.com>=
 wrote:
>
> Add the "open" operator for the inodes of BPF links to allow applications
> to obtain a file descriptor of a struct_ops link from a pinned path.
>
> Applications have the ability to update a struct_ops link with another
> struct_ops map. However, they were unable to open pinned paths of the lin=
ks
> with this patch. This implies that updating a link through its pinned pat=
hs
> was not feasible.
>
> This patch adds the "open" operator to bpf_link_ops and uses bpf_link_ops
> as the i_fop for inodes of struct_ops links. "open" will be called to ope=
n
> the pinned path represented by an inode. Additionally, bpf_link_ops will =
be
> used as the f->f_ops of the opened "file" to provide operators for the
> "file".
>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  include/linux/bpf.h         |  6 ++++++
>  kernel/bpf/bpf_struct_ops.c | 10 ++++++++++
>  kernel/bpf/inode.c          | 11 ++++++++---
>  kernel/bpf/syscall.c        | 16 +++++++++++++++-
>  4 files changed, 39 insertions(+), 4 deletions(-)
>

This is already supported, but you don't do it with open() syscall.
bpf() syscall provides BPF_OBJ_GET as a counterpart to BPF_OBJ_PIN. So
what you/your users want to do should be already supported through
libbpf's bpf_obj_get()/bpf_obj_get_ops() APIs. Have you tried that?

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 5034c1b4ded7..a0c0234d754b 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2160,6 +2160,12 @@ extern const struct super_operations bpf_super_ops=
;
>  extern const struct file_operations bpf_map_fops;
>  extern const struct file_operations bpf_prog_fops;
>  extern const struct file_operations bpf_iter_fops;
> +extern const struct file_operations bpf_link_fops;
> +

[...]

