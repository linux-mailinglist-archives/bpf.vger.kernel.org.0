Return-Path: <bpf+bounces-70459-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D24BBFCD7
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 01:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83D443A568B
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 23:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C18212574;
	Mon,  6 Oct 2025 23:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKOZwSAK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DDA35962
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 23:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759795058; cv=none; b=a9LoJpJLK0YBRSikQeq45UcX3rDNXJLUlaoWer8JpJZPP5i3TBgALeJkEjCHAknHXd3dt7fmvNmlRNypr3Vm5vwtZHax5vbftrS/4yIh5iQSvvRn28J0DvJvG+rQy2voq7SsQrP2SeoXPjBJpZ9NLZ9KvkTBiXrNUCKuOur0gnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759795058; c=relaxed/simple;
	bh=aeO5Bf807sImgx5mKyNh9w4Vqa9UgFwbmFN57TCeihs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P153RGkvIvhCPATfm2zlt2pQZU1XWtx5ct3XLw4aWslRq0p1OohpeUk5JkUMSI7Bm5Bdsw6URMpmQ25K2PSutXcS2t9C0RM0uqh4RcONxZrva+gWQVzvswJ/72aDWTRUN3Pi0bsZSqfmsL2vF4JyKUi+K72NGCXueai4Xcb1oBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKOZwSAK; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-339c9bf3492so4539235a91.2
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 16:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759795056; x=1760399856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aeO5Bf807sImgx5mKyNh9w4Vqa9UgFwbmFN57TCeihs=;
        b=jKOZwSAKnqtGSoXK1jf1Eyj4niDmjFYchVp942+iNgDf7FHGhW0NlgagwsU/w4pf9D
         FoGNgRCROSrlOFgB60Qru0V32K8p+ip6ZY6oFluhHTzS5oCp8TxKF+dYoosPPM29qoVT
         eAYjOvo6HpmtUVcbCL0XR8yNRVMcsVdY6AetiJnnwU3JfDLSpHi0BOynCkVNvuAY5kmX
         ML4YowpuzeK5gl+MSdz/KSiLydgo5aHDuQdsJiCmw3iuKFAchgPkF9ee5E56O/nlsbKM
         3vNs5YexqAMI+wePl9EueVvbm3Dw0AIh33cc64oUth/oN0CMInpj/JE7dYtRxLn8WFz0
         iobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759795056; x=1760399856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeO5Bf807sImgx5mKyNh9w4Vqa9UgFwbmFN57TCeihs=;
        b=u6k9KIXCCDPuFWNmteuYW01tiWZ+5pBu6ixpfF1BPV5SDd1cf0S6c+0h/PYEv2McEK
         HIZ0sQH56fUb1nANSluzz8eteCvEdxECGvL2gTRC/P+dj3igGb1i6EU2FFhHxj1aZ5bn
         AQuHgTB3Q0aBu9Jwb6WfeDdn5vcb29btXtEJ27wYF9dnWMVar1YP40k2g78zDaYIKo5d
         j0n9sGAWHw8xD6MoTxePG4hA2H9LrHc/ee9xHCuJi5qJm765QQeojQDW7akAlNs7uMme
         4wNCV0uhJYduKdZVVvwc7Y7ybcmgshm48ROmfLLT6K19lZfH4ecWVOV3g32Lb0Z+cjAU
         0HaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXytiU6GJjmf6RxvsRmwPERraEgGCdHOKUKhyrBjmUoTQHGLBRie0NqG/qKaHgg+WMSTxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz07wmYNIUhwUixg7+U2ry4xoGDblXvHe5HsolU8d4y2+z2xBwp
	0BCGHMkyANeisj7X8ItVeVopOTmP/c5Ty5262gzRqoykBt2CBLv/u5E2YwA1sNkpRBBildP49O5
	snxJpTT5GRAjGMeABgt2W0kPAWU/DAYyVUg==
X-Gm-Gg: ASbGnctnPhxDTZXsO0rvmUhj9igWYbIHAqoGocOKuKgWoRizPZaFYXKNhEwoc4Te1ro
	8HOExXPuPubGDQrWFx53C5DQE6nw121m9FDYQujEVMMCEbroH5beZzQqY52dEst2GMuZPTDxh3z
	0RMe4wKcb4+UDbDOQxoIWUXR3LtLzYn8jkd5WoSbjtVY35SQ6QKKKLx/aywWpVIQrzSzaG3LA7N
	/DieZv8Bex9Wy+v/e+zO+ZBtxt/8eXdH8kWfS1iwnA867o=
