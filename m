Return-Path: <bpf+bounces-35627-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCF093C047
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 12:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072C5281A0B
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 10:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3971991A9;
	Thu, 25 Jul 2024 10:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdcHRaOL"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CD3198E69
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721904277; cv=none; b=ItmIXDLAKNB15sWkezmfMkUakRNdQA1ZdzCf12LYd3JolqeawSr77//XK8LLXD3jeEikOKMMUk4lmVXQIfKHKWai6MW2SI8/RMLVQf4L0c+Gbj31++egYNMcQWV7Trtn6aFs/MN4dLVkVTc5poFV6AExuJb+Ue2c/7w//5MHhyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721904277; c=relaxed/simple;
	bh=0vq0rDUT6bKO2W9H+6WFqSg/9iuDLDwHFDr3lWX1Za4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XFYr7UHXcBvPhIzNcezCkjArRDU4f3zm+Sei1H6V0XoIkcJFiEAE7FVMshGSB7NwGPmAVybeSKr8koJp7+CeLCmQAp4Y34GUx9i0bNwp58Fdz6cACEIowiljjdnpzXyCNu31jtRtEld6L0Df41TD9YgGdVTMv3AWL2E4+T1Ylqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cdcHRaOL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721904274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zRI06KBbgnO+Bpzme7unWL6gNnWyJ2ogiXiY5GeACt8=;
	b=cdcHRaOLcwthOebFUhFv7D31Vtop8hzgLkGshr6Pv46Y/ae7lI1UTds6pKbU/Rog5WKB37
	NP4bcv212vxK1UMLDm9f8CITJINnU+qPlt5Yt4q040W6VsPUUZ+Z1rUQh6RlqYzUIdEbNu
	hMON3KgIBViMEhO45OUvQvRGvAo5ri4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-F00-HLx0OP26No-pUd5nCA-1; Thu, 25 Jul 2024 06:44:32 -0400
X-MC-Unique: F00-HLx0OP26No-pUd5nCA-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ef298e35e1so23821fa.0
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 03:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721904270; x=1722509070;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zRI06KBbgnO+Bpzme7unWL6gNnWyJ2ogiXiY5GeACt8=;
        b=SOpekrw4TwX5JfL5S3A6SPn0SlvRkBGdn4+W0abWN6TfgwdRsjsSaqe4u3QWZ+Ifxp
         8iOIgrTwZjEKWBArfW0Yxn6/6yhnJoOqmiZew/8REbUF7kgfzQ3bx790fac5rPLZ10Vc
         xuyMbfSLCXbhEpOj+UN5Yo95FFf96LOScVq1QJYwYGvLhLJFqhUCNQMN1iGFFgGN93Lf
         IvpxKWquoI4Zwz+rejNh8cz3DW7s/XTmSn/zrJn9pnDLtAbQXkVpv9kXG5hFWEblGGMa
         ffCDIEwiYb3/I7/S1GdzA6w4kMP0u+FLcHe92DFZJVXBBTOpx5xg5YMWsN14X+sfP0+P
         vIIg==
X-Forwarded-Encrypted: i=1; AJvYcCVEXDkU0/EY8qw7r+mWhBHF0W06IwNsVb4JKhTyMBHO+zf9zmmrWyZbX+sFfrcZaVtiUuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7vVkYkr85QXpy+3zogCIdpS+Vhb4pn5qMeZcjyRI/gK7DzcNJ
	GmX4sE/z5rrTlIt1/u4PycFt26GDzI9GAhsxSmJfIUcNlkUF7jrQW6XkWdnmFDd8uS0I5siAMm1
	blVOMjXLULFOPmexFhcM22OQtD7+gYpIKY57lMUs7fBwjNsAfDg==
X-Received: by 2002:a05:651c:155:b0:2ef:2346:9135 with SMTP id 38308e7fff4ca-2f03c8000e0mr7282321fa.9.1721904270475;
        Thu, 25 Jul 2024 03:44:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUBK6W2GUS8+jtAqWZDWCnsmj9yGfBQkRTr8Yb+Fe36zV0LVzufyszMXt+QAvJPZG2mpdWvg==
X-Received: by 2002:a05:651c:155:b0:2ef:2346:9135 with SMTP id 38308e7fff4ca-2f03c8000e0mr7282221fa.9.1721904269873;
        Thu, 25 Jul 2024 03:44:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b231:be10::f71? ([2a0d:3341:b231:be10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f9386b87sm67279135e9.19.2024.07.25.03.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 03:44:29 -0700 (PDT)
Message-ID: <e263f723-0b9c-4059-982d-2bb4b5636759@redhat.com>
Date: Thu, 25 Jul 2024 12:44:27 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tun: Remove nested call to bpf_net_ctx_set() in
 do_xdp_generic()
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jeongjun Park <aha310510@gmail.com>, jasowang@redhat.com
Cc: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, jiri@resnulli.us,
 bigeasy@linutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000949a14061dcd3b05@google.com>
 <20240724152149.11003-1-aha310510@gmail.com>
 <66a1bbe7f05a0_85410294c6@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <66a1bbe7f05a0_85410294c6@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/24 04:43, Willem de Bruijn wrote:
> Jeongjun Park wrote:
>> In the previous commit, bpf_net_context handling was added to
>> tun_sendmsg() and do_xdp_generic(), but if you write code like this,
>> bpf_net_context overlaps in the call trace below, causing various
>> memory corruptions.
> 
> I'm no expert on this code, but commit 401cb7dae813 that introduced
> bpf_net_ctx_set explicitly states that nested calls are allowed.
> 
> And the function does imply that:
> 
> static inline struct bpf_net_context *bpf_net_ctx_set(struct bpf_net_context *bpf_net_ctx)
> {
>          struct task_struct *tsk = current;
> 
>          if (tsk->bpf_net_context != NULL)
>                  return NULL;
>          bpf_net_ctx->ri.kern_flags = 0;
> 
>          tsk->bpf_net_context = bpf_net_ctx;
>          return bpf_net_ctx;
> }

I agree with Willem, the ctx nesting looks legit generally speaking. 
@Jeongjun: you need to track down more accurately the issue root cause 
and include such info into the commit message.

Skimming over the code I *think* do_xdp_generic() is not cleaning the 
nested context in all the paths before return and that could cause the 
reported issue.

Thanks,

Paolo


