Return-Path: <bpf+bounces-3672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6383074180B
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 20:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BDAA1C2039F
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 18:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12ADD536;
	Wed, 28 Jun 2023 18:32:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3FC110B
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 18:32:20 +0000 (UTC)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823C31FCB
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 11:32:18 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b84c7a26c9so1112445ad.0
        for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 11:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687977138; x=1690569138;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H5dRF2ngGvran1+nvkZlG3MKu7frym6gfaq2LVMIlec=;
        b=w5mEujA1wnu0hxpBvWuFNNlhZoJMnVw2kYrPbCWttF/E1Mzb9EpE7wceiaI19FDvCL
         s4IYASYy1q3x1y5fYCkk2i4Q47UIltBevIQabLw+eGIIKQAJ+O8TaaSQwBKOUPO+SP2E
         q0BtFn5wLb64saQy21KjOalZ1iVkxJLIMPzHUCXuirYeFkBxCE6lSj83ZcZVW9uLgeB9
         D5b2jRQKvkjeCA6bgQJ/Y5FcWSViiBMsB2AbI5v4sPHfA//rc6h8sw3Drsxjr+NZKdOK
         rzgqY+sC7FsK34xO96WH3L8VoVmVN+6blfQPGvzFK/iqpBpQbr+vU3THiX5x663W6amn
         8Cuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687977138; x=1690569138;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5dRF2ngGvran1+nvkZlG3MKu7frym6gfaq2LVMIlec=;
        b=ZsWdvlprjqlcrwGzgckXe/iiRLLbZlrbO7LHPo6UHHNQ+2RRKlE5KyLecoWzzHPs3z
         u9avc3jfw4a7D9lm9CXT5++gyN+CzlE22sViRFwM6FA66VCA8IEithack2WWHZxEZrO3
         KlDBafeBEWmQwikQaQFBtcpszJPDNuLKjWr9EHsKce9uDLRBkkvGoHHRKHGn6oCEYAUW
         Y2geDaCR2B7YfQdXi6wxwwAlQa/1yOcpUOTnYLf7+avvDcZ4Y/l0S/DqU8uCDVXA21jb
         4KoprDEHTmrOeXE6Vfx0zn5yEOfc69GFYnf7LauH57sWj1EDNmQDb3Ffd70L3SUvB3fT
         4PEg==
X-Gm-Message-State: AC+VfDws9xj/SwxYwoQxCIMIuqEb42V5Y7a4T36bsCwjIzfxkerb+rIB
	nHDaGxFWKq2ZMncFNlvvY7cs7A0DcZELcIf878eMrm42q1MdsvjCTwNXZsjJXiVEJSdFwKI8pID
	4R0yblacqWbums5tqDsbjRL7FCd7CPHX9Rcc4v3xgXLxEgaSKNw==
X-Google-Smtp-Source: ACHHUZ6zaeSfeCi91SbG53LBJMFtkGRI6rH5yZVDH+rt0JJON+lWSxIifM5rsPGH36RbvqmLb+W5iIg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:ef96:b0:1b0:46ae:ff83 with SMTP id
 iz22-20020a170902ef9600b001b046aeff83mr368532plb.1.1687977137868; Wed, 28 Jun
 2023 11:32:17 -0700 (PDT)
Date: Wed, 28 Jun 2023 11:32:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <ZJx8sBW/QPOBswNF@google.com>
Subject: [ANN] bpf development stats for 6.5
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Same as last time, running Jakub's scripts against bpf tree, see netdev
posting for more info on the methodology:
https://lore.kernel.org/netdev/20230627163832.75f3a340@kernel.org/T/#u

He also shared with me bpf stats for the previous cycle (a lot of
work went into the scripts in these past two months, so my data
was completely irrelevant), so we can have some comparisons!

As last time, I'm presenting raw stats without any evaluation. I'm
also trying to present the same data as we have in netdev email
so you can follow Jakub's comments about script changes/etc. One thing
to note maybe is that we have a lot of cross-pollination with netdev list,
so our stats change quite a bit depending on netdev activity :-)

Previous cycle:
21 Feb to 26 Apr: 5362 mailing list messages, 64 days, 86 messages per day
438 repo commits (7 commits/day)=20

Current cycle:
27 Apr to 28 Jun: 4234 mailing list messages, 62 days, 68 messages per day
664 repo commits (11 commits/day)

6.4 stats: https://lore.kernel.org/bpf/ZFAOojsT93ZxwNu3@google.com/

