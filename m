Return-Path: <bpf+bounces-28388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841218B8F28
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 19:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4CC2835CC
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 17:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C375130A64;
	Wed,  1 May 2024 17:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGmciCUd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27A11AAC4
	for <bpf@vger.kernel.org>; Wed,  1 May 2024 17:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714585431; cv=none; b=iOItUj2nPaa53iIBjqCAeY9r+6uw0MJpddZl5dReMLXttNCXOp9TmE4zvV+WRrTLPMjvBk31eLiWU3VKcvrYUrwEvHIpmeHWEPedwd2Tjh0WQCJv2BJxaJZ+kkXAF6YFDxlCuLJdjosJSjKTI3MabmMaWn4GJZfrSHPdw+3j6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714585431; c=relaxed/simple;
	bh=OE30dA+ktIYydw5+HOg5YlCuB/rlb5WqQasHaKZVE8w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aqFxESVDSfJLOXxrKBQNwzS3m5CZt2KarF8EpNvlGpU5/U7MMaPAdTNKoDrY4wfzXzxZakIaxoS+qJF2DMNRdYAG6f4TNqi4/uzg5JvyDkq/e4XOQhtGbp01Qw6N9za+Hle4Scnk2ZGb8tyrRtaB99bEKLNUhrqCiYSUk7BdEHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGmciCUd; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso6009822b3a.3
        for <bpf@vger.kernel.org>; Wed, 01 May 2024 10:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714585429; x=1715190229; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=64jKWNwHcz7eq8428f/JAum6vyigxQd+Dku9cTKM+mE=;
        b=jGmciCUdJLQEt2M6Zrhr7Pwgr23PPq5LllrJ8N1vsixYwh2uLDHX1jNT1LL8NrZ2m9
         0v3RgeJHrnsgAaYQOVeLbBZGs7t91onNIxpBJHbmTgUkJ9gMUPNk6+ECSoI2nuZCmjso
         cfb5BSaSjpBY1bvzJ2HDzfncNttGWlXxowq3XzUuWIlSVn8dFzJAoK8PdSdstk3lgPVI
         VfhdRlkf0uKOwx5C7cQs6sRzQLQoNBEEIA6O0Qph+w8d2tVdh2wMm+8zkYKNi1v8Jr9M
         oHeugTVrjriNAa49e+ZlJ+AA61Tphxxguw8aUTrngVeynPb+aWLJcsVPXAPtvipQR/fc
         xmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714585429; x=1715190229;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=64jKWNwHcz7eq8428f/JAum6vyigxQd+Dku9cTKM+mE=;
        b=rH92KMlZ0jbSPf9uEJ6pN91ZjcHdCZTnJ1Ioeem+ePvbxc1cmiUdR4e+4CuUjIWM5W
         wkd3tqJLsLy+fZPzZeiJQP3TpHoQ2BRga9hlTPvWdd7qewQ4LsDmvquWWa+EGLmsd1tx
         qdajdUwmrBAe0f+24NFUXJIZBCBc/58Hitl6avo/GREaRop3areyRVyqtTmNx5VdBhif
         2+EXJBGquYnd+P/VLZLBZTs+sL65mACHf3FjHJjbUOneU52wDBiRbwXGaqf4BSU7qJNc
         tvsiVsuvXskq3en50LB8Soti66TltKUtIuNn8C9azw0gS9b6NvdVQU3DYr2IyTxHE0E0
         R5Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUXW+niUtOQUZ54Cnh29R7s/Ql9PtfrpM9YKXSZ7l7Fh5iepnSVJ4UG318Ca0vj3gHObTXtYKUPGH4J6sSxHJM+kdqR
X-Gm-Message-State: AOJu0YyoWXgeUqSO3SapxyZH7qNB81gAvsjilT78RLhywnB2UpbijWVz
	L7na7v7KD4D9ub4Ia7XZKFV2rmKmrV4Q1DHzMYQSrxQbdYuFTCTP
X-Google-Smtp-Source: AGHT+IGpx1X73QrjN7PFjfIdf4mh2Sk91PBcILnvNFKqYqzPaUaJX8G8UTCbIQ0bfdDBDDgPLdR1gQ==
X-Received: by 2002:a05:6a21:6da1:b0:1a7:63ce:84ce with SMTP id wl33-20020a056a216da100b001a763ce84cemr4303298pzb.49.1714585428874;
        Wed, 01 May 2024 10:43:48 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160:7cc5:20b9:bcdc:5d52? ([2604:3d08:6979:1160:7cc5:20b9:bcdc:5d52])
        by smtp.gmail.com with ESMTPSA id pt7-20020a17090b3d0700b002b284a01223sm1636515pjb.5.2024.05.01.10.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 10:43:48 -0700 (PDT)
Message-ID: <ccd4170425217114afa41e0b3dab41fd5f47492b.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 02/13] libbpf: add btf__distill_base()
 creating split BTF with distilled base BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org
Cc: jolsa@kernel.org, acme@redhat.com, quentin@isovalent.com,
 mykolal@fb.com,  daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org,  yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org,  sdf@google.com, haoluo@google.com, houtao1@huawei.com,
 bpf@vger.kernel.org,  masahiroy@kernel.org, mcgrof@kernel.org,
 nathan@kernel.org
Date: Wed, 01 May 2024 10:43:47 -0700
In-Reply-To: <97e1275b-c876-4ea6-997f-45ea43fd9207@oracle.com>
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
	 <20240424154806.3417662-3-alan.maguire@oracle.com>
	 <c3564a5e0b159d559ecd72ad0849aabfb54a672c.camel@gmail.com>
	 <97e1275b-c876-4ea6-997f-45ea43fd9207@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-01 at 18:29 +0100, Alan Maguire wrote:

[...]

> > > +/* Check if a member of a split BTF struct/union refers to a base BT=
F
> > > + * struct/union.  Members can be const/restrict/volatile/typedef
> > > + * reference types, but if a pointer is encountered, type is no long=
er
> > > + * considered embedded.
> > > + */
> > > +static int btf_find_embedded_composite_type_ids(__u32 *id, void *ctx=
)
> > > +{
> > > +	struct btf_distill *dist =3D ctx;
> > > +	const struct btf_type *t;
> > > +	__u32 next_id =3D *id;
> > > +
> > > +	do {
> > > +		if (next_id =3D=3D 0)
> > > +			return 0;
> > > +		t =3D btf_type_by_id(dist->pipe.src, next_id);
> > > +		switch (btf_kind(t)) {
> > > +		case BTF_KIND_CONST:
> > > +		case BTF_KIND_RESTRICT:
> > > +		case BTF_KIND_VOLATILE:
> > > +		case BTF_KIND_TYPEDEF:
> >=20
> > I think BTF_KIND_TYPE_TAG is missing.
> >=20
>=20
> It's implicit in the default clause; I can't see a case for having a
> split BTF type tag base BTF types, but I might be missing something
> there. I can make all the unexpected types explicit if that would be
> clearer?

I mean, this skips a series of modifiers, e.g.:

struct buz {
  // next_id will get to 'struct bar' eventually
  const volatile struct bar foo;
}

Now, it is legal to have this chain like below:

struct buz {
  const volatile __type_tag("quux") struct bar foo;
}

In which case the traversal does not have to stop.
Am I confused?

(Note: at the moment type tags are only applied to pointers but that
 would change in the future, I have a stalled LLVM change for this).

[...]

