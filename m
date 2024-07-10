Return-Path: <bpf+bounces-34356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FEF92C9FB
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 06:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E141F23C7E
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 04:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9C5482C8;
	Wed, 10 Jul 2024 04:45:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C117529CE6;
	Wed, 10 Jul 2024 04:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720586718; cv=none; b=JzjhD2OV/PInCARo8k9ZXZE5FIPnpRuQyVweMKTwXeAHsgSsOBPD1P4JBC/bujWLkYf3R1qwNw6tTaNwM7SPIpKSkN6YE1Ve3cWZzgidG0epho0x/cK1axYxPAFk0zQ3E6y8qK5dREJuBvFU7xIDd55C3brYWDs0obsqXhNHgA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720586718; c=relaxed/simple;
	bh=JYApDXUCs7JJqzwwt3C3Uj5j8LGrqZZ2sqps6I6Z4/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6Ag3gUDUFdHVS+ECoTmMtcYNbAy0Ys4djSrPMxGsz6eFjp5JzKmsRoAtpW3rqBJkzVMcX3fIIQvZxeX1Ue4VyEA79RW4PwioQs5kELVsEagX8lHzVjYTbrsEc1r6yPWAf009fxF9dpoBJjgTSCBuwULdiqA3QpbE+AFrcXh1bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6e7b121be30so3363414a12.1;
        Tue, 09 Jul 2024 21:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720586716; x=1721191516;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N8f/vl9ZUkWJNXWkl4kW6AgkayOUPBh1tN2bBRKPUfk=;
        b=kpx69d+YGjaqQdDJ/yZ28FBW8Fe1Rl5BDu/3+Rpmine6Av9zdhUT6DgAUnwplzwhPM
         r968TjI/UBSrWB9XFUci6QBldFzsUnZJMnWmYLWI+JH2uMZYFdZex9+57uVIFAat3lLw
         CAbR1UEUBhVrqVqkJrMVOYl8kr/RPVm45o4u9lHdfwO4H7I2BSskylPMHgeGsFmdxx9x
         Gy4ghUPZCHo6IF+F8IDG0I6LStRJwH75qtUXiHhsffXF0Fnr8ptAOiNPJBlV/aLbG0ae
         HPUel3BJtw84W/M6RB2Jyd7Ofcr1ycNOoVsillcW4wxcWbliL5jnIsYKMaHnvZRtQWQQ
         NaZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRKCz77//ZX7wZDy1QuuzPXstaXUG3hOe7TqqaSTN/rDPxpgRD6sJuhpYZ8Kr0JwLiUmZTgZIoOpVGE/yGlR55dDEWzfbfvW4WoU4iNLr3ddiAYwiVE4bEuuIt
X-Gm-Message-State: AOJu0YwdMGh7TbrUsEdonL1WHeZ0BnsiBv+C5uPdJ95ep6LvzSFpeQp6
	vinbwou0fc9NHrJOCzRFXTa1Sw0JxhisiVN4iQ7/CWvAVG8eXZUma/JStZg=
X-Google-Smtp-Source: AGHT+IHWuTuIh2vu3X32nJEKUd6pHoJVhXW7ZrA3H0MuTL9yA63XEQGp+qkEsUwQsFkJcdjHLpJbTA==
X-Received: by 2002:a05:6a21:99a1:b0:1c2:8e77:a825 with SMTP id adf61e73a8af0-1c29820ed74mr5154327637.3.1720586715943;
        Tue, 09 Jul 2024 21:45:15 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca34e6e2d1sm2800160a91.19.2024.07.09.21.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 21:45:15 -0700 (PDT)
Date: Tue, 9 Jul 2024 21:45:15 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Julian Schindel <mail@arctic-alpaca.de>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>, bpf@vger.kernel.org,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org
Subject: Re: xdp/xsk.c: Possible bug in xdp_umem_reg version check
Message-ID: <Zo4R22FQeu_Ou7Gd@mini-arch>
References: <2d6ff64a-5e2c-4078-a8d1-84f1ff3361ce@arctic-alpaca.de>
 <CAJ8uoz0w9RhAk2v4G-FSzjOCqitCPhEXOC6c_PcOFr7PxTjbWg@mail.gmail.com>
 <485c0bfb-8202-4520-92e9-e2bbbf6ac89b@arctic-alpaca.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <485c0bfb-8202-4520-92e9-e2bbbf6ac89b@arctic-alpaca.de>

