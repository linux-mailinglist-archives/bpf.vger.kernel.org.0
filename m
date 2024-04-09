Return-Path: <bpf+bounces-26295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AD289DD8A
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 17:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7238128CE8D
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 15:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48BC8287F;
	Tue,  9 Apr 2024 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn0ixwuM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90041304BE;
	Tue,  9 Apr 2024 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712674875; cv=none; b=BiGQ8EUlTZDNrYyVZ/iXLcjiupBE3gUXHlDvdgnKIE/xWFSexOK6e+w5EMrcqufWeqZ1FLLqPNm6xLXmeedk3KlLB6JSw0BSgfPy4tL1/wGb40FlB3OLbBEFC7k7VDFQgZfinPNgKaQxTGRMG++yLePp4TRpkmn/XX4OuXGHrpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712674875; c=relaxed/simple;
	bh=vvh2iqJh/NSgdAgq4/uQT9xxSsXZC31Rr8+l3FGnk+k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NJjBfwHchgLhiG3pbGOZK+Bw4OHtB2H5Q4SpluFrC/3jaq7Zs6RTX+XpNKnk764pXuCWFBoU/5e7wRjgO00qLqrsHlaG+XU3H1P4zXUyjtajSEei51YcIMfDnH+EOo8YhM2Nd4SgxCKx8Ba7tlmUMPksmaRiYsKXb5/jgkRHAVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hn0ixwuM; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6181237230dso21961767b3.2;
        Tue, 09 Apr 2024 08:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712674873; x=1713279673; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tmmdlsZje12lMa0yGPgNyI6lY9y+jIiMGHCHxRVjqxU=;
        b=hn0ixwuMdm1dMEfva6bmLu+JXnRBqYwZYb96gcyiVAphxRu+LFblnfBebNuanV/snJ
         5iD/Hz8//bfq5gYHmTfE4FYDOTqh7cRLpidUgfOJ0JzvVQAOm19YSNerrRH8L52kn+Hs
         BjXcQUdlmlECQmt/jxojKeEjxuZGVJPhIGRtLK+0R/HWnNCdksxcge5bdZuGQTJDfA8T
         +HTH1LfOGggmN3e2XR1FPo+ghGuiH+4EKTmGiX+8u6L4zpzXnLA+/HMz/iRU91jlz2+f
         KxHG5IiS/CzBmdgxkhadjELMJYmyJd8S57LE56jpHe9mLyiTWB0HMUOfsND7hGud9eJ4
         VHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712674873; x=1713279673;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tmmdlsZje12lMa0yGPgNyI6lY9y+jIiMGHCHxRVjqxU=;
        b=o6guAiVJsDrX1g6bZ8qaeGHMEoEa/tb/FTi2RpSv2SO4WYKEy3CEuWjP7BNFHBhmTc
         9vcAdWyxUNKWX4D+D7rdpVTvU9r8hZF6tacyu3+PergczwHWOUavSvmviISNN2CGl6nw
         uj+t+FxLozvv+x0uVToq94OLP1FSi7wINOYYRVJdCvFbQNAa5owPn8D1SgYiVcI67aQ9
         Vna8w+ZVh+ftgz83yBgGlhBjsjJyKqXLQM/Si8rpU9Snt9H6DNNm/Pev3t9Vq6Nl4VQh
         LW0SyFyZ2cGfMgefPkdt8uOKa1LEguY1WlN/fHlnBJz3Z4dPMhbBPOOl7QF6QE7yt+Eo
         JhoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ9z+MALJwGKvUi0R/TCFGBKkx+5EPMkwJWTdlfIcTGuDXe5grTgiTQvjG4FCXsJcMfAlobE37OpzKHIUmst0yS1TZRsBQfkQJZOHVyvRJmyVBRoqA9kECjfK3Mw==
