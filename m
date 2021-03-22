Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E66344EB4
	for <lists+bpf@lfdr.de>; Mon, 22 Mar 2021 19:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhCVSlS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Mar 2021 14:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhCVSkr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Mar 2021 14:40:47 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F821C061574
        for <bpf@vger.kernel.org>; Mon, 22 Mar 2021 11:40:46 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x21so20600833eds.4
        for <bpf@vger.kernel.org>; Mon, 22 Mar 2021 11:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gVda+nMFqx0KFOxK2nphmM3DTa0PCLz2UoYE0fMhsdY=;
        b=cSPptbcXYUpGrBze4mZdiiMsatbhWL23TNu7SXojPLJsZ46do7lI0c7dbvEDTOZq0h
         D6I2Hqz19M3G7UR/9ZsnpAh4pYYEmL694Uz6NKMP4wCN4uX4px4ro8O+DsnE1Kv45nvl
         ClmyxQ/cNAJcxMJnXlhg6cXAKf3AR6iy137enm0zAM7nXbYkaBa3b1r9PRTowiAKCtWq
         pRWx/lPlRAQ7+AwKjEYjW8nLmq2QFPnZ31C0lgYcb+YIwZzBct552vInm1b0Eej18lgF
         ApqNhv0ODUxKXxAxLlK2SSVIAuo7FEDvWbAneBIdKKqzUh88xyUF9aaBqV2G9lnSiGKh
         GxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gVda+nMFqx0KFOxK2nphmM3DTa0PCLz2UoYE0fMhsdY=;
        b=UHWIbDt5HQfhjJVfEuCfhGquX1Cnr5/Zi5EMQknOF0Dxgf4mKBcLJPE0CFlbITRVhx
         JUgSIUu6TSvA+nDv06gDTwdbzX184G9RhFRcuY4bG+mA17Q4kJTcaB0VCIj94JBI58uK
         LXNN32zs2BrIxTCWi9mSQvCfCKsXhUE77e+TWmYFc/thLXB9P+68b5fgNv89f6N/tse5
         6qU8f2sPX2yBRiqJAIUXpBk0NKkQqX1xCHZhivV0Cy40Z4TSOHVhzgUH2hzQgEb3aTkW
         tGXf4CwBh4ENFDC2lMQC/bs/WwgHM4aZlDk4sYVMKo8KkKxjoAn0I4oU29NefUUnal6/
         Iniw==
X-Gm-Message-State: AOAM532cs79Czcg9RP5xaGHWLwCYA84zFZooWlvYsQqCbkc2a79vpMW1
        eEpRrvWHDoJwdpDmDkT67xMbOA==
X-Google-Smtp-Source: ABdhPJwQlDuYyPnC0cAetxVhhMN/z6NEhspyu50CTvFmlNWYV05q9+n+Ld0uZ+3zyBpDi+F7gvdCOA==
X-Received: by 2002:aa7:de11:: with SMTP id h17mr959782edv.83.1616438444955;
        Mon, 22 Mar 2021 11:40:44 -0700 (PDT)
Received: from gmail.com (93-136-63-101.adsl.net.t-com.hr. [93.136.63.101])
        by smtp.gmail.com with ESMTPSA id f9sm11856488eds.41.2021.03.22.11.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 11:40:44 -0700 (PDT)
Date:   Mon, 22 Mar 2021 19:40:45 +0100
From:   Denis Salopek <denis.salopek@sartura.hr>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, juraj.vijtiuk@sartura.hr,
        luka.oreskovic@sartura.hr, luka.perkov@sartura.hr, yhs@fb.com
Subject: Re: [PATCH v3 bpf-next] bpf: add lookup_and_delete_elem support to
 hashtab
Message-ID: <YFjkrU4H3t1hVPgz@gmail.com>
References: <YFDudWFj9zydyo/P@gmail.com>
 <2f5f29ed-354b-b88d-f5cb-535d61aaaf0e@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f5f29ed-354b-b88d-f5cb-535d61aaaf0e@iogearbox.net>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 19, 2021 at 09:35:59PM +0100, Daniel Borkmann wrote:
> On 3/16/21 6:44 PM, Denis Salopek wrote:
> [...]
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index c859bc46d06c..36f65b589b82 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -1463,7 +1463,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
> >   	return err;
> >   }
> > -#define BPF_MAP_LOOKUP_AND_DELETE_ELEM_LAST_FIELD value
> > +#define BPF_MAP_LOOKUP_AND_DELETE_ELEM_LAST_FIELD flags
> >   static int map_lookup_and_delete_elem(union bpf_attr *attr)
> >   {
> > @@ -1479,6 +1479,9 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
> >   	if (CHECK_ATTR(BPF_MAP_LOOKUP_AND_DELETE_ELEM))
> >   		return -EINVAL;
> > +	if (attr->flags & ~BPF_F_LOCK)
> > +		return -EINVAL;
> > +
> >   	f = fdget(ufd);
> >   	map = __bpf_map_get(f);
> >   	if (IS_ERR(map))
> > @@ -1489,13 +1492,19 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
> >   		goto err_put;
> >   	}
> > +	if ((attr->flags & BPF_F_LOCK) &&
> > +	    !map_value_has_spin_lock(map)) {
> > +		err = -EINVAL;
> > +		goto err_put;
> > +	}
> > +
> >   	key = __bpf_copy_key(ukey, map->key_size);
> >   	if (IS_ERR(key)) {
> >   		err = PTR_ERR(key);
> >   		goto err_put;
> >   	}
> > -	value_size = map->value_size;
> > +	value_size = bpf_map_value_size(map);
> >   	err = -ENOMEM;
> >   	value = kmalloc(value_size, GFP_USER | __GFP_NOWARN);
> > @@ -1505,6 +1514,17 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
> >   	if (map->map_type == BPF_MAP_TYPE_QUEUE ||
> >   	    map->map_type == BPF_MAP_TYPE_STACK) {
> >   		err = map->ops->map_pop_elem(map, value);
> > +	} else if (map->map_type == BPF_MAP_TYPE_HASH ||
> > +		   map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
> > +		   map->map_type == BPF_MAP_TYPE_LRU_HASH ||
> > +		   map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
> > +		if (!bpf_map_is_dev_bound(map)) {
> 
> I think you probably rather meant to fold the above !bpf_map_is_dev_bound(map)
> condition into the higher level 'else if', right? Otherwise for dev bound maps
> you'll always end up with -ENOMEM error rather than -ENOTSUPP.
> 

Yes, you're right, thank you. How about setting the err to -ENOTSUPP
before the 'if' and just drop the else altogether?

> > +			bpf_disable_instrumentation();
> > +			rcu_read_lock();
> > +			err = map->ops->map_lookup_and_delete_elem(map, key, value, attr->flags);
> > +			rcu_read_unlock();
> > +			bpf_enable_instrumentation();
> > +		}
> >   	} else {
> >   		err = -ENOTSUPP;
> >   	}
