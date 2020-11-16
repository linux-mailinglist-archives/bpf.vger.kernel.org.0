Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8A92B4660
	for <lists+bpf@lfdr.de>; Mon, 16 Nov 2020 15:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbgKPOuC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 09:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbgKPOuC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Nov 2020 09:50:02 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019BBC0613D1
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 06:50:02 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p1so18943484wrf.12
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 06:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=BPCLhabsRwKbkxxHaDPISDFulyGg56yfLX643YNXiJI=;
        b=SVa+P6UJKaAUuC40crd8bYpmh57hhWqyH6kuJM6H02bEsOA3hohY9w7B6Du6yEE1ba
         EhN509KkgOKXE5BT8/k8YoVr4gh+gqF0k386xsaY271t95SsJO3QW0YxhCVl+QRuF2Ue
         XCsyldoqhR7PFIofV/NR5p+s0B/M03M5RCDZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=BPCLhabsRwKbkxxHaDPISDFulyGg56yfLX643YNXiJI=;
        b=mrlGQj2Kq35ppP/9oMAZy8+dFEbxkLoXur4yhrW8v1tSu0k0fUyMf1ggTECMWziBn0
         X/9BKYYBwglkQzstoJUJNBQcwtRxh//HgNkaTPAYj5Dgn0tpAdFpawjsmTWvO2sFU4Ef
         u9B7Hjcm36D9a4quOAaee7Zkqz69W5lqMOiVdKN7x9ArnzzsjA+CMYmIvZZ6vrc5wlWv
         rav9bY7W8IpZDwQyE1Qez5MiuHp/Ur4/c1kxS8vpR+ToYBqLzzBai9t+Gj3o2zBJjkc5
         78Tf6saAUvKk1FLOcmrzGMHAg/9IJV2VdrsXcGjuU21cVrSPk2At9nOPa/clyLDmULLx
         VdHA==
X-Gm-Message-State: AOAM530A6g7ZPzRAqh+T/N3wAgLRFs0c1JnYooVKcoEw+PcL3jbFa2gJ
        hGY6InXZc/NKrgqfM9zKV05bjw==
X-Google-Smtp-Source: ABdhPJxyn60waabFePD78AVYYz+Pnem8hEKJlcVFwztIc/rsxDFPUqquEpK5Ysm4bQR9TAC31IP4Yw==
X-Received: by 2002:adf:e787:: with SMTP id n7mr21402364wrm.153.1605538200675;
        Mon, 16 Nov 2020 06:50:00 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id k22sm19673078wmi.34.2020.11.16.06.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 06:50:00 -0800 (PST)
References: <160522352433.135009.15329422887113794062.stgit@john-XPS-13-9370>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [bpf PATCH v2 0/6] sockmap fixes
In-reply-to: <160522352433.135009.15329422887113794062.stgit@john-XPS-13-9370>
Date:   Mon, 16 Nov 2020 15:49:59 +0100
Message-ID: <87a6vhwe3s.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 13, 2020 at 12:26 AM CET, John Fastabend wrote:
> This includes fixes for sockmap found after I started running skmsg and
> verdict programs on systems that I use daily. To date with attached
> series I've been running for multiple weeks without seeing any issues
> on systems doing calls, mail, movies, etc.
>
> Also I started running packetdrill and after this series last remaining
> fix needed is to handle MSG_EOR correctly. This will come as a follow
> up to this, but because we use sendpage to pass pages into TCP stack
> we need to enable TCP side some.
>
> v2:
>  - Added patch3 to use truesize in sk_rmem_schedule (Daniel)
>  - cleaned up some small nits... goto and extra set of brackets (Daniel)
>
> ---
>
> John Fastabend (6):
>       bpf, sockmap: fix partial copy_page_to_iter so progress can still be made
>       bpf, sockmap: Ensure SO_RCVBUF memory is observed on ingress redirect
>       bpf, sockmap: Use truesize with sk_rmem_schedule()
>       bpf, sockmap: Avoid returning unneeded EAGAIN when redirecting to self
>       bpf, sockmap: Handle memory acct if skb_verdict prog redirects to self
>       bpf, sockmap: Avoid failures from skb_to_sgvec when skb has frag_list


Patch 5 potentially can be simplified. Otherwise LGTM. For the series:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
