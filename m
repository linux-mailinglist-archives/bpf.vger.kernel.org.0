Return-Path: <bpf+bounces-67121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE6DB3EC65
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 18:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C75188BF82
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 16:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4033306490;
	Mon,  1 Sep 2025 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbSxVDiY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A295932F763
	for <bpf@vger.kernel.org>; Mon,  1 Sep 2025 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756744785; cv=none; b=h3oTNPHp5Rm1JFUOTMmLd1Sy9XXuzZq3pvmUvxcuXuHUN0/qePnB6PNkAw3lQDW2iKW0lsN26t+rP7/Rw2C8+FtWOFC+bRyjJeLmAQ9RKQsFXeRMKYVa25CN/6722sboP0fx+OErKTBDpSzsq6K5LqAUfji//X7VM4lnVRQYvPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756744785; c=relaxed/simple;
	bh=asvPhKJbdEqgWzBNHBISli71n7hNG4y9yKL7vvGDUHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJYrKz3QMFyJZMysa/DWqa2aIepCz1WkRLAFfFrtbEI8cTv8/wuO70dgewO17JpeOvCsEQAZSwKkuz7rWdJh3BE4MhV5+SUzk8ab0PYqPUuVpD4l/LuecxyjCjGVQzEJWhr12MpkDIwaQai+29ZJkFR29Z+6JqHrNzxfMDLeN+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbSxVDiY; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3d4dcf3863dso1020428f8f.1
        for <bpf@vger.kernel.org>; Mon, 01 Sep 2025 09:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756744782; x=1757349582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joN8vswwxkQrUISLfX+tNjcs7vNjY/DEjQNf5DkniQ4=;
        b=XbSxVDiYZXMl6Ol5AwAaTOO9r455q7DT39wWBib2icJd9N0Vt6FuZnx1Ok0P9Wtedb
         ow4dhxve8FPAHME7fxd+XY34gn2ZY4rks3aOUJxF3FKiiNej/GH/9lE5gdufE5SjCr7J
         DEUBc4xnLmF3EfT576YwGvJbz7WjeOmZJtbr4SK0osqEzIHDuYjAZ183ISUa08dHDqya
         RSiNwFhdKQ2LlxYJZcG+0L6wpu+BzYiAJBq94N9tGyfaPQDTtYa7m2kUPa1mhX6KOkrH
         HnSbFfoqThVfYceEM0aX1h9OMMRLH69ex5pqFvv/sk57bMRbIo9AKTdTWEXgz1KAjpUT
         XDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756744782; x=1757349582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joN8vswwxkQrUISLfX+tNjcs7vNjY/DEjQNf5DkniQ4=;
        b=VfWEZ7uOa3Ip91O+CCx+K4a7xVja7VvLXa0EfZECFsnUWOMfFD4TojHMDnp8tF+aSY
         cKv2nxiWTgby1id0WPkUu806ITZJ2q9Rv4z5EjlimwiEDamy0jQoIIUOleSet/tHVKp7
         1Z3ZgnNLsghZGpc3x4Cu27Di+fJHld8W/VletvEufQr4BBn6pc1nmoiEdngbIhRJiCEd
         wqYt2MSHMm5J+Do9cOmshlwrJc3pdU5Z0IXJnCmeDHjbvmxNjI7eIM3FCeHC2Xi5X7Bb
         dJvMt7ow648gb5wLwDoUCeGyAij097KNdZ64eA5XEoTOUwnJvly3vgstygK4UIHJ+ljZ
         FL1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkI7aqaohM6FuoPL1ml3r/uXBtR73ZbTF/CC7Bcy/f1QBHD0+3p7tdK8MMIG+6vmcUJ3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYq9Gd0cAXX0ZqBNCFk3tuwQ5rkxfyZMYpPXw2T9lyjpDcsO+j
	V4mTw96+C48ZiStQSK/8JMvUH6nHqfEKmdLC8JJYsq7MnvF1VXh3KHBqTHTxyGzx9b9mL2CCtlu
	hVq3ru8UQs9J+n5Scmxj1jK9JkGWQbww=
