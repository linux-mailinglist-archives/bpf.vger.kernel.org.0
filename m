Return-Path: <bpf+bounces-51878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBAAA3AC06
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 23:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B594188DE58
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 22:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE561D9346;
	Tue, 18 Feb 2025 22:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXSUteLX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1032862B7;
	Tue, 18 Feb 2025 22:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919103; cv=none; b=BTRIDNSrV7BYz9V4u464ERb+K5dJVH8+BeNAdwpshv/v4d80IurYIYJES95aaKJOCkNfNc9gLRvqeY1YGuXEnKAos6qIUJTXL2OmS3lnuuZl6VMcuqdbIcie+99CteAkfPXKYGe098cSPBGMzP4SsnouCCDFQpl4BiXrD2jd0oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919103; c=relaxed/simple;
	bh=09mhIVIKYxjiPovvCZwIfT9uucZB6bewGp1zpFbGO9o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VYkKCS+OCzAMtAryak4WM//vzzWv2daQeBuIlMDckU/rEKfvI91M6zzhf4tmfgpDArq4v10RX75nIHNJ1kw+ZoaPKsVXnPYGjDnJamc4E8VT2imLm91GzAH3jsP8y8ZsSdV9eDJL7v+XtLKTj6WdAErmXEwAqd/o1Rqhh4R955A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HXSUteLX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220ecbdb4c2so124481855ad.3;
        Tue, 18 Feb 2025 14:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739919101; x=1740523901; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6ORrYmUDPNdGvCeOBnG5uQ7Y0NU9bK0qUq1EfyO/514=;
        b=HXSUteLXLMEZVzKbBo/RWBPIitQOo+PyBvEWIFl0W9bUr/72/BSjdg55+LHwqN52a6
         awmwmDZasGa0OTSnz6cUldipWch/1M4r1d8Bd8csLmj1GjOTaAy2S74xT0qWKhLQ/EXi
         bP5UVdyOJr+/becFKfEvFSRlRqnI7Ly6Z5M/SjUuiE88uA0E5ntvhaBsEmjQKKhpZFbi
         7+3y8UuhSZyWkeCtCi4l7E07w7Pf/KU2S0vV7mrPGKQrli5umP3v28bHOTLF2AjmafDi
         PAS/lfiBrq9jEUCyGrD8lgp46RXgq8Nq35KioUqGM7xW6WxWZET5durhhe1/JcnLq6WU
         MgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739919101; x=1740523901;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ORrYmUDPNdGvCeOBnG5uQ7Y0NU9bK0qUq1EfyO/514=;
        b=HlLLP/cGFd112fSeWOVk9t7TswktVUPbaRFBDVwDZV+yenmz1iTWM6C+cLZvG25mA5
         bxlqZxwiwWk0L/rBLuo2pdXNPzwM4ebsG0LwSOUNTMoWnObyke3h1Rp4KgO/pBrTO4Gx
         1t/ALIda7HpMhRSzlNQj6dehXPnYaNte8VFceqlhklRXcrTOHbLmiZmTnf4EAaFltnS6
         RYFXdRynZxUllpPtvIx3tJj1ryUpgEzMih7PJV8tG7K4JnahA97lS/4xFIkMQt8LpWvg
         e5/7v4nWOGnU+h05V3npnWkKjA38EZrl3+1toJ2s+sWIID7Z8BMgf8/dc4R9yeU3s0E3
         V7SA==
X-Forwarded-Encrypted: i=1; AJvYcCXVLegzjXdmnZn5K+vQFYOy3PtzUkRSyWpQ+8bEx0Pdompqw9A98QyVl9oCUEGMmHmALq7nFLnQqTK4jzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXiQ0vd6p3Sjf0/FhBsWufRumpUIRvMS9nX0JX2p7BgMHcyZ+n
	jqQN9jXtLn18WKQUA1xqytidbweRuVgk59BhCV8/TDY10z/7Y9Z5779blA==
