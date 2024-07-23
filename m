Return-Path: <bpf+bounces-35336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED8C93985B
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 04:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D513B21B42
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0091386B3;
	Tue, 23 Jul 2024 02:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6pp7Kzy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048823D6A
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 02:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721702559; cv=none; b=t1lFcpo93UAWTfaJ09chXYsbXaOw11xxUv4W5ptvLIx8oUcB1O42PM41aiYoRB9M4H4BoQS7iQKS5RjPiB6GhU9mCMKqq4Rcn5eaVZoB/WYamGtK4yXOi2ZogdHJbbzpx67KO9MSsDhe9aQ9XNx6HEsfTeUZ7xAqeinbeFjBzpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721702559; c=relaxed/simple;
	bh=5EQ+upSaLK4swjX5hfANKGDBiar2vk8c12QPUnaEbSQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=B3fxZn6m2msIUJX45dwwaTCJoRXDVvBbSPTwIpuX6SBtNBnA+zURDIXaUv8MpbzDZ/rzJ+qM3DLr+7dXLAuCK0tJm+UoVN+7+WUcoWci9ZnSR7bHFRumtLcnY9OSIMXsP8ohSE/MNC+Roes20QTPEl/smzAHFt/iMsgAeM1HNnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6pp7Kzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6B6C32782;
	Tue, 23 Jul 2024 02:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721702558;
	bh=5EQ+upSaLK4swjX5hfANKGDBiar2vk8c12QPUnaEbSQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=S6pp7KzyCrWGxqBai9+0stYsahTTdiwFsI+7pcJznzlQj3pMFDX5hcgtZnH5KWxIK
	 gIozw96WPz9yp0QKyr7W7eS4EkqYvvIaIha3YrYzwJdfEBT7rO3eK4bMAosHCWOKCJ
	 HM/pSu1zJxDbR8pdJ0iRqP0ThwP5+hwHfs8cx7uvwNMeq1aLo7dwOAuwWbbs3HquCg
	 FlF6rqhwj759K2b4Gtr8vS0I/sUFGYshJygHTxbrRZ7jA05wVTTkIIdaz5B0PD924D
	 yTatqQofdiDzrjxbQ3m7UMMMDuzt0sgBAgGa+A1HojwVHOzEsikjdMqlwgaTHHjDu4
	 XP0eosxKg/Vtg==
Content-Type: multipart/mixed; boundary="===============5317232218417656344=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e540dd9fbfde1478595e8ed2c96d377e46ccd0ac6fdd9b296105137dd042a646@mail.kernel.org>
In-Reply-To: <20240722233844.1406874-1-eddyz87@gmail.com>
References: <20240722233844.1406874-1-eddyz87@gmail.com>
Subject: Re: [PATCH bpf-next v4 00/10] no_caller_saved_registers attribute for helper calls
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Tue, 23 Jul 2024 02:42:38 +0000 (UTC)

--===============5317232218417656344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next,v4,00/10] no_caller_saved_registers attribute for helper calls
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=873083&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10051541692

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============5317232218417656344==--

