Return-Path: <bpf+bounces-27717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E81128B1283
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 20:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CFEEB24D79
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 18:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A509317556;
	Wed, 24 Apr 2024 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddRwuYZJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491B414A85
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 18:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713983827; cv=none; b=mSjh+ONqEZVx4aKt1tdlE+AoubdhswJ2JyOXqtixI1J8oq7ZlzgiZuJjTA1mwX+Zew7r5UvlUfxCIbHRP54xH5Q0DjOyUx2KdjRCRn7/S4tsZTOx7kfTy4uO5WUL0QacLaHlolYzZ1ijzlTv3/nDDKiHrlJ4lZ9jbE6ox0P+4hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713983827; c=relaxed/simple;
	bh=fhn8w0I7YuvU4lEZCx72rcW8DEXWbLgmw9UyGFyFMtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R8WjnsRA0xQPHDKWfX6954PSqjVZLFB+yr49S77XADJhVCLVkatFPcsdTZ7MIjIzegKVAcE7/kGI3htvLvM2hJgOAGYOiYISoilOs8vAY4VI2EVxPL+s+zOxrrQZ1bX317hjXL4E/uDdylryDZpPrgGyfyeQZOeH3kV90GuBA0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddRwuYZJ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41a72f3a1edso1080215e9.2
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 11:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713983823; x=1714588623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYI6GpTn5xXNH8tiGFOGcPeKWjwy0F+xLvMKEdZqjgk=;
        b=ddRwuYZJbYmvwKuSz7eLvwGwq3C1UNHk396Md/I2PoXJYI09PdqEeGww3EJ5v3yMV7
         8pDiDJgNbZaU5OtrB25rfqx+t6L9FuRW1ZQUk5dtwJ+ZOuLp9uFeRjQmuUJBEwPbyMtE
         svTk0HSoJQ7L+lJzPsfftGEIRHbt7vq7exMlP8eIQbJbWe0fL6niW+kaEiOuj9BofHZl
         HmcT+pNm4eM8WpdNpdJZJxuU2l7DjRPCjeAItUWMG2WbEFDXmSsz1bB+Kiq5/Zlh+l1e
         XI5zwfKH2bStTwk47vh889Uh8gGrtynqV3WoR5/pGqTMmXGN9rp4R59zsM0XUsMLeRz5
         q0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713983823; x=1714588623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYI6GpTn5xXNH8tiGFOGcPeKWjwy0F+xLvMKEdZqjgk=;
        b=whZQu1r0lvQ0oC8OOcWxcugOzVQsX7NpyK1OdvJ6SHgxy93BZXAMeomayyjmFe9EQh
         biqXcKCyEzs756UIAy31PtosxxYahp3eoJS19iXEH8w++qsdLSrgOL1wxFVSM1Q8+8VX
         kiCTUVqyMdH7fiy/3RXUnG1QYdj862wU/zpdOYtlrB+aP2fbyZHIMFraif8jKL8KgI7N
         VjbdKZ9n/L57y4NoUcPebpV7IH4u0C3+0OUb1NX2MIotCCbthWlNB8GlTFX6d4qwDX6Y
         yeycmOcP6J5qW6btHBuK0Wp+gwXdAOs/EUt8QaMZlZtHALCFnHCfIRcdaOBueHiyD47a
         RK5A==
X-Forwarded-Encrypted: i=1; AJvYcCUu1vilKTHo8Kj8FuoCwycCjJjVZNoyAEQbJ3X2HrJ30gS4syXD/GLvw/uk2/9PCMzgoqCKp3G5rGZiKIWwccYi1hPc
X-Gm-Message-State: AOJu0YzsI6AgSoBklE4UFXuZI030WmTb5SLdON95AQMyKLQjIr2qIG2t
	QgZGhsmoUQl60PPjdPo0EQOwxiP2GWAMQpp49NY5547hFdBmtRyg317bWm4JkpxQJd5rI/b4wfr
	tUf4mUTvupx8enRm1hG3ESojGy7oYk23+
