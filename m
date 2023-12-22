Return-Path: <bpf+bounces-18602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 762FC81C9AD
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 13:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D971F2613D
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 12:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97F11799B;
	Fri, 22 Dec 2023 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3pYlr2w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541AB17992
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 12:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-28c075ad8e7so525835a91.2
        for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 04:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703246734; x=1703851534; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ce31oHDfW+pgm2MqfHV8cwDKyZakVtiuormHtNd5MY0=;
        b=b3pYlr2w8YMzECv1zpj3txUYCFOKZPRd5BAXqd23n8mzzLgjBMozYLCL9oLCrv88zG
         UE7jR4WrUPqPEVHp0lE7DBAh85QWQkOXJVcSGExm6v7HCZxc2yCbxJlG11kI2SlI60I8
         iepbLV5lRqBlif5WG+4BmsBtByVfbmONwhXuKE3m5XPoioC0xKtgqlSzhxif7P4/EBnC
         2kH9Sgfp121I9iLvNgVkQvCqqhYE13yAiEDufJCcMW/PiD0uly71KDV7NFr6gzPS+NPH
         z/WCMLqGgYIaBt9932REPaqPvLXOLyG9XRhz/0/UOkAcEvYtZeV7diMd9mTXeSjGITwH
         8wCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703246734; x=1703851534;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ce31oHDfW+pgm2MqfHV8cwDKyZakVtiuormHtNd5MY0=;
        b=n8GaASD4UaTBWCRJnB2onUYsDbsmQSNuQ/wJqofyttLBVyFFKHSAoTJ0IelY/shCmk
         KVbHcGZhopM1j5IMN1yjqSreva6DpnE2+ADBKvrKH10s58aHcPCRBpEY0mQwwQe/TqGH
         WMlaz6/uUUtahs28Bc8KSsKLsYmFTH3vq8rBDJVjnBXjZu1ojLZFU2Mi+41FMIPSff15
         fefOu3+7F1SE0FscZgBTnxR1k5bt12OCyzsjG27KGfBfCEDl2PXKf7bkEnshvztZBpxZ
         7XTA53f9HadZptbBafuZ9/1D+tXybb+fdCh75tQIYR1Gc/YCFGll5EBHvqLTe1NouiW1
         /m8w==
X-Gm-Message-State: AOJu0Yydk4ShGrTHJfPBVFAol95dkVJVzMCpn2wU8IuntdM/NBTlCtSL
	plGi1cnUFfFIHZlgRzdvgtgxMOZeqX42uKHoO0/pKGdFcNp7c5bArhM=
X-Google-Smtp-Source: AGHT+IHizBA2M33jG3VJZP/oszu3xnY6jvmfxsm/9xlIh9OZdRsk1U/u4WF1HyRjFt4mQqq5PUv3FaORueaxhKoLbF8=
X-Received: by 2002:a17:90a:7782:b0:28a:1dc8:bc09 with SMTP id
 v2-20020a17090a778200b0028a1dc8bc09mr923401pjk.65.1703246734303; Fri, 22 Dec
 2023 04:05:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dominic <d.dropify@gmail.com>
Date: Fri, 22 Dec 2023 17:35:28 +0530
Message-ID: <CAJxriS06VxYSaCoo0WT2LtUPPwXopyMHr=-FyR5qRoeGWguBZg@mail.gmail.com>
Subject: Using BPF_MAP_TYPE_LPM_TRIE for string matching
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Can BPF_MAP_TYPE_LPM_TRIE be used for string matching? I tried it but
the matching doesn't work as expected.

Thanks & Regards,
Dominic

