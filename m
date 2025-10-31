Return-Path: <bpf+bounces-73109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE996C236AD
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 07:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2B3188F236
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 06:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C112F656A;
	Fri, 31 Oct 2025 06:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWgZxD2e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BF5239E61
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 06:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761892639; cv=none; b=Ofx+5UGsYbFXVsuvY8lrf0UbyasI6SsX9r6hU1HaUljEMeMkLIlkjEK1wHLkK9FlDrrE6ufc8B7b1t6FReXJN+KRtyUDxNiPg34SU6Qyly7OBNvisRa0wEncs7X9kSmUS00sTSoRoZjATCEDuxWLJqme9k8UVTga0FNRep++uzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761892639; c=relaxed/simple;
	bh=vaP9tFVHrd+h3H4hUZXdcXreKNUI8n2Fq+c1yV7Q2Ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WevDn5VFYNVD4FGEps15UDiDB1xEHZ2UiuzHLuDQV2WECNZHQDjvhyNt87jefKLC/N0R9B5CY8IOscKZx9ODtlpsoY1gQdPkZd/NHD/YvyEcPsO+5Xr3DJAEAIuMMeujIcyuthVsCXT4dYdO9jT/cGXFsanR8eWB2NoJqrMJ2cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWgZxD2e; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-294df925292so16419205ad.1
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 23:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761892637; x=1762497437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDYWddzEhzy192wOWLvawa5saRjQOm029FdqACvNNZ0=;
        b=IWgZxD2eGivcA7Ep0azk2qGv2ZQW48r8NdRJQHR+uZNsuIbNPxzFK4+ZheG3oBm2Mb
         5X7lqgLPOQ1wnMx06hCwTiIcetlDfLowvreowL6sFDgytI3YeOiKfM5m8wmLmDe3VHh3
         5iug/vDpOR6flztM+rcYk46dBHfe3fBCZAp7mD7k4Cc6SGA57bNhyWQS2FmBBElYX2e5
         F2KHCMcMOPez2INS8vgHQrAlvWFy+pBXaM8KPSCSeDn2V+iHuyb4+Nzg9hZkjGONjhqN
         vyvWC/NC6o1KAR2wAJbPgEz04qdgMHTcxG8VbUJnNzdktQCNk2Dh26F3uaME5ltDIsf0
         rZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761892637; x=1762497437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDYWddzEhzy192wOWLvawa5saRjQOm029FdqACvNNZ0=;
        b=Mj/NPVxalq/zoFInizwJmpxhR3GBlol1I6dGVmF+XGeqTbIJCSF84tvAR8SIbMOJah
         /AnAMv5V37eGp42ArxG9JicI4FWxxENMI+2tbv9vsmnLUm/r9d0M3scJ8yrsZWFiNMTq
         KlxN8VFDiqULtQC454ugLAm2hmkoKYh6Fn3S5PFojVAMKspm8pskKYEgqEiB70UH5Oh4
         DW3kmIixDJHQ1kjvlKWsxv1BpEDvhhQ7sr1vrcpiHAHuKgaNpzeh2gmUGgfVq68zN0FK
         6WH1+b+r8gBtoZOE9/HY+/kXMEfxxbat18jbFuaE18SV574gOL6W49rrn7rPt62kMuOe
         77DQ==
X-Gm-Message-State: AOJu0YzgYATIh/+p+M0LbFKokrNB1WwAsMsW1i4XTTdgxh+eLt0p8sI5
	1z/IUxYXIPGb3MLnnNZhD7CHmhAFxdJIHBX9NnrF8js94Pb9hA5GXb2mRUFajSMroE5VwCeGsZU
	W768+qtbhCAzqXdiWZIgQVPujY+c5F2M=
