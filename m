Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B19831196B8
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2019 22:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfLJV2j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Dec 2019 16:28:39 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35584 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbfLJV2j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Dec 2019 16:28:39 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so9497267pgk.2
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2019 13:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=pIRKF4dHpqchckl72/YpmRs/BI55M7i7L1pucxA2z4E=;
        b=a093tOG7PusILFWMBFDVZ0S7cjLimPfDS0Zqh5j+gZZf0kucIbzeOm1CZHw/ZFdKMP
         c5BZhT8yU9LDGIwsJooldnJGpXIUeCdvKvmVTV1/7tGguspn6r67Ymp9MWE3b5ABeEX3
         MyMvr8rIAhVm4hFS2bpB0VRnNTI9K2aV6dFJnWzCGJ8HOgVy/DnlT2wfZlwVitnqMf1P
         Izu35iju3ABwkITiAmB6sjvuy0B4D8pxDxbRtihc+tHVaMVUuZKCDNImkk/IPBFMpKcQ
         ustlUOQPP84kvEv6q34WV3vdg+12dH5JvZzffPU87O63e/lZhpaNqSMeg8mFJh11e3fs
         c3jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=pIRKF4dHpqchckl72/YpmRs/BI55M7i7L1pucxA2z4E=;
        b=fy9aO7KUtb/K2bpraXG7q6rtMvCIexrUb0Y26uEkW7Vs2NxHhf5WP1gHNRGbCWFijZ
         ur7JW+vHbkRSrQhtv6zDvkqvpbS6Lxlfn4VUgqjXYTQXyyILr9BfruYkqqTEvfaMQ7ot
         ofTml/VZTOuR+9S+yFa+CNBGHMlJgH5ADxWoV3CK1+LkN8owO6c4s5x2/SzREyt1ECzF
         VgODXzCE2zPFB7KNN8qHyOmW2iHawLJolgoiVgdkxpixMJuH1LzagozfTZ1zpUmUFc8L
         Fm9/jEH9d957dpNwzUYpoy5um+caKm12UO1ELOTt4luePOW/OW69JVSHD3/EUrH4UUFy
         m0hg==
X-Gm-Message-State: APjAAAWR4TwnzkXy897iqxteR0e9K/AyRoi9PaHyEAWmSLp/LHuYOfz7
        xolqrCSSWFbAjSz2EdJGTTOZTg==
X-Google-Smtp-Source: APXvYqxRq/2Ns0jfcbuRphOE4p7vfQeBo99PSUxKfImVcOh2PMEHsuUBN+Tqjb4WlMMGrECKyUA6ww==
X-Received: by 2002:a63:e608:: with SMTP id g8mr190645pgh.448.1576013318350;
        Tue, 10 Dec 2019 13:28:38 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id k4sm4629761pfk.11.2019.12.10.13.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 13:28:38 -0800 (PST)
Date:   Tue, 10 Dec 2019 13:28:34 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, oss-drivers@netronome.com
Subject: Re: [oss-drivers] [PATCH AUTOSEL 5.4 326/350] bpf: Switch bpf_map
 ref counter to atomic64_t so bpf_map_inc() never fails
Message-ID: <20191210132834.157d5fc5@cakuba.netronome.com>
In-Reply-To: <20191210210735.9077-287-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
        <20191210210735.9077-287-sashal@kernel.org>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 10 Dec 2019 16:07:11 -0500, Sasha Levin wrote:
> From: Andrii Nakryiko <andriin@fb.com>
> 
> [ Upstream commit 1e0bd5a091e5d9e0f1d5b0e6329b87bb1792f784 ]
> 
> 92117d8443bc ("bpf: fix refcnt overflow") turned refcounting of bpf_map into
> potentially failing operation, when refcount reaches BPF_MAX_REFCNT limit
> (32k). Due to using 32-bit counter, it's possible in practice to overflow
> refcounter and make it wrap around to 0, causing erroneous map free, while
> there are still references to it, causing use-after-free problems.

I don't think this is a bug fix, the second sentence here is written
in a quite confusing way, but there is no bug.

Could you drop? I don't think it's worth the backporting pain since it
changes bpf_map_inc().
