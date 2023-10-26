Return-Path: <bpf+bounces-13313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D6D7D8250
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 14:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0D51F231B4
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 12:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941AB2DF60;
	Thu, 26 Oct 2023 12:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="a+tHNCJV"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AC512B69;
	Thu, 26 Oct 2023 12:12:19 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39749B9;
	Thu, 26 Oct 2023 05:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=TBeLZIWK9Sa831rnxvgFsesRY+fl60r7sXPrzABv3ZQ=; b=a+tHNCJVAY2tW7blTKBc+pOgbU
	TZa6rv3K7BjjKzWv0nCmE/IJc6y7GH1r2UOtaFwSIMk7HHBV/6lFGAnoxwzEZLx65RZmWQ9Rg9kMe
	JzBa/XzxgKqZU2Kfp/lbxguhtxKdsePQ/0oxF4tLuUQzFX0dLcVYfxAJiE6MAF5ZEshZzPagAA8hd
	i7gDumzhEWdqFqMKItt25ejaP0LYuGs3QORMpJw8aLFZ7ElVbUJvegT1IlOaVwmhS57u4b1ZCB7+d
	85SQEdcE3naGbOEVKqNu4ANtHNy6Rz/t1C247vpiXjKMZGHjbikExY64qrZnZu8aSuLgt9PgF4AAm
	XGNYpy1g==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvzDk-000O8f-Hi; Thu, 26 Oct 2023 14:12:16 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvzDj-0009vg-9n; Thu, 26 Oct 2023 14:12:15 +0200
Subject: Re: [PATCH bpf-next 1/2] netkit: remove explicit active/peer ptr
 initialization
To: Nikolay Aleksandrov <razor@blackwall.org>, bpf@vger.kernel.org
Cc: jiri@resnulli.us, netdev@vger.kernel.org, martin.lau@linux.dev,
 ast@kernel.org, andrii@kernel.org, john.fastabend@gmail.com,
 kuba@kernel.org, andrew@lunn.ch, toke@kernel.org, toke@redhat.com,
 sdf@google.com
References: <20231026094106.1505892-1-razor@blackwall.org>
 <20231026094106.1505892-2-razor@blackwall.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <69b65b9d-76d8-769f-d969-e030e77f8f2a@iogearbox.net>
Date: Thu, 26 Oct 2023 14:12:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231026094106.1505892-2-razor@blackwall.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27073/Thu Oct 26 09:47:53 2023)

On 10/26/23 11:41 AM, Nikolay Aleksandrov wrote:
> Remove the explicit NULLing of active/peer pointers and rely on the
> implicit one done at net device allocation.
> 
> Suggested-by: Jiri Pirko <jiri@resnulli.us>
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

