Return-Path: <bpf+bounces-46495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB989EAB22
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 09:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D9F166ABE
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 08:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6912D230D21;
	Tue, 10 Dec 2024 08:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="SMYKCPbm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5062AEE7
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 08:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733820968; cv=none; b=pPKElcGB/OTBtCHNIk2kq6BpSRWZEzF/iv9Qe2yoO2bpp/8JZ6pp/Bb67xi5hY0MNlxRQbWrKSdfsZptyIKJooLPdBHPKRMYrXiVAIdw7QafEuiFKhDL8fbAIqzGXKb7mXj4e/MvPhyUhLL0OfVsTSurygCIgrrgY+983U2wWpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733820968; c=relaxed/simple;
	bh=7CUwUdIAVY6sBLQrNHIgdyErA2jrl34vATNfk7IzuCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ku2dWoaKAkwfuQmgWvdoz0gOoOs7L+VL7rMRVNhFTODE+4eak2+Ilg67BWKJp72nLiTf/9jnS8tIYmPnxm8pVjiUgDiisJDQUNHjWwBZzBXYCsgQcBI3TInwMH/vnV5pXuMPl1uahU/DB0qnevVWyYdF2XXAsLPbLVdsuiN9l6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=SMYKCPbm; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a736518eso57858795e9.1
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 00:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1733820964; x=1734425764; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E6VHQTC4ZpyuSP/n5aent2g+9URInKSz+s0JcMBFCbg=;
        b=SMYKCPbm5jrAmYo25pPDGaNkZnrJhpGky86sUG2hO50uVkMuTx23BuHe+Ybts9FCqs
         2i34lM3nSDWzxbDZUUdM+N6J4UI4Ntlelk9/oR1HFJEKl5GAGfrBhJ5Rx7SZ/P44WBi5
         fLRq/t+zCGi5VdRJRMu1o/uKUJ6MgFql15RGpPiN+A1dir6K5RWPiNcInuOIUhHBf7jD
         f21pbtulSXJuHnKitafCwkYVNT/4G+vzvTPJiO8vgZvOaqIXawuUCHE+YJ2dEiYDpSII
         vN+qvlHp7md6orBPUuJjjmTx6YjysNOs8d58E9IBpQ6iULEetPNES23CmjY7vIUy0t34
         PpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733820964; x=1734425764;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6VHQTC4ZpyuSP/n5aent2g+9URInKSz+s0JcMBFCbg=;
        b=GnTz3rADmJYS8tJPPKSsexwdsM5GlT+jnKaZmrL80O89ZVL/WUjeAr4jQSsOVyHEee
         71DPJwp4ubRApVW35U8PxmkSe01XrlGCUvbv1vhBPgLVcwd8W6fdOBCYRwm8CsqtLxOy
         4CB33FziEVzB87d5QtPVGzTEYkuwkYOSFzhAgwhOwqXAXilLtgW+5u8jows/J3X3+bej
         QC3rumElKFsuZHtfPBotoCfIKEajnv2nANpkgyWx8BUxPkR2EDhljvZXvRlDLi6TTCB4
         y8i1ygtgXfNp3lAJJ9qgKqwlbQX3BnjMzb8hFuKmor39goKQd7q4Hk2E08+oH4nmwXiq
         kb9g==
X-Gm-Message-State: AOJu0Yw5EFcIAeEQ5WTXlKX4HBjpra5xlA+d3q7BIqk9BnNeyz6txudx
	W+A3tO30T/rR9cFzCo0zE5S5vACEE5MWrEt1aWFLZ1NoqV0CovVsNNwszWmNxc0=
X-Gm-Gg: ASbGncto1y+v0cyHVGR8/pCBSzPQjwqIuZT9n8Sj/xdrI69IgIQtg+aMI7/Eh3jLwau
	DFi0D9DzOTy7pXPApcAmk5hP9SZiYgugsD2zFylKd0kIdOsydRRbC8NqBeR2iDJTn7j8Rsaz4pZ
	i0wuB2NyVjq0T3OcpUeyyCzxu0bOKbRE6B3T9wv4IhmsBq0pdVIlIpZWkGLbyOVjxvUE8uKn0D+
	M6OIBd0KZRcYNnlb/gFmRoJlzxQxp0KvJ22SeRBwZA=
