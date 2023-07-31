Return-Path: <bpf+bounces-6406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8D8768E9F
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 09:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3475728106A
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 07:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB216124;
	Mon, 31 Jul 2023 07:24:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470801FA4
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 07:24:53 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744042121
	for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 00:24:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-317798b359aso3692673f8f.1
        for <bpf@vger.kernel.org>; Mon, 31 Jul 2023 00:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690788236; x=1691393036;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oGkyugvrEM6xlunfW9YYWZ5ucwxLmuDUqkGX4b2iOh8=;
        b=qQK5xiVbHQ0s49w3n8GJnkrT+3BNDrv+1HVHaLxPSwxHtCZAEfQYw+OgMfdSGXiHcV
         3kGJ3LhFbKOVG7gmi4w3mNVasWYu9gtPFele8Y70ujr3lSpHxcaOqKbn0jGI7W6YHnTB
         xlf9xULjx5FNoZHA2ah3Kr4EGDFz60q7uVHSyDmHTZRm6xISfMN27p5ya+3y5YWVg8pH
         WpfYV/lDXiJauCX6QAQcpEqH8Qay/sBTox0T5zutMQuAjY62y87uqfPSxJFuA09poU8c
         nI15zNaJKxbtxPow9GtaYcvGeTZG51TqRyeq/eHvgMikcTClaBggGZlgN3NZR3WI7vwm
         yrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690788236; x=1691393036;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oGkyugvrEM6xlunfW9YYWZ5ucwxLmuDUqkGX4b2iOh8=;
        b=T9Hb4gaAg0VRVHmuIT+KZRV8jBNbjpEaDDnifOvlMGG3/Ic6p5lRJ0M+ZzSQNAuyLQ
         18eVi1JIbrv8AnscqHfT56Az2YlHmWM6Mxj/B5AFD5WmCHZXBMxRkB07EqZBMWX0QKfh
         iezbURlFvndN6cSHmUt4D5HS/4/HiQf+DkXXcq6YHluf18GA07BYlEo9992XD7s0ZfZs
         wuLuVT1m4CMRDCuqypEBa/wCLSn34xqHojPYFtbI2FAp7N5XlDJLXkI/fieiKNnJEKNW
         UAaeTN3/ccAdQ9V/JcyJAWaeWn+PlZJHB9Z6d7Fx5ulj7yjoQNjMJgImJAmwV01kxPq1
         owmA==
X-Gm-Message-State: ABy/qLZPPdMDJPegvkMDlEcuoXnMIGxPWxnpSxX2d6wiZPpJUKiMdRxO
	dpPhmW7l3ueuAxe6MjxpZYHc07kD5utK0wP+0cI=
X-Google-Smtp-Source: APBJJlGGefjSfRLzDqfy6n0xkLrVkZTQJkZ0wt1xsiiqKwJWdNvqxpkai+L6mhbxu9yl4OJwmAtKQw==
X-Received: by 2002:adf:d092:0:b0:314:3b02:a8a8 with SMTP id y18-20020adfd092000000b003143b02a8a8mr4035110wrh.55.1690788236048;
        Mon, 31 Jul 2023 00:23:56 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t18-20020adfdc12000000b003143c9beeaesm12127892wri.44.2023.07.31.00.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:23:55 -0700 (PDT)
Date: Mon, 31 Jul 2023 09:29:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: joannelkoong@gmail.com
Cc: bpf@vger.kernel.org
Subject: [bug report] bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr
Message-ID: <d1360219-85c3-4a03-9449-253ea905f9d1@moroto.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Joanne Koong,

The patch 66e3a13e7c2c: "bpf: Add bpf_dynptr_slice and
bpf_dynptr_slice_rdwr" from Mar 1, 2023 (linux-next), leads to the
following Smatch static checker warning:

	tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c:403 forward_with_gre()
	error: 'encap_gre' dereferencing possible ERR_PTR()

tools/testing/selftests/bpf/progs/test_cls_redirect_dynptr.c
    396 
    397         encap_gre = bpf_dynptr_slice_rdwr(dynptr, 0, encap_buffer, sizeof(encap_buffer));
    398         if (!encap_gre) {
    399                 metrics->errors_total_encap_buffer_too_small++;
    400                 return TC_ACT_SHOT;
    401         }
    402 
--> 403         encap_gre->ip.protocol = IPPROTO_GRE;
                ^^^^^^^^^^^

The bpf_dynptr_slice() function accidentally propagates error pointers
from bpf_xdp_pointer() so it would crash here.


    404         encap_gre->ip.daddr = next_hop->s_addr;
    405         encap_gre->ip.saddr = ENCAPSULATION_IP;
    406         encap_gre->ip.tot_len =
    407                 bpf_htons(bpf_ntohs(encap_gre->ip.tot_len) + delta);
    408         encap_gre->gre.flags = 0;
    409         encap_gre->gre.protocol = bpf_htons(proto);
    410         pkt_ipv4_checksum((void *)&encap_gre->ip);
    411 
    412         if (encap_gre == encap_buffer)
    413                 bpf_dynptr_write(dynptr, 0, encap_buffer, sizeof(encap_buffer), 0);
    414 
    415         return bpf_redirect(skb->ifindex, 0);
    416 }

regards,
dan carpenter

