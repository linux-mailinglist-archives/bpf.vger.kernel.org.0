Return-Path: <bpf+bounces-20414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D22DC83E003
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 18:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49FB21F2598F
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 17:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD93B1F5FD;
	Fri, 26 Jan 2024 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKhPmlcm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CF71D553
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290103; cv=none; b=PPu60vV7WYy8pl0y3gufiFvvPsRS4mCUd/ES3hcP9le7sLYrxspesJP87aCE8JV+zuOTj2Wax9OTdIduVq1e/qEoHQpcUco8dwN9hRm+l+1Mp3ovPdSQesm10nkE2dL/QFK+Gt3V/xhn4tZQjvsNn6rBQ/FJovZy04r3gDU6xsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290103; c=relaxed/simple;
	bh=dXINbLKpclMabI5tEHrHpMS0akrlknIIxT2w8Q6uvCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3LHbMLrpQLKTZJVD8iNabnusyyCMbpGc0ftzupF9i88f32+CyjfOHFGf79BtA8LGBGtBYB1Xwl+sfuuBq7P5nCtRftkFRaHmg8ypSxHvsKauGlEa/X2gisk/vo/nxdNwJN5fHHYuYs4VucMHuel685AvowlFWTJVpEAJ8dDdek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKhPmlcm; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6dddf4fc85dso548292b3a.0
        for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 09:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706290101; x=1706894901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+uz7WX/Zf76b5z/pAb+VuJGc+7F9dOstWJKAcOuYTM=;
        b=NKhPmlcmE+6RQmj8ui/yPRVw49x4Q555Wntku2xZT9dajdM9w3MUtlYYWt07TVmFJh
         nRWQWxroQfPnEyqJJBPWIvdZogzPTfEoz0RL3Pl8OQ5eg5O+/+nJxrlL9i+InPcO9MW6
         ArDQXGVzzRvNcyevLh2TEhqJF5Hc1c/dYVQc8NyaHw2YnPZZrJIcRYlTHgSlN3uFR/76
         8crkPOPiWY7Jx/7nlmDYRNg5OJ35KMKTjOO4FarIWuaS7rmp6cOW6TZnm6E8ucx3Mst9
         b57yyqoq3nRb/t/fzGbL+7EuVXHphtzOW3W4KlQxwT6KdHUryDWY3TWVa31va6JPNt0f
         UkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706290101; x=1706894901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+uz7WX/Zf76b5z/pAb+VuJGc+7F9dOstWJKAcOuYTM=;
        b=cLzpR6uN8+iAs83SkGjsWlqiLGzpxCG+cjqfqWXGPcxlLPjrGbV7f8wrNjKsTuzDnK
         H2IESB5XbuYRO+47hPsX9pKReo9wZ93EIhHfwkn2AiMXZfkOqVWObvovBcw+bbU4vDgs
         4QWDx4UXquDIO8GKaUpse/AVo1ygqhaCtXyHz9Hs9tLqZyyPeK1eLK0zDRgDr7uIlD5h
         nzjFGbMvfAnDf82uDcYBgvmOAvrYcVnzr7qPVogZrurI5d9pMeAjDseq9svzR+fVGzVx
         aaLIGl1rd145z4fPEdXv0J3i3GgsRWJL+od/JHOPulGCALpVQukBaE1KvvleYtIhPIov
         BpCA==
X-Gm-Message-State: AOJu0YzB5/TyEzsH7cvc4WQSejlBLmyP2BRgjueS/Gkml0aMxxc7RRpc
	h/+H+Auwm0tctTpzwFIMON3xyGYMAFv1BWfxsajsrJV4R23GOu3zMGlF+sdnaEflEuU9VZkU1RA
	QxH9rzMzoN46f8JQtxJrcViwhkYs=
X-Google-Smtp-Source: AGHT+IH/Cr9bVKuD2gDj8vMJgXe7XATD0R8xCYWfqI2VOq4EpT7I01th4iSyACskJLEjASJJB8JjVVhdz66A5vV3AfA=
X-Received: by 2002:aa7:8514:0:b0:6dd:7b4f:bdb0 with SMTP id
 v20-20020aa78514000000b006dd7b4fbdb0mr115756pfn.57.1706290100801; Fri, 26 Jan
 2024 09:28:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124224130.859921-1-thinker.li@gmail.com> <CAEf4BzZaFh3BaDYhTAWCuZBZ9t_2C2iXOsCGF88LeNb+ndVaXg@mail.gmail.com>
 <b1819ff0-872b-4cab-91d2-b496929d49f7@gmail.com> <CAEf4BzZ7jke36H+UOyU8_UQCksF4QhEmu94=H70=uJqbdOPRRw@mail.gmail.com>
 <e472da72-4031-4502-bfc5-392c8e332816@gmail.com>