Rankings
--------

Top reviewers (thr):                 Top reviewers (msg):               =20
   1 (+13) [7] Yonghong Song            1 ( +1) [16] Andrii Nakryiko    =20
   2 ( -1) [7] Alexei Starovoitov       2 ( -1) [15] Alexei Starovoitov =20
   3 ( -1) [6] Andrii Nakryiko          3 (+17) [13] Yonghong Song      =20
   4 ( +1) [4] Daniel Borkmann          4 (***) [ 5] David Hildenbrand  =20
   5 ( +3) [3] Jiri Olsa                5 (+11) [ 5] Jiri Olsa          =20
   6 (+14) [3] Simon Horman             6 ( +3) [ 5] Daniel Borkmann    =20
   7 ( -4) [2] Stanislav Fomichev       7 ( -4) [ 5] Stanislav Fomichev =20
   8 ( -4) [2] Martin KaFai Lau         8 (***) [ 5] Song Liu           =20
   9 ( -3) [2] Jakub Kicinski           9 (+21) [ 4] Steven Rostedt     =20
  10 (+32) [2] Steven Rostedt          10 ( -6) [ 4] Martin KaFai Lau   =20
  11 ( +5) [2] Toke H=C3=B8iland-J=C3=B8rgensen   11 (+15) [ 4] Simon Horma=
n       =20
  12 ( -3) [2] Quentin Monnet          12 ( -2) [ 4] Toke H=C3=B8iland-J=C3=
=B8rgensen

Top authors (thr):                   Top authors (msg):                 =20
   1 (   ) [2] Andrii Nakryiko          1 (   ) [14] Andrii Nakryiko    =20
   2 (+11) [2] Yafang Shao              2 ( +4) [11] Yafang Shao        =20
   3 (+36) [1] Aditi Ghag               3 (***) [10] Maciej Fijalkowski =20
   4 (+14) [1] Jiri Olsa                4 (+27) [ 9] Masami Hiramatsu (Goog=
le)
   5 (+40) [1] Stanislav Fomichev       5 ( +2) [ 6] John Fastabend     =20
   6 ( +3) [1] Eduard Zingerman         6 ( +5) [ 6] Jiri Olsa          =20
   7 (***) [1] Masami Hiramatsu (Google)    7 (+40) [ 6] Stanislav Fomichev=
 =20
   8 (***) [1] Menglong Dong            8 (***) [ 5] Ian Rogers         =20
   9 ( +1) [1] Daniel Borkmann          9 ( -1) [ 5] Alexei Starovoitov =20
  10 ( +6) [1] Yonghong Song           10 ( -5) [ 4] Eduard Zingerman   =20

Company rankings
----------------

Top reviewers (thr):                 Top reviewers (msg):               =20
   1 (   ) [17] Meta                    1 (   ) [50] Meta               =20
   2 (   ) [ 7] Isovalent               2 ( +3) [19] RedHat             =20
   3 ( +1) [ 5] Google                  3 (   ) [13] Isovalent          =20
   4 ( +1) [ 5] RedHat                  4 ( -2) [11] Google             =20
   5 ( -2) [ 3] Intel                   5 ( -1) [ 6] Intel              =20
   6 ( +5) [ 3] Corigine                6 ( +8) [ 4] Corigine           =20
   7 ( +6) [ 1] Microsoft               7 ( +2) [ 4] nVidia             =20

Top authors (thr):                   Top authors (msg):                 =20
   1 (   ) [7] Meta                     1 (   ) [28] Meta               =20
   2 (   ) [6] Isovalent                2 ( +3) [24] Google             =20
   3 ( +2) [5] Google                   3 ( -1) [23] Isovalent          =20
   4 ( -1) [2] RedHat                   4 ( +3) [18] Intel              =20
   5 ( +1) [2] Huawei                   5 ( +3) [11] Yafang Shao        =20
   6 ( -2) [2] Intel                    6 ( +3) [ 6] Huawei             =20
   7 ( +6) [2] Yafang Shao              7 ( -3) [ 6] Alibaba            =20
   8 (***) [1] nVidia                   8 ( -5) [ 4] RedHat             =20
   9 ( +2) [1] Eduard Zingerman         9 ( -3) [ 4] Eduard Zingerman   =20

Yafang/Eduard, if you'd like to share you company with me, feel free
to drop a private email.

New formula rankings
--------------------

