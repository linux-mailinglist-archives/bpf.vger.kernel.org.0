Return-Path: <bpf+bounces-19054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96E482488F
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 20:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7448C284285
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 19:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B210B2C194;
	Thu,  4 Jan 2024 19:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S9PehNeE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D95C28E1F
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a29058bb2ceso29755466b.0
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 11:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704395080; x=1704999880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xABQKYwqb6Tn050lqN4gkUa6ogl98DT9i/4GjNnCoY0=;
        b=S9PehNeEr+4blxt6e8NKLyPCSA2MX+RY9rcAoM3px4mPQPOO+kRd3glFZgMH+UW4r7
         MZ9qeyyNPJiGMZHOYIR/4hJ/a7FeOvgqlL0xGVzFT9nNcQCiezvfZfYVNzLd/fLUqawB
         Pap8dX9qdHLkAx09xHOOuRMXM5t3EdOsWhD7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704395080; x=1704999880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xABQKYwqb6Tn050lqN4gkUa6ogl98DT9i/4GjNnCoY0=;
        b=UdovhkF4W/Q60Aao2xhxfC+I6zdLpJwWzPlMZ65SrTE+7zbCPAd2b03nZe97GHLmXj
         cQoOEZRiH9S2K5olU+7zBz2t3NMJUHy+fmm8b01720Bay0UUrAes5e6jKvMolq9f5wLy
         UbR79z+CK2iQp4b/9YwFGLVVQXJ932WYnPJL67recw+5A4xhQ9GPIp7SyhoZVBogfiG1
         85XG8a4qiI/qvRrVjeV4Uzq7Fj02DcPYdvuDd5VMz5pmkUplSj5rzxNOWh2h6ox1vxsV
         VsJYBDP9AcTK+XxJkG0LdcH263MAWANkhOKs8AWgDxltO31uB/0bt6bgJCHgFjE41uqJ
         aNDA==
X-Gm-Message-State: AOJu0YwHWpGOykeCGQHKo/9fq0EVmw5ZqifpMPfNnIk1GziwyAcO8LDy
	aZ5baDwxK2UzO88ZmmvuePMKNWtmcoVVuBJRjqSx/dYqziMLWThw
X-Google-Smtp-Source: AGHT+IEDxcnNQ45/vg6EPB2ExlhbnHeM2ND3a2hWQXw6QaT+7/uiuE90aoP/Z2IH3+/4yzIefS1zGQ==
X-Received: by 2002:a17:906:7fd8:b0:a28:cd62:c4d8 with SMTP id r24-20020a1709067fd800b00a28cd62c4d8mr354799ejs.121.1704395080558;
        Thu, 04 Jan 2024 11:04:40 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id zz15-20020a170907350f00b00a26c8c70069sm12015574ejb.48.2024.01.04.11.04.39
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 11:04:40 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a28d61ba65eso102556066b.3
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 11:04:39 -0800 (PST)
X-Received: by 2002:a17:906:18:b0:a28:f456:42a2 with SMTP id
 24-20020a170906001800b00a28f45642a2mr318777eja.44.1704395079598; Thu, 04 Jan
 2024 11:04:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-14-andrii@kernel.org>
In-Reply-To: <20240103222034.2582628-14-andrii@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Thu, 4 Jan 2024 11:04:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=whDxm+nqu0=7TNJ9XJq=hNuO5QsV7+=PTYt+Ykvz51yQg@mail.gmail.com>
Message-ID: <CAHk-=whDxm+nqu0=7TNJ9XJq=hNuO5QsV7+=PTYt+Ykvz51yQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 13/29] libbpf: add BPF token support to
 bpf_map_create() API
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 14:24, Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Add ability to provide token_fd for BPF_MAP_CREATE command through
> bpf_map_create() API.

I'll try to look through the series later, but this email was marked
as spam for me.

And it seems to be due to all your emails failing DMARC, even though
the others came through:

       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org

there's no DKIM signature at all, looks like you never went through
the kernel.org smtp servers.

             Linus

