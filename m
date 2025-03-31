Return-Path: <bpf+bounces-54926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C03C8A760ED
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 10:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AB6D1646BD
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 08:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823B31D63F5;
	Mon, 31 Mar 2025 08:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1M73gv0"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511931876
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 08:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743408461; cv=none; b=O8l+uSlTHLgK964ElN8PjYl4X7JCGto4Tck3jFHuwPrWy3ulhGmFDp5NwhRfI6EX6AkzSKZH20mHjVWEf9/BUQ1ctsm/wkdNsibB/v1wtEyb1GJUL3eSSgiXO/A60DurSgWrsXvBNCddD0Jm/7icju/G64i87M6nWEfYqxZt2Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743408461; c=relaxed/simple;
	bh=tK0Nf+/j4sX/azCF0BZOjpnoPy7MtYBQTn/ET7rMTmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IvTFSrQA1zOPZRAWnoghKpY+IYDKtFZNjbgw/9U0KJplYW0IXTjcg2nL7yCnZzBm3cY9sgLiO1JwvoNL2GxZ5dAtx4nzr70aD8ZzE2TteCLATqOs/0eemCyIH/JpWJ4RVcs4h+WCnlCuPkjmRZrzHa6tnO7fNpk/DeTzF3d0iPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1M73gv0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743408457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GeMg7uSOXE8clYR81AEgLtw/7BbQwXhU7PExYJZ2pRw=;
	b=G1M73gv0GeW2m+Kygo3NwckPCwQAV0eD4H4UTDOa9M31i7qAA1AYv5cRXB8MjlFyEuKvhE
	MsA6XtNJE1zzkMMjPZT+gs3vskb490kA0RaWmi4Y+k9UmcNbvRVzaWjsBoHzwv8Ivz+wO8
	55AA96qkdrI0VpJ+3QKkSL4pf4try98=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-B7Wn0NsDND6aqLN3657EWA-1; Mon, 31 Mar 2025 04:07:36 -0400
X-MC-Unique: B7Wn0NsDND6aqLN3657EWA-1
X-Mimecast-MFC-AGG-ID: B7Wn0NsDND6aqLN3657EWA_1743408455
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3913d8d7c3eso2160779f8f.0
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 01:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743408455; x=1744013255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GeMg7uSOXE8clYR81AEgLtw/7BbQwXhU7PExYJZ2pRw=;
        b=ebXzDAOpBV8p0+QI3f9+ICLw+d1uIN3iNmweJ4/m8nMyVppTnykvOVCCnU0JRZOuOJ
         8KrFT8nNi0GmuM1eWqVAPtXDJvk99uJvbo3KzE6oUsO6WaWhd3JnCIseyDoD7XMSimsG
         YeZ48YF8/KxDaLniV5EJTYG0fkZ5ekEstZc528RUjz2L2m2EQwiHgwop+kwk/UbTTytC
         1bTVwFAezN/YhGG47FbtADl6nKpINSXGvYDuq6OCzg9K6zU/cmk0uhr0Ldf+IbDIRMe/
         mvORYYACTWF+/HVn3AH7QXt3cxB7vsIPE/ot47g8M8tSaaqyIpqMy2gvWMlzl8ssPQSO
         JwmA==
X-Forwarded-Encrypted: i=1; AJvYcCV1FIXpjVRdrbtkrstd9Nq/kUq3+bpshOyt83eIRZHbbGQOjUruVFhTtMpNiO8QSgnt120=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF8oeUQR2oGDacwi7XFVHDdusgA5Rw7eWc/0jF8TZVxga2qIu6
	KSF3KGKEwvlACvd2Fe5AEN7AeAr3O+KzvwQQcELbBCfkAIbiIkfks32Olrjro2CFNFp8ekALqCo
	Bd7/sd+7AcAxroL1UtC9tyi/AptCCwAboN+rrOkMhQduvDGSX5Q==
X-Gm-Gg: ASbGncublMH2W9i9AQV+WCfw/r0+aRiyr2FbNwHJa/r3w+SWJiWFt33hB6fTYa6w/Vw
	W4h3Z0u9+dwpaCwKhnfi0Q0V4GNL26ueyNlJFY1zlrM4ilQUtew4we4LiIrBZCJzokxe34CP+Ok
	A2CDe41Qy4hy3a5hs+5o1sp5oszDwclvbk5tQbGR2+RzVR3cGvrSHGYIqYEyolOWhlRn9frtbLn
	7/twuMXJjIlzoWJh9JaZbmtbzr/CKFbLp+FMqX0nab9dLWQ8YKyRkUiblAAro3lzQYgQbaJxjNo
	BN+G55MZIw8iEMCKSdPAyFPhy0s6n5Ap9zHPAgGsGN0NJg==
