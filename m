Return-Path: <bpf+bounces-18326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBBD818F98
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 19:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5939228496A
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 18:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C1E37D10;
	Tue, 19 Dec 2023 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LTYhrY/x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8368B40BE7
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7b35d476d61so203541039f.0
        for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 10:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1703009714; x=1703614514; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vnnNBxYCIBTHcSzoKvUPCssZazPeCD1gELqmymS6yrU=;
        b=LTYhrY/xblDSkd+iJyBGmgnxHMDK4rvy4nhIqxzkZ4EwiFPNHln2ZnT/JkBlGPx2uC
         isaHRkhfW8myXLWRLvX9sxxltiM9GuwYSv9VlPPQe2M2Jnq/MKFIJ/CnjJN3Gn8MqrMl
         CFOoe0/mm3TAlH9i1ZKhvqOoY8IIn2X2n+byCTt5f2xy0e/gBjBq3cxn6tB/VrzsMIWX
         luF0sqh02Yr8cdkgXhG+gWvv12RxULWmHvCqOhTPu2qH8ivu98SCAlp151yi6OwOgqZE
         zPvhE0r1FnLILDXBHRjnCQtRlfMXysu4fCUZ6FAQ7RGjmuj4Z50sgHlrbqipUdDmxf1m
         OUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703009714; x=1703614514;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnnNBxYCIBTHcSzoKvUPCssZazPeCD1gELqmymS6yrU=;
        b=cPIkxsUoBTqnMFEq5dPKiptbHALzszEdr+q+SJ/jJ/vzzTMq5YHw+6HkC6sthYV+76
         dPNE+FCKB7txaKnWIXL9O9yiJeyrDk0qRqnGvbgSt7Jp9iTgXLxj4N0aiEo1KGPM5NTn
         VXCjRdV0T4TckWgpPrxf2INhnZMJPzR/CMUB+cwE6Avo/m/qvO9iyjHo2kDaVS6uc1o1
         pE+FrKfbzHM7IWpiRvjrMooVbCKU+yUYYwnnXbl64AMkIyXMufaj3DdgwBaD/QITNm+D
         VLVaqGRzNRoM4Mc7EHjBe0Txw/m9thZ5ZISnZJvv2sMOrtSfgGWlRTa8lT97SWzBrRXy
         b/lw==
X-Gm-Message-State: AOJu0YxSbUuQ+QpRaiAPnkvuCPZNM3awyz/S2eu3Xqkk3hn0ibbbdv+0
	NXSx9serURefO0ustGXkMms=
X-Google-Smtp-Source: AGHT+IGhiXMDScIoM2tRIe5Ld5PHlfr6SGhdohM4dO1GheQNnylpt5cFGRdPHkCjPfMLlPEAV6AqSA==
X-Received: by 2002:a05:6602:2f10:b0:7b4:3be1:91ac with SMTP id q16-20020a0566022f1000b007b43be191acmr24938798iow.22.1703009714504;
        Tue, 19 Dec 2023 10:15:14 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id k7-20020a02a707000000b00466ddd26820sm6271293jam.163.2023.12.19.10.15.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Dec 2023 10:15:14 -0800 (PST)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'Alexei Starovoitov'" <alexei.starovoitov@gmail.com>,
	"'David Vernet'" <void@manifault.com>
Cc: "'Dave Thaler'" <dthaler1968@googlemail.com>,
	<bpf@ietf.org>,
	"'bpf'" <bpf@vger.kernel.org>,
	"'Jakub Kicinski'" <kuba@kernel.org>
References: <20231127201817.GB5421@maniforge> <072101da2558$fe5f5020$fb1df060$@gmail.com> <20231207215152.GA168514@maniforge> <CAADnVQ+Mhe6ean6J3vH1ugTyrgWNxupLoFfwKu6-U=3R8i1TNQ@mail.gmail.com> <20231212214532.GB1222@maniforge> <157b01da2d46$b7453e20$25cfba60$@gmail.com> <CAADnVQKd7X1v6CwCa2MyJjQkN8hKsHJ_g9Kk5CwWSbp9+1_3zw@mail.gmail.com> <20231212233555.GA53579@maniforge> <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com>
In-Reply-To: <CAADnVQJ-JwNTY5fW-oXdTur9aDrv2NQoreTH3yYZemVBVtq9fQ@mail.gmail.com>
Subject: RE: [Bpf] BPF ISA conformance groups
Date: Tue, 19 Dec 2023 10:15:12 -0800
Message-ID: <09e101da32a7$4f749aa0$ee5dcfe0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKaT4/11CAPHwhRd3AqhQv3W/OzVwEwRWUPAqgd9mMCsPCsZAM3MzMrAU5aAh0CJOkFhgFiTxI+Acm6TbKura/J0A==
Content-Language: en-us

Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
[...]
> > Well, maybe not for Netronome, or maybe not even for any vendor
> > (though we have no way of knowing that yet), but what about for =
other
> > contexts like Windows / Linux cross-platform compat?
>=20
> bpf on windows started similar to netronome. The goal was to =
demonstrate
> real cilium progs running on windows. And it was done.

The eBPF for Windows project's origin was independent of Cilium per se.
The goal was to enable us to write BPF programs that worked on both =
Windows
and Linux, rather than doing similar work separately which would double =
the work.

Once the work was far enough along, Cilium then became an interesting =
test case
to use in a demo since it was popular and recognizeable.

Dave