X-Gm-Gg: ASbGncs3gENJEoguJItTpcY5ivEjwrP58eyzYwLdQG4Lh7+Mow0/KO6Tu0K8VoyiU56
	4P6qhalnKRJw7RX8UgYYpiJguuSRbZlEDnC4ausRjY+MqsauOFGeR01HAhoI5n7+QTaeDsLJym4
	xJaviQNNl2zhcXHzZLPg8NHza0Hbqmbe3BO7+4R0OvCrhzPN/xoKKUHyLIcHqTIerF0tDaFek0b
	AzxMbzcw9Dn6V4ZDOWkNKk8scAn0QxxTVrCW8FpQIOXWh4kl8DFjXN61+BURBjyy9gGfFg=
X-Google-Smtp-Source: AGHT+IHKvlwTT+v4lVp0g7UewFcEqQtoC0e/Rzm6EFfiRLL8K/1VBKeXr7TztP+Jn70agztCGIOlvZiTJHMPQ3Dj4hs=
X-Received: by 2002:a17:903:1ce:b0:27e:ec72:f6d with SMTP id
 d9443c01a7336-2951a36e6f8mr40862445ad.11.1761892636677; Thu, 30 Oct 2025
 23:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031032627.1414462-2-jianyungao89@gmail.com> <554b5b314ffd7eb00be58d5997d44c7c4986895ad28776a87a9d6a2bf1c0765c@mail.kernel.org>
In-Reply-To: <554b5b314ffd7eb00be58d5997d44c7c4986895ad28776a87a9d6a2bf1c0765c@mail.kernel.org>
From: Jianyun Gao <jianyungao89@gmail.com>
Date: Fri, 31 Oct 2025 14:37:05 +0800
X-Gm-Features: AWmQ_bkDa-Yulfkw8NVn1sKXKelgLuaoZX3bACDt0cDA73N01wPRBODLyGsfRxI
Message-ID: <CAHP3+4CWSbZdNjSdoQhsB9Cvc9vp7V3qzJ=EVMO5+By9ZeAr3A@mail.gmail.com>
Subject: Re: [PATCH 1/5] libbpf: Add doxygen documentation for bpf_map_* APIs
 in bpf.h
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I will fix it in the next version.

