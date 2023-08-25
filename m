Return-Path: <bpf+bounces-8615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DDE788B79
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14782819F3
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 14:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E259910785;
	Fri, 25 Aug 2023 14:18:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1406C8CE
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 14:18:05 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017212682;
	Fri, 25 Aug 2023 07:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=97b0JfQGSNXqXd4NigawyuOiSD9yyLhmMPvce7xdAJo=; b=bZk9slxNMCK8YfIOmLcT8bDoQ+
	CF+iY2j2oqXiKFmSR7+zwzbCqwEpYA5VISyStJg2Tttg/Pl3MZ5WGrNerwHBT4gigZU31jLXYn76A
	ulpj+UZiVCyzAmkOup3aEDwMe4Jh6rUWaKfaY758KyVI/8kFRMxeEX/wkfhKFZh/iw5Ya5CKrKYNE
	Uz9+CUnyciMsTGggroLM4tSx5DHd8kufPkmohiyotTXibwExH6WZq/urzgWF6RnzMzM+IvmNaHVKP
	eW+Hor8lFEYZ6rXt9YH9AQZEdDShegK83YSVFG2kS7ZdaG3RxubcGPwsqji2crERVvpByraHyFT4M
	Yl2Bf2lg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qZXcI-000Hqa-5E; Fri, 25 Aug 2023 16:16:50 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qZXcH-000OoA-W6; Fri, 25 Aug 2023 16:16:50 +0200
Subject: Re: [PATCH 1/2] Documentation: sphinx: Add sphinx-prompt
To: Nishanth Menon <nm@ti.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 bpf@vger.kernel.org, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Neha Francis <n-francis@ti.com>
References: <20230824182107.3702766-1-nm@ti.com>
 <20230824182107.3702766-2-nm@ti.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <149528e1-062b-ebed-aa25-d37be5fe5894@iogearbox.net>
Date: Fri, 25 Aug 2023 16:16:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230824182107.3702766-2-nm@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27011/Fri Aug 25 09:40:47 2023)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/24/23 8:21 PM, Nishanth Menon wrote:
> Sphinx-prompt[1] helps bring-in '.. prompt::' option that allows a
> better rendered documentation, yet be able to copy paste without
> picking up the prompt from the rendered documentation.
> 
> [1] https://pypi.org/project/sphinx-prompt/
> Link: https://lore.kernel.org/all/87fs48rgto.fsf@baylibre.com/
> Suggested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Suggested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Given the patch 2/2 is targeted for bpf docs, we can route this via bpf-next.
Jonathan, could we get an ack for this one if it looks good to you?

Thanks,
Daniel

