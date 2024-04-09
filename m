Return-Path: <bpf+bounces-26319-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3363389E39B
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 21:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC9C1C2122E
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 19:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E83157E92;
	Tue,  9 Apr 2024 19:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/p41Wsb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D7F156F28;
	Tue,  9 Apr 2024 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712690964; cv=none; b=tZXhTmxJUYv+GHb2HoPiGw9V3B1zibVHJhHVBmFOe8YKjKW3lizX2iCRrNn8fM7qk/pI5R/pb+KpNNvTfpDsTDpOx9Lq3bFdMEKJF0hp1tqTlgSv0HjyS9XZoCmOIizUUpjdmuN1csdu83bqf+lQ8idGkPFZZz8zjGtjMoDOoHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712690964; c=relaxed/simple;
	bh=jPBIIIx64h86+H3gqwYuFKfw9bQWcKMvunxDTcTpB9E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZITmYoeZIKyP3Wl7duLz9KnUNDnMZ0al7o/XPessQaQuGdn2bh6XHFkQuWAqcvmXAlLRHO5oCvi5Xn1dXcfDRLDXv3KikrMM0ZyA+wvl+aFCzquwXkUKjCEpfgTHf8FfwpO+/SMmRFXce6bSk7BeltjFbLXtwcHGd2/n/06orbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/p41Wsb; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a51c8274403so386356066b.1;
        Tue, 09 Apr 2024 12:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712690961; x=1713295761; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AEQ0KwSigjhH7yiyzFeHE3mJTiUfUOuo4U2SjSMzeL8=;
        b=H/p41Wsb+g0b5BY7nLmo+VgoJC4Gsl8Ou0w9PjzFatLJdfX2pHu08myi4yOeVe5TY4
         2jerB5wksf7GH7TzeMsW4QmRooWgG2LeJaKOxd7lGvoCdhuQDd9TrHUEcZzMwLY52Ch+
         60WznWODdzWxQ/uTJ2X+uxn/EBigvk4kHLGSylr+SRc5O+1xWEpHrNBkZndGu1+6OfYT
         UQ4AY+QmDPI/K8pYjg4Ru02AtIcSAOZgBglN0PJsVjE9BaKzm3joGcZ2j3tx/kQ3tmlZ
         /BV5/h/eE1CEIfRzdc57JUHx2ZWtKFVJ8LFjyavywbZ7Pp69Hs1gj8tdd14c2YeoxaML
         6M+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712690961; x=1713295761;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AEQ0KwSigjhH7yiyzFeHE3mJTiUfUOuo4U2SjSMzeL8=;
        b=dKXIS28KonR+ifI5J2SuuehWi5DM+ZlixtaHLjkrFsFDRTWN8/ci4BHD0mpwERZO60
         i94FCwgL2H6VZsejV1t/s/VfUQbzSbXZrt8/yhMVJg7M5Z6ScmBXlRYhEwTN9085ASHi
         ShA6Hs3k4rqNWD8bTjKgBucWDOhBrzW2vujdL9yfpmkM0QgqrEmTlI4LZY+Q0F56BQEz
         licMwRF6i3nsh7FP9QFCjhZlP1zqFsbpPWryH23Pjof4oI9ZmcXgSnRqRJsDOigR0MFS
         fnNL0N80fH4LEmFIth0Oya7CL2WNXLQxvJeNNSNm5gp+nEUyCbFnq1WduWwK93/WxnbR
         TzMw==
X-Forwarded-Encrypted: i=1; AJvYcCXnJPFwn+KXTIbpZZNattYpTqfF0m6hYOnPXi1xklDM1HhnYAt74VWggHIkeW0seBUOxfqrAPVFXW5g/k14sUVp0ov9ShLtLEyDadkoXzlqmRo7f07gXhQmj+gziA==
X-Gm-Message-State: AOJu0YzWTJVuzu9xyIEuMSLaUHrZpnW2zJFAGZ0jfG6Gn3TgGQD9SBzi
	bssaRCOEQ7uMrIf/Q07WpBs5FLFaFJmbE8OjTXDBvBGbyA7cEPVv
X-Google-Smtp-Source: AGHT+IEcwcNQVzVLVjDUfqt3iRv3i1+q720xzF0luuCaSQRPWFF6fMuXRL7OaAcbbdhiVhcSi4nk5A==
X-Received: by 2002:a17:906:374c:b0:a51:cbd5:1fb5 with SMTP id e12-20020a170906374c00b00a51cbd51fb5mr214265ejc.36.1712690960610;
        Tue, 09 Apr 2024 12:29:20 -0700 (PDT)
Received: from [192.168.100.206] ([89.28.99.140])
        by smtp.gmail.com with ESMTPSA id bp5-20020a17090726c500b00a51db91186fsm2534680ejc.119.2024.04.09.12.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 12:29:20 -0700 (PDT)
Message-ID: <1314495ccf0d31babf408eb539fa2eba70e404a0.camel@gmail.com>
Subject: Re: [RFC/PATCHES 00/12] pahole: Reproducible parallel DWARF
 loading/serial BTF encoding
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alan Maguire
 <alan.maguire@oracle.com>, dwarves@vger.kernel.org, Jiri Olsa
 <jolsa@kernel.org>,  Clark Williams <williams@redhat.com>, Kate Carcia
 <kcarcia@redhat.com>, bpf <bpf@vger.kernel.org>, Kui-Feng Lee
 <kuifeng@fb.com>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Date: Tue, 09 Apr 2024 22:29:18 +0300
