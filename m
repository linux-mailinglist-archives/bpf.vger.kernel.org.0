Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAADF2A4F49
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 19:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgKCSrT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 13:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgKCSrT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 13:47:19 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819FEC0613D1;
        Tue,  3 Nov 2020 10:47:18 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id f38so14394036pgm.2;
        Tue, 03 Nov 2020 10:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dHcZHPgYHc2YjFTUppg0958sEzY+Khac55EnBkUYGSA=;
        b=QKXiMwNaxGvDfHjyKbXc2WEcSPJrdxzdz+Qcz5T1s8UK9eGJ5xsy7TA38iRuO2j6AA
         Q9BYah9UcCwgLo8MLnen5qaDIkPvznu4CO9STDo0IaBMH9jJcnsSO6DuX9DyyhQicHKt
         /XulGeHJ/K7012VXbjWFMgjuTbO8GAbGcMvPd6vtmxP7MgCRsUvxi0eoUXsHdQI2nBib
         CkwwMptISrPuRKH+i9DLyVyUohuUU0nCnYES5YsUJQtfo9HhC2BCw/3nGhpjgITP3LlS
         UeEHYYWpvD+nskttExiduaD281VxDh97otiU+4u7Es5SqHvUrQ5eO35QhVrW6J0PC3Em
         vyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dHcZHPgYHc2YjFTUppg0958sEzY+Khac55EnBkUYGSA=;
        b=q2WSquM/AlCHsKbxuSDH0eBUBdpfYJv7jP8im3KIadGRixUC1DVhDyXs8ovg64dXdD
         6q1VVQ5mcgAijDhqYXBbL9S0sRyBzSC3CelDoIzu2UyyswB6wODdQGLY0Wh/Efq3fdpZ
         4lrwSb1bO0arPsf1fQPECTr/cxdrm/jwZM9K49f5+NZazOGL6QML1QAUq2S2as/TixRZ
         XOOVcavOOArf2kunrgV8r10iA6fOeE06+wY1AypSgYAT3BmWZuehZ4z+BNnFs20yBlSx
         IHrWt1xrDZh1iIk8UBTJowr23/Xa05wQ5xRJdM/SGSPab80YfeopJk9NJi3eNhdFjctD
         pz/g==
X-Gm-Message-State: AOAM530T+nh2n9Acjbs+oIVmGOkXaR0pEUYzm7sZ/GesVPLtfORE2Yr/
        1aB4F40MZy6ylQwhAnOQmJdJYNPgrfFZ5w==
X-Google-Smtp-Source: ABdhPJxbLQbz1Q/oXWkXo3tb7X7YDNnUGPneX2l1VkJ2tByPkWKdnZNS3wd92OX3zBlxFESmmsaDww==
X-Received: by 2002:a17:90a:5d93:: with SMTP id t19mr545469pji.220.1604429238068;
        Tue, 03 Nov 2020 10:47:18 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:4055])
        by smtp.gmail.com with ESMTPSA id v126sm6365550pfb.137.2020.11.03.10.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 10:47:17 -0800 (PST)
Date:   Tue, 3 Nov 2020 10:47:14 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v2 7/8] bpf: Add tests for task_local_storage
Message-ID: <20201103184714.iukuqfw2byls3s4k@ast-mbp.dhcp.thefacebook.com>
References: <20201103153132.2717326-1-kpsingh@chromium.org>
 <20201103153132.2717326-8-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103153132.2717326-8-kpsingh@chromium.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 03, 2020 at 04:31:31PM +0100, KP Singh wrote:
> +
> +struct storage {
> +	void *inode;
> +	unsigned int value;
> +	/* Lock ensures that spin locked versions of local stoage operations
> +	 * also work, most operations in this tests are still single threaded
> +	 */
> +	struct bpf_spin_lock lock;
> +};

I think it's a good idea to test spin_lock in local_storage,
but it seems the test is not doing it fully.
It's only adding it to the storage, but the program is not accessing it.
