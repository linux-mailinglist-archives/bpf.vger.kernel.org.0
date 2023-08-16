Return-Path: <bpf+bounces-7877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B5277DA42
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 08:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8DC281766
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 06:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C417C2EE;
	Wed, 16 Aug 2023 06:09:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5541844;
	Wed, 16 Aug 2023 06:09:21 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6F210C0;
	Tue, 15 Aug 2023 23:09:19 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 7CCCA5C04FA;
	Wed, 16 Aug 2023 02:09:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 16 Aug 2023 02:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjusaka.me; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1692166156; x=1692252556; bh=zlzqembgfhE0WkCCU6cyrn0gHCOoJpWxWoa
	DKK5MxFk=; b=QLKUstjdzno7jr4QviuCbeDyYe6U1eHEDfJhLa1Nm3YHwaIjwiI
	qbWj0LbSvY6RBxQGkNuk6uxVkCDA42450Jm/sGZy9NlsyNK4fkAFWbpi/uzHRkjF
	i0csvib4E0aF8JIcL+HXIbSV+Bw76nHZ3Man7dtQFEziw5t8f/vnescwOOvdy7Nz
	pTVljhjBLg3uRh7tU2/dVgc51J/kGnvPCqW9URefic3sKZVHf+8KzNHYktqHWZpl
	FM5bcZGtMbTUepgjXPjPiJCvhmJMC2e3LxO4KKAaXFA262FFMq3vGmYWJMyf8gLo
	b1UOd4Aei1ipsdaiMdh9jauigYnfo1jaopQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1692166156; x=1692252556; bh=zlzqembgfhE0WkCCU6cyrn0gHCOoJpWxWoa
	DKK5MxFk=; b=tGoRKzMFyaC/cY44HOj2rx4RX6fGRZllZAxUAdHiGxXkWGeUzU2
	R//aC1HQGSQfMy/fLIpHli7fNMfPS0q0EM0AZYFOeh+gIdwQamyaPxlCDD94eWcw
	oEGeIdfrWuivdD8qiknSQnvrBTGvT8yxV4+8wvue4v8rLT402elOPokiQKDeU6Mf
	G32wmbm9PBE29s1m6663qHnAEu/BtsG4wcKhnMc3xQ6j54g5JLTSIKjC9EcGDIoC
	/KiUW6DnG3zley+nK/SSU2CWlwZp6UILPRGXGMkv6fXjDOKL36m0PypITdEL/fxU
	Rf4U3ixEfPznMAcKqw7KQkwLeTnzW9zT0+g==
X-ME-Sender: <xms:C2jcZF0oKtYAAScnklLhmTavcaKuD7LTbiBteHF22PYSvbXODHt6ow>
    <xme:C2jcZMHZ6DPvsUla2HVKrmXF6hJKe8Gw-NeA7ZAh8MZOZjUg5v074-NAWaae4KjgS
    vt0PVXyNBQLMPR7C9A>
X-ME-Received: <xmr:C2jcZF51FGGqkvgZE1I2jzSgMdZPnQPs4Ov9gCUpX7RJjXafNgAgEUKepilp4jxF_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtkedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepofgr
    nhhjuhhsrghkrgcuoehmvgesmhgrnhhjuhhsrghkrgdrmhgvqeenucggtffrrghtthgvrh
    hnpeehheevjeeiudegledtleevuddufedttdekudfgteejjeetfeejleejffdtvdeugeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgesmh
    grnhhjuhhsrghkrgdrmhgv
X-ME-Proxy: <xmx:C2jcZC3Zs7LV2ZWhE68Wq7UI9dPVblgUgPByUvmuhfWWy2NtyNG9hQ>
    <xmx:C2jcZIGqcSNsaeiuCPX5EoP1Zm-gYSp-Gpsv8jKoT_4TTiHqCIM3ag>
    <xmx:C2jcZD8baMQE24wcA1oz-SlYyD7vgGpRb5wlqLacUTXfCWpuOlW7qQ>
    <xmx:DGjcZL97x-VkNyWsoWxlPeXlPCQmt5MABnMoDThElg5LBrIr2MkrFQ>
Feedback-ID: i3ea9498d:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Aug 2023 02:09:11 -0400 (EDT)
Message-ID: <8b0f2d2b-c5a0-4654-9cc0-78873260a881@manjusaka.me>
Date: Wed, 16 Aug 2023 14:09:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tracepoint: add new `tcp:tcp_ca_event` trace event
To: Joe Perches <joe@perches.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: edumazet@google.com, bpf@vger.kernel.org, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com
References: <CANn89iKQXhqgOTkSchH6Bz-xH--pAoSyEORBtawqBTvgG+dFig@mail.gmail.com>
 <20230812201249.62237-1-me@manjusaka.me>
 <20230812205905.016106c0@rorschach.local.home>
 <20230812210140.117da558@rorschach.local.home>
 <20230812210450.53464a78@rorschach.local.home>
 <6bfa88099fe13b3fd4077bb3a3e55e3ae04c3b5d.camel@perches.com>
 <20230812215327.1dbd30f3@rorschach.local.home>
 <a587dac9e02cfde669743fd54ab41a3c6014c5e9.camel@perches.com>
Content-Language: en-US
From: Manjusaka <me@manjusaka.me>
In-Reply-To: <a587dac9e02cfde669743fd54ab41a3c6014c5e9.camel@perches.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/8/13 10:08, Joe Perches wrote:
> On Sat, 2023-08-12 at 21:53 -0400, Steven Rostedt wrote:
>> On Sat, 12 Aug 2023 18:17:17 -0700
>> Joe Perches <joe@perches.com> wrote:
>>
>>>> I forgot to say "for TRACE_EVENT() macros". This is not about what
>>>> checkpatch says about other code.  
>>>
>>> trace has its own code style and checkpatch needs another
>>> parsing mechanism just for it, including the alignment to
>>> open parenthesis test.
>>
>> If you have a template patch to add the parsing mechanism, I'd be happy
>> to try to fill in the style.
> 
> There is no checkpatch mechanism per se.  It's all ad-hoc.
> 
> Perhaps something like this though would work well enough
> as it just avoids all the other spacing checks and such.
> ---
>  scripts/checkpatch.pl | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 528f619520eb9..3017f4dd09fd2 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3947,6 +3947,9 @@ sub process {
>  			}
>  		}
>  
> +# trace include files use a completely different grammar
> +		next if ($realfile =~ m{(?:include/trace/events/|/trace\.h$/)});
> +
>  # check multi-line statement indentation matches previous line
>  		if ($perl_version_ok &&
>  		    $prevline =~ /^\+([ \t]*)((?:$c90_Keywords(?:\s+if)\s*)|(?:$Declare\s*)?(?:$Ident|\(\s*\*\s*$Ident\s*\))\s*|(?:\*\s*)*$Lval\s*=\s*$Ident\s*)\(.*(\&\&|\|\||,)\s*$/) {
> 
> 
> 

Actually, I'm not sure this is the checkpatch style issue or my code style issue.

Seems wired.


