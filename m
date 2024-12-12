Return-Path: <bpf+bounces-46721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAC69EF7DF
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 18:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72FCC17E0ED
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 17:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90058215762;
	Thu, 12 Dec 2024 17:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="RAxG2Oqk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD5F2144C4
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 17:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734024255; cv=none; b=pnSFEkd4C3CYubR0O9tB7/S0OKBqt/gz8d5/u5+FeX3AGiNfgvluM084Ffn6aWihemAknJLLbLWqKlSFu7qIPm0TqDGWdG9bntpTlK1RWHPw0X/xTl5X7uMATiSCCd0Dp3n9x5byWl3eGTPLbFMZRRVsprc4zsmDJwCF3qxYu5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734024255; c=relaxed/simple;
	bh=MrYVOnaf6XI3kE+siVv/JLOdRpPtcnNdQXXUgib5LZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYqt3z54xoNdF3OtcML9VQ06Swdwg6L3GaCdhqioFnYH3gqSCpVN8UJXBZtrXGznuRHabSwPdmbUKsOBLdyf/n5eY4SJQQYSxmKtnYvm3VZYqdF+gA68M3enUik7v6o/XzpamcPaXjL7BE3Aejckqh+K4rJVlTbDnNJvUlB0SnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=RAxG2Oqk; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa67ac42819so141455666b.0
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 09:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1734024251; x=1734629051; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dgWU+ChwfeKZYj/qKnCwPMbMjkC+SQM2MEDShvqzZnM=;
        b=RAxG2OqkGjMXjU+hSS1qet38CDW2QoBlpc1XxEFYmm7Tsy/h7E/OWW6rwwep2+FOFw
         1pzLUJRawZb6uDfvYt/7xfo9FGmziTBRHEEw8klpZkDXTTH6+aRGiDqGlmjpY5TbZ6ew
         IdiUcdjamsqUYgxadH6M2hMSZ9bbzISlBdBEeIvtR0jPW5bkTO8Fdz9+cFv1gNq6KFEa
         8RlJf1v8NuZB2SM7M2A4DSqj+Hq8Wv4o3CRB5lFHZFlWy6gHbts5KZbQRlA64Pzt/seE
         w75Gx7RgYPWmc4xym2kwCKCCPMZ6Ak2Ip4SARgKx103GXKAjOCFIwQeKSxcy7YItw1Iy
         MdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734024251; x=1734629051;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dgWU+ChwfeKZYj/qKnCwPMbMjkC+SQM2MEDShvqzZnM=;
        b=a9WOm8bQf/bnmDo5O53qZAxk/0/ArrfrQ+1xmZpk5t/MhJjYQ8kXBdFid7wYy4NAWR
         NyJgXvtrDIAZH6rEUiZTm6RI6hhNwzvPjxLBT4H5UrcGe7PNO3sF0vpfHUwrsmbSLiJw
         AvZf7cxiVsQnGAhPcfuwGw+sSwR//MtUh16mblPIuDTQ4OXZpEU1m08v4RIDWBJtYziY
         ocq+tiFmgkylg3TSXpFa+eeKQpWrJlbdDz2hZSfJ6tpPiAXfdzosqrYmCE/Oohsixeyq
         5+SW6uO3mSAXVId4kYiYupBSoB0vazx/2Gqi+NG2pHtfFfQVrK/qt2YmSq5b8gjL1lJw
         8SPA==
X-Gm-Message-State: AOJu0YwuB3aZ6RRhCbQh7jT5K5emb429BnEmVZwLuU+g3ePRBjdb/OuD
	3E0jfeKuCl1dHYXjSDYo6w2TtsnXd8KOg1HGu7+S1LO5gpZaNZdRQnBhpMxJzFT70SNd9xq/qp1
	L
X-Gm-Gg: ASbGncu3GKTrM6UdN28EaEz9EPDF3AsR07UGmLzoScNQ35Ag2k5vYEQl7v6Z5gfaRrD
	NWAKBWxTP93HbmNQdMeFlmOiSADx4PJzwVpxTy5ZAPixOfCxeOGRiAnypMDY9yWkgZSiPQGfoyf
	upPdHTshtLlUoRG3vKW03JZdUCdvjCu2GliAoFTrbnjmuAyuD3iZbSa5uJIX3umtg0EH/POKVHC
	Mg986cFTK7qjnqs8PAO3jcdnFXOsdjSvIIelsiTIASNTw==
X-Google-Smtp-Source: AGHT+IGbs1GE8DdOnrbS8wUzzfwLhPDAmPW4XUYQx16Hn5AZv0VSItQC4CQwPQmxSfbqEl8l4Q+7uQ==
X-Received: by 2002:a17:906:9a95:b0:aa6:6276:fe5a with SMTP id a640c23a62f3a-aa6c1ce75f7mr498988966b.43.1734024251002;
        Thu, 12 Dec 2024 09:24:11 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa68b385b1dsm593155966b.21.2024.12.12.09.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 09:24:10 -0800 (PST)
