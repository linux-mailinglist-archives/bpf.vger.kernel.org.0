Return-Path: <bpf+bounces-48263-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B29A0630D
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 18:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EBBE188A11C
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 17:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47671FFC4C;
	Wed,  8 Jan 2025 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIIXojU7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D2280604
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736356273; cv=none; b=VWYsElHfa/cduUkUZFAGaU15DPqS7PWOVeeu8fWdSIoqRA+JXx4OzEY8Uf7gu1fqcHzoAuykuAIUYuttDZGsL2saRQUjIp8dkS67jLiD0tyNIS1FI7PojpGnALEOWaMXjrt2ZVu4GhrVbEhkfaN6lduQ7qLIIWDwx/kRRFb32hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736356273; c=relaxed/simple;
	bh=IjTVuotLpAhPOs969LCdn7UdjBdZNsZ8WJYHSPLxPbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KryACyuHERdzCF83a3nNbiYokyWnM7quMR59N1ok5TjOZWZw7dLLpcA7xsdrTuLIvDKgFlSWKRgnmXJwdC31BDBprLHLcxQKX4/iBbHzLtLTn+nxsdlQnYC8hHrgSA6+dXW65TVbw4quoKSf2toZJodtavXEtuB+aAbhxlzkJ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIIXojU7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38a34e8410bso5563f8f.2
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 09:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736356269; x=1736961069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ik/Z9aKhADrM4ZGh9YBZXDJHFq5NsgUSxb6xBJTNXbs=;
        b=iIIXojU72IBxQYVzoDwMtUdOqe6Ovx7EzFLOC4DLRXqB3oM/Res5dITuHT+mDdvyh/
         OrEgSjSqRQHgxbeofNEXPgS8+cQ/1mbjSXCffEINt6Uhl/oweGovzf6c4+rf41CeHmL5
         noWE+dxLfTgIRgYZULjhZPEMxSDYLUVe3+jr3Vo5DfscWcyDokP/b2oaDXKSX4Zhbzoi
         +qvcPO84Le0ArqU5N73C078ogOeabq1h46ibM+c0VeHW7fvDKNHEd9AribU/oKhU4P3y
         qkIkIEIBakZtS7LhzqmjZeyBeGoGKjkUwLtB1IqfgnQEHBy9Yodlw8Y53DH4msYtcYf7
         nChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736356269; x=1736961069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ik/Z9aKhADrM4ZGh9YBZXDJHFq5NsgUSxb6xBJTNXbs=;
        b=tRsPuqHHpNaRG2FCOZPFM6j6wuLer+6zrF/3DkJpMwRpM9VHeAmK3RlbevRB7NDrfV
         YmBB1QrLjq7EKLZ0Wri8BePMOLn2i+hvqUf0tagQKXJFcan+FHnDpgr15d2Hnp2QElpS
         U9YEkE0au+RcEAjnnsrI/rwATDAjU+eI1QxiOQBNLXsOx2KRkuqKAXt3c45RwNTOAryh
         HzdTVpwhbM561npAd07WLSnnW+FkuFb4ZweXS/u/FyRoH6Aev5fW1yKsbFrpYJRmFyvB
         fi05BhhG58aWF1wGz9JsyRuWblJlr2Musshb6Oxg8IQX0ODRmfX9JaOPalsKYsipS3+W
         HaWg==
X-Gm-Message-State: AOJu0YzfJ03bc2axy6zuAeqvT5Ti60BU3BNAPjg4l0olNfgJS6rDn8bF
	pN74VGsztXflDLL5LRuFZA4QSABXF+FssAM6jezPT3k2G2sgh7ZkCfCJpCOykFFUXy6PwWKOiHV
	y2EnxAT1J50qYxmPh03Ib8+UR2FuI8KpR
X-Gm-Gg: ASbGnctc1FIvMJMvbm6EyifQWSZmO1GeJjTeIFp4ycjtRQwWHIjLYYuFDHSWnTLBkdr
	zaJE0+pOka/FWdIWWYrVtN/ojNGq20EiYYioUMFfe
X-Google-Smtp-Source: AGHT+IEBlglgTbNXcYzK4LIP+TDyx4LIskVN/VPjXwpd5MP0NZJUuthCpzqRRO9lteFRLWejFndk91U8O4vDatvVlhk=
X-Received: by 2002:a5d:47c5:0:b0:386:1cd3:8a09 with SMTP id
 ffacd0b85a97d-38a872d2addmr2832900f8f.1.1736356268889; Wed, 08 Jan 2025
 09:11:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87ikqpmf81.fsf@oracle.com>
In-Reply-To: <87ikqpmf81.fsf@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 8 Jan 2025 09:10:57 -0800
X-Gm-Features: AbW1kvb_5-HKF6U2-wlWkMt_YHDRJqqcrrlpWoAN8fxLNpk6ayR4l8Tm6CSCzk8
Message-ID: <CAADnVQJZTJSeZmCRhpNSpw1WPN4xgG8cuMcOr3_hYZ7=aQWfKQ@mail.gmail.com>
Subject: Re: Compiler support for BPF at LSFMMBPF 2025 - Is there interest?
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: bpf <bpf@vger.kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Elena Zannoni <elena.zannoni@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 8, 2025 at 8:44=E2=80=AFAM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> Hello people.
>
> The deadline is approaching and we were wondering, should we prepare a
> proposal for a discussion around BPF support in both GCC and clang for
> LSFMMBPF?  Like in previous years, we could do a recap of the on-going
> work and where we stand, and discuss and clarify particular issues.

Yeah. Don't delay. See:
https://lore.kernel.org/bpf/Z1wQcKKw14iei0Va@tiehlicka/
request attendance in gform and send email with [LSF/MM/BPF TOPIC] subject.

