Return-Path: <bpf+bounces-53726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D25CDA59644
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 14:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BDFC18883F3
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 13:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5F322A4FD;
	Mon, 10 Mar 2025 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8HvQ0cb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D9B229B23;
	Mon, 10 Mar 2025 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741613300; cv=none; b=SfUwQy+gWAEmkIsLaHAOGbg1VFfXqrPvSPlu9BBTV8uM9kuCTvMKPQCZJECcFRLgTQmMo63joN4Yzp4ttTB/GSh8TBxZ56gKDSa2ZgjhEeSTdC54fl+O7H2qAys4/IJwM49Ebd+veqxi6xN5ayl8qdQeC+Jp2ZoWPBXneR+sSjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741613300; c=relaxed/simple;
	bh=nFQwviuFLEUXVD+O9mQqYEB6Xvy0zQX1YL6lxlu9H3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DWOgZ8C6eRh6i3HsSUu+wnDE1VdPxMIkE4+hh7ocrNumvInk6et4qQJhg/fM/wiUU3Fko6+NzF1mwsWtdjiv8ho1kn7x58I8E+LkXPZk6RFAdtpueKGZmhgWOK1lWpVAduKx7oH3Vdk9j7RkwYn4AAaEs/xcWxuI057f0lw566Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8HvQ0cb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3054C4CEE5;
	Mon, 10 Mar 2025 13:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741613300;
	bh=nFQwviuFLEUXVD+O9mQqYEB6Xvy0zQX1YL6lxlu9H3o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K8HvQ0cb0DZX+8lfGqS9AkInhopSbA2mtcQD1LQmSsE0PDIWkzni571GZvs+4AAsP
	 Zqn+2awCsTjb+C5jR+pbbwu9bkCQniSLWOvOUN5SjIE1q2p8noJDYnjxBuY0FPyn1S
	 nQBVO60XbxEjQAbrRkdcktUM7JZwZuexS4wD3Uz320sJ44Ls7mG5bvKopLGrX6sn/E
	 WkN63/g6sXpdJ6ChNJo8tIsF6p4SlUc8qSnbQITkcybLm0Rw3wGWx5o1j3+cF1YrB0
	 PLL1WDOhVdx3i0SiyRjR1KNDPWnAeAo19H6c/R/OilV1MKlbLRL8fylM63bTznc4iq
	 fxfD+hdoXxrxw==
Message-ID: <40064e3d-e8c6-42ee-80e9-a87f4140ecc0@kernel.org>
Date: Mon, 10 Mar 2025 13:28:16 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: bpftool: Setting error code in do_loader()
To: nswon <swnam0729@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250310052555.53483-1-swnam0729@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250310052555.53483-1-swnam0729@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-03-10 14:25 UTC+0900 ~ nswon <swnam0729@gmail.com>
> missing error code in do_loader()
> bpf_object__open_file() failed, but return 0
> This means the command's exit status code was successful, so make sure to return the correct error code.
> 
> Link: https://lore.kernel.org/bpf/d3b5b4b4-19bb-4619-b4dd-86c958c4a367@stanley.mountain/t/#u
> Closes: https://github.com/libbpf/bpftool/issues/156
> Signed-off-by: nswon <swnam0729@gmail.com>


Thanks for this!

Others may correct me if I'm wrong, but I think you should sign off with
your full name here (although it doesn't strictly have to be a full
name, the patch submission docs mention in should be a "known identity"
so I'm not sure whether a GitHub handle, for example, is acceptable).


> ---
>  tools/bpf/bpftool/prog.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index e71be67f1d86..641802e308f4 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1928,6 +1928,7 @@ static int do_loader(int argc, char **argv)
>  
>  	obj = bpf_object__open_file(file, &open_opts);
>  	if (!obj) {
> +		err = libbpf_get_error(obj);


This is the correct way to retrieve the error code, but given that
bpftool does nothing with this error code, could we instead simply
return -1 to remain consistent with the other locations where we call
bpf_object__open_file() in the tool, please?

Thanks,
Quentin

