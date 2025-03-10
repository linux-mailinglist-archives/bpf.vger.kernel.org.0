Return-Path: <bpf+bounces-53736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4A5A59909
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 16:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB2B18918F5
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 15:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2F422DF9A;
	Mon, 10 Mar 2025 15:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pbl7kuvt"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B35B2AE66
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618837; cv=none; b=E7z4483d1xQHXUDnIg4K9z+aEYzjWVmP4ak05FET+4VSXAoZhikdQaAZD5qJJM789ey6Yy2dO5ppw7qul2Cs/5kqn1qNabA4p6Y+N41/qFXSDmnXAwF4fOyUmN+Oy/eFP0nz1IldWUS/i41Em2f3zIixhtFOWP75EpDuLDlcIpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618837; c=relaxed/simple;
	bh=/x0ON/WedsoRMVzH8RSYa4VIPg/Gp3T7mT9f9BJjDFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5JZSAHJ8lIJeF9aO//dZ7jD+1+oyHZQhVaE4pmKM6xATe4/YPLoM+7y3W0Erp1oMNkRwiqpXEHxR8A9f+hntK5DATxmCjRz+/Ra4r+MURi1hlJGp+p3ZwA9DPU2+H6zsBHAGNCvCZ1h/nPzOr0izZ/loPwMIGKZpF2Rqn+FRcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pbl7kuvt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741618834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KH5i4IywbihOjouVmIrniM68yK+cO1l8JI4w0Ofv3s4=;
	b=Pbl7kuvtvT5emZ5jPZuXGo3qUAI3YiSG/mO5xoVw9VKvTkXz2WFSTfRit/0bH7/pN8vxbA
	WhGWEsJ7jnIIQDOXvQMyuOobKuhowF1WxjCvgG3xOZe6Y9jbsobnkdnt3kqZ+bcqMZTd4J
	bB5ys6gLWiZGuLo4fESoR4i3dSNzmAg=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-zPiMDG4LMD2GoZlPbmNolg-1; Mon, 10 Mar 2025 11:00:31 -0400
X-MC-Unique: zPiMDG4LMD2GoZlPbmNolg-1
X-Mimecast-MFC-AGG-ID: zPiMDG4LMD2GoZlPbmNolg_1741618829
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5496d38f725so2437907e87.2
        for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 08:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618829; x=1742223629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KH5i4IywbihOjouVmIrniM68yK+cO1l8JI4w0Ofv3s4=;
        b=Eg3ZIPtlpfnkt7ZhOegwpvslANoEzstSr/sPwakdV41NTi/9Lftr1YEQODiL6i3QUR
         MztoQf78ri7PKz8+iBoQvI7vdudz8kmA/lamT8x1Mz0Q5UuozNIjAxqbDuJUOJczRrzt
         ju2PP/Iickv27C6s9DJB2HXXZAX7yaGH3/TQHhKslRhDbq2+PGLtSUXup4qDDSPNB9ML
         MqLi0kW/+cD6Axmjz1ofgG4BBZgO3rwhG6eEKRlNmuCF8YDDTAMqxykWRr3qiWDGDN+E
         7JmL+GWdqPyW+QkXXhSJVjFnRs0VWpzMr0OPFFnsECtHm5peb68z69wZLSP003FdVSUe
         atQg==
X-Forwarded-Encrypted: i=1; AJvYcCXMxPp+4iVQXZUSbGbzlB+JHFNYuoQSfMVR5fbs7gAYHalaXUfRiKRREW9A5F1SKmf33i4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeO9WIxmoC/L33s7B0nlGx0BQuTt7sQ7qfUPe8nYBsyz39lyVM
	OHgvMu0s7gWH4ubfXYUKwXwuJPhgZgYpiVX96N1s7rozVkFOGqJx6tmT5D0a4+RjDRA2mcqvAsC
	cKk7DCjrlq8wgH8+RafRz3Fhp90a0ayRrqrasPeb4RxYoppivZ2PM3aJuTA==
X-Gm-Gg: ASbGnctnpounYKY84D66rpHBuR5xStQ793M/pPPuQa/kSaKAIQrY4zEgSXV9vrtTAOb
	W0B2Q9DLZr3ezifMm0Sc4YpK5EE52YyC08S2Y9n0cqkQ3IaYyZdRJTAYgVbvUkRV062XoY9TvWk
	lfNw7oT1sOIzFAumVtbxmNstU7u1emeCMunyJVIbQRJKKGu85ZYAg4Zob6HVGKvv7G3s0vCiBeq
	AQbFIEgD352UEC8PkB0qjv2SV24kyJS26NRQ623U94FASynX6brDdhDV81UUyw8DCxarpBov4z2
	VFdhSRLlW16Oramvm5msc1WKV2SHmec7busHHb78YH1qWp3lMISOBy4u0/0Rtslp
X-Received: by 2002:a05:6512:1112:b0:549:5850:f275 with SMTP id 2adb3069b0e04-54990ec8e60mr4491692e87.50.1741618828791;
        Mon, 10 Mar 2025 08:00:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGROxIODA3vj0+f3Hfn/vpKF5UrA5a5CTMt2ch2nftnuA6re4mbmftFp/dC3MyfFmuS2rop3g==
X-Received: by 2002:a05:6000:188c:b0:391:2f71:bbb3 with SMTP id ffacd0b85a97d-39132db782cmr9143318f8f.46.1741618814406;
        Mon, 10 Mar 2025 08:00:14 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceba8d727sm78011015e9.25.2025.03.10.08.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:00:13 -0700 (PDT)
Date: Mon, 10 Mar 2025 16:00:09 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH net] vsock/bpf: Handle EINTR connect() racing against
 sockmap update
Message-ID: <thza4ufhxxdy5lggglgqkzjtokl6shweszs3cqmdkxlhsg6wcq@6l6jn5samgsu>
References: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
 <be935429-2125-4fea-844b-abce83f7324e@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <be935429-2125-4fea-844b-abce83f7324e@rbox.co>

On Mon, Mar 10, 2025 at 12:42:28AM +0100, Michal Luczaj wrote:
>On 3/7/25 10:27, Michal Luczaj wrote:
>> Signal delivered during connect() may result in a disconnect of an already
>> TCP_ESTABLISHED socket. Problem is that such established socket might have
>> been placed in a sockmap before the connection was closed. We end up with a
>> SS_UNCONNECTED vsock in a sockmap. And this, combined with the ability to
>> reassign (unconnected) vsock's transport to NULL, breaks the sockmap
>> contract. As manifested by WARN_ON_ONCE.
>>
>> Ensure the socket does not stay in sockmap.
>>
>> WARNING: CPU: 10 PID: 1310 at net/vmw_vsock/vsock_bpf.c:90 vsock_bpf_recvmsg+0xb4b/0xdf0
>> CPU: 10 UID: 0 PID: 1310 Comm: a.out Tainted: G        W          6.14.0-rc4+
>>  sock_recvmsg+0x1b2/0x220
>>  __sys_recvfrom+0x190/0x270
>>  __x64_sys_recvfrom+0xdc/0x1b0
>>  do_syscall_64+0x93/0x1b0
>>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>
>> Fixes: 634f1a7110b4 ("vsock: support sockmap")
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>
>This fix is insufficient; warning can be triggered another way. Apologies.

No need to apologize, you are doing a great job to improve vsock with 
bpf!

Thanks,
Stefano

>
>maintainer-netdev.rst says author can do that, so:
>pw-bot: cr
>


