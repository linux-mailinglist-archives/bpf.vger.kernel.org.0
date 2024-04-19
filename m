Return-Path: <bpf+bounces-27198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D348AA712
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 05:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 885761F21C21
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 03:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271375664;
	Fri, 19 Apr 2024 03:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNzWOnYR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFD51C2D
	for <bpf@vger.kernel.org>; Fri, 19 Apr 2024 03:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713495837; cv=none; b=f0y8wfcSCclufac5Ug77Sohu44V8qVX8OoHKd3haCWAsVocpg+fDyoWFxGiEHyPzrHnpQ6fPBQTzHPb4f+27ZczGc1GhZFS6kwv/ozAM8uXxl1txChpa1Vr0sC9Qaz7hisnqrYTWzh4/s/z+L1YkUDfZM5Gxcmc1dRroeQnaSgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713495837; c=relaxed/simple;
	bh=EFkxad9O5jYYRcMcf2Z0Oz7BijGK+CHAs7X62FEDLYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTtUa1Oi0uu+b3EvKZYuPhp1RJ3hOcLQUX6OvQWqmt411Usats6bdEMHHo0ORE68dRkIfS3YdjPYgfb1e+Zm3DqB6DP3p2JJiieMxFj6xoSeaH9P98nw8Y+N4q3jrsLRZKUI2FIviAlHhBN+BpGKZo6rGx0UIppPHu6ssXycx08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNzWOnYR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-418e06c0ef4so14822325e9.0
        for <bpf@vger.kernel.org>; Thu, 18 Apr 2024 20:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713495834; x=1714100634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QA71R0TzDAIthzLW4s5MRvQRdoWciMPHxYDItdStD70=;
        b=YNzWOnYRYhkGnLmrS2U77E9IJ8RBDTEoSfd5vInq8/Emc8MGMKm9BixB2VRa8L7nS3
         VVoWvo8uQthjyROj7ATk86rBwRbjPqu5u4owLmeWmlHfbJz9aCtmJ32nx9o+OpcTv2iI
         I4bXRuyqQOAFOESpgNu3GEFEX/nUNHWd8ObXneCeaIpeRZqzz3W2RNtJKtktx+hmx3vl
         fMGcDkLaz1C29c2i26ZLvCZEZt7/+rogg3z7A4reBAbSuR/khBn6ZqkwNCQIEZEKgwbT
         tiWVXORk4JKwcataHoI1VUbucddsUeKEIwJe8ytfYgVSgL5KGe9D1zgsp3cCmfh8ZOeM
         D56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713495834; x=1714100634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QA71R0TzDAIthzLW4s5MRvQRdoWciMPHxYDItdStD70=;
        b=mBXKXEFJBr7juA5bPQbvkfhNHW9JLbB6mFPE00j9EqcsTOMLdNnre3L8wfrTYbspeb
         OAc6jW3DBx5dDtadPKTWPWKFcx/7Zh9D5l4x2ZDHbn5KyKQn5+nUODpV1GJ94pBTp+rg
         B3SAXYxgfidus6w+VufO1UpB7oO8fRLLzGne2V4VhDlg7Sf6qGNUx8BnWw1RgvZTQHzG
         tlvkiMJfYIT32d+UMXxnTHjDj/297qYIu7Yx277B4ZTYMZU9z3lJrx2O4ba/LiuWGdgW
         KOck9dqFRmq95G628QzMRxWBTC5946kqKFwHAbrUEfI2/7jPoWx8wUCWAnrw0h1hAomA
         3BlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4dMJ8DTpVsrpxqxpRcAZBbtbqE3avFzumSyMnx8psfVjw65HrbtKd4IQnAH1OYBrWSzHV/J/GNaTw8cdkFiEmen/C
X-Gm-Message-State: AOJu0YyabfW5/OCfqiVMR1nvarKfqxA+TLB4zcXpiDXruJnkMql9Qktl
	EpfUgaXzWwhN8PP9/P5niIfiQ5HR5buENSlGadUBGEbLcmpIcyBPEYKB15YwedGlxvOwGA3Mzmd
	QjVt700d9Nrz22eBIZZu6bAU2wog=
