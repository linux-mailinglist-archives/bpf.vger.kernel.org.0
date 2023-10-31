Return-Path: <bpf+bounces-13652-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26D77DC43D
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 03:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8801C20ADC
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 02:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B1110F8;
	Tue, 31 Oct 2023 02:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ay1OmHv2"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE9D1858
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 02:20:38 +0000 (UTC)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F7C11A
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 19:20:37 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cc37fb1310so16108285ad.1
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 19:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698718836; x=1699323636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IR1RaK/8rEz2FMTWGVRawIfxXRF+lhSJrNAyWr9AonQ=;
        b=ay1OmHv2LUxqGMTF1tyHKh6sHxSinulRL80O1X43nljiHBdRKdVfyExZuR0lI4l+m5
         OS1Vmu2iCNiLxfy9+KtdHf5ac7O6nARyTGFsIceMQqpMRpgKYwKWdCKuPdEkOjE4zNYt
         kk7Vv2MdQYBhShm6p9QEX5DpH4NFW786cOZ8P2wEqTlAFHEqGHdcvJcHma6Cywpf+tOi
         YNpz9bIsqK7Sw1i3VTfUPb/OOZcM+U+Gc9TUXBPTNGhm+NnaN2+srGlp1Hmn+aVBRo7R
         OjFvN8Nph+ol5yi5S/qg3P7XZ92zOHCMgDeQc/ODUDr58JhWjGd7y7j1+B1wLL9je6ZT
         sfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698718836; x=1699323636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IR1RaK/8rEz2FMTWGVRawIfxXRF+lhSJrNAyWr9AonQ=;
        b=hisgHvlIPxwbEqfA+DgO694D8+HCRsrW5MfK27qefeAoKSt9LCIAT2hFvVDMywHDcA
         dVJkcEQz0MnfE3lvljIbnupBYOa6zIPJvzwaZJM3xX6P4IhBjg1wS+Fk2LDkHQoQRptt
         xuKO/UKN+LytALyNwhXLKf7Mkn3YIa86ukLQp3fIVaq6aofd08geY+L0krnZiBKEB2r2
         nQUke0/d9NHwZQSVB2Zhiza8w3+eyBk1LDaWOcBTKH+IXoWAXJRgXLXV6eSqYbUHutSg
         wQ1YcQnZ9MFcrW3P+SZgtvGznsapeG0ZfFB4jk20oB2gnupFaNIdhQCYi563uBmK12sV
         xymA==
X-Gm-Message-State: AOJu0YwWZGeedXxkc1rFJEjyVkufSvcY+UXr4bomm8lRvOwIDHMb0fhL
	/KYzSlJpRrPpoVdpSeyDn6I=
X-Google-Smtp-Source: AGHT+IECfL2H2obA5Mg5C4JJDSw9Y+0FdCvDNBznO27RG3f6KTXnv1/R/p0JS8tU/rQOMZT0PbruJw==
X-Received: by 2002:a17:902:e892:b0:1cc:5691:5124 with SMTP id w18-20020a170902e89200b001cc56915124mr2794980plg.21.1698718836500;
        Mon, 30 Oct 2023 19:20:36 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2620:10d:c090:400::4:e78a])
        by smtp.gmail.com with ESMTPSA id jh20-20020a170903329400b001ca82a4a9c8sm164075plb.269.2023.10.30.19.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 19:20:36 -0700 (PDT)
Date: Mon, 30 Oct 2023 19:20:33 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v5 bpf-next 20/23] bpf: enhance BPF_JEQ/BPF_JNE
 is_branch_taken logic
Message-ID: <20231031022033.536yvwc5vcc4toh2@MacBook-Pro-49.local>
References: <20231027181346.4019398-1-andrii@kernel.org>
 <20231027181346.4019398-21-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027181346.4019398-21-andrii@kernel.org>

On Fri, Oct 27, 2023 at 11:13:43AM -0700, Andrii Nakryiko wrote:
> Use 32-bit subranges to prune some 64-bit BPF_JEQ/BPF_JNE conditions
> that otherwise would be "inconclusive" (i.e., is_branch_taken() would
> return -1). This can happen, for example, when registers are initialized
> as 64-bit u64/s64, then compared for inequality as 32-bit subregisters,
> and then followed by 64-bit equality/inequality check. That 32-bit
> inequality can establish some pattern for lower 32 bits of a register
> (e.g., s< 0 condition determines whether the bit #31 is zero or not),
> while overall 64-bit value could be anything (according to a value range
> representation).
> 
> This is not a fancy quirky special case, but actually a handling that's
> necessary to prevent correctness issue with BPF verifier's range
> tracking: set_range_min_max() assumes that register ranges are
> non-overlapping, and if that condition is not guaranteed by
> is_branch_taken() we can end up with invalid ranges, where min > max.

This is_scalar_branch_taken() logic makes sense,
but if set_range_min_max() is delicate, it should have its own sanity
check for ranges.
Shouldn't be difficult to check for that dangerous overlap case.

