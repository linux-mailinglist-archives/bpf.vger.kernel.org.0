Return-Path: <bpf+bounces-33678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 962AE9249D6
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 23:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C885A1C22A70
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 21:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF17205E00;
	Tue,  2 Jul 2024 21:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AL2q7t67"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A349201266
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 21:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719955161; cv=none; b=O6/5uhHbeXc91V9K4CkXoYGXCRB/hGASvUSErKIQEqxMf/aC+SIa6Rm7oaPRf1IuwVZAiQhE2yhE9wOmXFgS6ADOMU5Ndnd0XAaGIc6J8JKVSm7SuvG+yXYZxQgHMNabR9nbm0nunpDxeW+d/nvXR0zIxk6wt7V4cF3y70bHRWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719955161; c=relaxed/simple;
	bh=ixuO5zU7BLs/x+OFbA18CJXC1uYCVL0iNHm+XiWyt9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dx+a1uesbDPFQQ47mRz58MrsTMIn6UlIc8n/9QjPqyIFVoVNm3Yg2A8ZpKYwNS0Gmy+3bSEmai/zLS4Io+WGBGIGuJ8gLFBr+gbt5jlqV8S5rAnKyMt7abZccb7pmy7Vy2V0xbi3zse+j6DjxOLXMburFNadbPknxKRCJ/6sSm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AL2q7t67; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7180e5f735bso2770342a12.0
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 14:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719955159; x=1720559959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bk4U4wK3PRYDtAS3AbLMXIL6xXmyuolG2+OfZw6iESg=;
        b=AL2q7t67dr6xQulQMTPtnArQHQbOAlEI7t2XhCnCW1Qe+BRSpxi/PtOC8eRj2WGvjW
         uvv/2GtVVnVhrSBFwo6l7bzaD3k1QdUjLesLQTWn/laXdurOsedArQ/NOnQYI3n20nGH
         h3rPIO0x9GscFHzEf0cFfyU75uTFgTFWCNL2CMt8OU6onvqcFzsEtdO7/3y9cPsMXGXh
         Nc+Vp1QQ1kgjX0QkfRL5iZoDK7SujvPMBZeBTOoSTIGdHJfXhE636h0jtZt1H09tJEyj
         rz9BurddOZn7Ovv/kslL2PFppxGOxKdreXMM4wDlK6m3GLc2BK3RgYMfVeUPKReTkuXK
         nN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719955159; x=1720559959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bk4U4wK3PRYDtAS3AbLMXIL6xXmyuolG2+OfZw6iESg=;
        b=SCsbD5YnaJoL3KShix85EqFkkA74KODnWlAmGBPlmOP+i52E666W27fCkXWGtP1uzI
         yMBkTLwRHz7kmnIPE+a712EkMw/482+qL2kZ3k7dK1PQiAUuiE2B80l6jZPVodHqI9U9
         AdEpotSTax5Q3AimDqaHsM3EM2BeIZFbMpZDLo34a6HsTlEhaseSxMue8TuQyCRmEFLQ
         BCAGIszY0/nrGK58CbvNe2Qv/bYeASoExYb8iaH88/nD1wKJjgcpGkGPJXOoGrGR9CaN
         Z1VYciZAN+BbcRFoPy2agVEvBXxLqNsajYpMckyOLdWr7iGByNIoCUFqZ0iz+Ea2gMQS
         uT0w==
X-Gm-Message-State: AOJu0Yy2f0CJZ2R6Ztmy6icymumaiRwVs0grbjPGRXdlJwZNkpPU2oVS
	zo1QLlDpYOVYUy146sBVYSsYalVgIsa+6a5OXS5qdMe7xTUPN+GqjY+lsWT5jWO8GecYZKRvxgm
	tczdOvoTEJBwS9B/7RQV+c9Gf/iE=
X-Google-Smtp-Source: AGHT+IESOhwbV6Bf3Sg9h6oLIlLS+Eout+tuDc5hvaQxqal54HHAiVOv09YGtR0/HP0BzToQGyF9JbepuFluu0uNRAM=
X-Received: by 2002:a05:6a20:9143:b0:1bd:1d5f:35be with SMTP id
 adf61e73a8af0-1bef6137cb9mr16724276637.11.1719955159353; Tue, 02 Jul 2024
 14:19:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629094733.3863850-1-eddyz87@gmail.com> <20240629094733.3863850-8-eddyz87@gmail.com>
 <CAEf4Bzb1Bt+N7rKDrcgMSyo9=u+4qkD5mrWJtjwYFMg-ZsWrNA@mail.gmail.com> <2cc3dd09ecaa7691c3606120c81d58a40251516a.camel@gmail.com>
In-Reply-To: <2cc3dd09ecaa7691c3606120c81d58a40251516a.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 14:19:07 -0700
Message-ID: <CAEf4Bzbgu=VryCgnxsjVpHt7r53hj1EEyQmTo6MmQ2ib7Cz1nw@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 7/8] selftests/bpf: allow checking xlated
 programs in verifier_* tests
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 2:07=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2024-07-01 at 17:42 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > +#define __xlated_unpriv(msg)   \
> > > +       __attribute__((btf_decl_tag("comment:test_expect_xlated_unpri=
v=3D" msg)))
> >
> > nit: keep on a single line? you are ruining the beauty :)
>
> checkpatch.pl won't be happy but makes sense.

checkpath.pl will cope just fine, let's keep the beauty of regularity intac=
t

