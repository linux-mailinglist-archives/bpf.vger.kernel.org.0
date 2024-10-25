Return-Path: <bpf+bounces-43164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0049B05CC
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 16:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B620DB24CB7
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 14:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C14120651B;
	Fri, 25 Oct 2024 14:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGZA6lvs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B7A200BA4;
	Fri, 25 Oct 2024 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866465; cv=none; b=FtwHZFg4wDAookHN2IdRXlkuZgO+MnUMQu1cIZ/J8RSNAILdOWpvDUTM4Jzthf758nbaEFV2lq5GXWK00PYcAtNpRCSxc6Bw0p2ntBVNtYEADGGhGnytEDzk0gBzIKXt1sdShEICEWChHYV2gm+YgR6Y2nhJaqsSO/G/7OQmdmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866465; c=relaxed/simple;
	bh=SNOT2iG1uo43SZFt0GZqyBwcm+SiJ5JmL6rlhz0NOv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzEwvsoA8Rx7rI4tUvc0vQYp9w/nt1z3KWMmUIXKQdTDOSWXwkeIpTQ4kIw9q6w8FmWquE4TQy1NX1Tpf842cpgPp0zpSI8Vu2H0pg6bdxLBZq6UW8SajahsSQRP2ZgQoxkGj1CXLbkZeT1+n1Yaw7DY7R9Z40k2pB/iwWc615U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGZA6lvs; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a26a5d6bfso303371266b.1;
        Fri, 25 Oct 2024 07:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729866462; x=1730471262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fR5hzdpK0KAXZdWFhkN0m31lZEsfiSfvLl8lR/kVQKI=;
        b=CGZA6lvseLbgAnRAcYpH1VRs5Kvq3j89s22Sf/0fVWpwtVJpTJCbQF1PYfYbKaMO4m
         QuL61M/g30w/MPslAFzsI06Tm8VhYIQe81CDo9+zRtFoLZicCSEEikKIaOSDOlKUiA/H
         lHlYnz5RMueSUh0S36XZWeSsAF0tltMVC9Zchm6GpAbArhav2QjuD+FoQgH1viOSC8uy
         OzOgEbxfV+6NqMaMTmnhvn+EyJDHBsA9Mj4stbD7JeteDH0zexerVzv9/JmJRYiUDnP7
         kEbOVlU8uvaP487DOjjkfGCAStqwhiSBZ1gMEa1dpjaMfauYs8gtekPUUA+gIA0a2CXT
         MlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729866462; x=1730471262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fR5hzdpK0KAXZdWFhkN0m31lZEsfiSfvLl8lR/kVQKI=;
        b=hXB+k+sqkboaNOdouIUWuyIlerRUorl30dKYMsgFoS9OTiX8MsfGghsSPxTeVxf94v
         anenAhKVrh6Q8BLpbe/Qg3RN+h7m1gWdaazak96OKq40TNEt6hBk3SqUjAdJ1RihRGEM
         JJJ9GOA1f42GYmM3MXpCxdXx4be2OQzx2UgozQvINWPEsK2AYHsJNXWzmlcwzt7hRsHd
         bN6XhVgRMYfXR1zVkgzEK0SPO4o09AK/dPLocK5pBuBCRZ2Mg9khNZuYKJ8rj8ZNdoZB
         ijAliQIosx856Zuu5qSePVllxXqJi+Sbfu/8ZPDhUiUmd9rLouhRVBvJ1ShP0FDjvkVf
         fVVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdnmfHMMQrRyMURLt5WsX9No+BjKP3ZgQQTsJWCmaTEWl8+AntuoejmeNC6XPZYOte1bVp5ElImphEC4y5@vger.kernel.org, AJvYcCXiTOJTSmtaUzossPjgWuaBeEQ7xKDgmAbnKJBKgO3ms7vZJZkQ7496Lx3grLN0b0aRZaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoruXzGk5sBqjQ0JXeWJV9a/bpD4nGYJK5A1fV1qLnJE27CHCh
	r4siF9aqd8bfwtLCH0oJyXfNwV/M8vm7+zu5fo48iT6rWYbqShRaB8ihHObVwnE=