Top scores (positive):               Top scores (negative):             =20
   1 (   ) [156] Meta                   1 ( +2) [38] Yafang Shao        =20
   2 ( +3) [ 68] RedHat                 2 (***) [25] Intel              =20
   3 ( +5) [ 35] Corigine               3 (***) [25] Google             =20
   4 (+11) [ 15] IBM                    4 ( -3) [20] Alibaba            =20
   5 (+34) [ 13] Microsoft              5 (***) [14] Menglong Dong      =20
   6 ( +1) [ 10] nVidia                 6 (***) [11] Oracle             =20
   7 (***) [  9] Linux Foundation       7 (***) [10] Mike Rapoport      =20
   8 (***) [  8] Kent Overstreet        8 ( -4) [10] Bytedance          =20
   9 ( +8) [  8] Amazon                 9 ( +5) [ 8] Lorenzo Stoakes    =20
  10 (+11) [  7] Christoph Hellwig     10 ( +3) [ 7] Gilad Sever        =20
  11 ( +2) [  7] SUSE                  11 (***) [ 7] Tessares           =20
  12 (+10) [  7] CloudFlare            12 (***) [ 7] Eduard Zingerman   =20

How top authors rank in scores:
  1   p0 [155]  Meta
  2  p97 [-25]  Google
  3   p8 [  6]  Isovalent
  4  p98 [-26]  Intel
  5  p99 [-39]  Yafang Shao <laoar.shao@gmail.com>
  6  p89 [ -7]  Huawei
  7  p96 [-21]  Alibaba
  8   p0 [ 68]  RedHat
  9  p90 [ -7]  Eduard Zingerman <eddyz87@gmail.com>
 10  p96 [-15]  Menglong Dong <menglong8.dong@gmail.com>
 11  p95 [-11]  Oracle
 12  p94 [-11]  Mike Rapoport <rppt@kernel.org>
 13  p93 [-10]  Bytedance
 14   p3 [ 10]  nVidia
 15  p91 [ -7]  Tessares

How to reproduce
----------------

This is mostly for myself so I don't forget how to do it next time.

$ SINCE=3D04/26/2023
$ UNTIL=3D06/27/2023

$ cd bpf-0.git

$ git log --oneline --until $UNTIL | head -n1
a73e0498abf2 Re: [PATCH RFC net-next v4 6/8] virtio/vsock: support dgrams

$ git log --oneline --since $SINCE | tail -n 1
83eb87892df6 Re: [PATCH bpf-next 3/6] bpf: Don't EFAULT for {g,s}setsockopt=
 with wrong optlen

$ git rev-list --count 83eb87892df6..a73e0498abf2
4234

$ git checkout a73e0498abf2
$ cd ..

$ ./ml-stat.py --linux ~/bpf-next --repo bpf --db db.json --email-count 423=
4 --json-out bpf-6.5.json

$ cd bpf-next

$ git log --oneline --until $UNTIL | head -n1
771ca3de2502 Merge branch 'sfc-next'

$ git log --oneline --since $SINCE | tail -n 1
3ee23096add5 doc:it_IT: fix some typos

$ ./git-stat.py --linux ~/bpf-next/ \
	--db db.json \
	--json-out bpf-6.5.json \
        --start-commit 3ee23096add5 --end-commit 771ca3de2502 \
	--maintainers ast@kernel.org \
		daniel@iogearbox.net \
		andrii@kernel.org \
		martin.lau@kernel.org

$ ./stat-print.py --ml-stats bpf-6.4.json bpf-6.5.json

More raw stats
--------------

Prev: start: Tue, 21 Feb 2023 17:10:17 +0000
	end: Wed, 26 Apr 2023 16:39:19 -0700
Prev: messages: 5362 days: 64 (84 msg/day)
Prev: direct commits: 438 (7 commits/day)
Prev: people/aliases: 255  {'author': 95, 'commenter': 105, 'both': 55}
Prev: review pct: 10.73%  x-corp pct: 9.82%

Curr: start: Thu, 27 Apr 2023 08:55:55 +0200
	end: Wed, 28 Jun 2023 17:27:38 +0200
Curr: messages: 4234 days: 62 (68 msg/day)
Curr: direct commits: 664 (11 commits/day)
Curr: people/aliases: 241  {'author': 89, 'commenter': 103, 'both': 49}
Curr: review pct: 12.95%  x-corp pct: 12.05%

Diff: -18.5% msg/day
Diff: +56.5% commits/day
Diff: -2.4% people/day
Diff: review pct: +2.2%
      x-corp pct: +2.2%