X-Google-Smtp-Source: AGHT+IGBC1h3V42T/p8l4z5QiVSD7jt1L2ypIRGWBr/k74e4bQfBHBT9rrdx0Eic5LdwMtFM+QhZrm2MGJYA1pZYRQ8=
X-Received: by 2002:adf:cb04:0:b0:34a:3148:47f2 with SMTP id
 u4-20020adfcb04000000b0034a314847f2mr1861717wrh.18.1713983823282; Wed, 24 Apr
 2024 11:37:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZhkbrM55MKQ0KeIV@google.com> <3f8a481e-0dfe-468f-8c87-6610528f9009@linux.dev>
 <ZiAu6YDi-F_pxLOV@google.com> <dbba17cf-4351-45ca-9f43-090a0923a2bb@linux.dev>
 <CAADnVQ+z5w4GaMudrLXw3LAq1B3Ong7FhQHdkJN7m8svkCpMgA@mail.gmail.com> <20240424055005.GA170502@maniforge>
In-Reply-To: <20240424055005.GA170502@maniforge>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Apr 2024 11:36:51 -0700
Message-ID: <CAADnVQ+xPgOCYsMk8Tot0PPTWgY5Yqat9V-qZGaWXAF+BpxCow@mail.gmail.com>
Subject: Re: [RFC] bpf: allowing PTR_TO_BTF_ID | PTR_TRUSTED w/ non-zero fixed
 offset to selected KF_TRUSTED_ARGS BPF kfuncs
To: David Vernet <void@manifault.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 10:50=E2=80=AFPM David Vernet <void@manifault.com> =
wrote:
>
> On Thu, Apr 18, 2024 at 08:03:40PM -0700, Alexei Starovoitov wrote:
> > On Wed, Apr 17, 2024 at 5:11=E2=80=AFPM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> > >
> > >
> > > On 4/17/24 1:19 PM, Matt Bobrowski wrote:
> > > > On Mon, Apr 15, 2024 at 09:43:42AM -0700, Yonghong Song wrote:
> > > >> On 4/12/24 4:31 AM, Matt Bobrowski wrote:
> > > >>> Hi,
> > > >>>
> > > >>> Currently, if a BPF kfunc has been annotated with KF_TRUSTED_ARGS=
, any
> > > >>> supplied PTR_TO_BTF_ID | PTR_TRUSTED argument to that BPF kfunc m=
ust
> > > >>> have it's fixed offset set to zero, or else the BPF program being
> > > >>> loaded will be outright rejected by the BPF verifier.
> > > >>>
> > > >>> This non-zero fixed offset restriction in most cases makes a lot =
of
> > > >>> sense, as it's considered to be a robust means of assuring that t=
he
> > > >>> supplied PTR_TO_BTF_ID to the KF_TRUSTED_ARGS annotated BPF kfunc
> > > >>> upholds it's PTR_TRUSTED property. However, I believe that there =
are
> > > >>> also cases out there whereby a PTR_TO_BTF_ID | PTR_TRUSTED w/ a f=
ixed
> > > >>> offset can still be considered as something which posses the
> > > >>> PTR_TRUSTED property, and could be safely passed to a BPF kfunc t=
hat
> > > >>> is annotated w/ KF_TRUSTED_ARGS. I believe that this can particul=
arly
> > > >>> hold true for selected embedded data structure members present wi=
thin
> > > >>> given PTR_TO_BTF_ID | PTR_TRUSTED types i.e. struct
> > > >>> task_struct.thread_info, struct file.nf_path.
> > > >>>
> > > >>> Take for example the struct thread_info which is embedded within
> > > >>> struct task_struct. In a BPF program, if we happened to acquire a
> > > >>> PTR_TO_BTF_ID | PTR_TRUSTED for a struct task_struct via
> > > >>> bpf_get_current_task_btf(), and then constructed a pointer of typ=
e
> > > >>> struct thread_info which was assigned the address of the embedded
> > > >>> struct task_struct.thread_info member, we'd have ourselves a
> > > >>> PTR_TO_BTF_ID | PTR_TRUSTED w/ a fixed offset. Now, let's
> > > >>> hypothetically also say that we had a BPF kfunc that took a struc=
t
> > > >>> thread_info pointer as an argument and the BPF kfunc was also
> > > >>> annotated w/ KF_TRUSTED_ARGS. If we attempted to pass the constru=
cted
> > > >>> PTR_TO_BTF_ID | PTR_TRUSTED w/ fixed offset to this hypothetical =
BPF
> > > >>> kfunc, the BPF program would be rejected by the BPF verifier. Thi=
s is
> > > >>> irrespective of the fact that supplying pointers to such embedded=
 data
