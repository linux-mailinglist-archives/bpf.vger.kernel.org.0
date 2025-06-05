Return-Path: <bpf+bounces-59767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20BDACF40B
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 18:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C81E1641A9
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 16:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824DC1F8744;
	Thu,  5 Jun 2025 16:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7U/R1xt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79942E659
	for <bpf@vger.kernel.org>; Thu,  5 Jun 2025 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749140467; cv=none; b=jYcNw6H45LevaGrRQzI/C52FDf8Wa0FtOFoAZ1lglL4cFCKfNp9zHj5dx/bQbN7tDf+b8JAvbVRkKweCM/739vOrC7scskGR4ebUHjWBy0tsNvWT5w/vIhQKd2q3K/ZI6Tr5LKWsKWeUZjYa9PgOsTrx8wRS+zTeOrc8/ygHiqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749140467; c=relaxed/simple;
	bh=EEyLrLtCqRdmsxSJM6Tlei6QpaQSPMBuN9En1+8w8oY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJwrS8P0YnCEaG71CiHTXEpbIJdz44ws85OOg2vYpubzYB2ilBRlRRflI8W0PVSE2oF1SlIn5sfkN+Y4hfpdFBzaKCRzXiJ54qFyNI1nOqGwJ4N3sTLfFDoHSP1EuAfl7GYcJsoMCuj3YbsUQGkYm5pxbC+j4YQQd6nsDQrELBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7U/R1xt; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso1149400b3a.2
        for <bpf@vger.kernel.org>; Thu, 05 Jun 2025 09:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749140465; x=1749745265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TE85CpPfaD/ai+p0mPc2ARQSVhH6T1Ybr0eLe83m/tw=;
        b=a7U/R1xtQhrz89iDpdMk9fDumDBhZrkcv3+qWCzgpv0qXHn/V8g+29SpM4rrVdP17r
         t+OMPeBjsnfxk/q0Im2yIEgS8Sr5BVMnDL5Xqz+MY78fCoOcJey+wmWCJjWegOhKskZs
         5LOWcG0AQKPcSoLqTC6SYuaG0EVJgyeRsClntQsgwQOexpz/k6oHwk6gGMbH33oC1yTM
         AZj2ozg7xzCT89pxczTafD6XlxfPHrT6QWH3KD2nUcFtITLzl6Hin7yUJPRot0B9xjTm
         yNhIKaLJIf1c4f9f6nzcerdtVP/Jrx0R2fTsVm8GzW8FEhlFxIloSC8vvHw9QYsO0M7v
         ZChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749140465; x=1749745265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TE85CpPfaD/ai+p0mPc2ARQSVhH6T1Ybr0eLe83m/tw=;
        b=lVRBkMUiyLyKmXPnchunoE4/K8mwFlyssZiQEMq6hwgwMlfqYna4at9wGJH9H3Gkxx
         3piRxHd3LiySLWgydBmSMj0DFadXruKJAPJgigYmConh/kb1AZI9J3YMBeJ9nvw7Kss6
         Sjb5Yn54D1QsGZ8MkoRE+EVXFEPHyvmrhliHuLpNtT5lLKPGwgJ4QrXQPBeC55vQLQQP
         xT56+eF+yrsv+Y4NgdynnXBQsX/rMkg+whos/z335Y/rUgPk3xZPV64Ercg1rmiLbWi4
         fHsITaHG0cbj/dLqGrOJCgRX60UlqxHLOJWcUV3dHGFWrv2XvL/Cc+Fr4iT9crDuGg78
         Yozw==
X-Forwarded-Encrypted: i=1; AJvYcCVnxjycBUE2asV597Vclf1cRj/1s0hdOKg0yl9Ow6+X9aPCD27SNLLsEpNGmyf9Kn1JfmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwtuu6Bba+Wnr2BcAzvrV5DlyFUvEGv/WKadqo+FsiFZwuet6X
	BmlufrYDjRxVpeasAC3hY2FCic624hGkyENzXSD70DdWIIOPdIU6+oxcIygWPE9JVUsIMCUVGph
	V6cywuZDqL3BQzHZtS3PIT/qdxcdR338=
X-Gm-Gg: ASbGncu59pm8XMXRs90Gl51aeKwueI63VllIvNgLaXotijggIOtymhvTATDclCfxjab
	JDMAt3XmMVMwrysgFOzyTCBxhmqbCPRtPGVZdLN6byDuXaRjy/IduvRBgmPM5GSP+Gwl1G6DDYi
	S/zdVQyQP/KvzS30gw/O5q+zdtoT30VSZoglmk9gZSyjd9WUVE
X-Google-Smtp-Source: AGHT+IGNKnsIQogsBSW99629qvRmbKcDSvGA45iRdUwLKCbAhdwAgq7FXxh3etdlZz/SG8920djQl8YnKpNaT7YkeVc=
X-Received: by 2002:a05:6a00:848:b0:73d:fa54:afb9 with SMTP id
 d2e1a72fcca58-74827e7f02emr462442b3a.7.1749140464671; Thu, 05 Jun 2025
 09:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604222729.3351946-1-isolodrai@meta.com> <20250604222729.3351946-2-isolodrai@meta.com>
In-Reply-To: <20250604222729.3351946-2-isolodrai@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Jun 2025 09:20:49 -0700
X-Gm-Features: AX0GCFs1QmYWap4uDv5S7vUGYoPw3YPVkc1Xqg551bMzL3JzZA0xmcGbHBmPknc
Message-ID: <CAEf4BzaQbk6AAn-swV+2B6gmquEcKnW7haxhiO9sUHC30YfcCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] selftests/bpf: add cmp_map_pointer_with_const
 test
To: ihor.solodrai@linux.dev
Cc: andrii@kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, 
	yonghong.song@linux.dev, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 3:28=E2=80=AFPM Ihor Solodrai <isolodrai@meta.com> w=
rote:
>
> Add a test for CONST_PTR_TO_MAP comparison with a non-0 constant. A
> BPF program with this code must not pass verification in unpriv.
>
> Signed-off-by: Ihor Solodrai <isolodrai@meta.com>
> ---
>  .../selftests/bpf/progs/verifier_unpriv.c       | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/=
testing/selftests/bpf/progs/verifier_unpriv.c
> index 28200f068ce5..c4a48b57e167 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
> @@ -634,6 +634,23 @@ l0_%=3D:     r0 =3D 0;                              =
           \
>         : __clobber_all);
>  }
>
> +SEC("socket")
> +__description("unpriv: cmp map pointer with const")
> +__success __failure_unpriv __msg_unpriv("R1 pointer comparison prohibite=
d")
> +__retval(0)
> +__naked void cmp_map_pointer_with_const(void)
> +{
> +       asm volatile ("                                 \
> +       r1 =3D 0;                                         \

Does this assignment serve any purpose?

> +       r1 =3D %[map_hash_8b] ll;                         \
> +       if r1 =3D=3D 0xdeadbeef goto l0_%=3D;         \
> +l0_%=3D: r0 =3D 0;                                         \
> +       exit;                                           \
> +"      :
> +       : __imm_addr(map_hash_8b)
> +       : __clobber_all);
> +}
> +
>  SEC("socket")
>  __description("unpriv: write into frame pointer")
>  __failure __msg("frame pointer is read only")
> --
> 2.47.1
>

