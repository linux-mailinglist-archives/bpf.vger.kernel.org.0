Return-Path: <bpf+bounces-4645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F0F74E082
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 23:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40FF281329
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 21:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4338B16422;
	Mon, 10 Jul 2023 21:58:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C5A156D5
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 21:58:27 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A93DA
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 14:58:26 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 63A9DC17EA4C
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 14:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689026306; bh=xBsftCf7AcdYTdhtf/E90BI9zo4qee8wFeE79dTAVP0=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=jg8Ytoswm2HdIb0nYr9aHpiwdu0ArCO51yvnwOfb9iSUID6rthnPWRYpqLlA2YOEG
	 yl4+vaBqGMNTkQIToerV01iZfaHIM+/Zd7CgJRwsrXLrQwcQfFM4PXeKTjsLwY6X6I
	 j9j8f023g4xVxRawWHLdbxyOrUUzQEbL45DinWhg=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Jul 10 14:58:26 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 49E15C17CEA0;
	Mon, 10 Jul 2023 14:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1689026306; bh=xBsftCf7AcdYTdhtf/E90BI9zo4qee8wFeE79dTAVP0=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=jg8Ytoswm2HdIb0nYr9aHpiwdu0ArCO51yvnwOfb9iSUID6rthnPWRYpqLlA2YOEG
	 yl4+vaBqGMNTkQIToerV01iZfaHIM+/Zd7CgJRwsrXLrQwcQfFM4PXeKTjsLwY6X6I
	 j9j8f023g4xVxRawWHLdbxyOrUUzQEbL45DinWhg=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 2E066C16953F
 for <bpf@ietfa.amsl.com>; Mon, 10 Jul 2023 14:58:25 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.897
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20221208.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id whfg8fbHAJNq for <bpf@ietfa.amsl.com>;
 Mon, 10 Jul 2023 14:58:24 -0700 (PDT)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id B837EC17CEA0
 for <bpf@ietf.org>; Mon, 10 Jul 2023 14:58:24 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7659c6cae2cso355809385a.1
 for <bpf@ietf.org>; Mon, 10 Jul 2023 14:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1689026303; x=1691618303;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F1jSr9YWA3hBZ37krPSSfrcga/fNnyp1P2GV4GvNeWE=;
 b=gn+3upERU76we9kXLRRmCBPtfsRsPDTAcOdbAwxsnNr5lF1xpEaNzXiFHXP1hwyLY9
 HryzSDIfaVVzFSwb4gsoAZsDPWAqxZxJOXoYj8WU0lJoR9mOsLgjfJ1YebNvJSPvn9v4
 uVu0mbFQLuLizkWbrg/YKKDr7E4nPcHTED0hNIO9zQb27cEo5MV8y85qOXirdbVrIj/i
 SKYxp535O6SkzOqAARvd85StG2iGTsAwhNz6LbOjjDDImxXqnd9gjiHgsEDqjJ2rlLeV
 jdb5NdNdAJMeOFoiCOL36RA6PbDSCZzvd630dj4mjnbJGTirgSzAiAHRMPhtX0E8YuRJ
 T8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689026303; x=1691618303;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F1jSr9YWA3hBZ37krPSSfrcga/fNnyp1P2GV4GvNeWE=;
 b=hHuomC2X/hoTpoMVLDs8vibY0+GAHdrd6zgZzZP5hgWTnAroveiuUA3xrcWcSEIes/
 UY0Ut+v41PZ7DJ+ZR7Vzk95/DpngUr7vPFcG+mwsHvL+J0dadBo7+lsWBDcwLg8fk2kc
 ALoFTWen9nK8LVO0h8eMoZ0fMDJTKdvjAhlfg8k+YhmtbeE5/9n4N4mvk3ui7BxczJ75
 9RNEn6Pz378dTf6VE91LeM17vPK4W5Y7uGJRlSZBTUqLPeZnOMLOi0qSTY0F144RbppF
 LZDExfdRGQ8FoNnBQBeuVEQDvc6wehSpFJQqq9wK0UMEwHiL0U+IolnFgxNalfYz9tUx
 +WsQ==
X-Gm-Message-State: ABy/qLa3nBZ9y7INDpgXN71cVbCTlwy3YgZ7qTpc1HRzFEkr/mVwkLrU
 txtRfuNZcXYc1jgoA9Y5K6IL1w==
X-Google-Smtp-Source: APBJJlFjlRdPqScLU8h8QDMeOWgTfAWPL00Y3wHE6OGnlXarsQb7K1avpuyW6s6vDZusRf8zgfM1HA==
X-Received: by 2002:a05:620a:424a:b0:765:a7d9:7085 with SMTP id
 w10-20020a05620a424a00b00765a7d97085mr12928876qko.51.1689026303521; 
 Mon, 10 Jul 2023 14:58:23 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
 by smtp.gmail.com with ESMTPSA id
 pa36-20020a05620a832400b007676658e369sm295380qkn.26.2023.07.10.14.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 14:58:23 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Date: Mon, 10 Jul 2023 17:58:18 -0400
Message-Id: <20230710215819.723550-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/K6MrQwaXUtRDw6MIhAX3T2F-9kc>
Subject: [Bpf] [PATCH 0/1] Specify twos complement format for signed integers
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Following the precedent of the Intel architecture manuals, it seems
important that the ISA specify the format of the available data types. I
hope that this is a useful submission.

Thanks for all that you do!
Will


Will Hawkins (1):
  bpf, docs: Specify twos complement as format for signed integers

 Documentation/bpf/instruction-set.rst | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.40.1

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

