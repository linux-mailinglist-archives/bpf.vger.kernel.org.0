Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000575BDC52
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 07:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiITFYS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 01:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiITFYC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 01:24:02 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7A85A88F
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 22:23:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id cc5so2397169wrb.6
        for <bpf@vger.kernel.org>; Mon, 19 Sep 2022 22:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=98qbQv6w1d+q5r2VEqKFWdAB7F5cqKlEm1iqy8qrkhs=;
        b=QAbXeC52ehq2tMtbscVU2DmgGCB0nHm579m6AvT1/tDEHLSs3IEBrNreDSVtiARaSl
         Bvj3Vi+Jp6vG1qbV+412k5d5eLM0G75JlKGS5GhbmP88afjN2vkwfllgseqsd4w1FeqV
         S/X9hPadfip+2c+murYKwAr19YYGO7PMl/VgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=98qbQv6w1d+q5r2VEqKFWdAB7F5cqKlEm1iqy8qrkhs=;
        b=uv8yoPLn5H8orMMZueb1ad17DPqX743DICuAmwLGjdXVw64RgSZstJkgIKFGq85UXa
         ORVujY3RSulzU69JJ3lEA6CIXz4yYeenfJ+Wc92yhNSmotTmWwsxXNM1MpSn6+ylwk+I
         NW6spUI+9BZifDG2k8GURsJlHKqKlaiA8j7EarRKooYEd+t73T082MwMNapWFje2aNUa
         EnzsQ2bTZ6RpQI8ZmCCh8eXCNjjXB+qJ7B7CNE7lOt8Q15eyFqUGfBCN7HZsqXrgOLew
         yF5XQ0GCCJtBV4jLZ8KuzTW159xUko9vTnLDO+qFr+g5X7Pfvk2d8SF6JnGGgk7Kb2iU
         uG8w==
X-Gm-Message-State: ACrzQf1iIXTMxBB4haK4mYtzAYc3xnSrKVa+UCqo23P5tvskRNYLgEKi
        SCxEX9mVs7xB1+98q4GxHc0sxuu0BpyVRA==
X-Google-Smtp-Source: AMsMyM7Bjso/KWxgg4jZg8Y9PppoV5QfVV2p2qxCy6gtDQti2IJNt7o0UmvuLs3tPrCrz2pfx8bbzw==
X-Received: by 2002:adf:de0b:0:b0:22a:c7f7:8eb4 with SMTP id b11-20020adfde0b000000b0022ac7f78eb4mr12640386wrm.195.1663651378871;
        Mon, 19 Sep 2022 22:22:58 -0700 (PDT)
Received: from blondie ([77.137.65.34])
        by smtp.gmail.com with ESMTPSA id q6-20020adff946000000b00226dedf1ab7sm462395wrr.76.2022.09.19.22.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 22:22:58 -0700 (PDT)
Date:   Tue, 20 Sep 2022 08:22:54 +0300
From:   Shmulik Ladkani <shmulik@metanetworks.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: [PATCH v7 bpf-next 4/4] selftests/bpf: Add geneve with
 bpf_skb_set_tunnel_opt_dynptr test-case to test_progs
Message-ID: <20220920082254.4672d5e4@blondie>
In-Reply-To: <65c2f50f-d7ad-a979-a7ea-2b79b4886d15@fb.com>
References: <20220911122328.306188-1-shmulik.ladkani@gmail.com>
        <20220911122328.306188-5-shmulik.ladkani@gmail.com>
        <65c2f50f-d7ad-a979-a7ea-2b79b4886d15@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 19 Sep 2022 19:58:20 -0700 Yonghong Song <yhs@fb.com> wrote:

> > +	/* set empty geneve options (of runtime length) using a dynptr */
> > +	__builtin_memset(opts, 0x0, sizeof(*opts));
> > +	if (*local_ip % 2)
> > +		bpf_dynptr_from_mem(opts, GENEVE_OPTS_LEN1, 0, &dptr);
> > +	else
> > +		bpf_dynptr_from_mem(opts, GENEVE_OPTS_LEN0, 0, &dptr);
> > +	ret = bpf_skb_set_tunnel_opt_dynptr(skb, &dptr);  
> 
> I think the above example is not good. since it can write as
> 	if (*local_ip % 2)
> 		ret = bpf_skb_set_tunnel_opt(skb, opts, GENEVE_OPTS_LEN1);
> 	else
> 		ret = bpf_skb_set_tunnel_opt(skb, opts,	GENEVE_OPTS_LEN0);
> 
> In the commit message of Patch 2, we have
> 
> ===
> For example, we have an ebpf program that gets geneve options on
> incoming packets, stores them into a map (using a key representing
> the incoming flow), and later needs to assign *same* options to
> reply packets (belonging to same flow).
> ===
> 
> It would be great if you can create a test case for the above
> use case.

Yes, but please note dynptr trim/advance API is still WIP:

https://lore.kernel.org/bpf/CAJnrk1a53F=LLaU+gdmXGcZBBeUR-anALT3iO6pyHKiZpD0cNw@mail.gmail.com/

However, once we settled on the API for setting variable length tunnel
options from a *dynptr* (and not from raw buffer+len), we can just
exercise 'bpf_skb_set_tunnel_opt_dynptr' regardless the original
usecase (i.e. we can assume dynptrs can be properly mangled).

In any case, I can later amend the test once all dynptr convenience
helpers are accepted.

Best,
Shmulik
