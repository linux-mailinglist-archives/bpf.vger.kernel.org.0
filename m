Return-Path: <bpf+bounces-69901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F84BA5EC3
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 14:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944C517D221
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 12:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0686B2857CB;
	Sat, 27 Sep 2025 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJE96OVW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0305119EEC2
	for <bpf@vger.kernel.org>; Sat, 27 Sep 2025 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758975502; cv=none; b=PnQOKjwFa9C1Vi82vOVJ1xin2PFkBOuFdrn7DqPXBPNif7sNikNJvL/t0N6f9sBvb+ANpYcKTwqkBC5GfDfDrYaSrvyziAm8OBL6fFtkfW3QKzFLSAj5vliaE+LyuG8c5CPl+aPj3opu+81y4v5rgLxLzPOnwp1KhGHUZCyEJRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758975502; c=relaxed/simple;
	bh=vyEuiaZI0kzDxdy4E8QJUdr5hq5wKnTyzflmU+fNxFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFWJrXKdHjoO3UplxWY/u5cLL85OqfOzXLZTj5nDP3PDaEnjS7ZVfPMktBrbVeqIcsO/i0ea98H0J91DZJHuXb/YjNc5WFkS5hygEprzfrdNMeTRu6K8neiZybyaktTTYXq9Y5JEb/HXa9rZDz9sMybdGPeRbp9dplDgxR1OupE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJE96OVW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so2567915f8f.3
        for <bpf@vger.kernel.org>; Sat, 27 Sep 2025 05:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758975499; x=1759580299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vyEuiaZI0kzDxdy4E8QJUdr5hq5wKnTyzflmU+fNxFc=;
        b=OJE96OVWLbexthS9eE3GGiIgY9ZvLXU81TVFrhDBFfkJtml+VHYCR8buEqZ1tsErQ+
         mVvGEgqld0+ZImzWgm2EglC8SlZnlJIoeSTM3XzmsXBRapVHLqoJ+fObWa5MAWIVmwK/
         mpVj9NfEKZNq/mIoQLw3V835UcoaPe9r/7w4aBAAlqo/62xrTMbfzQmeHOyZMCWJsUzL
         4VcgaBMym9IhjT5BnBv3uNI42TqZLP8BTcjygm6M8cmZvBu7kYhYgAL+b5X+6m9C5ahN
         LNMVi03V9V8L/D/u4iCIvlSKOjrbSnMfljSv/s2SXXI/1zOVftZ0bS+yE8shUTE1ODr7
         zRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758975499; x=1759580299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vyEuiaZI0kzDxdy4E8QJUdr5hq5wKnTyzflmU+fNxFc=;
        b=SSNV5seVBv5SCEZ1IOneIGccpPcofDR6xq/w88rvoog7CL15abefzk1uO/r3Sal0fc
         dfmFgU5VNEspWZ9Ds21TnQXw4WLfm6aFtwEHvUnwsK5nfyDQEJwCEUcMTpOMWXsbI38T
         o/xxmJkqu5DBgj/E1/3rRq7IJal3o7zUjviRFD83/E006+Ho5jTcWT6H+QbRHxHOonXc
         /7i/raiYpDNJhiQcPO7q9aN6dn29E36cJrhaKI4yTfg44ygn5x3cZg/JX8N+6srxnbxw
         ef6g2J5PGoT3MjI2CCBYsj+vzSHBgNTUGCSYVK6xuVQESmvksQjLIT1JbREpAH8bC+kr
         nmNg==
X-Gm-Message-State: AOJu0YzdNB9XQJcEPDakq18gY8BfstXBI9mFh4v2s2hRy7MHO2JI4vnt
	TlZ0ZfzxUE7dZEYWH/dc5J4xcjCK2TGkPELMAe08x8pkzzRzU0HuHODFX2jmKrCtJXqFTxYaD5p
	JXDy5WUfF1vWYzgYfhA4Ce4gn5ZPct/k=
X-Gm-Gg: ASbGncv3d0DpUV9AbTv+iMPOnahxGMrMvWnE/aSETYz9FAgDjhhkKGpvtqUQl/I1vbv
	s/eYIVw/xaQ//R/05wf5MClMBa3dWX7DG37AMy1Ra23k7+N/KeSR46nDnSHaeOWzrmKfxNmRFH+
	3plnqBfqulyUqHbo4LByIskEtDVgWVUAVI0+lGiOYW053kTPcSTt1VbjFdshCd7BUzqQ0eFmB1M
	UDORxvcmA==
X-Google-Smtp-Source: AGHT+IGfU91S+QSwpGrDD7eq0OCKMdAgCO8j2sD7vLtvdUnOpgc6SSDHqURVSP7j/AzOP3sYoujCrmz/lE6gG/b3CUk=
X-Received: by 2002:a05:6000:1866:b0:3eb:6c82:bb27 with SMTP id
 ffacd0b85a97d-40e4accc83dmr8605022f8f.61.1758975499301; Sat, 27 Sep 2025
 05:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926235907.3357831-1-memxor@gmail.com> <CAP01T77czGuJju-Y2r4d=EDq6pnnSPCuLhFA6fcZBPf7EpJQag@mail.gmail.com>
In-Reply-To: <CAP01T77czGuJju-Y2r4d=EDq6pnnSPCuLhFA6fcZBPf7EpJQag@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 27 Sep 2025 13:18:08 +0100
X-Gm-Features: AS18NWCFD_SiLcEDUdYP9OlGsBeigyHroE8OJWV4s8bnJLLxbvGbzgQ0WCmCJKE
Message-ID: <CAADnVQJ9QSJVE4WqF7mxtF7+Awyjx-MfOSm0Wg+m-Z_zqxsAeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Add stress test for rqspinlock
 in NMI
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 1:01=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sat, 27 Sept 2025 at 01:59, Kumar Kartikeya Dwivedi <memxor@gmail.com>=
 wrote:
> >
> > Introduce a kernel module that will exercise lock acquisition in the NM=
I
> > path, and bias toward creating contention such that NMI waiters end up
> > being non-head waiters. Prior to the rqspinlock fix made in the commit
> > 0d80e7f951be ("rqspinlock: Choose trylock fallback for NMI waiters"), i=
t
> > was possible for the queueing path of non-head waiters to get stuck in
> > NMI, which this stress test reproduces fairly easily with just 3 CPUs.
> >
> > Both AA and ABBA flavors are supported, and it will serve as a test cas=
e
> > for future fixes that address this corner case. More information about
> > the problem in question is available in the commit cited above. When th=
e
> > fix is reverted, this stress test will lock up the system.
> >
> > To enable this test automatically through the test_progs infrastructure=
,
> > add a load_module_params API to exercise both AA and ABBA cases when
> > running the test.
> >
> > Note that the test runs for at most 5 seconds, and becomes a noop after
> > that, in order to allow the system to make forward progress. In
> > addition, CPU 0 is always kept untouched by the created threads and
> > NMIs. The test will automatically scale to the number of available
> > online CPUs.
> >
> > Note that at least 3 CPUs are necessary to run this test, hence skip th=
e
> > selftest in case the environment has less than 3 CPUs available.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> This currently won't trigger in BPF CI, as the VMs have two CPUs
> allocated to them.
> I was wondering if this is a simple change, otherwise I can rework the
> module to work with less than 3 CPUs.

It's fine. We can bump CI's cpu count.

But please see the bug spotted by our brand new AI review.
Despite false positives it's amazing what it catches.

Don't click on "Logs for ai-review" pw entry.
It's hard to navigate from there.
Click on "PR summary" and scroll down.