In-Reply-To: <e472da72-4031-4502-bfc5-392c8e332816@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Jan 2024 09:28:08 -0800
Message-ID: <CAEf4BzbjJYXM3ZYDGRxhSB3_T+aZyrvii8V5MJC7RcoF62_==Q@mail.gmail.com>
Subject: Re: [RFC bpf-next] bpf: Create shadow variables for struct_ops in skeletons.
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, kuifeng@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 6:46=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.com> =
wrote:
>
>
>
> On 1/25/24 15:59, Andrii Nakryiko wrote:
> > On Thu, Jan 25, 2024 at 3:13=E2=80=AFPM Kui-Feng Lee <sinquersw@gmail.c=
om> wrote:
> >>
> >>
> >>
> >> On 1/25/24 14:21, Andrii Nakryiko wrote:
> >>> On Wed, Jan 24, 2024 at 2:41=E2=80=AFPM <thinker.li@gmail.com> wrote:
> >>>>
> >>>> From: Kui-Feng Lee <thinker.li@gmail.com>
> >>>>
> >>>> Create shadow variables for the fields of struct_ops maps in a skele=
ton
> >>>> with the same name as the respective fields. For instance, if struct
> >>>> bpf_testmod_ops has a "data" field as following, you can access or m=
odify
> >>>> its value through a shadow variable also named "data" in the skeleto=
n.
> >>>>
> >>>>     SEC(".struct_ops.link")
> >>>>     struct bpf_testmod_ops testmod_1 =3D {
> >>>>         .data =3D 0x1,
> >>>>     };
> >>>>
> >>>> Then, you can change the value in the following manner as shown in t=
he code
> >>>> below.
> >>>>
> >>>>     skel->st_ops_vars.testmod_1.data =3D 13;
> >>>>
> >>>> It is helpful to configure a struct_ops map during the execution of =
a
> >>>> program. For instance, you can include a flag in a struct_ops type t=
o
> >>>> modify the way the kernel handles an instance. By implementing this
> >>>> feature, a user space program can alter the flag's value prior to lo=
ading
> >>>> an instance into the kernel.
> >>>>
> >>>> The code generator for skeletons will produce code that copies value=
s to
> >>>> shadow variables from the internal data buffer when a skeleton is
> >>>> opened. It will also copy values from shadow variables back to the i=
nternal
> >>>> data buffer before a skeleton is loaded into the kernel.
> >>>>
> >>>> The code generator will calculate the offset of a field and generate=
 code
> >>>> that copies the value of the field from or to the shadow variable to=
 or
> >>>> from the struct_ops internal data, with an offset relative to the be=
ginning
> >>>> of the internal data. For instance, if the "data" field in struct
> >>>> bpf_testmod_ops is situated 16 bytes from the beginning of the struc=
t, the
> >>>> address for the "data" field of struct bpf_testmod_ops will be the s=
tarting
> >>>> address plus 16.
> >>>>
> >>>> The offset is calculated during code generation, so it is always in =
line
> >>>> with the internal data in the skeleton. Even if the user space progr=
ams and
> >>>> the BPF program were not compiled together, any differences in versi=
ons
> >>>> would not impact correctness. This means that even if the BPF progra=
m and
> >>>> the user space program reference different versions of the "struct
> >>>> bpf_testmod_ops" and have different offsets for "data", these offset=
s
> >>>> computed by the code generator would still function correctly.
> >>>>
> >>>> The user space programs can only modify values by using these shadow
> >>>> variables when the skeleton is open, but before being loaded. Once t=
he
> >>>> skeleton is loaded, the value is copied to the kernel, and any futur=
e
> >>>> changes only affect the shadow variables in the user space memory an=
d do
> >>>> not update the kernel space. The shadow variables are not initialize=
d
> >>>> before opening a skeleton, so you cannot update values through them =
before
> >>>> opening.
> >>>>
> >>>> For function pointers (operators), you can change/replace their valu=
es with
> >>>> other BPF programs. For example, the test case in test_struct_ops_mo=
dule.c
> >>>> points .test_2 to test_3() while it was pointed to test_2() by assig=
ning a
> >>>> new value to the shadow variable.
> >>>>
> >>>>     skel->st_ops_vars.testmod_1.test_2 =3D skel->progs.test_3;
> >>>>
> >>>> However, you need to turn off autoload for test_2() since it is not
> >>>> assigned to any struct_ops map anymore. Or, it will fails to load te=
st_2().
> >>>>
> >>>>    bpf_program__set_autoload(skel->progs.test_2, false);
> >>>>
> >>>> You can define more struct_ops programs than necessary. However, you=
 need
