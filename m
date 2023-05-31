Return-Path: <bpf+bounces-1535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A124718A94
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 21:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FAFC1C20AD3
	for <lists+bpf@lfdr.de>; Wed, 31 May 2023 19:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458663C09D;
	Wed, 31 May 2023 19:54:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D8419E61
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 19:54:02 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA36B9D
	for <bpf@vger.kernel.org>; Wed, 31 May 2023 12:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Y1k/P7rHRI/uST6OUcO3Wa1vgIm+WpfRF3zuose9b3o=; b=UXuwdfvEPEEQ7NU2BVNk1AtT7V
	Ku2bZHdm1nJnGEZya9lP5h+VfOrgRRYVDx1NRO01Zz0jbbx/wzmhYOMABHvaEUD13zgRn1VuWDHtf
	d2Y+heMSefFPp8ZRGFeGeb0itzTQFNzp1cdMmOpVPxTFRsDsYT7Bf66SYEEx/VcvdDdZk/vUHdMLO
	bSPSvgT0WT1S0dbNpJgdMX7sC+enEaxo6NFsnqomfYPPjl0SW+TcqMzbOta2sgQDrt0W1AJZJAMf5
	6+C1IQouTTe6ESd43T7de7LnV5BeaDZ8XlIKg0UHvH31EvBPP/n2MDPvR5sOdc7orBVZJhqif9qYr
	1wX8gj+Q==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1q4RtO-0003j6-8D; Wed, 31 May 2023 21:53:58 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1q4RtN-000J2U-Sw; Wed, 31 May 2023 21:53:57 +0200
Subject: Re: [PATCH bpf-next] bpf, vmtest: Build test_progs and friends as
 statically linked
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrii@kernel.org, bpf@vger.kernel.org
References: <05b5dd79465be41ff8cf8b56b694118a0aa7ae12.1685140942.git.daniel@iogearbox.net>
 <CAEf4BzYZBC_518wLTEXVo4+QyJ=Lsx0BYuVsL38xYdPfGOKHEg@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8005de2d-5e10-9eef-2a0d-6f15aa681c05@iogearbox.net>
Date: Wed, 31 May 2023 21:53:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzYZBC_518wLTEXVo4+QyJ=Lsx0BYuVsL38xYdPfGOKHEg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26924/Wed May 31 09:24:56 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/31/23 9:02 PM, Andrii Nakryiko wrote:
> On Fri, May 26, 2023 at 3:47 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> Small fix for vmtest.sh that I've been carrying locally for quite a while
>> now in order to work around the following linker issue:
>>
>>    # ./vmtest.sh -- ./test_progs -t lsm
>>    [...]
>>    + ip link set lo up
>>    + [ -x /etc/rcS.d/S50-startup ]
>>    + /etc/rcS.d/S50-startup
>>    ./test_progs -t lsm
>>    ./test_progs: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.33' not found (required by ./test_progs)
>>    ./test_progs: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.34' not found (required by ./test_progs)
>>    [    1.356497] ACPI: PM: Preparing to enter system sleep state S5
>>    [    1.358950] reboot: Power down
>>    [...]
>>
>> With the specified TRUNNER_LDFLAGS out of vmtest to force static linking
>> runners like test_progs/test_maps/etc work just fine.
> 
> Should we make this a command line option to the vmtest.sh script
> instead? I, for one, can't even successfully build on my machine with
> this, probably due to missing some -static library package (though I
> did install libzstd-static). I'm getting:

Interesting, in my case it's the other way round, but yeah that could work
as well.

Thanks,
Daniel

