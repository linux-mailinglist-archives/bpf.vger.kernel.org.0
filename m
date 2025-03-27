Return-Path: <bpf+bounces-54836-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB51A73FFD
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 22:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615991B62A33
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 21:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBF51DDA0E;
	Thu, 27 Mar 2025 21:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfcTz3zO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D611D515B
	for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 21:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743109595; cv=none; b=SqpQ8amRVZ2epV47/cJ72zHcuvad5EFeqr/V1yQOKi0pxiTzXCQOyebm9KEbEkG3hfWPKF1xDbO7NUzQ8v/oSeKeqkqg7OWmp5xcVrLTcUyyVbQ+sjg9nZ/2Z6Str4Wj1yZk+SyMrPnYBckFXvDBC7nUBEmoul74QVES4WpFCQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743109595; c=relaxed/simple;
	bh=LR8O84X19vwUusxXF/OJHU/VeV01+Vst0QbDordKscM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JKFUupqfUScPWAnipwsuKce3T2qYDVHbQjBimkiYmfrrKRaaN1SCkYFScLy9JYG0yS3K9+Y2lQjrutZo6JMsEqHdUbC7sfUyOFBsr2gobitD3MpFPhK2Z3Z5844U79UK8bdc7c7MfQgyv/lRH06/MzcGuZGqY95q5i1FteRj/YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfcTz3zO; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3011737dda0so1869892a91.1
        for <bpf@vger.kernel.org>; Thu, 27 Mar 2025 14:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743109594; x=1743714394; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PuvJ7lfcvzjq39HUXfQVM5oPfpGstYAva51vhqcTrtM=;
        b=SfcTz3zOKNSDO7BC/7/5+R9HHZ1/tEZQ7/QALPVQHgz/0jF4xO5zBcoAJ6favjnqMO
         xWl7GOWZQHPx917hMgI/h8FVmy9njumQJclx/LeYQJ4WEeka8GMKFaE61buodpSzoes3
         oxyYLCcUqMDLU2kZoGePJNAOW/a75yo5fxNNPgMZ5ARmmSC4c9LwJ6Q3WptLcGSJ0uQD
         Bw72JXHIUsf8qF9rhNBXrp9cWLQ4w1R8BiEofUzElR5s6H+WFHjUtzZ2YQdJTJGvsNP8
         i4U1I0LiINDTlxoaasDk7J7ghyP0vV+Gnn7F/xJe1ZSAPFfhOwiR14D44wFhyNEjgihJ
         ndVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743109594; x=1743714394;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PuvJ7lfcvzjq39HUXfQVM5oPfpGstYAva51vhqcTrtM=;
        b=KZX3s301jXtPmtb4uw/IlyDVV2USqqneKMts5dy4u8g/mEyx+Gvddc7hxhd8z/pwBX
         xIBmRBr3SrwyKnvAVMQYViJLcRUlhOiB7PxBHpXI+9Dm115d8fvKiM2zIhWdBYCHqQWB
         jg0tp9lP1URuQ185aHRKB5i5nDE5BZ1GOALfmZMrXM/9EBWUfVNJBA/qGIqQaw5KnXCV
         EQt6CKMoQsyumVV9cODtOyNxyIMhnrPaJtxot/ZdZvxdWiD9QnTUmo2jLD43IvyHH+xB
         XTR0DFwhYcGliGLbzMe19m0HmrYi0InaD1137qdcejDjTKwunvlHyaLUWm4XBgG8oKSL
         kKnw==
X-Forwarded-Encrypted: i=1; AJvYcCUBh3RPwoRenfYTEvwt36v+waBzZ0w+4G7jHJwQ4q+HckVwEaDoEZ55zU6otrJA9Euh4lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsQVCcn00EMS5C4ehwgBvql6huppc92MPJlYFc7ddG+O1qypm8
	wDX0xOuvTbQlnxAwvH9oBNHRxF18gBnfs0T0UDZdkqSoX5OGI8ns
X-Gm-Gg: ASbGncvUPFuEqewmpoH/Nm1QaANeyDvOkzqFHU5g+a/BwkNgSWRgZjmcGMFdXAq+qFw
	87CCNVVNDcQzd3eewIE0mZoUAZQQnCcp1wjSwSufLmnn9ZuwhJ0kd0s11VDjU7w8eXNhCw7xafO
	E1eraT/1MOlc7C3dqu2zRom4dQ557cwauOtWEZpUtVN2O6VPNqYixy52dbDLaaLtuXGrqfP9hN4
	5WIiXDZmlXneTjdytMGd+S8s8y78RwPsUH7e1EQoKBgfE9BEa/0QA96GDCCGKUWJvfLO0mnsE3T
	lmkklTk4qtC7t1EswIWS5bGWkOOr5/QX7pqrm+E9
X-Google-Smtp-Source: AGHT+IF0p3hvI6DIiE8zVW6Samj8C/pLUkZL6nlFZDoO3C1NpdymL5hhSLPI715HnuDShc/AUnKO+w==
X-Received: by 2002:a17:90b:39cc:b0:2ff:5e4e:864 with SMTP id 98e67ed59e1d1-303a85c8f86mr7925574a91.25.1743109593431;
        Thu, 27 Mar 2025 14:06:33 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eec5cc9sm4598695ad.7.2025.03.27.14.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 14:06:33 -0700 (PDT)
Message-ID: <6a4bdba643dae8f5dd791949d6b76c03d26f194e.camel@gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: add getters for BTF.ext func and line
 info
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Thu, 27 Mar 2025 14:06:28 -0700
In-Reply-To: <20250326180714.44954-1-mykyta.yatsenko5@gmail.com>
References: <20250326180714.44954-1-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-03-26 at 18:07 +0000, Mykyta Yatsenko wrote:

[...]

> @@ -940,6 +940,14 @@ LIBBPF_API int bpf_program__set_log_level(struct bpf=
_program *prog, __u32 log_le
>  LIBBPF_API const char *bpf_program__log_buf(const struct bpf_program *pr=
og, size_t *log_size);
>  LIBBPF_API int bpf_program__set_log_buf(struct bpf_program *prog, char *=
log_buf, size_t log_size);
> =20
> +LIBBPF_API void *bpf_program__func_info(struct bpf_program *prog);

I don't like `void *` being returned here, but alternatives are ugly.
Maybe add a comment listing possible return types?

> +LIBBPF_API __u32 bpf_program__func_info_cnt(struct bpf_program *prog);
> +LIBBPF_API __u32 bpf_program__func_info_rec_size(struct bpf_program *pro=
g);
> +
> +LIBBPF_API void *bpf_program__line_info(struct bpf_program *prog);
> +LIBBPF_API __u32 bpf_program__line_info_cnt(struct bpf_program *prog);
> +LIBBPF_API __u32 bpf_program__line_info_rec_size(struct bpf_program *pro=
g);
> +

[...]


