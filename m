Return-Path: <bpf+bounces-48927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF475A1235A
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 12:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E617D1890119
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 11:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC742475D4;
	Wed, 15 Jan 2025 11:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlSZTR1V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F6F2475CC;
	Wed, 15 Jan 2025 11:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736942317; cv=none; b=jeIeb+le6iyLVysdZ40/UGlUS2+pJ/lP0J5K0dEoMO0Sira+t0QgaItsRLcnCQsAQ4mntYz8IZh69nOYoQKq1gJv6/+qOgEcP3w8s/OLhHxVBDVLdP5AKSReiCKZO56ACBulGG2Jb5IY4qcj1hXy9tigUbXE9jpQVqXEBxAAmKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736942317; c=relaxed/simple;
	bh=sMl9f2LkaeCiTy2z2bfw5tskHF+O1pC5QN3LwdDdF7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7kgnDIk0qkZNFvCtGw09kOPryYnmd91S/ZlzsLAb16orinqC+1R/UPVjs3OHTBmKy/8ZzCFSp6kewv2jG4P43gPJGgAKLSjqNTfN36LRqvK3RwTuTB1V12clnQ9ew/EGTqzih1/rgBq0O+lXRz7luB3xexwOnUSxsXrVfu5nFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlSZTR1V; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21631789fcdso9168795ad.1;
        Wed, 15 Jan 2025 03:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736942315; x=1737547115; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1oZOXJlrtV3ptX1wxOX2lKlYPN9rLc+sd9YiORr12FU=;
        b=YlSZTR1V1jXT/CVKVms7ScRFJnMn2RzKSPA/JT6WvteLJSWQhoc5sxBMzwJmEi3YFP
         6dYygPL3bCjqMBmoFRxP0aeCvrEkwWmWruZ+26cOJyDr5QEw8UGer1NfBPTNXs6CLQnP
         uGr44gfSXPYMd5ggjW+G/G4zxMMKLU96YeKaYPxleOuWa4OsP9MuaG7C0cVPSyb76YZH
         FYUwfXs2zDDmdxRb23Prc1ORGulJTEXrXJpd+owHZ6GbcuPhqniMsfpkprdRtDumwoDi
         wzzo1WS4oUX73bRYxrcmlu8lkIs7SGE1BBYHqQg4mQdPJhbEE9WMemsg+WUr/kYShJPp
         gzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736942315; x=1737547115;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1oZOXJlrtV3ptX1wxOX2lKlYPN9rLc+sd9YiORr12FU=;
        b=jnhl2M75jGqovD94bS/fV8bN+mkQT22/ssZQmclr1fEDHIQi06vCG7qq5Pxhl867A1
         MsIsYWqiJy2Q0ShQXfzJ+vq63GtEwzYS14UjPpwD3pVi0xmJMjGYuzDAgQFwDCfT+wpI
         tLnmpY9nG8T5B/GDX8n7vgnRKkpQMIPvWTCCubH3XrrlL9uDYMNJAWxroGPKgI5vKoV/
         Yf+DtooB9iajEMi6qZbLDYv87v9lUs6uaO4QhzYeD4XadIeduxTR4a697mgg1aJP68c0
         HE6joUiXevIMvAhVFeDGON3avxefft63xWoMnd9KemrDiRbJ2sSTIEK1a8n6uo7pZXZn
         CHTg==
X-Forwarded-Encrypted: i=1; AJvYcCU3TkLI+85KgeiYHCogm1jfrHd3kXDYY5aqPdbHNm68jwLumrKtoWyM8rAVKRqg43ZrmiQUYbc0cr2cUxM=@vger.kernel.org, AJvYcCX8z7dSJvm5qfxLZCiUxaNCknYxWFf7AuEcch/OXC8o3BIJyGYXD2cWI7ACecCpABBzljs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFOMn4V4A9XkYffriXVItaqODUuCUKuVhHIQZS+tNTwSIfW0bW
	2fqKZwrocpTWLTGVtwlhnxcu+MGquxh5/wLBSBht/RMYJyitkE0I
X-Gm-Gg: ASbGncsYcjuYu/fGvENuALj7u2gx3suMHXAv8bzcVPvbkUJYd3vQqQZ9Z6j2jZl8ymD
	B4b8T3k3rYMKO263k82QhhtMiP6VBFhuFaDekDY70eyzH3AApx2AJXC8cyXcAdQGDTFtGkzxWZI
	yRtBiDMOsuOpZJNZeq8NVICkiBKZ6G8TgkDxLm4lS1Pxv6mcfAaEEv9WBbvfgfx1SR/EMoxT+Pw
	eiW94XtYY8X9gmIkJ/wFbbcQQWkrzAivjv1kDROO8MKi/Qo4nWvRQ==
X-Google-Smtp-Source: AGHT+IE85pf02XYgOqWJTk5Oj3SNAlQRq6+w4IfdCka+V3TtAHSmTn/vQXJogWGVmd93J6MlQ7VYDg==
X-Received: by 2002:a05:6a00:8c0b:b0:725:e386:3c5b with SMTP id d2e1a72fcca58-72d8c4ae2b5mr3989391b3a.5.1736942314520;
        Wed, 15 Jan 2025 03:58:34 -0800 (PST)
