Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37E718C3AE
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2019 23:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfHMV2u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Aug 2019 17:28:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46413 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfHMV2u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Aug 2019 17:28:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id q139so4036131pfc.13
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2019 14:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7MV3mapKiYjg4aOC58fcsYuIoZKPAlaZsR9dswVdxNY=;
        b=puaeNSsvWnlTY/rsC/3atxQO0Qh1fQrwww3HFTG78nzm098bNepfwz4IhVbrEl0XOd
         UNaSL8sWry/8FGHaGlc4N7Cm/3oR+mgg7zezFFO20Ezf57V4+2ZRlX8a54X9IQ5VtMzI
         tlOdmipcZdQf+p+1YLTHIcITv1XW0gPc9+ySJP/fDD95zi9Dk63gqAKtlBg5SVchuNMg
         jl/f5W85DtttGchiNp2dpRRC3LjCcEbub+6nz61Xg5ii5GAj6SIGSY1mBoQCjd1hesBu
         pH7y/n6JOn0MRDCpDuVNlwR1Wfvm0Ih2h3jWNoyhgImn8m7pPlkFIIEjjB+gdY/LSPbK
         ly1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7MV3mapKiYjg4aOC58fcsYuIoZKPAlaZsR9dswVdxNY=;
        b=Oqy/J1611WXO/cqJF4QyOYWFIitWFwbPjKgr/U3eDDZ73hSlVtoBuiwjqW6UQs0TcD
         AK7czlnwAicrGy5k48pFb9gXsLtgMKeeR/fZ67KrdlzBVHvKshB2irS1Yh3wpzZlBuBn
         LVUn3Ff59VUUMOGEOUIK7dEkOcGMPdHUVT1a5yA9HrsiErnjQAFooqqGFcONXlX0HHWM
         bu4xNxfo4Lox782WcXUZIQor4Z5FOYmWRAtu2FdtRG3/DBM5eAahTcXo3z3ff7P5aAia
         3e9yBxiTAPrarOafsa9JFghCYrl1TyshTlc1hhkz5nrN4F/1uS5MZ7wk07RA1mNtwcOI
         6fpQ==
X-Gm-Message-State: APjAAAVZ3axQJM1H8DtJLBl52LIIfBeeLRas4xAIcwFOoMciPIwwB1BC
        EiqQovB/OnvWxtRh0yS6WL3rIjuk0MA=
X-Google-Smtp-Source: APXvYqx/61RzpvdOIsmGo8c1gIoU40mcA+PLNEXor9AkVw+DeDL2qD64DjRU+maXQGVAs3vuRh3+eA==
X-Received: by 2002:a63:5b52:: with SMTP id l18mr36021232pgm.21.1565731729276;
        Tue, 13 Aug 2019 14:28:49 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id i15sm115364401pfd.160.2019.08.13.14.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 14:28:48 -0700 (PDT)
Date:   Tue, 13 Aug 2019 14:28:47 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, davem@davemloft.net, ast@kernel.org,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next v2 2/4] bpf: support cloning sk storage on
 accept()
Message-ID: <20190813212847.GI2820@mini-arch>
References: <20190809161038.186678-1-sdf@google.com>
 <20190809161038.186678-3-sdf@google.com>
 <db5ec323-1126-d461-bc65-27ccc1414589@iogearbox.net>
 <20190812175249.GF2820@mini-arch>
 <2d24378a-73f4-bfa0-dc99-4a0ed761c797@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d24378a-73f4-bfa0-dc99-4a0ed761c797@iogearbox.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 08/13, Daniel Borkmann wrote:
> On 8/12/19 7:52 PM, Stanislav Fomichev wrote:
> > On 08/12, Daniel Borkmann wrote:
> > > On 8/9/19 6:10 PM, Stanislav Fomichev wrote:
> > > > Add new helper bpf_sk_storage_clone which optionally clones sk storage
> > > > and call it from sk_clone_lock.
> > > > 
> > > > Cc: Martin KaFai Lau <kafai@fb.com>
> > > > Cc: Yonghong Song <yhs@fb.com>
> > > > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > > [...]
> > > > +int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
> > > > +{
> > > > +	struct bpf_sk_storage *new_sk_storage = NULL;
> > > > +	struct bpf_sk_storage *sk_storage;
> > > > +	struct bpf_sk_storage_elem *selem;
> > > > +	int ret;
> > > > +
> > > > +	RCU_INIT_POINTER(newsk->sk_bpf_storage, NULL);
> > > > +
> > > > +	rcu_read_lock();
> > > > +	sk_storage = rcu_dereference(sk->sk_bpf_storage);
> > > > +
> > > > +	if (!sk_storage || hlist_empty(&sk_storage->list))
> > > > +		goto out;
> > > > +
> > > > +	hlist_for_each_entry_rcu(selem, &sk_storage->list, snode) {
> > > > +		struct bpf_sk_storage_elem *copy_selem;
> > > > +		struct bpf_sk_storage_map *smap;
> > > > +		struct bpf_map *map;
> > > > +		int refold;
> > > > +
> > > > +		smap = rcu_dereference(SDATA(selem)->smap);
> > > > +		if (!(smap->map.map_flags & BPF_F_CLONE))
> > > > +			continue;
> > > > +
> > > > +		map = bpf_map_inc_not_zero(&smap->map, false);
> > > > +		if (IS_ERR(map))
> > > > +			continue;
> > > > +
> > > > +		copy_selem = bpf_sk_storage_clone_elem(newsk, smap, selem);
> > > > +		if (!copy_selem) {
> > > > +			ret = -ENOMEM;
> > > > +			bpf_map_put(map);
> > > > +			goto err;
> > > > +		}
> > > > +
> > > > +		if (new_sk_storage) {
> > > > +			selem_link_map(smap, copy_selem);
> > > > +			__selem_link_sk(new_sk_storage, copy_selem);
> > > > +		} else {
> > > > +			ret = sk_storage_alloc(newsk, smap, copy_selem);
> > > > +			if (ret) {
> > > > +				kfree(copy_selem);
> > > > +				atomic_sub(smap->elem_size,
> > > > +					   &newsk->sk_omem_alloc);
> > > > +				bpf_map_put(map);
> > > > +				goto err;
> > > > +			}
> > > > +
> > > > +			new_sk_storage = rcu_dereference(copy_selem->sk_storage);
> > > > +		}
> > > > +		bpf_map_put(map);
> > > 
> > > The map get/put combination /under/ RCU read lock seems a bit odd to me, could
> > > you exactly describe the race that this would be preventing?
> > There is a race between sk storage release and sk storage clone.
> > bpf_sk_storage_map_free uses synchronize_rcu to wait for all existing
> > users to finish and the new ones are prevented via map's refcnt being
> > zero; we need to do something like that for the clone.
> > Martin suggested to use bpf_map_inc_not_zero/bpf_map_put.
> > If I read everythin correctly, I think without map_inc/map_put we
> > get the following race:
> > 
> > CPU0                                   CPU1
> > 
> > bpf_map_put
> >    bpf_sk_storage_map_free(smap)
> >      synchronize_rcu
> > 
> >      // no more users via bpf or
> >      // syscall, but clone
> >      // can still happen
> > 
> >      for each (bucket)
> >        selem_unlink
> >          selem_unlink_map(smap)
> > 
> >          // adding anything at
> >          // this point to the
> >          // bucket will leak
> > 
> >                                         rcu_read_lock
> >                                         tcp_v4_rcv
> >                                           tcp_v4_do_rcv
> >                                             // sk is lockless TCP_LISTEN
> >                                             tcp_v4_cookie_check
> >                                               tcp_v4_syn_recv_sock
> >                                                 bpf_sk_storage_clone
> >                                                   rcu_dereference(sk->sk_bpf_storage)
> >                                                   selem_link_map(smap, copy)
> >                                                   // adding new element to the
> >                                                   // map -> leak
> >                                         rcu_read_unlock
> > 
> >        selem_unlink_sk
> >         sk->sk_bpf_storage = NULL
> > 
> >      synchronize_rcu
> > 
> 
> Makes sense, thanks for clarifying. Perhaps a small comment on top of
> the bpf_map_inc_not_zero() would be great as well, so it's immediately
> clear also from this location when reading the code why this is done.
Sure, no problem, will have something similar to what I have before
synchronize_rcu in bpf_sk_storage_map_free.

> Thanks,
> Daniel
