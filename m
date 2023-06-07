Return-Path: <bpf+bounces-1998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08F37260F1
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 15:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7011B28127D
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 13:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A58E34D9D;
	Wed,  7 Jun 2023 13:16:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC47139F
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 13:16:48 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6221395;
	Wed,  7 Jun 2023 06:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=triKty2eWmiB4fvrBy4Tj5RIpIdluVAjdkSMtzCdvzk=; b=LoUSwzlXy2VYzAne77UBvaxvcV
	3+vDik5ef8dopUFA6r/1bTGLLVvta6aepG5CwY7J2+2Hsch7eZVFMIjYanDvBATi72t/MeovgRiks
	aSrE5j+qIeRRi/4M18ZYnPbhDeSYaLqW36oSC08ZmTOFoUJJwjVRIuA2hlyWM4x+AhUUrJgvgel4B
	Kgii2Kn94oFIb/zWFc5IeM2ycUo8J/BNj4NASiwfNaHbepDuCuZVsYw9260Ek2hLtPVSf2j4ZBWVo
	bokJ09q7K9tprWrB5Qaqv2baP0IDeM3e7Lkw9p+cVsRnU2VAO3o1ysbYElh2dGb6bJjH4z/6n0L47
	a7Ji6IEg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1q6t1o-0008OA-E0; Wed, 07 Jun 2023 15:16:44 +0200
Received: from [178.197.248.49] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1q6t1n-000RWB-TX; Wed, 07 Jun 2023 15:16:43 +0200
Subject: Re: [PATCHv2 bpf] bpf: Add extra path pointer check to d_path helper
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org, Stanislav Fomichev <sdf@google.com>,
 Anastasios Papagiannis <tasos.papagiannnis@gmail.com>, bpf@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@chromium.org>, Hao Luo <haoluo@google.com>
References: <20230606181714.532998-1-jolsa@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b311cea8-a6ee-6d4c-13ad-29bb6adcae63@iogearbox.net>
Date: Wed, 7 Jun 2023 15:16:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230606181714.532998-1-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26931/Wed Jun  7 09:23:57 2023)
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/6/23 8:17 PM, Jiri Olsa wrote:
> Anastasios reported crash on stable 5.15 kernel with following
> bpf attached to lsm hook:
[...]
> Fixes: 6e22ab9da793 ("bpf: Add d_path helper")
> Acked-by: Stanislav Fomichev <sdf@google.com>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Reported-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Looks like patchbot is not replying.. applied, thanks!

