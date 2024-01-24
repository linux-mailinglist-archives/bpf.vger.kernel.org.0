Return-Path: <bpf+bounces-20247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB48C83B04D
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 18:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8296C285C3D
	for <lists+bpf@lfdr.de>; Wed, 24 Jan 2024 17:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E4585C66;
	Wed, 24 Jan 2024 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYBHALON"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C0F7FBDB;
	Wed, 24 Jan 2024 17:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118367; cv=none; b=kC2uaR/WZg1KTRrXJJdyASLywOiEoE8gcxEwnDMy9wj1/XHaK8nP00IKyijmmaPm8b6OVldyFjgtUzeOCmjZHLNVg2OKj/7rVyErWJYPRRGfROqYKGG6lbhx65QNQDl8CZSAfiQnV74Q2THTP29XXopy0FsAr26+rd3ccR914Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118367; c=relaxed/simple;
	bh=i7yo+aYNNP72OkQGf+WKIxo9hPzYgQ2hT6dioi0XQOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6SiArkBPDKOtJcDnTKy8xNUoWvBBiy4Avh5eQdywn9JCwF4e9P20lWyO6h/JgxCay29T2+ImVwawvgkWyC6ZQnNIscCRaChhp4TVH75tVj9hrroHrkV3cCUCNom9v+rqvD/M/6+6XqrwW+PYdW/suhW6dItaVOBYRK+3194SHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYBHALON; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5100fbc27c3so1412774e87.2;
        Wed, 24 Jan 2024 09:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706118364; x=1706723164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtoLnV2D1shaHLJhQPdUvMm5JNTUSX08pNoC68KljUw=;
        b=HYBHALONRXR7W4EFjIZ5Ip3ZdlnnB2o6SxSBvmLMNR2SPK99weaCNqvX5pd5xv6iGx
         MDaiK9zLPjHsvbWMjR8syiTEMij2q9eiWqTbkAkt9Tog99Is04quNnGYuVJVhtfENq4b
         47sOHrDgtuOxaBvwwG/swMxKnETd+G042Ain6eYMZ9I1d5xwOjVeNeAzp/7kKRaqjnnS
         BfxpoXkJU8cyaUPrjbSOlGelp53t5zc4NZLNgqeL01MqeCDdzQKoPmovHcvDIJMMxBxn
         q3GiUSI/RlqHlP1HqNWlfJl4MWCgO7CktMXT37gde5bv5GUlWE/d13/QH4A+ZxdqK8vl
         0YPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706118364; x=1706723164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtoLnV2D1shaHLJhQPdUvMm5JNTUSX08pNoC68KljUw=;
        b=pKlkreur7ixWbLB3d6U1qu6wnZK+jI+Y7cYT6ffrmRdaPL9M7Sj3WYNC3OF9nioP5r
         E4KCk5ecc5S3kwIW1JFBxLEK4AXC6TFP3sEP7L5wgX76lRNHtdvmevKX961/G/DNUiiD
         h52y9SCGsiAGtl7WNRt+SSC9a8s5YfG6lSwqAgUHgGk1K2OskP2d9p5yAHesvPGZgOmN
         E9b0/0XnpuRW+vJd2ZiJ4p5EVTapNBG5a1+jIq+VeURmtMt3x+gFQzU0RVWK4L0EjxcO
         i1PlCJhY5JYz3jElkJtMk7Lyf0ztbBS9LZ484EM4vBTEX5hdyT+lslx1thjx6Vsf4pIk
         5AOg==
X-Gm-Message-State: AOJu0Yy6te8atJMbRv1YG0ZFP58yaABwW2K5sf7bqkEC1TuBe2j0HXpl
	DbFJAxBExSiEj23KhMJ39iQ+0SKR9eoeE/LvQd77cwyr9EAgIG+diLoFuDQfB/5Id0AWNDRoE9i
	wMIW2pKiJTL33hVryb5uBDqS9/7s=
X-Google-Smtp-Source: AGHT+IE/PbXl9skXFbrDcFzbNp9aYucNcy+ZFLKq4tN854doQ0kOLwg6BxeE/nd1vydLdNGrLdoLJuPqYZcf/QRvk/k=
X-Received: by 2002:a19:2d17:0:b0:510:1758:f111 with SMTP id
 k23-20020a192d17000000b005101758f111mr217348lfj.7.1706118363640; Wed, 24 Jan
 2024 09:46:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123223612.1015788-1-john.fastabend@gmail.com> <65b0776bd8ee2_fbe42208b8@john.notmuch>
In-Reply-To: <65b0776bd8ee2_fbe42208b8@john.notmuch>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 Jan 2024 09:45:46 -0800
Message-ID: <CAEf4BzbkGuDH91X2KaA=448HoZD0m09qQrBDvBxFwdTLTF7JFw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] transition sockmap testing to test_progs
To: John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org, jakub@cloudflare.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 6:35=E2=80=AFPM John Fastabend <john.fastabend@gmai=
l.com> wrote:
>
> John Fastabend wrote:
> > Its much easier to write and read tests than it was when sockmap was
> > originally created. At that time we created a test_sockmap prog that
> > did sockmap tests. But, its showing its age now. For example it reads
> > user vars out of maps, is hard to run targetted tests, has a different
> > format from the familiar test_progs and so on.
> >
> > I recently thought there was an issue with pop helpers so I created
> > some tests to try and track it down. It turns out it was a bug in the
> > BPF program we had not the kernel. But, I think it makes sense to
> > start deprecating test_sockmap and converting these to the nicer
> > test_progs.
> >
> > So this is a first round of test_prog tests for sockmap cork and
> > pop helpers. I'll add push and pull tests shortly. I think its fine,
> > maybe preferred to review smaller patchsets, to send these
> > incrementally as I get them created.
> >
> > Thanks!
> >
> > John Fastabend (4):
> >   bpf: Add modern test for sk_msg prog pop msg header
> >   bpf: sockmap, add a sendmsg test so we can check that path
> >   bpf: sockmap, add a cork to force buffering of the scatterlist
> >   bpf: sockmap test cork and pop combined
> >
> >  .../bpf/prog_tests/sockmap_helpers.h          |  18 +
> >  .../bpf/prog_tests/sockmap_msg_helpers.c      | 351 ++++++++++++++++++
> >  .../bpf/progs/test_sockmap_msg_helpers.c      |  67 ++++
> >  3 files changed, 436 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/sockmap_msg_=
helpers.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_=
helpers.c
> >
> > --
> > 2.33.0
> >
>
> Will need a v2 to fixup a couple things here. Thanks.
>

Can you please also try compiling selftests with `make RELEASE=3D1` and
making sure the compiler doesn't complain about uninitialized
variables and such. Unfortunately we don't do this automatically in CI
yet.

