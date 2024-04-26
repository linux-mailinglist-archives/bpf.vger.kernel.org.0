Return-Path: <bpf+bounces-27983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E05498B40F9
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 22:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761401F225A1
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 20:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF682C1B6;
	Fri, 26 Apr 2024 20:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVxyecyH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587E62C69A
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714164906; cv=none; b=jomxGUoVMgtz+GUamsIppK+i2fiSTjuG0/IRCJN/i2xBTNMXUoQw7LkcPOiF+1ZuyncdcoLUDYo7DP8CXyklcdQCfGFSJwieFfL1MJmBQjc3ylALklVV84AHsidIatXgr6nTvVjOQPyMS0uYOekS4F5Wu1HjIEh3Hgcnb3vioZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714164906; c=relaxed/simple;
	bh=KQL0mV0zP3eEpYxBudFXfFKQiXarTgXIB2rtQcbkd4A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D+0TZb4HBGxL9FBJceuY6JhdYFqM1xmECtNlQg9eWTknybrwOqPbA0YliEHA8JxIEGU98xsRYsmFq9TIq2TZb4L3SsW53lhdDAey9faox/xpa213lc/8GvCEJCfRcV6JqjpV7BYq6ETl/21Fw3FJ1OmlFfzawJZ3RWDeCFIdh10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVxyecyH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e8f68f8e0dso19264695ad.3
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 13:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714164904; x=1714769704; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=12hPOok5gkjYUsgN5cCk+ZH7pPTkBxMm4OONJlSA0/A=;
        b=TVxyecyHVFQQGxYRaUoxVMy7Lk3Ee3FgRQlsORO7Th3DkTDvlt/B6e+CxJCCWEBCN/
         gBTYDR23Hf/vyz/tc+YXkDq38zNKxZVf8XrhhDX6vbg23yiPt88HdYtEaAQUyx96YAKm
         44WI2v7pePCkI3l7kL6O2daKkiag+FwOM5bfOFWN9nWdu5+vSSfwZ4Hf6d8O2oJWl4js
         62Oi25I6q+TibYUAlHlnWpCKYUX49C+5z8PpDYmz4HHcijSFoUIS0mmnEsEkpbhbGb/W
         XFTGRMUG1XQbIX2YqiGZsTpnNrrN05twkaBcmzXqcIDXNpRbc0sc0hRQlk7r22tiJMyc
         mEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714164904; x=1714769704;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=12hPOok5gkjYUsgN5cCk+ZH7pPTkBxMm4OONJlSA0/A=;
        b=Y4GIM/+60mrKiTEnZV2iwgSm526IRPPAJbgorAtxWk813/3uL6dvdxzAvlqNCwf05L
         21BLDvFKyJ2BkVfaAtmwYHCBNQCCnbgZESnkOin60lBkNObbhggFRyN1zW2VXUfE81Ke
         0JdAyWCayN4AX9zAVC/j90f1zNnwaa+mvaX+D8b1GNaxKhvuPwhEn1bUobpOECpvRLpv
         cmIohK9DSQkaeJYNQesA2s9SulWyYsLtuFMn0cbArHmHrHE7W5FZUlITAHB5/ZAa23zt
         WiUZamiPptTpDEHU4bUWwzfEJcN0XbpryWanceeo+FyA2uD7x6888PO7ALEBzhRK7Dt8
         jV0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrjp72AILfHehTlxM9yn3QNaGa20iAdKqnE5cnYr/SiabKRJ000vdXt4o0/dHHtp/jtNRE2sHxwRoV8VHxsbkWGzOR
X-Gm-Message-State: AOJu0YyYh95a49TjsQm9Q/S1XPkgIRC+SKPkjlQVKaHg3nqX2yiy8oS7
	QCkcBMg4Wjui+2nPX9igIqasaxirGm8syw79ETaVP5ZCxfObB2g4
X-Google-Smtp-Source: AGHT+IH9Y+Y5L2aFNpT6D3NEnKaHP7SE2yi7ZqWcTmWbeEHkgbNo+fqljTHQ93QtbsxOspSmb1f+3A==
X-Received: by 2002:a17:903:187:b0:1e5:a3b2:4ba3 with SMTP id z7-20020a170903018700b001e5a3b24ba3mr785343plg.56.1714164904534;
        Fri, 26 Apr 2024 13:55:04 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:89b8:4c93:e351:1831? ([2604:3d08:9880:5900:89b8:4c93:e351:1831])
        by smtp.gmail.com with ESMTPSA id q4-20020a17090311c400b001eab3ba79f2sm3556983plh.35.2024.04.26.13.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 13:55:04 -0700 (PDT)
Message-ID: <89ea76fb441617adff7913e150047a1b0a181123.camel@gmail.com>
Subject: Re: [PATCH dwarves v8 3/3] pahole: Inject kfunc decl tags into BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, acme@kernel.org, jolsa@kernel.org, 
	quentin@isovalent.com, alan.maguire@oracle.com
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	bpf@vger.kernel.org
Date: Fri, 26 Apr 2024 13:55:03 -0700
In-Reply-To: <c046da5cec91dec15958c894d9a9cb7d7091659c.camel@gmail.com>
References: <cover.1714091281.git.dxu@dxuuu.xyz>
	 <1f82795e9ae651a3d303d498e2ce71540170b781.1714091281.git.dxu@dxuuu.xyz>
	 <c046da5cec91dec15958c894d9a9cb7d7091659c.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-26 at 12:47 -0700, Eduard Zingerman wrote:
> On Thu, 2024-04-25 at 18:28 -0600, Daniel Xu wrote:
> > This commit teaches pahole to parse symbols in .BTF_ids section in
> > vmlinux and discover exported kfuncs. Pahole then takes the list of
> > kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> >=20
> > Example of encoding:
> >=20
> >         $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kf=
unc'" | wc -l
> >         121
> >=20
> >         $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
> >         [56337] FUNC 'bpf_ct_change_timeout' type_id=3D56336 linkage=3D=
static
> >         [127861] DECL_TAG 'bpf_kfunc' type_id=3D56337 component_idx=3D-=
1
> >=20
> > This enables downstream users and tools to dynamically discover which
> > kfuncs are available on a system by parsing vmlinux or module BTF, both
> > available in /sys/kernel/btf.
> >=20
> > This feature is enabled with --btf_features=3Ddecl_tag,decl_tag_kfuncs.
>=20
> I tried to double-check results produced by this patch and found that
> decl_tag for one kfunc is missing, namely, the following function:
>=20
> [66020] FUNC 'update_socket_protocol' type_id=3D66018 linkage=3Dstatic
>=20
> And it is present in symbols table (15 is a number of the .BTF_ids sectio=
n):
>=20
> 60433: ffffffff8293a7fc     4 OBJECT  LOCAL  DEFAULT   15 __BTF_ID__func_=
_update_socket_protocol__78624
>=20
> Interestingly, this is the last symbol printed for the section.
> I'll try to debug this issue.

Nevermind, the 'update_socket_protocol' is not a kfunc, just a member of se=
t8.
Sorry for the noise.

