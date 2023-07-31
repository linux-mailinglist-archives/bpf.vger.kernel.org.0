Return-Path: <bpf+bounces-6450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9D0769975
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 16:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E4882814C7
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 14:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B79418B0E;
	Mon, 31 Jul 2023 14:27:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F784429
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 14:26:59 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF58B119
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 07:26:57 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-314417861b9so3840101f8f.0
        for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 07:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690813616; x=1691418416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d0amng8ESj5Ivn3+1Qpwn6F8c5hSHQtHpqsKrSaqmyM=;
        b=uc+fd4z3doK5zO6DlkUKmP75VP+YhckG31qRdKmzMx3SfzHxgEvUG4TZJe3y+phASO
         Vt6Vj2SpM+mhoB8FlaaLfSg4GvJr5glzyru4hhZn2/OF34PIdvyQuuXIC2o82IDlbMkT
         lvFY0u9O1qGNbQKhcLXSslU6Vjv6a+4hxvgmthJJEMVtsaJzdLjgk1j/Kq9rQ4lHsJTR
         Ep8xhUPTxZj6UgC7aru352SW/OnJsGkG03+RxM49bagpvN9UyEQbzbEjYCKCq+GDPMFr
         ipmS+4dk5mg5xGqNuajn9l1LXxr1F4Lh8OtGHZ3MAO2L7rx6TLAp98U/lDNOZOVNjYLy
         fd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690813616; x=1691418416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0amng8ESj5Ivn3+1Qpwn6F8c5hSHQtHpqsKrSaqmyM=;
        b=bFnpsSxTGNRH++G7Sn81K+gMspewnTCEOgzaIQ8lwPkhxueut7pmXW5JX9VKpNoJH9
         qclxvPyuCtVyRJfa+WJPAvAawqa2ml3nLT8zob7Q17jceG6jnxT4cSvNF6iJrx6QlDLB
         uuPWHbW79V+ttkdaznjiwzNbpKrk98WhxcWppG2Ugz3N8pyhBBPtM9iw+Uvw+XseQ3L6
         jpnW5P21i7it0ZMUJCwHaCiHlJJjWz6n0UBjQ6jfr3MfUr2YSL2wUKgL80EaQ7U88Ote
         kb5yUPblR2ua0bmosX2HDuR76fDBz+UvCqPWT6aD83UAbyS4zTnSGbNJgf0E/evD4YUf
         zyew==
X-Gm-Message-State: ABy/qLZmgj4V1Ug31Hvrqj9ugMliO1Z5lew3lQ9d5ZF7Tj88B1yE7C03
	c2ZKbCsW4YBRDO8iUz21T2F8aw==
X-Google-Smtp-Source: APBJJlGzCyI+U5RVUU8FDM+eBfMc+3uCEUPv/aNqKzgnlSN7kdoPm8KbQdY/Zxi8dDL10HtPb67Ihw==
X-Received: by 2002:adf:f70c:0:b0:313:f61c:42b2 with SMTP id r12-20020adff70c000000b00313f61c42b2mr5302957wrp.69.1690813616290;
        Mon, 31 Jul 2023 07:26:56 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a8-20020adfed08000000b0031417b0d338sm13274552wro.87.2023.07.31.07.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 07:26:56 -0700 (PDT)
Date: Mon, 31 Jul 2023 17:26:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yan Zhai <yan@cloudflare.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com,
	Jordan Griege <jgriege@cloudflare.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Jakub Sitnicki <jakub@cloudflare.com>
Subject: Re: [PATCH v4 bpf 1/2] bpf: fix skb_do_redirect return values
Message-ID: <38c61917-98b5-4ca0-b04e-64f956ace6e4@kadam.mountain>
References: <cover.1690332693.git.yan@cloudflare.com>
 <e5d05e56bf41de82f10d33229b8a8f6b49290e98.1690332693.git.yan@cloudflare.com>
 <a76b300a-e472-4568-b734-37115927621d@moroto.mountain>
 <ZMEqYOOBc1ZNcEER@debian.debian>
 <bc3ec02d-4d4e-477a-b8a5-5245425326c6@kadam.mountain>
 <ZMFFbChK/66/8XZd@debian.debian>
 <8b681fe1-4cc6-4310-9f50-1cff868f8f7f@kadam.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b681fe1-4cc6-4310-9f50-1cff868f8f7f@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I'm not a networking person, but I was looking at some use after free
static checker warnings.

Apparently the rule with xmit functions is that if they return a value
> 15 then that means the skb was not freed.  Otherwise it's supposed to
be freed.  So like NETDEV_TX_BUSY is 0x10 so it's not freed.

This is checked with using the dev_xmit_complete() function.  So I feel
like it would make sense for LWTUNNEL_XMIT_CONTINUE to return higher
than 15.

Because that's the bug right?  The original code was assuming that
everything besides LWTUNNEL_XMIT_DONE was freed.

regards,
dan carpenter


