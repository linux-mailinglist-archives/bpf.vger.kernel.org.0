Return-Path: <bpf+bounces-51572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526E9A36271
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 16:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF3C18933DD
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 15:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0A52673B3;
	Fri, 14 Feb 2025 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsRM/3Cp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333292673AA
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 15:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739548658; cv=none; b=s2uGViIBu6EAxjv+4sRq1jZ2AbUkvhnl1yVCr274448MK0xgoT0/5qBQbfWhoMrrwG01mXkGSNsC6Sg+G+ArmReC9N1QsCQW6aTmrmFZIuhENtawGD6Ef/vvuadf8RslllYh9vBGHZLdGp680t4XOf3jJd/50nssr5v+7bOlbh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739548658; c=relaxed/simple;
	bh=U8/Z+oxCPj9LBx1T9RY6FIGX2FeZO+d7OddQnhxVd2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWDSrN0UTANMXFk3d+fKv+Qpsi3MriRTus6uapYjaTMeG0G1+hminowWv8zQjMC2y/njyjjndc19movUl4Alp1VnSWrGtDvuXBPfrdrcKJVMQXLgllPftBmGpLaLd3S5F8IrZ8DT28myUu3kK32c/s1/R98W+7sQJMdLR24lpuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsRM/3Cp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4395578be70so23204855e9.2
        for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 07:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739548654; x=1740153454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8/Z+oxCPj9LBx1T9RY6FIGX2FeZO+d7OddQnhxVd2I=;
        b=DsRM/3CpSU9uVHfxULunsUVgzo69GaSPu9MiI5KAdaJzcmfT/y8SNntKKRTkjoXbVv
         rHZvU/kcZ+asyoLmJH2YhGX4Ym2jU8S2+rHYktwUpo+2KX/zs1vK8DvtAGlYrG3+Z+Zx
         8h02LYnA3n6y+nrwW1gKIq5g1DTDDmvG+2dq2C7qglWYfKEUW/z1T53iRpGg35DJqsHq
         oUP0vK6zKN1gT/AjtQP+VvYI3k2MIvaOEGcC7qbo2EDHkBZDCT3tGiF/zFBty7um6RsP
         NQOlfgzQ7X7NLpd7HZlSVq2hx2v36kA2oy4Ui6SPpG1288xmrD+Mr/49Be4q8hpn5y4L
         OVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739548654; x=1740153454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8/Z+oxCPj9LBx1T9RY6FIGX2FeZO+d7OddQnhxVd2I=;
        b=vvAXGJ7ZvRjY6RAnv74TJEtdF5gQU85VChGJAFqezHimS2F3RdH6im+UeUmSkeMg9S
         p6dfkYc+nJoyDPBr0hApTgQWAEqPOJX8bF29TeZ8Yz24V/bnw1jCEM7IbQDyLT0iGHWG
         Ljt9Fl01uDCKJ+007rnc42Mos2BsBKcI5uTaFBtX3/qoi0Cbce/KLfdGgRTKSBBIbmhh
         5En0YQy4sCgEA8E3eMgGO28kyYbKBz/30fixJoyrG0s/ZNqHvIxDldRSOVQBrKjSQUbd
         s2xh4567+rEC0MADgk4SvIpGCMoUHJoMcpBajpU/xYFMhEHzisnWw+wjXlyd66DcOaqa
         pgAw==
X-Gm-Message-State: AOJu0YyAr0oEsYHVbfJAlbzMd/b3+M5W6spnOoXnFq2POOmGvL3aJK1b
	m+UAqXclwjYVHhk84vuxf03wLtw58CDVVmuquE87rJMhv0mo0azZUYlkZ8TKghb6Lg170SqqURT
	abWMRjTalF0NLu3M48Pz+/UEx5Us=
X-Gm-Gg: ASbGncup1KiGLQoEZshhUVrGN5mL/0RICJwOk56yEkd1oaXQfnIpEICHaqtFtupEViS
	73HaB50RmBgL7T3tgEjcs7blv1ZApxjYDlCZyb+vSUmO8abprhfYHEVsjAPkNdY8vjdmAn/u8IS
	UpvXXAxlFdBaMOIvnTxCFDuNdv+8V5
X-Google-Smtp-Source: AGHT+IGs92dYORi0ccBFXIKHuVVbkjqRcGdYKo+6DP/dOwklXDn1pwKg2GnUWrlH49TQdtmGhB0+iBJeOBs/8CEI6Ew=
X-Received: by 2002:a05:600c:511a:b0:439:6b57:c68 with SMTP id
 5b1f17b1804b1-4396b570e93mr22245855e9.17.1739548654142; Fri, 14 Feb 2025
 07:57:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125111109.732718-1-houtao@huaweicloud.com>
 <20250125111109.732718-8-houtao@huaweicloud.com> <CAADnVQ+D+eZzLX02XmKCGDFvnxCM_za9pKiCzwkrgzUCShCGTA@mail.gmail.com>
 <e61df2a5-d27a-f3f8-8891-48702cc37be5@huaweicloud.com>
In-Reply-To: <e61df2a5-d27a-f3f8-8891-48702cc37be5@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Feb 2025 07:57:23 -0800
X-Gm-Features: AWEUYZmll1dvTZcmYeqW7OLUtp7_EUl0FK5WM3TRmeUJNK_-8cCLwglX9mFEfCw
Message-ID: <CAADnVQJ9QZyN3gQ3L7134a=7UDYcdcE6X_R2ZRdmuMKFbXxg4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 07/20] bpf: Use map_extra to indicate the max
 data size of dynptrs in map key
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Hou Tao <houtao1@huawei.com>, Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 10:13=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> w=
rote:
>
> Hi,
>
> On 2/14/2025 2:02 AM, Alexei Starovoitov wrote:
> > On Sat, Jan 25, 2025 at 2:59=E2=80=AFAM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> For map with dynptr key support, it needs to use map_extra to specify
> >> the maximum data length of these dynptrs. The implementation of the ma=
p
> >> will check whether map_extra is smaller than the limitation imposed by
> >> memory allocation during map creation. It may also use map_extra to
> >> optimize the memory allocation for dynptr.
> > Why limit it?
> > The only piece of code I could find is:
> >
> > uptr->size > map->map_extra
> >
> > and it doesn't look necessary.
> > Let it consume whatever necessary ?
> > .
>
> It will be usable when trying to iterate keys through ->get_next_key()
> in kernel (e.g., support map_seq_show_elem in v3), because for now the
> data memory for dynptr in the map key is allocated by the caller
> (because the callee hold a rcu read lock). If the max length of dynptr
> data is unknown, map_iter_alloc()/map_seq_next() may need some logic to
> probe the max length of dynptr data during the traversal of keys. Will
> check whether or not it is feasible in v3.

It doesn't have to be:
next_key =3D kvmalloc(map->key_size, GFP_USER);
the internal interface can be different.
It's not a good idea to impose uapi restrictions, because of
implementation details.

