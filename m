Return-Path: <bpf+bounces-35700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C18E93CCFF
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 05:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C451F21F1C
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2024 03:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B950422F1C;
	Fri, 26 Jul 2024 03:29:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A524436D;
	Fri, 26 Jul 2024 03:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721964593; cv=none; b=XDaJRG2CG/s9HthCGNZH/SOaJkY9z7bb813AyND/Luh+xDiAgCqngnW3Vla9PG/atZWGxJjEKuo1OJXdgrifGyhlFnj9aU6qkvizH9/O5o7ZbTtViRAEbdu+N5XQugidBlSEsOqL6V5/KTNgHmOqLY0WNbKGuPC5xKDEGnlKNy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721964593; c=relaxed/simple;
	bh=MX3S4xFhl5JUdGTw8lSleq8F1xXDRForZhuJShMwBOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezunPvllAkp8splkR2KEbQVvTbyIF6yTa97QuKPc0/LK5LQNMzKzxan3uxbeRHn5kxuEP8/LTGtLRnhdOeNrFnvqZcG1tuelIwNit6URzCvOdgnf4K6kPraUnGnuQeTsQIuufk9sgT1VhFXiF7MxlHQX43qsy/aAa25QMfKJdT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc5239faebso1829835ad.1;
        Thu, 25 Jul 2024 20:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721964591; x=1722569391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPCOqUxRe4HpKCHulx3jzZ69jtM3iGZkqcwYDzljxWU=;
        b=i6HCIPeZmEEnyYaIX0TSLV0tlsS14nbfNcQAZqsB4o9aT18fHG/YzYHeGYATrmAK4c
         gNZuiyLt5suV4n7X414hoBpR7kU+fXYEt2wdVxH8mtoAzfvVf0JO7Ntwe3qEjtJkUF1n
         eDf87+I7InpwtV7iG/xgooRpGOuSvrdQd9OgVAXLzIe+0LKZnrzsz5F4CWgY5UMLn5gu
         KVtn6KyJ3cvhpE3ifqO8GW+nuKwFSU1mDF+KIafwrNyiZ16ykG3ISmEe+QU76xQbAOld
         cBOXmgfOr0I2ekrHTblnmdJbeALGB3W5VF5MGkkwWpNZJYhD+4+AzlWApl3BfyfCeAfS
         OPOA==
X-Forwarded-Encrypted: i=1; AJvYcCVceY5ZR99G9eHm6h64qMI2p/PvLVqbVS+UE76vjoaMqZM2s5ECCkPtJRygBabvFdKWVtc=@vger.kernel.org, AJvYcCWvyC8FwSBZPB+g22SL31Rg5WgjHtHfu8EZuoKdc+evezOTFopSBmCcHOsgZqZh78mFHyXvWRio@vger.kernel.org
X-Gm-Message-State: AOJu0YzFPtunJyy9uA9QEO0G06yPscmI8K7Ed6n4ClGxVN/h04Dy7AgN
	LeRqCEtNGfVjVEVx+pYOMML+rrW7ORNSKaadDeQkM1243d2oLef3y7ujHs0=
X-Google-Smtp-Source: AGHT+IGasw4hobeHMoqOVtJJ7RT0a3xLWzniolZdHOnz54sKcMdpE/NRLN7xnlOnO0lIgftG8c2u2Q==
X-Received: by 2002:a17:903:18e:b0:1fa:7e0:d69a with SMTP id d9443c01a7336-1fed92a71e6mr42311865ad.46.1721964590813;
        Thu, 25 Jul 2024 20:29:50 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7cbedefsm22138605ad.67.2024.07.25.20.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 20:29:50 -0700 (PDT)
Date: Thu, 25 Jul 2024 20:29:49 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Rao Shoaib <rao.shoaib@oracle.com>
Cc: sdf@google.com, Eric Dumazet <edumazet@google.com>,
	priyarjha@google.com, ycheng@google.com, soheil@google.com,
	daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: bpf: add BPF_CGROUP_SOCK_OPS callback that is executed on every
 RTT (commit: 23729ff23186424)
Message-ID: <ZqMYLWFWEC0OWjrl@mini-arch>
References: <2628656e-ea6f-4885-8fbc-bd14f07a5b00@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2628656e-ea6f-4885-8fbc-bd14f07a5b00@oracle.com>

On 07/25, Rao Shoaib wrote:
> Hi Stanislav,
> 
> I have a question about the placement of tcp_bpf_rtt() call in
> tcp_rtt_estimator(). Why is the call made before the assignment
> 
> tp->srtt_us = max(1U, srtt);
> 
> How is the attached eBPF program suppose the get the new value?

Take a look at the way tcp_bpf_rtt is invoked. It gets mrtt_us
and srtt arguments. Those are passed via bpf_sock_ops args field.
See tools/testing/selftests/bpf/progs/tcp_rtt.c. Hope that helps!

