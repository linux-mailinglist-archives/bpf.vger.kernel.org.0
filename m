Return-Path: <bpf+bounces-34504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C472A92DEE2
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 05:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45DA21F223B7
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 03:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FEC1CF8F;
	Thu, 11 Jul 2024 03:48:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB253D0D0;
	Thu, 11 Jul 2024 03:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720669710; cv=none; b=X9LdS/w9ESffdrRZB1hspRqcjH4jvj3+ykP5PUPyXSQ60ABV+K/85VXDh9+yPadB1b55jtBMgGo5wcuFDy1qXxaDiv6OH+IR3wggAO+wBHfFpOvavlYhGn8GJN8GQcT0tZhdo7dPgJd9I7psaecIJ+vvymvgRGL78KNVlhLPFtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720669710; c=relaxed/simple;
	bh=gOTJkmxF92Ns5c107N+8cVVKfMtXu6t6sreVmPgMzUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bw7tChb1StV1/nYuU1X2Pm602MxESitDpaXS+hKNKky3yV16+ypE8PwcibZB4OWZIVSqc1nnTHlmXVtxUT/MknO0qf+idBRCE3RUAc2cMTW2s/J4bOEra49hdK5+pHsv+KabrnNiBlxDPKO2iAGGiYaLQK6MSceKC+TSQAVRwCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5c2011716a3so202919eaf.1;
        Wed, 10 Jul 2024 20:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720669707; x=1721274507;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6XtjgggXuxBdjdtm6uNds89QvL1RnCzQvhlpcncoTg=;
        b=dXW8/vky7z3VA8ITj/DCl9iDyTQuX7HCGeE12NDtHnlwEORZ8+cgMCSlJ+i8+po7hF
         klHHDoNbdwnEu3e7QB8idYOPg+mPn7+NJbC3xv0QVLbt09onLvhAEyNOHlTcEwQR1keb
         vCE6C3+CkYFLSho5iA2hsz9xch98S83smtwwbkwKA6LdxI/qxCQi/SDELsETffp28Pxm
         3L+YlisdPinVe2PuQx5iVSvu8Q+2V+YjCGj+EyeQ8W+2fhKaWuSID/+tU1y/miSgvFoc
         tHz4F5ZsifxgV9ym9vVlehfH7I9Pt+kElfQCjxXyJFP6vyPxiFlfcuHzlpzMOViXAi03
         LSmw==
X-Forwarded-Encrypted: i=1; AJvYcCVxAnEgW6ZF7fyDKlXfDuMrLRoJRchJjQJwu0DZIHXDOYU5A+18r1kMmXx4NZwiWv9Oa56dC6AWyxtPUfa88M4G1BP/cUC9IGazxFNlD8eqRg61u9W60dT6WmSa
X-Gm-Message-State: AOJu0YxpntgLZsW7a4qOxmlqjfVCYVHuV4do10O44sThySbfm65fdRV0
	GipHZJZg+uyOwhqSxQvXzoK7mY+kzd1aR6ijXGTsueWycRlZta0=
X-Google-Smtp-Source: AGHT+IH5P90Um39SA1lBlkJLyTOg2CLo+ErHr8VLL+sDR+/YiGBeDd2f8wYLZY1IMOSr9W6pkfMhcw==
X-Received: by 2002:a05:6359:4c85:b0:1ac:289d:a209 with SMTP id e5c5f4694b2df-1ac289da275mr538520455d.23.1720669707382;
        Wed, 10 Jul 2024 20:48:27 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aa8d106sm12721815a91.50.2024.07.10.20.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 20:48:26 -0700 (PDT)
Date: Wed, 10 Jul 2024 20:48:26 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Julian Schindel <mail@arctic-alpaca.de>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>, bpf@vger.kernel.org,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org
Subject: Re: xdp/xsk.c: Possible bug in xdp_umem_reg version check
Message-ID: <Zo9WCnMFSs775MSd@mini-arch>
References: <2d6ff64a-5e2c-4078-a8d1-84f1ff3361ce@arctic-alpaca.de>
 <CAJ8uoz0w9RhAk2v4G-FSzjOCqitCPhEXOC6c_PcOFr7PxTjbWg@mail.gmail.com>
 <485c0bfb-8202-4520-92e9-e2bbbf6ac89b@arctic-alpaca.de>
 <Zo4R22FQeu_Ou7Gd@mini-arch>
 <9f464c87-b211-4aa6-a77f-c0d6ea1c025f@arctic-alpaca.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f464c87-b211-4aa6-a77f-c0d6ea1c025f@arctic-alpaca.de>

