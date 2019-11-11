Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0605F7EC2
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2019 20:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfKKSjX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Nov 2019 13:39:23 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42375 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbfKKSjU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Nov 2019 13:39:20 -0500
Received: by mail-pg1-f193.google.com with SMTP id q17so9951350pgt.9
        for <bpf@vger.kernel.org>; Mon, 11 Nov 2019 10:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=0Mu4udifMW2tdEjG6UYU2zT+RxK9F/wgdArkhXdHLKk=;
        b=Wz88+p3XFfPbBq2jkfD75pN1azkIyYcRgohl37Bo8NUOwmW5K5ilJS+O8lA0ThFV48
         Nk+WAltH90XO24/CKTHW5Rxm/L5euGHmIVXSp3sbw1tFboUtCdwUL962rIy9lJE+2qci
         atdgIpcx6EONK9ZUWm40teQepN/o082ib5f6dkIuqdsE4s2Ri3DE2aXY9k9shs7SxkgW
         B7lGDS2dxHmPVv7YyqcCAaUJ4QRoX3AFxGVoysOdaszyfmpFU7pz+G9IloDNx6JmcqfP
         G4HArcPt7Ss4EYPoyla8yw0GVe5VQlFFuOzA9ObmlmbdDzt0ZXJ2NgoqHWR/0AdOO3Sc
         xtjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=0Mu4udifMW2tdEjG6UYU2zT+RxK9F/wgdArkhXdHLKk=;
        b=pp375aCtTQ96ROtdkkKQ72Tut5Qgj5F8ZO4IJ89LsglEQUrIBFI6qyigjpHkaiR5W0
         3MX/Nq0QlHoZTTg4lrIDC2bE1HTf0nYVQnC2Hu0yRa0IwKluD7BbVP6MigU5J2krUAtW
         +bJpLJyIDK27imgNpQnk2sltWaLqV+2cIzH+GMdk5nUQMGgjorBxFd2jqpfsJVPqhZSf
         Dj1apZ6SZcCsH95Gw31lG+E1stL55W9RBajyCrwXTdqqFF7597vLJvlWw3DgTJ3RR9k4
         Bhzr858WZ28Y0X6f2Jqqt0sKBT0F4sxpSVftcO27HfcPZBEktxbZF8iW8chDNSQeLHO3
         vN5Q==
X-Gm-Message-State: APjAAAWp8+2lacOcfCKWjLdThv/b33F6cKTodI9Vwza8fb0EOsl5SykY
        2wAYzEyQ2YcU95AURRsK3zxZpQ==
X-Google-Smtp-Source: APXvYqyNKEVZUi7PkBOrunPMI8En5eOdd1G4iqdJWGFXePrC4G6pZaQFPJ7LpNqvBvf7JnFw2pn6JA==
X-Received: by 2002:a65:620d:: with SMTP id d13mr31242730pgv.64.1573497559352;
        Mon, 11 Nov 2019 10:39:19 -0800 (PST)
Received: from cakuba (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id h3sm1671026pgr.81.2019.11.11.10.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 10:39:19 -0800 (PST)
Date:   Mon, 11 Nov 2019 10:39:16 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <ast@fb.com>,
        <daniel@iogearbox.net>, <andrii.nakryiko@gmail.com>,
        <kernel-team@fb.com>, Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 bpf-next 1/3] bpf: add mmap() support for
 BPF_MAP_TYPE_ARRAY
Message-ID: <20191111103916.0af3ac5b@cakuba>
In-Reply-To: <20191109080633.2855561-2-andriin@fb.com>
References: <20191109080633.2855561-1-andriin@fb.com>
        <20191109080633.2855561-2-andriin@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 9 Nov 2019 00:06:30 -0800, Andrii Nakryiko wrote:
> @@ -74,7 +78,7 @@ static struct bpf_map *array_map_alloc(union bpf_attr *attr)
>  	int ret, numa_node = bpf_map_attr_numa_node(attr);
>  	u32 elem_size, index_mask, max_entries;
>  	bool unpriv = !capable(CAP_SYS_ADMIN);
> -	u64 cost, array_size, mask64;
> +	u64 cost, array_size, data_size, mask64;
>  	struct bpf_map_memory mem;
>  	struct bpf_array *array;
>  

Please don't break reverse xmas tree where it exists.
