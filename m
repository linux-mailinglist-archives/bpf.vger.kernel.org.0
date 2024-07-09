Return-Path: <bpf+bounces-34231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF9592B7A5
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 13:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2B50B26599
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 11:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213A4158219;
	Tue,  9 Jul 2024 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arctic-alpaca.de header.i=@arctic-alpaca.de header.b="jz1wKStT"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8894F27713;
	Tue,  9 Jul 2024 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524321; cv=none; b=YVI/7F8OBEttlBiXamIXQ0cV/Ay+1ohupgWI2fvoBvHEsj4KGzpV7ERBoybKtMiZ5Av0YMJ5BIwW11HUPRn23CUKsXpSNpGeRxkjbkXamzlgkdYCb63ELi6nnXfOqfVdDhsE3J5dsLZPUz5/WMBn9VvbMpqq+ag/dqbp6eJGOI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524321; c=relaxed/simple;
	bh=3F6bqFEIOuMwXy24x2PpWtHMmyE1IyroOu/jdiac+sA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gtTKkoBmeizPBhM7Inq/f2Q7QeOukyRdMIEHM5miGdN36D7KjoRXTyBflIRSbin58xyT7yqGgf7PBJiYG/aet68TIw/7CgdtgSDo6zC2I5L/8OgvJP9CZW/vWPwIZo+Vlz6dRdfZYxyD9HZ1PwvanssqeTnpyFHF/THnwTWsR30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arctic-alpaca.de; spf=pass smtp.mailfrom=arctic-alpaca.de; dkim=pass (2048-bit key) header.d=arctic-alpaca.de header.i=@arctic-alpaca.de header.b=jz1wKStT; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arctic-alpaca.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arctic-alpaca.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WJJZ03Dyqz9sm8;
	Tue,  9 Jul 2024 13:25:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arctic-alpaca.de;
	s=MBO0001; t=1720524312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0pg5AiKR0vtXHBDG1/5/r2GQ65kYrGGtYs6SvUEbETY=;
	b=jz1wKStTofsC5ynfcZIwGUGng+MtAqblSuQf/EmkK/MALL6bIwFlzsK4GdGHmoKNb3QM7l
	rZlG76JmJbIxbq2o1moDaFnkft49M9r9F59fGQ2w5QojD4fCAwu9CpKzRc1EDY+xUTZuYN
	VPcyrl7GIdrDJR6UkJAbgAjo7KJUxsMHZTadfUMu9euSQUpbMEdZByeT2F7WcTcFMouzB7
	FgI8N2Q28BTIceD/ICpqs7ptkcBzod/Y2YgPDe7ogN9QsfZxN7u1lDIuaPOQyLHGuMlbhL
	KCxO1OlOE2hLAw+cZ4lF8HMkN9M2F1zNSNF4OtiBg7kiMg2nlGWBMMOGgAkC2A==
Message-ID: <485c0bfb-8202-4520-92e9-e2bbbf6ac89b@arctic-alpaca.de>
Date: Tue, 9 Jul 2024 13:25:09 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: xdp/xsk.c: Possible bug in xdp_umem_reg version check
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: bpf@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org
References: <2d6ff64a-5e2c-4078-a8d1-84f1ff3361ce@arctic-alpaca.de>
 <CAJ8uoz0w9RhAk2v4G-FSzjOCqitCPhEXOC6c_PcOFr7PxTjbWg@mail.gmail.com>
Content-Language: de-DE, en-US
From: Julian Schindel <mail@arctic-alpaca.de>
In-Reply-To: <CAJ8uoz0w9RhAk2v4G-FSzjOCqitCPhEXOC6c_PcOFr7PxTjbWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09.07.24 11:23, Magnus Karlsson wrote:
> On Sun, 7 Jul 2024 at 17:06, Julian Schindel <mail@arctic-alpaca.de> wrote:
>> Hi,
>>
>> [...]
> Thank you for reporting this Julian. This seems to be a bug. If I
> check the value of sizeof(struct xdp_umem_reg_v2), I get 32 bytes too
> on my system, compiling with gcc 11.4. I am not a compiler guy so do
> not know what the rules are for padding structs, but I read the
> following from [0]:
>
> "Pad the entire struct to a multiple of 64-bits if the structure
> contains 64-bit types - the structure size will otherwise differ on
> 32-bit versus 64-bit. Having a different structure size hurts when
> passing arrays of structures to the kernel, or if the kernel checks
> the structure size, which e.g. the drm core does."
>
> I compiled for 64-bits and I believe you did too, but we still get
> this padding. 
Yes, I did also compile for 64-bits. If I understood the resource you
linked correctly, the compiler automatically adding padding to align to
64-bit boundaries is expected for 64-bit platforms:

"[...] 32-bit platforms don’t necessarily align 64-bit values to 64-bit
boundaries, but 64-bit platforms do. So we always need padding to the
natural size to get this right."
> What is sizeof(struct xdp_umem_reg) for you before the
> patch that added tx_metadata_len?
I would expect this to be the same as sizeof(struct xdp_umem_reg_v2)
after the patch. I'm not sure how to check this with different kernel
versions.

Maybe the following code helps show all the sizes
of xdp_umem_reg[_v1/_v2] on my system (compiled with "gcc test.c -o
test" using gcc 14.1.1):

#include <stdio.h>
#include <sys/types.h>

typedef __uint32_t __u32;
typedef __uint64_t __u64;

struct xdp_umem_reg_v1  {
    __u64 addr; /* Start of packet data area */
    __u64 len; /* Length of packet data area */
    __u32 chunk_size;
    __u32 headroom;
};

struct xdp_umem_reg_v2 {
    __u64 addr; /* Start of packet data area */
    __u64 len; /* Length of packet data area */
    __u32 chunk_size;
    __u32 headroom;
    __u32 flags;
};

struct xdp_umem_reg {
    __u64 addr; /* Start of packet data area */
    __u64 len; /* Length of packet data area */
    __u32 chunk_size;
    __u32 headroom;
    __u32 flags;
    __u32 tx_metadata_len;
};

int main() {
    printf("__u32: \t\t\t %lu\n", sizeof(__u32));
    printf("__u64: \t\t\t %lu\n", sizeof(__u64));
    printf("xdp_umem_reg_v1: \t %lu\n", sizeof(struct xdp_umem_reg_v1));
    printf("xdp_umem_reg_v2: \t %lu\n", sizeof(struct xdp_umem_reg_v2));
    printf("xdp_umem_reg: \t\t %lu\n", sizeof(struct xdp_umem_reg));
}

Running "./test" produced this output:

__u32:                   4
__u64:                   8
xdp_umem_reg_v1:         24
xdp_umem_reg_v2:         32
xdp_umem_reg:            32
> [0]: https://www.kernel.org/doc/html/v5.4/ioctl/botching-up-ioctls.html
>> Best regards,
>> Julian


