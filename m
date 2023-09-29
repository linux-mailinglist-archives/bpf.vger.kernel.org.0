Return-Path: <bpf+bounces-11102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8797B2F20
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 11:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id CC43D1C20B1C
	for <lists+bpf@lfdr.de>; Fri, 29 Sep 2023 09:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5DB125BC;
	Fri, 29 Sep 2023 09:25:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB1C9CA7A;
	Fri, 29 Sep 2023 09:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F53C433C7;
	Fri, 29 Sep 2023 09:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695979527;
	bh=Ti9DZZ19rV42Iow/MPF+Ri4zjNiXMprHHMErhBYkwlc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ejPj6AOZ2jJD1DemNlm8WoUKIi2339Pzn/gg9m9OaJ6I2H/KxRduboXEADa11WxQQ
	 4WZvBY0W8WmKKqZtnE8c6FNRGiC+mX+XZAFU/3PXGPgMcejbVLlqiX6rLbVZj5yfh1
	 iacVNH6u4Jsy7USh9h1fEASqdm4SvdM9po02Pr3+RmdzNEZpU9vAcRac2RbQ0CoYSD
	 H8v9ZPDYtfelkxUcqUr3taH6Qc3RPdOZ2G/UHqxgi0kGBzqmiJuzXXadnF0lGZbBN2
	 N1aqTUoZ5UHadq3hbOu//IHgQ+R6JFRrL/lvO+6gdVDRULd158fX7YwFgeqF2jDINi
	 //RHRtHfS7WhA==
Date: Fri, 29 Sep 2023 11:25:21 +0200
From: Christian Brauner <brauner@kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	David Ahern <dsahern@kernel.org>
Subject: Re: Persisting mounts between 'ip netns' invocations
Message-ID: <20230929-paket-pechschwarz-a259da786431@brauner>
References: <87a5t68zvw.fsf@toke.dk>
 <2aa087b5-cbcf-e736-00d4-d962a9deda75@6wind.com>
 <20230928-geldbeschaffung-gekehrt-81ed7fba768d@brauner>
 <87il7ucg5z.fsf@toke.dk>
 <a68b135f-12ee-3c75-8b12-d039c9036d53@6wind.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a68b135f-12ee-3c75-8b12-d039c9036d53@6wind.com>

> I fear that creating a new mount ns for each net ns will introduce more problems.

Not sure if we're talking past each other but that is what's happening
now. Each new ip netns exec invocation will allocate a _new_ mount
namespace. In other words, if you have 300 ip netns exec commands
running then there will be 300 individual mount namespaces active.

What I tried to say is that ip netns exec could be changed to
_optionally_ allocate a prepared mount namespace that is shared between
ip netns exec commands. And yeah, that would need to be a new command
line addition to ip netns exec.

