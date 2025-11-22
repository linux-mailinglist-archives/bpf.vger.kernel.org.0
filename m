Return-Path: <bpf+bounces-75295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B21C7C980
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 08:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0672E3A7EF5
	for <lists+bpf@lfdr.de>; Sat, 22 Nov 2025 07:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB00F25A642;
	Sat, 22 Nov 2025 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3Zp+p/4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC27E1E9B1C
	for <bpf@vger.kernel.org>; Sat, 22 Nov 2025 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763796750; cv=none; b=JURZNYb3xtl/uFUUcfRyb8eozsDOepoMVEFgsXcyXDkVA0BA8hneBYm127wn4KARnM1F/QRoMQ7ZMz+bz7XDMFQQla08UehnbiJhWC6cAkcbbW18Vh74upWyS+O+zeaR3Io2iWEZfvOnNYANB3ZjycVPDFnjMLu9B6i+Yuv8XP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763796750; c=relaxed/simple;
	bh=an/FhzgnXaiQajHgNuSJuYQa60sKUqlACrSLhFfP99E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gmn1bUKCTN6EY9XKl0XQExiZVKshBDfmuQflUSfpmwCxLrOhGJycWExF2qjKhAbejZ3XGaIg/V08f6xNZPK1ArfrsV2gwC1+vu16YzxmewXsyYr71kVIYjQH8i8vrzvymbLtbmkmgNNN/v0VAf5i05qIP4xfxO5aPeq5b1k3B1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3Zp+p/4; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b2ed01ba15so240794585a.1
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 23:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763796748; x=1764401548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=an/FhzgnXaiQajHgNuSJuYQa60sKUqlACrSLhFfP99E=;
        b=m3Zp+p/4BJ6VgRqU7G2WQEDRyMgMDMqHfBvm9X+fuJM5guyZSTvjxkpsYqt6ShQVQX
         9rSanY9PbF5xkzno40CsP8buTaurxF2g9A7eTVzbO6tIh3V2PWy9iGe58NtpvhTqfn8i
         1M6y8/Gvdc74mdFXHVdebLT6a7F5/VtECxU2Urza95AUp67cQCTDexPZEOAG2pY9ge+7
         2hRt+6Rlzn9jQ7luEAosaGox3W1CF0dHWB3ro36xRdun3GHK/Y7JyavpdntkL2nM5JuF
         ufWVaNVVsMG1WjG13IAWKuseJLuCGQtRyXpZKBCEftRoRMuDlMcYveC22gGDOa8w4ZMS
         G+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763796748; x=1764401548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=an/FhzgnXaiQajHgNuSJuYQa60sKUqlACrSLhFfP99E=;
        b=eGeh3qJVMilVHFv3tdEzMgJRlPrAvbReGDRNeNyUiwDeW85RDN6s27KI+wFzsU0hxN
         PDVclsCIlQmQ1B/RG1Lq3HmkOv0E97rXSI+hjVh5ZDk4zCZIVbx3xvf1ZR0I8+q6bH89
         YxH/URt4CoSeMktEneX4KVfd9/a2A8nFyTayHw0JFtHlsLXDAbrpykoSt5du9Q0iw/HC
         LwqVudbLBu968Pefkvc/4UTScRObCL6N8EfvkTVTvczKuwdYyfJ0vbCUDsiVaCT6Bi8d
         RDuNTQC4icvqFiqCo6iNur62gA8DirNJ7PK7ld19tAwbmFG6vvaJ7kdqPKcW3VlPXmHQ
         hz0A==
X-Forwarded-Encrypted: i=1; AJvYcCVgwJPyQdEah8XrvrDiBTKcjrgkE4atA/HCzJYLBuvV0Swuwtn5ALIr/WE038KKbpDZB2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy2u6jQqbVjMQMeS2REHVtolPvnLKc/WkIeJnO/qUEOa8/cCVD
	WX9Sb0PY5waeArFd33Owwr04IfNxU+5Tb1UvADZFIWT3aPXX6vpvh6McIAkDWSEOKK4tSzhrSfF
	ohqgZvEDSN6yQmSZsBkqwHzYS5kRbHbE=
X-Gm-Gg: ASbGnctwDXUH/EuKz6pURXgflDVIGGSU2j1YHLt6LHsnIYCH6L4Lnmxy3I77jKJ/oiw
	cczy3oD+U7mtV/mfgA22aoOOnLZPgQVEA5z51Fp4dvo/SVFYqPRQn9a8jyVd+9vWHCaAkI4e3Xh
	wU4BtkICdGCLtBoHPaRh2BT1cTaNRKBBFK47PM2VDmoutL8Q8WfVInoiapIeV/hX5qXbs/eplpw
	aD1e69Pr4/TGuk0H6DfhFMb5YJCrbGYro6FVi3F40ImlwM2G6+2pKFUy/9XF9Iv8g0ZKGbIxB8g
	uUWlNIs=
X-Google-Smtp-Source: AGHT+IGf24HFCfwJPkCAL9U6twbSs0XIvihNIu1TiSt5AJ17fedOiDMNpBOmW9Ey4vIRUSfDv9GBVJRfl9QwPRwU7NQ=
X-Received: by 2002:a05:620a:3710:b0:8b2:ea5a:413d with SMTP id
 af79cd13be357-8b33d4afdefmr560215585a.86.1763796747606; Fri, 21 Nov 2025
 23:32:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
 <20251119031531.1817099-6-dolinux.peng@gmail.com> <CAEf4BzYQfHKHUdxv7W7mET1xBXuokvx9v=69HNAkhg_CAPCm-g@mail.gmail.com>
 <CAErzpmvLhKbCYh3hYW=54JJtXj3TV0t2JAmGwy4E3xW7r84OBw@mail.gmail.com> <e8f499647614e592845dbdfa23d53e6c62434485.camel@gmail.com>
In-Reply-To: <e8f499647614e592845dbdfa23d53e6c62434485.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Sat, 22 Nov 2025 15:32:14 +0800
X-Gm-Features: AWmQ_bkNPONPd_kSsuVdaor0fdaAKjYQnryRIU4YjsCBXSW81hWbrNJT7ir8X30
Message-ID: <CAErzpmvpyLE67gEyspuj33+FCczErZJVCZuy6BEZ6miurvL7cw@mail.gmail.com>
Subject: Re: [RFC PATCH v7 5/7] libbpf: Implement BTF type sorting validation
 for binary search optimization
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org, zhangxiaoqin@xiaomi.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 22, 2025 at 3:42=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2025-11-20 at 15:25 +0800, Donglin Peng wrote:
>
> [...]
>
> > Additionally, in the linear search branch, I saw there is a NULL check =
for
> > the name returned by btf__name_by_offset. This suggests that checking
> > name_off =3D=3D 0 alone may not be sufficient to identify an anonymous =
type,
> > which is why I used str_is_empty for a more robust check.
>
> btf_str_by_offset(btf, offset) returns NULL only when 'offset' is
> larger then 'btf->hdr.str_len'. However, function btf_check_meta()
> verifies that this shall not happen by invoking
> btf_name_offset_valid() check. The btf_check_meta() is invoked for all
> types by btf_check_all_metas() called from btf_parse_base(),
> btf_parse_module() and btf_parse_type_sec() -> btf_parse().
>
> So, it appears that kernel protects itself from invalid name_off
> values at BTF load time.

Right. The kernel guarantees that btf_str_by_offsetnever returns NULL,
and there is no NULL check performed on the name returned by
btf_find_by_name_kind. The NULL check is included in the libbpf version
of the function.

>
> [...]

