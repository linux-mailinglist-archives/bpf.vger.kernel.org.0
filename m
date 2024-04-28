Return-Path: <bpf+bounces-28046-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB078B4D51
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 19:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6412CB20F0B
	for <lists+bpf@lfdr.de>; Sun, 28 Apr 2024 17:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4783073531;
	Sun, 28 Apr 2024 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RJEZ5l6I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3F671B39
	for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 17:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714326493; cv=none; b=kJ7NsVMl638nhE8LF3BUP3XoRkKAKgSlXXmcP+uOJqqSYYPF3vO2q5WX7Nm9vjvv/YzUyGPDGEbF+Vr3uV6KHWvT0Nbg0lqR3DDZc3LfbwZ6MOn/U+TwYvM5IIpC/W9GMhdzKh0Ay9UORe/9bF/GTGABfMj1DmLh4UXwQPN9RLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714326493; c=relaxed/simple;
	bh=TwzZGhMmqwie1Sq9Mcj8uaIHqYMRdObHGpDRI+SDh8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvZfHx//EW6XQyGjp40bJDd/KOWje1g1kVgj5l1tSeXUfdhpCtXcMq9OWVK/4wrmBkUJaAQzVnvUJgbdQzHQDzxcuwsVwE9JvU0j9oaJ/m6SxBFF9hbOU9XJYvwMMrrFe6YmucxilAX/GwMWA9smm3y2bpXFWZRadjwdBZ001M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RJEZ5l6I; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a58e2740cd7so223401466b.1
        for <bpf@vger.kernel.org>; Sun, 28 Apr 2024 10:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714326490; x=1714931290; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TwzZGhMmqwie1Sq9Mcj8uaIHqYMRdObHGpDRI+SDh8w=;
        b=RJEZ5l6IjvsZZ7UV/FrrWvy1cFNdmogm3gVzGdnd/jvlUOSjARYnP8jJ5E3hPD4tTV
         Oj5Txb5hAnuXas0LiIstXjvqpQ27JBloXwwu52Fb/BNYlAaquv5aEGUn4yZJmdMALjmj
         OeF1b8NmPpfXiP1IjfQKfBJt9Xh6+143VjH/lajCZROlaaYeDZDFBW8kcN3w1+Ei4d75
         d3Aom3MCyGPJl/LFP9/8qJXSGZ3KvLTZTpjABxqfoyHEyb6C9YX+O+F1pxzCe2htcEF0
         ++U/giykTgnIMqbydkgCLFbkzi8U+mlcPPxJyOFJ4ssr4lyPQqHMYLNAHQPJi7ZDBh/Y
         bIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714326490; x=1714931290;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TwzZGhMmqwie1Sq9Mcj8uaIHqYMRdObHGpDRI+SDh8w=;
        b=MlRG/tpERKh3v3aI6gNu9ZPZlrcA21xnrcVLGkj0IProDGacw96hNU19h7kBftcbii
         f6rIdKpAt2M+M1BThxvDTO2wXkEBydv/ujWPw+SfmdwtU4ZbCnrMo/yIIzkt1F1MgK9F
         UzPTO5oiWYc+A2ZebmURhhdt2SlLw2QR7/7ZoXS5A+G2+ALMrJ6tJrTC2g6CTylLssC2
         TJlFiT12JBKXUywqOrDbMEzaG8ulCxsHf9/J2NBNL+FJ/AAOi3GX+u/HylLkE9qLOqf9
         x8PDNw1DmhIbTyDehVnpfUkBiGQ3TZg9aTCcrkgtUm0YWyncf+aPD2OKbbSqBbT5oBN9
         Eerw==
X-Gm-Message-State: AOJu0Yyr+KqP4L9AGZXNqNsRiwMM6aWPkAQBuJU4FBguKOV/LX0ReAb1
	/qsWqmXuNq9RYk0w/ezSgZKUE28ZU6HW7IeU48puk+pcQw9TYk15+O7mOmgDsFyeWQB4SqWcplq
	EAmmPXgVnqOhzbxTWc1s3vFjtp+QexLIFBabe
X-Google-Smtp-Source: AGHT+IHsqCaumHcpSEMj0qUiqXUFC+VzGr5pfg/19ufHlGUD5YvQ8KDcYV9TqIKpS7vspCjKF0cGITTjN4seBVQbdaM=
X-Received: by 2002:a17:906:4f16:b0:a58:af40:d023 with SMTP id
 t22-20020a1709064f1600b00a58af40d023mr4128985eju.36.1714326490448; Sun, 28
 Apr 2024 10:48:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412165230.2009746-1-jrife@google.com> <20240412165230.2009746-5-jrife@google.com>
 <3df13496-a644-4a3a-9f9b-96ccc070f2a3@linux.dev> <CADKFtnQDJbSFRS4oyEsn3ZBDAN7T6EvxXUNdrz1kU3Bnhzfgug@mail.gmail.com>
 <f164369a-2b6b-45e0-8e3e-aa0035038cb6@linux.dev> <CADKFtnQHy0MFeDNg6x2gzUJpuyaF6ELLyMg3tTxze3XV28qo7w@mail.gmail.com>
 <8c9e51b2-5401-4d58-a319-ed620fadcc63@linux.dev>
In-Reply-To: <8c9e51b2-5401-4d58-a319-ed620fadcc63@linux.dev>
From: Jordan Rife <jrife@google.com>
Date: Sun, 28 Apr 2024 13:47:58 -0400
Message-ID: <CADKFtnQ7L_CSq+CzAOt3PM_Jz2mboGe+Si2TPByt=DuL5Nu=1g@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/6] selftests/bpf: Add IPv4 and IPv6 sockaddr
 test cases
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Artem Savkov <asavkov@redhat.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>, 
	David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> Also, all this setup (and test) has to be done in a new netns. Anything blocking
> the kfunc in patch 2 using the current task netns instead of the init_net?
> Add nodad to the "ip -6 addr add...". just in case it may add unnecessary delay.
> This interface/address ping should not be needed. Other tests under prog_tests/
> don't need this interface/address ping also.

I was able to make these changes.

> Does it need a veth pair? The %s2 interface is not used.
>
> Can it be done in lo alone?

I think it may be better to keep it as-is for now with the veth pair.
It turns out that these BPF programs (progs/bind6_prog.c,
progs/bind4_prog.c, and progs/connect4_prog.c) expect the veth pair
setup with these names (test_sock_addr1, test_sock_addr2). We may be
able to update the logic in these BPF programs to allow us to just use
lo, but I'm not sure if we'd be losing out on important test coverage.
Additionally, since we aren't fully retiring test_sock_addr.c yet we'd
also need to change test_sock_addr.sh if we changed
progs/bind6_prog.c, progs/bind4_prog.c, and progs/connect4_prog.c. If
there are no objections to leaving things as-is here, I will send out
v3 with the rest of the changes listed above.

-Jordan

