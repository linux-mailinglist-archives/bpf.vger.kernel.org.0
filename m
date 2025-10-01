Return-Path: <bpf+bounces-70163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF50BB1E1D
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 23:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04E7318922F5
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 21:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE23C311976;
	Wed,  1 Oct 2025 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpDHkFBV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7C81C5F13
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 21:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759355769; cv=none; b=AYRIMVcAgMHW082Er6/VnFj8hWNT9g1AkkvXyB9FJD5iIBfVmN0kM5NWvESiF8CU+8kPnnnP3XpzHaLNKqRKaILM7sZh9YPQ35MJjlVaHenuH+umwBtS3y4ImNKJsGaGaDzQpUDD+GtSQ5l9FZKv7+eVzMot9v/emnb0520pMug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759355769; c=relaxed/simple;
	bh=2z6QWfJJSED58jH/LsnCG4/EcsEAnQS8dT7Qr9Ub/Aw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ax4azc+cyWW6CgOn3XlQCa6DTadhAQ+a0WYAczoBRsytKuTgalLXMQeEQZoyC1tAnAP/QuXZ/Z1kSFqce1eJ2K1TUZih7IaDLJBLL9oxdM5g3CWqRjbNYBgIClyIAgI2O4JQVnCwMunll3GPP0KDrEAvoqZ5SCMdJSGG0/Cv+W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpDHkFBV; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b6093f8f71dso226471a12.3
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 14:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759355766; x=1759960566; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2z6QWfJJSED58jH/LsnCG4/EcsEAnQS8dT7Qr9Ub/Aw=;
        b=VpDHkFBVLu1oPlI1bmsnGTRiDUR/sc96EDI0pXr/9wDFV+sib8QN7NdhhhKzUsb9PS
         /Q8GA6grRUp/3vM9GJa5iPZfyZFK4sZHag+uefaBy7o5kEcZraYzJjg5tLg85GM/8Jdj
         k+1zMIZhpXA4JwE16oj6XwrfAVhiQYiskMxOGpdd9S4bnUOMbeNj76QyGVsNERraI+GM
         WovXNK0yuc4fLqERMwgOvW2gsTf/UYxL9lN519ip+uCjJcjmL8rcshJkvsJsDmfMBctG
         PzbxXEpdRynFRMx1LGGlmPOIvKdz4Yr13y7m2gea3s6N7MYcXcySPfGEbB7eOb0VviJI
         +EoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759355766; x=1759960566;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2z6QWfJJSED58jH/LsnCG4/EcsEAnQS8dT7Qr9Ub/Aw=;
        b=nnY9ZUo4TDD95JGX/S9gmptv5/tS7rV8yn8VCVbfMEBm35TrI07Nv4SP7qNEwataUX
         h1X/gdgcL9H187CGJnUlrsLbwqkt7x2xi2g1htgoHCUGLU2zn8rCPpu1lxopOWdLfC6F
         zn0WrdzfXxX1vbQYKKrmeCAH/KorbU0Y30T6eZHoRDagAciTbO7Cw4fSShPI5pqotIXx
         S8GhP8kMuWzBFCFE6EaNyl8FiTaB07oE5XUFAeUhJ4GghHlA7KlSmvQitNtVBKnTYnGP
         c6bv/VA/isTPiu95/9aMKClxeoXn3MArL/p2f0Jb2iiXcyyYRIVmOM8bp8xyd4o0K+RT
         NCNw==
X-Forwarded-Encrypted: i=1; AJvYcCXsIlyrWD22WvChhSQPccYkymlCdezC2fKzkoxswphUOSZaNqFW0DBPI6kcPqcmyt5ZgBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVpXaElHk6FXK/aOGDwhcIfoXY2dn6Nm5HVlBu+bfQWC6lcwkI
	ojTJUA4q639i/s9Q9HqSQYrbBZZ6FmYFunaUV2hqOXM1kVeuYygGMXSu
X-Gm-Gg: ASbGncswsBmzWiVJm54JJdHxVnqR/TtUACtuRoI/ovzFu3pwEifyZpfSleIikMnG+ge
	JXil3SsdQJvB/I0+WF3eHZ8nLLeHsC6tQrMaBc2GeIJ6pmyCw4hPo5HPqegNLh1fzFAw1AI4oWm
	ZIYP58oqd0IdAYEyDx4LqyA8YqSUlpmBO8FwG49xu3D3JDKPbEplSk/UcAWol7OaYqOC7khUd7P
	IFm9O9DdJiq4//e2HBp3N3NJyiN83+4leAZ0L/wKDRvAGu4Mu5ZzxrywELpue/n67FObHeNK0fz
	G+QZ8Q9LC6ROOozoBu2XHQucMFXdQfcHauFqukYTpn4jBUJAVecpIjqEsqzpWRj4rMLSlTc8vF6
	aqmvRVvoWGM2Ya43cNvh51+JTGaii6Swgx8mJyICEbm5dqQrRfk0358NDOm12dz2Y2K/19Bk=
X-Google-Smtp-Source: AGHT+IEuMBCRPLJ0vYd+vUe52u9B7eQpMcIQQoHnWaKeSuZ/MoeZk45u2s3wK6wfio064zvWQxvOxw==
X-Received: by 2002:a17:902:e541:b0:28e:756c:7082 with SMTP id d9443c01a7336-28e7f299b57mr71673365ad.15.1759355766230;
        Wed, 01 Oct 2025 14:56:06 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ed4:e17:bedc:abbb? ([2620:10d:c090:500::6:420a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1ba1e3sm5811945ad.75.2025.10.01.14.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 14:56:05 -0700 (PDT)
Message-ID: <49b73197041dd70872ee4923da513c513040302e.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 03/15] bpf: generalize and export
 map_get_next_key for arrays
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Wed, 01 Oct 2025 14:56:04 -0700
In-Reply-To: <20250930125111.1269861-4-a.s.protopopov@gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
	 <20250930125111.1269861-4-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-30 at 12:50 +0000, Anton Protopopov wrote:
> The kernel/bpf/array.c file defines the array_map_get_next_key()
> function which finds the next key for array maps. It actually doesn't
> use any map fields besides the generic max_entries field. Generalize
> it, and export as bpf_array_get_next_key() such that it can be
> re-used by other array-like maps.
>=20
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

