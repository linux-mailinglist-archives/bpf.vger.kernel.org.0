Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E753F25DE0A
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 17:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgIDPnS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 11:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgIDPnP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 11:43:15 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB70C061244;
        Fri,  4 Sep 2020 08:43:13 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e5so4923218qth.5;
        Fri, 04 Sep 2020 08:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5LB2AUmOyNI3tt+w9oIfbzksgc/XXMTDOB7tUOQMLhE=;
        b=af4fMP4NwFMBDvGojGkCEZInk/7FBBJVCns+RaQLvd9DwUQJMy5tqAPGN5rNk8vmJd
         spLbxoa/CdZnb2P/gWg+OhNtmqoVKZ71Wqb/FNcX+6Cpb3oyvPx/1wmXUE+twBqphET6
         AXxRfeeq6dnFa+jImirlM5Q9OYofzgl6wvgscnBCWANlRnhPPE5pKWJIdg7RLzWtrIOF
         756+e4dmlPPvxxb4FOdwYu+sAmmtQfJwOQDQUMtpkFwfVoLo0CSIjYmOvCFbm5Y/gD3y
         dWI7pxLz648g5L0mEoenRxukN6fFzMyjKoMdycYRr4IyFfLrR3GorH790oa9KpSnI3JR
         Q5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5LB2AUmOyNI3tt+w9oIfbzksgc/XXMTDOB7tUOQMLhE=;
        b=EhSyyB7tg0P8oLcJ21jr3bf5gH02ivP2XEKmvUMZHIo7Kx8ubMCNtrICQWOB3OTEdC
         5yPxVzwaxlUelsdDXuby5yqapL15uVFNm2nzmpdwR6SiJGKYyug6H602abKh5cFlhGPF
         e8QMM1LvLJzu9JFL55mIVtX0tY1pEuuW+pimvBQoSexL1MgBihRZGNmxLXNFi7afT6wV
         80JV0tPdkFPNQCwagthTWtILqYh34mGbU0KqRI2AwkkwuhtV5DVtQQL/PMJSSTJPFXOf
         01IbI0VInonuAvyQsCsgXzOcNFJfZBg7cFvL7nYLECnbu24+urmYNmnb/iakRBepIyLE
         sJgQ==
X-Gm-Message-State: AOAM532mrlhK2oVYWw0uJjdQslkqYpbyVhVIwxh/GIfy+lq1Hgp8tytM
        8z+/X0nO/fClkK/d5ypMLOo=
X-Google-Smtp-Source: ABdhPJxwHRFdCIrGN8ZV8+QapOahu3J8vGobkcjgLyQtbWrpLgTUBEdnqp5tI7F/ZdczNTnZNRyBAQ==
X-Received: by 2002:ac8:743:: with SMTP id k3mr9543641qth.182.1599234193005;
        Fri, 04 Sep 2020 08:43:13 -0700 (PDT)
Received: from leah-Ubuntu ([2601:4c3:200:c230:e82f:35f2:cc6c:cdf5])
        by smtp.gmail.com with ESMTPSA id k64sm4700248qkc.105.2020.09.04.08.43.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Sep 2020 08:43:12 -0700 (PDT)
Date:   Fri, 4 Sep 2020 11:43:10 -0400
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, linux-block@vger.kernel.org,
        orbekk@google.com, harshads@google.com, jasiu@google.com,
        saranyamohan@google.com, tytso@google.com, bvanassche@google.com
Subject: Re: [RFC PATCH 1/4] bpf: add new prog_type BPF_PROG_TYPE_IO_FILTER
Message-ID: <20200904154309.GA2048@leah-Ubuntu>
References: <20200812163305.545447-1-leah.rumancik@gmail.com>
 <20200812163305.545447-2-leah.rumancik@gmail.com>
 <20200813230021.llbkj5ihyadcbuia@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813230021.llbkj5ihyadcbuia@kafai-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 13, 2020 at 04:00:51PM -0700, Martin KaFai Lau wrote:
> On Wed, Aug 12, 2020 at 04:33:02PM +0000, Leah Rumancik wrote:
> > Introducing a new program type BPF_PROG_TYPE_IO_FILTER and a new
> > attach type BPF_BIO_SUBMIT.
> > 
> > This program type is intended to help filter and monitor IO requests.
> 
> [ ... ]
> 
> > +#define BPF_MAX_PROGS 64
> > +
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
> > +	if (!f.file)
> > +		return -EBADF;
> > +
> > +	disk = I_BDEV(f.file->f_mapping->host)->bd_disk;
> > +	if (disk == NULL)
> > +		return -ENXIO;
> > +
> > +	ret = mutex_lock_interruptible(&disk->io_filter_lock);
> > +	if (ret)
> > +		return ret;
> > +
> > +	old_array = io_filter_rcu_dereference_progs(disk);
> > +	if (old_array && bpf_prog_array_length(old_array) >= BPF_MAX_PROGS) {
> > +		ret = -E2BIG;
> > +		goto unlock;
> > +	}
> > +
> > +	ret = bpf_prog_array_copy(old_array, NULL, prog, &new_array);
> > +	if (ret < 0)
> > +		goto unlock;
> > +
> > +	rcu_assign_pointer(disk->progs, new_array);
> > +	bpf_prog_array_free(old_array);
> > +
> > +unlock:
> > +	mutex_unlock(&disk->io_filter_lock);
> > +	return ret;
> > +}
> bpf link should be used.
> netns_bpf_link_create() can be used as an example.
I'll update this, thanks for the example.

> > diff --git a/include/uapi/linux/bpf.h Vb/include/uapi/linux/bpf.h
> > +struct bpf_io_request {
> > +	__u64 sector_start;	/* first sector */
> > +	__u32 sector_cnt;	/* number of sectors */
> > +	__u32 opf;		/* bio->bi_opf */
> > +};
> Is it all that are needed from "struct bio" to do the filtering and monitoring?
> Please elaborate a few more specific filtering usecases in the comment
> or even better is to add those usecases to the tests.
Fields can be added to the bpf_io_request later if needed. I'll add some
more tests and clarification in comments in the next version.

> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 94cead5a43e5..71372e99a722 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -2613,6 +2613,7 @@ static bool may_access_direct_pkt_data(struct bpf_verifier_env *env,
> >  	case BPF_PROG_TYPE_LWT_SEG6LOCAL:
> >  	case BPF_PROG_TYPE_SK_REUSEPORT:
> >  	case BPF_PROG_TYPE_FLOW_DISSECTOR:
> > +	case BPF_PROG_TYPE_IO_FILTER:
> Why it is needed?
Does not look like this is needed. I will remove it.

Thanks for the review,
Leah
