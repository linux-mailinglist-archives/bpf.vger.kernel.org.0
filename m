Return-Path: <bpf+bounces-75507-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91277C87715
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 00:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1513B354531
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 23:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FDC2EBBB3;
	Tue, 25 Nov 2025 23:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1hkUorQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786CF2EDD5D
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 23:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764112640; cv=none; b=IS06/Vfk8w6/T+N3mUqYzsZnkrG95dS7ppqabHXBH0n4iw27U5yjxNkft8grKUHqU6bLNo8ZOLapb78E+ne4ZRK7S4Bg3XRQ88cjByXrsHU7jgCynFsQzzGtGOQLePDj4TGUFg1SkDjcQqY5LYYxyfo0A5XhpuKBispRpfhAUHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764112640; c=relaxed/simple;
	bh=fPtAKXFhpWjEtu/g003hTv8SUC1hfqG0WTOqC9NRGpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qy5DcDcfLjHDUkEP5+q4JLaQcRCkyPJNoipCcJyDvRp8Vtp7+CeinqSa5XGxPflP9Cb+CFa4r+xBc6ZZmUITENy3QqWdiSqzCrxxm7Ss64xaHQCsWDjPO/XLnQfyEbbI7lZMyhPQwi2zZR1rmI9IdxH70WcepT9iuEwXfd4QXxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1hkUorQ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b3669ca3dso2417427f8f.0
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 15:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764112637; x=1764717437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLSOfqg3qZ9EiT0Ijffyf4g/E8245w03M66zf9wP0vs=;
        b=F1hkUorQk5IJx0woIzelzIcWKHAIvdIlPCt5wQ3LigbnGx7TAkdxeeGQHUjFVpuiSK
         KTIdQyUEhlJdK6v2mDXBp9MVl+TnrWYIGReniCtr9G5KI9Zx+H7W9vX4G3LG0uO8rOkh
         8WjwNfD9yyvbwCZPIswOeCbdulq29/NgUHW+Eqaaq2iO+2++5PFdYc8h3ED58VfHJyha
         wA2sDJpn2ekx0xBPjaOQMp0EZO+EtWhk95REyRWlvPeG0+f6U+EfpGFNoWRPnV43K1au
         Ag0dxq6hR0Sv4v0nx3sfMHhUvvyejisb6J2/ykIOPhsRUqy+4GGMfou1nhZCmEnjvwx8
         xgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764112637; x=1764717437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sLSOfqg3qZ9EiT0Ijffyf4g/E8245w03M66zf9wP0vs=;
        b=nTS7B6bSnvVL6YAz0jKVk25iHiyAYxeO6FVyzMYje354955u1LEcFO81cF63t4tzQz
         ccvDa7ZX13RqqJWFuB4Aa+0tiNAXL3yH10K6TZGVUEsbDRl7sUIsM7pxuqiCkjWvwE9O
         phxBbwYUSivgus8LkM8zi9X1gnUAFESXs0ODfGl6v+SJfNgQfKc5hxXGWdKg2uHS20ne
         XpSLmifCqEhy1TcaYvZwushdas7B9FbCrbh9P/ZBz07tMXl6c7goXK2mhOcUA8Ze1db1
         cSicNLdtR5poKG2hMgt4Ov2ppKSP0oPXdB2XGGXG3e8xKY7uJ24saAOlGnbxsNJCrKf5
         Rcmw==
X-Forwarded-Encrypted: i=1; AJvYcCVvPnIpaW3QMmY4m7IUWuzriVlgWs05OK38mRiVpMQOquYS7CkCIhqYe5fPsOQZvoH2u7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyBHXAxYfZ0I85cOnpiUztKcsa65WNhxZEPhXYO+/uUS7QFhgc
	ovWMseBM2AmSKGwKQBuKg72epuHSkYhmfmK670ysIRRhJ5Zladiw2b+hL+1VJKRX82I5d6ZdgYM
	/26/oQHTVqmJZCgLabNeRDKB84fDffaE=
X-Gm-Gg: ASbGncueq+/Lv6+Ocq4aThinTW54mu1cg/jk/Q/J355ZqQnJKAlGWq1aLhCxhtw5Fzf
	vjcooK1+RmR3j/25UjeLl+q86eJ1CKQk60TuR2llqPtcaDfjsnw1dYSw7xveyLtbwGUuBA+eFOy
	akq+vfgPNCDq5qRgXZN8CquVUiOMxKzoa2oae0mNHyZg+QUcrrRq+l2PKI+21zCvLugHg+L1UZt
	91kHruZMG44ZLGEyjhbTMRQ8AumNEG3UzowgmLoNOJ9xlrKFeb1jgpwwCN7TVcD3PzKnJ4nRBTo
	U8LmT0rqW6pYvwzANxF/4q4BxvCv
