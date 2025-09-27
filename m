Return-Path: <bpf+bounces-69875-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31851BA567F
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 02:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E11487AFF91
	for <lists+bpf@lfdr.de>; Sat, 27 Sep 2025 00:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B294534BA59;
	Sat, 27 Sep 2025 00:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJvuPcJt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AD82F32
	for <bpf@vger.kernel.org>; Sat, 27 Sep 2025 00:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758931309; cv=none; b=RfWlFDhdNkrzih1utwqBv4vGIVToyg3i7CyUlZ3PdRaJnqt6+VnG2AkMMf8E9RnRrx1FgJ1t0ezfJzlDEsgNQpu/6iHuCmRF2FWFGkkoDtpb+iykL9vCrBDvCHW2PFWyIB9Kas7mdKCe9a0bg/2ujqObKsHOyMNv6KWPqCQvo2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758931309; c=relaxed/simple;
	bh=ORXYBzcXvNg3Cd4JI1qFfTCPMrDl2NbR6JkcRutgSys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svT4d3wcoKmYZ6JrDPq0aHReNNH9teXKnLcrS+HeopdJO34IeGdYIiPEYtsYjHDOuH1NeZJv7r/zt6H10HBKzhDo1q7XZ+vjQGP07kUhDeY4TG2Xw9F2hp7sXGjN/Eej+L0ScOHcmzhiFdvAs2gh7kkQjyoywR8z5mG1GI7rdKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJvuPcJt; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b256c8ca246so24756766b.1
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 17:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758931305; x=1759536105; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ORXYBzcXvNg3Cd4JI1qFfTCPMrDl2NbR6JkcRutgSys=;
        b=GJvuPcJtvDzbGpekezp4sjNY5O2mlPnQtS8X/LNuw+wVdzVLtaPFbVFuXYcX+uoYlf
         Wc8KXuuBReG6iQYJlcbOFrnrAXm036Toqu+huiFHWxaWkHimezLXAzkWDAD82a4waxfU
         ckC0Y7rd96/smPpdW7Gt2XxCEOwRNYlO5FGaAGerAO/MN9glR9V3sbtZWP39XCnJUFVV
         kzIFO6LH7/Z+rZMBNVHu3V+2B4rLOpjAcdk9F/975jq6Wd0tCDGFQ/i8dxPeid1VxuBd
         MfY6yEyDspvUMPrpdl3zSMWEErPjP9zN2OYgYPeEOGW1SPyzChkqdUMbHlVdetizw9tq
         eI2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758931305; x=1759536105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORXYBzcXvNg3Cd4JI1qFfTCPMrDl2NbR6JkcRutgSys=;
        b=f0yfxKq6dOirZU0npY/VRjQgMwlwTpsoaR+UKFFrMJ9MBHTW4SjnkTpHHX4nQrt5Bq
         E/F7x9v2lTeP89Wj4Yp6PwC4HNfNYCQLWeF9aLq6SBX8B8niiP7vbClbWUPa2xKQS3Of
         Z05/xMvBJcl84woiOv700BMTARbnUA0NyRN1QCFn5B+sYSFHnsV3iU8ao7e2vqY6xMdi
         xNYHmFfdNFCknNtC81bs1KK161sLWnS6FxAg+3Dtkjqn52xOC1J0/e/GfQ3Q7IH/ZPrI
         I92oZal4ZyFxiMpgujSO+0UmbFxs1mHyiuQjTugDS1PvjzIlVY2XRujbUNq21BnkcNzQ
         UHKQ==
X-Gm-Message-State: AOJu0Yw9/xnXNXHYFcxpshoQ/QPtulaVAKTmhJl8XtodNszohpKd49Kx
	qQCwts+91u4HX+2Nlz3EJzE4MIDpS4ASFgK5sKuPi7ZKWSbPWDR1FGDfKkch46UoErBDrpIedCG
	evQZbtVqeD8ZbPjZ3owl+wemFcO+7ERO6Xcte
X-Gm-Gg: ASbGnct1Unc5ix/P+4AjAbGeVcshSqttGFJCS13cZsU7/COpsJunAYiI3NVQK8dmxu8
	rGJAKEmPYT6HsptXinvFeMoaMyjnTYQAkUJWnviyRLfYMnY+MNkMzhYapEiXEme0gNxqzl6KAM6
	/oeEnuAihOwutzG0n57Lc6kFIX8VvpT2yprrCRpmWGj6BvhlHAkCWC3fiJzsl1nwlJiQPXKUV1r
	sy0bwU=
X-Google-Smtp-Source: AGHT+IE54CnJ7B0uuIXqfrJK6UB+3DXr7yZrTo7RGlswhnHLzPiaZT2LADKdOizS0eGudswcr3GQ6GwPyu7kuy6zypA=
X-Received: by 2002:a17:907:9805:b0:b32:2b60:eed with SMTP id
 a640c23a62f3a-b34be7cedbcmr957366966b.44.1758931305429; Fri, 26 Sep 2025
 17:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926235907.3357831-1-memxor@gmail.com>
In-Reply-To: <20250926235907.3357831-1-memxor@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 27 Sep 2025 02:01:09 +0200
X-Gm-Features: AS18NWCMpSx0r73--BP_T_RVTE6STNM2aDbzvjmmg8emfpEe8zwgzcDKg3K3o4E
Message-ID: <CAP01T77czGuJju-Y2r4d=EDq6pnnSPCuLhFA6fcZBPf7EpJQag@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Add stress test for rqspinlock
 in NMI
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Sept 2025 at 01:59, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Introduce a kernel module that will exercise lock acquisition in the NMI
> path, and bias toward creating contention such that NMI waiters end up
> being non-head waiters. Prior to the rqspinlock fix made in the commit
> 0d80e7f951be ("rqspinlock: Choose trylock fallback for NMI waiters"), it
> was possible for the queueing path of non-head waiters to get stuck in
> NMI, which this stress test reproduces fairly easily with just 3 CPUs.
>
> Both AA and ABBA flavors are supported, and it will serve as a test case
> for future fixes that address this corner case. More information about
> the problem in question is available in the commit cited above. When the
> fix is reverted, this stress test will lock up the system.
>
> To enable this test automatically through the test_progs infrastructure,
> add a load_module_params API to exercise both AA and ABBA cases when
> running the test.
>
> Note that the test runs for at most 5 seconds, and becomes a noop after
> that, in order to allow the system to make forward progress. In
> addition, CPU 0 is always kept untouched by the created threads and
> NMIs. The test will automatically scale to the number of available
> online CPUs.
>
> Note that at least 3 CPUs are necessary to run this test, hence skip the
> selftest in case the environment has less than 3 CPUs available.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

This currently won't trigger in BPF CI, as the VMs have two CPUs
allocated to them.
I was wondering if this is a simple change, otherwise I can rework the
module to work with less than 3 CPUs.

