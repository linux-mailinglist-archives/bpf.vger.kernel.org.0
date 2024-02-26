Return-Path: <bpf+bounces-22737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A59867F9A
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 19:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515CB1F24EB4
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 18:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF2512EBED;
	Mon, 26 Feb 2024 18:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyXD4dC2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528CA12C815
	for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708971076; cv=none; b=oKYgq9Coml4w4mD6ckLSdd/WwGEONqqmJIeG3hEkv4X8/0Twv7lyZviVbw4u8l3f/J3X89nNVCObm1uf7eYKJGPRX1TCnTzAz+jvcWeaNWvMdcjPKZalAXSvU7gaKu9lePW/BfpSX62ceAsKQTCF2WfNT1zYba4Mxi786smRY58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708971076; c=relaxed/simple;
	bh=Siz+e579qyyLmrEPjL1wgtPi8pF/VTeq9RDiFwMQ9QM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s6LNt6g35FJW6MagXM5S/Mwqe0Pf+HXdFVOI4tVD7eNgjQVS0ln0y8Xvvv3KR8Knl1AS04TElfzanmRQZaJ7wvuW425PTTkeK3sSKgc+YMUMhu0fDlAj/YS4J9INPttPv40c6n3NDfAq1LViLIK9Oyy5y8XE8TPK035YyRqOqco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyXD4dC2; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a3e7f7b3d95so381471766b.3
        for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 10:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708971074; x=1709575874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Siz+e579qyyLmrEPjL1wgtPi8pF/VTeq9RDiFwMQ9QM=;
        b=fyXD4dC2g7jVGj/QOM5nKSFlwyQgI6DG3ttgOThieEKpweHgSXoykXY+1X0lV8GDrb
         HPu9f3lg+UpvCor9tzY3y54Ez+bK6YSjxRxZQWTPdTtRnQ/reeo4FLssW5RTeX5N4Mg8
         auZQp6EwwCCs5y2yP8Um44Lef6vcyH5DBcRXVWxyCE73pD06bVFXO1zUEZfD2zSD4W3D
         qe4H43tvQryIpWW3ArBjqWCO36shqC1MmkP33Q6CxyI5eCPoMjobIzDetd2CZZ1gdHZD
         VE1sJjKB54PIexLdBjiXsb7swuk/auEpuIPqcn5LS6ktF5am6PNllfrebDFr9NEBBXOL
         wmWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708971074; x=1709575874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Siz+e579qyyLmrEPjL1wgtPi8pF/VTeq9RDiFwMQ9QM=;
        b=F8ZoSLLKFQf3l9hYn0MvVsjQ+xAh+MTOdK1xFWkn4zJlZZpn9j6D8mx4rWMzL2/VHx
         6sNmYWUrMXJw5WsV6Eg2H3+M2apW4R4jt50b7wyxTSYxWPc7J4Xt3n3SKGzYqwcXPf1j
         0jCPbBNXy4dEN2CmOzYtMmP5vdRRD6w4w8+cgFMr17OpYrEwe9IuOz96KQXYvknrKcfG
         UrG1TzzAxU02si2w/SDRShytERaS0RkMIy/H3pjRahj2hbBcKSSKADaBUMj5wCKreMbK
         IUCvzwlmQjuUJSOLWtZt+NqPM6Pnb/9yAOqHPyRNeoG8oLNb+yDGMwVv8z/ktUhyBnmt
         Xgng==
X-Forwarded-Encrypted: i=1; AJvYcCUHZjJRbDgeUS2pC0+j4VCz+FY+9vRJYoQx5/z+Ir1dcU7QbjBRX7cRMhnmrJ96F1WzJ4npZZ320RSOZXREt2+PRs3E
X-Gm-Message-State: AOJu0YwyAdwCLX3RHlvAvcSWYTmVC7Wjf01cjC88Kj7+6AWrH8rS3HD0
	k2RzIeOtSW9AUrhScSOWjcEHmyj392mIiFNaJlvT75VM3hzB9HCFL0hUtsaAKrjElgxo/NKEnKN
	00bNFW9aS9lk1awtZDtrYoBs5y0p1/43Wf20=
X-Google-Smtp-Source: AGHT+IHv0A4S1qogpxD1UrJUD955Kg80ZW2OESD5zsDaexylhIZV3YOEv6112VdEPMSGikhc4cYM5jhfzHm4OVj7euk=
X-Received: by 2002:a17:907:209a:b0:a3f:7e2:84cc with SMTP id
 pv26-20020a170907209a00b00a3f07e284ccmr6091317ejb.6.1708971073500; Mon, 26
 Feb 2024 10:11:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMB2axOYHKLQhR9b50oVgvUDXeo573amqpiXRot51_JZQcFuiw@mail.gmail.com>
In-Reply-To: <CAMB2axOYHKLQhR9b50oVgvUDXeo573amqpiXRot51_JZQcFuiw@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 26 Feb 2024 19:10:37 +0100
Message-ID: <CAP01T76R0bqdNK+LkObuVTej_TRwEB9HnvwJaTTsRrr1Y8_WmA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] bpf qdisc
To: Amery Hung <ameryhung@gmail.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Feb 2024 at 19:04, Amery Hung <ameryhung@gmail.com> wrote:
>
> Hi all,
>
> I would like to discuss bpf qdisc in the BPF track. As we now try to
> support bpf qdisc using struct_ops, we found some limitations of
> bpf/struct_ops. While some have been discussed briefly on the mailing
> list, we can discuss in more detail to make struct_ops a more
> generic/palatable approach to replace kernel functions.
>
> In addition, I would like to discuss supporting adding kernel objects
> to bpf_list/rbtree, which may have performance benefits in some
> applications and can improve the programming experience. The current
> bpf fq in the RFC has a 6% throughput loss compared to the native
> counterpart due to memory allocation in enqueue() to store skb kptr.
> With a POC I wrote that allows adding skb to bpf_list, the throughput
> becomes comparable. We can discuss the approach and other potential
> use cases.
>

When discussing this with Toke (Cc'd) long ago for the XDP queueing
patch set, we discussed the same thing, in that the sk_buff already
has space for a list or rbnode due to it getting queued in other
layers (TCP OoO queue, qdiscs, etc.) so it would make sense to teach
the verifier that it is a valid bpf_list_node and bpf_rb_node and
allow inserting it as an element into a BPF list or rbtree. Back then
we didn't add that as the posting only used the PIFO map.

I think not only sk_buff, you can do a similar thing with xdp_buff as well.

The verifier side changes should be fairly minimal, just allowing the
use of a known kernel type as the contained object in a list or
rbtree, and the field pointing to this allowlisted list or rbnode.

Thanks

> Thanks,
> Amery
>

