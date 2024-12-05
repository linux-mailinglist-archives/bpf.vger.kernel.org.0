Return-Path: <bpf+bounces-46134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EDE9E4FEB
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 09:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D22F28546F
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 08:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A32A1D4339;
	Thu,  5 Dec 2024 08:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="MDfAJeGW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15B41CB332
	for <bpf@vger.kernel.org>; Thu,  5 Dec 2024 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387964; cv=none; b=U5oRPP/bOGWRPi4hA/vS4PdLBU8S4hMdN2Zsns5YkJ4ZDxkgl6RLfhYX0N/egwe/qIjaL1cA4M32SrjMvKxLdylxkXp2UbnJ77fGhEh0VKfiGMN9zmjpBLspWY2mLPIjG4be+XDomRReYKf/q8VtlcriLSwpbqHFj46N0fR5yno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387964; c=relaxed/simple;
	bh=anvYJVmpGJkmrznR3QTCngs9G0hPvu5Mnc4Gt4oSp4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKcAld+CrsrVWPPOKVlzZ03LB3/dfIsv74s4cB7IFIiT4/UiwdiG3lREHMF3ZZYV9vUbIjPPiy3dTCIySHe5DQgGOinMNOb9ilS+j8HR42WQW/7lhw4+cRDysdgWpC+pR409FisfuOegioUh8SO5tiLXvlEPemxC0aZ6rqIa1gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=MDfAJeGW; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385df8815fcso291295f8f.1
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 00:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1733387961; x=1733992761; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V9X2cms4LheEAEKKBQBCWYM7Mt/ZzZd7qnh00F8qyJ8=;
        b=MDfAJeGW/hy36zxT7PrAcyy71fDFxlHzBSO91MrEso0lgrKWS7WCsEH++TogmzXkGk
         nbbdviImfr1+9+bsCv1LFksj2C/UPgwbkFRWG1N5UqseZwSe+ZQj4e4/SRDtZZyfmppC
         Od81zZWPcypCVovGEC+RWbKqYM68E5no4+1xxQy87fKdexHq9QMH1KsX6wPs3n4/hIv9
         rYnozNI8c8KBPxFi2H2QloLW73DTynKJmZTidLmjLRfRRxZqZI6PSyE+JveanFCTA0HH
         tGff7VXKfsLJODtABf0lnLcBuVFm2jteVn3R9t3zIFfhgQggIQrb90rB9XeUvQyAgJHP
         SyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733387961; x=1733992761;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9X2cms4LheEAEKKBQBCWYM7Mt/ZzZd7qnh00F8qyJ8=;
        b=IK/PAXJvsVHeOQWbKlVlk1ZRTdZw7majVnLHheEMrMhU3ehbRKnJF4PAfzLeOX2uvY
         lw4R546lpgylG84ab+Mg6QVTo8gynizxGsZTRmHwLAI/G1LZde27CHpVuAmEYCo0g4Qo
         mSPlcPRkrf5ydKilpciMSWnQHNHjBb6mxBZ1bp2JSqaFgVY1FFapxdLn5W3yytYI5k65
         tNgg8fVDRe95LnNJ7aVgc9T907CNKd3yRRqzGbSLsmCIeJWUkBmgldhWIHTCrTD6/a88
         C1cJ5Z5+sP09qfcwvRnzn+6RVRTpjienvcWpnPj1Wcp5isukrryRNND18re1REJK7JCv
         Curg==
X-Gm-Message-State: AOJu0Yxfz9puRzi0rOZeK5EnzV1MZAqpZA/SO1uhPV608wQfMPqWTNhX
	cHEOw9E9YsgmQoRK2Ephj/7xw6m7zVXylPFz9nN4e1MSGyo1BMHNt2CSalpaljYkJeXFaf4uVWg
	Z
