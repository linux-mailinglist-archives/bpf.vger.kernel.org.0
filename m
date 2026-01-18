Return-Path: <bpf+bounces-79379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFEBD393A2
	for <lists+bpf@lfdr.de>; Sun, 18 Jan 2026 10:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B2513012DEF
	for <lists+bpf@lfdr.de>; Sun, 18 Jan 2026 09:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431632D59FA;
	Sun, 18 Jan 2026 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPnp3n2s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7C92627F9
	for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 09:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768729625; cv=none; b=cwOsiphQ9URfQoYt9ESd2aSDVlMQTHG8jq8IsOr4jlCRR4kIPn2GYmj4lIKbY4S7TJwGutRGJMDd/rfv4ltKvFFfaU6xMJVVl+r34OH4ch/OQJePniPGfUIqcRMgE3Da6bI1Pr1jawM5BsNvN/WqOCfqgkxxBWyBy0BdbkdWs9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768729625; c=relaxed/simple;
	bh=j4OPPDW/74ha1WGeXgcoYBSIWCPNDJsKlZ0pobuKQaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mj8iOS2msEriyver6yhhqJw8dGJ5ZV8Aqb2rn9hFZBojg4Xt9dV1rzUt3FzZEpn+t+nE8dAdkvHIeTOY5ff1g0QBTDEPxKNM3G927aaD2UYSsm46MdJy1gdZ2Cm8crkKKXmzRVA1oyXwIjUOgyhtrjeQOWK8FVEa0mp9372qBSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPnp3n2s; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0f3f74587so21586515ad.2
        for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 01:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768729624; x=1769334424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z21LqYe490CvSVyt/WeDpi46bN7C4s6bSKGlg1HJyZg=;
        b=KPnp3n2s68hWBGXjkjWEDBBJLqSTIoiKsWVx2X+zghg2vAKFmm2/cfEidiz/ZJPPIg
         Uaba9X1kZs2zqZzz2BZWX86/AIg+V2/y2NGDFxpBPh09eyaTOAiMh30mGyu0a3FCGOhq
         +NDvN1fbZnD4PPYgzEEmvFlJe5GArk7HxHg72D7qN8onYnYW6V5ijdIT1yeSPxrSHL+k
         Hf0ikdWd9JXAKCQoQ+qojflYHu4w9uhUkJc6sYmx9tKxoHFwefini0ZBdJ+JJ5G0yGE3
         CpxJya0iPUC+2RgjDdTh1PmLLhboyhZQf/xkbwEfaElSsLLWGtPhTDozb4ZNGn0KYSBo
         TM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768729624; x=1769334424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z21LqYe490CvSVyt/WeDpi46bN7C4s6bSKGlg1HJyZg=;
        b=oQJ5t4y6hxHQSGtHd3rRGykQtaPtPx3TaVNjii+2yGt6AVQ4/thNXtXNHbZHzW3KEc
         us0Znx2PRoc6v7k1BOF9DfAjxZomqXQNiEMCK+pEeGNoXVuYDJWT6Bq9seZyupHe6xjM
         amEyFJp3mpZj+Va8eNUEhpAij4JwICKQehVUpmx8/Pgd4bTlf/UjukRi7lA64W3zLbop
         dVwVMt/YxR8/umoZtXeKGkoi/pspod/+FOpEMqCNPPGcIN3x5EzrkB8j+Kz/i8zswEh1
         3GW6blbiyTUYFzrJLrPfqqkll005fnxAO0fZQMkiToz1pa27yZaCrw9JpdKqr2ldBVb7
         FkXg==
X-Forwarded-Encrypted: i=1; AJvYcCW2UYQCvw0EHWIP8Q5JEyuVU4K9YOgRDO2W1qCFHBF2D/PaQjuEO4ywr0412rRND2FEK8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwULAz9HEgSM8Q/7GYCVdBcjIE/UA5rZWt1MvedofLFfLACoPft
	u/gR0ZdgELN7VFgKoj5wGhPyfzJBs3xWL2ZzADEUWuG0pUQxcwMo4Ieu
X-Gm-Gg: AY/fxX7wE9WkDSNv/jfo/vnTIGsqDon8qAqaCbJo60/BlXB64EaW93uTgfBXvDtUnDJ
	7qDYzFOX7jO5qfST/ausCxjEUvDm+Wi2b9QeQvOD6ZEOpIb9gpm3zgr7XiLB7rT4xmQl211nEYJ
	rMjiflPrU5Y9c42c6CzEZ8LxzzH/ZDqo7MGfljXXeHuY9k1b3QrYK7Ey7WKYKyXRPdPjFhVoQHM
	hqc96IZ+5aYtf5AywxWTx9qQXEOkkRdZx3N9rusLnPAZuTt8Yx8OtKYjbwVM2CJXwPpt5uDRj6F
	ufQXBGfcqwoAlCx8Gy1FxWO5L/EREqArpsQt+NEwrO26T5DOIDBFcZF40/eK3tdQCzFjt9uO29s
	IA7ycHsKpyhanWX//PpTysdJX9KMswckKnqcgr2w90N49JXXxaqJqk09nJdmAbEXIDH8TZ3PDnt
	FCGspug6qAsubashN1CwdLXD8=
X-Received: by 2002:a17:902:c40c:b0:2a1:35df:2513 with SMTP id d9443c01a7336-2a717533c8dmr78891125ad.17.1768729623779;
        Sun, 18 Jan 2026 01:47:03 -0800 (PST)
Received: from localhost.localdomain ([138.199.21.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193fab6esm64932185ad.68.2026.01.18.01.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 01:47:03 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: menglong.dong@linux.dev
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	realwujing@gmail.com,
	realwujing@qq.com,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev,
	yuanql9@chinatelecom.cn
Subject: Re: [PATCH v2] bpf/verifier: implement slab cache for verifier state list
Date: Sun, 18 Jan 2026 17:46:36 +0800
Message-Id: <20260118094636.105625-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <6205668.MhkbZ0Pkbq@7950hx>
References: <6205668.MhkbZ0Pkbq@7950hx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Jan 17, 2026 at 7:27 PM, Menglong Dong <menglong.dong@linux.dev> wrote:
>You can put the link of your previous version to the change log. I
>suspect the patchwork can't even detect this new version if you send
>it as a reply.

That's because I used another username and email address before.

>You introduce the slab cache to speed up the verifier, so I think we need
>a comparison, such as how long a complex BPF program can take in
>the verifier. If it is no more than 1ms, then I think it doesn't make much
>sense to obtain the 5% speeding up. After all, it's not a BPF runtime
>overhead.

However, this patch can accelerate the bpf verifier, and the same idea we can use to 
accelerate the bpf runtime.

>I think we don't do it this way, and it makes the patch look a mess. You can
>reply directly in the mail.

You can see the guide of --- from this url:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#commentary

Best regards,
Qiliang

