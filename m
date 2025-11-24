Return-Path: <bpf+bounces-75386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A30C820DD
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 19:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 342C9349765
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 18:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6428231985C;
	Mon, 24 Nov 2025 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrLQqzQl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C55319619
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008212; cv=none; b=IVQR9so9BwaBtkDxpouJUIB79upAIsBIHspWBuv3CN9C+k2//DsL62bhrQy6R2om0AzrieQKOjMAzAx6Kf7m2RHl5gUY0OjTC/phdAuEMKzHXewV8vknSoBUo0t271aUmb3VNnmrvVN+TNK9ZubunsQ5fhBji3Cx/B7sDaD1LYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008212; c=relaxed/simple;
	bh=Knxe0aFzHU+vjMjbhS7WM2nEAsA8uRM+3J22VaGGraY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ov9Iq274lX/ey63n7MvhJscgrFL1WYqi0IaPp6SKv72d1nCozvm4GNC7FTwxoQQlGw1LpwlX8CtRdIXMWdmcNeAlEPu9H1d9hTpNFdqSY3CpX2WB9/f4dsQ1+NQjOpJp25o/GVPLSPosNke5IsiQnIv0PwkJ8Q+M8rtfp50iVdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrLQqzQl; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29808a9a96aso53609095ad.1
        for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 10:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764008211; x=1764613011; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Knxe0aFzHU+vjMjbhS7WM2nEAsA8uRM+3J22VaGGraY=;
        b=lrLQqzQltxKvCHdTLDem/ZWCjzvHsT0mtnNm/PSJ97V9ctqcp70NrNYbymwN308cqo
         Wf38sG6csN8r2DMfTFcjrdILL1oLMN9NvAOvVtm97EUuX32Xx41iJv1AFPdz1YZzgheH
         JKFRdX8+FUX5I4eAPXwKk4oC40JCVH6r8OCtmMa3mbDlrl9Rc+oXAoO1PIinHy1qa5oR
         fnbMuULK7uJwvislNmPONpvatugw89l4QGa9FbbzY8ArCWZROFMSsm5MxxTi6MZlFeho
         nRXfgZERmiwD434euhgDPIU7jGXDl3GVGT5JhbUhFhJpq4Qpv1BZwef3NOYqkTJWD4st
         MaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764008211; x=1764613011;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Knxe0aFzHU+vjMjbhS7WM2nEAsA8uRM+3J22VaGGraY=;
        b=Q0knSaJoITQcHIrdRI4+ECCp7p/LSPwRTJKoHKw+V7EphXCoVfMrRYOJJsvm3zvS0d
         k66RSYbJpRfQuJIoAjoI8GX5DdFjU7dzgZyeucySFARyqP//LRSSHf/gWorkLcD+19z0
         M4lK+81v2YEhdW62eYSZvvUlgTpjlxhxybRQSIxfPinTF3ADyWXW/SW9xXMZRTojW4XE
         aLvar5rGBui52/ce3MKZZwKJSPd0LDvVdGilfsxSmDEtBKBC56s49gCg1xxyDnzrMqEe
         PsQYXgCUtQx/pOf6vqZJFLkgdMCS8+GV8k56+ZhsvWJzWtJVhsKFSJA2tdDoYHlliJq0
         QtOQ==
X-Forwarded-Encrypted: i=1; AJvYcCViX5+raWN7f1JaI1coJw5+R85x80aGWTssoxOdo+FHcfOoY/eeSWI/Y32qNJ/Pal7iT1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxitgqEII6Ly0P22Vsz8BlNk/kkxS/e3H85nxhuAuoHSdxbGwD7
	ba5X0Orn58eb//IcHdhhbZQxAmR6DnE59hSOtWUVPCPfQ3FD8xzRjxUf
X-Gm-Gg: ASbGncunodRmOplDgmvfHW8nVQgR6+AZlnnd8d15w75/F64iut2EoLbpoQY8swlGCCa
	CfwpVfhrvpMHtwSP79TNABz6zhS0TYWEBZO7Irl6vToCsaabUmDoNud0vIm15HbbbBmfKaK1E+B
	1v2UT2IyHcE0JUmLw+7bM7OnFpcqOk5OpqHK5am3lqQpGLa4ZMi9kIwkSwKqBKRlSd79K7boiDj
	f+yX5a4bwqSnSbGkiBS4FfW3Br9dBv5eI6x+Kwr/AOBXwH0cHVBCG9KSgiXw5lSae7vaO+SMhaG
	9FMAiFYdAPbupJ7YExzZBstQIN1GuS3bjlrKpVfaUFHk94FWij1Hut+anJ6GJKf+7lz3nFgnUan
	FYYZAW+ZysP0JFrTl+Nl+Csj/vtrg1uaLSHbXScyzN2BSVd2so2nf6fAt1cIrBX2Js6AKl24bM6
	wMvDDxSwdIJotQ8YFdQhKzSQP6LrdM3eMHU7R9