X-Received: by 2002:a05:6000:381:b0:39c:1ef5:ff8b with SMTP id ffacd0b85a97d-39c1ef5ffa2mr697666f8f.48.1743408454738;
        Mon, 31 Mar 2025 01:07:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjfkooZdZCSF/EGrMLJ2JOyUMzq7CJPT42yrIBpk7KVfpc9QrFJRgYND6PboReL52CFj3zJg==
X-Received: by 2002:a05:6000:381:b0:39c:1ef5:ff8b with SMTP id ffacd0b85a97d-39c1ef5ffa2mr697638f8f.48.1743408454366;
        Mon, 31 Mar 2025 01:07:34 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d84632ffcsm154028585e9.31.2025.03.31.01.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 01:07:33 -0700 (PDT)
Message-ID: <647c3886-72fd-4e49-bdd0-4512f0319e8c@redhat.com>
Date: Mon, 31 Mar 2025 10:07:32 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: new splat
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Justin Iurman <justin.iurman@uliege.be>
References: <CAADnVQJFWn3dBFJtY+ci6oN1pDFL=TzCmNbRgey7MdYxt_AP2g@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAADnVQJFWn3dBFJtY+ci6oN1pDFL=TzCmNbRgey7MdYxt_AP2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adding Justin.

On 3/31/25 1:28 AM, Alexei Starovoitov wrote:
> After bpf fast forward we see this new failure:
> 
> [  138.359852] BUG: using __this_cpu_read() in preemptible [00000000]
> code: test_progs/9368
> [  138.362686] caller is lwtunnel_xmit+0x1c/0x2e0
> [  138.364363] CPU: 9 UID: 0 PID: 9368 Comm: test_progs Tainted: G
>       O        6.14.0-10767-g8be3a12f9f26 #1092 PREEMPT
> [  138.364366] Tainted: [O]=OOT_MODULE
> [  138.364366] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> [  138.364368] Call Trace:
> [  138.364370]  <TASK>
> [  138.364375]  dump_stack_lvl+0x80/0x90
> [  138.364381]  check_preemption_disabled+0xc6/0xe0
> [  138.364385]  lwtunnel_xmit+0x1c/0x2e0
> [  138.364387]  ip_finish_output2+0x2f9/0x850
> [  138.364391]  ? __ip_finish_output+0xa0/0x320
> [  138.364394]  ip_send_skb+0x3f/0x90
> [  138.364397]  udp_send_skb+0x1a6/0x3d0
> [  138.364402]  udp_sendmsg+0x87b/0x1000
> [  138.364404]  ? ip_frag_init+0x60/0x60
> [  138.364406]  ? reacquire_held_locks+0xcd/0x1f0
> [  138.364414]  ? copy_process+0x2ae0/0x2fa0
> [  138.364418]  ? inet_autobind+0x41/0x60
> [  138.364420]  ? __local_bh_enable_ip+0x79/0xe0
> [  138.364422]  ? inet_autobind+0x41/0x60
> [  138.364424]  ? inet_send_prepare+0xe7/0x1e0
> [  138.364428]  __sock_sendmsg+0x38/0x70
> [  138.364432]  ____sys_sendmsg+0x1c9/0x200
> [  138.364437]  ___sys_sendmsg+0x73/0xa0
> [  138.364444]  ? __fget_files+0xb9/0x180
> [  138.364447]  ? lock_release+0x131/0x280
> [  138.364450]  ? __fget_files+0xc3/0x180
> [  138.364453]  __sys_sendmsg+0x5a/0xa0

Possibly a decoded stack trace could help.

I think a possible suspect is:

commit 986ffb3a57c5650fb8bf6d59a8f0f07046abfeb6
Author: Justin Iurman <justin.iurman@uliege.be>
Date:   Fri Mar 14 13:00:46 2025 +0100

    net: lwtunnel: fix recursion loops

with dev_xmit_recursion() in lwtunnel_xmit() being called in preemptible
scope.

@Justin, could you please have a look?

Thanks,

Paolo


