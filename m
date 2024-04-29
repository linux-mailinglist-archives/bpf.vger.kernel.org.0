Return-Path: <bpf+bounces-28153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 486C68B6359
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 22:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080A6281618
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 20:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B24C1419B5;
	Mon, 29 Apr 2024 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="W+TFK+y6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF82F1411EB
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 20:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421719; cv=none; b=WasXaVZW378VAV+2+Qn1zhZ8/Gg3RUEP2gHsoStjwRifWLekLl/bkELZ7mhD2Palg9BMuHwVAeOT658t2q08lpFR8/2oaF6DwRcSHNef0hlMRdV6JElkYiz71nQFXXOb/9nOVZjGIQee+xAxUbud5YcPhcpPMMKOgU45iBNEs7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421719; c=relaxed/simple;
	bh=5lIm1eGtHM4PV56m4aPsCpHzpWdPQKBG54afaQAvc4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CACtAXWZMEhvTDEyUdrTmjOgoGWTyjQ3kXkVZB2wUYQq5feBSh8oAnrM/BgLomPhntmBgEvhcQkSuQIDTyc6OCd5YbgT655rlVH9W4hDasGtmeZhjH5oIv5NW9xpjydorJp/HLGrby3K7dYE9Qp2HDhO/daJrH0jcCImae1PGVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=W+TFK+y6; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e69888a36so5173149a12.3
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 13:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1714421714; x=1715026514; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5hNIl2k7bcjopXDurl21nUe10hqHAJ/W6XMO+7gYbZw=;
        b=W+TFK+y6jzm4Zy3kavYgQEYxs0c6e7ehSSSP1t+dRGz42hGGveiTJD0Y+x7Hjh58VN
         HrOEC517Xkq5q/bY65EPa+A1sdsfM7yB5YxPvEG388pBvmq23zMGNpZ4DA2KYIy/8ybx
         Twc7PnSoeWqJ5MTA2/7uMRyk4tQ0cJgIs3o09UWMHWwUHY0qpOlLA0FoTHYXhC4QjM8e
         PwWEWPEmd8zDtkfV+DHX3INFC98rFne2gRxJKDxQNu/cUy/CJILdl51Z1j245rB5q1Jn
         HJnukH9Iw+xafkhCmpM1k5UnirgFuzlMtrjro9PjgWJoYAP5BJTKWIS+FhKulz53WcEe
         gWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714421714; x=1715026514;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hNIl2k7bcjopXDurl21nUe10hqHAJ/W6XMO+7gYbZw=;
        b=Y/AXkPGMFDL34dzy5MnquRgrtIEmprqmAmIFjZdl1puQMsXWv0Ouo/1JjTd8n1nM6L
         gQoFukFxsZKzdatQAt+cGgTvXTtmhIpeO2b0qUE0yMn2445lGLH2RLeb7ZjDz6jjX7Ya
         gtihTsPKs5JrCPkj2DEFp5movfWufzi7gL6kKTHwVZJ1gDawQhDtwYxUvrMrtrWTXgvG
         emVR1ntS2oPZEj1QEIFk4Ved3DTyUxBozOPSfEwFmGJoXy5p9+kzFKJWjnyICYKRhjEx
         eHcFaRIXMyMOStEkwtu5B2La1gbf6xuHTF1Vm+vl5GYe1bqsNjxxIA7Yx8vsh5YTjf70
         9neA==
X-Forwarded-Encrypted: i=1; AJvYcCW9YYDc9rM6fdyHkaM85vzPGfVo52vT+VZ3F7Ke8nHOG24ivQTmdzUH1AJLvlL/Ehbqc2M6gQD77fpul/JNbhbo6cIB
X-Gm-Message-State: AOJu0YyANvCWCyiAqUi6Zqg8fCceuYBD1csy4e7wsZeb/Iw9nFEMMvhS
	9Gxp8SGycYzUArakzSOglOFCm1pHk+uLFCfSDhvScg2tvyhPDw6zChMh3N8+uIk=
X-Google-Smtp-Source: AGHT+IEYp6PrEor/rRFc0AvlZl9FY32fdI1sHcQqXd81K8C/WOL3RGcjPL+2CvSbMsQBan6olswboA==
X-Received: by 2002:a50:cd0e:0:b0:570:5b71:4859 with SMTP id z14-20020a50cd0e000000b005705b714859mr6505696edi.41.1714421713909;
        Mon, 29 Apr 2024 13:15:13 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:1ce])
        by smtp.gmail.com with ESMTPSA id en22-20020a056402529600b005721b7bfea2sm7844691edb.22.2024.04.29.13.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:15:13 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Geliang Tang <geliang@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,  Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai
 Lau <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@google.com>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Geliang Tang <tanggeliang@kylinos.cn>,
  bpf@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 1/2] selftests/bpf: Check recv lengths in
 test_sockmap
In-Reply-To: <0de8cc53c7b797fbb8d8a12748b30353ca99d98d.1713867615.git.tanggeliang@kylinos.cn>
	(Geliang Tang's message of "Tue, 23 Apr 2024 18:26:14 +0800")
References: <cover.1713867615.git.tanggeliang@kylinos.cn>
	<0de8cc53c7b797fbb8d8a12748b30353ca99d98d.1713867615.git.tanggeliang@kylinos.cn>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Mon, 29 Apr 2024 22:15:12 +0200
Message-ID: <87y18whqnj.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Apr 23, 2024 at 06:26 PM +08, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> The values of recv and recvp in msg_loop may be negative, so it's necessary
> to check if they are positive before using them.
>
> Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
> Fixes: 753fb2ee0934 ("bpf: sockmap, add msg_peek tests to test_sockmap")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/testing/selftests/bpf/test_sockmap.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
> index 43612de44fbf..24b55da9d4af 100644
> --- a/tools/testing/selftests/bpf/test_sockmap.c
> +++ b/tools/testing/selftests/bpf/test_sockmap.c
> @@ -680,7 +680,8 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
>  				}
>  			}
>  
> -			s->bytes_recvd += recv;
> +			if (recv > 0)
> +				s->bytes_recvd += recv;
>  
>  			if (opt->check_recved_len && s->bytes_recvd > total_bytes) {
>  				errno = EMSGSIZE;

I'm concerned why are we getting false-positives from select() here?
This is what leads to test failures once socket is non-blocking.

[pid   544] pselect6(29, [28], NULL, NULL, {tv_sec=3, tv_nsec=0}, NULL) = 1 (in [28], left {tv_sec=2, tv_nsec=999997014})
[pid   544] recvmsg(28,  <unfinished ...>
[pid   545] +++ exited with 0 +++
[pid   544] <... recvmsg resumed>{msg_namelen=0}, MSG_NOSIGNAL) = -1 EAGAIN (Resource temporarily unavailable)

Is there an explanation? Or are we ignoring an issue in sockmap code by
"skipping" over EAGAIN errors from recvmsg() in the test?

Didn't have time to dig deeper yet.

