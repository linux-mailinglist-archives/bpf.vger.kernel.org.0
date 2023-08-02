Return-Path: <bpf+bounces-6694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB87F76CB90
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 13:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766D4281D3E
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 11:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965E86FC4;
	Wed,  2 Aug 2023 11:16:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635C263DC;
	Wed,  2 Aug 2023 11:16:22 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 044A52115;
	Wed,  2 Aug 2023 04:16:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9923833737eso961739966b.3;
        Wed, 02 Aug 2023 04:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690974978; x=1691579778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1LEDgkbQVwyMApHrCW4foHYLU4LMYaivEbuRAOYhwfE=;
        b=MnxbqOOvhJ95m47M/aqhVRseOYAdbuuWiqHBFWSg/c/NUYT0oIu/EjBhezQYr1JK0t
         oVZxGMtABYf0uPk8mVv3gq8f/TC5AHPAVtb6qUSFnQRBlt9u/goShwbo/z0LJrcrhrd3
         0nVzry552Ut4gpR6AMmp5e0fSjSScnhHPaYMzPbX4gdyCQc+YEbFp3+/0ia/7+78T/Lm
         ylL7v4VgMOUjDkRo3H8rNuJiDe8m6ch5sbP3GpWYJHlcqwhDO3Slw7/PeXw3ZeO37nN0
         j6nSey+dj02+tPYxQD+wh6TrknAV/YXfLhKjVFiLF8KPPrAMlbw2y3Avvu19QEJfVgto
         R8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690974978; x=1691579778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1LEDgkbQVwyMApHrCW4foHYLU4LMYaivEbuRAOYhwfE=;
        b=TxUPoG66os/Iv27aHF7ztxJdCa5HzsYPv63W0y2VMC+E7DTKf5S0rrDQa99t2yKtJp
         lRVppa915jjNuauX/t8I3G/04S0BP2v84LQN6G4pToKjF6H1XhAQihd/YveIREyulwj4
         nhxVkkgGaeRexnOvrf4NwLhw8E8UGUEmNJa0wZRw87KLGG8ZDHpcQMcs5qGHdk1X2hu0
         neElqVY31JnTJBRvM0KewiwY1imNJg71/X7IG0xD3fJuVAqtk4+waV6dVK67Yx7SewaS
         9A/dDGL03yzheAq0oGTErj5FtbQON+jRzQJ/Lc50eiRryCC1KnsON4U4MpHM0tlJUOFZ
         tGyQ==
X-Gm-Message-State: ABy/qLYlkL5ylsDYr8B686xzQuF9hIuqSwfkDNJ9l4XuQT+U6dtk6Fuz
	Xfsv68XFTa+rNKMrKtXK9WM=
X-Google-Smtp-Source: APBJJlGq9/b/LK7cDecBtJhJYmf3YB7Ady3vuK2p9XsCxws0cwpzEj53FJW780nNmw+8dGQ+4M+MwQ==
X-Received: by 2002:a17:906:10cd:b0:99b:4bab:2839 with SMTP id v13-20020a17090610cd00b0099b4bab2839mr5612720ejv.55.1690974978178;
        Wed, 02 Aug 2023 04:16:18 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:310::2eef? ([2620:10d:c092:600::2:dbd1])
        by smtp.gmail.com with ESMTPSA id lu44-20020a170906faec00b00992f309cfe8sm9020548ejb.178.2023.08.02.04.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 04:16:17 -0700 (PDT)
Message-ID: <260c7815-ca50-f6f5-9a37-7960a9a3b9eb@gmail.com>
Date: Wed, 2 Aug 2023 12:12:38 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce
 virtqueue_dma_dev()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org>
 <ZLjSsmTfcpaL6H/I@infradead.org>
 <20230720131928-mutt-send-email-mst@kernel.org>
 <ZL6qPvd6X1CgUD4S@infradead.org>
 <1690251228.3455179-1-xuanzhuo@linux.alibaba.com>
 <20230725033321-mutt-send-email-mst@kernel.org>
 <1690283243.4048996-1-xuanzhuo@linux.alibaba.com>
 <1690524153.3603117-1-xuanzhuo@linux.alibaba.com>
 <20230728080305.5fe3737c@kernel.org>
 <CACGkMEs5uc=ct8BsJzV2SEJzAGXqCP__yxo-MBa6d6JzDG4YOg@mail.gmail.com>
 <20230731084651.16ec0a96@kernel.org>
 <1690855424.7821567-1-xuanzhuo@linux.alibaba.com>
 <20230731193606.25233ed9@kernel.org>
 <1690858650.8698683-2-xuanzhuo@linux.alibaba.com>
 <20230801084510.1c2460b9@kernel.org>
 <1690940214.7564142-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <1690940214.7564142-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/2/23 02:36, Xuan Zhuo wrote:
> On Tue, 1 Aug 2023 08:45:10 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
>> On Tue, 1 Aug 2023 10:57:30 +0800 Xuan Zhuo wrote:
>>>> You have this working and benchmarked or this is just and idea?
>>>
>>> This is not just an idea. I said that has been used on large scale.
>>>
>>> This is the library for the APP to use the AF_XDP. We has open it.
>>> https://gitee.com/anolis/libxudp
>>>
>>> This is the Alibaba version of the nginx. That has been opened, that supported
>>> to work with the libray to use AF_XDP.
>>> http://tengine.taobao.org/
>>>
>>> I supported this on our kernel release Anolis/Alinux.
>>
>> Interesting!
>>
>>> The work was done about 2 years ago. You know, I pushed the first version to
>>> enable AF_XDP on virtio-net about two years ago. I never thought the job would
>>> be so difficult.
>>
>> Me neither, but it is what it is.
>>
>>> The nic (virtio-net) of AliYun can reach 24,000,000PPS.
>>> So I think there is no different with the real HW on the performance.
>>>
>>> With the AF_XDP, the UDP pps is seven times that of the kernel udp stack.
>>
>> UDP pps or QUIC pps? UDP with or without GSO?
> 
> UDP PPS without GSO.
> 
>>
>> Do you have measurements of how much it saves in real world workloads?
>> I'm asking mostly out of curiosity, not to question the use case.
> 
> YES，the result is affected by the request size, we can reach 10-40%.
> The smaller the request size, the lower the result.
> 
>>
>>>> What about io_uring zero copy w/ pre-registered buffers.
>>>> You'll get csum offload, GSO, all the normal perf features.
>>>
>>> We tried io-uring, but it was not suitable for our scenario.
>>>
>>> Yes, now the AF_XDP does not support the csum offload and GSO.
>>> This is indeed a small problem.
>>
>> Can you say more about io-uring suitability? It can do zero copy
>> and recently-ish Pavel optimized it quite a bit.
> 
> First, AF_XDP is also zero-copy. We also use XDP for a few things.
> 
> And this was all about two years ago, so we have to say something about io-uring
> two years ago.
> 
> As far as I know, io-uring still use kernel udp stack, AF_XDP can
> skip all kernel stack directly to driver.
> 
> So here, io-ring does not have too much advantage.

Unfortunately I'd agree. Most of it is in the net stack. It can be
optimised to a certain extent (IMHO far more modest than 7x) but would
need extensive reworking, and I don't think I saw any appetite for that

-- 
Pavel Begunkov

