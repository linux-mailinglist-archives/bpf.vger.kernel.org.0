Return-Path: <bpf+bounces-5961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F16F76382C
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 15:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A005D1C21285
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 13:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A328821D2C;
	Wed, 26 Jul 2023 13:56:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732B5BA43
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 13:56:33 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ECD2D49;
	Wed, 26 Jul 2023 06:54:45 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 875505C010E;
	Wed, 26 Jul 2023 09:54:34 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 26 Jul 2023 09:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1690379674; x=1690466074; bh=jn
	8YT4QXzhf79icX43frcS+scUrPudwRPlXjFdtPVoI=; b=PUg04CxA/GT3yiMx7o
	+zIyPgBVG9Ha9lC6KiYsFp7hTGccg7sPMlQxrIT3fJ1Uj4CGN8iOBbHwFQrd3Y8V
	XVvpMjNyG4qWBNmaMj8UroPCNp8y5ZB6Ae54Usou9WSlw/DpSyEooS+UT2UXH2OG
	kKeFBvrLVNxolgoiKtg3GTocr+Bc+pxniSPtxBvNcuTlOyrJvopJ/UhEMal6Pk+c
	u3sUZhUDP+45MQSgQFpMovBNfSeKm/IkwqPNcldRxotDyyfHYDOTKUMFxOMWeP7f
	F2LafBh3qWAvSkb3uH/5d/S4S6eD3xahygnqTHhHrl9Hr4pkrC3e8Z8sSVoXvyaF
	ViTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690379674; x=1690466074; bh=jn8YT4QXzhf79
	icX43frcS+scUrPudwRPlXjFdtPVoI=; b=M4LQ1IB+miqlHpb8x5MagAMmHo/rt
	0L9pBrho9r/Ab3XYikuaTsVwfUiT7XuW2r6yjfetRLUat5i3mD1Ef3+r8H/8BcGb
	Xe+KuXtpBk7yeBuITLr5vOSDMt1Th7Jmc7IDU4QkC9iBqi92Nq7CbxYeLu3R8oB4
	P7u48XV2boNDvFSAwb3vEsyjN4UAFqE0vxW4LAuUj88dxGrAXoBVNUFUXtaO0Swd
	XjlwTUx1HSi3tXFMSsX0sPKom29FAftr22io7VPqomp5NPLvdam652ixMVTBSyvL
	cu2rATVoIUnUd/1DslyWNDzvuMMxUPClar5ey1m9qrsDFcGZdVvytbDjg==
X-ME-Sender: <xms:mSXBZERIT9IhfR8qKLs-GyoHM8USb_3bkSqgAEMlUfTbc_iT9AT9rg>
    <xme:mSXBZBz5VKWTjEUlIUje7mz6J1fa6AZJe9MHntB3J9ClvtYvXXKN_f5XPHdyO9Rc7
    gLu-kWAvVEhYllxMPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedriedvgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:mSXBZB2RLaL8nNWxM-sUzH8cBH_ZjnNgJVTtxfQUkPczKxIfLI_qXA>
    <xmx:mSXBZIBDZi92TRCIQ9-NC9cAE7WupWrAAjEVFsq26aYpER9Dnki9bw>
    <xmx:mSXBZNiBc4V_O0cwkSaaCf2m-G4KTRHZvmg0s1StgIqFHGiERcnKbQ>
    <xmx:miXBZAgKmsaiE44dWucPmy4JWb0JrxfACp37v97FvzF4jDHJMTCRNw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2AD45B60089; Wed, 26 Jul 2023 09:54:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-592-ga9d4a09b4b-fm-defalarms-20230725.001-ga9d4a09b
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <4df0dc2a-50d2-4a8f-8a8c-2b2a943f80ae@app.fastmail.com>
In-Reply-To: <ZMDS+lM/V5t1qD0D@krava>
References: <20230724135327.1173309-1-arnd@kernel.org>
 <20230724135327.1173309-2-arnd@kernel.org> <ZMDS+lM/V5t1qD0D@krava>
Date: Wed, 26 Jul 2023 15:54:11 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jiri Olsa" <olsajiri@gmail.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Luis Chamberlain" <mcgrof@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yhs@fb.com>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@google.com>, "Hao Luo" <haoluo@google.com>,
 "Mark Rutland" <mark.rutland@arm.com>, "Kees Cook" <keescook@chromium.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Palmer Dabbelt" <palmer@rivosinc.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
Subject: Re: [PATCH 2/2] [v2] kallsyms: rework symbol lookup return codes
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 26, 2023, at 10:02, Jiri Olsa wrote:
> On Mon, Jul 24, 2023 at 03:53:02PM +0200, Arnd Bergmann wrote:

>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index 05c0024815bf9..bc0eed24a5873 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -6965,7 +6965,7 @@ allocate_ftrace_mod_map(struct module *mod,
>>  	return mod_map;
>>  }
>>  
>> -static const char *
>> +static int
>>  ftrace_func_address_lookup(struct ftrace_mod_map *mod_map,
>>  			   unsigned long addr, unsigned long *size,
>>  			   unsigned long *off, char *sym)
>> @@ -6986,21 +6986,18 @@ ftrace_func_address_lookup(struct ftrace_mod_map *mod_map,
>>  			*size = found_func->size;
>>  		if (off)
>>  			*off = addr - found_func->ip;
>> -		if (sym)
>> -			strscpy(sym, found_func->name, KSYM_NAME_LEN);
>> -
>> -		return found_func->name;
>> +		return strlcpy(sym, found_func->name, KSYM_NAME_LEN);
>
> hi,
> any reason not to call the original strscpy in here?

No, that was a mistake. I replaced the other strcpy and strncpy
with strlcpy in order to get the desired behavior, but in fact
they should all be strscpy, and changing this one was an accident.

I'll send a v3.

     Arnd

