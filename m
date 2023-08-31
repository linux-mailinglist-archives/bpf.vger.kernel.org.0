Return-Path: <bpf+bounces-9034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AACF78E7DC
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 10:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2621C208F0
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 08:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DEC748E;
	Thu, 31 Aug 2023 08:24:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0766433D7;
	Thu, 31 Aug 2023 08:24:35 +0000 (UTC)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A6019A;
	Thu, 31 Aug 2023 01:24:32 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so10329531fa.3;
        Thu, 31 Aug 2023 01:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693470271; x=1694075071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RCWJJwiJwfEQ9qvx03Zju0AtGmnp0ECHX3E9Svs/RYI=;
        b=m92kKAhz0YpjS1cMAYgv4lcKBINA0qqrmfekN1MSSjtqhvoVUypiPmxhn2i5k3PqFd
         NdQyr52pTBA+fByQaaCDNbgJe2Ip1QTgKzgNq0L5nASBg+k+MMMO3hPnI5kpngrDLScq
         sxXJ1R0IEGPS4L5IoFz1z3cG7vQY4+PHEy0DfaLEjISkevgoC4S2lyWE3ETMh0BfJxwS
         JogrYp/rfC/LGcFEE09Lp3ATGsEdI1rqDgomReaEMt8svEy2vIvY45rrewwp/p4Mkz9v
         qB2ySVzapspUJwjZrMTtckt1yUcpa7STEIW+QJZCv86pRFVRp0lsNnEnUcoBWLYYYjO5
         uogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693470271; x=1694075071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCWJJwiJwfEQ9qvx03Zju0AtGmnp0ECHX3E9Svs/RYI=;
        b=g+FMQj/CaPrzqELEhf6AP34zXyL3Uoayz8iORLNm4eOPFb8LJZiJMzpbG1Qu4mb0i+
         gDxCv/3D2ijXM8lUpxyDQxJA1piKxkFOxAdWbEYfIpNrAyyFY/MLdI4a89ApHt7tRLlH
         chahv3rfS9OuVxumMI19obgq1tuc+uVvp2GOZu1Wj8MiGtTGCFbWe6+4OC5p4CkWvMWW
         bAzvuAl9Tq5LXr1TLo04qfs7rD1vbo9nkGfceCsS7Ktwa5zGaDc5X7Q1cCuZ7b7t3AV8
         kYsJmbNxIBcP87lJzoBBGzF4PXSWnYDWpLxeWB0JxSLrQP9DOhrO4F3r8uI+hO7mUnlC
         o2zg==
X-Gm-Message-State: AOJu0YyJ1Mk8IBcmBpoddfM/7IsRK2gaBzH6O2rePmV52aGMKGeWnojz
	scfrqwlZyMrruU0ojH4t5bkhVWRv4PM=
X-Google-Smtp-Source: AGHT+IFxLfxrECU7sYMtQj9pSLPx/MdT/61MWAXp/Q1zUB8CUl8NybrX5cxZVT1gNPBjgOgyy5mpMg==
X-Received: by 2002:a2e:3314:0:b0:2bd:14cc:ab1b with SMTP id d20-20020a2e3314000000b002bd14ccab1bmr3255489ljc.44.1693470270660;
        Thu, 31 Aug 2023 01:24:30 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709064a8a00b0099b8234a9fesm486903eju.1.2023.08.31.01.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 01:24:30 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 31 Aug 2023 10:24:28 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Stanislav Fomichev <sdf@google.com>,
	Network Development <netdev@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [ANN] bpf development stats for 6.6
Message-ID: <ZPBOPM0o3Cj61Xy1@krava>
References: <ZO6O27Z9RvresmiV@google.com>
 <CAADnVQJdB-vQwEsfq1uk8VciXUxu1RQgC3xZhRCOd==wxwi6iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJdB-vQwEsfq1uk8VciXUxu1RQgC3xZhRCOd==wxwi6iQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 30, 2023 at 02:24:19PM -0700, Alexei Starovoitov wrote:

SNIP