X-Google-Smtp-Source: AGHT+IGPQeVt+Ho9WeKCaan/AgLgjEin4LNAeAKET0Nw1qGl80K+N4Zeg8GXUkU+/j6Y1Rr/fpdcmA==
X-Received: by 2002:a17:907:6d24:b0:a86:94e2:2a47 with SMTP id a640c23a62f3a-a9abf887496mr901934066b.15.1729866461696;
        Fri, 25 Oct 2024 07:27:41 -0700 (PDT)
Received: from andrea ([2a01:5a8:300:22d3:a281:3d89:19cb:ed96])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b3a088ae9sm75669966b.217.2024.10.25.07.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 07:27:41 -0700 (PDT)
Date: Fri, 25 Oct 2024 17:27:37 +0300
From: Andrea Parri <parri.andrea@gmail.com>
To: Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>
Cc: puranjay@kernel.org, paulmck@kernel.org, bpf@vger.kernel.org,
	lkmm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Some observations (results) on BPF acquire and release
Message-ID: <Zxuq2Zvpn7ap4ZR5@andrea>
References: <Zxk2wNs4sxEIg-4d@andrea>
 <daa60273-d01a-8fc5-5e26-e8fc9364c1d8@huaweicloud.com>
 <ZxuZ-wGccb3yhBAD@andrea>
 <d8aa61a8-e2fc-7668-9845-81664c9d181f@huaweicloud.com>
 <ZxugzP0yB3zeqKSn@andrea>
 <8360f999-0d64-3b4f-e4b8-8c84f7311af2@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8360f999-0d64-3b4f-e4b8-8c84f7311af2@huaweicloud.com>

> I am particularly interested in tests using lwarx and stwcx instructions
> (this is what I understood would be used if one follows [1] to compile the
> tests in this thread).
> 
> I have not yet check the cambridge website, but due to the timeline, I don't
> expect to find tests with those instructions. The same is true with [2].
> 
> I have limited experience with diy7, but I remember that it had some
> limitations to generate RMW instructions, at least for C [3].

Oh, I'm sure there are, though I'd also not consider myself the 'expert'
when it comes to diy7 internals.  ;-)  Here's an example use of diy7 /
diyone7 generating lwarx and stwcx and reflecting the previous pattern:

$ diyone7 -arch PPC LwSyncdWW Coe SyncdWRPA SyncdRRAP Fre
PPC A
"LwSyncdWW Coe SyncdWRNaA SyncdRRANa Fre"
Generator=diyone7 (version 7.57+1)
Prefetch=0:x=F,0:y=W,1:y=F,1:x=T
Com=Co Fr
Orig=LwSyncdWW Coe SyncdWRNaA SyncdRRANa Fre
{
0:r2=x; 0:r4=y;
1:r2=y; 1:r3=z; 1:r6=x;
}
 P0           | P1              ;
 li r1,1      | li r1,2         ;
 stw r1,0(r2) | stw r1,0(r2)    ;
 lwsync       | sync            ;
 li r3,1      | Loop00:         ;
 stw r3,0(r4) | lwarx r4,r0,r3  ;
              | stwcx. r4,r0,r3 ;
              | bne  Loop00     ;
              | sync            ;
              | lwz r5,0(r6)    ;
exists ([y]=2 /\ 1:r5=0)

But again, I'd probably have to defer to proper herdtools7 developers
and maintainers for any diy7 bug or misbehavior you'd have to discover.

  Andrea


> 
> Hernan
> 
> [1] https://github.com/torvalds/linux/blob/master/arch/powerpc/net/bpf_jit_comp32.c
> [2] https://github.com/herd/herdtools7/tree/master/catalogue/herding-cats/ppc/tests/campaign
> [3] https://github.com/herd/herdtools7/issues/905
> 

