Return-Path: <bpf+bounces-2452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 184CB72D3AB
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 23:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55E4C1C208D8
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 21:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08ED23427;
	Mon, 12 Jun 2023 21:56:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88BB22D44
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 21:56:58 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F095E41
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 14:56:57 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b3be39e35dso18611105ad.0
        for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 14:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686607017; x=1689199017;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ihN9Iws18KJ665kwo8xf587qF+3VzsWohZaTNxgiq4s=;
        b=RfJ2MALHTfpMYMmQ8fJHSiafucGYabKIWITOAJHf+Ds17HyPIVk15D0SQ9YFuechmc
         BS3INMM9sH/WIO+lNQmOLKoekImppVtq6nBLBx3vRFayuhv3HMkOqZADDNyLmeXOvOW9
         KzfDLUrUKPWMqSnWlboAzPcvOt9NASgb+XD4eZ3qGlf93sCtbABvpZA21T6ZSq7Ax1KE
         c7Alf87zPoGLYXzZz7tpVLVwjyzl8ySxVId6Z2yb8oRsKaFRksqvj5BKq8CZY11py59y
         DuKNwvlMWCtpV/u0rDRssntetMs449XmtLjSlZYe25YpBGcqICXeFa27XjracK32SvO7
         Hqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686607017; x=1689199017;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihN9Iws18KJ665kwo8xf587qF+3VzsWohZaTNxgiq4s=;
        b=L9/N3QS56Tox7HZ8Ure4rU/WWbFU4LBCtpSonbxe4FMeI+1g0T9Ve4I3J4buii+xxR
         eC+R7SpEBHTj7KCexgsMG0xegmSK5V29nkIJ5FieHiXlrVrDoGjw2EPltPFz8RNaRW73
         2U0rFGqxJJ90Y+ywrC3ajHL4hMPMR92Pkk60ng0FQWo5S2wS8/7/VA3+JTZahvjuQFKc
         58smcNhr8g5mfyMuEQgXlMbAWwYLkyfpq56ukmpvHfe6pNSVfddfeg0qN0ZtViOikhpy
         0079/5fY0DwJvcp0RrIyCg9Jx4OUGNp18tgdNw9gqWbBb3xgw7pekZodGRCiNknttW1t
         0jMQ==
X-Gm-Message-State: AC+VfDyb8h8cTCDYKVBqZ0Cu5t8FSwOvVnSGgPinbO5FWhkR6xm7QpZD
	KanbFkQdXpgrji8BKUkA+qo=
X-Google-Smtp-Source: ACHHUZ7wqqAQfpFLAkrmpvYoRbJtANs1g6OpRTGOH6qeFs0qPlfyL9oUZxAAntkVYAiykSY42Di36A==
X-Received: by 2002:a17:902:d2c4:b0:1ab:253e:6906 with SMTP id n4-20020a170902d2c400b001ab253e6906mr9015319plc.67.1686607016764;
        Mon, 12 Jun 2023 14:56:56 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e8::12b4? ([2620:10d:c090:400::5:8131])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902c74500b001ac591b0500sm8700498plq.134.2023.06.12.14.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 14:56:56 -0700 (PDT)
Message-ID: <0c67d4b3-fe9f-507c-5856-78c2ea4f6573@gmail.com>
Date: Mon, 12 Jun 2023 14:56:54 -0700
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
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kui-Feng Lee <kuifeng@meta.com>
References: <20230612191641.441774-1-kuifeng@meta.com>
 <20230612191641.441774-3-kuifeng@meta.com>
 <CAADnVQ+Fbz9pQ6BbKX_z9Sx=pwNaODD7vvBsaz_89Zy6Zs0=jg@mail.gmail.com>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAADnVQ+Fbz9pQ6BbKX_z9Sx=pwNaODD7vvBsaz_89Zy6Zs0=jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/12/23 13:31, Alexei Starovoitov wrote:
> On Mon, Jun 12, 2023 at 12:16 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>> +static int close_connection(int *closing_fd, int *peer_fd, int *listen_fd)
>> +{
>> +       int err;
>> +
>> +       /* Half shutdown to make sure the closing socket having a chance to
>> +        * receive a FIN from the client.
>> +        */
>> +       err = shutdown(*closing_fd, SHUT_WR);
>> +       if (CHECK(err, "shutdown closing_fd", "failed: %d\n", err))
>> +               return -1;
>> +       usleep(100000);
>> +       err = close(*peer_fd);
>> +       if (CHECK(err, "close peer_fd", "failed: %d\n", err))
>> +               return -1;
>> +       *peer_fd = -1;
>> +       usleep(100000);
>> +       err = close(*closing_fd);
> 
> usleep() won't guarantee it. The test will be flaky.
> Can you make it reliable?
What if it checks a counter of packets going through the filter?
Will try a couple times until it is too long, one second
for example.

> 
>> +
>> +/* Run accept() on a socket in the cgroup to receive a new connection. */
>> +#define EGRESS_ACCEPT                                                  \
>> +       case SYN_RECV_SENDING_SYN_ACK:                                  \
>> +               if (tcph.fin || !tcph.syn || tcph.rst || !tcph.ack)     \
>> +                       g_unexpected++;                                 \
>> +               else                                                    \
>> +                       g_sock_state = SYN_RECV;                        \
>> +               break
>> +
>> +#define INGRESS_ACCEPT                                                 \
>> +       case INIT:                                                      \
>> +               if (!tcph.syn || tcph.fin || tcph.rst || tcph.ack)      \
>> +                       g_unexpected++;                                 \
>> +               else                                                    \
>> +                       g_sock_state = SYN_RECV_SENDING_SYN_ACK;        \
>> +               break;                                                  \
>> +       case SYN_RECV:                                                  \
>> +               if (tcph.fin || tcph.syn || tcph.rst || !tcph.ack)      \
>> +                       g_unexpected++;                                 \
>> +               else                                                    \
>> +                       g_sock_state = ESTABLISHED;                     \
>> +               break
>> +
> 
> The macros make the code difficult to follow.
> Could you do it with normal functions?
> 
Sure!


