Return-Path: <bpf+bounces-48976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA08A12C4D
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 21:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35C83A4B6A
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 20:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDDA1D8A12;
	Wed, 15 Jan 2025 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzRxQ/an"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368408F77;
	Wed, 15 Jan 2025 20:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736971892; cv=none; b=eBkHHOtdtVg33D+72S1W2iqGZBsNUCmiPuPVZ4Er8vvb7qfj+0qBUXa7i1JY3UEuZ4z/WdKAwuOI2qU48Z+26LIi4ZnfBAnJbR3pudRX7BZnnCEV44u0W7sEdRHG9uHnVIj4wWLc2L1/gFUAql9IshnMW9RPdrTq62LAW7pYsgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736971892; c=relaxed/simple;
	bh=UJHUB6xenh99+cna4Ly/ZUCK/cKJpLXrSOm+Ec0KnC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EExOekJR9F74obrqLV3cAnTLY3NqlxhmYsS5WTEX94ejdWsvImgC11FaPpewy/ZwJ8BdD3J31vDJ1VJOd/ZlJMiNFbmR/sMNpsB+wUWgdVYQO0vNcl2KtLQT8kkWvpmNHV/fBVrjB4dPfLqfwRkaa5C00zdgjKZFrde0OCowa60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzRxQ/an; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e398484b60bso283120276.1;
        Wed, 15 Jan 2025 12:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736971890; x=1737576690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laim8/9UAupt27studit1kxx/RItSqDasN0QPLFpyDI=;
        b=LzRxQ/anqz6bTmYTg+my+zOZfwZEYMAprD26ZKbzEl5H+VCLi9UQAvviz5kH3l19s+
         STlsh+GagSezYbWXCVm2eNbROJPVTJzGNMnpo7rqBv+9fc9GXQLRNSpWg0lNDvKLuFD4
         vkGgzLuj2tK6j8TLZwUY36ZKnkSM/Sy6c1GcEBL3Y4VNMWWRD0NOIc3X3GlaebztKBks
         KspN9B/s8xiPPTN7GFpwUPs5F8AadbRVtAGf3X0KKbETMcdJajE+x3gSTG9mz2vg0IxE
         /6PfAQUHwne4KSGoeVOrn3FJx0UFH8B9F0XPzhhgiCSwUx+TBwM2hB9sc+0P2+g96ehg
         YV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736971890; x=1737576690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laim8/9UAupt27studit1kxx/RItSqDasN0QPLFpyDI=;
        b=jnt2Y5005AcT50AnBBRi2XHdZLUhIztsZH7wXsRBOFuVTOpQ8AUu31uThb7N1L7zCL
         YIyM2Gr3c4DLjfdaJtI2wC1DReOQpISGxjtg6qlE+tTEUmP98s08GYxzyW2TP69X6deo
         N7VkHWYS7tQL0WJgligddDr35bic9PixvpsmqJN9RgNcS3B5O0vaHP/28HfqBB8KsFUi
         bxGXFBeMnat0coi3CebhRL63mVkhHFy/eAscNmh9hukN4hcTWmR5000JeHRHkhQuk5mr
         IBsAttHx97ESvM31VM0CQto17Z/nDHcFnO1o8KLF8wJxZ1f3D2QoIlPcGehddiFyVah2
         ltbA==
X-Forwarded-Encrypted: i=1; AJvYcCW13fQjtZCbNVoFUhWOXuFHK4sf8S6uapvxmI26p/y1wOXotlMTlEHqTb75Y/Q+KSWvrdQ=@vger.kernel.org, AJvYcCXZXgKkessjNzmQhjwCxC0u0mdKp4OOe7Da/5So2+WEkNT+ahasQOGBWhn9kzTMI6fX6U22uo5Hi/HlsA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYpLVDVHp3f/3MiIbxmtJ8IoTAw7BHyP0bdUzg+Gywm6MzVnak
	RJPzwtgYuCe3FqQ9or5Rwi5RyptRXWI0MpWoksuneF9NAwFn+WileH5x/b10H8MnZJU+eLrRWr9
	3n7NSyhSUw8uiDIZsf/CbN7UnlfE=
