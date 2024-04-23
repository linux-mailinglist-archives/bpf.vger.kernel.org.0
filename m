Return-Path: <bpf+bounces-27597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D888AFCCF
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 01:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B881C224EE
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 23:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20C2405FB;
	Tue, 23 Apr 2024 23:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jozxx6oZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C50367
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 23:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713916055; cv=none; b=fMGHw34DqzQnz2BPRqalyqjQ/f1rqevORLpEV5b/5bX7ei2i9YahUAmC1VoYdUbgMDCuf/FhpTJDxss9Vq7/n3QuSaqBWDEkCDjQ1NNDe7awvwRY7tqxUQCpS1KBcx3DQtCmoSAOdgdDdyVuVhUGuHAuq3pGsH3h6dnd/K+59t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713916055; c=relaxed/simple;
	bh=tKfD1Xf4nLj96AmEsPn+lKbpj98n420k4cJwM7aG/40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jA+Qthq4KXCRFw+w7bbRa5ZrOd6RB5D6+9oj6i0sqkvMaUXWxaH81w8cGHkiE0bMFmYYpnMQmvsdn62e142n99FFHJq4WdbQvOruHSTkotGaU9hLarfNCJa0fnIZSjTv4KvLVmzRvRb7hwEM0OvjEHRqe0BRgKnznG3JISk41YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jozxx6oZ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-344047ac7e4so194070f8f.0
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 16:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713916052; x=1714520852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLZME3VmDtAUhVlE1SgeGISkwzNOMyxQR/5LmDGWyik=;
        b=jozxx6oZav6QklfxG4Xs2iPhlKaSD2/jwOyGQXWaW1lDlBIJfwNsPBQ/7qPbK41rEy
         cY3j0NgeTAQ8ens9mNEvOYWUjM/9whx3aE6Cf0l+SkwxJtVoivBQUiO8E5fNN15xSV/P
         /dwtMXx0l6Bl1yeHuO28iPc7n7qvTR08Vtfan156NkYugpX55Igi+57/lM0lH+43nPfx
         PSqgCypGTuvNveCkVJPX25sAsBqrbR1fcRGDfIEx07YafIA6h/Rj/rgVvo2W25tu5z2E
         uzoZa4DJnwaSsBOqpvvus+fc9oG1SliYW2B2HpxDiOJFO9xS8qSGUVUHd9xzgdDTz+2p
         4PEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713916052; x=1714520852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLZME3VmDtAUhVlE1SgeGISkwzNOMyxQR/5LmDGWyik=;
        b=C9ztzSjL9E5i0FeuAXi1S1dR+RE9cxBlx5OdMsyNWjv/g+qzk98yh5P/cP5s2V+ezJ
         HtlnULxxkSRNscF4zPL6TikFWSuZWjm1DPf3G/J8kViBenSJvxwovPTEjGbVJbkkpVM0
         Wbsp/Fyn3BrWdg4wgxPxYSU8nTukREICxtZ7WK1OcoQQxPNM04fBVWY+9oshTaBlk5Cf
         kYFblh/cfr+H27pvfucPnHPPtVDABb5ieCn24vujn3xrE1ijc2QlFmlkLHS139BzB2AW
         uM8v2GCNV37Fu0CTLB4M8Ke+T3yRMvLeoRQZGnNt792ArdJLWKuWfiT31Bpt/R0lb3HL
         6AsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCl+kFaqgAorKwhzxQL9AmNhOvNHrzqnJXE67bu14NfToBemvLpebi31Ya2Di1qVajXpL4UbxMT5ypzDUavvna/uny
X-Gm-Message-State: AOJu0Yx8WLSxmexZM0t57NmGmSOG9amZJvNwrRNQjPqmZwmURJGyYgrh
	HJo+56JjDX2tRPCrniexUQuU3atgJn1T28TR2CyK9GeI9AkLDFmh4HQXIjQTa5m5ar+pT1d9p+a
	YvRjaixnaW3PIu0SyWr2LjNBufPY=
X-Google-Smtp-Source: AGHT+IGn+mJWwcR58W1J7lQbjot1jQ/WfMq21k5Y1AHjxq1XSSx1MP+Yshax5buqHsx9es0NTRG8ofPw/k8Co6pQAwU=
X-Received: by 2002:adf:f0cb:0:b0:349:e211:e4a5 with SMTP id
 x11-20020adff0cb000000b00349e211e4a5mr3000284wro.8.1713916051722; Tue, 23 Apr
 2024 16:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZhkbrM55MKQ0KeIV@google.com> <3f8a481e-0dfe-468f-8c87-6610528f9009@linux.dev>
 <ZiAu6YDi-F_pxLOV@google.com> <dbba17cf-4351-45ca-9f43-090a0923a2bb@linux.dev>
 <CAADnVQ+z5w4GaMudrLXw3LAq1B3Ong7FhQHdkJN7m8svkCpMgA@mail.gmail.com> <18bbc8d9-5a6b-4a7f-8805-d7565baf0d7c@linux.dev>
