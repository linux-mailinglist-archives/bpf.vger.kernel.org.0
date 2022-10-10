Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF0C5F9BA6
	for <lists+bpf@lfdr.de>; Mon, 10 Oct 2022 11:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiJJJKf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 10 Oct 2022 05:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiJJJKe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Oct 2022 05:10:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3F2F10
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 02:10:32 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-139-HFZjivJtMTyYiofjBLboqw-1; Mon, 10 Oct 2022 10:10:29 +0100
X-MC-Unique: HFZjivJtMTyYiofjBLboqw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Mon, 10 Oct
 2022 10:10:26 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Mon, 10 Oct 2022 10:10:26 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Rui Li' <me@lirui.org>, Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Martin KaFai Lau" <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] bpf: Replace strlcpy with strscpy in preload module
Thread-Topic: [PATCH] bpf: Replace strlcpy with strscpy in preload module
Thread-Index: AQHY2+D0KU3oaE9S1EmQcSEIwnHGPq4HV1Bw
Date:   Mon, 10 Oct 2022 09:10:26 +0000
Message-ID: <7d98ed76798d4c52afcd462d694ebb6b@AcuMS.aculab.com>
References: <166532064978.9.18239510123131509626.67790627@lirui.org>
In-Reply-To: <166532064978.9.18239510123131509626.67790627@lirui.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Rui Li
> Sent: 09 October 2022 14:03
> 
> Use strscpy instead of strlcpy as the former one checks the size
> of source. Especially for this case, source strings are less than
> dst size.

Not relevant.
The only problem with strlcpy() is the return value when the
the copy has to be truncated.
As well as wasting computrons it can fault if the source string
isn't actually terminated (which might be true for arbitrary pointers).
In this case the source strings are well formed and short.

While strscpy() might be a preferred function the reason above
is bogus.

	David

> 
> Signed-off-by: Rui Li <me@lirui.org>
> ---
>  kernel/bpf/preload/bpf_preload_kern.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/bpf_preload_kern.c
> index 5106b5372f0c..af8dd3a7c928 100644
> --- a/kernel/bpf/preload/bpf_preload_kern.c
> +++ b/kernel/bpf/preload/bpf_preload_kern.c
> @@ -19,9 +19,9 @@ static void free_links_and_skel(void)
> 
>  static int preload(struct bpf_preload_info *obj)
>  {
> -	strlcpy(obj[0].link_name, "maps.debug", sizeof(obj[0].link_name));
> +	strscpy(obj[0].link_name, "maps.debug", sizeof(obj[0].link_name));
>  	obj[0].link = maps_link;
> -	strlcpy(obj[1].link_name, "progs.debug", sizeof(obj[1].link_name));
> +	strscpy(obj[1].link_name, "progs.debug", sizeof(obj[1].link_name));
>  	obj[1].link = progs_link;
>  	return 0;
>  }
> --
> 2.30.2
> 

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

