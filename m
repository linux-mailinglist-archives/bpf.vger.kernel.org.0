Return-Path: <bpf+bounces-79189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1EDD2C542
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91AF73038065
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 06:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C812534D385;
	Fri, 16 Jan 2026 06:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCFsaXke"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08540346A0D
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 06:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768543667; cv=none; b=IS6W/rzFjjClLZZgOtuQ4D/N+gTaBO3UNXiog1sWgRtSuonye/6YQ0KqIpCzT3cF1h73BTWzT2rr9T4DPlIEpDMAqA0vascWygnWXaeEuW8EObfqe8mBwtlJHkjzmG4/cJXvqjgv+B3qx+UmEBMIv0eqrEjPkBErOwd5mIC5xLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768543667; c=relaxed/simple;
	bh=kAo5GY2HOD6erJYNvhZLaghrrNmaRoiKlocuVXULrgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PtrsNOwJ+m1skWWcZKW6YidTe9r2R0P6yAB1pAr9RlKZtUkz5BYGFzen/qsETCsafP76C/ydPITH7zLNIQIA1ScGKHFnkKAksGTMciQDwKL50dP+K3wXfMjhkeCpOqXpeXDcWxPjQowkuUTKiObE+/1PEqNdSldxsGXGoXyaGfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DCFsaXke; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2b4520f6b32so2315567eec.0
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 22:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768543665; x=1769148465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+wYykjIWhJAiIrhxgUD60+twdlUXB8UVk9AYpFC0BI=;
        b=DCFsaXke/g+BNw5n4OT/QeugufRAUf+/GvNa+VMh1uEtrMpuuJ/+JHfDjZhOygls0T
         YxSdcag4rzHhCGq8/bn4ZOlfVnaDdxZOYlQ59hCmY64U91E8T4fq1PE3LMCEIE0CUPHE
         DSeIZk77E3PYivj45Sa1A5ZzNfVjzkh5mOgajjtJSpIU0vWnUj+xv1TZWmybNjWZiv3Q
         9ZCCRI22sKcS32rwiAyPOPpYqvI4VvCCHQVWzBLo3/Gve+krAqjwUWMW3bGt21DDnEbF
         tVQA3/MlnCiGNStpUWUktNoP9KZVTpKNHIWugEqKSt8PsO44jD6q0epmI1isGTmW1Sn2
         eBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768543665; x=1769148465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6+wYykjIWhJAiIrhxgUD60+twdlUXB8UVk9AYpFC0BI=;
        b=MU/xf10pMTvQF0dLvsYNhNPiuiVD5sHOwVOCno6xSslNCP1TUGg2RsKeb2YGatkqPw
         AlbXTgKR1j+h8S/gIRrwXHWBXRR+wvncri3CBcoZ01Tab2iWh6KoXjqrgpasBAYfCq6d
         69fMEzCJVOxZJte3gA4wuC8u8ZQrcdEC4X9ZuBmReQuIcqTHcI4uqw0JVq5h2WtOgvDW
         L0asAG+Cwr991UQHGIVZykJqVv7S4NNnWRPFizNDOiWez7E/2LE5wP0KzkxaTSy+B8Dm
         89deLe+IbkTN20QjjK+fXNfBzojfeDHb8noH7AorFiTZHMSb0agQ6803n26ouN4MyM9c
         HUQg==
X-Forwarded-Encrypted: i=1; AJvYcCVkjcDIpeDg2+wR6p+MyaJWh/a9I+B2UIC9ngiKKqRAO1EIT8vdvxyLTB8KR++txE87Rps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWu0GNy1iGYb1YdI8IvshbTa2wLu5SQxt9JA/YsW9r6xfCnlDG
	mcvmBw8hkrqN+moEN1yHSMiOmJw5kR1hPkh9NY4h9xqMCVYWGfLIPXcT
X-Gm-Gg: AY/fxX6ea+iDmS/lPAzjBb9UJBI28k+sPtA5ypAIU//BlKGbxf2G9x8ElPsWuixJ7MX
	TOp3ae6LisWmFgC3GKtvTVOU1DOO3dVmy6/2pAXqr+hRtGGXYiIFAcFJPEyKGS96pBlUkjWPyxI
	QbIEi4+C612EcMZtTm+GUUTYey9A/9K1MgRfTvXnkqGHbL3T5QBxWU1bcgPbmceUM92tGOMfEPI
	qYN+fY+IeDeJ8zfXIo7FcXxctRw2WMMAEmGMp7XaoBQMST7ugxUsLv5xbVO0PwN3g2KTAQzUG7o
	WQSZq89IaTMG+DTifDddZVAn4eWYmaVMTKpo6MNVQTu0pkN61JBTo2MOk+G/TfP9KfOZgEPew3J
	x5ntiI2JANMiubeyLw3Mn2YRHukMads5is5okJBZCxO1LY94gTagRVSRw39R/JgPO1TLy9zWXg/
	5OIHikXs3Rx27epPrAyfgzZTJ5NLOOf5A9+g==