> >>>> to turn autoload off for unused ones.
> >>>
> >>> Overall I like the idea, it seems like a pretty natural and powerful
> >>> interface. Few things I'd do a bit differently:
> >>>
> >>> - less code gen in the skeleton. It feels like it's better to teach
> >>> libbpf to allow getting/setting intial struct_ops map "image" using
> >>> standard bpf_map__initial_value() and bpf_map__set_initial_value().
> >>> That fits with other global data maps.
> >>
> >> Right, it is doable to move some logic from the code generator to
> >> libbpf. The only thing should keep in the code generator should be
> >> generating shadow variable fields in the skeleton.
> >>
> >>>
> >>> - I think all struct ops maps should be in skel->struct_ops.<name>,
> >>> not struct_ops_vars. I'd probably also combine struct_ops.link and
> >>> no-link struct ops in one section for simplicity
> >>
> >> agree!
> >>
> >>>
> >>> - getting underlying struct_ops BTF type should be possible to do
> >>> through bpf_map__btf_value_type_id(), no need for struct_ops-specific
> >>> one
> >>
> >> AFAIK, libbpf doesn't set def.value_type_id for struct_ops maps.
> >> bpf_map__btf_value_type_id() doesn't return the ID of a struct_ops typ=
e.
> >> I will check what the side effects are if def.value_type_id is set for
> >> struct_ops maps.
> >
> > Yes, it doesn't right now, not sure why, though. At least we can fix
> > that on libbpf sid
> >
> >>
> >>>
> >>> - you have a bunch of specific logic to dump INT/ENUM/PTR, I wonder i=
f
> >>> we can just reuse libbpf's BTF dumping API to dump everything? Though
> >>> for prog pointers we'd want to rewrite them to `struct bpf_program *`
> >>> field, not sure yet how hard it is.
> >>
> >> I am not quite sure what part you are talking about.
> >> Do you mean the code skipping type modifiers?
> >> The implementation skips all const (and static/volatile/... etc) to ma=
ke
> >> sure the user space programs can change these values without any
> >> tricky type casting.
> >>
> >
> > No, I'm talking about gen_st_ops_shadow_vars and gen_st_ops_func_one,
> > which don't handle members of type STRUCT/UNION, for example. I didn't
> > look too deeply into details of the implementation in those parts, but
> > I don't see any reason why we shouldn't support embedded struct
> > members there?
>
>
> One of goals here is to make sure the result doesn't affect by the
> change of types between versions. So, even a BPF program and a user
> space program are compiled separated with different versions of a type,
> they should still work together if the skeleton doesn't miss any
> field required by the user space program.

I don't see a problem here. There is some local type information that
was used to compile BPF object file. Libbpf knows it, it's in BTF.
This is the type user knows about and fills out. Then during BPF
object load libbpf will translate it to whatever kernel actually
expects. I think it all works out fine and not really a concern. We
just stick (consistently) to what was compiled into .bpf.o's BTF
information.

>
> For fields of struct or
> union types, that means we also have to include definitions of all
> these types in the header files of skeletons.  It may also raise
> type conflicts if we don't rename these types properly.

That's true, and is basically similar to the problem we have with
global variables and their types. The only difference is that these
struct_ops types are generally not controlled by users, and rather
come from kernel (vmlinux.h and such), so you are right, this might
cause some problems. Ok, we can start simple and skip those for now, I
guess.

>
> >
> >>>
> >>> The above is brief, so please ask questions where it's not clear what
> >>> I propose, thanks!
> >>>
> >>> [...]
> >>
> >> Thank you for the comments.
> >>

