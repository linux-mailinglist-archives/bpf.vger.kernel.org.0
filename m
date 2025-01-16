Return-Path: <bpf+bounces-49041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 527BAA135E8
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 09:57:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B82E1887B72
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239131D7E5F;
	Thu, 16 Jan 2025 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+iUGFTV"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE6919D8A0
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737017841; cv=none; b=Oo+6SPjTBfnfyrwUPa55dYmugZdQoAOQO5idFoo8ZGJ92j8XkKtQevAJ2IIA+jF1EjcVW52p9BmBQlCHurf+c0jTio/KF7CPAkcJBuW53dgUpDioabKaldT6iNY0y5onfQCWz/kBBCbg+OsrPl2N+iudRLGeL0aAt89D1M5W2H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737017841; c=relaxed/simple;
	bh=PtUhQynYgZLYfz9e+zHBnnH2YW9fJ84gqLC9SnFqqqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdOzgOHq2na7YwI7kQROPzgXhPN4F9Mn7SyQ3Wd5sTRnQ0ckI719Hx5dkII+n/2WjiUVoYJY/NqfeaKHmLziFXQpeAYB/IMpOQQvV9Ze0pQlYxHH7irr3hlwS40WCoa/BAKPIkQTA1zSWCknYTwb6scHMxpZYLlTEGJMPAVGSc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+iUGFTV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737017838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pmkLmsyIcPYmFuaESsfI5oPSmcbmJsLv+8kU8eWcxJk=;
	b=b+iUGFTVAQTEESja0Q2tHSyjXymaEO+gM2Ow+H6WseVs4tQUCnDgSieFrf4N99ZynKKZV/
	JEGAuo6h4Ezc12u+ghHLDJxbnukg91t+dQec10P4JMiod1j4Nbx3lnRjKtlV+JS2BaYWRj
	QsgiPERHC2isFLHuBUfd1p/B/WckPKM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-pzuSx4xlO0eq7B5qTNObAw-1; Thu, 16 Jan 2025 03:57:16 -0500
X-MC-Unique: pzuSx4xlO0eq7B5qTNObAw-1
X-Mimecast-MFC-AGG-ID: pzuSx4xlO0eq7B5qTNObAw
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-467a0a6c846so17023871cf.1
        for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 00:57:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737017836; x=1737622636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pmkLmsyIcPYmFuaESsfI5oPSmcbmJsLv+8kU8eWcxJk=;
        b=LtGwO89DsyaURlAEvjD8DnQY1LuW/K799MWDxZyf0PVjZ3FRMivie6sMETWf4eHCHD
         gEwamgXkcD9K48NNUFBcPDFPuX5eHmfquUHPTCTmyia2gdhHbwAV793N2gdWYd8Pjozc
         fU6TDQqkx/LrVankmhMiiiPt5N0r+t8XIQu6ic0MJ49AveuIbsNKwBL2sZrzR2lkJ1lH
         Cm/cwpxszlBHWdB+NjhpoFoQ0z8Ea2usAcVLSlsjRj4tGEwOcR3VyVGRqPF4PX/IUKmc
         Yd9Hf4tv1XXEQxFc5cTtdP6JwX4SqB2qzaOAOgGPjxIImA0kiZVEcGFfHXVS1bRMR5iq
         4uAw==
X-Forwarded-Encrypted: i=1; AJvYcCXOsDhCmcNShscyT9rdDA4HC8uYVU2ICRiRHfaFcA96Y3apVO26DQY+8BXl72IxYnm/fcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8hrgw4IzrYWZY5V+6n7hW/RKDE4BnO8x3px3k+oEBC157arYY
	aTmZQ9sCLrsnemirdhZmRv8xNW9QeIEWFQSTWDZv4GR4jiluEIqpKQttAJVonJfPfVetB30fytr
	qfNKObtopCUVqtdcH3HM84NTSOxDhk2LlE2++NYKDXQI0onzruw==
