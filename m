Return-Path: <bpf+bounces-50085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6EEA2274E
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 01:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF9E518873F4
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 00:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF979475;
	Thu, 30 Jan 2025 00:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1SjEEfh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11067464
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 00:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738198110; cv=none; b=SHliDeWsBophAvXEQodcuhtT81ULphZUd4HAOeyNJRn85XX/rh2kK5SESPzsgicnhK8I3MtgspqcIC7YQqWb4fqxMkkybHHq15u+0GzmMw72xJR/+Bfkn6MGO9B5Bveee5a2DSGC6VJWG4r+4YbFh23Clpvc3VhSSS9DTXT1NBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738198110; c=relaxed/simple;
	bh=OWV+1fXXSXpjJunoQZInOTk7XyZKTjyjDg8hdQ7AriI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+h2RucO8wyAwMrQZPEoDHB4+I/EmadC4bNYhjSVGD6LdcTPD1A+RIdVSif6BW8ZnjdZd9vsRRW7TSNoAnW18dsDeHo/3kchmixSYOjdGAArwAXcXIEQlISr+m4nrJM6HwlehahX1odDvcXbuLRmfDgWpL0nlRPWadDyXK9rMn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1SjEEfh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21634338cfdso5044455ad.2
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 16:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738198108; x=1738802908; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ret6pTU3336+/26QOPrLJSeUu+2Mt+uc37UNhPyUjJo=;
        b=E1SjEEfheEjPNAqUGopkneVs+KzniHZR4BYDbA3a4eEB5mV3qyaMOtTuJ1xZWbtvpc
         7e2Wx8o2DcrP5aytyJhMzvyZdksFU/fusbwPnRiMFshCN8t65VBiolglR/Ij0Cj+7knM
         GrpdE2EDEu5iqhe80nfF0BkcHLFptz/yqQFL5iErE8Mvre5iAl+J9D4r0LQekcTuBlbh
         vMOjl+xsd1MaaZZN3hPToH1It7wpoeTIRQOtLBL9CoK4y94C0NBx0yIOYOx/AMQVHd9m
         PQAqnZnVxbdBacKNklcbC/ybdxlOY1BCJb7ixwUku4Ej202zRkcP+frYl+7CivIBM3FL
         OY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738198108; x=1738802908;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ret6pTU3336+/26QOPrLJSeUu+2Mt+uc37UNhPyUjJo=;
        b=aY1IfyTYpS8FQOTekidchOFJaiXU2m2Psh6g06mkFj1cKgCrGpX7sFh62HR6MjN12Q
         XxEND2Gj56E2+RBpLui8fdeG+/IcNO+STLr5OHgy1n39Vv0jPxq/VD5vGsJiS+l2VNvf
         eeCzEJHXCSXhyqcCtO05f1k0zhd46XD60VLSrXuk55605bJazjqL6Vtu5VMKbVIEqsVh
         b/ChbUk7IrJXd9s/NhmooMbZ5NSIjnPHmfFix0qy44eK1zoRLqZc61Zt5pGaXTtKu0hx
         zGeFCvo/nsQgNfFISmlnTZcZUTXdA4ASrDX8tkBZgVZuFb1lk+LMEo1jFL6dpQg3rvLm
         y61g==
X-Forwarded-Encrypted: i=1; AJvYcCX1tLJWreC4bxx9xa/xMBv6VK8Ha7rQBsE0F+bMGraPzMkuPteRsFCZ6JoBdio0rXnrmQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUW76koom8MU17IvqFsmRck2t0H+uQDYhr5Tac6UUAByhd/pbB
	KSSwYhby9XvJp7niY3drHBjYUKy5zbginjleemwhfUEOqU9FPux3
X-Gm-Gg: ASbGncsmzDHeL2hReHZClKmKWLS2ekWXAJOKliMN8LAbvaIKCwnp9CpJYNwbzF5MNRz
	c8Q186K6LEvHS2SlLN2wd6R//pdFatSdXi2X+8UfDwqiaEtpk+077xGBd1t3QkH0SRyhn1pAADG
	x+D2NV+19HkCKUkAs9TzbnmZZfi7spZq5W9Sh1uhf9y/z4GPiExcTyZGslN8xuHqiNcZZf4uxQU
	hn5DqEEBf6qj43i56+ex+8Gj/c0f1XkLfj4IiVFjZjCXwiySkSM/iIqnKWUFebYml+Y1u62/y1z
	6c2TK8KcM+Vg/EIVJiyh/Q==
