Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FB125E0C3
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 19:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgIDRaA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 13:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgIDR37 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 13:29:59 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71316C061244;
        Fri,  4 Sep 2020 10:29:59 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id g128so7880944iof.11;
        Fri, 04 Sep 2020 10:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iup/BPBU3NZvrPiN2q7hG6ObvdkJkFEtj83NMUIZ1KY=;
        b=cx1YgDod4rlnCOWPokMbDrqgPNNXfF4RFsY4J24ShFyXyP15fGTYlzrgebtUR9i1qp
         6T+Qd2yNsBkyETU02VdDXMOJvg4JKkPPTvbTwkMh7g4ttA0CZ0oTrOms0rp5Suvv2hkJ
         o/Hjuk4phd23HJkGxlFOuDV4sdWzo5BHrfSebz4mZScVqEnROpgkgwsM2JkPY3Urp1PM
         GJRXa7AtgIJKnnYlakaVajTT7ZONAocnWgzQ0+aF7vaOtNemDnZamR7eRUf1a8lxVVfr
         Y/iRbX8CvkuJPvuDQHQQcQv4HaYnYGSH/bURHI1rTFONa1+HQE2+YyYjK2BzXPNRWnk0
         Wt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iup/BPBU3NZvrPiN2q7hG6ObvdkJkFEtj83NMUIZ1KY=;
        b=jH8QSMHaKm89UgN9aUSxIqCeq0Jf8ZKPOmn3lyl4tuTzmvoeE5Uye+uL+MgxVE0c15
         /eMT69tPIZVPAaReWKORsfrDvA26xLtpvaRoyGn21i7zlQIgJYqurwc2f/RUwO7avOpB
         6Je6tN+IVIOoyVwcpGvCMVEboi+M7iZxaUOEUEAXwbyT/Nlo/OH3Na+8o0uG2H3P7v7y
         4U1ui4bPlGm0B0W+7kmG8i6Qvnrm8lWPsraZljOp8e+1F7PHLV63ykH2ou5oZgByfDcS
         B+uuxjYR7xatPw9BT2WIjQWI3B1cGXQyjoMTlCdb10005mizqcDQfsPDk4XXXrbn+ArG
         P60Q==
X-Gm-Message-State: AOAM5325ravfuXFxTRMjh22yv2sKqRJC10+0VBJzbMjb8VhN6dDpdsjp
        917fQulocguM6YuJMQrpDKe5ZLloC99p9Dsf
X-Google-Smtp-Source: ABdhPJzKEGTy0s+XClH8eBd580NUxzaUtvIhCksv0P9Mq6vYEIXPLYR9c9eA7SNTVNW8HoUddRifXg==
X-Received: by 2002:a6b:e718:: with SMTP id b24mr8734820ioh.9.1599240598271;
        Fri, 04 Sep 2020 10:29:58 -0700 (PDT)
Received: from leah-Ubuntu ([2601:4c3:200:c230:e82f:35f2:cc6c:cdf5])
        by smtp.gmail.com with ESMTPSA id d22sm390633ios.47.2020.09.04.10.29.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Sep 2020 10:29:57 -0700 (PDT)
Date:   Fri, 4 Sep 2020 13:29:55 -0400
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     bpf@vger.kernel.org, linux-block@vger.kernel.org,
        orbekk@google.com, harshads@google.com, jasiu@google.com,
        saranyamohan@google.com, tytso@google.com, bvanassche@google.com
Subject: Re: [RFC PATCH 1/4] bpf: add new prog_type BPF_PROG_TYPE_IO_FILTER
Message-ID: <20200904172954.GC2048@leah-Ubuntu>
References: <20200812163305.545447-1-leah.rumancik@gmail.com>
 <20200812163305.545447-2-leah.rumancik@gmail.com>
 <87mu2sru7d.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mu2sru7d.fsf@cloudflare.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 18, 2020 at 02:53:42PM +0200, Jakub Sitnicki wrote:
> On Wed, Aug 12, 2020 at 06:33 PM CEST, Leah Rumancik wrote:
> > +int io_filter_prog_attach(const union bpf_attr *attr, struct bpf_prog *prog)
> > +{
> > +	struct gendisk *disk;
> > +	struct fd f;
> > +	struct bpf_prog_array *old_array;
> > +	struct bpf_prog_array *new_array;
> > +	int ret;
> > +
> > +	if (attr->attach_flags)
> > +		return -EINVAL;
> > +
> > +	f = fdget(attr->target_fd);
>             ^^^^^
> 
> Missing corresponding fdput?
> 
> As per Martin's suggestion, with bpf_link this will become the
> link_create callback, but the comment still stands.

Yep, will add.

Thanks,
Leah
