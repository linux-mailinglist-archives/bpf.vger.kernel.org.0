Return-Path: <bpf+bounces-41349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E49995EAF
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 06:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF4321C22466
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 04:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6332F1531E8;
	Wed,  9 Oct 2024 04:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfFbxsoE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CCC3C24
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 04:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728448972; cv=none; b=WOnKwPwIp8fA6nRMqWoleJXm6LvnQa/wZ08UXgFf6NeoHEOkDlpigxoZQNAU3owjndhPzp72l6F9/FlJrAfUoyKB3MRW33bHwEb3MLZFoR/8aDL26VlWz3uy0sj+8ob0wWEVKtUptRoqjVVVnM6Bk69jON8PBWtMnNzY2ZSQ6fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728448972; c=relaxed/simple;
	bh=uk4UFdlkdWWy4vnMHBCDOf32TswryB1BheCMP7KzQVE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n+EZ+jhGmqBHixS2007C3/XjGAQ9YiFc9s6jUcXMshKUctUwghk0QeHsQG9QWxXioWlgguJssivCpt8+D3b9SpDanOOTIuvwYjiLNLw5a45uX4lNsSKzdbhMtvJ9TxDjcU9Jf0DHbewLWmDEbnGd21+Dr2HRpsGFmN1HXf9gjwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MfFbxsoE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b5affde14so46238835ad.3
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2024 21:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728448971; x=1729053771; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uk4UFdlkdWWy4vnMHBCDOf32TswryB1BheCMP7KzQVE=;
        b=MfFbxsoEbhzVGqnv5UdrnkWMNg9baRv8fq2S+CQxTnu/GEVCFQjRxHRI6SbUI51yim
         kynJNuc3J2R/c6mqXtXHSs/1R5XlTM0Uxh6sOHUu/nNZMJVCa8JllyfXXJuUQ5fDYhS3
         1SXa2PwtuJV+Pjy2BE8L65q6FNKzlld7e4jg7kkDzKI7myLbcHAO/d8bMYoz3QkfUbYe
         HHp8SVVfxTeqR2xGM1+2qG3Tlcukh+7ZodDG5sB+q5HVk9W4SAT07JPsEQ3C3KgCKOEa
         kxNlUR7m5OReq/J7bzOgwOhdU1nxVuYwLL+2RQ9XkvM0qFBhC8GBL6dffiQjNdodj7on
         OPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728448971; x=1729053771;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uk4UFdlkdWWy4vnMHBCDOf32TswryB1BheCMP7KzQVE=;
        b=u2R2rC1cQqVnrw/6T73dNDpPoFghq6ODf39zEzWr2iOGfhqrnwYYKKcA47QkBLzg/B
         jY3Fs4Aj2xLOQJjGsWRf7sZZ0zd2J0n0ID4aks06PhOOkBdB0EMIDWWfsroYKWeYIHpF
         oSKb9HnAkse8EjHwz2cTCWAwWFz8KhXZTmymvIEttec7/jwm4iqL1lddLF3MBggghzHg
         FCGVQTVgvqqcitBfZSPuD+kWoh1gvZVRpJukfiG77h6drfp+G6eqJKjcdGI2CHmELZ3H
         EDfzxbF0WAumhHNWVJcZGSD/EAyJh9QgpQLTOnGRzhTsGb3DUWNP5yiZ0Bgo+YD38hVK
         hcnA==
X-Forwarded-Encrypted: i=1; AJvYcCUbe++294cS1rmQUNPZix2IymPowYRsj3M60vCN3fNTnf+Oljf6yWWLNgiGi9x/JMaGhrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiM83tX3lwt8ODeAp7j4F+fFpV8ZC/nUvH8J2qld9RFvVdcRut
	Ep1UmJmSH97kyf2Rnb9Oheo0nH9Xm/msVIjqze59uYejVVqOXQn/
X-Google-Smtp-Source: AGHT+IFEvz/3hjsS1im5Sc/3tZ78DhIENlNVowSsRUPU9h116m+ilf7XxZQwAP1tc2dCxQW2ev/O1g==
X-Received: by 2002:a17:903:2286:b0:20b:fd73:32bb with SMTP id d9443c01a7336-20c636eb686mr20558435ad.2.1728448970829;
        Tue, 08 Oct 2024 21:42:50 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c13986787sm63092735ad.242.2024.10.08.21.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 21:42:50 -0700 (PDT)
Message-ID: <5713a88deabecef0f847ded008bd0833e405df80.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Prevent tailcall infinite loop
 caused by freplace
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 toke@redhat.com,  martin.lau@kernel.org, yonghong.song@linux.dev,
 puranjay@kernel.org,  xukuohai@huaweicloud.com, iii@linux.ibm.com,
 kernel-patches-bot@fb.com,  lkp@intel.com
Date: Tue, 08 Oct 2024 21:42:45 -0700
In-Reply-To: <20241008161333.33469-2-leon.hwang@linux.dev>
References: <20241008161333.33469-1-leon.hwang@linux.dev>
	 <20241008161333.33469-2-leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 00:13 +0800, Leon Hwang wrote:

[...]

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410080455.vy5GT8Vz-lkp@i=
ntel.com/

These tags are misplaced: "Closes" link is for v5 version of this series.
"Closes" should refer to error reports for something that is already
a part of the kernel.


[...]


