Return-Path: <bpf+bounces-27059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA968A89E6
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 19:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B629284FED
	for <lists+bpf@lfdr.de>; Wed, 17 Apr 2024 17:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E461917276F;
	Wed, 17 Apr 2024 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gcx7b9pI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A5B17109A
	for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373697; cv=none; b=BlQtvWmKqDImTa7TjXKlVjIjZglO4oY0mGUs1FJhGwfdMH8JWlAdrzw4lXz7I5h15xFciGiB8fOjiWBrCLb4nwwQlNWx14JHTsDH+uzr6eqfNlckD6g34LL88hodv6MLFiTMNjI6jatjjdsZckOg/zhGWdjcdUX98dwDZW9bWfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373697; c=relaxed/simple;
	bh=iRtw0PD0pqEC79T3RkPtgL/EOPtP10TIm3l5nAmbOB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2TiXVqARFQvaxQAJco2aYd//57yrxpnPFxy/UNWXZbv7dl3Os2PB9ykHotRHCQNr+hX/qmUH93QbBWg3ZtxVZPJ9KvtFoqm4oyLf4YA7Nk1L4CJKH8ltfiquJc/4dtoAOI7QBmCWd+JkM2H3ZEUIG12WEoYTQQ1nV3BDHCBNVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gcx7b9pI; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-69b3d05e945so14356d6.2
        for <bpf@vger.kernel.org>; Wed, 17 Apr 2024 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713373695; x=1713978495; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iRtw0PD0pqEC79T3RkPtgL/EOPtP10TIm3l5nAmbOB0=;
        b=gcx7b9pIWkLTY1xnKCAsT14+yklQ3zHnCJz5JOQ0u9vr01HOHfJfDgqNdDqeBUCgg/
         StUpMO+9T/uPgjQsD7oyHDDDBycLv9ESroDxHdMGyPjBcgvl+T/INazQkhLVpyBIZgLx
         dXQH+CKGTz0c7CN5BeV9xgiFZu3puK8MXbjjcRT7+jFmHQHFePuJqEvpxBzKPGwXqrIE
         v+be0UJj5FgcqCfepMcqVMhKbqr76+8bUzzxX9sgkwj81bphPVdnWb2LErqxBw0UG/EP
         a9h/R4HgSqyIu78WLPP5Iw//Tqte877C7AHwKCANhgZiEn1Jp+O4qYoeTtsJWyhwTp0k
         nHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713373695; x=1713978495;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRtw0PD0pqEC79T3RkPtgL/EOPtP10TIm3l5nAmbOB0=;
        b=AUE9TCQSDAFryzA4G6hQW2wMyBVt+C6IgdtT44Zb1ZTYeIaLnSedZJRUjnjSv8VPmh
         7CkGxIloWOn0NHrupFCZYokb0WT38j2o/WLD+e1sw5myfiG7ZDeSHZw7XYr5I6kN2qcf
         pQxQGiC55MW+7EteGG6d3CeR+bjxWlGJY5QijOjqSHIGQQsGSOPk4ldffBOXaCEl5WTF
         C3IHCXrAggbcvnJeS5yYa+RusQQojsQmkU+wRO9wqzCjJYoyYrI/y3BLmQKo3nxEagcW
         Dlv5s5uyIhKncwRO9lLs7YmCTOLHSjx3bxSodGdDD6smNXuXxu+aWVz3nqsCXvXi1BQ8
         nHVw==
X-Gm-Message-State: AOJu0YwsjGZRAAuNM3JEIOhiQPFs5LGlYd6aeX67pc6VXBx4SQdlhsDB
	cc2yKQphemm1muULr34Y+XpCxpEsoSdLN+T1oa5neivT66bU7N8lDO7V2AryOeKTD+d5rjAmJ50
	Ki0WQZR2lRb8A4kNnVY2rQBR07ukhd99R7LLj
X-Google-Smtp-Source: AGHT+IG2Y5iRWo4rKZF44A3iPRLBeQj1ZErvXWZc390A2Sc/nwOidXThguhHixJBLW2/gOox20PY4kYZKYc8fhz0Xbg=
X-Received: by 2002:a0c:f8cc:0:b0:699:2782:d256 with SMTP id
 h12-20020a0cf8cc000000b006992782d256mr17022398qvo.11.1713373695048; Wed, 17
 Apr 2024 10:08:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412165230.2009746-1-jrife@google.com> <20240412165230.2009746-5-jrife@google.com>
 <3df13496-a644-4a3a-9f9b-96ccc070f2a3@linux.dev>
In-Reply-To: <3df13496-a644-4a3a-9f9b-96ccc070f2a3@linux.dev>
From: Jordan Rife <jrife@google.com>
Date: Wed, 17 Apr 2024 13:08:02 -0400
Message-ID: <CADKFtnQDJbSFRS4oyEsn3ZBDAN7T6EvxXUNdrz1kU3Bnhzfgug@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/6] selftests/bpf: Add IPv4 and IPv6 sockaddr
 test cases
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Artem Savkov <asavkov@redhat.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>, 
	David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> I would like to take this chance to simplify the setup.
>
> Does it need a veth pair? The %s2 interface is not used.
>
> Can it be done in lo alone?

I will look into this for the next spin of the patch series.

> Also, all this setup (and test) has to be done in a new netns. Anything blocking
> the kfunc in patch 2 using the current task netns instead of the init_net?

This should be doable.

> Add nodad to the "ip -6 addr add...". just in case it may add unnecessary delay.
> This interface/address ping should not be needed. Other tests under prog_tests/
> don't need this interface/address ping also.

Ack.

> Can the test_sock_addr.{c,sh} be retired after this patch?

I know it's not used in the BPF CI tests, but is it still used in any
other contexts?

- Jordan

