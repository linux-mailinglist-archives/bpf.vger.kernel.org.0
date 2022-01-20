Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3937C495466
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 19:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbiATSti (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 13:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiATSth (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Jan 2022 13:49:37 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4205DC061574
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 10:49:37 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so16067227wme.0
        for <bpf@vger.kernel.org>; Thu, 20 Jan 2022 10:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=PjKjTy7eKMFmfv+qinocmQZR2jNJN1JZ8w0q2u47Vn0=;
        b=paUwrbhZpOFOr2xyR2soJ0kAo/nNbfubVkLwUSz83Sz4q100u/2m+ldwyqhvP4+ibh
         LJoQv0pBDZkkBmEmGsTXanXgsY+pbr6Om76/tzDmzfEm+K9YhcvY/MNq/9r77Wq6PE84
         hDH5fDVjTO2RdutpFbmeFsHefNlQ4X2AqM/DU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=PjKjTy7eKMFmfv+qinocmQZR2jNJN1JZ8w0q2u47Vn0=;
        b=ov/DEAxq3Fa4co8lwiXMSjn0efJgFA5PTVtCevDUPs+9xEXJfmtT+458rXnTdoag5h
         t/PHaxvZ5HNLQEaZgqqDNnkGmetnTVrnItkPLuo8IFGU4lEJn0AP+iIy/yConzel1bmA
         b1QsyaCDf9H2YwQzLnlp67bmZ330zIyz2Ge2pAioracOzeog7gVDwFz2EJlN+9fLthUP
         CtkWRwpFdn87EIoh8JQk6mYmikZHK0GZUPFMvU8Df46wK2cGCHlLN+qyAQaE+iYz1TG7
         MozdJX9Y5dCLxLFxN3znzcL8wE6h1UjneEqQzjanRSRGgzWHC4obpg+NjEfn0EOsRXow
         HPmQ==
X-Gm-Message-State: AOAM532ojcqV2GiXeJ8+drPSXg4JjLwz9VZTMuVqGmW+1HzvcJJCqoBL
        KB5V9+CKcv7WK7vJF61oYq8PBw==
X-Google-Smtp-Source: ABdhPJy/33XhjLc483J2fGdR8q8hYcr38yxjUVZuY1FCf5UdwYkL+OsJLlJHmPsW6ujinOgXviu0Gw==
X-Received: by 2002:a5d:47ad:: with SMTP id 13mr358168wrb.545.1642704575807;
        Thu, 20 Jan 2022 10:49:35 -0800 (PST)
Received: from cloudflare.com ([2a01:110f:4809:d800::e00])
        by smtp.gmail.com with ESMTPSA id p8sm3781641wre.72.2022.01.20.10.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 10:49:35 -0800 (PST)
References: <20220119014005.1209-1-zhudi2@huawei.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Di Zhu <zhudi2@huawei.com>
Cc:     andrii.nakryiko@gmail.com, ast@kernel.org, davem@davemloft.net,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, luzhihao@huawei.com,
        rose.chen@huawei.com
Subject: Re: [PATCH bpf-next v6 1/2] bpf: support BPF_PROG_QUERY for progs
 attached to sockmap
In-reply-to: <20220119014005.1209-1-zhudi2@huawei.com>
Date:   Thu, 20 Jan 2022 19:49:34 +0100
Message-ID: <87wniunsxt.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 19, 2022 at 02:40 AM CET, Di Zhu wrote:
> Right now there is no way to query whether BPF programs are
> attached to a sockmap or not.
>
> we can use the standard interface in libbpf to query, such as:
> bpf_prog_query(mapFd, BPF_SK_SKB_STREAM_PARSER, 0, NULL, ...);
> the mapFd is the fd of sockmap.
>
> Signed-off-by: Di Zhu <zhudi2@huawei.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---

Thanks for adding the annotation.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