X-Gm-Gg: ASbGnctqe/Ry2onPjBTyyAdoRktv7pB3aChSC6II/tvkTe1B18EffevG+e7vHhlDNjT
	g5YWHm46klVhSKJdec8fYv4i/W4KNNRmaGKr75w==
X-Google-Smtp-Source: AGHT+IHgwmPiUVSToDDK9ff6gjG/h8zsRSDbZoz0SBRDKXhcdTXP5yOfqBsihgWRymjuB0NBeqradGjUR0awx1dyJnk=
X-Received: by 2002:a25:1e57:0:b0:e39:85e3:1069 with SMTP id
 3f1490d57ef6-e54ee23f091mr17840404276.47.1736971889923; Wed, 15 Jan 2025
 12:11:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107120417.1237392-1-tom.leiming@gmail.com>
 <20250107120417.1237392-9-tom.leiming@gmail.com> <CAADnVQLGw07CNpi7=XHJRgBL2ku7Q23nfah07pBc45G+xeTKxw@mail.gmail.com>
 <Z4SRrrXeoZ2MwH96@fedora> <CAADnVQK1y2A_-Co5Jx=eeusbcMbEgErxuPzgCqA0yvUU6Uw1CA@mail.gmail.com>
 <Z4ei40AVuX2sCTmE@fedora>
