Return-Path: <bpf+bounces-3648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC9F74106A
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 13:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27928280DD1
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 11:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAAABE6C;
	Wed, 28 Jun 2023 11:52:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0E8BE47
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 11:52:11 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21244FF
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 04:52:09 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b80b343178so20981295ad.0
        for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 04:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687953128; x=1690545128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=juoQiVr0aY5LbgdzJ8Knoi0ZZjFwuTVW3cNmVIAHLZk=;
        b=WUkCnYyW9OYDNUxh7/rkcRGCNm6jqK7P2WMmGIc/U+GlDQbNAYVpItmC9VnFEVa0E4
         mUmWENQFGK7SP0rCVtQeGk1NMf+BiWQZ5k/TZRMIE91WIEVIVK3DyjlBuj0/fegh/4dx
         F/t8qkb21nsQLU2/qAso5Yv7IjuW2D6H/B7NP49eWrUz67Ta+MQAbfi66HLdgWtct6Y4
         twIA8E57QdsFb56gMNQAqgboYkvyLN7HTf1RaIa8Cgu0CdUpqSgdzeaTxVJcLug+gS91
         TK4SVThdkpRDci4Ld/gCppiufbvgPFtyB9AkFczqfJX3iUyUdKC/kRL7f5nN/kraTMI+
         O6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687953128; x=1690545128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=juoQiVr0aY5LbgdzJ8Knoi0ZZjFwuTVW3cNmVIAHLZk=;
        b=LvAiaQaPdphaq72dGhkkDpiubxbqkSyJp+jk5xIUl2YE9nsycHqYzvRFwR3O3qiuWO
         GMTPb289vODiyq7MT015Xj2fuyGzB5qDFqgZvBYqKe2vNlm/1KZvcKTg2V3PO2Gg+9uI
         qOcNdWRmIGLndLsIT8pk6OIVsHcN8CRAuH5jO2Lj6ODWdM1+H8U+IVGzSi3kUzhAvpX1
         xTUVbyqg4mqmId+bXxnmrf9I6bFvYoZS3aBjHbAuEIGZj22GtOplO7ku5bBOgCbMHxxP
         DTPzvmh13NfVIJquLoRr9BdzJIlMHy1NWDsya+U966C0QrGRNSerhV6A5vh80TOHqlbH
         1T5w==
X-Gm-Message-State: AC+VfDzX68kc064B0dkb5O6dyfV/0Tm6DUe8sNmNAif4xkhyRPO9IOLU
	aTBrxuxgwCwATsWqcUmxwVw=
X-Google-Smtp-Source: ACHHUZ4+T46qNZZ/hmVtf+Ak9G6wxCgjPhsWrGwo2TilxaP0CNCHSL6hWxSqfqg342TOQXM5wYtzJA==
X-Received: by 2002:a17:902:db03:b0:1b6:c552:b73b with SMTP id m3-20020a170902db0300b001b6c552b73bmr12369108plx.2.1687953128489;
        Wed, 28 Jun 2023 04:52:08 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b79:5400:4ff:fe7d:3e26])
        by smtp.gmail.com with ESMTPSA id jf5-20020a170903268500b001b7eeffbdbfsm6607133plb.261.2023.06.28.04.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:52:08 -0700 (PDT)
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
Subject: [PATCH bpf-next 0/2] bpf: Fix errors in verifying a union 
Date: Wed, 28 Jun 2023 11:52:03 +0000
Message-Id: <20230628115205.248395-1-laoar.shao@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Patch #1: Fix an issue found in code review
Patch #2: Fix an issue found in our dev server

Yafang Shao (2):
  bpf: Fix an error around PTR_UNTRUSTED
  bpf: Fix an error in verifying a field in a union

 kernel/bpf/btf.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

-- 
2.39.3


