Return-Path: <bpf+bounces-5952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB07763770
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 15:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E7E1C210A9
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 13:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B75C2DB;
	Wed, 26 Jul 2023 13:22:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFA6C2CA
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 13:22:30 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B352270E
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 06:22:25 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b933bbd3eeso100483451fa.1
        for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 06:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690377744; x=1690982544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RNBj29jr4jl10Xi2/aZroQsmuwBmNBwOZzK39VygtuU=;
        b=ZR7ItMsoA1A/Nf0sOAsNBK3BvkceyjN/sL6fBQtaSZAld48YYK29eLHJpLbOmYcO4N
         dYwufolsoOqxG66gXyatccol9XCFhslUJtN1fSKS7Ig5Kau5SMVFE7RX4yg5Rr4WodvW
         KGP5UDr+Anz0VQpD54p7Qveowg/GfBiANDGM4tvbiskCVcrN2Ayh2uU5VmTDPv4ac5wh
         wcczHEKlYM7+fs6dv2GFmLWJlAaieMsDTw3DWr/Yz6IprmyjYryQs6+CCKCZy1hgZmch
         9OcYz90i81pg25VCT++Zf0XNmTEBd2fezyDACkORNjUdmjCl6szBneV8zsIq5EvQsgSr
         1QLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690377744; x=1690982544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNBj29jr4jl10Xi2/aZroQsmuwBmNBwOZzK39VygtuU=;
        b=FRlnusam68IzkIQFzGffjlNsiizD8DXiVmGMDseJffR2+wUvbSImIkptYftmnYGkM2
         XIbds9SJ56XF+Q/8t57F8KqJoGwqArYlAmlnDM1SPs8HfUhWWKQ8mNz1rCu2orr3VBt/
         9qKEHzCoAcbfbnYz2+DmgYUYq+ZWmCpGD4AnNPJr+5r2wYkRm4HZHBMKvj2EXziVwkpI
         AuPCIo/XoTfB8tuHl8n9twRUu2KaUekNdEwvyQhO8TE/h+KD5Z+GeI/cI/PUgmJJxoHm
         TMejAObRuy+DGe1gm8clTVZkcSneiBl3E1H/D4yoCMYUGtF5nAnAdAj3qk5Ffdr7IRvM
         LQPw==
X-Gm-Message-State: ABy/qLaCDjPQ8CMLvbZeT26OMTdn4K9BS/x/Ff6uJSYbEoV2o/pJWbEC
	MO0x1DEt1O0yNNaxv7n2vk1EVw==
X-Google-Smtp-Source: APBJJlFMUTV8xO+xbHIIv/bIIICqq09UIEpnnxDWYTvm3DUYUWAby+Rd3s59OPhDm1XNqeKodSv6yA==
X-Received: by 2002:a2e:9805:0:b0:2b6:fe55:7318 with SMTP id a5-20020a2e9805000000b002b6fe557318mr1472225ljj.12.1690377743727;
        Wed, 26 Jul 2023 06:22:23 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y7-20020a1c4b07000000b003fc0505be19sm1939327wma.37.2023.07.26.06.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 06:22:23 -0700 (PDT)
Date: Wed, 26 Jul 2023 16:22:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yan Zhai <yan@cloudflare.com>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Hao Luo <haoluo@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>, Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jordan Griege <jgriege@cloudflare.com>,
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Yonghong Song <yhs@fb.com>,
	bpf@vger.kernel.org, kernel-janitors@vger.kernel.org,
	kernel-team@cloudflare.com, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v4 bpf 2/2] bpf: selftests: add lwt redirect regression
 test cases
Message-ID: <b0a4c52b-427d-462f-93a9-d94a294cedcf@kadam.mountain>
References: <cover.1690332693.git.yan@cloudflare.com>
 <9c4896b109a39c3fa088844addaa1737a84bbbb5.1690332693.git.yan@cloudflare.com>
 <3ec61192-c65c-62cc-d073-d6111b08e690@web.de>
 <CAO3-PbraNcfQnqHUG_992vssuA795RxtexYsMdEo=k9zp-XHog@mail.gmail.com>
 <ZMD1sFTW8SFiex+x@debian.debian>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMD1sFTW8SFiex+x@debian.debian>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Was Markus unbanned from vger?  How are we recieving these emails?

regards,
dan carpenter