X-Google-Smtp-Source: AGHT+IFBpc8AktbyAe5k9PamV8BjRGtWiiiYu0D2Dcq79fui5EpSovT9txzslfavXIkHrgDe3zmedEFm+teBBTWYkZA=
X-Received: by 2002:a05:600c:1da2:b0:417:e563:4aa4 with SMTP id
 p34-20020a05600c1da200b00417e5634aa4mr494424wms.5.1713495833894; Thu, 18 Apr
 2024 20:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZhkbrM55MKQ0KeIV@google.com> <3f8a481e-0dfe-468f-8c87-6610528f9009@linux.dev>
 <ZiAu6YDi-F_pxLOV@google.com> <dbba17cf-4351-45ca-9f43-090a0923a2bb@linux.dev>
In-Reply-To: <dbba17cf-4351-45ca-9f43-090a0923a2bb@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 18 Apr 2024 20:03:40 -0700
Message-ID: <CAADnVQ+z5w4GaMudrLXw3LAq1B3Ong7FhQHdkJN7m8svkCpMgA@mail.gmail.com>
Subject: Re: [RFC] bpf: allowing PTR_TO_BTF_ID | PTR_TRUSTED w/ non-zero fixed
 offset to selected KF_TRUSTED_ARGS BPF kfuncs
To: Yonghong Song <yonghong.song@linux.dev>, David Vernet <void@manifault.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 5:11=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
>
> On 4/17/24 1:19 PM, Matt Bobrowski wrote:
> > On Mon, Apr 15, 2024 at 09:43:42AM -0700, Yonghong Song wrote:
> >> On 4/12/24 4:31 AM, Matt Bobrowski wrote:
> >>> Hi,
> >>>
> >>> Currently, if a BPF kfunc has been annotated with KF_TRUSTED_ARGS, an=
y
> >>> supplied PTR_TO_BTF_ID | PTR_TRUSTED argument to that BPF kfunc must
> >>> have it's fixed offset set to zero, or else the BPF program being
> >>> loaded will be outright rejected by the BPF verifier.
> >>>
> >>> This non-zero fixed offset restriction in most cases makes a lot of
> >>> sense, as it's considered to be a robust means of assuring that the
> >>> supplied PTR_TO_BTF_ID to the KF_TRUSTED_ARGS annotated BPF kfunc
> >>> upholds it's PTR_TRUSTED property. However, I believe that there are
> >>> also cases out there whereby a PTR_TO_BTF_ID | PTR_TRUSTED w/ a fixed
> >>> offset can still be considered as something which posses the
> >>> PTR_TRUSTED property, and could be safely passed to a BPF kfunc that
> >>> is annotated w/ KF_TRUSTED_ARGS. I believe that this can particularly
> >>> hold true for selected embedded data structure members present within
> >>> given PTR_TO_BTF_ID | PTR_TRUSTED types i.e. struct
> >>> task_struct.thread_info, struct file.nf_path.
> >>>
> >>> Take for example the struct thread_info which is embedded within
> >>> struct task_struct. In a BPF program, if we happened to acquire a
> >>> PTR_TO_BTF_ID | PTR_TRUSTED for a struct task_struct via
> >>> bpf_get_current_task_btf(), and then constructed a pointer of type
> >>> struct thread_info which was assigned the address of the embedded
> >>> struct task_struct.thread_info member, we'd have ourselves a
> >>> PTR_TO_BTF_ID | PTR_TRUSTED w/ a fixed offset. Now, let's
> >>> hypothetically also say that we had a BPF kfunc that took a struct
> >>> thread_info pointer as an argument and the BPF kfunc was also
> >>> annotated w/ KF_TRUSTED_ARGS. If we attempted to pass the constructed
> >>> PTR_TO_BTF_ID | PTR_TRUSTED w/ fixed offset to this hypothetical BPF
> >>> kfunc, the BPF program would be rejected by the BPF verifier. This is
> >>> irrespective of the fact that supplying pointers to such embedded dat=
a
> >>> structure members of a PTR_TO_BTF_ID | PTR_TRUSTED may be considered
> >>> to be safe.
> >>>
> >>> One of the ideas that I had in mind to workaround the non-zero fixed
> >>> offset restriction was to simply introduce a new BPF kfunc annotation
> >>> i.e. __offset_allowed that could be applied on selected BPF kfunc
> >>> arguments that are expected to be KF_TRUSTED_ARGS. Such an annotation
> >>> would effectively control whether we enforce the non-zero offset
> >>> restriction or not in check_kfunc_args(), check_func_arg_reg_off(),
> >>> and __check_ptr_off_reg(). Although, now I'm second guessing myself
> >>> and I am wondering whether introducing something like the
> >>> __offset_allowed annotation for BPF kfunc arguments could lead to
> >>> compromising any of the safety guarantees that are provided by the BP=
F
> >>> verifier. Does anyone see an immediate problem with using such an
> >>> approach? I raise concerns, because it feels like we're effectively
> >>> punching a hole in the BPF verifier, but it may also be perfectly saf=
e
> >>> to do on carefully selected PTR_TO_BTF_ID | PTR_TRUSTED types
> >>> i.e. struct thread_info, struct file, and it's just my paranoia
> >>> getting the better of me. Or, maybe someone has another idea to
> >>> support PTR_TO_BTF_ID | PTR_TRUSTED w/ fixed offset safely and a
> >>> little more generally without the need to actually make use of any
> >>> other BPF kfunc annotations?
> >> In verifier.c, we have BTF_TYPE_SAFE_TRUSTED to indidate that
> >> a pointer of a particular struct is safe and trusted if the point
> >> of that struct is trusted, e.g.,
> >>
> >> BTF_TYPE_SAFE_TRUSTED(struct file) {
> >>          struct inode *f_inode;
> >> };
> >>
> >> We do the above since gcc does not support btf_tag yet.
> > Yes, I'm rather familiar with this construct.
> >
> >> I guess you could do
> >>
> >> BTF_TYPE_SAFE_TRUSTED(struct file) {
> >>          struct path f_path;
> >> };
> >>
> >> and enhance verifier with the above information.
> >>
> >> But the above 'struct path f_path' may unnecessary
> >> consume extra memory since we only care about field
> >> 'f_path'. Maybe create a new construct like
> >>
> >> /* pointee is a field of the struct */
> >> BTF_TYPE_SAFE_FIELD_TRUSTED(struct file) {
> >>          struct path *f_path;
> >> };
> > I don't fully understand how something like
> > BTF_TYPE_SAFE_FIELD_TRUSTED could work in practice. Do you mind
> > elaborating on that a little?
> >
> > What I'm currently thinking is that with something like
> > BTF_TYPE_SAFE_FIELD_TRUSTED, if the BPF verifier sees a PTR_TO_BTF_ID
> > | PTR_TRUSTED w/ a fixed offset supplied to a BPF kfunc, then the BPF
> > verifier can also check that fixed offset for the supplied
> > PTR_TO_BTF_ID | PTR_TRUSTED actually accesses a member that has been
> > explicitly annotated as being trusted via
> > BTF_TYPE_SAFE_FIELD_TRUSTED. Maybe that would be better then making
> > use of an __offset_allowed annotation, which would solely rely on the
> > btf_struct_ids_match() check for its safety.
> Right. What you described in the above is what I think as well.

