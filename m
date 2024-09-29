Return-Path: <bpf+bounces-40511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACC598967F
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 19:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CFA4B233B7
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 17:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DCC26AE4;
	Sun, 29 Sep 2024 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCGhd/4M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2899117C8B;
	Sun, 29 Sep 2024 17:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727630285; cv=none; b=s3vBjwbA2ZhcHyQAtbp1NyKU3uNHvbMcXJAf6B5PWPY2fg9x7lk9N7HK3z3bR6oqdb/3uVe2poZ87E/vKxlAJ2q+xHd/i5okoXkgfMqrg+oK4HexVp5Pl0lzwfUXh4lOTXqUi2ThLWLmYpGOQ+8boN8AsyHskaBjB0o7cHa0vwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727630285; c=relaxed/simple;
	bh=c/YdWzpIialsFV7FvSxr5A0UHhYFpTHIWBAVW3DzCc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvnFnpTn8deUPRdvD9uaqjatZnDJ728RG+8QrVHtmQokhuDnVuHBF93SJfoOK6SH9btp3lX31G0Cf5HFryVADKb9+hdu2Ql03HUV4ATVr/Y6GXya/0i0f9yt5Cf02wcqGnvLvew55OJr5ep3YKjVu9j6w5wVmUh0OcdioZOsnow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCGhd/4M; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37ce14ab7eeso1001914f8f.2;
        Sun, 29 Sep 2024 10:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727630282; x=1728235082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfTeuL3HHTItNwGr4HYulrBYE5z7fHt1sd5tCotQhqc=;
        b=TCGhd/4MaaqpbBQA/S9TPg6ZuNo2fRB9R5i+1LwqYBiIFgcM24nGMEwOdbcscdx8LH
         QwEBPD10QDWX20O1quYGgPRDvL5o3gzwehqRH8AqNyGRa8WwjG98eRYF10bxaHazVkOz
         DJbrDhW2gDnpI9t+jG1HD4RGmWS8XQTZemP07zJ8/UgTB7q4W6ETFlHVSv7VQZvqHdVz
         32BNWlY/U7ljWMFP9/G8tMNYb+hSG0VIJwtiyPTgeBk/DQMa6HT5zdnkq3Ynwil4qLTT
         jVMRcWE55B+/qfn9n00mUBL3WDmpk+iDRdumcGf6D3QsEbbJxPJG6W/TKjxh9zYGZXt6
         Ygjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727630282; x=1728235082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfTeuL3HHTItNwGr4HYulrBYE5z7fHt1sd5tCotQhqc=;
        b=f8USqWoIIeCXh+BpBWmZk2PYmBIGG1XkMXWad2DKgMfgllnUQDNhz+md8oIr4whdVn
         A9POrJMFbd+2+bDoJi8fIK0PPLkJ8juwXg9JPHl8R4yMOp7I6GpN5YgyMXYJvOF8TTkQ
         c6gd2+iekWY8Xkzq7HHEQXw6JOxfshI9+dNs1SsPA5QcmSVn3Z0ur3rw+O77IzB9pgQ2
         TEH3w+Jv5HjUHagpdyluJdq1EpaCHUKhrMGPL0pHBxwgOGev+iOKstMY/7p4esuDdxT6
         1mKCJLUlCuSh+VSQKIAvYXRD9k7z3tG9nkvh8KhkTNT1TJ7br+BrTmKcRQuzCnC/4XKH
         Ao5g==
X-Forwarded-Encrypted: i=1; AJvYcCUcJ+0EepYUeGq+/l99xzVSXqMRgHBPVKx3NoMpxAVbQKA12BwolUjLa5QKXd2vAi05nmI=@vger.kernel.org, AJvYcCVUFjm5OrrlKpgkqmHRXeq7XnIrmXjt1pFYmt8e2/nbXQfyxkXNcn593Hu6w587yq4vhpwknD6CAWz7DeKf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8fPjoLmcvLw3XNLYyQA5bAWdCvIxuXusYTy3Y2KB/2ytZaHrg
	p/MPeFKJl1D2Ym8BjWP7sog+y9mJwDeOgCuQPuF9C0bYzExdbIeywHnnE7Vs8Xgr+ayqtlP+2Kq
	u5xisZ/FQIjHwaIL2YUe2+W36SCo=
X-Google-Smtp-Source: AGHT+IG/zYLzF+KXXpd/g6WsHXPOf2xcNdkQ6HZ7C4+17Ad3rR7IS/ZQIaLNs0UidxH8tbm6nf+Ciie8epBuWaVhmcg=
X-Received: by 2002:adf:f14b:0:b0:374:c160:269e with SMTP id
 ffacd0b85a97d-37cd5a8c95dmr8750666f8f.22.1727630282343; Sun, 29 Sep 2024
 10:18:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926115328.105634-1-puranjay@kernel.org> <20240926115328.105634-3-puranjay@kernel.org>
In-Reply-To: <20240926115328.105634-3-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 29 Sep 2024 10:17:51 -0700
Message-ID: <CAADnVQ+T-e30wQMfFGp+crgOs1TzYA=c3anRu7k424x8owAXYQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Augment send_signal test
 with remote signaling
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 4:54=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> Add testcases to test bpf_send_signal_remote(). In these new test cases,
> the main process triggers the BPF program and the forked process
> receives the signals. The target process's signal handler receives a
> cookie from the bpf program.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  .../selftests/bpf/prog_tests/send_signal.c    | 133 +++++++++++++-----
>  .../bpf/progs/test_send_signal_kern.c         |  35 ++++-
>  2 files changed, 130 insertions(+), 38 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/send_signal.c b/tools=
/testing/selftests/bpf/prog_tests/send_signal.c
> index 6cc69900b3106..beb771347a503 100644
> --- a/tools/testing/selftests/bpf/prog_tests/send_signal.c
> +++ b/tools/testing/selftests/bpf/prog_tests/send_signal.c
> @@ -8,17 +8,25 @@ static int sigusr1_received;
>
>  static void sigusr1_handler(int signum)
>  {
> -       sigusr1_received =3D 1;
> +       sigusr1_received =3D 8;
> +}
> +
> +static void sigusr1_siginfo_handler(int s, siginfo_t *i, void *v)
> +{
> +       sigusr1_received =3D i->si_value.sival_int;

If I'm reading this correctly:
typedef union sigval {
        int sival_int;
        void *sival_ptr;
} sigval_t;

the user space will receive 4 bytes of garbage if it reads sival_ptr instea=
d.

I think it's better to make sure bpf prog passes 8 bytes instead of 4.