On 07/09, Julian Schindel wrote:
> On 09.07.24 11:23, Magnus Karlsson wrote:
> > On Sun, 7 Jul 2024 at 17:06, Julian Schindel <mail@arctic-alpaca.de> wrote:
> >> Hi,
> >>
> >> [...]
> > Thank you for reporting this Julian. This seems to be a bug. If I
> > check the value of sizeof(struct xdp_umem_reg_v2), I get 32 bytes too
> > on my system, compiling with gcc 11.4. I am not a compiler guy so do
> > not know what the rules are for padding structs, but I read the
> > following from [0]:
> >
> > "Pad the entire struct to a multiple of 64-bits if the structure
> > contains 64-bit types - the structure size will otherwise differ on
> > 32-bit versus 64-bit. Having a different structure size hurts when
> > passing arrays of structures to the kernel, or if the kernel checks
> > the structure size, which e.g. the drm core does."
> >
> > I compiled for 64-bits and I believe you did too, but we still get
> > this padding. 
> Yes, I did also compile for 64-bits. If I understood the resource you
> linked correctly, the compiler automatically adding padding to align to
> 64-bit boundaries is expected for 64-bit platforms:
> 
> "[...] 32-bit platforms don’t necessarily align 64-bit values to 64-bit
> boundaries, but 64-bit platforms do. So we always need padding to the
> natural size to get this right."
> > What is sizeof(struct xdp_umem_reg) for you before the
> > patch that added tx_metadata_len?
> I would expect this to be the same as sizeof(struct xdp_umem_reg_v2)
> after the patch. I'm not sure how to check this with different kernel
> versions.
> 
> Maybe the following code helps show all the sizes
> of xdp_umem_reg[_v1/_v2] on my system (compiled with "gcc test.c -o
> test" using gcc 14.1.1):
> 
> #include <stdio.h>
> #include <sys/types.h>
> 
> typedef __uint32_t __u32;
> typedef __uint64_t __u64;
> 
> struct xdp_umem_reg_v1  {
>     __u64 addr; /* Start of packet data area */
>     __u64 len; /* Length of packet data area */
>     __u32 chunk_size;
>     __u32 headroom;
> };
> 
> struct xdp_umem_reg_v2 {
>     __u64 addr; /* Start of packet data area */
>     __u64 len; /* Length of packet data area */
>     __u32 chunk_size;
>     __u32 headroom;
>     __u32 flags;
> };
> 
> struct xdp_umem_reg {
>     __u64 addr; /* Start of packet data area */
>     __u64 len; /* Length of packet data area */
>     __u32 chunk_size;
>     __u32 headroom;
>     __u32 flags;
>     __u32 tx_metadata_len;
> };
> 
> int main() {
>     printf("__u32: \t\t\t %lu\n", sizeof(__u32));
>     printf("__u64: \t\t\t %lu\n", sizeof(__u64));
>     printf("xdp_umem_reg_v1: \t %lu\n", sizeof(struct xdp_umem_reg_v1));
>     printf("xdp_umem_reg_v2: \t %lu\n", sizeof(struct xdp_umem_reg_v2));
>     printf("xdp_umem_reg: \t\t %lu\n", sizeof(struct xdp_umem_reg));
> }
> 
> Running "./test" produced this output:
> 
> __u32:                   4
> __u64:                   8
> xdp_umem_reg_v1:         24
> xdp_umem_reg_v2:         32
> xdp_umem_reg:            32
> > [0]: https://www.kernel.org/doc/html/v5.4/ioctl/botching-up-ioctls.html

Hmm, true, this means our version check won't really work :-/ I don't
see a good way to solve it without breaking the uapi. We can either
add some new padding field to xdp_umem_reg to make it larger than _v2.
Or we can add a new flag to signify the presence of tx_metadata_len
and do the validation based on that.

Btw, what are you using to setup umem? Looking at libxsk, it does
`memset(&mr, 0, sizeof(mr));` which should clear the padding as well.