X-Google-Smtp-Source: AGHT+IFM2LU8hV1tD8014ikpwsxqBa8FXfmKbHaHLnCTvb7Tb1iXWFSjY2BAvOzXDpVwK/Sif8CtaA==
X-Received: by 2002:a05:600c:3b99:b0:434:a781:f5d9 with SMTP id 5b1f17b1804b1-434fff41467mr33391865e9.11.1733820964187;
        Tue, 10 Dec 2024 00:56:04 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f1125e69sm102946175e9.32.2024.12.10.00.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 00:56:03 -0800 (PST)
Date: Tue, 10 Dec 2024 08:58:01 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 3/7] bpf: add fd_array_cnt attribute for
 prog_load
Message-ID: <Z1gCmV3Z62HXjAtK@eis>
References: <20241203135052.3380721-1-aspsk@isovalent.com>
 <20241203135052.3380721-4-aspsk@isovalent.com>
 <CAEf4BzZiD_iYpBkf5q5U9VoSUAFJN8dxOBWNJdT5y9DxAe=_UQ@mail.gmail.com>
 <Z1BJc/iK3ecPKTUx@eis>
 <CAEf4BzZVkNRV+8ROMMM-oGdHd1HUSx3WVv77TK+H4Fr8PhHHBQ@mail.gmail.com>
 <Z1FnPIuBiJFMRrLP@eis>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1FnPIuBiJFMRrLP@eis>

