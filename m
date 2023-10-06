Return-Path: <bpf+bounces-11590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2287BC2BF
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 01:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2F8281D57
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 23:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EF345F6B;
	Fri,  6 Oct 2023 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="ePX/sYbp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCEA405CC;
	Fri,  6 Oct 2023 23:02:15 +0000 (UTC)
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4351F9C;
	Fri,  6 Oct 2023 16:02:12 -0700 (PDT)
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTP
	id orRIqdGkHqBU3otpjqVuis; Fri, 06 Oct 2023 23:02:11 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id otpiqd15fsqNFotpiqdcYf; Fri, 06 Oct 2023 23:02:10 +0000
X-Authority-Analysis: v=2.4 cv=aPzjFJxm c=1 sm=1 tr=0 ts=652091f2
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=Dx1Zrv+1i3YEdDUMOX3koA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=hWMQpYRtAAAA:8 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=NEAV23lmAAAA:8
 a=cm27Pg_UAAAA:8 a=GO2MODqShKhmYEK19rIA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=KCsI-UfzjElwHeZNREa_:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D1jWl+Tzg11Q4/gxmIXK9n2WMBr7aaQFJ8hHOf2UdsQ=; b=ePX/sYbpKTIU/yGeXz9L+5lgna
	Hr5tQZm1PJJuwoB480gET8ruoogLBVGfA6PEAsSTnl81iBF57gow0WycKxTc7MEliqABUbmKpBzrB
	PmVcQihYF9wJMLqh2wA/lEAlECvczrvlmxKNWsgYylZcR7RvBsoQsRREHuW1HL6d1KoKXzwnrSRgX
	hsfGq194ZqjEHxoF1jT+6f1gQoGIoG8Y8dC9nmLX68LfJ/oq1bpJNr0gZJQOR0OF5640Gf+RDIYld
	9nqlCB42qcwp4tXelWk75+PJ8DZ6u/s1ZpVSC6wtvKT68KhCYmi9kgRSD7dGGB6g2VziLJlTOOZUX
	iWJ2TQWg==;
Received: from 94-238-9-39.abo.bbox.fr ([94.238.9.39]:47408 helo=[192.168.1.98])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1qorm9-001Bge-1M;
	Fri, 06 Oct 2023 15:50:21 -0500
Message-ID: <6b203ddd-d8d9-46e3-acbd-89d658f80e3a@embeddedor.com>
Date: Fri, 6 Oct 2023 22:50:15 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf: Annotate struct bpf_stack_map with __counted_by
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Song Liu <song@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, bpf@vger.kernel.org,
 linux-hardening@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20231006201657.work.531-kees@kernel.org>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231006201657.work.531-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.238.9.39
X-Source-L: No
X-Exim-ID: 1qorm9-001Bge-1M
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 94-238-9-39.abo.bbox.fr ([192.168.1.98]) [94.238.9.39]:47408
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 0
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPbIlqTGL6AuBhAaU/RqerWqzU9CWVTp3Q4V017J421Xs7UiLFH7qNBwND26g4H0OrN2bExfYRtVpC/dWpNok8zBA2QN2U5+0oY2NPq4jcqmno0tTkVW
 I5hFBqdX3ODmtm52YikTT0qn1nCU6kLELF+gV/tifgMMIHvLglEfDLX22gIlyAlrMlpx84GFgOGD1ilh+G3d0G0aMRRHGjhyFGVmHAt3HwPI++3l7qSFsLZZ
 DGkjYkt7XLtjXoL4tS/9uv98izIAU6b7wHLqmUW2+ZbClN9TW1x8e4kt62HjQphE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/6/23 22:17, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct bpf_stack_map.
> 
> Cc: Song Liu <song@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: bpf@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
-- 
Gustavo

> ---
>   kernel/bpf/stackmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 458bb80b14d5..d6b277482085 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -28,7 +28,7 @@ struct bpf_stack_map {
>   	void *elems;
>   	struct pcpu_freelist freelist;
>   	u32 n_buckets;
> -	struct stack_map_bucket *buckets[];
> +	struct stack_map_bucket *buckets[] __counted_by(n_buckets);
>   };
>   
>   static inline bool stack_map_use_build_id(struct bpf_map *map)

