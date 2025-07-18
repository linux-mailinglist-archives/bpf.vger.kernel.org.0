Return-Path: <bpf+bounces-63699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE71B09B2C
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 08:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34BD11C43681
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 06:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035241F03EF;
	Fri, 18 Jul 2025 06:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VN1tv6kp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646A11E8837
	for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 06:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752819208; cv=none; b=NbPbHpHHdlqi+qZ0mXzlGKXbo7nx9i1cZT5XtMz5ErPxNugaf17eAKH4qLLDZyRE9NFBcyqNtHI1nhhZ83P1ovIEhBG2ZOYZOoSQpuKntQ/5q+5tErZDDQRwgA2XZU5rTbylAAam/795Jjxs8vkrO1y0y0PVW1BCBZCjlqKGLZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752819208; c=relaxed/simple;
	bh=dT8dD8otj7B8/N5DzES6KuvGUGVP7eX1fqLflWes/9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImpWRr3ibkqQ9rEUjrhuAI63sGiDiU6FK7KUoJ/hY1j3WYuh4b6TwGSg9q0U2Y6K95wOQlCu3AEvFgFO7cQ8PPyM2Nnasn4sEDf3mIkJ1PhKCxl8L/ejwpDQGcEeJ5jqbZHEQB3TkDdWKGue7TwI1iuKgkcNBO0aB1Tyszojoz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VN1tv6kp; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so1719142f8f.1
        for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 23:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752819204; x=1753424004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0IlwzZWHdXDZy8rSZ/n+rprYFpUaSyPSB2vYYWvhIK4=;
        b=VN1tv6kpYL09orhwn+Ag6sryHdXf3nHI0wjWJYp2cA6NbKARlAkLpIeijNHc1sJpfH
         hUZkOWJ5F4QaXhRfFljc+JWWVoIMNlnzggkj8y7aq8C0ZH9n27jqv31LrFyhnZN9F0w4
         X/yz25FL6JjgNcJnn7X8hSsMgbyhdziKpM4XomFKN/weP2eFk78oZo19y4lzz0WYy5lg
         fvERmRMFwMcp4k6MSMkCAtJKlJ4uRYSkieDji6AgqLx8H4ffv3FcWhTyxbgfXm5oVG0X
         v/SbnuUNhjLkhYuEcWDElB5W11QYmMWo8YlrqvHx8WIS0TuWmqSVhQB2R5KU1vSNqAv9
         ksHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752819204; x=1753424004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IlwzZWHdXDZy8rSZ/n+rprYFpUaSyPSB2vYYWvhIK4=;
        b=qbBBxfuRLlN5ItSOW44bqhnhi/BaBkq17dIcmN5PguVrzj81boYrsUhXe/opnBkMG0
         oCJVHwc3OEMQoD6/tPONQldnb6Vde37joMC1/WFM6Z0lPWM/pi7gHeENU20kTsso6aVf
         yzWMpDCDGSKQeUYuL6xKkI0tYCX320WA9f01ydr1m66ztiD7XkUc6CwX3OYeySQeK8GR
         G4ZyMwHRUexDNzxgsPXLQjL3iAV60btr2nTlQ1PZ4GeLqLBluHIWoR8zU/MCfQy1IUXx
         f08Kz45vRWkO9PFZ5NxFP1YH1P46SjP4tIghc9ffVyuTETdjH0yjqKsRKDvF2FMn6pYY
         3EFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzj9jDMq5qLBIMuqqwrapExuDsJ2uRAYNQwPydF7eDD1EfUk2/zX53cWSIPgereI1jCdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc49c6bYdqwRufs2k8zxrF1zX2W1Biaple8bcx9pBMOar8eZjX
	2joRRwA3CAyWPkXXB2JUOcCy719kAeV0coOIqLfRHQsmKIsDCjgxJvPlQ1emE/mQ86k=