X-Google-Smtp-Source: AGHT+IGGO/M6iygnRA7BoiwflnrdEY75OzzJD//aC8/wYYBi/ch1yQn0qlFAO5y/djLY4rRD6bTsoA==
X-Received: by 2002:a17:902:ef09:b0:295:1aa7:edf7 with SMTP id d9443c01a7336-29b6bf3bd88mr148845645ad.30.1764008210593;
        Mon, 24 Nov 2025 10:16:50 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:e360:3d88:84bf:d2b9? ([2620:10d:c090:500::6:a7ca])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b111acfsm143967875ad.19.2025.11.24.10.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 10:16:50 -0800 (PST)
Message-ID: <a254810a42510ad3adc00d27d1fd456710c7faa9.camel@gmail.com>
Subject: Re: [RFC PATCH v7 5/7] libbpf: Implement BTF type sorting
 validation for binary search optimization
From: Eduard Zingerman <eddyz87@gmail.com>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, ast@kernel.org, 
	zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
  Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire
 <alan.maguire@oracle.com>, Song Liu <song@kernel.org>
Date: Mon, 24 Nov 2025 10:16:48 -0800
In-Reply-To: <CAErzpmv-CQy42LMFR4hzD4ANqL4ENnWyb0uKr7_FH1fj98S2QA@mail.gmail.com>
References: <20251119031531.1817099-1-dolinux.peng@gmail.com>
	 <20251119031531.1817099-6-dolinux.peng@gmail.com>
	 <CAEf4BzYQfHKHUdxv7W7mET1xBXuokvx9v=69HNAkhg_CAPCm-g@mail.gmail.com>
	 <CAErzpmvLhKbCYh3hYW=54JJtXj3TV0t2JAmGwy4E3xW7r84OBw@mail.gmail.com>
	 <bddc9f1d5c1f2f7f233707cf2af81a2013d46b7d.camel@gmail.com>
	 <CAErzpmvP41CNQhRVKuDU23xnBKjj239R6_e5K8DSwcNDo7GG5Q@mail.gmail.com>
	 <f515305c3b250f9dbed003b98d78f72c3d72cc2c.camel@gmail.com>
	 <ce92f733d24bfad103a9abcc209f411398e23332.camel@gmail.com>
	 <CAErzpmv-CQy42LMFR4hzD4ANqL4ENnWyb0uKr7_FH1fj98S2QA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-11-22 at 23:45 +0800, Donglin Peng wrote:
> On Sat, Nov 22, 2025 at 5:05=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Sat, 2025-11-22 at 00:50 -0800, Eduard Zingerman wrote:
> >=20
> > [...]
> >=20
> > > > Thanks. I=E2=80=99ve looked into find_btf_percpu_datasec and we can=
=E2=80=99t use
> > > > btf_find_by_name_kind here because the search scope differs. For
> > > > a module BTF, find_btf_percpu_datasec only searches within the
> > > > module=E2=80=99s own BTF, whereas btf_find_by_name_kind prioritizes
> > > > searching the base BTF first. Thus, placing named types ahead is
> > > > more effective here. Besides, I found that the '.data..percpu' name=
d
> > > > type will be placed at [1] for vmlinux BTF because the prefix '.' i=
s
> > > > smaller than any letter, so the linear search only requires one loo=
p to
> > > > locate it. However, if we put named types at the end, it will need =
more
> > > > than 60,000 loops..
> > >=20
> > > But this can be easily fixed if a variant of btf_find_by_name_kind()
> > > is provided that looks for a match only in a specific BTF. Or accepts
> > > a start id parameter.
> >=20
> > Also, I double checked, and for my vmlinux the id for '.data..percpu'
> > section is 110864, the last id of all. So, having all anonymous types
> > in front does not change status-quo compared to current implementation.
>=20
> Yes. If types are sorted alphabetically, the '.data..percpu' section will
> have ID 1 in vmlinux BTF. In this case, linear search performance is
> optimal when named types are placed ahead of anonymous types.
>=20
> I would like to understand the benefits of having anonymous types at the
> front of named types.

This will allow using strcmp() instead of btf_compare_type_names(),
which we have to copy both in kernel and in libbpf. Reducing the code
size and cognitive load.

