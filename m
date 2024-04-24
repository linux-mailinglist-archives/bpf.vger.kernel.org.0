Return-Path: <bpf+bounces-27647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46768B0150
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 07:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13A9E1C229EF
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 05:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058C7156873;
	Wed, 24 Apr 2024 05:50:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB47415667A
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 05:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713937811; cv=none; b=n5E9PFmbMLnwXpWABc5b4AAbaga7TknWTyFUyTnrwAQpHnsx/BsRD9TI3cipVSpugu0ATwuT0K59mfj6C+jMy7sxvzJsIg6e5AcdlcVt+uYLjapMGBq27woa8IZgFDRmuZnZqlEFCjIfM4tzw90p6BzDPb12TtpvkIJwnXHKJMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713937811; c=relaxed/simple;
	bh=HoaKq4Z3mkXis5a13Hcmmn0qTPQUjvhhCsIdzeC5Nx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qquBHNNzPSsyP8sVyKdEKbajMiwLB+BsdT56KOA4iW89avt80cWZqOLIKpnuhhBWyjhSmDe5R4EuiddngjPvEN8WaXU3Z6RfY18UlvJ+1BwfAjS8hzMcXVgNRrTTnW/dqt9j1wc/rbGuvbW/z0kOtNBl7frU+xnxKhADmxxnumM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d9f35fcd2eso263055639f.2
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 22:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713937809; x=1714542609;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmHLO8oZ84yuHFFbyzaHgVZ78++jde7fAEGs+NznoVI=;
        b=ZKbiLLOKREwREN8X/HZ/fGb0pWDhj4JZ+itslapGcMlShZwcPuLN50GJkaiq0JtDHa
         sLarwK/y9IQmnt9gOpe2hKAdVOCUzm1UI7FRJ6uFxDjG2G2eKPyc1jvoPT1DTshv4cdg
         WiNhAe1xm5ocPf3AQo6up+iOVzNwbxPv2uBttD/050FO2CBOUNW5FZ/SNgYEHyzOYDL5
         4TryFHTJlxHJj5DkmzXOG2O8/1MwR27+m7cOMQ0K0gwY1c+s6nwQvn0U1vhjiJtN5/Z1
         L3lVHYAJmdr/IvWAZSXFjF/E3RSW5KP5keytBc6upyoqCYYl/zDsASD1ZpzTNKDYPz/o
         uMSw==
X-Forwarded-Encrypted: i=1; AJvYcCWe356cdh7JSw8pJbUlj1jfN9cy7ChUckRiM0V/MGQLDaZFB0Zanq+zhdr1o4+JYIfsNS5orzhd68wcHt+VDEYrKreD
X-Gm-Message-State: AOJu0Yziwe6Ec5n5ebBOQDEs3ESe2+hyLr3C4kUstKHs+2tIsZhLV67W
	4NbMsfVe05yt95JLdNjZ2PxuAlM0GEQpccD1yNBWGBZwnG0rUjrf1wZeyNYR
X-Google-Smtp-Source: AGHT+IH/FwZy4O//VAg3uJF437hDfJjoqrpZwzYZZV+mXQsBOm3yf5ckLa3vaddgdi5W/ZY/+nQn3g==
X-Received: by 2002:a05:6602:22c5:b0:7d6:8f9:107f with SMTP id e5-20020a05660222c500b007d608f9107fmr1391061ioe.12.1713937808576;
        Tue, 23 Apr 2024 22:50:08 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id y8-20020a02c008000000b00482f496ade4sm4057187jai.83.2024.04.23.22.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 22:50:08 -0700 (PDT)
Date: Wed, 24 Apr 2024 00:50:05 -0500
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC] bpf: allowing PTR_TO_BTF_ID | PTR_TRUSTED w/ non-zero
 fixed offset to selected KF_TRUSTED_ARGS BPF kfuncs
