Return-Path: <bpf+bounces-7226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91F0773B1B
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 17:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7A32812FB
	for <lists+bpf@lfdr.de>; Tue,  8 Aug 2023 15:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D1D134D8;
	Tue,  8 Aug 2023 15:41:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277284C6B;
	Tue,  8 Aug 2023 15:41:37 +0000 (UTC)
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777F93C35;
	Tue,  8 Aug 2023 08:41:01 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 4BBAB5C0071;
	Tue,  8 Aug 2023 00:29:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 08 Aug 2023 00:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjusaka.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1691468967; x=1691555367; bh=8AiTok5JDF9sbeOx4wW7macbALwiE51ginh
	DuOAqzXo=; b=reYamyAdTQI2JHFGyYJcp8d4LBS1ve63JXOSAbQqpsTVDC/Teqp
	QRw2BHH/q0QbzaHtzCB57WsSvbFDJVudH3xuOi9wz4K5nuto27tpPfFTOCD01r6I
	DsNXv6eRnS/iuNETOIGkoJOVarSSFaeJxyhMsnSiR95qUwQWV2oEpryFJjTfqGf9
	OG1L9A9WQSLs+xSjLj5CTN2OssLLlwmG5d2i3CVykJFE0jwUE8mSB3QacMslzTm5
	UHxHgRyD5OySnvMfLLXMV5pM7QQoigCw5aFqoXyhI35MonC6CFL16jiWQj1/nRlj
	XsN6gRB2iu13NP8GMIMHHEGQOBR9IZUVEwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1691468967; x=1691555367; bh=8AiTok5JDF9sbeOx4wW7macbALwiE51ginh
	DuOAqzXo=; b=UGC1LlBn7G5IOZ7kx5v52i9V/nibptAyZpl7fotqSTn2BO/GRML
	x77ugu0DzFmWQTxkiOJU80AYm6w6C4YmShLb8pMxhXlXf2D+Ir3Pj9ZON6cH4iB4
	i5ytos5NcNMKkWi0VKfPB+H2mmbpPr5cbVHYz1zJDVNOx1WCfj590R4Y4vGTs+1Q
	PyhlfLH+UEIzvmiF5O+mLN16UoxVvS8YKfl4BZR6adu/dM11+vgeITi99GA1Yl5s
	9NapBNCsSsEM/OJTQ/plvpSQZswvLTMlQulRTZNAnvZwiJEk+xd3ZyfkrjCoE7Yj
	0lVd1fI7UhzFOJUSUOZ3hJGp1VOVqBgCfzw==
X-ME-Sender: <xms:psTRZNM1_bNNIENot-usKj6HaG0q7rUA6cDOfLCBm_iI9AATvSYioQ>
    <xme:psTRZP-YpQEzHRcVebDk8bxpGp0TjhpOgWO-EmmZYYcZlHZkdlzU2TV9jtNDkNqII
    tcMsK4Sz5oRuTOdPG8>
X-ME-Received: <xmr:psTRZMSWa5--0qGKjHlMqpM0bYNL3HfJ_Hnlb2HBL_MMx4S_xexx9WKlGDZrda-GTss>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrledugdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepofgrnhhj
    uhhsrghkrgcuoehmvgesmhgrnhhjuhhsrghkrgdrmhgvqeenucggtffrrghtthgvrhhnpe
    duveevjefhjedvgeevvdeutdeukeeljeelhfeftdehkefhfeeivdfgudekueeileenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesmhgrnh
    hjuhhsrghkrgdrmhgv
X-ME-Proxy: <xmx:p8TRZJu11sOMwh6GXOWCgZpysbcXRoWmrWnSuZzCx_79NXg5C2BIOQ>
    <xmx:p8TRZFdZvFr-niFfpbG71jqXHrRrtxVSJS0DLxTFc1flErWDfZFmBg>
    <xmx:p8TRZF3QkCnP-TF_1jlQnccrWRyt1RMK9-3StHw2JFYyqyraym_TKg>
    <xmx:p8TRZGXvVy7UCL9wAR1nNr4Sf3rGIpwd5qLmcYe0qI7sr9ONrvWxIQ>
Feedback-ID: i3ea9498d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 8 Aug 2023 00:29:23 -0400 (EDT)
Message-ID: <acd63d47-15a2-44a6-ace0-c55705db42a8@manjusaka.me>
Date: Tue, 8 Aug 2023 12:29:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracepoint: add new `tcp:tcp_ca_event_set` trace event
Content-Language: en-US
To: Neal Cardwell <ncardwell@google.com>
Cc: edumazet@google.com, mhiramat@kernel.org, rostedt@goodmis.org,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20230807183308.9015-1-me@manjusaka.me>
 <CADVnQyn3UMa3Qx6cC1Rx97xLjQdG0eKsiF7oY9UR=b9vU4R-yA@mail.gmail.com>
From: Manjusaka <me@manjusaka.me>
In-Reply-To: <CADVnQyn3UMa3Qx6cC1Rx97xLjQdG0eKsiF7oY9UR=b9vU4R-yA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 2023/8/8 04:00, Neal Cardwell wrote:
> On Mon, Aug 7, 2023 at 2:33 PM Manjusaka <me@manjusaka.me> wrote:
>> In normal use case, the tcp_ca_event would be changed in high frequency.
>>
>> It's a good indicator to represent the network quanlity.
>>
>> So I propose to add a `tcp:tcp_ca_event_set` trace event
>> like `tcp:tcp_cong_state_set` to help the people to
>> trace the TCP connection status
>>
>> Signed-off-by: Manjusaka <me@manjusaka.me>
>> ---
>>  include/net/tcp.h          |  9 ++------
>>  include/trace/events/tcp.h | 45 ++++++++++++++++++++++++++++++++++++++
>>  net/ipv4/tcp_cong.c        | 10 +++++++++
>>  3 files changed, 57 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index 0ca972ebd3dd..a68c5b61889c 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -1154,13 +1154,8 @@ static inline bool tcp_ca_needs_ecn(const struct sock *sk)
>>         return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
>>  }
>>
>> -static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
>> -{
>> -       const struct inet_connection_sock *icsk = inet_csk(sk);
>> -
>> -       if (icsk->icsk_ca_ops->cwnd_event)
>> -               icsk->icsk_ca_ops->cwnd_event(sk, event);
>> -}
>> +/* from tcp_cong.c */
>> +void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event);
>>
>>  /* From tcp_cong.c */
>>  void tcp_set_ca_state(struct sock *sk, const u8 ca_state);
>> diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
>> index bf06db8d2046..38415c5f1d52 100644
>> --- a/include/trace/events/tcp.h
>> +++ b/include/trace/events/tcp.h
>> @@ -416,6 +416,51 @@ TRACE_EVENT(tcp_cong_state_set,
>>                   __entry->cong_state)
>>  );
>>
>> +TRACE_EVENT(tcp_ca_event_set,
> Regarding the proposed name, "tcp_ca_event_set"... including "set" in
> the name is confusing, since the tcp_ca_event() function is not really
> setting anything. :-)
>
> The trace_tcp_cong_state_set() call you are using as a model has "set"
> in the name because the function it is tracing, tcp_set_ca_state(),
> has "set" in the name. :-)
>
> Would it work to use something like:
>   TRACE_EVENT(tcp_ca_event,
>
> thanks,
> neal
Thanks for the review! LGTM, I will send a new patch ASAP

