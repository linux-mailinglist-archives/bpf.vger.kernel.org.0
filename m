Return-Path: <bpf+bounces-71651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7C8BF967F
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 01:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E4B8508C4C
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 23:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FBA2571D4;
	Tue, 21 Oct 2025 23:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUJsr+6j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59952244664
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090667; cv=none; b=F2a+7KNL1Ud7v7XptTBXX0Zxq7VTkQkl0dNxmZ0XQ+9hGd/o0V/DTAcGO8wy2aJ72T7YeSPgprUeer6XaN2tXBLEcG59HiLfzfSS2+aZaxWVDi24XUw2I5ewkT60jcK3HpGMkc+SPrCudhZUbnVEXMKMmvjjfpAZ0jAA+StiM88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090667; c=relaxed/simple;
	bh=Dyal4P8ydFxd+cUaitzhfOyFPUeMDqPLkvw4798LpLc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QSko6IVJVVGlmzQrbmdqayCgBtzPw7M8Ru2VqTrYUQ+3E5IViMJaGca7Hx681WikTmbNLH+cI07FJ/XqiOxjsow5aHrboKR1FSG2Ci6uJYviGdGGwYBHabZbkHXCca4+ZTS7ZP8FDmv5nN30mxlVJ8IUhfQQ0mdnnIbTFOuaV54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUJsr+6j; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29292eca5dbso36435035ad.0
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 16:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090666; x=1761695466; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4a87o35DRP4a2Jg78x4CazMPBYlOfikhOHsc/PO8Sb4=;
        b=HUJsr+6jTs74IVpGEwNJfqDkkQiaWiUo6r46amSXjtGxaAMvXnHCZ9eQJ07mFIlOS0
         veTjOe6/wGZS4yKAn4PVdLf8kxPIJ8QXBH2JNZEeOKXpq+GtHtYiS9vzqeBvfzMBG17J
         dMhONQEB3gjvCQM7vkQgBfEJKk8KpJh1F8mwy6/Vd3dFi+BO8FBZsxYdhjIscpQAogXk
         dUlpIjEdckVc7V77zf/kvrBkny65Sq000o84af9yh1d3UnMKATcoXxV3TmKW/Hdon7XB
         Ew++Z6BRadA0Fql+B76jeoIWf49f+VIO3SQf/QFwMx2dXfMAKgaHooponrJVNe5NOeIa
         6j/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090666; x=1761695466;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4a87o35DRP4a2Jg78x4CazMPBYlOfikhOHsc/PO8Sb4=;
        b=rUjAbU9ogdhro7Iq3l6gEizs60GRfshWND1Armofj+N+ICtBKz9WDbll5yQeG42IdM
         ukoOT7bS9bOGXmZQPglsg48DrEc+cFrNHlOgJ3T5yJZKGGd6PxIXhyEHfzgUtg9eSdaP
         6Auf0x41AipI9DStrT6iwcSuuHwCuBfjtTiRoqm5ERah1nV8LkhU/dfbxENPtgjSqvfo
         n/IoA1JXqz/4xnVZ7DmxGTDoRGOSjLXSMBFVDE+gtBgijxTHJp1mF1sDVtXVSe2p2I8M
         7beULjIeSzSacjB2EYi+LgXIMx3NJ+HSPXtOOMCnhwax0AWbSfsR4zO2RtStOXGSi6YQ
         0SKw==
X-Forwarded-Encrypted: i=1; AJvYcCWYciQ0NFeyJKI2lvd4V+y8u08PL+YiPdqAMfLO9k3jwMo5b23syJC68u0lpPVGA/NvYdc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtHvpp8zYb6vTJ6fGDmyTRItl/3VUPJnoGeoN598xgVFAG7ZWz
	wmYb49LiJAtpdsD0Fj7WmoQdh3vmA2G2ZyXlf2thqAhlixJwS006WpYY
