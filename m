Return-Path: <bpf+bounces-78676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFBED17A3F
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 10:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7775630E1519
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 09:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC8F38A2AC;
	Tue, 13 Jan 2026 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9YB+5k/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEBB32A3F1
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296195; cv=none; b=Ue25KuB8ixuiqrK3nunGYlvNwWf6bOYFV9QkmO8FwhYZggc4pTeMqT1IR7Azy+BaZP1ulwxSyutXgOMYckOPD+XXcyafJdU8dzsshwUebYiqs64Ry0Z7KXb8K+t+VTn0lYTQy7JFSNJMiMOJIgCrC57EYRvn0SiHMFlzMFu1gy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296195; c=relaxed/simple;
	bh=VcgMZK0slP5/vktmw6e8SjCVahECRNkXO4RFOclwx1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pB+Z5cZ6fvTBoQ5Ct76+7jNYj2P7Tva18k4OkU7UVMrqBOLQDvh+TFejD3LGqIBisglvUpFUQ9SgSCEDRAsp8S7gZtqEcLF0K3BjpnsSUIVbt6gVDfnPrfej2hycFvD4+s8+ERNzFG2g3q0X/uG5Mccg0eMzQDqjmwS8qK0Obkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9YB+5k/; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso3845866f8f.2
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 01:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768296190; x=1768900990; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VcgMZK0slP5/vktmw6e8SjCVahECRNkXO4RFOclwx1c=;
        b=U9YB+5k/og+48dn9+hjqq5+UalZuySw3Vmrj59OpKYx7UPxf3Eezn9x2ZAU8H+RQ7E
         5LGUIGUM4uOcAHPeoFR8qYDtp3ECDjVg62bbeeu6vdLUvFzt0MSdd03Pd+Whpgh9akK9
         F7uQxbQwQKYj+yWspFfBBDa6xXn3r4hTcn0Sh0ZXzcKfUP08KQEklkyd5tb+J38B4ULZ
         SRVy33vcx5FkjK1JGEt3XS7tw0J0RESLk9KK8+NOA6B6176hOtArQi5QBkGzElIxddIN
         GJhYMjvoetGviUBuoNnrLFiacsjdtAe/A4BPTclJalGIkyoAYiDR/PVTbYDi400FJ0MZ
         XQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768296190; x=1768900990;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcgMZK0slP5/vktmw6e8SjCVahECRNkXO4RFOclwx1c=;
        b=CJEDfniknoesM9PHezaudnG6YPJDlehOaaQi6jiSsOn0LzVlwA1L4++DdE9XrvPY2T
         skR2sFYmNXPaRdJI+ojydPPHSWTG+yOkPUHrhrHvWzS7G4YKUOD1C9jiHhuWZZRWniXS
         ENggRwfdo/6kpbEdbIV4vP6k04Cb9LMUJRyk5gEqAcS0EDwqFToQu5mqKEQbnLQ+Un7G
         2SNbIIuCbEoBtuodhZ+ENu6teHr/FsP7LMFlhd71+fufCooj/NCUuL7TLsgtalw2Eiq2
         LJzT2H0d+YfJ8b785EFEwaCAsZ2jJcbZKiiD7XS0R3ZjhOEz/8LcwrWe0ikvTEF5tzIe
         mBOQ==
X-Gm-Message-State: AOJu0YzlYdjtCtgRYB52NxF12U6Gte8mFGsXTn8wnY1me9HXyIugbZvf
	ZnXk5T8jYCQovmfMHt4zi5geP4PFI4lbghau0zGEBZ43NLz3b6rwDhISF9rKLszXsph79I+s6KX
	Dl1V5NekFYL7Ob5F+iePjr7Ybcn2PZ7DPwJGh
X-Gm-Gg: AY/fxX7guQsZ4HyqZ1ue5GT4Bj4snU9yFH52g7Nb1PbtZhbJOW25QWeC93zz6Ojhctq
	44dAeOhl/pNYs73EPvD5onwi5wvskUz3QiAUHomL/iQvJOwMzXyT20DHqD1jGsOepcBJaVDk2k2
	cBTJo0TSPTnz2YisuuDZOxP16z0jQiwztxHPe5rfIKBMWuO6jKolYreA2hncBEGshKNNgOK3QGW
	/I6WKh8NjvvjIweVbzBXJjr6il6VjQoViSnekGtYuGUpZXliZJXnIa/ySpDD9fwKTs2Bbpcroi3
	/7Hb0eCdsHU8IlXZaTGuh7ryJ9QbPA==
X-Google-Smtp-Source: AGHT+IGyh96HD7rkhmqZ359MqiXyCf10i2Xz/W3LNpEENekURHVLuh8IhyXnHh2PgJVdz1WISJWdu41tXHxfUox6Lhw=
X-Received: by 2002:a05:6000:200d:b0:432:8504:8989 with SMTP id
 ffacd0b85a97d-432c37c32bemr24928000f8f.56.1768296189835; Tue, 13 Jan 2026
 01:23:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113083949.2502978-1-mattbobrowski@google.com>
In-Reply-To: <20260113083949.2502978-1-mattbobrowski@google.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 13 Jan 2026 10:22:33 +0100
X-Gm-Features: AZwV_Qj00U0tgo1eEqCpzPe0VgLMqKmYlbuu8DyZojukBgq-qksaU-jmPgCsxfY
Message-ID: <CAP01T77zqdBZRm04GOz+s+aGuayzL6QNRx51TxwjEDZRetw1gA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: return PTR_TO_BTF_ID | PTR_TRUSTED from
 BPF kfuncs by default
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Jan 2026 at 09:39, Matt Bobrowski <mattbobrowski@google.com> wrote:
>
> Teach the BPF verifier to treat pointers to struct types returned from
> BPF kfuncs as implicitly trusted (PTR_TO_BTF_ID | PTR_TRUSTED) by
> default. Returning untrusted pointers to struct types from BPF kfuncs
> should be considered an exception only, and certainly not the norm.
>
> Update existing selftests to reflect the change in register type
> printing (e.g. `ptr_` becoming `trusted_ptr_` in verifier error
> messages).
>
> Link: https://lore.kernel.org/bpf/aV4nbCaMfIoM0awM@google.com/
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

