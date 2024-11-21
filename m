Return-Path: <bpf+bounces-45392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAFD9D50F9
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 17:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30D48B260E8
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 16:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953431A070D;
	Thu, 21 Nov 2024 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P40SUAVE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA991AB6CE;
	Thu, 21 Nov 2024 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732207802; cv=none; b=EGo/tTREDHbGcl3BgBHAdiGopgf8LEMk0OWvFeAhrImvh84Xj5bxnyQ1mwKCc3ZaM9dq+Wrihd+LcPEK75sPkFDtEv0LGqjoCACVkFOMmaO8YmjNlN7l0mL446c6BP2TrK+/KImkp5loPZ8RpLAY4Z3V931Dalevqa/CiuOfZ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732207802; c=relaxed/simple;
	bh=PYuUHmOcp7lwA6lRIXG3lcUhFW3bbaV7n/1qg54d+DU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=QBfQiBJ4StDWc1+m6Iw7jT+OcpVf/a2NwM+A0RYb2dAaUtABAdAL0QwxI6A9UmisE725ddADgJBSR3j7lfseFmptyq95egv5qJtI1kq8DNDvP8shQ6t25gIcc/vWEFYC+0GJWulu0eHBHc+TLeefYjuH1KB75I7XTrgBcQWzz2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P40SUAVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5433C4CED0;
	Thu, 21 Nov 2024 16:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732207801;
	bh=PYuUHmOcp7lwA6lRIXG3lcUhFW3bbaV7n/1qg54d+DU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=P40SUAVED8Z8aZpwyl/pkwX1Gu6LzKC6kx7QewEZDn3HBdAgEB0jPoi09/kh9AB6a
	 a8VH69UVo2jg98OGgTHsGAZA6QD4Nk4/F1QKJLwUnQ5a+Nh2YmGAYcSLgeY7SnhB8g
	 bCGDG+Q31hhLdoNvlEVztNmqEoU50RBaoFA/gLYWMPSLmfcY7Ru4h4traniTmXuLyo
	 5dl4+QLPcnhif2XEW9f4LciQSdJUQoMCtyhdYMRGX4u4uFIQvnywhJehzRuW8DKS7r
	 +UpPZ4XSgsVJEdYj0Kcn6VbakEhHVYb5Ac8wkRw1waLq4fQQCHGStsse5Z7meW+o/h
	 9I25M4MPjLUVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0059D3809A01;
	Thu, 21 Nov 2024 16:50:15 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <20241119161923.29062-1-pabeni@redhat.com>
References: <20241119161923.29062-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20241119161923.29062-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.13
X-PR-Tracked-Commit-Id: dd7207838d38780b51e4690ee508ab2d5057e099
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fcc79e1714e8c2b8e216dc3149812edd37884eef
Message-Id: <173220781370.1988584.18030982237077896211.pr-tracker-bot@kernel.org>
Date: Thu, 21 Nov 2024 16:50:13 +0000
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 19 Nov 2024 17:19:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.13

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fcc79e1714e8c2b8e216dc3149812edd37884eef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

