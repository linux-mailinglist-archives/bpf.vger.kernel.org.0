Return-Path: <bpf+bounces-10504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A3B7A9055
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 03:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC72F1C209BB
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 01:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893B5A55;
	Thu, 21 Sep 2023 01:02:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796CD800;
	Thu, 21 Sep 2023 01:02:30 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54810C9;
	Wed, 20 Sep 2023 18:02:29 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-54290603887so254915a12.1;
        Wed, 20 Sep 2023 18:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695258148; x=1695862948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p2psVloYgvi7Yt+ex8SpTvRefb+xAylMcLN4klxRT/U=;
        b=JcHjgxh83WBpUgiI5W68HjbI51tQ11Km02fu+XETMZIJWR+Z+HCCjiFMKHZoeOZ4H/
         sX6LCx9wuQrMSGSIr4SZPZ8g4z4GfJMfhMXrM9ZXLrbHh5yAp6nP4Je7vEZGirly6eRR
         ShH3ZZwQvXtJJkNqYHQIWEXzojoRTI7mwubRFhZMXImtcf0bS+fLcNBREAAoajPgukDx
         LQh3E5thrHtxqDG4izY+z4G0ipG6D69KmUfh6mmEgtOoBwmvXQCDGXx3cJK8aSi7cZGc
         L/0YwEydlVizf4MYM1L4XcToX4Q5T2tjirdNyBv05nhKPnYO4+3njguuE+OYp+uRpF+z
         2GYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695258148; x=1695862948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p2psVloYgvi7Yt+ex8SpTvRefb+xAylMcLN4klxRT/U=;
        b=Cu5R8eMVANICX+q1PC+UUL7bCmuDv6oMD8no4h4UAf4EBmqLpSKhyN5UOL/dd6awj4
         unH48qBh9D34K6f7PUqexaoVHsm1YmItjW5Y/lfY4mhwu6sUelCevR3c/zHQ6z9xmeQI
         1uYAgSbrPaI3hg1MVo6qyv+WbQw4c6E86W4edc/2FW9hdC627Yjaopal+aIkI4wZ/VMx
         1KuqxbwmdxYffCVpQ6UvinWS7HsStEydSZkWB35NYCDJOfs1VWbKPRjywH8mzch1wyzz
         bP5fpVKJOg8y26DUIBwjXNxJ/hW7cdVi17qJpO2OxAZsmVoTbPQxi5TZ6Jr9eUh8nVu5
         BGIA==
X-Gm-Message-State: AOJu0Yxir5AO3jS7PVQYNznSTpPIrno2N5ENcLRE3OFfx1D89kOWR+b0
	xbDfCXlLe18hIkqaN5x9TIZ15OhPltgsPl104gc=
X-Google-Smtp-Source: AGHT+IGoaues0OO6GX0PR/Mbjoh6YZbH089Kh6H3mHaNzYk6YWBD1DX2CU/EvvBUf2soBD2cDRp7NYxiCzUXO3ofwbQ=
X-Received: by 2002:a17:90a:6d23:b0:274:8ed5:6b4d with SMTP id
 z32-20020a17090a6d2300b002748ed56b4dmr4015012pjj.11.1695258148537; Wed, 20
 Sep 2023 18:02:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230920115855.27631-1-linyunsheng@huawei.com> <20230920115855.27631-6-linyunsheng@huawei.com>
In-Reply-To: <20230920115855.27631-6-linyunsheng@huawei.com>
From: Dima Tisnek <dimaqq@gmail.com>
Date: Thu, 21 Sep 2023 10:02:17 +0900
Message-ID: <CAGGBzXLu7rO4bTet0wqb2Z7FmqsSu0BVuVw_LprcJcPKO1vXEg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 5/6] page_pool: update document about frag API
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>, 
	Liang Chen <liangchen.linux@gmail.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Eric Dumazet <edumazet@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, linux-doc@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Minor comment on natural language:

On Wed, Sep 20, 2023 at 9:04=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> As more drivers begin to use the frag API, update the
> document about how to decide which API to use for the
> driver author.

the fragment API

> +/**
> + * page_pool_dev_alloc_frag() - allocate a page frag.

allocate a page fragment.

the precedent is set in
https://www.kernel.org/doc/html/v5.0/vm/page_frags.html
foo_frag is used in C code, and foo fragment in English docs.

