Return-Path: <bpf+bounces-34521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BC092E1B5
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 10:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8394E1F23C1A
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 08:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5B8155741;
	Thu, 11 Jul 2024 08:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVsx/G7x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17BA14039D;
	Thu, 11 Jul 2024 08:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685477; cv=none; b=Mmnjemx0dgVdawGyEPh/WiQ4tSliFoZEeEmMByU3Hcx7rmS58IlPePBobjCsRvTVcJDd9vUAIzesmsneyeoju160H36mcTWgrB5S92QwRztGuE+hpxYhjamZOnVvN3JsW5ErzaOKOdRwPuJm1S9oNztXqYiWbYdG4NQDQQqwY6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685477; c=relaxed/simple;
	bh=MaOZXybpLtfNi4CwnExZdqtdtqtyX2to/UDVSw5qmLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CyCNFxF2UbnOnq4j8r/ifRDB2Tiu89zpnyZ24/qT9FDl8ayTsr5GcNWd0X7dWsdJgiZ81PuGkDTNeAQWOnnR/SuINskuSgDNC5pXBFr8tuYlyJtkwF121x4LROwctWUCThznwVVg+uEZ/G1VSVzRFCFKxmNySZDvrOMtkE0NchQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVsx/G7x; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6b5eb60f710so444856d6.1;
        Thu, 11 Jul 2024 01:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720685474; x=1721290274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKd5hnpqdwc3kLkLZ4fs6zVZ2Wrjh5fWr/qYF5YK788=;
        b=EVsx/G7xun9ewDJfXwRU4jUchPSmDqNUYxwRPDH5pKjdKpgGMHz1TJ2IKIt9WkmCiI
         0Rt3/D5j9z60TqC6j0V0mfI6RWHllN8kfVWYOxHstIqytwHvNtakncwsLjMK4UYSxF18
         qGg+XhiHOrypczSp3fFhhdSs+yMV+Nivyne5fraPlM+gYkdPngYchY9aVAItEa5PjE95
         7Ni3qrH3FBo7DRaH0jH2Lxifqba0gX7RUNGTJ7zUfqkAN5GMWn5j4/HNRNp/0KztcnuD
         lVRjGCTea7aZQLFLc5E+FR93QiXo3AhOJ2bdtyKPGA+Olwf5ifpmFpKPCqxXir79ayoX
         MJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720685474; x=1721290274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKd5hnpqdwc3kLkLZ4fs6zVZ2Wrjh5fWr/qYF5YK788=;
        b=jU8FHaQ5czifR+ZCIG+cgOfPSAV3oxCPb7Vxw1o6scU/LT2J+bUQNsWq1w9AIIcmJx
         L5R4y6xQAM3ijE3mRbUwBHWKXniLyhah03gTLwfXAjbG2VsmGW/S22jDMsxoaJ8DiQzU
         oPWKIK3bdYUFXaL+sUHTxlA4unPTLdz+WAdlUGOGs1dp4sx9wE9IQUIMHmecN/NIUK2v
         YiwRS8PW2IMKORFuhvCyf6LjHgBZPL9f0k79bANvPDQIf3K9E61LvT4olyz/D8Jt01nN
         bgOH2bzmm/P9zdyxEBiFgbd9IxNgS5l3q6zY5bOaBYXxA95dUk1D7//2ATldtayY7Ljy
         TrqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw9CTmE1SmN50l/ePprpvSLfyCPn2h16Uy3SZ6ZMZs7h1jxcgQDGn/dtVXhAvx+JTHZ9rMGWYNoIsaGHzy3+QNtvbAhiir1PcwlXPz18Na47ygozvb3FrU3FG7
X-Gm-Message-State: AOJu0Yz0CaI149RDvimUxyIyNabc850g9xPz8KfsSU+jS6Fk/RBBjWNm
	eFmC+/ci30+SjTKzJ8gPZeBUrEvNKnfoeDjNpxC7q8gTSUYLD9tYFHgqoNw0TLpyhb9lgztm5tS
	OoxIqAEfLogqOfV1Lv9Yf01dagx4=
