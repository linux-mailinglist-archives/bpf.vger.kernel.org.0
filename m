Return-Path: <bpf+bounces-35128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 591E1937E39
	for <lists+bpf@lfdr.de>; Sat, 20 Jul 2024 01:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138B128233D
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 23:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6ED149C41;
	Fri, 19 Jul 2024 23:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNBOBnDQ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA2E1494D9
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 23:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721433115; cv=none; b=hRV03to7dWdzwz6WXgTH7VKGtMc4ZctTT2b2n9893i0gQo2LXIpf7TCf/rP9jG4lPndPqlDzrrWAEKXaJKZsqI/7i3qx6KuTxKleFfCQW1kGchf/c5KDoP4JDe9JFYVsYJVIPybdUoVrDCT/X89LVsdNRgxDFbwmwz7m6mtIfEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721433115; c=relaxed/simple;
	bh=y3qDCGGYrETp8qHxc75Z4tJK2qBoeqACpJTpUXnS85o=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Rm4ntVDPmw6dGnBq/BYhWo5Bm1EHnZdLRO6A7+q3iJ8cSY/eVhnB8cHsbKzklk0laOdKtt9kVO9EeZSKUjOTppdxjzv92+L/K0XgYjclb0S/ss8E1f8wP+rFt6e+fCkliFr8na/xMf6xQ5LmyIlvuL1TPUYIcjGrFTYS1MVMI/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNBOBnDQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC04C32782;
	Fri, 19 Jul 2024 23:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721433114;
	bh=y3qDCGGYrETp8qHxc75Z4tJK2qBoeqACpJTpUXnS85o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=mNBOBnDQH2eEY9sNVHoi0nfAsrvyvDsan0/NNGJpLPnjEa/lLqLUEXkqyNNM7BdW0
	 X83O3CkTV342Cp4mVS/50eR3aG3YulayJgwU5QvzX3/EphUySUwiM2HjgP6pOh3XCH
	 Sx75wARgV+s8UQeh0UpDuwzIGHG1Lf1LC5FfHZgXs6ek2taydRp3Sg238ZnpdY+wkp
	 IdH6pi1MM/APe3Xg1lCmGgIx8jrojkU2O/MJyDNKK2dLh5tTpzQ59s5C7itnx2WD86
	 PMI4QhCapcBrZY2odenEVGXsWGksNLpS6CQA94gOJxTfMI3PQ/B1tU33f8iZWJ63t/
	 HBcRQPV/sXUPQ==
Content-Type: multipart/mixed; boundary="===============5819663609184124140=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <99096475f2df2ccf2a2ea3239bd1c08e7765d879066b27508ebcce05f79c4881@mail.kernel.org>
In-Reply-To: <20240718050228.3543663-1-yonghong.song@linux.dev>
References: <20240718050228.3543663-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for ldsx of pkt data/data_end/data_meta accesses
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev
Cc: bpf@vger.kernel.org,kernel-ci@meta.com
Date: Fri, 19 Jul 2024 23:51:54 +0000 (UTC)

--===============5819663609184124140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Dear patch submitter,

CI has tested the following submission:
Status:     SUCCESS
Name:       [bpf-next,v2,2/2] selftests/bpf: Add tests for ldsx of pkt data/data_end/data_meta accesses
Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=872131&state=*
Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10015588889

No further action is necessary on your part.


Please note: this email is coming from an unmonitored mailbox. If you have
questions or feedback, please reach out to the Meta Kernel CI team at
kernel-ci@meta.com.

--===============5819663609184124140==--

