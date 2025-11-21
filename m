Return-Path: <bpf+bounces-75251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2CDC7B921
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 20:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0F93A62D4
	for <lists+bpf@lfdr.de>; Fri, 21 Nov 2025 19:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B2330217E;
	Fri, 21 Nov 2025 19:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCp+E44j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E242E2FD7DE
	for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 19:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763754157; cv=none; b=bam2Lp0PUKyYPlUQg3OxT6Et5cWFBI7Iop/ZLr77l94CiByv/rtTKpsFRJtyk/5z6t3lK3I4Sdq68Ty9qTeD4rUSJv5xVdV0g/Y1qB03wIlOFB+VCCbUO7n2m2afBV9ooz+V6PNWKxPW9kPKtd5hdHq45o2yFik+VXW1A7Bwkuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763754157; c=relaxed/simple;
	bh=LCrB9EbsURiYuFrP7Iqz+2SjTbh7m0MdqxlcJqGHWcE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BXihmEO7THzhzs2udd9JVy2cmvbkMLZvVz3qZKKUYfJZUKBJyBIK4Wqu9cmo3iVHsIfgCDamOL9jzjC0RDieiMYTjB7GVG/UM/7zSl4P8kp0i//DDS3e+qcZsoqVYUJXxNpqfT3lwzNuXGuAVogSi7l64SdRg5tJOz9hDxlV4jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCp+E44j; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-295548467c7so27958255ad.2
        for <bpf@vger.kernel.org>; Fri, 21 Nov 2025 11:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763754155; x=1764358955; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LCrB9EbsURiYuFrP7Iqz+2SjTbh7m0MdqxlcJqGHWcE=;
        b=FCp+E44jWZuw2+j1sGH2mCRyv0H6iXdiGi3us90HdjnKz6svTs8AC1r7qlnfqpebSK
         6qQOmytdkqIWUz4j9aBDKBw+GGHYvs7vAz83kTbN3QoqqbEprdRuinnf/qE7ecQiIFTH
         a8hnRAGOv1JdPk8tjsZHFGz3U58TnXkXeOHuu37Kse63ATFce2ixhPnLHKACbmFW80xt
         87ONVkoUR3TOe/O0KDU8kg/IvWb6C+DQi/tfKvE/ZPDX5U399S4moH0dJxJOQ9GvWDlF
         gXwY2eXwxzHEC8CeAeCog0CECPTkh+CBPHhqc6nNFsFVbIzRUVOHPqTtGAhjDTWIjsaE
         MXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763754155; x=1764358955;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LCrB9EbsURiYuFrP7Iqz+2SjTbh7m0MdqxlcJqGHWcE=;
        b=Jp++es/3EyMSrNeb+XG75J0Nf/AwqHa8NCCY9mWLOiZj0W9YEKK8tg/VsaNccUD1Bj
         Bvoqlh296XSSFqls3tc39UnYvFy2FVlamwORuc/Ct3Y7kS2fafiJHYYHLOr8VygvnEjE
         Gf27WyOuYQa7kbLL3f+/dbqXjR/jKgign77CdcaS51tVCfE51+OzmVXtg/rGZ78FrFaZ
         E4H0Id8jk2LZTVuwkYOaOXak8w+M0uQAX3aCmwIxWAYWxCZlSBp1oMPQ0QOrsKtvPmH8
         zG5tMmqqs6WMJrgfLfVXa8XUmVZ3BxbEkA72Z3UP1Y6H6HIrq7i7Ag6B020dH2pS6CZk
         8jeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUt3pGsKYA7sDQnBaD6ohYzhlxGvUT21HYtBwIfHC+xppvERAGmNOeNNoj3/MvdbPgnMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS2b7R5ZmxtLXINefU9rWw+BTpIQnxSo/2uBblSQ+1tKRmNzJL
	coSRzvl3U2KwKZ3/iEuk4x7MkgPBTjkjYFCkcCaKcJUt0pLSBEeHhCxp
X-Gm-Gg: ASbGncvIMNBSmDQgcEMXwcL1TE4pH3DJJj+cmWCxFP5UPQ+t5hJOdHhC7Fr2sLgp4S3
	7ak1DdqITyZFpwiEIG88bdKAS18/e5M+vw3gCS9PF2+NPhalt6FKRUEUqzqHJz+yhgN7NLDihCb
	Y7wGJ36ODqeEdpITWO8pVHFAK6uT+8cCKHrphNrtdFfuz3UcJ/2rZnkIjiuoolrhCHPMxxJu47T
	JK1rjvMO1a/Hykeqfd39oGheaovv5mzj+g2RjEV2IkMvfVb65XJYQzUlobE+ZDaFp35SHjO4p0m
	9OzM12Mv4z3y2EqK0PtbI/QR3dV5MYakl/6OWTMPcXPpZZPh03W+ef4SlbqmhDVkpA7T4QwprN/
	Q2MB5QT0DHwnFx40GInGhbDxIel0uU6nKmieWydpN+1YdzmOXiS/5hORPEmsgumW/friURIhi4r
	RnsZiPoNiwghyQuOQjUw==
X-Google-Smtp-Source: AGHT+IGfulG3rJ7g745ww9DciWmUx3GXErP58V7EkhlpukfP7tMazv2crvCzOJejQHbFUbyl8ifbbw==
X-Received: by 2002:a17:903:2f8d:b0:298:29e0:5f32 with SMTP id d9443c01a7336-29b6bead4e2mr42949255ad.15.1763754155171;
        Fri, 21 Nov 2025 11:42:35 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2ac81bsm64978195ad.93.2025.11.21.11.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 11:42:34 -0800 (PST)
Message-ID: <e8f499647614e592845dbdfa23d53e6c62434485.camel@gmail.com>
Subject: Re: [RFC PATCH v7 5/7] libbpf: Implement BTF type sorting
 validation for binary search optimization
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire
	 <alan.maguire@oracle.com>, Song Liu <song@kernel.org>
Date: Fri, 21 Nov 2025 11:42:32 -0800
In-Reply-To: <CAErzpmvLhKbCYh3hYW=54JJtXj3TV0t2JAmGwy4E3xW7r84OBw@mail.gmail.com>
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
	 <20251119031531.1817099-6-dolinux.peng@gmail.com>
	 <CAEf4BzYQfHKHUdxv7W7mET1xBXuokvx9v=69HNAkhg_CAPCm-g@mail.gmail.com>
	 <CAErzpmvLhKbCYh3hYW=54JJtXj3TV0t2JAmGwy4E3xW7r84OBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-20 at 15:25 +0800, Donglin Peng wrote:

[...]

> Additionally, in the linear search branch, I saw there is a NULL check fo=
r
> the name returned by btf__name_by_offset. This suggests that checking
> name_off =3D=3D 0 alone may not be sufficient to identify an anonymous ty=
pe,
> which is why I used str_is_empty for a more robust check.

btf_str_by_offset(btf, offset) returns NULL only when 'offset' is
larger then 'btf->hdr.str_len'. However, function btf_check_meta()
verifies that this shall not happen by invoking
btf_name_offset_valid() check. The btf_check_meta() is invoked for all
types by btf_check_all_metas() called from btf_parse_base(),
btf_parse_module() and btf_parse_type_sec() -> btf_parse().

So, it appears that kernel protects itself from invalid name_off
values at BTF load time.

[...]