X-Google-Smtp-Source: AGHT+IG64BPMmubnVqFBVPofyrLVkS5dOgbYCeYODMcePEI+Fw+vfGPHYpSpBhazIG8hPIjE0mFJsTaBHvORelqo4r0=
X-Received: by 2002:a05:6214:aa8:b0:6b5:ddf3:c142 with SMTP id
 6a1803df08f44-6b74b2178f2mr18663216d6.5.1720685474472; Thu, 11 Jul 2024
 01:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2d6ff64a-5e2c-4078-a8d1-84f1ff3361ce@arctic-alpaca.de>
 <CAJ8uoz0w9RhAk2v4G-FSzjOCqitCPhEXOC6c_PcOFr7PxTjbWg@mail.gmail.com>
 <485c0bfb-8202-4520-92e9-e2bbbf6ac89b@arctic-alpaca.de> <Zo4R22FQeu_Ou7Gd@mini-arch>
 <9f464c87-b211-4aa6-a77f-c0d6ea1c025f@arctic-alpaca.de> <Zo9WCnMFSs775MSd@mini-arch>
In-Reply-To: <Zo9WCnMFSs775MSd@mini-arch>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Thu, 11 Jul 2024 10:11:03 +0200
Message-ID: <CAJ8uoz2AMN1y0kXqR2-uguPVHObekM0654M71GBzM4D1LmsMBg@mail.gmail.com>
Subject: Re: xdp/xsk.c: Possible bug in xdp_umem_reg version check
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: Julian Schindel <mail@arctic-alpaca.de>, bpf@vger.kernel.org, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Jul 2024 at 05:48, Stanislav Fomichev <sdf@fomichev.me> wrote:
>
> On 07/10, Julian Schindel wrote:
> > On 10.07.24 06:45, Stanislav Fomichev wrote:
> > > On 07/09, Julian Schindel wrote:
> > >> On 09.07.24 11:23, Magnus Karlsson wrote:
> > >>> On Sun, 7 Jul 2024 at 17:06, Julian Schindel <mail@arctic-alpaca.de=
> wrote:
> > >>>> Hi,
> > >>>>
> > >>>> [...]
> > >>> Thank you for reporting this Julian. This seems to be a bug. If I
> > >>> check the value of sizeof(struct xdp_umem_reg_v2), I get 32 bytes t=
oo
> > >>> on my system, compiling with gcc 11.4. I am not a compiler guy so d=
o
> > >>> not know what the rules are for padding structs, but I read the
> > >>> following from [0]:
> > >>>
> > >>> "Pad the entire struct to a multiple of 64-bits if the structure
> > >>> contains 64-bit types - the structure size will otherwise differ on
> > >>> 32-bit versus 64-bit. Having a different structure size hurts when
> > >>> passing arrays of structures to the kernel, or if the kernel checks
> > >>> the structure size, which e.g. the drm core does."
> > >>>
> > >>> I compiled for 64-bits and I believe you did too, but we still get
> > >>> this padding.
> > >> Yes, I did also compile for 64-bits. If I understood the resource yo=
u
> > >> linked correctly, the compiler automatically adding padding to align=
 to
