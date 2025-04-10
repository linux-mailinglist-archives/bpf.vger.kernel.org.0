Return-Path: <bpf+bounces-55654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF71A84380
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 14:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C591B80B9D
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 12:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDC92857D4;
	Thu, 10 Apr 2025 12:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knB0CNbS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7791B28541F;
	Thu, 10 Apr 2025 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744288889; cv=none; b=Sv36aTVGYPlzHzR0qY2kjAyAFp3CcU3k43bTU8DWrjx8osZy4EMZMBWR/jmwcLZx6t+Mk2sBPASpCrK8/e3XpXvX0NNbYrpcqJXOWqz1GR5RD/KF3azjVQ1FsqAZNWHhX+HMJPJR7kSUx/6pEE8TYpQmDuiUenJHR/34P1WOvMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744288889; c=relaxed/simple;
	bh=FdnbocKbRHhtLFIRneUZ+/1khNFKq2SMICJ8698GBPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6Zey62M722NUZhdV/ctbZEQJs7JQIWTP3f7dP+3PEk3/HMJ3/HPIQ5Xm05r3NDKZgEbL0qxVAMgWJZoiwUOyddU6kEy3EwoCt1BWjZq7QKGg5T+Ue/t35n8B0gW/m6EfXCuwHxEkoVY4tGVqCsXB6LYtpvLoTLcnES3wV2cfOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knB0CNbS; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-39c1ef4ae3aso468723f8f.1;
        Thu, 10 Apr 2025 05:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744288886; x=1744893686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdnbocKbRHhtLFIRneUZ+/1khNFKq2SMICJ8698GBPY=;
        b=knB0CNbSLyrwtTrRfh4BztPMuwF6XuwgMpMDo265lQMxCg6eabs1rMwZ5TwqYxHuek
         6YeZp70z5Ni2jVxZfEm/HWJkyEzqslEpts2lirzbsLFKWZKcVCvQkiZ3+BGqKxV4oS84
         Nu4bLpsCCD0xMJ0bsUjzCft+fezPM/cVhkW5KcZ3VlTyYRe3Q1ADAZ3KEUisS3ktMILK
         C7uIyLELxAuBpwaxAscmXzs1eA4NgjRRhxkUWBI0NFyIQu32/HmZ6iOWuC4AoQr5neTU
         i3jMZ1QjcyD6IhwZrLt7gGHYRXXHpsk5TjD3oOJC6Sy+TNx5DG5QjPuI+/jXTESpZWAY
         /pzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744288886; x=1744893686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdnbocKbRHhtLFIRneUZ+/1khNFKq2SMICJ8698GBPY=;
        b=S7lKnlJ9ZnqfBDP4UbKYCh3kWi2dV7FEQE8mvqnqWOaZOO5pKiSoQZ/hlsU21NHn/H
         ZRFIxbmsUzCXKe7TjB/gM8o1YPdSZXyApRQL9RLLPpio85h+LPuot/ZZC1k23HIxlY0a
         GJOMhfyQgX+g/9+1XBCKZyzmHFTsjF1VyH5BIINhTHC+UjXucKip+URj34QP5XCZ8iLZ
         vSW34kRr/dJIWR5/lQhOSbL5V1twT6TL4KCX/bBEeuv8HKmE8xDaqW3h1xwMmTXBHp26
         3G9+X5yMVnkxGGY3Hxa5k+gvpCn95p9qi2KDex4xjBEwc/EnI+7jCiVQ6K444aa/glzf
         LFJA==
X-Forwarded-Encrypted: i=1; AJvYcCUUD5EUHlsMvrOs64NG+NzmDtghDYG+mqQ//V2yz9N/EJM4l+/DgEfxxUh/nW4Cd4RVdM9uqapvMghtxaSU@vger.kernel.org, AJvYcCV0gqJolleYMZy+z3GVtInnlwQ3lLNfnc0O06bOIgfeeyTNrvvAFSsEPg52Wdg5P4uuNxg=@vger.kernel.org, AJvYcCXhBxjLnAe1libcCSjZef+faL9+kisMBB3s3Jp+1eQjXw9PbBzeYW+dHKqbx8ys6X3Ic29N1XVy@vger.kernel.org
X-Gm-Message-State: AOJu0YzJmKayxqiqHCOp1TWSIH76GvLOmF/sA84qOrNNbSR12fg9ncrA
	84Qm7ngn+rHj1U5+hsVGevhhPTQxloAW+AgZZM5Ho+5GNfkYzJXK
X-Gm-Gg: ASbGncuOhnirKfCLm8Z5rMpvFAowwEis8CkqnQdIbt18z7NAt1htxvapEEN/R3I1xy5
	AhRC1+sn1LHhDFcsmfirePxu5Z6VJOU4iJCjGNXneP73tsGUK/ZKXqi8qKLirfogSXHp4X1Yp/F
	KIFz06aKCi0EBLat6zFRn6WLyc/HDsTUfgVa84BmAqCh8UYLUFKRckrhiJa2q7BDzbab9fpRGas
	F82uNeaHfW5pF9tUoilL+/YF4tf9XepLQOJlQ1E7eTzIKOEDdR31qOxawXllXzUlPMl72TaMCbY
	BkxGzu46rG0AeSZ1lewSb6zzcYbjAm4=
X-Google-Smtp-Source: AGHT+IHFnixQ5MsGHZOrRj7wBMlCDreKn1YjUX+wo4a9yoUxFxM74gu0LIHOA4oxH0+d9O3PjuEj5w==
X-Received: by 2002:a05:6000:1ace:b0:38d:fede:54f8 with SMTP id ffacd0b85a97d-39d8f604e74mr2137274f8f.16.1744288885650;
        Thu, 10 Apr 2025 05:41:25 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:43::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d893f0cb7sm4722483f8f.75.2025.04.10.05.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 05:41:25 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: syzbot+252bc5c744d0bba917e1@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
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
	netdev@vger.kernel.org,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: [syzbot] [bpf?] possible deadlock in queue_stack_map_push_elem
Date: Thu, 10 Apr 2025 05:41:24 -0700
Message-ID: <20250410124124.1189471-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <000000000000c80abd0616517df9@google.com>
References: <000000000000c80abd0616517df9@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: https://github.com/kkdwivedi/linux.git res-lock-next

