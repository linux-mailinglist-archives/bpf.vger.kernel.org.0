Return-Path: <bpf+bounces-68873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AA1B8762B
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 01:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047E81C27EF6
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 23:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74847286D70;
	Thu, 18 Sep 2025 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXuhhvEv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1AB2F2E
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 23:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758238202; cv=none; b=Fy5IQJZZTHeGQwQVziwL58573T/II4XNNWQupbOOc+SgkifWKT0gZXubcvrS5CB85GSHGgSJfqW99ZBAlVxgvHK5HWa36ReRMKyDwnFiOlPPe/4HX4h5GI1fJKmFaxeXAYW+UTJ1QNUf6zBOLSXDsdooAH2Fic/17ORws15OYcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758238202; c=relaxed/simple;
	bh=n4EgfhLvMbMZE6nqhsNhp7+hJGGf7NHnBqXPzzOxTGQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J8gYppbD+MJDkDdlgV9RWKbhYZzDuKcaTwLSf9CHYD2ODWqipNy0EjfimrQEgsq3sK8wgNtBqRHGqaLEnXyNipq7K9/2lxwntKLXt1X5gKRGXaZYwy+2+PeTM/jp3UseWEC+v1wvBXmYi4bmJYgMINbPxWot+x3UMCyedynqRrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXuhhvEv; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so1744047a91.2
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 16:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758238200; x=1758843000; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CtSE/vivfhzb5bG1iK3Lr//FWW6En9tprv0275yO75o=;
        b=QXuhhvEvVAxPYbYd6s0SNWX5qhZgggx1olfDHzHDWSn04aCRUCbKkmgiDUyUb2FSSC
         ytIWszZFnq7E5ZVGNwBwPIYsKYW5hlvi79wraKitGUVwuK0/TxuKqrqO0qbFRtf1spgU
         SvCUHZt6x+qAS7qI2+bVDNxyQU7FnIvNFELthI32c+AjNLeAL1cR1XEaLODnK+Vw0wtw
         LH/B7v44XKUKiYUwr/25vLCICHJ5H+wFavVi95JLf2fimWEYjHa36Q+vGaKDtGfLD8Zu
         rDPflcPlmAVPXlUVlh9p0eJGm26UBwbMMFNQSkJmRcRaTc6r6dZtX9XoDX2vuETv5Kvq
         8bFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758238200; x=1758843000;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CtSE/vivfhzb5bG1iK3Lr//FWW6En9tprv0275yO75o=;
        b=vMo3NE07TjRy3dpqf+vIzjus98jShZXPSgFssR6E2sXyfyy1YpVXlEXsXIPZ6gA1B9
         WLDh7250xq2oLHBgfpX9RdtknqU96kvaWdmw7G4LeGlixp2dh9eNDdzJhSJJVH1hGXKA
         jJDUcYXHgewu8rOvsXPF7ytaOo2qrlW5+TpB7Wc51AMvZct04EFNjvKuKwYaRxhTFZVu
         awhijbLWSmSpNt393MNA/PRijR6xb3hVMLejMyV7qV7X4JdE7uIZdSabcSksObO8/lvX
         HwihRs0CrMzKF0KRsz8XsMxgvUAccfLAbUcBZ62hQLBY5e05KUXXobhUuV1663y11+pU
         nC1g==
X-Forwarded-Encrypted: i=1; AJvYcCXuwUpFCXv5wPDpcBW5WJaFPZlIUWQNzyBljK0PfobqoJ/B8LAqN67vbwvvc/YY8nrrtk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ7KhC9591Z7f9YRpXyH1eaSzEdl0J3wFLIfdTvSvHrPhgmyrq
	ZRPL6hKurBb7dk60lLSieYKrQR/TJKC+bB07kJXZRmTwiAfSo+eHCsTFio62AO4f
X-Gm-Gg: ASbGnct1RIM2zRQ+BXJ37qqCznQrchhWqMkbO80fnqfTx9xgKak+J6Jai8ejEMA1DVz
	v1lFsab/0keAM7tEwpIVUqgiUzOiaEfKMFtmY+mercjzQR5p1sK3Q+05cL0HctV42oElxCMVakV
	79dEIouFhmVEZTcHcQ6oj7FXM/8DVwHUBsr0I1vbb8LMmAaZ9TFnPyqbYUwqQkHeijRoo3vytta
	V9Mo5vhnI+wen8PAZZHq3SmrcpO1JkonW3UoPqKOp8UkppabRJtmG5va3QLfhziLPvcpSmKSLBH
	dW2SUdZMFN9nxOAac9IFl63pV1RkYZDo0KoZxCb9HnSCRGb1nl3vJWHWP05lVo9ISRFbP5p9QU6
	tUIS8pNUeaMLdEy1Ibun/Rrbq7Vs+TVeMCII3/w==
X-Google-Smtp-Source: AGHT+IFqdAW6QWbRPmXmLjcDfdF205+YVUpNchhUsl3kSUwHe+RbArF51anCuXYmVylicN71EZfJcQ==
X-Received: by 2002:a17:90b:3d0f:b0:32e:7497:4a4c with SMTP id 98e67ed59e1d1-33098345c1amr1601091a91.18.1758238199834;
        Thu, 18 Sep 2025 16:29:59 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55138043b6sm1393714a12.26.2025.09.18.16.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 16:29:59 -0700 (PDT)
Message-ID: <5d1f41605348e45e60c95a75bdbb286efa3ef3ac.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 4/6] bpf: Add common attr support for
 map_create
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	menglong8.dong@gmail.com
Date: Thu, 18 Sep 2025 16:29:56 -0700
In-Reply-To: <20250911163328.93490-5-leon.hwang@linux.dev>
References: <20250911163328.93490-1-leon.hwang@linux.dev>
	 <20250911163328.93490-5-leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-12 at 00:33 +0800, Leon Hwang wrote:

[...]

> @@ -1355,6 +1356,18 @@ static int map_create(union bpf_attr *attr, bool k=
ernel)
>  	if (err)
>  		return -EINVAL;
> =20
> +	if (common_attrs->log_buf) {
> +		log =3D kvzalloc(sizeof(*log), GFP_KERNEL);
> +		if (!log)
> +			return -ENOMEM;
> +		err =3D bpf_vlog_init(log, BPF_LOG_FIXED, u64_to_user_ptr(common_attrs=
->log_buf),
> +				    common_attrs->log_size, NULL);

Maybe use common_attrs->log_level instead of BPF_LOG_FIXED?
Just for consistent behavior with program and btf load operations.

> +		if (err) {
> +			kvfree(log);
> +			return err;
> +		}
> +	}
> +
>  	/* check BPF_F_TOKEN_FD flag, remember if it's set, and then clear it
>  	 * to avoid per-map type checks tripping on unknown flag
>  	 */

[...]

> @@ -1565,6 +1605,10 @@ static int map_create(union bpf_attr *attr, bool k=
ernel)
>  	bpf_map_free(map);
>  put_token:
>  	bpf_token_put(token);
> +	if (err && log)
> +		(void) bpf_vlog_finalize(log, &log_true_size);
> +	if (log)
> +		kvfree(log);
>  	return err;
>  }

+1 to Andrii's suggestion to report log size back,
just for consistency reasons.