X-Gm-Gg: ASbGncud8OLqRZwjzM9VJ1DrD2c+ZMLHJHSwYPk+aZFq7UWl2fZFph92w5ywrcYyhjV
	Q4iyGY4nzN8xeRwFXRD2POznqTXA/k86q5nloxQc1kTJ1CN7Jx8i/9tDfleJBt0Lw6D4OkxlBkf
	w2IObpmBwcSdondMYoa5uARm5lbcvelCzP9jJbWzTlz/GS/IGhg209tQvxGjM6F7QaNJm9x0Wg6
	r/TcKB6vcB+vWIwiv5hzAKLGuE8SVLBSiLaceNQZ6BXf2Jkir7+guW9zCLYpNluBFPV0qz/2So8
	PczHCwAQ45dH5uTX92aq1qN/EzskOjaY
X-Received: by 2002:ac8:5813:0:b0:466:aee5:a5b with SMTP id d75a77b69052e-46c70fd1faemr467248011cf.10.1737017836157;
        Thu, 16 Jan 2025 00:57:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEO29yrvkRyeFaWTkkTVXxmLbJIQYKA6Cnx5MRQ30jCm4qRaBjl6Z9IlhJpdMAezqnYQnnKAw==
X-Received: by 2002:ac8:5813:0:b0:466:aee5:a5b with SMTP id d75a77b69052e-46c70fd1faemr467247821cf.10.1737017835757;
        Thu, 16 Jan 2025 00:57:15 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-100.retail.telecomitalia.it. [82.53.134.100])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46c873216dbsm73689241cf.7.2025.01.16.00.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 00:57:15 -0800 (PST)
Date: Thu, 16 Jan 2025 09:57:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luigi Leonardi <leonardi@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Wongi Lee <qwerty@theori.io>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Eric Dumazet <edumazet@google.com>, kvm@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Simon Horman <horms@kernel.org>, Hyunwoo Kim <v4bel@theori.io>, 
	Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/5] vsock/virtio: discard packets if the
 transport changes
Message-ID: <pl4mhcim7v3ukv6eseynh6x2r6nftf7yuayjzd3ftyupwy5r2h@ixmlevubqzb2>
References: <1aa83abf-6baa-4cf1-a108-66b677bcfd93@rbox.co>
 <nedvcylhjxrkmkvgugsku2lpdjgjpo5exoke4o6clxcxh64s3i@jkjnvngazr5v>
 <CAGxU2F7BoMNi-z=SHsmCV5+99=CxHo4dxFeJnJ5=q9X=CM3QMA@mail.gmail.com>
 <cccb1a4f-5495-4db1-801e-eca211b757c3@rbox.co>
 <nzpj4hc6m4jlqhcwv6ngmozl3hcoxr6kehoia4dps7jytxf6df@iqglusiqrm5n>
 <903dd624-44e5-4792-8aac-0eaaf1e675c5@rbox.co>
 <5nkibw33isxiw57jmoaadizo3m2p76ve6zioumlu2z2nh5lwck@xodwiv56zrou>
 <7de34054-10cf-45d0-a869-adebb77ad913@rbox.co>
 <n2itoh23kikzszzgmyejfwe3mdf6fmxzwbtyo5ahtxpaco3euq@osupldmckz7p>
 <fb6f876f-a4eb-4005-bd76-fff0632291b8@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fb6f876f-a4eb-4005-bd76-fff0632291b8@rbox.co>

