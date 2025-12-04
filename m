Return-Path: <bpf+bounces-76025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BA8CA2538
	for <lists+bpf@lfdr.de>; Thu, 04 Dec 2025 05:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C02E3064372
	for <lists+bpf@lfdr.de>; Thu,  4 Dec 2025 04:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7782FD7A7;
	Thu,  4 Dec 2025 04:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN8zRAcM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FA41E1DEC
	for <bpf@vger.kernel.org>; Thu,  4 Dec 2025 04:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764823186; cv=none; b=VlqQHN39m78JHPJWUseOERSNQsNl3reAI+cAS02hpqE3w2OH48QBETgLfl63WIQEZkejirQaSliHTb1cEAQwpjmekpC4oTuQAeLEz9pMH6vk2Ec+NJH7wnYRxNoW7lgf5IS+hmOtTGuZ0gqQ+hl4sUdojRDffdSBTyavbcAOHHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764823186; c=relaxed/simple;
	bh=1v+obDT5FL5UYD781R+2FxUuick0foS9CSHwDNJndVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMdc1hv6PdBsy4L5DcrD6UG/yWjRIhWCrvgyJEudsERg5FYKRL1UGQv0dlQgfTkCnygAqR0BXxp/MV92hjFM7Y666mzLxXwcL4JDqAFPtY0uAcSelkEeqzuafpZT2tqw2UOuUD6qQNC/yQjp7Oz6mvvZraBF325P/uJt7RAdaY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN8zRAcM; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64306a32ed2so360347d50.2
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 20:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764823184; x=1765427984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1v+obDT5FL5UYD781R+2FxUuick0foS9CSHwDNJndVM=;
        b=LN8zRAcM6ZWMijDqaTN14taBIPCf1WTSVN1h/+zQRsBpt0JL+HSLRnE/8L2pm7JP6G
         HD9TC0Y/zoHNYLEeBvCJHuRkWSikOSeDPLo77egmdohX0hhF97DyoWtt6gA1xZJkowv0
         /TMPxCMev9PaduTtV6gow1Tpi+z3osZgRmZ2UqZqjPCi65JErICpNHW3Ys1Q1szFMS9Z
         HbIq7QCqw0GB9EnYRACRHp7KFa0YqOjZ89Hv/g0D27wS3lN9T++2W1giRryk9DIC4yYA
         W93s4T+cZ1FA2UUt4FPMCvi26Ik7JaLek0HQEFUhJqRgL7mckEFtN7WSBcDrO79J+jOg
         c/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764823184; x=1765427984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1v+obDT5FL5UYD781R+2FxUuick0foS9CSHwDNJndVM=;
        b=PDfSR+zGoZ50ky/4eKhGrjlK5FHFti6ereBhrTGKDNz9VGSzDNEjC+hZSPW9HvgMmw
         uFMAetKPiOvSc41nvsT6EOHtMVYmNX1dyxvzuYMfG1H0cmOie1SZzdH3efqlLfq2a4Nd
         4EsLTm6YBO6mPOGUssjb6FjbHO+ZLaqs3pp7AzQjs1Cx/cH34qu9B3wV36ysbyxLphhm
         L8zFWzr+vIOmzBLhrJgPJ3dbdVKKQ0N6JYTk8hIAW16xAiOG/PYUxlI7/Z5qz0+CHUBF
         QVu8g7gFVGyrT2GORtZjn3hxi+Q9kdrEafuUC9ww3ppt6zU7908PsosdR36DUvXNvsuX
         U8bQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwTqbqRGw1OlMB4bFnu4cHIym5qDYV/kuzLYaBma0c9JffcQyvmzYMz8o/jVbbytC04SI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY/KG2tFZRv/ncbBpGeUJ18hgJapD60I/5eNJoVJIu3Iu7XDPs
	slHLt3i1nErxiwfYtUplGINdjKb3kfzs8nnBax/FDY/1Yc6QKnRgnChB
X-Gm-Gg: ASbGnctNJGM7uTWIiobYTNU/0/X9OF91IbLotmjP0Vm3GUcYNESJcWxbAIcqLjzsAIv
	QhMaQRWhVDgZAhFGx/GoDOxVJ3uG2y/A0YJZPID0DmQjyYNlJeTektoUVA5AI0uDSwXcj1PIRPm
	oSuoT/ueiUepMqoRNy6fgjATRGvFALkz37sL8wib/Ahr63yc9W125vLQM6PXn5lSeZHsvADLfSD
	2txGzrFz6OaKQ7PGpy72x/KiJLGxXT5KosV51vHif2liHnmUSKTJLDO1SEX7nssTP8e2C8rtOMZ
	vKqrfokBqKBWI2FEF99DVOgifZUqcez2kX25H9ac9bPiW1caPy6HiDzMO8O/ggSb4aspSo/DUPQ
	JfZiUzoR+BkyErCVTxip1ih1yYojtKeX+6u9gRR/jwVAxqElUJWrK/Unhsv/vNtdU2xTLdbZ9tS
	uzad2SkMbL0Z4w//mAlpfhJ5NPyoSeJL93jkbMQHA91i685+a8m4c=
X-Google-Smtp-Source: AGHT+IH+6A/k1eBrqPWGoOLVGIDgsAJpEnT7ttLjvCmZkGA+Win1vr4rqv9Mub3s+PQhK4zSBz7kWA==
X-Received: by 2002:a05:690e:128e:b0:63e:350c:aea4 with SMTP id 956f58d0204a3-64436fe779fmr3579945d50.32.1764823183787;
        Wed, 03 Dec 2025 20:39:43 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6443f5a3e81sm246719d50.16.2025.12.03.20.39.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Dec 2025 20:39:43 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: mattbobrowski@google.com,
	alexei.starovoitov@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dxu@dxuuu.xyz,
	eddyz87@gmail.com,
	electronlsr@gmail.com,
	ftyg@live.com,
	gplhust955@gmail.com,
	haoluo@google.com,
	haoran.ni.cs@gmail.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	sdf@fomichev.me,
	shuah@kernel.org,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: fix and consolidate d_path LSM regression test
Date: Thu,  4 Dec 2025 12:39:14 +0800
Message-ID: <20251204043914.7580-1-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aTARqrMyC36CXa_L@google.com>
References: <aTARqrMyC36CXa_L@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt and Alexei,

Thanks for the feedback.

I have updated the test to use fallocate instead, which is in the allowlist of the d_path helper. I also minimized the test case while retaining the ability to reproduce the issue.

I will send the updated patch shortly. Thanks again for the review.

Best regards,
Shuran Liu

