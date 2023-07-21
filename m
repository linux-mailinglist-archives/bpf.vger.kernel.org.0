Return-Path: <bpf+bounces-5610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B14975C72C
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 14:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257BD2821F3
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 12:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AE01BE81;
	Fri, 21 Jul 2023 12:53:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA6429AB;
	Fri, 21 Jul 2023 12:53:34 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD59310D2;
	Fri, 21 Jul 2023 05:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=QkSZ3ez9IisjJg5TePm+J3YGJ6BKRfWqNu7wLrk3vlw=; b=JjCdhYduWJTh/T00+mW7grTevI
	7nu8EQp6yUpQ5GABqQco25qPps5FIc+AQ/Rvnto8FwkRALSKKVlJR1SfYvgFyNv7A4jKSN/Doyg0W
	EZi4Z94Xol410gJ5hgHF4q3fSJTYIVFS+JpmR3O9tO8xUQchdCEqiW7ISiLF7GaEfg5hNGC0freCp
	WTDrqbZFZgIryAiNUNF6GYN+CdO/P6B1A9/eqEXEeUTy3GaHWiW6nRk8g3/Qk2TMNaBvpqFEHdzKN
	09miZLGPiclFSzVa/jvQhoExkPzg2haqXglm366QlfRH2MveLCYn8LV0lKhTD7+L7np1v08dCR06J
	Bk4GMSHg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qMpdE-000BeS-0m; Fri, 21 Jul 2023 14:53:16 +0200
Received: from [123.243.13.99] (helo=192-168-1-114.tpgi.com.au)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qMpdD-000X0s-4n; Fri, 21 Jul 2023 14:53:15 +0200
Subject: Re: [PATCH bpf-next v6 2/8] bpf: Add fd-based tcx multi-prog infra
 with link support
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, sdf@google.com, john.fastabend@gmail.com,
 kuba@kernel.org, dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org,
 davem@davemloft.net, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20230719140858.13224-1-daniel@iogearbox.net>
 <20230719140858.13224-3-daniel@iogearbox.net>
 <CALOAHbAWXNRW4oz+AfUE7h5KJ_6DkRyYn5RWWSvjC5=oNm87QQ@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9f218f1d-3610-9112-2844-334399944164@iogearbox.net>
Date: Fri, 21 Jul 2023 14:53:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALOAHbAWXNRW4oz+AfUE7h5KJ_6DkRyYn5RWWSvjC5=oNm87QQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26976/Fri Jul 21 09:28:26 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/20/23 4:13 AM, Yafang Shao wrote:
> On Wed, Jul 19, 2023 at 10:11 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
[...]
>> +static const struct bpf_link_ops tcx_link_lops = {
>> +       .release        = tcx_link_release,
>> +       .detach         = tcx_link_detach,
>> +       .dealloc        = tcx_link_dealloc,
>> +       .update_prog    = tcx_link_update,
>> +       .show_fdinfo    = tcx_link_fdinfo,
>> +       .fill_link_info = tcx_link_fill_info,
> 
> Should we show the tc link info in `bpftool link show` as well? I
> believe that `bpftool link show` is the appropriate command to display
> comprehensive information about all links.

Yep, good idea. I'll add this to my todo list to tackle for once I'm back
from travel.

Thanks,
Daniel