On Tue, Jan 14, 2025 at 05:31:08PM +0100, Michal Luczaj wrote:
>On 1/14/25 11:16, Stefano Garzarella wrote:
>> On Tue, Jan 14, 2025 at 01:09:24AM +0100, Michal Luczaj wrote:
>>> On 1/13/25 16:01, Stefano Garzarella wrote:
>>>> On Mon, Jan 13, 2025 at 02:51:58PM +0100, Michal Luczaj wrote:
>>>>> On 1/13/25 12:05, Stefano Garzarella wrote:
>>>>>> ...
>>>>>> An alternative approach, which would perhaps allow us to avoid all this,
>>>>>> is to re-insert the socket in the unbound list after calling release()
>>>>>> when we deassign the transport.
>>>>>>
>>>>>> WDYT?
>>>>>
>>>>> If we can't keep the old state (sk_state, transport, etc) on failed
>>>>> re-connect() then reverting back to initial state sounds, uhh, like an
>>>>> option :) I'm not sure how well this aligns with (user's expectations of)
>>>>> good ol' socket API, but maybe that train has already left.
>>>>
>>>> We really want to behave as similar as possible with the other sockets,
>>>> like AF_INET, so I would try to continue toward that train.
>>>
>>> I was worried that such connect()/transport error handling may have some
>>> user visible side effects, but I guess I was wrong. I mean you can still
>>> reach a sk_state=TCP_LISTEN with a transport assigned[1], but perhaps
>>> that's a different issue.
>>>
>>> I've tried your suggestion on top of this series. Passes the tests.
>>
>> Great, thanks!
>>
>>>
>>> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>>> index fa9d1b49599b..4718fe86689d 100644
>>> --- a/net/vmw_vsock/af_vsock.c
>>> +++ b/net/vmw_vsock/af_vsock.c
>>> @@ -492,6 +492,10 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>>> 		vsk->transport->release(vsk);
>>> 		vsock_deassign_transport(vsk);
>>>
>>> +		vsock_addr_unbind(&vsk->local_addr);
>>> +		vsock_addr_unbind(&vsk->remote_addr);
>>
>> My only doubt is that if a user did a specific bind() before the
>> connect, this way we're resetting everything, is that right?
>
>That is right.
>
>But we aren't changing much. Transport release already removes vsk from
>vsock_bound_sockets. So even though vsk->local_addr is untouched (i.e.
>vsock_addr_bound() returns `true`), vsk can't be picked by
>vsock_find_bound_socket(). User can't bind() it again, either.

Okay, I see, so maybe for now makes sense to merge your patch, to fix 
the UAF fist.

>
>And when patched as above: bind() works as "expected", but socket is pretty
>much useless, anyway. If I'm correct, the first failing connect() trips
>virtio_transport_recv_connecting(), which sets `sk->sk_err`. I don't see it
>being reset. Does the vsock suppose to keep sk_err state once set?

Nope, I think this is another thing to fix.

>
>Currently only AF_VSOCK throws ConnectionResetError:
>```
>from socket import *
>
>def test(family, addr):
>	s = socket(family, SOCK_STREAM)
>	assert s.connect_ex(addr) != 0
>
>	lis = socket(family, SOCK_STREAM)
>	lis.bind(addr)
>	lis.listen()
>	s.connect(addr)
>
>	p, _ = lis.accept()
>	p.send(b'x')
>	assert s.recv(1) == b'x'
>
>test(AF_INET, ('127.0.0.1', 2000))
>test(AF_UNIX, '\0/tmp/foo')
>test(AF_VSOCK, (1, 2000)) # VMADDR_CID_LOCAL
>```
>
>> Maybe we need to look better at the release, and prevent it from
>> removing the socket from the lists as you suggested, maybe adding a
>> function in af_vsock.c that all transports can call.
>
>I'd be happy to submit a proper patch, but it would be helpful to decide
>how close to AF_INET/AF_UNIX's behaviour is close enough. Or would you
>rather have that UAF plugged first?
>

I'd say, let's fix the UAF first, then fix the behaviour (also in a
single series, but I prefer 2 separate patches if possible).
About that, AF_VSOCK was started with the goal of following AF_INET as
closely as possible, and the test suite should serve that as well, so if
we can solve this problem and get closer to AF_INET, possibly even
adding a dedicated test, that would be ideal!

Thank you very much for the help!
Stefano


