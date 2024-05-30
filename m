Return-Path: <bpf+bounces-30958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AFE8D52B8
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 21:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3861C22B55
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 19:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDEB142913;
	Thu, 30 May 2024 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTYxVaX7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0413433CA
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717099128; cv=none; b=Ey4OJzBvVAyhvi/CajtmlEJlLq5Jtu9X+54R1NG5my/0h4mVtCx8JBIzaTilpovOcKY4pUBwX/10Ym0yjiYYfxnciyKRXLBAOlUiakwAW8aI3rYPjuJttOEd0Rzx/hE91T8iPNKWW8vmYNpM2FZbOpM2iz0TKLT0HZOx2ygeggU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717099128; c=relaxed/simple;
	bh=5+IvnyaAbdXP3TBBlHMccwImhwCp6aWB4728tiag0ZM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iEwk20sH+oqATd4GF7kLJyQMuXzr7Lf1WeJgFQDez4QozW/07k6efwQDwHpR6d8h9OT7L0xyps2LH4q2q/zu6b9Wi2/CuC7tSUrA/O7ufmmCCKVw9ZlerJwWAEMhTA7rdLTJ9ba5yThMLQ8W1VY5cwgLSnHD7YpKyfRMcrshogU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTYxVaX7; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f693fb0ad4so1160491b3a.1
        for <bpf@vger.kernel.org>; Thu, 30 May 2024 12:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717099125; x=1717703925; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OeCQCzpI/kZr2DzYPw6aWxKXNMOsgm3t0ggHxlFkz60=;
        b=mTYxVaX73yKaZQ3GVvzYWPEzCCoM6aXGQHIM5E0GU8mrUGmNsrv4ZkBIZfdnjVedIM
         wYSw547wHWJcp8HK2Ypkaq6RXxxGFPLGUEjQswiMncnXQ/mKbQ3fTeol4GMmyRJZW7KQ
         +Jmq6whRA7M7PobZykdjgYIaVUiUKbaHW8EYBN8DLm3/8ssPcRTqQgnq+qOI+pt69tkL
         4ZT2NruPORCnw2XdUvp+E8xo4tgFrCiMoXvQEmopWGi3+bL4xZ4EUWqSRVcbebCqgTBD
         2fnm+lka6m73/3PkbOcpcBwJESSoo4Sxk18uTQlN+jy9MCYB1B88cBSiLgdhGPSVADr6
         Boyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717099125; x=1717703925;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OeCQCzpI/kZr2DzYPw6aWxKXNMOsgm3t0ggHxlFkz60=;
        b=BqB501O9R/i27ixc3FAHPWba+S1bms433OmrEjpiurLNtaOGRWD/Wo1+entrzmMcgo
         EgkdOUataajWK0eqznOvQ3xTlhh34BB67QTIA4DdHYHCSUAMJbs9Qg/QYRVX3zo9zUaw
         dPLAzSzbxZBOcC8bDFimAk/fAZMl5kwaODm7FS3sk2smLCsPDn7d7FFaN04W4ogUfcFE
         deSKB+hi8STSM+ZyBtJ5UgqDgXugK68RurWpe92ZQSZ/eqtpL5GOl1P9H0h0ooR6Dk4+
         655IVW9vVTAtVroRpCxssFUAR8vw9eSKN7bKijzWiBFe5Rdgrk+HkkTsCmvvAImfoU7a
         1lCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4EScAB7BYv6mjlsXyqw3Dp2vz/PMb0VL9KLiXr35anEhrw8LJMCOnPLr6M3rXCGCygdDJys8YIhpZmNmGun3yuGov
X-Gm-Message-State: AOJu0YzbbmYhylw4+XBsmsH7rkwuyKH7TPEkQgrH1e0kVzqhvcellb5s
	AR+LCD12+0WjG+FQdNNj6JwLrcDshr04VuNH+qQZrupFHUuRExZS