Message-ID: <20240424055005.GA170502@maniforge>
References: <ZhkbrM55MKQ0KeIV@google.com>
 <3f8a481e-0dfe-468f-8c87-6610528f9009@linux.dev>
 <ZiAu6YDi-F_pxLOV@google.com>
 <dbba17cf-4351-45ca-9f43-090a0923a2bb@linux.dev>
 <CAADnVQ+z5w4GaMudrLXw3LAq1B3Ong7FhQHdkJN7m8svkCpMgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SWcTPTF1WZpYj2c7"
Content-Disposition: inline
In-Reply-To: <CAADnVQ+z5w4GaMudrLXw3LAq1B3Ong7FhQHdkJN7m8svkCpMgA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--SWcTPTF1WZpYj2c7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 08:03:40PM -0700, Alexei Starovoitov wrote:
> On Wed, Apr 17, 2024 at 5:11=E2=80=AFPM Yonghong Song <yonghong.song@linu=
x.dev> wrote:
> >
> >
> > On 4/17/24 1:19 PM, Matt Bobrowski wrote:
> > > On Mon, Apr 15, 2024 at 09:43:42AM -0700, Yonghong Song wrote:
> > >> On 4/12/24 4:31 AM, Matt Bobrowski wrote:
> > >>> Hi,
> > >>>
> > >>> Currently, if a BPF kfunc has been annotated with KF_TRUSTED_ARGS, =
any
> > >>> supplied PTR_TO_BTF_ID | PTR_TRUSTED argument to that BPF kfunc must
> > >>> have it's fixed offset set to zero, or else the BPF program being
> > >>> loaded will be outright rejected by the BPF verifier.
> > >>>
> > >>> This non-zero fixed offset restriction in most cases makes a lot of
> > >>> sense, as it's considered to be a robust means of assuring that the
> > >>> supplied PTR_TO_BTF_ID to the KF_TRUSTED_ARGS annotated BPF kfunc
> > >>> upholds it's PTR_TRUSTED property. However, I believe that there are
> > >>> also cases out there whereby a PTR_TO_BTF_ID | PTR_TRUSTED w/ a fix=
ed
> > >>> offset can still be considered as something which posses the
> > >>> PTR_TRUSTED property, and could be safely passed to a BPF kfunc that
> > >>> is annotated w/ KF_TRUSTED_ARGS. I believe that this can particular=
ly
> > >>> hold true for selected embedded data structure members present with=
in
> > >>> given PTR_TO_BTF_ID | PTR_TRUSTED types i.e. struct
> > >>> task_struct.thread_info, struct file.nf_path.
> > >>>
> > >>> Take for example the struct thread_info which is embedded within
> > >>> struct task_struct. In a BPF program, if we happened to acquire a
> > >>> PTR_TO_BTF_ID | PTR_TRUSTED for a struct task_struct via
> > >>> bpf_get_current_task_btf(), and then constructed a pointer of type
> > >>> struct thread_info which was assigned the address of the embedded
> > >>> struct task_struct.thread_info member, we'd have ourselves a
> > >>> PTR_TO_BTF_ID | PTR_TRUSTED w/ a fixed offset. Now, let's
> > >>> hypothetically also say that we had a BPF kfunc that took a struct
> > >>> thread_info pointer as an argument and the BPF kfunc was also
> > >>> annotated w/ KF_TRUSTED_ARGS. If we attempted to pass the construct=
ed
> > >>> PTR_TO_BTF_ID | PTR_TRUSTED w/ fixed offset to this hypothetical BPF
> > >>> kfunc, the BPF program would be rejected by the BPF verifier. This =
is
> > >>> irrespective of the fact that supplying pointers to such embedded d=
ata
> > >>> structure members of a PTR_TO_BTF_ID | PTR_TRUSTED may be considered
> > >>> to be safe.
> > >>>
> > >>> One of the ideas that I had in mind to workaround the non-zero fixed
> > >>> offset restriction was to simply introduce a new BPF kfunc annotati=
on
> > >>> i.e. __offset_allowed that could be applied on selected BPF kfunc
> > >>> arguments that are expected to be KF_TRUSTED_ARGS. Such an annotati=
on
> > >>> would effectively control whether we enforce the non-zero offset
> > >>> restriction or not in check_kfunc_args(), check_func_arg_reg_off(),
> > >>> and __check_ptr_off_reg(). Although, now I'm second guessing myself
> > >>> and I am wondering whether introducing something like the
> > >>> __offset_allowed annotation for BPF kfunc arguments could lead to
> > >>> compromising any of the safety guarantees that are provided by the =
BPF
> > >>> verifier. Does anyone see an immediate problem with using such an
> > >>> approach? I raise concerns, because it feels like we're effectively
> > >>> punching a hole in the BPF verifier, but it may also be perfectly s=
afe
> > >>> to do on carefully selected PTR_TO_BTF_ID | PTR_TRUSTED types
> > >>> i.e. struct thread_info, struct file, and it's just my paranoia
> > >>> getting the better of me. Or, maybe someone has another idea to
> > >>> support PTR_TO_BTF_ID | PTR_TRUSTED w/ fixed offset safely and a
> > >>> little more generally without the need to actually make use of any
> > >>> other BPF kfunc annotations?
> > >> In verifier.c, we have BTF_TYPE_SAFE_TRUSTED to indidate that
> > >> a pointer of a particular struct is safe and trusted if the point
> > >> of that struct is trusted, e.g.,
> > >>
> > >> BTF_TYPE_SAFE_TRUSTED(struct file) {
> > >>          struct inode *f_inode;
> > >> };
> > >>
> > >> We do the above since gcc does not support btf_tag yet.
> > > Yes, I'm rather familiar with this construct.
> > >
> > >> I guess you could do
> > >>
> > >> BTF_TYPE_SAFE_TRUSTED(struct file) {
> > >>          struct path f_path;
> > >> };
> > >>
> > >> and enhance verifier with the above information.
> > >>
> > >> But the above 'struct path f_path' may unnecessary
> > >> consume extra memory since we only care about field
> > >> 'f_path'. Maybe create a new construct like
> > >>
> > >> /* pointee is a field of the struct */
> > >> BTF_TYPE_SAFE_FIELD_TRUSTED(struct file) {
> > >>          struct path *f_path;
> > >> };
> > > I don't fully understand how something like
> > > BTF_TYPE_SAFE_FIELD_TRUSTED could work in practice. Do you mind
> > > elaborating on that a little?
> > >
> > > What I'm currently thinking is that with something like
> > > BTF_TYPE_SAFE_FIELD_TRUSTED, if the BPF verifier sees a PTR_TO_BTF_ID
> > > | PTR_TRUSTED w/ a fixed offset supplied to a BPF kfunc, then the BPF
> > > verifier can also check that fixed offset for the supplied
> > > PTR_TO_BTF_ID | PTR_TRUSTED actually accesses a member that has been
> > > explicitly annotated as being trusted via
> > > BTF_TYPE_SAFE_FIELD_TRUSTED. Maybe that would be better then making
> > > use of an __offset_allowed annotation, which would solely rely on the
> > > btf_struct_ids_match() check for its safety.
> > Right. What you described in the above is what I think as well.
>=20
> I believe BTF_TYPE_SAFE_* or __offset_allowed annotations
> are not necessary.
>=20
> In this case thread_info is the first field of struct task_struct
> and I suspect the verifier already allows:
>=20
> bpf_kfunc void do_stuff_with_thread(struct thread_info *ti) KF_TRUSTED_AR=
GS
> and use it as:
> task =3D bpf_get_current_task_btf();
> do_stuff_with_thread(&task->thread_info);

