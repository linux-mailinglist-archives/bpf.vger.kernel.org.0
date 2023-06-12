Return-Path: <bpf+bounces-2399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9958772C8F6
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 16:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52516280ED7
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 14:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01871C747;
	Mon, 12 Jun 2023 14:52:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E551B8E6
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 14:52:27 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8423C5
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 07:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=zJGdh7s8QPxbXDFdLsx+AwcKzVJBkQAdavSHwkxo7IQ=; b=l2p7Bc0BIEOJpnDsmzBeNsZRls
	2hglNGa4eALKdMzdt5zHWTlTgWR3ARn2prW7/KOV+WiUnMFK/RQ3PNfpwOlVrsUVMuVBC1mGNDKve
	3ytGGTwu0rvGcguwPRY3OMH/IXHmVFTCv9dF4NtCqsj7MgNHXsbjkqFIA/TEItqUlOcOqpcSJvvxH
	8kagnp6oCde9BGKXzhk1tTS02CJEjeiOy1Os2xZgBgHFkBZjm71DZOr6FlN1cpve60VSq3bpFvE2I
	miJYS8tpfSU6pL5EBoJaV71mqK9INkSbrTYo1+qmlnkWPtY1sFJsA2qvId3naZ1wB6dVdsFI8TkKr
	1PvUcY1Q==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1q8itw-0009Hm-1m; Mon, 12 Jun 2023 16:52:12 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1q8itv-000URX-P6; Mon, 12 Jun 2023 16:52:11 +0200
Subject: Re: [PATCH bpf] bpf: Fix a bpf_jit_dump issue for x86_64 with sysctl
 bpf_jit_enable.
To: Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20230609005439.3173569-1-yhs@fb.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f0b228fd-2333-112d-4637-99e50a9a527f@iogearbox.net>
Date: Mon, 12 Jun 2023 16:52:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230609005439.3173569-1-yhs@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26937/Mon Jun 12 09:24:05 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/9/23 2:54 AM, Yonghong Song wrote:
> The sysctl net/core/bpf_jit_enable does not work now due to Commit
> 1022a5498f6f ("bpf, x86_64: Use bpf_jit_binary_pack_alloc").
> The commit saved the jitted insns into 'rw_image' instead of 'image'
> which caused bpf_jit_dump not dumping proper content.
> 
> With 'echo 2 > /proc/sys/net/core/bpf_jit_enable', run
> './test_progs -t fentry_test'. Without this patch, one of jitted
> image for one particular prog is:
>    flen=17 proglen=92 pass=4 image=0000000014c64883 from=test_progs pid=1807
>    00000000: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>    00000010: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>    00000020: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>    00000030: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>    00000040: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc
>    00000050: cc cc cc cc cc cc cc cc cc cc cc cc
> 
> With this patch, the jitte image for the same prog is:
>    flen=17 proglen=92 pass=4 image=00000000b90254b7 from=test_progs pid=1809
>    00000000: f3 0f 1e fa 0f 1f 44 00 00 66 90 55 48 89 e5 f3
>    00000010: 0f 1e fa 31 f6 48 8b 57 00 48 83 fa 07 75 2b 48
>    00000020: 8b 57 10 83 fa 09 75 22 48 8b 57 08 48 81 e2 ff
>    00000030: 00 00 00 48 83 fa 08 75 11 48 8b 7f 18 be 01 00
>    00000040: 00 00 48 83 ff 0a 74 02 31 f6 48 bf 18 d0 14 00
>    00000050: 00 c9 ff ff 48 89 77 00 31 c0 c9 c3
> 
> Fixes: 1022a5498f6f ("bpf, x86_64: Use bpf_jit_binary_pack_alloc")
> Signed-off-by: Yonghong Song <yhs@fb.com>

LGTM, applied, thanks!