X-Gm-Message-State: AOJu0Yw8KiMDUbgQr2KFTUE4pvuw9DcbEBIYQ7/2ophz7npgl538+fIS
	NAlh4Y6cOc6h/VOEfIBHUWx5O2aFnxAthz0CQvbMmwmakhsY1QGSYA2lQqaSXv8=
X-Google-Smtp-Source: AGHT+IFkZkrfoiPDCosGWxWQTNjgHMBd/OjOW3H9BGCy6XtCZg5HSmeE+l+wCG+KU+YK9kwGUCmmrA==
X-Received: by 2002:a5b:392:0:b0:dc6:be64:cfd1 with SMTP id k18-20020a5b0392000000b00dc6be64cfd1mr10865577ybp.36.1712674872628;
        Tue, 09 Apr 2024 08:01:12 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id fo6-20020a0569022d0600b00dcdb3dffa3dsm1757503ybb.39.2024.04.09.08.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 08:01:12 -0700 (PDT)
Message-ID: <7a08fb6a8c37e58a56121c8536b9ab68405c049d.camel@gmail.com>
Subject: Re: [RFC/PATCHES 00/12] pahole: Reproducible parallel DWARF
 loading/serial BTF encoding
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, dwarves@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, 
 Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>, bpf
 <bpf@vger.kernel.org>, Kui-Feng Lee <kuifeng@fb.com>, Thomas
 =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Date: Tue, 09 Apr 2024 18:01:08 +0300
In-Reply-To: <CAADnVQKnkGVL3Snaa-E+EpG536rauWZmn_kZsgQK-oaESfjjQg@mail.gmail.com>
References: <20240402193945.17327-1-acme@kernel.org>
	 <747816d2edd61a075d200ffa5da680d2cc2d6854.camel@gmail.com>
	 <64bfcf02-030d-471a-871a-e7490d74ca28@oracle.com>
	 <db6480e9378f59c367b03f7455372caf7b593348.camel@gmail.com>
	 <CAADnVQKnkGVL3Snaa-E+EpG536rauWZmn_kZsgQK-oaESfjjQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-09 at 07:56 -0700, Alexei Starovoitov wrote:
[...]

> I would actually go with sorted BTF, since it will probably
> make diff-ing of BTFs practical. Will be easier to track changes
> from one kernel version to another. vmlinux.h will become
> a bit more sorted too and normal diff vmlinux_6_1.h vmlinux_6_2.h
> will be possible.
> Or am I misunderstanding the sorting concept?

You understand the concept correctly, here is a sample:

  [1] INT '_Bool' size=3D1 bits_offset=3D0 nr_bits=3D8 encoding=3DBOOL
  [2] INT '__int128' size=3D16 bits_offset=3D0 nr_bits=3D128 encoding=3DSIG=
NED
  [3] INT '__int128 unsigned' size=3D16 bits_offset=3D0 nr_bits=3D128 encod=
ing=3D(none)
  [4] INT 'char' size=3D1 bits_offset=3D0 nr_bits=3D8 encoding=3D(none)
  [5] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
  [6] INT 'long int' size=3D8 bits_offset=3D0 nr_bits=3D64 encoding=3DSIGNE=
D
  [7] INT 'long long int' size=3D8 bits_offset=3D0 nr_bits=3D64 encoding=3D=
SIGNED
  ...
  [15085] STRUCT 'arch_elf_state' size=3D0 vlen=3D0
  [15086] STRUCT 'arch_vdso_data' size=3D0 vlen=3D0
  [15087] STRUCT 'bpf_run_ctx' size=3D0 vlen=3D0
  [15088] STRUCT 'dev_archdata' size=3D0 vlen=3D0
  [15089] STRUCT 'dyn_arch_ftrace' size=3D0 vlen=3D0
  [15090] STRUCT 'fscrypt_dummy_policy' size=3D0 vlen=3D0
  ...
 =20
(Sort by kind, than by vlen, than by name because sorting by name is a
 bit costly, then by member properties)


