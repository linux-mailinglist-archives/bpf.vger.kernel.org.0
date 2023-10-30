Return-Path: <bpf+bounces-13593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3F17DB639
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 10:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D18921F21E4F
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 09:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07920DDA2;
	Mon, 30 Oct 2023 09:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="mW2ANFGG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F2620EC
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 09:36:05 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4F3B3
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 02:36:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso647583766b.1
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 02:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698658561; x=1699263361; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uZCucFCd6/ZhRwrT9dPLVuma1cv227mEXSsAvccimvY=;
        b=mW2ANFGGf0d/0bzDdvm4qVYCy9c/qM8QtJ6aShmoZSIYQ8rLVPImYh1a05/8ylxxDL
         Mva8Imymnr/fjL9wesObE5iJz2v6YITJYBj6PwfnQCFVMJtufwsnbiKMsCODR8AKy8Fr
         IjPD68X+fTTrspZ2uH4ZG42C9IprZEuhbXUyhM0deL+pAOoLUY68zz9PMY7uDtkh240M
         0SudsAbrSLbEUjwoJEHYqon98YDFqOhJo2RBf1HgUkfxZwI2V81/xbynx9LLGUdlgwn9
         4SBDudXK5Sm/Byl3xbXxXdF2NVbLYFZZ5b/4zy8U0BzhEaZPx1IBZmBGjJpBqbkiyg87
         w+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698658561; x=1699263361;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uZCucFCd6/ZhRwrT9dPLVuma1cv227mEXSsAvccimvY=;
        b=ePH4Kpj45QFErUtWqGI2fpgH3WKcZl02ptAmmP1u2pkzHJxWH/GdfxAMTN34zFpd0+
         56Gnuh6DpQjeZzQmnZd5fWw/vyQ0bBwQTYpcWTnnl1Fvdl3n2bBjGVJMN4ohnQGPUdgC
         6EeFMPHMTMX4Q0UdExKajDQhJeiURAB9STFSOVOd4XKz5RD/XG7emC7Y53CUYHYeUsZW
         iDvslbVq0XABWzesf0ccfyXp34AicpdRj4nmyvPj8IHYcufbwEO6K224kSd1RuUpBkjT
         wzHh6QT6BMzvRrHV1hpWONfcvFKZyuzPiHoW2NPQtWxl0dMYm7mRRarmP8JqTGgaEsRK
         BVdw==
X-Gm-Message-State: AOJu0YyIaUUVxb/OVwSM8nk3EfscqYYJkQUyXlVqGsl64M1OnjrDoFSW
	jJVNAEduEYNCXHoqzQ7w4EzJpf/qCDOKPmk/z+I=
X-Google-Smtp-Source: AGHT+IHZDNHObIRPxSfGXdvodWZBeK32qjqyW+mzMoNhfYrLGnByurfQyAfextEPHdmQ2+INhDvehQ==
X-Received: by 2002:a17:907:1c1f:b0:9bd:a063:39d2 with SMTP id nc31-20020a1709071c1f00b009bda06339d2mr7821537ejc.16.1698658561496;
        Mon, 30 Oct 2023 02:36:01 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906044300b009cd1fca4d68sm5660801eja.5.2023.10.30.02.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 02:36:00 -0700 (PDT)
Date: Mon, 30 Oct 2023 10:35:59 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: bpf@vger.kernel.org
Subject: kfunc use newbie question
Message-ID: <ZT94/1VlpfA231TX@nanopsycho>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi BPF :)

I'm trying to use bpf_dynptr_from_skb() kfunc in my program. I compiled
it with having following declaration in the bpf .c file:
extern int bpf_dynptr_from_skb(struct __sk_buff *skb, __u64 flags,
                               struct bpf_dynptr *ptr__uninit) __ksym;

I have all "BPF/BTF" kernel config options on. During load,
I'm still getting:

libbpf: failed to find BTF for extern 'bpf_dynptr_from_skb': -3

I'm pretty much clueless about what may be wrong. Documentation didn't
help me either :/

Any idea what I may be doing wrong?

Thanks

Jiri

