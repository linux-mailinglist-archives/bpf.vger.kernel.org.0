Return-Path: <bpf+bounces-20351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9990183CF14
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 22:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37F11B220C7
	for <lists+bpf@lfdr.de>; Thu, 25 Jan 2024 21:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C530813AA2D;
	Thu, 25 Jan 2024 21:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlxGBBtQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9AD13A263
	for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 21:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219964; cv=none; b=gMJj4sS/6dIVKZNEgjXmN8uoxS0EKoMeatFR3LcRWPm++sXDs1sQoXb168Hf+SBJMwhbTKPwSskyyY9gWXXNmf6ekyBpf1aIJ4q6XiQkbhI94N9Wx10SwUcAauwxIW9uvY0lUGWLumS1SDQENCBF9TPByzEOSZ5Gmc5J23e4hCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219964; c=relaxed/simple;
	bh=Ns556+EmKSiN4XbKYn3ZL2HLqPz+TnHr/cXiB2rGv3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ozbELtqOxeaY9o5tIDeZT7YtNF5n9wYz5IJ4pGqxet8ZJDxb3fgH2NvLBHvxF1Lbo/ydeLXRD5mK6LVDXD47dHorxiwy7rz20l3OGEkkHRnM//EhnWoqDIRZV+G+RAGrY69b9XCQ3RUt9NbnNh9hF2TmYJkDri6ji5yenP30vM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlxGBBtQ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-290b1e19101so944610a91.0
        for <bpf@vger.kernel.org>; Thu, 25 Jan 2024 13:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706219962; x=1706824762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWyHVEE3dKhI+QQawxyRTqVc1/YUYaibBPXaZoG/OK0=;
        b=IlxGBBtQhy4GaeyEWSLhK2sGbjVwO9W8cB8zu6PN9Yk7ppVk5Yjl/SZtkIdOkFRfPi
         r+KVCdiASlPcaLY2XI9iE6CaY1KYKvnuyEpH5G5FRuybTlkxo4RYl6iVxkMFMLuemGHS
         EMBxBGdyj2xcZCjEPJYSkQhq/IsoGaSBXnVAH6rPyEqWrRjbEC1VWskIzzxT2DffMwNi
         eLrLimPcgH5ybBr0vxgpaNfuKocOTGPX2Dw6jZ5WvKuXURzm1P0ZAu8F5sO21MYAVRNJ
         rgU30aOX4rNQ7H4unnhuaR84d19J8pbvNFiVfDsy7Lt6e2c9v/xdX+XvWf28uHuCCwqY
         TGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706219962; x=1706824762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWyHVEE3dKhI+QQawxyRTqVc1/YUYaibBPXaZoG/OK0=;
        b=UkJo/72DovVM4/2TFhgroeuzbsW6Tn9ANJDMYWU2+kZj7IhFv1hnKZ8oWj4EucXUPA
         5+iaHdiljBrFYrQLBUjyeAJTHPUyEVLuOffSQPk3pRYjO8H12hNBpmaD4wX0G4o1dZWX
         l2tXgjcRsOrb+68bwlYKGW4J8yak0VuNrrd8b9mXZ/opNNfHtT6jEobaa6cxX2fnPTKi
         17NZiA6VEKTpW+rbIpw4HKKk4KhYEhQFhKzs9aeUCofOPi+YQPYBaYHx7o+XWvNO065G
         vaERrtR7Fn11Kh9eNM+0jUJq7ZiGoL+ZfAobU91lOsvjzg/eT3LpS+GlmBeTxyKUrCXO
         qAEQ==
X-Gm-Message-State: AOJu0YxI1NQw/NbuDTmyZYavhSJkV2Buj+lpFXW+bzcaSqeQHiaPqud0
	tz+mvELA6kGJDnf/ZGMGZMRDN/EXlB5jzA77Pxc/TGe4Ymt8gJTYuabQ2nYoGuaFVO0/H7UoF/d
	NlZIgkv9iHfjQS/+4e0VfmhQooHc=
X-Google-Smtp-Source: AGHT+IH9aB/8rWF8zdeQk2O5ypOKNdBCEkkLPQJ1qNxoRgKZEhpPzCdCNtmfgmx+ZBjO3O+jPC4xWOM8Jz2KgTk2xsU=
X-Received: by 2002:a05:6a20:e116:b0:19c:61eb:964 with SMTP id
 kr22-20020a056a20e11600b0019c61eb0964mr313716pzb.13.1706219962167; Thu, 25
 Jan 2024 13:59:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c318466f-ffd7-6bdf-9d95-93a952106bd5@loongson.cn>
In-Reply-To: <c318466f-ffd7-6bdf-9d95-93a952106bd5@loongson.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Jan 2024 13:59:10 -0800
Message-ID: <CAEf4BzYCOFEuLB53v=qsuW3poSE+O4R58U+824riQV1BzF2i_g@mail.gmail.com>
Subject: Re: Add missing line break in test_verifier
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 7:13=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Hi Andrii,
>
> There was a line break at the end of printf() in the original patch [1],
> but it is missing with small change in the git tree. Would you be able
> to squash below trivial change into the current commit [2]?
>
> diff --git a/tools/testing/selftests/bpf/test_verifier.c
> b/tools/testing/selftests/bpf/test_verifier.c
> index e1a1dfe8d7fa..df04bda1c927 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -1527,7 +1527,7 @@ static void do_test_single(struct bpf_test *test,
> bool unpriv,
>          int i, err;
>
>          if ((test->flags & F_NEEDS_JIT_ENABLED) && jit_disabled) {
> -               printf("SKIP (requires BPF JIT)");
> +               printf("SKIP (requires BPF JIT)\n");

Yeah, my bad, missed adding \n when fixing up message. I don't think
we can fix this up anymore, would you be able to send this as a proper
patch and we can apply this?

>                  skips++;
>                  sched_yield();
>                  return;
>
> Otherwise, there are no break lines in the test log, like this:
>
> #106/p inline simple bpf_loop call SKIP (requires BPF JIT)#107/p don't
> inline bpf_loop call, flags non-zero SKIP (requires BPF JIT)#108/p don't
> inline bpf_loop call, callback non-constant SKIP (requires BPF
> JIT)#109/p bpf_loop_inline and a dead func SKIP (requires BPF JIT)#110/p
> bpf_loop_inline stack locations for loop vars SKIP (requires BPF
> JIT)#111/p inline bpf_loop call in a big program SKIP (requires BPF
> JIT)#112/p BPF_ST_MEM stack imm non-zero OK
>
> [1]
> https://lore.kernel.org/bpf/20240123090351.2207-3-yangtiezhu@loongson.cn/
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?=
id=3D0b50478fd877
>
> Thanks,
> Tiezhu
>

