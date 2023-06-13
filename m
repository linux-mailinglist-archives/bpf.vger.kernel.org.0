Return-Path: <bpf+bounces-2472-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C14FD72D763
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 04:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81365281143
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 02:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A2717F6;
	Tue, 13 Jun 2023 02:36:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3624E7F
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 02:36:28 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5F510E2
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 19:36:24 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b3afd2f9bdso16433045ad.0
        for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 19:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686623783; x=1689215783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XY9UC3Bp/xIq1VGbFv2A/NuLEcX+9wS3+nQX7iCrIxk=;
        b=bfC7X5CyfyoCy5eZFxT7ip7PnaMo8b4OsPpEzN22EKL6lY20LJDlJ+QU87fdr9WUjq
         qmIJlCHYQMIk1sAFR3UV8GOa6+/VdyT9WrMiMLIxJ9/qF+a2p6RXMcMtKTFqxqamYvO+
         jU7TKgFG4FIrZwP/DIdsAAiEw7AJ1oc9M8+9hUxiq/1vzfHuZiaXLoVQe5A+M2cy8zUe
         weohEgcNLOl/ri/Cv88Fxe4NsMmek2c4WeFvtHrX6YfdFktZmV+4m7DGUw5FhBqXHM2R
         hrb8sh6kO5KyhEVCghK0RAtONbo2JDjRFBZWyuXOr91AL7VLQNJvkawHOp1WbZvHDkYr
         L4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686623783; x=1689215783;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XY9UC3Bp/xIq1VGbFv2A/NuLEcX+9wS3+nQX7iCrIxk=;
        b=Ta7hwwaw0gaiR2K4MP7QQz8DJkTnPB6Sj2pBbUluK4JVkyDRrTLptPOygZ6z8kdSGg
         XBBNJ/QW8GD6F+ueZXVV5sJdBY1Hwmc3SX+4aAmkTdkQVvt797o1ttTsxWCnk+TGhpn4
         +J7OXUTcgC5QKG5rLabf5H3d8iOpPuH/o0GFBViHb35+Eoc+6ANsJs2c9PpE+RSIw7pd
         tny2ZvGr2uywuqq1yRzd1kZbmQc9Hs2ErfNlKwUXvmPe3Ps6GnIicwe8s+Rjzz5RNKpy
         gz1Xjc5vof458EOPKnWWF2rR6+lsywIYo3DbEpGE6q6bt/B3w5m03m1ZKZYvOXXAw5dN
         zoXQ==
X-Gm-Message-State: AC+VfDxAbFiyTqLiTmadkAYaFrRUet5zUU8d1oqCXiUTuCkanj+sXG6l
	ALY/Na5JJzUILxos1rK/TjE=
X-Google-Smtp-Source: ACHHUZ6JpW8BilYkTXX/6vB6RWL8C90FmedJPScWWqsCOVJ2aHViU0oWm7LvhLDKlPqWz9AAnyxV8Q==
X-Received: by 2002:a17:902:c406:b0:1b0:48e9:cddd with SMTP id k6-20020a170902c40600b001b048e9cdddmr10212081plk.69.1686623783393;
        Mon, 12 Jun 2023 19:36:23 -0700 (PDT)
Received: from [172.20.0.228] ([65.57.72.195])
        by smtp.gmail.com with ESMTPSA id d6-20020a170903230600b001ae57277a87sm8924295plh.255.2023.06.12.19.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 19:36:22 -0700 (PDT)
Message-ID: <f9d91be1-3a88-0f3e-dd14-c4aaca756201@gmail.com>
Date: Mon, 12 Jun 2023 19:36:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Verify that the cgroup_skb
 filters receive expected packets.
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kui-Feng Lee <kuifeng@meta.com>
References: <20230612191641.441774-1-kuifeng@meta.com>
 <20230612191641.441774-3-kuifeng@meta.com>
 <CAADnVQ+Fbz9pQ6BbKX_z9Sx=pwNaODD7vvBsaz_89Zy6Zs0=jg@mail.gmail.com>
 <0c67d4b3-fe9f-507c-5856-78c2ea4f6573@gmail.com>
 <CAEf4BzZtj4mRExjh9kAt0Mwi+4pr17HMWpXzqCCTDDXBF5FeNg@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzZtj4mRExjh9kAt0Mwi+4pr17HMWpXzqCCTDDXBF5FeNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/12/23 16:31, Andrii Nakryiko wrote:
> On Mon, Jun 12, 2023 at 2:56 PM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>
>>
>> On 6/12/23 13:31, Alexei Starovoitov wrote:
>>> On Mon, Jun 12, 2023 at 12:16 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>>> +static int close_connection(int *closing_fd, int *peer_fd, int *listen_fd)
>>>> +{
>>>> +       int err;
>>>> +
>>>> +       /* Half shutdown to make sure the closing socket having a chance to
>>>> +        * receive a FIN from the client.
>>>> +        */
>>>> +       err = shutdown(*closing_fd, SHUT_WR);
>>>> +       if (CHECK(err, "shutdown closing_fd", "failed: %d\n", err))
>>>> +               return -1;
>>>> +       usleep(100000);
>>>> +       err = close(*peer_fd);
>>>> +       if (CHECK(err, "close peer_fd", "failed: %d\n", err))
>>>> +               return -1;
>>>> +       *peer_fd = -1;
>>>> +       usleep(100000);
>>>> +       err = close(*closing_fd);
>>>
>>> usleep() won't guarantee it. The test will be flaky.
>>> Can you make it reliable?
>> What if it checks a counter of packets going through the filter?
>> Will try a couple times until it is too long, one second
>> for example.
>>
>>>
>>>> +
>>>> +/* Run accept() on a socket in the cgroup to receive a new connection. */
>>>> +#define EGRESS_ACCEPT                                                  \
>>>> +       case SYN_RECV_SENDING_SYN_ACK:                                  \
>>>> +               if (tcph.fin || !tcph.syn || tcph.rst || !tcph.ack)     \
>>>> +                       g_unexpected++;                                 \
>>>> +               else                                                    \
>>>> +                       g_sock_state = SYN_RECV;                        \
>>>> +               break
>>>> +
>>>> +#define INGRESS_ACCEPT                                                 \
>>>> +       case INIT:                                                      \
>>>> +               if (!tcph.syn || tcph.fin || tcph.rst || tcph.ack)      \
>>>> +                       g_unexpected++;                                 \
>>>> +               else                                                    \
>>>> +                       g_sock_state = SYN_RECV_SENDING_SYN_ACK;        \
>>>> +               break;                                                  \
>>>> +       case SYN_RECV:                                                  \
>>>> +               if (tcph.fin || tcph.syn || tcph.rst || !tcph.ack)      \
>>>> +                       g_unexpected++;                                 \
>>>> +               else                                                    \
>>>> +                       g_sock_state = ESTABLISHED;                     \
>>>> +               break
>>>> +
>>>
>>> The macros make the code difficult to follow.
>>> Could you do it with normal functions?
>>>
>> Sure!
>>
> 
> please don't use CHECK() macros for new code, use ASSERT_xxx() family
Got it!