X-Gm-Gg: ASbGncuFY2zTlyjp5VAtaWwCvXBA0cOGds3ybWo6DyWeGkp7C7H5+qgQFv5BQ7CrBmM
	zEUg+GGD9jv+8txoJl3nOdfQl1U7Fnt57+RlePTdyzecdRa6/oRuLjAv7lr9ffSy1YPgqUeriGY
	7F2+/sSfCcx2DC6oV0VsLxUfpOh2yrKtWzDmc7Pm7A45IGf46XqpbVHODZjovgahoXma9rudtns
	6fpDzhq/NFZmLsugFiojTiRsF0aFtZNguCnqMMHc1N6KTc6pVI77eOSHA8KQndZnYsjtKypC6n1
	xtpCErXsQAZo
X-Google-Smtp-Source: AGHT+IHw221j9N2U4Hg+3w/6umwAipgdU2Ef5aU/ybP4CQxRHBWYMQjONMnDMTpY5xFUV+A2aPoBrQ==
X-Received: by 2002:a05:6a21:6b18:b0:1ee:688c:6ad9 with SMTP id adf61e73a8af0-1ee8cb4eec7mr27265022637.17.1739919101392;
        Tue, 18 Feb 2025 14:51:41 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adc746d1079sm8222439a12.68.2025.02.18.14.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 14:51:40 -0800 (PST)
Message-ID: <598a7d089936b18472937679d4131286f102cb18.camel@gmail.com>
Subject: Re: [PATCH RESEND bpf-next v7 0/4] Add prog_kfunc feature probe
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tao Chen <chen.dylane@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 18 Feb 2025 14:51:36 -0800
In-Reply-To: <2b025df3-144b-4909-a2b4-66356540f71c@gmail.com>
References: <20250212153912.24116-1-chen.dylane@gmail.com>
	 <2b025df3-144b-4909-a2b4-66356540f71c@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-17 at 13:21 +0800, Tao Chen wrote:
> =E5=9C=A8 2025/2/12 23:39, Tao Chen =E5=86=99=E9=81=93:
> > More and more kfunc functions are being added to the kernel.
> > Different prog types have different restrictions when using kfunc.
> > Therefore, prog_kfunc probe is added to check whether it is supported,
> > and the use of this api will be added to bpftool later.
> >=20
> > Change list:
> > - v6 -> v7:
> >    - wrap err with libbpf_err
> >    - comments fix
> >    - handle btf_fd < 0 as vmlinux
> >    - patchset Reviewed-by: Jiri Olsa <jolsa@kernel.org>
> > - v6
> >    https://lore.kernel.org/bpf/20250211111859.6029-1-chen.dylane@gmail.=
com
> >=20
> > - v5 -> v6:
> >    - remove fd_array_cnt
> >    - test case clean code
> > - v5
> >    https://lore.kernel.org/bpf/20250210055945.27192-1-chen.dylane@gmail=
.com
> >=20
> > - v4 -> v5:
> >    - use fd_array on stack
> >    - declare the scope of use of btf_fd
> > - v4
> >    https://lore.kernel.org/bpf/20250206051557.27913-1-chen.dylane@gmail=
.com/
> >=20
> > - v3 -> v4:
> >    - add fd_array init for kfunc in mod btf
> >    - add test case for kfunc in mod btf
> >    - refactor common part as prog load type check for
> >      libbpf_probe_bpf_{helper,kfunc}
> > - v3
> >    https://lore.kernel.org/bpf/20250124144411.13468-1-chen.dylane@gmail=
.com
> >=20
> > - v2 -> v3:
> >    - rename parameter off with btf_fd
> >    - extract the common part for libbpf_probe_bpf_{helper,kfunc}
> > - v2
> >    https://lore.kernel.org/bpf/20250123170555.291896-1-chen.dylane@gmai=
l.com
> >=20
> > - v1 -> v2:
> >    - check unsupported prog type like probe_bpf_helper
> >    - add off parameter for module btf
> >    - check verifier info when kfunc id invalid
> > - v1
> >    https://lore.kernel.org/bpf/20250122171359.232791-1-chen.dylane@gmai=
l.com
> >=20
> > Tao Chen (4):
> >    libbpf: Extract prog load type check from libbpf_probe_bpf_helper
> >    libbpf: Init fd_array when prog probe load
> >    libbpf: Add libbpf_probe_bpf_kfunc API
> >    selftests/bpf: Add libbpf_probe_bpf_kfunc API selftests
> >=20
> >   tools/lib/bpf/libbpf.h                        |  19 ++-
> >   tools/lib/bpf/libbpf.map                      |   1 +
> >   tools/lib/bpf/libbpf_probes.c                 |  86 +++++++++++---
> >   .../selftests/bpf/prog_tests/libbpf_probes.c  | 111 +++++++++++++++++=
+
> >   4 files changed, 201 insertions(+), 16 deletions(-)
> >=20
>=20
> Ping...
>=20
> Hi Andrii, Eduard,
>=20
> I've revised the previous suggestions. Please review it again. Thanks.
>=20

