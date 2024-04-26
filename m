Return-Path: <bpf+bounces-27889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D38158B2F9D
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 06:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9715B222DF
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 04:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B0213A279;
	Fri, 26 Apr 2024 04:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pZLFqUFT"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD8F762EF
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 04:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714107542; cv=none; b=Sr2YbNDoerPV3vBPclucf9bS14Q8XWKzEb0mWpuMmojkn9j+dufhuSnSuGlbAYqFahdwH2bk264JAUfQioKg1X38hxq1Zq0jZOwvimAaaxCFc8iGrQUjZNmFw4WAtiNBEtD7AP8DWAzCUrFxH0WmGOFe0ky9LuDb1nHVDqOqvsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714107542; c=relaxed/simple;
	bh=d3KmDmp/3dmubANe+l1+bNRnUChLWKM23acflPULoUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i18jGGN4JQ6nstI5zCCKuEX+C5zfcPGAHqUr4hvYOEdq6zpgvIrDwYSmGESRw+QfoJ0hyEf7ApXpCsZJI4Tkwi+uiPwEL4cYxg08Cxj0JYroVSeRRlreW/fogWMY0sKGeiMGizUgW6vfXo7W1vbTQaTKuKlZ4t3ceeVBFOUMNfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pZLFqUFT; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <840ddcb4-acaa-4ce4-ad56-e2d14b447907@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714107538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=djOZafUyrrq9V8xkvWbRVjEsaKg7oC8Pb5wsRAwbtL4=;
	b=pZLFqUFTypSQywrdzl7e4BPh62DtVR8OpL+ZLy1jgs55uNXOAHLhOOqRHVYCps0YlT5G6s
	Hltj3DqdiU6hnHAUiAwdpZbHIEkw03sqaaLzxx7KRYa0cdHHyjVzGStYymeew9EmcNaaQz
	vouPRb7v9/HHg9cHjyYXzWZNMj6K9zg=
Date: Thu, 25 Apr 2024 21:58:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH net-next 0/5] net: In-kernel QUIC implementation with
 Userspace handshake
To: Xin Long <lucien.xin@gmail.com>, Stefan Metzmacher <metze@samba.org>
Cc: network dev <netdev@vger.kernel.org>, davem@davemloft.net,
 kuba@kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Steve French <smfrench@gmail.com>,
 Namjae Jeon <linkinjeon@kernel.org>, Chuck Lever III
 <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, Tyler Fanelli <tfanelli@redhat.com>,
 Pengtao He <hepengtao@xiaomi.com>,
 "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
 Samba Technical <samba-technical@lists.samba.org>, bpf <bpf@vger.kernel.org>
References: <cover.1710173427.git.lucien.xin@gmail.com>
 <74d5db09-6b5c-4054-b9d3-542f34769083@samba.org>
 <CADvbK_dzVcDKsJ9RN9oc0K1Jwd+kYjxgE6q=ioRbVGhJx7Qznw@mail.gmail.com>
 <f427b422-6cfc-45ac-88eb-3e7694168b63@samba.org>
 <CADvbK_cA-RCLiUUWkyNsS=4OhkWrUWb68QLg28yO2=8PqNuGBQ@mail.gmail.com>
 <438496a6-7f90-403d-9558-4a813e842540@samba.org>
 <CADvbK_fkbOnhKL+Rb+pp+NF+VzppOQ68c=nk_6MSNjM_dxpCoQ@mail.gmail.com>
 <1456b69c-4ffd-4a08-b120-6a00abf1eb05@samba.org>
 <CADvbK_cQRpyzHG4UUOzfgmqLndvpx5Cd+d59rrqGRp0ic3PyxA@mail.gmail.com>
 <95922a2f-07a1-4555-acd2-c745e59bcb8e@samba.org>
 <CADvbK_eR4++HbR_RncjV9N__M-uTHtmqcC+_Of1RKVw7Uqf9Cw@mail.gmail.com>
 <CADvbK_dEWNNA_i1maRk4cmAB_uk4G4x0eZfZbrVX=zJ+2H9o_A@mail.gmail.com>
 <dc3815af-5b46-452b-8bcc-30a0934740a2@samba.org>
 <CADvbK_e7i08GAiOenJNTP_m+-MeYjSf7J-vkF+hgRfYGNCjkwQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CADvbK_e7i08GAiOenJNTP_m+-MeYjSf7J-vkF+hgRfYGNCjkwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/22/24 1:58 PM, Xin Long wrote:
