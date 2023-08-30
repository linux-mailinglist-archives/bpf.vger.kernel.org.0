Return-Path: <bpf+bounces-8942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED9278D12A
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 02:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5B482812D4
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 00:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04710A4C;
	Wed, 30 Aug 2023 00:35:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66227E6
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 00:35:46 +0000 (UTC)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBBBCD7
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 17:35:42 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-68a3d6ce18cso475634b3a.0
        for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 17:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693355741; x=1693960541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=usVrCdv60LbdGEvfEMFQTqaUYc6nbAmxrPyv3/0yGOE=;
        b=Vofn1lTa0tWRi1RA36I0URjnNB0BBqqLVH7jpbAeoTPCmbsvGsXyt7ICtA2xLniGZi
         70VIoBuJyjy5O0mBGT93cxJzhvRkw7p/k9vdDQtf6zFH5LGUe4RAvt/9FZFcNP+/SaWy
         syGWj8YDT1zqcQfxpmmnbGKlWa0s7DZ2KAH3ODvkC3gHIAdLeCwscpFunxYgc+8M8xW7
         va4x7e/YLcfAqcKwpiUBMRGs4MQooTe4dcGIEtiG3ekH+Jbfmcl2wS76ztzYcveiFV1J
         +3xhBZC5iDzGAVRRudMdKncAH+wZxjpGgBDiwBNOWcFIMIg4nwrmauIRSqoDw6PvcGkX
         /C0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693355741; x=1693960541;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=usVrCdv60LbdGEvfEMFQTqaUYc6nbAmxrPyv3/0yGOE=;
        b=iswbnKjxqBW6NHxecH6CkVSar+Kwaomt2ns+fXytA6cXMVjySxYzZtiG5INS5mBeBl
         7D2c0MQVQYeU1jX6BgeAmcqnUEzRQYmU2VY32+7VCmfpJyTaK0TK89B+Dpvg9X76aiEf
         FgX7/NpoTzggJxQkAdAjhEIyDhUk2uqmCNtHKB4CFuSL3Q0u3ftsOXeJsjzhVT5UHZIP
         4Iii+xFmXgofDQ46bXnvw9IkOafW2gL65Ce1KEyAII1rmCnBda8EmVv7Po3Dc/WRGg6e
         IqtvVzkxZ4nG7FkLjImvfTmnoHdgpEOXCeI0JCcKQhpiYj0V49AhoWVeD4jmfutsVbfh
         QdOg==
X-Gm-Message-State: AOJu0Yx23r2DTLeX+S100EDnAbCZh7X405LJTXlYZaR3h8U37O0CGMPs
	L4gUtpca4/Bb3sOJWDZZ4SP6gwOEPt7WB5m/sy++qRokHRAkesydo1pWGTzCYkDkIPQ78YXJ5Cd
	v6XxXvy4Lm1J3hwRTLEl4w81gZKV54EgRZcWdUpfheC8gJhwT/g==
X-Google-Smtp-Source: AGHT+IFVDeQaEwWxoBTsZBmaWQrik5bNR8SWCHXSAhBIuyKxPc3cih5/SEaf1HH7XPzp0GsB9evBiOY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:1404:b0:68a:5e6f:9975 with SMTP id
 l4-20020a056a00140400b0068a5e6f9975mr1296660pfu.1.1693355741529; Tue, 29 Aug
 2023 17:35:41 -0700 (PDT)
Date: Tue, 29 Aug 2023 17:35:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <ZO6O27Z9RvresmiV@google.com>
Subject: [ANN] bpf development stats for 6.6
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

See the netdev posting for more info and context:
https://lore.kernel.org/netdev/20230829150539.6f998d1f@kernel.org/T/#u

As last time, I'm presenting raw stats without any evaluation. I'm
posting a link to the previous cycle below so people can do the
comparison if needed. I'm also trying to present the same data as we
have in netdev email so you can follow Jakub's comments about script
changes/etc.

