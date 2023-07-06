Return-Path: <bpf+bounces-4342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC4374A6AB
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 00:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E439C1C20E99
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 22:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C8815AFC;
	Thu,  6 Jul 2023 22:20:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A351872
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 22:20:42 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0897E1725
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 15:20:41 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id D3CCFC16950E
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 15:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688682041; bh=eAf3TYRcR4GQWBRh4OnRJR84Nh8vUCNUSL4oKZo1Gog=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=li8fCQMulb5VrSzSZ6pZybJg3bupWT3fPwlZ6GMXggZa0zqSoOdk9OPw1q+wQQXQ4
	 iz4U3w4tEZ+yqTPE/NaBexa1mtdv1epvXfYgIx41kKcoV3gKroIw2t3zIrzN2l8ioc
	 uyqfa5suxY/LNVG32odTRn8WtoOjDq+DWKxNT0RA=
X-Mailbox-Line: From bpf-bounces@ietf.org  Thu Jul  6 15:20:41 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 7EFA6C1519B2;
	Thu,  6 Jul 2023 15:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1688682041; bh=eAf3TYRcR4GQWBRh4OnRJR84Nh8vUCNUSL4oKZo1Gog=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe;
	b=li8fCQMulb5VrSzSZ6pZybJg3bupWT3fPwlZ6GMXggZa0zqSoOdk9OPw1q+wQQXQ4
	 iz4U3w4tEZ+yqTPE/NaBexa1mtdv1epvXfYgIx41kKcoV3gKroIw2t3zIrzN2l8ioc
	 uyqfa5suxY/LNVG32odTRn8WtoOjDq+DWKxNT0RA=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 7481CC1519BA
 for <bpf@ietfa.amsl.com>; Thu,  6 Jul 2023 15:20:39 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.897
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=obs-cr.20221208.gappssmtp.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eNqntnWZbMaZ for <bpf@ietfa.amsl.com>;
 Thu,  6 Jul 2023 15:20:34 -0700 (PDT)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 08A20C15107C
 for <bpf@ietf.org>; Thu,  6 Jul 2023 15:20:33 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-635de03a85bso7610306d6.3
 for <bpf@ietf.org>; Thu, 06 Jul 2023 15:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=obs-cr.20221208.gappssmtp.com; s=20221208; t=1688682033; x=1691274033;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tcZcPcvDLuTHi258y77yahK6XXeK4B+Il7OypjQgctw=;
 b=MCh8dzwhbG3DQcbOyFyr/Gvh75QRh+0MYrOPppZ3QqkO6WkmTphuQvb7DCIl1WpZAI
 T8MVN3n9ZDa3di6IdS1a6B1EN1Tza1mcK5hzyOyXzon1hicIKdqoCpTAugEX7DT/dAha
 we4Kn1Ho/TvsGCJ6yv7OgNREBq37hznXT2EVT7RzxGpxqCBICX1b/QYyMQzw4GkKxvLB
 8/f6Fpiqn4Jtk9pGCI/yuhPCdrGnKYPb+f70IfOYY2HQ9pFRdGoxTru/76FrujJlje7C
 rEo7UE5MYyAgAK9GZYri74Bx8tY+iXzTLwvzOEJEyyYgcAiasohy10OaAGJb0m0uStYH
 Gb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688682033; x=1691274033;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tcZcPcvDLuTHi258y77yahK6XXeK4B+Il7OypjQgctw=;
 b=T/w7UstFKm15NFtVzyXSwVlPZ8cR7N6AYGfD207eHDLYgBV8GxHOTXIj7A8Abtnkyw
 vpwRGwbtI220bosMp9tqfw2/m2ksgh046c8vKfpcJzfBBKF4kJRWQQiJompzhNrJkLVv
 J/WSPVPBDPL/Zn3PdV9ggfeRrM/gMh8OsJl7ivQXKCoJdKXxV/oiEfbo9x4QCXlNoEs+
 dk05KQqjjr6OrzVp/kCbWd7SkwHLTkdsSPa/R5swwTprF94FL7UPjqX/whBfFi235Zbj
 cscIdjDe/mOxlbHNWe00RfF7kZfpOWf27Krl/o+9OvHW6n/l+2cQDEXGL1Gb1jUPzsYx
 nCdw==
X-Gm-Message-State: ABy/qLaGeo2ljhVwrKVVWbnAyWdFom3Ej9EVA8FWrx0L/QFWMHqyNPN8
 W2AI8dFz/z33gfxoLkHiv4KCYQ==
X-Google-Smtp-Source: APBJJlF0gywZGYyK183FavLX53tfDuw+l2/1oKaPq5cR+4xRGBCMDMnyMMczfILT1rR/QrpDwfPq6w==
X-Received: by 2002:a0c:b20b:0:b0:623:855a:9226 with SMTP id
 x11-20020a0cb20b000000b00623855a9226mr2622557qvd.23.1688682032991; 
 Thu, 06 Jul 2023 15:20:32 -0700 (PDT)
Received: from borderland.rhod.uc.edu ([129.137.96.2])
 by smtp.gmail.com with ESMTPSA id
 h5-20020a0cf205000000b0061b5dbf1994sm1322717qvk.146.2023.07.06.15.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 15:20:32 -0700 (PDT)
From: Will Hawkins <hawkinsw@obs.cr>
To: bpf@vger.kernel.org,
	bpf@ietf.org
Cc: Will Hawkins <hawkinsw@obs.cr>
Date: Thu,  6 Jul 2023 18:20:19 -0400
Message-Id: <20230706222020.268136-1-hawkinsw@obs.cr>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/Jz6jwPAr-HRjK6bs1OdUz1mdYyU>
Subject: [Bpf] [PATCH 0/1] Describe stack contents for function calls
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

Although I am sure that it is patently obvious to those smarter than me,
I thought it would make sense to add language to the ISA documentation
about the contents of the stack, especially with respect to bpf-to-bpf
calls. 

I hope that this change is helpful.

Sincerely,
Will

Will Hawkins (1):
  bpf, docs: Describe stack contents of function calls

 Documentation/bpf/instruction-set.rst | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.40.1

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