> > >> 64-bit boundaries is expected for 64-bit platforms:
> > >>
> > >> "[...] 32-bit platforms don=E2=80=99t necessarily align 64-bit value=
s to 64-bit
> > >> boundaries, but 64-bit platforms do. So we always need padding to th=
e
> > >> natural size to get this right."
> > >>> What is sizeof(struct xdp_umem_reg) for you before the
> > >>> patch that added tx_metadata_len?
> > >> I would expect this to be the same as sizeof(struct xdp_umem_reg_v2)
> > >> after the patch. I'm not sure how to check this with different kerne=
l
> > >> versions.
> > >>
> > >> Maybe the following code helps show all the sizes
> > >> of xdp_umem_reg[_v1/_v2] on my system (compiled with "gcc test.c -o
> > >> test" using gcc 14.1.1):
> > >>
> > >> #include <stdio.h>
> > >> #include <sys/types.h>
> > >>
> > >> typedef __uint32_t __u32;
> > >> typedef __uint64_t __u64;
> > >>
> > >> struct xdp_umem_reg_v1  {
> > >>     __u64 addr; /* Start of packet data area */
> > >>     __u64 len; /* Length of packet data area */
> > >>     __u32 chunk_size;
> > >>     __u32 headroom;
> > >> };
> > >>
> > >> struct xdp_umem_reg_v2 {
> > >>     __u64 addr; /* Start of packet data area */
> > >>     __u64 len; /* Length of packet data area */
> > >>     __u32 chunk_size;
> > >>     __u32 headroom;
> > >>     __u32 flags;
> > >> };
> > >>
> > >> struct xdp_umem_reg {
> > >>     __u64 addr; /* Start of packet data area */
> > >>     __u64 len; /* Length of packet data area */
> > >>     __u32 chunk_size;
> > >>     __u32 headroom;
> > >>     __u32 flags;
> > >>     __u32 tx_metadata_len;
> > >> };
> > >>
> > >> int main() {
> > >>     printf("__u32: \t\t\t %lu\n", sizeof(__u32));
> > >>     printf("__u64: \t\t\t %lu\n", sizeof(__u64));
> > >>     printf("xdp_umem_reg_v1: \t %lu\n", sizeof(struct xdp_umem_reg_v=
1));
> > >>     printf("xdp_umem_reg_v2: \t %lu\n", sizeof(struct xdp_umem_reg_v=
2));
> > >>     printf("xdp_umem_reg: \t\t %lu\n", sizeof(struct xdp_umem_reg));
> > >> }
> > >>
> > >> Running "./test" produced this output:
> > >>
> > >> __u32:                   4
> > >> __u64:                   8
> > >> xdp_umem_reg_v1:         24
> > >> xdp_umem_reg_v2:         32
> > >> xdp_umem_reg:            32
> > >>> [0]: https://www.kernel.org/doc/html/v5.4/ioctl/botching-up-ioctls.=
html
> > > Hmm, true, this means our version check won't really work :-/ I don't
> > > see a good way to solve it without breaking the uapi. We can either
> > > add some new padding field to xdp_umem_reg to make it larger than _v2=
.
> > > Or we can add a new flag to signify the presence of tx_metadata_len
> > > and do the validation based on that.
> > >
> > > Btw, what are you using to setup umem? Looking at libxsk, it does
> > > `memset(&mr, 0, sizeof(mr));` which should clear the padding as well.
> >
> > I'm using "setsockopt" directly with Rust bindings and the C
> > representation of Rust structs [1]. I'm guessing the compiler is not
> > zeroing the padding, which is why I encountered the issue.
> >
> > [1]:
> > https://doc.rust-lang.org/reference/type-layout.html#the-c-representati=
on
>
> Awesome, thanks for confirming! I guess for now you can work it around
> by having an explicit padding field and setting it to zero?
>
> For a long-term fix, I'm leaning towards adding new umem flag as
> a signal to the kernel to interpret this as a tx_metadata_len. But
> this is gonna break any existing users that set this value. Hopefully
> should not be a lot of them since it is a pretty recent functionality.
>
> I'm also gonna sprinkle some compile time asserts to make sure we can ext=
end
> xdp_umem_reg in the future without hitting the same issue again. I'm a
> bit spoiled by sys_bpf which takes care of enforcing the padding being
> zero.
>
> Magnus, any better ideas?

Unfortunately not. This is a pest or cholera kind of choice. I agree
with you that the least bad choice here is to break it for the users
of this new functionality as they should be fewer than all the
existing users that do not use the Tx metadata functionality. Really
appreciate your suggestions to put some compile time asserts in there
to make sure we do not make the same mistake again. Thanks.

