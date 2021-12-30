Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14AEB481851
	for <lists+bpf@lfdr.de>; Thu, 30 Dec 2021 03:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhL3CCm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Dec 2021 21:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbhL3CCl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Dec 2021 21:02:41 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C202C061574
        for <bpf@vger.kernel.org>; Wed, 29 Dec 2021 18:02:41 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id kd9so20736654qvb.11
        for <bpf@vger.kernel.org>; Wed, 29 Dec 2021 18:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IRT+QR4As3hSRg9h2+hqZx3kSelz/3wfJVcrZ8ddHOU=;
        b=IAsUmoxo14OnZJPeSeBZ56QwzInUScwBaoI7i67HZfXxfycr5UctDXjJQkI4Wbsijc
         iXMWIVIq5lLXEAJ5ZYRhdOF3EXMId566YvguafU+r0ss44rHDpzfydV6l0PjHEaV3NAP
         FmbDZkn8Lk5T00VegAiW8vimBI07eY/02Xl7VZcdekNP8AXOskONfv9E8ISigvYw1tby
         RrkkV3W4yNECsK7iFCG4AChYar57Lz2RRLRgDSpHaa0aAK5MI1ZTQeZWlLx03owEqs6V
         WxlOCSl2nlnCn7GXLOTY/PSAyFsjCJ65wM4toJbFQ8CEt8V3gGwRIFEZxn/jCdcIHqdi
         wpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IRT+QR4As3hSRg9h2+hqZx3kSelz/3wfJVcrZ8ddHOU=;
        b=A2DTzEKiJK8ri8hf9LOk7pKEg4lSyqPUFR3XGYtbadw7hdi86h1v7mpxremCRXfyeV
         kpDB4Aga7S8/iZ2g7kH0awCmHknWXIqB5LVqrnFC8y5jduVOUWnHRAVAys7jSOqKeNxg
         NFLa81pkBFAXpkZSaSF6IYaVEf2YT9VfXpInB8F1YZSwxDofmXqH0qvzbebEtY6uiDav
         bCbnV0En+0prOoIT4f1F9TbBkBaShcnBQKrXbIou5sAuYlGYHlUIg8ZU2r1q8slND0oa
         lKTpoNVE93BoXPgOLbC5Ij/+hVlMAUk15SnS9hQMLkLYlA4HNNnChGdjpQFNSy47+kX/
         JCGQ==
X-Gm-Message-State: AOAM531gTzwpaYJg3+Q8xHEYUKGL/hAi6zJ1k3ilYVIUZZHx5F6m4wQc
        DYgY2T7X81aa2cK8zqNdfTw=
X-Google-Smtp-Source: ABdhPJzQtA5O/CntZ2yD9o+fb0cdvGr+yGWLkuu5h0s8yWtlRMswu7+BapewQomJNTOP6mVsotHpZQ==
X-Received: by 2002:ad4:5ba4:: with SMTP id 4mr26127001qvq.15.1640829760736;
        Wed, 29 Dec 2021 18:02:40 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c091:480::1:33c4])
        by smtp.gmail.com with ESMTPSA id s9sm18805879qki.99.2021.12.29.18.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 18:02:40 -0800 (PST)
Date:   Wed, 29 Dec 2021 18:02:37 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH v3 bpf-next 0/2] Sleepable local storage
Message-ID: <20211230020237.p26qapxmfznd7p5g@ast-mbp.dhcp.thefacebook.com>
References: <20211224152916.1550677-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211224152916.1550677-1-kpsingh@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 24, 2021 at 03:29:14PM +0000, KP Singh wrote:
> Local storage is currently unusable in sleepable helpers. One of the
> important use cases of local_storage is to attach security (or
> performance) contextual information to kernel objects in LSM / tracing
> programs to be used later in the life-cyle of the object.
> 
> Sometimes this context can only be gathered from sleepable programs
> (because it needs accesing __user pointers or helpers like
> bpf_ima_inode_hash). Allowing local storage to be used from sleepable
> programs allows such context to be managed with the benefits of
> local_storage.
> 
> # v2 -> v3
> 
> * Fixed some RCU issues pointed by Martin
> * Added Martin's ack

Applied, Thanks
