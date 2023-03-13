Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244136B7A49
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 15:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjCMO1P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 10:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCMO1O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 10:27:14 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7191FFF21;
        Mon, 13 Mar 2023 07:27:13 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id ADD6C378;
        Mon, 13 Mar 2023 14:27:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net ADD6C378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1678717632; bh=we1dOyh2dtdOcF4wGKKVNAnTN7oZ4JTOZZ2/z75YBYY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gBEYFFGXY6FN/xfn5GN6z1RIvDKDZLE2Jy03LTN5SDP74r8RmlO1nZ5kDagcHEpgk
         /SS8JYmVjaX7bcVgA7AKtcFDk6osdrrHEy97vnWOTYcmoXTDtaOVXTQcjdwrwjcOEM
         FAonGDMWicA64t3bGXbxpAC4R5/aWL8FgFqv+KRG+dEb38oiSHtbJzjCTQwf/VH+RJ
         FclxWKR56bmLxRS14Ie0rWLKsE8sx7PQmstlOWXg0qv3HW/dHZABlM4cM20kXBrfF6
         zbG2p/Qc7ouAOFinatBTKNrBXrJdX/sEV0vWUiZAkkiSP/ScRkc1LxcnGKPn8yNxeL
         6tLOVCeuKZkYA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     David Vernet <void@manifault.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux BPF <bpf@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [PATCH bpf-next] bpf, doc: use internal linking for link to
 netdev FAQ
In-Reply-To: <20230313135638.GD2392@maniforge>
References: <20230313025119.17430-1-bagasdotme@gmail.com>
 <20230313030938.GA152792@maniforge> <ZA6knaEQcddfTCyS@debian.me>
 <fefa25fe-8148-cbd7-a91e-e4713eb6b0ef@gmail.com>
 <4653cfd1-7209-6e49-4f01-fcc3f82f16ce@gmail.com>
 <20230313123602.GA2392@maniforge> <87wn3kvkkq.fsf@meer.lwn.net>
 <20230313135638.GD2392@maniforge>
Date:   Mon, 13 Mar 2023 08:27:11 -0600
Message-ID: <87sfe8vi9s.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

David Vernet <void@manifault.com> writes:

>> In this specific case, though, there is a better solution.  Text like:
>> 
>>   see the netdev FAQ (Documentation/process/maintainer-netdev.rst)
>> 
>> will add links in the built docs, and also tells readers of the
>> plain-text files where they should be looking.  Without adding warnings.
>
> Nice, seems like the best of both worlds. A syntax clarification
> question: are you saying that this would work?
>
>> see the `netdev-FAQ`_.
>>
>>   <snip>
>>
>> .. _netdev-FAQ: Documentation/process/maintainer-netdev.rst
>
> Or is it required to have the full path inline in the text, as in your
> example:
>
>>   see the netdev FAQ (Documentation/process/maintainer-netdev.rst)
>
> The benefit of the former is of course that you only have to specify the
> link in one place.

Yeah, but the latter is what we actually have.

Thanks,

jon
