Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7975C3C6391
	for <lists+bpf@lfdr.de>; Mon, 12 Jul 2021 21:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhGLTWt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Jul 2021 15:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbhGLTWs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Jul 2021 15:22:48 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ED2C0613DD
        for <bpf@vger.kernel.org>; Mon, 12 Jul 2021 12:20:00 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id h6so24106071iok.6
        for <bpf@vger.kernel.org>; Mon, 12 Jul 2021 12:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=pIIm6AbmXiD/vyg2Vgajl2emWX7yF6AJRac9cHRTd6Q=;
        b=s5m1LxE17nMwkM6UWjjsXnkrVOUmD9ElW7LHZQYwlErg92PwO0mFHJ8j3XTzEYXEXp
         vaysQw3SmmqGI+9Hy8cm9Cefpuv5/YKH+kIKfWwmMYvFfLtnAD56H49xUSi++L8wbv1T
         XvxcBCfuR2cmWczjfK1YkmeeICLyAIvXtKDttHkkFujwJQC/KzHbheWZIfTW3HSj0gOT
         IqA1Sc3qOeMg0kTw+vJcTr/nCHyveYsDIsuiE8x6C8UbWkJkowz7K7tLffVZ6sWmc5Mz
         irxFZLSV24SiXRmxhnb3bYtjcb1S15K8M6MeOHSGe0YD47NLcENbYZk89GI6SmbBM9fp
         Hf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=pIIm6AbmXiD/vyg2Vgajl2emWX7yF6AJRac9cHRTd6Q=;
        b=U7k+agWwTYe+4MZ1I3zmc8pzf5o8SqPXoVkXsZ5TPkWsX2brvhaqUaMMvEBFllCpPh
         PwukqGcflLRVDfFNYhx4hjvwP4nXv9QBHSp++s9/Mkllj3PxTqUxKrOoMgukG85eSMJh
         Jn2n8yAbmxrViTL+VppBfmPxbCLClu0SH6OyElNBaVzzBb6qmimiOP6GVh48jnRgd3gX
         jHEj0PyuKpaIs9UzkcQdNiUFySF8YkQyfy4znZ/fg41zVxRvFSZzJu8x8Y+xjwM84Buq
         PxrUlD3Kou7eVt27ejCdNlxCvkl+T3QOvwamxZ95ilOmD8Z79grjTmy9EoAhXsznVfzQ
         SXJw==
X-Gm-Message-State: AOAM530Q36OZ0hT8kWHRyRUBR16GPmB4pU2euVNWlj3/2kER81JnTfdY
        cC1EdA2MJK9JdVuHvxY5wf4VLVoKp9Et8g==
X-Google-Smtp-Source: ABdhPJxNaWXHa/dHfxHgLsteFUC3y3sYURWbtsBC4a1ZB+EhQ77I3jiE6IzKxazoRu+FtVRZ4OesSg==
X-Received: by 2002:a6b:d109:: with SMTP id l9mr380724iob.122.1626117599712;
        Mon, 12 Jul 2021 12:19:59 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id b3sm8388183ilm.73.2021.07.12.12.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 12:19:59 -0700 (PDT)
Date:   Mon, 12 Jul 2021 12:19:52 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Martynas Pumputis <m@lambda.lt>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        m@lambda.lt
Message-ID: <60ec95d89c590_50e1d208fc@john-XPS-13-9370.notmuch>
In-Reply-To: <20210712125552.58705-1-m@lambda.lt>
References: <20210712125552.58705-1-m@lambda.lt>
Subject: RE: [PATCH v2 bpf-next] libbpf: fix reuse of pinned map on older
 kernel
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martynas Pumputis wrote:
> When loading a BPF program with a pinned map, the loader checks whether
> the pinned map can be reused, i.e. their properties match. To derive
> such of the pinned map, the loader invokes BPF_OBJ_GET_INFO_BY_FD and
> then does the comparison.
> 
> Unfortunately, on < 4.12 kernels the BPF_OBJ_GET_INFO_BY_FD is not
> available, so loading the program fails with the following error:
> 
> 	libbpf: failed to get map info for map FD 5: Invalid argument
> 	libbpf: couldn't reuse pinned map at
> 		'/sys/fs/bpf/tc/globals/cilium_call_policy': parameter
> 		mismatch"
> 	libbpf: map 'cilium_call_policy': error reusing pinned map
> 	libbpf: map 'cilium_call_policy': failed to create:
> 		Invalid argument(-22)
> 	libbpf: failed to load object 'bpf_overlay.o'
> 
> To fix this, fallback to derivation of the map properties via
> /proc/$PID/fdinfo/$MAP_FD if BPF_OBJ_GET_INFO_BY_FD fails with EINVAL,
> which can be used as an indicator that the kernel doesn't support
> the latter.
> 
> Signed-off-by: Martynas Pumputis <m@lambda.lt>
> ---

LGTM.

Acked-by: John Fastabend <john.fastabend@gmail.com>
