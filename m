Return-Path: <bpf+bounces-71645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 433DBBF9277
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 00:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4770A507EFD
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 22:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271BF2BDC32;
	Tue, 21 Oct 2025 22:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnmLswCM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2830C2FB
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 22:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761086717; cv=none; b=vFT9Mg53OwTRcNSSCLfXm0UiehKjeIkcTOege5IiHEKiHsFdkPe5qc9oxM1nv0imTSdxyjrhJWQqcL3vGJ7P6h20BdWSgtcH8Wm381kRlc7MKKu1Oz+JU6MKW095QT1jLwsAz/EWjwt/cW2thW6ZnQysieRuvZHkWKwezeuJ8OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761086717; c=relaxed/simple;
	bh=xlpcDofI9+fgrMOOQEyGZ+PcOAXHhvbHK+VFZ2VIIEE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rCRhAJd6wRq5D7addOKoHlIjKGatDfwiyNjR64GI8LVuGRTkx9SVq8kLjwWfEJwQZpm2VyOlyDAAlY5ETJkvekWMHLh9rn+cvOvUdWJpak0pmkW7Z16FaCJbdTpUOK+fpeP9njqXc+9TUW5tnXTjMNjIPwbNoQjm6cFIRI+mCKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnmLswCM; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7a23208a0c2so2771860b3a.0
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 15:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761086715; x=1761691515; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6etc7IKFQtvmVVy1rBmzfQiuGSqTL1/HIh/vxZoHiK8=;
        b=hnmLswCMyPkwm7UWnbfzkYOSQYA9CVGxU8lnriwiQIYxtlgA4OOBLWnzEQHm7FacaW
         WtKBV8Jvmv+2XiguyXLhRTRxjZ7qZmcXs4tq29ElYgI1HibSgPybyYpMgrnHwuZvIHSL
         J2WWHrPYyvFCSXF5oHFlZfJXv6JjWUKb4GfpwoBNjLwq6cGipdPxFMopVqWe6oRj4hRb
         dvAdpkFjiHzQQtxEF2B0YcCOpBsV+4jYi8hFCean0UySf5rknyNh2xpZ+T3k8GREJiaz
         uZtkhvCa4SBxszIJmSDEn0qypmWmYrIzDbdHWpYko+gYdh1MbCcSnb7VKIcA2xGwP2xH
         loIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761086715; x=1761691515;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6etc7IKFQtvmVVy1rBmzfQiuGSqTL1/HIh/vxZoHiK8=;
        b=Pt0uJ5HUd7f9vh9SjNoiXBDfatcPx1N8OdAm1FIX58uhTrkeXliJB5RxfnT1w7/bQ0
         J6p4fhxhxSgDecegTmhymo41IjjmDTyyhaAIEALrxinZHN1YyqHfLzN9gcLmtSf4cjxm
         7tjLoPC1s7VaqoBxkI+T2LCSfpXxGhRZVTqmLeMRZSEX887hVAt8BBUEPr97wmZ93Tx3
         MG3PkgWcdPQrTUmMa2wVS8CH8xvBCYxqf5woKlmSjS0pyMgoc69sZqU/l0BNDVq/Bqly
         lDiBCzn88bnou7L0ROSkMbz0rzBEAbfA1biZBYN0Za0MXHQebYkbUU8rtUGWyto3qkI5
         daQA==
X-Forwarded-Encrypted: i=1; AJvYcCVqfOzhbzbuhD+sQN4UwrVAMMgXmmXS8S9XHwVWQXxDO0mrVUjMtR6lrxIMlsnSKugofKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2TFiPJYzMN83qkyNjzHx8z024eKIn5So+4FGIRPSX3VZlUBTO
	YPoA6PfXW6hPDUCEa1FoJCKmk96Ds8Czb749kVDEfsaaCMvODcu4DFs5
