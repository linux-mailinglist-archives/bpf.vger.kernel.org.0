Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D800E3413
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2019 15:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387516AbfJXN0B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Oct 2019 09:26:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387483AbfJXN0B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Oct 2019 09:26:01 -0400
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 795F3C049E10
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2019 13:26:00 +0000 (UTC)
Received: by mail-lj1-f198.google.com with SMTP id w26so4018313ljh.9
        for <bpf@vger.kernel.org>; Thu, 24 Oct 2019 06:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+ZpJtPYK8YP0WE7ZBrQ7oSDcwMJnV8kp7n/BALIslZE=;
        b=Z56TipRXMDaji111Q5jF2k9tQWd6AKPdk8jdvw9ikukLa/TvuHxjgB2vPqDg+3WyA6
         uurOcxqcGNNd8gmd3CQ1fB0UUPoBvEdcN9E8DPocQni4LOCY0Sft/xZP1OIlusgORKQs
         EejNx3Q+7xc9AQ16QTMe5Nz1YYeOqP8XcTebODPW5CgRQE2QLy/NBbRFyJjLuqvnIS9y
         YghlEmFr+/beyu58b1eLJW5yskM4Fm0/svIR1ulzdL1auAPj9SsumLWd8LKzQxAf4a4m
         AYbRmPPBSTbi2YPrI7YSyQ0UsxiM9XWVJHvU5OIHVpQjfpdMRSXRp4Y5+QrckpCmy6Dp
         vLaA==
X-Gm-Message-State: APjAAAVu0DtGwwByJOD9x7NhT11Fj9Wl6oG+pNAW4ZGj9al+CztpYNpx
        lE6NKRUqiCaqjiVD3zNTo7OZ+bgJLWO3qehyT1mwqetLE42FwGpLzpf02iZnDACE0wNPOTM3fqo
        WJ5l9HkcqEZsS
X-Received: by 2002:a2e:7212:: with SMTP id n18mr2281739ljc.246.1571923558845;
        Thu, 24 Oct 2019 06:25:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxtE53w17ZF5FP6OkovcF6gQ3sVTn0QZi+tjbcw9ZRpu5zHatsousFIR6buOuIn4nGuzDDwTA==
X-Received: by 2002:a2e:7212:: with SMTP id n18mr2281727ljc.246.1571923558666;
        Thu, 24 Oct 2019 06:25:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id f22sm10509317lfk.56.2019.10.24.06.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 06:25:58 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 244971804B1; Thu, 24 Oct 2019 15:25:57 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 3/4] libbpf: Support configurable pinning of maps from BTF annotations
In-Reply-To: <157192270077.234778.5965993521171571751.stgit@toke.dk>
References: <157192269744.234778.11792009511322809519.stgit@toke.dk> <157192270077.234778.5965993521171571751.stgit@toke.dk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 24 Oct 2019 15:25:57 +0200
Message-ID: <87h83yl1ga.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> +int bpf_object__pin_maps(struct bpf_object *obj, const char *path)
> +{
> +	LIBBPF_OPTS(bpf_object_pin_opts, opts,
> +		    .pin_path = path,
> +		    .pin_all = (path != NULL));
> +	return bpf_object__pin_maps_opts(obj, &opts);
> +}

Hmm, seems I forgot to pull before sending; this should be
LIBBPF_DECLARE_OPTS now. Will fix in the next version, but I'll give
y'all a chance to comment on this version first :)

-Toke
