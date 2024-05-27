Return-Path: <bpf+bounces-30683-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8AE8D08F3
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 18:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE45228241C
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 16:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D6B15A856;
	Mon, 27 May 2024 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YW1bIrRI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515AF1E4BF
	for <bpf@vger.kernel.org>; Mon, 27 May 2024 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716828545; cv=none; b=Z0odrGXNb3N4wFe1xX8OFomW3WKPq5OP3kD9/RKimLiO9dTGYXkTBBiqqLXIO+LGeXzPVBocMTf/PPYzlXjbWaAchLbtTUCChAVvXqlyUb/COWECy0iFQvQmbuv9iLnmKl6kH9TgwBJc0pzawmhCr7oyd3Fcz0KC5IjqFE8zuw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716828545; c=relaxed/simple;
	bh=0fcU7GCki+HwiLEc//E3jm1vdhMToPAqpVUbbcFsqKA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=P1h/S4P/FbTStYtkidQ0ivNdYtyntBuW0Sd/p1lDLDqSjwhzaCsQHDuj15+YbXMqtqyOKj3UuSdG/FR6dEZv/XAWTCA8NLR3YeezPm5Akica5JFJs+f3kLOtyAgFR3ZH0td+V8NiU7UZNCola6dxxbGKqhHeuTo42x15CHog7ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YW1bIrRI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f8e9878514so2632440b3a.1
        for <bpf@vger.kernel.org>; Mon, 27 May 2024 09:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716828543; x=1717433343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7kXdBHv32dlnAKMKSau9ptj5/ba6hCNJ0XLNF1Reus=;
        b=YW1bIrRI1n26o6crQlYQE9YR/i0+XH/gtTe7nlxyfmcsT5BMxFlXPEaT3H3o13iW5s
         hc1BMiB3QgWyGxiGkn2sM/le5MaHCVFL4BEVYpvlyWgpQvT5mPYkZ9kdkt0vp+KIgjJz
         G1lqqOwxUyVH3M/pNhZaW+/pCDkATgThNCqHj8DKO5KQf/kjjRE08/yE2otC4/oGim3F
         JwPDLjmKup7i79Qy+SdBnAfqtcGewVsb0UbxixKD1n/33Do8XNi4ymHqPiyT+HrKImk4
         DunUiJCyj2hDR1ucHcKRDdTc6D2EBb6pI/5tqBBh2Kk23dwuavHLGotmYGVCqLuWLZY5
         uXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716828543; x=1717433343;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R7kXdBHv32dlnAKMKSau9ptj5/ba6hCNJ0XLNF1Reus=;
        b=oa1gfeC2LexdlhNB9yKCnjaajL7yFq5c1JPcrFDWVtO3nyPXTHoJvyO2FeWyNuxsHy
         8v/N1h1mcfakNLDd0a9/8U1TMbcYogYWtqKdTPHRDjkOJ8V87h78zhh7M0uidJx/oeEP
         bgIax8vC9FkBJknZfakT4x3bE9HxBhFRKRNma0QzADe28RcXX1ILm6kac4/HmFyfXlA6
         uSk9Q/7EN0lcXAJoZb5fbYOFJT2HjGxuVIJs03Ul9WftS9MQzfoW6Du7LBlaz6j24M42
         WyDYCTel31uX+5WLDGAEfDt9dLDCbN5WHle+fV40LU22ZhV3KhPw5Tfo7Crv2jMeP2Jr
         GG+A==
X-Forwarded-Encrypted: i=1; AJvYcCUOjQ4nr6H0nBd9e+1/cTCbYqnylKeT6efDWWmi9iNQhWlqr8EragGJjfvcwoWs5ZCRPRME+8tE5BFhwSkzjTSH5+Jv
X-Gm-Message-State: AOJu0Yy1HubBEg+Ud4udyyNSj8oLd4owgxevzcICGuicMfQ1hvZhDH5E
	mrb8Npi2tj8nXBhgIMesZoEV5fET4cfHEN6sJ3KBG70NK8H66uLT
X-Google-Smtp-Source: AGHT+IFpeWjd9iucGxZHRFgl2QaTURvy3FziQyLehiO1MSMnHZRjNstnMaDJwBvuNWdYTuByI57nBg==
X-Received: by 2002:a05:6a20:748b:b0:1a9:6c18:7e96 with SMTP id adf61e73a8af0-1b212d0a7c9mr10957292637.19.1716828543372;
        Mon, 27 May 2024 09:49:03 -0700 (PDT)
Received: from localhost ([98.97.41.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd4dccbcsm5093621b3a.197.2024.05.27.09.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 09:49:03 -0700 (PDT)
Date: Mon, 27 May 2024 09:49:02 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, 
 bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Hillf Danton <hdanton@sina.com>, 
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
 kernel-team@cloudflare.com, 
 syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com
Message-ID: <6654b97e45ad2_1c762087@john.notmuch>
In-Reply-To: <20240527-sockmap-verify-deletes-v1-1-944b372f2101@cloudflare.com>
References: <20240527-sockmap-verify-deletes-v1-0-944b372f2101@cloudflare.com>
 <20240527-sockmap-verify-deletes-v1-1-944b372f2101@cloudflare.com>
Subject: RE: [PATCH bpf 1/3] bpf: Allow delete from sockmap/sockhash only if
 update is allowed
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Sitnicki wrote:
> We have seen an influx of syzkaller reports where a BPF program attached to
> a tracepoint triggers a locking rule violation by performing a map_delete
> on a sockmap/sockhash.
> 
> We don't intend to support this artificial use scenario. Extend the
> existing verifier allowed-program-type check for updating sockmap/sockhash
> to also cover deleting from a map.
> 
> From now on only BPF programs which were previously allowed to update
> sockmap/sockhash can delete from these map types.
> 
> Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Reported-and-tested-by: syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ec941d6e24f633a59172
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

