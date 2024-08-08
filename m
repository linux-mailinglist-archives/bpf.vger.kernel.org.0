Return-Path: <bpf+bounces-36701-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97DD94C432
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 20:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1B91C20399
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 18:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE6B1422B8;
	Thu,  8 Aug 2024 18:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Hk2lqIWQ"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB8978281;
	Thu,  8 Aug 2024 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723141241; cv=none; b=SiOf+5Zxk7tE9ekYie6aFfLbHdv7vPH+xwvivsy1ZXQdLGhQaENyiFJ4y6COHhcqBtzAJvACSVjEG+ChghmVUJhMC5C6VbiEIT4KQA4XMZGhTNvXNnFkST7xL/jkAlHMUPPG3OHB221yGDtV88+/XD9VwT/Jln/hXpYbW7+V1R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723141241; c=relaxed/simple;
	bh=j9eVzVOxOErcrgnP/Bt6vhmW0/cWMReSjVsh1FlguqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WgNFJkRio6bg5GYLjBUI9QWtHsSDKFfYMjz6icx/NI7K9Ub9yiskMJRrvgLn99NkDkiMZ5GskMpx80xx/GRl4+mvmj4eEC8U0EGv5PcfEhhU2QEtGGlaKEY0F1caa9GR2py0hUB7oEOAQp8j5En3yBliUFa+fPK2biIIlLuUDSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Hk2lqIWQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 2434920B7165; Thu,  8 Aug 2024 11:20:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2434920B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1723141233;
	bh=j9eVzVOxOErcrgnP/Bt6vhmW0/cWMReSjVsh1FlguqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hk2lqIWQ8mJ88pEWjaM+9ZH08nyb+l6tkaARknde+EIim4phdajl+rPzEt53R4mNZ
	 FtG8MkPAmyMpAUiP7Uv0GXkoVZ0c5W3sBYOH8nxhegqEqntkQ9tI59o8uiR6PkEsDt
	 uikd37UZDkR05dQM+mlg04ME+OtUxhtNCPkBs5JY=
From: Hardik Garg <hargar@linux.microsoft.com>
To: toracat@elrepo.org,
	gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	qmo@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org
Subject: Re: bpf tool build failure in latest stable-rc 6.1.103-rc3 due to missing backport
Date: Thu,  8 Aug 2024 11:20:33 -0700
Message-Id: <1723141233-21006-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <v8lqgl$15bq$1@ciao.gmane.io>
References: <v8lqgl$15bq$1@ciao.gmane.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

adding the BPF maintainers




Thanks,
Hardik

