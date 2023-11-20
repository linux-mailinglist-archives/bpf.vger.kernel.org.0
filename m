Return-Path: <bpf+bounces-15387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61387F1BF5
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 19:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5F841C20441
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 18:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9612FE33;
	Mon, 20 Nov 2023 18:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TDr4TniW"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25418A4
	for <bpf@vger.kernel.org>; Mon, 20 Nov 2023 10:06:55 -0800 (PST)
Message-ID: <3b500f0d-bc14-41cd-9eb1-952ca383e461@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700503614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=poA1nugx66xNwNHx4ek8GBj4HYuH2tWf5FjmBjjv+YU=;
	b=TDr4TniWw24uugTKlvKXIMpT9fsaYQ+eFnV02FaDmUt425/DmxkSJUmpmkOi5f7QbihgRn
	8mGR90mdmkK9doYYRzrPt54qoaxCHUZJhw4A+35Q7D2WZiE5diihU/6mQlMu96DQtrQPXJ
	mlRaizzN6gXMN2cw7fbNFXgu1houEGw=
Date: Mon, 20 Nov 2023 10:06:46 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv3 bpf-next 4/6] selftests/bpf: Use bpf_link__destroy in
 fill_link_info tests
Content-Language: en-GB
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, bpf@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>
References: <20231120145639.3179656-1-jolsa@kernel.org>
 <20231120145639.3179656-5-jolsa@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231120145639.3179656-5-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/20/23 9:56 AM, Jiri Olsa wrote:
> The fill_link_info test keeps skeleton open and just creates
> various links. We are wrongly calling bpf_link__detach after
> each test to close them, we need to call bpf_link__destroy.
>
> Acked-by: Yafang Shao <laoar.shao@gmail.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


