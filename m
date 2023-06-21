Return-Path: <bpf+bounces-3071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1E77390D3
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 22:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E372817A3
	for <lists+bpf@lfdr.de>; Wed, 21 Jun 2023 20:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD3819E6E;
	Wed, 21 Jun 2023 20:34:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1076134A2;
	Wed, 21 Jun 2023 20:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F82C433C0;
	Wed, 21 Jun 2023 20:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687379666;
	bh=oRCppn6NllTeLup6jUsefGGPWfQvRH0xfbfsHtA0nyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=drxpX8Gjt69P4OK5d7luQRWitThKdyv7Y9GJY7lOcVj35q1wPEBQDPaMBK6OSLtwG
	 HiFsYsxg43+f5BtbBwHevqal0OginAPLfbMNTFOIJqtF66t44CpDr8rl4DoKdc8WZY
	 5x161x834pferVm5VPisOrBzYOfl04U5xjrA4SEwTm9hGqb0OfcUZS2AyIDoqnHsHD
	 ncWiN+ccHdLbAUQvvza/kSUeV2b6ZfkEM3zQd9gldOT4plnP8ctz7KLxsyrOM/D6+S
	 crVQXWxU5hP4Myhnez9Lglk9lYwjv7kLo9OJzW1LO21ItxxXPt1WjUYl1MG7J6C7iK
	 V289fjyWyYvGw==
Date: Wed, 21 Jun 2023 13:34:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 netdev@vger.kernel.org, magnus.karlsson@intel.com, bjorn@kernel.org,
 tirthendu.sarkar@intel.com, simon.horman@corigine.com
Subject: Re: [PATCH v4 bpf-next 15/22] xsk: add multi-buffer documentation
Message-ID: <20230621133424.0294f2a3@kernel.org>
In-Reply-To: <CAJ8uoz1j9t=yO6mrMEseRYDQQkn0vf1gWbwOv7z9X0qX0O0LVw@mail.gmail.com>
References: <20230615172606.349557-1-maciej.fijalkowski@intel.com>
	<20230615172606.349557-16-maciej.fijalkowski@intel.com>
	<87zg4uca21.fsf@toke.dk>
	<CAJ8uoz2hfXzu29KEgqm3rNm+hayDtUkJatFVA0n4nZz6F9de0w@mail.gmail.com>
	<87o7l9c58j.fsf@toke.dk>
	<CAJ8uoz1j9t=yO6mrMEseRYDQQkn0vf1gWbwOv7z9X0qX0O0LVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jun 2023 16:15:32 +0200 Magnus Karlsson wrote:
> > Hmm, okay, that sounds pretty tedious :P  
> 
> Indeed if you had to do it manually ;-). Do not think this max is
> important though, see next answer.

Can't we add max segs to Lorenzo's XDP info?
include/uapi/linux/netdev.h

