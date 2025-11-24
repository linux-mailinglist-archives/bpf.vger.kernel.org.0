Return-Path: <bpf+bounces-75387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E222C82134
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 19:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C95054E81B3
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 18:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD672BD5BB;
	Mon, 24 Nov 2025 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BH2WPuCg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3DC2BEC3A
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 18:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008459; cv=none; b=hBTmeNBUgObJpq3DYBvNrq2w509Vs34hF6PbwOaruC2PF4fnqCdalWNuVXmMAXnBGfqBwzOnhlwh0CTHh0EBkLdGe4tnaT4Q99Ab6VXfkJAqBvlFk06vwk84k15oVrd4UgmkxLNUaaKFHwqwPgakcVuoKyqrMBLiWtMIVgznNtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008459; c=relaxed/simple;
	bh=+5iwxSreQgRstxSDRCU49Cj3ggfhYtgM7epwZyIFgC4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bBsSaZbLLCTS+sbycP38Z2GVFUKJSWyPqYyUgEZIxbRfmIms7N9QHd0/WZOWr6/Bl23GL0oZoyiwUfpagjhfRi+0wY6mXaO2Wf/hNpGlF+/tFm3YIlYeUdv7sEPTFfmGjoJmhi7+N8yXCGZW6gYi22iRzx3qXxLC4zsxjanphVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BH2WPuCg; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3436d6bdce8so5520461a91.3
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 10:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764008458; x=1764613258; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+5iwxSreQgRstxSDRCU49Cj3ggfhYtgM7epwZyIFgC4=;
        b=BH2WPuCgpKH/GTKaQioRm+zXIPoH5vWdOFKNA430wxDWpRZBoq021u9UJvBqGox83J
         +U7wGvhXlqZ3Rjfjz5PQybXxd9DGvg5TEnQprRnYr+2RDGa0ZlZ6l9CuOvVlxmwPWM4F
         8G/k3SszCZ5axqwy4D+QHIfLiN+JiWlYiut0X49xm5lfEPGHnirSXum6iJMcd2K1p4n+
         dasr2MDf88A8wx091GPu8LmM59cO4e5gOySsVkiNX/GFF2BxmKYZQVXveoYFaoAJVpWV
         lN+6Xo1zRTJv+gVtTPGKXCiRbCIpzWMQ7kiX5sVveVSWSRYD5zcVtTS8YeZ2gQueOrdi
         u9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764008458; x=1764613258;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5iwxSreQgRstxSDRCU49Cj3ggfhYtgM7epwZyIFgC4=;
        b=ORMblNyC0MfG8SEPxgu4u9IWdLVoj00VF+q2CdNoBTxSrxgKU/ybrPVvgj2VdQxtog
         cL3AIglZfw3A2RHf/FhkAb+eXLiqSIYknG/Px+NnujZfDvhkUC4MRZmN/1syBPXAvcNL
         YQfpgXEMHWvWz1bZPjkAUgZnCDKlj9ADwFQQdhF53ZIS5wSw3nCdWHthN4ZNK4BUBLlF
         W+nMD3ddvdB3WD0A8zQHt54lrzepJvGtwMdntdzGT87vsWqfVlnwL5FwUi+OyeVbReWL
         3HFL3FOHltrS4HfOiMf7KzPivMjX7gOTAcV5A+rqBD+FL1uKP1iqNbsg1snkbhyXgW+p
         FGAg==
X-Forwarded-Encrypted: i=1; AJvYcCW/OlVlQYdF4pN+B+WgnwaTZigUQunhLK0Np0RXEvABxVt1j0S7MTpUzmqbEDp0546BX5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8TxZmkMt160WBt+wm3OAK2JPwL1e+WOAKJQtmEZf2aSJitn+z
	Vp/TVfVzJgmlGhnDHky6UkpAW+7rS6J6y40+uS7wElBJPIQ9+BMN+Jvr
X-Gm-Gg: ASbGncunzQgNASl03xSCYXjU4CnLO4cFwV4tXezTb8L7+0S1dr4UFBHCiQOXXPpEEZZ
	bwpn05gdjRKpBdWy5NejELi/FfafeyEmSpV/G7D3On+E0xmGypYcsgTtPXCEMx47EN2UriZIz6P
	6619cOZWUrbKvapyi/TGuWIxylKezUvMeOurGb0ji4/4zGOqz1Yc8qFfr4XOz1bVFwr8ebVEqwk
	wvS1Ho+n6PVRq0/sr00Ctx2BhRQ9OT1zxsIRgfAq5e/eO1eob3Ji97q+Rr4hndkGUyF9RGn4ZIE
	ZyO2okbN+QfZN9XxHr7EYX8PAGReBHpozx9nR9AUVz2RwVEYEtSJDxmxyEqz6RjIv6fEoIoywX3
	TgHlDO5ImmoW74K/SvabMJ0FkzgXYNSZTbn8uL6rx15jYn5gHblwsd5erSVM5wC1d1CSgjNsHj9
	ENm5TzAX1IBvIQb0/VEMc4vh4bgDwEOvSI3PYa
