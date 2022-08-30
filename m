Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE99F5A68E6
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 18:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiH3Q54 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 12:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiH3Q5y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 12:57:54 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF3891D08
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 09:57:53 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z41so7627383ede.0
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 09:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=bT65q1iQ2py+CqowRZWXOpFtPip1wjZtfTnnAdWaQuA=;
        b=KyteclhreRZoMBQIkCZ6mZXidH1FdB03VepUNhGBucVfbP9bDKlcuTjtTSJnPwa37j
         Z1N/4fSR8H6g+XIo28M5CBUN1F/rNAXK0neO9O+kfGlxIwAAR7WI5MVt6rCWZM+fWFpQ
         ARFpx0AN1xODXsjgMK7FBz81GCEem+wJgB4NU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=bT65q1iQ2py+CqowRZWXOpFtPip1wjZtfTnnAdWaQuA=;
        b=WVRJvv58Z1Vi/xmzBuGPB/tHm24mggXiKT/+PtLKztrtnM3HSy4VlTBCJhqKuJvw/4
         cUxan5rnbYnmMS2TLFNNyfWaHCHWxxoTbAe5peYSh8vnUgxc5lHhowsU4+iQCeTQT18s
         5ROtgRh67dub4HoxXjFmIzwL1GIHbECVcwcRPGisOMATOh7P2Vp4gcjQmnB6BJ7Z5waR
         k2Bla3HGI0+5ClY8tnXDSEUFsr/Z7cNaJmILFWZ1F7Yt564RAMOrT2CEW4nmOFos9gNM
         EdPJ56fzT5Gu7voFhWr1Yz1ziPIbeJ8jIlpiRz0/WH11PvFEgIHGj9kBDDD4sCtNERpW
         ueyQ==
X-Gm-Message-State: ACgBeo3vA7Fq0vkEYOizoBSRxVnDH1MBPSZdz3/OZhZrERt7s5HBCFJn
        jO/wpDGIL1A34ABD4mxDmY4ToQ==
X-Google-Smtp-Source: AA6agR75BQdZddBUP/2Kp03EjwNp2CN3+lxoFntbD+FULR885GgABIjHYPZpvNtyPs2kf2H8LDhiDg==
X-Received: by 2002:a05:6402:e96:b0:443:a086:e3e8 with SMTP id h22-20020a0564020e9600b00443a086e3e8mr21713863eda.330.1661878672293;
        Tue, 30 Aug 2022 09:57:52 -0700 (PDT)
Received: from blondie ([5.102.239.127])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906304d00b0073c8d4c9f38sm6161818ejd.177.2022.08.30.09.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 09:57:51 -0700 (PDT)
Date:   Tue, 30 Aug 2022 19:57:46 +0300
From:   Shmulik Ladkani <shmulik@metanetworks.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/4] bpf: Add 'bpf_dynptr_get_data' helper
Message-ID: <20220830195746.59b2ff6a@blondie>
In-Reply-To: <63079ffa3f2d_12460b208d0@john.notmuch>
References: <20220824044117.137658-1-shmulik.ladkani@gmail.com>
        <20220824044117.137658-2-shmulik.ladkani@gmail.com>
        <63079ffa3f2d_12460b208d0@john.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 25 Aug 2022 09:14:50 -0700
John Fastabend <john.fastabend@gmail.com> wrote:

> As a bit of an addmitedly nitpick I just wonder if having the avail_bytes
> passed through like this is much use anymore? For example,
> 
> +BPF_CALL_3(bpf_skb_set_tunnel_opt_dynptr, struct sk_buff *, skb,
> +	   struct bpf_dynptr_kern *, ptr, u32, len)
> +{
> +	const u8 *from;
> +	u32 avail;
> +
> -       if (!ptr->data)
> -		return -EFAULT;
> -       avail = bpf_dynptr_get_size(ptr)
> +	from = bpf_dynptr_get_data(ptr, &avail);
> +	if (unlikely(len > avail))
> +		return -EINVAL;
> +	return __bpf_skb_set_tunopt(skb, from, len);
> +}
> +
> 
> seems just about as compact to me and then drop the null check from the
> helper so we have a bpf_dynptr_get_data(*ptr) that just does the
> data+offset arithmatic. Then it could also be used in a few other
> spots where that calculation seems common.
> 
> I find it easier to read at least and think the helper would get
> more use, also land it in one of the .h files. And avoids bouncing
> avail around.
> 
> Bit of a gripe but what do you think?

Sure, I don't mind. 

My rationale extracting 'avail' was due to the fact the combo of 
"if !ptr->data + bpf_dynptr_get_size + bpf_dynptr_get_data" will be
repeated in future locations that need to access the stored data.
Therefore encapsulating this looked beneficial.

BTW, note we'll need to make bpf_dynptr_get_size public (currently it's
static).

Let me know your preference, I'm fine either way.
