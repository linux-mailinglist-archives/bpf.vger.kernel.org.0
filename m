Return-Path: <bpf+bounces-76218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D86CAA83A
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 15:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7E6D30819C6
	for <lists+bpf@lfdr.de>; Sat,  6 Dec 2025 14:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AD82FE580;
	Sat,  6 Dec 2025 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhH1t8a+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428081A5B8A
	for <bpf@vger.kernel.org>; Sat,  6 Dec 2025 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765030019; cv=none; b=IQDmzTPFX7IBCiFuzlf9YYgzNUnNdj1pp+RsWRcWvIDtCCDpos5qVLiJYbbjU9TNNylExjowpfDEefSuuOBdk04rhLIQfcCCyTp64bLApQzxS3Na4pC3+C6JPJHsQkmTvnBFGj+uDWqjOBaJslW+h5pWftRNSCNuAMwWnuoJkBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765030019; c=relaxed/simple;
	bh=vrfLk2ayZuf6l8AqfvNQb2nC/M/gETf+X2/3kIvvnp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRXCDtSjVxwOF19n4tFUl3WOsBWJIcreOf9xTU5muntS9+Nw8h31KcBmBf1MGfJ8m1V280yb2xpQP1wi106FKIvsrJVVP06EvED7xVj5G5iOF88pAt5/JRh8RTB/17UShZKsZV8UARQUSqHdqjkLLZApoCQ1RtZHl8xSZwHEiH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhH1t8a+; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-78a712cfbc0so34803097b3.1
        for <bpf@vger.kernel.org>; Sat, 06 Dec 2025 06:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765030017; x=1765634817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrfLk2ayZuf6l8AqfvNQb2nC/M/gETf+X2/3kIvvnp0=;
        b=ZhH1t8a+DxqcJZzRWPdwIrEFa4OissoLMMeovRnYJ58RyrLlC9Lbve4Rt/ZS7Rn9LI
         9u1N6AUmAjrczf9UfFvDAbMsNIzkE4OxzNI8J18/7pI+Ujik85VPk+3tWZvUkDjC9Ike
         q2p3Y7hYGuJ79WFR5ZZ1oUx/d1i+mf68aVyWqehpNcJe5Q7SdlH5emkYYLfJNZTxiTOA
         RfKCP6xbHZAivaP3KB14PM2xZ+dgYqiK26FoinCFsLt0ej/LYS/hjLCviWkI6R2ovyIN
         LIL1+hoqNucoYTKg84CPWtu/CXeF4byErQKNUpq8ixvbE+7+/E/J/0yDHwx/UnfBjHfu
         i43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765030017; x=1765634817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vrfLk2ayZuf6l8AqfvNQb2nC/M/gETf+X2/3kIvvnp0=;
        b=Bf0H5itov28VYdC97YJqcrx40I/92BnJMHu/FGwlXtj/N+xcPpjAEybvysapYWjNhW
         +9XyOJdYTTCS156wxbk/GprM3BbqLR4E1e9d4OAuGfclaeqMO/WTRdo6fIZVK+eUrmHW
         tHZV8lOIU4B5PZ5oPYBpa3Oma1L3053ySbKdO7A1ZbVnC1MFGTJQTcmh8JORQOOiGj5R
         sMERZmhRu1QfDM81g4ApdJiQH8k6chs/XmEyEWx/oqvmLIt4VmI7SsL/rXPAmHr8O2/K
         WtAUHuspoJImk16xwlzxfWkJH0aglrwgk9v8vYZBppu8ACS7z2w1QNY/skoFEYmMOBXh
         pYtg==
X-Forwarded-Encrypted: i=1; AJvYcCVnwUaQU+gVE89RfI7Z1TnivZpHtHoWxE6VGFfZ/EjkWXsAH3uVFCXCKkoukY8bdzbKaH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtsldAMBUzxysy8kjSDC2O299WWeOEGtpRxwJL7Y//bJtQiSeQ
	oVBTnTwGOgqKjkkmhnI31K896z6ASEQ1Qmlycz/YuAF1mJ3K7pHdDBXW
X-Gm-Gg: ASbGnctBRFpLX1ux4HDrdWiL9oCd0/GJQnqCX2GRViGbnb4ECwyc1AwJDX5SQCH9Q4t
	NPaeKiMoyQWYr5sYmF8RevgpvQoslcAt0387DtE2uderyYFpw8Bfs5w63y68y0tKGSlSBHgmOuK
	1iC+UdaPkyfHYAgw+tuMH8GXNSnvvnTocNpg6LrG/CvuMzQx4/GZoVCWrIejjOKBjxYkjspsBG8
	veoY+Wa1ZpOCpWdRvB9/KMF9N5nyJ9HdHKyXvT8c4P10YKLsIgCBFSXZtqfiTxP9HLqvJlinktb
	+ZttX864z5YwW1ISgNBzp+TWU+PMaXNiOq94nHe7fxazu3KFmyr2aNWMqL85t+mQadxneiQezDI
	czMxGw74E/sJO9nWz9uZqTMl8TpHl9ErynGNkq44dSgrj8DbspVZNZDgRh3nVwtan+ulOtbE99H
	n85DnmNH9+zxR0cyaGHx0rnkuAwRcxhiHxa95fHl5P80p9pFb/KmI=
X-Google-Smtp-Source: AGHT+IFxy8fT1dRrg4d0q8df8JdyXkj7/oD1PKfr96MRoX5/mmgZfjfDMVE7BSdSSFxAui9wnKIK0w==
X-Received: by 2002:a05:690c:7403:b0:788:1cde:cac9 with SMTP id 00721157ae682-78c33b5f13amr19558807b3.23.1765030016967;
        Sat, 06 Dec 2025 06:06:56 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b79942dsm27541147b3.49.2025.12.06.06.06.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 06 Dec 2025 06:06:56 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dxu@dxuuu.xyz,
	eddyz87@gmail.com,
	electronlsr@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	mattbobrowski@google.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	sdf@fomichev.me,
	shuah@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf v4 2/2] selftests/bpf: add regression test for bpf_d_path()
Date: Sat,  6 Dec 2025 22:06:40 +0800
Message-ID: <20251206140640.3013-1-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAPhsuW7NTGkbVD97DQddwPEQR6PZgYQJ6c-JcEsNUg6ddnh3rA@mail.gmail.com>
References: <CAPhsuW7NTGkbVD97DQddwPEQR6PZgYQJ6c-JcEsNUg6ddnh3rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Song,

I have done further testing and found that the initial version of
selftest (LSM version) could not reliably reproduce the issue on a
buggy kernel. I have now verified that the new fallocate test
correctly reproduces the bug.

I will be sending the v5 patch shortly. (This is our first patch
submission to the kernel, thank you for your patience :D )

Best regards,
Shuran Liu