X-Received: by 2002:a05:7300:6420:b0:2b0:4b5b:6820 with SMTP id 5a478bee46e88-2b6b40b392bmr1797267eec.26.1768543665004;
        Thu, 15 Jan 2026 22:07:45 -0800 (PST)
Received: from localhost.localdomain ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b361df88sm1239546eec.18.2026.01.15.22.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 22:07:44 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: eddyz87@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	haoluo@google.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	realwujing@gmail.com,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev,
	yuanql9@chinatelecom.cn
Subject: Re: [PATCH] bpf/verifier: compress bpf_reg_state by using bitfields
Date: Fri, 16 Jan 2026 14:07:35 +0800
Message-Id: <20260116060735.35686-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <7ffce4afdb0e859df7f0f87d170eda31b66a5b2b.camel@gmail.com>
References: <7ffce4afdb0e859df7f0f87d170eda31b66a5b2b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Eduard,

On Thu, Jan 15, 2026, Eduard Zingerman wrote:
> varistat collects verifier memory usage statistics.
> Does this change has an impact on programs generated for
> e.g. selftests and sched_ext?
> 
> In general, you posted 4 patches claiming performance improvements,
> but non of them are supported by any measurements.
> 
> P.S.
> Is this LLM-generated?

Thank you for the feedback. I would like to clarify that these optimizations
are the result of a deliberate engineering effort to address specific
performance bottlenecks in the BPF verifier. These improvements were identified
through my personal code analysis over the past two months, though I have only
recently started submitting them to the community.

Regarding the impact on selftests and sched_ext: I have verified these changes
using 'veristat' against the BPF selftests. Since these optimizations target
the core verifier engine and structural layout, they benefit any complex BPF
program, including those in sched_ext. The results show a clear reduction in
verification duration (up to 56%) and peak memory usage (due to the reduction of
struct bpf_reg_state from 112 to 104 bytes), with zero changes in the total
instruction or state counts. This confirms that the verification logic remains
identical while resource efficiency is significantly improved.

The specific order and context of the four patches are as follows:

1. bpf/verifier: implement slab cache for verifier state list
   (https://lore.kernel.org/all/tencent_0074C23A28B59EA264C502FA3C9EF6622A0A@qq.com/)
   Focuses on reducing allocation overhead. Detailed benchmark results added in:
   (https://lore.kernel.org/all/tencent_9C541313B9B3C381AB950BC531F6C627ED05@qq.com/)

2. bpf/verifier: compress bpf_reg_state by using bitfields
   (https://lore.kernel.org/all/20260115144946.439069-1-realwujing@gmail.com/)
   This is a structural memory optimization. By packing 'frameno', 'subreg_def',
   and 'precise' into bitfields, we eliminated 7 bytes of padding, reducing
   the struct size from 112 to 104 bytes. This is a deterministic memory
   saving based on object layout, which is particularly effective for
   large-scale verification states.

3. bpf/verifier: optimize ID mapping reset in states_equal
   (https://lore.kernel.org/all/20260115150405.443581-1-realwujing@gmail.com/)
   This is an algorithmic optimization similar to memoization. By tracking the
   high-water mark of used IDs, it avoids a full 4.7KB memset in every
   states_equal() call. This reduces the complexity of resetting the ID map
   from O(MAX_SIZE) to O(ACTUAL_USED), which significantly speeds up state
   pruning during complex verification.

4. bpf/verifier: optimize precision backtracking by skipping precise bits
   (https://lore.kernel.org/all/20260115152037.449362-1-realwujing@gmail.com/)
   Following your suggestion to refactor the logic into the core engine for
   better coverage and clarity, I have provided a v2 version of this patch here:
   (https://lore.kernel.org/all/20260116045839.23743-1-realwujing@gmail.com/)
   This v2 version specifically addresses your feedback by centralizing the
   logic and includes a comprehensive performance comparison (veristat results)
   in the commit log. It reduces the complexity of redundant backtracking
   requests from O(D) (where D is history depth) to O(1) by utilizing the
   'precise' flag to skip already-processed states.

Best regards,

Qiliang Yuan

