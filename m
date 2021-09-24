Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735C24179D3
	for <lists+bpf@lfdr.de>; Fri, 24 Sep 2021 19:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344149AbhIXRXM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Sep 2021 13:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348057AbhIXRWx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Sep 2021 13:22:53 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B000C061762
        for <bpf@vger.kernel.org>; Fri, 24 Sep 2021 10:21:19 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id k26so4866442pfi.5
        for <bpf@vger.kernel.org>; Fri, 24 Sep 2021 10:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HhqNBNgyc2rC1gOQsFw4IssIDlcZ8jU897SqBigUPJE=;
        b=jE3K/N1rfcUrHwpRX/aBhCQ3HU7Gn4cVncrbOB7HsoXnYKagsPSuzLssqdIEKNRkID
         FoCql4G5utEKXNrqzTkPReMGeGuL3PFFP731dV0svygnaUy3oVeJxe/EHUZ8fiCtBUbk
         ZOj9k2yeBAq1nzLgwnVhCU09C1TKonl/NQ016SylUTiVSeHp096uihJRTs7p5Oukjj8L
         90sjqZmpt0Buf2teBt3Xzh3uDQgqbQLY01iPGsLP9m3WZQgdWw9FFqRI4mZWU2EeuM1a
         HgThrZ6/sa6BwMG2lsugjDEgWBtNpt8ejKZRDTHvx4XPiMebNojFcVYA7nUPGNqBCEyi
         RVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HhqNBNgyc2rC1gOQsFw4IssIDlcZ8jU897SqBigUPJE=;
        b=D3YR7dLld8kauq6xb6Bv8tbomT4/iTfIztJYKbt+Jj5jijAzv89VKZcD6Pr0STjUEg
         F0MRUEkBqRj96I1d9Nlcx2nURieoOBEaxKksvASNdvIsyEdnuNZMDHCVkgvDOauAcVkU
         KhfIbsKE5VwsDfuHCxfxGhlzv+B/enZoVcw6EoEcOhM5RJig3+RFJsc3+ZGjPaOF1JYD
         3EoCzuE7544/WpN8u/dXk65RPlf6zzN/qaqYUzYufh2CjbuHYx7Kevg451hxaZfk9OKq
         RSdeHCqc4sp7n13zmrbdUQMYQgcljWCfJkEVfml3LI2kQqGmmVAoFfd1HNatZFV10q+X
         LDmA==
X-Gm-Message-State: AOAM532U9bdw2VN0OfAvrkJRG10vdpD373FrQkNzNWgyVUIj3HPkoXlI
        ii375AaoN3XC2eS6A2bvRWY=
X-Google-Smtp-Source: ABdhPJz+5b9pIL49ScHEJjdD7Hy9H/8QCSNAOqsxpzSqWMc80Kl6t81qpxdjvUIdSV5f4OgZabkPng==
X-Received: by 2002:a62:60c2:0:b0:446:b494:39cc with SMTP id u185-20020a6260c2000000b00446b49439ccmr10715488pfb.22.1632504078806;
        Fri, 24 Sep 2021 10:21:18 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id g22sm9402672pfb.191.2021.09.24.10.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 10:21:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 24 Sep 2021 07:21:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     alexei.starovoitov@gmail.com, andrii@kernel.org,
        bpf@vger.kernel.org,
        syzbot+df709157a4ecaf192b03@syzkaller.appspotmail.com,
        Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH bpf 1/2] bpf, cgroup: Assign cgroup in cgroup_sk_alloc
 when called from interrupt
Message-ID: <YU4JDMTCRJU38e4+@slm.duckdns.org>
References: <fe51fd2101fe9df82750d0beb2772ef77ba06bcf.1632427246.git.daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe51fd2101fe9df82750d0beb2772ef77ba06bcf.1632427246.git.daniel@iogearbox.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 23, 2021 at 10:09:23PM +0200, Daniel Borkmann wrote:
> If cgroup_sk_alloc() is called from interrupt context, then just assign the
> root cgroup to skcd->cgroup. Prior to commit 8520e224f547 ("bpf, cgroups:
> Fix cgroup v2 fallback on v1/v2 mixed mode") we would just return, and later
> on in sock_cgroup_ptr(), we were NULL-testing the cgroup in fast-path. Rather
> than re-adding the NULL-test to the fast-path we can just assign it once from
> cgroup_sk_alloc() given v1/v2 handling has been simplified.

I think you should explain why this is safe - ie. when do we hit the
condition and leak the socket to the root cgroup and why is that okay?

Thanks.

-- 
tejun