I tried the test enumerating all kfuncs in BTF and doing
libbpf_probe_bpf_kfunc for BPF_PROG_TYPE_{KPROBE,XDP}.
(Source code at the end of the email).

The set of kfuncs returned for XDP looks correct.
The set of kfuncs returned for KPROBE contains a few incorrect entries:
- bpf_xdp_metadata_rx_hash
- bpf_xdp_metadata_rx_timestamp
- bpf_xdp_metadata_rx_vlan_tag

This is because of a different string reported by verifier for these
three functions.

Ideally, I'd write some script looking for
register_btf_kfunc_id_set(BPF_PROG_TYPE_***, kfunc_set)
calls in the kernel source code and extracting the prog type /
functions in the set, and comparing results of this script with
output of the test below for all program types.
But up to you if you'd like to do such rigorous verification or not.

Otherwise patch-set looks good to me, for all patch-set:

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

--- 8< -----------------------------------------------------

static const struct {
	const char *name;
	int code;
} program_types[] =3D {
#define _T(n) { #n, BPF_PROG_TYPE_ ## n }
	_T(KPROBE),
	_T(XDP),
#undef _T
};

void test_libbpf_probe_kfuncs_many(void)
{
	int i, kfunc_id, ret, id;
	const struct btf_type *t;
	struct btf *btf =3D NULL;
	const char *kfunc;
	const char *tag;

	btf =3D btf__parse("/sys/kernel/btf/vmlinux", NULL);
	if (!ASSERT_OK_PTR(btf, "btf_parse"))
		return;

	for (id =3D 0; id < btf__type_cnt(btf); ++id) {
		t =3D btf__type_by_id(btf, id);
		if (!btf_is_decl_tag(t))
			continue;
		tag =3D btf__name_by_offset(btf, t->name_off);
		if (strcmp(tag, "bpf_kfunc") !=3D 0)
			continue;
		kfunc_id =3D t->type;
		t =3D btf__type_by_id(btf, kfunc_id);
		if (!btf_is_func(t))
			continue;
		kfunc =3D btf__name_by_offset(btf, t->name_off);
		printf("[%-6d] %-42s ", kfunc_id, kfunc);
		for (i =3D 0; i < ARRAY_SIZE(program_types); ++i) {
			ret =3D libbpf_probe_bpf_kfunc(program_types[i].code, kfunc_id, -1, NULL=
);
			if (ret < 0)
				printf("%-8d  ", ret);
			else if (ret =3D=3D 0)
				printf("%8s  ", "");
			else
				printf("%8s  ", program_types[i].name);
		}
		printf("\n");
	}
	btf__free(btf);
}

----------------------------------------------------- >8 ---