> > Company rankings
> > ----------------
> >
> > Top reviewers (thr):                 Top reviewers (msg):
> >    1 (   ) [20] Meta                    1 (   ) [50] Meta
> >    2 (   ) [ 8] Isovalent               2 (   ) [16] RedHat
> >    3 (   ) [ 7] Google                  3 ( +1) [15] Google
> >    4 (   ) [ 6] RedHat                  4 ( -1) [12] Isovalent
> >    5 (   ) [ 3] Intel                   5 (   ) [ 7] Intel
> >    6 ( +3) [ 3] Huawei                  6 ( +2) [ 7] Huawei
> >    7 (+24) [ 2] Oracle                  7 (+41) [ 4] Oracle
> >    8 ( -2) [ 2] Corigine                8 (+49) [ 3] Rivos
> >    9 ( -1) [ 1] nVidia                  9 ( -3) [ 3] Corigine
> >   10 (+34) [ 1] Rivos                  10 ( -3) [ 2] nVidia
> >
> > Top authors (thr):                   Top authors (msg):
> >    1 (   ) [9] Meta                     1 (   ) [40] Meta
> >    2 ( +3) [6] Huawei                   2 ( +1) [31] Isovalent
> >    3 ( -1) [4] Isovalent                3 ( +1) [24] Intel
> >    4 ( -1) [3] Google                   4 ( +2) [19] Huawei
> >    5 ( +1) [3] Intel                    5 ( -3) [17] Google
> >    6 ( -2) [2] RedHat                   6 ( +2) [ 9] RedHat
> >    7 (***) [2] Juniper Networks         7 (***) [ 8] SUSE
> >    8 (***) [2] SUSE                     8 ( +5) [ 7] Bytedance
> >    9 ( +8) [1] Oracle                   9 (***) [ 6] Juniper Networks
> >   10 (+42) [1] Linaro                  10 (***) [ 5] Hao Xu
> >
> > Development vs reviewing scores
> > -------------------------------
> >
> > Top scores (positive):               Top scores (negative):
> >    1 ( +1) [144] Alexei Starovoitov     1 (***) [46] Jiri Olsa
> >    2 ( +4) [ 50] Martin KaFai Lau       2 ( +4) [39] Larysa Zaremba
> >    3 (+15) [ 40] Stanislav Fomichev     3 (   ) [37] Masami Hiramatsu (Google)
> >    4 ( -3) [ 38] Yonghong Song          4 (***) [34] Geliang Tang
> >    5 ( +4) [ 37] Jakub Kicinski         5 ( +7) [22] Dave Marchevsky
> >    6 ( -1) [ 34] Andrii Nakryiko        6 ( -4) [22] Maciej Fijalkowski
> >    7 (***) [ 30] Jesper Dangaard Brouer    7 (***) [19] Hao Xu
> >    8 (***) [ 25] John Fastabend         8 (+26) [18] Roberto Sassu
> >    9 (***) [ 24] Hou Tao                9 (***) [16] Valentin Schneider
> >   10 ( -7) [ 23] Daniel Borkmann       10 (***) [16] Tejun Heo
> 
> Jiri,
> you've managed to be in the top reviewers and top negative :)
> I guess that means that we need to tweak the positive/negative formula
> to more accurately represent the value each person brings
> to the community.

heh nice, win-win ;-)

jirka

> 
> >
> > Top scores (positive):               Top scores (negative):
> >    1 (   ) [142] Meta                   1 ( +1) [49] Intel
> >    2 (   ) [ 52] RedHat                 2 (+11) [38] Huawei
> >    3 (***) [ 28] Google                 3 ( +5) [28] Bytedance
> >    4 ( -1) [ 22] Corigine               4 (***) [22] SUSE
> >    5 (***) [ 18] Oracle                 5 (***) [19] Isovalent
> >    6 (+37) [  8] Rivos                  6 (***) [19] Hao Xu
> >    7 ( -2) [  8] Microsoft              7 ( -3) [13] Alibaba
> >    8 (***) [  7] Markus Elfring         8 (***) [12] Aviatrix
> >    9 (   ) [  6] Amazon                 9 (***) [12] Juniper Networks
> >   10 (***) [  5] Huacai Chen           10 (***) [11] Leon Hwang
> >   11 (+28) [  5] Dave Thaler           11 (***) [10] IBM
> >
> > More raw stats
> > --------------
> >
> > Prev: start: Thu, 27 Apr 2023 08:55:55 +0200
> >         end: Wed, 28 Jun 2023 17:27:38 +0200
> > Prev: messages: 4234 days: 62 (68 msg/day)
> > Prev: direct commits: 664 (11 commits/day)
> > Prev: people/aliases: 241  {'author': 89, 'commenter': 103, 'both': 49}
> > Prev: review pct: 12.95%  x-corp pct: 12.05%
> >
> > Curr: start: Wed, 28 Jun 2023 22:18:25 -0700
> >         end: Tue, 29 Aug 2023 15:24:18 -0700
> > Curr: messages: 5240 days: 62 (85 msg/day)
> > Curr: direct commits: 384 (6 commits/day)
> > Curr: people/aliases: 279  {'author': 112, 'commenter': 120, 'both': 47}
> > Curr: review pct: 24.22%  x-corp pct: 23.44%
> >
> > Diff: +23.8% msg/day
> > Diff: -42.2% commits/day
> > Diff: +15.8% people/day
> > Diff: review pct: +11.3%
> >       x-corp pct: +11.4%
> >
> 

