Return-Path: <bpf+bounces-13149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2127D5A16
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 20:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25785281ABE
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 18:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC6A3B7B2;
	Tue, 24 Oct 2023 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="pwcFh0y1"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E06440E;
	Tue, 24 Oct 2023 18:05:26 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E3610D0;
	Tue, 24 Oct 2023 11:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kuQyDHagtTN3rp+CUKAjDkyyJVJBBi8CUps3DJAI21c=; b=pwcFh0y1kgvkUHqpWfyHgxFEtL
	F1nfgXrMq1kblXXJthS6IO8G34vsiJDayyMUExU5lFYbCD1cTnYo5VuX64b/jGnyg+uW5nn7TUOxx
	9fDbInsQXTn2kRKqZ+dO4e0pjY0yFg6Mm2pV1vlDyl5YpylTy5x01FEQh6cecIjNEUIeFglOKeoVa
	vmn77ClxNVVTLwmKXwUzc4lVrngRjJKNYjYtHU2VGk+qZ7o1Hp0kIoXPC5Bf0qGXlkmsNMPfgOucy
	ooHr8tFpAgxQKc+6pkk1RH/oIxAngLiSVkHoxDFUhpZM56/0TS+fACBlYFzxye04C1FQwOD25/Aoj
	mpU8M1fw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvLmL-0004fE-Tj; Tue, 24 Oct 2023 20:05:21 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvLmL-000HCX-F8; Tue, 24 Oct 2023 20:05:21 +0200
Subject: Re: [PATCH bpf-next v3 1/7] netkit, bpf: Add bpf programmable net
 device
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, ast@kernel.org, andrii@kernel.org,
 john.fastabend@gmail.com, toke@kernel.org, kuba@kernel.org, andrew@lunn.ch
References: <20231023171856.18324-1-daniel@iogearbox.net>
 <20231023171856.18324-2-daniel@iogearbox.net> <ZTfza8hC_79X10F8@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ca1f0aaa-94c2-5e7d-1d00-a640bb3be44a@iogearbox.net>
Date: Tue, 24 Oct 2023 20:05:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZTfza8hC_79X10F8@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27071/Tue Oct 24 09:43:50 2023)

On 10/24/23 6:40 PM, Stanislav Fomichev wrote:
> On 10/23, Daniel Borkmann wrote:
[...]
> The series looks great! FWIW:
> Acked-by: Stanislav Fomichev <sdf@google.com>

Thanks for review!

> One small question I have is:
> We now (and after introduction of tcx) seem to store non-refcounted
> dev pointers in the bpf_link(s). Is it guaranteed that the dev will
> outlive the link?

The semantics are the same as it was done in XDP, meaning, the link is in
detached state so link->dev is NULL when dev goes away, see also the
dev_xdp_uninstall(). We cannot hold a refcount on the dev as otherwise
if the link outlives it we get the infamous "unregister_netdev...waiting
for <dev>... refcnt = 1" bug.

>> +	ret = netkit_link_prog_attach(&nkl->link,
>> +				      attr->link_create.flags,
>> +				      attr->link_create.netkit.relative_fd,
>> +				      attr->link_create.netkit.expected_revision);
>> +	if (ret) {
>> +		nkl->dev = NULL;
>> +		bpf_link_cleanup(&link_primer);
>> +		goto out;
> 
> What happens to nkl here? Do we leak it?

No, this is done similarly as in XDP and tcx, that is, bpf_link_cleanup() will
trigger eventual release of nlk here :

/* Clean up bpf_link and corresponding anon_inode file and FD. After
  * anon_inode is created, bpf_link can't be just kfree()'d due to deferred
  * anon_inode's release() call. This helper marks bpf_link as
  * defunct, releases anon_inode file and puts reserved FD. bpf_prog's refcnt
  * is not decremented, it's the responsibility of a calling code that failed
  * to complete bpf_link initialization.
  * This helper eventually calls link's dealloc callback, but does not call
  * link's release callback.
  */

Thanks,
Daniel

