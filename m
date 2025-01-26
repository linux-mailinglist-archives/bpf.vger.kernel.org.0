Return-Path: <bpf+bounces-49830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF57A1C859
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 15:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CD13A6B0D
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2025 14:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAFF156887;
	Sun, 26 Jan 2025 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="G6SkSJPM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2693F1514F6
	for <bpf@vger.kernel.org>; Sun, 26 Jan 2025 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737900916; cv=none; b=HbMaeP/E45cM25IOkQ7eYi6X0Rwe9thQn69xSk+dMXrojqfPQBTAaBccvDi9BReNlE0nf8MNCEuJcCGP5DU6YKj8xSBR6P5tDcRLNFo3UfiYC91gYR9UC7Br7m8dmBqYeftkPg1fR+GGWwACClmP/+9jN3Z437cWh+CTn9E4Nsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737900916; c=relaxed/simple;
	bh=peHLr2meKF1TvUq/MZxe+1FIKfK53RpQEdIuer2wMfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p9Y140f+IxfUVmupajLsw7mi6VKKemhhCSolQDxebjsoDStmNMHKViU/VsVuB9yvULbI3cEOtlHyEfF6rG0sbuHkRL3KGrc1tXPhMQzurmSzg4qgldDxfa+KNREbaTK4HohlSnYji+Xenc2nJVVTJp0c29ZH0icHoF6r25KuHfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=G6SkSJPM; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d982de9547so6865593a12.2
        for <bpf@vger.kernel.org>; Sun, 26 Jan 2025 06:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737900911; x=1738505711; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=peHLr2meKF1TvUq/MZxe+1FIKfK53RpQEdIuer2wMfI=;
        b=G6SkSJPM3dLFlFbSNdfUSmAxcvEE1CXMA1Ejv5vXdvyJ6uuN33bKOAPFs/3NgbXn/w
         cQx6IGOxnsdgEJ0lE0xllJN7+TKBA7gVxNOyi6EaI6DXGbtnuyv8OmdMKvT5zfkulg96
         UyPg2BHKZxQMO6UTnHD0h9yJHkJRysHtB/pyGkeHuvHFr63NjAiwUHPFTIEI+Nvw0e15
         OWY37BLu6H50/Xm4IBNFwIdXhSKR73ttlyOXfrFuBm76o6hpU2J738JGtL5N1X7MyG8S
         KwrEvcb5FxT9fvLL1DumG97wI0A6wO39zZNcJVUdJHyJp6IKqMxEy9GwSmMiCcEblrHE
         Z4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737900911; x=1738505711;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=peHLr2meKF1TvUq/MZxe+1FIKfK53RpQEdIuer2wMfI=;
        b=Ta1rERdwzjh5vz+f3hS+DdQr+rozgLO55uyhFyJulRvoTAWWReu/1aYaotAAgE9Zb5
         b1kJ5yMDALwQWSM9SaclUeZAgsaDZniK6b0LDOmWP3A2reRCkud8dABr8hDR/y/8dyD2
         +Dkw3HzpMzvlwlHm8mkrxXoh9g87Q0ydG3nEVWrDZACdhwq9p1uOEbsrKCVkJBHsNbT8
         2WEr5igI1SH+7vHS7ZaXeZvdJOuudMIhwNZceEMODhHqW/bicjg1dKCI83qQKxVIhaJa
         I7EoEEodACJhOV8YkeTcX3GKMOtaHrJnoEjA4rB8Mhxp/Ho/3cCM5Zl+mdtlAANbrnYk
         +FdQ==
X-Gm-Message-State: AOJu0YytHu9rfjG2hStF/ghIxscrnmVTh3sKdWE9OKGRh1c2KVxkPz2l
	NlGeQC37SBhvqwnTCVYsxTYHBWIu45zzV2Ooxp5rxvi4cEcyh/GTSza+5bKXcW0=
X-Gm-Gg: ASbGncswDoXlUpH0adBiEC7XB6CeaHKd9rSnIbU70XFA4+cIZw1lzg9Cwdz1OeZRone
	BxDs4b7/Ah16TKXhTutMTRNYKwy2wrqW6E7KvYJFOQ9xkSS462z5u9+f/uINyjQAeZ70vm0kVuD
	N3qeboEnMTrij6Q6xJEZwFupB8K/G6zT5kX1E/nOVHoGQxUNMhqherx2CV/2XXGwlfgOROyg6lD
	Udj5pTXhpy3ubJz7dodpupXQt5EbtMtXcbD/Ka5Lb84nTYgYQlwxCFH4VH/ftVdoj5Zq9+YNA==
X-Google-Smtp-Source: AGHT+IHS+j/maW0HT7SPUukqXe3x6mcjCFkojnW+QLc+olCNf5e5LR+PCAIyPwV03Bd6SZmxxKy1SQ==
X-Received: by 2002:a05:6402:274c:b0:5d9:a85:1a59 with SMTP id 4fb4d7f45d1cf-5db7db2a0f0mr35080417a12.27.1737900911439;
        Sun, 26 Jan 2025 06:15:11 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2432::39b:69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc186191f6sm4028191a12.13.2025.01.26.06.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 06:15:09 -0800 (PST)
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
Subject: Re: [PATCH bpf v9 5/5] selftests/bpf: add strparser test for bpf
In-Reply-To: <20250122100917.49845-6-mrpre@163.com> (Jiayuan Chen's message of
	"Wed, 22 Jan 2025 18:09:17 +0800")
References: <20250122100917.49845-1-mrpre@163.com>
	<20250122100917.49845-6-mrpre@163.com>
Date: Sun, 26 Jan 2025 15:15:06 +0100
Message-ID: <87bjvtd5lh.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 22, 2025 at 06:09 PM +08, Jiayuan Chen wrote:
> Add test cases for bpf + strparser and separated them from
> sockmap_basic, as strparser has more encapsulation and parsing
> capabilities compared to standard sockmap.
>
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>

