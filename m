Return-Path: <bpf+bounces-8045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FD878074F
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 10:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8157F1C215F7
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 08:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B39174DD;
	Fri, 18 Aug 2023 08:39:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DFB3D7F
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 08:39:32 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1733A9C
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 01:39:29 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bf3a2f44f0so2569425ad.2
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 01:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692347969; x=1692952769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WoJNB5xajZKfrnY/n22v1srMiOrMvye+vRVcag5LXcA=;
        b=ej1gpeQOiA/Pi5ecZzSdowJTVtV/nUuC4IQqf43CVf+NNcIDITQ1WYcx5OzXjTXh0N
         tvdcxmFzZFHLZQ9EsrxvsBmz9L8cBIxDxx7TNz7tD8ugZK8e8ijpahSZc+JTGamc0cG/
         hEMgDdz2agljJoEH0fqNVhk3oOkaKDZhNWjO2mfMkp3GEyE32GP9tX/l5X4qc3n2gacC
         z4xJSzkTM/Nj9X7Q9RVIM07wfgWRFYk9/c9NLYULsyF0JlCty+FmuDORz1FZz1EESYmi
         WUY3nDD2hW543fDip4h/pKRfpXQCy3q9Qdzl562xIRmyV+CFCSlulby7Q0SbX/BCZiwo
         c+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692347969; x=1692952769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WoJNB5xajZKfrnY/n22v1srMiOrMvye+vRVcag5LXcA=;
        b=VKn4Ncx/lbY5XgnSbKVfGHQ5s6WWu7N/pvo6FOAh79nYArF+uD8M3VchUe6xvSCkOw
         nO5gEYUQFA5ItqxFX0s73ibrGWoKBAer2hixWBRcb0eQH4XH3zbjQhc476wma9wED9r8
         tJfDcBrH535pt/wR4CRHnQsRIW7NKH0WsPcoy6RE8vlCpUtaEwM3NCfB1w1eHT4MZACF
         i52yNp/yycmIjgAh+uYbewtA/iqe9dg6AAj7y1zfj2dCsPde6ud13V6E4bxAKjaZ3Ha+
         86cmAblU5EDrh2V9hEwgraxtGEssLn+YITSBKhobtY0wOEBzeI4kPwX5UDN68p+jwqDX
         dbrA==
X-Gm-Message-State: AOJu0YzHlpXCke6/LNvqaC5Z6BIjxTlAxlrsEoyhloPvEXV2XCDXhu0Y
	eDYE9Jrw5Jk0+NghlFGDXpo=
X-Google-Smtp-Source: AGHT+IEEkCLcPVtecE6SrWZ/7rYLxc1EIQzcXPyDWp7Z4cU9ozHspRepOM1jafNFsGakJjIWElMwbg==
X-Received: by 2002:a17:903:2306:b0:1b8:a720:f513 with SMTP id d6-20020a170903230600b001b8a720f513mr2371508plh.30.1692347968820;
        Fri, 18 Aug 2023 01:39:28 -0700 (PDT)
Received: from vultr.guest ([149.28.193.116])
        by smtp.gmail.com with ESMTPSA id ij27-20020a170902ab5b00b001b53c8659fesm1185209plb.30.2023.08.18.01.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 01:39:28 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 0/2] bpf: Fix an issue in verifing allow_ptr_leaks 
Date: Fri, 18 Aug 2023 08:39:18 +0000
Message-Id: <20230818083920.3771-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patch #1: An issue found in our local 6.1 kernel.
          This issue also exists in bpf-next.
Patch #2: Selftess for #1 

Yafang Shao (2):
  bpf: Fix issue in verifying allow_ptr_leaks
  selftests/bpf: Add selftest for allow_ptr_leaks

 kernel/bpf/verifier.c                           | 17 ++++++------
 tools/testing/selftests/bpf/prog_tests/tc_bpf.c | 36 ++++++++++++++++++++++++-
 tools/testing/selftests/bpf/progs/test_tc_bpf.c | 14 ++++++++++
 3 files changed, 58 insertions(+), 9 deletions(-)

-- 
1.8.3.1