Yes, I believe this should already work. It would be the same as casting
the task as a struct thread_info. btf_struct_ids_match() should
btf_struct_walk() the task, and find a struct thread_info object at that
offset and successfully compare the BTF IDs of that with the arg type.
If not for the check_func_arg_reg_off() code described below, it should
also work with nonzero offsets as well. When we begin the walk it can be
at any offset. After we do the first struct walk, we continue descending
at offset 0 from that first inner struct type.

> We have similar setup with:
> struct bpf_cpumask {
>         cpumask_t cpumask;
> ...
> };
>=20
> and kfunc that accepts trusted cpumask_t * will accept
> trusted struct bpf_cpumask *.
> The other way around should be rejected, of course.
> Similar approach should work with file/path.
> The only difference is that the offset will be non-zero.

Agreed

> process_kf_arg_ptr_to_btf_id() needs to get smarter.
>=20
> David Vernet added that check:
>=20
> WARN_ON_ONCE(is_kfunc_trusted_args(meta) && reg->off);
> as part of commit b613d335a743c.
>=20
> iirc the reg->off=3D=3D0 check is there, as an extra caution.

That check is currently an invariant because of this code:

11720                 case KF_ARG_PTR_TO_MAP:
11721                 case KF_ARG_PTR_TO_ALLOC_BTF_ID:
11722                 case KF_ARG_PTR_TO_BTF_ID:
11723                         if (!is_kfunc_trusted_args(meta) && !is_kfunc=
_rcu(meta))
11724                                 break;
11725
11726                         if (!is_trusted_reg(reg)) {
11727                                 if (!is_kfunc_rcu(meta)) {
11728                                         verbose(env, "R%d must be ref=
erenced or trusted\n", regno);
11729                                         return -EINVAL;
11730                                 }
11731                                 if (!is_rcu_reg(reg)) {
11732                                         verbose(env, "R%d must be a r=
cu pointer\n", regno);
11733                                         return -EINVAL;
11734                                 }
11735                         }
11736
11737                         fallthrough;
11738                 case KF_ARG_PTR_TO_CTX:
11739                         /* Trusted arguments have the same offset che=
cks as release arguments */
11740                         arg_type |=3D OBJ_RELEASE;  <<<<< because of =
this
11741                         break;

The OBJ_RELEASE causes check_func_arg_reg_off() to fail to verify if
there's a nonzero offset. In reality, I _think_ we only need to check
for a nonzero offset for KF_RELEASE, and possibly KF_ACQUIRE.

>=20
> We can allow off!=3D0 and it won't confuse btf_type_ids_nocast_alias.
>=20
>     struct  nf_conn___init {
>             int another_field_at_off_zero;
>             struct nf_conn ct;
>     };
>=20
> will still trigger strict_type_match as expected.

Yes, this should continue to just work, but I think we may also have to
be cognizant to not allow this type of pattern:

struct some_other_type {
	int field_at_off_zero;
	struct nf_conn___init ct;
};

In this case, we don't want to allow &other_type->ct to be passed to a
kfunc expecting a struct nf_conn. So we'd also have to compare the type
at the register offset to make sure it's not a nocast alias, not just
the type in the register itself. I'm not sure if this is a problem in
practice. I expect it isn't. struct nf_conn___init exists solely to
allow the struct nf_conn kfuncs to enforce calling semantics so that an
uninitialized struct nf_conn object can't be passed to specific kfuncs
that are expecting an initialized object. I don't see why we'd ever
embed a wrapper type like that inside of another type. But still
something to be cognizant of.

> Maybe other places in the verifier need to get smarter too
> to allow non-zero offset into kf_trusted_args.

Yes, see above. We're also validating that trusted args have a zero
offset in check_func_arg_reg_off(). There may be other places too, but I
don't think there are too many.

--SWcTPTF1WZpYj2c7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZiidjQAKCRBZ5LhpZcTz
ZOD9AQDEvd0PVkPECONWUzyV/o+6cbA0vjzVpMeWVsQG3/LoXgEAnH/GsCK3CzKz
9HSKUWXFap54ODLoE2vZMYRZr0jBhQc=
=uWJ9
-----END PGP SIGNATURE-----

--SWcTPTF1WZpYj2c7--

