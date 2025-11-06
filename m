Return-Path: <bpf+bounces-73793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BD6C396A8
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 08:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271443AACEA
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 07:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44171286D72;
	Thu,  6 Nov 2025 07:35:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from zpanel.taknet.net (unknown [130.185.75.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F4423BF91
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.185.75.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762414557; cv=none; b=LO/I0K034WbZzJPOgqnDfkICmMP7KFrVhxi5w1d7Uwbpz+So7DQUN3qVLRcLqnozBosgDay42B7/CqjJFlRoA/lnvnKAgSYbCn2CklJtH+Qih/pJLLuMUp300/6lKfGd4ReWgKkvPBPiXibfrN8hPUT61GExJC09SEFuFdlp/1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762414557; c=relaxed/simple;
	bh=Ol7exvCQAqv6YpENP860vQiYxr5AQ7EuSItPTN/8a+0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z84qa5+h6j+uRrCOomvQHTQs2AigVEebzQGFQLIyRTaPJy+G32/2guzs/Kd3w7RmeMEZJRvHHt2bU9EjEJnVIucLNiz9qbS4EwKU/3zDe8UmZxpRrENAizwV5XlijKN77xGG8CNns12FsSdOj622IXc5F/AicBfeHvBEX3iL6CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=virakshop.com; spf=none smtp.mailfrom=virakshop.com; arc=none smtp.client-ip=130.185.75.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=virakshop.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=virakshop.com
Received: from [36.255.98.22] (port=53667)
	by zpanel.taknet.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <supervisor@virakshop.com>)
	id 1vGuX2-0002at-2e
	for bpf@vger.kernel.org;
	Thu, 06 Nov 2025 08:35:52 +0100
Reply-To: harry.schofield@lexcapital-group.com
From: Harry Schofield ESQ <supervisor@virakshop.com>
To: bpf@vger.kernel.org
Subject: /Re,
Date: 5 Nov 2025 23:35:53 -0800
Message-ID: <20251105233553.ADD520D9309E66E2@virakshop.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - zpanel.taknet.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - virakshop.com
X-Get-Message-Sender-Via: zpanel.taknet.net: authenticated_id: supervisor@virakshop.com
X-Authenticated-Sender: zpanel.taknet.net: supervisor@virakshop.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Re: Good day,
Hope you are well, my first email returned undelivered, please=20
can I provide you with more information through this email?.
Best regards,
Harry Schofield

