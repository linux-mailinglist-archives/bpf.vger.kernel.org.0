Return-Path: <bpf+bounces-45321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 330849D4544
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 02:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B718D1F2248F
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 01:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A350B132122;
	Thu, 21 Nov 2024 01:25:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D2354918
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 01:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732152350; cv=none; b=KBYWmy3/6jTbkMuXAQGVNmIb2wjQMq2si2LMbigij+UnT7IWn46H8Wi1AU52NnsslNmP3LZRX6jIkPr9ZS4lSHsPOUADqft1Jn4TW7ajYH4ysSuSzXDyLMqh4Kq7T0aGln2ZKBamNSZoPviQaj+QFBZ4nz/K8BF1hOh/54nkOPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732152350; c=relaxed/simple;
	bh=JdoPrGONCbb4LRHo/z0YMboluey81sWcMKBQHmnvJPc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rTDbS8s0yhvLeNIG33gnoOTc3R4xCYd0IAlpC3PL98b2J0qPtlb0Wfz07U22Vo1n8j7FUM5WonDuN7JUHPDgeP0ndbLy1ScbRznAblct6LMCmT4X7+O9MAsXw2nW/xOh6YWeVfkbSlzpYAyCxPN3cHg80kb+iO0OiCEaZb9pCxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xv0qg2pvWz2DgmT;
	Thu, 21 Nov 2024 09:23:43 +0800 (CST)