On Fri, Oct 31, 2025 at 12:01=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
>
> ```
> commit 4da02b18e2168885350f3935b5ce2f1f52c850ba
> Author: Jianyun Gao <jianyungao89@gmail.com>
>
> libbpf: Add doxygen documentation for bpf_map_* APIs in bpf.h
>
> This commit adds Doxygen documentation for 13 bpf_map_* API functions in
> the libbpf user-space library header.
>
> > diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> > index e983a3e40..bcb303d95 100644
> > --- a/tools/lib/bpf/bpf.h
> > +++ b/tools/lib/bpf/bpf.h
>
> [ ... ]
>
> > @@ -151,19 +202,452 @@ struct bpf_btf_load_opts {
> >  LIBBPF_API int bpf_btf_load(const void *btf_data, size_t btf_size,
> >                           struct bpf_btf_load_opts *opts);
> >
> > +/**
> > + * @brief Update or insert an element in a BPF map.
> > + *
> > + * Attempts to store the value referenced by @p value into the BPF map
> > + * identified by @p fd under the key referenced by @p key. The semanti=
cs
> > + * of the operation are controlled by @p flags:
>
> [ ... ]
>
> > + * @return 0 on success; -1 on failure with errno set appropriately.
> > + *
> > + * Possible errno values include (not exhaustive):
> > + *   - E2BIG:      Key or value size exceeds map definition.
> > + *   - EINVAL:     Invalid map fd, flags, or unsupported operation for=
 map type.
> > + *   - EBADF:      @p fd is not a valid BPF map descriptor.
> > + *   - ENOENT:     Key does not exist (with BPF_EXIST).
> > + *   - EEXIST:     Key already exists (with BPF_NOEXIST).
> > + *   - ENOMEM:     Kernel memory allocation failure.
> > + *   - EPERM/EACCES: Insufficient privileges or rejected by security p=
olicy.
> > + *   - ENOSPC:     Map at capacity (for maps with a max entries limit)=
.
> > + *
> > + */
> >  LIBBPF_API int bpf_map_update_elem(int fd, const void *key, const void=
 *value,
> >                                  __u64 flags);
>
> Is the documented return value correct? The implementation uses
> libbpf_err_errno() which returns negative errno values directly on
> failure (e.g., -EINVAL, -ENOENT), not -1 with errno set. Looking at
> bpf_map_update_elem() in bpf.c:
>
>   int bpf_map_update_elem(int fd, const void *key, const void *value,
>                           __u64 flags)
>   {
>       ...
>       ret =3D sys_bpf(BPF_MAP_UPDATE_ELEM, &attr, attr_sz);
>       return libbpf_err_errno(ret);
>   }
>
> And libbpf_err_errno() in libbpf_internal.h:
>
>   static inline int libbpf_err_errno(int ret)
>   {
>       return ret < 0 ? -errno : ret;
>   }
>
> So when syscall() returns -1, libbpf_err_errno() converts this to
> -errno. Should the documentation state "negative error code on failure"
> instead of "-1 on failure with errno set"?
>
> For comparison, the existing batch operation docs in the same file
> correctly document: "@return 0, on success; negative error code,
> otherwise (errno is also set to..."
>
> > +/**
> > + * @brief Look up an element in a BPF map by key.
>
> [ ... ]
>
> > + * @return 0 on success (value populated),
> > + *         -1 on failure with errno set appropriately:
> > + *         - ENOENT: The key does not exist in the map.
>
> The same return value documentation issue appears in
> bpf_map_lookup_elem(). The implementation uses libbpf_err_errno() so it
> returns negative errno, not -1.
>
> > +/**
> > + * @brief Look up (read) a value stored in a BPF map.
>
> [ ... ]
>
> > + * @return 0 on success; -1 on failure with errno set appropriately:
> > + *         - ENOENT: No element with the specified key exists.
>
> Same issue in bpf_map_lookup_elem_flags() - should document negative
> errno return, not -1.
>
> > +/**
> > + * @brief Atomically look up and delete a single element from a BPF ma=
p.
>
> [ ... ]
>
> > + * @return 0 on success (value copied and element deleted);
> > + *         -1 on failure with errno set:
> > + *         - ENOENT: Key not found in the map.
>
> Same issue in bpf_map_lookup_and_delete_elem() - returns negative errno.
>
> > +/**
> > + * @brief Atomically look up and delete an element from a BPF map with=
 extra flags.
>
> [ ... ]
>
> > + * @return 0 on success; -1 on failure with errno set:
> > + *         - ENOENT: Key not found.
>
> Same issue in bpf_map_lookup_and_delete_elem_flags().
>
> > +/**
> > + * @brief Delete (remove) a single element from a BPF map.
>
> [ ... ]
>
> > + * @return 0 on success; -1 on failure with errno set appropriately.
> > + *
> > + */
> >  LIBBPF_API int bpf_map_delete_elem(int fd, const void *key);
>
> Same issue in bpf_map_delete_elem().
>
> > +/**
> > + * @brief Delete an element from a BPF map with optional flags.
>
> [ ... ]
>
> > + * @return 0 on success; -1 on failure with errno set:
> > + *         - ENOENT: Key not found.
>
> Same issue in bpf_map_delete_elem_flags().
>
> > +/**
> > + * @brief Iterate over keys in a BPF map by retrieving the key that fo=
llows a given key.
>
> [ ... ]
>
> > + * @return 0 on success (next key stored in @p next_key);
> > + *         -1 on failure with errno set:
> > + *           - ENOENT: No further keys (end of iteration) or map is em=
pty (when @p key is NULL).
>
> Same issue in bpf_map_get_next_key().
>
> All eight of these functions consistently return negative errno values
> via libbpf_err_errno(), but the documentation states they return -1 with
> errno set (the traditional C API pattern). This creates inconsistency
> with the existing batch operation documentation and could mislead users
> about proper error handling.
>
>
> ```
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> In-Reply-To-Subject: `libbpf: Add doxygen documentation for bpf_map_* API=
s in bpf.h`
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/189619=
81609

