Return-Path: <bpf+bounces-3676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 339F2741974
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 22:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 147721C20826
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 20:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8550610974;
	Wed, 28 Jun 2023 20:28:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7B41094D;
	Wed, 28 Jun 2023 20:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2030DC433C8;
	Wed, 28 Jun 2023 20:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687984122;
	bh=2ngmv8TfdwDU7n9twf1zZzLQXuUZt2cau8tUE4EiYIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FWAxrsUaAE77RFnNv0V8aU6+H1AQaKIyXbjYZpfa2yJT6V4tgH5QvWAzroth0cxfk
	 4CvihoClrAx3BBaFqhQkQbWI/rc5j24MtwHm086vrHWB/zZSbNsvl2qblt0ujp+I2b
	 ynP4YnCa1WQdKzyUhZyXC+n3v0HJMq1vaU28UXd5gdF1lbDMcRo01gXBaQFblZaR83
	 VTr8Z4/m0moG85TPo4i5ruHhfds41U3Kkz3PSNLvdpyF4xhtWt+95X78dokLZqyFiK
	 1r+jr/l5P5vD95oIMcODpd3iKWAtK/xpjLojKpAv1GEnOix1wifc0iotBA5FB6E8zu
	 A5YVRSun1ADLg==
Date: Wed, 28 Jun 2023 13:28:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Magnus
 Karlsson <magnus.karlsson@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <netdev@vger.kernel.org>, <magnus.karlsson@intel.com>, <bjorn@kernel.org>,
 <tirthendu.sarkar@intel.com>, <simon.horman@corigine.com>
Subject: Re: [PATCH v4 bpf-next 15/22] xsk: add multi-buffer documentation
Message-ID: <20230628132841.6c70690f@kernel.org>
In-Reply-To: <ZJx9WkB/dfB5EFjE@boxer>
References: <20230615172606.349557-1-maciej.fijalkowski@intel.com>
	<20230615172606.349557-16-maciej.fijalkowski@intel.com>
	<87zg4uca21.fsf@toke.dk>
	<CAJ8uoz2hfXzu29KEgqm3rNm+hayDtUkJatFVA0n4nZz6F9de0w@mail.gmail.com>
	<87o7l9c58j.fsf@toke.dk>
	<CAJ8uoz1j9t=yO6mrMEseRYDQQkn0vf1gWbwOv7z9X0qX0O0LVw@mail.gmail.com>
	<20230621133424.0294f2a3@kernel.org>
	<CAJ8uoz3N1EVZAJZpe_R7rOQGpab4_yoWGPU7PB8PeKP9tvQWHg@mail.gmail.com>
	<875y7flq8w.fsf@toke.dk>
	<ZJx9WkB/dfB5EFjE@boxer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jun 2023 20:35:06 +0200 Maciej Fijalkowski wrote:
> Okay, here's what I came up with, PTAL, it's on top of the current set but
> that should not matter a lot, you'll get the idea of it. I think it's
> better to post a diff here and if you guys find it alright then I'll
> include this in v5.

LGTM!