Received: from kwepemh200010.china.huawei.com (unknown [7.202.181.119])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B87E140155;
	Thu, 21 Nov 2024 09:25:43 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 kwepemh200010.china.huawei.com (7.202.181.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Nov 2024 09:25:42 +0800
Subject: Re: [ANN] bpf development stats for 6.13
To: Stanislav Fomichev <stfomichev@gmail.com>, <bpf@vger.kernel.org>
CC: <kuba@kernel.org>
References: <Zz4FDv5bnghUlJQP@mini-arch>
From: Hou Tao <houtao1@huawei.com>
Message-ID: <002f92f3-b1ca-926c-a1ca-4486b24e20ae@huawei.com>
Date: Thu, 21 Nov 2024 09:25:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zz4FDv5bnghUlJQP@mini-arch>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh200010.china.huawei.com (7.202.181.119)



On 11/20/2024 11:49 PM, Stanislav Fomichev wrote:
> Regular development statistics update, similar Jakub's netdev post:
> https://lore.kernel.org/netdev/20241119191608.514ea226@kernel.org/T/#u
>
> Previous cycle:
> 16 Jul to 16 Sep: 5077 mailing list messages, 62 days, 82 messages per day
> 247 repo commits (4 commits/day, 45.75% of these are selftests)
> https://lore.kernel.org/bpf/ZvH8f643jvK_gkyJ@mini-arch/
>
> Current cycle:
> 19 Sep to 19 Nov: 5097 mailing list messages, 61 days, 84 messages per day
> 260 repo commits (4 commits/day, 56.92% of these are selftests)
>
> Developer rankings
> ------------------
>
> Top reviewers (cs):                  Top reviewers (msg):                
>    1 (   ) [7] Andrii Nakryiko          1 ( +1) [21] Alexei Starovoitov  
>    2 (   ) [7] Alexei Starovoitov       2 ( -1) [19] Andrii Nakryiko     
>    3 ( +1) [3] Martin KaFai Lau         3 ( +1) [ 8] Martin KaFai Lau    
>    4 ( +2) [2] Yonghong Song            4 ( -1) [ 7] Eduard Zingerman    
>    5 (+11) [2] Daniel Borkmann          5 ( +2) [ 5] Jiri Olsa           
>    6 ( -3) [2] Eduard Zingerman         6 (***) [ 5] Willem de Bruijn    
>    7 ( -2) [2] Jiri Olsa                7 (+16) [ 5] Steven Rostedt      
>    8 ( -1) [2] Jakub Kicinski           8 (+12) [ 5] Toke Høiland-Jørgensen
>    9 ( +3) [1] Toke Høiland-Jørgensen    9 ( -3) [ 4] Yonghong Song       
>   10 (+12) [1] Peter Zijlstra          10 ( +4) [ 4] Stanislav Fomichev  
>   11 (+44) [1] Tejun Heo               11 (+18) [ 4] Daniel Borkmann     
>   12 ( +1) [1] Simon Horman            12 (+12) [ 4] Song Liu            
>   13 ( -3) [1] Stanislav Fomichev      13 ( -2) [ 3] Maciej Fijalkowski  
>   14 (***) [1] Kumar Kartikeya Dwivedi   14 (+32) [ 3] Peter Zijlstra      
>   15 ( -1) [1] Quentin Monnet          15 (***) [ 3] Kumar Kartikeya Dwivedi
>
> Top authors (cs):                    Top authors (msg):                  
>    1 (   ) [2] Andrii Nakryiko          1 (+19) [11] Jiri Olsa           
>    2 (***) [1] Hou Tao                  2 (+13) [11] Yonghong Song       
>    3 ( +7) [1] Jiri Olsa                3 (+47) [11] Alexander Lobakin   
>    4 (+14) [1] Namhyung Kim             4 ( +2) [ 8] Masami Hiramatsu (Google)
>    5 (+30) [1] Daniel Borkmann          5 (***) [ 8] Hou Tao             
>    6 ( -3) [1] Eduard Zingerman         6 (+21) [ 7] Mathieu Desnoyers   
>    7 (***) [1] Zijian Zhang             7 (***) [ 7] Menglong Dong       
>    8 (***) [1] Kumar Kartikeya Dwivedi    8 (+29) [ 6] Xuan Zhuo           
>    9 (***) [1] Zhu Jun                  9 ( -8) [ 5] Andrii Nakryiko     
>   10 (+24) [1] Alexei Starovoitov      10 (***) [ 5] Zijian Zhang        
>
> Top scores (positive):               Top scores (negative):              
>    1 (   ) [122] Alexei Starovoitov     1 (***) [38] Alexander Lobakin   
>    2 (   ) [108] Andrii Nakryiko        2 (+16) [28] Mathieu Desnoyers   
>    3 ( +2) [ 33] Martin KaFai Lau       3 (***) [26] Menglong Dong       
>    4 ( +5) [ 31] Eduard Zingerman       4 ( +6) [25] Masami Hiramatsu (Google)
>    5 ( -2) [ 25] Jakub Kicinski         5 (+29) [25] Xuan Zhuo           
>    6 (+13) [ 22] Steven Rostedt         6 (+46) [20] Zijian Zhang        
>    7 (***) [ 22] Daniel Borkmann        7 (***) [20] Jason Xing          
>    8 (+15) [ 18] Peter Zijlstra         8 ( -1) [18] Alexis Lothoré      
>    9 (***) [ 18] Tejun Heo              9 (***) [17] Hou Tao       

Devoted limited time to reviewing this cycle. Will do more in the next
cycle.
>       
>   10 (   ) [ 18] Stanislav Fomichev    10 ( +7) [16] Hari Bathini        
>
> Company rankings
> ----------------
>
> Top reviewers (cs):                  Top reviewers (msg):                
>    1 (   ) [16] Meta                    1 (   ) [55] Meta                
>    2 ( +3) [ 5] Intel                   2 ( +2) [17] Google              
>    3 (   ) [ 4] Isovalent               3 ( +2) [16] Intel               
>    4 ( -2) [ 4] RedHat                  4 ( -2) [14] RedHat              
>    5 ( -1) [ 3] Google                  5 ( -2) [11] Isovalent           
>    6 ( +1) [ 1] SUSE                    6 (+12) [ 4] Linaro              
>    7 ( +7) [ 1] Linaro                  7 ( +1) [ 3] Huawei              
>
> Top authors (cs):                    Top authors (msg):                  
>    1 (   ) [7] Meta                     1 (   ) [38] Meta                
>    2 ( +1) [4] Huawei                   2 ( +1) [17] Huawei              
>    3 ( +1) [3] RedHat                   3 ( +3) [16] Isovalent           
>    4 ( +2) [2] Isovalent                4 ( -2) [15] Google              
>    5 ( -3) [2] Google                   5 ( +2) [13] Intel               
>    6 (+18) [2] Alibaba                  6 ( -1) [10] RedHat              
>    7 (***) [1] China Mobile             7 ( +7) [ 9] IBM                 
>
> Top scores (positive):               Top scores (negative):              
>    1 (   ) [156] Meta                   1 ( +2) [49] Huawei              
>    2 ( +3) [ 46] Intel                  2 ( +8) [31] Alibaba             
>    3 ( -1) [ 46] RedHat                 3 (***) [28] EfficiOS            
>    4 (***) [ 26] Google                 4 (***) [26] ZTE                 
>    5 ( +2) [ 20] SUSE                   5 ( +4) [23] IBM                 
>    6 (+22) [ 19] Linaro                 6 ( +2) [21] Bytedance           
>    7 ( -1) [ 18] Linux Foundation       7 (***) [20] Tencent             
>
> More raw stats
> --------------
>
> Prev: start: Wed, 17 Jul 2024 00:36:44 +0000
> 	end: Tue, 17 Sep 2024 05:41:18 +0800
> Prev: messages: 5073 days: 62 (82 msg/day)
> Prev: direct commits: 225 (4 commits/day)
> Prev: test commits: 101 (44.89%)
> Prev: people/aliases: 312  {'author': 119, 'commenter': 136, 'both': 57}
> Prev: review pct: 19.11%  x-corp pct: 14.67%
>
> Curr: start: Thu, 19 Sep 2024 23:04:43 +0200
> 	end: Tue, 19 Nov 2024 16:34:56 +0100
> Curr: messages: 5097 days: 61 (84 msg/day)
> Curr: direct commits: 260 (4 commits/day)
> Curr: test commits: 148 (56.92%)
> Curr: people/aliases: 315  {'author': 124, 'commenter': 138, 'both': 53}
> Curr: review pct: 30.38%  x-corp pct: 27.69%
>
> Diff: +2.1% msg/day
> Diff: +17.4% commits/day
> Diff: +2.6% people/day
> Diff: review pct: +11.3%
>       x-corp pct: +13.0%
>
>
> .


