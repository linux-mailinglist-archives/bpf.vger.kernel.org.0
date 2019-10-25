Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 654B6E4C7F
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2019 15:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504855AbfJYNmi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Oct 2019 09:42:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46568 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504854AbfJYNmi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Oct 2019 09:42:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id n15so2367468wrw.13
        for <bpf@vger.kernel.org>; Fri, 25 Oct 2019 06:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RZsFj5mSHLDPjjfjXJ3TNXEUO7OqHqp8fru+xxws/tM=;
        b=ZhDSnzfh7B4uJ62zsXaqVGW4Au8iBBJ1wUiRaOIF6Kr16ReGw0YtsXjRWZ2u0IEQdm
         oQNaboyIeHxbkZT8bHZFa8IuVS0m0xWrOzhYOZtybO4qiMtvIEv1EMufeRIy4YykT2zy
         bV6uYl3YfCHfPzc1m23eY5Mce79GisIWGMjT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RZsFj5mSHLDPjjfjXJ3TNXEUO7OqHqp8fru+xxws/tM=;
        b=OCKGKm1dT5ATL6RSGjqoDgd7XmmOPF5+vA1VkMWy9BD2FjpWa9sMbs0DiokZ1qMz2y
         nwkYlhEZA4hGDclM6R4DZIvZaN6zKEWDFbyR1glWk+sfsxvuMYkZzkeCnYwfEuOiRLM8
         sQj3UNb4McBGnuPey3JnGX9wy17U7/5bPC7ZQwRHjabhbW+RIfJ8WPCNUSBCmbFK+jDs
         q6RhrDxPg0vlwpIUipFsdWqRnJ3wbKUgI5EA089mlQ3R0BbCjhjXGk1YMwcXU8rbWLPj
         azbjtaztJSK+/N8NoCV7iFk7eTh0XpUiZZqQELHPMwc2UBlqfWFSo7LeMO4SgkcdGXnB
         /g0A==
X-Gm-Message-State: APjAAAXvoDLosSNSnvWmlP2HmGEJjJ/ksZgkkINdkSechl2TBjyM7K5s
        HSMoqKVL7HzWksWQpY41bhuknA==
X-Google-Smtp-Source: APXvYqxJeHJ5GOyx5hF2JJ8W4vj16avyKvi1nOvY1+NwCXXu789wK5brJvb+yEKmgatOE1vZnZ9Ijw==
X-Received: by 2002:adf:9bdc:: with SMTP id e28mr2980294wrc.309.1572010956910;
        Fri, 25 Oct 2019 06:42:36 -0700 (PDT)
Received: from localhost.localdomain ([94.230.83.169])
        by smtp.gmail.com with ESMTPSA id v11sm2194730wrw.97.2019.10.25.06.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 06:42:36 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH bpf-next 0/2] test_bpf: Add an skb_segment test for a linear head_frag=0 skb whose gso_size was mangled
Date:   Fri, 25 Oct 2019 16:42:21 +0300
Message-Id: <20191025134223.2761-1-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a reproducer test that mimics the input skbs that lead to the BUG_ON
in skb_segment() which was fixed by commit 3dcbdb134f32 ("net: gso: Fix skb_segment splat when splitting gso_size mangled skb having linear-headed frag_list").

Shmulik Ladkani (2):
  test_bpf: Refactor test_skb_segment() to allow testing skb_segment()
    on numerous different skbs
  test_bpf: Introduce 'gso_linear_no_head_frag' skb_segment test

 lib/test_bpf.c | 112 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 103 insertions(+), 9 deletions(-)

-- 
2.17.1

