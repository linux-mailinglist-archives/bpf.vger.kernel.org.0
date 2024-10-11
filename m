Return-Path: <bpf+bounces-41696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E30E5999AEC
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 05:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D755282716
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 03:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C699C1F4FB0;
	Fri, 11 Oct 2024 03:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="AtbSpvr2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1061F4720
	for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 03:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728616092; cv=none; b=e65Epg0Z4ix8E7wDg40Bbef8Iy6SgMeutDLbMovdR8Vl3S4mh/NOr+atCkysann1UoNAbCs8V7kCulo6qSLsPGJ6eGbFZovWRSjTodcSkbqkuFCX9BXnE1htvv6dJ1e4Z8aU5Tn48qv3fwLKyLSpaWj+ggV+GJJhMtj/YNDR0qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728616092; c=relaxed/simple;
	bh=YLuBWG6/qc7ga5aPtQTIDDS1RpWthIDoLcApXgrfLZ8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=AV1UfIvYHTyiY9jk6vmzAhH7xNCkIXs0ud7tss1l3G1rTMNZRMCrzZPg3Gf0D6QgEVxpLOPv4XI2zMg85/HuagS8DbVczWHuj42aRa310HOihL3neJ/mKveoBu4q6phJdekpCK4mcCUvcH4RzW0K+pQueuFbhPgk8zfPp3Q751g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=AtbSpvr2; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7afc592ca19so94568785a.1
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2024 20:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728616088; x=1729220888; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBDimyqC4CJK4p2iBMj8GbFo0/9rbwMGrV3N2csFsfI=;
        b=AtbSpvr2QAKK1sYFFWgs6GGhi1qeRU0pYE/OpaTzaZmoFmMCVrhXhW6IjKn+DLUIdo
         Bq0b2Q+9CqDy6EXilVYr/HfKliG0VnrTZ/SunjhniFt2psA3+BMp11j+8BxNX6JkRb8x
         uyMoDV2aEs6OiIsQlROXcDwNFO9e525rfKgqy+MD55HlDkl4e7lsB16q+J4tt/MjU4VJ
         K5owi/TH0nvO4SZrkLrjXhL5cBM3oEKQL1pmGqk8XG1QskoVQuXpMMUzyNE2QC91a3E/
         AVpslDPydCSdDJA0w9cvRliB1G8JFRnySFmKJldZlk33S6O/qWzch5e0bJULhdxFSaJA
         EO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728616088; x=1729220888;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JBDimyqC4CJK4p2iBMj8GbFo0/9rbwMGrV3N2csFsfI=;
        b=IT7McVJHrZcKwMgk7EdR7QRBrUEBNmWREWS4W/Z1bT2KI1EpjQIui+RCz0RZnIviN1
         djZG4kIvzle+N0NcYxuU6bRMyrLoRBPZVZRvQ9itYgHdrMPsT9Z5V1FKm2uP09TOpBNg
         V1DEsuH5pZpVHD3flHet8LvOvHyw7p5ftQueZdcmcL6Nn3wb6sQZI6EFSe63lBK/kRyI
         IYnuq3thFxMZ5xD3PHZCMF9o76fpbhqmTJ7kPNEQZ2KITot9h8Sk0R9GiTVCe5MxWb60
         DZzEjfjEuZRcr65SlBHfe+hMUgzPjIMs7aGgSpWlCHYsN06Um4zXNpVX3cJ2nQ2Eal34
         JoUw==
X-Forwarded-Encrypted: i=1; AJvYcCV6SQmPlR+BOZX6PjIfK9O4bR/TNtNA0jSyj65f5Gk+VnIjhwclJixV8KrB/2u8g9XSJUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1f2m5A0JwRqywsz+EwOWBOwL5ryP8b5XDWEoJigYZi6HD8UqE
	pejwNzEYweJ3aG7ZZRyv/lSeiqzWoRQZp3M35vF8ijUo5WFc825WBlT0A7g68A==
X-Google-Smtp-Source: AGHT+IEq45tHLzd0BJhXzLGe1YJAlDo84n078XLgRxpwqpJN8UttW19ZEx28YGyczqACohCw1soA3Q==
X-Received: by 2002:a05:620a:444c:b0:7a9:c346:382c with SMTP id af79cd13be357-7b11a35f629mr149344885a.20.1728616088451;
        Thu, 10 Oct 2024 20:08:08 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b114956044sm97771285a.79.2024.10.10.20.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 20:08:07 -0700 (PDT)
Date: Thu, 10 Oct 2024 23:08:07 -0400
Message-ID: <1e6f94db91f0df07373ec1e0c8f3eced@paul-moore.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Casey Schaufler <casey@schaufler-ca.com>, casey@schaufler-ca.com, linux-security-module@vger.kernel.org
Cc: jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net, apparmor@lists.ubuntu.com, bpf@vger.kernel.org
Subject: Re: [PATCH v4 1/13] LSM: Add the lsm_prop data structure.
References: <20241009173222.12219-2-casey@schaufler-ca.com>
In-Reply-To: <20241009173222.12219-2-casey@schaufler-ca.com>

On Oct  9, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> 
> When more than one security module is exporting data to audit and
> networking sub-systems a single 32 bit integer is no longer
> sufficient to represent the data. Add a structure to be used instead.
> 
> The lsm_prop structure definition is intended to keep the LSM
> specific information private to the individual security modules.
> The module specific information is included in a new set of
> header files under include/lsm. Each security module is allowed
> to define the information included for its use in the lsm_prop.
> SELinux includes a u32 secid. Smack includes a pointer into its
> global label list. The conditional compilation based on feature
> inclusion is contained in the include/lsm files.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> Cc: apparmor@lists.ubuntu.com
> Cc: bpf@vger.kernel.org
> Cc: selinux@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> ---
>  include/linux/lsm/apparmor.h | 17 +++++++++++++++++
>  include/linux/lsm/bpf.h      | 16 ++++++++++++++++
>  include/linux/lsm/selinux.h  | 16 ++++++++++++++++
>  include/linux/lsm/smack.h    | 17 +++++++++++++++++
>  include/linux/security.h     | 20 ++++++++++++++++++++
>  5 files changed, 86 insertions(+)
>  create mode 100644 include/linux/lsm/apparmor.h
>  create mode 100644 include/linux/lsm/bpf.h
>  create mode 100644 include/linux/lsm/selinux.h
>  create mode 100644 include/linux/lsm/smack.h

Looks good to me, thanks for the lsm_prop rename.  As a FYI, I did add
a line to the MAINTAINERS entry for include/linux/lsm/.

--
paul-moore.com

