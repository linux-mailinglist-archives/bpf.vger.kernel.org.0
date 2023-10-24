Return-Path: <bpf+bounces-13156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E31527D5BF8
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 21:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E716B1C20D02
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 19:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97663D97C;
	Tue, 24 Oct 2023 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ZwxOBDVX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9763E468;
	Tue, 24 Oct 2023 19:58:10 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEEBD7F;
	Tue, 24 Oct 2023 12:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=wBc2ee6WgHMTUznIEqLMaOzJxqrA9qkMKQFIIG7GQFM=; b=ZwxOBDVXffZyVbxeALkJcZ5WRu
	7G1rxZkDK4jhZ9uKD9zvmkivbL0n3y4TrQ8uIACv8FDpq6pjNL2gGu7UBOssgSPusZGO0J0jmHXAm
	OrLW8yK5a17bwXU1nY3nJwssnoTNZgFJEgRL80uNQjLVYgbWoaDCv7VmxNPxhotlWaX1pY5sOvwRa
	KkmS25coB0i76U8W9anV8mZk3vm5WtEWl48Q6TFikBCjQDhJZ/TSfzZskFpKaaUiunCwmwCdIMeMX
	zM60dOmYjlxHg6x2oCsiLYLmOGNcKpehh5Zm6XgbbaDTN4MpGhopm883dQhI++G+tyPssawJP6pjd
	knQU3wsg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvNXS-000HAE-Mw; Tue, 24 Oct 2023 21:58:06 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvNXS-000Cvi-9I; Tue, 24 Oct 2023 21:58:06 +0200
Subject: Re: [PATCH bpf-next v3 1/7] netkit, bpf: Add bpf programmable net
 device
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, ast@kernel.org, andrii@kernel.org,
 john.fastabend@gmail.com, toke@kernel.org, kuba@kernel.org, andrew@lunn.ch
References: <20231023171856.18324-1-daniel@iogearbox.net>
 <20231023171856.18324-2-daniel@iogearbox.net> <ZTfza8hC_79X10F8@google.com>
 <ca1f0aaa-94c2-5e7d-1d00-a640bb3be44a@iogearbox.net>
 <ZTgMg3HfFohvISSF@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5578ded4-8957-5cfc-5731-7156b0152af2@iogearbox.net>
Date: Tue, 24 Oct 2023 21:58:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZTgMg3HfFohvISSF@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27071/Tue Oct 24 09:43:50 2023)

On 10/24/23 8:27 PM, Stanislav Fomichev wrote:
> On 10/24, Daniel Borkmann wrote:
>> On 10/24/23 6:40 PM, Stanislav Fomichev wrote:
>>> On 10/23, Daniel Borkmann wrote:
>> [...]
>>> The series looks great! FWIW:
>>> Acked-by: Stanislav Fomichev <sdf@google.com>
>>
>> Thanks for review!
>>
>>> One small question I have is:
>>> We now (and after introduction of tcx) seem to store non-refcounted
>>> dev pointers in the bpf_link(s). Is it guaranteed that the dev will
>>> outlive the link?
>>
>> The semantics are the same as it was done in XDP, meaning, the link is in
>> detached state so link->dev is NULL when dev goes away, see also the
>> dev_xdp_uninstall(). We cannot hold a refcount on the dev as otherwise
>> if the link outlives it we get the infamous "unregister_netdev...waiting
>> for <dev>... refcnt = 1" bug.
> 
> Yeah, I remember I've had a similar issue with holding netdev when
> adding dev-bound programs, so I was wondering what are we doing here.
> Thanks for the pointers!
> 
> And here, I guess the assumption that the device shutdown goes via
> dellink (netkit_del_link) and there is no special path that reaches
> unregister_netdevice_many_notify otherwise, right?

Correct, this is where various netdevices do their internal cleanup.

> What about that ndo_uninit btw? Would it be more safe/clear to make
> netkit_release_all be ndo_uninit? Looks like it's being triggered
> in a place similar to dev_xdp_uninstall/dev_tcx_uninstall.

Looking into it, that is a better location for netkit_release_all()
indeed, and ndo_uninit is under rtnl. I'll spin a v4 with this and the
commit message fixups that Toke suggested. Thanks for the pointer!

Thanks,
Daniel