Previous cycle:
27 Apr to 28 Jun: 4234 mailing list messages, 62 days, 68 messages per day
664 repo commits (11 commits/day)

Current cycle:
28 Jun to 29 Aug: 5240 mailing list messages, 62 days, 85 messages per day
384 repo commits (6 commits/day)

6.5 stats: https://lore.kernel.org/netdev/20230829150539.6f998d1f@kernel.org/T/#u

Rankings
--------

Top reviewers (thr):                 Top reviewers (msg):                
   1 ( +1) [11] Alexei Starovoitov      1 ( +1) [23] Alexei Starovoitov  
   2 ( -1) [ 7] Yonghong Song           2 ( +1) [15] Yonghong Song       
   3 ( +5) [ 4] Martin KaFai Lau        3 ( +4) [ 9] Stanislav Fomichev  
   4 ( +3) [ 4] Stanislav Fomichev      4 ( -3) [ 7] Andrii Nakryiko     
   5 ( -1) [ 4] Daniel Borkmann         5 ( +5) [ 7] Martin KaFai Lau    
   6 ( +3) [ 3] Jakub Kicinski          6 (+15) [ 5] Hou Tao             
   7 ( -2) [ 3] Jiri Olsa               7 ( +7) [ 5] Jakub Kicinski      
   8 ( -5) [ 2] Andrii Nakryiko         8 ( -2) [ 4] Daniel Borkmann     
   9 (***) [ 2] Hou Tao                 9 (+13) [ 4] Jesper Dangaard Brouer
  10 (+16) [ 2] Jesper Dangaard Brouer   10 (+17) [ 4] Eduard Zingerman    
  11 ( +7) [ 2] John Fastabend         11 ( -2) [ 4] Steven Rostedt      
  12 ( +3) [ 2] Eduard Zingerman       12 (***) [ 4] Alan Maguire        

Top authors (thr):                   Top authors (msg):                  
   1 ( +9) [3] Yonghong Song            1 ( +5) [20] Jiri Olsa           
   2 (   ) [2] Yafang Shao              2 (+30) [17] Yonghong Song       
   3 (***) [2] Geliang Tang             3 ( +8) [10] Larysa Zaremba      
   4 ( +5) [1] Daniel Borkmann          4 (   ) [10] Masami Hiramatsu (Google)
   5 ( +2) [1] Masami Hiramatsu (Google)    5 (***) [ 8] Geliang Tang        
   6 ( -2) [1] Jiri Olsa                6 ( -3) [ 8] Maciej Fijalkowski  
   7 (+19) [1] Kui-Feng Lee             7 ( -5) [ 6] Yafang Shao         
   8 (+40) [1] Dave Marchevsky          8 (+12) [ 6] Dave Marchevsky     
   9 (***) [1] Rong Tao                 9 (+15) [ 5] Daniel Borkmann     
  10 (***) [1] Daniel Xu               10 (***) [ 5] Hao Xu              

Company rankings
----------------

Top reviewers (thr):                 Top reviewers (msg):                
   1 (   ) [20] Meta                    1 (   ) [50] Meta                
   2 (   ) [ 8] Isovalent               2 (   ) [16] RedHat              
   3 (   ) [ 7] Google                  3 ( +1) [15] Google              
   4 (   ) [ 6] RedHat                  4 ( -1) [12] Isovalent           
   5 (   ) [ 3] Intel                   5 (   ) [ 7] Intel               
   6 ( +3) [ 3] Huawei                  6 ( +2) [ 7] Huawei              
   7 (+24) [ 2] Oracle                  7 (+41) [ 4] Oracle              
   8 ( -2) [ 2] Corigine                8 (+49) [ 3] Rivos               
   9 ( -1) [ 1] nVidia                  9 ( -3) [ 3] Corigine            
  10 (+34) [ 1] Rivos                  10 ( -3) [ 2] nVidia              