X-Google-Smtp-Source: AGHT+IHlM6uesN3I/HmLtec8vVg0Sswa2TrxGw2lJaByrmzN/YRE36Vv/lc/slcB+5V/N85kxzptxw==
X-Received: by 2002:a17:90a:da84:b0:33b:8ac4:1ac4 with SMTP id 98e67ed59e1d1-34733f4f7edmr13338802a91.35.1764008457701;
        Mon, 24 Nov 2025 10:20:57 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:e360:3d88:84bf:d2b9? ([2620:10d:c090:500::6:a7ca])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34727be33dbsm14019503a91.8.2025.11.24.10.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 10:20:57 -0800 (PST)
Message-ID: <c29c91ad68f01b8bee8fff36b511d4dbdca1549d.camel@gmail.com>
Subject: Re: [RFC PATCH v7 5/7] libbpf: Implement BTF type sorting
 validation for binary search optimization
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org, 
	zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
  Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire
 <alan.maguire@oracle.com>, Song Liu <song@kernel.org>
Date: Mon, 24 Nov 2025 10:20:55 -0800
In-Reply-To: <CAErzpmsCDmGvne4+TCbm09RNhfcUYVdsk_X7uoS_tSDKG=0Kqg@mail.gmail.com>
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
	 <20251119031531.1817099-6-dolinux.peng@gmail.com>
	 <CAEf4BzYQfHKHUdxv7W7mET1xBXuokvx9v=69HNAkhg_CAPCm-g@mail.gmail.com>
	 <CAErzpmvLhKbCYh3hYW=54JJtXj3TV0t2JAmGwy4E3xW7r84OBw@mail.gmail.com>
	 <e8f499647614e592845dbdfa23d53e6c62434485.camel@gmail.com>
	 <CAErzpmvpyLE67gEyspuj33+FCczErZJVCZuy6BEZ6miurvL7cw@mail.gmail.com>
	 <CAErzpmsCDmGvne4+TCbm09RNhfcUYVdsk_X7uoS_tSDKG=0Kqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-11-22 at 16:38 +0800, Donglin Peng wrote:
> On Sat, Nov 22, 2025 at 3:32=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >=20
> > On Sat, Nov 22, 2025 at 3:42=E2=80=AFAM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >=20
> > > On Thu, 2025-11-20 at 15:25 +0800, Donglin Peng wrote:
> > >=20
> > > [...]
> > >=20
> > > > Additionally, in the linear search branch, I saw there is a NULL ch=
eck for
> > > > the name returned by btf__name_by_offset. This suggests that checki=
ng
> > > > name_off =3D=3D 0 alone may not be sufficient to identify an anonym=
ous type,
> > > > which is why I used str_is_empty for a more robust check.
> > >=20
> > > btf_str_by_offset(btf, offset) returns NULL only when 'offset' is
> > > larger then 'btf->hdr.str_len'. However, function btf_check_meta()
> > > verifies that this shall not happen by invoking
> > > btf_name_offset_valid() check. The btf_check_meta() is invoked for al=
l
> > > types by btf_check_all_metas() called from btf_parse_base(),
> > > btf_parse_module() and btf_parse_type_sec() -> btf_parse().
> > >=20
> > > So, it appears that kernel protects itself from invalid name_off
> > > values at BTF load time.
> >=20
> > Right. The kernel guarantees that btf_str_by_offsetnever returns NULL,
> > and there is no NULL check performed on the name returned by
> > btf_find_by_name_kind. The NULL check is included in the libbpf version
> > of the function.
>=20
> Sorry =E2=80=94 my mistake. There=E2=80=99s no NULL check on the name fro=
m
> btf_str_by_offset in the kernel=E2=80=99s btf_find_by_name_kind. The
> libbpf version has it.

tools/lib/bpf/btf.c:btf_sanity_check() is called from btf_new(),
it calls btf_validate_type(), which does btf_validate_str().
So, ignoring the NULL case on libbpf side should be safe as well.

[...]

