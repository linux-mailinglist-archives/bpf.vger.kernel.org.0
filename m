Return-Path: <bpf+bounces-40207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B89797ED36
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 16:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA2A28184F
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 14:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200F219CC3F;
	Mon, 23 Sep 2024 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QPerjNNA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E11F1474BC
	for <bpf@vger.kernel.org>; Mon, 23 Sep 2024 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727102068; cv=none; b=PVHg7ph5pZndvB0RvCw7OdJorCDSYQDV0Q9ayNOxbecpMXItb6kdVm/+vQKawDsVijnxihrAZ6i2f95oMe94abh99CSPzG/UOCMRzMl/aOKYg0GFDmdVftp1ombl94u1FN02dn8TQ7thU5AcQOxhTVo914VHI+q7RnQ/myMDN78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727102068; c=relaxed/simple;
	bh=/hlN1vc3iqsnhJ8BbsFU6jjZPvQSoABUoLWn0JPyOj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nn71Eq5nZuXQOT/JXQ0WYA0jMCcKoT0EObcvayHZYvLj0WYtXsBynR73OWj3FQXOXbTd/rEEl7D/n0Py4ikEmdJrPNqWIn2zhS8YQy7T82oXQ9aJVj8ix+FpMMJrP9GW+BfLAABNuerJjadCDrkai5BahvXwTNiHF+SR1+mGNMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QPerjNNA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a910860e4dcso167600366b.3
        for <bpf@vger.kernel.org>; Mon, 23 Sep 2024 07:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1727102065; x=1727706865; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/hlN1vc3iqsnhJ8BbsFU6jjZPvQSoABUoLWn0JPyOj4=;
        b=QPerjNNAunT8g3oca6cMyqkWg91JFmbqR8GZv/t0dBb6Qgfl4wPfs+ItdFnLzPN5Aq
         nEzNhii9S20L/H/RYVbrOh0A3zABsPHNNdm4oycwVtLkhc6ziD0WzzyGusAc7nMapV++
         guf7HPqoCUi58x+wKb5YD6aTrOSTF/vo2S9CfKNnErUaFVSkNCiQpNVTKf2YC+Y61bob
         74RmMU5yhA14nkVH+Ktz7W+rMt3mKf5UD4x6EPc7a3LRueVIYLLNc1luXRJPzEUvs8pi
         2eXcDTt99KjbE+NGrlkyAETUGUz+k+/DK9OzsMPowX/MC12q+V9OtwnhQQfgVv4WSRmG
         7Sbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727102065; x=1727706865;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hlN1vc3iqsnhJ8BbsFU6jjZPvQSoABUoLWn0JPyOj4=;
        b=SS7cXJNFMhZsWHNcd8qo0FrLkUieY4QR7YyL5uBMPl3xsaKN3EOUHvlTkoB2dfJu5U
         9A1tzzn70oQsVJcgMANkz3DWACw4YwW5GzfWvdSRRxcJ9GzWVjc0WgV9EFnincDTWzxp
         KEsII7hZ9vIfGYxpdBR73WtET8xqQsFztEwFamJMyGhqDmbrJlmfQzkl9Z7r/pOPpQSI
         CvfoBxOuEAM5tpOdUXW9Or58q+reLXq5i1SvrXs6aMAU0IfLEolbl4SEZi+xgDt05bOk
         HegW0c3CDf9TWrt/67wV2MUEF9iVbgFkYmo3xvabQObDl9sFO9KAbRLFiZ/AEHvBdWKY
         czYg==
X-Forwarded-Encrypted: i=1; AJvYcCUkobbHinkHGlFAFmFP3UYHjcEhFxlywPsfEeAraw3gegqzpWb5Cvvh47ZsDkIsot4fgVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgBckMn30LQ1IA+mXZVAGkudXa/vCyFggGp9SJzz3wmZyiAEXG
	0paOJI6pNnN3l6kZmkatrGnegz2HHW+TdD2JZvHxoaxOxgr4z4GXbEPaqU3Pg40=
X-Google-Smtp-Source: AGHT+IGvZ8CQKXGAuBIihvOK7BE9/Z+R3v8H58CSqqO0KjaYyKlCLQW3ALuIjZIDoyqq5B9b4jxJgg==
X-Received: by 2002:a17:907:e64f:b0:a8d:555f:eeda with SMTP id a640c23a62f3a-a90d4fdf82cmr1225911666b.8.1727102065503;
        Mon, 23 Sep 2024 07:34:25 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:5a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b38d3sm1231298066b.120.2024.09.23.07.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 07:34:24 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Tiago Lam <tiagolam@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>,  David Ahern
 <dsahern@kernel.org>,  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>,  Alexei Starovoitov <ast@kernel.org>,
  Daniel Borkmann <daniel@iogearbox.net>,  Andrii Nakryiko
 <andrii@kernel.org>,  Martin KaFai Lau <martin.lau@linux.dev>,  Eduard
 Zingerman <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Mykola Lysenko
 <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  kernel-team@cloudflare.com
Subject: Re: [RFC PATCH v2 0/3] Allow sk_lookup UDP return traffic to egress
 when setting src port/address.
In-Reply-To: <20240920-reverse-sk-lookup-v2-0-916a48c47d56@cloudflare.com>
	(Tiago Lam's message of "Fri, 20 Sep 2024 18:02:11 +0100")
References: <20240920-reverse-sk-lookup-v2-0-916a48c47d56@cloudflare.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Mon, 23 Sep 2024 16:34:23 +0200
Message-ID: <87v7ym7828.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Just an FYI to the reviewers -

Tiago is out this week, so his reponses will be delayed.

