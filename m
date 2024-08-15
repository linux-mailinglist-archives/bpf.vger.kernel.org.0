Return-Path: <bpf+bounces-37311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAB4953CEC
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 23:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A11CBB23385
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 21:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A743715383B;
	Thu, 15 Aug 2024 21:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ka/LTq+E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E3C24211
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 21:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758495; cv=none; b=dMsHwyoiHwuuK1UayKtQ6bT5tJpyfL3OVD0WHdyOKhh5c5HVgnkSeknj4FC5dp4kRQ+OOvedD9b2xWkpnrdkAPoVpIxqDbJgiuQ1sYqglYFST78gjOYGUaNH7iP4Ft6F9xw96a7kIwEFmuZ9wn/l/VhCCfNTrcU08GKLkhro360=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758495; c=relaxed/simple;
	bh=hNiuLXQb/UbbCGi6EcXhXUkJgmXViZWnLJbq+9yFbrU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W4u6ptM2NezKgHcrnwSvxohp+cI8mzu499exUN/FrDgbdPgIaEaTEsA4iI5VoPnNoYcTVzhM/MPFptIf+8ww1Q3DPrHASI6Tti6Cxlo6ZY/itQDWl+3xrM3h/cTgKdeYfxyiowYt8KJgx+WHCI1yko0cP39+NH2/HXMdZgGIt0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ka/LTq+E; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc60c3ead4so13272565ad.0
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 14:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723758493; x=1724363293; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oeRP4kMFbx48aXSJxksqINRA19aXuFq6SjyKahmMKFA=;
        b=ka/LTq+EgPMMlgKJgBUcvqW1nZFdh1x1ZW/r/zjagGKK/9u2fzgh1H2Wa/6ULiK9Og
         l8t2tyrzOf20aNwRMmfMaah77GrW2TWr77+9MRfTsAjxCOLN9aroZIonK9gcXp7TdpJD
         OXCwrlDvIRUYwAmtEKwBU/fshJO4GAeon0lbisuWdTqtnELgUXJOVv27Fzzw7JcQ17ob
         9yX6v06kcXsnPRDsz9o+2D8vHW4tdzkvG0gAVt86jYNNTsrLBPCmpY8Wxy+sPEjYFEn5
         Yueca32LSgQis7za3xbsXDZ4hWRs65w4Srt4VBfHqQZdDJVYz2pk23C6i9ZSHSH9AutV
         VSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758493; x=1724363293;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oeRP4kMFbx48aXSJxksqINRA19aXuFq6SjyKahmMKFA=;
        b=jeLm6coI9LXAt2g/SXZiGYsWAEEBunzspjYVSnGITNC5wxKp1PiY6lvM3Qrk76ZzKn
         7P16/4Rv0IVO3tdurReFtTaf8U3iN0uDffVJhImlEcw0/iGvX9LIWMX0RXkNsbr00SZP
         UnB2gfiBOzH1lR5DuOp1cfmXyyhvoUSbN3nLkqUtLNiF1E7+oGheIMwm2URj/EjoDFWf
         6Zii+9LXDpX8+S8M+Oy6Rtd8aIS3g6AuqDRHC+tj12itb9b2MUAAnmYea2eHTtYdm+k0
         NZEdY6pkg/8AFt9oVQe1Loe4Zs/SN9oXkfwhoxR7X1mdtxe9LE+tcHyPnMMzURMGhfpb
         vQ2Q==
X-Gm-Message-State: AOJu0Yzl10R/qySSmSBW03lpxqGmhGV94HA4/xLygTHNxogZEYRt3q+0
	HRCKx05kdGeuJ+OUSYb2v6a17uMsi/2RYfsJSUgWeNjg8dP1GMaK
X-Google-Smtp-Source: AGHT+IEihNynvMMLN1Ch0M2NUHtGsFL4jWyBkMqqNxmpcAc4Ay3fLTdN/XVzSDrmrfdQPx06+Xx+vw==
X-Received: by 2002:a17:903:247:b0:201:ed48:f11c with SMTP id d9443c01a7336-20203c08902mr14649195ad.0.1723758493200;
        Thu, 15 Aug 2024 14:48:13 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f037560bsm14461255ad.148.2024.08.15.14.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:48:12 -0700 (PDT)
Message-ID: <7c44d7feb531bf94a1fcf9175ecd2a2431650a3e.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/4] selftests/bpf: __jited_x86 test tag to
 check x86 assembly after jit
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  hffilwlqm@gmail.com
Date: Thu, 15 Aug 2024 14:48:08 -0700
In-Reply-To: <CAEf4BzbWE-Zijtfa-ePSdcaQqYboXfQ5CTLA25DbWGeq8Vq8DA@mail.gmail.com>
References: <20240809010518.1137758-1-eddyz87@gmail.com>
	 <20240809010518.1137758-4-eddyz87@gmail.com>
	 <CAEf4BzbWE-Zijtfa-ePSdcaQqYboXfQ5CTLA25DbWGeq8Vq8DA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-15 at 14:11 -0700, Andrii Nakryiko wrote:

[...]

> > @@ -817,6 +866,21 @@ void run_subtest(struct test_loader *tester,
> >                 validate_msgs(tester->log_buf, &subspec->expect_xlated,=
 emit_xlated);
> >         }
> >=20
> > +       if (arch > 0 && subspec->jited[arch].cnt) {
> > +               err =3D get_jited_program_text(bpf_program__fd(tprog),
> > +                                            tester->log_buf, tester->l=
og_buf_sz);
> > +               if (err =3D=3D -ENOTSUP) {
>=20
> nit: let's use EOPNOTSUPP, ENOTSUP is internal Linux error

Ok, will change.

[...]


