Return-Path: <bpf+bounces-53798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78790A5BD29
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 11:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D881898F93
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 10:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6178231A42;
	Tue, 11 Mar 2025 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b348g7U5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5519E22FDE2;
	Tue, 11 Mar 2025 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687364; cv=none; b=NdZ4RDsEyEIQQFgOqGtutbi6vYQx5SVTJmx1vjqOzU7TB0AYHB8EDmliJqWJCwVZV3ekhGIr1v+0K5ieIqcshmR+iUpjlBgOj8wzeGlyznbuyShz/v8CNeOXYoDqPuJavd6J+IjY59jq+uE9twAHY2/Tk/+LSZg2rdyX12JmBy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687364; c=relaxed/simple;
	bh=vOs3SmbSNaZk++YPHRHHZqoV06mUCnf1W98C8Xpx8Uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tcHMfXE+JCdvqPoMNbMwGM1+FTypYA4sH7pCCY03F4LeMlfIDzrZQPw5X43u+NUrGcDGnCfHl35iAo4btetu89tsbfBqNMxcFtHIBe+3CRSxrBheDg9Y9mKs1ceIuZywbYvU0ipXar19wz0PQ95XiFz+7mUg/gaASyc1l9ze2AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b348g7U5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62838C4CEEB;
	Tue, 11 Mar 2025 10:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687363;
	bh=vOs3SmbSNaZk++YPHRHHZqoV06mUCnf1W98C8Xpx8Uw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b348g7U5zVZgw7oWmGbES0jpmNZPCbaQJwyx/YxbClfYnONUsBPNu9UMoEC2RkXOC
	 bnrCFmDSjWgDhglsdzZqTESX3E9pfIz0GAt+usMiTBpH2viSlbA6YOBnFDHOiKQVbu
	 QXfHHc0xHBfOkyMYO4O0bLwMIURix/fjxmGuWdqgMjzEAkXFdF4+0qFh7AjyyroNyB
	 Hq6lJ0gYidXOgUrsROKnGJPm6ZZrYha3oijJV/lidSBGCE9XbBQoi3u3bsXPbHpbpx
	 1lpqj2GLII6VUjjLvaJAOgMeObz9wAN9LTA28+NHeARXsMRqD9HJGU8GxjXdNn2Aao
	 3YSuNfryeUyXQ==
Message-ID: <6f250856-3e3c-4b4d-9537-d008dd4d1813@kernel.org>
Date: Tue, 11 Mar 2025 10:02:39 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bpf: bpftool: Setting error code in do_loader()
To: Sewon Nam <swnam0729@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20250311031238.14865-1-swnam0729@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20250311031238.14865-1-swnam0729@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2025-03-11 12:12 UTC+0900 ~ Sewon Nam <swnam0729@gmail.com>
> missing error code in do_loader()
> bpf_object__open_file() failed, but return 0
> This means the command's exit status code was successful, so make sure to return the correct error code.
> To maintain consistency with other locations where bpf_object__open_file() is called, it returns -1 instead.


Nit: Please wrap long lines in the commit description next time you send
a patch.


> 
> Link: https://lore.kernel.org/bpf/d3b5b4b4-19bb-4619-b4dd-86c958c4a367@stanley.mountain/t/#u


Reported-by: Dan Carpenter <dan.carpenter@linaro.org>


> Closes: https://github.com/libbpf/bpftool/issues/156
> Signed-off-by: Sewon Nam <swnam0729@gmail.com>

Tested-by: Quentin Monnet <qmo@kernel.org>
Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thank you!

