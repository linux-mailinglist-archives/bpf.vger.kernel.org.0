Return-Path: <bpf+bounces-3745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C01C7428A6
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 16:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297491C20AB7
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 14:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B47110961;
	Thu, 29 Jun 2023 14:42:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E10310FA
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 14:42:00 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3121FC1
	for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 07:41:58 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so1018142a12.1
        for <bpf@vger.kernel.org>; Thu, 29 Jun 2023 07:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688049717; x=1690641717;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VFKUSHvydnmwLfHL2dvTDOlRV+qT8pyhLrBahYOSl0E=;
        b=SgFTV6dfVWVQuBYhOrP094wWv8xJDwdE3UUxtfTtwwDaCDgTRcQCAlW3js9W1PEQxM
         1BvhfjMQKZOtgBfvljjtbDEB99wHP/oB7cRcm0xBiivKEvpynv+hRTLHdB1lDaosFGSX
         HxsLtcJW/Ft8II9qLYkOAu0wXwajjFOcEhgg4+gR2FV2YF85OtrOpePi+tXFAJ8EKCtj
         A7MivJCB8C54r5k3Ag9hpSPg0a3BRYgfxe1q85pNklldPZeJ699UevsoHdBkjPKaAI8/
         MH7IUQj8WRBjgCiIC4WBHQ23JvstvkJ8ZfCYo10BknNLH9wWwcNFx6MLHq98KelyYNqG
         LRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688049717; x=1690641717;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VFKUSHvydnmwLfHL2dvTDOlRV+qT8pyhLrBahYOSl0E=;
        b=b+YttV6MT32NOi7mBaLnfO5F15FU6woaJuch1cURlPsNqoiKu+gj3u5TmpdhXwXdAz
         3SYvgKwhz4rVcIOu5zYNc8AuwYJ0G5qxA6G1IpaW+0/zFPFMZE2M/KKrujV1XFHvRgxx
         bsXaWPp/5ySAlrZEROq7Fowyl/UZvNkUekos+8kexApLTWhaQofS2wJSHwtH2HY/WRVa
         /uapg7e6f5Qj0j6bN5mCym59yIi4IR5THyssNKUR+QjRjwb+6c6jVsFUqEAdw5IMKXOZ
         VtRlO1xwlITHlTlwq2pfKuIsc36/r/tL8P2T04eEym9VSFuT9EpvqccZiq8DvhpXwnke
         S2QQ==
X-Gm-Message-State: AC+VfDzaMtbksPJnVNZ61xppStbg5nAK77NAPl8m3jgLxyEAgGauTI1p
	mlkFtqCOwMZP3aRqx1HrNO4f/8dQ+xFGTQWhSOSby2TKNDGtVoXBhl7wFg==
X-Google-Smtp-Source: ACHHUZ5PpwlHihEBJKr/6GC1KVa4vlHk4QBMXqPo11p9tPg+6bn1TUW1aOxy520w5iR6PiV5HhJfJWj6cOCcGQqUbtY=
X-Received: by 2002:a17:907:318c:b0:987:e230:690 with SMTP id
 xe12-20020a170907318c00b00987e2300690mr33924666ejb.57.1688049716985; Thu, 29
 Jun 2023 07:41:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lorenz Bauer <lmb@isovalent.com>
Date: Thu, 29 Jun 2023 15:41:46 +0100
Message-ID: <CAN+4W8junMrqMTQJ1cy-5fhd9FFsASWOndRPaprspKXMXShJYQ@mail.gmail.com>
Subject: PSA: Ubuntu pahole creates buggy BTF
To: bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org, 
	Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Just a quick FYI for anyone else struggling with weird BTF on recent
Ubuntu releases, it seems like their pahole is broken due to an
incorrect backport.

The upstream issue is here:
https://bugs.launchpad.net/ubuntu/+source/dwarves/+bug/2025370

Best
Lorenz

