Return-Path: <bpf+bounces-1927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A1B7240F2
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 13:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89BD21C202F0
	for <lists+bpf@lfdr.de>; Tue,  6 Jun 2023 11:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5078815AF9;
	Tue,  6 Jun 2023 11:32:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E815ADB
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 11:32:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF74E47
	for <bpf@vger.kernel.org>; Tue,  6 Jun 2023 04:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1686051175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hj/oCZqRIaRss8Q4LgDlhtbf+IZqBpz4PwoZPwys/yQ=;
	b=HirrFCdCmhAXa1gsa6oD0zMAPPrUJrFWabjttwvzz+zqHMqOTiYOMbMjs2kGvXZ0rvlmmo
	a502j7AQYXt3PSbbG11SSZJP0fNL4ry+hbB8qC9RS9N31oBJIN/9s5OxgWzULo2H1b28yl
	W63AVNuYxMyETN3bWY4lIN7bcqIXpJE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-hXqmP5tvNgGCljTu2Vpp7g-1; Tue, 06 Jun 2023 07:32:54 -0400
X-MC-Unique: hXqmP5tvNgGCljTu2Vpp7g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-97463348446so383756266b.2
        for <bpf@vger.kernel.org>; Tue, 06 Jun 2023 04:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686051173; x=1688643173;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hj/oCZqRIaRss8Q4LgDlhtbf+IZqBpz4PwoZPwys/yQ=;
        b=NNth7TcQeF9eUovh9L7gtPauzC57bRP7gooVke/GVnN6o64m2nqC5cUI3vdlNF70S0
         wmNqy9AKgX80vnuQ8hom/iGuDj4MpFSFRxHfjwe7NV4/JCnVsmQH4pz69OATRQ/8ku5X
         Xkw4L90gnkn9kaAu5oB+jXuK6Kb8KIZbnf0BK2ij9o+wCzbf44Ch6kW5A39b8JWd9c4b
         0r4jiKvPQwxz5ukuYSmU6Mo6D4obENCfR+XNWJbpjP8tsqUm+7G6Lcflosc+46da/rBz
         NPSGTnshGj1Y4tPwBXdJvT7sJzj8G/49d7YwdIi3QpsswIMSDF7cfLWrClb6e6JoJWqX
         m1ng==
X-Gm-Message-State: AC+VfDwJgh2LTubZCki9Xq7X+YCOztNFZ+Ae3iZ1A0xUw9faVoZlgvmh
	61Xud4AYPArC36Ge/A1SCYMfBvMLg5HjHc2nevum1vow8r1UMFTyXpKzocw6avKl91GrLDp7gZN
	Sp+tG1p+xp5sk
X-Received: by 2002:a17:907:a42c:b0:974:1c90:2205 with SMTP id sg44-20020a170907a42c00b009741c902205mr2200643ejc.13.1686051173364;
        Tue, 06 Jun 2023 04:32:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4RPPPPFthYe4DwksyqkYkoUYRCGX6sEiUsyi9TszOqGKteH/2fL/6aokjXcd3QP/WDawUH7g==
X-Received: by 2002:a17:907:a42c:b0:974:1c90:2205 with SMTP id sg44-20020a170907a42c00b009741c902205mr2200628ejc.13.1686051173071;
        Tue, 06 Jun 2023 04:32:53 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id b27-20020a1709062b5b00b0097381fe7aaasm5445787ejg.180.2023.06.06.04.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 04:32:52 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <fae329d4-2599-d677-2ace-81bc137a758f@redhat.com>
Date: Tue, 6 Jun 2023 13:32:51 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc: brouer@redhat.com, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH bpf-next V1] selftests/bpf: Fix check_mtu using wrong
 variable type
Content-Language: en-US
To: Daniel Borkmann <borkmann@iogearbox.net>,
 Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org
References: <168605104733.3636467.17945947801753092590.stgit@firesoul>
In-Reply-To: <168605104733.3636467.17945947801753092590.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 06/06/2023 13.30, Jesper Dangaard Brouer wrote:
> Dan Carpenter found via Smatch static checker, that unsigned
> 'mtu_lo' is never less than zero.
> 
> Variable mtu_lo should have been an 'int', because read_mtu_device_lo()
> uses minus as error indications.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/check_mtu.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Providing the fixes like that I forgot.

Fixes: b62eba563229 ("selftests/bpf: Tests using bpf_check_mtu BPF-helper")

> diff --git a/tools/testing/selftests/bpf/prog_tests/check_mtu.c b/tools/testing/selftests/bpf/prog_tests/check_mtu.c
> index 5338d2ea0460..2a9a30650350 100644
> --- a/tools/testing/selftests/bpf/prog_tests/check_mtu.c
> +++ b/tools/testing/selftests/bpf/prog_tests/check_mtu.c
> @@ -183,7 +183,7 @@ static void test_check_mtu_tc(__u32 mtu, __u32 ifindex)
>   
>   void serial_test_check_mtu(void)
>   {
> -	__u32 mtu_lo;
> +	int mtu_lo;
>   
>   	if (test__start_subtest("bpf_check_mtu XDP-attach"))
>   		test_check_mtu_xdp_attach();
> 
> 


