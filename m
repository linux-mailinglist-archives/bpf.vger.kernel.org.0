Return-Path: <bpf+bounces-68924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 058BDB88AA4
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 11:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C621BC5CF4
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 09:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2CA2ECD15;
	Fri, 19 Sep 2025 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CyH62hPA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E531A256C91
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 09:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275659; cv=none; b=fxGJKPHO0vQCHSeyVFevK46A4eZeRxykFokuKl5nu7hcyju+pof3iZTpMZnyZn2RAzLExAGI3e+rzPIdw8UzQ11QmtT4/u9yYr2eUtZPwn43PjKAZnsMMiCc+9DUrj4C6ENgI/wrpV3zAuF0n3qM1CPl3GlIVH4Lf58q4CuBHi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275659; c=relaxed/simple;
	bh=r8WWHzbKJIxTeouSgwB4Mr2pbj4QCBcVdISTTpSBgvQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JkstlkP2TN86byE90diqqas1Vd0zCnQjHME1xZ1lzsqVYI/hKsXvvH+V7+5G7rHX6lDlrDvFQKDHPhAGS8DTC9+g3jTb7OgvIr/1OjoHNFNtXZLfejXGxgNJi22eKdOF5izKIerGNbMBRrkmMSElyqUio3Kd+90rE9tFXDHvXrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CyH62hPA; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-ea5c1e394a8so1420979276.1
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 02:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758275656; x=1758880456; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=POTRFWGD9N2Eju5JQSXhfOmcmRxIBLOL3ZetmyJPEbE=;
        b=CyH62hPA09osl6nefCXQ/8hXKAuLtUUzcsuNPYN6XoeW44BvChr6/rt+W2v69BbpN9
         vFC/oszlNTfD2ifi2dyPrZJwaVKMO46KSjxvzUutEqSG9Lj3PBr6g45qg3iZ20VeRIdC
         AntFg5KFQI3tFzjbRG3gJpo5THOKedIxGnssGOOdTfTp8PR5+uJAup0tOyHdzY3Ta7cF
         KLf2BPb10OR33/N2Y0FcTLL4dzVznVhZ4DHXATTJkQsMVi72bKn9C3hJKM1xZlRer/Gs
         yy9uNMfLylRc5Re53aQo2fVTpTgDIM0GdenRzs2WJ0mAf8IvchDKePGt/kkP36USo02D
         WijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758275656; x=1758880456;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POTRFWGD9N2Eju5JQSXhfOmcmRxIBLOL3ZetmyJPEbE=;
        b=SFAnrpjh40amF9QGPBg8BP/qjXJTg3pCCVl5VyAMcXX7KJAsE1jd/u3ceAbBXMKOnn
         sWOcl8acUZGyWzxnk1G3TN44FDii6FJcDccugq/5g8EPSJz7xV+zYKn5grI2XMeFuGG0
         Bu3VKE/3gG1k8GVVCdgac9rpK65C3b0D4r4oBuNOF55nLjDSM0cLUW2SgGA1VkUi+aV+
         LZKLN+3OYqxAafPmmUd/lah3EiEY2Y2JRAAMbh4b/7RBaxHGST5xWDSTpyDUTDGg78sY
         DT8q20zqNQgzNpNgz++Nn4T3E7RtuLQmgnuHjTuiCo4xIzcrfwdRtdq+yod7PmkM2bYh
         Wwmw==
X-Forwarded-Encrypted: i=1; AJvYcCV1LrA1s1gFgYisaFtw/UtB1195w5oBqHLN5Td+OFgsO9iS4nWIhI1QTCGbMaPGWKcc/a8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgDVhmdgPuqYJ2HBP+3h0/zSsDT7FW6hGXbvyZFjpitaCjQoWk
	4BgPwNobn/O7CQspOp0RYXs3T5icfN3cTVEP/bU9k8xTOQ9521KQvdHY/ISyTnQfOqI=
X-Gm-Gg: ASbGncvaLl22bMLKYblLzbvcbR51Ro610YHottaxJHjrdHafdvSEieYVzSPnDvRzsi2
	Kp9zCMNd0vCW8a6gPGy3FE9qMMA8iR04Bla3nIh67yOxeXGLERHwf/vrHtXqm8fk7HAGu/oL1EG
	n9cf8JqYL8C3Vuxxk/5R2tcnQsmpr59zfAzslx4hV8jw6AUJvJEnz6HO5C2H0P97KtBSE1f2wSf
	way1euA5+s2NpsTloRcl7PMFDq3HWurEwt9Klh2H4GQ57ccvZfvataIOup0KGnbGpwbxszPGVX/
	1r21odMG2EgSeZMgYIZVpY5PCJ8nbHucK2KWy6N+y2btLO/dIaiIEfxAB+S87WYt6fX25RgmvEx
	FDlIJpeEMRsaAHQ==
X-Google-Smtp-Source: AGHT+IFh6gBvRGK6CP91Xd7WmHsxfSp7jA0HwoLiouLAGHBFeou/eRHvssueILk3xyR+Puuh0g2paA==
X-Received: by 2002:a05:6902:150f:b0:ea4:139d:33f6 with SMTP id 3f1490d57ef6-ea8a0c2f5e3mr2212165276.29.1758275655893;
        Fri, 19 Sep 2025 02:54:15 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:2432::39b:31])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea5ce8544b5sm1580858276.17.2025.09.19.02.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:54:14 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,
  John Fastabend <john.fastabend@gmail.com>,  KP Singh
 <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Mykola Lysenko
 <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: sockmap_redir: Rename
 functions
In-Reply-To: <20250905-redir-test-pass-drop-v1-3-9d9e43ff40df@rbox.co> (Michal
	Luczaj's message of "Fri, 05 Sep 2025 13:11:43 +0200")
References: <20250905-redir-test-pass-drop-v1-0-9d9e43ff40df@rbox.co>
	<20250905-redir-test-pass-drop-v1-3-9d9e43ff40df@rbox.co>
Date: Fri, 19 Sep 2025 11:54:13 +0200
Message-ID: <87frciu5ru.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 05, 2025 at 01:11 PM +02, Michal Luczaj wrote:
> Preparatory patch before adding SK_PASS/SK_DROP support:
>
> test_redir() => test_sockets()
> test_socket() => test_redir()
> test_send_redir_recv() => test_send_recv()
>
> After the change (and the following patch) the call stack will be:
>
> serial_test_sockmap_redir
>   test_map
>     test_sockets
>       test_redir
>         test_send_recv
>       (test_verdict)
>         (test_send_recv)
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

