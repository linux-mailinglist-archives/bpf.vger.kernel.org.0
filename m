Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0833465168
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 16:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350796AbhLAPYr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 10:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234164AbhLAPYq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Dec 2021 10:24:46 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B28C061748
        for <bpf@vger.kernel.org>; Wed,  1 Dec 2021 07:21:25 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id c3so31317322iob.6
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 07:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MLUZwUEBzklOGib2Zk3PFAvxb+CbG+R1DuoQKaGE8gw=;
        b=ZuxaIRAQw9xvNctBz60Nfj9NhxbsQHjyNOETRPbMvYnh6f1pkkzEwYLKASKsQkDBsX
         cLxgvj4lcCVQwhetojQ9xZKtNbfvIHUUHXRXIUaDp7jCRfr9SAOQc+gyl9xFKXCnPeGQ
         H9NZep0ZvpgVihUy0KR8fIAAvJ1Mqn+ZN01E17kxyRlAXR/wrc5tVVh2RqcsrvC7lTt0
         TiyuS7VCsRmAr544lvRG/0BJNv1hD5xuPcyVZDknUo4F2sG8YNDlIhFfNWDQLJymasS6
         +009TxLuUtj/Vy51v2ws2aP4nFTf0va4FAhv8hFG4z4HZq3b5/zTF8SFjy9h4JUhyXM/
         l+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MLUZwUEBzklOGib2Zk3PFAvxb+CbG+R1DuoQKaGE8gw=;
        b=g1ASAYfhrmU1Aep+1+YbWmbUfwsYCqPosHlxsUqVDdlo3ZPwjyVOx76bsbV2q4ktMk
         NmhNwzAsW9+i5+fSQtqHz3n9+q/vZzIcZc/WhKDzXIScsF4oXoRTuwefNp3EkA6EXyHZ
         gvYkh6vjNQdcl6VnNamM3BEbvyWxeLendsf7ocRSKB5OLm3B5dSMqminJ5h/3nIvwv0o
         5DKr6zBrrmFATo1vLCZLEcGIIzVG0WxIYpX5O9LCyRwGRMPfLXdx3bDXZy0Czj+lj0PC
         FP6hNU22QN06wn7AL59cw4E6Ok92l42KNbZG1GwAUiaG8RS5lbjQBTpj4OLGc4bOtZUQ
         5O3w==
X-Gm-Message-State: AOAM5307UNvd/fDqjO+fA+HObt36dRkRnFlWb7yWEB5tmlZwXFcVi2On
        Yzz3Mgb/lIo0AgRq7NpISFpJ5w==
X-Google-Smtp-Source: ABdhPJxtrTLI1AMMf1O0aIqny9q8Vj3DCKNibLPnD2qvc7DdypU9Rl593ilbA+ms0w9jlf6eGN7WkA==
X-Received: by 2002:a05:6638:3711:: with SMTP id k17mr10967372jav.72.1638372085289;
        Wed, 01 Dec 2021 07:21:25 -0800 (PST)
Received: from [192.168.1.173] (bras-base-kntaon1617w-grc-33-142-112-185-132.dsl.bell.ca. [142.112.185.132])
        by smtp.googlemail.com with ESMTPSA id y15sm117996iow.44.2021.12.01.07.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 07:21:24 -0800 (PST)
Message-ID: <8f9faf42-8a78-f383-3b93-a17fab4ed79b@mojatatu.com>
Date:   Wed, 1 Dec 2021 10:21:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2 net-next 00/26] net: introduce and use generic XDP
 stats
Content-Language: en-US
To:     David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
        Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shay Agroskin <shayagr@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        Noam Dagan <ndagan@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Edward Cree <ecree.xilinx@gmail.com>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Yajun Deng <yajun.deng@linux.dev>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20211123163955.154512-1-alexandr.lobakin@intel.com>
 <20211130155612.594688-1-alexandr.lobakin@intel.com>
 <20211130081207.228f42ba@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20211130163454.595897-1-alexandr.lobakin@intel.com>
 <20211130090449.58a8327d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <18655462-c72e-1d26-5b59-d03eb993d832@gmail.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
In-Reply-To: <18655462-c72e-1d26-5b59-d03eb993d832@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2021-11-30 12:38, David Ahern wrote:
> Today, stats are sent as a struct so skipping stats whose value is 0 is
> not an option. When using individual attributes for the counters this
> becomes an option. Given there is no value in sending '0' why do it?
> 
> Is your pushback that there should be a uapi to opt-in to this behavior?

A filter in the netlink request should help pick what is user-preferred.
You can default to not sending zeros.

cheers,
jamal
