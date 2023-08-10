Return-Path: <bpf+bounces-7501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A50778374
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 00:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9B1281DE9
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 22:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DF325146;
	Thu, 10 Aug 2023 22:08:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3934A22F02
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 22:08:46 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5D22719
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 15:08:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-586b0ef8b04so18008707b3.3
        for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 15:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691705324; x=1692310124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bm4G8WH7EFl6vXS5gKnwIkRBObXYKsJHouh/rRIZO4c=;
        b=sfZSPEdmRM7KoFrBl6/wSdIOKSk4HifGoXeBPpJD7EcQf4Pi7lEoEW9PwQNDYZKc8n
         EbqtggVDwAzmMY64MGyyx0RCXozwMU+nyqeP0OWN47T3t+CsjwXNenW+QtgCIW8mmIcA
         zOxkdoV8KsAkqP3puL6cb5W0mZ2EQjbiP2qIT/F1dpuWbGCUZ0lQYDllIOIsOU54Q/dL
         t3A7pZhxaiyZc6anwvvAF+e77mMSU67pkE4MPYIf2fEWNHBfVomgorVSJJdYjP0X9rOB
         a1z7L59pllKR09G2WlsM6gdg2YfLuXqoxICdcyDRHfO0FIOD/6iIFM48S2LQWYc1P3UC
         HZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691705324; x=1692310124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bm4G8WH7EFl6vXS5gKnwIkRBObXYKsJHouh/rRIZO4c=;
        b=ipnurnq1UFCS46McFZwTbGJlCv5r1FKQPjoCgjWRDivqd7mPAVcvF9UVdDQjzkg10E
         MIudo2uGnJeWqnTlURfVkVUC5j7YbQJoJcvod6fnr9t33bOlYVnM3diH2G5Jiaw20+I/
         tQVAuVOl9lgcI/S3ooeeXz+qozGzgKOjAvCiTVuo0KatovryJxCPxRHlwT+S5IGqhi2K
         fOPOAvM8TbVPCptP+TXVcPaBOjU7ilxOrqNnU8yDMdhM1TSJGLCYm50y+0knpYH08OW3
         CABZoYBJ1zgMe1yDhSaPsHoAQ2yOobDkEYg7zu98PIDXqVZpOURH+oH0HiKGCUhohVGJ
         8WHA==
X-Gm-Message-State: AOJu0Yyq1JUXOl+lVKwyrM1NcPrZtBnjAnN7+GQvHRqPjKh+ApT1NYsx
	OD0yqlQnibCLLjxZnNygdYvfi30=
X-Google-Smtp-Source: AGHT+IGwmv+NTgklUJJcDZEVDARqwadRL2Cffkr9y8fnozGGxdX6UKET9hxQpCCI8saw3yJc22/qiNQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:af17:0:b0:583:4f82:b9d9 with SMTP id
 n23-20020a81af17000000b005834f82b9d9mr4216ywh.5.1691705324248; Thu, 10 Aug
 2023 15:08:44 -0700 (PDT)
Date: Thu, 10 Aug 2023 15:08:42 -0700
In-Reply-To: <20230810210945.100430-1-martin.kelly@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230810210945.100430-1-martin.kelly@crowdstrike.com>
Message-ID: <ZNVf6kHamI9awatB@google.com>
Subject: Re: [PATCH] libbpf: set close-on-exec flag on gzopen
From: Stanislav Fomichev <sdf@google.com>
To: Martin Kelly <martin.kelly@crowdstrike.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Marco Vedovati <marco.vedovati@crowdstrike.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/10, Martin Kelly wrote:
> From: Marco Vedovati <marco.vedovati@crowdstrike.com>
> 
> Enable the close-on-exec flag when using gzopen
> 
> This is especially important for multithreaded programs making use of
> libbpf, where a fork + exec could race with libbpf library calls,
> potentially resulting in a file descriptor leaked to the new process.

We do have fopen(, "re") all over the place; gzopen seem to pass mode
to fopen.

Acked-by: Stanislav Fomichev <sdf@google.com>
Fixes: 8601fd422148 ("libbpf: Allow to augment system Kconfig through extra optional config")

For fixes, not sure whether anybody actually builds libbpf from the kernel
tree...

