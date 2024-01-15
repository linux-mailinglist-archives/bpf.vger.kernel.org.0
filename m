Return-Path: <bpf+bounces-19563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120AF82E337
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 00:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ECDF1C22270
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 23:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967881B7E2;
	Mon, 15 Jan 2024 23:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0DNwMNs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B601AADB
	for <bpf@vger.kernel.org>; Mon, 15 Jan 2024 23:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d5c1c1cf58so12450505ad.1
        for <bpf@vger.kernel.org>; Mon, 15 Jan 2024 15:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705360869; x=1705965669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+RpXudObUBdGh/+5FP8MAEZSlhz5UTeYcefOqi5t54=;
        b=F0DNwMNsT1FRB9thCnpFWCLw5QOZsYUTM9p1PD+aZ844GllteU3cNe2YitYcKxrVL3
         d2JRhi64Gwj6VAMmgZxStYjfvLRZ12a4ACPV28VEYLMHAr89+41D0geKFuWGJ4YHMGNF
         5+SCbEsRVTZ1N3Bp43rwOcHYm22ZSKd1+HSXErq0ElTItBA0ExUvD8Q/oY5ABe6IVw9g
         aKf2zkzLemTVTXvPkW6gCF9tX9xW/Z0LY5a+xdrfLBpG4upUmASWN8lnxfZkWO3fGrZs
         ekH1SLawlv8E24g/ZCYEDIiQIb5/gN/fATbGex3Ju3OrBG9d6+zPeGu5P8dvgc59VzuH
         vsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705360869; x=1705965669;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+RpXudObUBdGh/+5FP8MAEZSlhz5UTeYcefOqi5t54=;
        b=qyGcNQ/rTieBwQGyV58Xovga+pGRtBzuvoXRlKnUUkm9tcuXpiHf0/KeZB22WjF+Il
         rI4LM6JSRSWuT06DiRSqct4O+mu7Co8HXXQlaX0KQITpLOLgeAh3PZSW6wq31lloAEEo
         And4n9sX0ZCH+XRonhXecxVY5ntiF3QoQbFB7dy6XD0dIef4N/OcbSu2yndCUwxhrRnP
         kb4uNbIKRZ99BcCgJdR7hHQ3zx3/Fi0rTxD4px1qRW2ikB/VR7L2N5l/ycI5DLd8K1ph
         7pTL2/uO72QAMsqBVFecGyLI9EKiNUABK1myA6vO4HqDjdy/NKYQhrywGpcJdjsmBtEt
         2jGg==
X-Gm-Message-State: AOJu0YzMc/n1qwUPhrHm3gOZncx6+RoyetjE7N1RvAjCdwg2PEOvOtnx
	T+VfXELcqNJPTPBQXQThtnF34C9EO7w=
X-Google-Smtp-Source: AGHT+IF9j26UcwG1AAedbmp6oRH6fvd2TbhIvqhG7RrfjVoTt09YFtbWTpTgxx265j5gZqVrGiLszw==
X-Received: by 2002:a17:902:eb84:b0:1d4:ceab:58b9 with SMTP id q4-20020a170902eb8400b001d4ceab58b9mr8925721plg.40.1705360868747;
        Mon, 15 Jan 2024 15:21:08 -0800 (PST)
Received: from localhost ([98.97.116.126])
        by smtp.gmail.com with ESMTPSA id jz3-20020a170903430300b001d4b0ae7052sm8127013plb.135.2024.01.15.15.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 15:21:07 -0800 (PST)
Date: Mon, 15 Jan 2024 15:21:06 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Victor Stewart <v@nametag.social>, 
 bpf <bpf@vger.kernel.org>, 
 Vadim Fedorenko <vadfed@meta.com>
Message-ID: <65a5bde2c4e31_2eaef20845@john.notmuch>
In-Reply-To: <CAM1kxwi9FMUr3vOqZeRe3FjuvwQgdW-8g0HGLL5fU2tOOjRfYA@mail.gmail.com>
References: <CAM1kxwj533vwyxNvCPgXK2p=CxVszOm4T4g0YzaFhWPGATS0RA@mail.gmail.com>
 <CAM1kxwi9FMUr3vOqZeRe3FjuvwQgdW-8g0HGLL5fU2tOOjRfYA@mail.gmail.com>
Subject: Re: [RFC bpf-next] crypto for unsleepable progs + new persistent bpf
 map for kernel api structs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Victor Stewart wrote:
> On Sat, Jan 13, 2024 at 2:31=E2=80=AFPM Victor Stewart <v@nametag.socia=
l> wrote:
> >
> > i was just brainstorming at Vadim off mailing list about my desire to=
 do AES
> > decryption of QUIC connection IDs in an XDP program, RE his pending
> > bpf crypto api patch series:
> >
> > https://lore.kernel.org/bpf/20231202010604.1877561-1-vadfed@meta.com/=

> >
> > i'm hoping to gather some thoughts on the below two roadblocks:
> >
> >
> > (1) crypto for preemption disabled bpf programs
> >
> > as he mentioned in the comments of 1/3 and to me directly, a non slee=
pable
> > bpf program is not allowed to allocate a crypto context.
> >
> > is it possible for this restriction to be lifted?
> >
> > if not what safeguards would be required to lift it?
> >
> > worst case maybe an API could be added for userspace to initialize th=
e
> > context, as userspace must provide the key anyway.

I'm trying to understand why this is "worst case" to setup the context
from userspace? Perhaps naively I haven't tried to code this up, but
it seems like a sensible workflow to have userspace generate the key and
also setup the context. Then have fastpath (XDP) use the context for
decrypting?

Thanks,
John=

