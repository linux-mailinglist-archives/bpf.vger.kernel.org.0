Return-Path: <bpf+bounces-71964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B19DC0306A
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 20:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB5E1A6761B
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 18:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC49283FEE;
	Thu, 23 Oct 2025 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/LqlZOg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932CB238C29
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244649; cv=none; b=QLjfv8oERj1KtHQ7n/LWKUDKNoUqRazJ5wAoY9mUxHTmCAPFps10f7gJxlv80ZQi0JDq1UoGZRId+TR9UxT2THLc8XJCEoxWWDVoHuYiE5FEb10lqzi9bkFAKUb1nRPbtVbzdWXc7s9BgMydzdYSNLP8Mm8twLDp4NvwwQ3Wb4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244649; c=relaxed/simple;
	bh=KRqUaIay42zUMMR+WlaGSAv3YkSsKZdFS0QWLd9/5XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tyAHBPfTtDYZI3rtviAHGeLMT5YUPbG7BDDN4kUnTJngyKzoHWknUiXeUi+VoSgqNcceeBWvLptkmo1rb7FVPLU417t3Z/Ga/ePIdGPHdoQ+Xk+3ds4cn0n4B4fxaJ2KbXNKe8+v2LTT5zD+Xp/ZBUB65vVG6Agvl9Git6RqwzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/LqlZOg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so775000f8f.1
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 11:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244646; x=1761849446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRqUaIay42zUMMR+WlaGSAv3YkSsKZdFS0QWLd9/5XI=;
        b=A/LqlZOgWhu+5tlrat+DsKQTP3ghnDp2jz2ng2mErFCLf006sjZU18Of1HEoaBuJOm
         HumY1iESQ6oEqoFkdbcfxp7Qz4+W0JjB2u16aqv9z0pXpfmtTrmSQyHUc/LaQ3oXZJpS
         NeQKO+djHhTbJ4V9Vl8z2x40hSDlKApi4o+YwaA2cZPjlATGTQuOqCQFwce2QEzp7qnE
         UCzHz9BsYBO15EgvSjAEGrIB0u+69e8wLNAXKaOWRsFuZAjtQbyTfbp2k06qfAPDZ5ta
         c01tUZDtZCku+h/gmJ9TnLE4X+Mz6OhV2oI9t5Q5JcvCz/HS+BWJwMFX7aORfiEuba/c
         mwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244646; x=1761849446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRqUaIay42zUMMR+WlaGSAv3YkSsKZdFS0QWLd9/5XI=;
        b=mq1hj2Oo+kmBCs8ZZmeFrvX+wb30KzmXmhEkMCx3a+WJVriUS+TYhfT+Ye2EN5HjN3
         FNwRxLceuZSdJmQAM/Hhs3B15gPwNFxyILPlH5NX4Y+iaeZCCbMptM5vMlOen7KbzB5o
         TQkK72gVNSjJd7Wr2UY7NLclXQ1yq0VH+lGl2zF9PhLuUfxaH0XDtV9Lag6xGWjiSBft
         RKycSu+EmN2ahyFRRuqKnkHLqFEe6/yilDNTpYsIHchbPOrOZRbUqwPxtjjUN43HL5ws
         S3K4k9wtT2EfjTRyGywXp5ZPxGJzuC5WXdQwz1pZ6+zjg8ZdWIanizMzpGtrx7Js4+04
         h73w==
X-Forwarded-Encrypted: i=1; AJvYcCVMQrfwVe4n+tI9w3RmFFBXdY8ymAKB4VDbT5fgc6eiT+knD2rEYOt7rW8T1p0y0g2PBTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTL/EpZvLC2zV6EAKR5YDJjy+ijxE/MUUbSkzBW8ngzJxL+bht
	EsgwxV88WRlilZfYnmw+2z9RHY0Y7kMQnWzyX2mP9Xi4DYXFkSJDLpv4V3EfpDIg3CcARuasZlq
	jY+S/lLgl4dEbHOWOnBQLLN07BYmgV2c=
X-Gm-Gg: ASbGncueYSyfs5O8YkJtFE8Jk4+1CVp5k2BkqPWCLDuGYAdU//xL/OKPpubhzGaTjkn
	2kYNV6wX0FwE2p2Zr82AFbxCcAXuY6m7PvpdtN22d6GZ3eFVH/UdjYP/lqhnG5VRaoIDip88FQS
	RYn6fAtX1IQQzK6kSD8XYaZSN8H8JpWmSLaujm26rzEtB+7aliJvdC535xqMpi5ZMx+NXfgx4Fh
	tWFxsW4jbbRBbYtzMXxTEoy3I8Eytp2vCbe6XW2GqWQ6otdhO8BV75tfL/GbpaIWWz1alTZhZcn
X-Google-Smtp-Source: AGHT+IH4qsxJ7mUIL9zboxFt4pG9B3IJms50YZNQUEES4nrTzidPaOReyuWCPuy05NT2kA3v8XjMqzGJKcdLVVEvPMM=
X-Received: by 2002:a05:6000:24c9:b0:3ee:15b4:8470 with SMTP id
 ffacd0b85a97d-42704e07b7amr18102377f8f.45.1761244645680; Thu, 23 Oct 2025
 11:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
 <20251020093941.548058-3-dolinux.peng@gmail.com> <174642a334760af39a5e7bacdd8b977b392a82c7.camel@gmail.com>
 <CAErzpmusSgOaROhEO25fKenvxQJU1oSPKKzUA4h67ptdQxWM7A@mail.gmail.com>
 <7651ac9cc74e135f04ecfee8660bea0a0d3883ab.camel@gmail.com>
 <CAErzpmtWLLYuFk3npTiOgGOKcEcH1QUGGEHLvPncVT+z261C1A@mail.gmail.com>
 <CAADnVQKU0MnQHxxvnp9WCu_UO4fEtd_D6ckNmOd7pLg90ecF4A@mail.gmail.com> <CAEf4Bzajdv3Rd1xAxm_UZWBxPc8M0=VuUkfjJvOFSObOs19GbQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzajdv3Rd1xAxm_UZWBxPc8M0=VuUkfjJvOFSObOs19GbQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 23 Oct 2025 11:37:11 -0700
X-Gm-Features: AWmQ_bmQyKMJs6G-0_Lgj-Xl1X1ye0IBGPVkDkUPwvrDh9KvDzOfdTPLybE8VS4
Message-ID: <CAADnVQJG_tK18oxmjW37cbrxF2zPKPk_dvqXUTnOjUue7J0tLQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/5] btf: sort BTF types by kind and name to enable
 binary search
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 9:28=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
>
> Speaking of flags, though. I think adding BTF_F_SORTED flag to
> btf_header->flags seems useful, as that would allow libbpf (and user
> space apps working with BTF in general) to use more optimal
> find_by_name implementation. The only gotcha is that old kernels
> enforce this btf_header->flags to be zero, so pahole would need to
> know not to emit this when building BTF for old kernels (or, rather,
> we'll just teach pahole_flags in kernel build scripts to add this
> going forward). This is not very important for kernel, because kernel
> has to validate all this anyways, but would allow saving time for user
> space.

Thinking more about it... I don't think it's worth it.
It's an operational headache. I'd rather have newer pahole sort it
without on/off flags and detection, so that people can upgrade
pahole and build older kernels.
Also BTF_F_SORTED doesn't spell out the way it's sorted.
Things may change and we will need a new flag and so on.
I think it's easier to check in the kernel and libbpf whether
BTF is sorted the way they want it.
The check is simple, fast and done once. Then both (kernel and libbpf) can
set an internal flag and use different functions to search
within a given BTF.

