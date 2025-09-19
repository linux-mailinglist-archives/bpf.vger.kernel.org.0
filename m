Return-Path: <bpf+bounces-69004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D9EB8B957
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 00:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDA0DB665A3
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 22:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386C32D660A;
	Fri, 19 Sep 2025 22:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpNU1SxH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D832D6636
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 22:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321492; cv=none; b=kdDwl5KhbICp56NJvF5iI/DI5DKg7sNIr3nvKrU2m83vCFw8wFi7jhBEZiePW8O/euOEQo15Iki80lyhUe89HM/r+Td6UGv5jXkZ5/8p4GktOQnT/FhZ5glIKyrq4UcxIOB7MPf3OWwy1D0j5/lsFhN91BQU3BWoKuj3QHsCxHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321492; c=relaxed/simple;
	bh=1QDuwK6JmCs3mQmCp7IrqlLAjWOOFGEICh6QKC1G0Xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlKxbBkzWgtr8UBq7h+eItgwC8IPwVykIceN5e/eux/X06D+HeqcfIpOf8Ge9zPTB+CyuMOPPjxf76YCcPS/94VXFAhRwtxAzKFuv7eV0oBlu9rM8+7yr7K2AKquLVws79z+yzZSqGpL99BD8EoMHBD6RXv3AcpL5Am23LSM3Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpNU1SxH; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b54abd46747so2618858a12.0
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 15:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758321490; x=1758926290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwMdv+p19BGi7esfYOG2GhYtNoTlMjkcb80apKjxE8M=;
        b=VpNU1SxHpu+eFxeyFow1pdCBSvXPPckHzlBkpLfYY12XjLxazMH7hYUZUJYrejH1o7
         lpaY+d2FpMZWDGb6OP57OUjm18iu7lkvOhvp7psYfU7a1U1T/noMQY7VMKGLlVmx7ei7
         MZxpoi94vtoArZdl8McxgzAHhypVeiQF2Gkxf1I8mjjYVGo3t0gKtcraaq48WSyVJw00
         q+E+BKwSvmRMJBIr7qgwMz7LBW+S/Gg4o1doy+RfMGYA353nRmMxZDLf/Le0XveKOOQF
         uMlHxnUyrdRYrNak/UNZTG6hFDgkLhRhU4FLpbgWvL1F39EmoI69nduLNMDNISPmW0aF
         YvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758321490; x=1758926290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwMdv+p19BGi7esfYOG2GhYtNoTlMjkcb80apKjxE8M=;
        b=vIhQCd+SFLHH7CvhjH6lLkeTxLIbjGgqSdv/Bsokz69kUMliGt/ylaK03hdxLL7KFo
         wroisgpddFPuPauvoBTpKopNEyXp+So3I7Q/zypjF4kHcuOb/jZuE2q+Cm78jI4DV8ok
         ZTt+FCiILZc/1cwsg792uWbwUtXV9qaBlzFUd1FiqZk5pSaTpWGtuF9dh0LXJbNdGtU/
         QrwOSxa7VT0q65+RyJsUwatP6FXe/czRbClCXhQxXzYpQ4ho4Po6R75AwqHzau3Peamd
         bvbEVFIMCQhUmet9SBAzfbrHo0Qdy0IxQsXqFDkZNrY7khV1yT3TGx/lamgqcBs9oif1
         GvRg==
X-Forwarded-Encrypted: i=1; AJvYcCUiv89WzxQpbjYucjXPWJhTsVTlC49d7Wa7PfoT6qsVEh44MtGbzBlssLo/IGCHpAySmF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/KH9T1cnc3wrXLAx2e1coTIMPXPXdJdw8mQCd1tLiK4OHROOh
	8fJ8QeQV3JUiHsAN/ygQZ2WYtOxGNyvKteAMM4gHxMC2i1U+KtPgqBQkZ+OiUq68KxOYTq/vgDS
	wMwSYSJE6p1m9y14sNHZFcwy2KpUzGjc=
X-Gm-Gg: ASbGncv1VZMHdpuhqgkH7Z3umFmZcADSSX0nEEmKd4x1fQqSxfRgAH3KU7ZM4S8XQzF
	pff5GgLZcH/0RhJ6OAdZg0XhMllYJYnsSlpXxywlsMiQMAFayC4UYFC37hL1JBDz6HvQU4phLAT
	a6TaNIGRT/URiEOHsHXy0xNIJXmKHdrlsXAkbc4DxZ4egsL2qDd6ZugpVNFZ8WG7rRU75gOodUh
	zc2yXGzOqKzwWeY7ndavb4=
X-Google-Smtp-Source: AGHT+IG5geaR0OTD/awjdGs5/vlEzVQFwf3QVLO4VifwvhZLe07HajKCLeG+iAVevYXk6ErhK7TN/q52Y2EL8n/fzcs=
X-Received: by 2002:a17:902:ccd1:b0:264:8a8d:92e8 with SMTP id
 d9443c01a7336-269ba5782a1mr68547505ad.59.1758321490463; Fri, 19 Sep 2025
 15:38:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919034816.1287280-1-chen.dylane@linux.dev> <20250919034816.1287280-2-chen.dylane@linux.dev>
In-Reply-To: <20250919034816.1287280-2-chen.dylane@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Sep 2025 15:37:55 -0700
X-Gm-Features: AS18NWB691QlcmBJKikgcgx1RsqS2VESdVs2gFgHpIjJauaKsboNjsk2CHaQDRk
Message-ID: <CAEf4BzbmTK9HtR0RwY30bPa1oObALv_prfZJ2sZq3eZku6pTzw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] bpftool: Fix UAF in get_delegate_value
To: Tao Chen <chen.dylane@linux.dev>
Cc: qmo@kernel.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 8:48=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> The return value ret pointer is pointing opts_copy, but opts_copy
> gets freed in get_delegate_value before return, fix this by free
> the mntent->mnt_opts strdup memory after show delegate value.
>
> Fixes: 2d812311c2b2 ("bpftool: Add bpf_token show")
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  tools/bpf/bpftool/token.c | 90 ++++++++++++++++-----------------------
>  1 file changed, 37 insertions(+), 53 deletions(-)
>
> diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
> index 82b829e44c8..2bbec4c98f2 100644
> --- a/tools/bpf/bpftool/token.c
> +++ b/tools/bpf/bpftool/token.c
> @@ -20,6 +20,16 @@
>
>  #define MOUNTS_FILE "/proc/mounts"
>
> +struct {

this should have been static, fixed up when applying


> +       const char *header;
> +       const char *key;
> +} sets[] =3D {
> +       {"allowed_cmds", "delegate_cmds"},
> +       {"allowed_maps", "delegate_maps"},
> +       {"allowed_progs", "delegate_progs"},
> +       {"allowed_attachs", "delegate_attachs"},
> +};
> +
>  static bool has_delegate_options(const char *mnt_ops)
>  {
>         return strstr(mnt_ops, "delegate_cmds") ||

[...]

