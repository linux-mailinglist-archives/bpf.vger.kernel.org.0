Return-Path: <bpf+bounces-34166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 619B392AC69
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 01:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92DBC1C21213
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 23:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383C1152199;
	Mon,  8 Jul 2024 23:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPaBtesX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8144014F9D9
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 23:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720480160; cv=none; b=ruca2MCL3rSHy4wYuBiRintVxGoBwEXr9x9vbXuBWFomUAy4Rpf52MjFw2yO9SOBhKRKmPeHJVY67Dg/L2Lx9w+4bWFtlat29sM6DpilBW5ClN4f1WEQYnWUc/7i9cS4+qEwW0BQJNg5YlAnqt93cY+nH63VOmhR4hhOQsqWISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720480160; c=relaxed/simple;
	bh=+hgcnvzqb7Aqgy/N9OiqDtSrnWe6+KsxMbwhVf2idQ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h6c047PlyjbWRSk41STi5Kds9S2fyMQpJlgiS5E5Ts/m5BPpZAizY2zTgXvBKMPOPTXsFBu/Q4OUIm5VOtLBCZm2wbUgLRTwPVOaWlHiek5uEOHGNg2TrL0f7tzY7fLi4H9DDObzJ/5h2xyu/h9aeyQeknuPXehK2GHy++Ya1IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPaBtesX; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-707040e3017so3006572a12.3
        for <bpf@vger.kernel.org>; Mon, 08 Jul 2024 16:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720480159; x=1721084959; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+hgcnvzqb7Aqgy/N9OiqDtSrnWe6+KsxMbwhVf2idQ8=;
        b=nPaBtesXjYTsubjNai3xtnlWaYrsX0Ie0VDwaNCvMWJi64vJupt8A8GStZWjpnJ/o8
         wUxC5m2RbVPpTCsGTW2OBWqEeEKfvfIdo2s2EZMindy2JdO8PF9nEbitQD90E/KbP4W7
         4vHkZF6g1hwzAoTBdb+lqR7HFlSmla7fKTl4grqsn0jIKiu1iU0FZCNQ3cqcia2R0DTc
         k81oypfrB/WL9F5BwKjbwamE9pH2h7baTcmKO5PdDGBxgmf9FhXqlWikYNmXwNUHL1e6
         /rEkNJ53bGwonNXtJHidIsAzcGuJRchhAwlEVjGUzm+HLsgA8OzpI5SOUJVTBe1GCIFO
         fiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720480159; x=1721084959;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+hgcnvzqb7Aqgy/N9OiqDtSrnWe6+KsxMbwhVf2idQ8=;
        b=NAu1+BXq+HO5tsF7ceSAVdnuMg3H0GIHWP1PpNnOYrX7sXKsMZ3zX+fFLkl3N1Zaz9
         PFCN3saovHPQzA+YVBATNmjqYNAqoAksyHa6D5eonjrj5vFuyLZdu64RS87HapLMaAGA
         EU5THL2Sw8sZvxomjbb/333lJk3cNviRDnYhbSyUTPfvOgY27T4lJs3s3hf4rKZRrvci
         j+PAiRc1c1atFYShpt560JhZoBbzDWfjSHPVNWY814W7k4VGE8SBeb5kc0J00VULirFc
         jkKoTC8Mk/p8nLn3vj1BNF3SYsPgIIOU3+OFmnLubwoHV/QYF2p7/K68Yd3BGpjp4mD7
         S0Zg==
X-Forwarded-Encrypted: i=1; AJvYcCU5HyqrMqHZYcZL9dlGFzWwX3LwaZlnkj/tCjVGoV9KzRLmu3Dzfk3P6Sd7nuroo8r+RM+MNxzJ45LnUac3dJW25SPH
X-Gm-Message-State: AOJu0YxjpA+/S4/DKEeNFCt3h94gX4Mn9DgW631aYsPzgFYuzAusZF6E
	EEk3w1JP6PJ869u235RqG4ZQzANuB9Dlv2bBXB18nWKlYGAYB/b1
X-Google-Smtp-Source: AGHT+IE0RcrxpRtdrqVf5bF0IcIQSjz6HIPPSHiAeYNQMIiFWnMXUu25ZO2zyBimNPN41u6aWXXpFA==
X-Received: by 2002:a17:90b:612:b0:2c9:6495:6edf with SMTP id 98e67ed59e1d1-2ca35c3dbedmr989056a91.15.1720480158762;
        Mon, 08 Jul 2024 16:09:18 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a98395csm8698749a91.29.2024.07.08.16.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 16:09:18 -0700 (PDT)
Message-ID: <2576d3aaf0b3acb0bf86592ca9a3f871ae660f48.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/3] libbpf: improve old BPF skeleton
 handling for map auto-attach
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Mon, 08 Jul 2024 16:09:13 -0700
In-Reply-To: <20240708204540.4188946-4-andrii@kernel.org>
References: <20240708204540.4188946-1-andrii@kernel.org>
	 <20240708204540.4188946-4-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-08 at 13:45 -0700, Andrii Nakryiko wrote:
> Improve how we handle old BPF skeletons when it comes to BPF map
> auto-attachment. Emit one warn-level message per each struct_ops map
> that could have been auto-attached, if user provided recent enough BPF
> skeleton version. Don't spam log if there are no relevant struct_ops
> maps, though.
>=20
> This should help users realize that they probably need to regenerate BPF
> skeleton header with more recent bpftool/libbpf-cargo (or whatever other
> means of BPF skeleton generation).
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

