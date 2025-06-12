Return-Path: <bpf+bounces-60524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3DEAD7C7C
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 22:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFDF3B6B1F
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 20:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0742D660A;
	Thu, 12 Jun 2025 20:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6kYlCh9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0727170A26;
	Thu, 12 Jun 2025 20:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749760548; cv=none; b=EW3aqxkFgLiEaiweyuqAgFsOX1nR7T5xgkTlD5FsyB96PXyJMjxWSoUm1sQntGp/U7jiydYRDkwMmXUd0BDLcGpHs2SBFdPZ9BYAV4wB1C5jq8B+nstyKe/uDP6lvjRa8lxjog4V7TIezu78yL3NNzOkQ+oi3tgK5A1eYMDHImg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749760548; c=relaxed/simple;
	bh=VKOjouIkPbjnpquNldGEURnFbitxXv7Hj66iDotFJR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9Rw2hL159mGlZrP91Mf7Z/DiUslwOcnWWczlBUjbD19iP8hw++kOWUn92uaRYjqIyZsSteO8trsHSs18FhkSktepxmpBQ9AGL1eyuzJq8zCuQ4r3jTZvFcUJZwnxEUNiGcM9qNWzLQO92YRlO7Q3FmvImE4ThprPkfsrxBksRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6kYlCh9; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2351227b098so12316755ad.2;
        Thu, 12 Jun 2025 13:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749760546; x=1750365346; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4QWSoYdyhatNabwZvPhcwiKLVaajSTZN35CYhP3BmVc=;
        b=b6kYlCh9kOijbqdENnbpDYmLn+Pn2IBLOyKa3RfiD0ybqqXcBEvIqnGixFH1dEKQ5i
         7XdbTyz3w8iwdZDNSnGrAFL3St9Ve8Ku3lwH0FW6Eg8PX5QZ10HvmaEo0kXHuL08DO0+
         b8HaxyuWw+lOQRgUcgzy3vlmj+ZUpG4IwuRIsoxMZuCly9mricCfi0XjBRv8F7UgPYNi
         YKEiesCoLfECGne+4LE6cE+IX1MIinAQwAMY0wJeyExXNzzl1/A+z/JEr/Hr6+w2pH1T
         jdtAZItonO3pSE6e37bO8bPi0KrwibKMm33U6EnPEZfTfZ/hQRRBVkkX41kqsaLDl3CM
         bNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749760546; x=1750365346;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4QWSoYdyhatNabwZvPhcwiKLVaajSTZN35CYhP3BmVc=;
        b=wo1MhcqXd0VoT9k2c6UiZ7n3mEWzogl44l5Wv7JETC7vf/npGt3fOOSr2vwWmIAy+D
         HsjhgMED/0TC3zeoo69+b57O5AOYPhzT5QSXChi43rFSib6kKxciaCAlV2ZUhJ5c0tj7
         G0kABmXvqRv9Z4rims6JrsXrK9J7uSiZosgDPPArSl6mo0Ue4kh+cw9EtwkJ7Q52oPyg
         ywu7/+szH50yKCrwmpMwMUew2YBj+r7MkFgFUz3fyiFAgeUv79w6ZMzGyf2nz0eZo9+T
         uOCombzcD/xVPwHZxexmAtA+RwOJRyfwiQyl8bLbOtWxalx3NiMeKRtgsbXk/B9d1Gm0
         2urQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbaKWVzvX/SuSi3poGvtFuXX1hdTTs8BT8DWQucFt1oDs26rGeqmitdEDUKDevlwIQhyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB8L9GB1q+4OXiQeFq95foESAmuSIGfXlVnkUxiFTv7RrXIRi+
	HswzSMDYddZr3e44wm/GQX4umYklM3EJV0K+RQQUKhmXnHKdyYcXcmGx
X-Gm-Gg: ASbGncvW4GfzHirTp8gocOBuwKaVIfJYRxZ/7dYAd9nlZhHLBwhKI9EOv6llo+FXXFP
	Go9n88v2DzSIOhqXt+XVTudE1dIZHDPy2KtZfItQvfbcbr5gf9pxLzToPbgahf8+bH48KcZNbuj
	ohsN2KW8p8BfMwVxiskRXFLNeYeD4x4Om3Q2s0GR3BDgTOzy32MUQR7O0n8ms2BM/45TDQIaNq9
	vzYUyhM5v6KyIYsOMdkJHTo+0RzxgiFd49GHj3QdjqVIjyHkR94glZ6Jv8PVngU6gcYvjGRJi9l
	rqF2VxCj6qlK5T3uWcRODB28H1+SQE6b9I3EXZxCVAET8eBCNDlDROjxvap0L+BQ1P6/3YRtcRf
	d
X-Google-Smtp-Source: AGHT+IH9btAUftjr4XnFGe6XjhQpAuBtvJF3bOSgSEruSMF5xgFR20FqFzrIqcz4tAx8eUoBIc5zsA==
X-Received: by 2002:a17:903:234e:b0:235:eb8d:800b with SMTP id d9443c01a7336-2365da0858cmr6108555ad.26.1749760546142;
        Thu, 12 Jun 2025 13:35:46 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365decb864sm1371725ad.213.2025.06.12.13.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 13:35:44 -0700 (PDT)
Date: Thu, 12 Jun 2025 13:35:43 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Alban Crequy <alban.crequy@gmail.com>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Yucong Sun <fallentree@fb.com>, mauriciovasquezbernal@gmail.com,
	albancrequy@microsoft.com
Subject: Re: Loading custom BPF programs at early boot (initrd)
Message-ID: <aEs6H4sVGY/YqcQl@pop-os.localdomain>
References: <CAMXgnP4nfgJ+gEvXLummspjRegsZsQ=e5Q8GFAONb2yCxVZLnA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMXgnP4nfgJ+gEvXLummspjRegsZsQ=e5Q8GFAONb2yCxVZLnA@mail.gmail.com>

Hi Alban,

On Wed, Jun 04, 2025 at 04:50:15PM +0200, Alban Crequy wrote:
> Hello,
> 
> I’m looking to load and attach a BPF program at early boot, that is
> before the rootfs is mounted in read-write mode. This is for tracing
> I/O operations on disk.
> 
> Without BPF, this can be done with a kernel module and then use Dracut
> + dkms to update the initrd. But I am looking to avoid custom kernel
> modules and I would like to have a solution with BPF working on most
> Linux distros without too much maintenance work for each distro.
> 
> I’ve noticed the bpf_preload module, but from the discussion below, I
> gather that it does not allow to load custom bpf modules:
> https://github.com/torvalds/linux/tree/master/kernel/bpf/preload
> https://lwn.net/Articles/889466/
> 
> Do you know of prior-art or recommendation how to do this correctly,
> and hopefully without a custom kernel module?

I must miss something here... but dracut should allow to pack any binary
(e.g. your own eBPF program) into initramfs and allow to customize your
own init script too. With the eBPF binary and bpftool and/or other
loading script packed into initramfs, you can get what you want without
bothering a kernel module?

Something like below?

install_items+="/path/to/your/ebpf_program"
# pack bpftool if you need
# pack libbpf if you need
inst_hook pre-mount 50 "/path/to/your_loading_script"

Regards,
Cong

