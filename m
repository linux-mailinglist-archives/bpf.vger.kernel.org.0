Return-Path: <bpf+bounces-42217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6CE9A1174
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 20:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7CF61C217AA
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 18:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D095D212630;
	Wed, 16 Oct 2024 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmzcvaQg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05815206941;
	Wed, 16 Oct 2024 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103144; cv=none; b=KnKn8192035sy6x17FYaKoQiKoXgOzeQK1aqWac+4wGeQspoNJRKLSG1uUJh/E22g/MQlzbbulJTJEFBoErh+Xtnvi+Yzs4BjCILZdjy6PvP/e/5MyILJYwT3sfB6BM7in25IfA+KUMaz28HT7z+nbDMwhn5OZoFnnWQYrKaiBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103144; c=relaxed/simple;
	bh=KdLT6OiWDNsYaTn5HBxfIcJwfevixBGDXkyERUEdlIs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RcFNC0RqeOz4oPmo5egBAls0IWm27IJCvKL728yI/Z4SvN1Eb0pJMhvh+wMTuO0INYMIyurtziB5dRe74Ams7wusWI2uWnSYKPBw2ySModNJFJv76kQHx/M10v+yPeiO9xd023MK/bu3mssavT/EFgOKEYw24qQ45BAumJrJnMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmzcvaQg; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea79711fd4so78203a12.0;
        Wed, 16 Oct 2024 11:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729103142; x=1729707942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rz8lBIkmJRx5GezBntyVCFYa/3Ve+MLj4cqQjzAsqig=;
        b=kmzcvaQgeKwB8wSlWbreMQHtfywV5l60YvssytR5476Ib91QjjHQprm0Q0Xk1Urxpo
         S4dNdp254IL7pOP2iWiaE9Iuj6cOcE409JuGhiZDengVPNuhLXMdg4eSiCRIGHoFnJ/V
         ChJwcdMl7DCF7KbdAPN0hvjBu7wj3HPUUm2EknVdXM6M1ewnfDWjcEMGGgkMjbiS77DX
         iAPfLi390+g4lPTa5cDiXudj7NGiQZahMC5X8wLKrlcG0533mHw6kyT+I7obg5GgSXyC
         vLviXzMBd/JqEH+vOpbUHcWWGrAzpJcih+WheHR1O0YeI+NATZ/4MyQjM2gxFALPxMjN
         FZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729103142; x=1729707942;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rz8lBIkmJRx5GezBntyVCFYa/3Ve+MLj4cqQjzAsqig=;
        b=Hj60lmqUI/tovGZqQRw+eoGC6XDo2WBEaHv9TtnxuWqCMpj3/nhxWHiYOcEklQHCh9
         p17EplGD3xcom9eUCvSQzmCSK0Afc8h0kYl4xp9kQn2xJgZLr26JXgDPZj7DDm1tGGE1
         tZ3EfeoUEzKQaQcqxJMgxKMtQaBnnTLTUfladS5mXyIpWPOztJ7MydZNJTt68VSp8kij
         Hl1HJ/IBAdo1jPgOhsO24/lou4Y5+6vTCYJ22r0G59Fl4FVFw52Xy+O5v6/XN2pIGp75
         oJ53SyflU7EaB2Rl2rl5GIcXCnKwFf87GotPAyWXD1o0A9WTkPrIcrCzeTXD90coC0OY
         pT5w==
X-Forwarded-Encrypted: i=1; AJvYcCUrkP3lTXwQSx1eG0ztRJgYCjAui2v8YD1hdoF1/xawYsEUtLXGQ1YSiIvnHvpHLItLbcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJKT+ZC417aZIXGvrV1KOq0WiF9HHSCgF5SLtqFhwwicYxAfYm
	VE+f4Df/WwIE1S3BD2cfTFgHQkx1MvSStqh8V/m3V8pJ26XlhbeN
X-Google-Smtp-Source: AGHT+IEfeiUiSaNaGm5/3wnhaxQBcFRoQZ1ZBTobKm8Z/aQw/UcoBcNyPKVvzcf3cjE12+ns+66bEQ==
X-Received: by 2002:a05:6a21:1585:b0:1d9:575:6654 with SMTP id adf61e73a8af0-1d905f7904dmr6951046637.49.1729103142264;
        Wed, 16 Oct 2024 11:25:42 -0700 (PDT)
Received: from localhost ([98.97.44.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e775089bbsm3386628b3a.190.2024.10.16.11.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 11:25:41 -0700 (PDT)
Date: Wed, 16 Oct 2024 11:25:41 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Michal Luczaj <mhal@rbox.co>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: netdev@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
Message-ID: <6710052533354_2071208aa@john.notmuch>
In-Reply-To: <20241013-vsock-fixes-for-redir-v2-0-d6577bbfe742@rbox.co>
References: <20241013-vsock-fixes-for-redir-v2-0-d6577bbfe742@rbox.co>
Subject: RE: [PATCH bpf v2 0/4] bpf, vsock: Fixes related to sockmap/sockhash
 redirection
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Michal Luczaj wrote:
> Series consists of few fixes for issues uncovered while working on a BPF
> sockmap/sockhash redirection selftest.
> 
> The last patch is more of a RFC clean up attempt. Patch claims that there's
> no functional change, but effectively it removes (never touched?) reference
> to sock_map_unhash().
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

For the series LGTM, ack.

Acked-by: John Fastabend <john.fastabend@gmail.com>