X-Google-Smtp-Source: AGHT+IGC5Y0+9gEl+5ZWZ6O4D/+txmj6JYzXT1QkNqrUPoVxuQ1bbHY7esrvJYga+cHMljzW6Oh1Fw==
X-Received: by 2002:a05:6a00:340a:b0:6f8:fe77:8a0a with SMTP id d2e1a72fcca58-702313cf863mr3525052b3a.32.1717099124958;
        Thu, 30 May 2024 12:58:44 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b055e7sm108773b3a.169.2024.05.30.12.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 12:58:44 -0700 (PDT)
Message-ID: <3a133769ef18b35aaae9c46647af866b38b3b2f9.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 1/9] libbpf: add btf__distill_base()
 creating split BTF with distilled base BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org,
 jolsa@kernel.org,  acme@redhat.com, quentin@isovalent.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev,  song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com,  kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, houtao1@huawei.com,  bpf@vger.kernel.org,
 masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Date: Thu, 30 May 2024 12:58:43 -0700
In-Reply-To: <20240528122408.3154936-2-alan.maguire@oracle.com>
References: <20240528122408.3154936-1-alan.maguire@oracle.com>
	 <20240528122408.3154936-2-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-28 at 13:24 +0100, Alan Maguire wrote:
> To support more robust split BTF, adding supplemental context for the
> base BTF type ids that split BTF refers to is required.  Without such
> references, a simple shuffling of base BTF type ids (without any other
> significant change) invalidates the split BTF.  Here the attempt is made
> to store additional context to make split BTF more robust.
>=20
> This context comes in the form of distilled base BTF providing minimal
> information (name and - in some cases - size) for base INTs, FLOATs,
> STRUCTs, UNIONs, ENUMs and ENUM64s along with modified split BTF that
> points at that base and contains any additional types needed (such as
> TYPEDEF, PTR and anonymous STRUCT/UNION declarations).  This
> information constitutes the minimal BTF representation needed to
> disambiguate or remove split BTF references to base BTF.  The rules
> are as follows:
>=20
> - INT, FLOAT, FWD are recorded in full.
> - if a named base BTF STRUCT or UNION is referred to from split BTF, it
>   will be encoded as a zero-member sized STRUCT/UNION (preserving
>   size for later relocation checks).  Only base BTF STRUCT/UNIONs
>   that are either embedded in split BTF STRUCT/UNIONs or that have
>   multiple STRUCT/UNION instances of the same name will _need_ size
>   checks at relocation time, but as it is possible a different set of
>   types will be duplicates in the later to-be-resolved base BTF,
>   we preserve size information for all named STRUCT/UNIONs.
> - if an ENUM[64] is named, a ENUM forward representation (an ENUM
>   with no values) of the same size is used.
> - in all other cases, the type is added to the new split BTF.
>=20
> Avoiding struct/union/enum/enum64 expansion is important to keep the
> distilled base BTF representation to a minimum size.
>=20
> When successful, new representations of the distilled base BTF and new
> split BTF that refers to it are returned.  Both need to be freed by the
> caller.
>=20
> So to take a simple example, with split BTF with a type referring
> to "struct sk_buff", we will generate distilled base BTF with a
> 0-member STRUCT sk_buff of the appropriate size, and the split BTF
> will refer to it instead.
>=20
> Tools like pahole can utilize such split BTF to populate the .BTF
> section (split BTF) and an additional .BTF.base section.  Then
> when the split BTF is loaded, the distilled base BTF can be used
> to relocate split BTF to reference the current (and possibly changed)
> base BTF.
>=20
> So for example if "struct sk_buff" was id 502 when the split BTF was
> originally generated,  we can use the distilled base BTF to see that
> id 502 refers to a "struct sk_buff" and replace instances of id 502
> with the current (relocated) base BTF sk_buff type id.
>=20
> Distilled base BTF is small; when building a kernel with all modules
> using distilled base BTF as a test, overall module size grew by only
> 5.3Mb total across ~2700 modules.
>=20
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

I think this looks good, don't see any logical inconsistencies.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

