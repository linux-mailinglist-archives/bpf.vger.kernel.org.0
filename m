Return-Path: <bpf+bounces-7525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821097787FD
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 09:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3791E281FFB
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 07:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D091FDB;
	Fri, 11 Aug 2023 07:19:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42A51C3D
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 07:19:22 +0000 (UTC)
Received: from out-120.mta1.migadu.com (out-120.mta1.migadu.com [IPv6:2001:41d0:203:375::78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DD92D43
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 00:19:20 -0700 (PDT)
Message-ID: <25d08207-43e6-36a8-5e0f-47a913d4cda5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691738358; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hd2S8ZGX6o389ipkrUYWXiz5xXIto0fBL2Sfn+aGdGs=;
	b=RGMX0qCXMTnlRRuTZoV+lWay/zCpo+6UYDEtG0W0I2BCVe8VhQ4j5Je5uPi8dbng01w3QE
	h2jzHjU6ZmqTTDqzEBvEZjf8RD7fYCYQOOz2/U/Zfs+FXFZ+JUI1wscYpg6xKETVUJ8baE
	LsG/hbMEYmMHz0bX4ASxPSKEFpHHS4w=
Date: Fri, 11 Aug 2023 00:19:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next 1/3] bpf: Explicitly emit BTF for struct
 bpf_iter_num, not btf_iter_num
Content-Language: en-US
To: Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>
References: <20230810183513.684836-1-davemarchevsky@fb.com>
 <20230810183513.684836-2-davemarchevsky@fb.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230810183513.684836-2-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/10/23 11:35 AM, Dave Marchevsky wrote:
> Commit 6018e1f407cc ("bpf: implement numbers iterator") added the
> BTF_TYPE_EMIT line that this patch is modifying. The struct btf_iter_num
> doesn't exist, so only a forward declaration is emitted in BTF:
> 
>    FWD 'btf_iter_num' fwd_kind=struct
> 
> Since that commit was probably hoping to ensure that struct bpf_iter_num
> is emitted in vmlinux BTF, this patch changes it to the correct type.
> 
> This isn't marked "Fixes" because the extraneous btf_iter_num FWD wasn't
> causing any issues that I noticed, aside from mild confusion when I
> looked through the code.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>   kernel/bpf/bpf_iter.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index 96856f130cbf..20ef64445754 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -793,7 +793,7 @@ __bpf_kfunc int bpf_iter_num_new(struct bpf_iter_num *it, int start, int end)
>   	BUILD_BUG_ON(sizeof(struct bpf_iter_num_kern) != sizeof(struct bpf_iter_num));
>   	BUILD_BUG_ON(__alignof__(struct bpf_iter_num_kern) != __alignof__(struct bpf_iter_num));
>   
> -	BTF_TYPE_EMIT(struct btf_iter_num);
> +	BTF_TYPE_EMIT(struct bpf_iter_num);

I think this can be removed instead.

In kernel/bpf/bpf_iter.c, we have
__bpf_kfunc int bpf_iter_num_new(struct bpf_iter_num *it, int start, int 
end)
__bpf_kfunc int *bpf_iter_num_next(struct bpf_iter_num* it)
__bpf_kfunc void bpf_iter_num_destroy(struct bpf_iter_num *it)

This will ensure that bpf_iter_num btf type will be generated by
the compiler.

>   
>   	/* start == end is legit, it's an empty range and we'll just get NULL
>   	 * on first (and any subsequent) bpf_iter_num_next() call

