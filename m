Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3554C6E7A
	for <lists+bpf@lfdr.de>; Mon, 28 Feb 2022 14:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbiB1Nom (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Feb 2022 08:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbiB1Nom (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Feb 2022 08:44:42 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB20941988
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 05:44:02 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id i11so21460902lfu.3
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 05:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=nN0PVIst4nluPMs1rHztby7hTwBkYQGxOHSdFHHEa5I=;
        b=ivIiwoggsHhoqPaJoV+GqNT2QGrhX8b+A8bPB6h2OM1DiQ13rFEWhV8iR5LrKoGIc1
         5baplXD/TIyLSAGLgLqVRKOAwo7HfMLWhGRslCxE4FBBfyJ78H5EHiHw0Tu+C1oDc9Lx
         +rliyUFqG8jdgSNTFp5yGrTD1E3XMqI+Mh9DM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=nN0PVIst4nluPMs1rHztby7hTwBkYQGxOHSdFHHEa5I=;
        b=gREbfG2eNq5yBswMsw+V1MIegOs6o/raKD1N5kuh7GeyILXzoDoZ/Ag+MaPCzLlSTt
         E/5o1MTcLSdH0Kn7LYz1jq5wSsXX/YyHfT5L+Q1MOgIITqYhkro9xFYDIQZ/fBDJJnhh
         g7i0vNRrMxKShvIAWfOx9wzLRwhbxAshU0zGxo5mz2WiZI7bzkubqrKpm5R4hequsV4Y
         kyYmwRCHg8MxNW8K4oh1VIgWYZc2JrEleBYEdZwWjv62Q+tnw80bWbQzqT0UzWebem8y
         67bG1Zu8P/xUF6kYryXTJt9R7If05+deu/Qqi+m6xdvFFObELU3EFicHWSVfnRn5Plgn
         B05Q==
X-Gm-Message-State: AOAM533ASi97yzhz7f8LI0JHW00meoiNybxhrWb7BQRkfbMqewIGq/xs
        INWSwgatCMizVBnzNy61LUN97w==
X-Google-Smtp-Source: ABdhPJyh0x0id6i2++t3+jAlusZcs4ppqOG0Gb3a7/ARGufN/hFwpWS1N12NZbklearM1VkX+XkmWg==
X-Received: by 2002:a05:6512:3f0d:b0:443:5f35:6360 with SMTP id y13-20020a0565123f0d00b004435f356360mr12311512lfa.661.1646055841061;
        Mon, 28 Feb 2022 05:44:01 -0800 (PST)
Received: from cloudflare.com ([2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id l2-20020a2e99c2000000b002461413aa81sm1324781ljj.78.2022.02.28.05.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 05:44:00 -0800 (PST)
References: <20220222182559.2865596-1-iii@linux.ibm.com>
 <20220222182559.2865596-3-iii@linux.ibm.com>
 <20220227024457.rv5zei6qk4d6wy6d@ast-mbp.dhcp.thefacebook.com>
 <87y21whwwl.fsf@cloudflare.com>
 <87d79308a2ffce76a805cc1e5f60d28bebc74239.camel@linux.ibm.com>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH RFC bpf-next 2/3] bpf: Fix bpf_sk_lookup.remote_port on
 big-endian
Date:   Mon, 28 Feb 2022 14:26:23 +0100
In-reply-to: <87d79308a2ffce76a805cc1e5f60d28bebc74239.camel@linux.ibm.com>
Message-ID: <87tucjhzrz.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 28, 2022 at 11:19 AM +01, Ilya Leoshkevich wrote:
> In order to resolve this inconsistency I've implemented patch 1 of this
> series. With that, "sk->dst_port == bpf_htons(0xcafe)" starts to fail,
> and that's where one needs something like this patch.

Truth be told I can't reproduce the said failure.
I've extended the test with an additional check:

   306          bool ok = sk->dst_port == bpf_htons(0xcafe);
   307          if (!ok)
   308                  RET_LOG();
   309          if (!sk_dst_port__load_word(sk))
   310                  RET_LOG();

... but it translates to the same BPF assembly as
sk_dst_port__load_half. That is:

; bool ok = sk->dst_port == bpf_htons(0xcafe);
   9: (69) r1 = *(u16 *)(r6 +12)
  10: (bc) w1 = w1
; if (!ok)
  11: (16) if w1 == 0xcafe goto pc+2
  12: (b4) w1 = 308
  13: (05) goto pc+14

During the test I had patch 1 from this series applied on top of [1].
The latter series should not matter, though, I didn't touch the access
converter.

Mind sharing what does the `bpftool prog objdump` output look like for
the failing test on your side?

[1] https://lore.kernel.org/bpf/20220227202757.519015-1-jakub@cloudflare.com/

