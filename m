Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650255AE05A
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 08:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbiIFG5S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 02:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiIFG5R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 02:57:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4DB72B70
        for <bpf@vger.kernel.org>; Mon,  5 Sep 2022 23:57:16 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e20so13925940wri.13
        for <bpf@vger.kernel.org>; Mon, 05 Sep 2022 23:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=zFJWGExBh7/ejgjCjzUqnrQxgOzG1QD0QttqPTjMDxQ=;
        b=NZJ4oojOYQ/ZIa7B8gf8BbGTK55vYZuNrhTX2zcxHensQZ2mTDPG14XOg71Lxnb0Gx
         XPS7rERLRuh3ZbcG5jSmiFEObloOChr3Qcwd8AG8Ns5L/IfRQrdM4TSSdtfCVzuZmI21
         GZ0cQmEYTrQzthcSDtb41mmm3pdXlt+swjcDfLn3p1RArD5ubjkfDplrBLvZfOArlL1U
         FA9VTB+jQ7Je1IruzrpmWQJPkhv3mMVNJLAq5lSByNepxZBjo3mJY1HEs2xvfiJ766PF
         oUNcRGj7hFf2+k87SH3rW/48UpDYaWEdiDP3/fBaeVqxoz1CtPsPIdW/9OaulJRiTAWU
         5g7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=zFJWGExBh7/ejgjCjzUqnrQxgOzG1QD0QttqPTjMDxQ=;
        b=y1evQ9zR5hfu5cWKaVXyIKbHA5nHt8NLT8zFKd/OHhXpsUtvg4GK82X4vU086CE4Y9
         vE3jIfaJbOMyKWZA7JyHxO1wsp5IySb9vtWguemd5kY4+tl9GPNoTA2bWa0ZO4sL/VNA
         SLiU26Qo+VYmXKufLp3I4qJbQ+0GQpsDMHt5mjNJKFqhchA2JIIz/Szye+hG2EDWDQgy
         s2K8E8rJgnS980WhpyFfSTpUsyno2L7CVosJpQCdNjVb279TfV3F+SMP4vBYlYDytdOk
         43+S1Vrnb0yWcp2wtX1zKpXYMBDnin2/ELUcX4PmVkg7mdlT+SVi3Q/U6oOqShzqnIta
         4f0Q==
X-Gm-Message-State: ACgBeo3afKBhZ5s7huJarTX40tNMTCDypCWC7XURLJkJ22YYYVOhg7zP
        vpv92bA0DNjqYucYkeTuAZPuDg==
X-Google-Smtp-Source: AA6agR7ESdke6b+0DY38mxHAxbvmmu0p+zpwwQ0e6ficvAoaU6+ZeBW6No9OyjI24p5tD5JUyqwLDQ==
X-Received: by 2002:a5d:4805:0:b0:228:db70:6641 with SMTP id l5-20020a5d4805000000b00228db706641mr346081wrq.377.1662447434487;
        Mon, 05 Sep 2022 23:57:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:68b7:cde8:77c2:4bde? ([2a01:e0a:b41:c160:68b7:cde8:77c2:4bde])
        by smtp.gmail.com with ESMTPSA id e2-20020a5d5942000000b00226f39d1a3esm11261015wri.73.2022.09.05.23.57.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 23:57:13 -0700 (PDT)
Message-ID: <bf148d57-dab9-0e25-d406-332d1b28f045@6wind.com>
Date:   Tue, 6 Sep 2022 08:57:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH nf-next] netfilter: nf_tables: add ebpf expression
Content-Language: en-US
To:     Florian Westphal <fw@strlen.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <20220831101617.22329-1-fw@strlen.de> <87v8q84nlq.fsf@toke.dk>
 <20220831125608.GA8153@breakpoint.cc> <87o7w04jjb.fsf@toke.dk>
 <20220831135757.GC8153@breakpoint.cc> <87ilm84goh.fsf@toke.dk>
 <20220831152624.GA15107@breakpoint.cc>
 <CAADnVQJp5RJ0kZundd5ag-b3SDYir8cF4R_nVbN8Zj9Rcn0rww@mail.gmail.com>
 <20220831155341.GC15107@breakpoint.cc>
 <CAADnVQJGQmu02f5B=mc1xJvVWSmk_GNZj9WAUskekykmyo8FzA@mail.gmail.com>
 <20220831215737.GE15107@breakpoint.cc>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20220831215737.GE15107@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Le 31/08/2022 à 23:57, Florian Westphal a écrit :
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>>> This helps gradually moving towards move epbf for those that
>>> still heavily rely on the classic forwarding path.
>>
>> No one is using it.
>> If it was, we would have seen at least one bug report over
>> all these years. We've seen none.
> 
> Err, it IS used, else I would not have sent this patch.
> 
>> very reasonable early on and turned out to be useless with
>> zero users.
>> BPF_PROG_TYPE_SCHED_ACT and BPF_PROG_TYPE_LWT*
>> are in this category.
> 
> I doubt it had 0 users.  Those users probably moved to something
> better?
We are using BPF_PROG_TYPE_SCHED_ACT to perform custom encapsulations.
What could we used to replace that?
