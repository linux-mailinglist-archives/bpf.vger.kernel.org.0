Return-Path: <bpf+bounces-41338-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A275995D9E
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 04:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD171C22487
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 02:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FEE6F073;
	Wed,  9 Oct 2024 02:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdeHLDT3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C8A15E8B;
	Wed,  9 Oct 2024 02:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728439750; cv=none; b=mDIbD7RhiA3gF7Oxk6Rig7Lvod+EqWV1FJLMxKaA/JN3amLEf22PdnR32RBSNBPS/F5rr2wEf1G//U5y2GZkS2VePOYlYE1vHHb38TD8rLWM9ABOp7ZqSZUhkhlKmoVnqOGJvYTwJ7Y8FSx2t327JkK5qtK5WE37fE7D+rxihbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728439750; c=relaxed/simple;
	bh=5e+WJJnYl0fu79JD31MoH9OkZmTCYJ73P/b5DnL24rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AdX0astLHUUrwwK8rrOZ/bYN70ifWl4B/OTqaI0PpKvdTyAfzlW5js1QmjORxJl2QjdUQPpr96D++A61+LJj2wAsqxoxGaolVx+vOY5mXWX5q43UQyHS76dubDvg4NKZ/fI1WHX6oqyEQxCMukOgUEP7o3CUxUY9Eby+Mliipz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdeHLDT3; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37cdac05af9so5832952f8f.0;
        Tue, 08 Oct 2024 19:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728439747; x=1729044547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5e+WJJnYl0fu79JD31MoH9OkZmTCYJ73P/b5DnL24rM=;
        b=KdeHLDT37HMeRNu8Cu/izpoHx/7XT0a3GmTFOsRB2fTrYTtvToZVMtaxrHMcOqYivq
         9D0nlCqxIfKnkpTyX9AIWyq6awth0DllH04zn9n5fnB6n8mn82lCpR6fpRVZpB23qFtg
         0OKCVLJ/S4T/JNu4Ud8hV6zkG8dohFWNO1zswuNZJF8mlDQXZD0KUvHvG2+pFTCvCoBR
         vucvBXvOUOMv2rrcy22ieZfb1BGve/EX3RtNiXcyN3YPvAh75x7v5XUW0oT6iID5/r2N
         i+lmiMs3LWFWJWGZ3WyFffe4/o57gpqpczpkw65AmeBs5gYYTZL2ffQy3/1+SaYWmUCM
         EyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728439747; x=1729044547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5e+WJJnYl0fu79JD31MoH9OkZmTCYJ73P/b5DnL24rM=;
        b=WP4sSbx+2U1R1nM2ZmM5zNbdm4a22R9s6zs9L58TbKMbrS3tSi9qx1BcSZ9t4NG8oI
         VVgbfPCz3HPIgUVNa91SD/A/Y9Utx1eF4USy5sqmvS/MlANT8utZCLrL/c1j5lc/x7AN
         gwlIEG+QzHxxo5ZItFqlOyGu2mVGVAtm7HK42E2VZURfrZtnA8SIK4beX8Q18XLmhBYC
         xrFBFUFNJdDyS3hQpOc+mWclnBXQhaaJZMuZNE01WC7o2OVPIn9DnQpWEwBZLh5v3Jgu
         GRlSP42LMaSm4GkGkSHJDJOQcS/rT9LYcgrCOYcP1ubQFG4LvTeB9Q9VOnEZ7zgkf2pv
         oqWg==
X-Forwarded-Encrypted: i=1; AJvYcCUZP9KEsqCKTSjkOiuiMgqnnmrqSqrqvQyx1xGpLcg4/6rRwDmfT964wVDmoadZVjMtbCMq0FhK@vger.kernel.org, AJvYcCV79W0C1P2UMrUlHpkObxP4F1zTMFQzSx6T5RztuK55H6AG0+7ltdZtMKrkXdhz71djKSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeA8sO/MDOudFIpgzcUSpOeZ+KFVp0gY+yaVexi2aJEg8XMXor
	NbE0nIv81aMTHOBaiz31l3Isuk/09yjNY7Bmm5vYAU5Rm+UbDo0hsZ95fTcUOuhPa6W6eaNZnnW
	VFkcz7ALpWWSunntij+Q0ft3GtNDPDA==
X-Google-Smtp-Source: AGHT+IFlCE2/ak/9bCoQtj8HQMX+xTerLYbQRp4KfMcRLweAp2acWb8FFS8EqfE7oETAUGyKiW2OFU+4JMDnESxr9QY=
X-Received: by 2002:adf:f850:0:b0:37c:c51b:8d9c with SMTP id
 ffacd0b85a97d-37d3aae2866mr616867f8f.38.1728439747219; Tue, 08 Oct 2024
 19:09:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
 <20241008-fix-kfunc-btf-caching-for-modules-v1-2-dfefd9aa4318@redhat.com>
In-Reply-To: <20241008-fix-kfunc-btf-caching-for-modules-v1-2-dfefd9aa4318@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 8 Oct 2024 19:08:56 -0700
Message-ID: <CAADnVQKM0Mw=VXp6mX2aZrHoUz1+EpVO5RDMq3FPm9scPkVZXw@mail.gmail.com>
Subject: Re: [PATCH bpf 2/4] selftests/bpf: Consolidate kernel modules into
 common directory
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Simon Sundberg <simon.sundberg@kau.se>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 3:35=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>
> The selftests build two kernel modules (bpf_testmod.ko and
> bpf_test_no_cfi.ko) which use copy-pasted Makefile targets. This is a
> bit messy, and doesn't scale so well when we add more modules, so let's
> consolidate these rules into a single rule generated for each module
> name, and move the module sources into a single directory.
>
> To avoid parallel builds of the different modules stepping on each
> other's toes during the 'modpost' phase of the Kbuild 'make modules', we
> create a single target for all the defined modules, which contains the
> recursive 'make' call into the modules directory. The Makefile in the
> subdirectory building the modules is modified to also touch a
> 'modules.built' file, which we can add as a dependency on the top-level
> selftests Makefile, thus ensuring that the modules are always rebuilt if
> any of the dependencies in the selftests change.

Nice cleanup, but looks unrelated to the fix and hence
not a bpf material.
Why combine them?

