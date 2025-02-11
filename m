Return-Path: <bpf+bounces-51105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FA7A30347
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 07:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2353A52E0
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 06:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174A81E5B87;
	Tue, 11 Feb 2025 06:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvmEDf/B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B591E571B
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 06:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739254360; cv=none; b=YJZWlfYT+2O6LEhaPYMK34wwScsCmMB4sKKXpQnNOwufhxh0y/mifKlgyoIqcC/LtiA7X83l7DAVY7crGytRhrYqJe5JHFD15Ld2B/KVrlSUHQ7m81xgTsF+SIahGRJjW9bHhwi9UBOaKYnBRkcNx+oEAZqCFeedRpsCiSsrrm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739254360; c=relaxed/simple;
	bh=meGEcgGi3WmhHB5/WM5WYcz4O47o8rYln8gxDswJLNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHI5GVzb2iwko9NgSVpC7BuRp87N8FbtoqUzLQRBuO0slhLPLBXYHvyRgarH3d248n1q+ouVo0Eqc1fDo7FGKQlR8lRA4fKBnq9YNBiY8ifQwodnmlR7MZ7ROitWZw80NbxtSFqPDdw50ZxGT3Z3xrYi6d5JlbXQxSDWQEjyRYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvmEDf/B; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4719141e711so15024521cf.0
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 22:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739254358; x=1739859158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ForXBKAplWQ6UEsQWTJaYZdTrnGy5CJtzi6tAObTHbs=;
        b=QvmEDf/B23suLidLO00vzeDGB88tgccLzC+liOAs7inIJ6rl2EwS20NLzTFB2+0bIP
         QU01LXpsCJT80y7ZUKA0coe+bs/WqJyoe6VU2k5EbyIVuNlxtalHOF535iWaDp+HOKnR
         QS7EhPjNk/zYQdiKSJhy/p2cQeeN2AuYpuTTkxQFI3wKQKbD8a4FrgahaKH+mnwJn+cX
         aJfCt8wRgVX2q2vn/47XwhvLdbCFxsNiXdABhF5FVrbw4/AH5LQuPmg4FY1xkEN7bTQ9
         H+W/iW2X4DjdQTGzMH4S/sXlTPur6Pvs/PCqDzUFfQlxwYVYXac02/RuBc/tj5/ccLHx
         kvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739254358; x=1739859158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ForXBKAplWQ6UEsQWTJaYZdTrnGy5CJtzi6tAObTHbs=;
        b=EVTZXobZmkCoaMkJCxfw4fyTecbxjlYkUEBBPYFU1yM5gIMIB8+ZEeKrrFKwxmnfve
         RyYhcoqQlxs1r1kzZ11GHlH2VRbS11d3HQHq6rKwZP6oYRj9poto6JN9GZZ1x6PSqrWY
         ktHS5jACSXO2Xdura9LTNtpprXFja5JV3cqxl8w0pIXYcwfsSmXuwN6k/FoD3cKeGAke
         Egemr1m0kjAHfae8qmUcdiEtmz9IXbzt8h97wbAFQWcHupD/J0Z6o8b5RjFrKiGHK16T
         AlMJrbuko3NOWvPZNF2QATGrqexS3Cv5+lTDoMCSVIqNP5SiD0bpJdjIgHnDOUbWMop9
         mHHA==
X-Forwarded-Encrypted: i=1; AJvYcCWLnBh1wzgD1bo0FJ+YXBMcpgvntmwleuyrQSQx5v5Z1xMyHX2+icHfb19WZsWRHpt08PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrXwklskm0qYi8eNAbTcGz0GO86RUE4v3kXhvyn7F5RTaU6CL4
	cYbRCNFmTFtBs/QscGJxBiEre2PjUKD6LoL0ljrP09sgmRb/VKlpWY1cCRlkxOb0rSN0LN+j19y
	VVm2ENvHkGoQNchGv7cckZfXuO+Dd/CUk3lelVg==
X-Gm-Gg: ASbGnct3HoEw8s2Dbj6OmMcODa62FnFmmo/57nOW0h6LitP+usP+DJI0IL1PiAXdofU
	jzdyG9mrdm9/XBM30/WGoL5Ng4eTu8lUGc0wVFDkzV1ISxmfv/Zp92Fks1e7i/zgo2qiBd/CFPJ
	s=
X-Google-Smtp-Source: AGHT+IFqkXg8VHfQyXov1eGldMAuHbwzmCeQzbJPiDYdDitx83yELyzRRii6ULSo1+b2haAcmE9sduHqHcTtRQbHkTw=
X-Received: by 2002:a05:6214:411c:b0:6e4:4484:f357 with SMTP id
 6a1803df08f44-6e4456ce5e2mr182475066d6.30.1739254357878; Mon, 10 Feb 2025
 22:12:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211023359.1570-1-laoar.shao@gmail.com> <20250211023359.1570-2-laoar.shao@gmail.com>
 <50d8dd8af3822f63f1a13230e6fa77998f0b713d.camel@gmail.com>
In-Reply-To: <50d8dd8af3822f63f1a13230e6fa77998f0b713d.camel@gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 11 Feb 2025 14:12:01 +0800
X-Gm-Features: AWEUYZmWi0ZfxD1CK2bh2jUkgB3DhrRFalksGwZqb6BnBVsdTx7NkYKB4vgD5ys
Message-ID: <CALOAHbAvo1OWP2We=GhQmM-xWYXE0ynwGPXs+e6V_GfSbk0qzg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] objtool: Move noreturns.h to a common location
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, jpoimboe@kernel.org, 
	peterz@infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 12:12=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Tue, 2025-02-11 at 10:33 +0800, Yafang Shao wrote:
>
> [...]
>
> > diff --git a/tools/include/linux/noreturns.h b/tools/include/linux/nore=
turns.h
> > new file mode 100644
> > index 000000000000..b2174894f9f7
> > --- /dev/null
> > +++ b/tools/include/linux/noreturns.h
> > @@ -0,0 +1,52 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * This is a (sorted!) list of all known __noreturn functions in the k=
ernel.
> > + * It's needed for objtool to properly reverse-engineer the control fl=
ow graph.
> > + *
> > + * Yes, this is unfortunate.  A better solution is in the works.
> > + */
>
> I'm probably out of context for this discussion, sorry if I'm raising
> points already discussed.

Please refer to the discussion at
https://lore.kernel.org/bpf/CAADnVQKXgPTQsjUDB3tjZ46aPWvoEcxBCnDXro8WPtNhkG=
NFyg@mail.gmail.com/
 for more details.

>
> The DW_AT_noreturn attribute is defined for DWARF. A simple script
> like [1] could be used to find all functions with this attribute known
> to DWARF. Using this script I see several functions present in my
> kernel but not present in the NORETURN list from this patch:
> - abort
> - devtmpfs_work_loop
> - play_dead
> - rcu_gp_kthread
> - rcu_tasks_kthread
>
> All these are marked as FUNC symbols when doing 'readelf --symbols vmlinu=
x'.
>
> 'pahole' could be modified to look for DW_AT_noreturn attributes and
> add this information in BTF. E.g. by adding special btf_decl_tag to
> corresponding FUNC definitions. This won't work if kernel is compiled
> w/o BTF, of-course.
>
> [1] https://gist.github.com/eddyz87/d8513a731dfe7e2be52b346aef1de353

Thank you for your example=E2=80=94it=E2=80=99s been really helpful. Follow=
ing
Alexei's suggestion, we=E2=80=99ll address this in the next step. We need t=
o
apply the fix to the current kernel and backport it, so for now, the
simplest approach is to implement the current solution.

--
Regards
Yafang