In-Reply-To: <Z4ei40AVuX2sCTmE@fedora>
From: Amery Hung <ameryhung@gmail.com>
Date: Wed, 15 Jan 2025 12:11:19 -0800
X-Gm-Features: AbW1kva9MVLiCtr54c3DhYIktsZ-aCl5KYQbzcpm8RnaNo_FN1eoEDEd-wSs3iU
Message-ID: <CAMB2axPBGk3HZJ6wtLtM1+CUtUznDAtd=sm5a6ESTHvOiuEMLw@mail.gmail.com>
Subject: Re: [RFC PATCH 08/22] ublk: bpf: add bpf struct_ops
To: Ming Lei <tom.leiming@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 3:58=E2=80=AFAM Ming Lei <tom.leiming@gmail.com> wr=
ote:
>
> Hello Alexei,
>
> On Mon, Jan 13, 2025 at 01:30:45PM -0800, Alexei Starovoitov wrote:
> > On Sun, Jan 12, 2025 at 8:08=E2=80=AFPM Ming Lei <tom.leiming@gmail.com=
> wrote:
> > >
> > > Hello Alexei,
> > >
> > > Thanks for your comments!
> > >
> > > On Thu, Jan 09, 2025 at 05:43:12PM -0800, Alexei Starovoitov wrote:
> > > > On Tue, Jan 7, 2025 at 4:08=E2=80=AFAM Ming Lei <tom.leiming@gmail.=
com> wrote:
> > > > > +
> > > > > +/* Return true if io cmd is queued, otherwise forward it to user=
space */
> > > > > +bool ublk_run_bpf_handler(struct ublk_queue *ubq, struct request=
 *req,
> > > > > +                         queue_io_cmd_t cb)
> > > > > +{
> > > > > +       ublk_bpf_return_t ret;
> > > > > +       struct ublk_rq_data *data =3D blk_mq_rq_to_pdu(req);
> > > > > +       struct ublksrv_io_desc *iod =3D ublk_get_iod(ubq, req->ta=
g);
> > > > > +       struct ublk_bpf_io *bpf_io =3D &data->bpf_data;
> > > > > +       const unsigned long total =3D iod->nr_sectors << 9;
> > > > > +       unsigned int done =3D 0;
> > > > > +       bool res =3D true;
> > > > > +       int err;
> > > > > +
> > > > > +       if (!test_bit(UBLK_BPF_IO_PREP, &bpf_io->flags))
> > > > > +               ublk_bpf_prep_io(bpf_io, iod);
> > > > > +
> > > > > +       do {
> > > > > +               enum ublk_bpf_disposition rc;
> > > > > +               unsigned int bytes;
> > > > > +
> > > > > +               ret =3D cb(bpf_io, done);
> > > >
> > > > High level observation...
> > > > I suspect forcing all sturct_ops callbacks to have only these
> > > > two arguments and packing args into ublk_bpf_io
> > > > will be limiting in the long term.
> > >
> > > There are three callbacks defined, and only the two with same type fo=
r
> > > queuing io commands are covered in this function.
> > >
> > > But yes, callback type belongs to API, which should be designed
> > > carefully, and I will think about further.
> > >
> > > >
> > > > And this part of api would need to be redesigned,
> > > > but since it's not an uapi... not a big deal.
> > > >
> > > > > +               rc =3D ublk_bpf_get_disposition(ret);
> > > > > +
> > > > > +               if (rc =3D=3D UBLK_BPF_IO_QUEUED)
> > > > > +                       goto exit;
> > > > > +
> > > > > +               if (rc =3D=3D UBLK_BPF_IO_REDIRECT)
> > > > > +                       break;
> > > >
> > > > Same point about return value processing...
> > > > Each struct_ops callback could have had its own meaning
> > > > of retvals.
> > > > I suspect it would have been more flexible and more powerful
> > > > this way.
> > >
> > > Yeah, I agree, just the 3rd callback of release_io_cmd_t isn't covere=
d
> > > in this function.
> > >
> > > >
> > > > Other than that bpf plumbing looks good.
> > > >
> > > > There is an issue with leaking allocated memory in bpf_aio_alloc kf=
unc
> > > > (it probably should be KF_ACQUIRE)
> > >
> > > It is one problem which troubles me too:
> > >
> > > - another callback of struct_ops/bpf_aio_complete_cb is guaranteed to=
 be
> > > called after the 'struct bpf_aio' instance is submitted via kfunc
> > > bpf_aio_submit(), and it is supposed to be freed from
> > > struct_ops/bpf_aio_complete_cb
> > >
> > > - but the following verifier failure is triggered if bpf_aio_alloc an=
d
> > > bpf_aio_release are marked as KF_ACQUIRE & KF_RELEASE.
> > >
> > > ```
> > > libbpf: prog 'ublk_loop_comp_cb': -- BEGIN PROG LOAD LOG --
> > > Global function ublk_loop_comp_cb() doesn't return scalar. Only those=
 are supported.
> > > ```
> >
> > That's odd.
> > Adding KF_ACQ/REL to bpf_aio_alloc/release kfuncs shouldn't affect
> > verification of ublk_loop_comp_cb() prog. It's fine for it to stay 'voi=
d'
> > return.
> > You probably made it global function and that's was the reason for this
> > verifier error. Global funcs have to return scalar for now.
> > We can relax this restriction if necessary.
>
> Looks marking ublk_loop_comp_cb() as static doesn't work:
>
> [root@ktest-40 ublk]# make
>   CLNG-BPF ublk_loop.bpf.o
>   GEN-SKEL ublk_loop.skel.h
> libbpf: relocation against STT_SECTION in non-exec section is not support=
ed!
> Error: failed to link '/root/git/linux/tools/testing/selftests/ublk/ublk_=
loop.bpf.o': Invalid argument (22)
>
> But seems not big deal because we can change its return type to 'int'.
>
> >
> > >
> > > Here 'struct bpf_aio' instance isn't stored in map, and it is provide=
d
> > > from struct_ops callback(bpf_aio_complete_cb), I appreciate you may s=
hare
> > > any idea about how to let KF_ACQUIRE/KF_RELEASE cover the usage here.
> >
> > This is so that:
> >
> > ublk_loop_comp_cb ->
> >   ublk_loop_comp_and_release_aio ->
> >     bpf_aio_release
> >
> > would properly recognize that ref to aio is dropped?
> >
> > Currently the verifier doesn't support that,
> > but there is work in progress to add this feature:
> >
> > https://lore.kernel.org/bpf/20241220195619.2022866-2-amery.hung@gmail.c=
om/
> >
> > then in cfi_stabs annotated bio argument in bpf_aio_complete_cb()
> > as "struct bpf_aio *aio__ref"
> >
> > Then the verifier will recognize that callback argument
> > comes refcounted and the prog has to call KF_RELEASE kfunc on it.
>
> This looks one very nice feature, thanks for sharing it!
>
> I tried to apply the above patch and patch 3 on next tree and pass 'aio__=
ref' to the
> callback cfi_stabs, but still failed:
>
> [root@ktest-40 ublk]# ./test_loop_01.sh
> libbpf: prog 'ublk_loop_comp_cb': BPF program load failed: -EINVAL
> libbpf: prog 'ublk_loop_comp_cb': -- BEGIN PROG LOAD LOG --
> 0: R1=3Dctx() R10=3Dfp0
> ; int BPF_PROG(ublk_loop_comp_cb, struct bpf_aio *aio, long ret) @ ublk_l=
oop.c:34
> 0: (79) r7 =3D *(u64 *)(r1 +8)          ; R1=3Dctx() R7_w=3Dscalar()
> 1: (79) r6 =3D *(u64 *)(r1 +0)
> func 'bpf_aio_complete_cb' arg0 has btf_id 37354 type STRUCT 'bpf_aio'
> 2: R1=3Dctx() R6_w=3Dtrusted_ptr_bpf_aio()
> ; struct ublk_bpf_io *io =3D ublk_bpf_acquire_io_from_aio(aio); @ ublk_lo=
op.c:24
> 2: (bf) r1 =3D r6                       ; R1_w=3Dtrusted_ptr_bpf_aio() R6=
_w=3Dtrusted_ptr_bpf_aio()
> 3: (85) call ublk_bpf_acquire_io_from_aio#43231       ; R0_w=3Dptr_ublk_b=
pf_io(ref_obj_id=3D1) refs=3D1
> 4: (bf) r8 =3D r0                       ; R0_w=3Dptr_ublk_bpf_io(ref_obj_=
id=3D1) R8_w=3Dptr_ublk_bpf_io(ref_obj_id=3D1) refs=3D1
> ; ublk_bpf_complete_io(io, ret); @ ublk_loop.c:26
> 5: (bf) r1 =3D r8                       ; R1_w=3Dptr_ublk_bpf_io(ref_obj_=
id=3D1) R8_w=3Dptr_ublk_bpf_io(ref_obj_id=3D1) refs=3D1
> 6: (bc) w2 =3D w7                       ; R2_w=3Dscalar(smin=3D0,smax=3Du=
max=3D0xffffffff,var_off=3D(0x0; 0xffffffff)) R7_w=3Dscalar() refs=3D1
> 7: (85) call ublk_bpf_complete_io#43241       ; refs=3D1
> ; ublk_bpf_release_io_from_aio(io); @ ublk_loop.c:27
> 8: (bf) r1 =3D r8                       ; R1_w=3Dptr_ublk_bpf_io(ref_obj_=
id=3D1) R8=3Dptr_ublk_bpf_io(ref_obj_id=3D1) refs=3D1
> 9: (85) call ublk_bpf_release_io_from_aio#43257       ;
> ; ublk_bpf_dettach_and_complete_aio(aio); @ ublk_loop.c:29
> 10: (bf) r1 =3D r6                      ; R1_w=3Dtrusted_ptr_bpf_aio() R6=
=3Dtrusted_ptr_bpf_aio()
> 11: (85) call ublk_bpf_dettach_and_complete_aio#43245         ;
> ; bpf_aio_release(aio); @ ublk_loop.c:30
> 12: (bf) r1 =3D r6                      ; R1_w=3Dtrusted_ptr_bpf_aio() R6=
=3Dtrusted_ptr_bpf_aio()
> 13: (85) call bpf_aio_release#95841
> release kernel function bpf_aio_release expects refcounted PTR_TO_BTF_ID
> processed 14 insns (limit 1000000) max_states_per_insn 0 total_states 1 p=
eak_states 1 mark_read 1
> -- END PROG LOAD LOG --
> libbpf: prog 'ublk_loop_comp_cb': failed to load: -EINVAL
> libbpf: failed to load object 'ublk_loop.bpf.o'
> fail to load bpf obj from ublk_loop.bpf.o
> fail to register bpf prog loop ublk_loop.bpf.o
>

Hi Ming,

Your stub function signature does not look quite right.

It should be <struct_ops_name>__<op_name>, hence:
static void bpf_aio_complete_ops__bpf_aio_complete_cb(struct bpf_aio
*io__ref, long ret)

For more detail, look at find_stub_func_proto().

Thanks,
Amery

>
>
> Thanks,
> Ming

