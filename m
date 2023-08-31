Return-Path: <bpf+bounces-9069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150B178F026
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 17:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA31281634
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 15:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D04C12B65;
	Thu, 31 Aug 2023 15:21:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0868F186A
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 15:21:33 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76517E6A
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 08:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=AdiFqZIp1q+SFvbXCvFOi1DQcMd8VfZl2IsYCx0/FSo=; b=mRJ1jszpJl5TBKJLr4Er9GqORH
	pO8H4/+acp7D7vRd8m0zjUqRrDIrKycpdVKOo29ArsW3Qs3e6ej5nTO8nAjXvnmXjpOSwCumm5bRD
	U7BzsOjITwxroEoIKL8Aq4PVPdR2aL5onHqFSOrYlDjbFIAEeAiIeZ0b18a7P7FEiD18gXhfiTaRJ
	dCqs+Ye+OX9wsyf2R5iivNwciUTDU+1rciAWFxdPpP4+K2Ucgwkg0X7euwfe7j/hnJ+6rsosAAL5v
	aOt795rj0UKI9elfTA6GuuOkPewJQpCGIBj31QG8chiKr9OqwpcZ6z62YoUFBHgk59qT+Jbbn/tce
	zOxzmrxQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qbjTo-000Pd6-O8; Thu, 31 Aug 2023 17:21:09 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qbjTo-000DiJ-Hz; Thu, 31 Aug 2023 17:21:08 +0200
Subject: Re: [PATCHv2 bpf-next] selftests/bpf: Fix d_path test
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Hou Tao <houtao1@huawei.com>
References: <20230831141103.359810-1-jolsa@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1fc894ed-0f54-ea4f-8b2f-d7120b6d9c0f@iogearbox.net>
Date: Thu, 31 Aug 2023 17:21:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230831141103.359810-1-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27017/Thu Aug 31 09:40:48 2023)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/31/23 4:11 PM, Jiri Olsa wrote:
> Recent commit [1] broken d_path test, because now filp_close is not called
> directly from sys_close, but eventually later when the file is finally
> released.
> 
> As suggested by Hou Tao we don't need to re-hook the bpf program, but just
> instead we can use sys_close_range to trigger filp_close synchronously.
> 
> [1] 021a160abf62 ("fs: use __fput_sync in close(2)")
> Suggested-by: Hou Tao <houtao@huaweicloud.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

That did the trick, thanks everyone, applied!

