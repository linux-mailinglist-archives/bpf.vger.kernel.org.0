Return-Path: <bpf+bounces-7979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB23E77F888
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 16:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2B67281FBC
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 14:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5882114F62;
	Thu, 17 Aug 2023 14:17:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD1E14AB2
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 14:17:34 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FE12D5F
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 07:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=XA/svONOMk4cxK5MKyct+i2UC6bHa5wC2sWP6s3jEMc=; b=beGhl9xIwIHUlEsd3sBl1r129Q
	1YVLiXZDLNb39EPYjpHjezLIcbsVsNM5TaN0dAPh3QJXLHwC/1Jj43AlafXyAqgaLC4X2ENQ763YF
	f3EeXKHs4xnibukLPDeY4k+CANNagrTzvJXotvGVZpMCuaqAlGwhqDGWFvGqN/BDUDixCcoKhOFYD
	Jr7dUoLHPUNGD6kmzojKsVTirawss1GgV6E/E4rlQc8sqvo772ZE6paRwbD6eAQT8hOlw4GxXJW1Y
	Dp4Yeecj8rU/srpNZXnAvjNbeC1Ix6b5un78jjqfgdrnfZM8NxAQRHl6hmpayPxzAxXiI+hmuYFx0
	gEFscP0g==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qWdoY-000Hxh-Oi; Thu, 17 Aug 2023 16:17:30 +0200
Received: from [85.1.206.226] (helo=pc-102.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qWdoY-000454-2a; Thu, 17 Aug 2023 16:17:30 +0200
Subject: Re: [PATCH bpf] libbpf: soften BTF map error
To: Martin Kelly <martin.kelly@crowdstrike.com>, bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>
References: <20230816173030.148536-1-martin.kelly@crowdstrike.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5806e499-069f-18f4-2af0-5d9bd8bfa05e@iogearbox.net>
Date: Thu, 17 Aug 2023 16:17:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230816173030.148536-1-martin.kelly@crowdstrike.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27003/Thu Aug 17 09:42:42 2023)
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/16/23 7:30 PM, Martin Kelly wrote:
> For map-in-map types, the first time the map is loaded, we get a scary
> error looking like this:
> 
> libbpf: bpf_create_map_xattr(map_name):ERROR: strerror_r(-524)=22(-524). Retrying without BTF.
> 
> On the second try without BTF, everything works fine. However, as this
> is logged at error level, it looks needlessly scary to users. Soften
> this to be at debug level; if the second attempt still fails, we'll
> still get an error as expected.
> 
> Signed-off-by: Martin Kelly <martin.kelly@crowdstrike.com>

nit: $subj should be for bpf-next instead of bpf

> ---
>   tools/lib/bpf/libbpf.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b14a4376a86e..0ca0c8d01707 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -5123,7 +5123,7 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
>   
>   		err = -errno;
>   		cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
> -		pr_warn("Error in bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
> +		pr_debug("bpf_create_map_xattr(%s):%s(%d). Retrying without BTF.\n",
>   			map->name, cp, err);

There are also several other places with pr_warns about BTF when loading an obj. Did
you audit them as well under !BTF kernel? nit: Why changing the fmt string itself,
looked ok as-is, no?

There is also libbpf_needs_btf(obj), perhaps this could be left as pr_warn similar
as in bpf_object__init_btf() - or would this still trigger in your case?

>   		create_attr.btf_fd = 0;
>   		create_attr.btf_key_type_id = 0;
> 

Thanks,
Daniel