X-Gm-Gg: ASbGnct5RzIyjwQqGr3MpNzfTisgvcptBT8/x5Wlbrkoi5yt7fRHxotHEkm62t0uNCd
	Hlwj/OCAAmb+exUaFb5wWe/hpmq12R1rM23pSEeLZv7vRnMQkMIh4mHmdNSOKc7UzwnSrTjTeNG
	zA+5Ophw81s8MVCP3JviMN2UGy1458qPSjiH5SoJ/+aGITCrBlLFgAuivC36XMXns7n2IeUKDHb
	YFxy9M5kHR7kxqZCUVgWjto4kHDqVx25NFX
X-Google-Smtp-Source: AGHT+IHuZ1AVTO6KBbf04oLkzMwUNmqLWu1gvXBtPWbhwvD9WMElK3pZ99KMkek8F5n1WTpLHP5URmNbe12YCrQGAbI=
X-Received: by 2002:a5d:5f8b:0:b0:3ce:a06e:f25f with SMTP id
 ffacd0b85a97d-3d1df349474mr5956514f8f.49.1756744781679; Mon, 01 Sep 2025
 09:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827153728.28115-1-puranjay@kernel.org> <20250827153728.28115-3-puranjay@kernel.org>
 <99bb1aa8-885b-4819-beb3-723a73960f67@huaweicloud.com> <CAADnVQKp-FXhVtxCSE8rako8BBnAU4Qt-dxviqrJUr-Fpfm+4w@mail.gmail.com>
 <mb61p4itmjnze.fsf@kernel.org>
In-Reply-To: <mb61p4itmjnze.fsf@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 1 Sep 2025 09:39:30 -0700
X-Gm-Features: Ac12FXylAmxdwx__yANW_yeK6qqk9QQc7yVNBBencYgNBymFlWIflR19nXzJmUk
Message-ID: <CAADnVQKPLwGF25YOzA=a4Vr==0UZFycv6GkLbwszkFrBiHGCcw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] bpf: Report arena faults to BPF stderr
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Xu Kuohai <xukuohai@huaweicloud.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 6:34=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > On Fri, Aug 29, 2025 at 3:30=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud=
.com> wrote:
> >>
> >> > +
> >> > +void bpf_prog_report_arena_violation(bool write, unsigned long addr=
)
> >> > +{
> >> > +     struct bpf_stream_stage ss;
> >> > +     struct bpf_prog *prog;
> >> > +     u64 user_vm_start;
> >> > +
> >> > +     prog =3D bpf_prog_find_from_stack();
> >>
> >> bpf_prog_find_from_stack depends on arch_bpf_stack_walk, which isn't a=
vailable
> >> on all archs. How about switching to bpf_prog_ksym_find with the fault=
 pc?
> >
> > Out of archs that support bpf arena only riscv doesn't
> > support arch_bpf_stack_walk(), which is probably fixable.
> > But I agree that direct bpf_prog_ksym_find() is cleaner here.
> > We need to make sure it works for subprogs, since streams[2] are
> > valid only for main prog.
> > I think we can add:
> > struct bpf_prog_aux {
> >   ...
> >   struct bpf_prog_aux *main_prog;
> > };
> > init it during jit_subprogs() and use it for stream access.
> > We can also remove skipping of subprogs in find_from_stack_cb() then.
> >
> > Kumar, wdyt?
>
> So, IIUC, after adding struct bpf_prog_aux *main_prog_aux in struct
> bpf_prog_aux,
>
> We can do in bpf_prog_alloc_no_stats():
>    fp->aux->main_prog_aux =3D aux;
>
> and in jit_subprogs():
>     func[i]->aux->main_prog_aux =3D prog->aux;
>
> and then all users of bpf_stream_get() can do
>     bpf_stream_get(stream_id, prog->aux->main_prog_aux);
>
> with above we can allow find_from_stack_cb() to return subprogs.
> and bpf_prog_ksym_find() can be used in
> bpf_prog_report_arena_violation() without any other changes.

Yes. That's exactly the proposal.

