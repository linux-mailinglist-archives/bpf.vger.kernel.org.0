Return-Path: <bpf+bounces-75083-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0ADC6FABD
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 16:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A46C4F860D
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 15:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E82525B311;
	Wed, 19 Nov 2025 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="AkjhWRWJ"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87A42C08CD;
	Wed, 19 Nov 2025 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763565931; cv=none; b=rds4t8i+ewyl3raO+Itg7D53io2F5OXUhw+zvFcWceuc2afhm2rR4xj3gAX6Ue5QeD3tuZqBna9HOLALSTcGmHxou78rCOQy7fOgvpebbp/4doMW3lcFu4C+Cp3jvOu5y2maGT+6oQZuBFDPa1hjLWUb6HhZJZYGXNYl1k0IlXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763565931; c=relaxed/simple;
	bh=/lm3D/t8RucZMw6LEUlzR9tkbbE5ViBMVXNNeF0jkPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d40Eh6NXbhdAeuNdaSLYq4egyD345d3+gGxfeGoZrPY7Ud9c4BQPjwSmbNQsWqkksI/8otVu8TcAF3CgNTjWaZxXYxSVZFwSs7JmSjz+aQt36YK2kqg1HhJNU6Kfdqtyum+Y5H00N5bmg7MT2OMWaUPjBFeM3OZ7Ijwfx+doGGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=AkjhWRWJ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/cQ90ymvJBRWE2biPSf/gxrsEHs5FH2HkQgu5nyu+eo=; b=AkjhWRWJ85RY4KyKzR+1p5Qt9d
	nPzWM8T5p4ihZuEr9RpNCvHMD0UffHxxosOYCFwOBLtVjJjTpVw0jQhbMuFG8vHlsjzeB/yAaGCP7
	H8xtO6NV/akRVlavZWsHFcXwsUdkJbZeHvwmjoLfwol5GdCxSMvkRUxrh77Gm78dbB5X6vnRKEcHZ
	elW3Aegb41H+lxLkYK4XacDbevlm0VytvKmIbzyhFN/7/cKRl5g8QdHHnJx93bOJafQHaAr8rj7ga
	JoMxwMoNv80oqAA6sdeglpmfUMEPVofrt9iHa1uUjbAZ29UeGtFu89HgX/lNmVee3BegF/Xlb12r5
	DuCEwD5w==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1vLjch-0006DF-1l;
	Wed, 19 Nov 2025 15:57:31 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1vLjcg-000GBY-0O;
	Wed, 19 Nov 2025 15:57:30 +0100
Message-ID: <2372a3b8-9bb2-4c53-9029-9bd03f56b98a@iogearbox.net>
Date: Wed, 19 Nov 2025 15:57:29 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 01/14] net: Add bind-queue operation
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251031212103.310683-1-daniel@iogearbox.net>
 <20251031212103.310683-2-daniel@iogearbox.net>
 <20251106163948.0d0d7d54@kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20251106163948.0d0d7d54@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.0.9/27825/Wed Nov 19 10:10:02 2025)

Hi Jakub,

On 11/7/25 1:39 AM, Jakub Kicinski wrote:
> On Fri, 31 Oct 2025 22:20:50 +0100 Daniel Borkmann wrote:
>> From: David Wei <dw@davidwei.uk>
>>
>> Add a ynl netdev family operation called bind-queue that creates a new
>> rx queue in a virtual netdev (i.e. netkit or veth) and binds it to an rx
>> queue in a real netdev.
> 
> bind is already used in context of queues to attach devmem.
> Having bind-rx, bind-tx == devmem, and bind-queue something else
> is not great. Plus well-named ops have the object first.
> 
> Can we call this op queue-create ?
> 
> It is creating a queue on the netkit, we can wrap the other params
> into a nest called "lease". Once / if we get to dynamic queue creation
> on real netdevs we can reuse it (presumably then lack of "lease" will
> then imply that we need a real queue to be allocated).
> 
>> This forms a queue pair, where the peer queue of
> 
> "queue pair" means Rx+Tx, please do not reuse terms like this.

Ok, yeah lets switch everything to 'lease', sgtm.

>> the pair in the virtual netdev acts as a proxy for the peer queue in the
>> real netdev. Thus, the peer queue in the virtual netdev can be used by
>> processes running in a container to use both memory providers (io_uring
>> zero-copy rx and devmem) and AF_XDP. An early implementation had only
>> driver-specific integration [0], but in order for other virtual devices
>> to reuse, it makes sense to have this as a generic API.
> 
>> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
>> index e00d3fa1c152..1e24c7f76de0 100644
>> --- a/Documentation/netlink/specs/netdev.yaml
>> +++ b/Documentation/netlink/specs/netdev.yaml
>> @@ -561,6 +561,46 @@ attribute-sets:
>>           type: u32
>>           checks:
>>             min: 1
>> +  -
>> +    name: queue-pair
>> +    attributes:
> 
> No need to create a "real" attribute set for this.
> 
> Once the attrs are wrapped in a "lease" nest you'll need a single
> triplet, so make this a subset-of: queue (see the queue-id set).
> name: ifc-queue-id ?

Does the below rework look reasonable to you in terms of netdev spec?

I do like the queue-create as it's generic and can be reused in future.
As you said, we'll make the lease a nested attribute there and in future
queue-create can be reused without it.

We could then also reuse the same for the queue-get operation, I'll still
add the netns-id to the 'lease' attribute set as well, and for 'queue-create'
we enforce that the 'netns-id' is not set in order to indicate to search
the ifindex in the current netns.

With the below its also clear that queue-create ifindex is always done
against the netkit device in our use-case and there's no ambiguity.

Thanks,
Daniel

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 82bf5cb2617d..b7278e8a167e 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -339,6 +339,11 @@ attribute-sets:
          doc: XSK information for this queue, if any.
          type: nest
          nested-attributes: xsk-info
+      -
+        name: lease
+        doc: tbd
+        type: nest
+        nested-attributes: lease
    -
      name: qstats
      doc: |
@@ -537,6 +542,20 @@ attribute-sets:
          name: id
        -
          name: type
+  -
+    name: lease
+    attributes:
+      -
+        name: ifindex
+        doc: netdev ifindex to lease the queue from.
+        type: u32
+        checks:
+          min: 1
+      -
+        name: queue
+        doc: netdev queue to lease from.
+        type: nest
+        nested-attributes: queue-id
    -
      name: dmabuf
      attributes:
@@ -684,6 +703,7 @@ operations:
              - dmabuf
              - io-uring
              - xsk
+            - lease
        dump:
          request:
            attributes:
@@ -795,6 +815,20 @@ operations:
          reply:
            attributes:
              - id
+    -
+      name: queue-create
+      doc: tbd
+      attribute-set: queue
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - ifindex
+            - type
+            - lease
+        reply: &queue-create-op
+          attributes:
+            - id
  
  kernel-family:
    headers: ["net/netdev_netlink.h"]


