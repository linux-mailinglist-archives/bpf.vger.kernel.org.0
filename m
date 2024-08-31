Return-Path: <bpf+bounces-38653-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F4E966F17
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 05:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973801C21DCE
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 03:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762426F2EA;
	Sat, 31 Aug 2024 03:29:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173CB2F2E;
	Sat, 31 Aug 2024 03:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725074949; cv=none; b=ee2uPvGRpsy+IrZM/1+k7A38SY4gb2tC5is03X27Z4448333GzRv3uIGfi7x5vu6W/23AAg1XnwTX9Pz+OKj7DrzHXxlapXKHwRlDwCCpo4/cheLuku7j+M9drBF7qK469DK64UCmS6GuHFoL5Sng4dbHMDWJZSY93u00+XvOxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725074949; c=relaxed/simple;
	bh=i09h7pVzWa6OCZm6rAC982LxyrDslBxDFkPhuofomjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lFJDPXFGsXwmCVqdsGRKH3OkajTEClaux/5BTIVaiuS+XpyfBqigQbT0pRRNqgQvg6CFGOKJNBtnbRSRIB0k1BH5oexOwHMG1qJohgNozOJqITkvZe6GsdOEjKkAE7k4kHGIA21+n5NS/JE6ECkaATq/z9GIzUsKk2jIlClMktg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-202146e93f6so24581115ad.3;
        Fri, 30 Aug 2024 20:29:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725074946; x=1725679746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmUNI7dopbgPT4zjvSEr3dpJrjim6ozHINXa3gY07bw=;
        b=A6NFQbRj8eRoYqG6QzKLIAT+2WiYkxxaaAkYUtWmgKb4rgC1mudsJDWBSd/bZQI/an
         wFAy93SgOcraHIPHVXMJBvLxY8+di8zQgI36bBQiL7Mn366ryoTV4wQovf1WZh/8xLmK
         n1bVWJvAy1AjL3CAng2wM6m+k4tIQq4x57RAX6X+I8VW0moU4lQ5ODjLXoQAb9hVMpne
         zTODwJRzLSxT+gbWmdnWnGtlfGZU+BWlaRqqYJaglRnKRohWqD1w7PSON3FYyNmUVf2B
         DD04rCMSCIZawD3RJsvtH7N9q3WHvDDC8PocA4Ng/jvbBLrxJ8/7OzaWGRktYHHLwnch
         wryg==
X-Forwarded-Encrypted: i=1; AJvYcCUcBBd/VaAd3eJviZhyPMFN8cgL8Se3yAe6MjyjyPa453OCn8GDBAFjqp7rUqZsKgWvJS0=@vger.kernel.org, AJvYcCW9m6lIuodtsOQYWek24tFXKUmVcz49F3xrF04skXkCqL0FhdJT+ogWkqidpt/o8tP7qdDr6+gAwG7ws0nj@vger.kernel.org
X-Gm-Message-State: AOJu0YxRkEnpO6mgjAS4cXvF208jixhvtdiXvdxuFRw5GtyjPIEqCd5u
	TwTT83T7UWJ2hhljpK00sZgp9wWMhi+WvQuT+iZmT81mS40MDFg=
X-Google-Smtp-Source: AGHT+IHd6g6pyez/8oZoyMFdR/yCZyTkS9LN5xXtI/s4MBHHHdVw0Q6ZuduT6Yegky8Pq/nfuJhkGQ==
X-Received: by 2002:a17:902:d486:b0:202:2a38:f9f1 with SMTP id d9443c01a7336-2050c4bc469mr90250375ad.58.1725074946166;
        Fri, 30 Aug 2024 20:29:06 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2054baf1423sm2147985ad.175.2024.08.30.20.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 20:29:05 -0700 (PDT)
Date: Fri, 30 Aug 2024 20:29:04 -0700
From: Stanislav Fomichev <sdf@fomichev.me>
To: Tze-nan Wu <Tze-nan.Wu@mediatek.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>, alexei.starovoitov@gmail.com,
	bobule.chang@mediatek.com, wsd_upstream@mediatek.com,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>, chen-yao.chang@mediatek.com,
	Yanghui Li <yanghui.li@mediatek.com>,
	Cheng-Jui Wang <cheng-jui.wang@mediatek.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v5] bpf, net: Fix a potential race in
 do_sock_getsockopt()
Message-ID: <ZtKOAKlNalVLIz2E@mini-arch>
References: <20240830082518.23243-1-Tze-nan.Wu@mediatek.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240830082518.23243-1-Tze-nan.Wu@mediatek.com>

On 08/30, Tze-nan Wu wrote:
> There's a potential race when `cgroup_bpf_enabled(CGROUP_GETSOCKOPT)` is
> false during the execution of `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN`, but
> becomes true when `BPF_CGROUP_RUN_PROG_GETSOCKOPT` is called.
> This inconsistency can lead to `BPF_CGROUP_RUN_PROG_GETSOCKOPT` receiving
> an "-EFAULT" from `__cgroup_bpf_run_filter_getsockopt(max_optlen=0)`.
> Scenario shown as below:
> 
>            `process A`                      `process B`
>            -----------                      ------------
>   BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN
>                                             enable CGROUP_GETSOCKOPT
>   BPF_CGROUP_RUN_PROG_GETSOCKOPT (-EFAULT)
> 
> To resolve this, remove the `BPF_CGROUP_GETSOCKOPT_MAX_OPTLEN` macro and
> directly uses `copy_from_sockptr` to ensure that `max_optlen` is always 
> set before `BPF_CGROUP_RUN_PROG_GETSOCKOPT` is invoked.
> 
> Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
> Co-developed-by: Yanghui Li <yanghui.li@mediatek.com>
> Signed-off-by: Yanghui Li <yanghui.li@mediatek.com>
> Co-developed-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
> Signed-off-by: Cheng-Jui Wang <cheng-jui.wang@mediatek.com>
> Signed-off-by: Tze-nan Wu <Tze-nan.Wu@mediatek.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

