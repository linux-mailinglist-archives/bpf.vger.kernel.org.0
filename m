Return-Path: <bpf+bounces-22876-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF5186B1EB
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 15:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A28A28873D
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 14:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52740159562;
	Wed, 28 Feb 2024 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XbXWy3+r"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120E214EFCD
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131001; cv=none; b=jaVqfOop+T66uhSgWei8yMjfBz1qPNvNTCGLawXb6nQPgDor2GtmVck+QEzwb2vlsh6ZaeMqwstjHAFQNpCeQ86BRhzT4FdDW9mGXVZ7IEswoxv6MoUuQGoH6tnbeO6nY/fWEKXVONjY2EOQDgFoO+DLChQP45XBpEcuJzEKP/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131001; c=relaxed/simple;
	bh=Xxb5FVp/NoNytGsrFLD77UfzlXJXbuuyyr2in+lym4M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uROCYs+25kCSWiqQYX7LGlajGdyZFNsvZVfrQN9N1wH1093JD2vWXD4NGL8YRsDord6Ypyqkfq55JhBNYCIXpdVnpkTRTBNV5IyymEoXGVVJr6yLSkcCINoqt8cwa4CE4joBhBAevy4+zfHsdthrFPEMMSb2MandTnPd6AiGLXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XbXWy3+r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709130998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xxb5FVp/NoNytGsrFLD77UfzlXJXbuuyyr2in+lym4M=;
	b=XbXWy3+rMerkt1p1Y6evoPfVkqxyTF+8VxnNKzo/RmHJgFQl8rTTYQk3HKWHGo2tmcjg/d
	9H4BdxGhLREv0WuoBxRMS68kVeZ6ALtYLHtfkORhsNEcHhRhA2bt4O7bndUqQJNuJRra2C
	y98euQ1lLzP4NiENKsEjN5z+0xaKfqg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-lDAdJUikPs2bTll6t67PdA-1; Wed, 28 Feb 2024 09:36:37 -0500
X-MC-Unique: lDAdJUikPs2bTll6t67PdA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a3e42733561so247514666b.0
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 06:36:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709130996; x=1709735796;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xxb5FVp/NoNytGsrFLD77UfzlXJXbuuyyr2in+lym4M=;
        b=xUQUYlyKqQHru31VpcWstvgVTY4V+k0TBRbgxwmfL2NErVqiXGQknON5E9mvB+N/Tb
         cmcEN+Jiw9vuQ+8P6dlNAZ7lQj4AAkOojj4oL96nWdm/xbJjC7IpTj4dymsnmX2WEb45
         vZLgY2ASzVqhf5IxRsV5Ahx1R2M3Xf5ykNLbwxAJf0zMrQBxXXrsXZyhUEVrGAIw7Vv0
         8RztUqAgQxT4cwr1XDwT/zySBlP+yiLDUhzf05FByar4a17b2UwhjKjT/Qb1jWKftHq7
         ISOWmjMwWa4wcXbH7ecLHnnMlzt5p14tL961dKGyCqeqcLEpKt04vJYI1etgojsfcbg7
         clLQ==
X-Forwarded-Encrypted: i=1; AJvYcCURNwLGO2m0lKgLAMSftUBtFqMle/UVHJVMH95k+M4XRa4WKY/uw9j3F9Z4FquxJiTktj1/a6jSDwzm4fwvtFBjnpQT
X-Gm-Message-State: AOJu0Yypg84OmL/9uAxx+iv5yiAmZMzt5rL0Is13K0rhkkcpK504i2lA
	Ckl+5rscJnu8Nmuilumu1lpaqZQzOVCUgFol8uhfcGyVnyUfK3+oLHw9XDxIVAzXtDEhUgg0zxT
	3E96qDOsS0CzAKd8LiXUII0gVpTC982z5/CAH3/aXNTzOioHnWA==
X-Received: by 2002:a17:906:150b:b0:a3f:d742:f353 with SMTP id b11-20020a170906150b00b00a3fd742f353mr9165849ejd.57.1709130996278;
        Wed, 28 Feb 2024 06:36:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBUb4fVMqvQR+JrNV/Qt3//XwuekRLgoQvwiqLvpKOvm/74mS+02hNSBehoyTs9R4BM94+Tw==
X-Received: by 2002:a17:906:150b:b0:a3f:d742:f353 with SMTP id b11-20020a170906150b00b00a3fd742f353mr9165832ejd.57.1709130995891;
        Wed, 28 Feb 2024 06:36:35 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id vg15-20020a170907d30f00b00a4319de07c6sm1896089ejc.127.2024.02.28.06.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 06:36:35 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id ECAED112E73A; Wed, 28 Feb 2024 15:36:34 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung
 <ameryhung@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] bpf qdisc
In-Reply-To: <CAP01T76R0bqdNK+LkObuVTej_TRwEB9HnvwJaTTsRrr1Y8_WmA@mail.gmail.com>
References: <CAMB2axOYHKLQhR9b50oVgvUDXeo573amqpiXRot51_JZQcFuiw@mail.gmail.com>
 <CAP01T76R0bqdNK+LkObuVTej_TRwEB9HnvwJaTTsRrr1Y8_WmA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 28 Feb 2024 15:36:34 +0100
Message-ID: <878r34ejv1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Mon, 26 Feb 2024 at 19:04, Amery Hung <ameryhung@gmail.com> wrote:
>>
>> Hi all,
>>
>> I would like to discuss bpf qdisc in the BPF track. As we now try to
>> support bpf qdisc using struct_ops, we found some limitations of
>> bpf/struct_ops. While some have been discussed briefly on the mailing
>> list, we can discuss in more detail to make struct_ops a more
>> generic/palatable approach to replace kernel functions.
>>
>> In addition, I would like to discuss supporting adding kernel objects
>> to bpf_list/rbtree, which may have performance benefits in some
>> applications and can improve the programming experience. The current
>> bpf fq in the RFC has a 6% throughput loss compared to the native
>> counterpart due to memory allocation in enqueue() to store skb kptr.
>> With a POC I wrote that allows adding skb to bpf_list, the throughput
>> becomes comparable. We can discuss the approach and other potential
>> use cases.
>>
>
> When discussing this with Toke (Cc'd) long ago for the XDP queueing
> patch set, we discussed the same thing, in that the sk_buff already
> has space for a list or rbnode due to it getting queued in other
> layers (TCP OoO queue, qdiscs, etc.) so it would make sense to teach
> the verifier that it is a valid bpf_list_node and bpf_rb_node and
> allow inserting it as an element into a BPF list or rbtree. Back then
> we didn't add that as the posting only used the PIFO map.
>
> I think not only sk_buff, you can do a similar thing with xdp_buff as
> well.

Yeah, I agree that allowing skbs to be inserted directly into a BPF
rbtree would make a lot of sense if it can be done safely. I am less
sure about xdp_frames, mostly for performance reasons, but if it does
turn out to be useful whichever mechanism we add for skbs should be
fairly straight forward to reuse.

> The verifier side changes should be fairly minimal, just allowing the
> use of a known kernel type as the contained object in a list or
> rbtree, and the field pointing to this allowlisted list or rbnode.

I think one additional concern here is how we ensure that an skb has
been correctly removed from any rbtrees it sits in before it is being
transmitted to another part of the stack?

-Toke


