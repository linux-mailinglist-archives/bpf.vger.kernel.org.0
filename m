Return-Path: <bpf+bounces-26887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C828A62FF
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 07:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8AC4B233C3
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 05:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1849A3A29C;
	Tue, 16 Apr 2024 05:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csqFvmk8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E19B3C08D;
	Tue, 16 Apr 2024 05:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713245254; cv=none; b=Ko7k9hPXp2X6pognjgizI9UYkL/dtEhNENMwyjncic+aLOv3UWLCeUs9jTnCZpKzNNsx/KM0uCqKruY9Fhg34+UQkiiAxIJjNXsAUGvW5NYVafWFQOVEsL3/nZCdFEGMT1XQhfo6w8aNh753x9qUzUpgN84WSK9iFlVD6giPT18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713245254; c=relaxed/simple;
	bh=THv3/79A2H9nNVIkJBfgTVoe6vvwnYyh4E5rCbVYmHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5X/k+MsPHiUnCl3gmzjsNU+fv1sE1ku+5wAZv1TPpUdP1R7vB51kpNYLGM+TKGFQASxTr5N+HsvNDB71qJYjymtBCzncaFH5wLoGteYorGoeaUFscm4s4IdJb+jf6OOXEGInuALx08a2z7g6zKII7yoq7NKMhoGoiOERUvPX+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=csqFvmk8; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso19698239f.0;
        Mon, 15 Apr 2024 22:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713245252; x=1713850052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Bj7b/FqbINJ9h3hT325VjbRsdDhuvdI+3SsuJJX6oM=;
        b=csqFvmk8QrbwJUESSsX2r+z9SRVpDcp86fjCenbeb91gj5XWDrXCuFI0SmVCYXPBqq
         dbCXDOJTIXWJq5clxv3pN5h1OGH/SJBfmNzB34mJdK7fKRt9noFYA7DIT23YJe4nKS6I
         I4zWkuP+tS9BljAKYIUA7F/uMPeaIPrE/FjUrGJOhKyV4m2Wui3XkH/oK1G/t/XhvZY9
         nFsW0voypOhd1gV1Nz+MgDRMKmqftY4073a7jUjHeytYGIjDRch1zieWyddcc+E1IPPX
         +SeB+zasko9mP8SNxlhZvKQljCyui7Me9ljKMpPGNPl8gttTltimMbSzkAn34Tk87SSR
         ACUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713245252; x=1713850052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Bj7b/FqbINJ9h3hT325VjbRsdDhuvdI+3SsuJJX6oM=;
        b=E8W0wJ+SLJfu760WXaJWsiNua8WP9x0sM1/1wB0gz9Z71ElRKE+uoRMkkyEMI0Efnf
         0OFFjIDWG8oqJeKAR/jjes6grX+cmtqsLwAldqYO2Zo0XgtD8aoRQVzFCwWOdrC1+AVa
         Z8RaPiI/HTeRBQhWHiFIpAwzO7EwsW6VZMXi/btAfBvBWWIyDT+tpQ89uukulUkS2x2I
         WoL4p107uQnqIbzm0iMGq+yHFzweiTzlHNKNLXBarxB8wVxNGa6iMngAoA80EpeywQjk
         NSw3O7As3WJQQwBWEIGmZaKEMqHAeKjYbfrLCfWlbBWoqiXerH9sR9Rf2cMLKyk7uoHf
         7yxw==
X-Forwarded-Encrypted: i=1; AJvYcCVr5Z8zAKfiZcS1cyA2U4/9Qk0yTWCMeq4EFjfGN2HkrmVBbV/JoIr0oWJ5T3/EQP3enYjyBYEbo+L22dX+x7SNSCpy
X-Gm-Message-State: AOJu0YxBRR65i9uLdR7t8tvrLOX53j3JoJb9DHXrjkDVS7rVJaBPWc4U
	7vyLLDWXjHbzYOeTasxIgU8w18ViqBXpu82h3+iKKeuZJd+CF8dvnsXqVnDihpG8j49ILDNB4Go
	nWDE0biBqOudf9p8fKzibghWoJeM=
X-Google-Smtp-Source: AGHT+IH10paInJPH+L7hyxwPhtlIilGIHl/CNqZEtYVliHjg71HXlWLA1KzKZJoYGWEtMJYJSVNqESRbGasr4hcugnU=
X-Received: by 2002:a92:c14d:0:b0:36a:3ee8:b9f0 with SMTP id
 b13-20020a92c14d000000b0036a3ee8b9f0mr9788652ilh.0.1713245252357; Mon, 15 Apr
 2024 22:27:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240414045124.3098560-1-dmitrii.bundin.a@gmail.com> <Zh0ZhEU1xhndl2k8@krava>
In-Reply-To: <Zh0ZhEU1xhndl2k8@krava>
From: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Date: Tue, 16 Apr 2024 08:27:21 +0300
Message-ID: <CANXV_Xwmf-VH5EfNdv=wcv8J=2W5L5RtOs8n-Uh5jm5a1yiMKw@mail.gmail.com>
Subject: Re: [PATCH] bpf: btf: include linux/types.h for u32
To: Jiri Olsa <olsajiri@gmail.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, haoluo@google.com, 
	sdf@google.com, kpsingh@kernel.org, john.fastabend@gmail.com, 
	yonghong.song@linux.dev, song@kernel.org, eddyz87@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org, martin.lau@linux.dev, 
	khazhy@chromium.org, vmalik@redhat.com, ndesaulniers@google.com, 
	ncopa@alpinelinux.org, dxu@dxuuu.xyz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 3:11=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
> lgtm, did it actualy cause problem anywhere?
>
> there's also tools/include/linux/btf_ids.h

It caused the problems exactly in the file
tools/include/linux/btf_ids.h and was reported in
https://bugzilla.kernel.org/show_bug.cgi?id=3D218647
The patch including linux/types.h in tools/include/linux/btf_ids.h is
already there https://lore.kernel.org/all/20240328110103.28734-1-ncopa@alpi=
nelinux.org/
I also faced the same compile-error of the form

    error: unknown type name 'u32'
                              u32 cnt;
                              ^~~
when compiling the bpf tool with glibc 2.28.

I think it might be reasonable to add the inclusion in
include/linux/btf_ids.h as well to prevent build problems like this.