X-Gm-Gg: ASbGncvR7BfCRK40E093MhoAdI2jovD9hOdnhZc5SfUIgLwJQhDJyhYtgPX4k0WfICN
	G4RQg4BbUtxZKH6RI1wDX6AyDUR4bH9xPq6lXOB+l8TxbQ3XX3LApm6bVozsn6Ib++cBXpT0D87
	tv+UYfEwaAkhDwsL1FJ6axFjVD5HFrXlDqsmmblIFUFoEMDPAEu12QHfHZHVvyJD6cfew/vpIs1
	kZMUQ6n1yXkNbknGrOCyMnNix6BgiYUaYe9RX1dVYR+iFDhohioZPGxrlHDhAVCjdlnPmDd8EuU
	n4AnWqmczmhujDVlga7WK/2yRKsioJfoXaA6yjpXwj9VHBoukAY+plmKaj9PeO3y+/Fc4DwGeyQ
	Kn1As/jyIVIk9wKqhuw==
X-Google-Smtp-Source: AGHT+IGYpCyf/XL+ilOaL8xDgNerjlJC6lG7TWjEG+3HrJvZLStqGqWpJ/kmeZdVkolJuAPRtCM1Fw==
X-Received: by 2002:adf:b651:0:b0:3a5:271e:c684 with SMTP id ffacd0b85a97d-3b619cd13eamr1530860f8f.24.1752819203556;
        Thu, 17 Jul 2025 23:13:23 -0700 (PDT)
Received: from u94a ([2401:e180:8dfc:69e4:fbdd:a670:1a68:e610])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6cfd8esm6187795ad.137.2025.07.17.23.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 23:13:23 -0700 (PDT)
Date: Fri, 18 Jul 2025 14:13:15 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH bpf-next v5 2/2] selftests/bpf: Add tests with stack ptr
 register in conditional jmp
Message-ID: <l4eujzpq73pu7ilrgfdiu3b3xpif7wyfcs3dleyci6yw4i6b5z@sx5c32oejbp6>
References: <20250524041335.4046126-1-yonghong.song@linux.dev>
 <20250524041340.4046304-1-yonghong.song@linux.dev>
 <4goguotzo5jh4224ox7oaan5l4mh2mt4y54j2bpbeba45umzws@7is5vdizr6m3>
 <9b41f9f5-396f-47e0-9a12-46c52087df6c@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b41f9f5-396f-47e0-9a12-46c52087df6c@linux.dev>

On Wed, Jul 16, 2025 at 09:05:05AM -0700, Yonghong Song wrote:
> On 7/16/25 3:13 AM, Shung-Hsi Yu wrote:
> > Hi Andrii and Yonghong,
> > 
> > On Fri, May 23, 2025 at 09:13:40PM -0700, Yonghong Song wrote:
> > > Add two tests:
> > >    - one test has 'rX <op> r10' where rX is not r10, and
> > >    - another test has 'rX <op> rY' where rX and rY are not r10
> > >      but there is an early insn 'rX = r10'.
> > > 
> > > Without previous verifier change, both tests will fail.
> > > 
> > > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > > ---
> > >   .../selftests/bpf/progs/verifier_precision.c  | 53 +++++++++++++++++++
> > >   1 file changed, 53 insertions(+)
> > I was looking this commit (5ffb537e416e) since it was a BPF selftest
> > test for CVE-2025-38279, but upon looking I found that the commit
> > differs from the patch, there is an extra hunk that changed
> > kernel/bpf/verifier.c that wasn't found the Yonghong's original patch.
> > 
> > I suppose it was meant to be squashed into the previous commit
> > e2d2115e56c4 "bpf: Do not include stack ptr register in precision
> > backtracking bookkeeping"?
> 
> Andrii made some change to my original patch for easy understanding.
> See
>   https://lore.kernel.org/bpf/20250524041335.4046126-1-yonghong.song@linux.dev
> Quoted below:
> "
> I've moved it inside the preceding if/else (twice), so it's more
> obvious that BPF_X deal with both src_reg and dst_reg, and BPF_K case
> deals only with BPF_K. The end result is the same, but I found this
> way a bit easier to follow. Applied to bpf-next, thanks.

Argh, indeed I missed the sibling thread. Thanks for point that out.

Shung-Hsi

...

