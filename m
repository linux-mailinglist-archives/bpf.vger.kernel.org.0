Return-Path: <bpf+bounces-250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A486FC9FF
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 17:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2574D281238
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 15:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41B26116;
	Tue,  9 May 2023 15:15:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF7C17FE6
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 15:15:23 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AC444B6
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 08:15:22 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1aaebed5bd6so42564415ad.1
        for <bpf@vger.kernel.org>; Tue, 09 May 2023 08:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683645322; x=1686237322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NcfT4RVbZnQGUcVgsYHoQ9jq5Fpna+ghUFRpqKMcIMg=;
        b=MjND4hB3Nrv/Z7VWBZqV3Oa8ddY3wH1rl5mRkswUmZbZ16aUy6kSAK7KGqAGNIw7ow
         mjXslqvvw6c4av9oghwg7KPgColxyJgaQdXfJDa/hlQEGf2Z6k9dtICq8m9FRtg6asZw
         419kqKZmAYhISu4XZfuelCGNxT+lATDKIFUdX1xZHnvSfO3wpR6J0VBDm3Ts7CXKuiar
         VhikqtDcOk0I6W8DtWlJbUSLbeKYAlymuC2gQnZu5QOeIITWz1ryCUzP24ZJTyfEm6Oz
         ZV3aYNdVrCriCb0Bt21OnFaUGJ9QkzsBcxDC0sul1eRnPPoABuBg4LMKyfqiQXgPhzVx
         llLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683645322; x=1686237322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NcfT4RVbZnQGUcVgsYHoQ9jq5Fpna+ghUFRpqKMcIMg=;
        b=NLqN9Vrx3QCf1mpGWy6J7x0pat0Ld1uJcwOGUpDG536LocngW8uJqSaMRr2PJc8OCA
         +w7iGJlhU0wuEUZqzZLygAHyXIZ/eX6F1hvhtiswa+JMGRBDH/Fp/HnhPJT/T0aVTdhb
         tgZ6+VCK91BkLQyzFwSlDm/1WjwfPbswGhrj9A0oHBnuV+7EXfVndeZ+uWmw5i7UAl+T
         cWdZEN4dVicFa1gXZibYHgf3fUV6hLp0JXCTi/vp8P7iIXMim9aJTvI/rlUafwLbVKzD
         CGBY+1eTO1FLZ0krO7SxG+KONUM70ac5/ScqhT8lxKmr3ZHUELbo2ASglpnNgJpRQolJ
         aARA==
X-Gm-Message-State: AC+VfDzl/RzJP26WEPYUksTUtWlHc3dBY6ihsPVzZfJMQ7gmjdNNvk5S
	UgqrmleNXxkNndiUdm2dNOc=
X-Google-Smtp-Source: ACHHUZ7vRuAkpGu8s+coio53LDJnVBLWkznO+85u0Xpow2+D8TN4BcvUls9wdRxeuKleQsYYE9nC/A==
X-Received: by 2002:a17:902:bd85:b0:1a6:9ec2:a48f with SMTP id q5-20020a170902bd8500b001a69ec2a48fmr14119327pls.34.1683645321713;
        Tue, 09 May 2023 08:15:21 -0700 (PDT)
Received: from vultr.guest ([149.28.193.116])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902ee4c00b001aafc8cea5fsm1706349plo.148.2023.05.09.08.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 08:15:21 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 0/2] bpf: bpf trampoline improvements 
Date: Tue,  9 May 2023 15:15:09 +0000
Message-Id: <20230509151511.3937-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patch #1: Fix memleak in bpf trampoline found on our server
Patch #2: Improve the trampoline ksym name 

Yafang Shao (2):
  bpf: Fix memleak due to fentry attach failure
  bpf: Show total linked progs cnt instead of selector in trampoline
    ksym

 include/linux/bpf.h     |  1 -
 kernel/bpf/trampoline.c | 24 +++++++++++++++++-------
 2 files changed, 17 insertions(+), 8 deletions(-)

-- 
1.8.3.1


