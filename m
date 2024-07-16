Return-Path: <bpf+bounces-34903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65774932256
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 10:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B6B282900
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 08:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0AA1957FF;
	Tue, 16 Jul 2024 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cP54LFqt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E100341A8E
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 08:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721120319; cv=none; b=UozhO/rCRqbinqlxj1BARBl6lxGt+eTbtXUqmsn7cvldzaDFdHwvJaqYjfXnZMNu6OxGuiGicu7EMlTkzSOzmc+Dfl2y1abRI6ZEnQpx/1LbQuh0909r4G17bDBTe42qp0ldCJmAqfUFpL2BiBzVB7uRGKibW+s0CNwn6kkZW+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721120319; c=relaxed/simple;
	bh=Qvu6/2sv4E/x1bqSzz0GteaUGzARIBIqi6/JMbHq+0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ekTmRPYduwwbyagFp4yC6EkceZi/6AB3xz/0Wxz/h3CnLe8ijmzvPhsZ5E5vBIlPFCgDhzCwCnoesNtWtDP8cKpxrscp8APO1eyAl0zhV+XCSrSuj30YpMv+mlwM2M2Fpl4WHP0zTfTXFn8T8DvzumiGdx5G5JUeoS1+vnJ2O+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cP54LFqt; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58bac81f40bso6549121a12.1
        for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 01:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1721120316; x=1721725116; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qvu6/2sv4E/x1bqSzz0GteaUGzARIBIqi6/JMbHq+0s=;
        b=cP54LFqtaIVSVNSXFon3jdsannvFGBBfxO2GpVZHiMjNxomKchr+XMJM0NdDiGohUR
         +CSgb1oevachsvZiOQze+/0wUUoqFyZh59uuTNwikBxZz5XHeBoAuRVI1VuvWcO1H+91
         csh7/a5JZANa92to8ZHY/qYXLthL40v6asPCEAjpQwStbwKr604xQUfg9QAG5b6i4m4g
         3vzYJcXR2C663xh5qohsCVW2U8NLDTdlsJReryHXdNSQmwo97FKElW0ix3/WQiO1mRwc
         jcvN6QWdID5xBxTPQPEkRpkK8Vzfh+/D+MZaa05+PS16+SsBQmOoqdBEsrgp2ak4CzGH
         wmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721120316; x=1721725116;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qvu6/2sv4E/x1bqSzz0GteaUGzARIBIqi6/JMbHq+0s=;
        b=L8ffotXERG57NJ7WISQsVpTFJw5BQbbMWOBoFG/ARa8xBychogQZ3BImXOag8VjHWy
         2oecdbMEddt4iZJSo8Q6R/f0BdZwKSXOJaoHF/lAfjjUEknvi500OnVTTemq60SR+Oe5
         A+92DHoUYKyBXqJqvwf5Sf090fy+sVkkuml6WwzQh4WLxYg+Uu/KzxW8GMGFQRNHzUTD
         z4CfBLeW8vHSBhNtwcAJwNmWYo2s9OXwAcM4CK5kA6DqYjThCiNFqfzFp+vZpPeEjm8c
         oVy2QYs6+XbzgQ3VGWj64qP8G7w0CM+Y5E7RVq0JEfhWVxWaQBiNT6lSA80u+6KZd62C
         nuag==
X-Forwarded-Encrypted: i=1; AJvYcCXhLOd5tgt1yBdpciT/xXa82bCtVZp31Lw/dUTEizsL2m4FpFqqVkCci0WdnYoP8kflzJW9sboq8nj+r4oR2NkaLoAx
X-Gm-Message-State: AOJu0YwL0RL47SYX2ZZWX7fw+Rw+LzNn0yFr/BMGJZ8oC7Yc1ytp1/lK
	L6yTnJJeuBnEN9s+nI5kciYqlZg8vSAa589vBpTdXvSeVLGnO5sq1bhKcz/EoS+di4NIoXZB3m3
	PMHk=
X-Google-Smtp-Source: AGHT+IFFhmSZ8eRL7XpdHbGlPAb2AF681cQcWm3zoxZWXp4dPHqdDwZIK1LmrmsNpKP4cHyYnixSRw==
X-Received: by 2002:a50:ab12:0:b0:57c:61a3:546 with SMTP id 4fb4d7f45d1cf-59eef15e4a7mr905575a12.21.1721120316341;
        Tue, 16 Jul 2024 01:58:36 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:77])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b2504b80dsm4522002a12.32.2024.07.16.01.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 01:58:35 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  john.fastabend@gmail.com,  kuniyu@amazon.com,  Rao.Shoaib@oracle.com,
  cong.wang@bytedance.com
Subject: Re: [PATCH bpf v4 4/4] selftest/bpf: Test sockmap redirect for
 AF_UNIX MSG_OOB
In-Reply-To: <20240713200218.2140950-5-mhal@rbox.co> (Michal Luczaj's message
	of "Sat, 13 Jul 2024 21:41:41 +0200")
References: <20240713200218.2140950-1-mhal@rbox.co>
	<20240713200218.2140950-5-mhal@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Tue, 16 Jul 2024 10:58:34 +0200
Message-ID: <87bk2x90hx.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jul 13, 2024 at 09:41 PM +02, Michal Luczaj wrote:
> Verify that out-of-band packets are silently dropped before they reach the
> redirection logic.
>
> The idea is to test with a 2 byte long send(). Should a MSG_OOB flag be in
> use, only the last byte will be treated as out-of-band. Test fails if
> verd_mapfd indicates a wrong number of packets processed (e.g. if OOB
> wasn't dropped at the source) or if it was possible to recv() MSG_OOB from
> the mapped socket, or if any stale OOB data have been left reachable from
> the unmapped socket.
>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