X-Google-Smtp-Source: AGHT+IHEWsTozgou/pnRfEXK8uZ0aowwSg3iDEyiQKCbz92wGX3OzqL/Zkz2hMV5yi0Vtwwu2UOG9/GpQzrivJsGndo=
X-Received: by 2002:a5d:5888:0:b0:42b:3b55:8908 with SMTP id
 ffacd0b85a97d-42cc1d22c70mr17557659f8f.51.1764112636605; Tue, 25 Nov 2025
 15:17:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1d2d1968.47cd3.19ab9528e94.Coremail.kaiyanm@hust.edu.cn> <CAMB2axMgCapnYS4Qr-PVm6FjPCkF3bi-LNtV5EpFLVtAs_JNGA@mail.gmail.com>
In-Reply-To: <CAMB2axMgCapnYS4Qr-PVm6FjPCkF3bi-LNtV5EpFLVtAs_JNGA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Nov 2025 15:17:04 -0800
X-Gm-Features: AWmQ_bm-G43xKnBmLbbQsLt7bv53xzROL4G9PZhsR3l3ArX-c_IF5To_mwIjcyo
Message-ID: <CAADnVQ+fDin56GSBaANBf0P+xiQYGWgcDZFT=2OnRKhCa04Kdg@mail.gmail.com>
Subject: Re: bpf: Race condition in inode local storage leads to use-after-free
To: Amery Hung <ameryhung@gmail.com>
Cc: =?UTF-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Yinhao Hu <dddddd@hust.edu.cn>, dzm91@hust.edu.cn, 
	hust-os-kernel-patches@googlegroups.com, 
	Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 3:06=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Mon, Nov 24, 2025 at 8:43=E2=80=AFPM =E6=A2=85=E5=BC=80=E5=BD=A6 <kaiy=
anm@hust.edu.cn> wrote:
> >
> > A use-after-free vulnerability was discovered in the `bpf_inode_storage=
_get` helper function. This flaw is caused by a race condition between the =
destruction of the anonymous inode that backs the map of type `BPF_MAP_TYPE=
_INODE_STORAGE` and the execution of a BPF program that attempts to access =
that inode.
> >
> > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> >
> > ## Root Cause
> >
> > The use-after-free occurs due to improper lifecycle management of the a=
nonymous inode associated with a `BPF_MAP_TYPE_INODE_STORAGE` map. The prob=
lem could be triggered through a race condition:
> >
> > 1.  A BPF program creates a map of type `BPF_MAP_TYPE_INODE_STORAGE`. T=
he kernel allocates a file descriptor and an associated anonymous `inode` t=
o serve as the backing storage.
> > 2.  A BPF LSM program is loaded and attached to an LSM hook `bpf_lsm_fi=
le_alloc_security`. This program holds a reference to the `inode_storage` m=
ap.
> > 3.  The process that created the map exits, causing the kernel to close=
 its file descriptor. This decrements the reference count on the `inode`. W=
hen the reference count drops to zero, the `inode` is freed.
> > 4.  When another process trys to create the map, the LSM hook is trigge=
red, causing the attached BPF program to execute.
> > 5.  The BPF program calls `bpf_inode_storage_get()`, passing a pointer =
to the now-freed `inode`. The function attempts to access fields within thi=
s freed memory region, leading to a use-after-free.
> >
> > The fundamental problem is that the BPF program's reference to the `bpf=
_map` does not translate to a reference on the underlying `inode`. This all=
ows the `inode` to be destroyed while it is still potentially in use by an =
active BPF program. The comment in the `bpf_inode_storage_get` function, `/=
* This helper must only called from where the inode is guaranteed to have a=
 refcount and cannot be freed. */`, highlights this exact requirement, whic=
h is violated by the race condition.
>
> Thanks for reporting. I found the root cause here a bit hard to
> follow, so I also ran your POC on a VM with bpf-next kernel and
> confirmed the kernel did panic.
>
> However, the bug seems to me to be an uninitialized file->f_inode
> being passed to bpf_inode_storage_get() in
> bpf_lsm_file_alloc_security.

Thanks for the analysis.
That's not the first such problematic lsm hook.
Let's just add it to bpf_lsm_disabled_hooks[].