X-Gm-Gg: ASbGncswzI2PSoJv5vxnO27+qza3JTky/RHHJGo9ul6XOfSoGBwMjXTd1fKL6OTHJCg
	IJ1SPVzQqOLf2/sQ5qeTFF1V7gdqmvq+s1sTo+wbfD8IReM/A5qPetXTWF3nseS+YG6h6lpcp6C
	k/+xQIZPm/1gAQdd4bAcplk5cSlOStKVrRCZxPaAIZd+saoJF3K27IFyWa7nlknrkKEIA02b4PC
	AzFgdS55TM+h9cinAUyv6LiX4iFM2MYdV6fbmQ=
X-Google-Smtp-Source: AGHT+IHl0O6jI0WKWAdzBQQL4yJkr+Cuf5VnHqZ1wHSE6AZUqshHS2V1Z+5S/IRnjMjf4r3tBQQ34A==
X-Received: by 2002:a5d:584f:0:b0:385:fc00:f5f9 with SMTP id ffacd0b85a97d-385fd3ec00cmr6620656f8f.18.1733387961022;
        Thu, 05 Dec 2024 00:39:21 -0800 (PST)
Received: from eis ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0dabf7sm15917885e9.24.2024.12.05.00.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 00:39:20 -0800 (PST)
Date: Thu, 5 Dec 2024 08:41:32 +0000
From: Anton Protopopov <aspsk@isovalent.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 3/7] bpf: add fd_array_cnt attribute for
 prog_load
Message-ID: <Z1FnPIuBiJFMRrLP@eis>
References: <20241203135052.3380721-1-aspsk@isovalent.com>
 <20241203135052.3380721-4-aspsk@isovalent.com>
 <CAEf4BzZiD_iYpBkf5q5U9VoSUAFJN8dxOBWNJdT5y9DxAe=_UQ@mail.gmail.com>
 <Z1BJc/iK3ecPKTUx@eis>
 <CAEf4BzZVkNRV+8ROMMM-oGdHd1HUSx3WVv77TK+H4Fr8PhHHBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZVkNRV+8ROMMM-oGdHd1HUSx3WVv77TK+H4Fr8PhHHBQ@mail.gmail.com>