In-Reply-To: <ZhWMxu8Xq1oAUAoC@x1>
References: <20240402193945.17327-1-acme@kernel.org>
	 <747816d2edd61a075d200ffa5da680d2cc2d6854.camel@gmail.com>
	 <64bfcf02-030d-471a-871a-e7490d74ca28@oracle.com>
	 <db6480e9378f59c367b03f7455372caf7b593348.camel@gmail.com>
	 <CAADnVQKnkGVL3Snaa-E+EpG536rauWZmn_kZsgQK-oaESfjjQg@mail.gmail.com>
	 <7a08fb6a8c37e58a56121c8536b9ab68405c049d.camel@gmail.com>
	 <ZhWMxu8Xq1oAUAoC@x1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-09 at 15:45 -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Apr 09, 2024 at 06:01:08PM +0300, Eduard Zingerman wrote:
> > On Tue, 2024-04-09 at 07:56 -0700, Alexei Starovoitov wrote:
> > [...]
> =20
> > > I would actually go with sorted BTF, since it will probably
> > > make diff-ing of BTFs practical. Will be easier to track changes
>=20
> What kind of diff-ing of BTFs from different kernels are you interested
> in?
>=20
> in pahole's repository we have btfdiff, that will, given a vmlinux with
> both DWARF and BTF use pahole to pretty print all types, expanded, and
> then compare the two outputs, which should produce the same results from
> BTF and DWARF. Ditto for DWARF from a vmlinux compared to a detached BTF
> file.
>=20
> And also now we have another regression test script that will produce
> the output from 'btftool btf dump' for the BTF generated from DWARF in
> serial mode, and then compare that with the output from 'bpftool btf
> dump' for reproducible encodings done using -j 1 ...
> number-of-processors-on-the-machine. All have to match, all types, all
> BTF ids.
>=20
> We can as well use something like btfdiff to compare the output from
> 'pahole --expand_types --sort' for two BTFs for two different kernels,
> to see what are the new types and the changes to types in both.
>=20
> What else do you want to compare? To be able to match we would have to
> somehow have ranges for each DWARF CU so that when encoding and then
> deduplicating we would have space in the ID space for new types to fill
> in while keeping the old types IDs matching the same types in the new
> vmlinux.

As far as I understand Alexei, he means diffing two vmlinux.h files
generated for different kernel versions. The vmlinux.h is generated by
bpftool using command `bpftool btf dump file <binary-file> format c`.
The output is topologically sorted to satisfy C compiler, but ordering
is not total, so vmlinux.h content may vary from build to build if BTF
type order differs.

Thus, any kind of stable BTF type ordering would make vmlinux.h stable.
On the other hand, topological ordering used by bpftool
(the algorithm is in the libbpf, actually) might be extended with
additional rules to make the ordering total.

> While ordering all types we would have to have ID space available from
> each of the BTF kinds, no?
>=20
> I haven't looked at Eduard's patches, is that what it is done?

No, I don't reserve any ID space, the output of=20
`bpftool btf dump file <binary-file> format raw` is not suitable for
diffing w/o post-processing if some types are added or removed in the
middle.

I simply add a function to compare two BTF types and a pass that sorts
all BTF types before finalizing BTF generation.

> > > from one kernel version to another. vmlinux.h will become
> > > a bit more sorted too and normal diff vmlinux_6_1.h vmlinux_6_2.h
> > > will be possible.
> > > Or am I misunderstanding the sorting concept?
> =20
> > You understand the concept correctly, here is a sample:
> =20
> >   [1] INT '_Bool' size=3D1 bits_offset=3D0 nr_bits=3D8 encoding=3DBOOL
> >   [2] INT '__int128' size=3D16 bits_offset=3D0 nr_bits=3D128 encoding=
=3DSIGNED
> >   [3] INT '__int128 unsigned' size=3D16 bits_offset=3D0 nr_bits=3D128 e=
ncoding=3D(none)
> >   [4] INT 'char' size=3D1 bits_offset=3D0 nr_bits=3D8 encoding=3D(none)
> >   [5] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED
> >   [6] INT 'long int' size=3D8 bits_offset=3D0 nr_bits=3D64 encoding=3DS=
IGNED
> >   [7] INT 'long long int' size=3D8 bits_offset=3D0 nr_bits=3D64 encodin=
g=3DSIGNED
>=20
> The above: so far so good, probably there will not be something that
> will push what is now BTF id 6 to become 7 in a new vmlinux, but can we
> say the same for the more dynamic parts, like the list of structs?
>=20
> A struct can vanish, that abstraction not being used anymore in the
> kernel, so its BTF id will vacate and all of the next struct IDs will
> "fall down" and gets its IDs decremented, no?

Yes, this would happen.

> If these difficulties are present as I mentioned, then rebuilding from
> the BTF data with something like the existing 'pahole --expand_types
> --sort' from the BTF from kernel N to compare with the same output for
> kernel N + 1 should be enough to see what changed from one kernel to the
> next one?

Yes, this is an option.

Thanks,
Eduard

