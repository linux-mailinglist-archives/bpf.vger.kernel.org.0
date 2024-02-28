Return-Path: <bpf+bounces-22948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E3386BBE0
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4DB1F258D0
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A581137747;
	Wed, 28 Feb 2024 23:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOpY0GiY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D55137741
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 23:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161320; cv=none; b=I+l/gTk95RQgLpKf9tyVOzgQUcoVuroelkP6tymU6jvXvWxZfz7dcMoQFbOlDIOCIpcwOQbizmSNGjcG87+TnV/BMjOEV64umTEMYT713wj2X3uouN8BKhgakdTTPgLdc/d0t49M07m5u3QxHIt5f2KzPg9G/w6QlXibdpZ1paM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161320; c=relaxed/simple;
	bh=fPozPKRTZRKK6/r0eK2jw8majAEK83bwZXth+bqp038=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MS1P0B1+NFueciEqCXp/ePrwrYZ8yxs7yle/QB+VEQwFJXX9cEluP247lEqiL6OPa0Qi9gWRtQKw+sSMQCaR7F/Wkdp0SMwTXb0FRwP8QBWbb7Ol/S3SKgmWjc4p/zn0HV05qzVjcLiBs58wmmHQ02XLGe3fVhR5sVl5EOn88/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOpY0GiY; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc745927098so292683276.3
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 15:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709161318; x=1709766118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPozPKRTZRKK6/r0eK2jw8majAEK83bwZXth+bqp038=;
        b=FOpY0GiYsxc/7iGueh2xm/FWjOQFKWBpnCVcHFfQYhau4F6xwwwyJ8o63/QMLt2LYp
         zntYnqGKtKoWPhOfoNUgGgEXyP51W8khuhkLGp4dp48zGsZDj4jSzG/kX6T6jTxfO0HN
         AOxrjNyxwE5V+KFU+hss/dE8xBCTkKIW0TyGu6LeweCl4uizqbBQPOBFKml9M3aldV6e
         yA6EjwqQJh+xZnEpOKK/NN9b0KGf3AGXln/q09L8oOQ7uLdkmxUjnRDgbB+loc4KdcVG
         9ZqeDoEwPy1fSP92dDWnL4SWzLYmF7RO77Q0AypMhPtq68gSEz1Rkeqr69x9qWMKttOF
         3f0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709161318; x=1709766118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPozPKRTZRKK6/r0eK2jw8majAEK83bwZXth+bqp038=;
        b=DAjMa+KYV6dY8jex4646c2Ax8tHABxH+5lzYz9N5wfalrlhq+hCLMkdJA+qVwMRZVA
         ZjuRWAMwyVSgLArF15Hr0q6A63d5AtAoOUVsk4GyDu+WJYxhvCKljWLMFgVVFmq5d1Eo
         EtHnyWy8azhLztR1aHlZaCluW2mx60nGKr4X1CwM/s5viwed0NgyprVKDiy2VhGQcVC9
         GQUMFUYDIh4YC4NM+Nu0JUCFYNcOJssMxX1wyxhr/ByKKlbw59zJ8ZBSu6oDyufTObL+
         btRqVdJNtqNwf1sC4nJGaSylpx1mf2z8eIfzeHse69opcWN9uRbeBjrSYqp6ZHiIIGBu
         QA4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQmc7XhMuogoTcP8gVwLpWqrhtAaCqNeoXVRpv3jaZm6kmD68LXINvX/PbyoaSPCpVdIgh9RMBLezifQ8JvxbqSH7R
X-Gm-Message-State: AOJu0YydcKYj5Gg3O+scI6ba34s77wn39NWvsfkiRtnu/LY1yKCf2jK/
	bxQJakp+5IxagTL745nVD872SLaeYuGrkepL53v8BqoHM8Fi3YbZfpsFex34jqdLFGTz7AKFXlC
	i0cbikv6IYW2u4tlrrcOMUzitNbg=
X-Google-Smtp-Source: AGHT+IG5I3cFnqMTi0DfFajOVIgyCFFLKcrIPKrU6TAuVjbfUiGJrGXSfHSvonfQOZwY1EyXlu/ofmdO64QJH6uSo4Y=
X-Received: by 2002:a25:eb09:0:b0:dc7:5a73:184e with SMTP id
 d9-20020a25eb09000000b00dc75a73184emr704885ybs.14.1709161318163; Wed, 28 Feb
 2024 15:01:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMB2axOYHKLQhR9b50oVgvUDXeo573amqpiXRot51_JZQcFuiw@mail.gmail.com>
 <CAP01T76R0bqdNK+LkObuVTej_TRwEB9HnvwJaTTsRrr1Y8_WmA@mail.gmail.com> <878r34ejv1.fsf@toke.dk>
In-Reply-To: <878r34ejv1.fsf@toke.dk>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 28 Feb 2024 15:01:47 -0800
Message-ID: <CAMB2axO3B-ziNt9AFM+Xkr1H0WQzzhaThi1PO-xKcGP3cNtxQQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] bpf qdisc
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, lsf-pc@lists.linux-foundation.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 6:36=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgensen <t=
oke@redhat.com> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> > On Mon, 26 Feb 2024 at 19:04, Amery Hung <ameryhung@gmail.com> wrote:
> >>
> >> Hi all,
> >>
> >> I would like to discuss bpf qdisc in the BPF track. As we now try to
> >> support bpf qdisc using struct_ops, we found some limitations of
> >> bpf/struct_ops. While some have been discussed briefly on the mailing
> >> list, we can discuss in more detail to make struct_ops a more
> >> generic/palatable approach to replace kernel functions.
> >>
> >> In addition, I would like to discuss supporting adding kernel objects
> >> to bpf_list/rbtree, which may have performance benefits in some
> >> applications and can improve the programming experience. The current
> >> bpf fq in the RFC has a 6% throughput loss compared to the native
> >> counterpart due to memory allocation in enqueue() to store skb kptr.
> >> With a POC I wrote that allows adding skb to bpf_list, the throughput
> >> becomes comparable. We can discuss the approach and other potential
> >> use cases.
> >>
> >
> > When discussing this with Toke (Cc'd) long ago for the XDP queueing
> > patch set, we discussed the same thing, in that the sk_buff already
> > has space for a list or rbnode due to it getting queued in other
> > layers (TCP OoO queue, qdiscs, etc.) so it would make sense to teach
> > the verifier that it is a valid bpf_list_node and bpf_rb_node and
> > allow inserting it as an element into a BPF list or rbtree. Back then
> > we didn't add that as the posting only used the PIFO map.
> >
> > I think not only sk_buff, you can do a similar thing with xdp_buff as
> > well.
>
> Yeah, I agree that allowing skbs to be inserted directly into a BPF
> rbtree would make a lot of sense if it can be done safely. I am less
> sure about xdp_frames, mostly for performance reasons, but if it does
> turn out to be useful whichever mechanism we add for skbs should be
> fairly straight forward to reuse.
>
> > The verifier side changes should be fairly minimal, just allowing the
> > use of a known kernel type as the contained object in a list or
> > rbtree, and the field pointing to this allowlisted list or rbnode.
>
> I think one additional concern here is how we ensure that an skb has
> been correctly removed from any rbtrees it sits in before it is being
> transmitted to another part of the stack?

I think one solution is to disallow shared ownership of skb in
multiple lists or rbtrees. That is, users should not be able to
acquire the reference of an skb from the ctx more than once in
".enqueue" or using bpf_refcount_acquire().

>
> -Toke
>