> > > >>> structure members of a PTR_TO_BTF_ID | PTR_TRUSTED may be conside=
red
> > > >>> to be safe.
> > > >>>
> > > >>> One of the ideas that I had in mind to workaround the non-zero fi=
xed
> > > >>> offset restriction was to simply introduce a new BPF kfunc annota=
tion
> > > >>> i.e. __offset_allowed that could be applied on selected BPF kfunc
> > > >>> arguments that are expected to be KF_TRUSTED_ARGS. Such an annota=
tion
> > > >>> would effectively control whether we enforce the non-zero offset
> > > >>> restriction or not in check_kfunc_args(), check_func_arg_reg_off(=
),
> > > >>> and __check_ptr_off_reg(). Although, now I'm second guessing myse=
lf
> > > >>> and I am wondering whether introducing something like the
> > > >>> __offset_allowed annotation for BPF kfunc arguments could lead to
> > > >>> compromising any of the safety guarantees that are provided by th=
e BPF
> > > >>> verifier. Does anyone see an immediate problem with using such an
> > > >>> approach? I raise concerns, because it feels like we're effective=
ly
> > > >>> punching a hole in the BPF verifier, but it may also be perfectly=
 safe
> > > >>> to do on carefully selected PTR_TO_BTF_ID | PTR_TRUSTED types
> > > >>> i.e. struct thread_info, struct file, and it's just my paranoia
> > > >>> getting the better of me. Or, maybe someone has another idea to
> > > >>> support PTR_TO_BTF_ID | PTR_TRUSTED w/ fixed offset safely and a
> > > >>> little more generally without the need to actually make use of an=
y
> > > >>> other BPF kfunc annotations?
> > > >> In verifier.c, we have BTF_TYPE_SAFE_TRUSTED to indidate that
> > > >> a pointer of a particular struct is safe and trusted if the point
> > > >> of that struct is trusted, e.g.,
> > > >>
> > > >> BTF_TYPE_SAFE_TRUSTED(struct file) {
> > > >>          struct inode *f_inode;
> > > >> };
> > > >>
> > > >> We do the above since gcc does not support btf_tag yet.
> > > > Yes, I'm rather familiar with this construct.
> > > >
> > > >> I guess you could do
> > > >>
> > > >> BTF_TYPE_SAFE_TRUSTED(struct file) {
> > > >>          struct path f_path;
> > > >> };
> > > >>
> > > >> and enhance verifier with the above information.
> > > >>
> > > >> But the above 'struct path f_path' may unnecessary
> > > >> consume extra memory since we only care about field
> > > >> 'f_path'. Maybe create a new construct like
> > > >>
> > > >> /* pointee is a field of the struct */
> > > >> BTF_TYPE_SAFE_FIELD_TRUSTED(struct file) {
> > > >>          struct path *f_path;
> > > >> };
> > > > I don't fully understand how something like
> > > > BTF_TYPE_SAFE_FIELD_TRUSTED could work in practice. Do you mind
> > > > elaborating on that a little?
> > > >
> > > > What I'm currently thinking is that with something like
> > > > BTF_TYPE_SAFE_FIELD_TRUSTED, if the BPF verifier sees a PTR_TO_BTF_=
ID
> > > > | PTR_TRUSTED w/ a fixed offset supplied to a BPF kfunc, then the B=
PF
> > > > verifier can also check that fixed offset for the supplied
> > > > PTR_TO_BTF_ID | PTR_TRUSTED actually accesses a member that has bee=
n
> > > > explicitly annotated as being trusted via
> > > > BTF_TYPE_SAFE_FIELD_TRUSTED. Maybe that would be better then making
> > > > use of an __offset_allowed annotation, which would solely rely on t=
he
> > > > btf_struct_ids_match() check for its safety.
> > > Right. What you described in the above is what I think as well.
> >
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
>
> Yes, I believe this should already work. It would be the same as casting
> the task as a struct thread_info. btf_struct_ids_match() should
> btf_struct_walk() the task, and find a struct thread_info object at that
> offset and successfully compare the BTF IDs of that with the arg type.
> If not for the check_func_arg_reg_off() code described below, it should
> also work with nonzero offsets as well. When we begin the walk it can be
> at any offset. After we do the first struct walk, we continue descending
> at offset 0 from that first inner struct type.
>
> > We have similar setup with:
> > struct bpf_cpumask {
> >         cpumask_t cpumask;
> > ...
> > };
> >
> > and kfunc that accepts trusted cpumask_t * will accept
> > trusted struct bpf_cpumask *.
> > The other way around should be rejected, of course.
> > Similar approach should work with file/path.
> > The only difference is that the offset will be non-zero.
>
> Agreed
>
> > process_kf_arg_ptr_to_btf_id() needs to get smarter.
> >
> > David Vernet added that check:
> >
> > WARN_ON_ONCE(is_kfunc_trusted_args(meta) && reg->off);
> > as part of commit b613d335a743c.
> >
> > iirc the reg->off=3D=3D0 check is there, as an extra caution.
>
> That check is currently an invariant because of this code:
>
> 11720                 case KF_ARG_PTR_TO_MAP:
> 11721                 case KF_ARG_PTR_TO_ALLOC_BTF_ID:
> 11722                 case KF_ARG_PTR_TO_BTF_ID:
> 11723                         if (!is_kfunc_trusted_args(meta) && !is_kfu=
nc_rcu(meta))
> 11724                                 break;
> 11725
> 11726                         if (!is_trusted_reg(reg)) {
> 11727                                 if (!is_kfunc_rcu(meta)) {
> 11728                                         verbose(env, "R%d must be r=
eferenced or trusted\n", regno);
> 11729                                         return -EINVAL;
> 11730                                 }
> 11731                                 if (!is_rcu_reg(reg)) {
> 11732                                         verbose(env, "R%d must be a=
 rcu pointer\n", regno);
> 11733                                         return -EINVAL;
> 11734                                 }
> 11735                         }
> 11736
> 11737                         fallthrough;
> 11738                 case KF_ARG_PTR_TO_CTX:
> 11739                         /* Trusted arguments have the same offset c=
hecks as release arguments */
> 11740                         arg_type |=3D OBJ_RELEASE;  <<<<< because o=
f this
> 11741                         break;
>
> The OBJ_RELEASE causes check_func_arg_reg_off() to fail to verify if
> there's a nonzero offset. In reality, I _think_ we only need to check
> for a nonzero offset for KF_RELEASE, and possibly KF_ACQUIRE.

Why special case KF_RELEASE/ACQUIRE ?
I think they're no different from kfuncs with KF_TRUSTED_ARGS.
Should be safe to allow non-zero offset trusted arg in all cases.

> >
> > We can allow off!=3D0 and it won't confuse btf_type_ids_nocast_alias.
> >
> >     struct  nf_conn___init {
> >             int another_field_at_off_zero;
> >             struct nf_conn ct;
> >     };
> >
> > will still trigger strict_type_match as expected.
>
> Yes, this should continue to just work, but I think we may also have to
> be cognizant to not allow this type of pattern:
>
> struct some_other_type {
>         int field_at_off_zero;
>         struct nf_conn___init ct;
> };
>
> In this case, we don't want to allow &other_type->ct to be passed to a
> kfunc expecting a struct nf_conn. So we'd also have to compare the type
> at the register offset to make sure it's not a nocast alias, not just
> the type in the register itself. I'm not sure if this is a problem in
> practice. I expect it isn't. struct nf_conn___init exists solely to
> allow the struct nf_conn kfuncs to enforce calling semantics so that an
> uninitialized struct nf_conn object can't be passed to specific kfuncs
> that are expecting an initialized object. I don't see why we'd ever
> embed a wrapper type like that inside of another type. But still
> something to be cognizant of.

Agree that it's not a problem now and I wouldn't proactively
complicate the verifier.
__init types are in the kernel code and it gets code reviewed.
So 'struct some_other_type' won't happen out of nowhere.

