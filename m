Return-Path: <bpf+bounces-44917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C6A9CD554
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 03:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3711F223DB
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 02:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EC61442F4;
	Fri, 15 Nov 2024 02:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MifU1ft7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE55284D02;
	Fri, 15 Nov 2024 02:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731637326; cv=none; b=ELSzweky0etVIOzpaqAK3GWY2wNh9TmBMsEOcXuVbTZ3bSocXMRxF5NBFJY2IRmnGK+TRw/tdtNNZQOOR6z/EB0oCiBd04CZPVIS/yQP3uDTuOW+F+/3pswz8orsk1smSUEaHBSQiuzpmj+a64gV8VH7gKOmbctwMfkXZHuMEMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731637326; c=relaxed/simple;
	bh=g0xEvCzZMMSK2UulgwKL9aXd0SK9uImX1WbO+gn7Y8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgWbMVOAWCRNMBQnAJ/UopseSHWi1ncZ9zUx1Api5h1DOXxSsr1yIWnnlMF0G5uyuN02mg2Gd6mo96xFshjetTGK4yhaHAHemOzNms4XL/sc76WfwE6JHK+QQV9rAPRKX4d/z57n1KuqOQtHN37DscHmjKNzx0/Ey6B5refSEiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MifU1ft7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDD9C4CECD;
	Fri, 15 Nov 2024 02:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731637325;
	bh=g0xEvCzZMMSK2UulgwKL9aXd0SK9uImX1WbO+gn7Y8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MifU1ft7lEj//tgGs7+dEnAVKWnLiBxKJtTrefRMjcsFWNvVIEqHnaIqcPJgTKsbX
	 b3Z3bS3n/hPN6WMmVcAaacj0uwHI9pmsj83HpWGmAc2aJmFVHAn9sv/ItPN4UAoDWZ
	 fFs4Bf3YvkVi456ShakW8z6uISJ7OFb3CkdYNHNiK+/hVc8YPrrgjIEXXPw46R0WXS
	 QTg5pvzLTUzj/ehPxnqUYhGHZRyaGqJBbT7Fta57nP8jOOZEIC3m9OByusXm6Z4zEU
	 i33q35Xq6MaPGNvJ2NQ06NwU1mCmaUNrblt5Ok7W3AarBEfALQmPbcVnfl6jU+GlE9
	 zmz1nDK57jVxQ==
Date: Thu, 14 Nov 2024 18:22:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Felix Maurer <fmaurer@redhat.com>, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, yoong.siang.song@intel.com,
 sdf@fomichev.me, netdev@vger.kernel.org, Michal Schmidt
 <mschmidt@redhat.com>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf] xsk: Free skb when TX metadata options are invalid
Message-ID: <20241114182203.2f6353d2@kernel.org>
In-Reply-To: <e5edc796-7ae3-4b57-b8ee-223f2c26f936@linux.dev>
References: <edb9b00fb19e680dff5a3350cd7581c5927975a8.1731581697.git.fmaurer@redhat.com>
	<e5edc796-7ae3-4b57-b8ee-223f2c26f936@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 13:43:22 -0800 Martin KaFai Lau wrote:
> Jakub, can you help to take it directly to the net tree? Thanks!

Ack, will do!