Date: Thu, 12 Dec 2024 17:26:02 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 3/7] bpf: add fd_array_cnt attribute for
 prog_load
Message-ID: <Z1scqusq/Rngn1Y9@eis>
References: <20241203135052.3380721-1-aspsk@isovalent.com>
 <20241203135052.3380721-4-aspsk@isovalent.com>
 <CAEf4BzZiD_iYpBkf5q5U9VoSUAFJN8dxOBWNJdT5y9DxAe=_UQ@mail.gmail.com>
 <Z1BJc/iK3ecPKTUx@eis>
 <CAEf4BzZVkNRV+8ROMMM-oGdHd1HUSx3WVv77TK+H4Fr8PhHHBQ@mail.gmail.com>
 <Z1FnPIuBiJFMRrLP@eis>
 <Z1gCmV3Z62HXjAtK@eis>
 <CAEf4Bzau=UnvGFskeyeBK2y3-O8x887ucUpX0bKhoHS-P-SwSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzau=UnvGFskeyeBK2y3-O8x887ucUpX0bKhoHS-P-SwSg@mail.gmail.com>

On 24/12/10 10:19AM, Andrii Nakryiko wrote:
> On Tue, Dec 10, 2024 at 12:56 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > On 24/12/05 08:41AM, Anton Protopopov wrote:
> > > On 24/12/04 10:08AM, Andrii Nakryiko wrote:
> > > > On Wed, Dec 4, 2024 at 4:19 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > > >
> > > > > On 24/12/03 01:25PM, Andrii Nakryiko wrote:
> > > > > > On Tue, Dec 3, 2024 at 5:48 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > > > > >
> > > > > > > The fd_array attribute of the BPF_PROG_LOAD syscall may contain a set
> > > > > > > of file descriptors: maps or btfs. This field was introduced as a
> > > > > > > sparse array. Introduce a new attribute, fd_array_cnt, which, if
> > > > > > > present, indicates that the fd_array is a continuous array of the
> > > > > > > corresponding length.
> > > > > > >
> > > > > > > If fd_array_cnt is non-zero, then every map in the fd_array will be
> > > > > > > bound to the program, as if it was used by the program. This
> > > > > > > functionality is similar to the BPF_PROG_BIND_MAP syscall, but such
> > > > > > > maps can be used by the verifier during the program load.
> > > > > > >
> > > > > > > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > > > > > > ---
> > > > > > >  include/uapi/linux/bpf.h       | 10 ++++
> > > > > > >  kernel/bpf/syscall.c           |  2 +-
> > > > > > >  kernel/bpf/verifier.c          | 98 ++++++++++++++++++++++++++++------
> > > > > > >  tools/include/uapi/linux/bpf.h | 10 ++++
> > > > > > >  4 files changed, 104 insertions(+), 16 deletions(-)
> > > > > > >
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > +/*
> > > > > > > + * The add_fd_from_fd_array() is executed only if fd_array_cnt is non-zero. In
> > > > > > > + * this case expect that every file descriptor in the array is either a map or
> > > > > > > + * a BTF. Everything else is considered to be trash.
> > > > > > > + */
> > > > > > > +static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
> > > > > > > +{
> > > > > > > +       struct bpf_map *map;
> > > > > > > +       CLASS(fd, f)(fd);
> > > > > > > +       int ret;
> > > > > > > +
> > > > > > > +       map = __bpf_map_get(f);
> > > > > > > +       if (!IS_ERR(map)) {
> > > > > > > +               ret = __add_used_map(env, map);
> > > > > > > +               if (ret < 0)
> > > > > > > +                       return ret;
> > > > > > > +               return 0;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       /*
> > > > > > > +        * Unlike "unused" maps which do not appear in the BPF program,
> > > > > > > +        * BTFs are visible, so no reason to refcnt them now
> > > > > >
> > > > > > What does "BTFs are visible" mean? I find this behavior surprising,
> > > > > > tbh. Map is added to used_maps, but BTF is *not* added to used_btfs?
> > > > > > Why?
> > > > >
> > > > > This functionality is added to catch maps, and work with them during
> > > > > verification, which aren't otherwise referenced by program code. The
> > > > > actual application is those "instructions set" maps for static keys.
> > > > > All other objects are "visible" during verification.
> > > >
> > > > That's your specific intended use case, but API is semantically more
> > > > generic and shouldn't tailor to your specific interpretation on how it
> > > > will/should be used. I think this is a landmine to add reference to
> > > > just BPF maps and not to BTF objects, we won't be able to retrofit the
> > > > proper and uniform treatment later without extra flags or backwards
> > > > compatibility breakage.
> > > >
> > > > Even though we don't need extra "detached" BTF objects associated with
> > > > BPF program, right now, I can anticipate some interesting use case
> > > > where we might want to attach additional BTF objects to BPF programs
> > > > (for whatever reasons, BTFs are a convenient bag of strings and
> > > > graph-based types, so could be useful for extra
> > > > debugging/metadata/whatever information).
> > > >
> > > > So I can see only two ways forward. Either we disable BTFs in fd_array
> > > > if fd_array_cnt>0, which will prevent its usage from light skeleton,
> > > > so not great. Or we bump refcount both BPF maps and BTFs in fd_array.
> > > >
> > > >
> > > > The latter seems saner and I don't think is a problem at all, we
> > > > already have used_btfs that function similarly to used_maps.
> > >
> > > This makes total sense to treat all BPF objects in fd_array the same
> > > way. With BTFs the problem is that, currently, a btf fd can end up
> > > either in used_btfs or kfunc_btf_tab. I will take a look at how easy
> > > it is to merge those two.
> >
> > So, currently during program load BTFs are parsed from file
> > descriptors and are stored in two places: env->used_btfs and
> > env->prog->aux->kfunc_btf_tab:
> >
> >   1) env->used_btfs populated only when a DW load with the
> >      (src_reg == BPF_PSEUDO_BTF_ID) flag set is performed
> >
> >   2) kfunc_btf_tab is populated by __find_kfunc_desc_btf(),
> >      and the source is attr->fd_array[offset]. The kfunc_btf_tab is
> >      sorted by offset to allow faster search
> >
> > So, to merge them something like this might be done:
> >
> >   1) If fd_array_cnt != 0, then on load create a [sorted by offset]
> >      table "used_btfs", formatted similar to kfunc_btf_tab in (2)
> >      above.
> >
> >   2) On program load change (1) to add a btf to this new sorted
> >      used_btfs. As there is no corresponding offset, just use
> >      offset=-1 (not literally like this, as bsearch() wants unique
> >      keys, so by offset=-1 an array of btfs, aka, old used_maps,
> >      should be stored)
> >
> > Looks like this, conceptually, doesn't change things too much: kfuncs
> > btfs will still be searchable in log(n) time, the "normal" btfs will
> > still be searched in used_btfs in linear time.
> >
> > (The other way is to just allow kfunc btfs to be loaded from fd_array
> > if fd_array_cnt != 0, as it is done now, but as you've mentioned
> > before, you had other use cases in mind, so this won't work.)
> >
> > > > >
> > > > > > > +        */
> > > > > > > +       if (!IS_ERR(__btf_get_by_fd(f)))
> > > > > > > +               return 0;
> > > > > > > +
> > > > > > > +       verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
> > > > > > > +       return PTR_ERR(map);
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int process_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr, bpfptr_t uattr)
> > > > > > > +{
> > > > > > > +       size_t size = sizeof(int);
> > > > > > > +       int ret;
> > > > > > > +       int fd;
> > > > > > > +       u32 i;
> > > > > > > +
> > > > > > > +       env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
> > > > > > > +
> > > > > > > +       /*
> > > > > > > +        * The only difference between old (no fd_array_cnt is given) and new
> > > > > > > +        * APIs is that in the latter case the fd_array is expected to be
> > > > > > > +        * continuous and is scanned for map fds right away
> > > > > > > +        */
> > > > > > > +       if (!attr->fd_array_cnt)
> > > > > > > +               return 0;
> > > > > > > +
> > > > > > > +       for (i = 0; i < attr->fd_array_cnt; i++) {
> > > > > > > +               if (copy_from_bpfptr_offset(&fd, env->fd_array, i * size, size))
> > > > > >
> > > > > > potential overflow in `i * size`? Do we limit fd_array_cnt anywhere to
> > > > > > less than INT_MAX/4?
> > > > >
> > > > > Right. So, probably cap to (UINT_MAX/size)?
> > > >
> > > > either that or use check_mul_overflow()
> > >
> > > Ok, will fix it, thanks.
> >
> > On the second look, there's no overflow here, as (int) * (size_t) is
> > expanded by C to (size_t), and argument is also (size_t).
> 
> What about 32-bit architectures? 64-bit ones are not a problem, of course.

Yes, sure, thanks. I added the (U32_MAX/size) limit.

BTW, the resolve_pseudo_ldimm64() also does 

        if (copy_from_bpfptr_offset(&fd,
                                    env->fd_array,
                                    insn[0].imm * sizeof(fd),
                                    sizeof(fd)))

I don't see that insn[0].imm is checked at any place,
or am I wrong?

> > However, maybe this is still makes sense to restrict the maximum size
> > of fd_array to something like (1 << 16). (The number of unique fds in
> > the end will be ~(MAX_USED_MAPS + MAX_USED_BTFS + MAX_KFUNC_BTFS).)
> >
> > > > >
> > > > > > > +                       return -EFAULT;
> > > > > > > +
> > > > > > > +               ret = add_fd_from_fd_array(env, fd);
> > > > > > > +               if (ret)
> > > > > > > +                       return ret;
> > > > > > > +       }
> > > > > > > +
> > > > > > > +       return 0;
> > > > > > > +}
> > > > > > > +
> > > > > >
> > > > > > [...]

