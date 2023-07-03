Return-Path: <bpf+bounces-3885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 901147460F8
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 18:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A982809C7
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 16:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1447F100DA;
	Mon,  3 Jul 2023 16:51:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCEF100B9
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 16:51:12 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B4EB3;
	Mon,  3 Jul 2023 09:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=QxCppFoOWYJMBZrEBLiTvPrc7XcTX5YOJcuc4Sw87jM=; b=FO5t8w2XVVxL31TJKd8jlr+Dcl
	+1ZQfQvaYW15WpVdkO17A7Rwip7ZPPIPMNMk/krnWLw9UX8EpyNsZXliGDZxCt5yt2hdR91n1o3Fp
	CGc6lcmPBdCQHdRLQWIKaEDv5M1PH47R3o0bDFFK08oZbjJVwhAM4uAar8A3AzfzU2OGxMjNyRqlO
	kimbfWX0a//mHxXspi7SwR9oktTS2e+QReanfvgYOw18wZY+A53zvrTVld9rel9aYF7Fjm8QhG/uh
	6Nygm4ha3zqjTzHqEdqPTC3cU4wcxSQXYHJlOjSmLlJCZ12/OHMka9v+8G2AsTlHJ+BYE5mTfe+tw
	xF5DPpzQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qGMlU-00062G-Lq; Mon, 03 Jul 2023 18:51:04 +0200
Received: from [178.197.249.52] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qGMlU-000EYF-B7; Mon, 03 Jul 2023 18:51:04 +0200
Subject: Re: [PATCH v2] btf: warn but return no error for NULL btf from
 __register_btf_kfunc_id_set()
To: SeongJae Park <sj@kernel.org>
Cc: martin.lau@linux.dev, Alexander.Egorenkov@ibm.com, ast@kernel.org,
 memxor@gmail.com, olsajiri@gmail.com, bpf@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Olsa <jolsa@kernel.org>
References: <20230630210251.126928-1-sj@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4c91c1a1-4f1c-09f2-95de-3fcc744c0989@iogearbox.net>
Date: Mon, 3 Jul 2023 18:51:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230630210251.126928-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26958/Mon Jul  3 09:29:03 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/30/23 11:02 PM, SeongJae Park wrote:
[...]
> Also, please note that this will not cleanly applicable on 6.1.y.  I will
> provide the backport to stable@ as soon as this is merged into the mainline.

Perfect, thanks!

