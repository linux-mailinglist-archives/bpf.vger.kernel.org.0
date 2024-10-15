Return-Path: <bpf+bounces-41941-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3913699DBFB
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 04:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8701C21A57
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 02:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D623515956C;
	Tue, 15 Oct 2024 02:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZgGmQw3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C317B8F5A
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 02:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728957625; cv=none; b=ORWkXK1v4Ng1W42f8SBEdk9Ql4oZklWLp5wVmIlkvJA6R1nhlUfjhq6o10KzhsBugPzedguqmIHjDoiDwb+AWFTnS38zc9GvqlLm/+i/V7b0BnQqnvDn52kqMIygEjBbho+nZJXgAD8SAdbcUoI1t498EjdszpJoVG5vPH5t0d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728957625; c=relaxed/simple;
	bh=HsjRy8f2psGU09oBTJhjrRCcbAP7WPjbM/S9psz0UBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtJA5bQjmasffZ9mTu6FL3eLtCdWvYvq37txjpK9ZKk9/wMZd3TcTSYzrx98XWOIr8rgSe+raPeQPb0O7YaV1daSJG8lYIBXWmSZu4bNlwqJI72GuJRQCIcOwkPigiNsdDCRLA3MolSQe36dOqerfdkp5ZAivQm2uWTj+2k+y30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZgGmQw3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4311ae6426aso31618235e9.2
        for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 19:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728957622; x=1729562422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8DB4RRMp54uvgptIY9NH81hTeep0a+5XznGmC0c07U=;
        b=fZgGmQw31tXhxi3mKiqxwdSMahuZzRZ7T8VHm59GMmy4v16B96jghBe6LEHvEPcXj1
         PlTBUh32lCmzygWIHU3YqMDpdI4vZaNU5pj6dwGvedPNlor/QlAJKxCh4JRZFJi5wxy6
         X0RBe+5LyoyAsDx7LjV4Yn6v4RyXl/6+UvSRIA2ArtWtMQ0BfJqioMBrZlLU6R87SjAx
         uZN4kyCtONOKa/W2Wvcww8eZBSjgKr/Yoff394wIIT+j5TEiFdUD503s19DT3bvCbgow
         peJqSuunc1ojemvtfSfm+CLPeYFNoWSDdIkBaZLQtt8hRmE5g1/v8khtMI210q6y+YUM
         yI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728957622; x=1729562422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8DB4RRMp54uvgptIY9NH81hTeep0a+5XznGmC0c07U=;
        b=ZJUP2t9UDBHD2I9Agy5e5wMS414H/Rjaqkl9U7mRqC167LICRTSDMUvMpI/1E0wsEW
         0PDXad23oUwsrs4Is0Ce8fL9eYI/dIiZeW1rJCO/+co1wIP2vDnE0No1fdXPzaa9z5i/
         GAN03buyvUWGwkiE24sPjZ9RvkISIsAsPfvDj8rUcpke0AWSNXo0uVu1vGKAVI+oC2jL
         Rp5+hB3LuGfCVc3s1BhFRUHbaqMNtoicezdkHXTygRf36q0MTY8tEA2w+m71guEglpxf
         SJjiv04LHbhxQ4OwEgvsjZ7j1KG4V4X833sTCfpUpx35yw5X2t24CVvC3gufxwCzwWyS
         Zupw==
X-Gm-Message-State: AOJu0YzD4nt72naysLHSzYO5gpCEuwJkoulFdmkd/82yh0J45y7JRgtk
	FmQ0ry8x4dfyPRjpApD/AIoykBiVXAnusqN/ZHGs+KycH8x5QWIgoam0WhU51Nvuvq9/p/I4mwT
	7Seyli4AFSAd59302HWPaDE9j9U4=
X-Google-Smtp-Source: AGHT+IE3yVgJtTj6SSHckOQb+EULpsddKfy+ZEvhqmtKsRW0gUO1DE0MFIvx+T/zfNFTAheKpoDGJVG1GQtOAC+eqOw=
X-Received: by 2002:a05:600c:3ba9:b0:426:593c:9361 with SMTP id
 5b1f17b1804b1-4311df47018mr110903015e9.26.1728957621844; Mon, 14 Oct 2024
 19:00:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010153835.26984-1-leon.hwang@linux.dev> <20241010153835.26984-2-leon.hwang@linux.dev>
 <CAADnVQL8ie=xxCXt7td=ZhQwyY_hKtig-y9kHwWYwBG9MdfRQA@mail.gmail.com>
 <c7e49c48-7644-40c3-a4a2-664cc16a702c@linux.dev> <CAADnVQLh9nBHvkS40gg+PynmfMmPvwuYrcdMh9j2DqoL=9dqqw@mail.gmail.com>
 <0c7a9153-a04c-40c9-be86-878cb415b1c0@linux.dev>
