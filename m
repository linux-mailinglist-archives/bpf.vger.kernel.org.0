Return-Path: <bpf+bounces-16024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270B17FB060
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 04:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B76281CD3
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 03:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E326FBA;
	Tue, 28 Nov 2023 03:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXg1UjGb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EFE1A5
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 19:15:13 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a03a900956dso940546566b.1
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 19:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701141312; x=1701746112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDKKBLy16Gjw10S3tse051SglTDoJZ3J4WPDhJ7n3jw=;
        b=KXg1UjGbRjhq0gZjb7Ytilc6v4kPmAXjgW07ZzJbtk3vMmzKa2vcqC7xWfaqqzsld8
         j2qTTBDaLD66le9SiWDcnU1okS7LUwXitTNYCiO40KHIdb/p2Y6A0eZfVjLgQF1Ti1IA
         MYgs0owhXGKK4dpfkydVGU0NJEABZy6IXXvOJb8zE8tFBAVDTMiD5+vRgs7NWD/tT0YS
         f8JUrccU8MvDDwliLlsB5wHtyxqphlDQjnprm3aVKaQcLlg6C1JypMEhtj452od8RG6Y
         NLpjQPlAGkch4+0cxuIdBZTb0RFi+YT6lDKtpz6Hfi1ZPJdNZPkj/ae5G24vBhx+PkO+
         g0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701141312; x=1701746112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDKKBLy16Gjw10S3tse051SglTDoJZ3J4WPDhJ7n3jw=;
        b=pKGOa167/MwDRbFzlGmyM60Zw3v62JB6Qp4GkJ7P8KctqVzwCQXLk7MtSmxNTubf6K
         14BZl/nr4F8z+kxgF6/RVs1joZAp/uZSTATtNu3BD9KeY/UjiG+PjPJyRBS7FINsOMHu
         O+QWF3fjeTyd0u1g7jJA/Wxp/zbbJ+0EjgQAvxMXPPGr0Tkkpdbu9Mudx3XxsWgl2tr8
         WWtlXeVTO0QBBHc8c7/6kgLxebEp9eo8QXYAva81G9EX9hsMfi9avnCRCDJWIxfmuq8t
         SCMUFe6g+IvHjMYvwolIkZxrKVWOPkfvdGNhoK045IESXFreqVyMSmR5PbcAOMRkfsLG
         r+Qg==
X-Gm-Message-State: AOJu0YyIKT+7jGveqePnuSuWhDCOHF3YJXXfdh5IkYTZLle3JHubeObZ
	9K6pW8UKx5t0oJzlgN2ULdAXnFHssK7HeV7nzQxsnYCtDKQ=
X-Google-Smtp-Source: AGHT+IFEZvSflGMr/44iMZ5jVescEl95cONxVt2CgnvYrHMrJieEN56Iplpx6fBMdF8k6D7GVH6lQ9DRcvkJhirgxYo=
X-Received: by 2002:a17:907:da3:b0:9fa:d1df:c2c4 with SMTP id
 go35-20020a1709070da300b009fad1dfc2c4mr16762404ejc.36.1701141311500; Mon, 27
 Nov 2023 19:15:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231126015045.1092826-1-andreimatei1@gmail.com>
 <20231126015045.1092826-3-andreimatei1@gmail.com> <de2946da3720afdde07aadcda1992e3f877cca70.camel@gmail.com>
In-Reply-To: <de2946da3720afdde07aadcda1992e3f877cca70.camel@gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Mon, 27 Nov 2023 22:15:00 -0500
Message-ID: <CABWLseviz4j=KhkbX7P8soj5dkBjbg3bP08joF+y43+TFEKX0Q@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: new verifier tests for stack access
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, andrii.nakryiko@gmail.com, sunhao.th@gmail.com, 
	kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2023 at 8:23=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Sat, 2023-11-25 at 20:50 -0500, Andrei Matei wrote:
> > This patch adds tests for the previous patch, checking the tracking of
> > the maximum stack size and checking that accesses to uninit stack memor=
y
> > are allowed.
> >
> > They are a separate patch for review purposes; whoever merges them can
> > consider squashing.
> >
> > Signed-off-by: Andrei Matei <andreimatei1@gmail.com>
> > ---
>
> I think the strategy now is to add new tests using inline assembly,
> e.g. as a part of verifier_* tests in test_progs.

Thanks, I'll try that. I see in some of the verifier tests that you
have converted to test_progs hints that they were converted
"automatically". I'm curious what tool you've used, if any.
Do you have any thoughts on how a test could assert the maximum stack
depth? test_verifier has access to the verifier verifier log and
parses it out of there; do you know how I could achieve the same in
test_progs?

For the curiosity of someone who doesn't know  much about this code
base - how come we moved from test_verifier, which seems a bit more
unit-test-y, do the higher level test_progs? Is it because of the
nicer assembly syntax?

