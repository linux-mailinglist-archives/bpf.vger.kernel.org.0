Return-Path: <bpf+bounces-15751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 165B17F6048
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 14:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD97281E60
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 13:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C45B250F7;
	Thu, 23 Nov 2023 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="EI6qt16N"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B2EBA;
	Thu, 23 Nov 2023 05:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=yW8Xpy7WFdU5emWEMV3cGGEJXXouqKEio/Q7EZwtC1c=; b=EI6qt16NOVBRmU0Oey7ynTU/A+
	RX/mKHdvJ92qRPF8h6jd0MNuF87iPf6GLGsZSFaVl15A/nx0AVm5U/8hQC5Ocg6WoDztLSlmDZvly
	1DI2cCpDv5J1wajhAPiD429v58Fao7/0Nh+sQ0SsdIU571Zpfsgw7KZKTG8BHlz7EaR2p8pssT5GL
	T9w6XWHsS83GjIbSftPriz1RIoaqZTGOhEK3hUdGcrPV1kwZ9w0zJn/HYmcItM9yQjkPofR8ZGa+P
	m0w6Eloue8zHU5n5Gm3mYyQzas9l+vt3o+Sj7rhFs3ovwLAmB2HSG4fzEvhMmVX77830pGT2/zv0e
	mtANanFg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r69nr-000ObS-2l; Thu, 23 Nov 2023 14:31:35 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r69nq-000KQ1-CB; Thu, 23 Nov 2023 14:31:34 +0100
Subject: Re: [PATCH bpf-next v2 0/3] skmsg: Add the data length in skmsg to
 SIOCINQ ioctl and rx_queue
To: Pengcheng Yang <yangpc@wangsu.com>,
 'John Fastabend' <john.fastabend@gmail.com>,
 'Jakub Sitnicki' <jakub@cloudflare.com>, 'Eric Dumazet'
 <edumazet@google.com>, 'Jakub Kicinski' <kuba@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <1700565725-2706-1-git-send-email-yangpc@wangsu.com>
 <6c856222-d103-8149-1cdb-b3e07105f5f8@iogearbox.net>
 <000001da1dff$223ed4e0$66bc7ea0$@wangsu.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <91ab6f52-c345-540f-703b-844293eda297@iogearbox.net>
Date: Thu, 23 Nov 2023 14:31:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <000001da1dff$223ed4e0$66bc7ea0$@wangsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27102/Thu Nov 23 09:42:42 2023)

On 11/23/23 12:20 PM, Pengcheng Yang wrote:
> Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 11/21/23 12:22 PM, Pengcheng Yang wrote:
>>> When using skmsg redirect, the msg is queued in psock->ingress_msg,
>>> and the application calling SIOCINQ ioctl will return a readable
>>> length of 0, and we cannot track the data length of ingress_msg with
>>> the ss tool.
>>>
>>> In this patch set, we added the data length in ingress_msg to the
>>> SIOCINQ ioctl and the rx_queue of tcp_diag.
>>>
>>> v2:
>>> - Add READ_ONCE()/WRITE_ONCE() on accesses to psock->msg_len
>>> - Mask out the increment msg_len where its not needed
>>
>> Please double check BPF CI, this series might be breaking sockmap selftests :
>>
>> https://github.com/kernel-patches/bpf/actions/runs/6922624338/job/18829650043
> 
> Is this a misunderstanding?
> The selftests failure above were run on patch set v1 4 days ago, and this patch v2
> is the fix for this case.

Indeed looks like there were two CI emails on v2 as well, one pointing to
failure (which was also linked from patchwork), and one to success, both
pointing to:
https://patchwork.kernel.org/project/netdevbpf/list/?series=802821&state=*
Let me rerun, meanwhile, I placed it back to 'under review'.

