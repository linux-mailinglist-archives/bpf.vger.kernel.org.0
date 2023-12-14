Return-Path: <bpf+bounces-17852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6594081357A
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 16:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10A881F21AE7
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 15:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9265E0B8;
	Thu, 14 Dec 2023 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPvujbuQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B74123
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 07:58:30 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1d351848c9fso9619625ad.0
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 07:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702569510; x=1703174310; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qOoPhCjb4CJRPnWbZPjhwalkYOW/D4DA0hOyNWvhhzU=;
        b=NPvujbuQ6zL9h+sURZGCqBea7lSfx1AluJt9M6qr9I0o6L/pilNd0mfBgLaWjrI5Oh
         dgnBlM9A26CB5fp5OrUxqRHSxADTGQAMtFM2MGrSS4k4F15cwvWSHNS2qh/4vMDDed/e
         P77l62GSux7edM0MHC5DRO5WMGCcU2lCnQy8w6W5peBtvk1proSVor2/dcVAWLHooRRj
         QQsiQZwzKjRH+uGPnEFPxmYEthm8rn1cRgEBFUkq4XlXCATLM5fWYaeSXXpxajzmvKsN
         0iS/RHnyV0TE0WGw+JcT9vPsTyyraBK8SXZdhcEkJJzLaLAlQBSEAOFXpA+tiR7u455i
         oNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702569510; x=1703174310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qOoPhCjb4CJRPnWbZPjhwalkYOW/D4DA0hOyNWvhhzU=;
        b=uCG/glz+y+jX8we53wjQLTzZfozN53jqmyvxUOlocKc3opnGy30X3Ecb+laC74Sooy
         HWFty5yXns3YHxtWQETxPDOac/S+Ug0XwG4WGnGiC5bx3zHhSR5PxAGSlTXkXZLs6Hp4
         RruJKah4j/hzthra5IfvVnxZC7gkt38BrrZbRH03Tctc42PveeKDo+fpbHLHfNIPvwyd
         G7wQM6rFovcN+uOt5TwEyBdwyQyNesVM4STDt2VYZ2PyUkksL4F0qojBa/GfbN4gT7Iq
         d+PzRXtsMF73ONcX0tSNzfIp+BlPiTOaHjCGW5BoN0/5MnXNkoGgBrM4e0XAgkvR/QcN
         AXYg==
X-Gm-Message-State: AOJu0YzB3dlm4QrkorCcEpGtQXF2N1+3/BwkfZUQI9jzJqWFRYJ14whJ
	50j5zCSMLrzrybDYtOQKUEQ=
X-Google-Smtp-Source: AGHT+IGVAkA6+fYfY4gA5VbmEkT1mQXaVGG3PDL5Oh0Wfm1IjHZAzGFZvYizpMxx27ei5lhgNIXoUA==
X-Received: by 2002:a17:902:f68d:b0:1d0:af28:254 with SMTP id l13-20020a170902f68d00b001d0af280254mr5487666plg.38.1702569509929;
        Thu, 14 Dec 2023 07:58:29 -0800 (PST)
Received: from MacBook-Pro-49.local ([2620:10d:c090:500::6:906c])
        by smtp.gmail.com with ESMTPSA id q17-20020a170902dad100b001d3517c5aeesm3342596plx.290.2023.12.14.07.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 07:58:29 -0800 (PST)
Date: Thu, 14 Dec 2023 07:58:27 -0800
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 1/2] bpf: support symbolic BPF FS delegation
 mount options
Message-ID: <moeyk2noput6zen2dan3s7xsudvxtjc6kf7anieyugwbj6z3uf@kcxw4a3ffvnj>
References: <20231213222327.934981-1-andrii@kernel.org>
 <20231213222327.934981-2-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213222327.934981-2-andrii@kernel.org>

On Wed, Dec 13, 2023 at 02:23:26PM -0800, Andrii Nakryiko wrote:
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

imo this is too verbose.
For cmds it doesn't look as bad. "BPF_" prefix is repetitive, but not overly so.
But for maps and progs it will be bad.
It will look like:
delegate_progs=BPF_PROG_TYPE_SOCKET_FILTER:BPF_PROG_TYPE_SOCKET_XDP:BPF_PROG_TYPE_SCHED_CLS
which is not readable.
delegate_progs=SOCKET_FILTER:XDP:SCHED_CLS
is much better.

And I would go further (like libbpf does) and lower case them for output
while allow both upper and lower for input:
delegate_progs=socket_filter:xdp:sched_cls.

Because of stripping the prefix for maps and progs I would strip the prefix for cmds too
for consistency.

pw-bot: cr