I believe BTF_TYPE_SAFE_* or __offset_allowed annotations
are not necessary.

In this case thread_info is the first field of struct task_struct
and I suspect the verifier already allows:

bpf_kfunc void do_stuff_with_thread(struct thread_info *ti) KF_TRUSTED_ARGS
and use it as:
task =3D bpf_get_current_task_btf();
do_stuff_with_thread(&task->thread_info);

We have similar setup with:
struct bpf_cpumask {
        cpumask_t cpumask;
...
};

and kfunc that accepts trusted cpumask_t * will accept
trusted struct bpf_cpumask *.
The other way around should be rejected, of course.
Similar approach should work with file/path.
The only difference is that the offset will be non-zero.

process_kf_arg_ptr_to_btf_id() needs to get smarter.

David Vernet added that check:

WARN_ON_ONCE(is_kfunc_trusted_args(meta) && reg->off);
as part of commit b613d335a743c.

iirc the reg->off=3D=3D0 check is there, as an extra caution.

We can allow off!=3D0 and it won't confuse btf_type_ids_nocast_alias.

    struct  nf_conn___init {
            int another_field_at_off_zero;
            struct nf_conn ct;
    };

will still trigger strict_type_match as expected.

Maybe other places in the verifier need to get smarter too
to allow non-zero offset into kf_trusted_args.

