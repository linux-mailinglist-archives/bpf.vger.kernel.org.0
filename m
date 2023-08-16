Return-Path: <bpf+bounces-7917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF8877E71A
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 18:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B5C1C20B0B
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 16:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397C5168B9;
	Wed, 16 Aug 2023 16:58:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFA310949;
	Wed, 16 Aug 2023 16:58:34 +0000 (UTC)
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64B81BE7;
	Wed, 16 Aug 2023 09:58:31 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 082113200936;
	Wed, 16 Aug 2023 12:58:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 16 Aug 2023 12:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjusaka.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1692205106; x=1692291506; bh=bqqqxjVQXB11bXS2XPDSYy3H/z1FMuEH1+F
	+yhBNcXM=; b=SpGcFI9tty5G9XxTIQp3m6j1v9g7Rc+qHIb5y47g7gC6r0+95eY
	+X+ZSJi+X0Dxakt4z2FYC2C4DqK0ylAhgjHgVdEP2s4W3dL49EhSfVcu1VvvB/Yp
	iHiffyxaZI6Qz8LlZeX5SwRgnapi5xZqp0wfYFk9C+BbySVny8N8wi+LFBysjpKB
	LPI1VHIOzflT3dZmwW8wI0GIj1YlhKCQWpBy2mQ1qcnobS1Y1pgxEKcZHvM+HDGC
	IAN8LTbyBQIHsmu87bLmJFcC0Ctu3mnGAO8N8t5MYvCUyFNApef30btJhD4+pjlx
	3QDLHg7vCkw+mUodUjzm+oFT6va+yzeKciQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1692205106; x=1692291506; bh=bqqqxjVQXB11bXS2XPDSYy3H/z1FMuEH1+F
	+yhBNcXM=; b=dSXAhvZyD1Sz+sOQ3jiijy0iUP53HYcBiZP2hGb3arMwbXBe7S8
	KxRPuWgfAp0WTOQrJBRLRUDkLJ7DO0tXCBgODTGcaZU0FFONSpiIpiOilPzF2aJ4
	ZcVMzU6OyGB4JshhmAoM9SmBQttKYuGubGqypLM0+c124+53N1Rb3qq75ECJJOFT
	Nux9CJL6fjoiCPTY8k5dCL+sCfJZihdtEquH9S2GsPS+G2/javkjTdhTVRS8Bj3I
	1tSyjvGtxnoHpwZH384e8BtvEe9VouYSvNsGKh2ZlnXOREIRuGVzTzDJWcdEPsuL
	vCRTPD4+7620a0NJfy2EK6MMBkoF3mBPw6w==
X-ME-Sender: <xms:MgDdZGJYKhzEkNmosz2m88L_QOMyOQHl5WZPng0N--h88yITaDq3Mg>
    <xme:MgDdZOLJvceuiltx6y0I9R0j6gOlnWULTMtP8WlIWMGUP--z29YQiupKCP1X9xygF
    ZKCbQzlbgzxZ5uz9tY>
X-ME-Received: <xmr:MgDdZGtZ6J7ncVdtmCiy3Ltu2xHIZqL8wZsyuikDtO_hDDNp_-u8mRJIN2dMofbk9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtledguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepofgr
    nhhjuhhsrghkrgcuoehmvgesmhgrnhhjuhhsrghkrgdrmhgvqeenucggtffrrghtthgvrh
    hnpeehheevjeeiudegledtleevuddufedttdekudfgteejjeetfeejleejffdtvdeugeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesmh
    grnhhjuhhsrghkrgdrmhgv
X-ME-Proxy: <xmx:MgDdZLagy-aPeEAMS0OSIjhUPaOQntc9XLR_qTYYc2qVM_l34zZcng>
    <xmx:MgDdZNa1Im85TOLkeBt9i3gWwp-qwmfxU6WxKY7CDNqcbmGB_-py6Q>
    <xmx:MgDdZHBMVDd02v-SsyL6JXDEPT9AP77lQijOkPSa3Gwqcn1tIVyiJA>
    <xmx:MgDdZDBbVpaQiNItVk7nTG8Ez2anmqSlo6xWg_kAVLEO4hJgL0-vWA>
