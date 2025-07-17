Return-Path: <bpf+bounces-63590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C320B08B8C
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 13:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1C4B1A67915
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 11:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A49219EB;
	Thu, 17 Jul 2025 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faZP6oRv"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDFA248F7F
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752750634; cv=none; b=Za7WIkDzy3aTUyqM2XvxkKmhIBHt9x0rMULAgXwhNTqp43HfWFlmaWbBognouZaZAJqRD39ViAFiRGN/N6nuB0kjXxuH6i8jbIHtko4MqNtl29dNDer8tR1/vQeUPfGqVmqJpwFKrvUithDkDjaDFe89+TywIafFfSFGXZcMFeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752750634; c=relaxed/simple;
	bh=o9DguUFd9ulRr/nGZ83LjaBmOxL8fPbmtWacXgwjtWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OMl8v2u2z8vOgQElte1fFKFoYPzVHcNKb2VUbuDb5PFNZKl7LngBGvleYhq4yG5b/2Bo13onSh77twD8+dH9u76fdKTY1inB37iEam50+WU87EhlVcZh8NZvcfH3h5Sf+GQhp1TuGjk86FxAbkVNID0U0XtfMawR0YP1KZHwE/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=faZP6oRv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752750631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mcuwFP2i4FlUn9FFKBy/90wO5gqfwimly/CV8vM4gi8=;
	b=faZP6oRvZllCHZ2BIyg9npqUkUKxbYXyU2EMHfW4XfV3o3wYGfRyc87mv9BdcPUrsR0N8z
	YfCErjllDb4c4AL+ewFJZO7EF2HW+3ObRFCIsNN6Y2rya9k8Q3eumT3XFwHjHjaL6ra/Gm
	8I1An+c9d3+m3FAU2zbYRG8FTqd/yy4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-aOstwln1MCKg7D3VzC7yaw-1; Thu, 17 Jul 2025 07:10:30 -0400
X-MC-Unique: aOstwln1MCKg7D3VzC7yaw-1
X-Mimecast-MFC-AGG-ID: aOstwln1MCKg7D3VzC7yaw_1752750629
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-455ea9cb0beso6966625e9.0
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 04:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752750629; x=1753355429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mcuwFP2i4FlUn9FFKBy/90wO5gqfwimly/CV8vM4gi8=;
        b=JjPVnR7KEEMLn3ulUp0ECIpqMHRcXWvtmMo2bugJrbriRzjMNfvIKT740lpTxyQ8BA
         YG0++WeEGk7Dcp94UbzJd6nJxxo2B6/GBDk5sPbpF/bizREnZL6sRiQFoVXAaWMGQhjy
         z3h52IBwUiXWsnJ3Gg50xPg/EZJyOjd94eNF4/7jmh81arf/KCvE9Z17e4/LdPpuIRwp
         7tBYLs9wKJFhKvk3YbTai5GBIR/P13fVO5eO/PCI29LY1ocLRWzQ7WAvBJHFDOnTIDdV
         v3HI1NbOcnppAuEJKHNKDsDombnko3xMUPYX+9ToSnOxtX9IjEXBe8VwW7MTj2oo7i7A
         F3Sw==
X-Forwarded-Encrypted: i=1; AJvYcCXkadMeJ2azseRXt5y6IYwdlokCTQX/AHQ5sP7R209GyG1hhiO8vbMY6QCyXpU2ain85PI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxICx5+urFgMhf/iylYhqBeHO6n90bCXwAqP6SnXPRLNtpznSXy
	PGoub++2LM0E4NoDt8gdlC9osxJmoIlMwr9p2vRYaDJXxYtdDXo3us/TSTNXIqwW2rFi1i6+V3y
	AHCksWmWyIoPI5WP77d9O3R019Ob/oiKoiMBrSKmQQ/sJcSurxLycZ8ebki2tRQ==
X-Gm-Gg: ASbGncvwLkBELdEuXmaYATyxDFS2QRA8MWHnfvHdfomn34hVraB5LtOCHX4XEaPkgUe
	mJkYzj6/KAUArAMPsfZCFMec9KYGjrO1IuA14KEfj8wX8GsE+hKkoVIJc5C4NduLGXBj5jfN3cW
	mSvhtztY+UzztMnKF9PyKkCy0hApebdSuZNlqfk/tIJXOl6DYdGOI518lgUMHKKs7ChrTy73uMx
	a0d9DXDhqF0VHV4ZWjM7Hy432QaSnr1T+coEuKc5mHKEfVo9JWv5SifHVo6l4N94kpQJpHX9Av6
	+TRvXIKg4scMDh06EjicBPv+fanvxZA65aRuCpzDSg5m4UjfGZz7Ou1iH5wWgDDMSbl4kE6ufYA
	0QF1hYvtEK6I=
X-Received: by 2002:a05:600c:3b11:b0:456:1dd9:943 with SMTP id 5b1f17b1804b1-4562e364923mr61991185e9.3.1752750628837;
        Thu, 17 Jul 2025 04:10:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxXKe1dFz2jXXAF/w6N+sF1RD95sU2Z+R0uSK0mMsz4eDz0ygxowQ/EwGBBRV415p8rq+tCA==
X-Received: by 2002:a05:600c:3b11:b0:456:1dd9:943 with SMTP id 5b1f17b1804b1-4562e364923mr61990895e9.3.1752750628413;
        Thu, 17 Jul 2025 04:10:28 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45627898725sm53301605e9.1.2025.07.17.04.10.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 04:10:27 -0700 (PDT)
Message-ID: <0f6e9770-1c79-418e-9135-df692f495a91@redhat.com>
Date: Thu, 17 Jul 2025 13:10:26 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: skmsg: fix NULL pointer dereference in
 sk_msg_recvmsg()
To: Pranav Tyagi <pranav.tyagi03@gmail.com>, john.fastabend@gmail.com,
 jakub@cloudflare.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, ast@kernel.org, cong.wang@bytedance.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
 syzbot+b18872ea9631b5dcef3b@syzkaller.appspotmail.com
References: <20250715081158.7651-1-pranav.tyagi03@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250715081158.7651-1-pranav.tyagi03@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/15/25 10:11 AM, Pranav Tyagi wrote:
> A NULL page from sg_page() in sk_msg_recvmsg() can reach
> __kmap_local_page_prot() and crash the kernel. Add a check for the page
> before calling copy_page_to_iter() and fail early with -EFAULT to
> prevent the crash.

Interesting. I thought the sge in this case are build from the kernel, I
did not expect a null page to be possible. Can you describe in the
commit message how such bad sges are created?

> 
> Reported-by: syzbot+b18872ea9631b5dcef3b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b18872ea9631b5dcef3b
> Fixes: 2bc793e3272a ("skmsg: Extract __tcp_bpf_recvmsg() and tcp_bpf_wait_data()")
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>

Does not apply to net. Please rebase and resend, adding the target tree
in the subj prefix and specifying a revision number.

Thanks,

Paolo