In-Reply-To: <0c7a9153-a04c-40c9-be86-878cb415b1c0@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 14 Oct 2024 19:00:10 -0700
Message-ID: <CAADnVQ+wkUOP4Qz2BsSietr-_O57ErEL4q0s_PPfjJ1twGd17Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Prevent tailcall infinite loop
 caused by freplace
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Eddy Z <eddyz87@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 6:17=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 2024/10/11 23:50, Alexei Starovoitov wrote:
> > On Thu, Oct 10, 2024 at 8:27=E2=80=AFPM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >>
> >>
> >> On 11/10/24 01:09, Alexei Starovoitov wrote:
> >>> On Thu, Oct 10, 2024 at 8:39=E2=80=AFAM Leon Hwang <leon.hwang@linux.=
dev> wrote:
> >>>>
> >>> Also Xu's suggestion makes sense to me.
> >>> "extension prog should not be tailcalled independently"
> >>>
> >>> So I would disable such case as a part of this patch as well.
> >>>
> >>
> >> I=E2=80=99m fine with adding this restriction.
> >>
> >> However, it will break a use case that works on the 5.15 kernel:
> >>
> >> libxdp XDP dispatcher --> subprog --> freplace A --tailcall-> freplace=
 B.
> >>
> >> With this limitation, the chain 'freplace A --tailcall-> freplace B'
> >> will no longer work.
> >>
> >> To comply with the new restriction, the use case would need to be
> >> updated to:
> >>
> >> libxdp XDP dispatcher --> subprog --> freplace A --tailcall-> XDP B.
> >
> > I don't believe libxdp is doing anything like this.
> > It makes no sense to load PROG_TYPE_EXT that is supposed to freplace
> > another subprog and _not_ proceed with the actual replacement.
> >
>
> Without the new restriction, it=E2=80=99s difficult to prevent such a use=
 case,
> even if it=E2=80=99s not aligned with the intended design of freplace.
>
> > tail_call-ing into EXT prog directly is likely very broken.
> > EXT prog doesn't have to have ctx.
> > Its arguments match the target global subprog which may not have ctx at=
 all.
> >
>
> Let me share a simple example of the use case in question:
>
> In the XDP program:
>
> __noinline int
> int subprog_xdp(struct xdp_md *xdp)
> {
>         return xdp ? XDP_PASS : XDP_ABORTED;
> }
>
> SEC("xdp")
> int entry_xdp(struct xdp_md *xdp)
> {
>         return subprog_xdp(xdp);
> }
>
> In the freplace entry:
>
> struct {
>         __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>         __uint(max_entries, 1);
>         __uint(key_size, sizeof(__u32));
>         __uint(value_size, sizeof(__u32));
> } jmp_table SEC(".maps");
>
> SEC("freplace")
> int entry_freplace(struct xdp_md *xdp)
> {
>         int ret =3D XDP_PASS;
>
>         bpf_tail_call_static(xdp, &jmp_table, 0);
>         __sink(ret);
>         return ret;
> }
>
> In the freplace tail callee:
>
> SEC("freplace")
> int entry_tailcallee(struct xdp_md *xdp)
> {
>         return XDP_PASS;
> }
>
> In this case, the attach target of entry_freplace is subprog_xdp, and
> the tail call target of entry_freplace is entry_tailcallee. The attach
> target of entry_tailcallee is entry_xdp, but it doesn't proceed with the
> actual replacement. As a result, the call chain becomes:
>
> entry_xdp -> subprog_xdp -> entry_freplace --tailcall-> entry_tailcallee.

exactly. above makes no practical application.
It's only a headache for the verifier and source of obscure bugs.

>
> > So it's not about disabling, it's fixing the bug.
>
> Indeed, let us proceed with implementing the change.

yep.

