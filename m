Return-Path: <bpf+bounces-8654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB1E788D3D
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185921C20FFA
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AEC17ACE;
	Fri, 25 Aug 2023 16:40:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F361079A
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 16:40:12 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA702121
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 09:40:10 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bcd7a207f7so16195971fa.3
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 09:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692981608; x=1693586408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6PRW/WZk/oyzjjs9Hl5hWuReyCC0VusjHkNVN5a+l4=;
        b=NiOXwa77CwX2Oa22AWZeXFazw51STOqnOhaqxDIZEPlrd7igCZd/q/S6wBSXRb87YZ
         zTm9Dw4Qj4aEQs3CxOLOfTEmPsRH0yA+jeybVKh+zInHnP/RnXhc7PJI6+5IZVcMgsZx
         Xudl6GMfyVITBA84XrmiObyjiOFip9hX3bgxEh7QPWDAjwGfua/ar9TRVtLOOHYk2WlF
         fWxUy5fd8vwQJwsTTKigHad70SiuaEk8TqMgMEtqZ/o20BCOL2Cn6jAzofYQESnKUfuU
         9/F/3LcndaoH5rq1okSCBgjQRzSk6cP2oNDIcH682WLr3IUycTDk1D2ZvkDOti083nwd
         ha1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692981608; x=1693586408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k6PRW/WZk/oyzjjs9Hl5hWuReyCC0VusjHkNVN5a+l4=;
        b=Lwh1PDv6uio5nhMgJ9dkZnbG+Z3Uz5cN/wcbNgZ8OsDPI5o/2ZbB8Rqgey9+G5YUNe
         H9nnwkns9Q3eC0py5xKpgYl3rz0aCX1CevFAtsve+LBaBJQnvZf57Q/OUen5+cAr+5JA
         v45c1r06owereNN7PzhFilckZ+x6O+pRIeYLTOqC1L2K+oz3JJd4SmxhpLSwHaDkj3KQ
         71e4abaTZlQGz3dLQv+u4rmhuXFa1PiUSnfxkqbntNEEhO2T+p5T03qdR3JZq1/k/e0T
         aKkUCYyW19QO6bB2XchxDlgaJO2febpLCNiFFlHxPW4PpEFHV26kYibXYYU3cJ7zLahV
         f/aA==
X-Gm-Message-State: AOJu0Yxp5wjRoJq9oNduTG3H80VFqCOGEQ5XjONv2y6CD+nHBvbRUZGg
	PBcoEzOkNI1NYoP5XKjywDOsW7d+PIlPF4GdMk4=
X-Google-Smtp-Source: AGHT+IHpobBh7yHaNGF4B3pOez3ev+DkkYNh9xq351Tvk3EZUP4mGFPBwPaXDL3CJID1XxQlCjaBExeJTqxSNcBfhGw=
X-Received: by 2002:a2e:3016:0:b0:2b6:dc55:c3c7 with SMTP id
 w22-20020a2e3016000000b002b6dc55c3c7mr15318198ljw.20.1692981608013; Fri, 25
 Aug 2023 09:40:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824220907.1172808-1-awerner32@gmail.com> <ce26e0c1-7d05-1572-dfc9-10d251fde86f@iogearbox.net>
In-Reply-To: <ce26e0c1-7d05-1572-dfc9-10d251fde86f@iogearbox.net>
From: Andrew Werner <awerner32@gmail.com>
Date: Fri, 25 Aug 2023 12:39:56 -0400
Message-ID: <CA+vRuzPsN=1xgvAaP6PrMaiLb7U+B5g1t2eBSnqZRC-XQ2EkzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] libbpf: handle producer position overflow
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org, kernel-team@dataexmachina.dev, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, olsajiri@gmail.com, 
	houtao@huaweicloud.com, void@manifault.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 25, 2023 at 11:28=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> On 8/25/23 12:09 AM, Andrew Werner wrote:
> > Before this patch, the producer position could overflow `unsigned
> > long`, in which case libbpf would forever stop processing new writes to
> > the ringbuf. Similarly, overflows of the producer position could result
> > in __bpf_user_ringbuf_peek not discovering available data. This patch
> > addresses that bug by computing using the signed delta between the
> > consumer and producer position to determine if data is available; the
> > delta computation is robust to overflow.
> >
> > A more defensive check could be to ensure that the delta is within
> > the allowed range, but such defensive checks are neither present in
> > the kernel side code nor in libbpf. The overflow that this patch
> > handles can occur while the producer and consumer follow a correct
> > protocol.
> >
> > Secondarily, the type used to represent the positions in the
> > user_ring_buffer functions in both libbpf and the kernel has been
> > changed from u64 to unsigned long to match the type used in the
> > kernel's representation of the structure. The change occurs in the
>
> Hm, but won't this mismatch for 64bit kernel and 32bit user space? Why
> not fixate both on u64 instead so types are consistent?

Sure. It feels like if we do that then we'd break existing 32bit
big-endian clients, though I am not sure those exist. Concretely, the
request here would be to change the kernel structure and all library
usages to use u64, right?

