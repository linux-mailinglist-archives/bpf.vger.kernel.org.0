Return-Path: <bpf+bounces-53763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 661C4A5A65B
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 22:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15FBE3AC36A
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 21:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0FD1E3DDE;
	Mon, 10 Mar 2025 21:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npQ6uKy3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDCE1E0E05
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 21:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741643009; cv=none; b=M0oJJmFsLkSo8JC6G2PSeTQEHAELevJnyEH/C/mYhQ9Oq3JdUzpQamhbIG/wOO0Rcy9nuUh4A+ht8vMu8NLZSn52yak+S3dc/Za7aaBo3KsE8wMFIN5OhkUYCfPqXTZUeHaIPNFk53iZGFTPKYnZhDwVcvS4s3wDXRBATTpawEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741643009; c=relaxed/simple;
	bh=MYOks50WoDkdoyOrPCyipUL7n4yzFqH0q8gA8fGLCyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXg0OyPyQXBXEMm8xIbfnQKQRCbbp5AeU2wsei5HgB5BHgjk0AcVYkQZG/hAwCwJXiXvUp6+f8mmU4vMV+1/rXFu96xc5mygldbbIfPljazb+zlNNYSgmYAcOM7Cdmf2TrtVd/UA4usPE/usX04TTWurPDyXTp+GcZ7sSl2noZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npQ6uKy3; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22403cbb47fso90588175ad.0
        for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 14:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741643007; x=1742247807; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lOzTUQX1PxOvtdBltrj7hxyrhemHlWPuwAmT+cGIKWA=;
        b=npQ6uKy3WNfKOYitpnyfr2vJDzPui4Mr6/pmhu4gVsKN/FwucSNXkmVpoRt1wjlYry
         9zBGrc8lluUSxYgIt6iLtZQKuQzILpOBkAC2U7BwWo82fIpmQ247+LQs4ennJdb5Wk2S
         /Q8jnVJA7EToRYdyxfhOVz2R4fdDHMxZjr8MA8QQNibfRlYXZCifeC+Q6wJPiyIhGxKy
         2b9MMx5YPr8znChORTf6qYYw9NcWF/mYZJ9rJ83mSbUnESSQfuW3tJsCxwrlfXLgSDu6
         k/qm4kQw2lYZXOH2uI3NBGYXZu74CkVNSpFvUvFVnSQKJueKXKlYt7OudVtzweFVlIdK
         wvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741643007; x=1742247807;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lOzTUQX1PxOvtdBltrj7hxyrhemHlWPuwAmT+cGIKWA=;
        b=lpADJmqt/EiDlBWwvTNSgM4NL+CpOkXpno04eYrOnjiSFtngEaOlXJ9Ap6e5ZS0gq+
         jL4lSX7Xm2ZMsxaZ2ObF7WKA/qywwWRRts8KMz1VllJ7+NN57v+iL5rCFu0N7fVpKCJt
         fN4p5orefgZ9agmShckIwOFVIc8obYrBq1KyLQchOSESJILD+kcpSvw2dt7GCctcy0HQ
         EKKiOEarWySitJzn2nhntDdmj1spdSa5lFx4Eqz0LiXOX+kCys5vFgW5g92DpDJ1aNqS
         NFEjYI1gV5nn2vPAjRT6ZfUblaqaVj4aTJoei8ngUhwyB6PfkNexg+n8xE9YW2MBqK+G
         fyGQ==
X-Gm-Message-State: AOJu0Yz0pT6BmgWR0qr9A0UQZelKrPIFwg6AktT1ey/sCLz9laiBu00e
	pIJ9DZEdoK4ToBYUy/eXwIJwSAnqJdmzuWd1oLWKcQqSxBfiCNJO5gKprw==
X-Gm-Gg: ASbGncu8v4p7pclTKQLJEgjKu7s8IXMg1hu4IMkGdSThhX2w09GLmyfPMcwrLQpg3g1
	jNH76YCqcvvr83HARUo9mRCCD1rlzqLgdZD9jouX9KvvxsvB0XrdqjcYbWKe2BYp/agiS4qeeqK
	/MXpu+RPYAlAE33Vw0lA6Xl3aVIuqoQFtSqnCeva1OPXwOQPt1pTy13lVhihYxq+KCP0VGF1gDy
	H8IZ0dgt9sUifzBDZkpQfLu3S0Q7ch4URYVnqA9IHgHnMJXaLgxLgM4gt5vipe/95kNnW82lKX4
	i2glTZkcCzc02Jyom9RNkWB2aVF68d03+6fH8yGh/3HTsB7J
