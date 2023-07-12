Return-Path: <bpf+bounces-4849-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 613D275087B
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 14:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C751C2116E
	for <lists+bpf@lfdr.de>; Wed, 12 Jul 2023 12:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80274200B5;
	Wed, 12 Jul 2023 12:38:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532AB385
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 12:38:58 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D2710F2
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 05:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=i4sixIMshXG77R8qrA8HGVsEQ5GRCmIofctuMiGo7Eo=; b=I4qmeRJBzP6x74Jgiigi6tDliW
	usZGS4WYmKzjHawJQR8aRjM0txYIPJwr/v6XO8BNhweBt/Dwj/vQR7p+M5ZqJZQujfqSo4NlxQfHM
	n271PfPjXEg6umGssn2PZZvAmxdklFbukHnTs/XYBEariKagZAdRD1p77mvOceVaP0yothCd6hEMd
	Gx3IFsLy4rjUeItki5zTMZqKm6wecAsm1dpAdnRWT4ie2ZRWiT/Z1ZyIst59JkBb3AxhWuSeB5g9m
	uxZMLPRtgH6k4uqsvZavaCV6bDgFNKDUnMs41ADy/FFs5H2WoyeIli382Evs4XKz6QC9LawFzMGOn
	/tzum6Uw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qJZ7L-000HFO-A4; Wed, 12 Jul 2023 14:38:51 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qJZ7L-000Sdw-2C; Wed, 12 Jul 2023 14:38:51 +0200
Subject: Re: [PATCH bpf-next] bpf, vmtest: Build test_progs and friends as
 statically linked
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, andrii@kernel.org,
 bpf@vger.kernel.org
References: <05b5dd79465be41ff8cf8b56b694118a0aa7ae12.1685140942.git.daniel@iogearbox.net>
 <CAEf4BzYZBC_518wLTEXVo4+QyJ=Lsx0BYuVsL38xYdPfGOKHEg@mail.gmail.com>
 <8005de2d-5e10-9eef-2a0d-6f15aa681c05@iogearbox.net>
 <dm7i55664qqp64gogp2gbfljivgiexckw5pnvljoldtxbk7or2@n6kjeviz23wn>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0456d565-a0d9-8c37-b36a-2d9b2098733d@iogearbox.net>
Date: Wed, 12 Jul 2023 14:38:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <dm7i55664qqp64gogp2gbfljivgiexckw5pnvljoldtxbk7or2@n6kjeviz23wn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26967/Wed Jul 12 09:28:32 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/11/23 10:15 PM, Daniel Xu wrote:
> On Wed, May 31, 2023 at 09:53:57PM +0200, Daniel Borkmann wrote:
>> On 5/31/23 9:02 PM, Andrii Nakryiko wrote:
>>> On Fri, May 26, 2023 at 3:47 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>>>
>>>> Small fix for vmtest.sh that I've been carrying locally for quite a while
>>>> now in order to work around the following linker issue:
>>>>
>>>>     # ./vmtest.sh -- ./test_progs -t lsm
>>>>     [...]
>>>>     + ip link set lo up
>>>>     + [ -x /etc/rcS.d/S50-startup ]
>>>>     + /etc/rcS.d/S50-startup
>>>>     ./test_progs -t lsm
>>>>     ./test_progs: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.33' not found (required by ./test_progs)
>>>>     ./test_progs: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.34' not found (required by ./test_progs)
>>>>     [    1.356497] ACPI: PM: Preparing to enter system sleep state S5
>>>>     [    1.358950] reboot: Power down
>>>>     [...]
>>>>
>>>> With the specified TRUNNER_LDFLAGS out of vmtest to force static linking
>>>> runners like test_progs/test_maps/etc work just fine.
>>>
>>> Should we make this a command line option to the vmtest.sh script
>>> instead? I, for one, can't even successfully build on my machine with
>>> this, probably due to missing some -static library package (though I
>>> did install libzstd-static). I'm getting:
>>
>> Interesting, in my case it's the other way round, but yeah that could work
>> as well.
> 
> I had the same zstd linker error. This hacky change fixes it:
> 
> ```
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 9706e7e5e698..c0d8809fd002 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -31,7 +31,7 @@ CFLAGS += -g -O0 -rdynamic -Wall -Werror $(GENFLAGS) $(SAN_CFLAGS)    \
>            -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
>            -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
>   LDFLAGS += $(SAN_LDFLAGS)
> -LDLIBS += -lelf -lz -lrt -lpthread
> +LDLIBS += -lelf -lz -lrt -lpthread -lzstd
> 
>   # Silence some warnings when compiled with clang
>   ifneq ($(LLVM),)
> ```
> 
> Would be good to get some variant of this patch in.

The above doesn't work for my env, getting same error with adding the -lzstd.
Btw, did the patch from above work for you?

