Return-Path: <bpf+bounces-10047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA2D7A0ACA
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 18:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3863E281D21
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 16:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE57422EE4;
	Thu, 14 Sep 2023 16:30:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B89210FE
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 16:30:00 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F511FC7
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 09:30:00 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59bcabc69easo16864157b3.1
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 09:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694708999; x=1695313799; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dQCQk6YHT4w1SIaBM4T9wkvVdHTFYqU+yaXty3zQMig=;
        b=IiH9liIRKJ97IxiSPDF9vPtG2AX4Abn0cKh/6I5+hxw88P0pOY8r7oq+W+P0ivR1Fu
         ihqlkVQSMb3YIg/z7y29uw8a0b0NOLXS2jNBnXIDjxtjxl3zax5T2cp1kmt5Wh1/DJVk
         KOGEKS4O/kqJqVa9uFSmcgn1KFdLVUSDlQmL/kxVF+SuxBl3gBFbr7tYxkqyH8d1g74N
         weLTPOPvnHFMMDgS9hRwNs9KuduVC7HUXGiALe8y4nromLIyeMlK1smi1KUNZMHk3bde
         HEccdISO0eXpLfibz4q01OWc4d91JEc+ujFh4Cu0qKfJxHCibktz2Fgqw4apgshALO7C
         Wm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694708999; x=1695313799;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQCQk6YHT4w1SIaBM4T9wkvVdHTFYqU+yaXty3zQMig=;
        b=CH8WXvZalXmNR+fzm0Dg0Y9tISFurHvui8apydMGaJK3KDoRPhd/brmvysCZMwjZ0l
         SwtPPIo/3yFS6P3/6q0d60uZilEg5IdpBbr78mqIDnFFjOpe2KcwOtnVgrK4RRBCx6lJ
         vlaCL9r8D8KNwQNpoq2qoqAIhiGBsJRvwvBmhiA27oJxrpZ7rfpePCG/GDuR14lMALFs
         FBWbWqZ81LSMCspw40rYQ1WCUNPD+vJi2a+WKKZAnaA0f9VghuGlKc7eOGTJVyRZYe5D
         VLqP41VAWqDUemIhgYpFUN7PbWxnP0nsFrciJiF2lyTw7p3CBd+YV3idkHX7cAq9V4QH
         facw==
X-Gm-Message-State: AOJu0Yw324EEKExyVvfFjmIhfO5alW7LBGwSTng+PvisbIIRao+myKrD
	xLMukWHp/vjm53+If0dAzhaSyv0=
X-Google-Smtp-Source: AGHT+IGLCdlQ6DhH2Nk720lughqWhXXVD4XHhWXzQhzNhM9o8Wnl99nkGz1gI3OlF0PdydA1el2ozHw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:b56:0:b0:d7f:8e0a:4b3f with SMTP id
 83-20020a250b56000000b00d7f8e0a4b3fmr129121ybl.3.1694708999121; Thu, 14 Sep
 2023 09:29:59 -0700 (PDT)
Date: Thu, 14 Sep 2023 09:29:57 -0700
In-Reply-To: <20230914083716.57443-1-larysa.zaremba@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230914083716.57443-1-larysa.zaremba@intel.com>
Message-ID: <ZQM1BUzcZQtXusA3@google.com>
Subject: Re: [PATCH bpf-next] bpf: Allow to use kfunc XDP hints and frags together
From: Stanislav Fomichev <sdf@google.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On 09/14, Larysa Zaremba wrote:
> There is no fundamental reason, why multi-buffer XDP and XDP kfunc RX hints
> cannot coexist in a single program.
> 
> Allow those features to be used together by modifying the flags conditions.
> 
> Suggested-by: Stanislav Fomichev <sdf@google.com>
> Link: https://lore.kernel.org/bpf/CAKH8qBuzgtJj=OKMdsxEkyML36VsAuZpcrsXcyqjdKXSJCBq=Q@mail.gmail.com/
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  kernel/bpf/offload.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
> index ee35f33a96d1..43aded96c79b 100644
> --- a/kernel/bpf/offload.c
> +++ b/kernel/bpf/offload.c
> @@ -232,7 +232,11 @@ int bpf_prog_dev_bound_init(struct bpf_prog *prog, union bpf_attr *attr)
>  	    attr->prog_type != BPF_PROG_TYPE_XDP)
>  		return -EINVAL;
>  
> -	if (attr->prog_flags & ~BPF_F_XDP_DEV_BOUND_ONLY)
> +	if (attr->prog_flags & ~(BPF_F_XDP_DEV_BOUND_ONLY | BPF_F_XDP_HAS_FRAGS))
> +		return -EINVAL;
> +

[..]

> +	if (attr->prog_flags & BPF_F_XDP_HAS_FRAGS &&
> +	    !(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY))
>  		return -EINVAL;

Any reason we have 'attr->prog_flags & BPF_F_XDP_HAS_FRAGS' part here?
Seems like doing '!(attr->prog_flags & BPF_F_XDP_DEV_BOUND_ONLY)' should
be enough, right? We only want to bail out here when BPF_F_XDP_DEV_BOUND_ONLY
is not set and we don't really care whether BPF_F_XDP_HAS_FRAGS is set
or not at this point.

