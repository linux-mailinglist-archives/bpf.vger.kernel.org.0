Return-Path: <bpf+bounces-45834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAAA9DBAC0
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 16:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D978A2820B2
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 15:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B2F1C07E4;
	Thu, 28 Nov 2024 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fa+UNnZ2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7B91C07D6;
	Thu, 28 Nov 2024 15:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732808452; cv=none; b=L9jgvW0V47iSXbWNQOmLqQxilM9nXHGyCF0UstkQ37cZ6lkYwv+jY/uaa3tsyivXReXw+cYoePlw952YCN1debTT5ZznZCnsTBcfI+MsJSEqdUAjrEjwRLM/XRMgtpWp7nm8Z7F0lIZ5dNtQaacskExNyCUFmcqfd9Zje1yMqSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732808452; c=relaxed/simple;
	bh=RfU2BrNtVdE+B4PWzfkq5wiw0Y6hxjt2mh7JwGaBDeE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pEv2mWTcuzq35uXyHBgQ2/jy1Ks4ibbmQXloxYWSgjopvgCd7qUDvnxIlwS4o6xrlLH1Ea+/8HnwAIkPFxomVpRAH/X6djvaq4+xORbrjd8HbH5Z7EiZIwFPbrEBa1/XKu9JCaCJ199cAgfDEKSZDWpv64voYKx2yHIjhxGNcKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fa+UNnZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41B9C4CECE;
	Thu, 28 Nov 2024 15:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732808451;
	bh=RfU2BrNtVdE+B4PWzfkq5wiw0Y6hxjt2mh7JwGaBDeE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Fa+UNnZ2cgWObGLncp8jdSv7rTwuMxqu5ewM++dctQkrBy6cP16KbKku7kM1KoR5q
	 fcohCCtfqQ30Cx2aX/yZniA3UKguXqgHIoB46sXCpY2WvZy1e6295EgnCb7ycg/2xt
	 HzwzspATopwfwJbqsRl4LVhpTegqlGHD0JY/m8lWzil7Q90micOFVT2WBR5t+YtoVa
	 GmpCW5ROzZpIDEOEnxGKvrQ6xkLUFfvs9haNrJxi40h0S180RgrXo/0ceP9iqefw68
	 TmX/DIbl7hemvpnviu4u6ekyepYgnwhEgdeyRsZO/Rqbgr6IPh+pg00WJHUiDfIDJt
	 j1HLcUIZQOU1w==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org
In-Reply-To: <20241127-hid-bpf-ops-v1-1-f9e41bfa3afd@weissschuh.net>
References: <20241127-hid-bpf-ops-v1-1-f9e41bfa3afd@weissschuh.net>
Subject: Re: [PATCH] HID: bpf: constify hid_ops
Message-Id: <173280845054.2348538.3045601083967746197.b4-ty@kernel.org>
Date: Thu, 28 Nov 2024 16:40:50 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.1

On Wed, 27 Nov 2024 17:41:56 +0100, Thomas Weißschuh wrote:
> The hid_ops struct is never modified. Mark it as const.
> 
> 

Applied to hid/hid.git (for-6.13/upstream-fixes), thanks!

[1/1] HID: bpf: constify hid_ops
      https://git.kernel.org/hid/hid/c/f9a11da1d92f

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


