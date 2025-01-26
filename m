Return-Path: <bpf+bounces-49828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA82A1C84C
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 15:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B32983A6D5D
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 14:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54811547F0;
	Sun, 26 Jan 2025 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YnG1MiVt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213ED25A652
	for <bpf@vger.kernel.org>; Sun, 26 Jan 2025 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737900708; cv=none; b=jpQpw91n4L6pjGz8UlYLTeLeLmO8cqx+QzSx+YpJCwsxAIHwQbHbmjduP7tQBFVMznLFSoT9iWUOnSse4u2qq4sps3h1Wab/VdmZodBNjQ55yUPmSI0QKxnPufO7/p6Qj1nnxCW3IL5pmDAZVEe6xQ6OVmIdQ7YyMJBY05jogEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737900708; c=relaxed/simple;
	bh=12HzqKG7XNFsVb1EKgZbZZW8oeDZ1Bj4ACbSBWVyPFQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lMDV2TXvrU6QRM05NlxM59428CrPrdTQeckUb7sVGCD9EuHqWREQpspy4FPd4Ha5Y+pyfqLfacRuX2rgQ1UXIW206BoKLTBZQOJ4hxWL2ODAo0cV5DrzstmVCbxJxktLbmtYyvybqr0tAY4OxgpkA7rGEsNwgMy5105hl0CNR5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YnG1MiVt; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf6b1a5f2bso950124066b.1
        for <bpf@vger.kernel.org>; Sun, 26 Jan 2025 06:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737900704; x=1738505504; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=12HzqKG7XNFsVb1EKgZbZZW8oeDZ1Bj4ACbSBWVyPFQ=;
        b=YnG1MiVtxyeJ9r3CsHAYBUzy6KfIIQIxoxtPSVTXES1p+HdITODLJiD5QC+y5BSJ7d
         KajWhHTVVXt3IWoyhJ8lAxgZwcwvXxHWtiZjyk9hAfsgDsHCWnf2AJyUzVsiVVm8ZaTA
         uZGcoHiSLNZla1Hr1K0aaAwlQqCvVRYdzApWQPV6rruZmtA1LwXS/EYurf2Lad+YKPVw
         9Gvp5+vd1rT53HD98Ki9zy2uOttRweItmMIgYfU52AcABSQw1PGdFS5S/CGKP4VpOwxd
         xbD0L4A3d1yJZFead6dE2ueuMWMf2kS/dnJYZ+yytcM4ThQjrwoW3cUel0n/oEayl9k+
         YIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737900704; x=1738505504;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12HzqKG7XNFsVb1EKgZbZZW8oeDZ1Bj4ACbSBWVyPFQ=;
        b=N/eLeuyqc6vmESt62grFkuUcom9XvEaIWCKj+BtE/+YTpAUEZAn8li7UpkY6VpV1xa
         /a2lBRdkUx7X1jxSYunFZniLUnjRYNA5Pq7oOojcjNolP1JkhT776DJY24PASPLpHkn/
         9YPorTL2oVEdR/sqijd8hOB4p9Kd7rmH96usu1ob6nFkmGVk2r0TNrosRGCUQ7kJO9fi
         v+Mlbcnm7TqgOs00fYpmjy5JM6Qu8oOhKXxyVdVhwXw4eoNczbHoGz5fa4Ml8lEtKwta
         iwGTbICEvO08tEh9PeliMhL+jN1MOebYM2YLT6YdAaMm+9AF7q/hbftoPL5d27nX7X/a
         ddDA==
X-Gm-Message-State: AOJu0YyGvUguhBSBqA2bGuhTH85vvjrxt7Lk1YViklCyfeSSWExNjfdE
	x5lrJCtuFSKp2mC7RwM04MAcrv1hERDHaAwZHM/QplMepWV1Z7g8LShReoznihs=
X-Gm-Gg: ASbGncup2J/jNa9UuGS25+/jpFxFAsC0f13eCiK8jYLGfNQfTCoIl7HBYZ9VdPn6OjT
	cPCSdNK8zKZI1CZB1wlrDsjeopBPgT6vZ8jS5VnsbKluXEdyB1WeJZZ3Pkm48RCcCO/QZlQhZlA
	Dijm2emQDsiXYoAgIuzdxoq816ERsAnHfKPDxUcrjIWBvW1PY2l+P/VirP4hnIQwLQAQloaB7s8
	gTwtH3BnIJ6dAke2CcBXBnnDf6zB0eHS3l8w2kZzezlYJS6fxAS33USOEtztVqKYEtjvFtEpg==
X-Google-Smtp-Source: AGHT+IEKSJdD2dRwqzzBvy9ISrqzwSE8h91lW/SaOjyNpZpNcIf5gT5KiPiOM2vkBbUPwNzHl+oUMQ==
X-Received: by 2002:a17:907:3206:b0:ab3:a4f6:7551 with SMTP id a640c23a62f3a-ab674600f00mr739626466b.13.1737900704480;
        Sun, 26 Jan 2025 06:11:44 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2432::39b:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e64dc9sm420223466b.45.2025.01.26.06.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 06:11:43 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  john.fastabend@gmail.com,  netdev@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org,
  corbet@lwn.net,  eddyz87@gmail.com,  cong.wang@bytedance.com,
  shuah@kernel.org,  mykolal@fb.com,  jolsa@kernel.org,  haoluo@google.com,
  sdf@fomichev.me,  kpsingh@kernel.org,  linux-doc@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v9 3/5] bpf: disable non stream socket for strparser
In-Reply-To: <20250122100917.49845-4-mrpre@163.com> (Jiayuan Chen's message of
	"Wed, 22 Jan 2025 18:09:15 +0800")
References: <20250122100917.49845-1-mrpre@163.com>
	<20250122100917.49845-4-mrpre@163.com>
Date: Sun, 26 Jan 2025 15:11:42 +0100
Message-ID: <87jzahd5r5.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 22, 2025 at 06:09 PM +08, Jiayuan Chen wrote:
> Currently, only TCP supports strparser, but sockmap doesn't intercept
> non-TCP connections to attach strparser. For example, with UDP, although
> the read/write handlers are replaced, strparser is not executed due to
> the lack of a read_sock operation.
>
> Furthermore, in udp_bpf_recvmsg(), it checks whether the psock has data,
> and if not, it falls back to the native UDP read interface, making
> UDP + strparser appear to read correctly. According to its commit history,
> this behavior is unexpected.
>
> Moreover, since UDP lacks the concept of streams, we intercept it directly.
>
> Fixes: 1fa1fe8ff161 ("bpf, sockmap: Test shutdown() correctly exits epoll and recv()=0")
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>

