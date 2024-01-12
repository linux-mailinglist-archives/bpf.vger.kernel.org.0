Return-Path: <bpf+bounces-19397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB8E82B964
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 03:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AD33286532
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 02:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF521379;
	Fri, 12 Jan 2024 02:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ew5w1X/5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08913110D
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 02:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-336c8ab0b20so5126030f8f.1
        for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 18:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705025801; x=1705630601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ys9RPjCf3gdmhWJyqgNQHVJIvjdd1ltt2tjom1v4dKc=;
        b=ew5w1X/5LFQRynskOB9457fYM89GtCCaSU5vu99pQwuzXo1J93neMbVi4ZxmA3m1+p
         0u0diun8DbDXn8M4C9DJpojHP6g6GwKdEoJ/PH8cF2fZ/pt1/+eHvH/2v4YoN608QySG
         Ju2gl2l1ri91hzrUsaWEQy5X5NM9x8yt3Oe9hK2+7l5R/Od6bTLslApZtXuZSu6sOfQM
         SlRwkje1/cPDtTFMQCl2PHos3ahFB4dB9XI7T3Xpim4lthHS3gYspYX2uHmUMv/iJ10x
         WeFzcywxQc72t8H1PZmts91xXvCMkvijP7v/Vhc3cN0EY7SZdd6UPq0yMpnLqtKn6stY
         vIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705025801; x=1705630601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ys9RPjCf3gdmhWJyqgNQHVJIvjdd1ltt2tjom1v4dKc=;
        b=oZlNscej2qBFwm2VY7xia0bP6j7PA5Tm3ejeVjYFlavgrszKXYBUiamk0xHFMAa8fa
         QveUH8Tyup1rtClBpO43nlOFCrfcIUAlVP6fcPo/Ne1UhZ43e5jkPR8ltsgtcWsJSbok
         RoxGOiQIwHQssfoHgYOTRvOLf1pJLiAFCjdQRDslRruUN1etAmqV+x3m7RAYYJu+rYwP
         jmophhf0tVwJDOVo5SfeG+NPIvcEAb8sBEaUtLcmgvpH/yFazqKQH+iXZ8tuDaX7Xb5J
         /lKocOjEtI1Gfw5atx9GtkAmhX9HOUTGyn8rg8EM34JIM/otfmvVEFQj8ZNApA+sBkJF
         +VFQ==
X-Gm-Message-State: AOJu0YwKJWUT8rs4/P0pbkVvEtJYgjRLEOKfSyj+P+PBAOxtLbDtQW9C
	ocwGhOGOq4YWkyDp4MgycMrZ5meoYzlqQ/gfA2Q=
X-Google-Smtp-Source: AGHT+IEgAbU7X912UlpZ4UzZfO7DDFi1TSl+tg+/fc8CM2epvcnYftEWrhRfrH1KkiQXou+GQIMX5ugkgFc71atSNO4=
X-Received: by 2002:a05:6000:1145:b0:336:7051:8400 with SMTP id
 d5-20020a056000114500b0033670518400mr287062wrx.23.1705025801099; Thu, 11 Jan
 2024 18:16:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TYZPR03MB679243A8E626CC796CB7BDBDB461A@TYZPR03MB6792.apcprd03.prod.outlook.com>
 <CAKOkDnNAQSrWxsJBrcLV7ReaQkX_BHX+EAn69e0cpe9b=FAsUg@mail.gmail.com>
 <CAKOkDnPnNE=MNP-1_8=T9vw6Ox80OAJmKonzpDO4abW8Dz9JwA@mail.gmail.com>
 <SEZPR03MB67865F9167DABCA16AA6811BB4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
 <CAADnVQJCxFt2R=fbqx1T_03UioAsBO4UXYGh58kJaYHDpMHyxw@mail.gmail.com>
 <CAKOkDnPZ5SKYOQhE646Se5oYCi7Rc3ubUTnrE+-aXiViTsA1jQ@mail.gmail.com> <SEZPR03MB6786BF42E7105E8B55C5788DB4662@SEZPR03MB6786.apcprd03.prod.outlook.com>
In-Reply-To: <SEZPR03MB6786BF42E7105E8B55C5788DB4662@SEZPR03MB6786.apcprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 11 Jan 2024 18:16:30 -0800
Message-ID: <CAADnVQJXtxV7VcfMCcmwVkjo8ZDeZhj+bF0YOjxwP8aVV_dZCQ@mail.gmail.com>
Subject: Re: [External] Fwd: BPF-NX+CFI is a good upstreaming candidate
To: Maxwell Bland <mbland@motorola.com>
Cc: "Jin, Di" <di_jin@brown.edu>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"v.atlidakis@gmail.com" <v.atlidakis@gmail.com>, "vpk@cs.brown.edu" <vpk@cs.brown.edu>, 
	Andrew Wheeler <awheeler@motorola.com>, =?UTF-8?B?U2FtbXkgQlMyIFF1ZSB8IOmYmeaWjOeUnw==?= <quebs2@motorola.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 8:58=E2=80=AFAM Maxwell Bland <mbland@motorola.com> =
wrote:
>
>
> With the inclusion of Peter's CFI patches and the adaption of these to AR=
M, there's already strong progress towards security for BPF's JIT. If the m=
ixing executable code with data issue gets fixed too, then it will soon bec=
ome possible to treat BPF JIT programs like any other part of the .text sec=
tion, which seems like a huge win, since BPF then gets all or many of the f=
ruits of standard .text section security.


FYI kCFI + BPF fixes for x86 have landed in Linus's tree today.
Somebody needs to do the work for arm64 JIT.
Since bpf core pieces are ready it will be a bit easier.

