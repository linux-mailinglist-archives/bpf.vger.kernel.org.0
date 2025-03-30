Return-Path: <bpf+bounces-54899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42066A75C20
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 22:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1EC188A9B6
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 20:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650541DE3C8;
	Sun, 30 Mar 2025 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I1g4ZzJ/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3342BE67
	for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 20:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743365341; cv=none; b=DdRv/Cm7m+uV+91orkhgUh2jo1yYvZkVGVkSL67FuYPdIluyEBlnyizxUQFQwgTzpEdiRVybjbRfePK2M3MG0GqSqwJeH98lF64I0bhOQASyLSHpHtR6MxK0nPh8q+WN1sJgqyaWMCTlEQ+jNGKZMd+pQ8dErwiWGjmhBojzXAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743365341; c=relaxed/simple;
	bh=9VI/A1wQaOhkd7eZpmAwmNPePm6byaoOQzgCYHgz/Qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuct+om9T2ehqlMznB/NiBKHwllE6Fc7+euBXiOi5iyVnBHJIQhEHqGnoJWtAeM3vz7XOKopo+IBoW1173p36t63YrjHnD0aAjIqfVldapDzQVwUR+/nxu9rl8RYtj5Jlyu/lICEZObMT5bSQ0YJ4rh+NKrqN646nu5tesPPVZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I1g4ZzJ/; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso775660766b.0
        for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 13:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743365338; x=1743970138; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FQdIPIBIFPsMXzbqA6bIdMRDw0puL1K2JM/M9dMbXWQ=;
        b=I1g4ZzJ/bBpUY6AOI3ey3/ZwtbFO03prl27NomzzYDAvB+GOEje3YrwH+YhrNMTxQw
         VEQoqvwsFgV6eKY0gWL4m6nPRbqbNWxYOJduoMUw13OPoBoQ5dFc0WxCrMMBqCmC/Gzd
         mEwce05We9MIdXmkyRyepZLirrervwBTeOhyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743365338; x=1743970138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQdIPIBIFPsMXzbqA6bIdMRDw0puL1K2JM/M9dMbXWQ=;
        b=kSSjh5ZS3+DNkY6vU13SdBMWtw4PPU/80i+Wdqzs6C/aMFe0VpP+HVbeHuMmGQH4AN
         r681/nGxxJQ9mY9DhSlag+9kbZFbg9UJiO7aNnMkOmZUbdfEOYWnl112VZpdPe4LgN8e
         ZAwY2zaooaolT/Iik3n7XdMZMh+PRYTtR5g8SJxD5bnmQRpG14++VpG0utcUTe6kjtVW
         wW8Vcyzot12jSzdg0JaaAP+/8RTpdok78FlZg9SwPG03tltnX07PcynzSo8gg7LuXKDv
         dHZGFPd5o2Y5Fyi4JZ/Os57Janc2Ac8xdk4UBPToL1K9MAkTScFJHKt/EHZ33kD0BRI3
         ueQQ==
X-Gm-Message-State: AOJu0YyBAiBL/N3pc+IkdJo9VItzVe0hkInblnQSt84NzfdUXywxNBRu
	2h55VFemVh6Dycl4BMGAH5vRbzTUxvQmv1L17ggHXxltcmKthhY/cCSEpP43I6YFtPJ9gkYEc9t
	f6KM=
X-Gm-Gg: ASbGncu8VtBq2Ijc3Szx+McoHOTlhPjWv5AQw1SnzAtXSlq1Q+G5YYTMM2j8YoHYYn2
	0EedutagUmmf78dRhoeoptL6lFRekKy5P1WIRKGYq5Va+JgUCrNsKvlEUMA5k27JKpYB8vPu9cI
	UZ30GARkYCp01dPc6XAORJTEuCcKEKFpqrx/vSxveK9qTiu4daNMvs0m3+hOCufmK/mwQRrw0Lk
	S/yQH+L1Lrl1oQGBecVAkgTE/E3NVjQOd8dlLwFt7tRsRY4VJ7vBY/6OTE3gkTJ2UXuNRy6Hq+m
	NR024cLLulUENSaQ8WeBtXa9Ya5cBGYlvHoEpMgPxyOlG6xUhJApgqC/GSqhjIW2dAxf8yXTFXt
	IKeRe+6aR6e5JXRxvScsjp6e+zWv7Fw==
X-Google-Smtp-Source: AGHT+IFDFQE/ekBch7sieYsjR6+iOyb50W2oS9I51v/BvFoee9MXU+f8RatNd4Piy+2gIQhd6ZPx6g==
X-Received: by 2002:a17:907:a088:b0:ac6:ba95:dc02 with SMTP id a640c23a62f3a-ac738bad240mr530996066b.44.1743365338084;
        Sun, 30 Mar 2025 13:08:58 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7192ea08esm516247366b.80.2025.03.30.13.08.57
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 13:08:57 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso775658866b.0
        for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 13:08:57 -0700 (PDT)
X-Received: by 2002:a17:907:3da3:b0:ac3:4227:139c with SMTP id
 a640c23a62f3a-ac738a5064dmr549397666b.24.1743365336889; Sun, 30 Mar 2025
 13:08:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327144823.99186-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20250327144823.99186-1-alexei.starovoitov@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 30 Mar 2025 13:08:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg+nyd6Cqnw-vVxvVTTW31zOyBOHO0ak1xPFX5C0qut=w@mail.gmail.com>
X-Gm-Features: AQ5f1JqZpY881qm9M5vJvGClsN_VOWkQMfOTIJY-M64XcTRU-qfDU4LkUOiqPUg
Message-ID: <CAHk-=wg+nyd6Cqnw-vVxvVTTW31zOyBOHO0ak1xPFX5C0qut=w@mail.gmail.com>
Subject: Re: [GIT PULL] BPF resilient spin_lock for 6.15
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, peterz@infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Mar 2025 at 07:48, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> This patch set introduces Resilient Queued Spin Lock (or rqspinlock with
> res_spin_lock() and res_spin_unlock() APIs).

I would have loved to have seen explicit acks from the locking people,
but the code looks fine to me.

And I saw the discussions and I didn't get the feeling that anybody
hated it. Merged.

             Linus

