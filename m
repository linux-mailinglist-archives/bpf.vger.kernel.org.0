Return-Path: <bpf+bounces-43889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FE39BB714
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 15:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5639283E63
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 14:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6600F1369B6;
	Mon,  4 Nov 2024 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJq8w4w+"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728F879FD
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729152; cv=none; b=s7D3xalW7bVKghyg/Gy1VJybPUhNyXcumwvw+zLUBOqW30nCh1xoeWUfQCkYHM1SuuCPyc4BcF9VhUWGxSkeXLEt99NCECneCRYPp+I7zqTSnxs2Z+hWfX/nL5NqHoKiDZY+GvzCux9+lY1HkOC0Q49cLDSn68PTFG4lY9WocrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729152; c=relaxed/simple;
	bh=81C3/l31aOF+X3wTj2KS3ryL3Kk4KGUfYpJISg+WXFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UnDCe4RMqS4RDUeViPjyT89+w+ODp0cE/Gbl08zsMQ7EorJkcLNw9BSfdFZM55me9n8/IZXnU0HsD4wKcFW6GKRnDXkhrcbnKok49a28taAMgqm3VttAPJKoAZOLmEJL1jo9QTMuDKfNC8g+RWzdpNGmKMXXeaAfB+blPq5zROU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJq8w4w+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730729149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gb1UMU1XuqOWDOTO5MhkKHQFWdwLrxCKkHpbwSRHyvM=;
	b=YJq8w4w+VQWox7Dw5fXMUBVTV7PX2JBAj1fL0uVzXElgiGUVWVw/3xssZ/oKu7IgChobo1
	VGNmMjxEceFNYBsxSYzNCTIfXm0gqdTvQZkcqW2NLEX594MDhL8mV1q9BMjfHWimvVc4Tg
	1YzsO3ulVr5H1o5A+LyJFaL0GxAWGHE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-tauRU6SnMrGmPLnRhmlG1A-1; Mon, 04 Nov 2024 09:05:47 -0500
X-MC-Unique: tauRU6SnMrGmPLnRhmlG1A-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a9a2593e9e9so285281866b.0
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 06:05:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730729146; x=1731333946;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gb1UMU1XuqOWDOTO5MhkKHQFWdwLrxCKkHpbwSRHyvM=;
        b=CBLoiiYuaM8arhTWlgH0dmvtIgdgPfbns7xyp1ylKKQ8/EPHftrJdLJZgYFchQg/Pa
         85uVULTsiv+ng5kvdjsUbSuO1rJk/qc8bXsSyioyRZU7saPxkHHCsfE3fn9zGd35EARr
         FjKJ6htkKC3xJvRtU9QNwCsgSSdLAbzoEoQDhWAOg1Ba6/7aH/JVzaZaZ8+sEpm4xJ5y
         8H0zPwutfe/+97Y0ThQR4ovDzqdObI98y2b3vUOlu7V8pjtOwPzMHVfutyZtiuRUZgBy
         6Jg/b3DqnSDAUDGiaUgiCGIN60rOJ4D8sWY1yntkflaTdVzRCHofnS726KidD40Nut3h
         kAkw==
X-Forwarded-Encrypted: i=1; AJvYcCXvGtwRNIKR1e3TEqRB7ZRsi+iWOBAOCk5N5wwSpr+Qd+hREGFdOjfZQkHTFBJaSiozKQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YybFw4wie3wSuD5Voxnxp2l9c0h3AVxLVxOMPEQcsX+5gBK3ULw
	4Yy7ZJ2j7VF7ijBGLr8inpxEe2s1KPN69mrQDDHHuAa5whi4bPoZQ/uQobd8SfA+v8ZboscvlkQ
	C7lmnl+sekUSLQtWTdzbpp/MGVuXbNnssemfWWOnj7Wg4V0KAgQ==
X-Received: by 2002:a17:907:ea8:b0:a99:44d1:5bba with SMTP id a640c23a62f3a-a9e6587e272mr1158687766b.45.1730729145880;
        Mon, 04 Nov 2024 06:05:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwG3aC/c4cclAeImIU1LjygXWnInwgPHOsuGZwo0d4K0zU188xmFb+7HuOopN0xWIMoXcstw==
X-Received: by 2002:a17:907:ea8:b0:a99:44d1:5bba with SMTP id a640c23a62f3a-a9e6587e272mr1158683466b.45.1730729145452;
        Mon, 04 Nov 2024 06:05:45 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56641249sm556140266b.156.2024.11.04.06.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 06:05:45 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id ED301164C03D; Mon, 04 Nov 2024 15:05:43 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Viktor Malik <vmalik@redhat.com>,
 Quentin Monnet <qmo@kernel.org>
Subject: Re: [PATCH bpf-next v3 2/3] bpftool: Prevent setting duplicate
 _GNU_SOURCE in Makefile
In-Reply-To: <acec3108b62d4df1436cda777e58e93e033ac7a7.1730449390.git.vmalik@redhat.com>
References: <cover.1730449390.git.vmalik@redhat.com>
 <acec3108b62d4df1436cda777e58e93e033ac7a7.1730449390.git.vmalik@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 04 Nov 2024 15:05:43 +0100
Message-ID: <874j4n9jrc.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Viktor Malik <vmalik@redhat.com> writes:

> When building selftests with CFLAGS set via env variable, the value of
> CFLAGS is propagated into bpftool Makefile (called from selftests
> Makefile). This makes the compilation fail as _GNU_SOURCE is defined two
> times - once from selftests Makefile (by including lib.mk) and once from
> bpftool Makefile (by calling `llvm-config --cflags`):
>
>     $ CFLAGS=3D"" make -C tools/testing/selftests/bpf
>     [...]
>     CC      /bpf-next/tools/testing/selftests/bpf/tools/build/bpftool/btf=
.o
>     <command-line>: error: "_GNU_SOURCE" redefined [-Werror]
>     <command-line>: note: this is the location of the previous definition
>     cc1: all warnings being treated as errors
>     [...]
>
> Filter out -D_GNU_SOURCE from the result of `llvm-config --cflags` in
> bpftool Makefile to prevent this error.
>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> Acked-by: Quentin Monnet <qmo@kernel.org>
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