On 07/10, Julian Schindel wrote:
> On 10.07.24 06:45, Stanislav Fomichev wrote:
> > On 07/09, Julian Schindel wrote:
> >> On 09.07.24 11:23, Magnus Karlsson wrote:
> >>> On Sun, 7 Jul 2024 at 17:06, Julian Schindel <mail@arctic-alpaca.de> wrote:
> >>>> Hi,
> >>>>
> >>>> [...]
> >>> Thank you for reporting this Julian. This seems to be a bug. If I
> >>> check the value of sizeof(struct xdp_umem_reg_v2), I get 32 bytes too
> >>> on my system, compiling with gcc 11.4. I am not a compiler guy so do
> >>> not know what the rules are for padding structs, but I read the
> >>> following from [0]:
> >>>
> >>> "Pad the entire struct to a multiple of 64-bits if the structure
> >>> contains 64-bit types - the structure size will otherwise differ on
> >>> 32-bit versus 64-bit. Having a different structure size hurts when
> >>> passing arrays of structures to the kernel, or if the kernel checks
> >>> the structure size, which e.g. the drm core does."
> >>>
> >>> I compiled for 64-bits and I believe you did too, but we still get
> >>> this padding. 
> >> Yes, I did also compile for 64-bits. If I understood the resource you
> >> linked correctly, the compiler automatically adding padding to align to
> >> 64-bit boundaries is expected for 64-bit platforms:
> >>
> >> "[...] 32-bit platforms don’t necessarily align 64-bit values to 64-bit
> >> boundaries, but 64-bit platforms do. So we always need padding to the
> >> natural size to get this right."
> >>> What is sizeof(struct xdp_umem_reg) for you before the
> >>> patch that added tx_metadata_len?
> >> I would expect this to be the same as sizeof(struct xdp_umem_reg_v2)
> >> after the patch. I'm not sure how to check this with different kernel
> >> versions.
> >>
> >> Maybe the following code helps show all the sizes
> >> of xdp_umem_reg[_v1/_v2] on my system (compiled with "gcc test.c -o
> >> test" using gcc 14.1.1):
> >>
> >> #include <stdio.h>
> >> #include <sys/types.h>
> >>
> >> typedef __uint32_t __u32;
> >> typedef __uint64_t __u64;
> >>
> >> struct xdp_umem_reg_v1  {
> >>     __u64 addr; /* Start of packet data area */
> >>     __u64 len; /* Length of packet data area */
> >>     __u32 chunk_size;
> >>     __u32 headroom;
> >> };
> >>
> >> struct xdp_umem_reg_v2 {
> >>     __u64 addr; /* Start of packet data area */
> >>     __u64 len; /* Length of packet data area */
> >>     __u32 chunk_size;
> >>     __u32 headroom;
> >>     __u32 flags;
> >> };
> >>
> >> struct xdp_umem_reg {
> >>     __u64 addr; /* Start of packet data area */
> >>     __u64 len; /* Length of packet data area */
> >>     __u32 chunk_size;
> >>     __u32 headroom;
> >>     __u32 flags;
> >>     __u32 tx_metadata_len;
> >> };
> >>
> >> int main() {
> >>     printf("__u32: \t\t\t %lu\n", sizeof(__u32));
> >>     printf("__u64: \t\t\t %lu\n", sizeof(__u64));
> >>     printf("xdp_umem_reg_v1: \t %lu\n", sizeof(struct xdp_umem_reg_v1));
> >>     printf("xdp_umem_reg_v2: \t %lu\n", sizeof(struct xdp_umem_reg_v2));
> >>     printf("xdp_umem_reg: \t\t %lu\n", sizeof(struct xdp_umem_reg));
> >> }
> >>
> >> Running "./test" produced this output:
> >>
> >> __u32:                   4
> >> __u64:                   8
> >> xdp_umem_reg_v1:         24
> >> xdp_umem_reg_v2:         32
> >> xdp_umem_reg:            32
> >>> [0]: https://www.kernel.org/doc/html/v5.4/ioctl/botching-up-ioctls.html
> > Hmm, true, this means our version check won't really work :-/ I don't
> > see a good way to solve it without breaking the uapi. We can either
> > add some new padding field to xdp_umem_reg to make it larger than _v2.
> > Or we can add a new flag to signify the presence of tx_metadata_len
> > and do the validation based on that.
> >
> > Btw, what are you using to setup umem? Looking at libxsk, it does
> > `memset(&mr, 0, sizeof(mr));` which should clear the padding as well.
> 
> I'm using "setsockopt" directly with Rust bindings and the C
> representation of Rust structs [1]. I'm guessing the compiler is not
> zeroing the padding, which is why I encountered the issue.
> 
> [1]:
> https://doc.rust-lang.org/reference/type-layout.html#the-c-representation

Awesome, thanks for confirming! I guess for now you can work it around
by having an explicit padding field and setting it to zero?

For a long-term fix, I'm leaning towards adding new umem flag as
a signal to the kernel to interpret this as a tx_metadata_len. But
this is gonna break any existing users that set this value. Hopefully
should not be a lot of them since it is a pretty recent functionality.

I'm also gonna sprinkle some compile time asserts to make sure we can extend
xdp_umem_reg in the future without hitting the same issue again. I'm a
bit spoiled by sys_bpf which takes care of enforcing the padding being
zero.

Magnus, any better ideas?

