Return-Path: <bpf+bounces-23040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2058686C7F7
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 12:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFA3D285829
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 11:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D657C0A5;
	Thu, 29 Feb 2024 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWQWTRv5"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E735645B
	for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709205777; cv=none; b=mle1805TADlL4ty5nKTgctsQaISWrDfa6GbUAFrLOxPl98x8LW2Z9AWA+PitwOipdDA2LNQgoxDb5qoYYtA5rDZrdDhP1T5TxAtxGdsl6GVcc49YaH9P1p591mceP4Jbyz4xly4J8yUGJrie+LiNJxsPXzy9Nq+F4NQlCJZU3gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709205777; c=relaxed/simple;
	bh=6Xm0wpBLfk1HBefMBjtWVO94B+fykzdv9FHKbIyd22Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ANmxcxi0Sbq4Zt7rT9S6ThO3+2/WNMIskUmZDo9WB6WRUi5WJdiL+zAxs5xiTQFIKrhIOiR6H6ycTl3PK6nabWVEVFyW42/yTA/PhA7WcJEg4cohd/wf7JsHJBYfyzCVjq04nIfr0nk5r5O2U1F4hc8whcoBd6xPQrplKlBEp7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZWQWTRv5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709205774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7At+Ii/grtsrpCGb+fCHoN8LAX5Jvg5wYpJeg8H4ilQ=;
	b=ZWQWTRv5KB2rg1h3tX3j+aI0nhd/4JAy2KJZm6NruZyvWzSn0GUSU10i7Bnd25+OgTonmK
	Xb8A95lnVQbBIe8Xoc244m8LMZ7oWqT0Kw4WAv6tCaufCxx8VTOgsqsfpjDId4ays/ufH7
	PJX/gKmrOAMpn+LdDTxl9XYCg4B34WQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-xBLiDz7lOaq5kZ3YYTpzKA-1; Thu, 29 Feb 2024 06:22:53 -0500
X-MC-Unique: xBLiDz7lOaq5kZ3YYTpzKA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5668e56a6c4so537117a12.1
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 03:22:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709205772; x=1709810572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7At+Ii/grtsrpCGb+fCHoN8LAX5Jvg5wYpJeg8H4ilQ=;
        b=ikcKaoK8LoF7+hLs4zfSl1QQrWdyJ8ebl7W88iCxBqjawaSWlovGaerOGfoyRpS8tW
         v+FqR4S8PfbYhaZI8quKo1ehK5gVACY9WN2Juvh0p3YDBsPYj0BiwyuZ4zDa4+vjFQEE
         Rx2TCWNX3jGRTFnIJLobmD+s8o0Ka3BqQFzl002Idz/K2DkxXETbVIEY5JtBkAk+Qq4/
         omoNy2ichrxN1z1MBIFmR+iCuNsL4uft0zaIixA6jPLAMVCMDB2bGVkmboU117SC8JRB
         4UFGF55B/M4W1DxLHZi3qKrrXK9SCu2LFfuMtirN+308p/uR2/NyhOd5o5+6Jumzu7EX
         +zJg==
X-Forwarded-Encrypted: i=1; AJvYcCWlRPY9IhzSS9g8nucFACuAw4nRsnyYKBiep9D5Bx5LDxNm/JlTA0+CwG4iNaXVrGN2jrhXi8nnqUiWNm4aqvRJCx/S
X-Gm-Message-State: AOJu0Ywf38tCLPk7xz/LLbCEFJwpIgfHVna1PhNwSdy/8W5nd5yUn7kV
	BBlRcjgRKRv86mXrTP3WgIUPbYlYPgxSogT8ZFBQi0BmOp3A2789UTvpCUzrfIXqwHCS5GSCMLL
	0fSBhK4wFr3ePMEX7tflM/7FqUnwLDBFPb3nOmqnlwcomcD8sEQ==
X-Received: by 2002:a05:6402:2156:b0:565:f9c1:d925 with SMTP id bq22-20020a056402215600b00565f9c1d925mr1171210edb.0.1709205772083;
        Thu, 29 Feb 2024 03:22:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFW5Mh+qKe9ZKENzsEqOvljF2oOzrK7eTWm8sNOJLak6DCHVU9G9ylchI20asRM3L6KA03OTQ==
X-Received: by 2002:a05:6402:2156:b0:565:f9c1:d925 with SMTP id bq22-20020a056402215600b00565f9c1d925mr1171188edb.0.1709205771761;
        Thu, 29 Feb 2024 03:22:51 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id y6-20020a056402358600b005645961ad39sm523690edc.47.2024.02.29.03.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 03:22:51 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id F0F0B112E802; Thu, 29 Feb 2024 12:22:50 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf v2 0/2] Fix hashmap overflow checks for 32-bit arches
Date: Thu, 29 Feb 2024 12:22:46 +0100
Message-ID: <20240229112250.13723-1-toke@redhat.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Syzbot managed to trigger a crash by creating a DEVMAP_HASH map with a
large number of buckets because the overflow check relies on
well-defined behaviour that is only correct on 64-bit arches.

Fix the overflow checks to happen before values are rounded up.

v2:
- Fix off-by-one error in overflow check
- Apply the same fix to hashtab, where the devmap_hash code was copied
  from (John)

Toke Høiland-Jørgensen (2):
  bpf: Fix DEVMAP_HASH overflow check on 32-bit arches
  bpf: Fix hashtab overflow check on 32-bit arches

 kernel/bpf/devmap.c  |  8 +++-----
 kernel/bpf/hashtab.c | 10 +++++-----
 2 files changed, 8 insertions(+), 10 deletions(-)

-- 
2.43.2