Received: from fedora ([2001:250:3c1e:503:ffff:ffff:ffaa:4903])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40567624sm8933101b3a.41.2025.01.15.03.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:58:33 -0800 (PST)
Date: Wed, 15 Jan 2025 19:58:27 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>,
	Amery Hung <ameryhung@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [RFC PATCH 08/22] ublk: bpf: add bpf struct_ops
Message-ID: <Z4ei40AVuX2sCTmE@fedora>
References: <20250107120417.1237392-1-tom.leiming@gmail.com>
 <20250107120417.1237392-9-tom.leiming@gmail.com>
 <CAADnVQLGw07CNpi7=XHJRgBL2ku7Q23nfah07pBc45G+xeTKxw@mail.gmail.com>
 <Z4SRrrXeoZ2MwH96@fedora>
 <CAADnVQK1y2A_-Co5Jx=eeusbcMbEgErxuPzgCqA0yvUU6Uw1CA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQK1y2A_-Co5Jx=eeusbcMbEgErxuPzgCqA0yvUU6Uw1CA@mail.gmail.com>

Hello Alexei,

On Mon, Jan 13, 2025 at 01:30:45PM -0800, Alexei Starovoitov wrote:
> On Sun, Jan 12, 2025 at 8:08 PM Ming Lei <tom.leiming@gmail.com> wrote:
> >
> > Hello Alexei,
> >
> > Thanks for your comments!
> >
> > On Thu, Jan 09, 2025 at 05:43:12PM -0800, Alexei Starovoitov wrote:
> > > On Tue, Jan 7, 2025 at 4:08 AM Ming Lei <tom.leiming@gmail.com> wrote:
> > > > +
> > > > +/* Return true if io cmd is queued, otherwise forward it to userspace */
> > > > +bool ublk_run_bpf_handler(struct ublk_queue *ubq, struct request *req,
> > > > +                         queue_io_cmd_t cb)
> > > > +{
> > > > +       ublk_bpf_return_t ret;
> > > > +       struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
> > > > +       struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
> > > > +       struct ublk_bpf_io *bpf_io = &data->bpf_data;
> > > > +       const unsigned long total = iod->nr_sectors << 9;
> > > > +       unsigned int done = 0;
> > > > +       bool res = true;
> > > > +       int err;
> > > > +
> > > > +       if (!test_bit(UBLK_BPF_IO_PREP, &bpf_io->flags))
> > > > +               ublk_bpf_prep_io(bpf_io, iod);
> > > > +
> > > > +       do {
> > > > +               enum ublk_bpf_disposition rc;
> > > > +               unsigned int bytes;
> > > > +
> > > > +               ret = cb(bpf_io, done);
> > >
> > > High level observation...
> > > I suspect forcing all sturct_ops callbacks to have only these
> > > two arguments and packing args into ublk_bpf_io
> > > will be limiting in the long term.
> >
> > There are three callbacks defined, and only the two with same type for
> > queuing io commands are covered in this function.
> >
> > But yes, callback type belongs to API, which should be designed
> > carefully, and I will think about further.
> >
> > >
> > > And this part of api would need to be redesigned,
> > > but since it's not an uapi... not a big deal.
> > >
> > > > +               rc = ublk_bpf_get_disposition(ret);
> > > > +
> > > > +               if (rc == UBLK_BPF_IO_QUEUED)
> > > > +                       goto exit;
> > > > +
> > > > +               if (rc == UBLK_BPF_IO_REDIRECT)
> > > > +                       break;
> > >
> > > Same point about return value processing...
> > > Each struct_ops callback could have had its own meaning
> > > of retvals.
> > > I suspect it would have been more flexible and more powerful
> > > this way.
> >
> > Yeah, I agree, just the 3rd callback of release_io_cmd_t isn't covered
> > in this function.
> >
> > >
> > > Other than that bpf plumbing looks good.
> > >
> > > There is an issue with leaking allocated memory in bpf_aio_alloc kfunc
> > > (it probably should be KF_ACQUIRE)
> >
> > It is one problem which troubles me too:
> >
> > - another callback of struct_ops/bpf_aio_complete_cb is guaranteed to be
> > called after the 'struct bpf_aio' instance is submitted via kfunc
> > bpf_aio_submit(), and it is supposed to be freed from
> > struct_ops/bpf_aio_complete_cb
> >
> > - but the following verifier failure is triggered if bpf_aio_alloc and
> > bpf_aio_release are marked as KF_ACQUIRE & KF_RELEASE.
> >
> > ```
> > libbpf: prog 'ublk_loop_comp_cb': -- BEGIN PROG LOAD LOG --
> > Global function ublk_loop_comp_cb() doesn't return scalar. Only those are supported.
> > ```
> 
> That's odd.
> Adding KF_ACQ/REL to bpf_aio_alloc/release kfuncs shouldn't affect
> verification of ublk_loop_comp_cb() prog. It's fine for it to stay 'void'
> return.
> You probably made it global function and that's was the reason for this
> verifier error. Global funcs have to return scalar for now.
> We can relax this restriction if necessary.

Looks marking ublk_loop_comp_cb() as static doesn't work:

[root@ktest-40 ublk]# make
  CLNG-BPF ublk_loop.bpf.o
  GEN-SKEL ublk_loop.skel.h
libbpf: relocation against STT_SECTION in non-exec section is not supported!
Error: failed to link '/root/git/linux/tools/testing/selftests/ublk/ublk_loop.bpf.o': Invalid argument (22)

But seems not big deal because we can change its return type to 'int'.

> 
> >
> > Here 'struct bpf_aio' instance isn't stored in map, and it is provided
> > from struct_ops callback(bpf_aio_complete_cb), I appreciate you may share
> > any idea about how to let KF_ACQUIRE/KF_RELEASE cover the usage here.
> 
> This is so that:
> 
> ublk_loop_comp_cb ->
>   ublk_loop_comp_and_release_aio ->
>     bpf_aio_release
> 
> would properly recognize that ref to aio is dropped?
> 
> Currently the verifier doesn't support that,
> but there is work in progress to add this feature:
> 
> https://lore.kernel.org/bpf/20241220195619.2022866-2-amery.hung@gmail.com/
> 
> then in cfi_stabs annotated bio argument in bpf_aio_complete_cb()
> as "struct bpf_aio *aio__ref"
> 
> Then the verifier will recognize that callback argument
> comes refcounted and the prog has to call KF_RELEASE kfunc on it.

This looks one very nice feature, thanks for sharing it!

I tried to apply the above patch and patch 3 on next tree and pass 'aio__ref' to the
callback cfi_stabs, but still failed:

[root@ktest-40 ublk]# ./test_loop_01.sh
libbpf: prog 'ublk_loop_comp_cb': BPF program load failed: -EINVAL
libbpf: prog 'ublk_loop_comp_cb': -- BEGIN PROG LOAD LOG --
0: R1=ctx() R10=fp0
; int BPF_PROG(ublk_loop_comp_cb, struct bpf_aio *aio, long ret) @ ublk_loop.c:34
0: (79) r7 = *(u64 *)(r1 +8)          ; R1=ctx() R7_w=scalar()
1: (79) r6 = *(u64 *)(r1 +0)
func 'bpf_aio_complete_cb' arg0 has btf_id 37354 type STRUCT 'bpf_aio'
2: R1=ctx() R6_w=trusted_ptr_bpf_aio()
; struct ublk_bpf_io *io = ublk_bpf_acquire_io_from_aio(aio); @ ublk_loop.c:24
2: (bf) r1 = r6                       ; R1_w=trusted_ptr_bpf_aio() R6_w=trusted_ptr_bpf_aio()
3: (85) call ublk_bpf_acquire_io_from_aio#43231       ; R0_w=ptr_ublk_bpf_io(ref_obj_id=1) refs=1
4: (bf) r8 = r0                       ; R0_w=ptr_ublk_bpf_io(ref_obj_id=1) R8_w=ptr_ublk_bpf_io(ref_obj_id=1) refs=1
; ublk_bpf_complete_io(io, ret); @ ublk_loop.c:26
5: (bf) r1 = r8                       ; R1_w=ptr_ublk_bpf_io(ref_obj_id=1) R8_w=ptr_ublk_bpf_io(ref_obj_id=1) refs=1
6: (bc) w2 = w7                       ; R2_w=scalar(smin=0,smax=umax=0xffffffff,var_off=(0x0; 0xffffffff)) R7_w=scalar() refs=1
7: (85) call ublk_bpf_complete_io#43241       ; refs=1
; ublk_bpf_release_io_from_aio(io); @ ublk_loop.c:27
8: (bf) r1 = r8                       ; R1_w=ptr_ublk_bpf_io(ref_obj_id=1) R8=ptr_ublk_bpf_io(ref_obj_id=1) refs=1
9: (85) call ublk_bpf_release_io_from_aio#43257       ;
; ublk_bpf_dettach_and_complete_aio(aio); @ ublk_loop.c:29
10: (bf) r1 = r6                      ; R1_w=trusted_ptr_bpf_aio() R6=trusted_ptr_bpf_aio()
11: (85) call ublk_bpf_dettach_and_complete_aio#43245         ;
; bpf_aio_release(aio); @ ublk_loop.c:30
12: (bf) r1 = r6                      ; R1_w=trusted_ptr_bpf_aio() R6=trusted_ptr_bpf_aio()
13: (85) call bpf_aio_release#95841
release kernel function bpf_aio_release expects refcounted PTR_TO_BTF_ID
processed 14 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
-- END PROG LOAD LOG --
libbpf: prog 'ublk_loop_comp_cb': failed to load: -EINVAL
libbpf: failed to load object 'ublk_loop.bpf.o'
fail to load bpf obj from ublk_loop.bpf.o
fail to register bpf prog loop ublk_loop.bpf.o



Thanks,
Ming

