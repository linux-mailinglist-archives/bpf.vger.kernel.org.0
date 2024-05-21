Return-Path: <bpf+bounces-30123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D5E8CB20E
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 18:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393701F22325
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 16:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41D21CD3B;
	Tue, 21 May 2024 16:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVTSqy5o"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22D64C66
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716308384; cv=none; b=RuAuofGMjYSzxGUxF7iZnQD0HsK1UWOh3PivWcciyQuZjmvPZI1r6bc6EwmHeTUKeVVBshUOzXwkB7jfPkbifRNAz9eeYoOyCpxAojwDjPblpVwpmHejdGyOdOjKU1Bvxcc3Qw52avUOg2wHln4INReglUeTKmyOz0s+YYH8rok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716308384; c=relaxed/simple;
	bh=wvroEoVEhaV92iXAqzB/u+ZllHGQlM9QZfVpy13fCQI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ij/N0ef79YxEppaRcKFljpQHtfm4J43mJdTjnmf+/2JA1Y2xdxA0aqRp4B7Aa5OljsZkBdtGkcHJvdcsxv82GTlSVR5dEARbWgzr7bRehaG72k+VRHFQbOAK9/naqPlJGo5Xe5CCY87pOezo6evECXkbnLOfjnkDHZujrsKK0R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVTSqy5o; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-656d8b346d2so1471110a12.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 09:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716308382; x=1716913182; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eNFK/UpQQJeUWPv9gZBtmOUb/BKOfMOKTFPirHiD6BE=;
        b=eVTSqy5oK1L1o2Ke0nx9+CWN5/LlzNh1n+dwojuHDk5qMBJh8MnXWUIP3hS0rqlDjP
         BzsS21Tx5ohwO/6pmCPzvZ4rMPd7i4IRZjnZxd8kT+pPUhor5PZGjtYqvzhkv0ys5Mfj
         D9EeGPHKc8Us6sg058ipFvgzHjZ4xVFHK54Wf1K1Qy0ajPyubdNUjqnuJVHs5mfGChcb
         Y5oqYwq48bKhSpa1IkSxLA27dLvVSIM3TRNVyf1J+3MYMghrvv91EbKh5oYlpnK+z4E1
         mnst7UvMn40+NeUlcZFHq1LbrAf2Eh9TvUDONek3ADw14/OMWB0BUQqZfwzGnYsa49/y
         JTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716308382; x=1716913182;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eNFK/UpQQJeUWPv9gZBtmOUb/BKOfMOKTFPirHiD6BE=;
        b=UtNEQDMdP43cnD185P6l3E3t8N8QuQSrkRCFv+9qyXHXhrjas1yekEwdqNMc802acO
         1dHNoSg9WhYnmJG6UZwK6Ds/IvtNxL2GDWVThXyv8aRPB+4Hqppb3t+0Axs53s3NR+Kd
         zrHFkTlGrgClVwesV6Y/l03koUgwOGVLF4HtkixhkzwbjcynJqufZCtd5WkasrA3gxrm
         g7CZ1QblwZa3MqBljtlbsw8D0rmMKyek6OWaXYHlty4vJ6batM8lpjnf2wBJnuxDO/ZV
         fmvS/ppUGc+swmRnRyxXV3M2ftcxwoIX3lQA0dppbgc8CubYIlYjyEOQQ1Yyf22cy6Pe
         0/eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCBkvGfZo5tMbHKJz9vKFjy5M9Wi8A60RF7nsqHeuye6kkguOjwrGR8YkI2srRZOJoTTb/xto/XFV0aYndC1mfbCI6
X-Gm-Message-State: AOJu0Yx5sRYWlkKqryCwqkeWhpOSUi1BlpyvWVHmUU5XxHwRUOdHs1wO
	2M7BxO/PuGQyQmm/PPS01rOkZcBQUEqXgeRylJ8AWKpqN0bz7IqQ
X-Google-Smtp-Source: AGHT+IGRwlaF6DjfYY4eMRziEx+cUyFUFumrzVMXR3qMubJ8Y0oeYE4WFtOMxBnoiTe43hcWUxyNew==
X-Received: by 2002:a17:90a:f495:b0:2b3:28be:ddfa with SMTP id 98e67ed59e1d1-2b6cceef302mr29410184a91.38.1716308382119;
        Tue, 21 May 2024 09:19:42 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bd7f6c90f0sm3841769a91.2.2024.05.21.09.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 09:19:41 -0700 (PDT)
Message-ID: <81bbbbad95244dd74801497414c2cdad88815f83.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 00/11] bpf: support resilient split BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org,  acme@redhat.com, quentin@isovalent.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com,  kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com,  bpf@vger.kernel.org,
 masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Date: Tue, 21 May 2024 09:19:40 -0700
In-Reply-To: <3ae296b2-402a-4e17-b874-e067c57fc091@oracle.com>
References: <20240517102246.4070184-1-alan.maguire@oracle.com>
	 <b647e0d1d225f9d21e78c6ffedb722507f42eff0.camel@gmail.com>
	 <3ae296b2-402a-4e17-b874-e067c57fc091@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-21 at 10:15 +0100, Alan Maguire wrote:

[...]

> This is a neat approach, and as you say it eliminates the need to modify
> bpftool to handle distilled base BTF and relocation.  The only wrinkle
> is resolve_btfids; we call resolve_btfids for modules with a "-B
> vmlinux" argument, so in that case we'd be calling btf_parse_elf() with
> both a split and base BTF. According to the approach outlined above,
> we'd relocate split BTF - originally relative to .BTF.base - to be
> relative to vmlinux BTF, but in the case of resolve_btfids we don't want
> that relocation. We want the BTF ids to reflect the distilled base BTF
> ids since they will be relocated later on module load along with the
> split BTF references themselves.

You are correct, I missed this detail, resolve_btfids needs distilled
base instead of vmlinux for out of tree modules.

> We can handle this by having a -R flag to skip relocation; it would
> simply ensure we first try calling btf__parse(), falling back to
> btf__parse_split(); we need the fallback logic as it is possible the
> pahole version didn't add .BTF.base sections. This logic would only be
> activated for out-of-tree module builds so seems acceptable to me. If
> that makes sense, with your permission I can rework the series to
> include your BTF parsing patch.

Makes sense to me, but I'm curious whether you and Andrii consider
this a good interface, compared to _opts version.

Thanks,
Eduard