On 24/12/05 08:41AM, Anton Protopopov wrote:
> On 24/12/04 10:08AM, Andrii Nakryiko wrote:
> > On Wed, Dec 4, 2024 at 4:19 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > >
> > > On 24/12/03 01:25PM, Andrii Nakryiko wrote:
> > > > On Tue, Dec 3, 2024 at 5:48 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > > >
> > > > > The fd_array attribute of the BPF_PROG_LOAD syscall may contain a set
> > > > > of file descriptors: maps or btfs. This field was introduced as a
> > > > > sparse array. Introduce a new attribute, fd_array_cnt, which, if
> > > > > present, indicates that the fd_array is a continuous array of the
> > > > > corresponding length.
> > > > >
> > > > > If fd_array_cnt is non-zero, then every map in the fd_array will be
> > > > > bound to the program, as if it was used by the program. This
> > > > > functionality is similar to the BPF_PROG_BIND_MAP syscall, but such
> > > > > maps can be used by the verifier during the program load.
> > > > >
> > > > > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > > > > ---
> > > > >  include/uapi/linux/bpf.h       | 10 ++++
> > > > >  kernel/bpf/syscall.c           |  2 +-
> > > > >  kernel/bpf/verifier.c          | 98 ++++++++++++++++++++++++++++------
> > > > >  tools/include/uapi/linux/bpf.h | 10 ++++
> > > > >  4 files changed, 104 insertions(+), 16 deletions(-)
> > > > >
> > > >
> > > > [...]
> > > >
> > > > > +/*
> > > > > + * The add_fd_from_fd_array() is executed only if fd_array_cnt is non-zero. In
> > > > > + * this case expect that every file descriptor in the array is either a map or
> > > > > + * a BTF. Everything else is considered to be trash.
> > > > > + */
> > > > > +static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
> > > > > +{
> > > > > +       struct bpf_map *map;
> > > > > +       CLASS(fd, f)(fd);
> > > > > +       int ret;
> > > > > +
> > > > > +       map = __bpf_map_get(f);
> > > > > +       if (!IS_ERR(map)) {
> > > > > +               ret = __add_used_map(env, map);
> > > > > +               if (ret < 0)
> > > > > +                       return ret;
> > > > > +               return 0;
> > > > > +       }
> > > > > +
> > > > > +       /*
> > > > > +        * Unlike "unused" maps which do not appear in the BPF program,
> > > > > +        * BTFs are visible, so no reason to refcnt them now
> > > >
> > > > What does "BTFs are visible" mean? I find this behavior surprising,
> > > > tbh. Map is added to used_maps, but BTF is *not* added to used_btfs?
> > > > Why?
> > >
> > > This functionality is added to catch maps, and work with them during
> > > verification, which aren't otherwise referenced by program code. The
> > > actual application is those "instructions set" maps for static keys.
> > > All other objects are "visible" during verification.
> > 
> > That's your specific intended use case, but API is semantically more
> > generic and shouldn't tailor to your specific interpretation on how it
> > will/should be used. I think this is a landmine to add reference to
> > just BPF maps and not to BTF objects, we won't be able to retrofit the
> > proper and uniform treatment later without extra flags or backwards
> > compatibility breakage.
> > 
> > Even though we don't need extra "detached" BTF objects associated with
> > BPF program, right now, I can anticipate some interesting use case
> > where we might want to attach additional BTF objects to BPF programs
> > (for whatever reasons, BTFs are a convenient bag of strings and
> > graph-based types, so could be useful for extra
> > debugging/metadata/whatever information).
> > 
> > So I can see only two ways forward. Either we disable BTFs in fd_array
> > if fd_array_cnt>0, which will prevent its usage from light skeleton,
> > so not great. Or we bump refcount both BPF maps and BTFs in fd_array.
> > 
> > 
> > The latter seems saner and I don't think is a problem at all, we
> > already have used_btfs that function similarly to used_maps.
> 
> This makes total sense to treat all BPF objects in fd_array the same
> way. With BTFs the problem is that, currently, a btf fd can end up
> either in used_btfs or kfunc_btf_tab. I will take a look at how easy
> it is to merge those two.

So, currently during program load BTFs are parsed from file
descriptors and are stored in two places: env->used_btfs and
env->prog->aux->kfunc_btf_tab:

  1) env->used_btfs populated only when a DW load with the
     (src_reg == BPF_PSEUDO_BTF_ID) flag set is performed

  2) kfunc_btf_tab is populated by __find_kfunc_desc_btf(),
     and the source is attr->fd_array[offset]. The kfunc_btf_tab is
     sorted by offset to allow faster search

So, to merge them something like this might be done:

  1) If fd_array_cnt != 0, then on load create a [sorted by offset]
     table "used_btfs", formatted similar to kfunc_btf_tab in (2)
     above.

  2) On program load change (1) to add a btf to this new sorted
     used_btfs. As there is no corresponding offset, just use
     offset=-1 (not literally like this, as bsearch() wants unique
     keys, so by offset=-1 an array of btfs, aka, old used_maps,
     should be stored)

Looks like this, conceptually, doesn't change things too much: kfuncs
btfs will still be searchable in log(n) time, the "normal" btfs will
still be searched in used_btfs in linear time.

(The other way is to just allow kfunc btfs to be loaded from fd_array
if fd_array_cnt != 0, as it is done now, but as you've mentioned
before, you had other use cases in mind, so this won't work.)

> > >
> > > > > +        */
> > > > > +       if (!IS_ERR(__btf_get_by_fd(f)))
> > > > > +               return 0;
> > > > > +
> > > > > +       verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
> > > > > +       return PTR_ERR(map);
> > > > > +}
> > > > > +
> > > > > +static int process_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr, bpfptr_t uattr)
> > > > > +{
> > > > > +       size_t size = sizeof(int);
> > > > > +       int ret;
> > > > > +       int fd;
> > > > > +       u32 i;
> > > > > +
> > > > > +       env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
> > > > > +
> > > > > +       /*
> > > > > +        * The only difference between old (no fd_array_cnt is given) and new
> > > > > +        * APIs is that in the latter case the fd_array is expected to be
> > > > > +        * continuous and is scanned for map fds right away
> > > > > +        */
> > > > > +       if (!attr->fd_array_cnt)
> > > > > +               return 0;
> > > > > +
> > > > > +       for (i = 0; i < attr->fd_array_cnt; i++) {
> > > > > +               if (copy_from_bpfptr_offset(&fd, env->fd_array, i * size, size))
> > > >
> > > > potential overflow in `i * size`? Do we limit fd_array_cnt anywhere to
> > > > less than INT_MAX/4?
> > >
> > > Right. So, probably cap to (UINT_MAX/size)?
> > 
> > either that or use check_mul_overflow()
> 
> Ok, will fix it, thanks.

On the second look, there's no overflow here, as (int) * (size_t) is
expanded by C to (size_t), and argument is also (size_t).

However, maybe this is still makes sense to restrict the maximum size
of fd_array to something like (1 << 16). (The number of unique fds in
the end will be ~(MAX_USED_MAPS + MAX_USED_BTFS + MAX_KFUNC_BTFS).)

> > >
> > > > > +                       return -EFAULT;
> > > > > +
> > > > > +               ret = add_fd_from_fd_array(env, fd);
> > > > > +               if (ret)
> > > > > +                       return ret;
> > > > > +       }
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > >
> > > > [...]

