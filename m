Return-Path: <bpf+bounces-66457-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F504B34CBA
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 22:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504F118979CD
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 20:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCC6298CDC;
	Mon, 25 Aug 2025 20:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFpOFneT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8391DE4C4;
	Mon, 25 Aug 2025 20:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756155079; cv=none; b=EJrjln7Q2py3PSFsj7pKp8NG1C8lUxMlZC9Rt6jj8ubBIShB3nqNfhEg8dMFplGLs9ZIdmnsLFJ26JVvLfUnfEXtUTgOBwwbNcsx3QWcmpX6em0u+rqdOBXeOYNwq42V8fTN09TyUOpHgZGGwRn2qNcOk3tYiaAj/IYhM6wJZx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756155079; c=relaxed/simple;
	bh=nS0SrknC+UZqtJTUPNoE+faUezKY7lJZHdlP+kuOgh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7UeNj04j4IAs/FuA4UFsTdWsRbuP6FlokS2QNdGcIvgNlPj+5HAQa4LR79cgjqN/SVBy0Y12ExGtSS7A5zpcsd64KUmgNvw0BfQokEUxzZzjunvegkavyHQugqBlkyl6hcwNyyLOd8TwnjPBwgLN4LhHvVIEwqzpB+g3ogZlCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFpOFneT; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2eb6d07bso4130696b3a.3;
        Mon, 25 Aug 2025 13:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756155077; x=1756759877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wAylyOp5FQc+WiTlWvLgCB3Lhs64/nbRQijPVDFnouc=;
        b=CFpOFneT0DGPfjZbDoMRZQMy1HZMDAaCPtT34Uxk0uGJxE+lBQxCHuNutBy61Ej9nd
         uIWlNFM4VCnMGbr+YWwU47424KIxUjYivDok168ryve0E5mGJdCW5Y/FLoRdwBFSaCPg
         HK9dooVcJmS+jx/8x19rx/lgPnrjiXvmjpTPi3JeKDpZY9nr5oA3XXUKu1bOVFmy9mhe
         qccD1fI4DngGMs4vhds9cji6Cs301f8nFi2WZjThVmpjswFBgulmVpSAfki+DgJmZ8dJ
         jjbDMCf6nyt+fwIzLnunUpW1NSxfxHlOlMaFPurhrl3g5nalhdWeW2aRm/CMMirTRdTg
         +UwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756155077; x=1756759877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAylyOp5FQc+WiTlWvLgCB3Lhs64/nbRQijPVDFnouc=;
        b=xH2EZlya1tATwIsfY5JRiIpLy5b7sfGe1QteuMW8FGTL364jcK/RXdvf8p8QqmdIjU
         21r2Us1Aj/4/zbfbHan8xoUxLdfuJ4ZvTGm1Kqd6lPsLe9Tl/zdpSPU63bRwy0qFizAs
         5cPwbbbh/YjpbO4Yk41NOSorVdC/HtLQlJsndxx2pYb6oWuiwckMmiEMLOFUdPjhdpH6
         cEGnkqJV8VJjOyxRKfex8/C8BSy256yAf7Xn2X1mMvZpr+KcG5ADaXBS/yTkCOZmMIhK
         ora55lGHFFe3jEtSvLCXaftYkgnuRkUaGwR+zK9jOF2pJymjtv4al4VakD7HshREupmF
         HjXw==
X-Forwarded-Encrypted: i=1; AJvYcCUoQlvtp+OkJkIMQ/2GifL92r8RZlHeSjgKDpYk9Mjf4klyhthwbOVr816DssTqv4uvI7W1FXd+@vger.kernel.org, AJvYcCWnEku+Di2e6XtxHOoGF7j/gNaCiyRlzLQEHjQXvqK/TCDKuwxGPnt4KLac+KW9ZlTapG8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4yEC303iCVm5FVwVOvoh1EamcNHPQ+gm/cBeFKtlX/COrZkOI
	zPvu95ezT6fITf28yw3Fuc45Xpzx1k0CNSIQAqdxK/7cWeSpU7CszFg=
X-Gm-Gg: ASbGncus1wJlBSRHJWgoOUpjKEFT27zMywzNNa68HYSRzOrq28iagWBDoAj/9K1BUuk
	Phdr2OmC9vOFIoqlodjwyPytltUZApILAWmJ6RwrHyx7jJxAkUpvGlZwG0Cjv9zcmWpJzhAj7+/
	h+KYFQkEuOXoIJOeJWgWfLy9xMhji+aalsImYqqHdHW56p7E+hhiRKBuC7gA5w/HqL1VzsK5eqL
	DsuMfiE+/9XuFja/UyaKvEwUA8pBYvO26nvxoqfyzHd+S48bhoiQojvVeTJxP74ZYpJFOPvoCPw
	aWTwwU+DzhVAS4tJAXxqSfpZlSECQdPNvsALa2VgKFc6mJP2y6NFfFzKlLCFrkymLac/pMrMDj0
	F3/QPxd+6nrt9+gIytmbJlikThmNQ6fxF9QUPzQNmW8eH4+7MEKX+GoANgVSbUjWs8904pavfb4
	AExBtPnmjaE0DOVHfYzbWg84FaXTKEauWdS86VEjsI/0/Xa200Uz6oLUtbybyRJZzlhpyLUb2Kp
	K0K
X-Google-Smtp-Source: AGHT+IG8h1TycEJE6i4EPqfv3OiAimNTg1Vg9H/FbRk929wHroZkBGGpAP/t7RGAV8gObl3GnVym2Q==
X-Received: by 2002:a05:6a20:3945:b0:243:78a:8297 with SMTP id adf61e73a8af0-24340e06898mr21516322637.48.1756155077028;
        Mon, 25 Aug 2025 13:51:17 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b49d48ebe53sm6092577a12.53.2025.08.25.13.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 13:51:16 -0700 (PDT)
Date: Mon, 25 Aug 2025 13:51:16 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next/net 2/8] bpf: Add a bpf hook in
 __inet_accept().
Message-ID: <aKzMxKViOGjxFhiW@mini-arch>
References: <20250825204158.2414402-1-kuniyu@google.com>
 <20250825204158.2414402-3-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825204158.2414402-3-kuniyu@google.com>

On 08/25, Kuniyuki Iwashima wrote:
> We will store a flag in sk->sk_memcg by bpf_setsockopt().
> 
> For a new child socket, memcg is not allocated until accept(),
> and the child's sk_memcg is not always the parent's one.
> 
> For details, see commit e876ecc67db8 ("cgroup: memcg: net: do not
> associate sock with unrelated cgroup") and commit d752a4986532
> ("net: memcg: late association of sock to memcg").
> 
> Let's add a new hook for BPF_PROG_TYPE_CGROUP_SOCK in
> __inet_accept().
> 
> This hook does not fail by not supporting bpf_set_retval().
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

And similarly to [0], doing it in sock_ops's BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB
is not an option because you want to run in the process context instead
of softirq?

0: https://lore.kernel.org/netdev/daa73a77-3366-45b4-a770-fde87d4f50d8@linux.dev/