>
> > same patch because it's required to align the data availability
> > calculations between the userspace producing ringbuf and the bpf
> > producing ringbuf.
> >
> > Not included in this patch, a selftest was written to demonstrate the
> > bug, and indeed this patch allows the test to continue to make progress
> > past the overflow. The shape of the self test was as follows:
> >
> >   a) Set up ringbuf of 2GB size (the maximum permitted size).
> >   b) reserve+commit maximum-sized records (ULONG_MAX/4) constantly as
> >      fast as possible.
> >
> > With 1 million records per second repro time should be about 4.7 hours.
> > Such a test duration is impractical to run, hence the omission.
> >
> > Additionally, this patch adds commentary around a separate point to not=
e
> > that the modular arithmetic is valid in the face of overflows, as that
> > fact may not be obvious to future readers.
> >
> > v2->v3:
> >    - Changed the representation of the consumer and producer positions
> >      from u64 to unsigned long in user_ring_buffer functions.
> >    - Addressed overflow in __bpf_user_ringbuf_peek.
> >    - Changed data availability computations to use the signed delta
> >      between the consumer and producer positions rather than merely
> >      checking whether their values were unequal.
> > v1->v2:
> >    - Fixed comment grammar.
> >    - Properly formatted subject line.
> >
> > Signed-off-by: Andrew Werner <awerner32@gmail.com>
> > ---
> >   kernel/bpf/ringbuf.c    | 11 ++++++++---
> >   tools/lib/bpf/ringbuf.c | 16 +++++++++++++---
> >   2 files changed, 21 insertions(+), 6 deletions(-)
> >
> > diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> > index f045fde632e5..0c48673520fb 100644
> > --- a/kernel/bpf/ringbuf.c
> > +++ b/kernel/bpf/ringbuf.c
> > @@ -658,7 +658,7 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringb=
uf *rb, void **sample, u32 *s
> >   {
> >       int err;
> >       u32 hdr_len, sample_len, total_len, flags, *hdr;
> > -     u64 cons_pos, prod_pos;
> > +     unsigned long cons_pos, prod_pos;
> >
> >       /* Synchronizes with smp_store_release() in user-space producer. =
*/
> >       prod_pos =3D smp_load_acquire(&rb->producer_pos);
> > @@ -667,7 +667,12 @@ static int __bpf_user_ringbuf_peek(struct bpf_ring=
buf *rb, void **sample, u32 *s
> >
> >       /* Synchronizes with smp_store_release() in __bpf_user_ringbuf_sa=
mple_release() */
> >       cons_pos =3D smp_load_acquire(&rb->consumer_pos);
> > -     if (cons_pos >=3D prod_pos)
> > +
> > +     /* Check if there's data available by computing the signed delta =
between
> > +      * cons_pos and prod_pos; a negative delta indicates that the con=
sumer has
> > +      * not caught up. This formulation is robust to prod_pos wrapping=
 around.
> > +      */
> > +     if ((long)(cons_pos - prod_pos) >=3D 0)
> >               return -ENODATA;
> >
> >       hdr =3D (u32 *)((uintptr_t)rb->data + (uintptr_t)(cons_pos & rb->=
mask));
> > @@ -711,7 +716,7 @@ static int __bpf_user_ringbuf_peek(struct bpf_ringb=
uf *rb, void **sample, u32 *s
> >
> >   static void __bpf_user_ringbuf_sample_release(struct bpf_ringbuf *rb,=
 size_t size, u64 flags)
> >   {
> > -     u64 consumer_pos;
> > +     unsigned long consumer_pos;
> >       u32 rounded_size =3D round_up(size + BPF_RINGBUF_HDR_SZ, 8);
> >
> >       /* Using smp_load_acquire() is unnecessary here, as the busy-bit
> > diff --git a/tools/lib/bpf/ringbuf.c b/tools/lib/bpf/ringbuf.c
> > index 02199364db13..141030a89370 100644
> > --- a/tools/lib/bpf/ringbuf.c
> > +++ b/tools/lib/bpf/ringbuf.c
> > @@ -237,7 +237,13 @@ static int64_t ringbuf_process_ring(struct ring *r=
)
> >       do {
> >               got_new_data =3D false;
> >               prod_pos =3D smp_load_acquire(r->producer_pos);
> > -             while (cons_pos < prod_pos) {
> > +
> > +             /* Check if there's data available by computing the signe=
d delta
> > +              * between cons_pos and prod_pos; a negative delta indica=
tes that the
> > +              * consumer has not caught up. This formulation is robust=
 to prod_pos
> > +              * wrapping around.
> > +              */
> > +             while ((long)(cons_pos - prod_pos) < 0) {
> >                       len_ptr =3D r->data + (cons_pos & r->mask);
> >                       len =3D smp_load_acquire(len_ptr);
> >
> > @@ -482,8 +488,7 @@ void user_ring_buffer__submit(struct user_ring_buff=
er *rb, void *sample)
> >   void *user_ring_buffer__reserve(struct user_ring_buffer *rb, __u32 si=
ze)
> >   {
> >       __u32 avail_size, total_size, max_size;
> > -     /* 64-bit to avoid overflow in case of extreme application behavi=
or */
> > -     __u64 cons_pos, prod_pos;
> > +     unsigned long cons_pos, prod_pos;
> >       struct ringbuf_hdr *hdr;
> >
> >       /* The top two bits are used as special flags */
> > @@ -498,6 +503,11 @@ void *user_ring_buffer__reserve(struct user_ring_b=
uffer *rb, __u32 size)
> >       prod_pos =3D smp_load_acquire(rb->producer_pos);
> >
> >       max_size =3D rb->mask + 1;
> > +
> > +     /* Note that this formulation is valid in the face of overflow of
> > +      * prod_pos so long as the delta between prod_pos and cons_pos is
> > +      * no greater than max_size.
> > +      */
> >       avail_size =3D max_size - (prod_pos - cons_pos);
> >       /* Round up total size to a multiple of 8. */
> >       total_size =3D (size + BPF_RINGBUF_HDR_SZ + 7) / 8 * 8;
> >
>