X-Google-Smtp-Source: AGHT+IFlbKfL5TblKqKnNhOe1oc4J8CKVBhJt//RaO+QWpyXhCbuSLuhVLl88NwO9ryI7OF3HhUw0Ia1vy0lp2lGsro=
X-Received: by 2002:a17:90b:1b50:b0:32d:17ce:49d5 with SMTP id
 98e67ed59e1d1-339c27a58d2mr18475006a91.23.1759795056201; Mon, 06 Oct 2025
 16:57:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
 <20250818170136.209169-2-roman.gushchin@linux.dev> <CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
 <87ms7tldwo.fsf@linux.dev> <1f2711b1-d809-4063-804b-7b2a3c8d933e@linux.dev>
 <87wm6rwd4d.fsf@linux.dev> <ef890e96-5c2a-4023-bcb2-7ffd799155be@linux.dev>
 <CAADnVQ+LGbXXHHTbBB9b-RjAXO4B6=3Z=G0=7ToZVuH61OONWA@mail.gmail.com>
 <87iki0n4lm.fsf@linux.dev> <a76ad1e9-07d5-4ba1-83e4-22fe36a32df0@linux.dev>
 <877bxb77eh.fsf@linux.dev> <CAEf4BzafXv-PstSAP6krers=S74ri1+zTB4Y2oT6f+33yznqsA@mail.gmail.com>
 <871pnfk2px.fsf@linux.dev>
In-Reply-To: <871pnfk2px.fsf@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 Oct 2025 16:57:22 -0700
X-Gm-Features: AS18NWAXVJ5dXSA50rDM1SRzH9Tu_dSgFwL-2Wcn7bv26ZAPiAQh2VJdbHvxDyA
Message-ID: <CAEf4BzaVvNwt18eqVpigKh8Ftm=KfO_EsB2Hoh+LQCDLsWxRwg@mail.gmail.com>
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 4:52=E2=80=AFPM Roman Gushchin <roman.gushchin@linux=
.dev> wrote:
>
> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>
> > On Fri, Oct 3, 2025 at 7:01=E2=80=AFPM Roman Gushchin <roman.gushchin@l=
inux.dev> wrote:
> >>
> >> Martin KaFai Lau <martin.lau@linux.dev> writes:
> >>
> >> > On 9/2/25 10:31 AM, Roman Gushchin wrote:
> >> >> Btw, what's the right way to attach struct ops to a cgroup, if ther=
e is
> >> >> one? Add a cgroup_id field to the struct and use it in the .reg()
> >> >
> >> > Adding a cgroup id/fd field to the struct bpf_oom_ops will be hard t=
o
> >> > attach the same bpf_oom_ops to multiple cgroups.
> >> >
> >> >> callback? Or there is something better?
> >> >
> >> > There is a link_create.target_fd in the "union bpf_attr". The
> >> > cgroup_bpf_link_attach() is using it as cgroup fd. May be it can be
> >> > used here also. This will limit it to link attach only. Meaning the
> >> > SEC(".struct_ops.link") is supported but not the older
> >> > SEC(".struct_ops"). I think this should be fine.
> >>
> >> I thought a bit more about it (sorry for the delay):
> >> if we want to be able to attach a single struct ops to multiple cgroup=
s
> >> (and potentially other objects, e.g. sockets), we can't really
> >> use the existing struct ops's bpf_link.
> >>
> >> So I guess we need to add a new .attach() function beside .reg()
> >> which will take the existing link and struct bpf_attr as arguments and
> >> return a new bpf_link. And in libbpf we need a corresponding new
> >> bpf_link__attach_cgroup().
> >>
> >> Does it sound right?
> >>
> >
> > Not really, but I also might be missing some details (I haven't read
> > the entire thread).
> >
> > But conceptually, what you describe is not how things work w.r.t. BPF
> > links and attachment.
> >
> > You don't attach a link to some hook (e.g., cgroup). You attach either
> > BPF program or (as in this case) BPF struct_ops map to a hook (i.e.,
> > cgroup), and get back the BPF link. That BPF link describes that one
> > attachment of prog/struct_ops to that hook. Each attachment gets its
> > own BPF link FD.
> >
> > So, there cannot be bpf_link__attach_cgroup(), but there can be (at
> > least conceptually) bpf_map__attach_cgroup(), where map is struct_ops
> > map.
>
> I see...
> So basically when a struct ops map is created we have a fd and then
> we can attach it (theoretically multiple times) using BPF_LINK_CREATE.

Yes, exactly. "theoretically" part is true right now because of how
things are wired up internally, but this must be fixable

>
> >
> > Having said that, we do have bpf_map__attach_struct_ops() already
> > (it's using BPF_LINK_CREATE command under the hood), and so perhaps
> > the right way is to have bpf_map__attach_struct_ops_opts() API, which
> > will accept optional extra attachment parameters which will be passed
> > into bpf_attr.link_create.struct_ops section of UAPI. That thing can
> > have target FD, where FD is cgroup/task/whatever we need to specify
> > attachment target. Just like we do that for BPF program's
> > BPF_LINK_CREATE, really.
>
> Yes, this sounds good to me!
>
> Thanks you for the clarification.