Top authors (thr):                   Top authors (msg):                  
   1 (   ) [9] Meta                     1 (   ) [40] Meta                
   2 ( +3) [6] Huawei                   2 ( +1) [31] Isovalent           
   3 ( -1) [4] Isovalent                3 ( +1) [24] Intel               
   4 ( -1) [3] Google                   4 ( +2) [19] Huawei              
   5 ( +1) [3] Intel                    5 ( -3) [17] Google              
   6 ( -2) [2] RedHat                   6 ( +2) [ 9] RedHat              
   7 (***) [2] Juniper Networks         7 (***) [ 8] SUSE                
   8 (***) [2] SUSE                     8 ( +5) [ 7] Bytedance           
   9 ( +8) [1] Oracle                   9 (***) [ 6] Juniper Networks    
  10 (+42) [1] Linaro                  10 (***) [ 5] Hao Xu              

Development vs reviewing scores
-------------------------------

Top scores (positive):               Top scores (negative):              
   1 ( +1) [144] Alexei Starovoitov     1 (***) [46] Jiri Olsa           
   2 ( +4) [ 50] Martin KaFai Lau       2 ( +4) [39] Larysa Zaremba      
   3 (+15) [ 40] Stanislav Fomichev     3 (   ) [37] Masami Hiramatsu (Google)
   4 ( -3) [ 38] Yonghong Song          4 (***) [34] Geliang Tang        
   5 ( +4) [ 37] Jakub Kicinski         5 ( +7) [22] Dave Marchevsky     
   6 ( -1) [ 34] Andrii Nakryiko        6 ( -4) [22] Maciej Fijalkowski  
   7 (***) [ 30] Jesper Dangaard Brouer    7 (***) [19] Hao Xu              
   8 (***) [ 25] John Fastabend         8 (+26) [18] Roberto Sassu       
   9 (***) [ 24] Hou Tao                9 (***) [16] Valentin Schneider  
  10 ( -7) [ 23] Daniel Borkmann       10 (***) [16] Tejun Heo           

Top scores (positive):               Top scores (negative):              
   1 (   ) [142] Meta                   1 ( +1) [49] Intel               
   2 (   ) [ 52] RedHat                 2 (+11) [38] Huawei              
   3 (***) [ 28] Google                 3 ( +5) [28] Bytedance           
   4 ( -1) [ 22] Corigine               4 (***) [22] SUSE                
   5 (***) [ 18] Oracle                 5 (***) [19] Isovalent           
   6 (+37) [  8] Rivos                  6 (***) [19] Hao Xu              
   7 ( -2) [  8] Microsoft              7 ( -3) [13] Alibaba             
   8 (***) [  7] Markus Elfring         8 (***) [12] Aviatrix            
   9 (   ) [  6] Amazon                 9 (***) [12] Juniper Networks    
  10 (***) [  5] Huacai Chen           10 (***) [11] Leon Hwang          
  11 (+28) [  5] Dave Thaler           11 (***) [10] IBM                 

More raw stats
--------------

Prev: start: Thu, 27 Apr 2023 08:55:55 +0200
	end: Wed, 28 Jun 2023 17:27:38 +0200
Prev: messages: 4234 days: 62 (68 msg/day)
Prev: direct commits: 664 (11 commits/day)
Prev: people/aliases: 241  {'author': 89, 'commenter': 103, 'both': 49}
Prev: review pct: 12.95%  x-corp pct: 12.05%

Curr: start: Wed, 28 Jun 2023 22:18:25 -0700
	end: Tue, 29 Aug 2023 15:24:18 -0700
Curr: messages: 5240 days: 62 (85 msg/day)
Curr: direct commits: 384 (6 commits/day)
Curr: people/aliases: 279  {'author': 112, 'commenter': 120, 'both': 47}
Curr: review pct: 24.22%  x-corp pct: 23.44%

Diff: +23.8% msg/day
Diff: -42.2% commits/day
Diff: +15.8% people/day
Diff: review pct: +11.3%
      x-corp pct: +11.4%