X-Google-Smtp-Source: AGHT+IG9ipYo/6a9WD8Pz3CEH4dgk43QpDNtVnKGE14HBYWEJLvpWjnzfR1fOZIV3f14wlr402PhOQ==
X-Received: by 2002:a17:903:11cd:b0:215:7719:24f6 with SMTP id d9443c01a7336-21dd7d788ffmr72709155ad.23.1738198107875;
        Wed, 29 Jan 2025 16:48:27 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:4529:d22b:21ed:27d4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31f80c2sm2168715ad.72.2025.01.29.16.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 16:48:26 -0800 (PST)
Date: Wed, 29 Jan 2025 16:48:25 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Two-Phase eBPF Program Signing
Message-ID: <Z5rMWZgivyCCcq1t@pop-os.localdomain>
References: <CAM_iQpXiQQ8Pv03ubsfq0=2h0XQ7xLAVDvhWFZjt-7M2OqxhhA@mail.gmail.com>
 <CAADnVQ+wPK1KKZhCgb-Nnf0Xfjk8M1UpX5fnXC=cBzdEYbv_kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+wPK1KKZhCgb-Nnf0Xfjk8M1UpX5fnXC=cBzdEYbv_kg@mail.gmail.com>

On Sat, Jan 25, 2025 at 09:33:38AM -0800, Alexei Starovoitov wrote:
> On Fri, Jan 24, 2025 at 7:06 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > The naive approach to signing eBPF programs faces a critical
> > limitation: programs undergo mandatory modifications by libbpf before
> > kernel loading, which invalidates conventional signatures. We present
> > Two-Phase Signing, a solution that implements sequential verification
> > aligned with the eBPF program lifecycle.
> >
> > Our approach establishes a baseline signature during initial
> > compilation, followed by a secondary signature that encompasses both
> > the modified program and initial signature. This creates a verifiable
> > chain of trust while accommodating essential libbpf modifications such
> > as relocations and map file descriptor updates. This approach enables
> > precise failure diagnosis by distinguishing between compromised
> > original programs and unauthorized post-compilation modifications.
> >
> > The Two-Phase Signing method balances security with practicality,
> > allowing necessary binary modifications while maintaining integrity
> > verification throughout the program's lifecycle. This approach
> > provides granular audit capabilities and clear identification of
> > potential security breaches in the signing chain.
> >
> > We invite discussion on the implications, trade-offs, and potential
> > improvements of this approach for securing eBPF programs in production
> > environments, particularly focusing on practical impact and
> > integration challenges with existing eBPF frameworks.
> 
> This is certainly an important topic, but there is already a solution:
> light skeleton.
> 
> Pls join the discussion:
> https://lore.kernel.org/bpf/bqxgv2tqk3hp3q3lcdqsw27btmlwqfkhyg6kohsw7lwdgbeol7@nkbxnrhpn7qr/
> 
> No need to delay it to lsfmm.

I appreciate you highlighting the significance of this matter.

I didn't notice the above work until seeing your email. From my quick
glance, it looks like another attempt to bring eBPF program loader into
the kernel.

In my own opinion, the biggest advantage of my proposal is that it
requires *no* kernel changes at all, which in turn means:

1) We still maintain the clear separation between userspace and kernel space, as it is now.

2) More flexible: It is always easier to update libbpf without kernel updates

3) Smaller kernel attack surface since complex relocation logic stays in userspace

4) Better compatibility with existing toolchains and build systems

5) Easier debugging of loading issues since more visibility in userspace

You can find more details in my github repo below.

> 
> If you believe that your double-sign algorithm is superior,
> please explain it in that email thread.

I have put everything together in my github repo here:
https://github.com/congwang/ebpf-2-phase-signing
including the design, the advantages, a proof-of-concept which already
works. Please take a look and let me know what you think.

Thanks a lot!

