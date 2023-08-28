Return-Path: <bpf+bounces-8852-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 652F878B500
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 18:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF39280E0D
	for <lists+bpf@lfdr.de>; Mon, 28 Aug 2023 16:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE0013AE4;
	Mon, 28 Aug 2023 16:00:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA7A134A6
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 16:00:08 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63B2CA
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 09:00:06 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 835A6C15155C
	for <bpf@vger.kernel.org>; Mon, 28 Aug 2023 09:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1693238406; bh=gKuqKfX9Xl0Ez2TE2zy4T2Wbg7zGIbemdNe6+D8G/iw=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=SIFzDpXC8U0eCLoaawdHnboe10mpEL+KO0PqHCoPO8gzwBaXEwhk4sKgodIzz9gAN
	 lj4W1KoOl1M5/EdIo1+fYsx6CGPVNIWuEq40RMBvvxAVCPCVI2QncQ0Mh07KzlfNAD
	 h/OQFdc3A3wbprYRetdlQSF6uRAOsONt6rPcnF2M=
X-Mailbox-Line: From bpf-bounces@ietf.org  Mon Aug 28 09:00:06 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 5B86EC151097;
	Mon, 28 Aug 2023 09:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1693238406; bh=gKuqKfX9Xl0Ez2TE2zy4T2Wbg7zGIbemdNe6+D8G/iw=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=SIFzDpXC8U0eCLoaawdHnboe10mpEL+KO0PqHCoPO8gzwBaXEwhk4sKgodIzz9gAN
	 lj4W1KoOl1M5/EdIo1+fYsx6CGPVNIWuEq40RMBvvxAVCPCVI2QncQ0Mh07KzlfNAD
	 h/OQFdc3A3wbprYRetdlQSF6uRAOsONt6rPcnF2M=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 91EA5C15155C
 for <bpf@ietfa.amsl.com>; Mon, 28 Aug 2023 09:00:04 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.41
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9ePbPashusdf for <bpf@ietfa.amsl.com>;
 Mon, 28 Aug 2023 09:00:00 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com
 [209.85.219.174])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 4120CC14CF0C
 for <bpf@ietf.org>; Mon, 28 Aug 2023 09:00:00 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id
 3f1490d57ef6-d7260fae148so3329980276.1
 for <bpf@ietf.org>; Mon, 28 Aug 2023 09:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693238399; x=1693843199;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LVKo28epBiUG3SEESqk0GaOO1fQ+tGlFjow4pbPvDOc=;
 b=WnNoW14URVMLmgrPTxykZyW+aazVAYBRmrSS+C0VP+iC5+DCK6oghVE9tz/St2IfRj
 WJKpNWBZXMtF3xsxM7eoyZxB2P3igqEcXVBFgxMdvzq2nqOrAxQTm7QkiiIBcHZj1zGZ
 syndf+/xJgPHDn3jzPUuhg3cGtsl9VNwlMcGHQvFLk/Waqwmil8YKIkxnchB/AmADTMb
 1K+wZCcaL7aLXwZhxtdP5Y3ywjy/vRx9s5Q87wP18ujJkwdKoyL1sQW4/Oe9Sdr+FwaW
 9F/MNi42ms/T8m2fV0fPgvqL1ckqC24xpZcD6PYGxIZVs6+LCvO+pZNEJdyYeto3fUed
 eA5g==
X-Gm-Message-State: AOJu0YzRWX2Zu5qDuj/If/Z+aREWX6fTsV9wDb7RqDvFe9aGf8S0WRFm
 HMABqesB2k6IWoUNYJml/+o=
X-Google-Smtp-Source: AGHT+IH+AFBVI3DPXh919wgqnRzEPxzRq+uwunyVsV2JXLy5zIepDPTI+3vWzY5m60dUrLlmwZ6Erw==
X-Received: by 2002:a25:d807:0:b0:d71:5afb:7741 with SMTP id
 p7-20020a25d807000000b00d715afb7741mr25038389ybg.60.1693238399368; 
 Mon, 28 Aug 2023 08:59:59 -0700 (PDT)
Received: from localhost ([24.1.27.177]) by smtp.gmail.com with ESMTPSA id
 f205-20020a25cfd6000000b00d05bb67965dsm1723919ybg.8.2023.08.28.08.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 08:59:58 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@meta.com, hch@infradead.org, hawkinsw@obs.cr,
 dthaler@microsoft.com, bpf@ietf.org
Date: Mon, 28 Aug 2023 10:59:45 -0500
Message-ID: <20230828155948.123405-1-void@manifault.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/_xe7-fuLJFTqZ3jB0srFqr5asSo>
Subject: [Bpf] [PATCH bpf-next 0/3] Clean up some standardization stuff
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

The Documentation/bpf/standardization subdirectory contains documents
that will be standardized with the IETF. There are a few things we can
do to clean it up:

- Move linux-notes.rst back to Documentation/bpf. It doesn't belong in
  the standardization directory.
- Move ABI-specific verbiage from instruction-set.rst into a new abi.rst
  document. This document will be expanded significantly over time. For
  now, we just need to get anything describing ABI out of
  instruction-set.rst.
- Say BPF instead of eBPF in our documents. It's just creating
  confusion.

There is more we can and should do. For example, we should create a
maps.rst document that will be a proposed standard for cross platform
map types, and remove any relevant content from instruction-set.rst.
This can be done in a subsequent patch set.

David Vernet (3):
  bpf,docs: Move linux-notes.rst to root bpf docs tree
  bpf,docs: Add abi.rst document to standardization subdirectory
  bpf,docs: s/eBPF/BPF in standards documents

 Documentation/bpf/index.rst                   |  1 +
 .../bpf/{standardization => }/linux-notes.rst |  0
 Documentation/bpf/standardization/abi.rst     | 25 ++++++++++++
 Documentation/bpf/standardization/index.rst   |  2 +-
 .../bpf/standardization/instruction-set.rst   | 38 ++++++-------------
 5 files changed, 38 insertions(+), 28 deletions(-)
 rename Documentation/bpf/{standardization => }/linux-notes.rst (100%)
 create mode 100644 Documentation/bpf/standardization/abi.rst

-- 
2.41.0

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

