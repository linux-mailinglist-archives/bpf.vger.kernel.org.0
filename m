Return-Path: <bpf+bounces-19043-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E64582467D
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 17:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092802873C3
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 16:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC85250E9;
	Thu,  4 Jan 2024 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmJkiI8T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62312250F1
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-554909ac877so867901a12.1
        for <bpf@vger.kernel.org>; Thu, 04 Jan 2024 08:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704386484; x=1704991284; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MysOljXQ+Zu99srr/prMGAdnMMIsOYUysgnAHcGseJk=;
        b=KmJkiI8TyIAK2Y81QauSOfl9AJMba31eLyAR0iriOXY8Fpee9Kpl5nHzkDFvIbYOV2
         5xoUeqEwOcpoc24qTxy4+LNqXKVPqEF/SRW2ueV1yj+DRfW5QrjA0R/HYVzLxEJdfKZn
         wJgFM4JdtXzRMhn47UI5vts5z94q4AN0ExhtfpQhV+hhGJ/TbO/bDrn7vwc1dOo2xXmA
         529hx2ZFGz4/eA4NSr0P5rFk8Bz7YaFvjx+U6Fuai8apEDW48jQSwfm5ITpKpO+77sE6
         rYtdHRuixjrzeFgfrwYSKdumtbMKzEdMq2a8X3HsN65Eo6bd39r13H1IypmHqwf5q4T9
         X2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704386484; x=1704991284;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MysOljXQ+Zu99srr/prMGAdnMMIsOYUysgnAHcGseJk=;
        b=gRCpJJ2nXGzx3OzyjFtKBrlH76q3WExA0g4NLROLzBPtvB+rcOtDaLs+RTM9oyBUtv
         6wsw6dd1uAUeIEgI88qxoHGzDg+zET905uAL+hgCIVrHzxuWTH8ogF9sGxng7xEDCDOO
         nIMAeAlbocSMH/1FKqRNKmSWuIV/Eb+10VpqlI/I3uqxAU/RkE3hNuM4JCYTDwEbAGyI
         M7c1djs0e0PmWN0PB/k8E6ui8I1qEA/Ra6ydB2t4jUJNRlQ4rEayOm03tQE113yaC04P
         kn+wbNXjAAv2Dm//SQexEDxOqh9yWJA38Ag8mOxmWq/YJdodho4iKl4osqzHhmL/EKxx
         czBQ==
X-Gm-Message-State: AOJu0Yy8awNjkoJTvEEHWaPkeQ6CkOBcwusbLnU6ToRgGWbj0svOaaVN
	4iPIqfGSSIlhjsGcpfHWLbNIfS8S7hAJDA==
X-Google-Smtp-Source: AGHT+IGQcKRFJ7+QBHqwbOOjx/ik70M2/Jc6Y40qBVJYFNV7wrs5OOCQ6qatZStM30vmXFBfcpxalQ==
X-Received: by 2002:aa7:c88f:0:b0:554:4dce:4c4d with SMTP id p15-20020aa7c88f000000b005544dce4c4dmr548025eds.75.1704386484424;
        Thu, 04 Jan 2024 08:41:24 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ca26-20020aa7cd7a000000b005528a899fccsm19137848edb.37.2024.01.04.08.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 08:41:23 -0800 (PST)
Message-ID: <4c58fcfed2258f92148dc616e41751ff2276bab4.camel@gmail.com>
Subject: Re: Funky verifier packet range error (> check works, != does not).
From: Eduard Zingerman <eddyz87@gmail.com>
To: Maciej =?UTF-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>
Cc: BPF Mailing List <bpf@vger.kernel.org>, Alexei Starovoitov
 <ast@kernel.org>
Date: Thu, 04 Jan 2024 18:41:22 +0200
In-Reply-To: <4e28b260c469164846abc26c1487f565fea98f67.camel@gmail.com>
References: 
	<CAHo-Oow5V2u4ZYvzuR8NmJmFDPNYp0pQDJX66rZqUjFHvhx82A@mail.gmail.com>
	 <1b75e54f235a7cb510768ca8142f15171024dd78.camel@gmail.com>
	 <CAHo-OowjLmtEPmoo2rQ3i4_3mO0Uy6Sr9+pdcv2qCbahdVVgxg@mail.gmail.com>
	 <85731a963139eb226b76069a5422ecbac063dd74.camel@gmail.com>
	 <CAHo-OoxanNo=0ppvq940KaUZBMBWjLyMgWCXCMfmyhMR6pmC2g@mail.gmail.com>
	 <4e28b260c469164846abc26c1487f565fea98f67.camel@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-03 at 01:13 +0200, Eduard Zingerman wrote:
> On Tue, 2024-01-02 at 12:36 -0800, Maciej =C5=BBenczykowski wrote:
[...]
> Suppose Andrii accepts this change, would you want to submit the patch?
> (or I can wrap-up what I have).

Hi Maciej,

If you don't mind I'll wrap up and submit my local changes today.

Thanks,
Eduard