X-Gm-Gg: ASbGncuAxWb7aNjgNNOk6VnRmZfQR9GA3h9YkBBWo3LXj/7tVwJjz44/e1rveG0PjX0
	TlX8ddrjLNk3jVet8azN5pwcf1wXx2avwKKV/XGR6ofwbO6eKxAKrMSVnX2EU3bntUDCDAFRvgw
	YgTYkAmc3baZCM1kktTaYg2ywvdFm80dXnBnFydb3rqrklF3YjmraV9fEB1IQq9NVc9thC3hT3W
	8ilOh67jAUpvq44Y8sSUUj9fZ4km3rx3pSjRTGpsfJ/heMVv4ibjLLKRzYPDjD8iNXoL0CB8xSA
	nqyI+NFLD0tAa3Prk21z7H34AI5iY65/vJiTP8ymhGLJG2PsRYuQYGJCYVX45BfYS8CK9zKVYtb
	BRbTQuXruHIa5jquzzUucp2l64C04726UrMstgaXQUn3jGRM65E6L/i1kzpmjzGzOStMN0f0hVr
	hJvq6sQ2zbFu3YsdR3RJQ8zgfL
X-Google-Smtp-Source: AGHT+IFIUO7I4ZencHOZ/p+dwdIcN7anMQ2d3cmnUB/D8XACHuxdxaANusKyq09o2C/4tqAweEp/rA==
X-Received: by 2002:a17:90b:4c92:b0:32e:32f8:bf9f with SMTP id 98e67ed59e1d1-33bcf8f9960mr22261588a91.30.1761086715266;
        Tue, 21 Oct 2025 15:45:15 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:84fc:875:6946:cc56? ([2620:10d:c090:500::7:6bbb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223c7fb5sm628232a91.2.2025.10.21.15.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 15:45:14 -0700 (PDT)
Message-ID: <d162c8aee790c60a75f0e253a95346cf12b51d7e.camel@gmail.com>
Subject: Re: [PATCH v6 bpf-next 14/17] libbpf: support llvm-generated
 indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Tue, 21 Oct 2025 15:45:13 -0700
In-Reply-To: <10f8fe24770eb663ea849f133b4474d2cbd0b513.camel@gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
		 <20251019202145.3944697-15-a.s.protopopov@gmail.com>
	 <10f8fe24770eb663ea849f133b4474d2cbd0b513.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-10-21 at 15:18 -0700, Eduard Zingerman wrote:

[...]

> > +/*
> > + * In LLVM the .jumptables section contains jump tables entries relati=
ve to the
> > + * section start. The BPF kernel-side code expects jump table offsets =
relative
> > + * to the beginning of the program (passed in bpf(BPF_PROG_LOAD)). Thi=
s helper
> > + * computes a delta to be added when creating a map.
> > + */
> > +static int jt_adjust_off(struct bpf_program *prog, int insn_idx)
> > +{
> > +	int i;
> > +
> > +	for (i =3D prog->subprog_cnt - 1; i >=3D 0; i--) {
> > +		if (insn_idx >=3D prog->subprogs[i].sub_insn_off)
>=20
> Sorry, I'm still confused about what happens here.
> The `insn_idx` is comes from relocation, meaning that it is a value
> recorded relative to section start, right?  On the other hand,
> `.sub_insn_off` is an offset of a subprogram within a concatenated
> program, about to be loaded.  These values should not be compared
> directly.

I'm wrong on this account, append_subprog_relos() adjusts relo->insn_idx.
Still, please consider refactoring as below.

> I think, that my suggestion from v5 [1] should be easier to understand:
>=20
>    > Or rename this thing to find_subprog_idx(), pass relo object into
>    > create_jt_map(), call find_subprog_idx() there, and do the following=
:
>    >
>    >   xlated_off =3D jt[i] / sizeof(struct bpf_insn);
>    >   /* make xlated_off relative to subprogram start */
>    >   xlated_off -=3D prog->subprogs[subprog_idx].sec_insn_off;
>    >   /* make xlated_off relative to main subprogram start */
>    >   xlated_off +=3D prog->subprogs[subprog_idx].sub_insn_off;
>=20
> [1] https://lore.kernel.org/bpf/b5fd31c3e703c8c84c6710f5536510fbce04b36f.=
camel@gmail.com/

[...]