On 24/12/04 10:08AM, Andrii Nakryiko wrote:
> On Wed, Dec 4, 2024 at 4:19 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> >
> > On 24/12/03 01:25PM, Andrii Nakryiko wrote:
> > > On Tue, Dec 3, 2024 at 5:48 AM Anton Protopopov <aspsk@isovalent.com> wrote:
> > > >
> > > > The fd_array attribute of the BPF_PROG_LOAD syscall may contain a set
> > > > of file descriptors: maps or btfs. This field was introduced as a
> > > > sparse array. Introduce a new attribute, fd_array_cnt, which, if
> > > > present, indicates that the fd_array is a continuous array of the
> > > > corresponding length.
> > > >
> > > > If fd_array_cnt is non-zero, then every map in the fd_array will be
> > > > bound to the program, as if it was used by the program. This
> > > > functionality is similar to the BPF_PROG_BIND_MAP syscall, but such
> > > > maps can be used by the verifier during the program load.
> > > >
> > > > Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> > > > ---
> > > >  include/uapi/linux/bpf.h       | 10 ++++
> > > >  kernel/bpf/syscall.c           |  2 +-
> > > >  kernel/bpf/verifier.c          | 98 ++++++++++++++++++++++++++++------
> > > >  tools/include/uapi/linux/bpf.h | 10 ++++
> > > >  4 files changed, 104 insertions(+), 16 deletions(-)
> > > >
> > >
> > > [...]
> > >
> > > > +/*
> > > > + * The add_fd_from_fd_array() is executed only if fd_array_cnt is non-zero. In
> > > > + * this case expect that every file descriptor in the array is either a map or
> > > > + * a BTF. Everything else is considered to be trash.
> > > > + */
> > > > +static int add_fd_from_fd_array(struct bpf_verifier_env *env, int fd)
> > > > +{
> > > > +       struct bpf_map *map;
> > > > +       CLASS(fd, f)(fd);
> > > > +       int ret;
> > > > +
> > > > +       map = __bpf_map_get(f);
> > > > +       if (!IS_ERR(map)) {
> > > > +               ret = __add_used_map(env, map);
> > > > +               if (ret < 0)
> > > > +                       return ret;
> > > > +               return 0;
> > > > +       }
> > > > +
> > > > +       /*
> > > > +        * Unlike "unused" maps which do not appear in the BPF program,
> > > > +        * BTFs are visible, so no reason to refcnt them now
> > >
> > > What does "BTFs are visible" mean? I find this behavior surprising,
> > > tbh. Map is added to used_maps, but BTF is *not* added to used_btfs?
> > > Why?
> >
> > This functionality is added to catch maps, and work with them during
> > verification, which aren't otherwise referenced by program code. The
> > actual application is those "instructions set" maps for static keys.
> > All other objects are "visible" during verification.
> 
> That's your specific intended use case, but API is semantically more
> generic and shouldn't tailor to your specific interpretation on how it
> will/should be used. I think this is a landmine to add reference to
> just BPF maps and not to BTF objects, we won't be able to retrofit the
> proper and uniform treatment later without extra flags or backwards
> compatibility breakage.
> 
> Even though we don't need extra "detached" BTF objects associated with
> BPF program, right now, I can anticipate some interesting use case
> where we might want to attach additional BTF objects to BPF programs
> (for whatever reasons, BTFs are a convenient bag of strings and
> graph-based types, so could be useful for extra
> debugging/metadata/whatever information).
> 
> So I can see only two ways forward. Either we disable BTFs in fd_array
> if fd_array_cnt>0, which will prevent its usage from light skeleton,
> so not great. Or we bump refcount both BPF maps and BTFs in fd_array.
> 
> 
> The latter seems saner and I don't think is a problem at all, we
> already have used_btfs that function similarly to used_maps.

This makes total sense to treat all BPF objects in fd_array the same
way. With BTFs the problem is that, currently, a btf fd can end up
either in used_btfs or kfunc_btf_tab. I will take a look at how easy
it is to merge those two.

> >
> > > > +        */
> > > > +       if (!IS_ERR(__btf_get_by_fd(f)))
> > > > +               return 0;
> > > > +
> > > > +       verbose(env, "fd %d is not pointing to valid bpf_map or btf\n", fd);
> > > > +       return PTR_ERR(map);
> > > > +}
> > > > +
> > > > +static int process_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr, bpfptr_t uattr)
> > > > +{
> > > > +       size_t size = sizeof(int);
> > > > +       int ret;
> > > > +       int fd;
> > > > +       u32 i;
> > > > +
> > > > +       env->fd_array = make_bpfptr(attr->fd_array, uattr.is_kernel);
> > > > +
> > > > +       /*
> > > > +        * The only difference between old (no fd_array_cnt is given) and new
> > > > +        * APIs is that in the latter case the fd_array is expected to be
> > > > +        * continuous and is scanned for map fds right away
> > > > +        */
> > > > +       if (!attr->fd_array_cnt)
> > > > +               return 0;
> > > > +
> > > > +       for (i = 0; i < attr->fd_array_cnt; i++) {
> > > > +               if (copy_from_bpfptr_offset(&fd, env->fd_array, i * size, size))
> > >
> > > potential overflow in `i * size`? Do we limit fd_array_cnt anywhere to
> > > less than INT_MAX/4?
> >
> > Right. So, probably cap to (UINT_MAX/size)?
> 
> either that or use check_mul_overflow()

Ok, will fix it, thanks.

> >
> > > > +                       return -EFAULT;
> > > > +
> > > > +               ret = add_fd_from_fd_array(env, fd);
> > > > +               if (ret)
> > > > +                       return ret;
> > > > +       }
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > >
> > > [...]