X-Google-Smtp-Source: AGHT+IFXLOvBDK4X9wfckI1WGUGqObmmijVRJTHS5odxNcOP7KVkt0gWd9EjluMvYqCdzJjttkoSSw==
X-Received: by 2002:a17:903:1b63:b0:220:d79f:60f1 with SMTP id d9443c01a7336-22428bd591fmr224360105ad.42.1741643005529;
        Mon, 10 Mar 2025 14:43:25 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736ad7e4448sm7037677b3a.111.2025.03.10.14.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 14:43:24 -0700 (PDT)
Date: Mon, 10 Mar 2025 14:43:23 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Vincent Li <vincent.mc.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, loongarch@lists.linux.dev
Subject: Re: [BUG?] loxilb tc BPF program cause Loongarch kernel hard lockup
Message-ID: <Z89c+5k3sRX8Al1I@pop-os.localdomain>
References: <CAK3+h2woEjG_N=-XzqEGaAeCmgu2eTCUc7p6bP4u8Q+DFHm-7g@mail.gmail.com>
 <Z8oXIhptXWhbCeCF@pop-os.localdomain>
 <CAK3+h2ys8ivcnnd=em7QZRWqqmtSuqy4xEiDoV6+9ccOzJHu4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK3+h2ys8ivcnnd=em7QZRWqqmtSuqy4xEiDoV6+9ccOzJHu4w@mail.gmail.com>

On Thu, Mar 06, 2025 at 08:04:14PM -0800, Vincent Li wrote:
> Sorry I had a type error on the loongarch mailing list address, corrected it.
> 
> On Thu, Mar 6, 2025 at 1:44 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > On Wed, Mar 05, 2025 at 04:51:15PM -0800, Vincent Li wrote:
> > > Hi,
> > >
> > > I have an issue recorded here [0] with kernel call trace  when I start
> > > loxilb, the loxilb tc BPF program seems to be loaded and attached to
> > > the network interface, but immediately it causes a loongarch kernel
> > > hard lockup, no keyboard response. Sometimes the panic call trace
> > > shows up in the monitor screen after I disabled kernel panic reboot
> > > (echo 0 > /proc/sys/kernel/panic) and started loxilb.
> > >
> > > Background: I ported open source IPFire [1] to Loongarch CPU
> > > architecture and enabled kernel BPF features, added loxilb as LFS
> > > (Linux from scratch) addon software, loxilb 0.9.8.3 has libbpf 1.5.0
> > > which has loongarch support [2]. The same loxilb addon runs fine on
> > > x86 architecture. Any clue on this?
> > >
> > > [0]: https://github.com/vincentmli/BPFire/issues/76
> > > [1]: https://github.com/ipfire/ipfire-2.x
> > > [2]: https://github.com/loxilb-io/loxilb/issues/972
> > >
> >
> > Thanks for your report!
> >
> > I have extracted the kernel crash log from your photo with AI so that
> > people can easily interpret it.
> >
> 
> Nice to know AI could do that :)
> 
> > From a quick glance, it seems related to MIPS JIT. So it would be
> > helpful if you could locate the eBPF program which triggered this and
> > dump its JIT'ed BPF instructions.
> >
> 
> This is call trace from Loongarch CPU so related to Loongarch BPF JIT.
> the kernel seems to lockup immediately right after attaching to the
> network interface. to dump the JIT'ed BPF instructions, maybe just
> load the BPF program, but not attach it so I can dump the BPF
> instructions?

Yes!

You can load the eBPF program which triggered the crash manually without
attaching it, using commands similar to the following:

# Load the program without attaching it
sudo bpftool prog load hello.o /sys/fs/bpf/hello

# List programs to find its ID
sudo bpftool prog list

# Dump JIT instructions (replace 123 with your actual program ID)
sudo bpftool prog dump jited id 123


Thanks.