Feedback-ID: i3ea9498d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Aug 2023 12:58:19 -0400 (EDT)
Message-ID: <82771f1c-9659-4aaa-bded-62bef6082bf8@manjusaka.me>
Date: Thu, 17 Aug 2023 00:58:05 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tracepoint: add new `tcp:tcp_ca_event` trace event
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Joe Perches <joe@perches.com>, edumazet@google.com, bpf@vger.kernel.org,
 davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mhiramat@kernel.org, ncardwell@google.com, netdev@vger.kernel.org,
 pabeni@redhat.com
References: <CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
 <20230812201249.62237-1-me@manjusaka.me>
 <20230812205905.016106c0@rorschach.local.home>
 <20230812210140.117da558@rorschach.local.home>
 <20230812210450.53464a78@rorschach.local.home>
 <6bfa88099fe13b3fd4077bb3a3e55e3ae04c3b5d.camel@perches.com>
 <20230812215327.1dbd30f3@rorschach.local.home>
 <a587dac9e02cfde669743fd54ab41a3c6014c5e9.camel@perches.com>
 <8b0f2d2b-c5a0-4654-9cc0-78873260a881@manjusaka.me>
 <20230816110206.13980573@gandalf.local.home>
Content-Language: en-US
From: Manjusaka <me@manjusaka.me>
In-Reply-To: <20230816110206.13980573@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/8/16 23:02, Steven Rostedt wrote:
> On Wed, 16 Aug 2023 14:09:06 +0800
> Manjusaka <me@manjusaka.me> wrote:
> 
>>> +# trace include files use a completely different grammar
>>> +		next if ($realfile =~ m{(?:include/trace/events/|/trace\.h$/)});
>>> +
>>>  # check multi-line statement indentation matches previous line
>>>  		if ($perl_version_ok &&
>>>  		    $prevline =~ /^\+([ \t]*)((?:$c90_Keywords(?:\s+if)\s*)|(?:$Declare\s*)?(?:$Ident|\(\s*\*\s*$Ident\s*\))\s*|(?:\*\s*)*$Lval\s*=\s*$Ident\s*)\(.*(\&\&|\|\||,)\s*$/) {
>>>
>>>
>>>   
>>
>> Actually, I'm not sure this is the checkpatch style issue or my code style issue.
>>
>> Seems wired.
> 
> The TRACE_EVENT() macro has its own style. I need to document it, and
> perhaps one day get checkpatch to understand it as well.
> 
> The TRACE_EVENT() typically looks like:
> 
> 
> TRACE_EVENT(name,
> 
> 	TP_PROTO(int arg1, struct foo *arg2, struct bar *arg3),
> 
> 	TP_ARGS(arg1, arg2, arg3),
> 
> 	TP_STRUCT__entry(
> 		__field(	int,		field1				)
> 		__array(	char,		mystring,	MYSTRLEN	)
> 		__string(	filename,	arg3->name			)
> 	),
> 
> 	TP_fast_assign(
> 		__entry->field1 = arg1;
> 		memcpy(__entry->mystring, arg2->string);
> 		__assign_str(filename, arg3->name);
> 	),
> 
> 	TP_printk("field1=%d mystring=%s filename=%s",
> 		__entry->field1, __entry->mystring, __get_str(filename))
> );
> 
> The TP_STRUCT__entry() should be considered more of a "struct" layout than
> a macro layout, and that's where checkpatch gets confused. The spacing
> makes it much easier to see the fields and their types.
> 
> -- Steve

Thanks for the explain!

So could I keep the current code without any code style change?

I think it would be a good idea to fix the checkpatch.pl script in another patch