> On Sun, Apr 21, 2024 at 3:27 PM Stefan Metzmacher <metze@samba.org> wrote:
>>
>> Am 20.04.24 um 21:32 schrieb Xin Long:
>>> On Fri, Apr 19, 2024 at 3:19 PM Xin Long <lucien.xin@gmail.com> wrote:
>>>>
>>>> On Fri, Apr 19, 2024 at 2:51 PM Stefan Metzmacher <metze@samba.org> wrote:
>>>>>
>>>>> Hi Xin Long,
>>>>>
>>>>>>> But I think its unavoidable for the ALPN and SNI fields on
>>>>>>> the server side. As every service tries to use udp port 443
>>>>>>> and somehow that needs to be shared if multiple services want to
>>>>>>> use it.
>>>>>>>
>>>>>>> I guess on the acceptor side we would need to somehow detach low level
>>>>>>> udp struct sock from the logical listen struct sock.
>>>>>>>
>>>>>>> And quic_do_listen_rcv() would need to find the correct logical listening
>>>>>>> socket and call quic_request_sock_enqueue() on the logical socket
>>>>>>> not the lowlevel udo socket. The same for all stuff happening after
>>>>>>> quic_request_sock_enqueue() at the end of quic_do_listen_rcv.
>>>>>>>
>>>>>> The implementation allows one low level UDP sock to serve for multiple
>>>>>> QUIC socks.
>>>>>>
>>>>>> Currently, if your 3 quic applications listen to the same address:port
>>>>>> with SO_REUSEPORT socket option set, the incoming connection will choose
>>>>>> one of your applications randomly with hash(client_addr+port) vi
>>>>>> reuseport_select_sock() in quic_sock_lookup().
>>>>>>
>>>>>> It should be easy to do a further match with ALPN between these 3 quic
>>>>>> socks that listens to the same address:port to get the right quic sock,
>>>>>> instead of that randomly choosing.
>>>>>
>>>>> Ah, that sounds good.
>>>>>
>>>>>> The problem is to parse the TLS Client_Hello message to get the ALPN in
>>>>>> quic_sock_lookup(), which is not a proper thing to do in kernel, and
>>>>>> might be rejected by networking maintainers, I need to check with them.
>>>>>
>>>>> Is the reassembling of CRYPTO frames done in the kernel or
>>>>> userspace? Can you point me to the place in the code?
>>>> In quic_inq_handshake_tail() in kernel, for Client Initial packet
>>>> is processed when calling accept(), this is the path:
>>>>
>>>> quic_accept()-> quic_accept_sock_init() -> quic_packet_process() ->
>>>> quic_packet_handshake_process() -> quic_frame_process() ->
>>>> quic_frame_crypto_process() -> quic_inq_handshake_tail().
>>>>
>>>> Note that it's with the accept sock, not the listen sock.
>>>>
>>>>>
>>>>> If it's really impossible to do in C code maybe
>>>>> registering a bpf function in order to allow a listener
>>>>> to check the intial quic packet and decide if it wants to serve
>>>>> that connection would be possible as last resort?
>>>> That's a smart idea! man.
>>>> I think the bpf hook in reuseport_select_sock() is meant to do such
>>>> selection.
>>>>
>>>> For the Client initial packet (the only packet you need to handle),
>>>> I double you will need to do the reassembling, as Client Hello TLS message
>>>> is always less than 400 byte in my env.
>>>>
>>>> But I think you need to do the decryption for the Client initial packet
>>>> before decoding it then parsing the TLS message from its crypto frame.
>>> I created this patch:
>>>
>>> https://github.com/lxin/quic/commit/aee0b7c77df3f39941f98bb901c73fdc560befb8
>>>
>>> to do this decryption in quic_sock_look() before calling
>>> reuseport_select_sock(), so that it provides the bpf selector with
>>> a plain-text QUIC initial packet:
>>>
>>> https://datatracker.ietf.org/doc/html/rfc9000#section-17.2.2
>>>
>>> If it's complex for you to do the decryption for the initial packet in
>>> the bpf selector, I will apply this patch. Please let me know.
>>
>> I guess in addition to quic_server_handshake(), which is called
>> after accept(), there should be quic_server_prepare_listen()
>> (and something similar for in kernel servers) that setup the reuseport
>> magic for the socket, so that it's not needed in every application.
> It's done when calling listen(), see quic_inet_listen()->quic_hash()
> where only listening sockets with its sk_reuseport set will be
> added into the reuseport group.
> 
> It means SO_REUSEPORT sockopt must be set for every socket
> before calling listen().
> 
>>
>> It seems there is only a single ebpf program possible per
>> reuseport group, so there has to be just a single one.
> Yes, a single ebpf program per reuseport group should work.
> see prepare_sk_fds() in kernel selftests for select_reuseport bfp.
> 
>>
>> But is it possible for in kernel servers to also register an epbf program?
> Good question. TBH, I don't really know much about epbf programming.
> I guess the real problem is how you pass the .o file to kernel space?
> 
> Another question is, in the selftests:
> tools/testing/selftests/bpf/prog_tests/s
> tools/testing/selftests/bpf/progs/test_select_reuseport_kern.c
> 
> it created a global reuseport_array, and then added these sockets
> into this array for the later lookup, but these sockets are all created
> in the same process.
> 
> But your case is that the sockets are created in different processes.
> I'm not sure if it's possible to add sockets from different processes
> into the same reuseport_array?
> 
> Added Martin who introduced BPF_PROG_TYPE_SK_REUSEPORT,
> I guess he may know the answers.

I didn't read the patchset, so I don't know what wanted to be done.

 From capturing the questions in this and next email:

the reuseport_array is a bpf map. Like any bpf map, it can be shared across
different processes. Meaning different processes can add sk to the map.

The bpf prog that selects a sk from the reuseport_array is set by the userspace 
through setsockopt(SO_ATTACH_REUSEPORT_EBPF). It is the only way right now, iirc.

If you can summarize what want to be done, it could help to see if there
are ways that work for the use case.


> 
> Thanks.
> 


