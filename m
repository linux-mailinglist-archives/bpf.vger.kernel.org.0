Return-Path: <bpf+bounces-17757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E60812448
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 02:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3D91F219D3
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 01:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BDB644;
	Thu, 14 Dec 2023 01:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy/jbhBU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6719D0
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 17:05:17 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cea2a38b48so6925837b3a.3
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 17:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702515917; x=1703120717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zh7Ff0t9w8NwrzkvhOG4WAOOqKEmLe6U4GxH7CeM0eQ=;
        b=Uy/jbhBUMbEdlGuMEcVAFgLTJf1N08+e8rfTEfUxmozuOpyQT9RRG20L+2ytDkggAO
         p8S0mc03VIpA9CRO9/O7WOu49hIxIjCcosXzE+W8dIe8S4Ru6Wjtpe/nK0rJ/iHq2Vt3
         oHt4iOEIaV5YI42gyueykEcZGU92peyaalCaMRcw4JSTRNmjuxpUta6LICq7d2vIwEkO
         +7sIrwXOz0aYtgU9nA8Ar5REVHoSlV05GYKzhxcluYQnhhpaA/xf/PSYYVstQo40kzVi
         OtTro1tnYm4KNCU+a2BAnGoN8yNcxpd9AjHhU2rRQg5rriGrrmHpOabV/F0sjX48jhV0
         RoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702515917; x=1703120717;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Zh7Ff0t9w8NwrzkvhOG4WAOOqKEmLe6U4GxH7CeM0eQ=;
        b=NDILMw53gMKtPrQ+Y8YAiyvmltY/UGHTyDyeUz+d4FHBN0T63koVT9dSfG9JPZ+bTD
         owQbYjEGHYRw5h8ixPLuyuNvovqAFX7jnXVaXX74IgfrsZecB4L4oqL30XS8PKp8wK4Z
         Kk9iDCV+myzPWpQPD4zo7sIvV3mb+09Ok6CPMBI6eSdH1Y+K0dM61sQiZZn/dokTjfxp
         LqIJi91nBPgaoM60bR194KOaBAn9LtGNhjDsLIFT4NhQiOPdekgsqfDU+e66Xb3e7Hcp
         134H/8pOBbpsiWwF7BdionGjFLPg3NEXYLBr8VQH/7JYwbtHPkvK7+yxIodu/h/e8fVs
         qxkQ==
X-Gm-Message-State: AOJu0Yx8qUhGQySCeBEbQB2iWdGbIJWud3kyDOXXd84ALF51xxhpDbsk
	GOnj5U52eazAiojd6b9Dvf4=
X-Google-Smtp-Source: AGHT+IHhAUaaZ/hvn56b52cV2BX1Pa8mpmJTySiZTlJzMYZVyQQXAf5jYTWcNUrT5Vvd/XwCEfs7AA==
X-Received: by 2002:a05:6a00:2301:b0:6cb:903a:b064 with SMTP id h1-20020a056a00230100b006cb903ab064mr11192920pfh.22.1702515917016;
        Wed, 13 Dec 2023 17:05:17 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id gx4-20020a056a001e0400b0068fe9c7b199sm10546878pfb.105.2023.12.13.17.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 17:05:16 -0800 (PST)
Date: Wed, 13 Dec 2023 17:05:15 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@kernel.org
Cc: andrii@kernel.org, 
 kernel-team@meta.com
Message-ID: <657a54cb684b1_44156208fe@john.notmuch>
In-Reply-To: <20231213222327.934981-2-andrii@kernel.org>
References: <20231213222327.934981-1-andrii@kernel.org>
 <20231213222327.934981-2-andrii@kernel.org>
Subject: RE: [PATCH bpf-next 1/2] bpf: support symbolic BPF FS delegation
 mount options
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Andrii Nakryiko wrote:
> Besides already supported special "any" value and hex bit mask, support
> string-based parsing of delegation masks based on exact enumerator
> names. Utilize BTF information of `enum bpf_cmd`, `enum bpf_map_type`,
> `enum bpf_prog_type`, and `enum bpf_attach_type` types to find supported
> symbolic names (ignoring __MAX_xxx guard values). So "BPF_PROG_LOAD" and
> "BPF_MAP_CREATE" are valid values to specify for delegate_cmds options,
> "BPF_MAP_TYPE_ARRAY" is among supported for map types, etc.
> 
> Besides supporting string values, we also support multiple values
> specified at the same time, using colon (':') separator.
> 
> There are corresponding changes on bpf_show_options side to use known
> values to print them in human-readable format, falling back to hex mask
> printing, if there are any unrecognized bits. This shouldn't be
> necessary when enum BTF information is present, but in general we should
> always be able to fall back to this even if kernel was built without BTF.
> 
> Example below shows various ways to specify delegate_cmds options
> through mount command and how mount options are printed back:
> 
>   $ sudo mkdir -p /sys/fs/bpf/token
>   $ sudo mount -t bpf bpffs /sys/fs/bpf/token \
>                -o delegate_cmds=BPF_PROG_LOAD \
>                -o delegate_cmds=BPF_MAP_CREATE \
>                -o delegate_cmds=BPF_TOKEN_CREATE:BPF_BTF_LOAD:BPF_LINK_CREATE
>   $ mount | grep token
>   bpffs on /sys/fs/bpf/token type bpf (rw,relatime,delegate_cmds=BPF_MAP_CREATE:BPF_PROG_LOAD:BPF_BTF_LOAD:BPF_LINK_CREATE:BPF_TOKEN_CREATE)
> 
> Same approach works across delegate_maps, delegate_progs, and
> delegate_attachs masks as well.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

