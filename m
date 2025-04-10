Return-Path: <bpf+bounces-55655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C22A8438D
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 14:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B551BA0BDC
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 12:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D6F285411;
	Thu, 10 Apr 2025 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5J44iI1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A02A26B2BA;
	Thu, 10 Apr 2025 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744289000; cv=none; b=Irldb9aE0rKStVcUsDU5/KZ3Yv4LgoYYLncRysofM8NaBivfooBH5eqv4cbpqWkxmV5Jfahfi+Lf/Hc0bERLrcd5juu/HMZEMsluzt3TbW+lOJyEIN8YtjBOh+JSNd0BUjDOJ+gxxiInWsG0yx0uG4aIdo/TBEsZxOCUqljTywU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744289000; c=relaxed/simple;
	bh=FdnbocKbRHhtLFIRneUZ+/1khNFKq2SMICJ8698GBPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWJsg3O657Sj0/QJ3ws9JfHsmTrg3YN1hSD3hWgYRXNKZQWuHahrGqvH4gWhpMo0+M4SxuHQR1wEuiN0/TPRaXq4AXHhl1EciY9TcQ+0rHlSZDiosZZqnat4RtFtbNzCM7PSaRM9TYW+/E41LCcmDoUlTdxYuSkEOcIz+kj5qW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5J44iI1; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso5825115e9.0;
        Thu, 10 Apr 2025 05:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744288997; x=1744893797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdnbocKbRHhtLFIRneUZ+/1khNFKq2SMICJ8698GBPY=;
        b=C5J44iI1FaqQ7HdWFzHc5dJptGqV+HQA+UguaaRUI4ZdeMT+1D2hSYJ4JEvJL3zlxP
         ifDjgUaxTgv9Iqb3Uc3AkJxmrWWbigd88FfuQH6NfgsXm0KXv0HNJN8AXPh+C2MNJfwJ
         7gFeNLPN9/DkHe/BrzngKfvWbGs5j8AnsxkzI0Nrope6vpXdJzYoJlhbMbFxB8Vub0ZT
         YKusjr2s0YCXVzGN173jTWdlbqBRpld/q5J0STeCgnN6J2DYkPjnFREJZY6ednwsX6my
         cncXRUV1qwjqLwwmcz3gcUIsL3ryNgeKV+BRo9ArabVrEsNsEYBAgTVb+PqnjE/ZSYWY
         +zoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744288997; x=1744893797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdnbocKbRHhtLFIRneUZ+/1khNFKq2SMICJ8698GBPY=;
        b=V75Bibr/UkVa2HIiDHV9CewYQg0AH11sEwDowW7XRVQoA73HsVClTNhL4FrPhksCam
         lWR0ff5rafJ+l3XIdn76iKWyEibaOy9Hf5KXVcYOI6fwyzwvTKa1+CBAkqCwr1+Ecx94
         mpyrInzteneeeMf1Uokzb9iJars5qtBYJkdySbvkOK3gwk+KaZ0Gx1G3YMwqWCTX10vd
         KC60W9b3cwUEQSaoCBgRq1xLSP/bEmchBnVRIlgadSC5CXLywHSEsPrzUPMmHIH6a3CX
         AazWyXfvaT3AYq/1ulbi9Ppn3QfwCnn0MeEEwHw2rS/OTnpKtj0b1GfjMqHD+3Ea0Bk0
         nXQw==
X-Forwarded-Encrypted: i=1; AJvYcCU/sdqANdfsKlkYpViFmyZPVDJFPhdcf/WRr1jMMeSccRdqLNRlRyAUg5/9IRVJd9EkvPE=@vger.kernel.org, AJvYcCUrz+5wFzztzPS9NvVwIkHMH4k5kaqGjcS+nJh+89H47fVXE84t6EoXFGQZxnMd+3mRnk7eXlzF@vger.kernel.org, AJvYcCVENS/HShnsp4CYID3Q3UBqu9PtDlkDkUvcnz6mwwZMfb4JtkTcF/Hqu17WBs1YlSHF0dtpyH8ul47jP4te@vger.kernel.org
X-Gm-Message-State: AOJu0YwnD/9Ql8AJQYxO/qmG7M9/g4U3NyKjSlMUJodSYSShyYQg2XBa
	jP31LDqyD3Ssbuf90usXf3waJeTKBjaju/uCc+mYu458u+zciYFg
X-Gm-Gg: ASbGncvCRmOWy0jg7rPrgHSzm3MzWSnO6AhSnlqId0X0uoLXy9mDFJGsCOoXQWNWdE1
	XjQ0ln8bjcpro9VuhZCSJv6qZoWoiZAi1bBmBVryPIm1O9wpYqeQ1bQO2ZymSlh4Ki7sqcns+Px
	DGObEJKY/jEL/0OQ+ZIGbNewroxSudJJVqx/fhTuLzfqZo1bUeEkbkra2prDfLo29/olnad43Jz
	PF4cos8Ql246FXPyFnOpHwrJWYzQ3uJf89HZuRXmu0rVTIoJXOznqmxpcl7gFBQnS2WnsenrLbF
	w51f5yZHJFK4wG1Xf9ImRIuMGykYmg==
X-Google-Smtp-Source: AGHT+IE1O/g9eSCNeD9X1PupioWSc5DczuV6yqkTZrHoR7wnetv602/KyAnSaHmO/djaQj3YLxmu3A==
X-Received: by 2002:a05:600c:1f8d:b0:43d:fa59:cc8f with SMTP id 5b1f17b1804b1-43f2ffa3188mr16121285e9.33.1744288996732;
        Thu, 10 Apr 2025 05:43:16 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:7::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f205ecc73sm54187835e9.8.2025.04.10.05.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 05:43:16 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com
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
Subject: [syzbot] [bpf?] possible deadlock in __queue_map_get
Date: Thu, 10 Apr 2025 05:43:15 -0700
Message-ID: <20250410124315.1201290-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <0000000000004c3fc90615f37756@google.com>
References: <0000000000004c3fc90615f37756@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: https://github.com/kkdwivedi/linux.git res-lock-next