X-Gm-Gg: ASbGnctsI7bAysypg2XnRI1ihJa9b1XT8sszZ/h0rB0/Q0VDbbYkvANUi9IYGm0JLy8
	0Um5FFHeTUzSeGDSUNWcTV+sD1mQ+s7AQQ9f/tn72Xa4IsYQQ2b0t+UcoljACzyF6jN+8S8iuG/
	l43NzBFNiLcV17WurWcMaGPfW8bW4hY9T5322L7AHXWh9w5iM7NcXfhoRWN6Jqwf3gMTuB/AGFS
	OVmAfMa1dM5H0nY3uS1KMjDtmzwzbPKUNcQ2irUMhBF4xl7uyQEcbKX1Defud86Q0nfDUP5F3rQ
	9in5t3htWgLAvAJHOQBGVZT1rzdwx3VpVQ1qsnnIgvzjnOSrZtfQz0mAthpiOgG5yGfzkG1Q8np
	9A7UKiy2G11aA3cV+PJGqa9yekAMyh8teNUwh2bLfkozZl41UfCRaT/i7hIs9Dw78JrzRML5NUg
	VWNVlnN/HMmkU23+VsFrhJAPjhTRq939pk30A=
X-Google-Smtp-Source: AGHT+IEAq/bz3vsp0ekko5jPM5K4SV3FKFG0Tc9fwP54eoQhGP2p/TbkRmeObLiUhoMhSdVzM7gqXg==
X-Received: by 2002:a17:903:240a:b0:25e:37ed:d15d with SMTP id d9443c01a7336-290c99b11femr226435785ad.0.1761090665722;
        Tue, 21 Oct 2025 16:51:05 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:84fc:875:6946:cc56? ([2620:10d:c090:500::7:6bbb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe2cdsm120264945ad.95.2025.10.21.16.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:51:05 -0700 (PDT)
Message-ID: <9660d7d3d3348bdf84c0a1a2861b66db9e2cc980.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 05/17] selftests/bpf: add selftests for new
 insn_array map
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Tue, 21 Oct 2025 16:51:03 -0700
In-Reply-To: <20251019202145.3944697-6-a.s.protopopov@gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
	 <20251019202145.3944697-6-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-10-19 at 20:21 +0000, Anton Protopopov wrote:
> Add the following selftests for new insn_array map:
>=20
>   * Incorrect instruction indexes are rejected
>   * Two programs can't use the same map
>   * BPF progs can't operate the map
>   * no changes to code =3D> map is the same
>   * expected changes when instructions are added
>   * expected changes when instructions are deleted
>   * expected changes when multiple functions are present
>=20
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  .../selftests/bpf/prog_tests/bpf_insn_array.c | 404 ++++++++++++++++++
>  1 file changed, 404 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_insn_array=
.c
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/to=
ols/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> new file mode 100644
> index 000000000000..a4304ef5be13
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c

[...]

> +static void check_bpf_no_lookup(void)

This one can be moved to prog_tests/bpf_insn_array.c, I think.

> +{
> +	struct bpf_insn insns[] =3D {
> +		BPF_LD_MAP_FD(BPF_REG_1, 0),
> +		BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> +		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> +		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> +		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
> +		BPF_EXIT_INSN(),
> +	};
> +	int prog_fd =3D -1, map_fd;
> +
> +	map_fd =3D map_create(BPF_MAP_TYPE_INSN_ARRAY, 1);
> +	if (!ASSERT_GE(map_fd, 0, "map_create"))
> +		return;
> +
> +	insns[0].imm =3D map_fd;
> +
> +	if (!ASSERT_EQ(bpf_map_freeze(map_fd), 0, "bpf_map_freeze"))
> +		goto cleanup;
> +
> +	prog_fd =3D prog_load(insns, ARRAY_SIZE(insns), NULL, 0);
> +	if (!ASSERT_EQ(prog_fd, -EINVAL, "program should have been rejected (pr=
og_fd !=3D -EINVAL)"))
> +		goto cleanup;
> +
> +	/* correctness: check that prog is still loadable with normal map */
> +	close(map_fd);
> +	map_fd =3D map_create(BPF_MAP_TYPE_ARRAY, 1);
> +	insns[0].imm =3D map_fd;
> +	prog_fd =3D prog_load(insns, ARRAY_SIZE(insns), NULL, 0);
> +	if (!ASSERT_GE(prog_fd, 0, "bpf(BPF_PROG_LOAD)"))
> +		goto cleanup;
> +
> +cleanup:
> +	close(prog_fd);
> +	close(map_fd);
> +}

[...]