In-Reply-To: <18bbc8d9-5a6b-4a7f-8805-d7565baf0d7c@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 23 Apr 2024 16:47:20 -0700
Message-ID: <CAADnVQ+YowfQs9wLuPN2Rwi52x8rm+gwd+sxhrwPVi5PpaDikQ@mail.gmail.com>
Subject: Re: [RFC] bpf: allowing PTR_TO_BTF_ID | PTR_TRUSTED w/ non-zero fixed
 offset to selected KF_TRUSTED_ARGS BPF kfuncs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: David Vernet <void@manifault.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 3:16=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 4/18/24 8:03 PM, Alexei Starovoitov wrote:
> > On Wed, Apr 17, 2024 at 5:11=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >>
> >> On 4/17/24 1:19 PM, Matt Bobrowski wrote:
> >>> On Mon, Apr 15, 2024 at 09:43:42AM -0700, Yonghong Song wrote:
> >>>> On 4/12/24 4:31 AM, Matt Bobrowski wrote:
> >>>>> Hi,
> >>>>>
> >>>>> Currently, if a BPF kfunc has been annotated with KF_TRUSTED_ARGS, =
any
> >>>>> supplied PTR_TO_BTF_ID | PTR_TRUSTED argument to that BPF kfunc mus=
t
> >>>>> have it's fixed offset set to zero, or else the BPF program being
> >>>>> loaded will be outright rejected by the BPF verifier.
> >>>>>
> >>>>> This non-zero fixed offset restriction in most cases makes a lot of
> >>>>> sense, as it's considered to be a robust means of assuring that the
> >>>>> supplied PTR_TO_BTF_ID to the KF_TRUSTED_ARGS annotated BPF kfunc
> >>>>> upholds it's PTR_TRUSTED property. However, I believe that there ar=
e
> >>>>> also cases out there whereby a PTR_TO_BTF_ID | PTR_TRUSTED w/ a fix=
ed
> >>>>> offset can still be considered as something which posses the
> >>>>> PTR_TRUSTED property, and could be safely passed to a BPF kfunc tha=
t
> >>>>> is annotated w/ KF_TRUSTED_ARGS. I believe that this can particular=
ly
> >>>>> hold true for selected embedded data structure members present with=
in
> >>>>> given PTR_TO_BTF_ID | PTR_TRUSTED types i.e. struct
> >>>>> task_struct.thread_info, struct file.nf_path.
> >>>>>
> >>>>> Take for example the struct thread_info which is embedded within
> >>>>> struct task_struct. In a BPF program, if we happened to acquire a
> >>>>> PTR_TO_BTF_ID | PTR_TRUSTED for a struct task_struct via
> >>>>> bpf_get_current_task_btf(), and then constructed a pointer of type
> >>>>> struct thread_info which was assigned the address of the embedded
> >>>>> struct task_struct.thread_info member, we'd have ourselves a
> >>>>> PTR_TO_BTF_ID | PTR_TRUSTED w/ a fixed offset. Now, let's
> >>>>> hypothetically also say that we had a BPF kfunc that took a struct
> >>>>> thread_info pointer as an argument and the BPF kfunc was also
> >>>>> annotated w/ KF_TRUSTED_ARGS. If we attempted to pass the construct=
ed
> >>>>> PTR_TO_BTF_ID | PTR_TRUSTED w/ fixed offset to this hypothetical BP=
F
> >>>>> kfunc, the BPF program would be rejected by the BPF verifier. This =
is
> >>>>> irrespective of the fact that supplying pointers to such embedded d=
ata
> >>>>> structure members of a PTR_TO_BTF_ID | PTR_TRUSTED may be considere=
d
> >>>>> to be safe.
> >>>>>
> >>>>> One of the ideas that I had in mind to workaround the non-zero fixe=
d
> >>>>> offset restriction was to simply introduce a new BPF kfunc annotati=
on
> >>>>> i.e. __offset_allowed that could be applied on selected BPF kfunc
> >>>>> arguments that are expected to be KF_TRUSTED_ARGS. Such an annotati=
on
> >>>>> would effectively control whether we enforce the non-zero offset
> >>>>> restriction or not in check_kfunc_args(), check_func_arg_reg_off(),
> >>>>> and __check_ptr_off_reg(). Although, now I'm second guessing myself
> >>>>> and I am wondering whether introducing something like the
> >>>>> __offset_allowed annotation for BPF kfunc arguments could lead to
> >>>>> compromising any of the safety guarantees that are provided by the =
BPF
> >>>>> verifier. Does anyone see an immediate problem with using such an
> >>>>> approach? I raise concerns, because it feels like we're effectively
> >>>>> punching a hole in the BPF verifier, but it may also be perfectly s=
afe
> >>>>> to do on carefully selected PTR_TO_BTF_ID | PTR_TRUSTED types
> >>>>> i.e. struct thread_info, struct file, and it's just my paranoia
> >>>>> getting the better of me. Or, maybe someone has another idea to
> >>>>> support PTR_TO_BTF_ID | PTR_TRUSTED w/ fixed offset safely and a
> >>>>> little more generally without the need to actually make use of any
> >>>>> other BPF kfunc annotations?
> >>>> In verifier.c, we have BTF_TYPE_SAFE_TRUSTED to indidate that
> >>>> a pointer of a particular struct is safe and trusted if the point
> >>>> of that struct is trusted, e.g.,
> >>>>
> >>>> BTF_TYPE_SAFE_TRUSTED(struct file) {
> >>>>           struct inode *f_inode;
> >>>> };
> >>>>
> >>>> We do the above since gcc does not support btf_tag yet.
> >>> Yes, I'm rather familiar with this construct.
> >>>
> >>>> I guess you could do
> >>>>
> >>>> BTF_TYPE_SAFE_TRUSTED(struct file) {
> >>>>           struct path f_path;
> >>>> };
> >>>>
> >>>> and enhance verifier with the above information.
> >>>>
> >>>> But the above 'struct path f_path' may unnecessary
> >>>> consume extra memory since we only care about field
> >>>> 'f_path'. Maybe create a new construct like
> >>>>
> >>>> /* pointee is a field of the struct */
> >>>> BTF_TYPE_SAFE_FIELD_TRUSTED(struct file) {
> >>>>           struct path *f_path;
> >>>> };
> >>> I don't fully understand how something like
> >>> BTF_TYPE_SAFE_FIELD_TRUSTED could work in practice. Do you mind
> >>> elaborating on that a little?
> >>>
> >>> What I'm currently thinking is that with something like
> >>> BTF_TYPE_SAFE_FIELD_TRUSTED, if the BPF verifier sees a PTR_TO_BTF_ID
> >>> | PTR_TRUSTED w/ a fixed offset supplied to a BPF kfunc, then the BPF
> >>> verifier can also check that fixed offset for the supplied
> >>> PTR_TO_BTF_ID | PTR_TRUSTED actually accesses a member that has been
> >>> explicitly annotated as being trusted via
> >>> BTF_TYPE_SAFE_FIELD_TRUSTED. Maybe that would be better then making
> >>> use of an __offset_allowed annotation, which would solely rely on the
> >>> btf_struct_ids_match() check for its safety.
> >> Right. What you described in the above is what I think as well.
> > I believe BTF_TYPE_SAFE_* or __offset_allowed annotations
> > are not necessary.
> >
> > In this case thread_info is the first field of struct task_struct
> > and I suspect the verifier already allows:
> >
> > bpf_kfunc void do_stuff_with_thread(struct thread_info *ti) KF_TRUSTED_=
ARGS
> > and use it as:
> > task =3D bpf_get_current_task_btf();
> > do_stuff_with_thread(&task->thread_info);
> >
> > We have similar setup with:
> > struct bpf_cpumask {
> >          cpumask_t cpumask;
> > ...
> > };
> >
> > and kfunc that accepts trusted cpumask_t * will accept
> > trusted struct bpf_cpumask *.
> > The other way around should be rejected, of course.
> > Similar approach should work with file/path.
> > The only difference is that the offset will be non-zero.
> >
> > process_kf_arg_ptr_to_btf_id() needs to get smarter.
> >
> > David Vernet added that check:
> >
> > WARN_ON_ONCE(is_kfunc_trusted_args(meta) && reg->off);
> > as part of commit b613d335a743c.
> >
> > iirc the reg->off=3D=3D0 check is there, as an extra caution.
> >
> > We can allow off!=3D0 and it won't confuse btf_type_ids_nocast_alias.
> >
> >      struct  nf_conn___init {
> >              int another_field_at_off_zero;
> >              struct nf_conn ct;
> >      };
> >
> > will still trigger strict_type_match as expected.
> >
> > Maybe other places in the verifier need to get smarter too
> > to allow non-zero offset into kf_trusted_args.
>
> So IIUC, for a trusted pointer, any member or nested member
> access (without pointer tracing) is trusted.
> For example
>     struct p2 {
>        struct t1 *s1;
>        struct t2 s2;
>     };
>     struct p {
>        struct p1 f1;
>        struct p2 f2;
>        struct p3 f3;
>     }
>     struct p *trust_p;
>
> So here &trust_p->f1, &trust_p->f2, &trust_p->f3, &trust_p->f2.s2
> are all trusted, right?

Correct, but the verifier currently only allows to pass &trust_p->f1
as an argument.

