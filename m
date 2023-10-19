Return-Path: <bpf+bounces-12635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416247CED2E
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 03:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3375281E4F
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 01:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7B1394;
	Thu, 19 Oct 2023 01:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaexODAK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF55D38C
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 01:07:49 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02875112
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 18:07:48 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-65b0e623189so43842716d6.1
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 18:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697677667; x=1698282467; darn=vger.kernel.org;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93iTMdBSd/L52S+O8BZ0+TOR69y0nK2OuLj6qOm2suw=;
        b=UaexODAKG2nSSTiMSVHFrhor3E5hvvFsrm5ZHLBN/G4klti+Wlu/3zORc+mcF7Z1MJ
         tkaTjS8g2rMFtlSpKX6eKn3ePRc5X/zpWJVjVZlMPEqIf7VnNud/+J+eYcVLmx3mpwc1
         sKkaH8e6Bi7oegByn5ACrqbhumYyv2zCPDgnNj350eGyoxuSwnYkXXV3SXffA1Hj261x
         RnxslLso9NQfBlRpZ3d2woK+dL7LhCV6oKTNa78NqbYTTQdMMrrjZnbJjS+PSdSRYe3m
         Vdc4Vm5w9v7MdQUl231tH/VuPSVk+EnX7rOas8LkGk7Yx5VwG8llhs8FyW/GON8WjlNc
         1NIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697677667; x=1698282467;
        h=message-id:in-reply-to:to:references:date:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93iTMdBSd/L52S+O8BZ0+TOR69y0nK2OuLj6qOm2suw=;
        b=JlghFpL6HZD1qhjwg1i8MRB4aM0quHgY2Qq4zqZDuEzFZWT0RWgeBmDoTIVgUSq1MJ
         TGfNk/Z9I0IMChpa38RnvyLJn4dcv0fDJ+FQyioHr4KoArERR9Q/JZdh0mzseMQLWqWh
         f1S/BS3yMolKU9S4uD1UbFBC/BlVe+IQWv4sn7FcDevgKFcyHmHs0M3px9nL/O0o+Jq9
         M+zrc5S0vZdwDijUd5v/Wyi25mfi2InyeKOv8q91Y8/TJunkVAg7BAUEo22r1ar1gxMs
         7ddtuM6kMAn8Sh+AgkLacY+o1ZBRf5cQGMIi1z89wh4g2I0LcoMjHbreDH5SbCxyAb1E
         AppQ==
X-Gm-Message-State: AOJu0YyaGMmS4cZB9CllAhc5BwnvBUTns7W0j6uMktdr2FHF4/oYXEt/
	ucCtkR7MOhKqjvBvyVesVIebxtO12DU=
X-Google-Smtp-Source: AGHT+IFqO0u5YdNYimUIslC487swT9BZk+UNlFqvPQBvHDE3YHGQTo315dlj1oN7K/XccD7UpM5Q2w==
X-Received: by 2002:ad4:5b89:0:b0:66d:50a6:da73 with SMTP id 9-20020ad45b89000000b0066d50a6da73mr1225476qvp.22.1697677667014;
        Wed, 18 Oct 2023 18:07:47 -0700 (PDT)
Received: from smtpclient.apple (45-19-110-76.lightspeed.tukrga.sbcglobal.net. [45.19.110.76])
        by smtp.gmail.com with ESMTPSA id qh11-20020a0562144c0b00b0065af657ddf7sm376860qvb.144.2023.10.18.18.07.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Oct 2023 18:07:45 -0700 (PDT)
From: Suresh Krishnan <suresh.krishnan@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: Call for WG adoption: draft-thaler-bpf-isa-02
Date: Wed, 18 Oct 2023 21:07:44 -0400
References: <CA+MHpBoHdG4ptYsdeHaEUNqmyPYYgavWUpMbVW5zzOzUoLUJMw@mail.gmail.com>
To: bpf@ietf.org,
 bpf <bpf@vger.kernel.org>
In-Reply-To: <CA+MHpBoHdG4ptYsdeHaEUNqmyPYYgavWUpMbVW5zzOzUoLUJMw@mail.gmail.com>
Message-Id: <1C8A6FD1-1724-4AD3-A6C9-CA2C427FD32E@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)

Hi all,
  This document has now been adopted as a WG item. Dave, please submit =
the next revision as draft-ietf-bpf-isa-00.

Thanks
Suresh & David

> On Sep 29, 2023, at 10:28 AM, Suresh Krishnan =
<suresh.krishnan@gmail.com> wrote:
>=20
> Hi all,
>  This draft has been presented at the bpf meetings and has received
> significant feedback both at the meetings and on/off list. Dave has
> published a new revision that addresses all the comments, and has
> requested WG adoption of the draft. This call is being initiated to
> determine whether there is WG consensus towards adoption of
> draft-thaler-bpf-isa-02 as a bpf WG draft. This draft is expected to
> address the WG deliverable
>=20
> "[PS] the BPF instruction set architecture (ISA) that defines the
> instructions and low-level virtual machine for BPF programs"
>=20
> The draft is available at
>=20
> (HTML) https://datatracker.ietf.org/doc/html/draft-thaler-bpf-isa-02
> (Plaintext) =
https://www.ietf.org/archive/id/draft-thaler-bpf-isa-02.txt
>=20
> Please state whether or not you're in favor of the adoption by
> replying to this email. If you are not in favor, please also state
> your objections in your response. This adoption call will conclude on
> Friday October 13 2023 (AoE) .
>=20
> Regards
> Suresh & David


