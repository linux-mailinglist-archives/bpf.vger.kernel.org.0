Return-Path: <bpf+bounces-43902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC099BBAF5
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 18:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282561C219E2
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 17:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5BF1C8781;
	Mon,  4 Nov 2024 17:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ii04fnKr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B301C877E
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739733; cv=none; b=sd7jvWtSlQxY40JDX9fzIrY59CCXGGWy+K99z9xIDFXKhpX1E5iQz61sApbV/nvQrxteRDs1fQVPwMCi7fzdOz2Ji5f+AX8Hb/klsfrmAuyUWgkMD8QhSOx1YeVpMIpg4m5JzgvZKjLX7JyKyhDbN/23Wn7k0a16Vh3rjScRPeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739733; c=relaxed/simple;
	bh=QdRv9uOU22Sb/+HCq8kedT7FQybNLUb+SQ3H42Qq34U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6l9AO3ODlZi+LUfbyz9dA4VF6bylZ1ESDs3s9I26wcS5MxuHbwm9Jse6Ef3OsIdgEisXd1TYqTDvl6GbYUXmI7yOCiN55ld0kHtxQTdAWAsFEBiBfg/6iPIxm3F205oRd/WdWFvG3VESQEEkBrq2CH6XkdSyZN6RQTpkHlwkCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ii04fnKr; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5c9404c0d50so5487898a12.3
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 09:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730739730; x=1731344530; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dfqw8Co0luSVWrgjjUhea9y+vUV2VZdbmxtnFWJNZj8=;
        b=Ii04fnKrx7wbyoJPZviiQld9KWN9acdpZMfpFblIuj+zcXhYxUQb4cfCt4s50cOImm
         vtebwiH+1n1pN9RRrw33RbzhCWJf/l26CZtxIXnfV1WH8RwzYX37DhRbNn220fQ+17p+
         dreqsjjUFIS7uIGe5vbD4/PuosBtX8vSoBRV5x5NU1sTZf6gY8HmI9MD/B9R7qeLNyDw
         wCIWq4bCWXTyRebiP6nZj6//RgF4hLlmrQZSoQbmOFFxzGo5+HiwBHj+m9dQj/WrkpGO
         XzrDF+cVYLI8WF9+t2rP0FGv1Y0/qWNVtGtF+1F3eN9I5l8HfY/SnbIvOygbDjEYvpIe
         cW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730739730; x=1731344530;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dfqw8Co0luSVWrgjjUhea9y+vUV2VZdbmxtnFWJNZj8=;
        b=oWDkY1wNPmY5lboer0MYTX7g4JPgMPtfAxAQSd1jRMcei4KYhgUKHKxNyjPyMHb/dL
         liQuaJLIQgNwfDzBpWnMchkG/XH0Ck/gCBNPeMN3kpdtKfuOfO5kdBQYFafIpeMyFu0v
         Q1am/nvwnY/A51LFm3E8uS+Mx3MZP2+4kKklfW5+Pjxk1di4xRui8Qw/bOT6gALEX+9s
         ay4BH6a78AXphrAh/ZSIRl1jXxBBeme/sTp7Be8906dG2Idg8bwPGYjEzNk4YlLkokF1
         +XgvpaXl+nJlGbGP29/OcFNXFUMAo0SPlfG09yRdGw2oG2cVvq/AnOj7+ysmKWlmvIZB
         hKQA==
X-Gm-Message-State: AOJu0YzxjTI6vSkZxNkGqoVPG56BdGQw/swpZ7hN0IMBKoav71Q/biUc
	0qHGt9lq15Cl7RxluMQY1yMUToDzPa/cFlF/gC+kkNHGPYEZ1P4JnzNdHbJWnYJUxCbDV6IF1fH
	9RoNdl6TzAcajw2PmhfA4xceFgEA=
X-Google-Smtp-Source: AGHT+IFg56zX7K9pf29w5dTYAkhhvlR5dhmnDo4QtSES3/PjZvm1rGKP1ULEuBvA6Jt8VeX+TmoqcR0e8eEyAA9jt9A=
X-Received: by 2002:a17:907:7f07:b0:a9a:17f5:79a8 with SMTP id
 a640c23a62f3a-a9de5d6fad3mr3336650966b.13.1730739729948; Mon, 04 Nov 2024
 09:02:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241103193512.4076710-1-memxor@gmail.com> <11519ad1-12b1-4bda-9f53-6387f95ae61c@intel.com>
In-Reply-To: <11519ad1-12b1-4bda-9f53-6387f95ae61c@intel.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 4 Nov 2024 11:01:33 -0600
Message-ID: <CAP01T77zs4x9vvtdPJP889bLja3EcuG6V9PhvZA9gRNmS-q6fQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/2] Zero overhead PROBE_MEM
To: Dave Hansen <dave.hansen@intel.com>
Cc: bpf@vger.kernel.org, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan <puranjay@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Rishabh Iyer <rishabh.iyer@berkeley.edu>, Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>, x86@kernel.org, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Nov 2024 at 10:48, Dave Hansen <dave.hansen@intel.com> wrote:
>
> Next time, could we please not run the patch subjects through the
> marketing department before sending them out? ;)
>
> This might be "zero overhead" for the BPF program, but it adds new code
> (and overhead) to the x86 page fault code.  The new check is *not* zero
> overhead.

In patch 1, the kernel is about to panic after entering the branch
where the check is inserted. Branch is marked "unlikely". Surely this
is not the fast path of the fault handler? The patch subject is about
zero overhead of PROBE_MEM.

